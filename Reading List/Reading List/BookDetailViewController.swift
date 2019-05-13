//
//  BookDetailViewController.swift
//  Reading List
//
//  Created by Stephanie Bowles on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    var bookController: BookController?
    var book: Book?
    
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var reasonText: UITextView!
/*Create an updateViews() method. If the book variable has a value, it should take its title and put it in the text field, and put its reasonToRead in the textView. It should also set the title of the view controller to the book's title if there is one, or it should set the title to "Add a new book" if a new book is going to be created.
 In the action of the button, it should either call the createBook method in the bookController if the book property is nil or call the update method in the bookController if the book property is not nil.*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }
    func updateViews() {
        guard let book = book else {title = "Add a new Book"    //weird reverse logic from if statements
            return }
        titleLabel.text = book.title
        reasonText.text = book.reasonToRead
        
//        navigationItem.title = book.title
       title = book.title
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleLabel.text , let reasonText = reasonText.text, title != "" && reasonText != "" else {return}
        if let book = book {
            bookController?.updateBook(book: book, with: title, reasonToRead: reasonText)
        } else {
            bookController?.createBook(titled: title, reasonToRead: reasonText, hasBeenRead: false)
        }
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
