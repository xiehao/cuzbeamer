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
\newif\ifcuz@option@lighttheme \cuz@option@lightthemefalse%
\DeclareOption{light}{%
    \cuz@option@lightthemetrue%
}
\DeclareOption{wide}{
    \PassOptionsToClass{aspectratio=1610}{beamer}
}
\DeclareOption*{
    \PassOptionsToClass{\CurrentOption}{beamer}
}
%-
%-> Terminates all options processing
%-
\ProcessOptions\relax%
%---------------------------------------------------------------------------%
%->> Load class information
%---------------------------------------------------------------------------%
\LoadClass[UTF8,10pt]{beamer}%
\RequirePackage[zihao=false]{ctex}%
%---------------------------------------------------------------------------%
%->> Theme configuration
%---------------------------------------------------------------------------%
\usetheme{metropolis}%
\ifcuz@option@lighttheme%
    \metroset{background=light}%
\else%
    \metroset{background=dark}%
\fi%
\RequirePackage{appendixnumberbeamer}
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
\RequirePackage{etoolbox}% a toolbox of programming facilities
\newcommand{\eifstringequal}{\expandafter\ifstrequal\expandafter}% expansion control
\eifstringequal{\cuz@fontset}{windows}{
    \cuz@windowstrue%
    % \ctexset{fontset=windowsnew}%
}{\eifstringequal{\cuz@fontset}{mac}{
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
        \else
            \setmonofont[NFSSFamily=entexttt]{Monaco}%
        \fi
    \fi
\fi
%---------------------------------------------------------------------------%
%->> Some code to be executed at the beginning of the document
%---------------------------------------------------------------------------%
\AtBeginDocument{
    \makeatletter
    %-
    %-> The university logo in the title page
    %-
    \ifcuz@option@lighttheme
        \titlegraphic{\hfill\includegraphics[width=0.28\textwidth]{images/cuzlogo}}
    \else
        \titlegraphic{\hfill\includegraphics[width=0.28\textwidth]{images/cuzlogo-brown}}
    \fi
    \makeatother
}
%---------------------------------------------------------------------------%
%->> New environments for convenience
%---------------------------------------------------------------------------%
%-
%-> The new standout environment for standout frames
%-
\newenvironment{standout}[1][]{%
    \begin{frame}[standout]{#1}
}{%
    \end{frame}
}%
%---------------------------------------------------------------------------%
\endinput%