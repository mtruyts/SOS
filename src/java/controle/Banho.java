package controle;
import javax.persistence.*;
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorValue("1")
public class Banho extends Servico {

    public Banho() {
        super.setTipo(BANHO);
        super.setNome("Banho");
    }
}