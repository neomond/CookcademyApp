//
//  ContentView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 07.09.24.
//

import SwiftUI

struct RecipesListView: View {
    
    @StateObject var recipeData = RecipeData()
    /// We add the @StateObject wrapper so that the view updates when the model changes;
    /// so the RecipesListView view now has access to an instance of the RecipeData view model!
    
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
    var recipes: [Recipe] {
        recipeData.recipes
    }
    
    var navigationTitle: String {
        "All Recipes"
    }
}

#Preview {
    NavigationView {
        RecipesListView()
    }
}

/// Create a view model that connects the model to the view.
/// Create a reference to the view model in the view
/// Update the view when the view model changes


