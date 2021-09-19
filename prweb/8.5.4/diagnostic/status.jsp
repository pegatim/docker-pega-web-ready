<%@ page import="java.util.*, java.io.*, com.pega.pegarules.api.util.StatusConstants, com.pega.pegarules.api.util.FilterUtils" %><%--
 * status.jsp
 *
 * Copyright (c) 2020  Pegasystems Inc.
 * All rights reserved.
 *
 * This  software  has  been  provided pursuant  to  a  License
 * Agreement  containing  restrictions on  its  use.   The  software
 * contains  valuable  trade secrets and proprietary information  of
 * Pegasystems Inc and is protected by  federal   copyright law.  It
 * may  not be copied,  modified,  translated or distributed in  any
 * form or medium,  disclosed to third parties or used in any manner
 * not provided for in  said  License Agreement except with  written
 * authorization from Pegasystems Inc.
 *
 * -----------------------------------------------------------------
 *
 * Sample customizable status screen for Pega platform messages. This page is
 * outside of the Pega platform rules engine and shouldn't make calls back into the
 * Web or Enterprise tiers, or reference Rule-File-* instances. Instead, 
 * rely on the information published below.
 *
--%><%
	String sStatus = (String)request.getAttribute(StatusConstants.ERROR_INFORMATION_STATUS);
    if(sStatus!=null){
          sStatus = FilterUtils.crossScriptingFilter(sStatus);
    }
	String sMessage = (String)request.getAttribute(StatusConstants.ERROR_INFORMATION_MESSAGE);
    if (sMessage != null) {
	   sMessage = FilterUtils.crossScriptingFilter(sMessage);
	}
	boolean bIsNoContent = false;
	if(request.getAttribute(StatusConstants.ERROR_INFORMATION_NO_OUTPUT)!=null)
		bIsNoContent = ((Boolean)request.getAttribute (StatusConstants.ERROR_INFORMATION_NO_OUTPUT)).booleanValue();
	
	// clear exceptions - otherwise some app servers will cache and prevent garbage collection at shutdown
	request.setAttribute(StatusConstants.ERROR_INFORMATION_EXCEPTIONS, null);
	
	if (bIsNoContent) {
		sStatus = "Success";
		sMessage = "The operation completed successfully";	
	} else {
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	}
	response.setHeader("Cache-Control", "max-age=0");
    if (sStatus == null || sStatus.equalsIgnoreCase("fail")) {
        sStatus = "Error";
    } 
    if (sMessage == null) {
        sMessage = "An error has occurred";
    }
%><!doctype html>
<html>
<head>
<title>Status Page</title>
<style>
body {
    font: 18px/22px sans-serif;
    font-weight: 400;
    font-style: normal;
    color: #000;
    height: 100vh;
    display: flex;
    overflow: hidden;
    margin: 0;
    text-align: center;
}
.error {
    margin: auto;
    max-width: 600px;
    padding: 16px;
}
</style>
</head>
<body>
  <div class='error'>
    <h1><%= sStatus %></h1>
    <p><%= sMessage %></p>
  </div>
</body>
</html>
