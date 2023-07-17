//
//  CharacterView.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @EnvironmentObject var appState: AppState
    @StateObject var viewModel: CharacterDetailViewModel
    
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
            viewModel.fetchCharacterDetail()
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
            
            AsyncImage(url: URL(string: viewModel.character?.image ?? "")!) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: viewModel.imageSize, height: viewModel.imageSize)
                .clipShape(RoundedRectangle(cornerRadius: viewModel.cornerRadius))
                .shadow(color: .gray, radius: 2, x: 0, y: 2)
                
            Text(viewModel.character?.name ?? "")
                .font(.ubuntu(.bold, size: 32))
                .foregroundColor(.tabColor)
                
            Divider().frame(maxWidth: 240)
            
            VStack(spacing: 10) {
                    
                genderView
            
                speciesView
                
                currentStatusView
  
                bornView
                
                livingView
                
            }.padding(.top, 16)
            
            Spacer()
            
        }.padding(.horizontal, 20)
    }

    var genderView: some View {
        HStack {
            Text("Gender")
                .foregroundColor(.primaryColor)
                .font(.ubuntu(.medium, size: 16))
            
            Spacer()
            
            VStack {
                
                Text(viewModel.character?.gender?.rawValue ?? "")
                    .font(.ubuntu(.regular, size: 16))
            }
        }
    }
    
    var speciesView: some View {
        HStack {
                
            Text("Species")
                .foregroundColor(.primaryColor)
                .font(.ubuntu(.medium, size: 16))
                
            Spacer()
                
            VStack {
                    
                Text(viewModel.character?.species ?? "")
                    .font(.ubuntu(.regular, size: 16))
            }
        }
    }
    
    var currentStatusView: some View {
        HStack {
            
            Text("Current status")
                .foregroundColor(.primaryColor)
                .font(.ubuntu(.medium, size: 16))
            
            Spacer()
            
            VStack {
                
                Text(viewModel.character?.status?.rawValue ?? "")
                    .font(.ubuntu(.regular, size: 16))
            }
        }
    }
    
    var bornView: some View {
        HStack {
            
            Text("Born in")
                .foregroundColor(.primaryColor)
                .font(.ubuntu(.medium, size: 16))
            
            Spacer()
            
            VStack {
                
                Text(viewModel.character?.origin?.name ?? "")
                    .font(.ubuntu(.regular, size: 16))
            }
        }
    }
    
    var livingView: some View {
        HStack {
            
            Text("Current living in")
                .foregroundColor(.primaryColor)
                .font(.ubuntu(.medium, size: 16))
            
            Spacer()
            
            VStack {
                
                Text(viewModel.character?.location?.name ?? "")
                    .font(.ubuntu(.regular, size: 16))
            }
        }
    }
    
    var loadingView: some View {
        LoadingView()
    }
    
    var noItemsView: some View {
        NoItemsView(message: "Oopss...It seems that the character of this series have disappeared. ")
    }
    
    var errorView: some View {
        ErrorView(message: "It seems that an unknown error has occurred. Sorry for the disturbances.")
    }
    
    var networkErrorView: some View {
        NoNetworkView(message: "It seems that the server has had a problem with the portal gun. Come back another time.")
    }
}

