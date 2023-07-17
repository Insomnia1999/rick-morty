//
//  LocationsView.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import SwiftUI

struct LocationsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: LocationsViewModel
    
    var body: some View {
        ZStack {
            Color.tabBackgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                header
                
                searchView
                
                switch viewModel.screenState {
                case .loading:
                    loadingView
                case .error:
                    errorView
                case .networkError:
                    networkErrorView
                case .noItems:
                    noItemsView
                case .success:
                    content
                }
            }

            
        }.onAppear(perform: {
            self.viewModel.requestInitialSetOfItems()
        })
    }
    
    var header: some View {
        VStack {
            Text("Locations")
                .font(.ubuntu(.bold, size: 32))
                .foregroundStyle(Color.tabColor)
        }.frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 16)
        .padding(.leading, 20)
        .padding(.bottom, 8)
    }
    
    var searchView: some View {
        TextField("Search...", text: $viewModel.searchTerm)
                        .padding(7)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding([.horizontal, .top])
                        .onSubmit {
                            self.viewModel.requestInitialSetOfItems()
                        }
    }
    
    var content: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.locations.indices, id: \.self) { index in
                        LocationCellView(location: $viewModel.locations[index])
                            .onTapGesture {
                                Globals.tabState = .locations
                                appState.switchView = .locationDetail(id: "\( viewModel.locations[index].id ?? 0)")

                            }
                            .onAppear {
                                if index == viewModel.locations.count - 1 {
                                    viewModel.requestMoreItemsIfNeeded()
                                }
                            }
                    }
                }.padding(.bottom, 90)
            }
        }
    }
    
    var loadingView: some View {
        LoadingView()
    }
    
    var noItemsView: some View {
        NoItemsView(message: "Oopss...It seems that the locations of this series have disappeared. ")
    }
    
    var errorView: some View {
        ErrorView(message: "It seems that an unknown error has occurred. Sorry for the disturbances.")
    }
    
    var networkErrorView: some View {
        NoNetworkView(message: "It seems that the server has had a problem with the portal gun. Come back another time.")
    }
}

