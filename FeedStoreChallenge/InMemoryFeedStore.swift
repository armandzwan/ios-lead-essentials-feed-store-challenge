//
//  InMemoryFeedStore.swift
//  FeedStoreChallenge
//
//  Created by armand on 30/10/2020.
//  Copyright © 2020 Essential Developer. All rights reserved.
//

import Foundation

public class InMemoryFeedStore: FeedStore {
    private struct Cache {
        let feedItems: [LocalFeedImage]
        let timestamp: Date
    }
    
    public init() {
        
    }
    
    private var localStore: [Cache] = []
    
    public func deleteCachedFeed(completion: @escaping DeletionCompletion) {
        localStore = []
        completion(.none)
    }
    
    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
        if localStore.isEmpty {
            localStore.append(Cache(feedItems: feed, timestamp: timestamp))
        } else {
            localStore[0] = Cache(feedItems: feed, timestamp: timestamp)
        }
        completion(nil)
    }
    
    public func retrieve(completion: @escaping RetrievalCompletion) {
        if let cache = localStore.first {
            completion(.found(feed: cache.feedItems, timestamp: cache.timestamp))
        } else {
            completion(.empty)
        }
    }
    
}
