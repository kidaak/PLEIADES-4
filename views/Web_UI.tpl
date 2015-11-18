<!DOCTYPE html>
<html>
<head>

<title>PLEIADES Extracted Datum Browser </title>

<!-- Bootstrap -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" integrity="sha512-dTfge/zgoMYpP7QbHy4gWMEGsbsdZeCXz7irItjcC3sPUFtf0kuFbDz/ixG7ArTxmDjLXDmezHubeNikyKGVyQ==" crossorigin="anonymous">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css" integrity="sha384-aUGj/X2zp5rLCbBxumKTCw2Z50WgIr1vs/PFN4praOTvYXWlVyh2UtNUU0KAUhAX" crossorigin="anonymous">
<!--<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js" integrity="sha512-K1qjQ+NcF2TYO/eI3M6v8EiNYZfA95pQumfvcVrTHtwQVDG+aHRqLi/ETn2uB+1JqwYqVG3LIvdm9lj6imS/pQ==" crossorigin="anonymous"></script>-->


<style>
body {
    background-color: white;
    /*font-family:Tahoma,Verdana,Segoe,sans-serif;*/
    font-size:14px;
}


#searchbox {
    margin-top: 100px;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
    border: solid 3px #B70101;
    border-radius: 10px;
}

#formcontrols {
    padding: 30px;
}

#header {
    text-align: center;
    color: white;
    padding: 10px;
    background: #B70101 url('test-tube.svg') no-repeat;
background-position: 40px;
background-size: auto 70%;

}

#title {
    font-size: 200%;
}

#subtitle {
    font-size: 90%;
}


#logo {
    height: 30px;
    width: auto;
    margin-right: 10px;
    position: relative;
    bottom: 4px;
}

.checkbox-label {
    font-weight: normal !important;
}


#footer {
    background-color:black;
    color:white;
    clear:both;
    text-align:center;
    padding:5px;
}

</style>
</head>
<body>


<div id="searchbox"><form accept-charset="UTF-8" action="/datum" method="POST">

<div id="header">
    <div id="title">    
        PLEIADES Extracted Datum Browser
    </div>
    <div id="subtitle">
        University of Wisconsin &mdash; Madison
    </div>
</div>


<div id="formcontrols" class="form-horizontal">



<div class="form-group">
    <label for="subject" class="col-sm-2 control-label">Subject</label>
    <div class="col-sm-10">
        <input type="text" name="subject" class="form-control" maxlength="30">
    </div>
</div>


<div class="form-group" style="margin-top:30px">
    <label class="control-label col-sm-2">Assay</label>

    <div class="col-sm-5">
        <label class="checkbox-label"><input type="checkbox" name="assay_phos" value="phos"> Phosphorylation</label>
    </div>

    <div class="col-sm-5">
        <label class="checkbox-label"><input type="checkbox" name="assay_copp" value="copptby"> Coprecipitation</label>
    </div>

    <div class="col-sm-5 col-sm-offset-2">
        <label class="checkbox-label"><input type="checkbox" name="assay_ubiq" value="ubiq"> Ubiquitination</label>
    </div>

    <div class="col-sm-5">
        <label class="checkbox-label"><input type="checkbox" name="assay_gtp" value="GTP-association"> GTP association</label>
    </div>

</div>



<div class="form-group" style="margin-top:30px;">
    <label class="control-label col-sm-2">Change</label>

    <div class="col-sm-5">
        <label class="checkbox-label"><input type="checkbox" name="change_inc" value="increased"> Increased</label>
    </div>

    <div class="col-sm-5">
        <label class="checkbox-label"><input type="checkbox" name="change_dec" value="decreased"> Decreased</label>
    </div>

    <div class="col-sm-5 col-sm-offset-2">
        <label class="checkbox-label"><input type="checkbox" name="change_unc" value="unchanged"> Unchanged</label>
    </div>

    <div class="col-sm-5">
        <label class="checkbox-label"><input type="checkbox" name="change_detunc" value="det_unch"> Detectable but unchanged</label>
    </div>


    <div class="col-sm-5 col-sm-offset-2">
        <label class="checkbox-label"><input type="checkbox" name="change_det" value="detect"> Detectable</label>
    </div>

    <div class="col-sm-5">
        <label class="checkbox-label"><input type="checkbox" name="achange_undet" value="undetect"> Undetectable</label>
    </div>


</div>





<div class="form-group" style="margin-top:30px;margin-bottom:30px;">
    <label for="treatment" class="col-sm-2 control-label">Treatment</label>
    <div class="col-sm-10">
        <input type="text" name="treatment" class="form-control" maxlength="30">
    </div>
</div>



<hr>
<div class="form-group" >
    <label class="control-label col-sm-2">Rank Datums</label>

    <div class="col-sm-5">
        <label class="checkbox-label"><input type="radio" name="rank_by" value="expected" checked> Expected number of datums</label>
    </div>

    <div class="col-sm-5">
        <label class="checkbox-label"><input type="radio" name="rank_by" value="uncertainty"> Most uncertainty about datums &nbsp &nbsp</label>
    </div>

</div>


<div class="form-group" style="margin-top:40px;">
    <div class="col-sm-3 col-sm-offset-2">
        <input type="submit" id="search" value="Search" class="btn btn-lg btn-danger" >
    </div>
</div>

</div>

</form></div>

</body>
</html>
