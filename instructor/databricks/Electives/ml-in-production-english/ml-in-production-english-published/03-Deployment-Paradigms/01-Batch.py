# Databricks notebook source
# MAGIC %md-sandbox
# MAGIC 
# MAGIC <div style="text-align: center; line-height: 0; padding-top: 9px;">
# MAGIC   <img src="https://databricks.com/wp-content/uploads/2018/03/db-academy-rgb-1200px.png" alt="Databricks Learning" style="width: 600px">
# MAGIC </div>

# COMMAND ----------

# DBTITLE 0,--i18n-b8f7f476-820c-470b-b998-ee49d8090103
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC # Batch Deployment
# MAGIC 
# MAGIC Batch inference is the most common way of deploying machine learning models.  This lesson introduces various strategies for deploying models using batch including Spark, write optimizations, and on the JVM.
# MAGIC 
# MAGIC ## ![Spark Logo Tiny](https://files.training.databricks.com/images/105/logo_spark_tiny.png) In this lesson you:<br>
# MAGIC  - Explore batch deployment options
# MAGIC  - Apply an **`sklearn`** model to a Spark DataFrame and save the results
# MAGIC  - Employ write optimizations including partitioning and Z-ordering

# COMMAND ----------

# MAGIC %run ../Includes/Classroom-Setup

# COMMAND ----------

# DBTITLE 0,--i18n-c69d373e-764d-4d90-89af-cd7ec988e8ce
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC ### Inference in Batch
# MAGIC 
# MAGIC Batch deployment represents the vast majority of use cases for deploying machine learning models.<br><br>
# MAGIC 
# MAGIC * This normally means running the predictions from a model and saving them somewhere for later use.
# MAGIC * For live serving, results are often saved to a database that will serve the saved prediction quickly. 
# MAGIC * In other cases, such as populating emails, they can be stored in less performant data stores such as a blob store.
# MAGIC 
# MAGIC <img src="https://files.training.databricks.com/images/eLearning/ML-Part-4/batch-predictions.png" width=800px />
# MAGIC 
# MAGIC Writing the results of an inference can be optimized in a number of ways...<br><br>
# MAGIC 
# MAGIC * For large amounts of data, predictions and writes should be performed in parallel
# MAGIC * **The access pattern for the saved predictions should also be kept in mind in how the data is written**
# MAGIC   - For static files or data warehouses, partitioning speeds up data reads
# MAGIC   - For databases, indexing the database on the relevant query generally improves performance
# MAGIC   - In either case, the index is working similar to an index in a book: it allows you to skip ahead to the relevant content

# COMMAND ----------

# DBTITLE 0,--i18n-25510128-3adc-46f2-a87a-fd25250917b0
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC There are a few other considerations to ensure the accuracy of a model...<br><br>
# MAGIC 
# MAGIC * First is to make sure that the model matches expectations
# MAGIC   - We'll cover this in further detail in the model drift section
# MAGIC * Second is to **retrain the model on the majority of your dataset**
# MAGIC   - Either use the entire dataset for training or around 95% of it
# MAGIC   - A train/test split is a good method in tuning hyperparameters and estimating how the model will perform on unseen data
# MAGIC   - Retraining the model on the majority of the dataset ensures that you have as much information as possible factored into the model

# COMMAND ----------

# DBTITLE 0,--i18n-a6956622-b714-4906-b513-6c84e79399b8
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC ### Inference in Spark
# MAGIC 
# MAGIC Models trained in various machine learning libraries can be applied at scale using Spark.  To do this, use **`mlflow.pyfunc.spark_udf`** and pass in the **`SparkSession`**, name of the model, and run id.
# MAGIC 
# MAGIC <img src="https://files.training.databricks.com/images/icon_note_24.png"/> Using UDF's in Spark means that supporting libraries must be installed on every node in the cluster.  In the case of **`sklearn`**, this is installed in Databricks clusters by default.  When using other libraries, you will need to install them to ensure that they will work as UDFs.

