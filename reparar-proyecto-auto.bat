@echo off
title 🚀 Reparar Proyecto Ecommerce-Mayoreo
color 0B
echo =======================================================
echo 🚀 Script de Reparación Automática Ecommerce-Mayoreo
echo =======================================================

REM --- Buscar carpeta del proyecto ---
setlocal enabledelayedexpansion
set "projectRoot="

for %%p in ("%USERPROFILE%\Desktop\Ecommerce-Mayoreo" "%USERPROFILE%\Documents\Ecommerce-Mayoreo" "%USERPROFILE%\Proyectos\Ecommerce-Mayoreo") do (
    if exist "%%~p" (
        set "projectRoot=%%~p"
        goto :found
    )
)

:found
if not defined projectRoot (
    color 0C
    echo ❌ No se encontró la carpeta 'Ecommerce-Mayoreo'.
    echo 👉 Muévela a Escritorio, Documentos o C:\Users\TuUsuario\Proyectos
    echo Presiona una tecla para salir...
    pause >nul
    exit /b
)

set "apiPath=%projectRoot%\api"
set "webPath=%projectRoot%\web"

echo.
echo 📁 Proyecto detectado en: %projectRoot%
echo -------------------------------------------------------

REM --- Backend ---
if exist "%apiPath%" (
    echo 🧹 Limpiando backend (NestJS)...
    cd /d "%apiPath%"
    rmdir /s /q node_modules dist
    del /q pnpm-lock.yaml 2>nul
    call pnpm install
    echo ⚙️ Iniciando backend...
    start powershell -NoExit -Command "cd '%apiPath%'; pnpm run start:dev"
) else (
    echo ⚠️ No se encontró la carpeta 'api'
)

REM --- Frontend ---
if exist "%webPath%" (
    echo 🧼 Limpiando frontend (Next.js)...
    cd /d "%webPath%"
    rmdir /s /q node_modules .next
    del /q pnpm-lock.yaml 2>nul
    call pnpm install
    echo 🌐 Iniciando frontend...
    start powershell -NoExit -Command "cd '%webPath%'; pnpm run dev"
) else (
    echo ⚠️ No se encontró la carpeta 'web'
)

echo.
echo ✅ Todo listo:
echo    • Backend NestJS → http://localhost:3000
echo    • Frontend Next.js → http://localhost:3001
echo -------------------------------------------------------
echo 💡 Si algo falla, asegúrate de tener Node.js v18+ y PNPM instalado.
echo.
pause
exit
