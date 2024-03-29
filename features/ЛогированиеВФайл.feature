﻿#language: ru

@tree

Функционал: Логирование через способ логирования "Файл"

Как Разработчик я хочу
Иметь возможность при необходимости записывать логирующие сообщения в произвольный файл на диске
чтобы обеспечить возможность независимого от базы изучения логов

Сценарий: Логирование на клиенте ниже уровня логирования по умолчанию
	Когда я инициализирую лог по умолчанию на клиенте
	И я инициализирую лог с именем "ЛогироватьНеУмею" на клиенте
	И я получаю имя временного файла и сохраняю его в переменную "ФайлНаКлиенте"
	И добавляю в лог с именем "" вариант логирования Файл в контексте "" файл с именем "ФайлНаКлиенте"
	И я вывожу лог с уровнем логирования отладка сообщение "Привет. Это первый лог" в лог с именем ""
	и я вывожу лог с уровнем логирования отладка сообщение "Привет. Этого лога не должно быть" в лог с именем "ЛогироватьНеУмею"
	и я вывожу лог с уровнем логирования информация сообщение "Привет. Это второй лог" в лог с именем ""
	и в файле логирования "ФайлНаКлиенте" количество строк равно 1

Сценарий: Логирование на клиенте и сервере в один файл
	Когда я инициализирую лог по умолчанию на клиенте
	И я инициализирую лог с именем "ЛогироватьНеУмею" на клиенте
	И я получаю имя временного файла и сохраняю его в переменную "ФайлНаКлиенте"
	И добавляю в лог с именем "" вариант логирования Файл в контексте "" файл с именем "ФайлНаКлиенте"
	и я вывожу лог с уровнем логирования информация сообщение "Привет. Это первый лог" в лог с именем ""
	и я вывожу лог с уровнем логирования информация сообщение "Привет. Это второй лог" в лог с именем ""
	и я вывожу лог с уровнем логирования информация сообщение на сервере "Привет. Это третий лог" в лог с именем ""
	и в файле логирования "ФайлНаКлиенте" количество строк равно 3

Сценарий: Логирование на клиенте и сервере в разные файлы
	Когда я инициализирую лог по умолчанию на клиенте
	И я получаю имя временного файла и сохраняю его в переменную "ОбщийФайл"
	И я получаю имя временного файла и сохраняю его в переменную "ФайлНаКлиенте"
	И я получаю имя временного файла на сервере и сохраняю его в переменную "ФайлНаСервере"
	И добавляю в лог с именем "" вариант логирования Файл в контексте "" файл с именем "ОбщийФайл"
	и я вывожу лог с уровнем логирования информация сообщение "Привет. Это первый лог" в лог с именем ""
	И добавляю в лог с именем "" вариант логирования Файл в контексте "Клиент" файл с именем "ФайлНаКлиенте"
	и я вывожу лог с уровнем логирования информация сообщение "Привет. Это второй лог" в лог с именем ""
	И добавляю в лог с именем "" вариант логирования Файл в контексте "Сервер" файл с именем "ФайлНаСервере"
	и я вывожу лог с уровнем логирования информация сообщение на сервере "Привет. Это третий лог" в лог с именем ""
	и в файле логирования "ОбщийФайл" количество строк равно 3
	и в файле логирования "ФайлНаКлиенте" количество строк равно 1
	и в файле логирования "ФайлНаСервере" количество строк равно 1