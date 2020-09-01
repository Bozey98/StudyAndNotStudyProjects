//
//  DetailView.swift
//  NewBook11
//
//  Created by Денис Мусатов on 15.06.2020.
//  Copyright © 2020 Денис Мусатов. All rights reserved.
//

import SwiftUI
import CoreData

struct DetailView: View {
    
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var moc
    @State private var showAlert = false
    
    let book: Book
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geo.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                Spacer()
                Text("You read it in \(self.showDate())")
                    .font(.headline)
            }
        }.alert(isPresented: $showAlert) {
            Alert(title: Text("Delete book"), message: Text("Are you sure?"),
                  primaryButton: .destructive(Text("Delete")) {
                    self.deleteBook()
                },
                  secondaryButton: .cancel())
        }
        .navigationBarTitle(Text(book.title ?? "Unknown book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showAlert = true
        }){
            Image(systemName: "trash")
        })
    }
    
    func deleteBook() {
        moc.delete(book)
        presentation.wrappedValue.dismiss()
    }
    
    func showDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: book.date ?? Date())
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        book.date = Date()
        return DetailView(book: book)
    }
}
