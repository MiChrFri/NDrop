//
//  InterfaceController.swift
//  NDrop WatchKit Extension
//
//  Created by Michael Frick on 07/07/2018.
//  Copyright © 2018 Michael Frick. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    let defaults = UserDefaults.standard
    
    @IBOutlet var numberLabel: WKInterfaceLabel!
    
    @IBAction func newNumberTapped() {
        presentTextInputController(withSuggestions: nil, allowedInputMode: WKTextInputMode.allowEmoji, completion: {(results) -> Void in
            if results != nil && results!.count > 0 {
                if let input = results?[0] as? String {
                    self.numberLabel.setText(input)
                    self.store(input)
                }
            }
        })
    }
    
    private func store(_ input: String) {
        defaults.set(input, forKey: "stored")
        defaults.synchronize()
    }
    
    private func load() -> String? {
        guard let stored = defaults.string(forKey: "stored") else { return nil }
        return stored
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        self.numberLabel.setText(load())
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
