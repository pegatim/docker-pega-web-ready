<%@ page import="java.util.*, java.io.*, com.pega.pegarules.api.util.StatusConstants, com.pega.pegarules.api.util.FilterUtils" contentType="text/xml;charset=utf-8" %><?xml version="1.0" encoding="utf-8"?>
<%--
NOTE: Do NOT add additional spacing/newlines to the line above; otherwise certain XML parsers will complain about this document
not leading off with the <?xml?> tag.
--%>
<%--
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
--%>
<%
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
%>
<status>
  <title>Request Status</title>
  <status><%= sStatus %></status>
  <message><%= sMessage %></message>
</status>
