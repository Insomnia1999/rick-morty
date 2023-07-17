//
//  NoItemsView.swift
//  busoviedo-swiftui
//
//  Created by Iván Fernández Arenas on 4/4/23.
//

import SwiftUI

struct NoItemsView: View {
    
    var message: String
    
    var body: some View {
        GeometryReader { geometryReader in
            Color.tabBackgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Image.noItemsImage
                    .resizable()
                    .frame(width: geometryReader.size.width * 0.6, height:  geometryReader.size.width * 0.4)
                
                Text(message)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .multilineTextAlignment(.center)
                    .padding(.top, 8)
                    .padding(.leading, 24)
                    .padding(.trailing, 24)
            }.position(x: geometryReader.frame(in: .local).midX, y: geometryReader.frame(in: .local).midY)
        }
    }
}

struct NoItemsView_Previews: PreviewProvider {
    static var previews: some View {
       NoItemsView(message: "Upss... Parece que aún no tienes paradas favoritas.")
    }
}

