//
//  PalleteChooser.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 18/09/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

struct PaletteChooser: View {

    @ObservedObject var document: EmojiArtDocument
    
    @Binding var chosenPalette: String

    var body: some View {
        HStack {
            Stepper(onIncrement: {
                self.chosenPalette = self.document.palette(after: self.chosenPalette)
            }, onDecrement: {
                self.chosenPalette = self.document.palette(before: self.chosenPalette)
            }, label: {
                EmptyView()
            })
            Text(self.document.paletteNames[self.chosenPalette] ?? "")
        }
        .fixedSize(horizontal: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/, vertical: false)
    }
}

struct PalleteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser(document: EmojiArtDocument(), chosenPalette: Binding.constant(""))
    }
}
