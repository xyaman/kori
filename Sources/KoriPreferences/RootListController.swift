import CepheiPrefs
import Cephei
import UIKit

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
        appearanceSettings.tintColor = UIColor(red:(68.0/255.0), green:(151.0/255.0), blue:(221.0/255.0), alpha: 1)
        
        // Hide separators
        appearanceSettings.tableViewCellSeparatorColor = UIColor(white: 0, alpha: 0)
        self.appearanceSettings = appearanceSettings
        
        // Add respring button at right
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Respring", style: .done, target: self, action: #selector(respring(_:)))
    }
    
    override func tableViewStyle() -> UITableView.Style {
        return .insetGrouped
    }
    
    @objc func startEdit(_ sender: Any?) {
        CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFNotificationName("com.xyaman.koripreferences/StartEditing" as CFString), nil, nil, true)
    }
    
    @objc func respring(_ sender: Any?) {
        if(FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/DynamicLibraries/shuffle.dylib")) {
            HBRespringController.respringAndReturn(to: URL(string: "prefs:root=Tweaks&path=Kori"))
        } else {
            HBRespringController.respringAndReturn(to: URL(string: "prefs:root=Kori"))
        }
    }
}
