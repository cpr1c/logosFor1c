#Область ПрограммныйИнтерфейс
// содержит экспортные процедуры и функции, предназначенные для использования другими объектами конфигурации или другими программами (например, через внешнее соединение).
#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

Функция НомерСеанса() Экспорт
	Возврат НомерСеансаИнформационнойБазы();
КонецФункции

Функция ИмяТекущегоПользователяБазы() Экспорт
	Возврат ИмяПользователя();
КонецФункции

Процедура ВыполнитьЗаписьЛогаПоСпособу(Лог, СпособЛогированияДляЛога, УровеньЛогирования, Сообщение) Экспорт
	лЛогСлужебный.ВыполнитьЗаписьЛогаПоСпособу(Лог, СпособЛогированияДляЛога, УровеньЛогирования, Сообщение);
КонецПроцедуры

Процедура ВывестиСообщениеВЖурналРегистрации(Лог, Сообщение, УровеньЛогирования) Экспорт
	УстановитьПривилегированныйРежим(Истина);

	УровеньЖР = СоответствиеУровнейЛогированияУровнямЖР()[УровеньЛогирования.Имя];
	Если УровеньЖР = Неопределено Тогда
		УровеньЖР = УровеньЖурналаРегистрации.Примечание;
	КонецЕсли;
	
	ИмяСобытия = Лог.ИмяСобытия;
	ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖР, , , Сообщение);
КонецПроцедуры

