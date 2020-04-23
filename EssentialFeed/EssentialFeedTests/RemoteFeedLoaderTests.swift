//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by karlis.berzins on 23/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import XCTest

class HTTPClient {
  var requestedURL: URL?
}

class RemoteFeedLoader {

}

class RemoteFeedLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() {
    let client = HTTPClient()
    let _ = RemoteFeedLoader()

    XCTAssertNil(client.requestedURL)
  }
}
