Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69ED1C282DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:08:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC07B402D2;
	Fri, 14 Mar 2025 00:08:14 +0100 (CET)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id EEC854025D
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:08:12 +0100 (CET)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-2feb91a2492so2743077a91.2
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741907292; x=1742512092; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=QSjh0X9vqrMcMEJphW++zjFCg9MmUGlHNmB+GShmoHI=;
 b=UnSYI9tySl3MWJVKHmWFEOaEB+cAfkT7J+I11fhoQp6Dc0tMr10mdbXodZY5vUtX3E
 Qt2Jz80UZbFx5WfU2wedTnrJe5DACWs4JT6G3CTV32SFJmcFNnqfLwpd5AEBRqTUlyeX
 jOk/YuT4Q3Gi9EEaj/TpM/4AP103ZjlvAd04s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741907292; x=1742512092;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QSjh0X9vqrMcMEJphW++zjFCg9MmUGlHNmB+GShmoHI=;
 b=Q4vNVQNuVBWEZFfRRl/48LF8U+4rfNGaP/7uhCbzogAvcu7MrpLBXqPWTKjIAO1Xwx
 hHWcy/1MjBVZWNL4naskhypbb5SFgg44XdDwERdpsJpEvq4gyJ5ZonhTXYsWFt8EV93A
 Wit3ATRsDzQ7ACaJ7JTLeiDDQYYQ7liVC7QpCQdHWJjZ6r4uH9g1B3hDyKzQR+NIz0aR
 OpJhPdzI4jyDck9Ax5K0qu8XVK++h08UrP1Lg/SS57nupyyL8yzor497RHTBrWbYLobr
 0BqGNPp4ShSZUq52UWYihrxo05KlkJaZ5Bzl93e119an/7d3ET0KdXRUj903OagAkK0H
 7i5A==
X-Gm-Message-State: AOJu0Yz7TNOBcWL/RyGHvkXtmm+A7LkGClxvbHv5o1mJM3R5KdPhoptz
 O8Pxl28wRwTjCpWDg9m2XX5SwNt7hUIzrkNqXrfCxFYcOpCeYynf+qMF9oYrhonfNMDOIyPRqwG
 JQZAg1xY4Y0Nw6v6VpEv4ZnPIR4wifpN3uofC7UL3uQaLIk23Nrn17A==
X-Gm-Gg: ASbGncv/TxTf4r50Ifb+AZwGWP/Lp8+PjJrhZppRgUyM3VH0Lkrvg+tvBLSCLd3iWxV
 dr2wj6YH1eF7RgKLrBdC7gfmWea62mgE967Yef5AUuLRxbSDWW0KvjkKdrZFpbDTHKvnq4I0jYA
 f4n810ZvHc0IjKHKtvpGiVL1M+LvhkGgC5CeNlVQ08r6pl7pcZea3nM03VqR4=
X-Google-Smtp-Source: AGHT+IGaQfYBGRtKe3CTTJdU1Lx5RGUaMupedKSppgcbFgNpVVLkdLEGoLu3Ww8kwPCID1ZnWSdHGfV+LtG9JdlCzqY=
X-Received: by 2002:a17:90b:5144:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-30151c79931mr327199a91.6.1741907291612; Thu, 13 Mar 2025
 16:08:11 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 19:04:29 -0400
X-Gm-Features: AQ5f1JowAZD8dESYLZi__SWwssR8N-wpJ1HO_sCy4HQCly93NeZ4CYdkDRxn-Os
Message-ID: <CAJvnSUBnno0Dp+DU27jiLRg53td-CB6mZf16e_AcYyVMn6YSnQ@mail.gmail.com>
Subject: Community CI Meeting Minutes - January 23, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000593df906304165f3"
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

--000000000000593df906304165f3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
January 23, 2025
Attendees
. Patrick Robb
. Aaron
. Paul Szczepanek
. Andre Muezerie

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* Aaron raised patch volume and public lab test capacity at tech board
yesterday, and this will be a discussion item at the next tech board
meeting on 02/05
   * CI testing should not be a replacement for developers testing their
code before submission to the mailing list. When people submit patches in
high volume with minimal testing, it can create a testing queue which
worsens the experience for everyone.
   * For the linux kernel project, developers are =E2=80=9Crate limited=E2=
=80=9D to 1
patchseries per 24 hours
      * If your patch causes a build failure, you should not resubmit for
some longer period (maybe a week)
   * There may be some opportunities to make developer testing easier
      * For instance, it may be possible to add a GHA cross compile to
arm64 which would allow developers to fork the repo, get cross compile
tests for their patches
* Andre has started working on DPDK at Microsoft and has joined the meeting
to get to know the CI processes
   * Patrick should check which build toolchains are in use (should be all
3 supported for windows) and email this to andre afterwards.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* The new ARM Grace-Grace server has shipped, patrick has the tracking #,
and it is expected to be delivered to UNH tomorrow January 24.
   * NICs will be moved over to the Grace server according to the migration
plan which was shared out to the governing board and tech board last year
* David helped add the =E2=80=9Cnext-dts-for-main=E2=80=9D branch to github=
, which mirrors
the next-dts branch from dpdk.org.
   * Still require a review and merge from Aaron for
https://patchwork.dpdk.org/project/ci/patch/20250116221112.19794-1-ccheng@i=
ol.unh.edu/
which simply adds a mapping for this branch in the CI patch apply script
* New DTS in CI testing:
   * Patrick is adding configs for additional NICs - aiming to turn this on
early next week. Most likely to start with a few testsuites and then scale
up from there.
* Dashboard search feature has been added, allowing users to search for
test results by patchwork series id OR by patch name keywords
   * https://lab.dpdk.org/results/dashboard/
