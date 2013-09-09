# Lab 0: Haskell, Prolog and Git setup

These instructions assume that you are using Windows, but should work fine on Mac or Linux. All errors and omissions are mine. Feel free to share your improvements to these instructions (pull requests are welcome).

## Haskell setup

[Haskell](http://www.haskell.org/platform/) is a functional programming language. Download it!

## Prolog setup

[Prolog](http://www.swi-prolog.org/download/stable) is a logic programming language. Download it!

## Git setup

Git is a popular distributed version control system that we will use in this course. Git tracks changes (commits) to a project (repository) over time and decouples recording changes from publishing (pushing) changes. This means that you can record work on a project and then decide later when to publish your work, unlike predecessor version control systems such as CVS and Subversion.

In this lab, you will download, install and configure Git so that you can commit (record changes) and push (submit changes) privately to your choice of project host (Bitbucket or Github), and practice Git basics. While the professor's Git repository is publicly available, you will make your Git repository private on the project host but share it with me. Therefore, anything you submit to project host for this repository will be visible only to you and me, but nobody else.

# Download, install and configure git

First, [download and install Git from here](http://git-scm.com). With one exception, the default settings in the installer are fine, so click *Next*, *Continue*, or *Finish* to move along. When it is an option, be sure to select **Run Git and included Unix tools from the Windows Command Prompt**. This will allow you to use Git outside Git Bash if you wish to do so.

Also, [download and install TortoiseGit](http://code.google.com/p/tortoisegit/). The default settings in that installer are fine, so click to move the installer along. TortoiseGit allows you to commit and push your work directly to the project host from the Windows File Explorer, and also includes a nice diff viewer and merge tool. Similar tools for Mac/Linux include [GitX](http://gitx.frim.nl/), [KDiff3](http://kdiff3.sourceforge.net/), and [Meld](http://meldmerge.org/).

Once Git is installed, you will need to open the command prompt and keep it open for the duration of this lab. From the Start Menu, open Git Bash: **Start -> All Programs -> Git -> Git Bash**. In Mac/Linux, open **Terminal**. You will see a window with text inside; this is the command prompt. When you open the command prompt, you will see something like this:

	lawrancej@WITR9EZ83Y ~
	$

Let's understand what this means. The first line lists your username, machine name, and current folder (`~` pronounced tilde, means home directory). By default, the command prompt is open in your home directory. The next line is the command prompt; anything you type will appear after the `$`. You can see your home directory in the Windows File Explorer by navigating to the Desktop and clicking on your name, or you can type in the following and press enter to bring up the File Explorer:

	start .

You can also see what's in your folder at the command prompt by typing in the following:

	ls

Sometimes in this lab, I will present a command with a comment. In the command prompt, everything after a `#` on a line is a comment, like how `//` works in C++ and Java.

Git doesn't know you (and don't worry if you don't know Git just yet), so introduce yourself to Git. In the command prompt, tell Git who you are (use your name and school email address). Type in something like the following (replace my name and email with yours).

	git config --global user.name "Joey Lawrance"    # Use your name
	git config --global user.email lawrancej@wit.edu # Use your email

You will need to set up SSH keys now so you can easily submit your work to the project host that you will soon choose. SSH keys allow you to authenticate and send changes securely to a project host without the trouble of Git asking you to enter a password all the time. Type in the following command to generate SSH public/private keys.

	ssh-keygen -t rsa

The SSH key generator will ask several questions that you can ignore; just go with the defaults by pressing Enter until you're back to the command prompt.

Next, copy the public key to the clipboard using one of the commands below. Remember: the public key is what you share with others, and the private key is what you never share with anyone but the NSA. ;-)

	cat ~/.ssh/id_rsa.pub > /dev/clipboard # On Windows
	cat ~/.ssh/id_rsa.pub | pbcopy         # On Mac OS X
	cat ~/.ssh/id_rsa.pub | xclip          # On Linux

At this point, you are done downloading, installing and configuring Git. Yay!

## Set up an account on a project host

Next, choose a project host, but don't create an account just yet (read on for why). The choices are [Bitbucket](http://bitbucket.org) or [Github](http://github.com). I use both project hosts, but you can use just one. Bitbucket gives you free private repositories by default, so it's easy to set up. However, Github has a much slicker interface but requires that you [request private repositories for educational purposes as a student](http://github.com/edu), unless money is no object for you. Github's turn around time is short; however, the start of a semester is the busiest time for this, and an actual person reviews all requests from students. **You need to ensure that your repository is private, otherwise I won't post feedback to you.**

Did you choose a project host? Great! Go ahead and create an account using your *@wit.edu* email address and real name. Once you set up an account successfully, [complete this form](https://docs.google.com/forms/d/1lsSvVQVRlnIKl8qp5sSWwy-BgxyqnYGEvDzGLoQXV28/viewform) so that I know where to look for your work. If you feel like it, you can set up a [Gravatar](http://en.gravatar.com/) with your *@wit.edu* email address so that everyone can associate your user name with your face.

You will need to share the public SSH key you created earlier with the project host. If you haven't copy/pasted anything since you put your public key in the clipboard, you should be good to go. [Github users go here](https://github.com/settings/ssh); Bitbucket users: navigate to your user (in the upper right corner) -> Manage account -> SSH keys. The interface for Bitbucket and Github are pretty much the same at this point. Click Add key, and then paste in your public SSH key into the key field. For the title, use a nickname for your machine (e.g., laptop). In case you are unsure what a public key looks like, here's one of mine, although using my public key won't work for you.

	ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAtEON8Q8KF98Nkn/hbW4Z2GrvB2qgMf/
	rubgSmjiKpe8MQps86UHxYyqd+ZsHaCJrrwi7PjH0iakvxvSnNJUzoheBETKyzTJhsB
	RTdgybGmvK0rWl3/S7Da0uJTmb0OvawacS+pXjZdBUCQKcIPAQg2Ain+dmJr2LkCFHK
	WFoH7O+4dYLTsowmpAa2Le/4q0lYTYBXL6rzXJi3Us89pRnmvjPJxDJ7M2N2lx9EtaQ
	B3B/48SHaBafbTwtOMiVcn/xLYithiMPOnt+sJ/zJsBF+4MpboUXpq6h1Vjz8W0KBL6
	k0P+D6WBqil/edyIyyTVP4sJeYIrIykpKdDE9U1zWw== lawrancej@wit.edu

At this point, you have set up your account on a project host. Huzzah!

## Create your local course repository

You now need to create a Git repository on your machine to save (commit) your work and get material from me. Copy/paste the following commands into the command prompt (don't even think about typing it in manually). Speaking of which, to paste into a command prompt in Windows, press Insert on the keyboard (Ctrl-V doesn't work); if that doesn't work, right click the command prompt window title, select **Edit -> Paste**.

	git init COMP501 # Create local git repository
	cd COMP501       # Change directory (cd) into the COMP501 folder
	git remote add upstream https://github.com/lawrancej/COMP501.git
	git pull upstream master # Pull from the professor (upstream)

If you see something like the following, then everything worked fine.

	remote: Counting objects: 12, done.
	remote: Compressing objects: 100% (10/10), done.
	remote: Total 12 (delta 1), reused 0 (delta 0)
	Unpacking objects: 100% (12/12), done.

Let's understand what these commands mean before we move on. The first command (`git init`) created a local git repository into a new folder called COMP501. Git saves all project history in that folder in a hidden subdirectory called `.git`. Then, we entered the repository folder. Next, we told git about my repository at github (calling it `upstream`), but we did not yet download anything from the provided URL. The last command (`git pull`) downloaded my repository into your local repository and merged it into your master (default) branch. These four commands have almost the same effect as `git clone https://github.com/lawrancej/COMP501.git && cd COMP501`, but we didn't do that because I want your remote repository to be called `origin` and mine `upstream`. We'll get to that in a moment.

At this point, you created your local course repository. Woo hoo!

## Create your remote repository

Now let's create a remote private repository on the project host to submit your work. On [Bitbucket](https://bitbucket.org/repo/create) or [Github](https://github.com/new), create a new empty **private** repository called **COMP501**. Aside from setting the repository private, don't play around with the other settings, just go with the defaults (DO NOT initialize the repository with a README).

If you are using Github, and it asks you for money, just make the repository public for now. Don't forget to [request private repositories as a student](http://github.com/edu), and when Github confirms that you are free to do so, make the repository you created private later by clicking on the wrench and screwdriver icon (it's **Settings**, not **Account settings**) and scroll down to the **Danger Zone** and click **Make private**. 

Once created, you will see your new remote repository on the project host, and you need to study this page carefully. Go ahead and bookmark or star this page in your browser so you can get back to it later. On this page, you will see command prompt instructions, but don't type these in just yet. Bitbucket users: pretend you are starting from scratch. Github users: click on **SSH**. We only need to run one command: find the line in the instructions that says `git remote add origin ...` and copy/paste it into the command prompt and press enter. Then, type in the following at the command prompt and press enter to push the contents of your local repository to the project host.

	git push --all origin

If it asks for your password, type in your project host password and press Enter for now. Don't expect to see anything as you type it in, because nothing will appear (it's not broken, it's a security feature). Either you didn't set up SSH keys properly, or origin isn't an SSH URL. To diagnose the problem, type in `git remote -v` and examine the output. If origin is a URL starting with SSH or GIT, then SSH keys are not set up. If origin is a URL starting with HTTPS, then you need to change the origin URL in a moment; follow the next step first.

Reload your Bitbucket or Github repository page. If all goes well, you will see **Welcome to COMP501**. This indicates that you successfully cloned my repository on your machine and pushed it over to your private repository on the project host. Later on, if you ever wonder if you were able to push something over successfully, you can take a look at your repository on the project host. Those of you in the know may ask: why not just fork my repsitory instead? The answer: because Github won't allow you to fork a public repository into a private repository.

At this point, your local and remote repsitories are set up! Hooray!

**If git asked for your password earlier during a push**, and you set up SSH keys properly, type in the following to remove the link to origin:

	git remote rm origin

Then, go to your repository page and look for SSH. The URL that you want for origin will start with `git@bitbucket.org` or `git@github.com`. Copy this URL and type in the following command (replacing the comment with your SSH URL) to change your origin URL.

	git remote add origin   # Replace this comment with your SSH URL

Try to push again.

## Share your repository with me, and watch my repository

I'd like to take a peek at your repository, but I can't! Indeed, nobody but you can see it (hence the term private repository). You need to add me as a collaborator to your private repository so that I can see all the hard work that you're up to. Bitbucket users: click the gear icon (It's **Administration**), select **Access management**, enter `lawrancej` under Users, select **Admin**, and click Add. Github users: click the wrench and screwdriver icon (It's **Settings**, not **Account settings**), click **Collaborators**, enter `lawrancej`, and click Add.

Now that I can see you, why don't you watch my repository, so you know whenever I make updates? I make updates frequently, and I won't email you when I make changes. [Bitbucket users go here](https://bitbucket.org/lawrancej/comp501). [Github users go here](https://github.com/lawrancej/COMP501). The interface for watching my repository is similar for Bitbucket and Github: on my repository page, click on the eye icon to watch my repository.

Now we can see each other's stuff. Sweet!

## Practice committing and pushing work

We just need to ensure that you can commit work to wrap up this lab.

Back in the command prompt, type in the following:

	git status

Assuming you haven't messed around with your folder, you should see:

	nothing to commit, working directory clean

This means that there are no changes to the current directory as far as Git is concerned. Now let's make some changes. Type in the following command to create a new file called `test.txt` if it doesn't already exist.

	touch test.txt

Type in `git status` again. Now you will see `test.txt` listed under `Untracked files`. This means that `test.txt` is not yet in version control. Let Git track this file. Type in the following to stage it for the next commit.

	git add test.txt

Type in `git status` again. Notice that `test.txt` is now listed under `Changes to be committed`. We haven't yet recorded our change. We've only added `test.txt` to a staging area that will be part of the next commit. Don't commit just yet. Let's open up `test.txt` in a text editor. Open it up using the following command:

	start test.txt      # Windows
	open test.txt       # Mac
	gnome-open test.txt # Linux

Type in a sentence about yourself in the text editor and save it. Back in the command prompt, type in `git status` again. You will notice that `test.txt` is listed under `Changes to be committed` as well as under `Changes not staged for commit`. To see the changes not staged for commit, type in `git diff`. You will see the sentence you just typed in.

Type in the following:

	git commit -m "Added test.txt to version control."

Type in `git status` again. You will notice that the `Changes to be committed` category disappeared, because the contents of the staging area moved to the commit we just made. However, there are still changes not staged for commit. Even though we did a commit, until we stage it (add it), it won't appear as part of a commit. We could do `git add test.txt` again, but there's a shortcut. Type in the following:

	git commit -am "Added a sentence about myself."

Notice the `-am`. This adds changes to any tracked file to the commit. If we want to track an untracked file (i.e., tell Git that changes to a file are worth tracking), we still need to do `git add`.

If you look at your repository on the project host you chose, you won't see the commits there just yet. Just because you recorded a change doesn't mean it's posted online. To post your changes to your remote repository, type in the following:

	git push --all origin

This is the command you will use whenever you are ready to submit your work or work in progress.

And with that, you just completed lab 0. Booyah!

## Get course updates

By the way, I will post new material frequently. Pull (fetch and merge) to receive updates.

	git pull origin master

Occasionally, this command won't work because we made conflicting changes. To fix a merge conflict, look for conflict markers and revise as necessary. This command makes it easier:

	git mergetool

If you want to keep only my changes, checkout their version.

	git checkout --theirs some.file.goes.here

If you want to keep only your changes, checkout our version.

	git checkout --ours some.file.goes.here

If you are thoroughly confused, examine the complete history to see what's going on.

	gitk --all &

**Note:** Even though you have removed conflict markers, you must still add files to git and commit as usual to resolve the merge conflict.

## References

* [Atlassian Git Tutorials](http://www.atlassian.com/git/)
* [Pro Git](http://git-scm.com/book)
* [Git Reference](http://gitref.org/)
* [Git Immersion](http://gitimmersion.com/)
* [Try Git](http://try.github.com/)
* [Git Branching](http://pcottle.github.io/learnGitBranching/?demo)