import TweakC
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
