//
//  EpisodeCellview.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import SwiftUI

struct EpisodeCellview: View {
    @Environment(\.colorScheme) var currentMode
    @Binding var episode: Episode
    
    let imageSize: CGFloat = 60
    let cornerRadius: CGFloat = 50
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.backgroundColor)
            
            HStack() {
                
                VStack() {
                    
                    Text(episode.name ?? "")
                        .foregroundColor(Color.primaryColor)
                        .font(.ubuntu(.medium, size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(episode.episode ?? "")
                        .font(.ubuntu(.regular, size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Air date: \(episode.airDate ?? "")")
                        .font(.ubuntu(.regular, size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.padding()
        }.padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 10)
    }
}
