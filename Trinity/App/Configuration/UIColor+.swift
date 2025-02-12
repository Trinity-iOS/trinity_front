//
//  Color+.swift
//  Trinity
//
//  Created by Park Seyoung on 12/13/24.
//

import UIKit

extension UIColor {
    convenience init(hex: Int, alpha: Double = 1.0) {
        let red = Double((hex >> 16) & 0xff) / 255
        let green = Double((hex >> 8) & 0xff) / 255
        let blue = Double((hex >> 0) & 0xff) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    convenience init(hex: String, alpha: Double = 1.0) {
        let scanner = Scanner(string: hex)
        _ = scanner.scanString("#")
        
        var rgb: UInt64 = 0
        scanner.scanHexInt64(&rgb)
        
        let r = Double((rgb >> 16) & 0xFF) / 255.0
        let g = Double((rgb >>  8) & 0xFF) / 255.0
        let b = Double((rgb >>  0) & 0xFF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
    
    //MARK: - Main Color
    static let IFBlackPrimary = UIColor(hex: "#191919")
    static let IFBlackSecondary = UIColor(hex: "#232323")
    
    //MARK: - Sub Color
    static let IFIvory = UIColor(hex: "#F9F7F2")
    static let IFIvory2 = UIColor(hex: "#F3F0E6")
    
    //MARK: - Highlight Color
    static let IFHighlight = UIColor(hex: "#FF5050")
    
    //MARK: - Text Color
    static let IFTextInfo = UIColor(hex: "#bdbdbd")
    static let IFTextSub = UIColor(hex: "#F3F0E6")
    static let IFTextDef = UIColor(hex: "#F9F7F2")
    static let IFTextDis = UIColor(hex: "#999999")
    
    //MARK: - Border Color
    static let IFBorderDef = UIColor(hex: "#999999")
    static let IFBorderAct = UIColor(hex: "#444444")
    static let IFBorderTab = UIColor(hex: "#F3F0E6")
    
    //MARK: - Background Color
    static let IFBgDef = UIColor(hex: "#191919")
    static let IFBgSecondary = UIColor(hex: "#F9F7F2")
    
    //MARK: - Icon Color
    static let IFIconDis = UIColor(hex: "#999999")
    static let IFIconDef = UIColor(hex: "#F3F0E6")
    
    //MARK: - Error Color
    static let IFErrorText = UIColor(hex: "#9E5050")
    static let IFErrorBorder = UIColor(hex: "#B35F5F")
}

