//
//  CoreDataBootcamp.swift
//  PracticeProject
//
//  Created by Luka Vujnovac on 04.11.2021..
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    
    let container: NSPersistentContainer
    @Published var savedEntities: [FruitEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "FruitsContainer")
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loading core data \(error)")
            } 
        }
        
        fetchFruits()
    }
    
    func fetchFruits() {
        let request = NSFetchRequest<FruitEntity>(entityName: "FruitEntity")
        
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching \(error)")
        }   
    }
    
    func addFruits(text: String) {
        let newFruit = FruitEntity(context: container.viewContext)
        newFruit.name = text
        saveData()
    }
    
    func deleteFruit(indexSet: IndexSet) {
        guard let index = indexSet.first else {return}
        let entity = savedEntities[index]
        container.viewContext.delete(entity)
        
        saveData()
    }
    
    func updateFruit(entity: FruitEntity) {
        let currentName = entity.name ?? ""
        let newName = currentName + "!"
        entity.name = newName
        
        saveData()
    }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchFruits()
        }catch let error {
            print("error saving \(error)")
        }
    }
}

struct CoreDataBootcamp: View {
    
    @State private var text: String = ""
    
    @StateObject var vm = CoreDataViewModel()
    
    var body: some View {
        NavigationView{
            VStack(spacing: 20) {
                
                TextField("Add fruit here...", text: $text)
                    .font(.headline)
                    .padding(.leading)
                    .frame(height: 55)
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                Button { 
                    guard !text.isEmpty else {return}
                    vm.addFruits(text: text)
                    text = ""
                } label: { 
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .cornerRadius(10)
                    
                }
                .padding(.horizontal)

                List{
                    ForEach(vm.savedEntities) { entity in 
                        Text(entity.name ?? "No Name")
                            .onTapGesture {
                                vm.updateFruit(entity: entity)
                            }
                    }
                    .onDelete(perform: vm.deleteFruit)
                }.listStyle(PlainListStyle())
                
                Spacer()
                
            }.navigationTitle("Fruits")
        }
    }
}

struct CoreDataBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataBootcamp()
    }
}

