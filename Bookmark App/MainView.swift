//
//  MainView.swift
//  Bookmark App
//
//  Created by Адлет Жумагалиев on 13.03.2025.
//

import SwiftUI

struct MainView: View {
    @State private var bookmarks: [Bookmark] = StorageManager.shared.load()
    @State var isBottomSheetPresented = false
    
    @State private var title = ""
    @State private var link = ""
    
    var body: some View {
        NavigationView {
            VStack {
                if bookmarks.isEmpty {
                    Text("Bookmark App")
                        .font(.system(size: 17, weight: .semibold))
                    Spacer()
                    Text("Save your first bookmark")
                        .frame(width: 358, height: 92)
                        .font(.system(size: 36, weight: .bold))
                        .multilineTextAlignment(.center)
                    Spacer()
                    Button(action: {
                        isBottomSheetPresented.toggle()
                    }, label: {
                        Text("Add bookmark")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(Color.white)
                            .frame(width: 358, height: 58)
                            .background(.black)
                            .cornerRadius(16)
                    })
                } else {
                    NavigationView {
                        VStack {
                            List {
                                ForEach(bookmarks) {bookmark in
                                    HStack {
                                        Text(bookmark.title)
                                        Spacer()
                                        Button(action: {
                                            openURL(bookmark.link)
                                        }, label: {
                                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                        })
                                    }
                                    .frame(height: 46)
                                }
                                .onDelete(perform: deleteBookmark)
                            }
                            Button(action: {
                                isBottomSheetPresented.toggle()
                            }, label: {
                                Text("Add bookmark")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundStyle(Color.white)
                                    .frame(width: 358, height: 58)
                                    .background(.black)
                                    .cornerRadius(16)
                            })
                            
                        }
                    }
                    .navigationTitle("List")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .sheet(isPresented: $isBottomSheetPresented) {
                BottomSheetView(bookmarks: $bookmarks, title: $title, link: $link, isBottomSheetPresented: $isBottomSheetPresented)
                    .presentationDetents([.height(340)])
            }
        }
    }
    
    func openURL(_ urlString: String) {
        var formattedURLString = urlString
        
        if !formattedURLString.lowercased().hasPrefix("http") {
            formattedURLString = "https://" + formattedURLString
        }
        if let url = URL(string: formattedURLString) {
            UIApplication.shared.open(url)
        } else {
            print("Invalid URL: \(formattedURLString)")
        }
    }
    
    func deleteBookmark(at offsets: IndexSet) {
        bookmarks.remove(atOffsets: offsets)
        StorageManager.shared.save(bookmarks)
    }
}

#Preview {
    MainView()
}
