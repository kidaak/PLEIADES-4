// On the search results page, this script provides visual feedback as the user
// edits the datums.



// Show that this datum field has been edited, with a green check mark
// This function is called when the input is changed.
function inputFeedbackEdited() {
    
    // Clear existing feedback
    inputFeedbackClear.apply(this);
    
    var textbox = $(this);
    
    // Show checkmark if value is different than the placeholder
    if (textbox.val() != textbox.attr('placeholder')) {
        var formgroup = textbox.parent();
        formgroup.addClass('has-success has-feedback');
        
        if (!formgroup.find('.form-control-feedback').length) {
            formgroup.append('<span class="glyphicon glyphicon-ok form-control-feedback"></span>');
        }
    }
}



// Show that this datum is marked for deletion 
// (Show a red x in each input box for this row)
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



// Called when the "delete" checkbox is checked or unchecked
function deleteCheckboxFeedback() {
    var datumInputs = $(this).parents('.datum').find('input.datum-field');
    
    // Mark all inputs as deleted
    if ($(this).is(':checked')) {
        
        datumInputs.prop('disabled', true);    
        
        datumInputs.each(function(i, input) {
            inputFeedbackDeleted.apply(input);
        });
    }
    
    // Or show input as edited or unmodivied
    else {
        datumInputs.prop('disabled', false);
    
        datumInputs.each(function(i, input) {
            inputFeedbackEdited.apply(input);
        });
    }
}



// Clear visual feedback for a given input box (this).
function inputFeedbackClear() {
    var textbox = $(this);
    var formgroup = textbox.parent();
    
    formgroup.removeClass('has-success has-error has-feedback');
    formgroup.find('.form-control-feedback').remove();
}






function submitVisualFeedback() {
    
    // find the datums for this submit button
    var datumForm = $(this).parents('.datum-form');
    
    // in case of multiple submits
    datumForm.find('.row.datum').removeClass('bg-sucess bg-danger');
    
    // Find all edited and deleted rows, based on the visual feedback.  (This is kind of a hack.)
    datumForm.find('.has-success').parents('.row.datum').addClass('bg-success');
    datumForm.find('.has-error').parents('.row.datum').addClass('bg-danger');
}




$(document).ready(function() {
    $('table#results').delegate('input.datum-field', 'change keyup', inputFeedbackEdited); // also on keyup?
    $('table#results').delegate('input.datum-delete-checkbox', 'change', deleteCheckboxFeedback);
    $('table#results').delegate('.submit-datums', 'click', submitVisualFeedback);
});
