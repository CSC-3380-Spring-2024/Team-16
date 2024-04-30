package com.example.foodApp.System;


import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
public class DistinctId
{
    public String generateId ()
    {
        return UUID.randomUUID().toString();
    }

}
