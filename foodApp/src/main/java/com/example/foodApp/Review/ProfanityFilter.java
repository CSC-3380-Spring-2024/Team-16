package com.example.foodApp.Review;

import java.util.Arrays;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;

public class ProfanityFilter {
    private static final Set<String> profanity = new HashSet<>(Arrays.asList(
            "ass", "fuck", "pussy", "chinky", "cockhead", "cum", "dick", "porn", "faggot", "motherfucker"
            , "nigga", "prostitute", "whitetrash", "wuss", "wussy", "wanker",
            "twat", "terrorist", "shit", "shits", "slut", "slophead", "slutwhore", "whore", "sex"));

    public static String filterText(String input) {
        for (String word : profanity) {
            if (input.toLowerCase().contains(word)) {
                input = input.replaceAll("(?i)" + word, "****");
            }
        }
        return input;
    }
}

