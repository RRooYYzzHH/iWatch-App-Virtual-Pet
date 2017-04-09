//
//  petListRow.swift
//  VirtualPetApp
//
//  Created by RoYzH on 3/25/17.
//  Copyright © 2017 Nathan Gitter. All rights reserved.
//

import WatchKit

class petListRow: NSObject {
    
    @IBOutlet var petsLabel: WKInterfaceLabel!

    public var text: String = "" {
        didSet {
            petsLabel.setText(text)
        }
    }
}
