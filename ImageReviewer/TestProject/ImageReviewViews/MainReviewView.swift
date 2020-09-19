//
//  ImagesReviewView.swift
//  TestProject
//
//  Created by Денис Мусатов on 14.09.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct MainReviewView: View {
    
    @State private var showImageMenu = false
    @State private var imageNumber: Int
    @ObservedObject var pointInfo: PointInfo
    @State var currentImage: LoadedImage
    
    @EnvironmentObject var previewHider: PreviewHider
    
    init(pointInfo: PointInfo, currentImage: LoadedImage) {
        self.pointInfo = pointInfo
        self._currentImage = State(initialValue: currentImage)
        
        self._imageNumber = State(initialValue: pointInfo.images.firstIndex { image in image.id == currentImage.id } ?? 0)
        
    }
    
    var body: some View {
        ZStack {
            Color.black.opacity(previewHider.showBackground ? 1 : 0)
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)

            PageView(pointInfo.images, number: $imageNumber)
                .environmentObject(previewHider)
                .zIndex(1).onTapGesture {
                    withAnimation(.easeInOut(duration: 0.8)) {
                        self.showImageMenu.toggle()
                    }
                }
            
            if showImageMenu {
                VStack {
                    ZStack {
                        Color.black.opacity(0.4)
                            .frame(height: UIScreen.main.bounds.height / 10)
                        ZStack {
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    previewHider.showReviewView = false
                                }
                            }){
                                HStack {
                                    Image(systemName: "chevron.left")
                                    Text("Back")
                                    Spacer()
                                }
                            }
                            
                            HStack {
                                Spacer()
                                Text("\(imageNumber + 1) of \(pointInfo.images.count)").bold()
                                Spacer()
                            }
                                             
                        }
                        .foregroundColor(.white)
                        .padding()
                        .padding(.top, 20)
                    }
                    
                    Spacer()
                    
                }
                .opacity(previewHider.showBackground ? 1 : 0)
                .zIndex(2)
                .edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.header)
                
                
            }
            
            if showImageMenu {
                VStack {
                    
                    Spacer()
                    Color.black.opacity(0.4)
                        .frame(height: UIScreen.main.bounds.height / 10)
                    
                }
                .opacity(previewHider.showBackground ? 1 : 0)
                .zIndex(2)
                .edgesIgnoringSafeArea(.all)
                .transition(AnyTransition.footer)
                
                
            }
            
        }
    }
}

extension AnyTransition {
    static var header: AnyTransition {
        let transition = AnyTransition.move(edge: .top).combined(with: .opacity)
         
        return transition
    }
}

extension AnyTransition {
    static var footer: AnyTransition {
        let transition = AnyTransition.move(edge: .bottom).combined(with: .opacity)
         
        return transition
    }
}
