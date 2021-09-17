import CepheiPrefs
import Foundation

class RootListController: HBRootListController {
    override var specifiers: NSMutableArray? {
        get {
            if let specifiers = value(forKey: "_specifiers") as? NSMutableArray {
                return specifiers
            } else {
                let specifiers = loadSpecifiers(fromPlistName: "Root", target: self)
                setValue(specifiers, forKey: "_specifiers")
                return specifiers
            }
        }
        set {
            super.specifiers = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Change appearance
        let appearanceSettings = HBAppearanceSettings()
        
        // Change tint cplor
        appearanceSettings.tintColor = UIColor(red:(214.0/255.0), green:(54.0/255.0), blue:(54.0/255.0), alpha: 1)
        
        // Hide separators
        appearanceSettings.tableViewCellSeparatorColor = UIColor(white: 0, alpha: 0)
        self.appearanceSettings = appearanceSettings
    }
    
    @objc func startEdit(_ sender: Any?) {
        NSLog("orion edit")
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName("com.xyaman.koripreferences/StartEditing" as CFString), nil, nil, true)
    }
}
