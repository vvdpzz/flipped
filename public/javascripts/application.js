jQuery.extend(jQuery.validator.messages, {
	required: "必选字段",
	remote: "请修正该字段",
	email: "请输入正确格式的电子邮件",
	url: "请输入合法的网址",
	date: "请输入合法的日期",
	dateISO: "请输入合法的日期 (ISO).",
	number: "请输入合法的数字",
	digits: "只能输入整数",
	creditcard: "请输入合法的信用卡号",
	equalTo: "请再次输入相同的值",
	accept: "请输入拥有合法后缀名的字符串",
	maxlength: jQuery.validator.format("请输入一个长度最多是 {0} 的字符串"),
	minlength: jQuery.validator.format("请输入一个长度最少是 {0} 的字符串"),
	rangelength: jQuery.validator.format("请输入一个长度介于 {0} 和 {1} 之间的字符串"),
	range: jQuery.validator.format("请输入一个介于 {0} 和 {1} 之间的值"),
	max: jQuery.validator.format("请输入一个最大为 {0} 的值"),
	min: jQuery.validator.format("请输入一个最小为 {0} 的值")
});

function ajax_form(form_id, submit_button, loading_text, complete_text){
	var hash = {
		type: "POST",
		url: form_id.attr('action'),
		data: form_id.serialize(),
		beforeSend: function() {
            var obj = $('#' + submit_button + '_submit');
            obj.val(loading_text);
            obj.attr("disabled", "true");
        },
        complete: function() {
            var obj = $('#' + submit_button + '_submit');
            obj.val(complete_text);
            obj.attr("disabled", "");
        },
		success: function(data, textStatus, jqXHR){
			form_id[0].reset();
		},
		error: function(jqXHR, textStatus, errorThrown){
			alert(jqXHR.responseText);
		}
	}
	$.ajax(hash);
}
String.prototype.trim = function() {
	return this.replace(/^\s+|\s+$/g,"");
}
function setUpOnFocus(obj, defaultText) {
    if (defaultText)
        obj.data("defaultText", defaultText);
    if (obj.data("onfocusSetup")) {
        if (obj.data("empty") || obj.val() == "") {
            obj.val(obj.data("defaultText"));
            obj.data("empty", true);
            if (!obj.hasClass("default-text"))
                obj.addClass("default-text");
        }
        return;
    }
    obj.data("onfocusSetup", true);
    var isEmpty = (obj.val() == "" || obj.val() == obj.data("defaultText"));
    if (isEmpty) {
    obj.val(obj.data("defaultText"));
    obj.data("empty", true);
        obj.addClass("default-text");
    }

    obj.focus(function () {
    if (obj.val() == obj.data("defaultText")) {
        obj.val("");
            obj.removeClass("default-text");
    }
    obj.data("empty", false);
    })

    obj.blur(function () {
    var isEmpty = (obj.val() == "" || obj.val() == obj.data("defaultText"));
    if (isEmpty) {
        obj.val(obj.data("defaultText"));
        obj.data("empty", true);
            obj.addClass("default-text");
    }
    });

}
$(document).ready(function(){
	$("#user_new").validate();
	$('#new_tweet').submit(function() {
		ajax_form($(this), 'tweet', 'Sending', '喵～喵～');
		return false;
	});
	$('#new_comment').submit(function() {
		ajax_form($(this), 'comment', 'Sending', '回复');
		return false;
	});
	$(".new_message").keypress(function(event) {
		if (event.keyCode == '13') {
			event.preventDefault();
				var data = $(this).serialize();
				$(this)[0].reset();
				$.post("/messages/chat", data);
		}
	});
	setUpOnFocus($('#search_school'), "搜索你的学校...");
	$('.submit_message').remove();
});