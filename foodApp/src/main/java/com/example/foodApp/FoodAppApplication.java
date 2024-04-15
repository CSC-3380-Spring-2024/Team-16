/*
 * Makei Salmon
 */
package com.example.foodApp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class FoodAppApplication {

	public static void main(String[] args) {
		SpringApplication.run(FoodAppApplication.class, args);
		
	}
	@GetMapping
	public String bais() {
		System.out.println("bais");
		return "bais!!!!!";
	}
}
