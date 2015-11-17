(function ($) {
    $.fn.showHide = function (options) {

        //default vars for the plugin
        var defaults = {
            speed: 1000,
            easing: '',
            changeText: 0,
            showText: 'Show',
            hideText: 'Hide'

        };
        var options = $.extend(defaults, options);

        $(this).click(function () {

            $('.toggleDiv').slideUp(options.speed, options.easing);
            // this var stores which button you've clicked
            var toggleClick = $(this);
            // this reads the rel attribute of the button to determine which div id to toggle
            var toggleDiv = $(this).attr('rel');
            // here we toggle show/hide the correct div at the right speed and using which easing effect
            $(toggleDiv).slideToggle(options.speed, options.easing, function () {
                // this only fires once the animation is completed
                if (options.changeText == 1) {
                    $(toggleDiv).is(":visible") ? toggleClick.text(options.hideText) : toggleClick.text(options.showText);
                }
            });

            return false;

        });

    };
})(jQuery);


jQuery(document).ready(function($) {                                    
            // Animate the scroll to top
            $('.go-top').click(function(event) {
                event.preventDefault();

                $('html, body').animate({scrollTop: 0}, 300);
            });   

            $('body').delegate('#insert-more', 'click', function(e) {
                //alert("Saswati")
                var parent_ul = $(this).siblings('ul:first')
                console.log("The id of the ul element is: " + parent_ul.attr("id"))
                var last = $(this).siblings('ul:first').children('li:visible:last');
                console.log("The id of the last visible li element is: " + last.attr("id")) 
                var $form = $(this).parents('form:first');
                var $pmcid = $form.attr("id")
                console.log("PMCID: " + $pmcid)
                var max_srno = 0;
                $("#"+parent_ul.attr("id")+" li").each(function(){
                    //console.log("List element id: " + this.id)
                    num = parseInt(this.id.split("_")[1],10);
                    if(num > max_srno)
                    {
                       max_srno = num;
                    }
                });   
                console.log("Maximum sr. no: " + max_srno)            
                $('#'+last.attr("id")).after("<li id='"+$pmcid+"_"+(max_srno+1)+"' class='new'>" +
                    "<table>" +
                        "<tr style='width:100%'>" +
                            "<td>" +
                            "<input type='checkbox' name='del_"+(max_srno+1)+"_"+$pmcid+"' value='Yes'> Delete? &nbsp &nbsp" +
                            "</td>" +                                           
                            "<td width='250px'>" +                                                                                                                
                                "<b>Subject:</b> &nbsp <input type='text' name='sub_"+(max_srno+1)+"_"+$pmcid+"' value='' placeholder=''> &nbsp &nbsp " +                                                                      
                            "</td>" +
                            "<td width='250px'>" +                           
                                "<b>Assay:</b> &nbsp <input type='text' name='ass_"+(max_srno+1)+"_"+$pmcid+"' value='' placeholder=''> &nbsp &nbsp " +                           
                            "</td>" +
                            "<td width='250px'>" +                      
                                "<b>Change:</b> &nbsp <input type='text' name='chn_"+(max_srno+1)+"_"+$pmcid+"' value='' placeholder=''> &nbsp &nbsp " +                           
                            "</td>" +
                            "<td width='250px'>" +                           
                                "<b>Treatment:</b> &nbsp <input type='text' name='trt_"+(max_srno+1)+"_"+$pmcid+"' value='' placeholder=''> &nbsp &nbsp " +                           
                            "</td>" +                                                    
                        "</tr>" +
                    "</table>" +
                "</li>");

                $('input[name=sub_' +(max_srno+1)+'_'+$pmcid+']').focus();                
            });

            $('body').delegate('#Submit', 'click', function(e) {
                e.preventDefault();
                //alert("Saswati")
                var $form = $(this).parents('form:first');
                var $pmcid = $form.attr("id")                
                var fields = $form.serializeArray()
                var seen = []
                var datums = []
                var json_obj = {}
                json_obj["PMCID"] = $pmcid                
                jQuery.each( fields, function( i, field ) {                                   
                    if ($.trim(field.value) != $.trim($('input[name=' + field.name +']').attr("placeholder")) ) { 
                        console.log("Field Name: " + field.name + "   " + "Field Value: " + $.trim(field.value) + "   " + "Placeholder: " + $('input[name=' + field.name +']').attr("placeholder"))                                                                   
                        var $li = $('input[name=' + field.name +']').parents('li')
                        var temp_arr = $li.attr("id").toString().split('_')
                        var $list_srno = temp_arr[1]                        
                        if( $.inArray($list_srno, seen) != -1){
                            return true
                        } 
                        seen.push($list_srno)
                        var temp = {}
                        temp["sr_no"] = $list_srno
                        if ($li.attr('class') != undefined)
                        {   temp["New"] = "Yes" }
                        else {  temp["New"] = "No" }
                        $('#'+$li.attr("id")).find('input').each(function(j, element) {  
                            var str_arr = $(element).attr("name").toString().split('_')
                            console.log($(element).attr("name").toString())
                            var values = {}
                            if (str_arr[0] == "del") {                                
                                //console.log($('#'+$(element).attr("id")).is(':checked'));
                                temp["Delete"] = $(element).is(':checked')
                                //return true
                            }          
                            else if (str_arr[0] == "sub") {                                    
                                    values["OldValue"] = $(element).attr("placeholder")
                                    if ($(element).attr("placeholder") != $(element).attr("value"))
                                        {   values["NewValue"] = $(element).attr("value")   }
                                    else    { values["NewValue"] = ""   }
                                    temp["Subject"] = values
                                    $(element).attr("placeholder", $(element).attr("value"))
                            }

                            else if (str_arr[0] == "ass") {                                    
                                    values["OldValue"] = $(element).attr("placeholder")
                                    if ($(element).attr("placeholder") != $(element).attr("value"))
                                        {   values["NewValue"] = $(element).attr("value")   }
                                    else    { values["NewValue"] = ""   } 
                                    temp["Assay"] = values
                                    $(element).attr("placeholder", $(element).attr("value"))
                            }

                            else if (str_arr[0] == "chn") {                                    
                                    values["OldValue"] = $(element).attr("placeholder")
                                    if ($(element).attr("placeholder") != $(element).attr("value"))
                                        {   values["NewValue"] = $(element).attr("value")   }
                                    else    { values["NewValue"] = ""   }
                                    temp["Change"] = values 
                                    $(element).attr("placeholder", $(element).attr("value"))
                            }

                            else if (str_arr[0] == "trt") {                                    
                                    values["OldValue"] = $(element).attr("placeholder")
                                    if ($(element).attr("placeholder") != $(element).attr("value"))
                                        {   values["NewValue"] = $(element).attr("value")   }
                                    else    { values["NewValue"] = ""   } 
                                    temp["Treatment"] = values
                                    $(element).attr("placeholder", $(element).attr("value"))
                            }
                            //console.log("Old_Value: " + $(element).attr("placeholder") + "   " + "New_Value: " + $(element).attr("value"));
                        }); // End of the for loop that iterates over all the input elements present within the li item 

                        datums.push(temp)
                        
                    }
                }); // End of the for loop that iterates over the array returned by serializearray
                if (datums.length !== 0) {
                    json_obj["Datums"] = datums
                    console.log(JSON.stringify(json_obj))

                    // Send the data using post
                    var posting = $.post( "/feedback", {"jstring": JSON.stringify(json_obj)} );
                    // Put the results in a span
                    posting.done(function( ret_val ) { 
                        console.log(ret_val)
                        if (ret_val == "True")
                        {   $( "#result_"+$pmcid ).text( "Feedback Saved!" ).show().fadeOut( 2000 ); }
                        else  
                        {   $( "#result_"+$pmcid ).text( "Something happened and your feedback was lost. Please try again!" ).show().fadeOut( 2000 ); }                         
                    }); // End of posting.done
                } 
                else
                {   $( "#result_"+$pmcid ).text( "No changes were detected!" ).show().fadeOut( 2000 ); }
                                                                   
            });  // End of the delegated click event of the Submit button
        });


