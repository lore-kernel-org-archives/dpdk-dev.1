Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82037C5AD49
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 20:45:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D00CA402B6;
	Wed, 28 May 2025 22:45:49 +0200 (CEST)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com
 [209.85.216.47]) by mails.dpdk.org (Postfix) with ESMTP id 56C2C40156
 for <dev@dpdk.org>; Wed, 28 May 2025 22:45:48 +0200 (CEST)
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-3115a6db4d6so125788a91.2
 for <dev@dpdk.org>; Wed, 28 May 2025 13:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748465147; x=1749069947; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YU9bmwhSMmSV8vtR18Jz6Py6UUV/UjJ9Kg2IaUgbE5E=;
 b=jsRflG0oq/hllBgt8HZcjb5WzpubCEiubGoMY0F+cyqjQmh0R2MGvL4+joHLJt36s4
 kylSASTRHCLqeCgjJrDmrLzLXt91v02IKF4BFmd2XvOmAW4VfJOpjS5uvntSg5fdXjR9
 YoF3kRZQ11M3CeQFWkwfg7KL5kZtYfEKbUKxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748465147; x=1749069947;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YU9bmwhSMmSV8vtR18Jz6Py6UUV/UjJ9Kg2IaUgbE5E=;
 b=UxAvgqa/CMoHKXV1lCVT3ADukUYQWmHEYAqkoyp4ek6O80BM4kngcffwmQcp8LAFub
 NLF/ssslLLZmMzCGoSj6mv5TnK+iDPrpopbt5ybokLkiiQCLPCeveFmDf8jau/+78RAb
 55Xa2a+8lBEq0KFyP0iTE13ystBpgTHN0w6lO29Z/L3V2JC3iAbXlN7Pf3UyKTA0s4Ex
 +hbZE2kaVGUKPI9T4RVgvB8HeMT9P5OCU9/u6wxeLyQkJR71HeCe0JVt/8MfKb+63064
 7T4EvVgtzQElwfQ5pSWGyN3tgmrSAkOFsqCVMSU1xqjRIyTCtub35YCm6L4VqTcGk57v
 zazA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWwyxr4O/zuYbqko5AinH1T7strqt6c0lzjctmgX0tYfwwQm/kU5zPyypM+eR1PxoNBso=@dpdk.org
X-Gm-Message-State: AOJu0YwK1eAu/2pSr4lL1E7JvjyzeF6ozo7LZFSMEB0BNAZ2kKQwOJmN
 eti8skP/+f3rB6GINXspR3jGo/J/euHb5S+wYntjagTjhCGccER1y/kDMm7SOOTqirwiS57sPR4
 Wg2yc97ckB/FEAf0bf+txp0uXw1Mpgk8ZImN9gch3Qg==
X-Gm-Gg: ASbGncu7SskvzuwQo/KMcO2PDVt0mZm8r8xg9Lw4HPn9U6Vm8IrXIPzguR2aRvSE8O+
 SrljTwjyfctAp/QM9tbNc4lRO4St4vXyskGcPowdCAuaG/V36Q54hlAp6Z5ph1FxMuUjAr46N50
 j9dLtp4FV9PV/I21tYbAR5OQMNqddLj/zo5I/N0wtJEPimH7nn398F5Y36a1sIs0eTTQ==
X-Google-Smtp-Source: AGHT+IGhpnA7Hdwo/Jldbq52/8z3wqFP1Da3nxBPbbmg6Wcb3KrLx4ZmddkfJpCP4go+9/8xaii2zF/Xmr5t3eg2NyI=
X-Received: by 2002:a17:90b:48c8:b0:312:db8:dbdd with SMTP id
 98e67ed59e1d1-3120db8ddc5mr2281904a91.28.1748465147165; Wed, 28 May 2025
 13:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250527153734.368235-1-dmarx@iol.unh.edu>
