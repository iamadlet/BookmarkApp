//
//  BottomSheetView.swift
//  Bookmark App
//
//  Created by Адлет Жумагалиев on 13.03.2025.
//

import SwiftUI

struct BottomSheetView: View {
    @Binding var bookmarks: [Bookmark]
    @Environment(\.dismiss) var dismiss
    @Binding var title: String
    @Binding var link: String
    @Binding var isBottomSheetPresented: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
                
            Button(action: {
                isBottomSheetPresented.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 14, height: 14)
                    .foregroundStyle(.black)
            })
            .padding(.leading, 334)
            .padding(.bottom, 16)
            
            
            Text("Title")
                .padding(.bottom, 12)
            
            TextField("Bookmark title", text: $title)
                .padding(.leading, 16)
                .frame(width: 358, height: 46)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.bottom, 16)
            
            Text("Link")
                .padding(.bottom, 12)

            TextField("Bookmark link (URL)", text: $link)
                .padding(.leading, 16)
                .frame(width: 358, height: 46)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(12)
                .padding(.bottom, 24)
            
            Button(action: {
                saveBookmark()
                print(bookmarks)
                title = ""
                link = ""
            }, label: {
                Text("Save")
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 358, height: 58)
                    .background(Color.black)
                    .cornerRadius(16)
            })
        }
//        .frame(width: 390, height: 362)
    }
    
    private func saveBookmark() {
        guard !title.isEmpty, !link.isEmpty else { return }
        
        let newBookmark = Bookmark(title: title, link: link)
        bookmarks.append(newBookmark) // Update list
        
        StorageManager.shared.save(bookmarks) // Save to storage
        
        dismiss()
    }
}

#Preview {
    BottomSheetView(bookmarks: .constant([]), title: .constant(""), link: .constant(""), isBottomSheetPresented: .constant(true))
}