# COMMAND ----------

# DBTITLE 0,--i18n-a2a01839-d58e-480c-a827-a6fd16718b28
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Start by training an **`sklearn`** model.  Apply it using a Spark UDF generated by **`mlflow`**.
# MAGIC 
# MAGIC Import the data.  **Do not perform a train/test split.**
# MAGIC 
# MAGIC <img src="https://files.training.databricks.com/images/icon_note_24.png"/> It is common to skip the train/test split in training a final model.

# COMMAND ----------

import pandas as pd

df = pd.read_parquet(f"{DA.paths.datasets_path}/airbnb/sf-listings/airbnb-cleaned-mlflow.parquet")
X = df.drop(["price"], axis=1)
y = df["price"]

# COMMAND ----------

# DBTITLE 0,--i18n-3110b46a-f08d-437b-a54b-99891bf3095a
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Train and log model

# COMMAND ----------

from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error
import mlflow.sklearn

with mlflow.start_run(run_name="Final RF Model") as run:
    rf = RandomForestRegressor(n_estimators=100, max_depth=5)
    rf.fit(X, y)

    predictions = rf.predict(X)
    mlflow.sklearn.log_model(rf, "random_forest_model")

    mse = mean_squared_error(y, predictions) # This is on the same data the model was trained
    mlflow.log_metric("mse", mse)

# COMMAND ----------

# DBTITLE 0,--i18n-4c5710a9-3cc1-49b6-81eb-9acf386afbad
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Create a Spark DataFrame from the Pandas DataFrame.

# COMMAND ----------

spark_df = spark.createDataFrame(X)
display(spark_df)

# COMMAND ----------

# DBTITLE 0,--i18n-0c892310-6d74-44df-a42e-cfea83296be4
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC MLflow easily produces a Spark user defined function (UDF).  This bridges the gap between Python environments and applying models at scale using Spark.

# COMMAND ----------

predict = mlflow.pyfunc.spark_udf(spark, f"runs:/{run.info.run_id}/random_forest_model")

# COMMAND ----------

# DBTITLE 0,--i18n-edd6acae-9489-47c7-9d46-8a730ed48c3c
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Apply the model as a standard UDF using the column names as the input to the function.

# COMMAND ----------

prediction_df = spark_df.withColumn("prediction", predict(*spark_df.columns))

display(prediction_df)

# COMMAND ----------

# DBTITLE 0,--i18n-1fa8ab51-0dc8-433c-92e2-ae76e661e060
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC ### Write Optimizations
# MAGIC 
# MAGIC There are many possible optimizations depending on your batch deployment scenerio.  In Spark and Delta Lake, the following optimizations are possible:<br><br>
# MAGIC 
# MAGIC - **Partitioning:** stores data associated with different categorical values in different directories
# MAGIC - **Z-Ordering:** colocates related information in the same set of files
# MAGIC - **Data Skipping:** aims at speeding up queries that contain filters (WHERE clauses)
# MAGIC - **Partition Pruning:** speeds up queries by limiting the amount of data read
# MAGIC 
# MAGIC Other optimizations include:<br><br>
# MAGIC 
# MAGIC - **Database indexing:** allows certain table columns to be more effectively queried 
# MAGIC - **Geo-replication:** replicates data in different geographical regions

# COMMAND ----------

# DBTITLE 0,--i18n-5632d9fc-878e-4253-9911-505eb2ea8e2e
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Partition by neighborhood.

# COMMAND ----------

dbutils.fs.rm(f"{DA.paths.working_dir}/batch-predictions-partitioned.delta", recurse=True)
delta_partitioned_path = f"{DA.paths.working_dir}/batch-predictions-partitioned.delta"

prediction_df.write.partitionBy("neighbourhood_cleansed").mode("OVERWRITE").format("delta").save(delta_partitioned_path)

# COMMAND ----------

# DBTITLE 0,--i18n-daa95012-b4cb-4c40-8931-cf328b7b3e3d
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Take a look at the files.

