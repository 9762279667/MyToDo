//
//  Constants.swift
//  MyToDo
//
//  Created by Nitin Kalokhe on 18/06/23.
//

import Foundation

struct Constants {
    static let MainStoryboardIdentifier = "Main"
    static let ItemCellIdentifier = "ItemCell"
    static let ItemListViewController = "ItemListViewController"
    static let InputListViewController = "InputListViewController"
    static let DetailViewControllerIdentifier = "DetailViewController"
    static let userName = "Crystal"
    static let password = "1234"
}

extension Notification {
  static let ItemSelectedNotification = Notification.Name("ItemSelectedNotification")
}
