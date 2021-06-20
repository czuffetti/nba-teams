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
    
    override func viewDidLoad() {
        self.title = "Teams"
        spinner.startAnimating()
        tableView.backgroundView = spinner
        tableView.register(TeamCell.self, forCellReuseIdentifier: "TeamCell")
        tableView.rowHeight = 130
        let ws = WebServices()
        ws.loadTeamsData { (teams, success) in
          if success == true {
            self.teams  = teams
            self.spinner.stopAnimating()
          }
        }
    }
  
  //
  // MARK: - View Controller
  //
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    super.prepare(for: segue, sender: sender)
    
    if
      segue.identifier == "ShowPlayers",
      let playersViewController = segue.destination as? PlayersViewController,
      let teamCell = sender as? TeamCell,
      let row = tableView.indexPath(for: teamCell)?.row,
        let teams = teams
    {
        let team = teams.data[row]
      
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
      
      if let team = teams?.data[indexPath.row] {
        teamCell.teamName.text = team.name
        teamCell.teamDivision.text = "Division: \(team.division)"
        teamCell.teamCity.text = "City: \(team.city)"
        teamCell.teamConference.text = "Conference: \(team.conference)"
        teamCell.teamLogo.image = UIImage(named: team.abbreviation)
      }
      
      return teamCell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return teams?.data.count ?? 0
    }

    //
    // MARK: - Table View Delegate
    //
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowPlayers", sender: tableView.cellForRow(at: indexPath))
    }
}
