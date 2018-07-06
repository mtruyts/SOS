<%-- 
    Document   : registrar
    Created on : 05/06/2010, 17:22:42

--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="br.com.benefrancis.controle.*" %>
<%@page import="br.com.benefrancis.util.Util" %>
<%@page import="java.util.List" %>
<%@page import="java.util.Date" %>
<%@page import="java.util.ListIterator" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.util.Collection" %>
<%@page import="java.util.Date" %>
<%
//Operações:
// 0 = nenhuma. Neste caso exibiremos o formulário pedindo para selecionar o dono do animal. Após selecionado submit será executado.
// 1 = buscar os animais do dono:
//    1a) Mostraremos os dados do dono(apagaremos o combobox de listagem de donos);
//    1b) Aguardamos que o usuário escolha o animal. Após selecionado submit será executado.
// 2 = registraremos o serviço executado.

//Iniciando a variável op
            int op = 0;
//verificando a variável op enviada pelo formulário:
            try {
                op = Integer.parseInt(Util.SoNumero(request.getParameter("op")));
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            
            List<Pessoa> pList = new ArrayList<Pessoa>();
           
            List<Animal> aList = new ArrayList<Animal>();
             
            //Serviço
            int servicoEscolhido = 0;
            Servico servico = null;
            String nome = null;
            
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <jsp:include page="../geral/head.jsp" />
    <body>        
        <table width="750" border="0" cellpadding="0" cellspacing="0" align="center">
            <tr>
                <td colspan="2">
                    <jsp:include page="../geral/topo.jsp" />
                </td>
            </tr>
            <tr>
                <td height="22" colspan="2" valign="top" class="Txt"><strong>CADASTRAMENTO DE  SERVIÇOS NO ANIMAL</strong></td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                </td>
            </tr>
            <%  if (op == 0) {%>
            <tr>
                <td colspan="2">
                    <form action="registrar.jsp" method="post" name="Formulario" >
                        <table width="750" border="0" cellpadding="0" cellspacing="0" align="center">
                            <tr>
                                <td colspan="2">
                            <tr>
                                <td width="162" class="Txt">Dono do animal</td>
                                <td width="436" class="Txt">
                                    <select name="idPessoa">
                                        <option value="0">  Selecione  </option>
                                        <%
                                  pList = Pessoa.consultar();
                                  for (ListIterator iter = pList.listIterator(); iter.hasNext();) {
                                      Pessoa achei = (Pessoa) iter.next();
                               %>
                                        <option value="<% out.print(achei.getIdPessoa());%>"><% out.print(achei.getNome());%></option>
                                        <%
                                  }
                             %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="Txt">&nbsp;</td>
                                <td class="Txt"><input type="hidden" name="op" value="1" />
                                    <input type="button" name="Btn_Entrar" value="Prosseguir >>"  onClick="ValidarRegistro1(document.Formulario);"  >
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>

                            </tr>
                        </table>
                    </form>
                    <jsp:include page="../geral/rodape.jsp" />
                </td>
            </tr>
            <% } else if (op == 1) {%>
            <tr>
                <td colspan="2">
                    <form action="registrar.jsp" method="post" name="Formulario" >
                        <table width="750" border="0" cellpadding="0" cellspacing="0" align="center">
                            <%
                      int idPessoa = Integer.parseInt(Util.SoNumero(request.getParameter("idPessoa")));
                      Pessoa donoAnimal = Pessoa.consultar(idPessoa);
                      %>
                            <tr>
                                <td colspan="2">
                                    <input type="hidden" name="idPessoa" value="<%out.print(donoAnimal.getIdPessoa());%>" />
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td width="20%" class="TopoTit">CLIENTE: </td>
                                            <td class="TextoTit"><% out.print(donoAnimal.getNome());%></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            <tr>
                                <td width="162" class="Txt">ANIMAL DE ESTIMAÇÃO</td>
                                <td width="436" class="Txt">
                                    <select name="idAnimal">
                                        <option value="0">  Selecione  </option>
                                        <%
                                  aList = (ArrayList<Animal>) Animal.consultar(donoAnimal);
                                  for (ListIterator iter = aList.listIterator(); iter.hasNext();) {
                                      Animal acheiAnimal = (Animal) iter.next();
                               %>
                                        <option value="<% out.print(acheiAnimal.getIdAnimal());%>"><% out.print(acheiAnimal.getNome());%></option>
                                        <%
                                  }
                               %>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="Txt">&nbsp;</td>
                                <td class="Txt">
                                    <input type="hidden" name="op" value="2" />
                                    <input type="button" name="Btn_Entrar" value="Prosseguir >>"  onClick="ValidarRegistro2(document.Formulario);" >
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>

                            </tr>
                        </table>
                        <jsp:include page="../geral/rodape.jsp" />

                    </form>

                </td>
            </tr>
            <%} else if (op == 2) {%>

            <tr>
                <td  height="104" colspan="2" valign="top" >
                    <form action="registrar.jsp" method="post" name="Formulario" >
                        <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
                            <!--DWLayoutTable-->
                            <%
                          int idPessoa = Integer.parseInt(Util.SoNumero(request.getParameter("idPessoa")));
                          Pessoa donoAnimal = Pessoa.consultar(idPessoa);

                          int idAnimal = Integer.parseInt(Util.SoNumero(request.getParameter("idAnimal")));
                          Animal animal = Animal.consultar(idAnimal);
                      %>
                            <tr>
                                <td colspan="2">
                                    <input type="hidden" name="idPessoa" value="<%out.print(donoAnimal.getIdPessoa());%>" />
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
                                        <tr >
                                            <td width="20%" class="TopoTit">CLIENTE: </td>
                                            <td class="TextoTit"><% out.print(donoAnimal.getNome());%></td>
                                        </tr>
                                        <tr>
                                            <td width="20%" class="TopoTit">ANIMAL DE ESTIMAÇÃO: </td>
                                            <td class="TextoTit" ><% out.print(animal.getNome());%></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2"><hr size="1"></td>
                            </tr>
                            <tr>
                                <td height="22" colspan="2" valign="top" class="Txt"><strong>SERVIÇO EXECUTADO</strong></td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <table width="100%" border="0" cellpadding="0" cellspacing="0" align="center">
                                        <tr>
                                            <td width="165" class="Txt">Serviço</td>
                                            <td width="581" class="Txt">
                                                <select name="servico" id="servico">
                                                    <option value="0">Selecione</option>
                                                    <option value="1">Consulta Veterinária</option>
                                                    <option value="2">Banho</option>
                                                    <option value="3">Tosa</option>
                                                    <option value="4">Vacina</option>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td width="165" height="27" valign="top" class="Txt">Nome / Descrição </td>
                                            <td width="581" valign="top" class="Txt">
                                                <input name="nome" type="text" id="nome" size="50" maxlength="100">
                                                <span class="style1">*</span></td>
                                        </tr>

                                        <tr>
                                            <td height="27" valign="top" class="Txt">Valor R$ </td>
                                            <td valign="top" class="Txt">
                                                <input name="valor" type="text"  size="11"  maxLength="10" onKeyUp="javascript:Sonumero(this)">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td height="27" valign="top" class="Txt">Observacao</td>
                                            <td valign="top" class="Txt">
                                                <textarea name="observacao" rows="4" cols="50"></textarea>
                                            <td width="10">
                                        </tr>
                                        <tr>
                                            <td colspan="2">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                <td class="Txt" width="23%">&nbsp;</td>
                                <td class="Txt" width="77%">
                                    <input type="hidden" name="op" value="3" />
                                    <input type="hidden" name="idAnimal" value="<% out.print(Util.SoNumero(request.getParameter("idAnimal")));%>" />
                                    <input type="button" name="Btn_Entrar" value="Cadastrar"  onClick="ValidarRegistro(document.Formulario);"    >
                                </td>
                            </tr>

                        </table>
                    </form>
                </td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">
                    <jsp:include page="../geral/rodape.jsp" />

                </td>
            </tr>
            <%} else if (op == 3) {%>
            <tr>
                <td colspan="2">
                    <%
                    try{
                    Animal animal=null;
                          try {
                              //Cadastraremos o serviço executado no animal de estimação de uma pessoa
                              //Buscando Animal
                              int idAnimal = Integer.parseInt(Util.SoNumero(request.getParameter("idAnimal")));
                              animal = Animal.consultar(idAnimal);
                              if (animal == null) {
                                  throw new RuntimeException("Erro na busca dos dados do animal.");
                              }
                              //Criando um objeto serviço conforme o serviço escolhido:
                              try {
                                  servicoEscolhido = Integer.parseInt(Util.SoNumero(request.getParameter("servico")));
                                  switch (servicoEscolhido) {
                                      case 1:
                                          servico = new Banho();
                                          break;
                                      case 2:
                                          servico = new Consulta();
                                          break;
                                      case 3:
                                          servico = new Tosa();
                                          break;
                                      case 4:
                                          servico = new Vacina();
                                          break;
                                      default:
                                          throw new RuntimeException("Serviço inválido! Favor selecionar o serviço executado.");
                                  }
                              } catch (Exception ex) {
                              }
                              } catch (Exception ex) {
                                  ex.printStackTrace();
                                  throw new RuntimeException("<br><center><font face='verdana' color='red'   size='2'><br />Erro ao pegar o nome do serviço efetuado</font></center><br>");
                              }
                              double valor = 0;
                              try {
                                  valor = Double.parseDouble(request.getParameter("valor"));
                                  servico.setValor(valor);
                              } catch (Exception ex) {
                                  ex.printStackTrace();
                                  throw new RuntimeException("<br><center><font face='verdana' color='red'   size='2'><br />Informe corretamente o valor do serviço executado</font></center><br>");
                              }

                              String descricao = null;
                              try {
                                  descricao = request.getParameter("nome");
                                  servico.setDescricao(descricao);
                              } catch (Exception ex) {
                                  ex.printStackTrace();
                                  throw new RuntimeException("<br><center><font face='verdana' color='red'   size='2'><br />Erro ao pegar o nome / descrição do serviço efetuado</font></center><br>");
                              }

                              String observacao = null;
                              try {
                                  observacao = request.getParameter("observacao");
                                  servico.setObservacao(observacao);
                              } catch (Exception ex) {
                                  ex.printStackTrace();
                                  throw new RuntimeException("<br><center><font face='verdana' color='red'   size='2'><br />Erro ao pegar observação referente ao serviço efetuado</font></center><br>");
                              }
                              //Adicionando o animal
                              servico.setAnimal(animal);
                              servico.setData(new Date());
                              //salvando
                              servico.salvar(servico);
                              out.print("<br>");
                              out.print("<br>");
                              out.print("<br>");
                              out.print("<br><center><font face='verdana' color='blue'   size='2'><br />Serviço cadastrado com sucesso</font></center><br>");
                              out.print("<br>");
                              out.print("<br>");
                          } catch (Exception ex) {
                              ex.printStackTrace();
                              out.print("<br>");
                              out.print("<br>");
                              out.print("<br>");
                              out.print("<br><center><font face='verdana' color='red'   size='2'><br />Erro ao cadastrar o serviço executado</font></center><br>");
                              out.print("<br><center><font face='verdana' color='red'   size='2'><br />" + ex.getMessage() + "</font></center><br>");
                              out.print("<br>");
                              out.print("<br>");
                          }
                    %>
                    <jsp:include page="../geral/rodape.jsp" />

                </td>
            </tr>
            <% }//fim do if de op%>
        </table>
    </body>
</html>