# COMMAND ----------

display(dbutils.fs.ls(delta_partitioned_path))

# COMMAND ----------

# DBTITLE 0,--i18n-f3232c00-22de-4b36-97d6-1c3c76b30121
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Z-Ordering is a form of multi-dimensional clustering that colocates related information in the same set of files.  It reduces the amount of data that needs to be read.  <a href="https://docs.databricks.com/delta/optimizations/file-mgmt.html#z-ordering-multi-dimensional-clustering" target="_blank">You can read more about it here.</a> Let's z-order by zipcode.

# COMMAND ----------

spark.sql(f"OPTIMIZE delta.`{delta_partitioned_path}` ZORDER BY (zipcode)")

# COMMAND ----------

# DBTITLE 0,--i18n-f13dcb97-e937-4953-8753-ae6e79d50f43
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC ### Feature Store Batch Scoring

# COMMAND ----------

# DBTITLE 0,--i18n-661ad1cf-1389-4903-9d5c-68257d80637c
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Create feature table
# MAGIC 
# MAGIC <img src="https://files.training.databricks.com/images/icon_note_24.png"/> Read dataframe from the csv file with spark directly to track **`data source`** in Feature Store

# COMMAND ----------

from databricks import feature_store
from databricks.feature_store import feature_table,FeatureLookup

## create a feature store client
fs = feature_store.FeatureStoreClient()

# COMMAND ----------

from pyspark.sql.functions import monotonically_increasing_id

## build feature dataframe, add index column and drop label
df = (spark.read
           .csv(f"{DA.paths.datasets}/airbnb/sf-listings/airbnb-cleaned-mlflow.csv", header=True, inferSchema=True)
           .withColumn("index", monotonically_increasing_id()))

## feature data - all the columns except for the true label
features_df = df.drop("price")

## inference data - contains only index and label columns, if you have online features, it should be added to inference_df as well
inference_df = df.select("index", "price")

# COMMAND ----------

# DBTITLE 0,--i18n-b3bbf60b-d884-4e1e-8cdb-a9de86fa2353
# MAGIC %md
# MAGIC 
# MAGIC Declare a fully-qualified, unique table name.
# MAGIC 
# MAGIC In DBR 10.5+, we can drop Feature Store tables, but for now we need a uniuqe name in case we re-run this notebook.

# COMMAND ----------

feature_table_name = f"{DA.schema_name}.airbnb_fs"
print(f"Table: {feature_table_name}\n")

# create feature table
result = fs.create_table(
    name=feature_table_name,
    primary_keys=["index"],
    df=features_df,
    description="review cols of Airbnb data"
)

# COMMAND ----------

# DBTITLE 0,--i18n-6ad326c5-036f-4c5e-950a-5ade154cc398
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Create training set from feature store using **`fs.create_training_set`**

# COMMAND ----------

## FeatureLoopup object
#feature_lookups = [FeatureLookup(feature_table_name, f, "index") for f in features_df.columns if f!="index"] ## exclude index colum
## uncomment the command below to create lookup features if using Runtime 9.1 ML
feature_lookups = [FeatureLookup(table_name = feature_table_name, feature_names = None, lookup_key = "index") ]

## fs.create_training_set will look up features in model_feature_lookups with matched key from inference_data_df
training_set = fs.create_training_set(inference_df, feature_lookups, label="price", exclude_columns="index")

# COMMAND ----------

# DBTITLE 0,--i18n-1cb7cc5b-83cb-4a83-9bc6-027730a7fbfc
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Log a feature store packaged model.
# MAGIC 
# MAGIC We need a unique model name and we can use our unique database name to construct it.

# COMMAND ----------

suffix = DA.unique_name("-")
model_name = f"airbnb-fs-model_{suffix}"

print(f"Model Name: {model_name}")

# COMMAND ----------

