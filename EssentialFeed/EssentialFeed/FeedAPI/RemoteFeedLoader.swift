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
      case let .success((data, response)):
        do {
          let items = try FeedItemsMapper.map(data, response: response)
          completion(.success(items))
        } catch {
          completion(.failure(.invalidData))
        }
      case .failure:
        completion(.failure(.connectivity))
      }
    }
  }
}

private class FeedItemsMapper {
  private struct Root: Decodable {
    var items: [Item]
  }

  private struct Item: Decodable {
    let id: UUID
    let description: String?
    let location: String?
    let image: URL

    var item: FeedItem {
      return FeedItem(id: id, description: description, location: location, imageURL: image)
    }
  }

  static var OK_200: Int {  return 200 }

  static func map(_ data: Data, response: HTTPURLResponse) throws -> [FeedItem] {
    guard response.statusCode == OK_200 else {
      throw RemoteFeedLoader.Error.invalidData
    }

    let root = try JSONDecoder().decode(Root.self, from: data)
    return root.items.map { $0.item }
  }
}
