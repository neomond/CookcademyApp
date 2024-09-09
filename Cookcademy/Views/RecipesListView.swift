//
//  ContentView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 07.09.24.
//

import SwiftUI

struct RecipesListView: View {
    
    @EnvironmentObject private var recipeData: RecipeData
    /// We add the @StateObject wrapper so that the view updates when the model changes;
    /// so the RecipesListView view now has access to an instance of the RecipeData view model!
   
    /// The recipeData property changed from a @StateObject to a @EnvironmentObject. 
    /// By passing an object through the environment, the current view and any children views can access that object.
    /// Here, RecipeCategoryGridView will hold now hold the recipeData object. Since RecipesListView will be a child view, RecipesListView will access that data through the environment using the @EnvironmentObject property wrapper.
    
    let category: MainInformation.Category
    private let listBackgroundColor = AppColor.background
    private let listTextColor = AppColor.foreground
    
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name,
                               destination: RecipeDetailView(recipe: recipe))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }
        .navigationTitle(navigationTitle)
    }
}

extension RecipesListView {
    
   private var recipes: [Recipe] {
       recipeData.recipes(for: category)
    }
    
   private var navigationTitle: String {
       "\(category.rawValue) Recipes"
    }
}

#Preview {
    NavigationView {
        RecipesListView(category: .breakfast)
            .environmentObject(RecipeData())
    }
}

/// Create a view model that connects the model to the view.
/// Create a reference to the view model in the view
/// Update the view when the view model changes




///The new category property is the Category to display that the grid will pass in. The new function, recipes(for:), was created to filter recipes by category. Then, the recipes property calls this function to return the recipes filtered by the category. The navigation title was also changed to only include the specific category. Lastly, RecipesListView_Previews needed to add the category argument for RecipesListView as well as an environment object to correctly display a list of recipes.
