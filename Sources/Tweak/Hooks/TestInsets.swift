import TweakC
import Orion

class NotificationStructuredListHook : ClassHook<CSCombinedListViewController> {
    
    func viewWillAppear(_ animated: Bool) {
        orig.viewWillAppear(animated)
        
        target.layoutListView()
    }
    
    func _listViewDefaultContentInsets() -> UIEdgeInsets {
        var insets = orig._listViewDefaultContentInsets()
        NSLog("orion here")
        insets.top -= 90
        return insets
    }
}