* Patrick to check with Adam about the depends-on series for the patchwork
project
   * Latest we heard was that there were no additional comments from the
maintainer and that it was expected to be merged in the current patchwork
release cycle
* Cody is adding a cross compile job for x86 32 bit

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions
* Aaron has resurrected the Cirrus CI support patch - addressing some
comments and will submit a new patchseries version tomorrow or next week.
   * Zero day bot will connect with Cirrus server, which supports freebsd
and windows

---------------------------------------------------------------------
Loongarch Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Refactor configuration series:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D34355
   * Reviewed by Dean
   * Nick is reviewing now and will have all comments in by EOD
* Patrick left a few comments for the MTU testsuite, which Nick has
indicated he will incorporate into a v2 and submit by EOD
   * Should be possible to merge this =E2=80=9Cimmediately=E2=80=9D as the =
comments were
minimal, and Patrick has tested the V1 across multiple NICs

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting Feb 6, 2025

--000000000000593df906304165f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>January 23, 2025<br>Attendees<br>. Patrick Robb<br>. Aaron<b=
r>. Paul Szczepanek<br>. Andre Muezerie<br>=C2=A0<br>######################=
###############################################<br>Minutes<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<b=
r>* Aaron raised patch volume and public lab test capacity at tech board ye=
sterday, and this will be a discussion item at the next tech board meeting =
on 02/05<br>=C2=A0 =C2=A0* CI testing should not be a replacement for devel=
opers testing their code before submission to the mailing list. When people=
 submit patches in high volume with minimal testing, it can create a testin=
g queue which worsens the experience for everyone.<br>=C2=A0 =C2=A0* For th=
e linux kernel project, developers are =E2=80=9Crate limited=E2=80=9D to 1 =
patchseries per 24 hours<br>=C2=A0 =C2=A0 =C2=A0 * If your patch causes a b=
uild failure, you should not resubmit for some longer period (maybe a week)=
<br>=C2=A0 =C2=A0* There may be some opportunities to make developer testin=
g easier<br>=C2=A0 =C2=A0 =C2=A0 * For instance, it may be possible to add =
a GHA cross compile to arm64 which would allow developers to fork the repo,=
 get cross compile tests for their patches<br>* Andre has started working o=
n DPDK at Microsoft and has joined the meeting to get to know the CI proces=
ses<br>=C2=A0 =C2=A0* Patrick should check which build toolchains are in us=
e (should be all 3 supported for windows) and email this to andre afterward=
s.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CI=
 Status<br><br>------------------------------------------------------------=
---------<br>UNH-IOL Community Lab<br>* The new ARM Grace-Grace server has =
shipped, patrick has the tracking #, and it is expected to be delivered to =
UNH tomorrow January 24.<br>=C2=A0 =C2=A0* NICs will be moved over to the G=
race server according to the migration plan which was shared out to the gov=
erning board and tech board last year<br>* David helped add the =E2=80=9Cne=
xt-dts-for-main=E2=80=9D branch to github, which mirrors the next-dts branc=
h from <a href=3D"http://dpdk.org">dpdk.org</a>. <br>=C2=A0 =C2=A0* Still r=
equire a review and merge from Aaron for <a href=3D"https://patchwork.dpdk.=
org/project/ci/patch/20250116221112.19794-1-ccheng@iol.unh.edu/">https://pa=
tchwork.dpdk.org/project/ci/patch/20250116221112.19794-1-ccheng@iol.unh.edu=
/</a> which simply adds a mapping for this branch in the CI patch apply scr=
ipt<br>* New DTS in CI testing:<br>=C2=A0 =C2=A0* Patrick is adding configs=
 for additional NICs - aiming to turn this on early next week. Most likely =
to start with a few testsuites and then scale up from there. <br>* Dashboar=
d search feature has been added, allowing users to search for test results =
by patchwork series id OR by patch name keywords<br>=C2=A0 =C2=A0* <a href=
=3D"https://lab.dpdk.org/results/dashboard/">https://lab.dpdk.org/results/d=
ashboard/</a><br>* Patrick to check with Adam about the depends-on series f=
or the patchwork project<br>=C2=A0 =C2=A0* Latest we heard was that there w=
ere no additional comments from the maintainer and that it was expected to =
be merged in the current patchwork release cycle<br>* Cody is adding a cros=
s compile job for x86 32 bit<br><br>---------------------------------------=
------------------------------<br>Intel Lab<br>* None<br><br>--------------=
-------------------------------------------------------<br>Github Actions<b=
r>* Aaron has resurrected the Cirrus CI support patch - addressing some com=
ments and will submit a new patchseries version tomorrow or next week.<br>=
=C2=A0 =C2=A0* Zero day bot will connect with Cirrus server, which supports=
 freebsd and windows<br><br>-----------------------------------------------=
----------------------<br>Loongarch Lab<br>* None<br><br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Deve=
lopment<br>* Refactor configuration series: <a href=3D"https://patchwork.dp=
dk.org/project/dpdk/list/?series=3D34355">https://patchwork.dpdk.org/projec=
t/dpdk/list/?series=3D34355</a><br>=C2=A0 =C2=A0* Reviewed by Dean<br>=C2=
=A0 =C2=A0* Nick is reviewing now and will have all comments in by EOD<br>*=
 Patrick left a few comments for the MTU testsuite, which Nick has indicate=
d he will incorporate into a v2 and submit by EOD<br>=C2=A0 =C2=A0* Should =
be possible to merge this =E2=80=9Cimmediately=E2=80=9D as the comments wer=
e minimal, and Patrick has tested the V1 across multiple NICs<br><br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<b=
r>* Next Meeting Feb 6, 2025</div>

--000000000000593df906304165f3--
