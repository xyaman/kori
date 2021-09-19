import TweakC
import Orion

class DateViewHook : ClassHook<SBFLockScreenDateView> {
        
    @Property(.nonatomic) var originalFrame = CGRect()

    func didMoveToWindow() {
        orig.didMoveToWindow()
        Manager.shared.dateView = target
        
        if let label = target._timeLabel() {
            label.font = UIFont(name: label.font.fontName, size: Manager.shared.dateFontSize)
        }
    }
    

    func setFrame(_ frame: CGRect) {
        
//        let label = target._timeLabel()
//        label?.font = UIFont.systemFont(ofSize: label?.font.pointSize ?? 20, weight: .bold)
        
        if(Manager.shared.useDateStaticFrame.boolValue) {
            let origin = CGPoint(x: Manager.shared.dateXStatic, y: Manager.shared.dateYStatic)
            originalFrame = CGRect(origin: origin, size: frame.size)
        }
        
        var newFrame = originalFrame
        
        // We only want to update one CSCoverSheetViewBase
        if(!Manager.shared.isEditing) {
            originalFrame = newFrame
            newFrame = Manager.shared.useDateStaticFrame.boolValue ? newFrame : frame
        }
                
        newFrame.origin.y += Manager.shared.dateYOffset
        newFrame.origin.x += Manager.shared.dateXOffset

        orig.setFrame(newFrame)
    }
}

class DateControllerHook : ClassHook<UIViewController> {
    
    static let targetName: String = "SBFLockScreenDateViewController"
    
    func setContentAlpha(_ arg0: CGFloat, withSubtitleVisible arg1: Bool) {
        if(Manager.shared.useDateStaticFrame.boolValue) {
            orig.setContentAlpha(1, withSubtitleVisible: arg1)
        
        } else {
            orig.setContentAlpha(arg0, withSubtitleVisible: arg1)
        }
    }
}
