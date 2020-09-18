//
//  Spinning.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 18/09/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

struct Spinning: ViewModifier {
    
    @State var isVisible = false
    
    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: isVisible ? 360 : 0))
            .animation(Animation.linear(duration: 1).repeatForever(autoreverses: false))
            .onAppear { self.isVisible = true }
    }
}

