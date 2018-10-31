//
//  Checklist.swift
//  Checklists
//
//  Created by Nicolas SUEUR on 29/10/2018.
//  Copyright © 2018 Nicolas SUEUR. All rights reserved.
//

import UIKit

class Checklist: NSObject, Codable {
    
    var name = ""
    var items = [ChecklistItem]()
    
    init(name: String) {
        self.name = name
        super.init()
    }
    
    func countUncheckedItems() -> Int {
        var count = 0
        for item in items where !item.checked {
            count += 1
        }
        return count
    }
}
