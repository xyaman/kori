import UIKit
import TweakC

class EditorView : UIView {
    
    var topConstraint: NSLayoutConstraint!
    
    // UI
    var blurView: UIView!
    var closeView: UIImageView!
    var returnView: UIImageView!
    var titleLabel: UILabel!
    var collectionView: UICollectionView!
    var collectionLayout: UICollectionViewFlowLayout!
    
    
    // Controls
    var controlsView: ControlEditorView = ControlEditorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // View settings
        backgroundColor = .clear
        clipsToBounds = true
        layer.cornerRadius = 13
        layer.cornerCurve = .continuous

        // Blur View
        let materialView = objc_getClass("MTMaterialView") as! MTMaterialView.Type
        blurView = materialView.materialView(withRecipe: 1, configuration: 1)
        addSubview(blurView)
        
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        
        
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
        
        // Return View
        returnView = UIImageView(image: UIImage(systemName: "arrow.uturn.backward"))
        returnView.isHidden = true
        returnView.tintColor = .label
        returnView.contentMode = .scaleAspectFit
        returnView.isUserInteractionEnabled = true
        addSubview(returnView)
        
        returnView.translatesAutoresizingMaskIntoConstraints = false
        returnView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        returnView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        returnView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        returnView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        // TitleLabel
        titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "Editor"
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 30).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        
        // Collection view
        collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.itemSize = CGSize(width: 70, height: 70)
        collectionLayout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: "SettingCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo:topAnchor, constant: 45).isActive = true
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
        let closeTap = UITapGestureRecognizer(target: Manager.sharedInstance, action: #selector(Manager.sharedInstance.stopEditing))
        closeView.addGestureRecognizer(closeTap)
        
        let returnTap = UITapGestureRecognizer(target: self, action: #selector(toggleControlsView))
        returnView.addGestureRecognizer(returnTap)

        // Pan movement gesture
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(pan)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func toggleControlsView() {
        Manager.sharedInstance.selectionFeedback?.selectionChanged()

        self.collectionView.isHidden = !self.collectionView.isHidden
        self.controlsView.isHidden = !self.controlsView.isHidden
        
        self.closeView.isHidden = !self.closeView.isHidden
        self.returnView.isHidden = !self.returnView.isHidden
        
        if(!self.collectionView.isHidden) {
            self.titleLabel.text = "Editor"
        }
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

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Manager.sharedInstance.editableSettings.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingCell", for: indexPath) as! SettingCell
        let setting = Manager.sharedInstance.editableSettings[indexPath.row]
        
        cell.label.text = setting.title
        cell.imageView.image = Manager.sharedInstance.getImage(key: setting.key)
        cell.imageView.tintColor = .label
        
        return cell
    }
}

extension EditorView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = Manager.sharedInstance.editableSettings[indexPath.row]
        controlsView.startEdit(setting: setting)
        
        toggleControlsView()
        titleLabel.text = setting.title
    }
}
