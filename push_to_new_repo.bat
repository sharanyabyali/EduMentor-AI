@echo off
echo =========================================================
echo  EduMentor AI - Push to New GitHub Repository Helper
echo =========================================================
echo.
echo Step 1: Go to https://github.com/new in your browser.
echo Step 2: Name your repository "EduMentor-AI" and click "Create repository".
echo.
set /p REPO_URL="Step 3: Paste the new repository URL here (e.g., https://github.com/username/EduMentor-AI.git): "

if "%REPO_URL%"=="" (
    echo.
    echo [ERROR] No URL provided. Exiting.
    pause
    exit /b
)

echo.
echo Staging files...
git add .

echo.
echo Committing latest code updates...
git commit -m "feat: initial commit for EduMentor AI personalized learning platform" 2>nul

echo.
echo Re-linking Git remote to the new repository...
git remote rename origin backup_origin 2>nul
git remote remove origin 2>nul
git remote add origin %REPO_URL%

echo.
echo Pushing codebase to %REPO_URL%...
git push -u origin main

if %errorlevel% neq 0 (
    echo.
    echo [WARNING] Push failed. Reverting Git remote to previous repository...
    git remote remove origin 2>nul
    git remote rename backup_origin origin 2>nul
    echo.
    echo If authentication failed, please ensure you are logged into Git on your computer.
    pause
    exit /b
)

echo.
echo =========================================================
echo  SUCCESS! Code pushed successfully to new repository.
echo =========================================================
pause
