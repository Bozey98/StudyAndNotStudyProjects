//
//  ContentView.swift
//  KekMemTestProj
//
//  Created by Денис Мусатов on 09.08.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var pointInfo : PointInfo
    @ObservedObject var previewHider = PreviewHider()
    
    @State var selectedImage: LoadedImage
    
    init() {
        self.pointInfo = PointInfo()
        _selectedImage = State(initialValue: _pointInfo.wrappedValue.images[0])
    }
    
    
    var body: some View {
        //MainReviewView()
        ZStack {
            Color.blue.edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(pointInfo.images) { image in
                        LoadingImageView(loadedImage: image).squadClipped()
                            .onTapGesture {
                                self.selectedImage = image
                                self.previewHider.repickImage()
                                withAnimation(.easeInOut(duration: 0.25)) {
                                    self.previewHider.showReviewView = true
                                }
                            }
                    }
                }
            }
            .padding(.horizontal)
        }
        
        .imagesReview(isPresented: $previewHider.showReviewView) {
            MainReviewView(pointInfo: self.pointInfo, currentImage: self.selectedImage)
                .environmentObject(previewHider)
        }.environmentObject(previewHider)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct ImagesReviewModifier<ImagesView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    var imagesView: ImagesView
    @EnvironmentObject var previewHider: PreviewHider
    
    init(isPresented: Binding<Bool>, @ViewBuilder imagesView: () -> ImagesView ) {
        _isPresented = isPresented
        self.imagesView = imagesView()
    }
    
    
    func body(content: Content) -> some View {
       
        ZStack {
            content.zIndex(0)
            if isPresented {
                imagesView
                    .transition(AnyTransition.superOpacity(transitionWay: self.previewHider.transitionWay))
                    .zIndex(1)
            }
        }
    }
}

extension View {
    func imagesReview<ImagesView: View>(isPresented: Binding<Bool>, @ViewBuilder imagesView: () -> ImagesView) -> some View {
        self.modifier(ImagesReviewModifier(isPresented: isPresented, imagesView: imagesView))
    }
}

extension AnyTransition {
    static func superOpacity(transitionWay: CGFloat) -> AnyTransition {
        let insertion = AnyTransition.opacity
        
        let removal = AnyTransition.move(edge: transitionWay >= 0 ? .top : .bottom).combined(with: .opacity)
         
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
