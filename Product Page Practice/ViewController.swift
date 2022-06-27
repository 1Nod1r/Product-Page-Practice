//
//  ViewController.swift
//  Product Page Practice
//
//  Created by Nodirbek on 27/06/22.
//

import UIKit

struct TextCellViewModel {
    let text: String
    let font: UIFont
}

enum SectionTypes {
    case productPhotos(images: [UIImage])
    case productInfo(viewModels: [TextCellViewModel])
    case relatedProducts(viewModels: [RelatedProductTableViewCellViewModel])
    
    var title: String? {
        switch self {
        case .relatedProducts:
            return "Related Products"
        default:
            return nil
        }
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PhotoCarouselTableViewCell.self, forCellReuseIdentifier: PhotoCarouselTableViewCell.id)
        tableView.register(RelatedProductTableViewCell.self, forCellReuseIdentifier: RelatedProductTableViewCell.id)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private var sections = [SectionTypes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        sections.append(.productPhotos(images: [
            UIImage(named: "photo1"),
            UIImage(named: "photo2"),
            UIImage(named: "photo3"),
            UIImage(named: "photo4")
        ].compactMap({ $0 })))
        sections.append(.productInfo(viewModels: [
            .init(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took ",
                  font: .systemFont(ofSize: 18)),
            .init(text: "Price: $49.99 ",
                  font: .systemFont(ofSize: 22))
        ]))
        sections.append(.relatedProducts(viewModels: [
            .init(image: UIImage(named: "photo2"),
                  title: "Essential 1"),
            .init(image: UIImage(named: "photo1"),
                  title: "Essential 2"),
            .init(image: UIImage(named: "photo3"),
                  title: "Essential 3"),
            .init(image: UIImage(named: "photo4"),
                  title: "Essential 4")
        ]))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = sections[section]
        switch sectionType {
        case .productPhotos:
            return 1
        case .productInfo(let viewModels):
            return viewModels.count
        case .relatedProducts(let viewModels):
            return viewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = sections[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .productPhotos(let images):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoCarouselTableViewCell.id, for: indexPath) as? PhotoCarouselTableViewCell else { return UITableViewCell() }
            cell.configure(with: images)
            return cell
        case .productInfo(let viewModels):
            let viewModel = viewModels[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.configure(with: viewModel)
            return cell
        case.relatedProducts(let viewModels):
            let viewModel = viewModels[indexPath.row]
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RelatedProductTableViewCell.id, for: indexPath) as? RelatedProductTableViewCell else { return UITableViewCell() }
            cell.configure(with: viewModels[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .productPhotos:
            return view.frame.size.width
        case .relatedProducts:
            return 150
        case .productInfo:
            UITableView.automaticDimension
        }
        return UITableView.automaticDimension
    }
    
}


extension UITableViewCell {
    func configure(with viewModel: TextCellViewModel){
        textLabel?.text = viewModel.text
        textLabel?.numberOfLines = 0
        textLabel?.font = viewModel.font
    }
}
