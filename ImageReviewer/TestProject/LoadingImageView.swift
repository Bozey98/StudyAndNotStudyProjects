//
//  LoadingImageView.swift
//  GdePotrnenitProject
//
//  Created by Денис Мусатов on 07.09.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct LoadingImageView: View {
    
    @ObservedObject var loadedImage: LoadedImage
    @State var isLoading = false
    
    var body: some View {
        Group {
            if loadedImage.image == nil {
                ZStack {
                    Color.white
                    Circle()
                        .trim(from: 0, to: 0.8)
                        .stroke(AngularGradient(gradient: .init(colors: [.red, .orange]), center: .center), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                        .padding(15)
                        .rotationEffect(.init(degrees: isLoading ? 360 : 0))
                        .animation(Animation.linear(duration: 0.7).repeatForever(autoreverses: false))
                }
                .onAppear { self.isLoading = true}
                .onDisappear { self.isLoading = false}
                
            } else {
                self.loadedImage.image!
                    .squadClipped()
                    .transition(.opacity)
            }
        }
    }
    
    
}

//struct LoadingImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoadingImageView(loadedImage: LoadedImage(id: "123"))
//    }
//}
