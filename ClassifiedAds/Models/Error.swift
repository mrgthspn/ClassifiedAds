//
//  Error.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/22/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

struct ErrorInfo: Error, Decodable {
  let error: ErrorDetail
}

struct ErrorDetail: Decodable {
  let code: Int
  let info: String
}
