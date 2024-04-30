package com.example.foodApp.AccountCreaete;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/account")
@CrossOrigin(origins = "*")
public class AccountController {

    @Autowired
    private AccountService accountService;

    //PostMapping

    /**
     * @apiNote
     *    http://localhost:8080/api/account/create
     *   {
     *
     *        "username": "Jonh Doe" // username ( have to be distinct)
     *        "password": "password" // user pasword
     *
     *     }
     * @param payload
     * @return
     */
    @PostMapping("/create")
    public ResponseEntity<String> createAccount (@RequestBody Map<String, String> payload)
    {
        Account account = new Account(payload.get("username"), payload.get("password"));
        System.out.println(account.getPassword());
        if(accountService.prevUsernameDup(account.getUsername()))
        {
            return ResponseEntity.unprocessableEntity().body("Please Choose Different Username");
        }
        String createAccount =accountService.createAccount(account);

        return ResponseEntity.status(HttpStatus.OK).body(createAccount);
    }


    /**
     * @apiNote
     *    http://localhost:8080/api/account/create
     *   {
     *
     *        "username": "Jonh Doe" // username (has to be valid)
     *        "password": "password" // user pasword (has to be valid)
     *
     *     }
     * @param payload
     * @return
     */

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


}

