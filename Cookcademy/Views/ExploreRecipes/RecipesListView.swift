//
//  ContentView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 07.09.24.
//

import SwiftUI

struct RecipesListView: View {
    
    @EnvironmentObject private var recipeData: RecipeData
    let viewStyle: ViewStyle
    
    @State private var isPresenting = false
    @State private var newRecipe = Recipe()
    /// We add the @StateObject wrapper so that the view updates when the model changes;
    /// so the RecipesListView view now has access to an instance of the RecipeData view model!
    
    /// The recipeData property changed from a @StateObject to a @EnvironmentObject.
    /// By passing an object through the environment, the current view and any children views can access that object.
    /// Here, RecipeCategoryGridView will hold now hold the recipeData object. Since RecipesListView will be a child view, RecipesListView will access that data through the environment using the @EnvironmentObject property wrapper.
    
    
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    
    var body: some View {
        List {
            ForEach(recipes) { recipe in
                NavigationLink(recipe.mainInformation.name,
                               destination: RecipeDetailView(recipe: binding(for: recipe)))
            }
            .listRowBackground(listBackgroundColor)
            .foregroundColor(listTextColor)
        }
        .navigationTitle(navigationTitle)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    newRecipe = Recipe()
                    newRecipe.mainInformation.category = recipes.first?.mainInformation.category ?? .breakfast
                    isPresenting = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $newRecipe)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresenting = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            if newRecipe.isValid {
                                Button("Add") {
                                    if case .favorites = viewStyle {
                                        newRecipe.isFavorite = true
                                    }
                                    recipeData.add(recipe: newRecipe)
                                    isPresenting = false
                                }
                            }
                        }
                    }
                    .navigationTitle("Add a New Recipe")
            }
        }
    }
}

extension RecipesListView {
    
    enum ViewStyle {
        case favorites
        case singleCategory(MainInformation.Category)
        /// display either all recipes from a single category or the favorite recipes.
    }
    
    private var recipes: [Recipe] {
        switch viewStyle {
        case let .singleCategory(category):
            return recipeData.recipes(for: category)
        case .favorites:
            return recipeData.favoriteRecipes
        }
    }
    
    private var navigationTitle: String {
        switch viewStyle {
        case let .singleCategory(category):
            return  "\(category.rawValue) Recipes"
        case .favorites:
            return "Favorite Recipes"
        }
    
    }
    
    func binding(for recipe: Recipe) -> Binding<Recipe> {
        guard let index = recipeData.index(of: recipe) else {
            fatalError("Recipe not found")
        }
        return $recipeData.recipes[index]
    }
    
    /// A binding to a recipe in RecipeDetailView allows the view to modify the recipe directly. This is essential for the ModifyRecipeView to update the recipe in real-time. Without a binding, changes made in the ModifyRecipeView wouldn’t reflect in the original recipe data. Bindings ensure that the data stays consistent across different views.
}

#Preview {
    NavigationView {
        RecipesListView(viewStyle:  .singleCategory(.breakfast))
            .environmentObject(RecipeData())
    }
}

/// Create a view model that connects the model to the view.
/// Create a reference to the view model in the view
/// Update the view when the view model changes




///The new category property is the Category to display that the grid will pass in. The new function, recipes(for:), was created to filter recipes by category. Then, the recipes property calls this function to return the recipes filtered by the category. The navigation title was also changed to only include the specific category. Lastly, RecipesListView_Previews needed to add the category argument for RecipesListView as well as an environment object to correctly display a list of recipes.
