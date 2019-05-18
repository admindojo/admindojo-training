<div class="jumbotron">
    <h1 class="display-4 text-left">system-packages-usage-1-ub18</h1>
    <p class="lead text-left">Learn basic package operations on Debian-based distributions</p>
</div>


<h2 class="display-4">Objectives</h2>

Your client just got a new Ubuntu server. He already installed Apache2, but decided to use Nginx 1.5 instead.

He already tried to add the [nginx/development repository](https://nginx.org/en/linux_packages.html#Ubuntu) to get the Nginx version 1.5, but `apt get install nginx` didn't work.

He want you fix this and a few other things:

- install Nginx 1.5
- remove Apache2 completely, including all files that were installed
- he messed up /etc/crontab.
  - Please make a backup of this file to /etc/crontab.backup and install the original file that came with Ubuntu
- to prevent the system to ask which editor should be used, please remove `nano`

<h2 class="display-4">Notes</h2>

- The fist boot will take a few minutes to prepare

<h2 class="display-4">Walkthrough</h2>

??? lead "installing tools"

    <div class="alert alert-secondary" role="alert">

    To install packages on Debian-based distributions you'll use `dpkg`, `apt-get` and `apt`.
    Occasionally you'll stumble across `aptitude` as well - but you'll probably use `apt` most of the time.

    How packages work is also one main difference between different Linux distributions. Debian distributions uses the Debian Packages - file extension `.deb`.<br/>
    You won't find `apt` or `.deb` files on other distributions than Debian-based systems since they use a different package format.
    CentOS or Red Hat Enterprise Linux, for example, uses the RPM package format - to install these you'll use [yum](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/deployment_guide/ch-yum).

    Please see listed external resources to learn about `dpkg`, `apt-get` and `apt`.<br />


    External resources

    - [apt vs. apt-get@itsfoss.com](https://itsfoss.com/apt-vs-apt-get-difference/)
    - [manpage: dpkg](https://manpages.ubuntu.com/manpages/precise/man1/dpkg.1.html)

    </div>

??? lead "using third-party repositories"

    <div class="alert alert-secondary" role="alert">

    It is important to remember that software must be developed and maintained by people or companies and that it must come from _somewhere_.<br/><br/>
    In the case of Linux, we call the source of packages _Repositories_(short: Repo). Repositories often not only contain the finished tool, but also the source code, a bug tracker(a place to collect and manage software bugs) or wikis.<br/>
    A repository is just a URL that Ubuntu/the package manager uses as a source for the tool. The repo maintainer will always distribute the latest updates via the Repo - by checking the URL via e.g. `apt update`, you always get notified about new versions.

    The _app store_ you find on modern distributions is just a graphical user interface to interact with these repositories and are just a _friendlier_ version of `apt`.

    To make it easier to get the software, Linux distributions include a collection of repositories from the beginning. These repos often include system tools and very popular tools like the Apache webs erver.<br/><br/>
    Because all distributions have their own quirks and features, the included repositories are often maintained by the maintainer of the distribution itself. In the case of Ubuntu it's the company [Canonical](https://www.canonical.com/). They maintain their repo at [packages.ubuntu.com](https://packages.ubuntu.com/).<br/>
    Since Ubuntu only includes its own repository, it also acts as a security feature. As long as [Canonical](https://www.canonical.com/) is under the control of the repository, a freshly installed Ubuntu can only install what [Canonical](https://www.canonical.com/) is distributing.
    They will also fix bugs that are specific to the distribution - but keep in mind that they usually not the original _inventor_ of these tools. The original source is called the _upstream_.<br/>
    [Launchpad.net](https://launchpad.net/) is a service to create public repositories for everyone. To install a tool from Launchpad, you need to add the tools repository URL to your system first.

    An Example:

    The popular editor _nano_ was developed in the 90's as _pico_, [a clone was developed and called _nano_](https://www.nano-editor.org/dist/latest/faq.html#1.2).
    You'll find the source code at nano's website: [git.savannah.gnu.org/cgit/nano.git/log/](https://git.savannah.gnu.org/cgit/nano.git/log/) - but you can't just start nano from the raw text file, right?!<br/><br/>
    This is where a package repository comes in to play - but first, you need to know that Ubuntu is Debian-based and uses Debian packages as their _upstream_. So, [Canonical](https://www.canonical.com/) reuses Debian packages and may add/modify features to it. <br/>
    Debian includes nano in a [core repository](https://tracker.debian.org/pkg/nano) - some of nano's developers are also maintainer for the package in the Debian repository. They make sure it always includes the latest changes from the original upstream(nano's [own, official git repository](https://git.savannah.gnu.org/cgit/nano.git/log/)). [Canonical](https
    ://www.canonical.com/) then incorporates these changes into the [Ubuntu package](https://packages.ubuntu.com/source/bionic/nano).<br />
    This is also why some people are not happy about cooperations using their open source code. Companies like [Canonical](https://www.canonical.com/) or [RedHat](https://www.redhat.com) earn money with free, open source code - and sometimes fix bugs or add features to the code in their repository, but doesn't add them back to the _original_ upstream.
    This is a whole topic by itself and includes other important topics like software licenses and open source culture.

    This example also shows why it can have negative side effects to use repositories, but also why it's better to use them anyway:

    - in case a repository is unmaintained, you won't get updates of the software
        - especially important when using _not so popular_ tools that don't have a big and active community
    - in case the development is too fast, the repository maintainer may can't keep up and provide _outdated_ versions in the repository
        - e.g. Ubuntu Bionic only inlcudes [Nginx version 1.14](https://packages.ubuntu.com/bionic/nginx). In case you need the most recent version 1.15, you'll need to add the [repository maintained by Nginx](https://launchpad.net/~nginx/+archive/ubuntu/development)
    - when a tool is installed manually - and not through a repository - you do need to check for updates yourself and can't use _apt update_

    It's usually better to use official or community supported repositories then manually checking for updates.

    External resources

    - [ubuntu wiki/Repositories](https://help.ubuntu.com/community/Repositories/Ubuntu)
    - [ubuntu manpage/add-apt-repository](https://manpages.ubuntu.com/manpages/trusty/man1/add-apt-repository.1.html)

    </div>

??? lead "remove installed tools"

    <div class="alert alert-secondary" role="alert">

    Removing tools is very similar to installing them - you probably find all you need in the first section: _installing tools_.

    It is important to check the output while removing a tool. You'll often find information about directories or files that didn't got deleted.
    These files often hold configuration files or files that were modified by the user - the _uninstaller_ then warns you and helps you to keep these files. They must be either removed by hand or with a special option while uninstalling.

    Another note: When installing a tool, it often installs additional tools as a dependency. Sometimes the installer will also check for installed tools and add configuration files to the existing, already installed tools. To completely remove all configuration files check the output while removing and check out `apt autoremove`.<br /> <br />
    While it's not hurting the system to include unused configuration files or unused tools, a clean system is always easier to work with. Imagine troubleshooting a configuration file, you found on the system, only to find out that it's just a leftover file from 4 years ago.


    </div>

??? lead "restore configuration files"

    <div class="alert alert-secondary" role="alert">


    While some operations are almost unrecoverable, changing or deleting files that came with a tool is not.

    When installing tools via packages, the _.deb_ file contains everything necessary to install and run it. Since your Linux system usually stores the source files on the hard drive, you don't even need to download the _.deb_ file again. <br/>

    Check out the external resources to learn more about the _.deb_ file and how to recover configuration files:

    External resources

    - [.deb basics/@debian.org](https://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics.en.html)
    - [How do I get a list of installed files from a package?@askubuntu.com](https://askubuntu.com/questions/32507/how-do-i-get-a-list-of-installed-files-from-a-package)
    - [How to list files of a Debian package without install@superuser.com](https://superuser.com/questions/82923/how-to-list-files-of-a-debian-package-without-install)
    - [How can I revert a config file back to the originally installed version@askubuntu.com](https://askubuntu.com/questions/12699/how-can-i-revert-a-config-file-back-to-the-originally-installed-version-after-i)


    </div>


