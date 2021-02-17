import Foundation
import UIKit

struct Tea: Codable {
    let name: String
    let brewTimeInSeconds: Int
    let backgroundColor: Color

    init(name: String, brewTimeInMinutes: Int, backgroundColor: Color) {
        self.name = name
        self.brewTimeInSeconds = brewTimeInMinutes * 60
        self.backgroundColor = backgroundColor
    }
}

struct Color : Codable {
    var red : CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0, alpha: CGFloat = 0.0

    var uiColor : UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }

    init(uiColor : UIColor) {
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
    }
}
