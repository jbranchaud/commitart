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

First, set the `EMAIL` and `USERNAME` values in `commitart.rb` to whatever
values you want for the committer and author of the commits.

Then, run `ruby commitart.rb /absolute/path/to/existing/repo GITHUB`

Assumption: the repository you are targeting already exists.

## Related

[gitfiti](https://github.com/gelstudios/gitfiti) by
[gelstudios](https://github.com/gelstudios) is similar to what I've done,
but also much cooler.
This repository allows you to draws pictures like the '1up' mushroom from
Mario. It also uses a different approach: raw git commands invoked from a
python script.

## License

Copyright &copy; 2013-2014 [Josh Branchaud](http://joshbranchaud.com)

Licensed under the MIT License. See LICENSE for details.
