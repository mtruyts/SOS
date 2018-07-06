<%-- 
    Document   : index
    Created on : 14/11/2010, 20:14:03
    Author     : Benefrancis
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.com.benefrancis.controle.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>PETSHOP</title>
        <link  rel="stylesheet" type="text/css" href="css/Estilo.css">

    </head>
    <body>

        <form name="FrmLogin" id="FrmLogin" method="POST"  action="index.jsp">
            <table width="103%"  border="0" cellpadding="0" cellspacing="0"align="center" >
                <tr>
                    <td align="center" valign="middle">
                        <table width="750"  border="0" cellspacing="0" cellpadding="0" align="center" >
                            <tr>
                                <td width="40%" height="500" align="center" valign="middle">
                                    <img src="images/login.png" alt="Petshop"/>
                                </td>
                                <td width="60%" align="center" valign="middle">
                                    <table border="0" >
                                        <tr>
                                            <td class="Txt">USUARIO</td>
                                            <td class="Txt"><input type="text" name="usuario" value="" size="15"/></td>
                                        </tr>
                                        <tr>
                                            <td class="Txt">SENHA</td>
                                            <td class="Txt"><input type="password" name="senha" value="" size="15" /></td>
                                        </tr>
                                        <tr>
                                            <td colspan="2"><hr size="1"><input type="hidden" name="op" value="1" /></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td><input type="submit" value="Autenticar" name="btn_autenticar" /></td>
                                        </tr>
                                        <tr><td colspan="2" class="Txt">
<%
String usuario = "";
String senha = "";
int op = 0;
try {
    op = Integer.parseInt(request.getParameter("op"));
} catch (Exception ex) {
}
try {
    if (op == 1) {
        usuario = request.getParameter("usuario");
        senha = request.getParameter("senha");
        Autenticavel p = new PF().autenticar(usuario, senha);
        if (p != null) {
            session.setAttribute("Usuario", p);
            String novaURL = "geral/inicio.jsp";
            response.sendRedirect(novaURL);
        } else {
            out.print("<br>");
            out.print("<center><font face='verdana' color='red'   " +
                    "size='2'>Usuario ou senha inválidos</font></center>");
            out.print("<br>");
        }
    }
} catch (Exception e) {
   e.printStackTrace();
}
%>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>