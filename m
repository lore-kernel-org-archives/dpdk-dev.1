Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3220FC282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:24:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 344CF402D9;
	Fri, 14 Mar 2025 00:24:36 +0100 (CET)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 473FB4026B
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:24:35 +0100 (CET)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-2feb91a25bdso2825758a91.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741908274; x=1742513074; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8zP8wqswzvP0XhCiq5FcOUbPII4XlylT4hZwycJ6fr0=;
 b=TGIFFLmsGuEqX148gU2YWppOgRpHx0ly1ehsbcJs0R55jS3ITXcqK6sh8k16kg4iqc
 m8TjTyZUyaY+t0RXUbDZnOzH+pKZ2ulKiNFrXnr4GTlwKnHrDZi+gOuy20IN4MrIyslo
 EAkY1SeP1AA+/WZwpEDNpsUCXYLSP6CDgmzG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741908274; x=1742513074;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8zP8wqswzvP0XhCiq5FcOUbPII4XlylT4hZwycJ6fr0=;
 b=YOwyCoEEdjtsCFdw7Ru7Z3ViTl7jUbL7p2uF8E7ZIWVZOh9p7Qimx/0APkh4lUz0AS
 fjXKgZQPc6nPY8PDtKHACs8nDxvpuf0O7Tq/3SrqDwpHIMMMA64HaHvbW1b8NPvY4Rk7
 SnHBNfDxKpYbhsQMKpKgE9Hg+2bs5bXYpG7CQ2+cy2DrOrF6s9CMkndfko3QPbIiG/E8
 TUlehaVEzq7t1IpXXQZ+x3VoZOj9WfpF9tjTuzt8Hp8uJRkYxeXZ9rs7+uptayKwpEiY
 jL6+wlPFalRi239Dw/nlowkUtmOFv31qoQA0zSgl3XvAp4rb1P9I6qp6RahdzqV0mAG7
 9YkA==
X-Gm-Message-State: AOJu0YyOfRRWW337YqNl9rnyz5fCjkC2mXRjETs+Ui0mcEIvs0UNF7Dk
 JJzVzNwd8jdem++wFvcSA1gXeb99duHhVkqwmwZeDJgezlblfBXZpWs8PADrcFtMnsKgC1YLoP4
 J6DX7vf6r0BoC7oMNT0HsbCoFUTCTcKGxhIhjYCo5Rj2n7ai67Yne6A==
X-Gm-Gg: ASbGnctbdXFkrvacbfKWVwGkWpYdqNS5qmkEh2zV0H1/WdVfaxloC0yZvaCh26Lezm3
 K6TOl0hWIYeU1gijBDoVFqogq+NdaGIrLEzyrU9Y0lpwyewVcPmjUFP5Kr6Qvcx8IfVXbe/FnMO
 gKgirq/2096JhDTKALcgBpD1rlthBFrtoHSopJVyH0l0cGibqYgcZeCcfot2k=
X-Google-Smtp-Source: AGHT+IHcoG3wtAW8ul3EkQHIIUyCAb2srxU5kwpYSmL/9os6jWUziuD4M5Gqia5r1GhOkAxlWbIlunVeIkfI0kiiNmw=
X-Received: by 2002:a17:90b:51c3:b0:2ff:6ac2:c5a6 with SMTP id
 98e67ed59e1d1-30151dc757dmr367490a91.31.1741908273266; Thu, 13 Mar 2025
 16:24:33 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 19:20:51 -0400
X-Gm-Features: AQ5f1JqslWf-njc5QxIatZIjI0GMOnkUmRn6xSCJtys13CWSq9jtTJ1fq5MfXkA
Message-ID: <CAJvnSUBXCQ2sMczzmSm7Fmauc-qkXwbsySyJvRkEhJZXQRfjZg@mail.gmail.com>
Subject: Community CI Meeting Minutes - February 20, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000dc19e30630419f1c"
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

