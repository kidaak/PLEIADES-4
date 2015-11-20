// On the search results page, this script provides visual feedback as the user
// edits the datums.



// Show that this datum field has been edited, with a green check mark
// This function is called when the input is changed.
function inputFeedbackEdited() {
    
    // clear existing feedback
    inputFeedbackClear.apply(this);
    
    var textbox = $(this);
    
    // show checkmark if value is different than the placeholder
    if (textbox.val() != textbox.attr('placeholder')) {
        var formgroup = textbox.parent();
        formgroup.addClass('has-success has-feedback');
        
        if (!formgroup.find('.form-control-feedback').length) {
            formgroup.append('<span class="glyphicon glyphicon-ok form-control-feedback"></span>');
        }
    }
}



// show that this datum is marked for deletion 
// (Show a red x in the input box)
function inputFeedbackDeleted() {
    
    // clear existing feedback
    inputFeedbackClear.apply(this);
    
    var textbox = $(this);
    
    var formgroup = textbox.parent();
    formgroup.addClass('has-error has-feedback');
    
    if (!formgroup.find('.form-control-feedback').length) {
        formgroup.append('<span class="glyphicon glyphicon-remove form-control-feedback"></span>');
    }
}



// called when the "delete" checkbox is checked or unchecked
function deleteCheckboxFeedback() {
    var datumInputs = $(this).parents('.datum').find('input.datum-field');
    
    // mark all inputs as deleted
    if ($(this).is(':checked')) {
        
        datumInputs.prop('disabled', true);    
        
        datumInputs.each(function(i, input) {
            inputFeedbackDeleted.apply(input);
        });
    }
    
    // or show input as edited or unmodivied
    else {
        datumInputs.prop('disabled', false);
    
        datumInputs.each(function(i, input) {
            inputFeedbackEdited.apply(input);
        });
    }
}



// clear visual feedback for a given input box (this)
function inputFeedbackClear() {
    var textbox = $(this);
    var formgroup = textbox.parent();
    
    formgroup.removeClass('has-success has-error has-feedback');
    formgroup.find('.form-control-feedback').remove();
}




$(document).ready(function() {
    $('table#results').delegate('input.datum-field', 'change keyup', inputFeedbackEdited); // also on keyup?
    $('table#results').delegate('input.datum-delete-checkbox', 'change', deleteCheckboxFeedback);
});
