package com.example.foodApp.Post;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PostRespository extends MongoRepository<Post, ObjectId>
{
}