Процедура ЗаписатьСообщениеЛогаВБазу(Лог, Сообщение, УровеньЛогирования) Экспорт
	УстановитьПривилегированныйРежим(Истина);
	ИмяСобытия = Лог.ИмяСобытия;

	ДатаЗаписи = ТекущаяДатаСеанса();
	ИдентификаторЗаписи = Строка(Новый УникальныйИдентификатор);
	
	МенеджерЗаписи = РегистрыСведений.лСообщенияЛогирования.СоздатьМенеджерЗаписи();
	МенеджерЗаписи.ИмяСобытия = ИмяСобытия;
	МенеджерЗаписи.НомерСеанса = Лог.НомерСеанса;
	МенеджерЗаписи.Дата = ДатаЗаписи;
	МенеджерЗаписи.Идентификатор = ИдентификаторЗаписи;
	МенеджерЗаписи.Уровень = УровеньЛогирования.Имя;
	МенеджерЗаписи.ТекстСообщения = Сообщение;
	МенеджерЗаписи.ИмяПользователя = Лог.ИмяПользователя;
	
	Попытка
		МенеджерЗаписи.Записать();
	Исключение
		ЗаписатьОшибкуЛогированияВЖурналРегистрации(ИмяСобытия, ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
	КонецПопытки;

КонецПроцедуры

Процедура ДобавитьТекущийЛогНаСервер(Имя, Лог) Экспорт
	ТекущиеЛоги = ТекущиеЛогиНаСервере();
	ТекущиеЛоги.Вставить(Имя, Лог);
	
	ЗаписатьТекущиеЛогиНаСервере(ТекущиеЛоги);
КонецПроцедуры

Функция ЛогПоИмениНаСервере(ИмяЛога) Экспорт
	ТекущиеЛоги = ТекущиеЛогиНаСервере();
	Возврат ТекущиеЛоги[ИмяЛога];
КонецФункции

Процедура ОчиститьСписокТекущихЛоговНаСервере() Экспорт
	ЗаписатьТекущиеЛогиНаСервере(Новый Соответствие);
КонецПроцедуры

Функция ТекущиеЛогиНаСервере() Экспорт
	УстановитьПривилегированныйРежим(Истина);
	Возврат ХранилищеОбщихНастроекЗагрузить(
		КлючОбъектаТекущиеЛоги(),
		КлючНастроекТекущиеЛоги(), Новый Соответствие);
	
КонецФункции

Процедура УдалитьЛогИзХранилищаЛогов(Лог) Экспорт
	ТекущиеЛоги = ТекущиеЛогиНаСервере();
	
	лЛогСлужебный.УдалитьЛогИзХранилищаЛогов(ТекущиеЛоги, Лог);
	ЗаписатьТекущиеЛогиНаСервере(ТекущиеЛоги);

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ЗаписатьОшибкуЛогированияВЖурналРегистрации(ИмяСобытия, Текст)
	
	УстановитьПривилегированныйРежим(Истина);
	ЗаписьЖурналаРегистрации(ИмяСобытия, УровеньЖурналаРегистрации.Ошибка,,, Текст);
	
КонецПроцедуры

Функция СоответствиеУровнейЛогированияУровнямЖР()
	УровниЛогирования = лЛогСлужебный.УровниЛогирования();

	Уровни = Новый Соответствие;
	Уровни.Вставить(УровниЛогирования.Отладка.Имя,			УровеньЖурналаРегистрации.Примечание);
	Уровни.Вставить(УровниЛогирования.Информация.Имя,		УровеньЖурналаРегистрации.Информация);
	Уровни.Вставить(УровниЛогирования.Предупреждение.Имя,	УровеньЖурналаРегистрации.Предупреждение);
	Уровни.Вставить(УровниЛогирования.Ошибка.Имя,			УровеньЖурналаРегистрации.Ошибка);
	Уровни.Вставить(УровниЛогирования.КритическаяОшибка.Имя,УровеньЖурналаРегистрации.Ошибка);
	
	Возврат Уровни;
	
КонецФункции

Процедура ЗаписатьТекущиеЛогиНаСервере(Логи)
	УстановитьПривилегированныйРежим(Истина);
	ХранилищеОбщихНастроекСохранить(
		КлючОбъектаТекущиеЛоги(), КлючНастроекТекущиеЛоги(),
		Логи);
	
КонецПроцедуры

Функция КлючНастроекТекущиеЛоги()
	Возврат "ТекущиеЛоги";
КонецФункции

Функция КлючОбъектаТекущиеЛоги()
	Возврат "logosFor1C";
КонецФункции

// Сохраняет настройку в хранилище общих настроек, как метод платформы Сохранить,
// объектов СтандартноеХранилищеНастроекМенеджер или ХранилищеНастроекМенеджер.<Имя хранилища>,
// но с поддержкой длины ключа настроек более 128 символов путем хеширования части,
// которая превышает 96 символов.
// Если нет права СохранениеДанныхПользователя, сохранение пропускается без ошибки.
//
// Параметры:
//   КлючОбъекта       - Строка           - см. синтакс-помощник платформы.
//   КлючНастроек      - Строка           - см. синтакс-помощник платформы.
//   Настройки         - Произвольный     - см. синтакс-помощник платформы.
//   ОписаниеНастроек  - ОписаниеНастроек - см. синтакс-помощник платформы.
//   ИмяПользователя   - Строка           - см. синтакс-помощник платформы.
//   ОбновитьПовторноИспользуемыеЗначения - Булево - выполнить одноименный метод платформы.
//
Процедура ХранилищеОбщихНастроекСохранить(КлючОбъекта, КлючНастроек, Настройки, ОписаниеНастроек = Неопределено,
	ИмяПользователя = Неопределено, ОбновитьПовторноИспользуемыеЗначения = Ложь) Экспорт

	ХранилищеСохранить(ХранилищеОбщихНастроек, КлючОбъекта, КлючНастроек, Настройки, ОписаниеНастроек, ИмяПользователя,
		ОбновитьПовторноИспользуемыеЗначения);

КонецПроцедуры

Процедура ХранилищеСохранить(МенеджерХранилища, КлючОбъекта, КлючНастроек, Настройки, ОписаниеНастроек,
	ИмяПользователя, ОбновитьПовторноИспользуемыеЗначения)

	Если Не ПравоДоступа("СохранениеДанныхПользователя", Метаданные) Тогда
		Возврат;
	КонецЕсли;

	МенеджерХранилища.Сохранить(КлючОбъекта, КлючНастроек, Настройки, ОписаниеНастроек, ИмяПользователя);

	Если ОбновитьПовторноИспользуемыеЗначения Тогда
		ОбновитьПовторноИспользуемыеЗначения();
	КонецЕсли;

КонецПроцедуры

// Загружает настройку из хранилища общих настроек, как метод платформы Загрузить,
// объектов СтандартноеХранилищеНастроекМенеджер или ХранилищеНастроекМенеджер.<Имя хранилища>,
// но с поддержкой длины ключа настроек более 128 символов путем хеширования части,
// которая превышает 96 символов.
// Кроме того, возвращает указанное значение по умолчанию, если настройки не найдены.
// Если нет права СохранениеДанныхПользователя, возвращается значение по умолчанию без ошибки.
//
// В возвращаемом значении очищаются ссылки на несуществующий объект в базе данных, а именно
// - возвращаемая ссылка заменяется на указанное значение по умолчанию;
// - из данных типа Массив ссылки удаляются;
// - у данных типа Структура и Соответствие ключ не меняется, а значение устанавливается Неопределено;
// - анализ значений в данных типа Массив, Структура, Соответствие выполняется рекурсивно.
//
// Параметры:
//   КлючОбъекта          - Строка           - см. синтакс-помощник платформы.
//   КлючНастроек         - Строка           - см. синтакс-помощник платформы.
//   ЗначениеПоУмолчанию  - Произвольный     - значение, которое возвращается, если настройки не найдены.
//                                             Если не указано, возвращается значение Неопределено.
//   ОписаниеНастроек     - ОписаниеНастроек - см. синтакс-помощник платформы.
//   ИмяПользователя      - Строка           - см. синтакс-помощник платформы.
//
// Возвращаемое значение: 
//   Произвольный - см. синтакс-помощник платформы.
//
Функция ХранилищеОбщихНастроекЗагрузить(КлючОбъекта, КлючНастроек, ЗначениеПоУмолчанию = Неопределено,
	ОписаниеНастроек = Неопределено, ИмяПользователя = Неопределено) Экспорт

	Возврат ХранилищеЗагрузить(ХранилищеОбщихНастроек, КлючОбъекта, КлючНастроек, ЗначениеПоУмолчанию, ОписаниеНастроек,
		ИмяПользователя);

КонецФункции

Функция ХранилищеЗагрузить(МенеджерХранилища, КлючОбъекта, КлючНастроек, ЗначениеПоУмолчанию, ОписаниеНастроек,
	ИмяПользователя)

	Результат = Неопределено;

	Если ПравоДоступа("СохранениеДанныхПользователя", Метаданные) Тогда
		Результат = МенеджерХранилища.Загрузить(КлючОбъекта, КлючНастроек, ОписаниеНастроек,
			ИмяПользователя);
	КонецЕсли;

	Если Результат = Неопределено Тогда
		Результат = ЗначениеПоУмолчанию;
	КонецЕсли;

	Возврат Результат;

КонецФункции

#КонецОбласти
