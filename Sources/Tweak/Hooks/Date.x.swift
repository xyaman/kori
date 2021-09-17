import TweakC
import Orion

class DateViewHook : ClassHook<SBFLockScreenDateView> {
        
    @Property(.nonatomic) var originalFrame = CGRect()

    func didMoveToWindow() {
        orig.didMoveToWindow()
        Manager.sharedInstance.dateView = target
        
        if let label = target._timeLabel() {
            label.font = UIFont(name: label.font.fontName, size: Manager.sharedInstance.dateFontSize)
        }
    }
    

    func setFrame(_ frame: CGRect) {
        
//        let label = target._timeLabel()
//        label?.font = UIFont.systemFont(ofSize: label?.font.pointSize ?? 20, weight: .bold)
        
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
