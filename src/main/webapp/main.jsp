<%--
  Created by IntelliJ IDEA.
  User: Fanis
  Date: 5/25/2022
  Time: 8:39 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js" integrity="sha512-894YE6QWD5I59HgZOGReFYm4dnWc1Qt5NtvYSaNcOP+u1T9qYdvdihz0PPSiiqn/+/3e7Jo4EaG7TubfWGUrMQ==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
<script src="https://unpkg.com/moment@2.9.0/moment.js"></script>
<html>
<head>
    <title>Main</title>
</head>
<style type="text/css">
    * {
        margin: 0px;
        padding: 0px;
        box-sizing: border-box;
    }
    #optionsBox {
        width: 100%;
        top: 50px;
        position: absolute;
    }
    #optionsContent {
        display: block;
        margin-left: auto;
        margin-right: auto;
        width: 300px;
    }
    #dropdownContent {
        display: none;
    }
    #dropdownOptions {
        font-size: 20px;
        border: 1px solid black;
        text-align: center;
    }
    #responseBox{
        width: 100%;
        margin-top: 250px;
    }
    #responseContent {
        margin-left: 50px;
    }
</style>
<script type="application/javascript">
    $(document).ready(function() {

        $('#dropdownOptions').mouseover(function(){
            $('#dropdownContent').css("display", "block");
        });

        $('#dropdownOptions').mouseleave(function(){
            $('#dropdownContent').css("display", "none");
        });

        $('.option').mouseover(function() {
            $(this).css("color", "yellow");
            $(this).css("background-color", "blue");
        });

        $('.option').mouseleave(function() {
            $(this).css("color", "black");
            $(this).css("background-color", "white");
        });

        $('.option').click(function(){
            var operationId = $(this).attr("id");
            switch (operationId) {
                case "operation1":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div>Enter Record ID: <input id='recordId' type='text'>" +
                        "<br><button id='submit'>Submit</button><div id='responseId'></div></div>")
                    $('#submit').click(function(){
                        $('#responseId').empty();
                        if(isNaN($('#recordId').val())){
                            $('#responseId').append("<div style='color:red;'>Input is non-numerical.</div>");
                            return;
                        }
                        $.ajax({
                            type : "GET",
                            dataType : "json",
                            contentType : "application/json",
                            url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/" +
                                $('#recordId').val(),
                            async : false,
                            success : function(responseData){
                                if(responseData != null){
                                    $('#responseId').append("<div><i>Blood Glucose Level</i>: <b>" + responseData.bloodGlucoseLevel
                                        + "</b> | <i>Carb Intake</i>: <b>" + responseData.carbIntake
                                        + "</b> | <i>Medication Dose</i>: <b>" + responseData.medicationDose
                                        + "</b> | <i>Date Recorted</i>: <b>" + moment(responseData.dateRecorded).format('DD MMM YYYY')
                                        + "</b></div>");
                                } else {
                                    $('#responseId').append("<div style='color:red;'>Record not existing in Database.</div>");
                                }
                            },
                            error : function(){}
                        });
                    });
                    break;
                case "operation2":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div>Enter <i>Blood Glucose Level</i>:<input id='bloodGlucoseLevel' type='text'><br>" +
                        "<div>Enter <i>Carb Intake</i>:<input id='crabIntake' type='text'><br>" +
                        "<div>Enter <i>Medication Dose</i>:<input id='medicationDose' type='text'><br>" +
                        "<button id='submit'>Submit</button><div id='responseId'></div></div>")
                    $('#submit').click(function(){
                        $('#responseId').empty();
                        if(isNaN($('#bloodGlucoseLevel').val()) || isNaN($('#carbIntake').val())
                            || isNaN($('#medicationDose').val())){
                            $('#responseId').append("<div style='color:red;'>There are non-numerical inputs.</div>");
                            return;
                        }
                        if($('#bloodGlucoseLevel').val() <= 0 || $('#carbIntake').val() <= 0
                            || $('#medicationDose').val() <= 0) {
                            $('#responseId').append("<div style='color:red;'>Negative values (or 0; 0.1 is acceptable)" +
                                " are not permitted.</div>");
                            return;
                        }
                        var data = {
                            bloodGlucoseLevel : $('#bloodGlucoseLevel').val(),
                            carbIntake : $('#carbIntake').val(),
                            medicationDose : $('#medicationDose').val()
                        };
                        $.ajax({
                            type : "POST",
                            dataType : "json",
                            contentType : "application/json",
                            url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/add",
                            data : JSON.stringify(data),
                            async : false,
                            success : function(){
                                $('#responseId').append("<div style='color:green;'>Record added in Database!</div>");
                            },
                            error : function(){}
                        });
                    });
                    break;
                case "operation3":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div>Enter Record ID: <input id='recordId' type='text'>" +
                        "<br><button id='submit'>Submit</button><div id='responseId'></div></div>")
                    $('#submit').click(function(){
                        $('#responseId').empty();
                        if(isNaN($('#recordId').val())){
                            $('#responseId').append("<div style='color:red;'>Input is non-numerical.</div>");
                            return;
                        }
                        $.ajax({
                            type : "GET",
                            dataType : "json",
                            contentType : "application/json",
                            url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/" +
                                $('#recordId').val(),
                            async : false,
                            success : function(responseData){
                                if(responseData != null){
                                    $('#responseId').append("<div><i>Blood Glucose Level</i>: <input type='text' value='" + responseData.bloodGlucoseLevel + "' id='bloodGlucoseLevel'><br>" +
                                        "<i>Carb Intake</i>: <input type='text' value='" + responseData.carbIntake + "' id='carbIntake'/><br>" +
                                        "<i>Medication Dose</i>: <input type='text' value='" + responseData.medicationDose + "' id='medicationDose'/><br>" +
                                        "<i>Date Recorded</i>: <input type='date' value='" + moment(responseData.dateRecorded).format('YYYY-MM-DD') + "' id='dateRecorded'/><br>" +
                                        "<button id='submitUpdate'>Update Values</button>" +
                                        "</div>");
                                    $('#submitUpdate').click(function(){
                                        if(isNaN($('#bloodGlucoseLevel').val()) || isNaN($('#carbIntake').val())
                                            || isNaN($('#medicationDose').val())){
                                            $('#responseId').append("<div style='color:red;'>There are non-numerical inputs.</div>");
                                            return;
                                        }
                                        if($('#bloodGlucoseLevel').val() <= 0 || $('#carbIntake').val() <= 0
                                            || $('#medicationDose').val() <= 0) {
                                            $('#responseId').append("<div style='color:red;'>Negative values (or 0; 0.1 is acceptable)" +
                                                " are not permitted.</div>");
                                            return;
                                        }
                                        var updatedRecordObj = {
                                            diabetesRecordId : responseData.diabetesRecordId,
                                            bloodGlucoseLevel : $('#bloodGlucoseLevel').val(),
                                            carbIntake : $('#carbIntake').val(),
                                            medicationDose : $('#medicationDose').val(),
                                            dateRecorded : $('#dateRecorded').val()
                                        };
                                        $.ajax({
                                            type : "PUT",
                                            dataType : "json",
                                            contentType : "application/json",
                                            url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/update",
                                            data : JSON.stringify(updatedRecordObj),
                                            async : false,
                                            success : function() {
                                                $('#responseId').append("<div style='color:green;'>Record updated!</div>");
                                            },
                                            error : function() {}
                                        });
                                    });
                                } else {
                                    $('#responseId').append("<div style='color:red;'>Record not existing in Database.</div>");
                                }
                            },
                            error : function(){}
                        });
                    });
                    break;
                case "operation4":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div>Enter Record ID: <input id='recordId' type='text'>" +
                        "<br><button id='submit'>Submit</button><div id='responseId'></div></div>")
                    $('#submit').click(function(){
                        $('#responseId').empty();
                        if(isNaN($('#recordId').val())){
                            $('#responseId').append("<div style='color:red;'>Input is non-numerical.</div>");
                            return;
                        }
                        if(isRecordInDB($('#recordId').val()) === true) {
                            $.ajax({
                                type: "DELETE",
                                dataType: "json",
                                contentType: "application/json",
                                url: "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/delete/"
                                    + $('#recordId').val(),
                                async: false,
                                success: function () {
                                    $('#responseId').append("<div style='color:green;'>Record deleted from the Database.</div>");
                                },
                                error: function () {
                                }
                            });
                        } else {
                            $('#responseId').append("<div style='color:red;'>Requested record (to delete) is not in the Database.</div>");
                        }
                    });
                    break;
                case "operation5":

                    break;
                case "operation6":

                    break;
                case "operation7":

                    break;
            }
        });

        function isRecordInDB(recordId) {
            var exists = false;
            $.ajax({
                type : "GET",
                dataType : "json",
                contentType : "application/json",
                url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/"
                    + recordId,
                async : false,
                success : function(responseData){
                    if(responseData != null) {
                        exists = true;
                    } else {
                        exists = false;
                    }
                },
                error : function(){}
            });
            return exists;
        }

    });
</script>
<body>
<div id="optionsBox">
    <div id="optionsContent">
        <div id="dropdownOptions">
            Operations
            <div id="dropdownContent">
                <div class="option" id="operation1">Get (Specific) Diabetes Record</div>
                <div class="option" id="operation2">Add Diabetes Record</div>
                <div class="option" id="operation3">Update Diabetes Record</div>
                <div class="option" id="operation4">Delete Diabetes Record</div>
                <div class="option" id="operation5"> Get list of Diabetes Record</div>
                <div class="option" id="operation6"> Get average of blood glucose level</div>
                <div class="option" id="operation7"> Get average of carb intake</div>
            </div>
        </div>
    </div>
</div>
<div id="responseBox">
    <div id="responseContent">
    </div>
</div>
</body>
</html>
