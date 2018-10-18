//
//  ViewController.swift
//  Checklists
//
//  Created by Nicolas SUEUR on 16/10/2018.
//  Copyright © 2018 Nicolas SUEUR. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController {
    
    var items: [ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        let row0item = ChecklistItem()
        let row1item = ChecklistItem()
        let row2item = ChecklistItem()
        let row3item = ChecklistItem()
        let row4item = ChecklistItem()
        let row5item = ChecklistItem()
        
        items = [ChecklistItem]()
        row0item.text = "Walk the dog"
        row0item.checked = false
        items.append(row0item)
        row1item.text = "Brush my teeth"
        row1item.checked = true
        items.append(row1item)
        row2item.text = "Learn iOS development"
        row2item.checked = true
        items.append(row2item)
        row3item.text = "Soccer practice"
        row3item.checked = false
        items.append(row3item)
        row4item.text = "Eat ice cream"
        row4item.checked = true
        items.append(row4item)
        row5item.text = "Buy coffee"
        row5item.checked = false
        items.append(row5item)
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func addItem() {
        let newRowIndex = items.count
        let item = ChecklistItem()
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        item.text = "I am a new row"
        item.checked = true
        items.append(item)
        tableView.insertRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChecklistItem", for: indexPath)
        let item = items[indexPath.row]
        
        configureText(for: cell, with: item)
        configureCheckmark(for: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            
            item.toggleChecked()
            configureCheckmark(for: cell, with: item)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let indexPaths = [indexPath]
        
        items.remove(at: indexPath.row)
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    func configureCheckmark(for cell: UITableViewCell, with item : ChecklistItem) {
        if item.checked {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
    
    func configureText(for cell : UITableViewCell, with item : ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = item.text
    }
}
