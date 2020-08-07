//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 07/08/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import Foundation

struct EmojiArt {
    
    private var uniqueEmojiId: Int = 0
    
    var backgroundURL: URL?
    var emojis = [Emoji]()
    
    struct Emoji: Identifiable {
    
        let id: Int
        let text: String
        /// Offset from center
        var x: Int
        /// Offset from center
        var y: Int
        var size: Int
        
        fileprivate init(id: Int, text: String, x: Int, y: Int, size: Int) {
            self.id = id
            self.text = text
            self.x = x
            self.y = y
            self.size = size
        }

    }
    
    mutating func addEmoji(_ text: String, x: Int, y: Int, size: Int) {
        uniqueEmojiId += 1
        emojis.append(Emoji(id: uniqueEmojiId, text: text, x: x, y: y, size: size))

    }
    
}
