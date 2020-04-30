//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by karlis.berzins on 22/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedItem], Error>

protocol FeedLoader {
  func load(completion: @escaping (LoadFeedResult) -> Void)
}
