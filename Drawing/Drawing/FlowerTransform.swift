//
//  MoreContent.swift
//  Drawing
//
//  Created by Yemi Gabriel on 11/23/21.
//

import SwiftUI

//CGAffineTransform: describes how a path or view should be rotated, scaled, or sheared
struct Flower: Shape {
    var petalOffset = -20.0
    var petalWidth = 100.0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Count from 0 up to pi * 2, moving up pi / 8 each time
        for number in stride(from: 0, to: Double.pi * 2, by: Double.pi/8) {
            let rotation = CGAffineTransform(rotationAngle: CGFloat(number))
            let position = rotation.concatenating(CGAffineTransform(translationX: rect.width/2, y: rect.height/2))

            let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: Double(rect.width)/2) )
            let rotatedPetal = originalPetal.applying(position)

            path.addPath(rotatedPetal)
        }

        return path
    }
}

struct FlowerTransform: View {
    @State var petalOffset = -20.0
    @State var petalWidth = 100.0
    
    var body: some View {
        VStack {
            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                .stroke(Color.red, lineWidth: 1.0)
                .fill(Color.blue, style: FillStyle(eoFill: true)) //even-odd fill
            
            Text("Offset")
            Slider(value: $petalOffset, in: -40...40)
                .padding([.horizontal, .bottom])
            
            Text("Width")
            Slider(value: $petalWidth, in: 0...100)
                .padding(.horizontal)
            
        }
    }
}

struct FlowerTransform_Previews: PreviewProvider {
    static var previews: some View {
        FlowerTransform()
    }
}
