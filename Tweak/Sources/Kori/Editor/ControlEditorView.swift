import UIKit

class ControlEditorView : UIView {
    
    // Data
    var currentEditSetting: EditableSetting?
    var currentEditValue: Float = 0
    var minValue: CGFloat = 0
    var maxValue: CGFloat = 0
    
    // UI
    var valueSlider = UISlider()
    var minLabel = UILabel()
    var maxLabel = UILabel()
    var currentTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        // Slider
        valueSlider.addTarget(self, action: #selector(sliderDidChange(slider:)), for: .valueChanged)
        addSubview(valueSlider)
        
        valueSlider.translatesAutoresizingMaskIntoConstraints = false
        valueSlider.widthAnchor.constraint(equalTo: widthAnchor, constant: -140).isActive = true
        valueSlider.heightAnchor.constraint(equalTo:heightAnchor, constant: -15).isActive = true
        valueSlider.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        valueSlider.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -15).isActive = true
        
        
        // Min label
        addSubview(minLabel)
        
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        minLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -15).isActive = true
        minLabel.leftAnchor.constraint(equalTo:leftAnchor, constant: 15).isActive = true
        minLabel.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -15).isActive = true
        
        // Max label
        addSubview(maxLabel)
        
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        maxLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -15).isActive = true
        maxLabel.rightAnchor.constraint(equalTo:rightAnchor, constant: -15).isActive = true
        maxLabel.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -15).isActive = true
        
        // Current label
        currentTextField.textAlignment = .center
        currentTextField.returnKeyType = .done
        currentTextField.keyboardType = .numberPad
        currentTextField.addDoneButtonToKeyboard(target: self, action: #selector(textDone))
        
        addSubview(currentTextField)
        
        currentTextField.translatesAutoresizingMaskIntoConstraints = false
        currentTextField.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        currentTextField.topAnchor.constraint(equalTo: valueSlider.bottomAnchor, constant: 2).isActive = true
        currentTextField.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        currentTextField.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startEdit(setting: EditableSetting) {
        currentEditSetting = setting
        currentEditValue = Manager.sharedInstance.preferences[setting.key] as? Float ?? 0
        
        valueSlider.minimumValue = Float(setting.minValue)
        valueSlider.maximumValue = Float(setting.maxValue)
        valueSlider.setValue(currentEditValue, animated: true)
        
        minLabel.text = "-300"
        maxLabel.text = "300"
        currentTextField.text = String(format: "%.2f", currentEditValue)
    }
    
    @objc func sliderDidChange(slider: UISlider) {
        
        currentEditValue = slider.value
        currentTextField.text = String(format: "%.2f", currentEditValue)
        
        // Edit preferences value
        if let setting = currentEditSetting {
            Manager.sharedInstance.preferences.set(slider.value, forKey: setting.key)
            Manager.sharedInstance.editValue(setting: setting)
        }
    }
    
    // Used by UITextField
    @objc func textDone() {
        if let newValue = NumberFormatter().number(from: currentTextField.text ?? "") {
            currentEditValue = Float(truncating: newValue)
            valueSlider.value = Float(truncating: newValue)
            Manager.sharedInstance.preferences.set(newValue, forKey: currentEditSetting!.key)
            Manager.sharedInstance.editValue(setting: currentEditSetting!)
        }
        
        currentTextField.resignFirstResponder()
    }
}
