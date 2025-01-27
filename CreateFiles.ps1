# Путь к папке
$folderPath = "C:\Users\NPC\Documents\Code - Projects\Designing operating systems\PowerShell_v1\Files"

# Кол-во файлов
$fileCount = 100

# Начальная дата для файлов
$startDate = Get-Date "2025-01-01"

# Создание файла
for ($i = 1; $i -le $fileCount; $i++) {
    # Формируем имя файла и путь к нему
    $fileName = "image_$i.jpg"
    $filePath = Join-Path -Path $folderPath -ChildPath $fileName

    # Создаем пустой файл .jpg
    New-Item -Path $filePath -ItemType File | Out-Null

    # Устанавливаем случайное время
    $randomDays = Get-Random -Minimum 0 -Maximum 28
    $randomHours = Get-Random -Minimum 0 -Maximum 23
    $randomMinutes = Get-Random -Minimum 0 -Maximum 59


    # Формируем дату и время
    $fileDateTime = $startDate.AddDays($randomDays).AddHours($randomHours).AddMinutes($randomMinutes)

    # Устанавливаем дату и время для файла
    (Get-Item $filePath).CreationTime = $fileDateTime   # Создание
    (Get-Item $filePath).LastWriteTime = $fileDateTime  # Изменение
    (Get-Item $filePath).LastAccessTime = $fileDateTime # Открытие

    Write-Host "$fileName создан: с датой и временем $fileDateTime"
}

Write-Host "Создание файлов завершено!"
