//
//  LocationCellView.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 16/7/23.
//

import SwiftUI

struct LocationCellView: View {
    @Environment(\.colorScheme) var currentMode
    @Binding var location: Location
    
    let imageSize: CGFloat = 60
    let cornerRadius: CGFloat = 50
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.backgroundColor)
            
            HStack() {
                
                VStack() {
                    
                    
                    
                    Text(location.name ?? "")
                        .foregroundColor(Color.primaryColor)
                        .font(.ubuntu(.medium, size: 18))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(location.type ?? "")
                        .font(.ubuntu(.regular, size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text((location.dimension == "Unknown" ? "Unknown" : "Dimension: \(location.dimension ?? "")") ?? "")
                        .font(.ubuntu(.regular, size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.padding()
        }.padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.top, 10)
    }
}
