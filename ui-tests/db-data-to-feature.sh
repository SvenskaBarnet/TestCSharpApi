#!/bin/bash

for (( i=0; i<2; i++ )); do
    products="products.csv"
    parsedProducts="parsed-products.csv"
    scenario=$i
    newProducts=()
    allCategories=()
    if [ -e "$products" ]; then
        while IFS=";" read -r id name description price category; do 
            cleanCategory=$(echo "$category" | tr -d '\r')
            allCategories+=("$id;$name;$description;$price;Alla")

            if [[ "$cleanCategory" == "1" ]]; then
                newProducts+=("$id;$name;$description;$price;Bouldering")

            elif [[ "$cleanCategory" == "2"  ]]; then
                newProducts+=("$id;$name;$description;$price;Climbing Shoes")

            elif [[ "$cleanCategory" == "3"  ]]; then
                newProducts+=("$id;$name;$description;$price;Climbing Harnesses")

            elif [[ "$cleanCategory" == "4"  ]]; then
                newProducts+=("$id;$name;$description;$price;Climbing Ropes")

            elif [[ "$cleanCategory" == "5"  ]]; then
                newProducts+=("$id;$name;$description;$price;Climbing Clothes")
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
            local scenario=$1
            local filePath="specs/correct-products.feature"
            local firstMarker="Examples:"
            local firstMarkerLine
            local allEmptyLines
            local secondMarkerLine
            local textToInsert=$input
        
            if (( scenario == 0 )); then
                firstMarkerLine=$(grep -n "$firstMarker" "$filePath" | cut -d: -f1 | head -n 1)
                ((firstMarkerLine++))
            else    
                firstMarkerLine=$(grep -n "$firstMarker" "$filePath" | cut -d: -f1 | tail -n 1)
                ((firstMarkerLine++))
            fi

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
            tail -n +$firstMarkerLine specs/correct-products.feature >> temp_file && \
            mv temp_file specs/correct-products.feature
        }
        if (( scenario == 0 )); then
            editFile 0
        fi

        newProducts=()
        allCategories=()
        categoryEnum=("Bouldering" "Climbing Shoes" "Climbing Harnesses" "Climbing Ropes" "Climbing Clothes")

        for (( j=0; j<${#categoryEnum[@]}; j++)); do
            while IFS=";" read -r id name description price category; do 
                cleanCategory=$(echo "$category" | tr -d '\r')
                if ! (( $((j+1)) == "$cleanCategory" )); then
                    newProducts+=("$id;$name;$description;$price;${categoryEnum[$j]}")
                fi
            done < $products
        done

        printf "%s\n" "${newProducts[@]}" | sort -r -k1 > "parsed-products.csv"
    
        input=$(tr -d '\r' < "$parsedProducts" | \
        sed 's/ *;/|/g' | \
        awk -F'|' \
        'BEGIN {printf "\t| %-20s| %-35s|\n", "category", "product"}    
        {printf "\t| %-20s| %-35s|\n", $5, $2}' | sort -r -k1)
    
        if (( scenario == 1 )); then
            editFile 1
        fi
    else
        echo "File not found: $products"
    fi
done
rm -f "parsed-products.csv"