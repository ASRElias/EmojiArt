//
//  ContentView.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 07/08/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    @ObservableObject var document: EmojiArtDocument
    
    var body: some View {
        Text("Hello, World!")
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiArtDocumentView()
    }
}
