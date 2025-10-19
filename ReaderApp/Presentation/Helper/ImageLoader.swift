//
//  ImageLoader.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import UIKit
import SDWebImage

final class ImageLoader {
    
    static let shared = ImageLoader()
    private init() {}
    
    func load(
        into imageView: UIImageView,
        from urlString: String?
    ) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            imageView.image = nil
            imageView.backgroundColor = .systemGray5 // fallback background
            return
        }
        
        imageView.sd_setImage(
            with: url,
            placeholderImage: nil,
            options: [.retryFailed, .continueInBackground]
        ) { image, error, _, _ in
            if let error = error {
                print("❌ Failed to load image: \(error.localizedDescription)")
                imageView.backgroundColor = .systemGray5
            } else {
                print("🟢 Loaded image from: \(urlString)")
                imageView.backgroundColor = .clear
            }
        }
    }
}

