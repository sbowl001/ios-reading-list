//
//  BookController.swift
//  Reading List
//
//  Created by Stephanie Bowles on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class BookController {
    private(set) var books : [Book] = []
    
    private var readingListURL: URL? {
        let fileManager = FileManager.default
        guard let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask) .first else {return nil}
        return documentsDirectory.appendingPathComponent("ReadingList.plist")
    }
    
    var readBooks: [Book] {
        let readBooks = books.filter { $0.hasBeenRead == true}
        return readBooks
    }
    var unreadBooks: [Book] {
        let unreadBooks = books.filter { $0.hasBeenRead == false}
        return unreadBooks
    }
    
    func createBook(titled title: String, reasonToRead : String, hasBeenRead : Bool) {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        
    }
    
    func deleteBook(book: Book) {
//         Add a "Delete" method that passes in a Book object as a parameter, and removes it from the books array.
        guard let index = books.index(of: book) else {return}
        books.remove(at: index)
        saveToPersistentStore()
    }
 
    func updateHasBeenRead(for book:Book){
//         One is to update a Book object's hasBeenRead property. Call it updateHasBeenRead(for book: Book). It should simply swap the hasBeenRead value from false to true and vice-versa.
        guard let index = books.index(of: book) else {return}
       
        books[index].hasBeenRead = !books[index].hasBeenRead
        
//        books.append(updatedBook)
        saveToPersistentStore()
    }
    
    func updateBook(book: Book, with title: String, reasonToRead: String) {

        guard let index = books.index(of: book) else {return}
        books[index].title = title
        books[index].reasonToRead = reasonToRead
        saveToPersistentStore()
        
    }
    
/*
  
 We'll need two "Update" methods:

 The other is to edit the Book's title and/or reasonToRead properties.*/
    
    func saveToPersistentStore() {
    guard let url = self.readingListURL else {return}
        
        do {
            
            let encoder = PropertyListEncoder()
            let booksData = try encoder.encode(books)
            try booksData.write(to: url)
        } catch {
            NSLog("Error saving books data: \(error)")
        }
 
    }
    func loadFromPersistentStore() {
        let fileManager = FileManager.default
        guard let url = readingListURL, fileManager.fileExists(atPath: url.path) else {return}
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
//            let decodedBooks = self.books
            self.books = try decoder.decode([Book].self, from: data)
        } catch {
            NSLog("Error loading books data: \(error)")
        }
    
/*Inside of a do-try-catch- block, unwrap the readingListURL property.
 Still inside of the block, use the Data(contentsOf: URL) initializer to get access to the property list form of the books. Assign this data you initialize to a constant.
 Initialize a PropertyListDecoder and assign it to a constant.
 Create a constant called
     ??What constant?
     decodedBooks. Set its value by calling the decode method on the property list decoder you just created, and passing in the type it should be decoded as, and the data constant you made a couple steps ago. (Hint: the type parameter to this function should be [Book].self)
 Set the value of the books property in the BookController to the decodedBooks you just made.
 In the catch block, you should make an error message that is descriptive of what happened
*/
    
    
}
}
