//
//  SwiftCryptoXApp.swift
//  SwiftCryptoX
//
//  Created by Jon Rosenblum on 8/21/23.
//

import SwiftUI

@main
struct SwiftCryptoXApp: App {
    
    
    @StateObject private var vm = HomeViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(vm)
        }
    }
}
