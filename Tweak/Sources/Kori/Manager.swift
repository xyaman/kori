import KoriC
import Foundation
import Cephei

class Manager {
    
    // Preferences
    var preferences = HBPreferences(identifier: "com.xyaman.koripreferences")
    var notificationsYOffset: CGFloat = 0
    var notificationsXOffset: CGFloat = 0
    var notificationsWidthOffset: CGFloat = 0
    var notificationsHeightOffset: CGFloat = 0
    var editableSettings: [EditableSetting] = []

    
    // Tweak
    private var editorView = EditorView()
    var isEditing = false
    
    // Hook views
    var presenter: UIViewController?
    var notificationsView: UIView?
    
    static let sharedInstance = Manager()
    
    init() {
        preferences.register(float: &notificationsYOffset, default: 0, forKey: "notificationsYOffset")
        preferences.register(float: &notificationsXOffset, default: 0, forKey: "notificationsXOffset")
        preferences.register(float: &notificationsWidthOffset, default: 0, forKey: "notificationsWidthOffset")
        preferences.register(float: &notificationsHeightOffset, default: 0, forKey: "notificationsHeightOffset")


        
        // Notification editable settings
        editableSettings.append(contentsOf: [
            EditableSetting(key: "notificationsYOffset", title: "Notifications Y Offset", type: .notifications, minValue: -300, maxValue: 300),
            EditableSetting(key: "notificationsXOffset", title: "Notifications X Offset", type: .notifications, minValue: -300, maxValue: 300),
            EditableSetting(key: "notificationsWidthOffset", title: "Notifications Width Offset", type: .notifications, minValue: -300, maxValue: 300),
            EditableSetting(key: "notificationsHeightOffset", title: "Notifications Height Offset", type: .notifications, minValue: -300, maxValue: 300)
        ])
        
        // Time editable settings
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
        
        editorView.prepare()
    }
    
    func stopEditing() {
        // Only execute this function if we are editing
        if(!isEditing) { return }
        isEditing = false
 
        editorView.removeFromSuperview()
    }
    
    func editValue(setting: EditableSetting) {
        
        switch setting.type {
        case .notifications:
            // Reload the notificationView frame (we hooked setFrame)
            notificationsView?.frame = CGRect()
        }
    }
}

struct EditableSetting {
    var key: String
    var title: String
    var type: Editabletype
    var minValue: CGFloat
    var maxValue: CGFloat
    var iconName: String?
}

enum Editabletype {
    case notifications
}
