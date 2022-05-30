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
            $(this).css("cursor", "pointer");
        });

        $('.option').mouseleave(function() {
            $(this).css("color", "black");
            $(this).css("background-color", "white");
            $(this).css("cursor", "default");
        });

        $('.option').click(function(){
            var operationId = $(this).attr("id");
            switch (operationId) {
                // Get operation for data record.
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
                // Add operation for new data record.
                case "operation2":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div><div>Enter <i>Blood Glucose Level</i>:<input id='bloodGlucoseLevel' type='text'></div>" +
                        "<div>Enter <i>Carb Intake</i>:<input id='carbIntake' type='text'></div>" +
                        "<div>Enter <i>Medication Dose</i>:<input id='medicationDose' type='text'></div>" +
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
                // Update operation for existing data record.
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
                // Delete operation for existing data record.
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
                // "Display all the above data over a (user-specified) time period".
                case "operation5":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div><div id='startingDate'>Enter <i>starting date</i>:<input id='startingDateInput' type='date'/></div>" +
                        "<div id='endingDate'>Enter <i>ending date</i>:<input id='endingDateInput' type='date'/></div>" +
                        "<button id='submitDates'>Submit</button><div id='responseId'></div></div>");
                    $('#submitDates').click(function(){
                        $('#responseId').empty();
                        var startDate = moment($('#startingDateInput').val());
                        var endDate = moment($('#endingDateInput').val());
                        if(startDate.isAfter(endDate)) {
                            $('#responseId').append("<div style='color:red;'>Starting date should be prior to the ending date.</div>");
                            return;
                        } else {
                            $.ajax({
                                type : "GET",
                                dataType : "json",
                                contentType : "application/json",
                                url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/list?startingDate="
                                    + $('#startingDateInput').val() + "&endingDate=" + $('#endingDateInput').val(),
                                async : false,
                                success : function(responseData){
                                    if(responseData.length === 0) {
                                        $('#responseId').append("<div style='color:green;'>There are no records in the database for that date range.</div>");
                                        return;
                                    }
                                    var sortedList = responseData.sort((a, b) => (a.diabetesRecordId > b.diabetesRecordId) ? 1 : -1);
                                    for(var i=0; i<sortedList.length; i++) {
                                        $('#responseId').append("<div><i>Record ID</i>: <b>" + sortedList[i].diabetesRecordId + "</b>"
                                            + " | <i>Blood Glucose Level</i>: <b>" + sortedList[i].bloodGlucoseLevel
                                            + "</b> | <i>Carb Intake</i>: <b>" + sortedList[i].carbIntake
                                            + "</b> | <i>Medication Dose</i>: <b>" + sortedList[i].medicationDose
                                            + "</b> | <i>Date Recorted</i>: <b>" + moment(sortedList[i].dateRecorded).format('DD MMM YYYY')
                                            + "</b></div>");
                                    }
                                },
                                error : function(){}
                            });
                        }
                    });
                    break;
                // Display the average daily blood glucose level over a (user-specified) period.
                case "operation6":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div><div id='startingDate'>Enter <i>starting date</i>:<input id='startingDateInput' type='date'/></div>" +
                        "<div id='endingDate'>Enter <i>ending date</i>:<input id='endingDateInput' type='date'/></div>" +
                        "<button id='submitDates'>Submit</button><div id='responseId'></div></div>");
                    $('#submitDates').click(function(){
                        $('#responseId').empty();
                        var startDate = moment($('#startingDateInput').val());
                        var endDate = moment($('#endingDateInput').val());
                        if(startDate.isAfter(endDate)) {
                            $('#responseId').append("<div style='color:red;'>Starting date should be prior to the ending date.</div>");
                            return;
                        } else {
                            $.ajax({
                                type : "GET",
                                dataType : "json",
                                contentType : "application/json",
                                url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/averageBloodGlucose?startingDate="
                                    + $('#startingDateInput').val() + "&endingDate=" + $('#endingDateInput').val(),
                                async : false,
                                success : function(responseData){
                                    if(responseData.length === 0) {
                                        $('#responseId').append("<div style='color:green;'>There are no records in the database for that date range.</div>");
                                        return;
                                    }
                                    var displayAverage = (date1, date2) => {
                                        if(date1 === '' || date2 === '') {
                                            $('#responseId').append("<div style='color:green;'>The average daily blood glucose level for the " +
                                                "entire database timespan is " + responseData + ".</div>");
                                        } else {
                                            $('#responseId').append("<div style='color:green;'>The average daily blood glucose level for the " +
                                                "given range (" + date1 + " until " + date2 + ") is " + responseData +".</div>");
                                        }
                                    };
                                    displayAverage($('#startingDateInput').val(), $('#endingDateInput').val());
                                },
                                error : function(){}
                            });
                        }
                    });
                    break;
                // Display the average carb intake over a (user-specified) period.
                case "operation7":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div><div id='startingDate'>Enter <i>starting date</i>:<input id='startingDateInput' type='date'/></div>" +
                        "<div id='endingDate'>Enter <i>ending date</i>:<input id='endingDateInput' type='date'/></div>" +
                        "<button id='submitDates'>Submit</button><div id='responseId'></div></div>");
                    $('#submitDates').click(function(){
                        $('#responseId').empty();
                        var startDate = moment($('#startingDateInput').val());
                        var endDate = moment($('#endingDateInput').val());
                        if(startDate.isAfter(endDate)) {
                            $('#responseId').append("<div style='color:red;'>Starting date should be prior to the ending date.</div>");
                            return;
                        } else {
                            $.ajax({
                                type : "GET",
                                dataType : "json",
                                contentType : "application/json",
                                url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/averageCarbIntake?startingDate="
                                    + $('#startingDateInput').val() + "&endingDate=" + $('#endingDateInput').val(),
                                async : false,
                                success : function(responseData){
                                    if(responseData.length === 0) {
                                        $('#responseId').append("<div style='color:green;'>There are no records in the database for that date range.</div>");
                                        return;
                                    }
                                    var displayAverage = (date1, date2) => {
                                        if(date1 === '' || date2 === '') {
                                            $('#responseId').append("<div style='color:green;'>The average carb intake for the " +
                                                "entire database timespan is " + responseData + ".</div>");
                                        } else {
                                            $('#responseId').append("<div style='color:green;'>The average carb intake for the " +
                                                "given range (" + date1 + " until " + date2 + ") is " + responseData +".</div>");
                                        }
                                    };
                                    displayAverage($('#startingDateInput').val(), $('#endingDateInput').val());
                                },
                                error : function(){}
                            });
                        }
                    });
                    break;
                // Display chart depicting the daily blood glucose level over a user specified period.
                case "operation8":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div><div id='startingDate'>Enter <i>starting date</i>:<input id='startingDateInput' type='date'/></div>" +
                        "<div id='endingDate'>Enter <i>ending date</i>:<input id='endingDateInput' type='date'/></div>" +
                        "<button id='submitDates'>Submit</button><div id='responseId'></div></div>");
                    $('#submitDates').click(function(){
                        $('#responseId').empty();
                        var startDate = moment($('#startingDateInput').val());
                        var endDate = moment($('#endingDateInput').val());
                        if(startDate.isAfter(endDate)) {
                            $('#responseId').append("<div style='color:red;'>Starting date should be prior to the ending date.</div>");
                            return;
                        } else {
                            $.ajax({
                                type : "GET",
                                url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/chart?startingDate="
                                    + $('#startingDateInput').val() + "&endingDate=" + $('#endingDateInput').val() + "&chartCase=" +
                                    "bloodGlucoseSingle",
                                async : false,
                                success : function(responseData){
                                    $('#responseId').append("<img id='chartImage' src=''>");
                                    // we retrieve the image as a base64 encoded String, and we display as shown below;
                                    $('#chartImage').attr('src', "data:image/png;base64," + responseData);
                                },
                                error : function(){}
                            });
                        }
                    });
                    break;
                // Display chart depicting the carbon intake over a user specified period.
                case "operation9":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div><div id='startingDate'>Enter <i>starting date</i>:<input id='startingDateInput' type='date'/></div>" +
                        "<div id='endingDate'>Enter <i>ending date</i>:<input id='endingDateInput' type='date'/></div>" +
                        "<button id='submitDates'>Submit</button><div id='responseId'></div></div>");
                    $('#submitDates').click(function(){
                        $('#responseId').empty();
                        var startDate = moment($('#startingDateInput').val());
                        var endDate = moment($('#endingDateInput').val());
                        if(startDate.isAfter(endDate)) {
                            $('#responseId').append("<div style='color:red;'>Starting date should be prior to the ending date.</div>");
                            return;
                        } else {
                            $.ajax({
                                type : "GET",
                                url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/chart?startingDate="
                                    + $('#startingDateInput').val() + "&endingDate=" + $('#endingDateInput').val() + "&chartCase=" +
                                    "carbonIntakeSingle",
                                async : false,
                                success : function(responseData){
                                    $('#responseId').append("<img id='chartImage' src=''>");
                                    $('#chartImage').attr('src', "data:image/png;base64," + responseData);
                                },
                                error : function(){}
                            });
                        }
                    });
                    break;
                /* Display chart depicting both (daily blood glucose level and the carbon intake)
                   over a user specified period. */
                case "operation10":
                    $('#responseContent').empty();
                    $('#responseContent').append("<div><div id='startingDate'>Enter <i>starting date</i>:<input id='startingDateInput' type='date'/></div>" +
                        "<div id='endingDate'>Enter <i>ending date</i>:<input id='endingDateInput' type='date'/></div>" +
                        "<button id='submitDates'>Submit</button><div id='responseId'></div></div>");
                    $('#submitDates').click(function(){
                        $('#responseId').empty();
                        var startDate = moment($('#startingDateInput').val());
                        var endDate = moment($('#endingDateInput').val());
                        if(startDate.isAfter(endDate)) {
                            $('#responseId').append("<div style='color:red;'>Starting date should be prior to the ending date.</div>");
                            return;
                        } else {
                            $.ajax({
                                type : "GET",
                                url : "http://localhost:8090/DiabetesMonitoringApp_war_exploded/api/diabetes-records/chart?startingDate="
                                    + $('#startingDateInput').val() + "&endingDate=" + $('#endingDateInput').val() + "&chartCase=" +
                                    "bothInOne",
                                async : false,
                                success : function(responseData){
                                    $('#responseId').append("<img id='chartImage' src=''>");
                                    $('#chartImage').attr('src', "data:image/png;base64," + responseData);
                                },
                                error : function(){}
                            });
                        }
                    });
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

        /* "A client-side filter that ensures that all client requests encompass an
            authentication header with a username and password"
            Got help from these sources;
            https://www.ibm.com/docs/en/imdm/11.6?topic=provider-creating-soapui-http-basic-auth-header
            https://developer.mozilla.org/en-US/docs/web/api/btoa#unicode_strings
        */
        $.ajaxPrefilter(function(options, originalOptions, jqXHR){
            /*
                Part from the source that I read ->
                "<...> if you pass a string into btoa() containing characters that occupy more than one byte,
                you will get an error, because this is not considered binary data <...>"
                btw in each JavaScript string, each character occupies 2 bytes source ->
                https://stackoverflow.com/questions/2219526/how-many-bytes-in-a-javascript-string
                So the steps are the following; convert the desired string to binary and encode it
                in base64.
                The value of the header is recommended (by the IBM) to be in the form; username:password
            */
            var valueOfHeader = "<%=session.getAttribute("username")%>:<%=session.getAttribute("password")%>"
            var convertedValue = toBinary(valueOfHeader);
            jqXHR.setRequestHeader("Authorization", "Basic " + btoa(convertedValue));
        });

        function toBinary(string) {
            const codeUnits = new Uint16Array(string.length);
            for (let i = 0; i < codeUnits.length; i++) {
                codeUnits[i] = string.charCodeAt(i);
            }
            const charCodes = new Uint8Array(codeUnits.buffer);
            let result = '';
            for (let i = 0; i < charCodes.byteLength; i++) {
                result += String.fromCharCode(charCodes[i]);
            }
            return result;
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
                <div class="option" id="operation8"> Line chart (blood glucose level)</div>
                <div class="option" id="operation9"> Line chart (carbon intake)</div>
                <div class="option" id="operation10"> Line chart (both in one)</div>
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
