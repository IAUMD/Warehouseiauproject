import javax.swing.*;
import java.awt.*;

public class MainMenu extends JFrame {
    public MainMenu() {
        setTitle("IMS - Main Menu");
        setSize(600, 400);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        
        JPanel panel = new JPanel(new GridLayout(5, 1, 10, 10));
        panel.setBorder(BorderFactory.createEmptyBorder(20, 20, 20, 20));
        
        addButton(panel, "Users", e -> new UserWindow().setVisible(true));
        addButton(panel, "Warehouses", e -> new WarehouseWindow().setVisible(true));
        addButton(panel, "Products", e -> new ProductWindow().setVisible(true));
        addButton(panel, "Suppliers", e -> new SupplierWindow().setVisible(true));
        addButton(panel, "Movements", e -> new MovementWindow().setVisible(true));
        
        add(panel);
        setLocationRelativeTo(null);
    }
    
    private void addButton(JPanel p, String text, ActionListener a) {
        JButton b = new JButton(text);
        b.addActionListener(a);
        p.add(b);
    }
}