import TweakC
import Orion

class DateViewHook : ClassHook<SBFLockScreenDateView> {
    
//    static let targetName: String = "SBFLockScreenDateView"
    
    @Property(.nonatomic) var originalFrame = CGRect()

    func didMoveToWindow() {
        orig.didMoveToWindow()
        Manager.sharedInstance.dateView = target
    }

    func setFrame(_ frame: CGRect) {
        
        // We only want to update one CSCoverSheetViewBase
        var newFrame = originalFrame
        if(!Manager.sharedInstance.isEditing) {
            originalFrame = frame
            newFrame = frame
        }
                
        newFrame.origin.y += Manager.sharedInstance.dateYOffset
        newFrame.origin.x += Manager.sharedInstance.dateXOffset
//        newFrame.size.width += Manager.sharedInstance.dateWidthOffset
//        newFrame.size.height += Manager.sharedInstance.dateHeightOffset
        orig.setFrame(newFrame)
    }
}

class DateControllerHook : ClassHook<UIViewController> {
    
    static let targetName: String = "SBFLockScreenDateViewController"
    
    
}
