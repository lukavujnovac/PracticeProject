//
//  TimerBootcamp.swift
//  PracticeProject
//
//  Created by Luka Vujnovac on 15.11.2021..
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 3.0, on: .main, in: .common).autoconnect()
    
    //current time
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        return formatter
    }
    */
    
    // Countdown
    /*
    @State var count: Int = 10
    @State var finishedText: String? = nil
    */
    
    //Countdown to date
    /*
    @State var timeRemaining: String = "" 
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        
        timeRemaining = "\(hour):\(minute):\(second)"
    }
    */
    
    //animation counter
    @State var count: Int = 1
    
    var body: some View {
        ZStack{
            RadialGradient(colors: [Color.purple, Color.blue], center: .center, startRadius: 5, endRadius: 500)
                .ignoresSafeArea()
            
            TabView(selection: $count) { 
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(5)
            }
            .frame(height: 200)
            .tabViewStyle(PageTabViewStyle())
            
            //loading animation
            /*
            HStack(spacing: 15){
                Circle()
                    .offset(y: count == 1 ? -20 : 0)
                Circle()
                    .offset(y: count == 2 ? -20 : 0)
                Circle()
                    .offset(y: count == 3 ? -20 : 0)
            }
            .frame(width: 150)
            .foregroundColor(.white)
             */
        }
        .onReceive(timer, perform: { _ in
            withAnimation(.default) {
                count = count == 5 ? 1 : count + 1
            }
        })
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
