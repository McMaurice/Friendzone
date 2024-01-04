//
//  ContentView.swift
//  Friendzone
//
//  Created by Macmaurice Osuji on 4/26/23.
//

import SwiftUI

struct ContentView: View {
    /// @StateObject is used to create a class instatnce to re-use
    @StateObject var project = Project()
    
    var body: some View {
        NavigationView {
            List(project.persons, id: \.id) { person in
                NavigationLink {
                    DetailView(person: person)
                } label: {
                    HStack {
                        ZStack {
                            Image("dp")
                                .resizable()
                                .frame(width: 55, height: 50)
                                .clipShape(Capsule())
                            if person.isActive == true {
                                Image(systemName: "circle.fill")
                                    .foregroundColor(.green)
                                    .offset(x: +10, y: +12)
                            }
                        }
                        Text(person.name)
                            .font(.headline)
                            
                        Spacer()
                        
                        if person.isActive == true {
                            Text("online")
                                .foregroundColor(.green)
                        } else {
                            Text(person.lastSeen)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .navigationTitle("Friends")
            .task {
                if project.persons.isEmpty {
                    await loadData()
                }
            }
        }
    }

    func loadData() async {
        // create url
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        // fetch data from url
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode the data
            if let decodedResponse = try? JSONDecoder().decode([Person].self, from: data) {
                project.persons = decodedResponse
            }
        } catch {
            print("Invalid data")
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
