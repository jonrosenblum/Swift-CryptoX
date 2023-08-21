//
//  HomeView.swift
//  SwiftCryptoX
//
//  Created by Jon Rosenblum on 8/21/23.
//

import SwiftUI

struct HomeView: View {
    
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack{
                HStack{
                    CircleButtonView(iconName: "info")
                    Spacer()
                    Text("Live Prices")
                        .font(.headline)
                        .fontWeight(.heavy)
                        .foregroundColor(Color.theme.accent)
                    Spacer()
                    CircleButtonView(iconName: "chevron.right")
                }
                .padding(.horizontal)
                Spacer(minLength: 0)
            }
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
    }
}
