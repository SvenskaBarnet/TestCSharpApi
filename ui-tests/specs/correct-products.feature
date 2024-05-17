Feature: As user I want to be able to see the correct products listed when I have chosen a category so that I can easily filter the product list by category.

  Scenario Outline: Check that the category <category> shows the product <product>.
    Given that I am on the product page
    When I choose the category "<category>"
    Then I should see the product "<product>"

    Examples:
      | category           | product                         |
      | Bouldering         | Crash Pad                       |
      | Bouldering         | Chalk Bag                       |
      | Bouldering         | Climbing Brush                  |
      | Bouldering         | Climbing Holds Set              |
      | Bouldering         | Climbing Tape                   |
      | Climbing Shoes     | SuperGrip Shoes                 |
      | Climbing Shoes     | Beginner Climb Shoes            |
      | Climbing Shoes     | AllRounder Shoes                |
      | Climbing Harnesses | Climbing Helmet                 |
      | Climbing Harnesses | Climbing Harness - Basic        |
      | Climbing Harnesses | Climbing Harness - Professional |
      | Climbing Harnesses | Belay Device                    |
      | Climbing Ropes     | Dynamic Climbing Rope - 60m     |
      | Climbing Ropes     | Static Climbing Rope - 30m      |
      | Climbing Ropes     | Quickdraw Set                   |
      | Climbing Ropes     | Carabiner - Locking             |
      | Climbing Clothes   | StretchClimb Pants              |
      | Climbing Clothes   | Breathable Climb Shirt          |
      | Climbing Clothes   | Insulated Climb Jacket          |
      | Alla               | Crash Pad                       |
      | Alla               | Chalk Bag                       |
      | Alla               | Climbing Brush                  |
      | Alla               | Climbing Holds Set              |
      | Alla               | Climbing Tape                   |
      | Alla               | SuperGrip Shoes                 |
      | Alla               | Beginner Climb Shoes            |
      | Alla               | AllRounder Shoes                |
      | Alla               | Climbing Helmet                 |
      | Alla               | Climbing Harness - Basic        |
      | Alla               | Climbing Harness - Professional |
      | Alla               | Belay Device                    |
      | Alla               | Dynamic Climbing Rope - 60m     |
      | Alla               | Static Climbing Rope - 30m      |
      | Alla               | Quickdraw Set                   |
      | Alla               | Carabiner - Locking             |
      | Alla               | StretchClimb Pants              |
      | Alla               | Breathable Climb Shirt          |
      | Alla               | Insulated Climb Jacket          |


  Scenario Outline: Check that the category <category> does not shows the product <product>.
    Given that I am on the product page
    When I choose the category "<category>"
    Then I should not see the product "<product>"


    Examples:
      | category           | product                         |
      | Bouldering         | SuperGrip Shoes                 |
      | Bouldering         | Beginner Climb Shoes            |
      | Bouldering         | AllRounder Shoes                |
      | Bouldering         | Climbing Helmet                 |
      | Bouldering         | Climbing Harness - Basic        |
      | Bouldering         | Climbing Harness - Professional |
      | Bouldering         | Belay Device                    |
      | Bouldering         | Dynamic Climbing Rope - 60m     |
      | Bouldering         | Static Climbing Rope - 30m      |
      | Bouldering         | Quickdraw Set                   |
      | Bouldering         | Carabiner - Locking             |
      | Bouldering         | StretchClimb Pants              |
      | Bouldering         | Breathable Climb Shirt          |
      | Bouldering         | Insulated Climb Jacket          |
      | Climbing Shoes     | Crash Pad                       |
      | Climbing Shoes     | Chalk Bag                       |
      | Climbing Shoes     | Climbing Brush                  |
      | Climbing Shoes     | Climbing Holds Set              |
      | Climbing Shoes     | Climbing Tape                   |
      | Climbing Shoes     | Climbing Helmet                 |
      | Climbing Shoes     | Climbing Harness - Basic        |
      | Climbing Shoes     | Climbing Harness - Professional |
      | Climbing Shoes     | Belay Device                    |
      | Climbing Shoes     | Dynamic Climbing Rope - 60m     |
      | Climbing Shoes     | Static Climbing Rope - 30m      |
      | Climbing Shoes     | Quickdraw Set                   |
      | Climbing Shoes     | Carabiner - Locking             |
      | Climbing Shoes     | StretchClimb Pants              |
      | Climbing Shoes     | Breathable Climb Shirt          |
      | Climbing Shoes     | Insulated Climb Jacket          |
      | Climbing Harnesses | Crash Pad                       |
      | Climbing Harnesses | Chalk Bag                       |
      | Climbing Harnesses | Climbing Brush                  |
      | Climbing Harnesses | Climbing Holds Set              |
      | Climbing Harnesses | Climbing Tape                   |
      | Climbing Harnesses | SuperGrip Shoes                 |
      | Climbing Harnesses | Beginner Climb Shoes            |
      | Climbing Harnesses | AllRounder Shoes                |
      | Climbing Harnesses | Dynamic Climbing Rope - 60m     |
      | Climbing Harnesses | Static Climbing Rope - 30m      |
      | Climbing Harnesses | Quickdraw Set                   |
      | Climbing Harnesses | Carabiner - Locking             |
      | Climbing Harnesses | StretchClimb Pants              |
      | Climbing Harnesses | Breathable Climb Shirt          |
      | Climbing Harnesses | Insulated Climb Jacket          |
      | Climbing Ropes     | Crash Pad                       |
      | Climbing Ropes     | Chalk Bag                       |
      | Climbing Ropes     | Climbing Brush                  |
      | Climbing Ropes     | Climbing Holds Set              |
      | Climbing Ropes     | Climbing Tape                   |
      | Climbing Ropes     | SuperGrip Shoes                 |
      | Climbing Ropes     | Beginner Climb Shoes            |
      | Climbing Ropes     | AllRounder Shoes                |
      | Climbing Ropes     | Climbing Helmet                 |
      | Climbing Ropes     | Climbing Harness - Basic        |
      | Climbing Ropes     | Climbing Harness - Professional |
      | Climbing Ropes     | Belay Device                    |
      | Climbing Ropes     | StretchClimb Pants              |
      | Climbing Ropes     | Breathable Climb Shirt          |
      | Climbing Ropes     | Insulated Climb Jacket          |
      | Climbing Clothes   | Crash Pad                       |
      | Climbing Clothes   | Chalk Bag                       |
      | Climbing Clothes   | Climbing Brush                  |
      | Climbing Clothes   | Climbing Holds Set              |
      | Climbing Clothes   | Climbing Tape                   |
      | Climbing Clothes   | SuperGrip Shoes                 |
      | Climbing Clothes   | Beginner Climb Shoes            |
      | Climbing Clothes   | AllRounder Shoes                |
      | Climbing Clothes   | Climbing Helmet                 |
      | Climbing Clothes   | Climbing Harness - Basic        |
      | Climbing Clothes   | Climbing Harness - Professional |
      | Climbing Clothes   | Belay Device                    |
      | Climbing Clothes   | Dynamic Climbing Rope - 60m     |
      | Climbing Clothes   | Static Climbing Rope - 30m      |
      | Climbing Clothes   | Quickdraw Set                   |
      | Climbing Clothes   | Carabiner - Locking             |