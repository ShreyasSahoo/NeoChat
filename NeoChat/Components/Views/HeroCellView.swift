//
//  HeroCellView.swift
//  NeoChat
//
//  Created by Shreyas on 25/10/25.
//

import SwiftUI

struct HeroCellView: View {

    var title: String? = "This is the title"
    var subtitle: String? = "This is the subtitle"
    var imageName: String? = Constants.randomImageURL
    var cornerRadius: CGFloat = 24

    var body: some View {
        VStack {
            if let imageName = imageName {
                ImageLoaderView(urlString: imageName, aspectRatio: .fill)
            } else {
                Color.accent
            }
        }
        .overlay(alignment: .bottomLeading) {
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
            .foregroundStyle(.white)
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .addBackgroundGradientForText()
        }
        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
}

#Preview {
    ScrollView {
        VStack(spacing: 16){
            HeroCellView()
                .frame(width: 350, height: 200)

            HeroCellView(cornerRadius: 0)
                .frame(width: 200, height: 400)

            HeroCellView(title: nil, subtitle: nil)
                .frame(width: 350, height: 200)
        }
    }
    .scrollIndicators(.hidden)
}
