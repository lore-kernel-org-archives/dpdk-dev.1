Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F46C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 22:55:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 20AAA40280;
	Thu, 13 Mar 2025 23:55:28 +0100 (CET)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id 040754025A
 for <dev@dpdk.org>; Thu, 13 Mar 2025 23:55:27 +0100 (CET)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2243803b776so44217705ad.0
 for <dev@dpdk.org>; Thu, 13 Mar 2025 15:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741906526; x=1742511326; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kXYv5rwkV7PrQ8YuvFU7QLtzGnUZja9x9C+PD9oBNXE=;
 b=auZkUEva1B5hDvR9fOUuPIMY9qPqdBz/hrFsDScXcrNEAf5Z7Iu2PgqLwKjUKfQSjv
 7ywDzs385khg5ipkcserRrKGNwGDoAT05fy0/GkbPzrJcXEFSTvTxAPffoaYn63kTrHT
 8kIFKF2EiTwmOnjO76+GDkz8S6jtbwBe7HxIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741906526; x=1742511326;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kXYv5rwkV7PrQ8YuvFU7QLtzGnUZja9x9C+PD9oBNXE=;
 b=L9hicHZ0/SEBzr/P603inrIOXBlgLsyFR7resjP0xXo71U5YnKU947kN/x4o9fGeQp
 nb9lyRXhMsmo4/wFmByDwDdwHXVkivIVDQhHzVYowb0awUnndqDGyhN5ReLpDVnHQl+i
 /laQf4L/ZrL1unb6zjtZ8D+/Z7Wem4t0oWUQuseGqym/jqLwhnN2sHBXADEC4XxkbJRB
 68KuJERgNm4ghOI7VeobIZlh4YMkGkL5fg4YeNNufLL2Mjd+PXvKpy/5bljtSrmFn8Jj
 Z0ub9ib4Vs4jeGfoHKeGPTER27QFRlE5dRVKbhW6GpAKzD3JxKZKZVq58jhUx/mFv7e8
 0wgw==
X-Gm-Message-State: AOJu0Yx7Lo2qtsPsKBP5jLOsTbzTrFTXSwp6F/B1CusGMn7RYq5x8MEO
 jUuVM6N21wJv5laFtbU87Owai3a6PeMa0JTQfZRwfZUNJVBh5S/neupXvKxBJ5GJpLSYF1DIjK0
 83ob/tjmUejpUxHhX19M8USaI+8iqMIsuVMGFUv1UsqvD483087nPPQ==
X-Gm-Gg: ASbGncvkNAPIko+s16FxS5SXCkO6JUHaZg6jkPGnjRL6azTd9A4ZeDjCdTlnHuNekQO
 +yafkNhRYEziTxFpCHeamNARzAHLigcgig9C2Y0rS6CrGe624fwqinSa99XhpV4OxiWtEYXbZAs
 tI2ZhYfuNoU+79JPx9KPBkAJ+o2s/zk9O6h5c68Na66OtuW0aXTmU6KYZHKOI=
X-Google-Smtp-Source: AGHT+IEK3J/lT6WRNs9q24YyayMuz5isR3AUIuBBLkKhVTBVVlD7z8cFXW+UbLARmOI1omrUwMJaQc6FCy+17cOkAwY=
X-Received: by 2002:a17:903:2ec8:b0:224:1609:a747 with SMTP id
 d9443c01a7336-225e0a9c84amr3896575ad.31.1741906525693; Thu, 13 Mar 2025
 15:55:25 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 18:51:43 -0400
X-Gm-Features: AQ5f1JoyUyfCWLiwX6UV7QtouAuHdvH6MUtlgYKNtMz9K8e-jiX3Gjp6dlAVVbM
Message-ID: <CAJvnSUDYfj1EgDVKv6RR14hV5cZirHJeuwfNsPLSnJjDt5NFaQ@mail.gmail.com>
Subject: DTS WG Meeting Minutes - December 19, 2024
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000b240ce063041373b"
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

--000000000000b240ce063041373b
Content-Type: text/plain; charset="UTF-8"

#####################################################################
December 19, 2024
Attendees
* Patrick Robb
* Paul Szczepanek
* Luca Vizzarro
* Thomas Wilks

#####################################################################
Minutes

=====================================================================
General Discussion
* 25.03 DTS roadmap was mailed out:
https://inbox.dpdk.org/ci/CAJvnSUA1gtvVyzSEqBdErYXSwRAeijj5MCOvcxPr5GF3O0ANrA@mail.gmail.com/T/#u
* December 26 CI meeting is cancelled
* January 2 DTS meeting is cancelled

=====================================================================
Patch discussions
* Nick has submitted a bugfix for the paramiko interactive shell, which
forces the close method to wait for 1 byte to enter the stdout buffer
before calling paramiko close():
   *
https://patchwork.dpdk.org/project/dpdk/patch/20241212193902.31789-1-npratte@iol.unh.edu/
* Queue start/stop:
   * Dean reviewed this again yesterday, submitted a new patch which
rewrote the commit message and requested a review and merge
   * Stephen Hemminger replied to the latest patch, requesting that an
