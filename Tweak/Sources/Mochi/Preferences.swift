import Foundation

struct Prefs: Codable {
    var scrollYOffset: Double = 0
}

func loadPrefs(identifier: String) -> Prefs? {
    guard let plistFile = FileManager.default.contents(atPath: identifier) else {
        NSLog("[Mochi] Preferences config not found")
        return nil
    }
    
    let decoder = PropertyListDecoder()
    return try? decoder.decode(Prefs.self, from: plistFile)
}

class Preferences {

    var identifier: String = ""
    var yOffset: Double = 0

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
                self.yOffset = (yOffset as? Double ?? 0)
            }
        } catch {
            NSLog("orion Error reading plist: \(error), format: \(propertyListFormat)")
        }
    }
}
