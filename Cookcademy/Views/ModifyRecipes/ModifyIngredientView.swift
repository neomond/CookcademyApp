//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 11.09.24.
//

import SwiftUI

struct ModifyIngredientView: View {
    @Binding var ingredient: Ingredient
    @Environment(\.presentationMode) private var mode
    
    let createAction: ((Ingredient) -> Void)
    
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            Form {
                TextField("Ingredient Name", text: $ingredient.name)
                    .listRowBackground(listBackgroundColor)
                Stepper(value: $ingredient.quantity, in: 0...100, step: 0.5) {
                    HStack {
                        Text("Quantity:")
                        TextField("Quantity",
                                  value: $ingredient.quantity,
                                  formatter: NumberFormatter.decimal)
                        .keyboardType(.numbersAndPunctuation)
                    }
                }
                .listRowBackground(listBackgroundColor)
                Picker(selection: $ingredient.unit, label:
                        HStack {
                    Text("Unit")
                    Spacer()
                    Text(ingredient.unit.rawValue)
                }
                ) {
                    ForEach(Ingredient.Unit.allCases, id: \.self) { unit in
                        Text(unit.rawValue)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .listRowBackground(listBackgroundColor)
                
                HStack {
                    Spacer()
                    Button("Save") {
                        createAction(ingredient)
                        mode.wrappedValue.dismiss()
                    }
                    Spacer()
                }
                .listRowBackground(listBackgroundColor)
            }
            .foregroundColor(listTextColor)
        }
    }
}

extension NumberFormatter {
    static var decimal: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }
}

struct ModifyIngredientView_Preview: PreviewProvider {
  @State static var emptyIngredient = Ingredient()
  static var previews: some View {
    NavigationView {
      ModifyIngredientView(ingredient: $emptyIngredient) { ingredient in
        print(ingredient)
      }
    }
  }
}


///Because the ModifyIngredientView now gets its ingredient from a different view, we update its ingredient to be a @Binding instead of a @State property.
