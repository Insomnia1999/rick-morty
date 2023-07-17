//
//  ErrorView.swift
//  busoviedo-swiftui
//
//  Created by Iván Fernández Arenas on 13/4/23.
//

import SwiftUI

struct ErrorView: View {
    
    var message: String
    
    var body: some View {
        GeometryReader { geometryReader in
            Color.tabBackgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Image.errorImage
                    .resizable()
                    .frame(width: geometryReader.size.width * 0.6, height:  geometryReader.size.width * 0.6)
                
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

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
       NoItemsView(message: "Parece que no hemos encontrado trayectos y paradas para esta línea ahora mismo.")
    }
}

