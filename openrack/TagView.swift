//
//  TagView.swift
//  openrack
//
//  Created by Ayman Ali on 06/04/2023.
//

import SwiftUI

struct TagView: View {
    let tags = ["Trading Cards", "Sports", "Toys & Hobbies", "Comics & Manga", "Coins & Money", "Men's Fashion", "Women's Fashion", "Steetwear", "Sneakers", "Vintage"]
    @State var selectedTags: Set<String> = []

    var body: some View {
        VStack {
            HStack {
                Text("Selected tags: ")
                Text(selectedTags.sorted().joined(separator: ", "))
            }
            .padding()

            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(tags, id: \.self) { tag in
                    Toggle(tag, isOn: Binding(
                        get: { self.selectedTags.contains(tag) },
                        set: { isOn in
                            if isOn {
                                self.selectedTags.insert(tag)
                            } else {
                                self.selectedTags.remove(tag)
                            }
                        }
                    ))
                    .toggleStyle(TagToggleStyle())
                }
            }
            .padding()
        }
    }
}

struct TagToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.label
        } icon: {
//            Image(systemName: configuration.isOn ? "tag.fill" : "tag")
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .foregroundColor(.white)
        .background(configuration.isOn ? Color.blue : Color.gray)
        .cornerRadius(8)
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}
struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView()
    }
}
