import javax.swing.*;
import java.awt.*;

public class MovementWindow extends JFrame {
    private final JTextField idField = new JTextField(10);
    private final JComboBox<String> productBox = new JComboBox<>(new String[]{"Laptop", "Chair"});
    private final JSpinner qtySpinner = new JSpinner(new SpinnerNumberModel(1, 1, 100, 1));
    
    public MovementWindow() {
        super("Movement Management");
        setSize(400, 300);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        
        JPanel panel = new JPanel(new GridLayout(4, 2, 5, 5));
        panel.add(new JLabel("ID:")); panel.add(idField);
        panel.add(new JLabel("Product:")); panel.add(productBox);
        panel.add(new JLabel("Qty:")); panel.add(qtySpinner);
        
        JButton save = new JButton("Save");
        save.addActionListener(e -> saveMovement());
        panel.add(save);
        
        add(panel);
        setLocationRelativeTo(null);
    }
    
    private void saveMovement() {
        if (idField.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "ID required");
            return;
        }
        JOptionPane.showMessageDialog(this, "Movement saved");
    }
}