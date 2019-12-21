## What is this?

This repository stores a non-personal copy of my résumé (CV) written in LaTeX. The design is largely a
replication of [@WebPraktikos' universal-resume](https://github.com/WebPraktikos/universal-resume)
and reuses some code of [@posquit0's Awesome-CV](https://github.com/posquit0/Awesome-CV).
Feel free to use and customize the template for your own purposes.

## Preview

| Sad boy style | Technicolor |
|:---:|:---:|
| ![Black & White](preview/bw.png?raw=true) | ![Color](preview/color.png?raw=true) |

## How to Use

#### Requirements

A full TeX distribution is assumed.  [Various distributions for different operating systems (Windows, Mac, \*nix) are available](http://tex.stackexchange.com/q/55437) but TeX Live is recommended.
You can [install TeX from upstream](http://tex.stackexchange.com/q/1092) (recommended; most up-to-date) or use `sudo apt-get install texlive-full` if you really want that.  (It's generally a few years behind.)

#### Usage

At a command prompt, run

```bash
$ xelatex {your-cv}.tex
```

This should result in the creation of ``{your-cv}.pdf``
