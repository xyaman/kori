import MochiC
import Orion
import UIKit


// CoverSheet hook to get the instance
class CoverSheetController : ClassHook<CSCoverSheetViewController> {
    
    func viewDidLoad() {
        orig.viewDidLoad()
        Manager.sharedInstance.presenter = target
    }
}

// Notifications Scroll view hook
class NotificationsHook : ClassHook<CSMainPageView> {

    @Property(.nonatomic) var originalFrame = CGRect()
    
    func didMoveToWindow() {
        orig.didMoveToWindow()
        
        Manager.sharedInstance.notificationsView = target
    }

    func setFrame(_ frame: CGRect) {
        var newFrame = frame;
        if(!Manager.sharedInstance.isEditing) {
            originalFrame = frame
            newFrame = frame
            NSLog("orion original frame: %@", String(describing: originalFrame))
        } else {
            newFrame = originalFrame
        }
        NSLog("orion edited first: %@", String(describing: newFrame))

        newFrame.origin.y += Manager.sharedInstance.notificationsYOffset
//        newFrame.size.height -= Manager.sharedInstance.notificationsYOffset
//        newFrame.size.width -= 100
        NSLog("orion edited frame: %@", String(describing: newFrame))
        orig.setFrame(newFrame)
    }
}

struct Mochi : Tweak {
    init() {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
            nil,
            {center, observer, name, object, userInfo in
                Manager.sharedInstance.startEditing()
            },
            "com.xyaman.mochipreferences/StartEditing" as CFString,
            nil,
            .coalesce
        )
    }
}
