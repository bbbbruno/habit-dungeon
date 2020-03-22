document.addEventListener('turbolinks:load', () => {
  const inputs = document.querySelectorAll('.field._file input[type=file]')
  if (inputs) {
    for (let input of inputs) {
      input.addEventListener('change', e => {
        const preview = input.closest('.preview').querySelector('img')
        console.log(preview)
        const file = e.target.files[0]
        const reader = new FileReader()
        reader.addEventListener('load', () => {
          const span = input.closest('.preview').querySelector('span')

          preview.src = reader.result
          span.innerHTML = '画像を変更'
        })

        if (file) {
          reader.readAsDataURL(file)
        }
      })
    }
  }
})
