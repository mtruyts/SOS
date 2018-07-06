package modelo;

import controle.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import javax.swing.JOptionPane;
import org.hibernate.cfg.AnnotationConfiguration;
import org.hibernate.tool.hbm2ddl.SchemaExport;

public class TestandoHibernate {

    public static void main(String[] args) {

        GerarTabelas();

        if (autenticar("matheus", "1234") != null) {
            System.out.println("Usuário autenticado");
        } else {
            System.out.println("Erro na autenticação");
        }
        try {
            persistindo();
        } catch (Exception ex) {
            JOptionPane.showMessageDialog(null, "Erro ao persistir objetos no banco de dados " + ex.getMessage());
        }

    }

    public static Autenticavel autenticar(String usuario, String senha) {
        return new PF().autenticar(usuario, senha);
    }

    private static void GerarTabelas() {
        AnnotationConfiguration cfg = new AnnotationConfiguration();
        cfg.configure("hibernate.cfg.xml");
        SchemaExport sx = new SchemaExport(cfg);
        sx.create(true, true);
    }

    private static void excluindo() {
    }

    private static void persistindo() throws Exception {
        PF pf = new PF();
        pf.setNome("Benefrancis do Nascimento");
        pf.setEmail("benefrancis@gmail.com");
        pf.setSenha("root");

        DocReceita cpf = new CPF(" 248. 788. 918-74 ");
        pf.setDocReceita(cpf);
        cpf.setPessoa(pf);



        if (pf.existe(cpf) == true) {
            throw new RuntimeException("<br><center><font face='verdana' color='red'   size='2'><br />já existe usuário cadastrado com o CPF ou CNPJ informado</font></center><br>");
        }



        Endereco end = new Endereco();
        end.setBairro("Jd Leni");
        end.setCep("05818250");
        end.setCidade("São Paulo");
        end.setLogradouro("Rua faustino Allende");
        end.setNumero("39");
        end.setUf("SP");
        end.setPessoa(pf);

        Collection<Endereco> e = new ArrayList<Endereco>();
        e.add(end);
        pf.setEndereco(e);

        Telefone t = new Telefone();
        t.setDdd(11);
        t.setNumero("8281-6536");
        t.setPessoa(pf);

        Collection<Telefone> tel = new ArrayList<Telefone>();
        tel.add(t);
        pf.setTelefone(tel);

        Animal a = new Cachorro();
        Date d = new Date();
        d.setDate(15);
        d.setMonth(5 - 1);
        d.setYear(2000 - 1900);

        a.setDataNascimento(d);
        a.setNome("Pluto");
        a.setRaca("Vira lata");
        a.setSexo('M');
        a.setObservacao("Cachorro muito sem vergonha!");
        a.setPessoa(pf);

        Servico s = new Banho();
        s.setData(new Date());
        s.setDescricao("Banho completo");
        s.setValor(20.95);
        s.setAnimal(a);

        Collection<Servico> serv = new ArrayList<Servico>();
        serv.add(s);
        a.setServico(serv);

        Collection<Animal> ani = new ArrayList<Animal>();
        ani.add(a);
        pf.setAnimal(ani);

        pf.salvar(pf);
    }
}
