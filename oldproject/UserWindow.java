import javax.swing.*;
import java.awt.*;

public class UserWindow extends JFrame {
    private final JTextField idField = new JTextField(10);
    private final JTextField nameField = new JTextField(10);
    
    public UserWindow() {
        super("User Management");
        setSize(400, 300);
        setDefaultCloseOperation(DISPOSE_ON_CLOSE);
        
        JPanel panel = new JPanel(new GridLayout(3, 2, 5, 5));
        panel.add(new JLabel("ID:")); panel.add(idField);
        panel.add(new JLabel("Name:")); panel.add(nameField);
        
        JButton save = new JButton("Save");
        save.addActionListener(e -> saveUser());
        panel.add(save);
        
        add(panel);
        setLocationRelativeTo(null);
    }
    
    private void saveUser() {
        if (idField.getText().isEmpty() || nameField.getText().isEmpty()) {
            JOptionPane.showMessageDialog(this, "ID and Name required");
            return;
        }
        JOptionPane.showMessageDialog(this, "User saved");
    }
}