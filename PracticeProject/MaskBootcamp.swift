//
//  MaskBootcamp.swift
//  PracticeProject
//
//  Created by Luka Vujnovac on 29.10.2021..
//

import SwiftUI

struct MaskBootcamp: View {
    
    @State private var rating: Int = 0
    
    var body: some View {
        ZStack{
            starsView
                .overlay(overlayView.mask(starsView))
        }
    }
    private var starsView: some View {
        HStack{
            ForEach(1..<6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index   
                        }
                    }
            }
        }
    }
    
    private var overlayView: some View {
        GeometryReader{ geometry in 
            ZStack(alignment: .leading){
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            }
        }.allowsHitTesting(false)
    }
}

struct MaskBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MaskBootcamp()
    }
}
