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
    @State private var searchText = ""
    
    var body: some View {
        
        // Navigation View (NavigationStack starts from iOS 16)
        NavigationView {
            
            // Using a list for the cell reusability aspect
            // Note this is only accessible through List, not ScrollView or LazyVStack
            List {
                
                // Categories Section
                Section {
                    MealCategoryView(category: $viewModel.selectedCategory)
                }
                
                // Switching over the different view state models
                switch viewModel.state {
                    
                case .loading:
                    // Skeleton View (initializing)
                    Section {
                        SkeletonMealsView()
                            .listRowSeparator(.hidden)
                    } header: {
                        Text("Recipes")
                            .listRowInsets(.zero)
                            .listRowSeparator(.hidden)
                            .sectionTitle()
                            .redacted(reason: .placeholder)
                    }
                    
                case .result:
                    // Recipe card view
                    Section {
                        ForEach(viewModel.mealsSearchResults) { meal in
                            NavigationLink {
                                RecipeDetailsView(meal: meal)
                            } label: {
                                RecipeView(meal: meal)
                            }
                            .accessibilityIdentifier("\(meal.name) Recipe")
                        }
                        .listRowSeparator(.hidden)
                    } header: {
                        HStack {
                            Text("Recipes")
                            
                            Text(viewModel.mealsSearchResults.count, format: .number)
                                .roundedRectBackground()
                        }
                        .listRowInsets(.zero)
                        .listRowSeparator(.hidden)
                        .sectionTitle()
                    }
                    
                case .empty, .error :
                    // If no recipes found, show custom empty view
                    Section {
                        EmptyMealsView()
                            .padding(.top)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            
            // View modifcations
            .listStyle(.plain)
            .navigationTitle("Cuisine")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            
            // Toolbar for filter button
            .toolbar {
                MealFilterButton(mealFilter: $viewModel.mealFilter)
            }
            
            // Initializing
            .task {
                await viewModel.getMeals()
            }
            
            // Refreshable
            .refreshable {
                await viewModel.getMeals()
            }
            
            // Search meals from the user's input
            .onChange(of: searchText) { value in
                viewModel.searchMeals(with: value)
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
            .alert(viewModel.error?.title ?? MealError.unknown.title, isPresented: $viewModel.showError) {
                Button("Ok") {
                    viewModel.error = nil
                }
            } message: {
                Text(viewModel.error?.message ?? MealError.unknown.message)
            }
        }
    }
}

#Preview {
    MainView()
}
