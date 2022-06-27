//
//  PhotoCollectionViewCell.swift
//  Product Page Practice
//
//  Created by Nodirbek on 27/06/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let id = "PhotoCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    func configure(with image: UIImage){
        imageView.image = image
    }
}
