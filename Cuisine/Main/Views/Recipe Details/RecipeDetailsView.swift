//
//  RecipeDetailsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    let meal: Meal
    
    @State private var mealDetail: MealDetail?
    
    @ObservedObject var viewModel: MainViewModel
    
    @State private var isInitializing = true
    
    var body: some View {
        
        // Can use ScrollView to boost performance
        // Animation masking works better for a list
        List {
            
            // Header
            Section {
                RecipeDetailsHeaderView(meal: meal)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
            }
            
            if isInitializing {
                
                // Skeleton Loading View
                Section {
                    SkeletonDetailsView()
                        .listSectionSeparator(.hidden)
                        .listRowInsets(.zero)
                }
                
            } else if let mealDetail {
                
                // About
                Section {
                    RecipeDetailsAboutView(mealDetail: mealDetail)
                } header: {
                    Text("About")
                        .sectionTitle()
                }
                .listSectionSeparator(.hidden)
                .listRowInsets(.zero)
                
                // Ingredients
                Section {
                    RecipeDetailsIngredientsView(mealDetail: mealDetail)
                } header: {
                    Text("Ingredients")
                        .sectionTitle()
                }
                .listSectionSeparator(.hidden)
                .listRowInsets(.zero)
            
                // Instructions
                if let instructions = mealDetail.instructions {
                    Section {
                        RecipeDetailsInstructionsView(instructions: instructions)
                    } header: {
                        Text("Instructions")
                            .sectionTitle()
                    }
                    .listSectionSeparator(.hidden)
                    .listRowInsets(.zero)
                }
                
                // Tags
                if let tags = mealDetail.tags {
                    Section {
                        RecipeDetailsTagsView(tags: tags)
                    } header: {
                        Text("Tags")
                            .sectionTitle()
                    }
                    .listSectionSeparator(.hidden)
                    .listRowInsets(.zero)
                }
               
            } else {
                // Error View
                Section {
                    EmptyDetailsView()
                        .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
        
        // Initializing
        // Would usually have task cancellation checks
        // Since we don't have multiple navigation stacks, it's not needed
        .task {
            mealDetail = await viewModel.getMealDetail(for: meal)
            withAnimation {
                isInitializing = false
            }
        }
        
        // Error handling alerts
        .alert(viewModel.mealError?.title ?? MealError.unknown.title, isPresented: $viewModel.showMealError) {
            Button("Ok") {
                viewModel.mealError = nil
            }
        } message: {
            Text(viewModel.mealError?.message ?? MealError.unknown.message)
        }
    }
}

#Preview {
    NavigationView {
        RecipeDetailsView(meal: .MOCK_MEALS[0], viewModel: MainViewModel())
    }
}
