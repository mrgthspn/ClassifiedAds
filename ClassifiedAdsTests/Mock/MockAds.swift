//
//  MockAds.swift
//  ClassifiedAdsTests
//
//  Created by Maria Agatha España on 12/23/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

@testable import ClassifiedAds

extension Results {
  
  static func with(ads: [Ad] = [Ad(name: "Test", created_at: "21-12-2019", price: "24AED")]) -> Results {
    return Results(results: ads)
  }

  static func none(ads: [Ad] = []) -> Results {
    return Results(results: ads)
  }
  
}

