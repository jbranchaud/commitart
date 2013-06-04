#!/usr/bin/env ruby

# commitart.rb
#
# this script will utilize the rugged rubygem to create a git history that
# spells things in the contribution graph on GitHub.

require 'rugged'

require File.dirname(__FILE__) + '/alphabet'

module CommitArt

  # MULTIPLIER - this value represents the number to multiply the letter map
  # value by which results in the number of commits to be created for that
  # slot.
  MULTIPLIER = 10

  # These values represent the email and username used for the committer and
  # author of the commits that are generated. These need to be set to the
  # email and username of the GitHub account to which you wish the commits
  # to be attributed.
  EMAIL = "commitart1337@gmail.com"
  USERNAME = "commitart"

  # create_commit_art
  #
  # given the full path of a git repository and a string of letters, this
  # function is going to access the repository and create a series of
  # commits for past dates in such a way that the resulting GitHub
  # contribution graph spells out the given string of letters.
  # Assuming the string of letters is no more than 7 letters.
  # Assuming the given repository is not important as this script will
  # clobber that repositories commit history.
  def self.create_commit_art(repo_path, letters)
    repo = Rugged::Repository.new(repo_path)
    # make sure we only working with no more than 7 letters
    chars = letters[0,7]
#    char_maps = chars.split("").map do |char|
#      Alphabet.letter_to_hash(char)
#    end
    char_strings = chars.split("").map do |char|
      Alphabet.get_chronological_letter_chars(char)
    end
    ref_date = find_oldest_sunday
    char_strings.each do |char_string|
      char_string.split("").each do |char|
        create_commits(repo,ref_date,char.to_i*MULTIPLIER)
        ref_date = add_day(ref_date)
      end
    end
  end

  # find_oldest_sunday
  #
  # based on the current date, this function will find the sunday closest to
  # 365 days ago (but on the lower bound of it). For instance, if there is a
  # Sunday 362 days ago, then it is that Time object that is returned.
  def self.find_oldest_sunday
    one_year = 365*24*60*60
    one_day = 24*60*60
    curr_day = Time.now.to_i - one_year
    year_ago = Time.at(curr_day)
    sunday = false
    while !Time.at(curr_day).sunday?
      curr_day += one_day
    end
    return Time.at(curr_day)
  end

  # add_day
  #
  # given a Time object, this function will add a day to the date and return
  # the new Time object.
  def self.add_day(date)
    one_day = 24*60*60
    next_day = date.to_i + one_day
    return Time.at(next_day)
  end

  def self.get_repo(repo_path)
    return Rugged::Repository.new(repo_path)
  end

  def self.create_commits(repo, date, count)
    # if the count is 0, then get out of here
    if count <= 0
      return
    end
    # get the stuff we need from the repo (head commit, tree, etc.)
    curr_ref = repo.head.name
    curr_commit = repo.lookup(repo.head.target)

    # create the author hash
    time = date.to_i
    count.times do |x|
      # create the author hash for this commit
      author = {:email=>EMAIL,:time=>Time.at(time),:name=>USERNAME}

      # create the commit's blob and tree
      oid = repo.write("Some content for this blob - #{Time.at(time)}.", :blob)
      index = repo.index
      index.add(:path => 'test.txt', :oid => oid, :mode => 0100644)
      curr_tree = index.write_tree(repo)

      new_commit_id = Rugged::Commit.create(repo,
                            :author => author,
                            :message => "CommitArt commit at #{Time.at(time)}.",
                            :committer => author,
                            :parents => [curr_commit.oid],
                            :tree => curr_tree,
                            :update_ref => curr_ref)
      curr_commit = repo.lookup(new_commit_id)
      time = time + 1
    end
  end

  def self.create_commit(repo, date, count)
    # create the tree for the commit
    oid = repo.write("Some test content for the repo - #{date}", :blob)
    index = repo.index
    index.add(:path => 'test.txt', :oid => oid, :mode => 0100644)
    curr_tree = index.write_tree(repo)

    curr_ref = "HEAD"
    curr_commit = repo.lookup(repo.head.target)
    # create the author commit
    author = {:email=>EMAIL,:time=>date,:name=>USERNAME}
    curr_commit = Rugged::Commit.create(repo,
                          :author => author,
                          :message => "Test Commit at #{date}.",
                          :committer => author,
                          :parents => [curr_commit.oid],
                          :tree => curr_tree,
                          :update_ref => curr_ref)
  end

end
