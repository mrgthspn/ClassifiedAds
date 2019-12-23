//
//  Result.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/20/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

enum Result<T, U: Error> {
  case success(payload: T)
  case failure(U?)
}

enum EmptyResult<U: Error> {
  case success
  case failure(U?)
}
