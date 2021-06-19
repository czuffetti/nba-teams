//
//  WebServices.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import Foundation

class WebServices {
  //
  // MARK: - Class Methods
  //
  static func loadTeamsData(completionHandler: @escaping (Teams?, Bool?) -> Void) {
    Network.loadJSONFile(named: .teams, type: Teams.self) { (teams, error) in
      guard error == nil else {
        completionHandler(nil, false)
        return
      }
        
        completionHandler(teams, true)
      }
    }
  }
