//
//  ContentView.swift
//  CustomAlert
//
//  Created by Marwa Abou Niaaj on 25/01/2024.
//

import SwiftUI

struct Book: Identifiable, Hashable {
    var id: UUID { UUID() }
    var title: String
    var author: String
}

struct ContentView: View {

    @State private var books = [
        Book(title: "Atomic Habits", author: "James Clear"),
        Book(title: "Start With Why", author: "Simon Sinek"),
        Book(title: "Think Like A Monk", author: "Jay Shetty"),
        Book(title: "Limitless", author: "Jim Kwik")
    ]

    @State private var randomBook: Book?
    @State private var selectedBook: Book?

    @State private var showAlert = false
    @State private var showCreditAlert = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Button {
                    randomBook = books.randomElement()
                    showAlert = true
                } label: {
                    Label("Show Random Book", systemImage: "books.vertical.fill")
                        .imageScale(.large)
                        .controlSize(.large)
                }

                if let selectedBook {
                    HStack {
                        Text("\(selectedBook.title ) by ")
                        +
                        Text("\(selectedBook.author )")
                            .bold()
                    }
                } else {
                    Text("No book is selected yet!")
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .padding()
            .toolbar {
                Button {
                    showCreditAlert = true
                } label: {
                    Label("Show credit", systemImage: "person.bubble")
                }

                Button {
                    print("Add tapped")
                } label: {
                    Label("Add book", systemImage: "plus")
                }
            }
//            .alert(
//                "Random Book",
//                isPresented: $showAlert,
//                presenting: randomBook
//            ) { book in
//                Button("Done") {
//                    selectedBook = book
//                }
//            } message: { book in
//                Text("You have selected \(book.title) by \(book.author)")
//            }
            .customAlert(
                "Random Book",
                isPresented: $showAlert,
                presenting: randomBook,
                actionText: "Yes, Done"
            ) { book in
                selectedBook = book
            } message: { book in
                Text("You have selected \(book.title) by \(book.author)")
            }
            .customAlert(
                "Credits",
                isPresented: $showCreditAlert,
                actionText: "OK"
            ) {
                // TODO: OK Action
            } message: {
                Text("This custom alert tutorial was implemented by **Marwa**.")
            }

        }
    }
}

#Preview {
    ContentView()
}
