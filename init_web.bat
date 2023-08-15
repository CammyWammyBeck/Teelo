call venv\Scripts\activate

cd teelo_web\backend
start cmd /k "python app.py"

cd ..\frontend
start cmd /k "npm start"