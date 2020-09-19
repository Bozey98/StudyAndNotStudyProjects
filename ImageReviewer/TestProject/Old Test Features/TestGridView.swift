//
//  GridView.swift
//  TestProject
//
//  Created by Денис Мусатов on 31.08.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct TestGridView: View {
    
    var config = ImagePickerConfigurations()
    
    var body: some View {
        
//        ScrollView {
//            VStack(spacing: 0){
//                ForEach(self.getNums, id: \.self) { i in
//                    HStack(spacing: 0) {
//                        ForEach(0..<self.lastValue(i)) { add in
//                            return self.gridView(self.collection[i + add])
//                        }
//                    Spacer()
//                    }
//
//
//
//                }
//            }
//        }0
        
            //GeometryReader { geo in
                ScrollView {
                    VStack {
                        ForEach(0..<self.config.assets.count) { i in
                            Image(uiImage: self.config.getImage(id: i))
                                .resizable()
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width / 4, height: UIScreen.main.bounds.width / 4)
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                            //.frame(width: geo.size.width / 4, height: geo.size.width / 4)
                            //.offset(x: )
                                //.modifier(GridLocation(position: i))
                        }
                    }
            //}
        }
        
    }
}

