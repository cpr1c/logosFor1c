# logosFor1c

Данный проект содержит подсистему с интерфейсом логирования похожим на модуль logos.

# Зачем?
За основу взята обработка https://github.com/codenull/log1c. К сожалению, с ней не очень удобно работать, если нужно логировать одновременно на клиенте и на сервере. Также хотелось бы иметь возможность сохранить настройки логирования в базе, чтобы каждый раз их не задавать кодом. 

# Установка
1. Скачать конфигурацию из данного проекта.
2. Запустить Сравнение/объединение конфигураций в базе, на которой требуется логирование.
3. Снять все флажки.
4. Нажать Действия - Установить по подсистемам файла. Выбрать подсистему лЛогирование
5. Через настройку объединения или вручную добавить в модуль приложения инициализацию 2 переменных (окружены областью Логирование)
6. Через настройку объединения или вручную добавить в модуль сеанса инициализацию 2 параметров сеанса (окружены областью Логирование)
7. Сохранить изменения и обновить конфигурацию базы данных.

# Настройка 
Подсистема позволяет хранить настройки логирования в базе. Если установить значение константы лНастройкиЛогирования, выбранная настройка будет использоваться по умолчанию. Также можно добавить в справочник лНастройкиЛогирования несколько настроек для быстрой инициализации по наименованию настройки.

# Использование

## Инициализация

1. Инициализация с настройками по умолчанию

```bsl
лЛог.Инициализировать();
```

