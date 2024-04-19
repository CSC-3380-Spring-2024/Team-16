package com.example.foodApp.Review;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

public class LikeNDislikeFilter {

    private List<String> listOffName;
    private List<String> listOffName1;
    private String personName;

    public LikeNDislikeFilter (List<String> listofNameList,List<String> listofName1, String personName)
    {
        this.listOffName = listofNameList;
        this.personName = personName;
        this.listOffName1 = listofName1;
    }

    public int filter()
    {
        ArrayList<String> allNameInBothList = new ArrayList<>();
        if(listOffName != null)
        {
            allNameInBothList.addAll(listOffName);
        }
        if(listOffName1 != null)
        {
            allNameInBothList.addAll(listOffName1);
        }
        if(allNameInBothList == null)
        {
            return 0;
        }
        Set<String> allName = new HashSet<>(allNameInBothList);

        for(String word : allName)
        {
            if(personName.contains(word))
            {
                return 1;
            }

        }

      return 0;
    }
    

    
}
