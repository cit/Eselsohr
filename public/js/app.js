// Foundation JavaScript
// Documentation can be found at: http://foundation.zurb.com/docs
$(document).foundation();
console.log("Testing");

$('#loginBtn').click(function(event){
	$(this).slideUp('200');
	$("form[name='login']").slideDown('230');
	
});	
