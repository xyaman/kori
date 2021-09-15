import KoriC
import Orion
import UIKit


// CoverSheet hook to get the instance
class CoverSheetController : ClassHook<CSCoverSheetViewController> {
    
    func viewDidLoad() {
        orig.viewDidLoad()
        Manager.sharedInstance.presenter = target
    }
    
    func viewDidDisappear(_ animated: Bool) {
        orig.viewDidDisappear(animated)
        
        Manager.sharedInstance.stopEditing()
    }
}

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
            
            var newFrame = frame
            if(!Manager.sharedInstance.isEditing) {
                originalFrame = frame
                newFrame = frame
            } else {
                newFrame = originalFrame
            }

            newFrame.origin.y += Manager.sharedInstance.notificationsYOffset
            newFrame.origin.x += Manager.sharedInstance.notificationsXOffset
            newFrame.size.width += Manager.sharedInstance.notificationsWidthOffset
            newFrame.size.height += Manager.sharedInstance.notificationsHeightOffset
            orig.setFrame(newFrame)
        
        } else {
            orig.setFrame(frame)
        }
    }
}


struct Kori : Tweak {
    init() {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
            nil,
            {center, observer, name, object, userInfo in
                Manager.sharedInstance.startEditing()
                let cover = objc_getClass("SBCoverSheetPresentationManager") as! SBCoverSheetPresentationManager.Type
                cover.sharedInstance().setCoverSheetPresented(true, animated: true, withCompletion: nil)
            },
            "com.xyaman.koripreferences/StartEditing" as CFString,
            nil,
            .coalesce
        )
    }
}
