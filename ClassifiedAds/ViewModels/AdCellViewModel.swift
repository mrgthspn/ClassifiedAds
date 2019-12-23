//
//  AdCellViewModel.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/22/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

protocol AdCellViewModel {
  var ad: Ad { get }
  var nameText: String { get }
  var imageThumbnailURLText: String { get }
}

extension Ad: AdCellViewModel {
  var ad: Ad {
    return self
  }
  var nameText: String {
    return name
  }
  var imageThumbnailURLText: String {
    return image_urls_thumbnails[0]
  }
}
