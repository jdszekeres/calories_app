// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get aiCredits => 'Créditos de IA';

  @override
  String get aiCreditDescription =>
      'Nececitas créditos para usar el análisis nutricional con IA. Presiona aqui para mirar un advertisio para ganar 5 créditos más.';

  @override
  String creditCount(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count créditos',
      one: '1 crédito',
      zero: '0 créditos',
    );
    return '$_temp0';
  }

  @override
  String get calorieGoals => 'Metas de Calorías';

  @override
  String get macroNutrientGoals => 'Metas de Macronutrientes';

  @override
  String get vitaminGoals => 'Metas de Vitaminas';

  @override
  String get cancel => 'Cancelar';

  @override
  String get setGoal => 'Establecer meta';

  @override
  String get invalidInput => 'Entrada inválida';

  @override
  String get fillForm => 'Por favor complete todos los campos del formulario.';

  @override
  String get dailyGoals => 'Metas diarias';

  @override
  String get retry => 'Reintentar';

  @override
  String get noGoalsFound =>
      'No se encontraron metas. Configure sus metas en ajustes.';

  @override
  String get myMeals => 'Mis comidas';

  @override
  String get noMealsFound =>
      'No se encontraron comidas. Por favor agregue algunas.';

  @override
  String get addMeal => 'Agregar comida';

  @override
  String get reAddMeal => 'Volver a agregar comida';

  @override
  String get goal => 'Meta';

  @override
  String get enterGoal => 'Ingrese su meta';

  @override
  String setGoalFor(Object foodType) {
    return 'Establecer meta para $foodType';
  }

  @override
  String get welcomeBack => '¡Bienvenido de nuevo!';

  @override
  String get username => 'Nombre de usuario';

  @override
  String get email => 'Correo electrónico';

  @override
  String get password => 'Contraseña';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get next => 'Siguiente';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get step1_2 => 'Paso 1/2';

  @override
  String get step2_2 => 'Paso 2/2';

  @override
  String get tellUs => 'Cuéntenos más sobre usted';

  @override
  String get tellUsExplain =>
      'Esto nos ayuda a calcular sus metas diarias de calorías';

  @override
  String get age => 'Edad';

  @override
  String get useImperial => 'Usar unidades imperiales';

  @override
  String get weight => 'Peso (kg)';

  @override
  String get weightImperial => 'Peso (lb)';

  @override
  String get height => 'Altura (cm)';

  @override
  String get heightImperial => 'Altura (in)';

  @override
  String get sex => 'Sexo';

  @override
  String get male => 'Hombre';

  @override
  String get female => 'Mujer';

  @override
  String get activityLevel => 'Nivel de actividad';

  @override
  String get sedentary => 'Sedentario (poco o nada de ejercicio)';

  @override
  String get lightlyActive =>
      'Ligeramente activo (ejercicio ligero 1-3 días/semana)';

  @override
  String get moderatelyActive =>
      'Moderadamente activo (ejercicio moderado 3-5 días/semana)';

  @override
  String get veryActive => 'Muy activo (ejercicio intenso 6-7 días por semana)';

  @override
  String get extraActive =>
      'Súper activo (ejercicio muy intenso, trabajo físico o entrenamiento dos veces al día)';

  @override
  String get completeSignUp => 'Completar registro';

  @override
  String get back => 'Atrás';

  @override
  String get signIn => 'Iniciar sesión';

  @override
  String get noAccount => '¿No tienes cuenta? Regístrate';

  @override
  String get tryAnon => 'Probar sin cuenta';

  @override
  String get downloadApp => 'Descargar aplicación';

  @override
  String get webAdvertisementTitle => 'No podemos ofrecer anuncios en la web';

  @override
  String get mobileAdvertisementTitle => 'No hay anuncios disponibles';

  @override
  String get useMobileAppMessage =>
      'Por favor usa la aplicación móvil para ver anuncios';

  @override
  String get supportMeMessage =>
      'o considera apoyarme a través de BuyMeACoffee.';

  @override
  String get supportMe => 'Apóyame';

  @override
  String get appTitle => 'Contador de calorías';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get creatingAnon => 'Creando una cuenta anónima';

  @override
  String get creatingAnonExplain =>
      'Aún necesitamos información para configurar su perfil y calcular sus metas.';

  @override
  String get pleaseFillAllFields => 'Por favor complete todos los campos';

  @override
  String get invalidEmail => 'Por favor ingrese un correo electrónico válido';

  @override
  String get passwordTooShort =>
      'La contraseña debe tener al menos 6 caracteres';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get invalidAge => 'Por favor ingrese una edad válida';

  @override
  String get invalidWeight => 'Por favor ingrese un peso válido';

  @override
  String get invalidHeight => 'Por favor ingrese una altura válida';

  @override
  String errorLoadingData(Object message) {
    return 'Error al cargar datos: $message';
  }

  @override
  String errorLoadingGoals(Object message) {
    return 'Error al cargar metas: $message';
  }

  @override
  String get editNutritionFacts => 'Editar información nutricional';

  @override
  String get nutritionFacts => 'Información nutricional';

  @override
  String get servingSize => 'Tamaño de la porción';

  @override
  String servingSizeValue(Object servingSize) {
    return 'Tamaño de la porción $servingSize';
  }

  @override
  String youAteServings(Object servings) {
    return 'Comiste $servings porciones';
  }

  @override
  String get yourIntake => 'Tu ingesta';

  @override
  String get ingredients => 'INGREDIENTES:';

  @override
  String get save => 'Guardar';

  @override
  String get confirm => 'Confirmar';

  @override
  String get settings => 'Ajustes';

  @override
  String get general => 'General';

  @override
  String get homePageWidgets => 'Widgets de la página de inicio';

  @override
  String get selectHomeWidgetsDescription =>
      'Seleccione qué metas deben aparecer en la pantalla de inicio';

  @override
  String get selectHomePageWidgets =>
      'Seleccionar widgets de la página de inicio';

  @override
  String get homePageWidgetsUpdated =>
      'Widgets de la página de inicio actualizados correctamente';

  @override
  String get nutritionGoals => 'Metas de nutrición';

  @override
  String get updateHealthInformation => 'Actualizar información de salud';

  @override
  String get resetNutritionGoals => 'Restablecer metas de nutrición';

  @override
  String get nutritionGoalsReset =>
      'Metas de nutrición restablecidas correctamente';

  @override
  String get account => 'Cuenta';

  @override
  String get createAccountDesc =>
      '¿Quieres seguir usando nuestra app? Crea una cuenta para guardar tus datos.';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get deleteAccount => 'Eliminar cuenta';

  @override
  String get delete => 'Eliminar';

  @override
  String get deleteAccountConfirmTitle => 'Eliminar cuenta';

  @override
  String get deleteAccountConfirmBody =>
      '¿Seguro que deseas eliminar tu cuenta? Esta acción no se puede deshacer.';

  @override
  String get accountDeleted => 'Cuenta eliminada correctamente';

  @override
  String get metric => 'Métrico';

  @override
  String get imperial => 'Imperial';

  @override
  String get years => 'años';

  @override
  String get saving => 'Guardando...';

  @override
  String get updateHealthInformationSuccess =>
      '¡Información de salud actualizada correctamente!';

  @override
  String get couldNotLoadUserProfile =>
      'No se pudo cargar el perfil del usuario';

  @override
  String errorSavingHealthInformation(Object message) {
    return 'Error al guardar la información de salud: $message';
  }

  @override
  String get createAccountTagline =>
      'Guarda tus datos y sincroniza entre dispositivos';

  @override
  String get createAccountSuccess => 'Cuenta creada correctamente';

  @override
  String get unitKg => 'kg';

  @override
  String get unitLbs => 'lb';

  @override
  String get unitCm => 'cm';

  @override
  String get unitFt => 'ft';

  @override
  String get unitIn => 'in';

  @override
  String get unitKcal => 'kcal';

  @override
  String get searchFoodTitle => 'Buscar alimentos';

  @override
  String get searchForProducts => 'Buscar productos';

  @override
  String get noResultsFound => 'No se encontraron resultados';

  @override
  String errorSearchingProducts(Object message) {
    return 'Error al buscar productos: $message';
  }

  @override
  String errorWithMessage(Object message) {
    return 'Error: $message';
  }

  @override
  String get nutritionFactsUpdated => '¡Información nutricional actualizada!';

  @override
  String get scanBarcodeTitle => 'Escanear código de barras';

  @override
  String get mealDetailsTitle => 'Detalles de la comida';

  @override
  String get aiNutritionAnalysisTitle => 'Análisis de nutrición con IA';

  @override
  String get aiDescriptionAnalysisTitle => 'Describir comida con IA';

  @override
  String get noImageSelected => 'No se seleccionó ninguna imagen';

  @override
  String get aiPoweredNutritionAnalysis => 'Análisis nutricional con IA';

  @override
  String get aiAnalysisDescription =>
      'Sube una foto de tu comida y deja que nuestra IA analice su contenido nutricional al instante';

  @override
  String get whatAiCanIdentify => 'Lo que nuestra IA puede identificar:';

  @override
  String get foodIdentification => 'Identificación de alimentos';

  @override
  String get portionEstimation => 'Estimación de porciones';

  @override
  String get calorieCalculation => 'Cálculo de calorías';

  @override
  String get macroMicronutrients => 'Macro y micronutrientes';

  @override
  String get ingredientBreakdown => 'Desglose de ingredientes';

  @override
  String get uploadPhoto => 'Subir foto';

  @override
  String get takePhoto => 'Tomar una foto';

  @override
  String get aiTipMessage =>
      'Consejo: Para mejores resultados, toma una foto clara con buena iluminación e incluye toda la comida en el encuadre.';

  @override
  String get failedToAnalyzeImage => 'Error al analizar la imagen';

  @override
  String get calories => 'Calorías';

  @override
  String get carbohydrates => 'Carbohidratos';

  @override
  String get fiber => 'Fibra';

  @override
  String get protein => 'Proteínas';

  @override
  String get fat => 'Grasas';

  @override
  String get sugar => 'Azúcar';

  @override
  String get water => 'Agua';

  @override
  String get vitaminA => 'Vitamina A';

  @override
  String get vitaminD => 'Vitamina D';

  @override
  String get vitaminE => 'Vitamina E';

  @override
  String get vitaminK => 'Vitamina K';

  @override
  String get vitaminC => 'Vitamina C';

  @override
  String get thiamin => 'Tiamina';

  @override
  String get riboflavin => 'Riboflavina';

  @override
  String get niacin => 'Niacina';

  @override
  String get pantothenicAcid => 'Ácido pantoténico';

  @override
  String get vitaminB6 => 'Vitamina B6';

  @override
  String get folate => 'Folato';

  @override
  String get vitaminB12 => 'Vitamina B12';

  @override
  String get choline => 'Colina';

  @override
  String get calcium => 'Calcio';

  @override
  String get chlorine => 'Cloro';

  @override
  String get copper => 'Cobre';

  @override
  String get fluoride => 'Flúor';

  @override
  String get iodine => 'Yodo';

  @override
  String get iron => 'Hierro';

  @override
  String get magnesium => 'Magnesio';

  @override
  String get manganese => 'Manganeso';

  @override
  String get molybdenum => 'Molibdeno';

  @override
  String get phosphorus => 'Fósforo';

  @override
  String get potassium => 'Potasio';

  @override
  String get selenium => 'Selenio';

  @override
  String get sodium => 'Sodio';

  @override
  String get zinc => 'Zinc';

  @override
  String get loadingCredits => 'Cargando créditos...';

  @override
  String get insufficientCredits => 'Créditos Insuficientes';

  @override
  String insufficientCreditsMessage(Object credits) {
    return 'Necesitas al menos 1 crédito para usar el análisis de IA. Actualmente tienes $credits créditos. Puedes ganar más créditos viendo anuncios en la página de Configuración.';
  }

  @override
  String get ok => 'OK';

  @override
  String get goToSettings => 'Ir a Configuración';

  @override
  String get tryAgain => 'Intentar de Nuevo';

  @override
  String get loading => 'Cargando...';

  @override
  String get selectLanguage => 'Seleccionar idioma';

  @override
  String get english => 'English';

  @override
  String get spanish => 'Español';

  @override
  String get chinese => '中文';

  @override
  String get arabic => 'العربية';

  @override
  String get hindi => 'हिंदी';

  @override
  String get languageChangedSuccessfully => '¡Idioma cambiado exitosamente!';
}