--000000000000dc19e30630419f1c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
February 20, 2025
Attendees
. Patrick Robb
. Paul Szczepanek
. Roman Epo
. Andre Muezerie
. Aaron Conole
. Luca Vizzarro

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* DPDK 25.03 RC2 is scheduled for February 28
* CFP is open for DPDK Summit Prague: May 8-9

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* ARM Grace:
   * Honnappa/Wathsala gave us some more performance tuning tips for Grace:
   * Sent them the latest raw MPPS metrics for E810 on Grace, and indicated
we would enable saving/reporting to patchwork this week if there isn=E2=80=
=99t any
more system tuning to be done (this appears to be the case)
* New DTS in CI testing:
   * Started publishing CI results to the dashboard last week for the mac
filter testsuite only - this has been stable
   * Will extend the test matrix since everything has gone fine over the
past week
* Depends on:
   * Adam submitted his latest version, and aaron ACKed
   * Adam also submitted the git-pw patch which allows people to use the
new depends-on updates for patchwork
* Intel E810 failures:
   * This series improved the single core forwarding performance for
ICE/E810: https://patchwork.dpdk.org/project/dpdk/list/?series=3D34444&stat=
e=3D*
   * When this happened, the TG send throughput was overtaken by testpmd=E2=
=80=99s
=E2=80=9Cthroughput,=E2=80=9D making the TG the bottleneck. Usually this is=
 avoided by
sending at line rate from the TG - but in this case we are having trouble
hitting line rate with our TG. Patrick is seeing if the TG config can be
updated to boost the throughput. Otherwise, we will have to sub in a
different TG NIC which we know can send at a higher rate.

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions
* Cirrus CI:
   * Worked on the cirrus yaml file for FreeBSD
   * There are some environmental and code issues with running the testing.
It may be a major effort to resolve these issues. It=E2=80=99s not immediat=
ely
clear to Aaron how he could resolve this alone.
      * If testing with FreeBSD isn=E2=80=99t possible, this reduces the us=
efulness
of Cirrus overall, particularly given that GHA now supports Windows
   * Can we run a subset of the meson unit tests?
      * It is possible to do this:
https://doc.dpdk.org/guides/prog_guide/meson_ut.html

---------------------------------------------------------------------
AWS
* They are working on rolling their own test-report email
templating/sending script
* After this, they will enable build and meson test pipelines for x86_64
and ARM Graviton

---------------------------------------------------------------------
Loongarch Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* The =E2=80=9Crevamp framework=E2=80=9D topology patch was merged
* Add VFs to framework:
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D33109
* SUT cleanup patch:
https://git.dpdk.org/next/dpdk-next-dts/commit/?id=3Dc79f7084ae45e5bbe9553e=
0efb323d232a46feaf
* Verbose output: The testpmd patch which adds l4 port # to testpmd verbose
output is staged on next-net currently
* Dean is updating a few of Jeremy=E2=80=99s old testsuites, like rx/tx off=
load,
port_stats.
* Fix dts-check-format:
   * dts: grab linter return value
   * Linter results were not being included in the =E2=80=9Ctest=E2=80=9D r=
esult

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting Mar 6, 2025

