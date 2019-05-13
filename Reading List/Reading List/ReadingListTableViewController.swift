//
//  ReadingListTableViewController.swift
//  Reading List
//
//  Created by Stephanie Bowles on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController, BookTableViewCellDelegate {
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {return}
        let book = bookFor(indexPath: indexPath)
        bookController.updateHasBeenRead(for: book)
        tableView.reloadData()
    }
    
    
    let bookController = BookController()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return bookController.readBooks.count
            
        } else {
    
        return bookController.unreadBooks.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "readingList", for: indexPath) as? BookTableViewCell else {return UITableViewCell()}
        
       let book = bookFor(indexPath: indexPath)
        cell.book = book
        cell.delegate = self
        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let book = bookFor(indexPath: indexPath)
            bookController.deleteBook(book: book)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
   
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            guard bookController.readBooks.count > 0 else {return nil}
            return "Read Books"
        } else {
            guard bookController.unreadBooks.count > 0 else {return nil}
            return "Unread Books"
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addToDetail") {
            
             guard let destinationVC = segue.destination as? BookDetailViewController else {return}
            destinationVC.bookController = bookController
        } else if(segue.identifier == "toDetail") {
            guard let indexPath = tableView.indexPathForSelectedRow,
                let destinationVC = segue.destination as? BookDetailViewController else {return}
                let book = bookFor(indexPath: indexPath)
                destinationVC.book = book
                destinationVC.bookController = bookController
        }
    }
/*Finally, we need to set up the prepare(for segue: ...) in order to pass the bookController and potentially a Book to the BookDetailViewController.
 
 Check the segue's identifier property using a conditional statement. If it's the one from the "Add" bar button item, then this means the user wants to create a new Book. Pass the bookController variable in the table view controller to the segue's destination view controller. (You will need to cast the destination as the correctly typed view controller)
 If the segue's identifier matches the cell's segue identifier, do the same thing as step 1, and also pass a Book object that was selected in the table view to the destination view controller's book property as well.*/
 

}
