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
