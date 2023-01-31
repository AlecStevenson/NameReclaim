//
//  AddNameView.swift
//  NameReclaim
//
//  Created by alec stevenson on 11/28/22.
//

import SwiftUI
import CoreData

struct AddNameView: View {
    let myItem: Item
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var Contact = ""
    
    @FetchRequest(sortDescriptors: []) private var items:FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Add Name", text: $Contact)
                Button(action: {
                    saveName()
                    dismiss()
                }, label: {
                    Text("Save Name").frame(minWidth: 0, maxWidth: .infinity)
                }
                )
            }
            .navigationTitle("Add Name")
        }
    }
    
    private func saveName() {
        let newItem = Item(context: viewContext)
        newItem.name = Contact
        newItem.profile = String()
        newItem.photo = String()
        newItem.location = String()
        newItem.time = String()
        newItem.physical = String()
        newItem.details = String()
        newItem.storedImage = Data()
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
}
