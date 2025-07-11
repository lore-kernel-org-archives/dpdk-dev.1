Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A9BC83F1B
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Jul 2025 21:28:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7033F40156;
	Fri, 11 Jul 2025 23:28:48 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id 9F65D4013F
 for <dev@dpdk.org>; Fri, 11 Jul 2025 23:28:46 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b3507b63c6fso2866611a12.2
 for <dev@dpdk.org>; Fri, 11 Jul 2025 14:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752269326; x=1752874126; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WsDgwqysNik2FsF1TQz4kSzR2uBCzI5RNmIW4kxuurM=;
 b=fL2IkL2HrfzdANzRNt5ZopEilqplYtviDajzm1tasHAGaipi9NPKlgItbHoQoCBSrV
 OdAV6Y07s6l1X/qu5pvZ9SOPc7sr+MZEsHAJQ41XqKpaTkhLWYk+rzDNwPxhGfRqQze5
 WvmWGZBkc52/S9rNAN2mYa4qYII++zSQ++7/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752269326; x=1752874126;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WsDgwqysNik2FsF1TQz4kSzR2uBCzI5RNmIW4kxuurM=;
 b=PFwQQ1hhvMSZqOCyyhSMQyiEtgeuRgYwpmLzJIj/YtYEGIDpVPEuD1g8cFh8imQJAK
 5g4gotYWb/aWrh0JnnLikeOX2Av/lmNNpNE1w3EHyL2y2Ccn4HXljAcbnYq2s6kUIhM9
 xfyOccNGKQNZwKaHODZke3JWK7hsYj23Dj7t8Lnx8iEGcJPo7yanwM2tz5CxTVowQfQt
 8OKtEolCoQjXvhYorsujVk20iaz0XkqfdGkkhvkwLMNNkqc1ZC0T3hPxqFUWNiHhV+SD
 ak/8Fy3OBRlbhZ8BKTz+fK5NmRn3kW5DzF99xvUdJhfq/MoyD3r4LsjexSxs6nnZpsW8
 2E/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwEE9BCjri3AxbhBRPwJ4yZPSO23qTP12cm55H7V1FVzqWK4jXk4AmT57W4ZfSraaT6U8=@dpdk.org
X-Gm-Message-State: AOJu0YwpNATSJceFc7gMGbvDAmF+Rk27a+3fPrdRzACBeLifhIzmbP4I
 mmh1ZD18pYdB25mPQylVi7zuf25WDOcIBu/RxtSgL4nDO6Xs9FmCNKew8Nyh4dvxXqa30j2WT+T
 arb+gC2FZ4SavOLcuSP5OqWOk85xY43HKg8Nq3FnFAA==
X-Gm-Gg: ASbGncuaXgYTZKJIn+KseB8thvgXZC3RLesTJE5ZoB837qO7kqCIU40TDcTuJGSE0Iy
 H4j2o2Bi1HFmyucH3wXa5GhL2huPP/wCnowuIE2rttkpPMxKiVTV5+WRnT1anPt2M/vv2dfpx5Q
 IEA/GK6/fRZ9Dz5/UaayEYqAQ3lby52j7dE0ZLSgLnwAhfQfqGEy9vkCxos/PTQW2TTztw2ZsUW
 gLD+O5m4D3Du9JL978WGMgFTrqORRMORLoeCjJO
X-Google-Smtp-Source: AGHT+IGk9RtEvJtd5CdqrpuMY+s5DhXWLNhW8lTpRGUrQg3JtT2prAqgKRGRD3gAVpkmoA3aaee+CldCz0f8pZh4szY=
X-Received: by 2002:a17:90a:d610:b0:313:28f1:fc33 with SMTP id
 98e67ed59e1d1-31c4f4ca85emr6222195a91.10.1752269325548; Fri, 11 Jul 2025
 14:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250603172827.458725-1-dmarx@iol.unh.edu>
 <20250711172534.540416-1-dmarx@iol.unh.edu>
In-Reply-To: <20250711172534.540416-1-dmarx@iol.unh.edu>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 11 Jul 2025 17:22:59 -0400
X-Gm-Features: Ac12FXzu4d6pbud7q1X3pJxLK_qR9OlEk4fhEnQwJhWYSlYOZxw3dSIZZIgxvDI
Message-ID: <CAJvnSUC_R_Yeoqis1cLaQJbwxyuTANYrNVpe9F=3dt29d+Wi-Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dts: rewrite README
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b359930639adfe2d"
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

