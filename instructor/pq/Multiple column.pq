    #"Divided Column" = 
        Table.TransformColumns(
            #"Changed Type"
            , 
            {
                    {"OLSAT Verbal Score", each _ / 100, type number},
                    { "OLSAT Verbal Percentile", each _ / 100, type number},
                    { "NNAT Non Verbal Raw Score", each _ / 100, type number},
                    { "NNAT Non Verbal Percentile", each _ / 100, type number},
                    { "Overall Score", each _ / 100, type number}
            }
        )
    
in
    #"Divided Column"