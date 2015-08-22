

/* Popover for search and add new link*/
var initPopover = function(elm){
	var $elmId = $('#' + elm);
	var $elmClass = $('.' + elm);

	$elmId.popover({
	    html: true,
	    placement: 'bottom',
	    title: function () {
	        return $elmClass.find('.head').html();
	    },
	    content: function () {
	        return $elmClass.find('.content').html();
	    }
	}).click(function(event){
		/*Clear input field of search popover*/
		$(".js-hasclear").on('keyup', function () {
		    var t = $(this);
		    t.next('span').toggle(Boolean(t.val()));
		});
		$(".js-clearer").hide($(this).prev('input').val());
		console.log($(".js-clearer"));
		$(".js-clearer").on('click',function () {
			console.log('foobar!');
		    $(this).prev('input').val('').focus();
		    $(this).hide();
		});
	});
};

initPopover('searchPopover');
initPopover('addPopover');

$('.js-openPopover').on('click', function(event){
	$('.js-openPopover').not(this).popover('hide');
});
/*****************************************/




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

