let
//SQL
//create function Add (@x int)
//AS BEGIN RETURN @x * 5
    Add = (x) => x*5
in
    Add(100)    
//DAX
//Query = VAR Add = tbl[col] * 5
// RETURN Query 