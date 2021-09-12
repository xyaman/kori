import UIKit

class EditorView : UIView {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .purple
        let button = UIButton(frame: CGRect(x: 5, y: 5, width: 100, height: 100))
        
        button.setTitle("Exit", for: .normal)
        button.addTarget(self, action: #selector(stop), for: .touchUpInside)
        addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func stop() {
        Manager.sharedInstance.stopEditing()
    }
}
