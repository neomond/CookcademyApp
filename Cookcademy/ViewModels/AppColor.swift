//
//  AppColor.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 08.09.24.
//

import SwiftUI

struct AppColor {
  static let background: Color = Color(.sRGB,
                                       red: 228/255,
                                       green: 235/255,
                                       blue: 250/255,
                                       opacity: 1)
  static let foreground: Color = Color(.sRGB,
                                       red: 118/255,
                                       green: 119/255,
                                       blue: 231/255,
                                       opacity: 1)
}

/// Importing SwiftUI allows the Color structure to be referenced.
/// Next, there is a new structure AppColor. Within AppColor, a foreground and a background property were created and assigned to a Color instance. Remember, since they are static, reference them as AppColor.background and AppColor.foreground.
///
///
///
/// public protocol RawRepresentable {
///associatedtype RawValue
///init?(rawValue: Self.RawValue)
///var rawValue: Self.RawValue { get }
///}

///To conform to RawRepresentable, a structure needs to be able to be switched back and forth between an associated RawValue without losing any data. If RawRepresentable is a simple type like String or Int, then Swift provides built-in encoding and decoding functionality.


extension Color: RawRepresentable {
    public init?(rawValue: String) {
        do {
            let encodedData = rawValue.data(using: .utf8)!
            let components = try JSONDecoder().decode([Double].self, from: encodedData)
            self = Color(red: components[0],
                         green: components[1],
                         blue: components[2],
                         opacity: components[3])
        }
        catch {
            return nil
        }
    }
    
    public var rawValue: String {
        guard let cgFloatComponents = UIColor(self).cgColor.components else { return "" }
        let doubleComponents = cgFloatComponents.map { Double($0) }
        do {
            let encodedComponents = try JSONEncoder().encode(doubleComponents)
            return String(data: encodedComponents, encoding: .utf8) ?? ""
        }
        catch {
            return ""
        }
    }
}

// rawValue property converts color into a String. The first step is to get the red, green, blue, and alpha components from a Color. For example, Color.blue has a doubleComponents of [0.0, 0.478, 1.0, 1.0]. The doubleComponents are then encoded into JSON. Finally, a String is built by passing in the encoded JSON data.

// The rawValue encodes the Color into a String, and the initializer converts the String back into a Color object. It does this by converting the rawValue back into Data, then using a JSONDecoder to decode the Data into an array of Doubles representing the red, green, blue, and alpha components. Finally, it builds a Color out of those components and assigns that Color to the new object being instantiated.
