//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Yemi Gabriel on 12/15/21.
//

import SwiftUI

class User: ObservableObject, Codable {
    enum CodingKeys: CodingKey {
        case name
    }
    @Published var name = "Paul Hudson"
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
    }
}

struct Response: Codable {
    let results: [Result]
}

struct Result: Codable {
    let trackId: Int
    let trackName: String
    let collectionName: String
}

struct ContentView: View {
    @State private var results = [Result]()
    @State private var username = ""
    @State private var email = ""
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    
    var body: some View {
        VStack {
            
            Form {
                Section {
                    TextField("username", text: $username)
                    TextField("email", text: $email, prompt: Text("emaiiil"))
                }
                Section {
                    Button("Create account") {
                        print("creating account")
                    }
                }
                .disabled(disableForm)
            }
            
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .scaledToFit()
                } else if phase.error != nil {
                    Text("Error loading image")
                } else {
                    ProgressView()
                }
            }
            .frame(width: 200, height: 200)
            
            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { Image in
                Image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                Color.red
            }
            .frame(width: 200, height: 200)
            
//            List(results, id: \.trackId) { item in
//                VStack(alignment: .leading) {
//                    Text(item.trackName)
//                        .font(.headline)
//
//                    Text(item.collectionName)
//
//                }
//            }
//            .task {
//                await loadData()
//            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=burna+boy&entity=song") else {
            print("Invalid URL")
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch  {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
