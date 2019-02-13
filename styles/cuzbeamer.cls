%---------------------------------------------------------------------------%
%-                                                                         -%
%-                           Document Class                                -%
%-                                                                         -%
%---------------------------------------------------------------------------%
%- Copyright (C) Hao XIE <oaheix@gmail.com> 
%- This is free software: you can redistribute it and/or modify it
%- under the terms of the GNU General Public License as published by
%- the Free Software Foundation, either version 3 of the License, or
%- (at your option) any later version.
%---------------------------------------------------------------------------%
%->> Identification
%---------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}%
\ProvidesClass{cuzbeamer}[2019/02/01 v1.0 LaTeX Document Class]%

%---------------------------------------------------------------------------%
%->> Declare options
%---------------------------------------------------------------------------%
\RequirePackage{kvoptions}% use key-value options
\SetupKeyvalOptions{
    family=cuz,
    prefix=cuz@option@
}
\DeclareStringOption[dark]{colortheme}[dark]% light or dark (default)
\DeclareStringOption[wide]{pagestyle}[wide]% normal, wide (default) or wider
\DeclareStringOption[left]{titlealignment}[left]% left, center or right (default)
\DeclareDefaultOption{%
    \PassOptionsToClass{\CurrentOption}{beamer}%
}%
%-
%-> Terminates all options processing
%-
\ProcessKeyvalOptions{cuz}\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\ifxstringequal}{\expandafter\ifstrequal\expandafter}% expansion control
\ifxstringequal{\cuz@option@pagestyle}{normal}{%
    \PassOptionsToClass{aspectratio=43}{beamer}%
}{\ifxstringequal{\cuz@option@pagestyle}{wide}{%
    \PassOptionsToClass{aspectratio=1610}{beamer}%
}{%
    \PassOptionsToClass{aspectratio=169}{beamer}%
}}%
\LoadClass[UTF8,10pt]{beamer}%
\RequirePackage[zihao=false]{ctex}%
%---------------------------------------------------------------------------%
%->> CJK Languages for different platforms and compilers
%---------------------------------------------------------------------------%
\RequirePackage{expl3}% LaTeX3 programming environment
\ExplSyntaxOn%
\providecommand{\g__ctex_fontset_tl}{}% platform fontset state variable
\edef\cuz@fontset{\g__ctex_fontset_tl}% expanded platform fontset state variable
\ExplSyntaxOff%
%-
%-> Platform fontset <windows>, <mac>, <linux>
%-
\newif\ifcuz@windows \cuz@windowsfalse% 
\newif\ifcuz@mac \cuz@macfalse% 
\newif\ifcuz@linux \cuz@linuxfalse% 
\ifxstringequal{\cuz@fontset}{windows}{
    \cuz@windowstrue%
    % \ctexset{fontset=windowsnew}%
}{\ifxstringequal{\cuz@fontset}{mac}{
    \cuz@mactrue
    % \ctexset{fontset=macnew}%
}{
    \cuz@linuxtrue%
    % \ctexset{fontset=ubuntu}%
}}
%-
%-> LaTeX engine <pdflatex>, <lualatex>, <xelatex>
%-
\newif\ifcuz@pdftex \cuz@pdftexfalse
\newif\ifcuz@xetex \cuz@xetexfalse
\newif\ifcuz@luatex \cuz@luatexfalse
\RequirePackage{ifxetex,ifluatex}% LaTeX engine detection
\ifxetex% XeLaTeX
    \cuz@xetextrue%
\else\ifluatex% LuaLaTeX
    \cuz@luatextrue%
\else% pdfLaTeX, not supported in Linux
    \cuz@pdftextrue%
\fi\fi
\RequirePackage{amsmath,mathtools,amsfonts}%
\ifcuz@pdftex
    \RequirePackage[utf8]{inputenc}% set input encoding, document must use utf-8 encoding
    \RequirePackage[T1]{fontenc}% set font encoding to enable modern font encoding
    \RequirePackage{newtxtext}%
    \RequirePackage[cmintegrals]{newtxmath}% load after math packages