additional testcase be added to the suite which uses deferred start.
      * This will be added by Dean ASAP and then Patrick will review to
merge to next-dts.
* Hello world replacement series:
https://patchwork.dpdk.org/project/dpdk/patch/20241209215406.6982-2-dmarx@iol.unh.edu/
   * Brings up testpmd app, does nothing, closes
   * Paul will review
* Ruff: Patrick will provide a review by end of week
   * There is a scapy/mypy update series which depends on this
* A linting bugfix patch for python 3.12 was submitted, which affects dts
file and regular DPDK files. We are unsure of whether this should go to the
next-dts tree or not, which Patrick asked about on the mailing list. If
there is no comment we will merge the series to next-dts next week.
* Config persistency testsuite is submitted by Thomas Wilks
   *
https://patchwork.dpdk.org/project/dpdk/patch/20241212132807.263829-3-thomas.wilks@arm.com/
   * Patrick will review tomorrow
* Shell conversation: create a list of shells per node, references are
stored, then at the end of each testcase check if there are still any open
shells in this list and if so, closes them.

=====================================================================
Bugzilla discussions
* Dockerfile upgrade to 24.04 ticket: Dean has been playing around with
upgrading the Dockerfile to 24.04 and trying to understand which
dependencies are broken by this.
   * Dean should assign this ticket to himself on bugzilla if he means to
do this in 25.03
   * Patrick/Dean create a bugzilla ticket for this

=====================================================================
Any other business
* Next meeting January 16, 2025

--000000000000b240ce063041373b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>December 19, 2024<br>Attendees<br>* Patrick Robb<br>* Paul S=
zczepanek<br>* Luca Vizzarro<br>* Thomas Wilks<br><br>#####################=
################################################<br>Minutes<br><br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Discussion<b=
r>* 25.03 DTS roadmap was mailed out: <a href=3D"https://inbox.dpdk.org/ci/=
CAJvnSUA1gtvVyzSEqBdErYXSwRAeijj5MCOvcxPr5GF3O0ANrA@mail.gmail.com/T/#u">ht=
tps://inbox.dpdk.org/ci/CAJvnSUA1gtvVyzSEqBdErYXSwRAeijj5MCOvcxPr5GF3O0ANrA=
@mail.gmail.com/T/#u</a><br>* December 26 CI meeting is cancelled<br>* Janu=
ary 2 DTS meeting is cancelled<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>Patch discussions<br>* Nick has submitted a bugfix=
 for the paramiko interactive shell, which forces the close method to wait =
for 1 byte to enter the stdout buffer before calling paramiko close():<br>=
=C2=A0 =C2=A0* <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/202=
41212193902.31789-1-npratte@iol.unh.edu/">https://patchwork.dpdk.org/projec=
t/dpdk/patch/20241212193902.31789-1-npratte@iol.unh.edu/</a><br>* Queue sta=
rt/stop:<br>=C2=A0 =C2=A0* Dean reviewed this again yesterday, submitted a =
new patch which rewrote the commit message and requested a review and merge=
<br>=C2=A0 =C2=A0* Stephen Hemminger replied to the latest patch, requestin=
g that an additional testcase be added to the suite which uses deferred sta=
rt. <br>=C2=A0 =C2=A0 =C2=A0 * This will be added by Dean ASAP and then Pat=
rick will review to merge to next-dts.<br>* Hello world replacement series:=
 <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/20241209215406.69=
82-2-dmarx@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch/2024=
1209215406.6982-2-dmarx@iol.unh.edu/</a><br>=C2=A0 =C2=A0* Brings up testpm=
d app, does nothing, closes<br>=C2=A0 =C2=A0* Paul will review<br>* Ruff: P=
atrick will provide a review by end of week<br>=C2=A0 =C2=A0* There is a sc=
apy/mypy update series which depends on this<br>* A linting bugfix patch fo=
r python 3.12 was submitted, which affects dts file and regular DPDK files.=
 We are unsure of whether this should go to the next-dts tree or not, which=
 Patrick asked about on the mailing list. If there is no comment we will me=
rge the series to next-dts next week.<br>* Config persistency testsuite is =
submitted by Thomas Wilks<br>=C2=A0 =C2=A0* <a href=3D"https://patchwork.dp=
dk.org/project/dpdk/patch/20241212132807.263829-3-thomas.wilks@arm.com/">ht=
tps://patchwork.dpdk.org/project/dpdk/patch/20241212132807.263829-3-thomas.=
wilks@arm.com/</a><br>=C2=A0 =C2=A0* Patrick will review tomorrow<br>* Shel=
l conversation: create a list of shells per node, references are stored, th=
en at the end of each testcase check if there are still any open shells in =
this list and if so, closes them. <br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions<br>* Dockerfile upgrade to=
 24.04 ticket: Dean has been playing around with upgrading the Dockerfile t=
o 24.04 and trying to understand which dependencies are broken by this.<br>=
=C2=A0 =C2=A0* Dean should assign this ticket to himself on bugzilla if he =
means to do this in 25.03<br>=C2=A0 =C2=A0* Patrick/Dean create a bugzilla =
ticket for this<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Next meeting January 16, 2025=
</div>

--000000000000b240ce063041373b--
