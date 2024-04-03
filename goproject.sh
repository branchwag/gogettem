#!/bin/bash

clear
read -p "Project name? " projectname

#Make a new project folder
mkdir $projectname
cd $projectname

# Initialize a new Go module
go mod init $projectname

# Get the Echo framework
go get github.com/labstack/echo/v4

# Install Air for live reloading
go install github.com/cosmtrek/air@latest

# Install gopls for Go language server
go install golang.org/x/tools/gopls@latest

# Get Echo middleware
go get github.com/labstack/echo/v4/middleware

#Make starter files
touch .prettierignore
touch index.html
touch style.css
touch server.go

#Put boilerplate in starter files
cat << EOF > server.go
package main

import (
	"html/template"
	"io"
	"net/http"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

type Templates struct {
	templates *template.Template
}

func (t *Templates) Render(w io.Writer, name string, data interface{}, c echo.Context) error {
	return t.templates.ExecuteTemplate(w, name, data)
}

func NewTemplates() *Templates {
	return &Templates{
		templates: template.Must(template.ParseGlob("*.html")),
	}
}

func main() {
	e := echo.New()
	e.Use(middleware.Logger())

	e.Renderer = NewTemplates()

	e.GET("/", func(c echo.Context) error {
		//return c.String(http.StatusOK, "Hello, World!")
		return c.Render(http.StatusOK, "index", "muhaha")
	})
	e.Logger.Fatal(e.Start(":1323"))
}
EOF

cat << EOF > index.html
{{block "index" . }}
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="X-UA-Compatible" content="ie=edge" />
    <title>A Fantastic Webpage</title>
    <link rel="stylesheet" href="style.css" />
    <script
      src="https://unpkg.com/htmx.org@1.9.11"
      integrity="sha384-0gxUXCCR8yv9FM2b+U3FDbsKthCI66oH5IA9fHppQq9DDMHuMauqq1ZHBpJxQ0J0"
      crossorigin="anonymous"
    ></script>
  </head>
  <body>
    <h1>Oh hey it's a webpage</h1>
  </body>
</html>
{{ end }}
EOF

cat << EOF > README.md
# <Your-Project-Title>

## Description

Provide a short description explaining the what, why, and how of your project. Use the following questions as a guide:

- What was your motivation?
- Why did you build this project? (Note: the answer is not "Because it was a homework assignment.")
- What problem does it solve?
- What did you learn?

## Table of Contents (Optional)

If your README is long, add a table of contents to make it easy for users to find what they need.

- [Installation](#installation)
- [Usage](#usage)
- [Credits](#credits)
- [License](#license)

## Installation

What are the steps required to install your project? Provide a step-by-step description of how to get the development environment running.

## Usage

Provide instructions and examples for use. Include screenshots as needed.

To add a screenshot, create an assets/images folder in your repository and upload your screenshot to it. Then, using the relative file path, add it to your README using the following syntax:

![alt text](assets/images/screenshot.png)

## Credits

List your collaborators, if any, with links to their GitHub profiles.

If you used any third-party assets that require attribution, list the creators with links to their primary web presence in this section.

If you followed tutorials, include links to those here as well.

## License

The last section of a high-quality README file is the license. This lets other developers know what they can and cannot do with your project. If you need help choosing a license, refer to [https://choosealicense.com/](https://choosealicense.com/).

---

The previous sections are the bare minimum, and your project will ultimately determine the content of this document. You might also want to consider adding the following sections.

## Badges

![badmath](https://img.shields.io/github/languages/top/nielsenjared/badmath)

Badges aren't necessary, but they demonstrate street cred. Badges let other developers know that you know what you're doing. Check out the badges hosted by [shields.io](https://shields.io/). You may not understand what they all represent now, but you will in time.

## Features

If your project has a lot of features, list them here.

## How to Contribute

If you created an application or package and would like other developers to contribute to it, you can include guidelines for how to do so. The [Contributor Covenant](https://www.contributor-covenant.org/) is an industry standard, but you can always write your own if you'd prefer.

## Tests

Go the extra mile and write tests for your application. Then provide examples on how to run them here.
EOF

# Run Air for live reloading
#air

#Open vscode
code .

