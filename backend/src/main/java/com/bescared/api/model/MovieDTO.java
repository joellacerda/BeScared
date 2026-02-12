package com.bescared.api.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public record MovieDTO(
    Long id,
    String title,
    @JsonProperty("poster_path") String posterPath,
    @JsonProperty("vote_average") Double voteAverage,
    String overview,
    @JsonProperty("release_date") String releaseDate
    ) {}
