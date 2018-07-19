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
}

class AddItemTableViewController: UITableViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddItemTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    

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
        let item  = CheckListItem()
        item.text = textField.text!
        item.checked = false
        delegate?.addItemTableViewController(self, didFinishAdding: item)
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
