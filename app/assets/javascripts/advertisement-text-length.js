function advertisement_text_length()

{
var text = document.getElementById('ads_text');
var content = text.value;
var length = content.length;
var commentlength = document.getElementById('ads_text_length');
commentlength.innerHTML = length + '/1000';
}
