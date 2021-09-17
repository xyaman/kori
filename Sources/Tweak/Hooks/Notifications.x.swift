import TweakC
import Orion
import UIKit

// Notifications Scroll view hook (Works for X, Y && width offset)
class NotificationsHook : ClassHook<UIView> {

    static let targetName: String = "CSCoverSheetViewBase"

    @Property(.nonatomic) var originalFrame = CGRect()

    func didMoveToWindow() {
        orig.didMoveToWindow()
        let ancestor: UIViewController = target._viewControllerForAncestor()!
        if(ancestor.isKind(of: CSCombinedListViewController.self)) {
            Manager.sharedInstance.notificationsView = target
        }
    }

    func setFrame(_ frame: CGRect) {

        // We only want to update one CSCoverSheetViewBase
        let ancestor: UIViewController? = target._viewControllerForAncestor()

        if(ancestor != nil && ancestor!.isKind(of: CSCombinedListViewController.self)) {

            var newFrame = originalFrame
            if(!Manager.sharedInstance.isEditing) {
                originalFrame = frame
                newFrame = frame
            }

            newFrame.origin.y += Manager.sharedInstance.notificationsYOffset
            newFrame.origin.x += Manager.sharedInstance.notificationsXOffset
            newFrame.size.width += Manager.sharedInstance.notificationsWidthOffset
            orig.setFrame(newFrame)

        } else {
            orig.setFrame(frame)
        }
    }
}

// Notifications Scroll view hook
// (Works only for height offset, basically because media player dont subview this class)
class NotificationList : ClassHook<NCNotificationListView> {
    
    @Property(.nonatomic) var originalFrame = CGRect()
    @Property(.nonatomic) var isTargetView = false
    @Property(.nonatomic) var gradientLayer: CAGradientLayer? = nil
    
    func didMoveToWindow() {
        orig.didMoveToWindow()
        let gradient = Gradient.init(rawValue: Manager.sharedInstance.notifsGradient)
        
        // TODO
        if(gradientLayer != nil || !isTargetView || gradient == Gradient.none) {return}
        
        if let superview = target.superview {
            
            gradientLayer = CAGradientLayer()
            gradientLayer?.frame = superview.bounds
            
            switch gradient {
            case .top:
                gradientLayer?.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
                gradientLayer?.locations = [0, 0.1]
            case .bottom:
                gradientLayer?.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
                gradientLayer?.locations = [0.9, 1]
            default:
                break
            }
            
            superview.layer.mask = gradientLayer
        }
        
    }
    
    // Temporal solution
    func layoutSubviews() {
        orig.layoutSubviews()
        
        if let superview = target.superview {
            gradientLayer?.frame = superview.bounds
        }
        
    }
    
    func didMoveToSuperview() {
        orig.didMoveToSuperview()
        isTargetView = false
        
        let notificationListViewClass = objc_getClass("NCNotificationListView") as! NCNotificationListView.Type
        guard let superview = target.superview else {
            return
        }
        
        if(!superview.isKind(of: notificationListViewClass.self)) {
            isTargetView = true
            Manager.sharedInstance.notificationsListView = target
        }
        
    }
    
    func setFrame(_ frame: CGRect) {
        
        // We only want to update one CSCoverSheetViewBase
        if(isTargetView) {
            var newFrame = originalFrame
            if(!Manager.sharedInstance.isEditing) {
                originalFrame = frame
                newFrame = frame
            }

            // Only clips to bounds if user change height
            target.clipsToBounds = Manager.sharedInstance.notificationsHeightOffset != 0
            newFrame.size.height += Manager.sharedInstance.notificationsHeightOffset
                        
//            orig.setFrame(newFrame)
            gradientLayer?.frame = target.bounds
        
        } else {
            orig.setFrame(frame)
        }
    }
}
