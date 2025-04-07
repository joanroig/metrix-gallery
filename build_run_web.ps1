# Cleanup
flutter clean  
# Build the Flutter web project
flutter build web
# Run the server
cd build/web
Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c python -m http.server" | Out-Null
Start-Sleep -Seconds 2
# Open the website in the default web browser
Start-Process "http://localhost:8000"