//
//  MainTabView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 14.09.24.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var recipeData = RecipeData()
    
    var body: some View {
        TabView {
            RecipeCategoryGridView()
                .tabItem { Label("Recipes", systemImage: "list.dash") }
            NavigationView {
                RecipesListView(viewStyle: .favorites)
            }   .tabItem { Label("Favorites", systemImage: "heart.fill")}
            SettingsView()
                .tabItem { Label("Settings", systemImage: "gear") }
        }
        .environmentObject(recipeData)
    }
}

#Preview {
    MainTabView()
}

/// The MainTabView owns a RecipeData instance as a @StateObject.
/// Because the MainTabView will be the initial view the user sees, it should create and own the view model. This means that the RecipeCategoryGridView should now have its RecipeData passed in as an environmentObject instead of creating its own.
