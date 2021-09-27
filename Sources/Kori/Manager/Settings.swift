import Foundation

final class EditableSetting {
    var key: String
    var title: String
    var type: EditableType
    var minValue: CGFloat
    var maxValue: CGFloat
    
    enum EditableType {
        case notifications
        case date
    }

    
    init(key: String, title: String, type: EditableType, minValue: CGFloat, maxValue: CGFloat) {
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
