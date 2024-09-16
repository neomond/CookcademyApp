//
//  ModifyIngredientView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 11.09.24.
//

import SwiftUI

struct ModifyIngredientView: ModifyComponentView {
    @Binding var ingredient: Ingredient
    @Environment(\.presentationMode) private var mode
    
    let createAction: ((Ingredient) -> Void)
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    init(component: Binding<Ingredient>, createAction: @escaping (Ingredient) -> Void) {
        self._ingredient = component
        self.createAction = createAction
      }
    
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

struct ModifyIngredientView_Previews: PreviewProvider {
  @State static var emptyIngredient = Recipe.testRecipes[0].ingredients[0]
    
  static var previews: some View {
    NavigationView {
      ModifyIngredientView(component: $emptyIngredient) { ingredient in
        print(ingredient)
      }
    }.navigationTitle("Add Ingredient")
  }
}



///Because the ModifyIngredientView now gets its ingredient from a different view, we update its ingredient to be a @Binding instead of a @State property.
