package com.example.foodApp.AccountCreaete;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;


@Service
public class AccountService {

    @Autowired
    private AccountRepository accountRepository;
    @Autowired
    private MongoTemplate mongoTemplate;

    public String createAccount (Account account)
    {
        if(account.getUsername() == null && account.getPassword() == null)
        {
            return "Please Enter your username and password";
        }
        else
        {
            mongoTemplate.insert(account);
            return "Account Successfully Created";
        }
    }
    public boolean acountAuthy (String username, String password)
    {
        Query query = new Query(Criteria.where("username").is(username).and("password").is(password));

        return mongoTemplate.exists(query,Account.class);
    }
}
