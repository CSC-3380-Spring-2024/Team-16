package com.example.foodApp.AccountCreaete;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.bson.types.ObjectId;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection = "UserAccount")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Account {

    @Id
    ObjectId id;
    private String username;
    private String password;

    public Account (String username, String password)
    {
        this.username = username;
        this.password = password;
    }


}
