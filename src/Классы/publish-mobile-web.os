
#Использовать logos

Перем ВерсияПлагина;
Перем Лог;
Перем КомандыПлагина;
Перем МассивНомеровВерсий;
Перем Лимит;
Перем Обработчик;
Перем НачальнаяВерсия;
Перем КонечнаяВерсия;

#Область Интерфейс_плагина

// Возвращает версию плагина
//
//  Возвращаемое значение:
//   Строка - текущая версия плагина
//
Функция Версия() Экспорт
	Возврат "1.3.0";
КонецФункции

// Возвращает приоритет выполнения плагина
//
//  Возвращаемое значение:
//   Число - приоритет выполнения плагина
//
Функция Приоритет() Экспорт
	Возврат 0;
КонецФункции

// Возвращает описание плагина
//
//  Возвращаемое значение:
//   Строка - описание функциональности плагина
//
Функция Описание() Экспорт
	Возврат "Плагин добавляет возможность ограничения на минимальный, максимальный номер версии хранилища, а так же на лимит на количество выгружаемых версий за один запуск";
КонецФункции

// Возвращает подробную справку к плагину 
//
//  Возвращаемое значение:
//   Строка - подробная справка для плагина
//
Функция Справка() Экспорт
	Возврат "Справка плагина publish-mobile-web";
КонецФункции

// Возвращает имя плагина
//
//  Возвращаемое значение:
//   Строка - имя плагина при подключении
//
Функция Имя() Экспорт
	Возврат "publish-mobile-web";
КонецФункции 

// Возвращает имя лога плагина
//
//  Возвращаемое значение:
//   Строка - имя лога плагина
//
Функция ИмяЛога() Экспорт
	Возврат "oscript.lib.gitsync.plugins.publish-mobile-web";
КонецФункции

#КонецОбласти

#Область Подписки_на_события

Процедура ПриАктивизации(СтандартныйОбработчик) Экспорт

	Обработчик = СтандартныйОбработчик;

КонецПроцедуры

Процедура ПриРегистрацииКомандыПриложения(ИмяКоманды, КлассРеализации) Экспорт

	Лог.Отладка("Ищу команду <%1> в списке поддерживаемых", ИмяКоманды);
	Если КомандыПлагина.Найти(ИмяКоманды) = Неопределено Тогда
		Возврат;
	КонецЕсли;

	Лог.Отладка("Устанавливаю дополнительные параметры для команды %1", ИмяКоманды);

	КлассРеализации.Опция("w publishw", 0, СтрШаблон("<Булево> -разрешение публикации мобильной конфигурации и добавление ее в комит GIT"))
						.ТБулево()
						.ВОкружении("GITSYNC_PUBLISH_WEB");
	КлассРеализации.Опция("webdir", 0, СтрШаблон("<каталог_публикации_web> мобильного приложения"))
						.ТСтрока();
	//КлассРеализации.Опция("minversion", 0, СтрШаблон("[*limit] <номер> минимальной версии для выгрузки"))
	//					.ТЧисло();
	//КлассРеализации.Опция("maxversion", 0, СтрШаблон("[*limit] <номер> максимальной версии для выгрузки"))
	//					.ТЧисло();

КонецПроцедуры

Процедура ПриПолученииПараметров(ПараметрыКоманды) Экспорт

	Лимит = ПараметрыКоманды.Параметр("limit", 0);
	НачальнаяВерсия = ПараметрыКоманды.Параметр("minversion", 0);
	КонечнаяВерсия = ПараметрыКоманды.Параметр("maxversion", 0);

	Если Лимит > 0  Тогда
		Лог.Информация("Установлен лимит <%1> для количества версий, при выгрузке", Лимит);
	КонецЕсли;

	Если НачальнаяВерсия > 0 Тогда
		Лог.Информация("Установлена начальная версия <%1> при выгрузке версий", НачальнаяВерсия);
	КонецЕсли;
	Если КонечнаяВерсия > 0  Тогда
		Лог.Информация("Установлена конечная версия <%1> при выгрузке версий", КонечнаяВерсия);
	КонецЕсли;
	
КонецПроцедуры

Процедура ПередНачаломЦиклаОбработкиВерсий(ТаблицаИсторииХранилища, ТекущаяВерсия, СледующаяВерсия, МаксимальнаяВерсияДляРазбора) Экспорт

	Сообщить("Я тут! ПередНачаломЦиклаОбработкиВерсий. Тек версия " + ТекущаяВерсия);

КонецПроцедуры

Процедура ПередКоммитом(КаталогРабочейКопии, Комментарий, Автор, Дата) Экспорт

	Сообщить("Я тут! ПередКоммитом");
	Сообщить("		КаталогРабочейКопии: " + КаталогРабочейКопии);
	Сообщить("		Комментарий:         " + Комментарий);
	Сообщить("		Автор:               " + Автор);

	Комментарий = "Борман";

КонецПроцедуры

Процедура ПередВыгрузкойКонфигурациюВИсходники(Конфигуратор, КаталогРабочейКопии, КаталогВыгрузки, ПутьКХранилищу, НомерВерсии, Формат) Экспорт

	Сообщить("Я тут! ПередВыгрузкойКонфигурациюВИсходники");

КонецПроцедуры

Процедура ПриВыгрузкеКонфигурациюВИсходники(Конфигуратор, КаталогВыгрузки, Формат, СтандартнаяОбработка) Экспорт
//	СтандартнаяОбработка = ложь;

	Сообщить("Я тут! ПриВыгрузкеКонфигурациюВИсходники");

КонецПроцедуры

Процедура ПослеОкончанияВыгрузкиВерсииХранилищаКонфигурации(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии) Экспорт

	Сообщить("Я тут! ПриВыгрузкеКонфигурациюВИсходники");

КонецПроцедуры

Процедура ПриЗагрузкеВерсииХранилищаВКонфигурацию(Конфигуратор, КаталогРабочейКопии, ПутьКХранилищу, НомерВерсии, СтандартнаяОбработка) Экспорт

	Сообщить("Я тут! ПриЗагрузкеВерсииХранилищаВКонфигурацию");

КонецПроцедуры


#КонецОбласти


Процедура Инициализация()

	Лог = Логирование.ПолучитьЛог(ИмяЛога());
	КомандыПлагина = Новый Массив;
	КомандыПлагина.Добавить("sync");
	Лимит = 0;
	КонечнаяВерсия = 0;
	НачальнаяВерсия = 0;
	
КонецПроцедуры

Инициализация();


