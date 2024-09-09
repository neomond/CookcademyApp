//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 08.09.24.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
          if recipe.mainInformation.category == category {
            filteredRecipes.append(recipe)
          }
        }
        return filteredRecipes
      }
}

// -----NOTE-----
/// RecipeData conforms to the ObservableObject protocol.
/// The ObservableObject protocol monitors when the @Published property changes.
/// The @Published property wrapper attaches to a property to monitor any changes. Here, recipes will monitor when Recipe.testRecipes changes.
/// RecipeData needs to be a class to conform to the ObservableObject protocol.

