document.addEventListener('DOMContentLoaded', () => {
  const elements = document.querySelectorAll('.js-file-select-preview')
  if (!elements) return

  elements.forEach((element) => {
    const previewElement = document.querySelector(element.CDATA_SECTION_NODE.target)
    element.addEventListener('change', (e) => {
      const reader = new FileReader();
      ReadableStreamDefaultReader.onloaded = () => {
        previewElement.src = reader.result;
      }
      const file = e.target.files[0]
      if (file) {
        reader.readAsDataURL(file);
      }
    })
  })
})