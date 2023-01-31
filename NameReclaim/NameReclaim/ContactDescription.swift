//
//  ContactDescription.swift
//  NameReclaim
//
//  Created by alec stevenson on 12/9/22.
//

import Foundation
import SwiftUI
import CoreData
import UIKit

struct ContactDescription {
    
    let myItem: Item
    
    @State private var name: String
    @State private var profile: String
    @State private var photo: String
    @State private var location: String
    @State private var time: String
    @State private var physical: String
    @State private var details: String
    
    init(myItem: Item) {
        self.myItem = myItem
        
        self._name = State(initialValue: myItem.name ?? "")
        self._profile = State(initialValue: myItem.profile ?? "")
        self._photo = State(initialValue: myItem.photo ?? "")
        self._location = State(initialValue: myItem.location ?? "")
        self._time = State(initialValue: myItem.time ?? "")
        self._physical = State(initialValue: myItem.physical ?? "")
        self._details = State(initialValue: myItem.details ?? "")
    }
    
    func Contact() -> String {
        var contactString = ""
        contactString += "Name: "
        contactString += name
        contactString += "\n"
        if(!(String(profile).isEmpty)) {
            contactString += "Profile: "
            contactString += profile
            contactString += "\n"
        }
        if(!(String(location).isEmpty)) {
            contactString += "Location: "
            contactString += location
            contactString += "\n"
        }
        if(!(String(time).isEmpty)) {
            contactString += "Time: "
            contactString += time
            contactString += "\n"
        }
        if(!(String(physical).isEmpty)) {
            contactString += "Physical Description: "
            contactString += physical
            contactString += "\n"
        }
        if(!(String(details).isEmpty)) {
            contactString += "Details: "
            contactString += details
        }
        
        return contactString
    }
    
    func NameTitle() -> String {
        var titleString = ""
        titleString += name.uppercased()
        return titleString
        
    }
    
}
