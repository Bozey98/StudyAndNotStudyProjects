//
//  Grid.swift
//  Memorize
//
//  Created by Денис Мусатов on 26.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

extension Grid where Item: Identifiable, ID == Item.ID {
    init(_ items: [Item], viewForitem: @escaping (Item) -> ItemView) {
        self.init(items, id: \Item.id, viewForItem: viewForitem)
    }
}

struct Grid<Item, ID, ItemView>: View where ItemView: View, ID: Hashable {
    
    private var items: [Item]
    private var id: KeyPath<Item, ID>
    private var viewForItem: (Item) -> ItemView
    
    init(_ items: [Item], id: KeyPath<Item, ID>, viewForItem: @escaping (Item) -> ItemView) {
        self.items = items
        self.id = id
        self.viewForItem = viewForItem
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: GridLayout(itemCount: self.items.count, in: geometry.size))
        }
    }
    
    private func body(for layout: GridLayout) -> some View {
        ForEach(items, id: id) { item in
            self.body(for: item, in: layout)
        }
    }
    
    private func body(for item: Item, in layout: GridLayout) -> some View {
        let index = self.items.firstIndex(where: { item[keyPath: id] == $0[keyPath: id]})
        return viewForItem(item)
            .frame(width: layout.itemSize.width, height: layout.itemSize.height)
            .position(layout.location(ofItemAt: index!))
        
    }
    
    
}

