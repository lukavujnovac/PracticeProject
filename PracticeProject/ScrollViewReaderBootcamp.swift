//
//  ScrollViewReaderBootcamp.swift
//  PracticeProject
//
//  Created by Luka Vujnovac on 25.10.2021..
//

import SwiftUI

struct ScrollViewReaderBootcamp: View {
    
    @State private var textFieldText: String = ""
    @State private var scrollToIndex: Int = 0
    
    var body: some View {
        VStack {
            
            TextField("Enter a # here", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
            
            Button("SCROLL NOW") {
                withAnimation(.default) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    } 
                    
//                    proxy.scrollTo(49, anchor: .bottom)
                }
            }
            
            ScrollView{
                ScrollViewReader{ proxy in 
                    ForEach(0..<50) { index in
                        Text("this is item number #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { newValue in
                        withAnimation(.default) {
                            proxy.scrollTo(newValue, anchor: nil)   
                        }
                    }
                }
            }
        }
    }
}

struct ScrollViewReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewReaderBootcamp()
    }
}