--000000000000b359930639adfe2d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:25=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote=
:

> Remove unnecessary information from README.md,
>

I would call the dropped information "extraneous".


> and add new sections to clarify the purpose/use
> of DTS along with clear setup instructions.
>

Maybe say that the goal of the commit is refactoring the README to be a
document which contains only a high level description of the relevant
concepts in DTS and a simple getting started guide.


>
> +
> +1. 2 links topology: Represents a topology in which the TG node and SUT
> node both have two network interfaces
> +which form the TG <-> SUT connection. An example of this would be a dual
> interface NIC which is the
> +TG node connected to a dual interface NIC which is the SUT node.
> Interface 0 on TG <-> interface 0
> +on SUT, interface 1 on TG <-> interface 1 on SUT.
> +2. 1 links topology: Works, but may result in skips for testsuites which
> are explicitly decorated with a

+2 link requirement. Represents a topology in which the TG node and SUT
> node are both located on one
> +network interface. An example of this would be a dual interface NIC with
> a connection between
> +its own ports.
>

1 links -> 1 link

And the phrasing seems slightly off. Can you reword the 1 link topology to:

"Represents a topology in which the TG node and SUT node are connected over
a single networking link. An example of this would be two single interface
NICs directly connected to each other."

or similar to this phrasing.

And, maybe make this an unordered list? the "1. 2" and "2. 1" thing looks a
touch weird. Not a big deal but probably worth doing:
https://docs.github.com/en/get-started/writing-on-github/getting-started-wi=
th-writing-and-formatting-on-github/basic-writing-and-formatting-syntax#lis=
ts

Also, I never did get a response from you about whether it would be good to
include some ascii art to depict these topologies :)

You don't have to be a fan, but it would be good to get your opinion. If
you think it's a good idea, can you add a bugzilla ticket so we can do this
during 25.11? If you're opposed I'm okay with it - ultimately the wording
should make the valid topologies clear enough to people. It's not something
we can add during RC4 in any case.


2 link topology:


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




1 link topology:


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
|                              |                 |
         |
|                              |                 |
         |

+------------------------------+
+------------------------------+



2 link topology on a single host:


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





> +
> +# Simple Linux Setup
> +
> +1. On your TG and SUT nodes, add a dedicated user. In this example I wil=
l
> name the user "dts."
>

"add a dedicated user for DTS"


> +2. Grant passwordless sudo to the dts user, like so:
> +    2a: enter 'visudo' in your terminal
> +    2b: In the visudo text editor, add:
> +        dts   ALL=3D(ALL:ALL) NOPASSWD:ALL
> +3. DTS uses ssh key auth to control the nodes. Copy your ssh keys to the
> TG and SUT:
> +    ssh-copy-id dts@{your host}.
> +
> +For additional detail, please refer to
> [dts.rst](../doc/guides/tools/dts.rst)
> +
> +# DTS Configuration
> +
> +DTS requires two yaml files to be filled out with information about your
> environment,
> +test_run.yaml and nodes.yaml, which follow the format illustrated in the
> example files.
> +
> +1. Download Docker on the SUT, and Scapy on the TG.
>

It's semantics but let's say Install instead of download.


> -### Visual Studio Code
> +Usage of VScode devcontainers is NOT required for developing on DTS and
> running DTS,
> +but provide some small quality of life improvements for the developer. I=
f
> you
> +want to develop from a devcontainer, see the instructions below:
>
>  VSCode has first-class support for developing with containers.
>  You may need to run the non-Docker setup commands in the integrated
> terminal.
> @@ -76,6 +75,6 @@ will mount the SSH keys of the user currently running
> VSCode into the container
>  The `source` on this line can be altered to mount any SSH keys
>  on the local machine into the container at the correct location.
>
> -### Other
> +## Other


> -Searching for '$IDE dev containers' will probably lead you in the right
> direction.
> +Searching for '$IDE dev containers' will probably lead you in the right
> direction.
>

I would just drop this whole "Other" section with the comment about
searching for dev containers - it's not needed.

