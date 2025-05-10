import javax.swing.*;
import java.awt.*;

public class WarehouseWindow extends JFrame {
    private final JTextField idField = new JTextField(10);
    private final JTextField locField = new JTextField(10);
    
    public WarehouseWindow() {
        super("Warehouse Management");
        setSize(400, 300);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        
        JPanel panel = new JPanel(new GridLayout(3, 2, 5, 5));
        panel.add(new JLabel("ID:")); panel.add(idField);
        panel.add(new JLabel("Location:")); panel.add(locField);
        
        JButton save = new JButton("Save");
        save.addActionListener(e -> saveWarehouse());
        panel.add(save);
        
        add(panel);
        setLocationRelativeTo(null);
    }
    
    private void saveWarehouse() {
        if (idField.getText().isEmpty() || locField.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "ID and Location required");
            return;
        }
        JOptionPane.showMessageDialog(this, "Warehouse saved");
    }
}