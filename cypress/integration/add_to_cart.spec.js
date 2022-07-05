describe('Home page testing', () => {
  it('opens the homepage', () => {
    cy.visit('/');
  });
  it('There is 2 products on the page', () => {
    cy.get('.products article').should('have.length', 2);
  });
  it('adds a product to the cart', () => {
    cy.get('.products article').first();
    cy.contains('My Cart').should('have.text', ' \n          My Cart (0) \n');
    cy.get('.button_to > .btn').first().click({ force: true });
    cy.contains('My Cart').should('have.text', ' \n          My Cart (1) \n');
  });
});
