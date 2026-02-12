package com.bescared.api.client;

import com.bescared.api.model.TmdbResponse;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(name = "tmdb-client", url = "${tmdb.url}")
public interface TmdbClient {
    @GetMapping("/discover/movie?with_genres=27")
    TmdbResponse getHorrorMovies(@RequestParam("api_key") String apiKey);
}
