import MochiC
import Orion
import UIKit


var preferences = Preferences()

// CoverSheet hook to get the instance
class CoverSheetController : ClassHook<CSCoverSheetViewController> {
    
    func `init`() {
        orig.`init`()
        Manager.sharedInstance.presenter = target
    }
}

// Notifications Scroll view hook
class NotificationsHook : ClassHook<CSMainPageView> {

    func setFrame(_ frame: CGRect) {
        // orig.setFrame(frame)
        var newFrame = frame

        // target.frame = CGRect(origin: CGPoint(x: frame.origin.x, y: frame.origin.y + 300), size: frame.size)
        newFrame.origin.y += preferences.notificationsYOffset
        newFrame.size.height -= preferences.notificationsYOffset
        newFrame.size.width -= 100
        orig.setFrame(newFrame)
    }
}

