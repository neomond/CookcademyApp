//
//  RecipeDetailView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 08.09.24.
//

import SwiftUI

struct RecipeDetailView: View {
    @Binding var recipe: Recipe
    @State private var isPresenting = false
    
    @EnvironmentObject var recipeData: RecipeData
    
    @AppStorage("hideOptionalSteps") private var hideOptionalSteps: Bool = false
    @AppStorage("listBackgroundColor") private var listBackgroundColor = AppColor.background
    @AppStorage("listTextColor") private var listTextColor = AppColor.foreground
    
    var body: some View {
        VStack {
            HStack {
                Text("Author: \(recipe.mainInformation.author)")
                    .font(.subheadline)
                    .padding()
                Spacer()
            } /* Author */
            HStack {
                Text(recipe.mainInformation.description)
                    .font(.subheadline)
                    .padding()
                Spacer()
            } /* Description */
            List {
                Section(header: Text("Ingredients")) {
                    ForEach(recipe.ingredients.indices, id: \.self){ index in
                        let ingredient = recipe.ingredients[index]
                        Text(ingredient.description)
                            .foregroundColor(listTextColor)
                    }
                } .listRowBackground(listBackgroundColor) /* List Ingredients */
                Section(header: Text("Directions")) {
                    ForEach(recipe.directions.indices, id: \.self) { index in
                        let direction = recipe.directions[index]
                        if direction.isOptional && hideOptionalSteps {
                            EmptyView()
                        } else {
                            HStack {
                                let index = recipe.index(of: direction, excludingOptionalDirections: hideOptionalSteps) ?? 0
                                Text("\(index + 1)").bold()
                                Text("\(direction.isOptional ? "(Optional) " : "" )"  +  "\(direction.description)")
                            }
                            .foregroundColor(listTextColor)
                        }
                    }
                }.listRowBackground(listBackgroundColor) /* List Directions */
            }
        }
        .navigationTitle(recipe.mainInformation.name)
        .toolbar {
            ToolbarItem {
                HStack {
                    Button("Edit") {
                        isPresenting = true
                    }
                    Button(action: {
                        recipe.isFavorite.toggle()
                    }) {
                        Image(systemName: recipe.isFavorite ? "heart.fill" : "heart")
                    }
                }
            }
            ToolbarItem(placement:  .navigationBarLeading) { Text("")}
        }
        .sheet(isPresented: $isPresenting) {
            NavigationView {
                ModifyRecipeView(recipe: $recipe)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                isPresenting = false
                            }
                        }
                    }
                    .navigationTitle("Edit Recipe")
            }
            .onDisappear() {
                recipeData.saveRecipes()
            }
        }
    }
}

/// \.self uses the entire recipe as the identifier.

struct RecipeDetailView_Previews: PreviewProvider {
    @State static var recipe = Recipe.testRecipes[0]
    
    static var previews: some View {
        NavigationView {
            RecipeDetailView(recipe: $recipe)
        }
    }
}
