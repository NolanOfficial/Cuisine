//
//  RecipeDetailsView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/7/24.
//

import SwiftUI

struct RecipeDetailsView: View {
    
    let meal: Meal
    
    @StateObject var viewModel = RecipeDetailsViewModel()
    
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
            
            // Switching over the different view state models
            switch viewModel.state {
                
            case .loading:
                // Skeleton Loading View
                Section {
                    SkeletonDetailsView()
                        .listSectionSeparator(.hidden)
                        .listRowInsets(.zero)
                }
                
            case .result:
                if let mealDetail = viewModel.mealDetail {
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
                }
                
            case .empty, .error:
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
        .task {
            await viewModel.getMealDetail(for: meal)
        }
        
        // Error handling alerts
        .alert(viewModel.error?.title ?? MealError.unknown.title, isPresented: $viewModel.showError) {
            Button("Ok") {
                viewModel.error = nil
            }
        } message: {
            Text(viewModel.error?.message ?? MealError.unknown.message)
        }
    }
}

#Preview {
    NavigationView {
        RecipeDetailsView(meal: .MOCK_MEALS[0], viewModel: RecipeDetailsViewModel())
    }
}
