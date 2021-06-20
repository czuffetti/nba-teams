//
//  NetworkError.swift
//  nba-teams
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import Foundation

//
// MARK: - Network Error
//
enum NetworkError: Error {
  //
  // MARK: - Cases
  //
  case dateParseError
  case invalidPath
  case parseError
  case requestError
  case networkError
}
