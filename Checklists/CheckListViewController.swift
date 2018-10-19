//
//  ViewController.swift
//  Checklists
//
//  Created by Nicolas SUEUR on 16/10/2018.
//  Copyright © 2018 Nicolas SUEUR. All rights reserved.
//

import UIKit

class CheckListViewController: UITableViewController, ItemDetailViewControllerDelegate {
    
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
        let label = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            label.text = "✔️"
        } else {
            label.text = ""
        }
    }
    
    func configureText(for cell : UITableViewCell, with item : ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        
        label.text = item.text
    }
    
    //MARK: Implementation of AddItemViewControllerDelegate
    func ItemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        navigationController?.popViewController(animated: true)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: ChecklistItem) {
        let newRowIndex = items.count
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        
        items.append(item)
        tableView.insertRows(at: indexPaths, with: .automatic)
        navigationController?.popViewController(animated: true)
    }
    
    func ItemDetailViewController(_ controller: ItemDetailViewController, didFinishEditing item: ChecklistItem) {
        if let index = items.index(of: item) {
            let indexPath = IndexPath(row: index, section: 0)
            if let cell = tableView.cellForRow(at: indexPath) {
                configureText(for: cell, with: item)
            }
        }
        navigationController?.popViewController(animated:true)
    }
    
    //MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let controller = segue.destination as! ItemDetailViewController
            
            controller.delegate = self
        } else if segue.identifier == "EditItem" {
            let controler = segue.destination as! ItemDetailViewController
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                controler.itemToEdit = items[indexPath.row]
            }
            
            controler.delegate = self
        }
    }
}
