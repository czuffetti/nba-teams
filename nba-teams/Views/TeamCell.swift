//
//  TeamCell.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import UIKit

class TeamCell: UITableViewCell {
    
    let teamName = UILabel()
    let teamLogo = UIImageView()
    let arrow = UIImageView()
    let teamDivision = UILabel()
    let teamCity = UILabel()
    let teamConference = UILabel()
    
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            // Set any attributes of your UI components here.
            teamName.translatesAutoresizingMaskIntoConstraints = false
            teamName.font = UIFont.boldSystemFont(ofSize: 20)
            teamDivision.translatesAutoresizingMaskIntoConstraints = false
            teamDivision.font = UIFont.systemFont(ofSize: 14)
            teamCity.translatesAutoresizingMaskIntoConstraints = false
            teamCity.font = UIFont.systemFont(ofSize: 14)
            teamConference.translatesAutoresizingMaskIntoConstraints = false
            teamConference.font = UIFont.systemFont(ofSize: 14)
            teamLogo.translatesAutoresizingMaskIntoConstraints = false
            teamLogo.contentMode = .scaleAspectFit
            arrow.translatesAutoresizingMaskIntoConstraints = false
            arrow.contentMode = .scaleAspectFit
            arrow.image = UIImage(named: "arrow")
            
            // Add the UI components
            contentView.addSubview(teamLogo)
            contentView.addSubview(teamName)
            contentView.addSubview(teamDivision)
            contentView.addSubview(teamCity)
            contentView.addSubview(teamConference)
            contentView.addSubview(arrow)
            
            NSLayoutConstraint.activate([
                teamLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                teamLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                teamLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                teamLogo.widthAnchor.constraint(equalToConstant: 50),
                teamName.leadingAnchor.constraint(equalTo: teamLogo.trailingAnchor, constant: 40),
                teamName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                teamName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
                teamCity.topAnchor.constraint(equalTo: teamName.topAnchor, constant: 30),
                teamCity.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                teamCity.leadingAnchor.constraint(equalTo: teamLogo.trailingAnchor, constant: 40),
                teamDivision.topAnchor.constraint(equalTo: teamCity.topAnchor, constant: 20),
                teamDivision.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                teamDivision.leadingAnchor.constraint(equalTo: teamLogo.trailingAnchor, constant: 40),
                teamConference.topAnchor.constraint(equalTo: teamDivision.topAnchor, constant: 20),
                teamConference.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                teamConference.leadingAnchor.constraint(equalTo: teamLogo.trailingAnchor, constant: 40),
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
