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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(valueSlider)
        
        valueSlider.translatesAutoresizingMaskIntoConstraints = false
        valueSlider.widthAnchor.constraint(equalTo: widthAnchor, constant: -140).isActive = true
        valueSlider.heightAnchor.constraint(equalTo:heightAnchor, constant: -15).isActive = true
        valueSlider.centerXAnchor.constraint(equalTo:centerXAnchor).isActive = true
        valueSlider.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -15).isActive = true
        
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
    }
}
