//
//  RecipeCategoryGridView.swift
//  Cookcademy
//
//  Created by Nazrin Atayeva on 09.09.24.
//

import SwiftUI

struct RecipeCategoryGridView: View {
    
    @StateObject private var recipeData = RecipeData()
    
    var body: some View {
        let columns = [GridItem(), GridItem()]
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(MainInformation.Category.allCases, id: \.self) {
                        category in
                        NavigationLink(
                            destination: RecipesListView(category: category)
                                .environmentObject(recipeData),
                            label: {
                                CategoryView(category: category)
                            }
                        )
                    }
                })
                .navigationTitle("Categories")
            }
        }
    }
}

#Preview {
    RecipeCategoryGridView()
}


/// The Image is modified to be .resizeable, forcing the image to fill all available space. Then, the image’s aspect ratio is set to .fit which forces the content to fit within the ZStack‘s frame. Here, the image will continue to shrink until the width of the photo matches the width of the view.


struct CategoryView: View {
    let category: MainInformation.Category
    
    var body: some View {
        ZStack {
            Image(category.rawValue)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.35)
            Text(category.rawValue)
                .font(.title)
        }
    }
}
