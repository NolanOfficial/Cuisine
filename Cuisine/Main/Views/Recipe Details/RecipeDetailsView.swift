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
            
            Section {
                RecipeDetailsHeaderView(meal: meal)
                    .listRowSeparator(.hidden)
                    .listSectionSeparator(.hidden)
            }
            
            switch viewModel.state {
            case .loading:
                Section {
                    SkeletonDetailsView()
                        .listSectionSeparator(.hidden)
                        .listRowInsets(.zero)
                }
                
            case .result:
                if let mealDetail = viewModel.mealDetail {
                    
                    Section {
                        RecipeDetailsAboutView(mealDetail: mealDetail)
                    } header: {
                        Text("About")
                            .sectionTitle()
                    }
                    .listSectionSeparator(.hidden)
                    .listRowInsets(.zero)
                    
                    Section {
                        RecipeDetailsIngredientsView(mealDetail: mealDetail)
                    } header: {
                        Text("Ingredients")
                            .sectionTitle()
                    }
                    .listSectionSeparator(.hidden)
                    .listRowInsets(.zero)
                    
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
                Section {
                    EmptyDetailsView()
                        .listRowSeparator(.hidden)
                }
            }
        }
        .listStyle(.plain)
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
        
        .task {
            await viewModel.getMealDetail(for: meal)
        }
        
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
        RecipeDetailsView(meal: .MOCK_MEALS[0], viewModel: RecipeDetailsViewModel())
    }
}
