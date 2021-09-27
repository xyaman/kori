import CepheiPrefs
import Cephei
import Prefs

class SubListController: HBListController {
        
    override var specifiers: NSMutableArray? {
        get {
            if let specifiers = value(forKey: "_specifiers") as? NSMutableArray {
                return specifiers
            } else {
                let sub = specifier.property(forKey: "KRISub") as! String
                let specifiers = loadSpecifiers(fromPlistName: sub, target: self)
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
    }
    
    override func tableViewStyle() -> UITableView.Style {
        return .insetGrouped
    }
}
