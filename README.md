# `cuzbeamer`

This is a LaTeX template based on the [`metropolis`](https://github.com/matze/mtheme) beamer theme, and customized for the convenience of making slides for Communication University of Zhejiang.

## Project Structure

The structure of this project is shown and explained below:

```bash
CUZbeamer
├── demo.pdf
├── demo.tex
├── images
│   ├── cuzlogo-brown.pdf
│   ├── cuzlogo-dark.pdf
│   ├── cuzlogo-light.pdf
│   ├── cuzlogo.pdf
│   └── ...
├── initialization.tex
├── README.md
├── references.bib
└── styles
    ├── cuzbeamer.cls
    └── tikz-uml.sty
```

- `styles/`: a folder containing the class file `cuzbeamer.cls` and the package `tikz-uml.sty` (written by [Nicolas Kielbasiewicz](http://perso.ensta-paristech.fr/~kielbasi/tikzuml/));
- `images/`: a folder containing images and figures used by the main `.tex` file (the school logos are also in it, and should not be modified or removed);
- `initialization.tex`: common info imported by the main `.tex` files, involving: author's name and e-mail, title, subtitle and date, users should assign theses variables beforehand;
- `demo.tex`: the demo source file, showing how to use this `cuzbeamer` class to make a proper set of slides;
- `references.bib` (optional): the bib file used for `bibtex` to import references.

Users are supposed to add new `.tex` files at the same level of `demo.tex`, and specify their own common info in `initialization.tex`, put necessary image files in `images/` folder and necessary reference items in `references.bib` file if needed; while the file structure is not suggested to be modified.

## Prerequests

To use this class:

- A LaTeX environment is required ([TeX Live](https://www.tug.org/texlive/) is highly recommended);
- [Optional] If codes are to be shown, the `minted` package is used (the `minted` option should be switched on, se below), which then requires a Python 3 environment, with the `pygments` installed:

    ``` bash
    > pip install pygments
    ```

## Usage

### Compilation

Due to some reasons of `metropolis` beamer theme, the `pdflatex` engine is not supported, thus the `xelatex` or `lualatex` is recommended. Besides, if `minted` option is on, the `-shell-escape` option is required when compiling, e.g.:

```bash
> xelatex -shell-escape -synctex=1 -interaction=nonstopmode -file-line-error demo.tex
```

### Options

When importing this `cuzbeamer` class in the main `.tex` files, several options are allowed to be set:

- `[colortheme=light/dark]`: a string option, set the background color of `metropolis`, `dark` by default, or `light` if desired;
- `[pagestyle=normal/wide/wider]`: a string option, set the aspectratio of slide pages, `normal` for 5:4, `wide` for 16:10 (the default), or `wider` for 16:9;
- `[titlealignment=left/center/right]`: a string option, set the alignment of elements (e.g. title, subtitle, author, date, etc.) in the title page, `left` (the default), `center` or `right`;
- `[minted=true/false]`: a boolean option, set for whether to include codes in the slides, `true` by default;
- `[algorithm=true/false]`: a boolean option, set for whether to use algorithm environments, `false` by default;
- `[pgfplots=true/false]`: a boolean option, set for whether to use `pgfplots` package to plot figures, `false` by default.

## License

This class is licensed under a [Creative Commons Attribution-ShareAlike 4.0 International License](https://creativecommons.org/licenses/by-sa/4.0/). This means that if you change the theme and re-distribute it, you *must* retain the copyright notice header and license it under the same CC-BY-SA license. This does not affect the presentation that you create with the class.