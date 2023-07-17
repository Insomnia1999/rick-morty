//
//  CharacteCell.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import SwiftUI

struct CharacterCellView: View {
    
    @Environment(\.colorScheme) var currentMode
    @Binding var character: Character
    
    let imageSize: CGFloat = 60
    let cornerRadius: CGFloat = 50
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.backgroundColor)
            
            HStack() {
                CachedAsyncImage(url: URL(string: character.image ?? "" )!, urlCache: .imageCache) { image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                    .frame(width: imageSize, height: imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    .shadow(color: .gray, radius: 2, x: 0, y: 2)
                
                VStack() {
                    
                    Text(character.name ?? "")
                        .foregroundColor(Color.primaryColor)
                        .font(.ubuntu(.medium, size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(character.status?.rawValue ?? "")
                        .font(.ubuntu(.regular, size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.padding()
        }.padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 10)
    }
}
