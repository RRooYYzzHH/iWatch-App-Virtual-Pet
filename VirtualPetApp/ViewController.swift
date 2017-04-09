//
//  ViewController.swift
//  VirtualPetApp
//
//  Created by Nathan Gitter on 11/8/16.
//  Copyright © 2016 Nathan Gitter. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    var session: WCSession!
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if message["pet"]! is String {
            let msg = message["pet"]! as? String
            if(msg == "feed") {
                currentPet.feed()
                updateDisplayViews(animated: true)
            }
            else if(msg == "play") {
                currentPet.play()
                updateDisplayViews(animated: true)
            }
            else if(msg == "dog") {
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
        }
    }
    
    // WCSessionDelegate
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        //
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        //
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        //
    }
    
    private let pets: [PetType: Pet] = [
        .dog: Pet(type: .dog),
        .cat: Pet(type: .cat),
        .bird: Pet(type: .bird),
        .bunny: Pet(type: .bunny),
        .fish: Pet(type: .fish)
        
    ]
    
    private var currentPet: Pet! {
        didSet {
            petImageView.image = currentPet.image
            petView.backgroundColor = currentPet.color
            happinessDisplayView.color = currentPet.color
            hungrinessDisplayView.color = currentPet.color
            updateDisplayViews(animated: false)
            
        }
    }
    
    @IBOutlet weak var petView: UIView!
    @IBOutlet weak var petImageView: UIImageView!

    @IBOutlet weak var happinessLabel: UILabel!
    @IBOutlet weak var hungrinessLabel: UILabel!
    
    @IBOutlet weak var happinessDisplayView: DisplayView!
    @IBOutlet weak var hungrinessDisplayView: DisplayView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentPet = pets[.dog]
        updateDisplayViews(animated: false)
        
        self.session = WCSession.default()
        self.session.delegate = self
        self.session.activate()
    }
    
    private func updateDisplayViews(animated: Bool) {
        let happinessDisplayValue = CGFloat(currentPet.happiness) / 10
        let hungrinessDisplayValue = CGFloat(currentPet.foodLevel) / 10
        if animated {
            happinessDisplayView.animateValue(to: happinessDisplayValue)
            hungrinessDisplayView.animateValue(to: hungrinessDisplayValue)
            
        } else {
            happinessDisplayView.value = happinessDisplayValue
            hungrinessDisplayView.value = hungrinessDisplayValue
        }
        happinessLabel.text = "played: \(currentPet.playSessions)"
        hungrinessLabel.text = "fed: \(currentPet.feedings)"
        
        
    }
    
    // MARK: Interaction Button Actions

    @IBAction func feedButtonPressed(_ sender: UIButton) {
        currentPet.feed()
        updateDisplayViews(animated: true)
        let msg = ["pet" : "feed"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBAction func playButtonPressed(_ sender: UIButton) {
        currentPet.play()
        updateDisplayViews(animated: true)
        let msg = ["pet" : "play"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    // MARK: Animal Button Actions
    
    @IBAction func dogButtonPressed(_ sender: UIButton) {
        currentPet = pets[.dog]
        let msg = ["pet" : "dog"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)

    }
    
    @IBAction func catButtonPressed(_ sender: UIButton) {
        currentPet = pets[.cat]
        let msg = ["pet" : "cat"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)

    }
    
    @IBAction func birdButtonPressed(_ sender: UIButton) {
        currentPet = pets[.bird]
        let msg = ["pet" : "bird"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)

    }
    
    @IBAction func guineaPigButtonPressed(_ sender: UIButton) {
        currentPet = pets[.bunny]
        let msg = ["pet" : "bunny"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    @IBAction func fishButtonPressed(_ sender: UIButton) {
        currentPet = pets[.fish]
        let msg = ["pet" : "fish"]
        session.sendMessage(msg, replyHandler: nil, errorHandler: nil)
    }
    
    
}

