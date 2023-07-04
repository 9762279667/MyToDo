//
//  InputViewController.swift
//  MyToDo
//
//  Created by Nitin Kalokhe on 20/06/23.
//

import UIKit
import CoreLocation

class InputViewController : UIViewController {
    
    var itemManager : ToDoItemManager?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!

    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        titleTextField.delegate = self
        addressTextField.delegate = self
        descriptionTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func onSave(_ sender: UIButton) {
        guard let titleText = titleTextField.text, titleText.count > 0 else { return }
        
        // datePicker could be nil if the view controller is init via code
        var date : Date?
        if datePicker != nil {
            date = datePicker.date
            dateLabel.text = date?.timeIntervalSince1970.description
        }
        var descripton: String?
        if descriptionTextField != nil {
            descripton = descriptionTextField.text
        }
                
        if addressTextField != nil {
            
            if let locationName = addressTextField.text, locationName.count > 0 {
                geocoder.geocodeAddressString(locationName){[weak self](placemarks, error) in
                    guard let self = self else { return }
                    if let error = error {
                        print("Geocoding error \(error.localizedDescription)")
                        return
                    }
                    guard let placemarks = placemarks, let location = placemarks.first?.location else {
                        print("No location found for address")
                        return
                    }
                                        
                    let item = ToDoItem(title: title, itemDescription: descripton, timestamp: date?.timeIntervalSince1970, location: Location(name: locationName, coordinates: location.coordinate))
        
                    DispatchQueue.main.async {
                        self.itemManager?.add(item)
                        self.dismiss(animated: true)
                    }
                }
                
            }else {
                let item = ToDoItem(title: titleText, itemDescription: description, timestamp: date?.timeIntervalSince1970, location: nil)
                self.itemManager?.add(item)
            }
        }
        
    }
    @IBAction func onCancel(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
    }
    
}

extension InputViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        resignFirstResponder()
        view.endEditing(true)
        return false
    }
}
