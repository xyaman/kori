import MochiC
import Foundation

class Manager {
    
    // Tweak
    private var editorView = EditorView()
    private var isEditing = false
    
    // Hook views
    var presenter: UIViewController?
    var notificationsView: CSMainPageView?
    
    static let sharedInstance = Manager()
    
    init() {}
    
    func startEditing() {
        
        // Only execute this function if we are not editing
        if(isEditing) { return }
        isEditing = true
        
        // Check if there is a presenter view
        guard let presenterView = presenter?.view {
            isEditing = false
            return
        }
        
        // Add our view to the presenter
        presenterView.addSubview(editorView)
    }
    
    func stopEditing() {
        // Only execute this function if we are editing
        if(!isEditing) { return }
        isEditing = false
 
        editorView.removeFromSuperview()
    }
}
