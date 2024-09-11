//
//  ModifyMainInformationView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 11.09.24.
//

import SwiftUI

struct ModifyMainInformationView: View {
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    @Binding var mainInformation: MainInformation
    
    var body: some View {
        Form {
            TextField("Recipe Name", text: $mainInformation.name)
                .listRowBackground(listBackgroundColor)
            TextField("Author", text: $mainInformation.author)
                .listRowBackground(listBackgroundColor)
            Section(header: Text("Description")) {
                TextEditor(text: $mainInformation.description)
                    .listRowBackground(listBackgroundColor)
            }
            Picker(selection: $mainInformation.category, label:
                    HStack {
                Text("Category")
                Spacer()
                Text(mainInformation.category.rawValue)
            }) {
                ForEach(MainInformation.Category.allCases,
                        id: \.self) { category in
                    Text(category.rawValue)
                }
            }
            .listRowBackground(listBackgroundColor)
            .pickerStyle(MenuPickerStyle())
        }
        .foregroundColor(listTextColor)
    }
}


#Preview {
    @State var sampleMainInformation = MainInformation(
        name: "Sample Recipe",
        description: "This is a sample description.", author: "Sample Author",
        category: .breakfast)
    return ModifyMainInformationView(mainInformation: $sampleMainInformation)
}


/// In the context of ModifyMainInformationView, the @Binding property mainInformation allows the view to modify the mainInformation of a recipe. Here’s why it’s needed:

///Two-Way Data Flow: When the user edits the text fields or selects a category, the changes are reflected in the mainInformation property. Similarly, if mainInformation is updated elsewhere in the app, the view will reflect those changes.

///State Management: @Binding helps manage state across different views. The parent view can pass a binding to its child views, allowing them to read and write to the same state.

///Reactivity: SwiftUI’s declarative nature relies on state and bindings to automatically update the UI when the data changes.

///In summary, @Binding is essential for creating interactive and dynamic views that can read and modify shared state.
