#Область ПрограммныйИнтерфейс

#Область ИнициализацияЛогирования

Процедура Инициализировать(ИспользоватьОсновную = Истина, Настройка = "") Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ИспользоватьОсновную И Метаданные.Константы.Найти("лНастройкиЛогирования") <> Неопределено Тогда
		Настройки = СохраненныеНастройкиЛогирования(Константы.лНастройкиЛогирования.Получить());
	ИначеЕсли ЗначениеЗаполнено(Настройка) Тогда
		Настройки = СохраненныеНастройкиЛогирования(Настройка);
	Иначе
		Настройки = НастройкиЛогированияПоУмолчанию();
	КонецЕсли;
		
	ПараметрыСеанса.лПараметрыЛогирования = Новый ФиксированнаяСтруктура(Настройки);
	
КонецПроцедуры

Функция ТекущиеНастройкиЛогирования() Экспорт
	Возврат ПараметрыСеанса.лПараметрыЛогирования;	
КонецФункции

Функция СохраненныеНастройкиЛогирования(Настройка)
	
	УстановитьПривилегированныйРежим(Истина);
		
	Запрос = Новый Запрос;
	Запрос.Текст = 
	"ВЫБРАТЬ
	|	лНастройкиЛогирования.УровеньЛогирования КАК УровеньЛогирования,
	|	ПРЕДСТАВЛЕНИЕ(лНастройкиЛогирования.УровеньЛогирования) КАК УровеньЛогированияПредставление,
	|	лНастройкиЛогирования.ПутьКаталогаЛоговНаКлиенте КАК ПутьКаталогаЛоговНаКлиенте,
	|	лНастройкиЛогирования.ПутьКаталогаЛоговНаСервере КАК ПутьКаталогаЛоговНаСервере,
	|	лНастройкиЛогирования.СпособыЛогирования.(
	|		СпособЛогирования КАК СпособЛогирования,
	|		ШаблонСообщения КАК ШаблонСообщения,
	|		ФорматДаты КАК ФорматДаты,
	|		ПРЕДСТАВЛЕНИЕ(лНастройкиЛогирования.СпособыЛогирования.СпособЛогирования) КАК СпособЛогированияПредставление
	|	) КАК СпособыЛогирования
	|ИЗ
	|	Справочник.лНастройкиЛогирования КАК лНастройкиЛогирования
	|ГДЕ
	|	лНастройкиЛогирования.Ссылка = &Ссылка";

	Если ТипЗнч(Настройка) = Тип("Строка") Тогда
		Запрос.УстановитьПараметр("Ссылка", Справочники.лНастройкиЛогирования.НайтиПоНаименованию(Настройка, Истина));
	Иначе
		Запрос.УстановитьПараметр("Ссылка", Настройка);
	КонецЕсли;

	Результат = Запрос.Выполнить();

	Если Результат.Пустой() Тогда
		ЗаписатьОшибкуЛогированияВЖурналРегистрации("Логирование.Инициализация", СтрШаблон("Не найдена настройка логирования %1", Настройка));
		Возврат НастройкиЛогированияПоУмолчанию();
	КонецЕсли;
	
	Выборка = Результат.Выбрать();
	Выборка.Следующий();
	
	Настройки = Новый Структура;
	
	Настройки.Вставить("Отключен", Ложь);
	Настройки.Вставить("УровеньЛогирования", Выборка.УровеньЛогирования);
	Настройки.Вставить("УровеньЛогированияПредставление", Выборка.УровеньЛогированияПредставление);	
	Настройки.Вставить("ПриоритетУровняЛогирования", лЛогированиеКлиентСерверСлужебный.ПриоритетУровняЛогирования(Выборка.УровеньЛогирования));
	Настройки.Вставить("ПутьКаталогаЛоговНаКлиенте", Выборка.ПутьКаталогаЛоговНаКлиенте);
	Настройки.Вставить("ПутьКаталогаЛоговНаСервере", Выборка.ПутьКаталогаЛоговНаСервере);
	
	Способы = Новый Соответствие;
	ВыборкаСпособы = Выборка.СпособыЛогирования.Выбрать();
	Пока ВыборкаСпособы.Следующий() Цикл
		НастройкиСпособа = Новый Структура;
		НастройкиСпособа.Вставить("ШаблонСообщения", 	?(ЗначениеЗаполнено(ВыборкаСпособы.ШаблонСообщения), ВыборкаСпособы.ШаблонСообщения, лЛог.ШаблонСообщенияПоУмолчанию()));
		НастройкиСпособа.Вставить("ФорматДаты", 		?(ЗначениеЗаполнено(ВыборкаСпособы.ФорматДаты), ВыборкаСпособы.ФорматДаты, лЛог.ФорматДатыПоУмолчанию()));
		НастройкиСпособа.Вставить("Представление", 		ВыборкаСпособы.СпособЛогированияПредставление);
		Способы.Вставить(ВыборкаСпособы.СпособЛогирования, Новый ФиксированнаяСтруктура(НастройкиСпособа));
	КонецЦикла;
	
	Настройки.Вставить("СпособыЛогирования", Новый ФиксированноеСоответствие(Способы));
	
	Настройки.Вставить("ИмяСобытия", "Логирование");
	
	КлючСеанса = СтрШаблон("Сеанс %1 от %2", НомерСеансаИнформационнойБазы(), Формат(ТекущаяУниверсальнаяДата(), "ДФ='dd.MM.yyyy HH-mm-ss'"));
	Настройки.Вставить("КлючСеанса", КлючСеанса);
	
	Если Настройки.СпособыЛогирования.Получить(Перечисления.лСпособыЛогирования.Файл) = Неопределено Тогда
		
		Настройки.Вставить("ИмяФайлаЛогаНаКлиенте", "");
		Настройки.Вставить("ИмяФайлаЛогаНаСервере", "");
		
	Иначе
		
		ИмяФайлаЛога = ЗаменитьНедопустимыеСимволыВИмениФайла(СтрШаблон("Лог сеанса %1.txt", КлючСеанса));
			
		Настройки.Вставить("ИмяФайлаЛогаНаКлиенте", ДобавитьКонечныйРазделительПути(Настройки.ПутьКаталогаЛоговНаКлиенте) + ИмяФайлаЛога);
		Настройки.Вставить("ИмяФайлаЛогаНаСервере", ДобавитьКонечныйРазделительПути(Настройки.ПутьКаталогаЛоговНаСервере) + ИмяФайлаЛога);
		
	КонецЕсли;
	
	Возврат Настройки;
	
