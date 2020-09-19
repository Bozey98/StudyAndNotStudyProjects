//
//  GridView.swift
//  TestProject
//
//  Created by Денис Мусатов on 31.08.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct Grid<GridView: View, GridElement: Hashable>: View {
    
    var collection: [GridElement]
    var gridView: (GridElement) -> GridView
    var columns = 4
    
    init(_ collection: [GridElement], gridView: @escaping (GridElement) -> GridView) {
        self.collection = collection
        self.gridView = gridView
    }
    
    var getNums: [Int] {
        print(Array(stride(from: 0, through: collection.count, by: columns)))
        return Array(stride(from: 0, through: collection.count, by: columns))
    }
    
    func lastValue(_ i: Int) -> Int {
        
        if i + columns > collection.count {
            return min(columns, collection.count % columns)
        } else {
            return columns
        }
        
    }
    
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
//        }
        
            //GeometryReader { geo in
                ScrollView {
                    VStack {
                        ForEach(0..<self.collection.count) { i in
                            self.gridView(self.collection[i])
                            //.frame(width: geo.size.width / 4, height: geo.size.width / 4)
                            //.offset(x: )
                                //.modifier(GridLocation(position: i))
                        }
                    }.onAppear {
                        print(self.collection.count)
                    }
            //}
        }
        
    }
}

struct GridLocation: ViewModifier {
    
    var position: Int
    
    
    func body(content: Content) -> some View {
        let xPosition: CGFloat = UIScreen.main.bounds.width / 8 + (UIScreen.main.bounds.width / 4 * CGFloat(position % 4))
        let yPosition: CGFloat = UIScreen.main.bounds.width / 8
        let rowPosition = CGPoint(x: xPosition, y: yPosition)
        let yOffset: CGFloat = -(UIScreen.main.bounds.width / 4) * CGFloat(position % 4) - ( (UIScreen.main.bounds.width / 4) * CGFloat(position / 4 * 3))
        print(position)
        return content
                .position(rowPosition)
                .offset(y: yOffset)
    }
}
