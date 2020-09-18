//
//  EmojiArt.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 07/08/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import Foundation

struct EmojiArt: Codable {
    
    private var uniqueEmojiId: Int = 0
    
    var backgroundURL: URL?
    var emojis = [Emoji]()
    var json: Data?  {
        return try? JSONEncoder().encode(self)
    }
    
    init?(json: Data?) {
        if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!) {
            self = newEmojiArt
        } else {
            return nil
        }
    }
    
    init() { }
    
    struct Emoji: Identifiable, Codable, Hashable {
    
        let id: Int
        let text: String
        var x: Int
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
