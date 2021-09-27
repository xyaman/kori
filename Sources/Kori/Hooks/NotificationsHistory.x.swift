import TweakC
import Orion

class NotificationItemViewHook: ClassHook<NCNotificationListView> {
    
    typealias Group = DisableNotificationsHistory
    
    func setRevealed(_ arg1: Bool) {
        orig.setRevealed(true)
    }
}

class OlderNotificationsHook: ClassHook<NCNotificationListSectionRevealHintView> {
    
    typealias Group = DisableNotificationsHistory
    
    func didMoveToWindow() {
        target.isHidden = true
    }
    
    func setFrame(_ frame: CGRect) {
        orig.setFrame(CGRect())
    }
}

class OlderNotificationsControlsHook: ClassHook<NCNotificationListSectionHeaderView> {
    
    typealias Group = DisableNotificationsHistory
    
    func didMoveToWindow() {
        target.isHidden = true
    }
    
    func setFrame(_ frame: CGRect) {
        orig.setFrame(CGRect())
    }
}

class NotificationGroupLabelHook: ClassHook<NCNotificationListCoalescingControlsCell> {
   
    typealias Group = DisableNotificationsHistory
    
    func didMoveToWindow() {
        target.isHidden = true
    }
    
    func setFrame(_ frame: CGRect) {
        orig.setFrame(CGRect())
    }
}

class NotificationGroupControlsHook: ClassHook<NCNotificationListCoalescingHeaderCell> {
   
    typealias Group = DisableNotificationsHistory
    
    func didMoveToWindow() {
        target.isHidden = true
    }
    
    func setFrame(_ frame: CGRect) {
        orig.setFrame(CGRect())
    }
}
