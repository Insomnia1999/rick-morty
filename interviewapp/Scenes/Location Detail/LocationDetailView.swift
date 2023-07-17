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
            
            VStack {
                Text(viewModel.location?.name ?? "")
                    .font(.ubuntu(.bold, size: 32))
                    .foregroundColor(.tabColor)
                
                Divider().frame(maxWidth: 240)
                
                VStack(spacing: 10) {
                    typeView
                    
                    dimensionView
                }
                
            }.padding(.horizontal, 20)
               
            charactersListView
            
            Spacer()
        }
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
            Text("Residents")
                .font(.ubuntu(.bold, size: 20))
                .foregroundColor(.tabColor)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
            
            ScrollView(showsIndicators: false) {
                LazyVStack {
                    ForEach($viewModel.characters) { character in
                        CharacterCellView(character: character)
                            .onTapGesture {
                                appState.switchView = .characterDetail(id: "\(character.id ?? 0)", screen: .locationDetail(id: "\(viewModel.location?.id ?? 0)"))
                            }
                    }
                }
            }
        }.padding(.top, 18)
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
