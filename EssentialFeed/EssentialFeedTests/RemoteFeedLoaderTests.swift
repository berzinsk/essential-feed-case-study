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
  let url: URL
  let client: HTTPClient

  init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }

  func load() {
    client.get(from: url)
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
    let url = URL(string: "http://a-url.com")!
    let client = HTTPClientSpy()
    let _ = RemoteFeedLoader(url: url, client: client)

    XCTAssertNil(client.requestedURL)
  }

  func test_load_requestsDataFromURL() {
    let url = URL(string: "http://a-given-url.com")!
    let client = HTTPClientSpy()
    let sut = RemoteFeedLoader(url: url, client: client)

    sut.load()

    XCTAssertEqual(client.requestedURL, url)
  }
}
