import UIKit
import MochiC

class EditorView : UIView {
    
    var topConstraint: NSLayoutConstraint!
    
    // Edit
    var collectionView: UICollectionView!
    var collectionLayout: UICollectionViewFlowLayout!
    
    // Controls
    var controlsView: ControlEditorView = ControlEditorView()
    
    var blurView: UIView!
    var closeView: UIImageView!
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // View settings
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
        closeView.isUserInteractionEnabled = true
        addSubview(closeView)
        
        closeView.translatesAutoresizingMaskIntoConstraints = false
        closeView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        closeView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        closeView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        closeView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        // Collection view
        collectionLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: "SettingCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo:topAnchor, constant: 40).isActive = true
        collectionView.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -8).isActive = true
        collectionView.leftAnchor.constraint(equalTo:leftAnchor, constant: 10).isActive = true
        collectionView.rightAnchor.constraint(equalTo:rightAnchor, constant: -10).isActive = true
        
        // Controls View
        controlsView.isHidden = true
        addSubview(controlsView)
        
        controlsView.translatesAutoresizingMaskIntoConstraints = false
        controlsView.topAnchor.constraint(equalTo:topAnchor, constant: 40).isActive = true
        controlsView.bottomAnchor.constraint(equalTo:bottomAnchor, constant: -8).isActive = true
        controlsView.leftAnchor.constraint(equalTo:leftAnchor, constant: 10).isActive = true
        controlsView.rightAnchor.constraint(equalTo:rightAnchor, constant: -10).isActive = true
        
        // Add buttons tap gestures
        let closeTap = UITapGestureRecognizer(target: self, action: #selector(close))
        closeView.addGestureRecognizer(closeTap)

        // Pan movement gesture
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func close() {
        Manager.sharedInstance.stopEditing()
        controlsView.isHidden = true
        collectionView.isHidden = false
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

extension EditorView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Manager.sharedInstance.editableKeys.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingCell", for: indexPath) as! SettingCell
        cell.label.text = Manager.sharedInstance.editableKeys[indexPath.row]
        return cell
    }
}

extension EditorView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        controlsView.isHidden = false
        collectionView.isHidden = true
        
        let key = Manager.sharedInstance.editableKeys[indexPath.row]
        controlsView.startEdit(key: key)
    }
}
