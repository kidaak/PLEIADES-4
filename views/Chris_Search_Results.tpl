<!DOCTYPE html>
<html>
<head>
<style>
body {background-color: #fff3f0;
font-family:Tahoma,Verdana,Segoe,sans-serif;
font-size:14px;}

#Results {
padding-top: 5px;

}

a {
    cursor:pointer;
}

tr.exp:nth-child(odd) { background-color: #eae0ff; }
tr.exp:nth-child(even) { background-color: #d6c1ff; }

</style>
</head>

<body>


<div id="Results">
<h2>Search Results</h2>

<table>
%for each_pmid in pmcid_det:
  <tr class="exp">
    <td>
        <ul>
            <li>
                <b>{{each_pmid["_id"]["Title"]}}</b> <br />
                {{each_pmid["_id"]["Authors"]}} <br />
                <i>{{each_pmid["_id"]["FullJournalName"]}}</i> {{each_pmid["_id"]["Volume"]}}: {{each_pmid["_id"]["Pages"]}}  &nbsp <a href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC{{each_pmid['_id']['PMCID']}}/" target="_blank">PMC{{each_pmid["_id"]["PMCID"]}} </a> &nbsp 

                    <div class="paginate">
                        <table>
                            <tr style="height:80%">
                                <ul>
                                    %for each_datum in each_pmid["Datums"]:
                                        <li>                                      
                                            %if 'subject' in each_datum["map"]:
                                                <b>Subject:</b> &nbsp {{each_datum["map"]["subject"][0]["Entity"]["strings"]}} &nbsp &nbsp 
                                            %end
                                             
                                            %if 'assay' in each_datum["map"]:
                                                <b>Assay:</b> &nbsp {{each_datum["map"]["assay"][0]["Text"]}} &nbsp &nbsp
                                            %end
                                             
                                            %if 'change' in each_datum["map"]:
                                                <b>Change:</b> &nbsp {{each_datum["map"]["change"][0]["Text"]}} &nbsp &nbsp 
                                            %end
                                            
                                            %if 'treatment' in each_datum["map"]:
                                                <b>Treatment:</b> &nbsp {{each_datum["map"]["treatment"][0]["Entity"]["strings"]}} 
                                            %end
                                        </li>
                                    %end
                                </ul>
                            </tr>
                        </table>
                    </div>
                
            </li>
        </ul>
    </td>
  </tr>
%end
</table>

</div>

</body>
</html>
