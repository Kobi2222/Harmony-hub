// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
document.addEventListener('DOMContentLoaded', function() {
    const flashMessages = document.querySelectorAll('.flash');
    const duration = 2000;

    flashMessages.forEach(function(flashMessage) {
        setTimeout(function() {
            flashMessage.style.transition = 'opacity 0.5s';
            flashMessage.style.opacity = '0';

            flashMessage.addEventListener('transitionend', function() {
                flashMessage.remove();
            });
        }, duration);
    });
});