jQuery(function ($) {
    function check_navigation_display(el) {
        //accepts a jQuery object of the containing div as a parameter 
        $(el).children('.more').show();
        $(el).children('.less').show();
        
        if ($(el).find('ul li:visible').size() <= 20) {
            $(el).children('.less').hide();            
        } 

        if ($(el).find('ul').children('li').last().is(':visible')) {
            $(el).children('.more').hide();            
        } 
    }

    
    $('.show_hide').showHide({
        speed: 100, // speed you want the toggle to happen    
        easing: '', // the animation effect you want. Remove this line if you dont want an effect and if you haven't included jQuery UI
        changeText: 1, // if you dont want the button text to change, set this to 0
        showText: 'Show Datums', // the button text to show when a div is closed
        hideText: 'Hide Datums' // the button text to show when a div is open

    });

    $('div.paginate').each(function () {            
        if ($(this).find('ul li').length > 20) {
            var $form = $(this).parents('form:first');
            var $pmcid = $form.attr("id")
            //alert("From inside div.paginate" + $pmcid)
            $(this).append("<br> <a class='more' id='1_"+$pmcid+ "' href='javascript:void()'>Show More</a> <br> <br>");
            $(this).append("<a class='less' id='1_"+$pmcid + "' href='javascript:void()'>Show Less</a>");
        }
        $(this).find('ul li:gt(19)').hide();
        
        check_navigation_display($(this));

        $(this).find('.more').click(function () {
            var last = $(this).siblings('ul').children('li:visible:last');
            last.nextAll(':lt(20)').show();
            //last.next().prevAll().hide();
            check_navigation_display($(this).closest('div'));
        });

        $(this).find('.less').click(function () {
            var last = $(this).siblings('ul').children('li:visible:last');
            var last_li_index = last.index();
            //var visible_size = $(this).siblings('ul').children('li:visible').size();            
            if (last_li_index >= 39) {
                last.prevAll(':lt(19)').hide();
            	last.hide();
            }
            else {
                var elem_hide = last_li_index - 19
            	//alert("The no of li elements to hide: " + elem_hide);
                if (elem_hide > 0) {
                    last.prevAll(":lt(" + (elem_hide-1) + ")").hide();
            		last.hide();
                }
            }
            
            //first.prev().nextAll().hide()
            check_navigation_display($(this).closest('div'));
        });

    });

});
