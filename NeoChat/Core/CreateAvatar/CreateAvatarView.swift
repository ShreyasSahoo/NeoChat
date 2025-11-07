//
//  CreateAvatarView.swift
//  NeoChat
//
//  Created by Shreyas on 06/11/25.
//

import SwiftUI

struct CreateAvatarView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var avatarName: String = ""
    @State private var characterOption: CharacterOption = .default
    @State private var characterAction: CharacterAction = .default
    @State private var characterLocation: CharacterLocation = .default

    @State private var isGenerating: Bool = false
    @State private var generatedImage: UIImage?

    @State private var isSaving: Bool = false

    var body: some View {
        NavigationStack {
            List {
                nameSection
                attributesSection
                imageSection
                saveSection
            }
            .navigationTitle("Create Avatar")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    backButton
                }
            }
        }
    }

    private var backButton: some View {
        Image(systemName: "xmark")
            .foregroundStyle(.accent)
            .font(.title2)
            .fontWeight(.semibold)
            .anyButton {
                onBackButtonTapped()
            }
    }

    private var nameSection: some View {
        Section {
            TextField("Player 1", text: $avatarName)
        } header: {
            Text("NAME YOUR AVATAR*")
        }
    }

    private var attributesSection: some View {
        Section {
            Picker("Is a...", selection: $characterOption) {
                ForEach(CharacterOption.allCases, id: \.self) { option in
                    Text(option.rawValue.capitalized)
                        .tag(option)
                }
            }

            Picker("That is...", selection: $characterAction) {
                ForEach(CharacterAction.allCases, id: \.self) { action in
                    Text(action.rawValue.capitalized)
                        .tag(action)
                }
            }

            Picker("in the...", selection: $characterLocation) {
                ForEach(CharacterLocation.allCases, id: \.self) { location in
                    Text(location.rawValue.capitalized)
                        .tag(location)
                }
            }
        } header: {
            Text("ATTRIBUTES")
        }
    }

    private var imageSection: some View {
        Section {
            HStack(alignment: .top, spacing: 8) {
                ZStack {
                    Text("Generate image")
                        .underline()
                        .foregroundStyle(.accent)
                        .anyButton {
                            onGenerateButtonTapped()
                        }
                        .disabled(isGenerating || avatarName.isEmpty)
                        .opacity(isGenerating ? 0 : 1)

                    ProgressView()
                        .tint(.accent)
                        .opacity(isGenerating ? 1 : 0)
                }
                Circle()
                    .fill(.secondary.opacity(0.3))
                    .overlay {
                        ZStack {
                            if let generatedImage {
                                Image(uiImage: generatedImage)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                    .clipShape(Circle())
            }
            .removeListFormatting()
            .padding(8)
        }
    }

    private var saveSection: some View {
        AsyncCallToActionButton(
            isLoading: isSaving,
            action: onSaveButtonTapped
        )
        .removeListFormatting()
        .opacity(isSaving || generatedImage == nil ? 0.5 : 1)
        .disabled(isSaving || generatedImage == nil)
    }

    private func onGenerateButtonTapped() {
        isGenerating = true

        Task {
            try? await Task.sleep(for: .seconds(3))
            generatedImage = UIImage(systemName: "star.fill")

            isGenerating = false
        }
    }

    private func onSaveButtonTapped() {
        isSaving = true

        Task {
            try? await Task.sleep(for: .seconds(3))
            generatedImage = UIImage(systemName: "star.fill")

            isSaving = false
            dismiss()
        }
    }

    private func onBackButtonTapped() {
        dismiss()
    }
}

#Preview {
    CreateAvatarView()
}
