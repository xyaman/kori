import TweakC
import Orion
import UIKit


// Used on NotificationsHistory.x.swift
struct DisableNotificationsHistory : HookGroup {}

// CoverSheet hook to get the instance
class CoverSheetController : ClassHook<CSCoverSheetViewController> {
    
    func viewDidLoad() {
        orig.viewDidLoad()
        Manager.shared.presenter = target
    }
    
    func viewDidDisappear(_ animated: Bool) {
        orig.viewDidDisappear(animated)
        
        Manager.shared.stopEditing()
    }
}

let startEditCallback: CFNotificationCallback = {center, observer, name, object, userInfo in
    Manager.shared.startEditing()
    let cover = objc_getClass("SBCoverSheetPresentationManager") as! SBCoverSheetPresentationManager.Type
    cover.sharedInstance().setCoverSheetPresented(true, animated: true, withCompletion: nil)
}

struct Kori : Tweak {
    init() {
        // Start edit notification
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), nil, startEditCallback, "com.xyaman.koripreferences/StartEditing" as CFString, nil, .coalesce)
    
        // Enable groups
        if(Manager.shared.disableNotificationsHistory.boolValue) {
            DisableNotificationsHistory().activate()
        }
    }
}
