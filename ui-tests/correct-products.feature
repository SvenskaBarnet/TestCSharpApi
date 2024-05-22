Feature: As user I want to be able to see the correct products listed when I have chosen a category so that I can easily filter the product list by category.

  Scenario Outline: Check that the category <category> shows the product <product> with the price <price> and the description '<description>'.
    Given that I am on the product page
    When I choose the category "<category>"
    Then I should see the product "<product>" 
    And The product "<product>" should have the price "<price>" 
    And The product "<product>" should have the description "<description>"

    Examples:
	| category            | product                            | price  | description                                                                          |
	| Climbing Shoes      | SuperGrip Shoes                    | 1200   | Shoes with superior grip for advanced climbers                                       |
	| Climbing Shoes      | Beginner Climb Shoes               | 600    | Comfortable and supportive shoes for beginners                                       |
	| Climbing Shoes      | AllRounder Shoes                   | 1000   | Versatile shoes suitable for all types of climbing                                   |
	| Climbing Ropes      | Static Climbing Rope - 30m         | 870    | Static rope ideal for rappelling and rescue operations.                              |
	| Climbing Ropes      | Quickdraw Set                      | 900    | Set of quickdraws used to connect the rope to bolts on the climbing route.           |
	| Climbing Ropes      | Dynamic Climbing Rope - 60m        | 1200   | Dynamic rope suitable for lead climbing and top-roping.                              |
	| Climbing Ropes      | Carabiner - Locking                | 240    | Locking carabiner for securing critical climbing equipment.                          |
	| Climbing Harnesses  | Climbing Helmet                    | 465    | Protective headgear designed to protect climbers from falling debris.                |
	| Climbing Harnesses  | Climbing Harness - Professional    | 1600   | Advanced climbing harness with additional features for experienced climbers.         |
	| Climbing Harnesses  | Climbing Harness - Basic           | 890    | Entry-level climbing harness for beginner climbers.                                  |
	| Climbing Harnesses  | Belay Device                       | 700    | Device used to control the rope during belaying, lowering, or rappelling.            |
	| Climbing Clothes    | StretchClimb Pants                 | 1100   | Stretchable pants providing flexibility and durability                               |
	| Climbing Clothes    | Insulated Climb Jacket             | 2300   | Jacket with insulation for colder climbs                                             |
	| Climbing Clothes    | Breathable Climb Shirt             | 650    | Lightweight and breathable shirt for climbers                                        |
	| Bouldering          | Crash Pad                          | 2000   | Large foam pad used to protect climbers from falls while bouldering.                 |
	| Bouldering          | Climbing Tape                      | 75     | Specialized tape used to protect skin and prevent injuries while climbing.           |
	| Bouldering          | Climbing Holds Set                 | 2500   | Set of artificial climbing holds for building indoor climbing routes.                |
	| Bouldering          | Climbing Brush                     | 65     | A brush used to clean holds and remove excess chalk and dirt from climbing routes.   |
	| Bouldering          | Chalk Bag                          | 150    | A bag used to hold chalk, keeping climber's hands dry and improving grip.            |
	| Alla                | SuperGrip Shoes                    | 1200   | Shoes with superior grip for advanced climbers                                       |
	| Alla                | StretchClimb Pants                 | 1100   | Stretchable pants providing flexibility and durability                               |
	| Alla                | Static Climbing Rope - 30m         | 870    | Static rope ideal for rappelling and rescue operations.                              |
	| Alla                | Quickdraw Set                      | 900    | Set of quickdraws used to connect the rope to bolts on the climbing route.           |
	| Alla                | Insulated Climb Jacket             | 2300   | Jacket with insulation for colder climbs                                             |
	| Alla                | Dynamic Climbing Rope - 60m        | 1200   | Dynamic rope suitable for lead climbing and top-roping.                              |
	| Alla                | Crash Pad                          | 2000   | Large foam pad used to protect climbers from falls while bouldering.                 |
	| Alla                | Climbing Tape                      | 75     | Specialized tape used to protect skin and prevent injuries while climbing.           |
	| Alla                | Climbing Holds Set                 | 2500   | Set of artificial climbing holds for building indoor climbing routes.                |
	| Alla                | Climbing Helmet                    | 465    | Protective headgear designed to protect climbers from falling debris.                |
	| Alla                | Climbing Harness - Professional    | 1600   | Advanced climbing harness with additional features for experienced climbers.         |
	| Alla                | Climbing Harness - Basic           | 890    | Entry-level climbing harness for beginner climbers.                                  |
	| Alla                | Climbing Brush                     | 65     | A brush used to clean holds and remove excess chalk and dirt from climbing routes.   |
	| Alla                | Chalk Bag                          | 150    | A bag used to hold chalk, keeping climber's hands dry and improving grip.            |
	| Alla                | Carabiner - Locking                | 240    | Locking carabiner for securing critical climbing equipment.                          |
	| Alla                | Breathable Climb Shirt             | 650    | Lightweight and breathable shirt for climbers                                        |
	| Alla                | Belay Device                       | 700    | Device used to control the rope during belaying, lowering, or rappelling.            |
	| Alla                | Beginner Climb Shoes               | 600    | Comfortable and supportive shoes for beginners                                       |
	| Alla                | AllRounder Shoes                   | 1000   | Versatile shoes suitable for all types of climbing                                   |

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