//
//  DowloadWithCombine.swift
//  PracticeProject
//
//  Created by Luka Vujnovac on 15.11.2021..
//

import SwiftUI
import Combine

struct PostModel: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCobineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        
        //combine steps
        /*
        // 1. create the publisher
        // 2. subscribe publisher on background thread
        // 3. recieve on main thread
        // 4. tryMap (check that data is good)
        // 5. decode (data into PostModels)
        // 6. sync (put the item into app)
        // 7. store (cancel subscription if needed)
        */
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap(handleOutput)
            .decode(type: [PostModel].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] returnedPosts in
                self?.posts = returnedPosts
            })
            .store(in: &cancellables)
    }
    
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard 
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
            }
        return output.data
    }
}

struct DowloadWithCombine: View {
    
    @StateObject var vm = DownloadWithCobineViewModel()
    
    var body: some View {
        List{
            ForEach(vm.posts) { post in  
                VStack(alignment: .leading){
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: . leading)
            }
        }.listStyle(PlainListStyle())
    }
}

struct DowloadWithCombine_Previews: PreviewProvider {
    static var previews: some View {
        DowloadWithCombine()
    }
}
