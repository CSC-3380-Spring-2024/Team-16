package com.example.foodApp.AccountCreaete;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/account")
public class AccountController {

    @Autowired
    private AccountService accountService;

    //PostMapping
    @PostMapping("/create")
    public ResponseEntity<String> createAccount (@RequestBody Map<String, String> payload)
    {
        Account account = new Account(payload.get("username"), payload.get("password"));
        System.out.println(account.getPassword());
        String createAccount =accountService.createAccount(account);

        return ResponseEntity.unprocessableEntity().body(createAccount);
    }
    @PostMapping("/login")
    public ResponseEntity<String> login (@RequestBody  Map<String, String> payload){
        String username = payload.get("username");
        String password = payload.get("password");

        if(accountService.acountAuthy(username,password))
        {
            return ResponseEntity.ok().body("welcome "+ username);
        }
        else
        {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid username or password");
        }

    }


    //GetMapping
}

