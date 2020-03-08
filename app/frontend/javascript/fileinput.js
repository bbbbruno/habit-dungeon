document.addEventListener('turbolinks:load', () => {
  const preview = document.querySelector('.field._file img')
  const input = document.querySelector('.field._file input[type=file]')
  input.addEventListener('change', e => {
    const file = e.target.files[0]
    const reader = new FileReader()
    reader.addEventListener('load', () => {
      const span = document.querySelector('.field._file span')

      preview.src = reader.result
      span.innerHTML = '画像を変更'
    })

    if (file) {
      reader.readAsDataURL(file)
    }
  })
})
