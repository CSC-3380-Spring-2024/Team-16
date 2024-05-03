package com.example.foodApp.System;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class LikeNDislikeFilter {

    private Set<String> setOfAllName;

    public LikeNDislikeFilter(List<String> listofNameList, List<String> listofName1) {
        setOfAllName = new HashSet<>();
        if (listofNameList != null) {
            setOfAllName.addAll(listofNameList);
        }
        if (listofName1 != null) {
            setOfAllName.addAll(listofName1);
        }
    }

    public boolean filter(String personName) {
        return setOfAllName.contains(personName);

    }


}