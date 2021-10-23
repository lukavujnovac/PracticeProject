//
//  LongPressGestureBootcamp.swift
//  PracticeProject
//
//  Created by Luka Vujnovac on 23.10.2021..
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack{
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("CLICK HERE")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                .cornerRadius(10)
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
                    // start of press -> min duration
                    if isPressing {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            isComplete = true
                        }
                    }else {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { 
                            if !isSuccess {
                                withAnimation(.easeInOut) {
                                    isComplete = false
                                }
                            }
                        }
                    }
                } perform: { 
                    withAnimation(.default) {
                        isSuccess = true
                    }
                }


                
                Text("RESET")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                .cornerRadius(10)
                
                .onTapGesture {
                    withAnimation(.default) {
                        isSuccess = false
                        isComplete = false
                    }
                }
            }
            
        }
        
        
//        Text(isComplete ? "completed" : "not competed")
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.gray)
//            .cornerRadius(10)
//            .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { 
//                isComplete.toggle()
//            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
