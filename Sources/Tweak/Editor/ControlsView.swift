import UIKit

class ControlEditorView : UIView {
    
    // Data
    var currentSetting: EditableSetting?
    
    // UI
    var slider = UISlider()
    var minLabel = UILabel()
    var maxLabel = UILabel()
    var currentTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        // Slider
        slider.addTarget(self, action: #selector(sliderDidBegin(slider:)), for: .touchDown)
        slider.addTarget(self, action: #selector(sliderDidChange(slider:)), for: .valueChanged)
        addSubview(slider)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.widthAnchor.constraint(equalTo: widthAnchor, constant: -140).isActive = true
        slider.heightAnchor.constraint(equalTo:heightAnchor, constant: -15).isActive = true
        slider.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        slider.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -15).isActive = true
        
        
        // Min label
        minLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(minLabel)
        
        minLabel.translatesAutoresizingMaskIntoConstraints = false
        minLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        minLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -15).isActive = true
        minLabel.leftAnchor.constraint(equalTo:leftAnchor, constant: 15).isActive = true
        minLabel.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -15).isActive = true
        
        
        // Max label
        maxLabel.font = UIFont.systemFont(ofSize: 12)
        addSubview(maxLabel)
        
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        maxLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -15).isActive = true
        maxLabel.rightAnchor.constraint(equalTo:rightAnchor, constant: -15).isActive = true
        maxLabel.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -15).isActive = true
        
        
        // Current label
        currentTextField.font = UIFont.systemFont(ofSize: 12)
        currentTextField.textAlignment = .center
        currentTextField.returnKeyType = .done
        currentTextField.keyboardType = .decimalPad
        currentTextField.addDoneButtonToKeyboard(target: self, action: #selector(textDone))
        addSubview(currentTextField)
        
        currentTextField.translatesAutoresizingMaskIntoConstraints = false
        currentTextField.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        currentTextField.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 2).isActive = true
        currentTextField.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        currentTextField.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startEdit(setting: EditableSetting) {
        currentSetting = setting
        let currentValue = Manager.sharedInstance.preferences[setting.key] as? Float ?? 0
        
        slider.minimumValue = Float(setting.minValue)
        slider.maximumValue = Float(setting.maxValue)
        slider.setValue(currentValue, animated: true)
        
        minLabel.text = "\(setting.minValue)"
        maxLabel.text = "\(setting.maxValue)"
        currentTextField.text = String(format: "%.2f", currentValue)
    }
    
    @objc func sliderDidBegin(slider: UISlider) {
        Manager.sharedInstance.impactFeedback?.impactOccurred()
    }
    
    @objc func sliderDidChange(slider: UISlider) {
        currentTextField.text = String(format: "%.2f", slider.value)
        Manager.sharedInstance.editSetting(currentSetting, value: CGFloat(slider.value))
    }
    
    
    // Used when you touch "Done" on UITextField
    @objc func textDone() {
        let newValue = ((currentTextField.text ?? "") as NSString).floatValue
        slider.value = newValue
        Manager.sharedInstance.editSetting(currentSetting, value: CGFloat(slider.value))
        
        currentTextField.resignFirstResponder()
    }
}
