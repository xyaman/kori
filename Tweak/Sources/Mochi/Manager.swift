import MochiC
import Foundation
import Cephei

class Manager {
    
    // Preferences
    var preferences = HBPreferences(identifier: "com.xyaman.mochipreferences")
    var notificationsYOffset: CGFloat = 0
    var editableKeys = ["notificationsYOffset"]

    
    // Tweak
    private var editorView = EditorView()
    var isEditing = false
    
    // Hook views
    var presenter: UIViewController?
    var notificationsView: CSMainPageView?
    
    static let sharedInstance = Manager()
    
    init() {
        preferences.register(float: &notificationsYOffset, default: 0, forKey: "notificationsYOffset")
//        notificationsYOffset = preferences["notificationsYOffset"] as? CGFloat ?? 0
    }
    
    func loadValues() {
        
    }
    
    func startEditing() {
        
        // Only execute this function if we are not editing
        if(isEditing) { return }
        isEditing = true
        
        // Check if there is a presenter view
        guard let presenterView = presenter?.view else {
            isEditing = false
            return
        }
        
        // Add our view to the presenter
        presenterView.addSubview(editorView)
        editorView.translatesAutoresizingMaskIntoConstraints = false
        editorView.topConstraint = editorView.topAnchor.constraint(equalTo: presenterView.topAnchor, constant: 10)
        
        // Activate contraints
        NSLayoutConstraint.activate([
            editorView.topConstraint,
            editorView.leftAnchor.constraint(equalTo: presenterView.leftAnchor, constant: 10),
            editorView.rightAnchor.constraint(equalTo: presenterView.rightAnchor, constant: -10),
            editorView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func stopEditing() {
        // Only execute this function if we are editing
        if(!isEditing) { return }
        isEditing = false
 
        editorView.removeFromSuperview()
    }
}