\else
    \RequirePackage{fontspec}% support calling system fonts
    \ifcuz@xetex
        \RequirePackage{xeCJK}% support calling system fonts
    \fi
    \ifcuz@linux
        \setmainfont[NFSSFamily=entextrm]{Ubuntu}
        \setsansfont[NFSSFamily=entextsf]{Ubuntu}
        % \setmainfont[NFSSFamily=entextrm]{TeX Gyre Termes}% an alternative of Times New Roman
        % \setsansfont[NFSSFamily=entextsf]{TeX Gyre Heros}% an alternative of Helvetica
        \setmonofont[NFSSFamily=entexttt]{Ubuntu Mono}%{TeX Gyre Cursor}% an alternative of Courier New
    \else
        \setmainfont[NFSSFamily=entextrm]{Palatino Linotype}% Times New Roman
        \setsansfont[NFSSFamily=entextsf]{Palatino Linotype}% Helvetica
        \ifcuz@windows%
            \setmonofont[NFSSFamily=entexttt]{Consolas}%
        \else% for mac
            \setmonofont[NFSSFamily=entexttt]{Monaco}%
        \fi
    \fi
\fi
%---------------------------------------------------------------------------%
%->> Theme configuration
%---------------------------------------------------------------------------%
\usetheme{metropolis}%
\RequirePackage{appendixnumberbeamer}% 
\ifxstringequal{\cuz@option@colortheme}{light}{
    \metroset{background=light}%
}{%
    \metroset{background=dark}%
}%
%---------------------------------------------------------------------------%
%->> Some code to be executed at the beginning of the document
%---------------------------------------------------------------------------%
\AtBeginDocument{
    \makeatletter
    %-
    %-> The university logo in the title page
    %-
    \ifxstringequal{\cuz@option@colortheme}{light}{%
        \titlegraphic{\hfill\includegraphics[width=0.28\textwidth]{images/cuzlogo}}%
    }{%
        \titlegraphic{\hfill\includegraphics[width=0.28\textwidth]{images/cuzlogo-brown}}%
    }%
    \makeatother
}
%---------------------------------------------------------------------------%
%->> New environments and macros for convenience
%---------------------------------------------------------------------------%
\RequirePackage{calc}
%-
%-> The new standout environment for standout frames
%-
\newenvironment{standout}[1][]{%
    \begin{frame}[standout]{#1}
}{%
    \end{frame}
}%
%-
%-> The new bicolumns macro for two columns environment
%-
\newcommand{\bicolumns}[3][0.618]{%
    \newlength{\leftwidth}%
    \setlength{\leftwidth}{#1\textwidth}%
    \newlength{\rightwidth}%
    \setlength{\rightwidth}{\textwidth-\leftwidth}%
    \begin{columns}[T,onlytextwidth]
        \column{\leftwidth}%
        #2%
        \column{\rightwidth}%
        #3%
    \end{columns}
}%
%---------------------------------------------------------------------------%
%->> Customize the alignment of elements at the cover page
%---------------------------------------------------------------------------%
\setbeamertemplate{title}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \linespread{1.0}%
    \inserttitle%
    \par%
    \vspace*{0.5em}%
}
\setbeamertemplate{subtitle}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \insertsubtitle%
    \par%
    \vspace*{0.5em}%
}
\newcommand{\email}[1]{\gdef\cuz@email{#1}}%
\setbeamertemplate{author}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \vspace*{2em}%
    \insertauthor%
    \par%
    {\scriptsize \href{mailto:\cuz@email}{\itshape \cuz@email}}%
    \par%
    \vspace*{0.25em}%
}
\setbeamertemplate{date}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \insertdate%
    \par%
}
\setbeamertemplate{institute}{
    \ifxstringequal{\cuz@option@titlealignment}{left}{%
        \raggedright%
    }{\ifxstringequal{\cuz@option@titlealignment}{center}{%
        \centering%
    }{%
        \raggedleft%
    }}%
    \vspace*{0.02em}%
    \insertinstitute%
    \par%
}
%---------------------------------------------------------------------------%
\endinput%