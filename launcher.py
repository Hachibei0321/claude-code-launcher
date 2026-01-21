import webview
import subprocess
import os
import sys

class Api:
    def run_command(self, files):
        """
        Execute a list of files/commands. 
        Usually receives a single filename from the UI.
        """
        # Ensure files is a list, even if a single string is passed
        if isinstance(files, str):
             files = [files]
             
        for filename in files:
            print(f"Request to run: {filename}")
            try:
                # Get the absolute path to the file
                # The script assumes files are in the same directory as launcher.py
                script_dir = os.path.dirname(os.path.abspath(__file__))
                file_path = os.path.join(script_dir, filename)
                
                if not os.path.exists(file_path):
                    print(f"Error: File not found: {file_path}")
                    continue

                # Run the file
                # shell=True allows running batch files directly
                subprocess.Popen(file_path, shell=True, cwd=script_dir)
                print(f"Started: {filename}")
                
            except Exception as e:
                print(f"Error running {filename}: {e}")

    def get_current_dir(self):
        return os.path.dirname(os.path.abspath(__file__))

def main():
    api = Api()
    
    # Get HTML file path
    script_dir = os.path.dirname(os.path.abspath(__file__))
    html_path = os.path.join(script_dir, 'launcher.html')
    
    # Create window
    # width/height set to match a comfortable size for the launcher
    window = webview.create_window(
        'Claude Code Launcher', 
        url=html_path,
        js_api=api,
        width=1000,
        height=700,
        background_color='#1a1a2e' # Match body background for seamless look
    )
    
    webview.start(debug=False) # Disable debug mode for production

if __name__ == '__main__':
    main()
