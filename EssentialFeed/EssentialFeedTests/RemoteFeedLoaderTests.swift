//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by karlis.berzins on 23/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import XCTest

protocol HTTPClient {
  func get(from url: URL)
}

class RemoteFeedLoader {
  let client: HTTPClient

  init(client: HTTPClient) {
    self.client = client
  }

  func load() {
    client.get(from: URL(string: "http://a-url.com")!)
  }
}

class HTTPClientSpy: HTTPClient {
  var requestedURL: URL?

  func get(from url: URL) {
    requestedURL = url
  }
}

class RemoteFeedLoaderTests: XCTestCase {
  func test_init_doesNotRequestDataFromURL() {
    let client = HTTPClientSpy()
    let _ = RemoteFeedLoader(client: client)

    XCTAssertNil(client.requestedURL)
  }

  func test_load_requestsDataFromURL() {
    let client = HTTPClientSpy()
    let sut = RemoteFeedLoader(client: client)

    sut.load()

    XCTAssertNotNil(client.requestedURL)
  }
}
