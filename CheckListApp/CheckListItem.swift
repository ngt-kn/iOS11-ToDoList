//
//  CheckListItem.swift
//  CheckListApp
//
//  Created by ngt kn on 7/18/18.
//  Copyright © 2018 ngtkn. All rights reserved.
//

import Foundation

class CheckListItem {
    
    var text = ""
    var checked = false
    
    func toggleChecked() {
        checked = !checked
    }
}
