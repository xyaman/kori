import Foundation
import CoreGraphics


class Preferences {

    var identifier: String = ""
    var yOffset: CGFloat = 0

    init(identifier: String) {
        var propertyListFormat =  PropertyListSerialization.PropertyListFormat.xml //Format of the Property List.
        var plistData: [String: Any] = [:] //Our data
        let plistXML1 = FileManager.default.contents(atPath: identifier)

        guard let plistXML = plistXML1 else {
            NSLog("orion cant read xml")
            return
        } 

        do {//convert the data to a dictionary and handle errors.
            plistData = try PropertyListSerialization.propertyList(from: plistXML, options: .mutableContainersAndLeaves, format: &propertyListFormat) as! [String:AnyObject]

            if let yOffset = plistData["yOffset"] {
                self.yOffset = (yOffset as? CGFloat ?? 0) ?? 0
            }
        } catch {
            NSLog("orion Error reading plist: \(error), format: \(propertyListFormat)")
        }
    }
}