//
//  TopRedditsModelTests.swift
//  TopRedditsTests
//
//  Created by Arthur Givigir on 20/11/22.
//

import XCTest
@testable import TopReddits

final class TopRedditsModelTests: XCTestCase {
    var topRedditsModel: TopRedditsModel!

    override func setUpWithError() throws {
        topRedditsModel = JsonHelper.objectFrom(.topReddits)
    }

    func test_toEntityFromModel_success() throws {
        let entities: [RedditMessage] = topRedditsModel.toEntity
        let messages = topRedditsModel.data.reddits
        
        XCTAssertEqual(entities.count, messages.count)
        
        for (offset, message) in messages.enumerated() {
            let data = message.message
            XCTAssertEqual(entities[offset].title, data.title)
            XCTAssertEqual(entities[offset].subredditName, data.subredditName)
            XCTAssertEqual(entities[offset].created, data.created)
            XCTAssertEqual(entities[offset].text, data.text)
            XCTAssertEqual(entities[offset].thumbnailWidth, data.thumbnailWidth)
            XCTAssertEqual(entities[offset].thumbnailHeight, data.thumbnailHeight)
            XCTAssertEqual(entities[offset].thumbnail, data.thumbnail)
            XCTAssertEqual(entities[offset].author, data.author)
        }
    }
}