Если установлено значение константы лНастройкиЛогирования, настройки будут взяты из нее. Иначе будут использованы настройки по умолчанию (описаны в функции лЛогированиеВызовСервераСлужебный.НастройкиЛогированияПоУмолчанию().

Если для логирования нужны настройки по умолчанию, инициализацию можно пропустить, она сама выполнится при первом вызове метода логирования.

2. Инициализация по наименованию настройки

```bsl
лЛог.Инициализировать(Ложь, Наименование);
```
Наименование должно совпадать с наименованием настройки в справочнике лНастройкиЛогирования.

## Уровни логирования и основные методы
В подсистеме используется 4 уровня логирования (по возрастанию приоритета):
1. ОТЛАДКА
2. ИНФОРМАЦИЯ
3. ПРЕДУПРЕЖДЕНИЕ
4. ОШИБКА

По умолчанию используется уровень логирования ОШИБКА. При установке какого-либо уровня, в лог будут выводиться только сообщения этого уровня и уровней с большим приоритетом. Например, если установлен уровень ИНФОРМАЦИЯ то будут выводиться сообщения следующих уровней: ИНФОРМАЦИЯ, ПРЕДУПРЕЖДЕНИЕ, ОШИБКА.

Уровень логирования можно изменить с помощью метода *УстановитьУровеньЛогирования()*:
```bsl
лЛог.УстановитьУровеньЛогирования(УровеньЛогирования);
```

Уровень логиования можно передать строкой (регистр не важен) или значением перечисления лУровниЛогирования.

Каждому уровню логирования соответствует свой метод вывода информации:
```bsl
лЛог.Отладка_("Отладочное сообщение", "Имя события");
лЛог.Информация_("Информационное сообщение", "Имя события");
лЛог.Предупреждение_("Предупреждающее сообщение", "Имя события")
лЛог.Ошибка_("Сообщение об ошибке", "Имя события");
```
Если не передать имя события, оно будет взято из текущих параметров логирования (см. ниже). 

## Способы логирования
Поддерживаются следующие способы:
* Консоль
* Файл
* Память
* ЖурналРегистрации
* База

Способы логирования можно хранить в справочнике с настройками логирования. Также можно добавлять способ программно:

```bsl
лЛог.ДобавитьСпособЛогирования(СпособЛогирования, ШаблонСообщения = "", ФорматДаты = "");
```

Способ логирования можно передать строкой (регистр не важен) или значением перечисления лСпособыЛогирования.

Шаблоны сообщения описаны ниже.

Формат даты передается в платформенную функцию Формат().

# Шаблон сообщения
При добавлении способов вывода для них можно задать свой шаблон сообщения. В шаблонах поддерживаются следующие псевдонимы:
* **%УРОВЕНЬ%**- уровень лога которым было сформировано сообщение (например: ИНФОРМАЦИЯ).
* **%СОБЫТИЕ%**   - указанное событие логирования (имя лога).
* **%СООБЩЕНИЕ%** - текст выводимого сообщения.
* **%ДАТА%** - дата и время в формате yyyy.MM.dd HH:mm:ss (например: 2020.09.16 23:52:49), либо в пользовательском формате заданном через параметр ФорматДаты.
* **%ДАТАМС%** - количество миллисекунд текущей даты.
* **%УНИВЕРСАЛЬНАЯДАТАМС%** - универсальная дата полученная с помощью функции ТекущаяУниверсальнаяДатаВМиллисекундах().

**ВАЖНО:** псевдонимы регистрозависмые и допускается их указание только в верхнем регистре.

Пример шаблона:
```bsl
лЛог.ДобавитьСпособЛогирования("Консоль", "%ДАТА%.%ДАТАМС% - %УНИВЕРСАЛЬНАЯДАТАМС% - %СОБЫТИЕ% - %УРОВЕНЬ% - %СООБЩЕНИЕ%");
лЛог.Предупреждение_("Предупредительное 1 сообщение");
```
```
2020.09.16 23:53:08.771 - 63735861188771 - Логирование - ПРЕДУПРЕЖДЕНИЕ - Предупредительное 1 сообщение
```
## Параметры логирования

На клиенте хранятся в глобальной переменной лПараметрыЛогирования. На сервере - в параметре сеанса лПараметрыЛогирования. Тип значения - Фиксированная структура.

Получить можно с помощью функции:
```bsl
лЛог.ПараметрыЛогирования();
```

## Имя события

В параметрах логирования хранится имя события по умолчанию. При инициализации устанавливается значение "Логирование". Изменить это значение можно с помощью метода:
```bsl
лЛог.УстановитьИмяСобытияЛогирования(ИмяСобытия);
```

В основных методах логирования есть необязательный параметр ИмяСобытия. Если его заполнить, оно будет использовано в этой записи. Иначе будет использовано значение из параметров логирования.

Например,
```bsl
лЛог.УстановитьИмяСобытияЛогирования("Логирование.Глобальное");
лЛог.ДобавитьСпособЛогирования("Консоль", "%СОБЫТИЕ% - %СООБЩЕНИЕ%");

лЛог.Ошибка_("Возникла критичная ошибка", "Логирование.Событие1");
лЛог.Информация_("Дополнительная инфорация");
``` 

В результате будет выведено: 

```
"Логирование.Событие1 - Возникла критичная ошибка"
"Логирование.Глобальное - Дополнительная инфорация"
```

## Логирование в файл
Для логирования в файл небходимо задать имя файла лога. Отдельно задается для клиента и для сервера с помощью метода:

```bsl
лЛог.УстановитьПутьКФайлуЛогирования(ПутьКФайлу);
```

Возможно настроить автоматическое формирование путей к файлам. Для этого в справочнике с настройками нужно заполнить путь к каталогу логов. При инициализации логирования в указанном каталоге для каждого сеанса будет создан свой файл лога с именем "Лог сеанса Сеанс [НомерСеанса] от [ТекущаяДата].txt".

## Отключение логирования
Метод *ОтключитьЛогирование()* позволяет выключить логирование, обратное включение осуществляется методом *ВключитьЛогирование()*. Это может быть удобным, если требуется отключить логи на определенном участке кода.


# Другие решения
* Обработка для логирования из одного объекта (обработки): https://github.com/codenull/log1c
* Модуль logos из OneScript: https://github.com/oscript-library/logos
* Подсистема логирования на базе модуля logos: https://github.com/1823244/logos-1c