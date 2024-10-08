//
//  RecipeData.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 08.09.24.
//

import Foundation

class RecipeData: ObservableObject {
    @Published var recipes = Recipe.testRecipes
    
    
    ///  we create a favoriteRecipes computed property inside RecipeData to filter recipes by their isFavorite property, so we can find the ones that have been selected as favorites.
    var favoriteRecipes: [Recipe] {
        recipes.filter { $0.isFavorite}
    }
    
    func recipes(for category: MainInformation.Category) -> [Recipe] {
        var filteredRecipes = [Recipe]()
        for recipe in recipes {
            if recipe.mainInformation.category == category {
                filteredRecipes.append(recipe)
            }
        }
        return filteredRecipes
    }
    
    func add(recipe: Recipe){
        if recipe.isValid {
            recipes.append(recipe)
            saveRecipes()
        }
    }
    
    func index(of recipe: Recipe) -> Int? {
        for i in recipes.indices {
            if recipes[i].id == recipe.id {
                return i
            }
        }
        return nil
    }
    
    func saveRecipes(){
        do {
            let encodedData = try JSONEncoder().encode(recipes)
            try encodedData.write(to: recipesFileURL)
        } catch {
            fatalError("An error occurred while saving recipes: \(error)")
        }
    }
    
    func loadRecipes(){
        guard let data = try? Data(contentsOf: recipesFileURL) else { return }
        do {
            let savedRecipes = try JSONDecoder().decode([Recipe].self, from: data)
            recipes = savedRecipes
        } catch {
            fatalError("An error occurred while loading recipes: \(error)")
        }
    }
    
    private var recipesFileURL: URL {
        do {
            let documentsDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                 in: .userDomainMask,
                                                                 appropriateFor: nil,
                                                                 create: true)
            return documentsDirectory.appendingPathComponent("recipeData")
        }
        catch {
            fatalError("An error occurred while getting the url: \(error)")
        }
    }
}

// -----NOTE-----
/// RecipeData conforms to the ObservableObject protocol.
/// The ObservableObject protocol monitors when the @Published property changes.
/// The @Published property wrapper attaches to a property to monitor any changes. Here, recipes will monitor when Recipe.testRecipes changes.
/// RecipeData needs to be a class to conform to the ObservableObject protocol.

