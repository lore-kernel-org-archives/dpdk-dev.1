Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B76C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:05:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D80D9402D2;
	Fri, 14 Mar 2025 00:05:10 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 67B974025A
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:05:09 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-3012a0c8496so2424471a91.2
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741907108; x=1742511908; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2hx2sVe+Q0aYrxv+gzu7Oq4f9xuj6z0x/hUUhSHFqT8=;
 b=dX9OT1+x3WBb9YmbsooczRGgaY3bn2QkgxDWEC/Eygq9ZRAvsDpBSsMNfJiJ83kkK/
 o5IMdG72qBvf/eAVcgEK3DG/0cTcRSax28MMD5znwZVP5VsQnFQo1GlNPOqWJ/xOFO51
 k4kwJqoiyZckiO8wY932E2R+d2zRydFDxtXVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741907108; x=1742511908;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2hx2sVe+Q0aYrxv+gzu7Oq4f9xuj6z0x/hUUhSHFqT8=;
 b=M4SEI2vz5squrij3wvxQK5kvvwc8W4nmp/HiwS1567UAZDrN/GLA//kSzlvvHTN/MO
 w6EEPQBrUOhXRnworph2Udz0MXlmSZkMLZvCE/8ZsnIJb3rPYSIx+ZehTelzyxXxsqQi
 I7LdsYohCTcNgBybT/vcTiuIkHsvWviwl12Ygi4R7h/FbBVdTt9paxZfHpCqNnpttWLM
 fohGziLE49tJcBmhEBUB4DR9NMNrSSLBB16xuUP78z3heZUzWn1PN/UkG8ohSrzirnPm
 gK+F886T2uEmR7I9+c9TRcKytHIB4xKAsdnyXg5lQ1yRIe7YCuXAWC6J9nQX/EXpNV9e
 inpQ==
X-Gm-Message-State: AOJu0YzlXrfyoHUm5mmAecMZCum5xwLIFxvzXHHtTLwycfvPSMpYQPQE
 pUpqrFv59qrU8dXNGK+zboM+DYa3mVw1mMfTBAKB8C198wbMSp7bY5esCIBwg8j0iVax0VrhBlY
 nHnDdDgNAmwYYQDpnwSl3Vs+LgaJcG9gZ6Jl/f7T24W6pc3yG7p/rig==
X-Gm-Gg: ASbGncuxuiRX9I1flM6g8PJuf5l82FPrhhuKvQ3/lRDhzcc3g3UrCvDDyGNcN///FhT
 FzZJfrYozlbgP0sWU2WXzQ5GH+0PZ+Gt0HCeQoTG1k1AB+k/hjoUYl+C9DwI1Jxj9t0oo3fuewP
 RBxBju36Cmv0nVQP7+01fOIWKijdbBTcRYVzLSfA8L84ddIqqSJ/TQ95Yedtc=
X-Google-Smtp-Source: AGHT+IGnBxr8pMLjiuwycrGh5zxQOccRIXdXX4q7xVK1T8VZIMa1w3YeW5IFTgznlKtUIse/Osch0jhzLZRvqArJjKs=
X-Received: by 2002:a17:90b:2690:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-30151cb59afmr335382a91.5.1741907107934; Thu, 13 Mar 2025
 16:05:07 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 19:01:25 -0400
X-Gm-Features: AQ5f1Jrtoj90o7KAMUPzXpK02HVfJTHUCLrAnYCuuxYH6K3cVGbZ3hTD9LJoo1Q
Message-ID: <CAJvnSUC1rdADyLAdFSY992WtXAyboqVKLdTi=+jvyrYx3vOc1Q@mail.gmail.com>
Subject: DTS WG Meeting Minutes - January 16, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000006688f70630415a43"
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

--0000000000006688f70630415a43
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
January 16, 2025
Attendees
* Patrick Robb
* Cody Cheng
* Ian Stokes
* Dean Marx
* Paul Szczepanek
* Luca Vizzarro
* Thomas Wilks

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* DPDK Summit will be May 8-9 in Prague:
https://www.dpdk.org/event/dpdk-summit-2025-prague/
* git apply patch fails for next-dts
   * Cody Cheng who works on UNH CI Testing can resolve this.
   * 1. Verify
