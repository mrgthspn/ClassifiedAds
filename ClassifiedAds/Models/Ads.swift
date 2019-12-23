//
//  Ads.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/22/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

import Foundation

struct Results: Decodable {
  let results: [Ad]
}

@objc class Ad: NSObject, Decodable {
  @objc let created_at: String
  @objc let price: String
  @objc let name: String
  let image_urls: [String]
  let image_urls_thumbnails: [String]
  
  @objc func getImage() -> String {
    return image_urls[0]
  }
  
  init(name: String, created_at: String, price: String) {
    self.name = name
    self.created_at = created_at
    self.price = price
    image_urls = [String]()
    image_urls_thumbnails = [String]()
  }
}
