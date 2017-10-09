<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<h1>
	Create new Term
</h1>

<div id="errorMessage" class="bs-callout bs-callout-danger <c:if test="${empty errorMessage}">hidden</c:if>">
	<c:out value="${errorMessage}" />
</div>

<c:url value="/staff/termupdate" var="formAction"/>
<form:form method="POST" modelAttribute="term" action="${formAction}" cssClass="form-horizontal top50" role="form" id="termForm">
	<fieldset>
	
		<div class="form-group">
			<label for="year" class="col-sm-2 control-label">Year</label>
			<div class="col-sm-5">
				<form:input cssClass="form-control" path="year" />
			</div>
		</div>
		
		<div class="form-group">
			<label for="number" class="col-sm-2 control-label">Number</label>
			<div class="col-sm-5">
				<form:input cssClass="form-control" path="number" />
			</div>
		</div>
		
		<fmt:formatDate value="${term.startDate}" var="startDate" pattern="dd-MM-yyyy" />
		<div class="form-group">
			<label for="startDate" class="col-sm-2 control-label">Start Date</label>
			<div class="col-sm-5">
				<form:input cssClass="form-control date-field" path="startDate" value="${startDate}" />
			</div>
		</div>
		
		<fmt:formatDate value="${term.finishDate}" var="finishDate" pattern="dd-MM-yyyy" />
		<div class="form-group">
			<label for="finishDate" class="col-sm-2 control-label">Finish Date</label>
			<div class="col-sm-5">
				<form:input cssClass="form-control date-field" path="finishDate" value="${finishDate}" />
			</div>
		</div>
		
		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-5">
				<label class="checkbox-inline">
					<form:checkbox path="enabled" label="Enabled" value="1" />
				</label>
			</div>
		</div>

		<div class="form-group">
			<div class="col-sm-offset-2 col-sm-5">
				<button type="submit" class="btn btn-default">Create</button>
			</div>
		</div>
		
	</fieldset>
</form:form>

<script>
	// Form validation. Displays error message
	$(function() {
		$('#termForm').bootstrapValidator({
	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        live: 'enabled',
	        message: 'This value is not valid',
	        submitButtons: 'button[type="submit"]',
	        submitHandler: null,
	        trigger: null,
	        fields: {
	        	year: {
	                validators: {
	                    notEmpty: {
	                        message: 'Term year is required and cannot be empty'
	                    },
	                    integer: {
	                        message: 'This should be a positive integer number'
	                    },
	                    between: {
	                        min: 1900,
	                        max: 2999,
	                        message: 'Year should be between 1900 and 2999'
	                    }
	                }
	        	},
	        	number: {
	        		validators: {
	                    notEmpty: {
	                        message: 'Term number is required and cannot be empty'
	                    },
	                    integer: {
	                        message: 'This should be a positive integer number'
	                    },
	                    between: {
	                        min: 1,
	                        max: 10,
	                        message: 'Number should be between 1 and 10'
	                    }
	                }
	        	},
	        	startDate: {
	        		validators: {
	        			notEmpty: {
	                        message: 'Term stat date is required and cannot be empty'
	                    },
	                    regexp: {
                        	regexp: /^(\d{1,2})-(\d{1,2})-(\d{4})$/,
	                        message: 'Date format is not valid'
	                    }
	        		}
	        	},
	        	finishDate: {
	        		validators: {
	        			notEmpty: {
	                        message: 'Term finish date is required and cannot be empty'
	                    },
	                    regexp: {
	                    	regexp: /^(\d{1,2})-(\d{1,2})-(\d{4})$/,
	                        message: 'Date format is not valid'
	                    },
	                    different: {
	                        field: 'startDate',
	                        message: 'Finish date should not be the same as start date'
	                    }
	        		}
	            },
	        }
	    });
	});
</script>