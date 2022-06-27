//
//  RelatedProductTableViewCellViewModel.swift
//  Product Page Practice
//
//  Created by Nodirbek on 27/06/22.
//

import UIKit

struct RelatedProductTableViewCellViewModel {
    let image: UIImage?
    let title: String
}

class RelatedProductTableViewCell : UITableViewCell {
    
    static let id = "RelatedProductTableViewCell"
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(productImageView)
        contentView.addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.frame.size.height
        productImageView.frame = CGRect(
            x: 5,
            y: 0,
            width: imageSize,
            height: imageSize)
        label.frame = CGRect(
            x: 15 + imageSize,
            y: 0,
            width: contentView.frame.size.width - 20 - imageSize,
            height: imageSize)
    }
    
    func configure(with viewModel: RelatedProductTableViewCellViewModel) {
        label.text = viewModel.title
        productImageView.image = viewModel.image
    }
}
