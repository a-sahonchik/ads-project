# ADS PROJECT


## История изменений

### 10.1 Корректировки

Внесены небольшие корректировки

### 10. Добавлены статусы объявлений

#### Черновик

- Как только пользователь создал объявление
- Нигде не отображается, кроме как самому пользователю
- Пользователь может редактировать объяву (если он автор)
- Пользователь может удалить объяву
- Можно перевести в статус "Новая"

#### Новая

- Когда пользователь отправил объявление на проверку
- Пользователь не может изменить объяву
- Пользователь может удалить объяву
- Объяву видит админ в админке
- Админ может принять или отклонить объявление

#### Отклонена

- Когда админ отклонил объяву
- Пользователь может удалить объяву или вернуть в черновики для редактирования и последующей отправки на модерацию

#### Одобрена

- Одобрена админом и скоро будет опубликована
- Пользователь может удалить объяву
- Автоматически переводится в статус "Опубликована"
- Публикуется автоматически в полночь

#### Опубликована

- Отображается, видят все пользователи
- Пользователь может удалить объяву
- Админ может удалить объяву

#### Архивная

- Объява снята с публикации и помещена в архив
- Опубликованные объявы автоматически переходят в архив в 23:50 после трех дней в публикации
- Пользователь может удалить объяву или вернуть в черновики для редактирования и последующей отправки на модерацию

### 9. Тестирование моделек

Были протестированы модели с помощью Rspec.

### 8. Добавлена авторизация, аутентификация и роли

Теперь в приложении можно зарегистрироваться и авторизоваться.

#### Незалогиненный пользователь (гость) может:
- Видеть объявления и типы объявлений
- Открывать объявления и просматривать их
- Открывать страницы типов объявлений и просматривать объявления (но не может просматривать список всех типов)
- Фильтровать объявления по типу и сортировать по дате
- Открывать страницы пользователей с их объявлениями (но не может просматривать список всех пользователей)

#### Залогиненный пользователь (user) может:
- Все возможности гостя
- Редактировать и удалять свои объявления
- Изменять email, пароль и имя пользователя

#### Администратор (admin) может:
- Все возможности гостя
- Удалять любое объявление
- Просматривать список всех пользователей
- Добавлять, редактировать и удалять пользователей
- Изменять роли пользователей
- Создавать новые типы объявлений
- Удалять типы объявлений (только если нет ни одного объявления с этим типом)
- НЕ МОЖЕТ создавать и редактировать объявления

### 7. Добавлена фильтрация и сортировка
Теперь объявления можно фильтровать (на общей странице объявлений):
- По типу

И сортировать:
- Сначала новые
- Сначала старые

### 6. Добавлена пагинация

- Для страницы со всеми объявлениями.
- Для страниц типов объявлений.

### 5. Исправлена ошибка с некорректной ссылкой на тип объявления в хлебных крошках

- Ссылки на типы объявлений в хлебных крошках работали некорректно. Теперь всё ок.

### 4. Прикручена верстка
- Теперь приложение выглядит лучше.

### 3. Добавлены хлебные крошки
- Добавлены хлебные крошки для упрощения навигации.

### 2. Добавлены типы для объявлений
- Добавлены типы для объявлений (Покупка, продажа, аренда, работа).
- У каждго объявления есть свой тип.
- На странице каждого типа выводятся объявления с этим типом.
- Можно удалять существующие и добавлять новые типы.

### 1. Добавлены объявления
- Добавлены объявления.
- Их можно создавать, просматривать, редактировать и удалять.
