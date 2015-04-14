// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();

/**
* click event to slide down loggin form
*
*/
$('#loginBtn').click(function(event){
	$(this).slideUp('200');
	$("form[name='login']").slideDown('230');
	
});	


var username = $('table').attr('data-user');

/**
* click event to toggle between editableText and textarea
*/
$('table').find('.editText').on('click', function(event){
	var $currentTarget = $(event.currentTarget);
	var $editableText = $currentTarget.siblings('.editableText');
	var $textarea = $('<textarea class="editableTextarea"></textarea');


	if($editableText.is(":visible")){
		$textarea.val($editableText.html());
		$editableText.hide();
		$currentTarget.parent().append($textarea);
	} else {
		$textarea = $currentTarget.siblings('.editableTextarea');
		var desc = $textarea.val();
		var id = $currentTarget.parent().attr('id');
		$editableText.html(desc)
		$editableText.show();

		testingAjax(username, desc, id);
		$textarea.remove();
	}
});

var testingAjax = function(username, desc, id){
	$.ajax({
  		method: "POST",
  		url: "/" + username + "/update/" + id,
  		data: { desc: desc }
	})
  	.done(function( msg ) {
    	alert( "Data Saved: " + msg );
  	});
}


