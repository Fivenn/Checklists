//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Nicolas SUEUR on 17/10/2018.
//  Copyright © 2018 Nicolas SUEUR. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject {
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
