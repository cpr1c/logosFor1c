
#Область СлужебныйПрограммныйИнтерфейс

#Область ЗаписьВЛог

Процедура ЗаписатьВЛог(Сообщение, ДопПараметры) Экспорт
	
	лПараметрыЛогирования = лЛог.ПараметрыЛогирования();
	
	Если лПараметрыЛогирования.Отключен Тогда
		Возврат;
	КонецЕсли;
	
	// Пропускаем вывод сообщения, если установлен уровень логирования больше уровня текущего метода логирования.
	Приоритет = лПараметрыЛогирования.ПриоритетУровняЛогирования;

	Если Приоритет > ПриоритетУровняЛогирования(ДопПараметры.УровеньЛогирования) Тогда
		Возврат;
	КонецЕсли;
		
	Для Каждого СпособЛогирования Из лПараметрыЛогирования.СпособыЛогирования Цикл
		
		ДопПараметры.Вставить("СпособЛогирования", СпособЛогирования.Ключ);
		ДопПараметры.Вставить("ОписаниеСпособаЛогирования", СпособЛогирования.Значение);
		
		Если СпособЛогирования.Ключ = ПредопределенноеЗначение("Перечисление.лСпособыЛогирования.База") Тогда
			лЛогированиеВызовСервераСлужебный.ДобавитьЗаписьВРегистр(Сообщение, ДопПараметры);
		ИначеЕсли СпособЛогирования.Ключ = ПредопределенноеЗначение("Перечисление.лСпособыЛогирования.ЖурналРегистрации") Тогда
			лЛогированиеВызовСервераСлужебный.ДобавитьЗаписьВЖурналРегистрации(Сообщение, ДопПараметры);
		ИначеЕсли СпособЛогирования.Ключ = ПредопределенноеЗначение("Перечисление.лСпособыЛогирования.Консоль") Тогда
			ДобавитьЗаписьВКонсоль(Сообщение, ДопПараметры);		
		ИначеЕсли СпособЛогирования.Ключ = ПредопределенноеЗначение("Перечисление.лСпособыЛогирования.Память") Тогда
			ДобавитьЗаписьВПамять(Сообщение, ДопПараметры);
		ИначеЕсли СпособЛогирования.Ключ = ПредопределенноеЗначение("Перечисление.лСпособыЛогирования.Файл") Тогда
			ДобавитьЗаписьВФайл(Сообщение, ДопПараметры);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

Функция СтрокаСообщенияЛога(Сообщение, ДопПараметры) Экспорт
	
	// Способ определения миллисекунд не точный, могут быть коллизии на границах перехода между секундами,
	// в дате сообщения может оказаться одна секунда (например 54), а в универсальной дате следующая (например, 55).
	// Для более точного определения миллисекунд необходимо дату целиком извлекать из универсальной даты в мс.
	ДатаСообщения                = ТекущаяДата();
	ДатаСообщенияУниверсальнаяМС = ТекущаяУниверсальнаяДатаВМиллисекундах();
	ДатаМиллисекунды             = ДатаСообщенияУниверсальнаяМС % 1000; 
	ДатаПредставление            = Формат(ДатаСообщения, ДопПараметры.ОписаниеСпособаЛогирования.ФорматДаты);	
	ДатаПредставлениеМС          = Формат(ДатаМиллисекунды, "ЧЦ=3; ЧДЦ=0; ЧВН=; ЧГ=");
	
	лПараметрыЛогирования = лЛог.ПараметрыЛогирования();
	
	Если ДопПараметры.Свойство("ИмяСобытия") Тогда
		ИмяСобытия = ДопПараметры.ИмяСобытия;
	Иначе
		ИмяСобытия = лПараметрыЛогирования.ИмяСобытия;
	КонецЕсли;
	
	СтрокаСообщения = ДопПараметры.ОписаниеСпособаЛогирования.ШаблонСообщения;
	СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%ДАТА%",                 ДатаПредставление);
	СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%ДАТАМС%",               ДатаПредставлениеМС);
	СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%УНИВЕРСАЛЬНАЯДАТАМС%",  Формат(ДатаСообщенияУниверсальнаяМС, "ЧГ="));
	СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%УРОВЕНЬ%",              Врег(ДопПараметры.УровеньЛогирования));
	СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%СООБЩЕНИЕ%",            Сообщение);
	СтрокаСообщения = СтрЗаменить(СтрокаСообщения, "%СОБЫТИЕ%",              ИмяСобытия);
		
	Возврат СтрокаСообщения;
	
