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
    var searchedPlayers: [DatumPlayer] = []
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    override func viewDidLoad() {
        self.title = teamName + " - Players"
        spinner.startAnimating()
        tableView.backgroundView = spinner
        tableView.register(PlayerCell.self, forCellReuseIdentifier: "PlayerCell")
        tableView.rowHeight = 130
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Players"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        if (CachedPlayers == nil) {
            loadPlayersData()
        } else {
            guard let filteredPlayers = CachedPlayers?.data.filter({$0.team.id == self.teamId}).map({return $0}) else { return }
            guard let meta = CachedPlayers?.meta else { return }
            let tempPlayers = Players(data: filteredPlayers, meta: meta)
            self.players = nil
            self.players = tempPlayers
            self.searchedPlayers = tempPlayers.data
            self.tableView.reloadData()
        }
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
                CachedPlayers = Players(data: self.allPlayers, meta: meta)
                self.searchedPlayers = tempPlayers.data
                self.spinner.stopAnimating()
                self.tableView.reloadData()
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
        
        let player = searchedPlayers[indexPath.row]
        playerCell.playerName.text = player.firstName + " " + player.lastName
        var position = player.position.rawValue
        if position.isEmpty { position = "N/A" }
        playerCell.playerPosition.text = "Position: " + position
        playerCell.playerPhoto.image = UIImage(named: "player-icon")
      
      return playerCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchedPlayers.count
    }

    //
    // MARK: - Table View Delegate
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowPlayer", sender: tableView.cellForRow(at: indexPath))
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if(isSearchBarEmpty) {
            guard let p = players else { return }
            searchedPlayers = p.data
        } else {
            guard let filteredPlayers = self.players?.data.filter({$0.firstName.lowercased().contains(searchText.lowercased()) || $0.lastName.lowercased().contains(searchText.lowercased())}).map({return $0}) else { return }
            searchedPlayers = filteredPlayers
        }
        
        tableView.reloadData()
    }
}

extension PlayersViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