--000000000000dc19e30630419f1c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>February 20, 2025<br>Attendees<br>. Patrick Robb<br>. Paul S=
zczepanek<br>. Roman Epo<br>. Andre Muezerie<br>. Aaron Conole<br>. Luca Vi=
zzarro<br><br>#############################################################=
########<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>General Announcements<br>* DPDK 25.03 RC2 is scheduled for Feb=
ruary 28<br>* CFP is open for DPDK Summit Prague: May 8-9 <br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>------=
---------------------------------------------------------------<br>UNH-IOL =
Community Lab<br>* ARM Grace: <br>=C2=A0 =C2=A0* Honnappa/Wathsala gave us =
some more performance tuning tips for Grace:<br>=C2=A0 =C2=A0* Sent them th=
e latest raw MPPS metrics for E810 on Grace, and indicated we would enable =
saving/reporting to patchwork this week if there isn=E2=80=99t any more sys=
tem tuning to be done (this appears to be the case)<br>* New DTS in CI test=
ing:<br>=C2=A0 =C2=A0* Started publishing CI results to the dashboard last =
week for the mac filter testsuite only - this has been stable<br>=C2=A0 =C2=
=A0* Will extend the test matrix since everything has gone fine over the pa=
st week<br>* Depends on:<br>=C2=A0 =C2=A0* Adam submitted his latest versio=
n, and aaron ACKed<br>=C2=A0 =C2=A0* Adam also submitted the git-pw patch w=
hich allows people to use the new depends-on updates for patchwork<br>* Int=
el E810 failures:<br>=C2=A0 =C2=A0* This series improved the single core fo=
rwarding performance for ICE/E810: <a href=3D"https://patchwork.dpdk.org/pr=
oject/dpdk/list/?series=3D34444&amp;state=3D*">https://patchwork.dpdk.org/p=
roject/dpdk/list/?series=3D34444&amp;state=3D*</a><br>=C2=A0 =C2=A0* When t=
his happened, the TG send throughput was overtaken by testpmd=E2=80=99s =E2=
=80=9Cthroughput,=E2=80=9D making the TG the bottleneck. Usually this is av=
oided by sending at line rate from the TG - but in this case we are having =
trouble hitting line rate with our TG. Patrick is seeing if the TG config c=
an be updated to boost the throughput. Otherwise, we will have to sub in a =
different TG NIC which we know can send at a higher rate.<br><br>----------=
-----------------------------------------------------------<br>Intel Lab<br=
>* None<br><br>------------------------------------------------------------=
---------<br>Github Actions<br>* Cirrus CI:<br>=C2=A0 =C2=A0* Worked on the=
 cirrus yaml file for FreeBSD<br>=C2=A0 =C2=A0* There are some environmenta=
l and code issues with running the testing. It may be a major effort to res=
olve these issues. It=E2=80=99s not immediately clear to Aaron how he could=
 resolve this alone.<br>=C2=A0 =C2=A0 =C2=A0 * If testing with FreeBSD isn=
=E2=80=99t possible, this reduces the usefulness of Cirrus overall, particu=
larly given that GHA now supports Windows<br>=C2=A0 =C2=A0* Can we run a su=
bset of the meson unit tests?<br>=C2=A0 =C2=A0 =C2=A0 * It is possible to d=
o this: <a href=3D"https://doc.dpdk.org/guides/prog_guide/meson_ut.html">ht=
tps://doc.dpdk.org/guides/prog_guide/meson_ut.html</a><br><br>-------------=
--------------------------------------------------------<br>AWS<br>* They a=
re working on rolling their own test-report email templating/sending script=
<br>* After this, they will enable build and meson test pipelines for x86_6=
4 and ARM Graviton<br><br>-------------------------------------------------=
--------------------<br>Loongarch Lab<br>* None<br><br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Deve=
lopment<br>* The =E2=80=9Crevamp framework=E2=80=9D topology patch was merg=
ed<br>* Add VFs to framework:<br>=C2=A0 =C2=A0* <a href=3D"https://patchwor=
k.dpdk.org/project/dpdk/list/?series=3D33109">https://patchwork.dpdk.org/pr=
oject/dpdk/list/?series=3D33109</a><br>* SUT cleanup patch: <a href=3D"http=
s://git.dpdk.org/next/dpdk-next-dts/commit/?id=3Dc79f7084ae45e5bbe9553e0efb=
323d232a46feaf">https://git.dpdk.org/next/dpdk-next-dts/commit/?id=3Dc79f70=
84ae45e5bbe9553e0efb323d232a46feaf</a><br>* Verbose output: The testpmd pat=
ch which adds l4 port # to testpmd verbose output is staged on next-net cur=
rently<br>* Dean is updating a few of Jeremy=E2=80=99s old testsuites, like=
 rx/tx offload, port_stats.<br>* Fix dts-check-format:<br>=C2=A0 =C2=A0* dt=
s: grab linter return value<br>=C2=A0 =C2=A0* Linter results were not being=
 included in the =E2=80=9Ctest=E2=80=9D result<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Next Meetin=
g Mar 6, 2025</div>

--000000000000dc19e30630419f1c--
