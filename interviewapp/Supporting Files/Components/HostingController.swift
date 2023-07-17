//
//  HostingController.swift
//  rickandmorty
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import SwiftUI

class HostingController: UIHostingController<ViewManager> {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default // Cambia el color de los elementos de la barra de estado a blanco
    }
}

