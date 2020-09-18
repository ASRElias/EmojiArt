//
//  EmojiArtDocumentView.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 07/08/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

struct EmojiArtDocumentView: View {
    
    @State private var chosenPalette: String = ""
    
    @State private var steadyStateZoomScale: CGFloat = 1.0
    
    @State private var steadyStatePanOffset: CGSize = .zero
    
    @GestureState private var gesturePanOffset: CGSize = .zero

    @GestureState private var gestureZoomScale: CGFloat = 1.0
    
    @ObservedObject var document: EmojiArtDocument
    
    private let defaultEmojiSize: CGFloat = 40
    
    private var zoomScale: CGFloat {
        steadyStateZoomScale * gestureZoomScale
    }
    
    private var panOffset: CGSize {
        (steadyStatePanOffset + gesturePanOffset) * zoomScale
    }
    
    var isLoading: Bool {
        document.backgroundURL != nil && document.backgroundImage == nil 
    }
    var body: some View {
        
        VStack {
            HStack {
                PaletteChooser(document: document, chosenPalette: $chosenPalette)
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(chosenPalette.map { String($0) }, id: \.self) { emoji in
                            Text(emoji)
                                .font(.system(size: self.defaultEmojiSize))
                                .onDrag { NSItemProvider(object: emoji as NSString) }
                        }
                    }
                }
                .onAppear {
                    self.chosenPalette = self.document.defaultPalette
                }
            }
            GeometryReader { geometry in
                ZStack {
                    Color.white.overlay(
                        OptionalImage(uiImage: self.document.backgroundImage)
                            .scaleEffect(self.zoomScale)
                    )
                        .gesture(self.doubleTapToZoom(in: geometry.size))
                    
                    if self.isLoading {
                        Image(systemName: "timer")
                            .imageScale(.large)
                            .spinning()
                    } else {
                        ForEach(self.document.emojis) { emoji in
                            Text(emoji.text)
                                .font(animatableWithSize: emoji.fontSize * self.zoomScale)
                                .position(self.position(for: emoji, in: geometry.size))
                        }
                    }
                }
                .clipped()
                .gesture(self.panGesture())
                .gesture(self.zoomGesture())
                .edgesIgnoringSafeArea([.horizontal, .bottom])
                .onReceive(self.document.$backgroundImage) { image in
                    self.zoomToFit(image, in: geometry.size)
                }
                .onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
                    var location = geometry.convert(location, from: .global)
                    location = CGPoint(x: location.x  - geometry.size.width / 2, y: location.y - geometry.size.height / 2)
                    location = CGPoint(x: location.x / self.zoomScale, y: location.y / self.zoomScale)
                    return self.drop(providers: providers, at: location)
                }
            }
        }
        
    }
    
    private func doubleTapToZoom(in size: CGSize) -> some Gesture {
        
        TapGesture(count: 2)
            .onEnded {
                withAnimation {
                    self.zoomToFit(self.document.backgroundImage, in: size)
                }
        }
        
    }
    
    private func panGesture() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, transaction in
                gesturePanOffset = latestDragGestureValue.translation / self.zoomScale
        }
        .onEnded { finalDragGestureValue in
            self.steadyStatePanOffset = self.steadyStatePanOffset + (finalDragGestureValue.translation / self.zoomScale)
        }
    }
    
    private func zoomGesture() -> some Gesture {
        
        MagnificationGesture()
            .updating($gestureZoomScale) { latestGestureScale, ourGestureStateInOut, transaction in
                ourGestureStateInOut = latestGestureScale
        }
        .onEnded { finalGestureScale in
            self.steadyStateZoomScale *= finalGestureScale
        }
        
    }
    
    private func position(for emoji: EmojiArt.Emoji, in size: CGSize) -> CGPoint {
        
        var location = emoji.location
        location = CGPoint(x: location.x * zoomScale, y: location.y * zoomScale)
        location = CGPoint(x: location.x + size.width / 2, y: location.y + size.height / 2)
        return location
        
    }
    
    private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
        
        var found = providers.loadFirstObject(ofType: URL.self) { url in
            self.document.backgroundURL = url
        }
        if !found {
            found = providers.loadObjects(ofType: String.self) { string in
                self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
            }
        }
        return found
        
    }
    
    private func zoomToFit(_ image: UIImage?, in size: CGSize) {
        
        if let image = image, image.size.width > 0, image.size.height > 0 {
            let hZoom = size.width / image.size.width
            let vZoom = size.height / image.size.height
            self.steadyStateZoomScale = min(hZoom, vZoom)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        EmojiArtDocumentView(document: EmojiArtDocument())
    }
    
}
