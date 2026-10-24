// 1. Мобильді мәзір
const burger = document.querySelector('.burger');
const navLinks = document.querySelector('.nav-links');
if (burger && navLinks) {
  burger.addEventListener('click', () => navLinks.classList.toggle('open'));
}

// 2. Жаттығуларды іздеу және сүзу (classes.html)
const search = document.getElementById('search');
const category = document.getElementById('category');
const cards = document.querySelectorAll('.class-card');
const empty = document.querySelector('.empty');

function filterClasses() {
  const q = search.value.trim().toLowerCase();
  const cat = category.value;
  let visible = 0;
  cards.forEach(card => {
    const matchText = card.dataset.title.toLowerCase().includes(q) ||
                      card.dataset.trainer.toLowerCase().includes(q);
    const matchCat = cat === 'all' || card.dataset.category === cat;
    const show = matchText && matchCat;
    card.style.display = show ? '' : 'none';
    if (show) visible++;
  });
  if (empty) empty.style.display = visible === 0 ? 'block' : 'none';
}
if (search && category) {
  search.addEventListener('input', filterClasses);
  category.addEventListener('change', filterClasses);
}

// 3. Формаларды валидациялау (login.html, register.html)
function setError(field, message) {
  field.classList.add('invalid');
  field.querySelector('.error').textContent = message;
}
function clearErrors(form) {
  form.querySelectorAll('.field').forEach(f => f.classList.remove('invalid'));
}

const emailRe = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

function validateForm(form) {
  clearErrors(form);
  let ok = true;
  const get = name => form.elements[name];
  const box = el => el.closest('.field');

  if (get('full_name') && get('full_name').value.trim().length < 3) {
    setError(box(get('full_name')), 'Аты-жөніңізді толық жазыңыз (кемінде 3 таңба)');
    ok = false;
  }
  if (!emailRe.test(get('email').value.trim())) {
    setError(box(get('email')), 'Email дұрыс емес');
    ok = false;
  }
  if (get('phone') && !/^\+?\d{10,15}$/.test(get('phone').value.replace(/[\s()-]/g, ''))) {
    setError(box(get('phone')), 'Телефон нөмірін дұрыс жазыңыз');
    ok = false;
  }
  if (get('password').value.length < 6) {
    setError(box(get('password')), 'Пароль кемінде 6 таңба болуы керек');
    ok = false;
  }
  if (get('password2') && get('password2').value !== get('password').value) {
    setError(box(get('password2')), 'Парольдер сәйкес келмейді');
    ok = false;
  }
  return ok;
}

document.querySelectorAll('form[data-validate]').forEach(form => {
  form.addEventListener('submit', e => {
    e.preventDefault();
    if (validateForm(form)) {
      const msg = form.querySelector('.success');
      if (msg) msg.style.display = 'block';
      form.reset();
    }
  });
});
