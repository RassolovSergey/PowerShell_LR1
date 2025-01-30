# Считываем путь до папки
Write-Host "Введите путь к папке, которую необходимо очистить:" -ForegroundColor Cyan
$folderPath = Read-Host "Путь к папке"

# Проверка существования папки
if (Test-Path $folderPath -PathType Container) {
    Write-Host "Очистка папки: $folderPath..." -ForegroundColor Yellow

    # Удаление всех файлов в папке
    Get-ChildItem -Path $folderPath -File | Remove-Item -Force -ErrorAction SilentlyContinue

    # Удаление всех папок и файлов в папке, с подавлением ошибок
    Get-ChildItem -Path $folderPath -Directory | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

    Write-Host "Папка успешно очищена!" -ForegroundColor Green
}
else {
    Write-Host "Ошибка: Указанный путь не существует или это не папка!" -ForegroundColor Red
    exit 1
}
