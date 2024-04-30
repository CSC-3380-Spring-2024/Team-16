package com.example.foodApp.Comment;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document(collection = "Comment")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Comment {
    private String commentBody;
    private List<String> like;
    private List<String> dislike;
    private String username;


    public Comment(String commentBody, String username) {
        this.commentBody = commentBody;
        this.username = username;
    }

}