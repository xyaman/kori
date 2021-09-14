import UIKit

class ControlEditorView : UIView {
    
    // Data
    var currentEditKey: String?
    var currentEditValue: Float = 0
    var minValue: CGFloat = 0
    var maxValue: CGFloat = 0
    
    // UI
    var valueSlider = UISlider()
    var minLabel = UILabel()
    var maxLabel = UILabel()
    var currentLabel = UILabel()
    
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
        currentLabel.textAlignment = .center
        addSubview(currentLabel)
        
        currentLabel.translatesAutoresizingMaskIntoConstraints = false
        currentLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        currentLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -30).isActive = true
        currentLabel.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        currentLabel.bottomAnchor.constraint(equalTo:bottomAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startEdit(key: String) {
        currentEditKey = key
        currentEditValue = Manager.sharedInstance.preferences[key] as? Float ?? 0
        
        valueSlider.minimumValue = -300
        valueSlider.maximumValue = 300
        valueSlider.setValue(currentEditValue, animated: true)
        
        minLabel.text = "-300"
        maxLabel.text = "300"
        currentLabel.text = String(currentEditValue)
    }
    
    @objc func sliderDidChange(slider: UISlider) {
        
        currentEditValue = slider.value
        currentLabel.text = String(currentEditValue)
        
        // Edit preferences value
        if let key = currentEditKey {
            Manager.sharedInstance.preferences.set(slider.value, forKey: key)
            Manager.sharedInstance.notificationsView!.frame = CGRect()
        }
    }
}
