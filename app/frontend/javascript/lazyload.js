import lozad from 'lozad'

document.addEventListener('turbolinks:load', () => {
  const observer = lozad() // lazy loads elements with default selector as '.lozad'
  observer.observe()
})
