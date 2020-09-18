//
//  PalleteChooser.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 18/09/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

struct PaletteChooser: View {
    var body: some View {
        HStack {
            Stepper(
                onIncrement: /*@START_MENU_TOKEN@*/{ }/*@END_MENU_TOKEN@*/,
                onDecrement: /*@START_MENU_TOKEN@*/{  }/*@END_MENU_TOKEN@*/,
                label: {
                    Text("Choose Palette")
                })
            Text("Palette Name")
        }
    }
}

struct PalleteChooser_Previews: PreviewProvider {
    static var previews: some View {
        PaletteChooser()
    }
}
