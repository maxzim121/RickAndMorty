# Rick&Morty

## Описание
Приложение отображает список персонажей из сериала "Рик и Морти" с помощью Rick and Morty REST API. Состоит из двух экранов: список персонажей и детальная информация о выбранном персонаже.

## Функциональность
1. **Первый экран**: Список всех персонажей с изображением, именем и полом. Поддерживается пагинация и бесконечная прокрутка.
2. **Второй экран**: Детальная информация о персонаже, доступная по нажатию на элемент списка.

## Архитектура
Приложение разработано с использованием архитектуры **MVVM** с применением **Coordinator** для навигации и **Dependency Injection** для управления зависимостями.

## Технологии
- **Язык**: Swift
- **Архитектура**: MVVM + Coordinator
- **Паттерны**: Dependency Injection
- **API**: Rick and Morty REST API (https://rickandmortyapi.com/documentation/#rest)
- **Пагинация**: Реализована с бесконечной прокруткой.
