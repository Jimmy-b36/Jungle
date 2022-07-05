describe('product page testing', () => {
  it('opens the homepage', () => {
    cy.visit('/');
  });
  it('There is 2 products on the page', () => {
    cy.get('.products article').should('have.length', 2);
  });
  it('Can navigate to the product page', () => {
    cy.get('.products article').first().click();
    cy.get(':nth-child(2) > h1').should('have.text', 'Scented Blade');
  });
});
