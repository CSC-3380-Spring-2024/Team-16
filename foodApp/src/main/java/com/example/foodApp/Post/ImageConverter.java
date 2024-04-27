package com.example.foodApp.Post;


import java.util.Base64;

public class ImageConverter {
    private String base64;
    private String imageFormat;

    public byte [] base64Tobinary(String image)
    {
        try
        {
            // Check for PNG format
            if (image.startsWith("data:image/png;base64,")) {
                image = image.substring("data:image/png;base64,".length());
                imageFormat = "png";
            }
            // Check for JPEG format
            else if (image.startsWith("data:image/jpeg;base64,")) {
                image = image.substring("data:image/jpeg;base64,".length());
                imageFormat = "jpeg";
            } else {
                // Handle unsupported format
                return null;
            }

             byte [] decodeBytes = Base64.getDecoder().decode(image);

            return decodeBytes;

        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }


    }
    public String getImageFormat()
    {
        return imageFormat;
    }
}
