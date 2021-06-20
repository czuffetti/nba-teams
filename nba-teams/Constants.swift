//
//  Constants.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import Foundation

//
// MARK: - Constants
//

var CachedPlayers: Players?

struct Constants {
  //
  // MARK: - Date Formatters
  //
  struct DateFormatters {
    static let simpleDateFormatter: DateFormatter = {
      var dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      return dateFormatter
    }()
  }
    //
    // MARK: - EndpointData
    //
    struct EndpointData {
        let baseUrl: String = "https://free-nba.p.rapidapi.com/"
        let apiHostKey: String = "x-rapidapi-host"
        let apiHostValue: String = "free-nba.p.rapidapi.com"
        let apiKeyKey: String = "x-rapidapi-key"
        let apiKeyValue: String = "bf4986b7f6msh81554ae6a1ae7a0p11ab0djsn8fe930c453d2"
    }
}
