<!DOCTYPE html>
<html>
<head>


<title>PLEIADES Search Results </title>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">
<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>-->


<style>
body {
font-size:14px;}

.go-top {
    position: fixed;
    bottom: 0.75em;
    right: 0.5em;
    text-decoration: none;
    color: white;
    background-color: rgba(0, 0, 0, 0.25);
    font-size: 12px;
    padding: 10px;
    display: none;
    margin: 0;
}

.go-top:hover {
    background-color: rgba(0, 0, 0, 0.6);
    color: white;
    text-decoration: none;
}

.exp td {
    padding-bottom: 20px;
}

.row.datum label {
    display: inline;
}

.row.datum {
    margin-bottom: 5px;
    padding-top: 10px;
}

#Results {
padding-top: 5px;

}


</style>
</head>

<body>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
<script src="inputFeedback.js" type="text/javascript"></script>
<script src="divPagination.js" type="text/javascript"></script>
<script src="jquery.sticky.js" type="text/javascript"></script>
<script>
// Show or hide the sticky 'Back_to_Top' button 
$(window).scroll(function() {                
    if ($(this).scrollTop() > 200) {
        $('.go-top').fadeIn(500);
    } else {
        $('.go-top').fadeOut(300);
    }
}); 

// Show sticky 'Search_Again' button
$(window).load(function(){
  $("#header").sticky({ topSpacing: 0 });
});
</script>


<div id="Results">
<h2 style="margin:40px;">Search Results</h2>

<h4> {{query_res["query"]}} </h4> <br \>
<h5>Total {{query_res["num"]}} articles returned! </h5>

<a href="#" class="go-top" style="display:none;">Back to top</a>
<div id="header">
    <a href="/" style="position:absolute;top:0;right:0;"><h4>Search Again!</h4></a>
</div>

<table id="results" style="max-width:1000px;margin-left:20px;">
%for each_pmid in pmcid_det:
  <tr class="exp">
    <td>
        <ul>
            <li>
                <b>{{each_pmid["_id"]["Title"]}}</b> <br />
                {{each_pmid["_id"]["Authors"]}} <br />
                <i>{{each_pmid["_id"]["FullJournalName"]}}</i> {{each_pmid["_id"]["PubDate"]}}, {{each_pmid["_id"]["Volume"]}}: {{each_pmid["_id"]["Pages"]}}  &nbsp <a href="/articles/PMC{{each_pmid['_id']['PMCID']}}/PMC{{each_pmid['_id']['PMCID']}}.html" target="_blank">PMC{{each_pmid["_id"]["PMCID"]}} </a> &nbsp <a href="#" class="show_hide" rel="#slidingDiv_{{each_pmid['_id']['PMCID']}}"> Show Datums </a> &nbsp <a href="http://www.ncbi.nlm.nih.gov/pubmed/{{each_pmid["_id"]['PMID']}}/" target="_blank">PMID:{{each_pmid["_id"]["PMID"]}} </a> <br />
                <div id="slidingDiv_{{each_pmid['_id']['PMCID']}}" style="padding:20px; margin-top:10px; border-bottom:5px; solid #3399FF; display:none;">
                    <form id="{{each_pmid['_id']['PMCID']}}" class="datum-form">
                        <div class="paginate">                        
                            <ul id="datumList_{{each_pmid['_id']['PMCID']}}" style="list-style-type: none; padding-left:0">                                         
                                <li>
                                    <div class="container-fluid"><div class="row">
                                        <div class="col-sm-10 col-sm-offset-2"><div class="row">
                                            <div class="col-sm-3"><b>Subject</b></div>
                                            <div class="col-sm-3"><b>Assay</b></div>
                                            <div class="col-sm-3"><b>Change</b></div>
                                            <div class="col-sm-3"><b>Treatment</b></div>
                                        </div></div>
                                    </div></div>
                                </li>
                                                               
                                %for each_datum in each_pmid["Datums"]:
                                    <li id="{{each_pmid['_id']['PMCID']}}_{{each_datum['sr_no']}}">


                                        <div class="container-fluid"><div class="row datum"><div class="form">
                                            <div class="col-sm-2" style="padding-top:4px">
                                                <label><input type="checkbox" class="datum-delete-checkbox" name="del_{{each_datum['sr_no']}}_{{each_pmid['_id']['PMCID']}}" value="Yes"> Delete</label>
                                            </div>
                                            
                                            
                                            
                                            <div class="col-sm-10"><div class="row">
                                                <div class="col-sm-3">
                                                    %if 'subject' in each_datum["map"]:
                                                    <div class="form-group">
                                                        <input type="text" class="form-control datum-field" name="sub_{{each_datum['sr_no']}}_{{each_pmid['_id']['PMCID']}}" value="{{each_datum['map']['subject'][0]['Entity']['strings']}}" placeholder="{{each_datum['map']['subject'][0]['Entity']['strings']}}">
                                                    </div>
                                                    %end
                                                </div>
                                                
                                                
                                                <div class="col-sm-3">
                                                    %if 'assay' in each_datum["map"]:
                                                    <div class="form-group">
                                                        <input type="text" class="form-control datum-field" name="ass_{{each_datum['sr_no']}}_{{each_pmid['_id']['PMCID']}}" value="{{each_datum['map']['assay'][0]['Text']}}" placeholder="{{each_datum['map']['assay'][0]['Text']}}"> 
                                                    </div>
                                                    %end
                                                </div>
                                                
                                                
                                                <div class="col-sm-3">
                                                    %if 'change' in each_datum["map"]:
                                                    <div class="form-group">
                                                        <input type="text" class="form-control datum-field" name="chn_{{each_datum['sr_no']}}_{{each_pmid['_id']['PMCID']}}" value="{{each_datum['map']['change'][0]['Text']}}" placeholder="{{each_datum['map']['change'][0]['Text']}}">
                                                    </div> 
                                                    %end
                                                </div>
                                                
                                                
                                                <div class="col-sm-3">
                                                    %if 'treatment' in each_datum["map"]:
                                                    <div class="form-group">
                                                        <input type="text" class="form-control datum-field" name="trt_{{each_datum['sr_no']}}_{{each_pmid['_id']['PMCID']}}" value="{{each_datum['map']['treatment'][0]['Entity']['strings']}}" placeholder="{{each_datum['map']['treatment'][0]['Entity']['strings']}}">
                                                    </div>
                                                    %end
                                                </div>
                                            
                                            </div></div>

                                            
                                        </div></div></div>
                                        



                                    </li>
                                %end                                    
                            </ul> 
                            <input type="submit" id="Submit" name="Submit" value="Submit" class="submit-datums"> 
                            <span id="result_{{each_pmid['_id']['PMCID']}}" width="250px"></span>   &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp 
                            <a href="javascript:void()" id="insert-more"> Add New Datum </a>  <br>                                             
                        </div>
                    </form>
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
