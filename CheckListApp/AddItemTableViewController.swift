//
//  AddItemTableViewController.swift
//  CheckListApp
//
//  Created by ngt kn on 7/19/18.
//  Copyright © 2018 ngtkn. All rights reserved.
//

import UIKit

protocol AddItemTableViewControllerDelegate: class {
    func addItemTableViewControllerDidCancel(_ controller: AddItemTableViewController)
    func addItemTableViewController(_ controller: AddItemTableViewController, didFinishAdding item: CheckListItem)
    func addItemTableViewController(_ controller: AddItemTableViewController, didFinishEditing item: CheckListItem)
}

class AddItemTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var itemToEdit: CheckListItem?
    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            title = "Edit Item"
            textField.text = item.text
            doneBarButton.isEnabled = true
        }

    }
    
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        textField.becomeFirstResponder()
    }

    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
        delegate?.addItemTableViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let itemToEdit = itemToEdit {
            itemToEdit.text = textField.text!
            delegate?.addItemTableViewController(self, didFinishEditing: itemToEdit)
        } else {
            let item  = CheckListItem()
            item.text = textField.text!
            item.checked = false
            delegate?.addItemTableViewController(self, didFinishAdding: item)
        }
    }
    
    // Allows copy and paste text in field
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text!
        let stringRange = Range(range, in:oldText)
        let newText = oldText.replacingCharacters(in: stringRange!, with: string)
        if newText.isEmpty {
            doneBarButton.isEnabled = false
        } else {
            doneBarButton.isEnabled = true
        }
        return true
    }

}
