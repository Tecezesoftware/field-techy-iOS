//
//  AppTheme.swift
//  FieldTechy
//
//  Created by Kowsalya on 06/08/26.
//

import UIKit

enum AppFonts {
    static func Bold(size: CGFloat) -> UIFont {
        guard let PoppinsBold = UIFont(name: "Poppins-Bold", size: size) else { return UIFont.systemFont(ofSize: size) }
        return PoppinsBold
    }
    
    static func Italic(size: CGFloat) -> UIFont {
        guard let PoppinsItalic = UIFont(name: "Poppins-Italic", size: size) else { return UIFont.systemFont(ofSize: size) }
        return PoppinsItalic
    }
    
    static func Light(size: CGFloat) -> UIFont {
        guard let PoppinsLight = UIFont(name: "Poppins-Light", size: size) else { return UIFont.systemFont(ofSize: size) }
        return PoppinsLight
    }
    
    static func Medium(size: CGFloat) -> UIFont {
        guard let PoppinsMedium = UIFont(name: "Poppins-Medium", size: size) else { return UIFont.systemFont(ofSize: size) }
        return PoppinsMedium
    }
    
    static func Regular(size: CGFloat) -> UIFont {
        guard let PoppinsRegular = UIFont(name: "Poppins-Regular", size: size) else { return UIFont.systemFont(ofSize: size) }
        return PoppinsRegular
    }
    
    static func SemiBold(size: CGFloat) -> UIFont {
        guard let PoppinsSemiBold = UIFont(name: "Poppins-SemiBold", size: size) else { return UIFont.systemFont(ofSize: size) }
        return PoppinsSemiBold
    }
}

enum AppTheme{
    static let primaryButtonBGColor = UIColor(hex: "#009966")
    static let primaryButtonLabelColor = UIColor(hex: "#FFFFFF")
    static let primaryTextColor = UIColor(hex: "#101828")
    static let secondaryTextColor = UIColor(hex: "#717182")
    static let secondaryBGColor = UIColor(hex: "#FFFFFF")
    static let borderColorOfViews = UIColor(hex: "#E5E7EB")
    static let fieldBGColor = UIColor(hex: "#F9FAFB")
    static let secondaryButtonBGColor = UIColor(hex: "#F2F2F2")
    static let closeBtnBG = UIColor(hex: "#EAEFF3")
    static let brandPrimaryTint = UIColor(hex: "#CDF0E4")
    static let primaryBrand100 = UIColor(hex: "#CDF0E4")
    static let neutralDark800 = UIColor(hex: "#26272C")
    static let neutralLight500 = UIColor(hex:"D0D0D0")
    static let neutralLight100 = UIColor(hex: "DCDCDC")
    static let neutralLight200 = UIColor(hex: "#DDDDDD")
    static let neutralLight800 = UIColor(hex: "#8B8B8B")
    static let error100 = UIColor(hex: "#EC8686")
    static let error800 = UIColor(hex: "#DA2316")
}

// MARK: - UIColor + Hex
extension UIColor {

    // MARK: Hex to UIColor
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let formatted = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)

        guard formatted.count == 6 else {
            self.init(red: 0, green: 0, blue: 0, alpha: alpha)
            return
        }

        var rgb: UInt64 = 0
        Scanner(string: formatted).scanHexInt64(&rgb)

        self.init(
            red:   CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat( rgb & 0x0000FF)         / 255.0,
            alpha: alpha
        )
    }

    // MARK: UIColor to Hex String
    func toHex(includeAlpha: Bool = false) -> String? {
        guard let components = cgColor.components,
              components.count >= 3 else { return nil }

        let red   = Float(components[0])
        let green = Float(components[1])
        let blue  = Float(components[2])
        let alpha = components.count >= 4 ? Float(components[3]) : Float(1.0)

        if includeAlpha {
            return String(
                format: "#%02lX%02lX%02lX%02lX",
                lroundf(red   * 255),
                lroundf(green * 255),
                lroundf(blue  * 255),
                lroundf(alpha * 255)
            )
        } else {
            return String(
                format: "#%02lX%02lX%02lX",
                lroundf(red   * 255),
                lroundf(green * 255),
                lroundf(blue  * 255)
            )
        }
    }
}
