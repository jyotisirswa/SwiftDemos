//
//  CircleImage.swift
//  SwiftUIDemo
//
//  Created by Jyoti on 12/10/2022.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        if #available(iOS 15.0, *) {
            Image("turtlerock")
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
        } else {
            // Fallback on earlier versions
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
