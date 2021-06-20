//
//  TeamsViewController.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import UIKit

//
// MARK: - Teams View Controller
//
class TeamsViewController: UITableViewController {
  
    //
    // MARK: - Variables And Properties
    //

    let spinner = UIActivityIndicatorView(style: .large)
    var teams: Teams? {
      didSet {
        if isViewLoaded {
          tableView.reloadData()
        }
      }
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchedTeams: [Datum] = []
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    override func viewDidLoad() {
        self.title = "Teams"
        spinner.startAnimating()
        tableView.backgroundView = spinner
        tableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
        tableView.rowHeight = 130
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Teams"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        let ws = WebServices()
        ws.loadTeamsData { (teams, success) in
          if success == true {
            self.teams  = teams
            guard let t = teams else { return }
            self.searchedTeams = t.data
            self.tableView.reloadData()
            self.spinner.stopAnimating()
          } else {
            self.displayError()
          }
        }
    }
  
  //
  // MARK: - View Controller
  //
    
    private func displayError() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
            let alert = UIAlertController(title: "Error", message: "Network connection is required", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
    }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    if
      segue.identifier == "ShowPlayers",
      let playersViewController = segue.destination as? PlayersViewController,
      let teamCell = sender as? TeamCell,
      let row = tableView.indexPath(for: teamCell)?.row
    {
        let teams = searchedTeams
        let team = teams[row]
      
        let teamId = team.id
        playersViewController.teamId = teamId
        playersViewController.teamName = team.name
    }
  }
    
    //
    // MARK: - Table View Data Source
    //
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let teamCell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath) as! TeamCell
      
      let team = searchedTeams[indexPath.row]
      teamCell.teamName.text = team.name
      teamCell.teamDivision.text = "Division: \(team.division)"
      teamCell.teamCity.text = "City: \(team.city)"
      teamCell.teamConference.text = "Conference: \(team.conference)"
      teamCell.teamLogo.image = UIImage(named: team.abbreviation)
      
      return teamCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return searchedTeams.count
    }

    //
    // MARK: - Table View Delegate
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowPlayers", sender: tableView.cellForRow(at: indexPath))
    }
    
    func filterContentForSearchText(_ searchText: String) {
        if(isSearchBarEmpty) {
            guard let t = teams else { return }
            searchedTeams = t.data
        } else {
            guard let filteredTeams = self.teams?.data.filter({$0.name.lowercased().contains(searchText.lowercased())}).map({return $0}) else { return }
            searchedTeams = filteredTeams
        }
        
        tableView.reloadData()
    }
}

extension TeamsViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
