package com.bescared.api.model;

import java.util.List;

public record TmdbResponse(List<MovieDTO> results) {}
