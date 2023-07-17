//
//  LocationView.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import SwiftUI

struct LocationDetailView: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: LocationDetailViewModel
    
    var body: some View {
        ZStack {
            Color.tabBackgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                header
                
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
        }.onAppear {
            viewModel.fetchLocationDetail()
        }
    }
    
    var header: some View {
        HStack {
            Button {
                viewModel.popToViewController(appState: appState)
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .frame(width: 12, height: 18)
                    .foregroundColor(.tabColor)
            }
            .padding(.leading, 24)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var content: some View {
        VStack {
            
            Text(viewModel.location?.name ?? "")
                .font(.ubuntu(.bold, size: 32))
                .foregroundColor(.tabColor)
                
            Divider().frame(maxWidth: 240)
            
            VStack(spacing: 10) {
                    
                typeView
            
                dimensionView
            
                charactersListView
                
            }.padding(.top, 16)
            
            Spacer()
            
        }.padding(.horizontal, 20)
    }

    var typeView: some View {
        HStack {
            Text("🪐 Type")
                .foregroundColor(.primaryColor)
                .font(.ubuntu(.medium, size: 16))
            
            Spacer()
            
            VStack {
                
                Text(viewModel.location?.type ?? "")
                    .font(.ubuntu(.regular, size: 16))
            }
        }
    }
    
    var dimensionView: some View {
        HStack {
                
            Text("🚀 Dimension")
                .foregroundColor(.primaryColor)
                .font(.ubuntu(.medium, size: 16))
                
            Spacer()
                
            VStack {
                    
                Text("Dimension \(viewModel.location?.dimension ?? "")")
                    .font(.ubuntu(.regular, size: 16))
            }
        }
    }
    
    var charactersListView: some View {
        VStack(spacing: 10) {
            Text("Characters")
                .font(.ubuntu(.bold, size: 20))
                .foregroundColor(.tabColor)
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach(viewModel.characters.indices, id: \.self) { index in
                        let character = viewModel.characters[index]
                        
                        CharacterCellView(character: character)
                            .onTapGesture {
                                Globals.tabState = .characters
                                appState.switchView = .characterDetail(id: "\(character.id ?? 0)", isFromCharacterList: true)
                            }
                            .onAppear {
                                if index == viewModel.characters.count - 1 {
                                    viewModel.requestMoreItemsIfNeeded()
                                }
                            }
                    }
                }
            }
        }
    }
    
    var loadingView: some View {
        LoadingView()
    }
    
    var noItemsView: some View {
        NoItemsView(message: "Oopss...It seems that this location from Rick and Morty series have disappeared. ")
    }
    
    var errorView: some View {
        ErrorView(message: "It seems that an unknown error has occurred. Sorry for the disturbances.")
    }
    
    var networkErrorView: some View {
        NoNetworkView(message: "It seems that the server has had a problem with the portal gun. Come back another time.")
    }
}
