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
        
        if(Manager.sharedInstance.useDateStaticFrame.boolValue) {
            let origin = CGPoint(x: Manager.sharedInstance.dateXStatic, y: Manager.sharedInstance.dateYStatic)
            originalFrame = CGRect(origin: origin, size: frame.size)
        }
        
        var newFrame = originalFrame
        
        // We only want to update one CSCoverSheetViewBase
        if(!Manager.sharedInstance.isEditing) {
            originalFrame = newFrame
            newFrame = Manager.sharedInstance.useDateStaticFrame.boolValue ? newFrame : frame
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
    
    func setContentAlpha(_ arg0: CGFloat, withSubtitleVisible arg1: Bool) {
        if(Manager.sharedInstance.useDateStaticFrame.boolValue) {
            orig.setContentAlpha(1, withSubtitleVisible: arg1)
        
        } else {
            orig.setContentAlpha(arg0, withSubtitleVisible: arg1)
        }
    }
}
