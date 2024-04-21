package com.example.foodApp.AccountCreaete;

import org.bson.types.ObjectId;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository

public interface AccountRepository extends MongoRepository<Account, ObjectId> {

}