КонецФункции

Функция НастройкиЛогированияПоУмолчанию()
	
	УстановитьПривилегированныйРежим(Истина);
	
	Настройки = Новый Структура;
	Настройки.Вставить("Отключен", Ложь);
	Настройки.Вставить("УровеньЛогирования", ПредопределенноеЗначение("Перечисление.лУровниЛогирования.ОШИБКА"));
	Настройки.Вставить("УровеньЛогированияПредставление", Настройки.УровеньЛогирования);	
	Настройки.Вставить("ПриоритетУровняЛогирования", лЛогированиеКлиентСерверСлужебный.ПриоритетУровняЛогирования(Настройки.УровеньЛогирования));
	Настройки.Вставить("ПутьКаталогаЛоговНаКлиенте", "");
	Настройки.Вставить("ПутьКаталогаЛоговНаСервере", "");
	
	Способы = Новый Соответствие;
	Настройки.Вставить("СпособыЛогирования", Новый ФиксированноеСоответствие(Способы));
	
	Настройки.Вставить("ИмяСобытия", "Логирование");
	
	КлючСеанса = СтрШаблон("Сеанс %1 от %2", НомерСеансаИнформационнойБазы(), Формат(ТекущаяУниверсальнаяДата(), "ДФ='dd.MM.yyyy HH-mm-ss'"));
	Настройки.Вставить("КлючСеанса", КлючСеанса);
	
	Настройки.Вставить("ИмяФайлаЛогаНаКлиенте", "");
	Настройки.Вставить("ИмяФайлаЛогаНаСервере", "");
	
	Возврат Настройки;
	
