//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by karlis.berzins on 22/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import Foundation

public struct FeedItem: Equatable {
  let id: UUID
  let description: String?
  let location: String?
  let imageURL: URL
}
