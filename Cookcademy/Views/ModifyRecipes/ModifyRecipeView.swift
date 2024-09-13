//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 10.09.24.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    
    @State private var selection = Selection.main
    
    var body: some View {
        VStack {
            Picker("Select recipe component", selection: $selection) {
                Text("Main Info").tag(Selection.main)
                Text("Ingredients").tag(Selection.ingredients)
                Text("Directions").tag(Selection.directions)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            switch selection {
            case .main:
              ModifyMainInformationView(mainInformation: $recipe.mainInformation)
            case .ingredients:
              ModifyComponentsView<Ingredient, ModifyIngredientView>(components: $recipe.ingredients)
            case .directions:
              ModifyComponentsView<Direction, ModifyDirectionView>(components: $recipe.directions)
            }
            Spacer()
        }
    }
    
    enum Selection {
       case main
       case ingredients
       case directions
     }
}

/// recipe is wrapped with @Binding which means this view does not own it.
/// RecipesListView will provide the recipe to ModifyRecipeView through the binding. The binding allows ModifyRecipeView to access and modify the original property as if it owned recipe. Once ModifyRecipeView is done, it doesn’t need to send any recipe data back to RecipesListView since it was already owned by RecipesListView.


struct ModifyRecipeView_Previews: PreviewProvider {
  @State static var recipe = Recipe()
  static var previews: some View {
    ModifyRecipeView(recipe: $recipe)
  }
}
