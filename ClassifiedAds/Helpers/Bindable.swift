//
//  Bindable.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/20/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

class Bindable<T> {
  typealias Listener = ((T) -> Void)
  var listener: Listener?

  var value: T {
    didSet {
      listener?(value)
    }
  }

  init(_ v: T) {
    self.value = v
  }

  func bind(_ listener: Listener?) {
    self.listener = listener
  }

  func bindAndFire(_ listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
  
}