https://git.dpdk.org/tools/dpdk-ci/tree/tools/pw_maintainers_cli.py
requires no updates for next-dts
   * 2. Add next-dts to the branches dict in
https://git.dpdk.org/tools/dpdk-ci/tree/tools/create_series_artifact.py
   * 3. Submit to ci@dpdk.org for review.
* Failing existing tests due to scapy
   * Luca observed DTS failing due to errors at packet creation. This may
be due to updating Scapy, which may have brought in a small API change.
      * Nick from the UNH team should try to recreate this, share output on
the dts-dev slack to sync with the ARM guys and confirm it is the same,
* Reviews are more important than new patches right now - we still have a
backlog which we need to review and merge to our next branch.
* DTS Single node Deployments:
   * By running TG and DUT as one system, this reduces the burden for
developers to run DTS using only 1 board. This probably reduces no
limitations for functional tests.
   * Scapy asyncsniffer will never init condition properly when running on
a single system
   * Patrick to make ticket so we can start tracking what the issues are
* DTS internal API:
   * Paul was trying to write docs for the DTS =E2=80=9Cuser=E2=80=9D (test=
 developer).
   * What should be exposed to the developer for testsuite
      * Testsuite class should be exposed
      * Logger, for instance, should not directly be used (leveraged only
by framework), but it is located at the same path as TestSuite.
      * Create a top level dir for all the modules that users should use
directly.
      * Seconded by Ian, who ran into this as a new user who did not know
which
   * Currently we have no restrictions on DTS API updates during regular
release dev cycles.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* Patchseries merged this week:
   * Dynamic config testsuite
   * fix pass rate edge case in results json
   * Hello_world
   * unified  packet testsuite
      * Is it 1:1 with legacy DTS? If so, copyrights should be brought over=
.
      * Is nvgre deprecated in DPDK? This was removed in the new testsuite.
