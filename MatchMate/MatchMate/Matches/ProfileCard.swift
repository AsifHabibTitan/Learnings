//
//  ProfileCard.swift
//  MatchMate
//
//  Created by Asif Habib on 30/07/25.
//

import SwiftUI

struct ProfileCard: View {
    let user: ProfileModel
    let onAccept: () -> Void
    let onReject: () -> Void
    @State private var imageLoaded = false
    @State private var profileImage: UIImage?
    
    var body: some View {
        
            ZStack {
                // Background Image
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .aspectRatio(2/3, contentMode: .fill)
                
                if let image = profileImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(2/3, contentMode: .fill)
                        .clipped()
                } else {
                    ProgressView()
                        .scaleEffect(1.5)
                }
                
                // Text overlay at bottom with gradient background
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(user.fullName)
                                    .font(.headline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                
                                Text("\(user.age) years old")
                                    .font(.subheadline)
                                    .foregroundColor(.white.opacity(0.9))
                            }
                            
                            Spacer()
                            
                            // Gender indicator
                            Image(systemName: user.gender == "male" ? "mars" : "venus")
                                .foregroundColor(.white)
                                .font(.title2)
                        }
                        
                        // Location
                        HStack {
                            Image(systemName: "location.fill")
                                .foregroundColor(.white.opacity(0.9))
                                .font(.caption)
                            
                            Text(user.locationString)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.9))
                                .lineLimit(1)
                            
                            Spacer()
                        }
                        
                        // Nationality
                        HStack {
                            Image(systemName: "flag.fill")
                                .foregroundColor(.white.opacity(0.9))
                                .font(.caption)
                            
                            Text(user.nat)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.9))
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                Color.black.opacity(0.7),
                                Color.black.opacity(0.5),
                                Color.black.opacity(0.3),
                                Color.black.opacity(0.1),
                                
                            ]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                }
            }
            .aspectRatio(2/3, contentMode: .fit)
            .overlay(
                // Accept/Reject buttons
                VStack {
                    Spacer()
                    
                    HStack {
                        // Reject
                        ActionButton(action: onReject, imageName: "xmark", color: .red, isDisabled: user.acceptanceStatus != nil)
                        Spacer()
                        // Accept
                        ActionButton(action: onAccept, imageName: "checkmark", color: .green, isDisabled: user.acceptanceStatus != nil)
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
                    
                    
                    Spacer()
                        .frame(height: 100)
                    
                    
                }
                    .opacity(user.acceptanceStatus != nil ? 0 : 1)
            )
            .overlay(
                // Decision status indicator
                VStack {
                    HStack {
                        Spacer()
                        
                        if let status = user.acceptanceStatus {
                            StatusText(status: status)
                        }
                    }
                    Spacer()
                }
            )
            .onAppear {
                loadImage()
            }
            .onChange(of: user.picture.large) { _ in
                // Reset image and reload when user changes
                profileImage = nil
                imageLoaded = false
                loadImage()
            }
            .background(Color(.systemBackground))
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 1)
            )
        
    }
    private struct ActionButton: View {
        var action: () -> Void
        var imageName: String
        var color: Color
        var isDisabled: Bool = false
        var body: some View {
            Button(action: action) {
                Image(systemName: imageName)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(
                        Circle()
                            .fill(color)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
                    )
            }
            .disabled(isDisabled)
        }
    }
    private struct StatusText: View {
        var status: Bool?

        @ViewBuilder
        var body: some View {
            if let status = status {
                Text(status ? "ACCEPTED" : "REJECTED")
                    .font(.caption)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule()
                            .fill(status ? Color.green : Color.red)
                    )
                    .padding(.top, 12)
                    .padding(.trailing, 12)
            } else {
                EmptyView()
            }
        }
    }

    
    private func loadImage() {
        guard let url = URL(string: user.picture.large) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.profileImage = image
                    self.imageLoaded = true
                }
            }
        }.resume()
    }
}

#Preview {
    ProfileCard(
        user: ProfileModel(
        gender: "female",
        name: Name(title: "Ms", first: "Alice", last: "Johnson"),
        location: Location(
            street: Street(number: 123, name: "Main St"),
            city: "New York",
            state: "NY",
            country: "United States",
            postcode: .string("10001"),
            coordinates: Coordinates(latitude: "40.7128", longitude: "-74.0060"),
            timezone: Timezone(offset: "-5:00", description: "Eastern Time")
        ),
        email: "alice.johnson@example.com",
        login: Login(
            uuid: "123e4567-e89b-12d3-a456-426614174000",
            username: "alicej",
            password: "password123",
            salt: "salt",
            md5: "md5",
            sha1: "sha1",
            sha256: "sha256"
        ),
        dob: DateOfBirth(date: "1990-01-01T00:00:00.000Z", age: 33),
        registered: Registered(date: "2020-01-01T00:00:00.000Z", age: 3),
        phone: "555-1234",
        cell: "555-5678",
        userID: UserID(name: "SSN", value: "123-45-6789"),
        picture: Picture(
            large: "https://randomuser.me/api/portraits/women/1.jpg",
            medium: "https://randomuser.me/api/portraits/med/women/1.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/women/1.jpg"
        ),
        nat: "US"
    ),
        onAccept: {
            print("Accept tapped")
        },
        onReject: {
            print("Reject tapped")
        }
    )
    .padding()
} 
