/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package controle;

/**
 *
 * @author Benefrancis
 */
public interface Autenticavel {

    public Autenticavel autenticar(String usuario, String senha);

    public boolean existe(String usuario);
}
