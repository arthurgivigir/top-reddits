//
//  TopRedditsServiceTests.swift
//  TopRedditsTests
//
//  Created by Arthur Givigir on 19/11/22.
//

import XCTest
@testable import TopReddits

final class TopRedditsServiceTests: XCTestCase {
    
    let networkSession = NetworkSessionMock()
    let jsonFromTopReddits = DataToJson.jsonFrom(.topReddits)
    var topRedditsRepository: TopRedditsRepository?
    
    override func setUpWithError() throws {
        let networkManager = NetworkManager(session: networkSession)
        let topRedditsService = DefaultTopRedditsService(networkManager: networkManager)
        topRedditsRepository = DefaultTopRedditsRepository(topRedditsService: topRedditsService)
    }

    func test_fecthTopReddits_success() throws {
        networkSession.data = jsonFromTopReddits
        networkSession.error = nil
        
        topRedditsRepository?.fecthTopReddits { result in
            switch result {
            case .success(let success):
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }

}
