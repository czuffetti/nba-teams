//
//  nba_teamsTests.swift
//  nba-teamsTests
//
//  Created by Carlo Zuffetti on 19/06/21.
//

import XCTest
@testable import nba_teams

class nba_teamsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testTeam() {
        let viewModel = Team(id: 1, abbreviation: "bs", city: "milano", conference: .east, division: .atlantic, fullName: "test team milano", name: "test team")
        XCTAssert(viewModel.id == 1)
    }
    
    func testEmptyTeams() {
        let data: [Datum] = []
        let meta: Meta = Meta(totalPages: 0, currentPage: 0, nextPage: 0, perPage: 0, totalCount: 0)
        let viewModel = Teams.init(data: data, meta: meta)
        XCTAssert(viewModel.data.count == 0)
    }
    
    func testPlayer() {
        let team = Team(id: 1, abbreviation: "bs", city: "milano", conference: .east, division: .atlantic, fullName: "test team milano", name: "test team")
        let viewModel = DatumPlayer.init(id: 1, firstName: "Carlo", heightFeet: nil, heightInches: nil, lastName: "Zuffetti", position: .empty, team: team, weightPounds: nil)
        
        XCTAssert(viewModel.id == 1)
        XCTAssert(viewModel.firstName == "Carlo")
    }
    
    func testEmptyPlayers() {
        let data: [DatumPlayer] = []
        let meta: Meta = Meta(totalPages: 0, currentPage: 0, nextPage: 0, perPage: 0, totalCount: 0)
        let viewModel = Players.init(data: data, meta: meta)
        XCTAssert(viewModel.data.count == 0)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
