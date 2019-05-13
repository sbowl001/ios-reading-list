//
//  BookTableViewCell.swift
//  Reading List
//
//  Created by Stephanie Bowles on 5/13/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    weak var delegate: BookTableViewCellDelegate?
    
    var book: Book? {
        didSet {
            updateViews()
        }
    }
    
    
    func updateViews() {
    guard let book = self.book else {return}
    self.label.text = book.title
    if(book.hasBeenRead) {
        button.setImage(UIImage(named: "checked.png"), for: .normal)
    } else {
        button.setImage(UIImage(named: "unchecked.png"), for: .normal)
    }
    
    }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func buttonTapped(_ sender: Any) {
        print("ButtonPressed")
        delegate?.toggleHasBeenRead(for : self)
    }
    
}
