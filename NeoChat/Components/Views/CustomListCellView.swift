//
//  CustomListCellView.swift
//  NeoChat
//
//  Created by Shreyas on 03/11/25.
//

import SwiftUI

struct CustomListCellView: View {
    var imageName: String? = Constants.randomImageURL
    var title: String? = "Alpha"
    var subtitle: String? = "An Alien that is smiling in the park"

    var body: some View {
        HStack(spacing: 8) {
            ZStack {
                if let imageName {
                    ImageLoaderView(urlString: imageName)
                } else {
                    Rectangle()
                        .fill(Color.secondary.opacity(0.5))
                }
            }
            .aspectRatio(1, contentMode: .fit)
            .frame(height: 60)
            .cornerRadius(16)

            VStack(alignment: .leading) {
                if let title {
                    Text(title)
                        .font(.headline)
                }

                if let subtitle {
                    Text(subtitle)
                        .font(.subheadline)
                }
            }
        }
        .padding(12)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .systemBackground))
    }
}

#Preview {

    VStack {
        CustomListCellView()
        CustomListCellView(title: nil)
        CustomListCellView(subtitle: nil)
        CustomListCellView(imageName: nil)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.secondary)

}
