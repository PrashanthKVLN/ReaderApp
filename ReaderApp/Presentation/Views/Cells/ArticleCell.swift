//
//  ArticleCell.swift
//  ReaderApp
//
//  Created by Prashanth on 19/10/25.
//

import UIKit

class ArticleCell: UITableViewCell {
    
    @IBOutlet private weak var thumbNailImage: UIImageView!
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var author: UILabel!
    
    @IBOutlet weak var bookmarkButton: UIButton!
    
    var onBookmarkTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        thumbNailImage.clipsToBounds = true
        thumbNailImage.layer.cornerRadius = 6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func configure(with article: Article, isBookmarked: Bool) {
        ImageLoader.shared.load(into: thumbNailImage, from: article.urlToImage)
        title.text = article.title
        author.text = article.author
        updateBookmarkIcon(isBookmarked: isBookmarked)
    }
    
    @IBAction func bookmarkButtonTapped(_ sender: UIButton) {
        onBookmarkTapped?()
    }
}

private extension ArticleCell {
    func updateBookmarkIcon(isBookmarked: Bool) {
        let iconName = isBookmarked ? "star.fill" : "star"
        bookmarkButton.setImage(UIImage(systemName: iconName), for: .normal)
        bookmarkButton.tintColor = .systemYellow
    }
}
