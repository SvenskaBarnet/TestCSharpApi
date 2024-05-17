Feature: As user I want to be able to see the correct products listed when I have chosen a category so that I can easily filter the product list by category.

  Scenario Outline: Check that the category <category> shows the product <product>.
    Given that I am on the product page
    When I choose the category "<category>"
    Then I should see the product "<product>"

    Examples:
      | category            | product                         |
      | Bouldering          | Crash Pad                       |
      | Bouldering          | Chalk Bag                       |
      | Bouldering          | Climbing Brush                  |
      | Bouldering          | Climbing Holds Set              |
      | Bouldering          | Climbing Tape                   |
      | Climbing Shoes      | SuperGrip Shoes                 |
      | Climbing Shoes      | Beginner Climb Shoes         |
      | Climbing Shoes      | AllRounder Shoes                |
      | Climbing Harnesses  | Climbing Helmet                 |
      | Climbing Harnesses  | Climbing Harness - Basic        |
      | Climbing Harnesses  | Climbing Harness - Professional |
      | Climbing Harnesses  | Belay Device                    |
      | Climbing Ropes      | Dynamic Climbing Rope - 60m     |
      | Climbing Ropes      | Static Climbing Rope - 30m      |
      | Climbing Ropes      | Quickdraw Set                   |
      | Climbing Ropes      | Carabiner - Locking             |
      | Climbing Clothes    | StretchClimb Pants              |
      | Climbing Clothes    | Breathable Climb Shirt          |
      | Climbing Clothes    | Insulated Climb Jacket          |