from mlflow.models.signature import infer_signature
## log RF model as a feature store packaged model and register the packaged model in model registry as `model_name`
fs.log_model(
    model=rf,
    artifact_path="feature_store_model",
    flavor=mlflow.sklearn,
    training_set=training_set,
    registered_model_name=model_name,
    input_example=X[:5],
    signature=infer_signature(X, y)
)

# COMMAND ----------

# DBTITLE 0,--i18n-79acd949-a75b-4b50-962f-49f612e56ce3
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC Now view the model on the Model Registry UI.
# MAGIC 
# MAGIC <img src="https://files.training.databricks.com/images/mlflow/FS_MLProd_model_registry.png" alt="step12" width="800"/>
# MAGIC 
# MAGIC </br>
# MAGIC </br>
# MAGIC Meanwhile you can find the registered model appears also on the Feature Store UI.
# MAGIC 
# MAGIC <img src="https://files.training.databricks.com/images/mlflow/FS_MLProd_feature_store_UI.png" alt="step12" width="800"/>

# COMMAND ----------

# DBTITLE 0,--i18n-17e87bbe-1fff-4c46-8dcd-b358ad936dd8
# MAGIC %md
# MAGIC 
# MAGIC Let's now perform batch scoring with the feature store model.

# COMMAND ----------

## for simplicity sake, we will just predict on the same inference_data_df
batch_input_df = inference_df.drop("price") #exclude true label
with_predictions = fs.score_batch(f"models:/{model_name}/1", 
                                  batch_input_df, result_type='double')
display(with_predictions)

# COMMAND ----------

# DBTITLE 0,--i18n-a2c7fb12-fd0b-493f-be4f-793d0a61695b
# MAGIC %md
# MAGIC 
# MAGIC ## Classroom Cleanup
# MAGIC 
# MAGIC Run the following cell to remove lessons-specific assets created during this lesson:

# COMMAND ----------

DA.cleanup()

# COMMAND ----------

# DBTITLE 0,--i18n-82dd28bc-1943-4273-b01d-c7293c6aa60c
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC ## Review
# MAGIC **Question:** What are the main considerations in batch deployments?  
# MAGIC **Answer:** The following considerations help determine the best way to deploy batch inference results:
# MAGIC * How the data will be queried
# MAGIC * How the data will be written
# MAGIC * The training and deployment environment
# MAGIC * What data the final model is trained on
# MAGIC 
# MAGIC **Question:** How can you optimize inference reads and writes?  
# MAGIC **Answer:** Writes can be optimized by managing parallelism.  In Spark, this would mean managing the partitions of a DataFrame such that work is evenly distributed and you have the most efficient connections back to the target database.

# COMMAND ----------

# DBTITLE 0,--i18n-9a23fac7-e622-4c09-a389-b74c95f7efaf
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC ## ![Spark Logo Tiny](https://files.training.databricks.com/images/105/logo_spark_tiny.png) Lab<br>
# MAGIC 
# MAGIC Start the labs for this lesson, [Batch Lab]($./Labs/01-Batch-Lab)

# COMMAND ----------

# DBTITLE 0,--i18n-203cc214-4db6-4796-977e-eaf2bf16f33f
# MAGIC %md
# MAGIC 
# MAGIC 
# MAGIC 
# MAGIC ## Additional Topics & Resources
# MAGIC 
# MAGIC **Q:** Where can I find more information on UDF's created by MLflow?  
# MAGIC **A:** See the <a href="https://www.mlflow.org/docs/latest/python_api/mlflow.pyfunc.html" target="_blank">MLflow documentation for details</a>

# COMMAND ----------

# MAGIC %md-sandbox
# MAGIC &copy; 2023 Databricks, Inc. All rights reserved.<br/>
# MAGIC Apache, Apache Spark, Spark and the Spark logo are trademarks of the <a href="https://www.apache.org/">Apache Software Foundation</a>.<br/>
# MAGIC <br/>
# MAGIC <a href="https://databricks.com/privacy-policy">Privacy Policy</a> | <a href="https://databricks.com/terms-of-use">Terms of Use</a> | <a href="https://help.databricks.com/">Support</a>
