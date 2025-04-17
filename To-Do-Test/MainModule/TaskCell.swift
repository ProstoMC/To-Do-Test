//
//  TaskCell.swift
//  To-Do-Test
//
//  Created by admin on 01.04.25.
//

import UIKit

class TaskCell: UITableViewCell {
    let checkImageView = UIImageView()
    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    let dateLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    func configure(title: String, subtitle: String, date: String, isDone: Bool = false) {
        titleLabel.text = title
        if isDone {
            //Prepare image
            checkImageView.image = UIImage(systemName: "checkmark.circle")
            checkImageView.tintColor = .systemYellow
            
            //Prepare texts
            titleLabel.attributedText = NSAttributedString(
                string: title,
                attributes: [
                    .foregroundColor: UIColor.stroke,
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .strikethroughColor: UIColor.stroke
                ]
            )
            subtitleLabel.text = subtitle
            subtitleLabel.textColor = UIColor.stroke
        }
        else {
            checkImageView.image = UIImage(systemName: "circle")
            checkImageView.tintColor = .gray
            //Prepare texts
            titleLabel.attributedText = NSAttributedString(
                string: title,
                attributes: [
                    .foregroundColor: UIColor.text,
                    .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                    .strikethroughColor: UIColor.gray.withAlphaComponent(0)
                ]
            )
            subtitleLabel.text = subtitle
        }
        
        dateLabel.text = date
    }
    
}

extension TaskCell {
    private func setupUI() {
        contentView.backgroundColor = .background
        setupImage()
        setupTitle()
        setupSubtitle()
        setupDate()
    }
    
    private func setupImage() {
        checkImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(checkImageView)
        
        NSLayoutConstraint.activate([
            checkImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            checkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            checkImageView.heightAnchor.constraint(equalToConstant: 30),
            checkImageView.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    private func setupTitle() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
        titleLabel.textColor = .text
        titleLabel.font = .systemFont(ofSize: 20)
        

        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: checkImageView.trailingAnchor, constant: 8),
            titleLabel.centerYAnchor.constraint(equalTo: checkImageView.centerYAnchor),
            titleLabel.heightAnchor.constraint(equalTo:checkImageView.heightAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    private func setupSubtitle() {
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(subtitleLabel)
        subtitleLabel.textColor = .text
        
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.numberOfLines = 2
        subtitleLabel.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50),
            subtitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 1)
        ])
    }
    
    private func setupDate() {
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dateLabel)
        dateLabel.textColor = .gray
        
        dateLabel.font = .systemFont(ofSize: 12)
        dateLabel.numberOfLines = 2
        dateLabel.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 1),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 20),
            dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
