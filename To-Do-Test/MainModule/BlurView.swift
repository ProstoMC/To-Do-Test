//
//  BlurView.swift
//  To-Do-Test
//
//  Created by admin on 16.04.25.
//

import UIKit


class BlurView: UIViewController {
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let dateLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .gray
 
        
    }

    func configure(with cellData: MainCellContent) {
        titleLabel.text = cellData.title
        subtitleLabel.text = cellData.body
        dateLabel.text = cellData.date
    }

}

extension BlurView {
    private func setupUI() {
        self.preferredContentSize = CGSize(width: UIScreen.main.bounds.width*0.9, height: 120)
        
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        
        setupTitle()
        setupSubtitle()
        setupDate()
    }
    
    
    
    private func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        titleLabel.textColor = .text
        titleLabel.font = .systemFont(ofSize: 20)
        

        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        ])
    }
    private func setupSubtitle() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)
        subtitleLabel.textColor = .text
        
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupDate() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(dateLabel)
        dateLabel.textColor = .gray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.numberOfLines = 2
        dateLabel.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
