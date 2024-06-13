//
//  MainView.swift
//  Cuisine
//
//  Created by Nolan Fuchs on 6/4/24.
//

import SwiftUI

struct MainView: View {
    
    @StateObject private var viewModel = MainViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        
        // Navigation View (NavigationStack starts from iOS 16)
        NavigationView {
            
            // Using a list for the cell reusability aspect
            // Note this is only accessible through List, not ScrollView or LazyVStack
            List {
                
                Section {
                    MealCategoryView(category: $viewModel.selectedCategory)
                }
                
                switch viewModel.state {
                case .loading:
                    Section {
                        SkeletonMealsView()
                            .listRowSeparator(.hidden)
                    }
                    
                case .result:
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
                        .sectionTitle()
                    }
                    
                case .empty, .error :
                    Section {
                        EmptyMealsView()
                            .padding(.top)
                            .listRowSeparator(.hidden)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Cuisine")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            
            .toolbar {
                MealFilterButton(mealFilter: $viewModel.mealFilter)
            }
            
            .task {
                await viewModel.getMeals()
            }

            .refreshable {
                await viewModel.getMeals()
            }
            
            // Search meals from the user's input
            .onChange(of: searchText) { value in
                viewModel.searchMeals(with: value)
            }
            
            // Changing meal category retrieves new meals
            .onChange(of: viewModel.selectedCategory) { value in
                Task {
                    await viewModel.getMeals()
                }
            }
            
            // Sorting the recipes from toolbar filter selection
            .onChange(of: viewModel.mealFilter) { value in
                viewModel.filterMeals()
            }
            
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
