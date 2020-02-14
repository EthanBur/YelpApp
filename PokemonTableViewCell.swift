//
//  PokemonTableViewCell.swift
//  PokedexApp
//
//  Created by mcs on 1/31/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

class PokemonTableViewCell: UITableViewCell {
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var gameIndexLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var partyIcon: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var typeIcon: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var typeTwoIcon: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupView() {
        partyIcon.frame = CGRect(x: 0, y: 2.5, width: 70, height: 70)
        addSubview(partyIcon)
        addSubview(gameIndexLabel)
        addSubview(nameLabel)
        addSubview(typeIcon)
        addSubview(typeTwoIcon)

        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            partyIcon.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            partyIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            partyIcon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            gameIndexLabel.leadingAnchor.constraint(equalTo: partyIcon.trailingAnchor, constant: 40),
            gameIndexLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            gameIndexLabel.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 0),

            nameLabel.topAnchor.constraint(equalTo: gameIndexLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: partyIcon.trailingAnchor, constant: 40),

            typeIcon.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            typeIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            typeTwoIcon.topAnchor.constraint(equalTo: typeIcon.bottomAnchor, constant: 5),
            typeTwoIcon.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}