КонецФункции

// Сбрасывает параметры логирования до настроек по умолчанию 
// и очищает массив с сообщениями лога, если включено логирование в память
//
Процедура ЗавершитьЛогирование() Экспорт
	
	ПараметрыСеанса.лПараметрыЛогирования = Новый ФиксированнаяСтруктура(НастройкиЛогированияПоУмолчанию());
	ПараметрыСеанса.лСообщенияЛогирования = Новый ФиксированныйМассив(Новый Массив);
	
КонецПроцедуры

#КонецОбласти

#Область ЗаписьВЛог

Процедура ДобавитьЗаписьВЖурналРегистрации(Сообщение, ДопПараметры) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	лПараметрыЛогирования = ПараметрыСеанса.лПараметрыЛогирования;
	
	Текст = лЛогированиеКлиентСерверСлужебный.СтрокаСообщенияЛога(Сообщение, ДопПараметры);
	
	УровеньЖР = СоответствиеУровнейЛогированияУровнямЖР()[ДопПараметры.УровеньЛогирования];
	Если УровеньЖР = Неопределено Тогда
		УровеньЖР = УровеньЖурналаРегистрации.Примечание;
	КонецЕсли;
	
	Если ДопПараметры.Свойство("ИмяСобытия") Тогда
		ИмяСобытия = ДопПараметры.ИмяСобытия;
	Иначе
		ИмяСобытия = лПараметрыЛогирования.ИмяСобытия;
	КонецЕсли;
	
	ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖР, , , Текст);
	
КонецПроцедуры

