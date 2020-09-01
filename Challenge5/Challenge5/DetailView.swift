//
//  DetailView.swift
//  Challenge5
//
//  Created by Денис Мусатов on 19.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI

struct DetailView: View {
    
    let user: User
    @State var showInfo = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                    HStack {
                        ZStack {
                            Circle()
                                .fill(Color.gray)
                                .frame(width: UIScreen.main.bounds.width / 4)
                                .overlay(Circle().stroke(Color.primary, lineWidth: 2))
                            Image(systemName: "photo")
                                .scaledToFit()
                                .font(.title)
                                .opacity(0.6)
                                .foregroundColor(.primary)
                        }.frame(height: UIScreen.main.bounds.width / 4)
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.system(size: 23))
                                .bold()
                            Text("Расскажите о себе")
                                .foregroundColor(.blue)
                                .bold()
                            HStack {
                                Text(user.online)
                                Image(systemName: "phone")
                            }.font(.headline)
                            
                            
                        }.padding(.horizontal)
                        
                        Spacer()
                    }.padding()
                    Divider()
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "house")
                                .offset(y: -2)
                            Text("Address: \(user.address)")
                        }
                        
                        HStack {
                            Image(systemName: "info.circle.fill")
                            Text("Detail information")
                                .bold()
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        self.showInfo.toggle()
                                    }
                            }
                            
                        }
                        .padding(.vertical)
                        .foregroundColor(.blue)
                        
                    }
                    .padding()
                
                    
                    
                    Spacer()
                    .navigationBarTitle("\(user.name)", displayMode: .inline)
                    .navigationBarBackButtonHidden(false)
                        .navigationBarHidden(false)
            }
            
            if showInfo {
                Color
                    .black.edgesIgnoringSafeArea(.all)
                    .opacity(0.6)
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.white)
                        .edgesIgnoringSafeArea(.all)
                        .shadow(radius: 20)
                    VStack {
                        InfoView(user: user, showInfo: $showInfo)
                        .transition(.moveLikeJagger)
                            
                    }
                    
                        //.animation(.default)
                }
            
                .offset(y:50)
            }
        }
    }
}

extension AnyTransition {
    static var moveLikeJagger: AnyTransition {
        let insert = AnyTransition.move(edge: .bottom).combined(with: .opacity)
        let remove = AnyTransition.move(edge: .top).combined(with: .opacity)
        return .asymmetric(insertion: insert, removal: remove)
    }
}

struct DetailView_Previews: PreviewProvider {
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
        DetailView(user: user)
    }
}