* Queue Start Stop was updated this week to change how deferred start is
validated (now checks both that port doesn=E2=80=99t start erroneously, and=
 that it
can be updated at runtime
   * Patrick needs to run this and merge it, but he has no more comments
* Jumboframes/mtu_update
   * Initial testcases simply bring up testpmd using =E2=80=93max-pkt-len
(includinig jumboframe MTU), and send packets
   * Final testcases bring up testpmd, update MTU at runtime, send packets
   * CC Ian Stokes on this who has some background in this subject
* Port topology patch:
   * Luca has offered to take this off of Nick=E2=80=99s hands
   * Ian should be CC=E2=80=99d on this

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
*

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* If you observe any instabilities or unpredictable behavior in DTS, please
post to the Slack channel.
* Next meeting is Jan 30, 2025

--0000000000006688f70630415a43
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>January 16, 2025<br>Attendees<br>* Patrick Robb<br>* Cody Ch=
eng<br>* Ian Stokes<br>* Dean Marx<br>* Paul Szczepanek<br>* Luca Vizzarro<=
br>* Thomas Wilks<br><br>##################################################=
###################<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<br>* DPDK Summit will be May 8-=
9 in Prague: <a href=3D"https://www.dpdk.org/event/dpdk-summit-2025-prague/=
">https://www.dpdk.org/event/dpdk-summit-2025-prague/</a><br>* git apply pa=
tch fails for next-dts<br>=C2=A0 =C2=A0* Cody Cheng who works on UNH CI Tes=
ting can resolve this.<br>=C2=A0 =C2=A0* 1. Verify <a href=3D"https://git.d=
pdk.org/tools/dpdk-ci/tree/tools/pw_maintainers_cli.py">https://git.dpdk.or=
g/tools/dpdk-ci/tree/tools/pw_maintainers_cli.py</a> requires no updates fo=
r next-dts<br>=C2=A0 =C2=A0* 2. Add next-dts to the branches dict in <a hre=
f=3D"https://git.dpdk.org/tools/dpdk-ci/tree/tools/create_series_artifact.p=
y">https://git.dpdk.org/tools/dpdk-ci/tree/tools/create_series_artifact.py<=
/a><br>=C2=A0 =C2=A0* 3. Submit to <a href=3D"mailto:ci@dpdk.org">ci@dpdk.o=
rg</a> for review.<br>* Failing existing tests due to scapy<br>=C2=A0 =C2=
=A0* Luca observed DTS failing due to errors at packet creation. This may b=
e due to updating Scapy, which may have brought in a small API change.<br>=
=C2=A0 =C2=A0 =C2=A0 * Nick from the UNH team should try to recreate this, =
share output on the dts-dev slack to sync with the ARM guys and confirm it =
is the same, <br>* Reviews are more important than new patches right now - =
we still have a backlog which we need to review and merge to our next branc=
h.<br>* DTS Single node Deployments:<br>=C2=A0 =C2=A0* By running TG and DU=
T as one system, this reduces the burden for developers to run DTS using on=
ly 1 board. This probably reduces no limitations for functional tests. <br>=
=C2=A0 =C2=A0* Scapy asyncsniffer will never init condition properly when r=
unning on a single system<br>=C2=A0 =C2=A0* Patrick to make ticket so we ca=
n start tracking what the issues are<br>* DTS internal API:<br>=C2=A0 =C2=
=A0* Paul was trying to write docs for the DTS =E2=80=9Cuser=E2=80=9D (test=
 developer). <br>=C2=A0 =C2=A0* What should be exposed to the developer for=
 testsuite<br>=C2=A0 =C2=A0 =C2=A0 * Testsuite class should be exposed<br>=
=C2=A0 =C2=A0 =C2=A0 * Logger, for instance, should not directly be used (l=
everaged only by framework), but it is located at the same path as TestSuit=
e.<br>=C2=A0 =C2=A0 =C2=A0 * Create a top level dir for all the modules tha=
t users should use directly. <br>=C2=A0 =C2=A0 =C2=A0 * Seconded by Ian, wh=
o ran into this as a new user who did not know which <br>=C2=A0 =C2=A0* Cur=
rently we have no restrictions on DTS API updates during regular release de=
v cycles.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>Patch discussions<br>* Patchseries merged this week:<br>=C2=A0 =C2=A0* =
Dynamic config testsuite<br>=C2=A0 =C2=A0* fix pass rate edge case in resul=
ts json<br>=C2=A0 =C2=A0* Hello_world<br>=C2=A0 =C2=A0* unified =C2=A0packe=
t testsuite<br>=C2=A0 =C2=A0 =C2=A0 * Is it 1:1 with legacy DTS? If so, cop=
yrights should be brought over.<br>=C2=A0 =C2=A0 =C2=A0 * Is nvgre deprecat=
ed in DPDK? This was removed in the new testsuite.<br>* Queue Start Stop wa=
s updated this week to change how deferred start is validated (now checks b=
oth that port doesn=E2=80=99t start erroneously, and that it can be updated=
 at runtime<br>=C2=A0 =C2=A0* Patrick needs to run this and merge it, but h=
e has no more comments<br>* Jumboframes/mtu_update<br>=C2=A0 =C2=A0* Initia=
l testcases simply bring up testpmd using =E2=80=93max-pkt-len (includinig =
jumboframe MTU), and send packets<br>=C2=A0 =C2=A0* Final testcases bring u=
p testpmd, update MTU at runtime, send packets<br>=C2=A0 =C2=A0* CC Ian Sto=
kes on this who has some background in this subject<br>* Port topology patc=
h:<br>=C2=A0 =C2=A0* Luca has offered to take this off of Nick=E2=80=99s ha=
nds<br>=C2=A0 =C2=A0* Ian should be CC=E2=80=99d on this<br>=C2=A0 =C2=A0<b=
r>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla di=
scussions<br>* <br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>Any other business<br>* If you observe any instabilities or unpre=
dictable behavior in DTS, please post to the Slack channel.<br>* Next meeti=
ng is Jan 30, 2025</div>

--0000000000006688f70630415a43--
