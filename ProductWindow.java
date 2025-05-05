import javax.swing.*;
import java.awt.*;

public class ProductWindow extends JFrame {
    private final JTextField idField = new JTextField(10);
    private final JTextField nameField = new JTextField(10);
    private final JSpinner priceSpinner = new JSpinner(new SpinnerNumberModel(0.0, 0.0, 1000.0, 0.5));
    
    public ProductWindow() {
        super("Product Management");
        setSize(400, 300);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        
        JPanel panel = new JPanel(new GridLayout(4, 2, 5, 5));
        panel.add(new JLabel("ID:")); panel.add(idField);
        panel.add(new JLabel("Name:")); panel.add(nameField);
        panel.add(new JLabel("Price:")); panel.add(priceSpinner);
        
        JButton save = new JButton("Save");
        save.addActionListener(e -> saveProduct());
        panel.add(save);
        
        add(panel);
        setLocationRelativeTo(null);
    }
    
    private void saveProduct() {
        if (idField.getText().isEmpty() || nameField.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "ID and Name required");
            return;
        }
        JOptionPane.showMessageDialog(this, "Product saved");
    }
}