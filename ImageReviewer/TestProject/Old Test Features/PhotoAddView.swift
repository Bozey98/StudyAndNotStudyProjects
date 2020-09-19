//
//  PhotoAddView.swift
//  TestProject
//
//  Created by Денис Мусатов on 30.08.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI
import UIKit

struct PhotoAddView: View {
    
    //@EnvironmentObject var test : ImagePicker
    
    var body: some View {
            
//        Grid(test.photos) { card in
//            Image(uiImage: card.image)
//                .resizable()
//                .scaledToFill()
//                .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
//                .clipShape(RoundedRectangle(cornerRadius: 4))
//
//        }.onAppear {
//            self.test.getImages()
//        }
        TestGridView()
        
    }
}

struct PhotoAddView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoAddView()
    }
}
