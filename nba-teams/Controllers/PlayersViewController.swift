//
//  PlayersViewController.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import UIKit

//
// MARK: - Players View Controller
//
class PlayersViewController: UITableViewController {
  
    //
    // MARK: - Variables And Properties
    //
    let ws = WebServices()
    var players: Players? {
        didSet {
          if isViewLoaded {
            tableView.reloadData()
          }
        }
      }
    var allPlayers: [DatumPlayer] = []
    var teamId: Int?
    var teamName: String = ""
    let spinner = UIActivityIndicatorView(style: .large)
    
    
    override func viewDidLoad() {
        self.title = teamName + " - Players"
        spinner.startAnimating()
        tableView.backgroundView = spinner
        tableView.register(PlayerCell.self, forCellReuseIdentifier: "PlayerCell")
        tableView.rowHeight = 130
        loadPlayersData()
    }
    
    private func loadPlayersData() {
        ws.loadPlayersData { (players, success, more) in
            if success == true && more == true {
                guard let data = players?.data else { return }
                self.allPlayers.append(contentsOf: data)
                self.loadPlayersData()
            } else if success == true && more == false {
                guard let data = players?.data else { return }
                guard let meta = players?.meta else { return }
                self.allPlayers.append(contentsOf: data)
                let filteredPlayers = self.allPlayers.filter({$0.team.id == self.teamId}).map({return $0})
                let tempPlayers = Players(data: filteredPlayers, meta: meta)
                self.players = tempPlayers
                self.spinner.stopAnimating()
            }
        }
    }
  
  //
  // MARK: - View Controller
  //
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    /*if
      segue.identifier == "ShowAttendeeDetails",
      let detailViewController = segue.destination as? DetailViewController,
      let attendeeCell = sender as? UITableViewCell,
      let row = tableView.indexPath(for: attendeeCell)?.row,
      let teams = teams
    {
        let team = teams.data[row]
      
        var detailsString = team.fullName
      
      detailViewController.details = detailsString
    }*/
  }
    
    //
    // MARK: - Table View Data Source
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let playerCell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        
      if let player = players?.data[indexPath.row] {
        playerCell.playerName.text = player.firstName + " " + player.lastName
        var position = player.position.rawValue
        if position.isEmpty { position = "N/A" }
        playerCell.playerPosition.text = "Position: " + position
      }
      
      return playerCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.players?.data.count ?? 0
    }

    //
    // MARK: - Table View Delegate
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
    }
}