> \ No newline at end of file
> --
> 2.49.0
>
>

--000000000000b359930639adfe2d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><div dir=3D"ltr"><div dir=3D"lt=
r"><br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail=
_attr">On Fri, Jul 11, 2025 at 1:25=E2=80=AFPM Dean Marx &lt;<a href=3D"mai=
lto:dmarx@iol.unh.edu" target=3D"_blank">dmarx@iol.unh.edu</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Remove unnecessar=
y information from README.md,<br></blockquote><div><br></div><div>I would c=
all the dropped information &quot;extraneous&quot;.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">
and add new sections to clarify the purpose/use<br>
of DTS along with clear setup instructions.<br></blockquote><div><br></div>=
<div>Maybe say that the goal of the commit is refactoring the README to be =
a document which contains only a high level description of the=C2=A0relevan=
t concepts in DTS and a simple getting started guide.</div><div>=C2=A0</div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
+<br>
+1. 2 links topology: Represents a topology in which the TG node and SUT no=
de both have two network interfaces<br>
+which form the TG &lt;-&gt; SUT connection. An example of this would be a =
dual interface NIC which is the<br>
+TG node connected to a dual interface NIC which is the SUT node. Interface=
 0 on TG &lt;-&gt; interface 0<br>
+on SUT, interface 1 on TG &lt;-&gt; interface 1 on SUT.<br>
+2. 1 links topology: Works, but may result in skips for testsuites which a=
re explicitly decorated with a</blockquote><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">
+2 link requirement. Represents a topology in which the TG node and SUT nod=
e are both located on one<br>
+network interface. An example of this would be a dual interface NIC with a=
 connection between<br>
+its own ports.<br></blockquote><div><br></div><div>1 links -&gt; 1 link</d=
iv><div><br></div><div><div>And the phrasing seems slightly off. Can you re=
word the 1 link topology to:<br><br>&quot;Represents a topology in which th=
e TG node and SUT node are connected over a single networking link. An exam=
ple of this would be two single interface NICs directly connected to each o=
ther.&quot;</div><div><br></div><div>or similar to this phrasing.</div><div=
><br></div><div>And, maybe make this an unordered list? the &quot;1. 2&quot=
; and &quot;2. 1&quot; thing looks a touch weird. Not a big deal but probab=
ly worth doing:=C2=A0<a href=3D"https://docs.github.com/en/get-started/writ=
ing-on-github/getting-started-with-writing-and-formatting-on-github/basic-w=
riting-and-formatting-syntax#lists">https://docs.github.com/en/get-started/=
writing-on-github/getting-started-with-writing-and-formatting-on-github/bas=
ic-writing-and-formatting-syntax#lists</a></div></div><div><br></div><div>A=
lso, I never did get a response from you about whether it would be good to =
include some ascii art to depict these topologies :)</div><div><br></div><d=
iv>You don&#39;t have to be a fan, but it would be good to get your opinion=
. If you think it&#39;s a good idea, can you add a bugzilla ticket so we ca=
n do this during 25.11? If you&#39;re opposed I&#39;m okay with it - ultima=
tely the wording should make the valid topologies clear enough to people. I=
t&#39;s not something we can add during RC4 in any case.</div><div><br></di=
v><div><br></div><div>2 link topology:</div><div><div><pre style=3D"margin-=
top:0px;margin-bottom:0px;padding:0px;overflow:hidden;line-height:1.2em;col=
or:rgb(0,0,0)"><br class=3D"gmail-Apple-interchange-newline">+-------------=
-----------------+                 +------------------------------+        =
             =20
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
-----+             </pre><pre style=3D"margin-top:0px;margin-bottom:0px;pad=
ding:0px;overflow:hidden;line-height:1.2em;color:rgb(0,0,0)"><br></pre><pre=
 style=3D"margin-top:0px;margin-bottom:0px;padding:0px;overflow:hidden;line=
