# commands

## Author(s)

  * Steven Colburn

## Instructions

###  **npm run [command] [parameters]**

  **Command List**  

  * atom
    * adds packages to atom
  * commit [message]
    * commits to this projects git
    * messages should be wrapped in singles quotes of there are spaces
  * git-config [name] [email]
    * sets configuration locally for this projects git
    * use single quotes for name if there are spaces ex: 'Jane Doe'
  * git-global-config [name] [email]
    * sets the global git configuration for the user
    * use single quotes for name if there are spaces ex: 'Jane Doe'
  * pair [user-one user-one-email user-two user-two-email]
    * Creates a pairing file for git
    * Wrap user-one and user-two in singles quotes ex: 'Jane Doe'
  * unset-global-git
    * unsets the global configuration for git username and email

  **Project Setup**  

  * angular [project-name]
    * Angular project setup
  * solution [project-name]
    * Microsoft ASP.NET solution project setup
  * javascript [project-name]
    * Javascript setup
  * javascript-api [project-name]
    * Javascript setup using an api
  * react [project-name]
    * React project setup
    * Setup includes using bootstrap

## NPX Windows Problems

When using npx on Windows if you get the error  
"The "path" argument must be of type string. Received type undefined"  
make sure for the order of folder in the System Environment Path  
C:\Users\[Username]\AppData\Roaming\npm  
C:\Program Files (x86)\nodejs  
Don't use the User Variable path  

## License

MIT License

Copyright (c) 2018 Steven Colburn

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
