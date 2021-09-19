<%@ page isErrorPage="true" import="java.util.*, java.io.*" %><%--
 * error.jsp
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
    String sDetails="";
    Class filterUtils = null;	
    java.lang.reflect.Method stringUtilMethodInfo = null;
    try {
     if(exception != null){
      filterUtils = Class.forName("com.pega.pegarules.api.util.FilterUtils");
      stringUtilMethodInfo = filterUtils.getMethod("crossScriptingFilter", java.lang.String.class);
      sDetails = exception.getClass().getName()+ " : " + (java.lang.String)stringUtilMethodInfo.invoke(null,exception.getMessage());	 
     }
    } catch(Exception e) {}
    if(sDetails == null) sDetails = "";
%><!doctype html>
<html>
<head>
<title>Error Page</title>
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
    <h1>An error has occurred processing this request</h1>
    <p><%= sDetails %></p>
  </div>
</body>
</html>
