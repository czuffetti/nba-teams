//
//  PlayerCell.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import UIKit

class PlayerCell: UITableViewCell {
    
    let playerName = UILabel()
    let playerPhoto = UIImageView()
    let arrow = UIImageView()
    let playerPosition = UILabel()
    
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            // Set any attributes of your UI components here.
            playerName.translatesAutoresizingMaskIntoConstraints = false
            playerName.font = UIFont.boldSystemFont(ofSize: 20)
            playerName.text = playerName.text?.uppercased()
            playerPosition.translatesAutoresizingMaskIntoConstraints = false
            playerPosition.font = UIFont.systemFont(ofSize: 14)
            playerPhoto.translatesAutoresizingMaskIntoConstraints = false
            playerPhoto.contentMode = .scaleAspectFit
            arrow.translatesAutoresizingMaskIntoConstraints = false
            arrow.contentMode = .scaleAspectFit
            arrow.image = UIImage(named: "arrow")
            
            // Add the UI components
            contentView.addSubview(playerName)
            contentView.addSubview(playerPosition)
            contentView.addSubview(playerPhoto)
            contentView.addSubview(arrow)
            
            NSLayoutConstraint.activate([
                playerPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                playerPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                playerPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                playerPhoto.widthAnchor.constraint(equalToConstant: 50),
                playerName.leadingAnchor.constraint(equalTo: playerPhoto.trailingAnchor, constant: 40),
                playerName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                playerName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
                playerPosition.topAnchor.constraint(equalTo: playerName.topAnchor, constant: 30),
                playerPosition.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                playerPosition.leadingAnchor.constraint(equalTo: playerPhoto.trailingAnchor, constant: 40),
                arrow.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
                arrow.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                arrow.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                arrow.widthAnchor.constraint(equalToConstant: 30)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
