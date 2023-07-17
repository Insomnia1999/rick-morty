//
//  EpisodesView.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import SwiftUI

struct EpisodesView: View {
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: EpisodesViewModel
    
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
            Text("Episodes")
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
                    ForEach(viewModel.episodes.indices, id: \.self) { index in

                        EpisodeCellview(episode: $viewModel.episodes[index])
                            .onTapGesture {
                                Globals.tabState = .episodes
                                appState.switchView = .episodeDetail(id: "\(viewModel.episodes[index].id!)")
                            }
                            .onAppear {
                                if index == viewModel.episodes.count - 1 {
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
        NoItemsView(message: "Oopss...It seems that the episodes of this series have disappeared. ")
    }
    
    var errorView: some View {
        ErrorView(message: "It seems that an unknown error has occurred. Sorry for the disturbances.")
    }
    
    var networkErrorView: some View {
        NoNetworkView(message: "It seems that the server has had a problem with the portal gun. Come back another time.")
    }
}
