//
//  ProfileView.swift
//  NeoChat
//
//  Created by Shreyas on 23/10/25.
//

import SwiftUI

struct ProfileView: View {

    @State private var showSettings: Bool = false
    @State private var showCreateAvatarView: Bool = false
    @State private var isLoading: Bool = true
    @State private var currentUser: UserModel? = .mock
    @State private var myAvatars: [AvatarModel] = []
    var body: some View {
        NavigationStack {
            List {
                myInfoSection
                myAvatarsSection
            }
                .navigationTitle("Profile")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        settingsButton
                    }
                }
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        .fullScreenCover(isPresented: $showCreateAvatarView) {
            CreateAvatarView()
        }
        .task {
            await loadData()
        }
    }
    
    private var settingsButton: some View {
        Image(systemName: "gear")
            .font(.headline)
            .foregroundStyle(.accent)
            .anyButton {
                onSettingsButtonTapped()
            }
    }

    private func loadData() async {
        try? await Task.sleep(for: .seconds(3))
        isLoading = false
        myAvatars = AvatarModel.mocks
    }

    private var myInfoSection: some View {
        Section {
            ZStack {
                Circle()
                    .fill(currentUser?.profileColorCalculated ?? .accent)

            }
            .frame(width: 100, height: 100)
            .frame(maxWidth: .infinity)
            .removeListFormatting()
        }
    }

    private var myAvatarsSection: some View {
        Section {
            if myAvatars.isEmpty {
                Group {
                    if isLoading {
                        ProgressView()
                    } else {
                        Text("Click + to create an Avatar")
                    }
                }
                    .removeListFormatting()
                    .padding(50)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color.secondary)
                    .font(.body)
            } else {
                ForEach(myAvatars, id: \.self) { avatar in
                    CustomListCellView(
                        imageName: avatar.profileImageName,
                        title: avatar.name,
                        subtitle: nil
                    )
                    .anyButton(.highlight, action: {

                    })
                    .removeListFormatting()
                }
                .onDelete(perform: deleteAvatars)
            }
        } header: {
            HStack(spacing: 0) {
                Text("MY AVATARS")
                Spacer()

                Image(systemName: "plus.circle.fill")
                    .font(.title)
                    .foregroundStyle(Color.accent)
                    .anyButton {
                        showCreateAvatarView = true
                    }
            }
        }

    }

    private func onSettingsButtonTapped() {
        showSettings = true
    }

    private func onNewAvatarButtonTapped() {
        showCreateAvatarView = true
    }

    private func deleteAvatars(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        myAvatars.remove(atOffsets: indexSet)
    }
}

#Preview {
    ProfileView()
        .environment(AppState())
}
