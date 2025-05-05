import javax.swing.*;
import java.awt.*;

public class SupplierWindow extends JFrame {
    private final JTextField idField = new JTextField(10);
    private final JTextField nameField = new JTextField(10);
    
    public SupplierWindow() {
        super("Supplier Management");
        setSize(400, 300);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        
        JPanel panel = new JPanel(new GridLayout(3, 2, 5, 5));
        panel.add(new JLabel("ID:")); panel.add(idField);
        panel.add(new JLabel("Name:")); panel.add(nameField);
        
        JButton save = new JButton("Save");
        save.addActionListener(e -> saveSupplier());
        panel.add(save);
        
        add(panel);
        setLocationRelativeTo(null);
    }
    
    private void saveSupplier() {
        if (idField.getText().isEmpty() || nameField.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "ID and Name required");
            return;
        }
        JOptionPane.showMessageDialog(this, "Supplier saved");
    }
}