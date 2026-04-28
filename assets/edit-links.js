// Check for admin cookie and show edit links if present
(function() {
  // Function to show edit links when admin cookie is set
  function showEditLinks() {
    // Check if admin cookie is set
    const cookies = document.cookie.split('; ');
    let isAdmin = false;
    
    for (let i = 0; i < cookies.length; i++) {
      const cookie = cookies[i].trim();
      if (cookie.startsWith('admin=')) {
        const value = cookie.substring(6); // Remove "admin=" prefix
        if (value === 'true' || value === '1') {
          isAdmin = true;
          break;
        }
      }
    }
    
    if (isAdmin) {
      // Add admin-visible class to all edit-link-container elements
      const editContainers = document.querySelectorAll('.edit-link-container');
      
      editContainers.forEach((container, index) => {
        // Add the class
        container.classList.add('admin-visible');
        
        // Find the link inside and modify its href to point to edit view
        const link = container.querySelector('a');
        if (link && link.href) {
          // Convert blob URL to edit URL
          const currentHref = link.href;
          if (currentHref.includes('/blob/')) {
            // Replace /blob/ with /edit/ to get the edit view
            const newHref = currentHref.replace('/blob/', '/edit/');
            link.href = newHref;
          }
        }
        
        // Force display with !important using CSSOM
        const style = document.createElement('style');
        style.textContent = `
          .edit-link-container {
            display: block !important;
            visibility: visible !important;
            opacity: 1 !important;
          }
        `;
        document.head.appendChild(style);
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