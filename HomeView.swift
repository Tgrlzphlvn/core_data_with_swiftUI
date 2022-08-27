//
//  HomeView.swift
//  core-data-with-swiftUI
//
//  Created by Tuğrul Özpehlivan on 26.08.2022.
//

import SwiftUI
import CoreData

struct HomeView: View {
    
    let manager : CoreDataManager
    
    @State private var title : String = ""
    @State private var note : String = ""
    
    @State private var notes : [Notes] = [Notes]()
    
    @State private var sheetİsOn = false
    
    var body: some View {
        NavigationView {
            VStack{
                List {
                    ForEach(notes,id: \.self) { note in
                        VStack {
                            Text(note.title ?? "").fontWeight(.bold).font(.headline)
                            Text(note.note ?? "")
                        }
                    }.onDelete { indexSet in
                        indexSet.forEach { index in
                            let note = notes[index]
                            manager.delete(notes: note)
                            getDatas()
                        }
                    }
                }.sheet(isPresented: $sheetİsOn) {
                    VStack {
                        TextField("Enter the title", text: $title).padding().textFieldStyle(RoundedBorderTextFieldStyle())
                        TextField("Enter the note", text: $note).padding().textFieldStyle(RoundedBorderTextFieldStyle())
                        Button("Save") {
                            manager.save(title: title, note: note)
                            getDatas()
                            title = ""
                            note = ""
                            sheetİsOn.toggle()
                        }.padding()
                    }
                }
            }.navigationTitle("Notes")
                .toolbar {
                    ToolbarItem {
                        Button("Add Note") {
                            sheetİsOn.toggle()
                        }
                    }
                }
                .onAppear {
                    getDatas()
                }
        }
    }
    
    private func getDatas() {
        self.notes = self.manager.getNotes()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(manager: CoreDataManager())
    }
}
