//
//  Alert.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/20/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

struct AlertAction {
  let buttonTitle: String
  let handler: (() -> Void)?
}

struct SingleButtonAlert {
  let title: String
  let message: String?
  let action: AlertAction
}
