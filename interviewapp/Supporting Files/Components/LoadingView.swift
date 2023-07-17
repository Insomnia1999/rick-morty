//
//  LoadingView.swift
//  busoviedo-swiftui
//
//  Created by Iván Fernández Arenas on 12/4/23.
//

import SwiftUI
import LottieUI

struct LoadingView: View {

    var body: some View {
        ZStack {
            Asset.paleGray.swiftUIColor.edgesIgnoringSafeArea(.all)
            
            LottieView(state: LUStateData(type: .name("loading", .main), loopMode: .loop))
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
       LoadingView()
    }
}


