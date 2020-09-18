//
//  View+Extensions.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 18/09/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

extension View {

    func font(animatableWithSize size: CGFloat, weight: Font.Weight = .regular, design: Font.Design = .default) -> some View {
        self.modifier(AnimatableSystemFontModifier(size: size, weight: weight, design: design))
    }
    
    func spinning() -> some View {
        self.modifier(Spinning())
    }
}


