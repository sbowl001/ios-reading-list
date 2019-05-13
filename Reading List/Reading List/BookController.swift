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
    
}
