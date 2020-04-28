//
//  RemoteFeedLoader.swift
//  EssentialFeed
//
//  Created by karlis.berzins on 27/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
  func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public final class RemoteFeedLoader {
  private let url: URL
  private let client: HTTPClient

  public typealias Result = Swift.Result<[FeedItem], Error>

  public enum Error: Swift.Error {
    case connectivity
    case invalidData
  }

  public init(url: URL, client: HTTPClient) {
    self.url = url
    self.client = client
  }

  public func load(completion: @escaping (Result) -> ()) {
    client.get(from: url) { result in
      switch result {
      case let .success((data, _)):
        if let _ = try? JSONSerialization.jsonObject(with: data) {
          completion(.success([]))
        } else {
          completion(.failure(.invalidData))
        }
      case .failure:
        completion(.failure(.connectivity))
      }
    }
  }
}
