//
//  PageView.swift
//  TestProject
//
//  Created by Денис Мусатов on 14.09.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct PageView: View {
    
    var viewControllers: [UIHostingController<ReviewImage>]
    
    
    
    @State var showBackground: Bool
    
    @Binding var number: Int
    
    init(_ loadedImages: [LoadedImage], number: Binding<Int>) {
        
        _showBackground = State(initialValue: true)
        
        self.viewControllers = loadedImages.map {
            
            let uiView = UIHostingController(rootView: ReviewImage(image: $0.image))
            uiView.view.backgroundColor = .none
            return uiView
            
        }
        _number = number
    }
    
    var body: some View {
        PageViewController(controllers: viewControllers, number: $number)
            .edgesIgnoringSafeArea(.all)
    }
}

struct ReviewImage: View {
    var image: Image?
    
    @State private var dragOffset: CGSize = .zero
    @State var showBackground: Bool = true
    
    @EnvironmentObject var previewHider: PreviewHider
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
                .opacity(previewHider.showBackground ? 1 : 0)
            image?
                .resizable()
                .scaledToFit()
                .offset(dragOffset)
                
                
        }
        .allowsHitTesting(previewHider.transitionPermission)
//        .gesture(
//            DragGesture()
//                .onChanged { drag in
//                    print(drag.translation.height)
//                    withAnimation(Animation.linear(duration: 0.1)) {
//                        self.dragOffset.height = drag.translation.height
//                        
//                    }
//                    
//                    withAnimation {
//                        previewHider.showBackground = false
//                    }
//                    
//                }
//                .onEnded { drag in
//                    self.previewHider.transitionPermission = false
//                    if abs(self.dragOffset.height) > UIScreen.main.bounds.height / 5 {
//                        withAnimation {
//                            self.previewHider.showReviewView = false
//                            self.previewHider.transitionWay = drag.translation.height
//                            print(drag.translation.height)
//                        }
//                    } else {
//                        withAnimation {
//                            self.dragOffset = .zero
//                            self.previewHider.showBackground = true
//                        }
//                    }
//                    
//                    
//                    
//                    
//                }
//            )
        
    }
}


class PreviewHider: ObservableObject {
    @Published var showReviewView = false
    @Published var showBackground = true
    @Published var transitionWay: CGFloat = .zero
    @Published var transitionPermission = false
    
    func repickImage() {
        self.showBackground = true
    }
}



