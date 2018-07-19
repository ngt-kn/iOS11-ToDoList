//
//  AddItemTableViewController.swift
//  CheckListApp
//
//  Created by ngt kn on 7/19/18.
//  Copyright © 2018 ngtkn. All rights reserved.
//

import UIKit

protocol ItemDetailViewProtocol: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailView)
    func itemDetailViewController(_ controller: ItemDetailView, didFinishAdding item: CheckListItem)
    func itemDetailViewController(_ controller: ItemDetailView, didFinishEditing item: CheckListItem)
}

class ItemDetailView: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    var itemToEdit: CheckListItem?
    
    weak var delegate: ItemDetailViewProtocol?
    
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
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        if let itemToEdit = itemToEdit {
            itemToEdit.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: itemToEdit)
        } else {
            let item  = CheckListItem()
            item.text = textField.text!
            item.checked = false
            delegate?.itemDetailViewController(self, didFinishAdding: item)
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
