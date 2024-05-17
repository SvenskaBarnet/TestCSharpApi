import { Given, When, Then } from "@badeball/cypress-cucumber-preprocessor";

Given('that I am on the product page', () => {
  cy.visit('/products');
});

When('I choose the category {string}', (category) => {
  cy.get('#categories').select(category);
});
Then('I should see the product {string}', (product) => {
  cy.get('.product .name').contains(product);
});

Then('The product {string} should have the price {string}', (product, price) => {
  cy.get('.product').contains('div.product', product).find('.price ').contains('Pris: ' + price + ' kr');
});

Then('The product {string} should have the description {string}', (product, description) => {
  cy.get('.product').contains('div.product', product).find('.description').contains(description);
});

Then('I should not see the product {string}', (product) => {
  cy.get('.product .name').should('not.include.text', product);
});