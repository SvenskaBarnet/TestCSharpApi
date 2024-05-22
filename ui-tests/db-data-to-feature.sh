#!/bin/bash

products="products.csv"
parsedProducts="parsed-products.csv"
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

    printf "%s\n" "${newProducts[@]}" > "parsed-products.csv"
    printf "%s\n" "${allCategories[@]}" >> "parsed-products.csv"
    
    input=$(tr -d '\r' < "$parsedProducts" | \
    sed 's/ *;/|/g' | \
    awk -F'|' \
    'BEGIN {printf "\t| %-20s| %-35s| %-7s| %-85s|\n", "category", "product", "price", "description"}    
    {printf "\t| %-20s| %-35s| %-7s| %-85s|\n", $5, $2, $4, $3}' | sort -r -k1)

    editFile() {
        local filePath="correct-products.feature"
        local firstMarker="Examples:"
        local firstMarkerLine
        local allEmptyLines
        local secondMarkerLine
        local textToInsert=$input
        
        firstMarkerLine=$(grep -n "$firstMarker" "$filePath" | cut -d: -f1 | head -n 1)
        ((firstMarkerLine++))

        allEmptyLines=$(grep -n -E '^\s*$' "$filePath" | cut -d: -f1)

        while IFS= read -r line; do
            if (( "$line" > "$firstMarkerLine" )); then
                nextLine=$((firstMarkerLine + 1))
                nextLineContent=$(sed -n "${nextLine}p" "$filePath")
                    if ! [[ "$nextLineContent" ]]; then
                        secondMarkerLine="$nextLine"
                        break;
                    else
                        secondMarkerLine="$line"
                        ((secondMarkerLine--))
                        break;
                    fi
            fi
        done <<< "$allEmptyLines"
        
        if ! (( secondMarkerLine - firstMarkerLine <= 1 )); then
            sed -i "${firstMarkerLine},${secondMarkerLine}d" "$filePath"
        fi

        head -n $((firstMarkerLine - 1)) "$filePath" > temp_file && \
        echo "$textToInsert" >> temp_file && \
        tail -n +$firstMarkerLine correct-products.feature >> temp_file && \
        mv temp_file correct-products.feature
    }

    editFile

    newProducts=()
    allCategories=()
    categoryEnum=("Bouldering" "Climbing Shoes" "Climbing Harnesses" "Climbing Ropes" "Climbing Clothes")

    for (( i=0; i<${#categoryEnum[@]}; i++)); do
        while IFS=";" read -r id name description price category; do 
            cleanCategory=$(echo "$category" | tr -d '\r')
            echo "i+1: $((i+1)),  categoryEnum: ${categoryEnum[$i]}, cleanCategory: $cleanCategory"
            if ! (( $((i+1)) == "$cleanCategory" )); then
                newProducts+=("$id;$name;$description;$price;${categoryEnum[$i]}")
            fi
        done < $products
    done

    printf "%s\n" "${newProducts[@]}" | sort -r -k1 > "parsed-products.csv"
    
    input=$(tr -d '\r' < "$parsedProducts" | \
    sed 's/ *;/|/g' | \
    awk -F'|' \
    'BEGIN {printf "\t| %-20s| %-35s|\n", "category", "product"}    
    {printf "\t| %-20s| %-35s|\n", $5, $2}' | sort -r -k1)

else
    echo "File not found: $products"
fi