Процедура ДобавитьЗаписьВРегистр(Сообщение, ДопПараметры) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	лПараметрыЛогирования = ПараметрыСеанса.лПараметрыЛогирования;
	
	Текст = лЛогированиеКлиентСерверСлужебный.СтрокаСообщенияЛога(Сообщение, ДопПараметры);
	
	Если ДопПараметры.Свойство("ИмяСобытия") Тогда
		ИмяСобытия = ДопПараметры.ИмяСобытия;
	Иначе
		ИмяСобытия = лПараметрыЛогирования.ИмяСобытия;
	КонецЕсли;
	
	ДатаЗаписи = ТекущаяДатаСеанса();
	ИдентификаторЗаписи = Строка(Новый УникальныйИдентификатор);
	
	Набор = РегистрыСведений.лСообщенияЛогирования.СоздатьНаборЗаписей();
	Набор.Отбор.ИмяСобытия.Установить(ИмяСобытия);
	Набор.Отбор.КлючСеанса.Установить(лПараметрыЛогирования.КлючСеанса);
	Набор.Отбор.Дата.Установить(ДатаЗаписи);
	Набор.Отбор.Идентификатор.Установить(ИдентификаторЗаписи);
	
	Запись = Набор.Добавить();
	Запись.ИмяСобытия = ИмяСобытия;
	Запись.КлючСеанса = лПараметрыЛогирования.КлючСеанса;
	Запись.Дата = ДатаЗаписи;
	Запись.Идентификатор = ИдентификаторЗаписи;
	Запись.ТекстСообщения = Текст;
	Запись.Уровень = ДопПараметры.УровеньЛогирования;
	
	Попытка
		Набор.Записать();
	Исключение
		ЗаписатьОшибкуЛогированияВЖурналРегистрации(ИмяСобытия, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#Область ДанныеЛога

Функция ЛогИзБазы(ПараметрыОтбора, ПоляИтогов, ПоляУпорядочивания) Экспорт
	
	Запрос = Новый Запрос;
	ТекстЗапроса = 
	"ВЫБРАТЬ
	|	лСообщенияЛогирования.ИмяСобытия КАК ИмяСобытия,
	|	лСообщенияЛогирования.КлючСеанса КАК КлючСеанса,
	|	лСообщенияЛогирования.Дата КАК Дата,
	|	лСообщенияЛогирования.Идентификатор КАК Идентификатор,
	|	лСообщенияЛогирования.ТекстСообщения КАК ТекстСообщения,
	|	лСообщенияЛогирования.Уровень КАК Уровень
	|ИЗ
	|	РегистрСведений.лСообщенияЛогирования КАК лСообщенияЛогирования
	|ГДЕ
	|	ИСТИНА
	|	И лСообщенияЛогирования.ИмяСобытия В(&ИменаСобытия)
	|	И лСообщенияЛогирования.КлючСеанса В(&КлючиСеанса)
	|	И лСообщенияЛогирования.Дата МЕЖДУ &ДатаНач И &ДатаКон";
	
	Если ТипЗнч(ПараметрыОтбора) = Тип("Структура") Тогда
		Если ПараметрыОтбора.Свойство("ИменаСобытия") Тогда
			Запрос.УстановитьПараметр("ИменаСобытия", ПараметрыОтбора.ИменаСобытия);
		Иначе
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И лСообщенияЛогирования.ИмяСобытия В(&ИменаСобытия)", "");
		КонецЕсли;
		Если ПараметрыОтбора.Свойство("КлючиСеанса") Тогда
			Запрос.УстановитьПараметр("КлючиСеанса", ПараметрыОтбора.КлючиСеанса);
		Иначе
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И лСообщенияЛогирования.КлючСеанса В(&КлючиСеанса)", "");
		КонецЕсли;
		Если ПараметрыОтбора.Свойство("ДатаНач") И ПараметрыОтбора.Свойство("ДатаКон") Тогда
			Запрос.УстановитьПараметр("ДатаНач", ПараметрыОтбора.ДатаНач);
			Запрос.УстановитьПараметр("ДатаКон", ПараметрыОтбора.ДатаКон);
		Иначе
			ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И лСообщенияЛогирования.Дата МЕЖДУ &ДатаНач И &ДатаКон", "");		
		КонецЕсли;
	Иначе
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И лСообщенияЛогирования.ИмяСобытия В(&ИменаСобытия)", "");
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И лСообщенияЛогирования.КлючСеанса В(&КлючиСеанса)", "");
		ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "И лСообщенияЛогирования.Дата МЕЖДУ &ДатаНач И &ДатаКон", "");		
	КонецЕсли;
	
	Если Не ПустаяСтрока(ПоляУпорядочивания) Тогда
		ТекстЗапроса = ТекстЗапроса + " УПОРЯДОЧИТЬ ПО " + ПоляУпорядочивания;
	КонецЕсли;
	Если НЕ ПустаяСтрока(ПоляИтогов) Тогда
		ТекстЗапроса = ТекстЗапроса + " ИТОГИ ПО " + ПоляИтогов;
	КонецЕсли;
	
	Запрос.Текст = ТекстЗапроса;
	
	Текст = Новый ТекстовыйДокумент;
	
	Если Не ЗначениеЗаполнено(ПоляИтогов) Тогда
		ЗаписиЛога = Запрос.Выполнить().Выгрузить();
	Иначе
		ЗаписиЛога = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкам);
	КонецЕсли;
	
	ВывестиСтрокиРекурсивно(ЗаписиЛога.Строки, Текст);
	
	Возврат Текст;
	
КонецФункции

Процедура ВывестиСтрокиРекурсивно(Строки, Текст)
	
	Для Каждого Строка Из Строки Цикл
		Текст.ДобавитьСтроку(Строка.ТекстСообщения);
		ВывестиСтрокиРекурсивно(Строка.Строки, Текст);
		Текст.ДобавитьСтроку("");
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеФункцииИПроцедуры

