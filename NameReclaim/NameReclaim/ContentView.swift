//
//  ContentView.swift
//  NameReclaim
//

import SwiftUI
import CoreData


struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.number, ascending: true)],
        animation: .default)
    
    private var items: FetchedResults<Item>
    
    @State private var addNameView = false
    
    private func reSort() {
        return
    }
    
    var body: some View {
        
        NavigationView {
            
            
            List {
                
                ForEach(items) { item in
                    NavigationLink {
                        
                        NameView(myItem: item)
                        
                        
                    }
                    label: {
                        Text(item.name!)
                    }
                    .navigationTitle("NameReclaim")
                    .sheet(isPresented: $addNameView) {
                        AddNameView(myItem: item)
                    }
                }
                .onMove(perform: moveItem)
                .onDelete(perform: deleteName)
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: {
                        addNameView.toggle()
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
                
            }
            
            Text("Select an item")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    
    private func name_and_number(myItem: Item) -> String {
        return "Hello World"
    }
    
    private func moveItem(at sets: IndexSet, destination: Int) {
        let itemToMove = sets.first!
        
        if itemToMove < destination {
            var startIndex = itemToMove + 1
            let endIndex = destination - 1
            var startOrder = items[itemToMove].number
            while startIndex <= endIndex {
                items[startIndex].number = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            items[itemToMove].number = startOrder
        }
        else if itemToMove > destination {
            var startIndex = destination
            let endIndex = itemToMove - 1
            var startOrder = items[destination].number + 1
            let newOrder = items[destination].number
            while startIndex <= endIndex {
                items[startIndex].number = startOrder
                startOrder = startOrder + 1
                startIndex = startIndex + 1
            }
            items[itemToMove].number = newOrder
        }
    }
    
    private func deleteName(at offset:IndexSet) {
        withAnimation {
            offset.map {
                items[$0]
            }.forEach(viewContext.delete)
        }
    }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = "New Name"
            newItem.profile = String()
            newItem.photo = String()
            newItem.location = String()
            newItem.time = String()
            newItem.physical = String()
            newItem.details = String()
            tempNum += 1
            newItem.number = tempNum
            
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func nameString(item: Item) -> String {
        var returnString = ""
        let profileString = "Social Media Profile: \(String(describing: item.profile))"
        returnString += profileString
        returnString += "\n"
        
        let photoString = "Photo: \(String(describing: item.photo))"
        returnString += photoString
        returnString += "\n"
        
        let locationString = "Location: \(String(describing: item.location))"
        returnString += locationString
        returnString += "\n"
        
        let timeString = "Time: \(String(describing: item.time))"
        returnString += timeString
        returnString += "\n"
        
        let physicalString = "Description: \(String(describing: item.physical))"
        returnString += physicalString
        returnString += "\n"
        
        let detailString = "Detalis: \(String(describing: item.details))"
        returnString += detailString
        returnString += "\n"
        
        return returnString
    }
    
}
    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
