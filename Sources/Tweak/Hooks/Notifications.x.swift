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
            
            target.clipsToBounds = Manager.sharedInstance.notificationsHeightOffset != 0
            newFrame.size.height += Manager.sharedInstance.notificationsHeightOffset
           
            orig.setFrame(newFrame)

        } else {
            orig.setFrame(frame)
        }
    }
}

// We just add gradient here
class NotificationStructuredListHook : ClassHook<NCNotificationStructuredListViewController> {

    @Property(.nonatomic) var gradientLayer = CAGradientLayer()
    
    func viewDidLoad() {
        orig.viewDidLoad()
        
        let gradient = Gradient.init(rawValue: Manager.sharedInstance.notifsGradient)
        let width = target.view.bounds.width + Manager.sharedInstance.notificationsWidthOffset
        let height = target.view.bounds.height + Manager.sharedInstance.notificationsHeightOffset
        let frame = CGRect(origin: target.view.bounds.origin, size: CGSize(width: width, height: height))
        
        switch gradient {
            case .top:
                gradientLayer.frame = frame
                gradientLayer.colors = [UIColor.clear.cgColor, UIColor.white.cgColor]
                gradientLayer.locations = [0, 0.1]
                target.view.layer.mask = gradientLayer

            case .bottom:
                gradientLayer.frame = frame
                gradientLayer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor]
                gradientLayer.locations = [0.9, 1]
                target.view.layer.mask = gradientLayer
            default:
                break
            }
    }
    
    func viewWillLayoutSubviews() {
        orig.viewWillLayoutSubviews()
       
        let width = target.view.bounds.width + Manager.sharedInstance.notificationsWidthOffset
        let height = target.view.bounds.height + Manager.sharedInstance.notificationsHeightOffset
        let frame = CGRect(origin: target.view.bounds.origin, size: CGSize(width: width, height: height))
        gradientLayer.frame = frame
    }
}
