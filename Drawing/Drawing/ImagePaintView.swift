//
//  ImagePaintView.swift
//  Drawing
//
//  Created by Yemi Gabriel on 11/30/21.
//

import SwiftUI

struct ImagePaintView: View {
    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: 300, height: 300)
                .border(ImagePaint(image: Image("pexels-sebastian-voortman-214574"), scale: 0.2), width: 50)
            
            Capsule()
                .strokeBorder(ImagePaint(image: Image("pexels-sebastian-voortman-214574"), sourceRect: CGRect(x: 0, y: 0.5, width: 1, height: 0.2), scale: 0.2), lineWidth: 50)
                .frame(width: 300, height: 200)
        }
        
        
    }
}

struct ImagePaintView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintView()
    }
}
