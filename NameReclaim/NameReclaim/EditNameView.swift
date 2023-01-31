//
//  EditNameView.swift
//  NameReclaim
//
//  Created by alec stevenson on 11/29/22.
//

import SwiftUI
import CoreData
import UIKit

struct EditNameView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State private var isImagePickerDisplay = false
    
    let myItem: Item
    
    @State private var name = ""
    @State private var profile = ""
    @State private var photo = ""
    @State private var location = ""
    @State private var time = ""
    @State private var physical = ""
    @State private var details = ""
    
    @State private var currentImage: UIImage!
    
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
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    var edit_name = ""
    var edit_profile = ""
    var edit_location = ""
    var edit_time = ""
    var edit_physical = ""
    var edit_details = ""
    
    @FetchRequest(sortDescriptors: []) private var items:FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                TextField("Profile", text: $profile)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                TextField("Location", text: $location)
                .disableAutocorrection(true)
                TextField("Time", text: $time)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                TextField("Physical Description", text: $physical)
                TextField("Details", text: $details)
                Button(action: {
                    saveName()
                    dismiss()
                }, label: {
                    Text("Save Changes").frame(minWidth: 0, maxWidth: .infinity)
                }
                )
            }
            .navigationTitle("Edit Name")
        }
    }
    
    private func saveName() {
        myItem.name = name
        myItem.profile = profile
        myItem.location = location
        myItem.time = time
        myItem.physical = physical
        myItem.details = details
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
    }
    
}