КонецФункции

Процедура ДобавитьЗаписьВФайл(Сообщение, ДопПараметры)
	
	// для веб-клиента пока не реализован
	#Если ВебКлиент Тогда
	Возврат;		
	#КонецЕсли
	
	лПараметрыЛогирования = лЛог.ПараметрыЛогирования();
	
	Текст = СтрокаСообщенияЛога(Сообщение, ДопПараметры);
	
	// файл может быть по какой-то причине недоступен, делаем через попытку, чтобы не падало
	#Если Клиент Тогда
	ИмяФайлаЛога = лПараметрыЛогирования.ИмяФайлаЛогаНаКлиенте;
	#Иначе
	ИмяФайлаЛога = лПараметрыЛогирования.ИмяФайлаЛогаНаСервере;
	#КонецЕсли
	
	#Если НЕ ВебКлиент Тогда // чтобы не ругалась проверка
	Попытка
		ФайлЛога = Новый ЗаписьТекста(ИмяФайлаЛога,,,Истина);
		ФайлЛога.ЗаписатьСтроку(Текст);
		//ФайлЛога.Закрыть();
	Исключение
		Если ДопПараметры.Свойство("ИмяСобытия") Тогда
			ИмяСобытия = ДопПараметры.ИмяСобытия;
		Иначе
			ИмяСобытия = лПараметрыЛогирования.ИмяСобытия;
		КонецЕсли;
		лЛогированиеВызовСервераСлужебный.ЗаписатьОшибкуЛогированияВЖурналРегистрации(ИмяСобытия, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;
	#КонецЕсли
	
КонецПроцедуры

Процедура ДобавитьЗаписьВКонсоль(Сообщение, ДопПараметры)
	
	лПараметрыЛогирования = лЛог.ПараметрыЛогирования();
	
	Текст = СтрокаСообщенияЛога(Сообщение, ДопПараметры);
	
	Консоль = Новый СообщениеПользователю;
	Консоль.Текст = Текст;
	Консоль.Сообщить();
	
КонецПроцедуры

Процедура ДобавитьЗаписьВПамять(Сообщение, ДопПараметры)
	
	лСообщенияЛогирования = лЛог.СообщенияЛогирования();
	
	Текст = СтрокаСообщенияЛога(Сообщение, ДопПараметры);
	
	Попытка
		#Если Клиент Тогда
		лСообщенияЛогирования.Добавить(Текст);
		#Иначе
		МассивСообщений = Новый Массив(лСообщенияЛогирования);
		МассивСообщений.Добавить(Текст);
		ПараметрыСеанса.лСообщенияЛогирования = Новый ФиксированныйМассив(МассивСообщений);
		#КонецЕсли
	Исключение
	КонецПопытки;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеФункцииИПроцедуры

// Возвращает числовой приоритет переданного уровня логирования.
// Параметры
//     Уровень - Строка - имя уровеня лога.
// 
// Возвращаемое значение:
//     Число - числовой приоритет переданного уровня, если такой уровень неизвестен, будет возвращено -1 (наименьший приоритет).
Функция ПриоритетУровняЛогирования(Уровень) Экспорт
	
	Приоритет = ВсеУровниЛогирования().Получить(Уровень);
	Если Приоритет = Неопределено Тогда
		Возврат -1;
	КонецЕсли;
	
	Возврат Приоритет;
	
КонецФункции

// Возвращает соответствие уровней логирования и их приоритет: [Уроверь => Приоритет].
Функция ВсеУровниЛогирования() 
	
	Уровни = Новый Соответствие;
	Уровни.Вставить(ПредопределенноеЗначение("Перечисление.лУровниЛогирования.ОТЛАДКА"),        0);
	Уровни.Вставить(ПредопределенноеЗначение("Перечисление.лУровниЛогирования.ИНФОРМАЦИЯ"),     1);
	Уровни.Вставить(ПредопределенноеЗначение("Перечисление.лУровниЛогирования.ПРЕДУПРЕЖДЕНИЕ"), 2);
	Уровни.Вставить(ПредопределенноеЗначение("Перечисление.лУровниЛогирования.ОШИБКА"),         3);
	
	Возврат Уровни;
	
КонецФункции

#КонецОбласти

#КонецОбласти
