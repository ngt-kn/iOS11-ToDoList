//
//  ViewController.swift
//  CheckListApp
//
//  Created by ngt kn on 7/18/18.
//  Copyright © 2018 ngtkn. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    func addItemTableViewControllerDidCancel(_ controller: AddItemTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func addItemTableViewController(_ controller: AddItemTableViewController, didFinishAdding item: CheckListItem) {
        navigationController?.popViewController(animated: true)
    }
    
    
    var items: [CheckListItem]
    
    @IBAction func addItem(_ sender: UIBarButtonItem) {
        let newRowIndex = items.count
        let item = CheckListItem()
        item.text = "new row"
        item.checked = false
        
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        items = [CheckListItem]()
        
        let row0item = CheckListItem()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        
        let row1item = CheckListItem()
        row1item.text = "Brush My Teeth"
        row1item.checked = false
        items.append(row1item)
        
        let row2item = CheckListItem()
        row2item.text = "Learn iOS Development"
        row2item.checked = false
        items.append(row2item)
        
        let row3item = CheckListItem()
        row3item.text = "Soccer Practice"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = CheckListItem()
        row4item.text = "Eat ice cream"
        row4item.checked = false
        items.append(row4item)
        
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        items.remove(at: indexPath.row)
//        let indexPaths = [indexPath]
//        tableView.deleteRows(at: indexPaths, with: .automatic)
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            
            let item = items[indexPath.row]
            item.toggleChecked()
            
            configureCheckmark(for: cell, with: item)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckListItem", for: indexPath)
        
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        return cell
    }
    
    func configureText(for cell: UITableViewCell, with item: CheckListItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
        
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item: CheckListItem){
        if item.checked{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}

