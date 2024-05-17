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

Then('I should not see the product {string}', (product) => {
  cy.get('.product .name').should('not.include.text', product);
});