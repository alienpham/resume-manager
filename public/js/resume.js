$(document).ready(function() {
    //Begin Comment for resume
    $(".addcomment").fancybox();
    $(".addcomment").click(function(){
        $('#contentcomment').val(''); 
        $('input[name=resume_id]').val($(this).attr('id'));
    });

    $("#insertcomment").click(function(){
    	checkLogin();
        if(!$('#contentcomment').val()) {
            $('#msgcomment').html('Content is not null'); 
            return;
        }
        var resume_id = $('input[name=resume_id]').val();
        $.ajax({
            url: '/resume/save-comment',
            type: "POST",
            data: { 
                resume_id: resume_id, 
                consultant_id: $('input[name=consultant_id]').val(), 
                content: $('#contentcomment').val()
            },
            success: function(result) {
                $('#viewcomment' + resume_id).html(result);
                $.fancybox.close();
            }
        });
    });
    
    $(".allcomment").fancybox();
    $(".allcomment").click(function(){
    	checkLogin();
        var resume_id = $(this).attr('id');
        $.ajax({
            url: '/resume/all-comment',
            type: "POST",
            data: { 
                resume_id: resume_id, 
            },
            success: function(result) {
                $('#allcomment').html(result);
            }
        });
    });
    //End Comment for resume

    
    //Begin history for resume
    $(".addhistory").fancybox();
    $(".addhistory").click(function(){
        $('#contenthistory').val(''); 
        $('input[name=resume_id]').val($(this).attr('id'));
    });

    $("#inserthistory").click(function(){
    	checkLogin();
        if(!$('#contenthistory').val()) {
            $('#msghistory').html('Content is not null'); 
            return;
        }
        var resume_id = $('input[name=resume_id]').val();
        $.ajax({
            url: '/resume/save-history',
            type: "POST",
            data: { 
                resume_id: resume_id, 
                consultant_id: $('input[name=consultant_id]').val(), 
                content: $('#contenthistory').val()
            },
            success: function(result) {
                $('#viewhistory' + resume_id).html(result);
                $.fancybox.close();
            }
        });
    });
    
    $(".allhistory").fancybox();
    $(".allhistory").click(function(){
    	checkLogin();
        var resume_id = $(this).attr('id');
        $.ajax({
            url: '/resume/all-history',
            type: "POST",
            data: { 
                resume_id: resume_id, 
            },
            success: function(result) {
                $('#allhistory').html(result);
            }
        });
    });
    //End History for resume
    
    //Begin View detail candidate
    $(".detail_resume").fancybox();
    $(".detail_resume").click(function(){
    	checkLogin();
        $('#detail_resume').html('');
        var resume_id = $(this).attr('id');
        $.ajax({
            url: '/resume/detail-resume',
            type: "POST",
            data: { 
                resume_id: resume_id, 
            },
            success: function(result) {
                $('#detail_resume').html(result);
            }
        });
    });
    //End View detail candidate

    $('#rowperpage').change(function(){
        $('#frmresume').submit();
    });

    $('.pagination a');
});

function allComment(resume_id){
	checkLogin();
    $.ajax({
        url: '/resume/all-comment',
        type: "POST",
        data: { 
            resume_id: resume_id, 
        },
        success: function(result) {
            $('#allcomment').html(result);
        }
    });	    
}

function allHistory(resume_id){
	checkLogin();
    $.ajax({
        url: '/resume/all-history',
        type: "POST",
        data: { 
            resume_id: resume_id, 
        },
        success: function(result) {
            $('#allhistory').html(result);
        }
    });	    
}
