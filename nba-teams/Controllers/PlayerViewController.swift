//
//  PlayerViewController.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 20/06/21.
//

import UIKit

//
// MARK: - Player View Controller
//

class PlayerViewController: UIViewController {
    
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var position: UILabel!
    
    var player: DatumPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let player = player else { return }
        self.title = player.firstName + " " + player.lastName
        firstName.text = player.firstName.uppercased()
        lastName.text = player.lastName.uppercased()
        height.text = "\(player.heightInches?.description ?? "N/A")"
        weight.text = "\(player.weightPounds?.description ?? "N/A")"
        
        if(player.position.rawValue == "") {
            position.text = "N/A"
        } else {
            position.text = "\(player.position.rawValue)"
        }
    }
}
