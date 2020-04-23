//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by karlis.berzins on 23/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import XCTest

class HTTPClient {
  static let shared = HTTPClient()
  var requestedURL: URL?

  private init() {}
}

class RemoteFeedLoader {
  func load() {
    HTTPClient.shared.requestedURL = URL(string: "http://a-url.com")
  }
}

class RemoteFeedLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() {
    let client = HTTPClient.shared
    let _ = RemoteFeedLoader()

    XCTAssertNil(client.requestedURL)
  }

  func test_load_requestsDataFromURL() {
    let client = HTTPClient.shared
    let sut = RemoteFeedLoader()

    sut.load()

    XCTAssertNotNil(client.requestedURL)
  }
}
