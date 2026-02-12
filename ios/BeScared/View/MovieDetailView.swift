//
//  MovieDetailView.swift
//  BeScared
//
//  Created by Joel Lacerda on 28/01/26.
//

import SwiftUI

struct MovieDetailView: View {
    @StateObject private var viewModel = MoviesViewModel()
    let movie: Movie
    
    @State private var isZoomed = false
    @State private var posterImage: UIImage? = nil
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            // 1. CAMADA DE CONTEÚDO (Fica borrada quando zoomed)
            ScrollView {
                VStack(alignment: .leading) {
                    
                    // HEADER (Imagem Pequena)
                    ZStack(alignment: .bottom) {
                        if let image = posterImage {
                            // Se NÃO estiver em zoom, mostra a imagem aqui
                            if !isZoomed {
                                Image(uiImage: image)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 400)
                                    .clipped()
                                    .matchedGeometryEffect(id: "poster", in: animation)
                                    .overlay(
                                        LinearGradient(colors: [.clear, .black], startPoint: .center, endPoint: .bottom)
                                    )
                                    .onTapGesture {
                                        withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                            isZoomed = true
                                        }
                                    }
                            } else {
                                // Espaço reservado transparente para manter o layout
                                Rectangle().fill(Color.clear).frame(height: 400)
                            }
                        } else {
                            // Placeholder enquanto carrega do zero
                            Rectangle().fill(Color.gray.opacity(0.2)).frame(height: 400)
                        }
                        
                        // Título e Data
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .shadow(radius: 4)
                            
                            Text(movie.formattedDate)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(isZoomed ? 0 : 1) // Texto some no zoom
                    }
                    
                    // BOTÕES E SINOPSE
                    VStack(alignment: .leading, spacing: 20) {
                        HStack(spacing: 20) {
                            LikeButton(
                                isFavorite: viewModel.favoriteIds.contains(movie.id),
                                action: { Task { await viewModel.toggleFavorite(movie: movie) } }
                            )
                            
                            Button(action: { print("Watched!") }) {
                                Label("Seen", systemImage: "eye")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                            .buttonStyle(.bordered)
                            .tint(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Synopsis")
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(movie.overview.isEmpty ? "No synopsis available." : movie.overview)
                                .font(.body)
                                .foregroundColor(.gray)
                                .lineSpacing(4)
                        }
                    }
                    .padding()
                }
            }
            .blur(radius: isZoomed ? 15 : 0) // <--- O EFEITO DE BLUR NO FUNDO
            .ignoresSafeArea(edges: .top)
            
            // 2. CAMADA DE ZOOM (Overlay)
            if isZoomed, let image = posterImage {
                ZStack {
                    // Fundo escuro semitransparente para destacar a imagem mas ver o blur
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                isZoomed = false
                            }
                        }
                    
                    // Imagem Grande (Cresce a partir da pequena)
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .matchedGeometryEffect(id: "poster", in: animation) // A Mágica
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(20)
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7)) {
                                isZoomed = false
                            }
                        }
                        .zIndex(1) // Garante que a imagem fique acima do fundo escuro
                }
            }
        }
        .background(Color.black)
        .onAppear {
            Task {
                await viewModel.fetchFavoriteIds()
                // Carrega a imagem manualmente para garantir fluidez
                await loadImage()
            }
        }
    }
    
    // Função auxiliar para baixar a imagem e salvar no @State
    private func loadImage() async {
        guard let url = movie.fullPosterURL, posterImage == nil else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let uiImage = UIImage(data: data) {
                // Animação suave quando a imagem termina de carregar
                withAnimation {
                    self.posterImage = uiImage
                }
            }
        } catch {
            print("Erro ao carregar imagem: \(error)")
        }
    }
}
