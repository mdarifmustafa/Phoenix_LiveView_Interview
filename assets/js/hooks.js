// Utility function to check if an element is within the viewport
export function isInViewport(element) {
  const rect = element.getBoundingClientRect();
  const windowHeight = (window.innerHeight || document.documentElement.clientHeight);
  const windowWidth = (window.innerWidth || document.documentElement.clientWidth);

  return (
    rect.top >= 0 &&
    rect.left >= 0 &&
    rect.bottom <= windowHeight &&
    rect.right <= windowWidth
  );
}

// Define the ScrollToItem hook
export const ScrollToItem = {
  mounted() {
    if (!isInViewport(this.el)) {
      this.el.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
    this.pushState();
  },
  updated() {
    if (!isInViewport(this.el)) {
      this.el.scrollIntoView({ behavior: 'smooth', block: 'center' });
    }
    this.pushState();
  },
  pushState() {
    // Dynamically update the URL without refreshing the page
    const newUrl = new URL(window.location.href);
    // newUrl.searchParams.set('question_key', this.el.getAttribute('phx-value-id'));
    history.pushState({}, '', newUrl);
  }
}
