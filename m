Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF117C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 16:06:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9ABE840648;
	Tue, 12 Aug 2025 18:06:22 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id BA97940270
 for <dev@dpdk.org>; Tue, 12 Aug 2025 18:06:21 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-76c18568e5eso6335179b3a.1
 for <dev@dpdk.org>; Tue, 12 Aug 2025 09:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755014780; x=1755619580; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=9kawyV+b4uZ0D+wWO10Wgqa4uqzieLD1md67Ix1ACig=;
 b=ROokCsZjH66f6HoID6KyYo1ezaSEUZOsUatUQEERu7cri8b1mBA8kiDr38Nbht5YUq
 K8p+HPDa8c/oyMaJVkX3dnAMwJooeMDd3PUG7PCJwtHt+RyEXsDmKQmXSFT3CKtpeC7u
 io+Hqwe+T5PpQ3+eAl9a7EdU6sShnT3u0zfnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755014780; x=1755619580;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9kawyV+b4uZ0D+wWO10Wgqa4uqzieLD1md67Ix1ACig=;
 b=KQiVgbqxrQcGbHbCiG8AIw+EysMUC9vMbc6Q11TPla9KWWKo1yXtOZFLKos2W3Cux7
 I0uhh9vScsyNVxUGowHf13rNQQPQeXGLuyIQxMLq/GG6KCdM+JoE4jUdFFTeYmLFPU1a
 0VDy7McddJcR0dtjHiofigiPuQhkaCNAfwPo7nq4nc8G8XVQ5jpjXM7rslTEGoglaUgk
 W/Z7jQqwO0Ya501xUjCv+Cu4a69wopgeYYd0gJZBvBLsg3PP47XFiLAQFvilYMF6/9Fq
 OpKp7ANJOWGzHCEwW7DCtt91v7qOrcaOkKorucgsPjV8wbqtUNTCFf3pxR6Ntw8E4739
 2qSQ==
X-Gm-Message-State: AOJu0Yzc+/MKJBTmVXXDOU1MfgauwjQM7mf+O/X3cD22KFoh4ngkeiPY
 gouBcAtW8bfeKsBQGaoff7C+1QpmpyxCOHQABI0Skr0HeEWMp+1tJ61TmH+pWZVASZzc93mcTYB
 5YRn8S+l4UmeLgRFFCEcAkZaw1XMeen02LgJ6XaiydoXTQifo7ROvUYE=
X-Gm-Gg: ASbGncusGEqWmCsfCPJQo5D8fpi1GXdK+bPLMEyRIA0BzdiuoVZHwppwuemaxdQCrN8
 NkXEqxzLHw6c+4GoId9mJCkanqZ65Z+9AUfTSCnaNe649GeX39lz+iWzx5nA3ZxzF5dZ27E3Esj
 lQ/bQJa3PEbTA+kmxhEgVDlCBi0VLNHtbZNmBbCHjajZioFtcbOm70ZHZ3dC9AByNvqIgirqw6b
 wc1EJgww6bBkN6lzdPNlA==
X-Google-Smtp-Source: AGHT+IGCckUNuS1LQw/tZyB3VEpdWaP03RBVLObA9W1ZVWMqpK8/oDaBkhF56tKCxk3BQQFOIYyKqu7xk0VxNv5c2B8=
X-Received: by 2002:a17:903:2b03:b0:240:a889:554d with SMTP id
 d9443c01a7336-2430c102eefmr3193665ad.45.1755014780325; Tue, 12 Aug 2025
 09:06:20 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 12 Aug 2025 11:59:59 -0400
X-Gm-Features: Ac12FXwz0NmTM6W8wEecT_a1EaTS_5YYAzVtTzt2RbkmC7LpdgBYA7TrJtxOcng
Message-ID: <CAJvnSUBb_qSa0XetRw_C9cpPJZ+1DqWBOrvXHCZy=b4Mcxx0Gg@mail.gmail.com>
Subject: DTS WG Meeting Minutes - July 31, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org, Dean Marx <dmarx@iol.unh.edu>, 
 Paul Szczepanek <Paul.Szczepanek@arm.com>,
 Luca Vizzarro <Luca.Vizzarro@arm.com>, 
 Andrew Bailey <abailey@iol.unh.edu>, Thomas Wilks <thomas.wilks@arm.com>
