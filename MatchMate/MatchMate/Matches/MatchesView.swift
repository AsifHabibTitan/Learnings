//
//  MatchesView.swift
//  MatchMate
//
//  Created by Asif Habib on 30/07/25.
//

import SwiftUI

struct MatchesView: View {
    @StateObject private var viewModel = MatchesViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background
                Color(.systemBackground)
                    .ignoresSafeArea()
                
                if viewModel.isLoading && viewModel.profiles.isEmpty {
                    VStack {
                        ProgressView()
                            .scaleEffect(1.5)
                        Text("Loading profiles...")
                            .foregroundColor(.secondary)
                            .padding(.top)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let errorMessage = viewModel.errorMessage {
                    ErrorMessageView(text: errorMessage, onRetry: viewModel.fetchMatches())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Vertical scrollable cards
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVStack(spacing: 20) {
                            ForEach(Array(viewModel.profiles.enumerated()), id: \.element.id) { index, profile in
                                ProfileCard(
                                    user: profile,
                                    onAccept: {
                                        viewModel.acceptUser(profile)
                                    },
                                    onReject: {
                                        viewModel.rejectUser(profile)
                                    }
                                )
                                .onAppear(){
                                    if index == viewModel.profiles.count - 1 {
                                        print("DEBUG: Last Card reached")
                                        viewModel.fetchMatches()
                                    }
                                }

                                .padding(.horizontal)
                            }
                        }
                        .padding(.vertical, 20)
                    }
                    .refreshable {
                        viewModel.fetchMatches()
                    }
                }
            }
            .navigationTitle("Matches")
            .onAppear {
                if viewModel.profiles.isEmpty {
                    viewModel.fetchMatches()
                }
            }
        }
    }
}

struct ErrorMessageView: View {
    var text: String
    var onRetry: ()
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "exclamationmark.triangle")
                .font(.system(size: 50))
                .foregroundColor(.orange)
            
            Text("Error")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text(text)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Button("Retry") { onRetry }
            .buttonStyle(.borderedProminent)
        }
    }
}

#Preview {
    MatchesView()
}
