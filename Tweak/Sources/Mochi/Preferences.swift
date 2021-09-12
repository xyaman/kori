import UIKit
import Cephei

class Preferences {
    private let preferences = HBPreferences(identifier: "com.xyaman.mochipreferences")
    
    private(set) var notificationsYOffset: CGFloat = 0
    
    init() {
        
        preferences.register(float: &notificationsYOffset, default: 0, forKey: "notificationsYOffset")
    }
}