Content-Type: multipart/alternative; boundary="0000000000008eacf8063c2d385b"
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

--0000000000008eacf8063c2d385b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

####################################################################
July 31, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Paul Szczepanek
* Andrew Bailey

####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* RFC deadline for 25.11 development is August 31.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* RSS:
   * Updated and rebased. Ivan=E2=80=99s comments have been addressed.
   * Patrick Robband Andrew Baileyto review this and test it on lab devices
(must include mellanox)
* dts: add file management
   * Patrick Robbto review
   * Provides abstraction which defines a file on TG, SUT, or DTS engine
system
* There are some stylistic differences between how testsuite docstrings are
written
   * Currently, the only =E2=80=9Crule=E2=80=9D is that testsuite developer=
s write =E2=80=9Csteps=E2=80=9D
and =E2=80=9Cverify=E2=80=9D section
      * Steps and Verify should also have an empty line included between
them
   * Otherwise, there are various discrepancies (example, ordered vs
unordered list for providing =E2=80=9Csteps=E2=80=9D) and we need to provid=
e more
comprehensive rules to bring the testsuite docstrings in alignment
   * Also some missing =E2=80=9CAttributes=E2=80=9D or =E2=80=9CReturns=E2=
=80=9D sections for various class
and method docstrings
   * There is major duplication between module, class, and method
docstrings in each testsuite.
      * Module docstring should be a few sentences briefly identifying the
testsuite and the DPDK functionality validated in the testsuite
      * Testsuite class can just be a stock phrase to satisfy the linter,
like =E2=80=9Ctestsuite class=E2=80=9D
      * Testcase docstrings contain the actual details
* Thomas Wilks is looking through testsuites and looking for problems with
code style. We should provide a code style guide going forward.
   * Example: Some functions which return None have no typehinted return,
when technically they should return None like =E2=80=9C -> None =E2=80=9C
* Testcase naming convention
   * The old requirement of prefixing testcases with =E2=80=9Ctest_=E2=80=
=9D is still
present in some testcases. Although it=E2=80=99s not a =E2=80=9Cproblem=E2=
=80=9D for testcases to
be named in this way, we should stop doing this going forward and do a 1
time re-naming of all the existing testcases that are named in this way.
* Docs builds:
   * We have some private methods which are not actually made private (they
are not prefixed with an underscore), so these methods are showing up in
the testsuite docs unnecessarily.
* Patrick Robb and luca.vizzarro@arm.comreviewed change requested patches
   * Confirmed all of those patches are tracked
   * It may be better to not use the change requested status at all. Just
provide comments on series, and let the submitter change the series to
=E2=80=9Csuperseded=E2=80=9D when they send a new version.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* Reviewed bugzilla tickets:
   *
https://bugs.dpdk.org/buglist.cgi?quicksearch=3Dcomponent%3Adts&list_id=3D9=
444

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Andrew at UNH is looking at TG driver binding, which was previously
removed from DTS.
* Intel CI Docs build had a failure for some DTS docs on a patch applied to
next-dts
   * Need to remove the autodoc pydantic dependency from the standard docs
build, which Luca is going to do
* Next meeting is Aug 14, 2025

--0000000000008eacf8063c2d385b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
##########<br>July 31, 2025<br>Attendees<br>* Patrick Robb<br>* Luca Vizzar=
ro<br>* Paul Szczepanek<br>* Andrew Bailey<br><br>#########################=
###########################################<br>Minutes<br><br>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<br>* RF=
C deadline for 25.11 development is August 31.<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Patch discussions<br>* RSS:<br>=C2=
=A0 =C2=A0* Updated and rebased. Ivan=E2=80=99s comments have been addresse=
d.<br>=C2=A0 =C2=A0* Patrick Robband Andrew Baileyto review this and test i=
t on lab devices (must include mellanox)<br>* dts: add file management<br>=
=C2=A0 =C2=A0* Patrick Robbto review<br>=C2=A0 =C2=A0* Provides abstraction=
 which defines a file on TG, SUT, or DTS engine system<br>* There are some =
