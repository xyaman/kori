import TweakC
import UIKit
import Cephei

class Manager {
    
    static let sharedInstance = Manager()
    
    // Preferences
    var preferences = HBPreferences(identifier: "com.xyaman.koripreferences")
    var disableNotificationsHistory: ObjCBool = false
    
    // Notifications
    var notificationsXOffset: CGFloat = 0
    var notificationsYOffset: CGFloat = 0
    var notificationsWidthOffset: CGFloat = 0
    var notificationsHeightOffset: CGFloat = 0
    
    var dateXOffset: CGFloat = 0
    var dateYOffset: CGFloat = 0
    var dateWidthOffset: CGFloat = 0
    var dateHeightOffset: CGFloat = 0
    
    // Editable preferences (not available on tweak prefs)
    var editableSettings: [EditableSetting] = []
    
    // Hooked views
    var presenter: UIViewController?
    var notificationsView: UIView?
    var notificationsListView: UIView?
    var dateView: UIView?
    
    // Edition
    private var editorView: EditorView?
    var isEditing = false

    // Haptic feedback
    var selectionFeedback: UISelectionFeedbackGenerator?
    var impactFeedback: UIImpactFeedbackGenerator?
    
    private init() {
        
        preferences.register(_Bool: &disableNotificationsHistory, default: false, forKey: "disableNotificationsHistory")
        
        // Notifications
        preferences.register(float: &notificationsYOffset, default: 0, forKey: "notificationsYOffset")
        preferences.register(float: &notificationsXOffset, default: 0, forKey: "notificationsXOffset")
        preferences.register(float: &notificationsWidthOffset, default: 0, forKey: "notificationsWidthOffset")
        preferences.register(float: &notificationsHeightOffset, default: 0, forKey: "notificationsHeightOffset")
        
        preferences.register(float: &dateXOffset, default: 0, forKey: "dateXOffset")
        preferences.register(float: &dateYOffset, default: 0, forKey: "dateYOffset")
        preferences.register(float: &dateWidthOffset, default: 0, forKey: "dateWidthOffset")
        preferences.register(float: &dateHeightOffset, default: 0, forKey: "dateHeightOffset")
        
        // Notification editable settings
        editableSettings.append(contentsOf: [
            .notification(key: "notificationsYOffset", title: "Notifications Y Offset", minValue: -300, maxValue: 300),
            .notification(key: "notificationsXOffset", title: "Notifications X Offset", minValue: -300, maxValue: 300),
            .notification(key: "notificationsWidthOffset", title: "Notifications Width Offset", minValue: -300, maxValue: 300),
            .notification(key: "notificationsHeightOffset", title: "Notifications Height Offset", minValue: -300, maxValue: 300)
        ])
        
        // Time editable settings
        editableSettings.append(contentsOf: [
            .date(key: "dateXOffset", title: "Date X Offset", minValue: -300, maxValue: 300),
            .date(key: "dateYOffset", title: "Date Y Offset", minValue: -100, maxValue: 500)
        ]);
    }
    
    func startEditing() {
        
        // Only execute this function if we are not editing
        if(editorView?.superview != nil) { return }
        
        // We need to do this here, because if we do on init, UIScreen crashes
        // Because this class is instantiated on Tweak init()
        selectionFeedback = selectionFeedback ?? UISelectionFeedbackGenerator()
        impactFeedback = impactFeedback ?? UIImpactFeedbackGenerator()
        
        // Check if there is a presenter view
        guard let presenterView = presenter?.view else {
            return
        }
        
        editorView = editorView ?? EditorView()
        
        // Add our view to the presenter
        presenterView.addSubview(editorView!)
        editorView!.translatesAutoresizingMaskIntoConstraints = false
        
        editorView?.topConstraint = editorView?.topAnchor.constraint(equalTo: presenterView.topAnchor, constant: 10)

        // Activate contraints
        NSLayoutConstraint.activate([
            editorView!.topConstraint,
            editorView!.leftAnchor.constraint(equalTo: presenterView.leftAnchor, constant: 10),
            editorView!.rightAnchor.constraint(equalTo: presenterView.rightAnchor, constant: -10),
            editorView!.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    @objc func stopEditing() {
        // Only execute this function if we are editing
        if(editorView?.superview == nil) { return }
        
        if let unwrappedEditorView = editorView {
            unwrappedEditorView.removeFromSuperview()
            editorView = nil
        }
        
    }
    
    func getImage(key: String) -> UIImage? {
        let url = "/Library/PreferenceBundles/KoriPreferences.bundle/Editor/\(key).png"
        return UIImage(contentsOfFile: url)?.withRenderingMode(.alwaysTemplate)
    }
    
    func editSetting(_ wrappedSetting: EditableSetting?, value: CGFloat) {
        
        guard let setting = wrappedSetting else {
            return
        }
        
        preferences.set(value, forKey: setting.key)
        
        isEditing = true
        switch setting.type {
        case .notifications:
            // Reload the notificationView frame (we hooked setFrame)
            notificationsView?.frame = CGRect()
            notificationsListView?.frame = CGRect()
        case .date:
            NSLog("orion date view")
            dateView?.frame = CGRect()
        }
        isEditing = false
    }
}

final class EditableSetting {
    var key: String
    var title: String
    var type: Editabletype
    var minValue: CGFloat
    var maxValue: CGFloat
    
    enum Editabletype {
        case notifications
        case date
    }

    
    init(key: String, title: String, type: Editabletype, minValue: CGFloat, maxValue: CGFloat) {
        self.key = key
        self.title = title
        self.type = type
        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    static func notification(key: String, title: String, minValue:CGFloat, maxValue: CGFloat) -> EditableSetting {
        EditableSetting(key: key, title: title, type: .notifications, minValue: minValue, maxValue: maxValue)
    }
    
    static func date(key: String, title: String, minValue:CGFloat, maxValue: CGFloat) -> EditableSetting {
        EditableSetting(key: key, title: title, type: .date, minValue: minValue, maxValue: maxValue)
    }
}


