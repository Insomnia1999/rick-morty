//
//  NoNetworkView.swift
//  busoviedo-swiftui
//
//  Created by Iván Fernández Arenas on 10/4/23.
//

import SwiftUI

struct NoNetworkView: View {
    
    var message: String
    
    var body: some View {
        GeometryReader { geometryReader in
            Color.tabBackgroundColor.edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .center) {
                Image.networkErrorImage
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

struct NoNetworkView_Previews: PreviewProvider {
    static var previews: some View {
       NoItemsView(message: "Parece que el servidor de buses de gijón no esta disponible en estos momentos. Disculpa las molestias.")
    }
}
