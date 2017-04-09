//
//  InterfaceController.swift
//  VirtualPetApp WatchKit Extension
//
//  Created by RoYzH on 3/25/17.
//  Copyright © 2017 Nathan Gitter. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    
    @IBOutlet var playLabel: WKInterfaceLabel!

    @IBOutlet var feedLabel: WKInterfaceLabel!
    
    var session: WCSession!
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let msg = message["pet"]! as? String
        if(msg == "dog") {
            currentPet = pets[.dog]
        }
        else if(msg == "cat") {
            currentPet = pets[.cat]
        }
        else if(msg == "bird") {
            currentPet = pets[.bird]
        }
        else if(msg == "bunny") {
            currentPet = pets[.bunny]
        }
        else if(msg == "fish") {
            currentPet = pets[.fish]
        }
        else if(msg == "feed") {
            currentPet.feed()
            displayLabel()
        }
        else if(msg == "play") {
            currentPet.play()
            displayLabel()
        }
    }
    
    @IBOutlet var imagePet: WKInterfaceButton!
    
    let petsList = ["dog", "cat", "bird", "bunny", "fish"]
    
    private let pets: [PetType: Pet] = [
        .dog: Pet(type: .dog),
        .cat: Pet(type: .cat),
        .bird: Pet(type: .bird),
        .bunny: Pet(type: .bunny),
        .fish: Pet(type: .fish)
    ]
    
    private var currentPet: Pet! {
        didSet {
            imagePet.setBackgroundImage(currentPet.image)
            displayLabel()
            print("Selected pet is \(currentPet.type)")
            print("Happiness is: \(currentPet.happiness)")
            print("Foodlevel is: \(currentPet.foodLevel)")
        }
    }
    
    private func displayLabel() {
        playLabel.setText("\(currentPet.playSessions)")
        feedLabel.setText("\(currentPet.feedings)")
    }
    
    @IBAction func feedButton() {
        if currentPet.foodLevel > 10 {
            let firstAction = WKAlertAction(title: "Back", style: WKAlertActionStyle.cancel) {() -> Void in
            }
            
            let secondAction = WKAlertAction(title: "I know", style: WKAlertActionStyle.destructive) {() -> Void in
            }
            
            self.presentAlert(withTitle: "Suggestion!", message: "The food level for this pet is over 10. You can now play with him!", preferredStyle: WKAlertControllerStyle.actionSheet, actions: [firstAction, secondAction])
        }
        
        currentPet.feed()
        displayLabel()
        // Send message to ios
        let msg = ["pet" : "feed"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    
 
    @IBAction func playButton() {
        if currentPet.foodLevel <= 0 {
            let firstAction = WKAlertAction(title: "Back", style: WKAlertActionStyle.cancel) {() -> Void in
            }
            
            let secondAction = WKAlertAction(title: "I know", style: WKAlertActionStyle.destructive) {() -> Void in
            }
            
            self.presentAlert(withTitle: "Warning!", message: "The food level for this pet is \(currentPet.foodLevel). If you want to play with the pet, you need to first feed him!", preferredStyle: WKAlertControllerStyle.actionSheet, actions: [firstAction, secondAction])
        }
        else {
            currentPet.play()
            displayLabel()
            let msg = ["pet" : "play"]
            session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
        }
    }
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        self.session = WCSession.default()
        self.session.delegate = self
        self.session.activate()
        
        print("awake")
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        switch index {
        case 0:
            currentPet = pets[.dog]
            let msg = ["pet" : "dog"]
            session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
            break
        case 1:
            currentPet = pets[.cat]
            let msg = ["pet" : "cat"]
            session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
            break
        case 2:
            currentPet = pets[.bird]
            let msg = ["pet" : "bird"]
            session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
            break
        case 3:
            currentPet = pets[.bunny]
            let msg = ["pet" : "bunny"]
            session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
            break
        default:
            currentPet = pets[.fish]
            let msg = ["pet" : "fish"]
            session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
        }
        
        print("activate")
    }
    
    @IBAction func fishMenu() {
        index = 4
        currentPet = pets[.fish]
        let msg = ["pet" : "fish"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBAction func catMenu() {
        index = 1
        currentPet = pets[.cat]
        let msg = ["pet" : "cat"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBAction func birdMenu() {
        index = 2
        currentPet = pets[.bird]
        let msg = ["pet" : "bird"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBAction func bunnyMenu() {
        index = 3
        currentPet = pets[.bunny]
        let msg = ["pet" : "bunny"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
