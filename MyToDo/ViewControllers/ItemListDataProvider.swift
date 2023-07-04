//
//  ItemListDataProvider.swift
//  MyToDo
//
//  Created by Nitin Kalokhe on 17/06/23.
//

import UIKit

enum Section: Int {
    case todo
    case done
}

class ItemListDataProvider:NSObject{
    var itemManager: ToDoItemManager?
}

extension ItemListDataProvider: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let itemManager = itemManager else { return 0 }
        
        guard let itemSection = Section(rawValue: section) else {  fatalError() }
        
        let numberOfRows: Int
        
        switch itemSection {
        case .todo:
            numberOfRows = itemManager.todoCount
        case .done:
            numberOfRows = itemManager.doneCount
        }
        
        return numberOfRows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: Constants.ItemCellIdentifier, for: indexPath) as? ItemCell
        return UITableViewCell()
    }
}

extension ItemListDataProvider: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Hello World"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
