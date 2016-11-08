//
//  FilterOperation.swift
//  swift-multithreading-lab
//
//  Created by Felicity Johnson on 11/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation

class FilterOperation: Operation {
    var flatigram: Flatigram
    var filter: String
    
    init(flatigram: Flatigram, filter: String) {
        self.flatigram = flatigram
        self.filter = filter
    }
    
    override func main() {
        guard let filteredPic = flatigram.image?.filter(with: filter) else {return}
        flatigram.image = filteredPic
    }
    
}
