//
//  ShoppingListTableViewController.swift
//  ShoppingList2
//
//  Created by Kelsey Sparkman on 3/10/20.
//  Copyright © 2020 Kelsey Sparkman. All rights reserved.
//

import UIKit
import CoreData

class ShoppingListTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        ListController.shared.fetchedResultsController.delegate = self
    }
   
    @IBAction func addButtonTapped(_ sender: Any) {
        //Create the alert
        let alert = UIAlertController(title: "Add Item", message: "What would you like to add to your list?", preferredStyle: .alert)
        
        //Add a text field
        alert.addTextField(configurationHandler: nil)
        
        //Create a cancel button
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        //Create add button
        let addButton = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let item = alert.textFields?[0].text, item != "" else {return}
            ListController.shared.create(text: item)
            //Reload data
            self.tableView.reloadData()
        }
        //Add our buttons to the alert
        alert.addAction(cancelButton)
        alert.addAction(addButton)
        //Present our alert
        self.present(alert, animated: true)
        
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListController.shared.fetchedResultsController.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? CustomListTableViewCell else {return UITableViewCell()}
        let list = ListController.shared.fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = list.title
        cell.update(list: list)
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let list = ListController.shared.fetchedResultsController.object(at: indexPath)
            ListController.shared.delete(list: list)
        }
    }
}//end of class
extension ShoppingListTableViewController: CustomListTableViewCellDelegate {
    func buttonTapped(_ sender: CustomListTableViewCell){
        guard let indexPath = tableView.indexPath(for: sender) else {return}
        let list = ListController.shared.fetchedResultsController.object(at: indexPath)
        ListController.shared.toggleCheckBox(for: list)
        sender.update(list: list)
    }
    func updateButton(_ sender: CustomListTableViewCell) {
        
    }
}

extension ShoppingListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    //sets behavior for cells
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .delete:
            guard let indexPath = indexPath else { break }
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .insert:
            guard let newIndexPath = newIndexPath else { break }
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        case .move:
            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { break }
            tableView.moveRow(at: indexPath, to: newIndexPath)
        case .update:
            guard let indexPath = indexPath else { break }
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }
    //additional behavior for cells
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        @unknown default:
            fatalError()
        }
    }
    
}
