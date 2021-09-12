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
        
        NSLog("orion 1")
        
        // Check if there is a presenter view
        guard let presenterView = presenter?.view else {
            isEditing = false
            return
        }
        
        NSLog("orion 2")

        
        // Add our view to the presenter
        presenterView.addSubview(editorView)
        editorView.translatesAutoresizingMaskIntoConstraints = false
        
        editorView.leftAnchor.constraint(equalTo: presenterView.leftAnchor).isActive = true
        editorView.rightAnchor.constraint(equalTo: presenterView.rightAnchor).isActive = true
        editorView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func stopEditing() {
        // Only execute this function if we are editing
        if(!isEditing) { return }
        isEditing = false
 
        editorView.removeFromSuperview()
    }
}
