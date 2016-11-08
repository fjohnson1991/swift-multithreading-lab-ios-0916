//
//  Flatigram.swift
//  swift-multithreading-lab
//
//  Created by Felicity Johnson on 11/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Foundation
import UIKit

class Flatigram {
    
    var image: UIImage?
    var state: ImageState = .unfiltered
    
    
}

enum ImageState {
    case filtered, unfiltered
}
