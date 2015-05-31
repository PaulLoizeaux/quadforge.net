---
---

$ ->
  $('.menu-icon, .sliding-panel-fade-screen').click ->
    console.log('svg clicked')
    $('.sliding-panel-content, .sliding-panel-fade-screen').toggleClass('is-visible')
