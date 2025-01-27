# Считываем и сохраняем путь до папки
Write-Host "Введите расположение ваших файлов:" -ForegroundColor Cyan
$folderPath = Read-Host "Путь к папке"

# Проверка существования пути
if (Test-Path $folderPath -PathType Container) {
    # Получаем список файлов в папке формата .jpg
    $files = Get-ChildItem -Path $folderPath -File | Where-Object { $_.Extension -eq ".jpg" }

    # Проверяем количество файлов
    if ($files.Count -lt 2) {
        Write-Host "Ошибка! Недостаточно файлов для выполнения скрипта." -ForegroundColor Red
        exit 1  # Завершаем выполнение скрипта с кодом ошибки
    }
    else {
        Write-Host "Путь сохранён: $folderPath" -ForegroundColor Green
        Write-Host "В папке найдено $($files.Count) файлов формата .jpg." -ForegroundColor Green

        # Шаг 1: Присваиваем временные имена файлам для устранения дублирования
        Write-Host "Переименование файлов во временные имена..." -ForegroundColor Cyan
        $tempCounter = 0
        foreach ($file in $files) {
            $tempFileName = "TEMP_{0:D6}.jpg" -f $tempCounter
            Rename-Item -Path $file.FullName -NewName $tempFileName -Force
            Write-Host "Файл $($file.Name) временно переименован в $tempFileName"
            $tempCounter++
        }

        # Получаем список файлов снова после временного переименования
        $tempFiles = Get-ChildItem -Path $folderPath -File | Where-Object { $_.Extension -eq ".jpg" }

        # Сортируем временные файлы по дате создания (CreationTime)
        $sortedFiles = $tempFiles | Sort-Object CreationTime

        # Шаг 2: Присваиваем окончательные имена файлам в формате IMG_000000.jpg
        Write-Host "Присваиваем окончательные имена файлам..." -ForegroundColor Cyan
        $counter = 0
        foreach ($file in $sortedFiles) {
            $newFileName = "IMG_{0:D6}.jpg" -f $counter
            Rename-Item -Path $file.FullName -NewName $newFileName -Force
            Write-Host "Файл $($file.Name) окончательно переименован в $newFileName"
            $counter++
        }

        Write-Host "Переименование завершено успешно!" -ForegroundColor Green
    }
}
else {
    Write-Host "Ошибка: Указанный путь не существует или это не папка!" -ForegroundColor Red
    exit 1  # Завершаем выполнение скрипта с кодом ошибки
}
