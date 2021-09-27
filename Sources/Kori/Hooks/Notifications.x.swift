import TweakC
import Orion
import UIKit

// Notifications Scroll view hook
class NotificationsHook : ClassHook<UIView> {

    static let targetName: String = "CSCoverSheetViewBase"

    @Property(.nonatomic) var originalFrame = CGRect()

    func didMoveToWindow() {
        orig.didMoveToWindow()
        let ancestor: UIViewController = target._viewControllerForAncestor()!
        if(ancestor.isKind(of: CSCombinedListViewController.self)) {
            Manager.shared.notificationsView = target
        }
    }

    func setFrame(_ frame: CGRect) {

        // We only want to update one CSCoverSheetViewBase
        let ancestor: UIViewController? = target._viewControllerForAncestor()

        if(ancestor != nil && ancestor!.isKind(of: CSCombinedListViewController.self)) {

            var newFrame = originalFrame
            if(!Manager.shared.isEditing) {
                originalFrame = frame
                newFrame = frame
            }

            newFrame.origin.y += Manager.shared.notificationsYOffset
            newFrame.origin.x += Manager.shared.notificationsXOffset
            newFrame.size.width += Manager.shared.notificationsWidthOffset
            
            target.clipsToBounds = Manager.shared.notificationsHeightOffset != 0
            newFrame.size.height += Manager.shared.notificationsHeightOffset
           
            orig.setFrame(newFrame)
            
            // Only if we modify the height we should update layer frame
            if(Manager.shared.notificationsHeightOffset != 0) {
                NotificationCenter.default.post(name: .updateGradientFrame, object: nil)
            }

        } else {
            orig.setFrame(frame)
        }
    }
}

// We just add gradient here
class NotificationStructuredListHook : ClassHook<NCNotificationStructuredListViewController> {

    @Property(.nonatomic) var gradientLayer: CAGradientLayer? = nil
    
    func viewDidLoad() {
        orig.viewDidLoad()
        
        let gradient = Gradient.init(rawValue: Manager.shared.notifsGradient)
        if(gradient == Gradient.none) {return}
        
        // Add observer
        NotificationCenter.default.addObserver(self, selector: #selector(updateGradientFrame), name: .updateGradientFrame, object: nil)
        updateGradientFrame()
    }
    
    func viewWillLayoutSubviews() {
        orig.viewWillLayoutSubviews()
        updateGradientFrame()
    }
    
    // orion:new
    @objc func updateGradientFrame() {
        
        let width = target.view.bounds.width + Manager.shared.notificationsWidthOffset
        let height = target.view.bounds.height + Manager.shared.notificationsHeightOffset
        let frame = CGRect(origin: target.view.bounds.origin, size: CGSize(width: width, height: height))
        
        if(gradientLayer == nil) {
            
            gradientLayer = CAGradientLayer()
            gradientLayer?.frame = frame
            let gradient = Gradient.init(rawValue: Manager.shared.notifsGradient)
            
            switch gradient {
                case .top:
                    gradientLayer?.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
                    gradientLayer?.locations = [0, 0.1]

                case .bottom:
                    gradientLayer?.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
                    gradientLayer?.locations = [0.9, 1]
                // This should never happen
                default:
                    break
            }
            
            target.view.layer.mask = gradientLayer
        }
        
        // Always update frame at the end
        gradientLayer?.frame = frame
    }
}
