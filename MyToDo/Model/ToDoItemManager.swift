//
//  ToDoItemManager.swift
//  MyToDo
//
//  Created by Nitin Kalokhe on 17/06/23.
//

import UIKit

class ToDoItemManager {
    var todoCount : Int { return todoItems.count}
    var doneCount : Int { return doneItems.count}
    
    private var todoItems = [ToDoItem]()
    private var doneItems = [ToDoItem]()
    
    //plist related
    var todoPathUrl: URL {
        var fileUrls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        guard let documentURl = fileUrls.first else {
            fatalError("Something went wrong, document url could not be found")
        }
        
        return documentURl.appendingPathComponent("toDoItem.plist")
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
        if let nsToDoItems = NSArray(contentsOf: todoPathUrl) {
            for dict in nsToDoItems {
                if let todoItem = ToDoItem(dict: dict as! [String : Any]) {
                    todoItems.append(todoItem)
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        save()
    }
    
    @objc func save(){
        let nsToDoItems = todoItems.map {
            $0.plistDict
        }
        
        guard nsToDoItems.count > 0 else {
            try? FileManager.default.removeItem(at: todoPathUrl)
            return
        }
        
        do {
            let plistData = try PropertyListSerialization.data(fromPropertyList: nsToDoItems, format: PropertyListSerialization.PropertyListFormat.xml, options: PropertyListSerialization.WriteOptions(0))
            try plistData.write(to: todoPathUrl, options: Data.WritingOptions.atomic)
        } catch {
            print(error)
        }
        
    }
    
    func add(_ item:ToDoItem){
        todoItems.append(item)
    }
    
    func item(at index:Int) -> ToDoItem {
        return todoItems[index]
    }
    
    func doneItem(at index:Int) -> ToDoItem {
        return doneItems[index]
    }
    
    func checkItem(at index:Int){
        let checkedItem = todoItems.remove(at: index)
        doneItems.append(checkedItem)
    }
    
    func uncheckItem(at index:Int) {
        let uncheckItem = doneItems.remove(at: index)
        todoItems.append(uncheckItem)
    }
    
    func removeAll(){
        todoItems.removeAll()
        doneItems.removeAll()
    }
}
