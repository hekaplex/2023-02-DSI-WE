let
    Source = Web.BrowserContents("http://lprb.web.geniussports.com/competitions/?WHurl=%2Fcompetition%2F35169%2Fmatch%2F2217625%2Fsummary%3F"),
    #"Extracted Table From Html" = Html.Table(Source, {{"Column1", "DIV.summary-boxscore-detail:nth-child(2) > DIV.table-wrap > TABLE.tableClass.footable > * > TR > :nth-child(1)"}, {"Column2", "DIV.summary-boxscore-detail:nth-child(2) > DIV.table-wrap > TABLE.tableClass.footable > * > TR > :nth-child(2)"}, {"Column3", "DIV.summary-boxscore-detail:nth-child(2) > DIV.table-wrap > TABLE.tableClass.footable > * > TR > :nth-child(3)"}, {"Column4", "DIV.summary-boxscore-detail:nth-child(2) > DIV.table-wrap > TABLE.tableClass.footable > * > TR > :nth-child(4)"}, {"Column5", "DIV.summary-boxscore-detail:nth-child(2) > DIV.table-wrap > TABLE.tableClass.footable > * > TR > :nth-child(5)"}, {"Column6", "DIV.summary-boxscore-detail:nth-child(2) > DIV.table-wrap > TABLE.tableClass.footable > * > TR > :nth-child(6)"}}, [RowSelector="DIV.summary-boxscore-detail:nth-child(2) > DIV.table-wrap > TABLE.tableClass.footable > * > TR"]),
    #"Promoted Headers" = Table.PromoteHeaders(#"Extracted Table From Html", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"No", Int64.Type}, {"Jugador", type text}, {"Pos", type text}, {"Min", type text}, {"Pt", Int64.Type}, {"2P%", type number}})
in
    #"Changed Type"

let
    myFunction = (inputParameter as text) =>
        let
            outputTable = Table.FromColumns({{inputParameter}}, {"Column1"})
 in
            outputTable
in
    myFunction