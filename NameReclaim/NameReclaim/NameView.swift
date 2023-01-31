//
//  NameView.swift
//  NameReclaim
//

import SwiftUI
import CoreData

struct NameView: View {
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var isImagePickerDisplay = false
    @State private var selectedImage: UIImage?
    
    
    
    let myItem: Item
    
    @State private var name: String
    @State private var profile: String
    @State private var photo: String
    @State private var location: String
    @State private var time: String
    @State private var physical: String
    @State private var details: String
    @State private var storedImage: Data
    
    init(myItem: Item) {
        self.myItem = myItem
        
        self._name = State(initialValue: myItem.name ?? "")
        self._profile = State(initialValue: myItem.profile ?? "")
        self._photo = State(initialValue: myItem.photo ?? "")
        self._location = State(initialValue: myItem.location ?? "")
        self._time = State(initialValue: myItem.time ?? "")
        self._physical = State(initialValue: myItem.physical ?? "")
        self._details = State(initialValue: myItem.details ?? "")
        self._storedImage = State(initialValue: myItem.storedImage ?? Data())
    }
    @Environment(\.managedObjectContext) private var viewContext
    @State private var editNameView = false
    
    func setVals(myItem: Item, attribute: String, val: String) {
        if(attribute == "name") {
            myItem.name = val
        }
        if(attribute == "profile") {
            myItem.profile = val
        }
        if(attribute == "photo") {
            myItem.photo = val
        }
        if(attribute == "location") {
            myItem.location = val
        }
        if(attribute == "time") {
            myItem.time = val
        }
        if(attribute == "physical") {
            myItem.physical = val
        }
        if(attribute == "details") {
            myItem.details = val
        }
        return
        
    }
    
    func prepopulate(myItem: Item, attribute: String, val: String) -> String {
        
        if(val == "New Name") {
            return ""
        }
        else {
            return val
        }
        
    }
    
    func submitIt() {
        setVals(myItem: self.myItem, attribute: "name", val: String(name))
        setVals(myItem: self.myItem, attribute: "profile", val: String(profile))
        setVals(myItem: self.myItem, attribute: "photo", val: String(photo))
        setVals(myItem: self.myItem, attribute: "location", val: String(location))
        setVals(myItem: self.myItem, attribute: "time", val: String(time))
        setVals(myItem: self.myItem, attribute: "physical", val: String(physical))
        setVals(myItem: self.myItem, attribute: "details", val: String(details))
        
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
        
        return "Hello World"
    }
    
    func uiToJpeg(myImage: UIImage) -> Data? {
        let myJpeg = myImage.jpegData(compressionQuality: 1)
        return myJpeg
    }
    
    func jpegToUI(myJpeg: Data) -> UIImage? {
        let myImage = UIImage(data: myJpeg)
        return myImage
    }
    
    func saveImage(myItem: Item, myImage: UIImage) {
        
        myItem.storedImage = uiToJpeg(myImage: myImage)
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    var body: some View {
        
        
        NavigationView {
            
            
            VStack {
                
                let nameString = ContactDescription(myItem: myItem).NameTitle()
                Text(nameString)
                    .offset(y: -70)
                
                VStack {
                    
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 150, height: 150)
                            .offset(y: -20)
                        
                    } else {
                        Image(systemName: "plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .frame(width: 150, height: 150)
                            .offset(y: -20)
                    }
                    Button("Select Photo") {
                        self.sourceType = .photoLibrary
                        self.isImagePickerDisplay.toggle()
                    }.padding()
                    
                }
                .sheet(isPresented: self.$isImagePickerDisplay) {
                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                }
                
                
                Group {
                    Text(ContactDescription(myItem: myItem).Contact())
                        .offset(y: 50)
                }
                
            }
        }
        .sheet(isPresented: $editNameView) {
            EditNameView(myItem: myItem)
        }
        .toolbar {
            ToolbarItem {
                Button(action: {
                    editNameView.toggle()
                }) {
                    Label("Edit Item", systemImage: "pencil")
                }
            }
        }
        
    }
}
