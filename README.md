# AME Wizard Playbook Builder

This is a simple batch script that creates .apbx playbook files for use with [AME Wizard](https://ameliorated.io/)

## 🛠 What It Does

- Compresses the contents of a src/ directory into a .zip archive
- Renames the archive to .apbx (AME Wizard playbook format)
- Outputs the result as playbook.apbx in the root directory

## 📁 Folder Structure
├── your-repo/
├── build-playbook.bat # Main build script
├── src/ # Your playbook contents

## 🚀 How to Use

1. Place your AME Wizard playbook files in the src/ folder.
2. Run build-playbook.bat.
3. If successful, a playbook.apbx file will be created in the root directory.

You can now import this .apbx file into AME Wizard.

## ✅ Requirements
- A playbook either your own or https://revi.cc/
- [AME Wizard](https://ameliorated.io/) to use the generated playbook
