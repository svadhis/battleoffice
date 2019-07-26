//Collapsible init
document.addEventListener('DOMContentLoaded', function () {
    M.Collapsible.init(document.querySelectorAll('.collapsible'));
    M.FormSelect.init(document.querySelectorAll('select'));
});


// Gestion du formulaire facultatif (adresse de livraison)
let toggleForm = () => {
    let inputs = document.querySelectorAll('.shipping-address input');
    let toggleButton = document.querySelector('.show-shipping-address');

    if (toggleButton.classList.contains('opened')) {
        inputs.forEach(input => {
            input.required = false;
        });
        toggleButton.classList.remove('opened');
    }
    else {
        inputs.forEach(input => {
            input.required = true;
        });
        toggleButton.classList.add('opened');
    }  
}