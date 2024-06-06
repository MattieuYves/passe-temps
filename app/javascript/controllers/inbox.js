// document.addEventListener('DOMContentLoaded', function() {
//     const minimizeIcon = document.querySelector('.fa-solid.fa-minimize');
//     minimizeIcon.addEventListener('click', function() {
//         // Basculer la classe pour l'animation de l'expansion
//         document.querySelector('.inbox-chat').classList.toggle('expanded');

//         // Vérifier si l'icône est actuellement en mode "minimize"
//         if (minimizeIcon.classList.contains('fa-minimize')) {
//             // Changer de "minimize" à "maximize"
//             minimizeIcon.classList.remove('fa-minimize');
//             minimizeIcon.classList.add('fa-maximize');
//         } else {
//             // Changer de "maximize" à "minimize"
//             minimizeIcon.classList.remove('fa-maximize');
//             minimizeIcon.classList.add('fa-minimize');
//         }
//     });
// });

// document.addEventListener('DOMContentLoaded', function() {
//     const closeIcon = document.querySelector('.fa-solid.fa-xmark');
//     closeIcon.addEventListener('click', function() {
//         const chatBox = document.querySelector('.inbox-chat');
//         chatBox.classList.add('d-none');
//     });
// });

export default class extends Controller {
    static targets = ["inboxChat"];
  
    close() {
      this.inboxChatTarget.classList.add("d-none");
    }
  }

