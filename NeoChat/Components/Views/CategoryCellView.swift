//
//  CategoryCellView.swift
//  NeoChat
//
//  Created by Shreyas on 01/11/25.
//

import SwiftUI

struct CategoryCellView: View {
    var image: String = Constants.randomImageURL
    var text: String = "Alien"
    var cornerRadius: CGFloat = 10

    var body: some View {
        ImageLoaderView(urlString: image)
            .aspectRatio(1, contentMode: .fit)
            .overlay(alignment: .bottomLeading) {
                Text(text)
                    .padding(8)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .addBackgroundGradientForText()
            }
            .cornerRadius(cornerRadius)
    }
}

#Preview {
    VStack {
        CategoryCellView()
            .frame(width: 150, height: 150)

        CategoryCellView()
            .frame(width: 300, height: 300)
    }
}
