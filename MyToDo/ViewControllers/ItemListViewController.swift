//
//  ViewController.swift
//  MyToDo
//
//  Created by Nitin Kalokhe on 29/05/23.
//

import UIKit

class ItemListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
        
    @IBOutlet weak var dataProvider: ItemListDataProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataProvider;
        tableView.delegate = dataProvider;
        
        dataProvider.itemManager = ToDoItemManager()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetails(_:)), name: Notification.ItemSelectedNotification, object: nil)
    }
    
    @objc func showDetails(_ sender:Notification){
        guard let index = sender.userInfo!["index"] as? Int else { fatalError() }
        
        if let nextViewController = storyboard?.instantiateViewController(withIdentifier: Constants.DetailViewControllerIdentifier) as? DetailsViewController{
            
            if let itemManager = dataProvider.itemManager {
                guard index < itemManager.todoCount else {
                    return
                }
                nextViewController.item = itemManager.item(at: index)
                navigationController?.pushViewController(nextViewController, animated: true)
            }
        }
    }

    @IBAction func addItem(_ sender: UIBarButtonItem) {
        guard let inputViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return  }
        
//        inputViewController.itemManager = dataProvider.itemManager
        present(inputViewController, animated: true, completion: nil)
    }
    
}

