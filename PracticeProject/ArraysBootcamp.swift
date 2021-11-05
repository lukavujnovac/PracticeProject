//
//  ArraysBootcamp.swift
//  PracticeProject
//
//  Created by Luka Vujnovac on 31.10.2021..
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVertified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        //sort
        /*
//        filteredArray = dataArray.sorted { (user1, user2) -> Bool in
//            return user1.points > user2.points
//        }
        filteredArray = dataArray.sorted(by: {$0.points > $1.points})
        */
        
        //filter
        /*
//        filteredArray = dataArray.filter({ user in
//            return user.isVertified
//        })
        
        filteredArray = dataArray.filter({$0.isVertified})
        */
        
        //map
        /*
//        mappedArray = dataArray.map({ (user) -> String in
//            return user.name
//        })
//        
//        mappedArray = dataArray.map({$0.name})
        
        //mapped array se koristi kad radis sa optionalsima
//        mappedArray = dataArray.compactMap({ user in
//            return user.name
//        })
        mappedArray = dataArray.compactMap({$0.name})
         */
        
        mappedArray = dataArray
            .sorted(by: {$0.points > $1.points})
            .filter({$0.isVertified})
            .compactMap({$0.name})
        
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Luka", points: 5, isVertified: true)
        let user2 = UserModel(name: nil, points: 4, isVertified: false)
        let user3 = UserModel(name: "Ivan", points: 6, isVertified: true)
        let user4 = UserModel(name: "Stipe", points: 8, isVertified: false)
        let user5 = UserModel(name: nil, points: 12, isVertified: true)
        let user6 = UserModel(name: "Patrick", points: 14, isVertified: false)
        let user7 = UserModel(name: "Sponge Bob", points: 1, isVertified: true)
        let user8 = UserModel(name: "Kleopatra", points: 2, isVertified: false)
        let user9 = UserModel(name: "Joe", points: 30, isVertified: true)
        let user10 = UserModel(name: "Mama", points: 5, isVertified: false)
        
        self.dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10
        ])
    }
}

struct ArraysBootcamp: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                ForEach(vm.mappedArray, id: \.self) { name in 
                    Text(name)
                        .font(.title)
                }
                
                
                /*
//                ForEach(vm.filteredArray) { user in  
//                    VStack(alignment: .leading){
//                        Text((user.name))
//                            .font(.headline)
//                        HStack{
//                            Text("points: \(user.points)")
//                            Spacer()
//                            if user.isVertified {
//                                Image(systemName: "flame.fill")
//                            }
//                        }
//                    }
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.blue.cornerRadius(10))
//                    .padding(.horizontal)
//                }
                 */
            }
        }
    }
}

struct ArraysBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ArraysBootcamp()
    }
}