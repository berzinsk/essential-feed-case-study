//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by karlis.berzins on 29/04/2020.
//  Copyright © 2020 berzinsk. All rights reserved.
//

import Foundation

public typealias HTTPClientResult = Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
  func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}