// Добавляет к переданному пути каталога конечный символ-разделитель, если он отсутствует.
//
// Параметры:
//  ПутьКаталога - Строка - путь к каталогу.
//  Платформа - ТипПлатформы - параметр устарел, больше не используется.
//
// Возвращаемое значение:
//  Строка - путь к каталогу с конечным символом-разделителем.
//
// Пример:
//  Результат = ДобавитьКонечныйРазделительПути("C:\Мой каталог"); // возвращает "C:\Мой каталог\".
//  Результат = ДобавитьКонечныйРазделительПути("C:\Мой каталог\"); // возвращает "C:\Мой каталог\".
//  Результат = ДобавитьКонечныйРазделительПути("%APPDATA%"); // возвращает "%APPDATA%\".
//
Функция ДобавитьКонечныйРазделительПути(Знач ПутьКаталога, Знач Платформа = Неопределено) Экспорт
	
	Если ПустаяСтрока(ПутьКаталога) Тогда
		Возврат ПутьКаталога;
	КонецЕсли;
	
	ДобавляемыйСимвол = ПолучитьРазделительПути();
	
	Если СтрЗаканчиваетсяНа(ПутьКаталога, ДобавляемыйСимвол) Тогда
		Возврат ПутьКаталога;
	Иначе 
		Возврат ПутьКаталога + ДобавляемыйСимвол;
	КонецЕсли;
	
КонецФункции

// Заменяет недопустимые символы в имени файла.
//
// Параметры:
//  ИмяФайла     - Строка - исходное имя файла.
//  НаЧтоМенять  - Строка - строка, на которую необходимо заменить недопустимые символы.
//
// Возвращаемое значение:
//   Строка - преобразованное имя файла.
//
Функция ЗаменитьНедопустимыеСимволыВИмениФайла(Знач ИмяФайла, НаЧтоМенять = " ") Экспорт
	
	Возврат СокрЛП(СтрСоединить(СтрРазделить(ИмяФайла, ПолучитьНедопустимыеСимволыВИмениФайла(), Истина), НаЧтоМенять));

КонецФункции

