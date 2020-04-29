//
//  FeedItemsMapper.swift
//  EssentialFeed
//
//  Created by karlis.berzins on 29/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import Foundation

final class FeedItemsMapper {
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

  private static var OK_200: Int {  return 200 }

  static func map(_ data: Data, response: HTTPURLResponse) throws -> [FeedItem] {
    guard response.statusCode == OK_200 else {
      throw RemoteFeedLoader.Error.invalidData
    }

    let root = try JSONDecoder().decode(Root.self, from: data)
    return root.items.map { $0.item }
  }
}
