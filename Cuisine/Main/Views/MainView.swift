//
//  MainView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/4/24.
//

import SwiftUI

struct MainView: View {
    
    // View Model
    @StateObject private var viewModel = MainViewModel()
    
    // Search text for recipes
    @State private var mealSearchText = ""
    // Search text results (filters name or id)
    var searchResults: [Meal] {
        if mealSearchText.isEmpty {
            return viewModel.meals
        } else {
            return viewModel.meals.filter { 
                $0.name.lowercased().contains(mealSearchText.lowercased()) ||
                $0.id.contains(mealSearchText) }
        }
    }
    
    var body: some View {
        
        // Navigation View (NavigationStack starts from iOS 16)
        NavigationView {
            
            // Using a list for the cell reusability aspect
            // Note this is only accessible through List, not ScrollView or LazyVStack
            List {
                
                // Categories Section
                Section {
                    MealCategoryView(viewModel: viewModel)
                }
                
                if viewModel.isInitializing || viewModel.isDownloadingMeals {
                    // Skeleton View (initializing)
                    Section {
                        Text("Recipes")
                            .font(.headline)
                            .listRowSeparator(.hidden)
                        
                        SkeletonMealsView()
                            .listRowSeparator(.hidden)
                    }
                    
                } else if searchResults.isEmpty {
                    // If no recipes found, show custom empty view
                    Section {
                        EmptyMealsView()
                            .padding(.top)
                            .listRowSeparator(.hidden)
                    }
                    
                } else {
                    // Recipe card view
                    Section {
                        HStack {
                            Text("Recipes")
                                .font(.headline)
                             
                            Text(searchResults.count, format: .number)
                                .roundedRectBackground()
                        }
                        .listRowSeparator(.hidden)
                       
                        // Pagination would be integrated here if the api request supported it
                        ForEach(searchResults) { meal in
                            NavigationLink {
                                RecipeDetailsView(meal: meal, viewModel: viewModel)
                            } label: {
                                RecipeView(meal: meal)
                            }
                            .accessibilityIdentifier("\(meal.name) Recipe")
                        }
                    }
                }
            }
            
            // View modifcations
            .listStyle(.plain)
            .navigationTitle("Cuisine")
            .searchable(text: $mealSearchText, placement: .navigationBarDrawer(displayMode: .always))
            
            // Toolbar for filter button
            .toolbar {
               MealFilterButton(viewModel: viewModel)
            }
            
            // Initializing
            // Would usually have task cancellation checks
            // Since we don't have multiple navigation stacks, it's not needed
            .task {
                guard viewModel.isInitializing else { return }
                await viewModel.getMeals()
                withAnimation {
                    viewModel.isInitializing = false
                }
            }
            
            // Refreshable
            .refreshable {
                await viewModel.getMeals()
            }
            
            // Changing meal category
            .onChange(of: viewModel.selectedCategory) { value in
                Task {
                    await viewModel.getMeals()
                }
            }
            
            // Sorting the recipes
            .onChange(of: viewModel.mealFilter) { value in
                viewModel.filterMeals()
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
}

#Preview {
    MainView()
}
