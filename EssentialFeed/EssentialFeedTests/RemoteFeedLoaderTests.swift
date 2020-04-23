//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by karlis.berzins on 23/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import XCTest

class HTTPClient {
  static var shared = HTTPClient()

  func get(from url: URL) {}
}

class RemoteFeedLoader {
  func load() {
    HTTPClient.shared.get(from: URL(string: "http://a-url.com")!)
  }
}

class HTTPClientSpy: HTTPClient {
  var requestedURL: URL?

  override func get(from url: URL) {
    requestedURL = url
  }
}

class RemoteFeedLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() {
    let client = HTTPClientSpy()
    HTTPClient.shared = client
    let _ = RemoteFeedLoader()

    XCTAssertNil(client.requestedURL)
  }

  func test_load_requestsDataFromURL() {
    let client = HTTPClientSpy()
    HTTPClient.shared = client
    let sut = RemoteFeedLoader()

    sut.load()

    XCTAssertNotNil(client.requestedURL)
  }
}
