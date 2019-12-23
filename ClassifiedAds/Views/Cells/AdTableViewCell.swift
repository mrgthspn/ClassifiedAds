//
//  AdTableViewCell.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/22/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

import UIKit

class AdTableViewCell: UITableViewCell {
  var viewModel: AdCellViewModel? {
    didSet {
      bindViewModel()
    }
  }

  @IBOutlet weak var adThumbnailImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  
  private func bindViewModel() {
    guard let safeViewModel = viewModel else {
      return
    }
    
    URLSession.shared.dataTask(with: URL(string: safeViewModel.imageThumbnailURLText)!) { (data, urlResponse, error) in
      if let data = data {
        DispatchQueue.main.async {
          self.adThumbnailImageView.image = UIImage(data: data)
        }
      }
    }.resume()
    
    nameLabel.text? = safeViewModel.nameText
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    self.adThumbnailImageView.image = UIImage(systemName: "camera.on.rectangle")
  }
    
}
