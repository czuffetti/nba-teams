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
  func loadTeamsData(completionHandler: @escaping (Teams?, Bool?) -> Void) {
    Network.loadJSONFile(named: .teams, type: Teams.self) { (teams, error) in
      guard error == nil else {
        completionHandler(nil, false)
        return
      }
        
        completionHandler(teams, true)
      }
    }
    
    var allPlayers: [DatumPlayer] = []
    var meta: Meta?
    var page: Int = 0
    
    func loadPlayersData(completionHandler: @escaping (Players?, Bool?, Bool?) -> Void) {
        //loadsPlayers()

        Network.loadJSONFile(named: .players, page: page, type: Players.self) { (players, error) in
          guard error == nil else {
            return
          }
            guard let p = players?.data else {
                return
            }
            
            self.allPlayers.append(contentsOf: p)
            
            guard let m = players?.meta else {
                return
            }
            
            var more: Bool = false
            
            if(m.nextPage?.hashValue != nil) {
                self.page += 1
                more = true
            } else {
                more = false
                self.meta = m
            }
            
            completionHandler(players, true, more)
            
            /*if(m.nextPage?.hashValue != nil) {
                self.page += 1
                self.loadsPlayers()
            } else {
                self.meta = m
            }*/
        }
      }
    
    private func loadsPlayers() {
        Network.loadJSONFile(named: .players, page: page, type: Players.self) { (players, error) in
          guard error == nil else {
            return
          }
            guard let p = players?.data else {
                return
            }
            
            self.allPlayers.append(contentsOf: p)
            
            guard let m = players?.meta else {
                return
            }
            
            self.page += 1
            self.meta = m
            
            /*if(m.nextPage?.hashValue != nil) {
                self.page += 1
                self.loadsPlayers()
            } else {
                self.meta = m
            }*/
        }
    }
  }
