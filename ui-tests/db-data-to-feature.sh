#!/bin/bash

products="products.csv"
newProducts=()
allCategories=()
if [ -e "$products" ]; then

    while IFS=";" read -r id name description price category; do 
    
    cleanCategory=$(echo "$category" | tr -d '\r')
    
        if [[ "$cleanCategory" == "1" || "$cleanCategory" == "Bouldering" ]]
        then
            newProducts+=("$id;$name;$description;$price;Bouldering")
        elif [[ "$cleanCategory" == "2"  || "$cleanCategory" == "Climbing Shoes" ]]
        then
            newProducts+=("$id;$name;$description;$price;Climbing Shoes")
        elif [[ "$cleanCategory" == "3"  || "$cleanCategory" == "Climbing Harnesses" ]]
        then
            newProducts+=("$id;$name;$description;$price;Climbing Harnesses")
        elif [[ "$cleanCategory" == "4"  || "$cleanCategory" == "Climbing Ropes" ]]
        then
            newProducts+=("$id;$name;$description;$price;Climbing Ropes")
        elif [[ "$cleanCategory" == "5"  || "$cleanCategory" == "Climbing Clothes" ]]
        then
            newProducts+=("$id;$name;$description;$price;Climbing Clothes")
        elif [[ "$cleanCategory" == "Alla" ]]
        then
            allCategories+=("$id;$name;$description;$price;Alla")
        else
            echo "$cleanCategory"
            echo "nope"
        fi

        if [[ "$cleanCategory" == "1" || "$cleanCategory" == "2" || "$cleanCategory" == "3" || "$cleanCategory" == "4" || "$cleanCategory" == "5" ]]
        then
            allCategories+=("$id;$name;$description;$price;Alla")
        fi
    done < $products

    printf "%s\n" "${newProducts[@]}" > "products.csv"
    printf "%s\n" "${allCategories[@]}" >> "products.csv"
    

    tr -d '\r' < "$products" | sed 's/ *;/|/g' | awk -F'|' '{printf "|%-20s|%-35s|%-7s|%-85s|\n", $5, $2, $4, $3}'    
else
    echo "File not found: $products"
fi
