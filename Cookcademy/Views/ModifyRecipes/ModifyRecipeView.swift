//
//  ModifyRecipeView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 10.09.24.
//

import SwiftUI

struct ModifyRecipeView: View {
    @Binding var recipe: Recipe
    
    var body: some View {
        Button("Fill in the recipe with test data.") {
            recipe.mainInformation = MainInformation(name: "test",
                                                          description: "test",
                                                          author: "test",
                                                          category: .breakfast)
            recipe.directions = [ Direction(description: "test", isOptional: false)
            ]
            recipe.ingredients = [Ingredient(name: "test", quantity: 1.0, unit: .none)]
        }
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
