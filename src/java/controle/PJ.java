package controle;
import javax.persistence.*;
@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@DiscriminatorValue("2")
public class PJ extends Pessoa {

    public PJ() {
        super.setTipo(PJ);
    }
}








