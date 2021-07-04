//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Yemi Gabriel on 7/1/21.
//

import SwiftUI

//MARK: Extracted View
struct RoundedText: View {
    var text: String
    var body: some View {
        Text(text)
            .padding()
            .font(.title)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

//MARK: Custom Modifier
struct BrandTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .font(.title)
            .foregroundColor(.blue)
            .padding()
            .background(Color.yellow)
    }
}

struct WaterMark: ViewModifier {
    var text: String
    func body(content: Content) -> some View {
        ZStack (alignment: .bottomTrailing) {
            content
            
            Text(text)
                .padding(5)
                .foregroundColor(.white)
                .background(Color.black)
        }
    }
}

extension View {
    func brandTitleStyle() -> some View {
        modifier(BrandTitle())
    }
    
    func watermarked(with text: String) -> some View {
        modifier(WaterMark(text: text))
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            RoundedText(text: "Hello World")
                .background(Color.red)
            RoundedText(text: "Hey, human!")
                .background(Color.blue)
            Text("Auld Lang Syne")
                .fontWeight(.heavy)
                .underline(true, color: /*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                .modifier(BrandTitle())
            
            Text("We'll take a cup of kindness yet!")
                .fontWeight(.heavy)
                .underline(true, color: Color.black)
                .brandTitleStyle()
            
            Color.purple
                .frame(width: 400, height: 300)
//                .modifier(WaterMark(text: "I am Yemi"))
                .watermarked(with: "Yemi Gabriel")
            
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
