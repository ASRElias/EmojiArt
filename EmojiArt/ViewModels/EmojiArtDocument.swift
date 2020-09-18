//
//  EmojiArtDocument.swift
//  EmojiArt
//
//  Created by Elias Santa Rosa on 07/08/20.
//  Copyright © 2020 Santa Rosa Digital. All rights reserved.
//

import SwiftUI
import Combine

class EmojiArtDocument: ObservableObject {
    
    static let pallete: String = "🐆🐉🌹⛈⛄️"

    private static let untitled: String = "EmojiArtDocument.Untitled"
    
    var emojis: [EmojiArt.Emoji] { emojiArt.emojis }
    
    var backgroundURL: URL? {
        get {
            emojiArt.backgroundURL
        }
        set {
            emojiArt.backgroundURL = newValue?.imageURL
            fetchBackgroundImageData()
        }
    }
    
    private var autosabeCancellable: AnyCancellable?
    
    private var fetchImageCancellable: AnyCancellable?
    
    @Published private var emojiArt: EmojiArt

    @Published private(set) var backgroundImage: UIImage?
    
    init() {
        emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: EmojiArtDocument.untitled)) ?? EmojiArt()
        autosabeCancellable = $emojiArt.sink { emojiArt in
            UserDefaults.standard.set(emojiArt.json, forKey: EmojiArtDocument.untitled)
        }
        fetchBackgroundImageData()
    }
    
    // MARK: - Intents
    
    func addEmoji(_ emoji: String, at location: CGPoint, size: CGFloat) {
        emojiArt.addEmoji(emoji, x: Int(location.x), y: Int(location.y), size: Int(size))
    }
    
    func moveEmoji(_ emoji: EmojiArt.Emoji, by offset: CGSize) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].x += Int(offset.width)
            emojiArt.emojis[index].y += Int(offset.height)
        }
    }
    
    func scaleEmoji(_ emoji: EmojiArt.Emoji, by scale: CGFloat) {
        if let index = emojiArt.emojis.firstIndex(matching: emoji) {
            emojiArt.emojis[index].size = Int((CGFloat(emojiArt.emojis[index].size) * scale).rounded(.toNearestOrEven))
        }
    }
    
    private func fetchBackgroundImageData() {
        backgroundImage = nil
        if let url = self.emojiArt.backgroundURL {
            fetchImageCancellable?.cancel()
            fetchImageCancellable = URLSession.shared.dataTaskPublisher(for: url)
                .map { data, urlResponse in UIImage(data: data) }
                .receive(on: DispatchQueue.main)
                .replaceError(with: nil)
                .assign(to: \.backgroundImage, on: self)
        }
    }
}


