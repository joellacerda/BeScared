package com.bescared.api.controller;

import com.bescared.api.client.TmdbClient;
import com.bescared.api.model.Favorite;
import com.bescared.api.model.MovieDTO;
import com.bescared.api.repository.FavoriteRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/movies")
public class HorrorMovieController {

    private final TmdbClient tmdbClient;
    private final FavoriteRepository favoriteRepository;

    @Value("${tmdb.api.key}")
    private String apiKey;

    public HorrorMovieController(TmdbClient tmdbClient, FavoriteRepository favoriteRepository) {
        this.tmdbClient = tmdbClient;
        this.favoriteRepository = favoriteRepository;
    }

    @GetMapping("/horror")
    public List<MovieDTO> listHorrorMovies() {
        var response = tmdbClient.getHorrorMovies(apiKey);
        return response.results();
    }

    @PostMapping("/favorites")
    public ResponseEntity<String> saveFavorite(@RequestBody Favorite favorite) {
        favoriteRepository.save(favorite);
        return ResponseEntity.ok("Filme salvo nas trevas com sucesso! ⚰️");
    }

    @GetMapping("/favorites")
    public List<Favorite> listFavorites() {
        return favoriteRepository.findAll();
    }

    @DeleteMapping("/favorites/{id}")
    public ResponseEntity<Void> removeFavorite(@PathVariable Long id) {
        favoriteRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}
