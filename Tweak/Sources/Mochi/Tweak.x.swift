import MochiC
import Orion
import UIKit

// let updatePrefs = {center, observer, name, object, userInfo in
//     print("orion prefs updated")
//     preferences = Preferences(identifier: "/var/mobile/Library/Preferences/com.xyaman.mochipreferences.plist")
// }


var preferences = Preferences(identifier: "/var/mobile/Library/Preferences/com.xyaman.mochipreferences.plist")

class CSScrollViewHook : ClassHook<UIView> {

    static let targetName = "CSMainPageView"

    func setFrame(_ frame: CGRect) {
        // orig.setFrame(frame)
        var newFrame = frame

        // target.frame = CGRect(origin: CGPoint(x: frame.origin.x, y: frame.origin.y + 300), size: frame.size)
        newFrame.origin.y += CGFloat(preferences.yOffset)
        newFrame.size.height -= CGFloat(preferences.yOffset)
        newFrame.size.width -= 100
        orig.setFrame(newFrame)
    }
}

struct Mochi: Tweak {
    init() {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
         nil, 
         {center, observer, name, object, userInfo in
            NSLog("orion prefs updated")
            preferences = Preferences(identifier: "/var/mobile/Library/Preferences/com.xyaman.mochipreferences.plist")
        },
        "com.xyaman.mochipreferences/ReloadPrefs" as CFString, nil, .coalesce)
    }
}