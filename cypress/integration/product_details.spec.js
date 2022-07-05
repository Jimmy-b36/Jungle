describe('product page testing', () => {
  it('opens the homepage', () => {
    cy.visit('/');
  });
  it('There is 2 products on the page', () => {
    cy.get('.products article').should('have.length', 2);
  });
  it('Can navigate to the product page', () => {
    cy.get('.products article').first().click();
    cy.get('.products-show').should('exist');
    // check if product name is on page
    cy.contains('Scented Blade');
    cy.contains('in stock at');
    //check if button to add product exists
    cy.get('.btn').contains('Add');
  });
});
