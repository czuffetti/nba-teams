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
  
    override func viewDidLoad() {
        WebServices.loadTeamsData { (teams, success) in
          if success == true {
            self.teams  = teams
          }
        }
    }
    
  //
  // MARK: - Variables And Properties
  //
  var teams: Teams? {
    didSet {
      if isViewLoaded {
        tableView.reloadData()
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
      let teamCell = tableView.dequeueReusableCell(withIdentifier: "TeamCell", for: indexPath)
      
      if let team = teams?.data[indexPath.row] {
        teamCell.textLabel?.text = team.fullName
        teamCell.detailTextLabel?.text = "\(team.division)"
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
    }
}
