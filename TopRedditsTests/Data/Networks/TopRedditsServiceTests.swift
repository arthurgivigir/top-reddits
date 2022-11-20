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
    let dataFromTopReddits = JsonHelper.dataFrom(.topReddits)
    var topRedditsRepository: TopRedditsRepository?
    
    override func setUpWithError() throws {
        let networkManager = NetworkManager(session: networkSession)
        let topRedditsService = DefaultTopRedditsService(networkManager: networkManager)
        topRedditsRepository = DefaultTopRedditsRepository(topRedditsService: topRedditsService)
    }

    func test_fecthTopReddits_success() throws {
        networkSession.data = dataFromTopReddits
        networkSession.error = nil
        
        let expectationFetch = expectation(description: "⚠️ Testing fecthTopReddits.....")
        
        topRedditsRepository?.fecthTopReddits { result in
            switch result {
            case .success(let topRedditsModel):
                XCTAssertNotNil(topRedditsModel, "✅ fecthTopReddits")
            case .failure(let error):
                XCTFail("⛔️ fecthTopReddits: \(error)")
            }
            expectationFetch.fulfill()
        }
        
        wait(for: [expectationFetch], timeout: 5.0)
    }
}
