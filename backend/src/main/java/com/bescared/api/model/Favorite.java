package com.bescared.api.model;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;

@Entity
@Table(name = "favorites")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(onlyExplicitlyIncluded = true)
public class Favorite {

    @Id
    @EqualsAndHashCode.Include
    private Long id;
    private String title;
    @JsonProperty("poster_path")
    private String posterPath;
    @JsonProperty("vote_average")
    private Double voteAverage;
    @JsonProperty("release_date")
    private String releaseDate;
    @Column(columnDefinition = "TEXT")
    private String overview;
}
