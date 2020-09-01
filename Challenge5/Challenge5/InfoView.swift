//
//  InfoView.swift
//  Challenge5
//
//  Created by Денис Мусатов on 19.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct InfoView: View {
    let user: User
    let users = Users()
    
    @State var showFriends = false
    @Binding var showInfo: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Spacer()
                Text("Подробнее")
                    .font(.title)
                    .bold()
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .padding(.horizontal)
                    .onTapGesture {
                        
                            self.showInfo.toggle()
                        
                }
            }
            .padding(.top)
            .foregroundColor(.black)
            
            
            ScrollView {
                Divider()
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "person.circle")
                        Text("Age: \(user.age)")
                        
                    }.foregroundColor(.gray)
                    
                    HStack {
                        Image(systemName: "envelope")
                        Text("Email: \(user.email)")
                        
                    }.foregroundColor(.gray)
                    
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        Text("Company: \(user.company)")
                        
                    }.foregroundColor(.gray)
                    
                    HStack(alignment: .top) {
                        Image(systemName: "info.circle")
                            .offset(y: 5)
                        Text("About: \(user.about)")
                        
                    }.foregroundColor(.gray)
                    
                    Button(action : {
                        
                            self.showFriends.toggle()
                        
                        
                    }) {
                        HStack{
                            Image(systemName: "person.2")
                            Text("\(user.friends.count) friends")
                            
                        }
      
                    }
                }.padding()
                
                if showFriends {
                    VStack {
                        ForEach(user.friends) { friend in
                            NavigationLink(destination: DetailView(user: self.getUserInfo(id: friend.id))) {
                                HStack {
                                    ZStack {
                                        Circle()
                                            .fill(Color.gray)
                                            .frame(
                                                width: UIScreen.main.bounds.width / 6,
                                                height: UIScreen.main.bounds.width / 6)
                                            .overlay(Circle().stroke(lineWidth: 1))
                                            .shadow(radius: 2)
                                        Image(systemName: "photo")
                                            .opacity(0.6)
                                    }
                                        
                                    VStack {
                                        Text(friend.name).font(.headline)
                                        //.padding()
                                            .offset(x: 10)
                                    }
                                    Spacer()
                                }.padding([.top, .horizontal])
                            }
                        }.foregroundColor(.black)
                        
                    }
                    
                    
                }
            }
                
            
            Spacer()
            
            
        }
    }
    
    func getUserInfo(id: String) -> User {
        return users.users.first(where: {$0.id == id}) ?? users.users[0]
    }
}

struct InfoView_Previews: PreviewProvider {
    static let user = User(
    id: "kekmem",
    isActive: true,
    name: "John Wick",
    age: 42,
    company: "Killer Company",
    email: "lovedog@gmail.com",
    address: "New York",
    about: "I am professional Killer, love guns, my dog and my wife.",
    registered: "2015-11-10T01:47:18-00:00",
    tags: [
        "cillum",
        "consequat",
        "deserunt",
        "nostrud",
        "eiusmod",
        "minim",
        "tempor"],
    friends: [Friend(id: "dfdsfdsfds", name: "Sobaka"), Friend(id: "dfsdfsfsdfsdfs", name: "Zhena")]
    )
    static var previews: some View {
        InfoView(user: user, showInfo: .constant(true))
    }
}
