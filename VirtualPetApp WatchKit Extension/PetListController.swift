//
//  PetListController.swift
//  VirtualPetApp
//
//  Created by RoYzH on 3/25/17.
//  Copyright © 2017 Nathan Gitter. All rights reserved.
//

import WatchKit

var index = 0

class PetListController: WKInterfaceController {
    
    @IBOutlet var table: WKInterfaceTable!
    
    let petsList = ["dog", "cat", "bird", "bunny", "fish"]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        table.setNumberOfRows(petsList.count, withRowType: "myRow")
        
        for (index, pet) in petsList.enumerated() {
            guard let row = table.rowController(at: index) as? petListRow else {return}
            row.text = pet
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        index = rowIndex
        guard let row = table.rowController(at: rowIndex) as? petListRow else { return }
        print("Select " + row.text)
    }
}
