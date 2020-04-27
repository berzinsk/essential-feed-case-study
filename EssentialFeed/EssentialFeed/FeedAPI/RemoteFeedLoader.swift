//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by karlis.berzins on 27/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import Foundation

public protocol HTTPClient {
  func get(from url: URL)
}

public final class RemoteFeedLoader {
  private let url: URL
  private let client: HTTPClient

  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }

  public func load() {
    client.get(from: url)
  }
}