In-Reply-To: <20250527153734.368235-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 28 May 2025 16:40:52 -0400
X-Gm-Features: AX0GCFuzuHQ-cYMAlsCU05Qw0DiHpX9ofNIt61r8sPEsDUMvk8pJj3_oySfyUcU
Message-ID: <CAJvnSUCjgSje4Tt870WtHk4+qAxDjpoQXWOnJF6y2bVLv32X2A@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dts: rewrite README
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000ffd4bd0636384310"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000ffd4bd0636384310
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 11:37=E2=80=AFAM Dean Marx <dmarx@iol.unh.edu> wrot=
e:

> Remove unnecessary information from README.md, and add new sections to
> clarify
> the purpose/use of DTS along with clear setup instructions.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/README.md | 104 +++++++++++++++++++-------------------------------
>  1 file changed, 39 insertions(+), 65 deletions(-)
>
> diff --git a/dts/README.md b/dts/README.md
> index 2b3a7f89c5..879cf65abc 100644
> --- a/dts/README.md
> +++ b/dts/README.md
> @@ -1,81 +1,55 @@
> -# DTS Environment
> +# Description
>
> -The execution and development environments for DTS are the same,
> -a [Docker](https://docs.docker.com/) container defined by our
> [Dockerfile](./Dockerfile).
> -Using a container for the development environment helps with a few thing=
s.
> +DTS is a testing framework and set of testsuites for end to end testing
> of DPDK and DPDK
> +enabled hardware. Unlike the DPDK unit test application, DTS is intended
> to be used to


Maybe change to "unlike DPDK's dpdk-test application, which is used for
running unit tests, DTS is intended to be used to evaluate real DPDK
workloads run over supported hardware."


>
> +evaluate real DPDK workloads run over supported hardware. For instance,
> DTS will control
> +a traffic generator node which will send packets to a system under test
> node which is
> +running a DPDK application, and evaluate those results.
>
>
Change to "evaluate the resulting DPDK application behavior."


> -1. It helps enforce the boundary between the DTS environment and the
> TG/SUT,
> -   something which caused issues in the past.
> -2. It makes creating containers to run DTS inside automated tooling much
> easier, since
> -   they can be based off of a known-working environment that will be
> updated as DTS is.
> -3. It abstracts DTS from the server it is running on. This means that th=
e
> bare-metal OS
> -   can be whatever corporate policy or your personal preferences dictate=
,
> -   and DTS does not have to try to support all distros that are supporte=
d
> by DPDK CI.
> -4. It makes automated testing for DTS easier,
> -   since new dependencies can be sent in with the patches.
> -5. It fixes the issue of undocumented dependencies,
> -   where some test suites require Python libraries that are not installe=
d.
> -6. Allows everyone to use the same Python version easily,
> -   even if they are using a distribution or Windows with out-of-date
> packages.
> -7. Allows you to run the tester on Windows while developing via Docker
> for Windows.
> +# Supported Test Node Topologies
>
> -## Tips for setting up a development environment
> +DTS is a python application which will control a traffic generator node
> (TG) and system
> +under test node (SUT). The nodes represent a DPDK device (usually a NIC)
> located on a
> +host. The devices/NICs can be located on two separate servers, or on the
> same server. If you use
> +the same server for both NICs, install them on separate NUMA domains if
> possible (this is ideal
> +for performance testing.)
>
> -### Getting a docker shell
> +1. 2 link: Represents a topology in which the TG node and SUT node both
> have two network interfaces
>

2 links topology


> +which form the TG <-> SUT connection. An example of this would be a dual
> interface NIC which is the
> +TG node connected to a dual interface NIC which is the SUT node.
> Interface 0 on TG <-> interface 0
> +on SUT, interface 1 on TG <-> interface 1 on SUT.
> +2. 1 link: Works, but may result in skips for testsuites which are
> explicitly decorated with a
>

1 links topology


> +2 link requirement. Represents a topology in which the TG node and SUT
> node are both located on one
> +network interface. An example of this would be a dual interface NIC with
> a connection between
> +its own ports.
>

I wonder whether it makes sense to provide an ascii drawing of the various
topologies?

I google an online ascii art tool and got these 2 showing the 2 links
topology for 2 servers and 1 server:

+------------------------------+
+------------------------------+
|                              |                 |
         |
|                              | --------------- |
         |
|                              |                 |
         |
|  Tester (Traffic Generator)  |                 |     System Under
Test        |
|                              |                 |
         |
|                              | --------------- |
         |
|                              |                 |
         |
+------------------------------+
+------------------------------+





                       -----------------------------------
                      |                                   |
                      |     -------------------------     |
                      |    |                        |     |
                      |    |                        |     |
                      |    |                        |     |
                      |    |                        |     |
                      |    |                        |     |
                      |    |                        |     |
                      |    |                        |     |
                      |    |                        |     |
                +--------------------------------------------------+
                |                                                  |
                |                                                  |
                |                                                  |
                |                                                  |
                |          Combined Tester & SUT system            |
                |                                                  |
                |                                                  |
                               -
                |                                                  |
                |                                                  |
                +--------------------------------------------------+



If you wanted to do this you might have to use triple tilde to put it in a
code block so it renders with a monospaced font for readers.



> -These commands will give you a bash shell inside the container
> -with all the Python dependencies installed.
> -This will place you inside a Python virtual environment.
> -DTS is mounted via a volume, which is essentially a symlink from the hos=
t
> to the container.
> -This enables you to edit and run inside the container
> -and then delete the container when you are done, keeping your work.
> -It is also strongly recommended that you mount your SSH keys into the
> container
> -to allow you to connect to hosts without specifying a password.
> +# Simple linux setup
>

capitalize linux and setup


>
> -#### Start docker container with SSH keys
> +1. On your TG and SUT nodes, add a dedicated user. In this example I wil=
l
> name the user "dts."
> +2. Grant passwordless sudo to the dts user, like so:
> +    2a: enter 'visudo' in your terminal
> +    2b: In the visudo text editor, add:
> +        dts   ALL=3D(ALL:ALL) NOPASSWD:ALL
> +3. DTS uses ssh key auth to control the nodes. Copy your ssh keys to the
> TG and SUT:
> +    ssh-copy-id dts@{your host}.
>
> -```shell
> -docker build --target dev -t dpdk-dts .
> -docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it
> dpdk-dts bash
> -$ poetry install
> -$ poetry shell
> -```
> +For additional detail, please refer to [dts.rst](doc/guides/tools/dts.rs=
t)
> +
> +# DTS Configuration
>
> -#### Start docker container without SSH keys
> +DTS requires two yaml files to be filled out with information about your
> environment,
> +test_run.yaml and nodes.yaml, which follow the format illustrated in the
> example files.
>
>  ```shell
>  docker build --target dev -t dpdk-dts .
> -docker run -v $(pwd)/..:/dpdk -it dpdk-dts bash
> +docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it
> dpdk-dts bash
>

Instead of dtsuser maybe we can more explicitly say {insert your dts ssh
user}/ or similar.


>  $ poetry install
> -$ poetry shell
> +$ poetry run ./main.py
>  ```
>

This information looks good, but I think it needs to be tied together more
cohesively. I would make a step 4 like:

4. Create and fill out a test_run.yaml and nodes.yaml file within your dts
directory, based on the structure from the example config files.

And a step 5 like:

5. Run the bash terminal commands below in order to run the DTS container
and start the DTS execution.

```shell
docker build --target dev -t dpdk-dts .
docker run -v $(pwd)/..:/dpdk -v /home/{insert your dts ssh
user}/.ssh:/root/.ssh:ro -it dpdk-dts bash
$ poetry install
$ poetry run ./main.py
```


I also think we may have to call out some of the project dependencies (this
is outside of the python dependencies that poetry handles for the DTS
execution). So that would include Docker on the execution host, Scapy on
the TG host.


> -### Vim/Emacs
> -
> -Any editor in the Ubuntu repos should be easy to use,
> -with Vim and Emacs already installed.
> -You can add your normal config files as a volume,
> -enabling you to use your preferred settings.
> -
> -```shell
> -docker run -v ${HOME}/.vimrc:/root/.vimrc -v $(pwd)/..:/dpdk -it dpdk-dt=
s
> bash
> -```
>

I agree we can remove this.


> -
> -### Visual Studio Code
> -
> -VSCode has first-class support for developing with containers.
> -You may need to run the non-Docker setup commands in the integrated
> terminal.
> -DTS contains a .devcontainer config,
> -so if you open the folder in VSCode it should prompt you to use the dev
> container
> -assuming you have the plugin installed.
> -Please refer to
> -[VS Development Containers Docs](
> https://code.visualstudio.com/docs/remote/containers)
> -to set it all up.
> -Additionally, there is a line in `.devcontainer/devcontainer.json` that,
> when included,
> -will mount the SSH keys of the user currently running VSCode into the
> container for you.
> -The `source` on this line can be altered to mount any SSH keys
> -on the local machine into the container at the correct location.
> +These commands will give you a bash shell inside a docker container
> +with all DTS Python dependencies installed.
>
>
Well... I know I was saying the devcontainers aren't so useful, but upon
reflection, it's kind of nice to not have to manage the 2nd terminal for
driving the container, and of course it means python intellisense will work
without having to poetry install on your base system. I would leave this
part in, but stick a sentence in at the start saying  "usage of vscode
devcontainers is NOT required for developing on DTS and running DTS, but
provide some small quality of life improvements for the developer. If you
want to develop from a devcontainer, see the instructions here" or
somethign like that.


> -### Other
> +## Other
>
> -Searching for '$IDE dev containers' will probably lead you in the right
> direction.
> +Searching for '$IDE dev containers' will probably lead you in the right
> direction.
> \ No newline at end of file
> --
> 2.49.0
>
>
Reviewed-by: Patrick Robb <probb@iol.unh.edu>

--000000000000ffd4bd0636384310
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote"><div di=
r=3D"ltr" class=3D"gmail_attr">On Tue, May 27, 2025 at 11:37=E2=80=AFAM Dea=
n Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D"_blank">dmarx@iol=
.unh.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">Remove unnecessary information from README.md, and add new sections=
 to clarify<br>
the purpose/use of DTS along with clear setup instructions.<br>
<br>
Signed-off-by: Dean Marx &lt;<a href=3D"mailto:dmarx@iol.unh.edu" target=3D=
"_blank">dmarx@iol.unh.edu</a>&gt;<br>
---<br>
=C2=A0dts/README.md | 104 +++++++++++++++++++------------------------------=
-<br>
=C2=A01 file changed, 39 insertions(+), 65 deletions(-)<br>
<br>
diff --git a/dts/README.md b/dts/README.md<br>
index 2b3a7f89c5..879cf65abc 100644<br>
--- a/dts/README.md<br>
+++ b/dts/README.md<br>
@@ -1,81 +1,55 @@<br>
-# DTS Environment<br>
+# Description<br>
<br>
-The execution and development environments for DTS are the same,<br>
-a [Docker](<a href=3D"https://docs.docker.com/" rel=3D"noreferrer" target=
=3D"_blank">https://docs.docker.com/</a>) container defined by our [Dockerf=
ile](./Dockerfile).<br>
-Using a container for the development environment helps with a few things.=
<br>
+DTS is a testing framework and set of testsuites for end to end testing of=
 DPDK and DPDK <br>
+enabled hardware. Unlike the DPDK unit test application, DTS is intended t=
o be used to</blockquote><div><br></div><div>Maybe change to &quot;unlike D=
PDK&#39;s dpdk-test application, which is used for running unit tests, DTS =
is intended to be used to evaluate real DPDK workloads run over supported h=
ardware.&quot;</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex"> <br>
+evaluate real DPDK workloads run over supported hardware. For instance, DT=
S will control<br>
+a traffic generator node which will send packets to a system under test no=
de which is <br>
+running a DPDK application, and evaluate those results.<br>
<br></blockquote><div><br></div><div>Change to &quot;evaluate the resulting=
 DPDK application behavior.&quot;</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
-1. It helps enforce the boundary between the DTS environment and the TG/SU=
T,<br>
-=C2=A0 =C2=A0something which caused issues in the past.<br>
-2. It makes creating containers to run DTS inside automated tooling much e=
asier, since<br>
-=C2=A0 =C2=A0they can be based off of a known-working environment that wil=
l be updated as DTS is.<br>
-3. It abstracts DTS from the server it is running on. This means that the =
bare-metal OS<br>
-=C2=A0 =C2=A0can be whatever corporate policy or your personal preferences=
 dictate,<br>
-=C2=A0 =C2=A0and DTS does not have to try to support all distros that are =
supported by DPDK CI.<br>
-4. It makes automated testing for DTS easier,<br>
-=C2=A0 =C2=A0since new dependencies can be sent in with the patches.<br>
-5. It fixes the issue of undocumented dependencies,<br>
-=C2=A0 =C2=A0where some test suites require Python libraries that are not =
installed.<br>
-6. Allows everyone to use the same Python version easily,<br>
-=C2=A0 =C2=A0even if they are using a distribution or Windows with out-of-=
date packages.<br>
-7. Allows you to run the tester on Windows while developing via Docker for=
 Windows.<br>
+# Supported Test Node Topologies<br>
<br>
-## Tips for setting up a development environment<br>
+DTS is a python application which will control a traffic generator node (T=
G) and system <br>
+under test node (SUT). The nodes represent a DPDK device (usually a NIC) l=
ocated on a <br>
+host. The devices/NICs can be located on two separate servers, or on the s=
ame server. If you use<br>
+the same server for both NICs, install them on separate NUMA domains if po=
ssible (this is ideal<br>
+for performance testing.)<br>
<br>
-### Getting a docker shell<br>
+1. 2 link: Represents a topology in which the TG node and SUT node both ha=
ve two network interfaces<br></blockquote><div><br></div><div>2 links topol=
ogy</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>
+which form the TG &lt;-&gt; SUT connection. An example of this would be a =
dual interface NIC which is the<br>
+TG node connected to a dual interface NIC which is the SUT node. Interface=
 0 on TG &lt;-&gt; interface 0 <br>
+on SUT, interface 1 on TG &lt;-&gt; interface 1 on SUT.<br>
+2. 1 link: Works, but may result in skips for testsuites which are explici=
tly decorated with a<br></blockquote><div><br></div><div>1 links topology</=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+2 link requirement. Represents a topology in which the TG node and SUT nod=
e are both located on one<br>
+network interface. An example of this would be a dual interface NIC with a=
 connection between<br>
+its own ports.<br></blockquote><div><br></div><div>I wonder whether it mak=
es sense to provide an ascii drawing of the various topologies?</div><div><=
br></div><div>I google an online ascii art tool and got these 2 showing the=
 2 links topology for 2 servers and 1 server:=C2=A0</div><div><br></div><di=
v><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;overflow:hidde=
n;line-height:1.2em;color:rgb(0,0,0)">+------------------------------+     =
            +------------------------------+                     =20
|                              |                 |                         =
     |                     =20
|                              | --------------- |                         =
     |                     =20
|                              |                 |                         =
     |                     =20
|  Tester (Traffic Generator)  |                 |     System Under Test   =
     |                     =20
|                              |                 |                         =
     |                     =20
|                              | --------------- |                         =
     |                     =20
|                              |                 |                         =
     |                     =20
+------------------------------+                 +-------------------------=
-----+                     =20
                                                                           =
                           =20
                                                                           =
                           =20
                                                                           =
                           =20
                                                                           =
                           =20
                                                                           =
                           =20
                       -----------------------------------                 =
                           =20
                      |                                   |                =
                           =20
                      |     -------------------------     |                =
                           =20
                      |    |                        |     |                =
                           =20
                      |    |                        |     |                =
                           =20
                      |    |                        |     |                =
                           =20
                      |    |                        |     |                =
                           =20
                      |    |                        |     |                =
                           =20
                      |    |                        |     |                =
                           =20
                      |    |                        |     |                =
                           =20
                      |    |                        |     |                =
                           =20
                +--------------------------------------------------+       =
                           =20
                |                                                  |       =
                           =20
                |                                                  |       =
                           =20
                |                                                  |       =
                           =20
                |                                                  |       =
                           =20
                |          Combined Tester &amp; SUT system            |   =
                               =20
                |                                                  |       =
                           =20
                |                                                  |       =
                           -
                |                                                  |       =
                           =20
                |                                                  |       =
                           =20
                +--------------------------------------------------+  </pre=
></div><div><br></div><div><br></div><div>If you wanted to do this you migh=
t have to use triple tilde to put it in a code block so it renders with a m=
onospaced font for readers.</div><div><br></div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">
<br>
-These commands will give you a bash shell inside the container<br>
-with all the Python dependencies installed.<br>
-This will place you inside a Python virtual environment.<br>
-DTS is mounted via a volume, which is essentially a symlink from the host =
to the container.<br>
-This enables you to edit and run inside the container<br>
-and then delete the container when you are done, keeping your work.<br>
-It is also strongly recommended that you mount your SSH keys into the cont=
ainer<br>
-to allow you to connect to hosts without specifying a password.<br>
+# Simple linux setup<br></blockquote><div><br></div><div>capitalize linux =
and setup</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"=
margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-lef=
t:1ex">
<br>
-#### Start docker container with SSH keys<br>
+1. On your TG and SUT nodes, add a dedicated user. In this example I will =
name the user &quot;dts.&quot;<br>
+2. Grant passwordless sudo to the dts user, like so:<br>
+=C2=A0 =C2=A0 2a: enter &#39;visudo&#39; in your terminal<br>
+=C2=A0 =C2=A0 2b: In the visudo text editor, add:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dts=C2=A0 =C2=A0ALL=3D(ALL:ALL) NOPASSWD:ALL<b=
r>
+3. DTS uses ssh key auth to control the nodes. Copy your ssh keys to the T=
G and SUT:<br>
+=C2=A0 =C2=A0 ssh-copy-id dts@{your host}.<br>
<br>
-```shell<br>
-docker build --target dev -t dpdk-dts .<br>
-docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it dpdk=
-dts bash<br>
-$ poetry install<br>
-$ poetry shell<br>
-```<br>
+For additional detail, please refer to [dts.rst](doc/guides/tools/dts.rst)=
<br>
+<br>
+# DTS Configuration<br>
<br>
-#### Start docker container without SSH keys<br>
+DTS requires two yaml files to be filled out with information about your e=
nvironment,<br>
+test_run.yaml and nodes.yaml, which follow the format illustrated in the e=
xample files.<br>
<br>
=C2=A0```shell<br>
=C2=A0docker build --target dev -t dpdk-dts .<br>
-docker run -v $(pwd)/..:/dpdk -it dpdk-dts bash<br>
+docker run -v $(pwd)/..:/dpdk -v /home/dtsuser/.ssh:/root/.ssh:ro -it dpdk=
-dts bash<br></blockquote><div><br></div><div>Instead of dtsuser maybe we c=
an more explicitly=C2=A0say {insert your dts ssh user}/ or similar.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0$ poetry install<br>
-$ poetry shell<br>
+$ poetry run ./main.py<br>
=C2=A0```<br></blockquote><div><br></div><div>This information looks good, =
but I think it needs to be tied together more cohesively. I would make a st=
ep 4 like:=C2=A0</div><div><br></div><div>4. Create and fill out a test_run=
.yaml and nodes.yaml file within your dts directory, based on the structure=
 from the example config files.</div><div><br></div><div>And a step 5 like:=
</div><div><br></div><div>5. Run the bash terminal commands below in order =
to run the DTS container and start the DTS execution.</div><div>=C2=A0</div=
><div>```shell<br>docker build --target dev -t dpdk-dts .<br>docker run -v =
$(pwd)/..:/dpdk -v /home/{insert your dts ssh user}/.ssh:/root/.ssh:ro -it =
dpdk-dts bash<br>$ poetry install<br>$ poetry run ./main.py<br>```</div><di=
v><br></div><div><br></div><div>I also think we may have to call out some o=
f the project dependencies (this is outside of the python dependencies that=
 poetry handles for the DTS execution). So that would include Docker on the=
 execution host, Scapy on the TG host.</div><div><br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">
<br>
-### Vim/Emacs<br>
-<br>
-Any editor in the Ubuntu repos should be easy to use,<br>
-with Vim and Emacs already installed.<br>
-You can add your normal config files as a volume,<br>
-enabling you to use your preferred settings.<br>
-<br>
-```shell<br>
-docker run -v ${HOME}/.vimrc:/root/.vimrc -v $(pwd)/..:/dpdk -it dpdk-dts =
bash<br>
-```<br></blockquote><div><br></div><div>I agree we can remove this.</div><=
div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0=
px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-<br>
-### Visual Studio Code<br>
-<br>
-VSCode has first-class support for developing with containers.<br>
-You may need to run the non-Docker setup commands in the integrated termin=
al.<br>
-DTS contains a .devcontainer config,<br>
-so if you open the folder in VSCode it should prompt you to use the dev co=
ntainer<br>
-assuming you have the plugin installed.<br>
-Please refer to<br>
-[VS Development Containers Docs](<a href=3D"https://code.visualstudio.com/=
docs/remote/containers" rel=3D"noreferrer" target=3D"_blank">https://code.v=
isualstudio.com/docs/remote/containers</a>)<br>
-to set it all up.<br>
-Additionally, there is a line in `.devcontainer/devcontainer.json` that, w=
hen included,<br>
-will mount the SSH keys of the user currently running VSCode into the cont=
ainer for you.<br>
-The `source` on this line can be altered to mount any SSH keys<br>
-on the local machine into the container at the correct location.<br>
+These commands will give you a bash shell inside a docker container<br>
+with all DTS Python dependencies installed.<br>
<br></blockquote><div><br></div><div>Well... I know I was saying the devcon=
tainers=C2=A0aren&#39;t so useful, but upon reflection, it&#39;s kind of ni=
ce to not have to manage the 2nd terminal for driving the container, and of=
 course it means python intellisense will work without having to poetry ins=
tall on your base system. I would leave this part in, but stick a sentence =
in at the start saying=C2=A0 &quot;usage of vscode devcontainers is NOT req=
uired for developing on DTS and running DTS, but provide some small quality=
 of life improvements for the developer. If you want to develop from a devc=
ontainer, see the instructions here&quot; or somethign=C2=A0like that.</div=
><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
-### Other<br>
+## Other<br>
<br>
-Searching for &#39;$IDE dev containers&#39; will probably lead you in the =
right direction.<br>
+Searching for &#39;$IDE dev containers&#39; will probably lead you in the =
right direction.<br>
\ No newline at end of file<br>
-- <br>
2.49.0<br>
<br></blockquote><div><br></div><div>Reviewed-by: Patrick Robb &lt;<a href=
=3D"mailto:probb@iol.unh.edu">probb@iol.unh.edu</a>&gt;=C2=A0</div></div></=
div>
</div>
</div>
</div>
</div>

--000000000000ffd4bd0636384310--
