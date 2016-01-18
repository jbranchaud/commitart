# CommitArt

Modifying the commit history of git repositories in order to write messages
in GitHub's contribution graph.

I did this project as a way of learning how to use the
[Rugged](https://github.com/libgit2/rugged) library which is a ruby binding to
[libgit2](https://github.com/libgit2/libgit2).

Check out the picture below or [see it live](https://github.com/commitart)
(note: more than a year has passed since I created this, so the contribution
graph for this account now looks empty).

![GITHUB CommitArt](http://i.imgur.com/e6DlzfA.png)

Using the letters from the `alphabet.yml` file, I was able to write `GITHUB`
in the contribution history.

## How to run it

First, set environment variable for the script to use. Both the email and
the user need to be configured for the script to run. The environment
variables for the email and username are `COMMIT_ART_EMAIL` and
`COMMIT_ART_USERNAME`, respectively.

Then, run

```
$ ruby commitart.rb /absolute/path/to/existing/repo GITHUB
```

*Assumption: the repository you are targeting already exists.*

## Related

- [gitfiti](https://github.com/gelstudios/gitfiti) - uses python to make raw
  git calls and allows you to draw pictures such as the '1up' mushroom from
  Mario.
- [github-contributions](https://github.com/IonicaBizau/github-contributions)
  \- uses JavaScript and provides a GUI for designing the look of the
  contribution calendar to be generated.
- [git-draw](https://github.com/ben174/git-draw) - interactive chrome plugin
  that allows you to draw directly on the heat map and then export the
  script.

## License

Copyright &copy; 2013-2016 [Josh Branchaud](http://joshbranchaud.com)

Licensed under the MIT License. See LICENSE for details.
