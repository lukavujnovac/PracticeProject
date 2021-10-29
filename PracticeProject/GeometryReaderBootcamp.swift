//
//  GeometryReaderBootcamp.swift
//  PracticeProject
//
//  Created by Luka Vujnovac on 28.10.2021..
//

import SwiftUI

struct GeometryReaderBootcamp: View {
    
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }
    
    var body: some View {
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack{
                ForEach(0..<20) { index in 
                    GeometryReader{ geometry in 
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0))
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                } 
            }
        }

        
        
        
//        GeometryReader { geometry in 
//            HStack(spacing: 0){
//                Rectangle()
//                    .fill(Color.red)
//                Rectangle()
//                    .fill(Color.blue)
//                    .frame(width: geometry.size.width * 0.6666)
//            }
//            .ignoresSafeArea()
//        }
    }
}

struct GeometryReaderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderBootcamp()
    }
}