-height:1.2em;color:rgb(0,0,0)"><br></pre><pre style=3D"margin-top:0px;marg=
in-bottom:0px;padding:0px;overflow:hidden;line-height:1.2em;color:rgb(0,0,0=
)">   </pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;over=
flow:hidden;line-height:1.2em;color:rgb(0,0,0)"><br></pre><pre style=3D"mar=
gin-top:0px;margin-bottom:0px;padding:0px;overflow:hidden;line-height:1.2em=
;color:rgb(0,0,0)">1 link topology: </pre><pre style=3D"margin-top:0px;marg=
in-bottom:0px;padding:0px;overflow:hidden;line-height:1.2em;color:rgb(0,0,0=
)"><br></pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;ove=
rflow:hidden;line-height:1.2em;color:rgb(0,0,0)">+-------------------------=
-----+                 +------------------------------+                    =
 =20
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
|                              |                 |                         =
     |                     =20
|                              |                 |                         =
     |                     =20
</pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;overflow:h=
idden;line-height:1.2em;color:rgb(0,0,0)">+-----------------------------<sp=
an style=3D"font-family:Arial,Helvetica,sans-serif">-+                     =
              </span>+-----------------------------<span style=3D"font-fami=
ly:Arial,Helvetica,sans-serif">-+</span> <span style=3D"font-family:Arial,H=
elvetica,sans-serif">      </span></pre><pre style=3D"margin-top:0px;margin=
-bottom:0px;padding:0px;overflow:hidden;line-height:1.2em;color:rgb(0,0,0)"=
>                                                                          =
                            =20
                                                                           =
                           =20
<br></pre><pre style=3D"margin-top:0px;margin-bottom:0px;padding:0px;overfl=
ow:hidden;line-height:1.2em;color:rgb(0,0,0)">2 link topology on a single h=
ost:                                                                       =
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
></div><div><br></div></div><div><br></div><div>=C2=A0</div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">
+<br>
+# Simple Linux Setup<br>
+<br>
+1. On your TG and SUT nodes, add a dedicated user. In this example I will =
name the user &quot;dts.&quot;<br></blockquote><div><br></div><div>&quot;ad=
d a dedicated user for DTS&quot;</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
+2. Grant passwordless sudo to the dts user, like so:<br>
+=C2=A0 =C2=A0 2a: enter &#39;visudo&#39; in your terminal<br>
+=C2=A0 =C2=A0 2b: In the visudo text editor, add:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 dts=C2=A0 =C2=A0ALL=3D(ALL:ALL) NOPASSWD:ALL<b=
r>
+3. DTS uses ssh key auth to control the nodes. Copy your ssh keys to the T=
G and SUT:<br>
+=C2=A0 =C2=A0 ssh-copy-id dts@{your host}.<br>
+<br>
+For additional detail, please refer to [dts.rst](../doc/guides/tools/dts.r=
st)<br>
+<br>
+# DTS Configuration<br>
+<br>
+DTS requires two yaml files to be filled out with information about your e=
nvironment,<br>
+test_run.yaml and nodes.yaml, which follow the format illustrated in the e=
xample files.<br>
+<br>
+1. Download Docker on the SUT, and Scapy on the TG.<br></blockquote><div><=
br></div><div>It&#39;s semantics but let&#39;s say Install instead of downl=
oad.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
">
-### Visual Studio Code<br>
+Usage of VScode devcontainers is NOT required for developing on DTS and ru=
nning DTS,<br>
+but provide some small quality of life improvements for the developer. If =
you<br>
+want to develop from a devcontainer, see the instructions below:<br>
<br>
=C2=A0VSCode has first-class support for developing with containers.<br>
=C2=A0You may need to run the non-Docker setup commands in the integrated t=
erminal.<br>
@@ -76,6 +75,6 @@ will mount the SSH keys of the user currently running VSC=
ode into the container<br>
=C2=A0The `source` on this line can be altered to mount any SSH keys<br>
=C2=A0on the local machine into the container at the correct location.<br>
<br>
-### Other<br>
+## Other</blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
-Searching for &#39;$IDE dev containers&#39; will probably lead you in the =
right direction.<br>
+Searching for &#39;$IDE dev containers&#39; will probably lead you in the =
right direction.<br></blockquote><div><br></div><div>I would just drop this=
 whole &quot;Other&quot; section with the comment about searching for dev c=
ontainers - it&#39;s not needed.=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
\ No newline at end of file<br>
-- <br>
2.49.0<br>
<br>
</blockquote></div></div>
</div>

--000000000000b359930639adfe2d--
