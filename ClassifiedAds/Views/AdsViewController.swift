//
//  AdsViewController.swift
//  ClassifiedAds
//
//  Created by Maria Agatha España on 12/22/19.
//  Copyright © 2019 Maria Agatha España. All rights reserved.
//

import UIKit

class AdsViewController: UIViewController {
  
  let SEGUE_ID = "listToDetail"
  let CELL_ID = "adCell"
  let minRowHeight: CGFloat = 80.0
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  let viewModel: AdsViewModel = AdsViewModel()
  
  var refreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
    initTableSettings()
    initSearchBarSettings()
    showSpinner(onView: view)
    
    bindViewModel()
    viewModel.getAds()
    
    hideKeyboardWhenTapped()
  }
  
   func initTableSettings() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.accessibilityIdentifier = "adsTableView"
    
    refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
    refreshControl.addTarget(self, action: #selector(AdsViewController.refresh(sender:)), for: UIControl.Event.valueChanged)
    tableView.addSubview(refreshControl)
   }
   
   func initSearchBarSettings() {
    searchBar.delegate = self
   }
  
  func bindViewModel() {
    viewModel.adCells.bindAndFire() { [weak self] cells in
      if let `self` = self {
        DispatchQueue.main.async {
          if cells.count != 0 {
            self.removeSpinner()
          }
          self.tableView.reloadData()
          self.refreshControl.endRefreshing()
          self.refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        }
      }
    }
    
    viewModel.state.bindAndFire() { [weak self] state in
      if let `self` = self {
        switch state {
        case .error(let message):
          DispatchQueue.main.async {
            self.presentSingleButtonDialog(alert: SingleButtonAlert(title: "Error", message: message.error.info, action: AlertAction(buttonTitle: "Ok", handler: nil)))
          }
        default:
          break
        }
      }
    }
  }
  
  public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == SEGUE_ID,
      let destinationViewController = segue.destination as? DetailViewController,
      let indexPath = tableView.indexPathForSelectedRow {
        switch viewModel.adCells.value[indexPath.row] {
        case .normal(let viewModel):
          destinationViewController.data = viewModel.ad
        default:
          break
        }
    }
  }

}

// MARK: - User Interactions
extension AdsViewController {
  @objc func refresh(sender: AnyObject) {
    refreshControl.attributedTitle = NSAttributedString(string: "Loading... Please Wait")
    viewModel.getAds()
  }
}

// MARK: - UITableViewDelegate
extension AdsViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.adCells.value.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     switch viewModel.adCells.value[indexPath.row] {
     case .normal(let viewModel):
      guard let cell = tableView.dequeueReusableCell(withIdentifier: self.CELL_ID) as? AdTableViewCell else {
         return UITableViewCell()
       }
       cell.viewModel = viewModel
       return cell
     case .error(let message):
       let cell = UITableViewCell()
       cell.isUserInteractionEnabled = false
       cell.textLabel?.text = message
       return cell
    }
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
     let tHeight = tableView.frame.height
     let temp = tHeight / CGFloat(15)
     return temp > minRowHeight ? temp : minRowHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: false)
  }
  
}

// MARK: - UISearchBarDelegate
extension AdsViewController: UISearchBarDelegate {
  
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    if searchText == "" {
      viewModel.normalState()
    } else {
      viewModel.filter(text: searchText)
    }
  }
  
  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    viewModel.searchingState()
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    viewModel.searchingState()
    searchBar.resignFirstResponder()
  }
}

// MARK: - HideKeyboard
extension AdsViewController {
  func hideKeyboardWhenTapped() {
      let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AdsViewController.dismissKeyboard))
      tap.cancelsTouchesInView = false
      view.addGestureRecognizer(tap)
  }

  @objc func dismissKeyboard() {
      view.endEditing(true)
  }
}

// MARK: - AlertExtension
extension AdsViewController: SingleButtonDialogPresenter {}