stylistic differences between how testsuite docstrings are written<br>=C2=
=A0 =C2=A0* Currently, the only =E2=80=9Crule=E2=80=9D is that testsuite de=
velopers write =E2=80=9Csteps=E2=80=9D and =E2=80=9Cverify=E2=80=9D section=
<br>=C2=A0 =C2=A0 =C2=A0 * Steps and Verify should also have an empty line =
included between them<br>=C2=A0 =C2=A0* Otherwise, there are various discre=
pancies (example, ordered vs unordered list for providing =E2=80=9Csteps=E2=
=80=9D) and we need to provide more comprehensive rules to bring the testsu=
ite docstrings in alignment<br>=C2=A0 =C2=A0* Also some missing =E2=80=9CAt=
tributes=E2=80=9D or =E2=80=9CReturns=E2=80=9D sections for various class a=
nd method docstrings<br>=C2=A0 =C2=A0* There is major duplication between m=
odule, class, and method docstrings in each testsuite.<br>=C2=A0 =C2=A0 =C2=
=A0 * Module docstring should be a few sentences briefly identifying the te=
stsuite and the DPDK functionality validated in the testsuite<br>=C2=A0 =C2=
=A0 =C2=A0 * Testsuite class can just be a stock phrase to satisfy the lint=
er, like =E2=80=9Ctestsuite class=E2=80=9D<br>=C2=A0 =C2=A0 =C2=A0 * Testca=
se docstrings contain the actual details<br>* Thomas Wilks is looking throu=
gh testsuites and looking for problems with code style. We should provide a=
 code style guide going forward.<br>=C2=A0 =C2=A0* Example: Some functions =
which return None have no typehinted return, when technically they should r=
eturn None like =E2=80=9C -&gt; None =E2=80=9C<br>* Testcase naming convent=
ion<br>=C2=A0 =C2=A0* The old requirement of prefixing testcases with =E2=
=80=9Ctest_=E2=80=9D is still present in some testcases. Although it=E2=80=
=99s not a =E2=80=9Cproblem=E2=80=9D for testcases to be named in this way,=
 we should stop doing this going forward and do a 1 time re-naming of all t=
he existing testcases that are named in this way.<br>* Docs builds:<br>=C2=
=A0 =C2=A0* We have some private methods which are not actually made privat=
e (they are not prefixed with an underscore), so these methods are showing =
up in the testsuite docs unnecessarily.<br>* Patrick Robb and luca.vizzarro=
@arm.comreviewed change requested patches<br>=C2=A0 =C2=A0* Confirmed all o=
f those patches are tracked<br>=C2=A0 =C2=A0* It may be better to not use t=
he change requested status at all. Just provide comments on series, and let=
 the submitter change the series to =E2=80=9Csuperseded=E2=80=9D when they =
send a new version.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>Bugzilla discussions<br>* Reviewed bugzilla tickets:<br>=C2=A0=
 =C2=A0* <a href=3D"https://bugs.dpdk.org/buglist.cgi?quicksearch=3Dcompone=
nt%3Adts&amp;list_id=3D9444">https://bugs.dpdk.org/buglist.cgi?quicksearch=
=3Dcomponent%3Adts&amp;list_id=3D9444</a><br><br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Andrew at UNH =
is looking at TG driver binding, which was previously removed from DTS. <br=
>* Intel CI Docs build had a failure for some DTS docs on a patch applied t=
o next-dts<br>=C2=A0 =C2=A0* Need to remove the autodoc pydantic dependency=
 from the standard docs build, which Luca is going to do<br>* Next meeting =
is Aug 14, 2025</div>

--0000000000008eacf8063c2d385b--
