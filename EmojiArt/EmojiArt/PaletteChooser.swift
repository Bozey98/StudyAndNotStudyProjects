//
//  PaletteChooser.swift
//  EmojiArt
//
//  Created by Денис Мусатов on 07.07.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct PaletteChooser: View {
    
    @ObservedObject var document: EmojiArtDocument
    @Binding var chosenPalette: String
    @State private var showPaletteEditor = false
    
    var body: some View {
        HStack {
            Stepper(onIncrement: {
                self.chosenPalette = self.document.palette(after: self.chosenPalette)
            }, onDecrement: {
                self.chosenPalette = self.document.palette(before: self.chosenPalette)
            }, label: { EmptyView()})
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
            Image(systemName: "keyboard").imageScale(.large)
                .onTapGesture {
                    self.showPaletteEditor = true
                }
                .popover(isPresented: $showPaletteEditor) {
                    PaletteEditor(chosenPalette: self.$chosenPalette, isShowing: self.$showPaletteEditor)
                        .frame(minWidth: 300, minHeight: 500)
                        .environmentObject(self.document)
                }
        }
        .fixedSize(horizontal: true, vertical: false)
    }
}


struct PaletteEditor: View {
    
    @Binding var chosenPalette: String
    @Binding var isShowing: Bool
    @EnvironmentObject var document: EmojiArtDocument
    @State private var paletteName: String = ""
    @State private var emojisToAdd: String = ""
    
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Palette Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.isShowing = false
                    }, label: {Text("Done")}).padding()
                }
            }
            
            Divider()
            Form {
                Section {
                    TextField("Pallete Name", text: $paletteName, onEditingChanged: { began in
                       if !began {
                           self.document.renamePalette(self.chosenPalette, to: self.paletteName)
                       }
                    })
    
                    TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                       if !began {
                           self.chosenPalette = self.document.addEmoji(self.emojisToAdd, toPalette: self.chosenPalette)
                           self.emojisToAdd = ""
                       }
                    })
                }
                
                Section(header: Text("Remove emoji")) {
                    Grid(chosenPalette.map {String($0)}, id: \.self) { emoji in
                        Text(emoji).font(.system(size: self.fontSize))
                                .onTapGesture {
                                    self.chosenPalette = self.document.removeEmoji(emoji, fromPalette: self.chosenPalette)
                                }
                            
                    }.frame(height: self.height)
                    
                }
            }
  
        }
        .onAppear {
            self.paletteName = self.document.paletteNames[self.chosenPalette] ?? ""
        }
    }
    
    var height: CGFloat {
        CGFloat((chosenPalette.count - 1) / 6) * 70 + 70
    }
    
    var fontSize: CGFloat = 35
}

















struct PaletteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser(document: EmojiArtDocument(), chosenPalette: .constant(EmojiArtDocument().defaultPalette))
    }
}
