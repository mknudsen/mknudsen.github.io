// Check for admin cookie and show edit links if present
(function () {
    // Function to show edit links when admin cookie is set
    function showEditLinks() {
        const cookies = document.cookie.split('; ');
        const isAdmin = cookies.filter(cookie => cookie.trim().startsWith('admin=')).length > 0;

        if (isAdmin) {
            // Add admin-visible class to all edit-link-container elements
            const editContainers = document.querySelectorAll('.edit-link-container');

            editContainers.forEach((container, index) => {
                container.classList.add('admin-visible');
            });
        }
    }

    // Run immediately if DOM is ready, otherwise wait for it
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', showEditLinks);
    } else {
        showEditLinks();
    }
})();