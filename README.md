# ETS preambles

This repository contains several self-written preambles for LuaTeX that serve
the following purposes:

 * Use OpenType features and contextual tracking for advanced font declarations
   (such as all caps and “all small caps” in titles or labels).
 * Implement the layout of Robert Bringhurst’s textbook [The Elements of Typographic
   Style](https://en.wikipedia.org/wiki/The_Elements_of_Typographic_Style)
   (short: ETS, hence the name of the project) by modifying parameters in Markus
   Kohm’s [KOMA classes](https://komascript.de/).[^1]
 * Use the commercial fonts [Minion Pro](https://fonts.adobe.com/fonts/minion)
   and [Minion Math](http://www.typoma.com/en/fonts.html) directly as OTFs.[^2]
   (The fonts themselves are _not_ part of the repository, see details below.)
 * Define theorem names and command abbreviations which I regularly use.

Note that this entire project heavily uses OpenType features, and hence requires
all documents to be compiled with LuaTeX (i.e. using the `lualatex` command).

[^1]: I shall point out that there is a rather famous package called
    [classicthesis](https://ctan.org/pkg/classicthesis) by André Miede and Ivo
    Pletikosić, which pursues a similar goal.  Our documentclasses, however, are
    way less elaborate and essentially relie on internal KOMA options, making
    the code more flexible – and, hopefully, more robust.
[^2]: And not, as in the package [minionpro](https://ctan.org/pkg/minionpro) by
    Achim Blumensath, by first converting them to Type 1 fonts.

## Components

The project is split into several _components_, which can be used somewhat
independently of each other:

### OpenType font styles (`otfontstyles`)

This package employs `fontspec` and `microtype` to establish the following font
declarations:

 * `\allcaps` (letterspaced all caps with `case` and `cpsp`),
 * `\sctitle` (heavily spaced small caps with `c2sc` in titles and headings),
 * `\sclabel` (moderately spaced small caps with `c2sc` in labels), and
 * `\tbfigures` (tabular text figures).
 
Moreover, we introduce the semantic command `\acr` for acronyms (mildly spaced
small caps with `c2sc`).  This package is used by all upcoming components.

### OpenType Minion packages (`otminionpro`, `otminionmath`)

The two packages `otminionpro` and `otminionmath` implement the aforementioned
commercial fonts (including optical sizes, contextual swashes, breaking the
Th-ligature, and some spacing adjustments).  In order to use them, you need the
commercial fonts Minion Pro and Minion Math, respectively.

However, none of the following components actually relie on these specific
fonts.  The base package `otfontstyles` works well with any font that has the
respective OpenType features (such as EB Garamond, see below).

### Custom bibliography and theorem environments (`etsbib`, `etsthm`)

These packages contain some design choices for bibliography (extending
`biblatex`) and theorem environments (extending `amsthm`), both using the font
declarations from `otfontstyles`.  The package `etsthm` includes `cleveref` and
hence also loads `hyperref`; it therefore should be the last package to call.

### Documentclasses (`etsbook`, `etsartcl`, `etslttr`)

These three classes establish an overall layout that is inspired by Bringhurst’s
“Elements of Typographic Style” via KOMA-internal commands. Before using them,
please note the following:

 * Each of these classes requires a language option (such as `ngerman` or
   `british`) as an argument.  They will load `babel`, `csquotes` and `isodate`
   to get language-specific quotation styles and date formats.
 * The paper format for `etsbook` and `etsartcl` can be set via `paper=`, the
   default being `b5` (176×250mm²).  With `a5` and `b5`, you will get decent
   typeareas; any other choice will merely use the preconfigured typearea for
   `b5` as a fallback.  The default paper format for `etslttr` is `a4` with a
   lot of free area.
 * The class `etsbook` allows you to put a cover figure on the title page.  This
   can be set using the command `\coverfigure`.  If you do not use this command,
   the corresponding area is left empty.

### My theorems and commands (`mythms`, `mycmds`, `mydefs`)

The components `mythms` and `mycmds` are mere `tex`-files containing theorem
definitions (using the styles defined in `etsthm`) and math commands (assuming
`unicode-math`, which is loaded e.g. by `otminionmath`).  They can be included
by simply writing `\input{mythms}` or `\input{mycmds}`.
 
## Installation

The easiest way is to just copy the content of the folder `./texmf` directly
into your local TEXMF tree, resulting in two new folders `tex/latex/ets` and
`scripts/ets`.  A cleaner solution is to clone the repository to your favourite
directory (choose it carefully once and for all) and then _link_ the files via
`stow` (a tool available for any Linux system).  This is done as follows (from
within the repository’s main folder, assuming that `$TEXMFHOME` contains the
path of your local TEXMF tree):

    stow -t $TEXMFHOME -S texmf
    
If you want to remove the preambles from your TEXMF tree, just run (again from
within the repository’s main folder):

    stow -t $TEXMFHOME -D texmf

## Instructive examples

In order to see the different components in action, and also to check whether
they work properly on your system, have a look at the small examples that are
contained in the folder `./examples`.  You should be able to compile them if:

  1. you installed the components as described before,
  2. you installed the fonts that are called (see below), and
  3. you use `lualatex` for the compilation.

## Templates and shortcuts

Even though the usage of these preambles significantly reduces the amount of
code necessary to put the beginning of each TeX file, you might still want to
have a mechanism that produces a new document containing a rough structure
waiting to be filled with content (especially for letters, where you have to set
several KOMA variables).

The folder `./templates` addresses this requirement.  Since you might want to
change these templates to your needs (e.g. add your name and address in the
letter template), I suggest to _copy_ them to your local TEXMF tree[^3], e.g. by
calling (from within the repository’s main folder):

    mkdir -d $TEXMFHOME/local/templates/ets
    cp templates/* $TEXMFHOME/local/templates/ets/

[^3]: According to the [TDS convention](https://tug.org/tds/), the folder
    `$TEXMFHOME/local` is the place for files that have been modified locally.

In order to quickly access these files, I recommend to define aliases in your
`.bashrc`, such as

    alias newbook='cp $TEXMFHOME/local/templates/ets/etsbook.tex main.tex'

and similarly `newartcl` and `newlttr` (or whichever name you prefer).  If you
start a new project, you just have to execute `newbook` from within the intended
folder, and you end up having a main file to work with.

## Fonts

### Commercial fonts

As mentioned above, the fonts Minion Pro and Minion Math are commercial and have
to be purchased and installed before you will be able to use either
`otminionpro` or `otminionmath`.  According to the TDS convention, you should
put the corresponding OTFs into the folders

    $TEXMFHOME/fonts/opentype/adobe/MinionPro
    $TEXMFHOME/fonts/opentype/typoma/MinionMath

The `otminionpro` package uses the default font style, the italic font style,
and the semibold font style, all three in all four optical sizes (Caption,
Regular, Subhead, and Display), i.e. twelve font styles in total.  The
`otminionmath` package uses the default font style in three optical sizes
(Tiny, Caption, and Regular), and a semibold variant, i.e. four font styles in
total.

One remark on the Minion Math OTFs: As discussed in [this StackExchange
thread](https://tex.stackexchange.com/a/736527/70834), Minion Math contains a
lot of pairwise kerning information; however, this data is stored under
`script=dflt` rather than under `script=math`, and hence is ignored by LuaTeX.
I am using a version of Minion Math where this mistake has been corrected.  If
you do not have this version and still want to kern properly in math mode, a
workaround is described in the aforementioned thread.

### Other fonts

Apart from the taylored packages `otminionpro` and `otminionmath`, all other
components can be used with different fonts.  Many of my examples use EB
Garamond as a main font, as it has the desired OpenType features and is
available on most TeX distributions.

Finally, if you look for a monospace font that matches MinionPro, my suggestion
would be [Monaspace Xenon](https://monaspace.githubnext.com/), which you can
easily find on Github; the OTFs should be stored in 

    $TEXMFHOME/fonts/opentype/githubnext/monaspace

Monaspace’s texture healing mechanism is implemented via the OpenType feature
`calt`, which is active per default when using `\setmonofont`.
