import UIKit
import MochiC

class EditorView : UIView {
    
    var topConstraint: NSLayoutConstraint!
    
    // Content
    var blurView: UIView!
    var closeView: UIImageView!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = 13
        layer.cornerCurve = .continuous
        
        // Blur View
        if let materialView = objc_getClass("MTMaterialView") as? MTMaterialView.Type {
            blurView = materialView.materialView(withRecipe: 1, configuration: 1)
            addSubview(blurView)
            
            blurView.translatesAutoresizingMaskIntoConstraints = false
            blurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
            blurView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            blurView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
            blurView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        }
        
        // Close View
        closeView = UIImageView(image: UIImage(systemName: "xmark"))
        closeView.tintColor = .label
        closeView.contentMode = .scaleAspectFit
        addSubview(closeView)
        
        closeView.translatesAutoresizingMaskIntoConstraints = false
        closeView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        closeView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        closeView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        closeView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Add buttons tap gestures
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(close))
        addGestureRecognizer(closeTap)

        // Pan movement gesture
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func close() {
        Manager.sharedInstance.stopEditing()
    }
    
    // Basically here we move the editor
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        let posY = gesture.location(in: superview).y
        let maxY = UIScreen.main.bounds.height - frame.height
        
        UIView.animate(withDuration: 0.2,
        animations: {
            self.topConstraint.constant = posY > maxY ? maxY : posY
            self.superview?.layoutIfNeeded()
        })
    }
}