// Возвращает строку недопустимых символов.
// Согласно http://en.wikipedia.org/wiki/Filename - в разделе "Reserved characters and words".
// Возвращаемое значение:
//   Строка - строка недопустимых символов.
//
Функция ПолучитьНедопустимыеСимволыВИмениФайла() Экспорт

	НедопустимыеСимволы = """/\[]:;|=?*<>";
	НедопустимыеСимволы = НедопустимыеСимволы + Символы.Таб + Символы.ПС;
	Возврат НедопустимыеСимволы;

КонецФункции

Функция СоответствиеУровнейЛогированияУровнямЖР()
	
	Уровни = Новый Соответствие;
	Уровни.Вставить(ПредопределенноеЗначение("Перечисление.лУровниЛогирования.ОТЛАДКА"),        УровеньЖурналаРегистрации.Примечание);
	Уровни.Вставить(ПредопределенноеЗначение("Перечисление.лУровниЛогирования.ИНФОРМАЦИЯ"),     УровеньЖурналаРегистрации.Информация);
	Уровни.Вставить(ПредопределенноеЗначение("Перечисление.лУровниЛогирования.ПРЕДУПРЕЖДЕНИЕ"), УровеньЖурналаРегистрации.Предупреждение);
	Уровни.Вставить(ПредопределенноеЗначение("Перечисление.лУровниЛогирования.ОШИБКА"),         УровеньЖурналаРегистрации.Ошибка);
	
	Возврат Уровни;
	
КонецФункции

Процедура ЗаписатьОшибкуЛогированияВЖурналРегистрации(ИмяСобытия, Текст) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка,,, Текст);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Процедура УстановитьИмяСобытияЛогирования(ИмяСобытия) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Настройки = Новый Структура(ПараметрыСеанса.лПараметрыЛогирования);
	Настройки.Вставить("ИмяСобытия", ИмяСобытия);
	
	ПараметрыСеанса.лПараметрыЛогирования = Новый ФиксированнаяСтруктура(Настройки);
	
КонецПроцедуры

Процедура УстановитьУровеньЛогирования(Знач УровеньЛогирования) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ТипЗнч(УровеньЛогирования) = Тип("Строка") Тогда
		Попытка
			УровеньЛогирования = Перечисления.лУровниЛогирования[УровеньЛогирования];
		Исключение
			ЗаписатьОшибкуЛогированияВЖурналРегистрации("Логирование.УстановкаУровняЛогирования", СтрШаблон("Некорректное значение уровня логирования %1", УровеньЛогирования));
			Возврат;
		КонецПопытки;
	КонецЕсли;
	
	Настройки = Новый Структура(ПараметрыСеанса.лПараметрыЛогирования);
	Настройки.Вставить("УровеньЛогирования", УровеньЛогирования);
	Настройки.Вставить("УровеньЛогированияПредставление", Строка(УровеньЛогирования));
	Настройки.Вставить("ПриоритетУровняЛогирования", лЛогированиеКлиентСерверСлужебный.ПриоритетУровняЛогирования(УровеньЛогирования));
	
	ПараметрыСеанса.лПараметрыЛогирования = Новый ФиксированнаяСтруктура(Настройки);
	
КонецПроцедуры

Процедура ОтключитьЛогирование() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Настройки = Новый Структура(ПараметрыСеанса.лПараметрыЛогирования);
	Настройки.Вставить("Отключен", Истина);
	
	ПараметрыСеанса.лПараметрыЛогирования = Новый ФиксированнаяСтруктура(Настройки);
	
КонецПроцедуры

Процедура ВключитьЛогирование() Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Настройки = Новый Структура(ПараметрыСеанса.лПараметрыЛогирования);
	Настройки.Вставить("Отключен", Ложь);
	
	ПараметрыСеанса.лПараметрыЛогирования = Новый ФиксированнаяСтруктура(Настройки);
	
КонецПроцедуры

Процедура ДобавитьСпособЛогирования(Знач СпособЛогирования, ШаблонСообщения, ФорматДаты) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Если ТипЗнч(СпособЛогирования) = Тип("Строка") Тогда
		Попытка
			СпособЛогирования = Перечисления.лСпособыЛогирования[СпособЛогирования];
		Исключение
			ЗаписатьОшибкуЛогированияВЖурналРегистрации("Логирование.УстановкаСпособаЛогирования", СтрШаблон("Некорректное значение способа логирования %1", СпособЛогирования));
			Возврат;
		КонецПопытки;
	КонецЕсли;
	
	НастройкиСпособа = Новый Структура;
	
	Если ЗначениеЗаполнено(ШаблонСообщения) Тогда
		НастройкиСпособа.Вставить("ШаблонСообщения", ШаблонСообщения);
	Иначе
		НастройкиСпособа.Вставить("ШаблонСообщения", лЛог.ШаблонСообщенияПоУмолчанию());
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ФорматДаты) Тогда
		НастройкиСпособа.Вставить("ФорматДаты", ФорматДаты);
	Иначе
		НастройкиСпособа.Вставить("ФорматДаты", лЛог.ФорматДатыПоУмолчанию());
	КонецЕсли;
	
	НастройкиСпособа.Вставить("Представление", Строка(СпособЛогирования));
	
	Настройки = Новый Структура(ПараметрыСеанса.лПараметрыЛогирования);
	
	Способы = Новый Соответствие(Настройки.СпособыЛогирования);
	Способы.Вставить(СпособЛогирования, Новый ФиксированнаяСтруктура(НастройкиСпособа));
	
	Настройки.Вставить("СпособыЛогирования", Новый ФиксированноеСоответствие(Способы));
	
	ПараметрыСеанса.лПараметрыЛогирования = Новый ФиксированнаяСтруктура(Настройки);
	
КонецПроцедуры

Процедура УстановитьПутьКФайлуЛогирования(ПутьКФайлу, ИмяНастройки) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Настройки = Новый Структура(ПараметрыСеанса.лПараметрыЛогирования);
	Настройки.Вставить(ИмяНастройки, ПутьКФайлу);
	
	ПараметрыСеанса.лПараметрыЛогирования = Новый ФиксированнаяСтруктура(Настройки);
	
КонецПроцедуры

#КонецОбласти
