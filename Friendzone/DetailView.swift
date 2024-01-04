//
//  DetailView.swift
//  Friendzone
//
//  Created by Macmaurice Osuji on 4/27/23.
//

import SwiftUI

struct DetailView: View {
    // @ObservedObject is only telling the view that another view has established it alredy
    
    let person: Person
    
    @State private var showFriends = false
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    Image("dp")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(Circle())
                    if person.isActive == true {
                        Image(systemName: "circle.fill")
                            .foregroundColor(.green)
                            .offset(x: +40, y: +60)
                    }
                }
                Text(person.name)
                    .font(.system(size: 30, weight: .medium, design: .rounded))
                HStack {
                    Text("Age:")
                    Text("\(person.age)")
                        .font(.headline)
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 50)
            .background(.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 110))
            .shadow(color: Color.black.opacity(0.5), radius: 10, y: 5)
            
            Spacer(minLength: 40)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(logo(name: "briefcase.fill")) Works at")
                    Text(person.company)
                        .font(.headline)
                }
                HStack {
                    Text("\(logo(name: "clock.fill")) Joined")
                    Text(person.joinDate)
                        .font(.headline)
                }
                HStack {
                    Text("\(logo(name: "wave.3.forward.circle.fill")) Followed by")
                    Text("\(person.followers)")
                        .font(.headline)
                }
                Text("\(logo(name: "envelope.fill")) \(person.email)")
                Text("\(logo(name: "house.fill")) \(person.address)")
                    .font(.headline)
            }
            .padding(5)
            
            
            VStack(alignment: .leading) {
                Text("About")
                    .font(.headline)
                Spacer()
                Text(person.about)
                    .italic()
                Spacer()
                
            }
            .padding()
           
            VStack {
                Text("Tags")
                    .font(.headline)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(person.tags, id: \.self){
                            Text("\($0)".capitalized)
                                .padding()
                                  .background(
                                    Capsule()
                                        .stroke(Color(.blue), lineWidth: 4)
                                      .padding(6)
                                  )
                        }
                    }
                   
                }
                Spacer(minLength: 20)
                
                VStack(alignment: .leading) {
                    Button("Friends of \(person.name)") {
                        showFriends.toggle()
                    }
                    .buttonStyle(.bordered)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    
                    if showFriends == true {
                        ForEach(person.friends, id: \.id) { friend in
                            HStack {
                                Image("dp")
                                    .resizable()
                                    .frame(width: 55, height: 50)
                                    .clipShape(Capsule())
                                
                                Text(friend.name)
                                    .font(.headline)
                            
                            }
                        }
                    }
                }
            }
        }
    }
    
    func logo(name: String) -> Image {
        let displayLogo = Image(systemName: name)
        return displayLogo
    }
}
