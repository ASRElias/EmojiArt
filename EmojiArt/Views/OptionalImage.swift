//
//  OptionalImage.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 13/08/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI

struct OptionalImage: View {
    
    var uiImage: UIImage?
    var body: some View {
        Group {
            if uiImage != nil {
                Image(uiImage: uiImage!)
            }
        }
    }
}

struct OptionalImage_Previews: PreviewProvider {
    static var previews: some View {
        OptionalImage()
    }
}
