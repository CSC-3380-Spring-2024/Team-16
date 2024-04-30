/*
 * Makei Salmon
 */
package com.example.foodApp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
@CrossOrigin(origins = "*")
public class FoodAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(FoodAppApplication.class, args);

	}

	@GetMapping
	public ResponseEntity<String> bais() {
		System.out.println("bais");
		return new ResponseEntity<String>("bais!!!!!", HttpStatus.OK);
	}
}
