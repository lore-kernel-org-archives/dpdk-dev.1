Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AAFC35FF1
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 22:58:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DE06C40280;
	Thu, 13 Mar 2025 23:58:37 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1BDF84025D
 for <dev@dpdk.org>; Thu, 13 Mar 2025 23:58:36 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-22398e09e39so31935065ad.3
 for <dev@dpdk.org>; Thu, 13 Mar 2025 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741906715; x=1742511515; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=81zaYvfAjUvHk3+XuxEerKtJekgcbjJSQ1hjOUTcZOY=;
 b=ebZ/BuR42TTQ7AS3UOXf3XWtcxvKZJwn2rtMtUd4DL8ODyICXvi4GBALlbQiZ3O7bm
 wZwQ/xac2lKoZPo7difPC3Pl2o6ZfCNI0XVOWkh6i5tZi8+QSmtWKLKGZ2xP5v4sgu1P
 v4yRRolE9LvKd9b6hH3Y+I0s17lVvQdmee/kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741906715; x=1742511515;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=81zaYvfAjUvHk3+XuxEerKtJekgcbjJSQ1hjOUTcZOY=;
 b=Ic7QTxsF3QOB7tZ3u6d6lWA4077G/axosFJ1ShezOgBaWpoTmDJtLCmgnCX05wQHxt
 LVwUMZGnNble60gxJWceBNCrpQshA4eSrDgH2rUBv3E0yixXs3zAUz0Q38oHHTCF1T1n
 5borR8he5ng/vQKmojWJy85EigTen7wdnNnuTpZ1evO/+KbiJesX9+6g4S1G+OzKaQgt
 v8hsXTCcF0WSpZW9M/92cBfnzVvdYFRjWxNkzvS69G6MiDZ5tJlOlMOuwk00nOfu+WMB
 SKCuSc+/95kkf9j1KbnAu75FlphV57pJFHPoDCRSDpg4l905xxUJc8cngPRtPbJ1o5x7
 3FEQ==
X-Gm-Message-State: AOJu0YxdJlzh4s3nOXofMLVFAfPgiP4VejJhZ/7TEwDPZQJZ24xM/u+c
 JAne5ePLH4ywwd6EC0xvoBeOGg8KzTU3ALDqRAUHGgFlm8TYQgiuzskNI+d/60Oi9geWiYO7Epj
 Yp/ZolcYPVaALLJgWfBmn29/rB0lXlpu8BmkOqmIn/kV2vzL1ILYliw==
X-Gm-Gg: ASbGncsdS70jGQ2gLKS9361/OUaxC8vhvrqw2wJ9ALYClIMxITg0LqL32HxvImTlYGQ
 0GHATA1LECJhrd3d0dRpoMguDq29O7m3cHHFlPHFhLuJDGQJucKOszJKsHmbvnX6omPb57iKdbZ
 IzTOut1OcjTxrbOXxG2AFwza30ha2IkUugrrs94/QavtOq1ecABQ7iHkmbI5uE3SDL2UsXsA==
X-Google-Smtp-Source: AGHT+IHiJ2NCt8nUh0RRrGwlQUuncjUqIZaTso6Ojdd4GCGUDszb/H0HlP5nFb5+VHuBz5EamyQM6KxSuLSCOnX7nN0=
X-Received: by 2002:a17:902:fc8e:b0:220:cb1a:da5 with SMTP id
 d9443c01a7336-225e0af57a4mr5312395ad.40.1741906714809; Thu, 13 Mar 2025
 15:58:34 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 18:54:52 -0400
X-Gm-Features: AQ5f1Jpjlm8OyY1ugiLqsPd1FJmWmQ5KdR_lEtvSX9bmcFAMAUVVD1lMf3Aamr4
Message-ID: <CAJvnSUDW=Odh26v0LO4jwNdXG3HzJftrYjfzS4o+O=nGKkBQUA@mail.gmail.com>
Subject: Community CI Meeting Minutes - January 9, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000f7f09f0630414298"
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

--000000000000f7f09f0630414298
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
January 9, 2025
Attendees
. Patrick Robb
. Aaron Conole
. Luca Vizzarro
. Dean Marx
. Cody Cheng
. Aaron Conole
. Nicholas Pratte
. Matthew McGovern
. Manit Mahajan

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* Happy New Year!
* 25.03 release schedule is:
   * (-rc1): 7 February 2025
   * (-rc2): 28 February 2025
   * (-rc3): 7 March 2025
   * Release: 26 March 2025

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* OvS install now requires python 3.7, which opensuse 15.6 does not ship
with. So, options are to either upgrade python on this test container, or
discontinue the test for this distro.
* Lab Dashboard updates:
   * We are adding a patch series search feature for searching by series
title or series # id. This will deploy before end of week.
   * Working on embedding the code coverage reports in the dashboard
   * Working on embedding the code coverage reports in the dashboard such
that the reports don=E2=80=99t have to be manually downloaded and opened by=
 users
      * We should also begin running the coverage reports on a per series
basis
         * Can produce json output from gcov/lcov, and compare the
=E2=80=9Cbasline=E2=80=9D json coverage to a new result
* ABI testing: We have been running ABI tests for 24.11 and main for the
past few weeks, but still need to backfill ABI results for patches
submitted immediately after 24.11 released. We can put these into queue
today.
* The lab will have a little downtime next week for infra maintenance,
which will be announced the day before on the mailing list.

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions
* None

---------------------------------------------------------------------
Loongarch Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Series Patrick should review:
   * Dean: queue start stop
   * Nick: ethertype test suite
   * Softnic testsuite
      * V3 is submitted
      * * Perf testing:
   * UNH team has been investigating performance traffic generators
      * Trex
         * Have just been testing the trex api for setting traffic streams,
collecting stats etc.
      * Dperf
      * Need to decide on collecting stats via trex API vs testpmd when
writing the single core forwarding perf test
   * Luca proposes an abstraction for creating files on the DTS nodes, such
that we don=E2=80=99t have to manually create and copy files requires for D=
TS
testsuites.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting January 23
* Azure:
   * Currently using a =E2=80=9CLisa=E2=80=9D test framework for managing n=
odes and running
some tests
   * Aiming to leverage DTS in the future
   * Can we get 2 nodes on the same l2 networking?
      * Not really on Azure, so we would need to provide support for tests
through l3 routing.

--000000000000f7f09f0630414298
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>January 9, 2025<br>Attendees<br>. Patrick Robb<br>. Aaron Co=
nole<br>. Luca Vizzarro<br>. Dean Marx<br>. Cody Cheng<br>. Aaron Conole<br=
>. Nicholas Pratte<br>. Matthew McGovern<br>. Manit Mahajan<br><br>########=
#############################################################<br>Minutes<br=
><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General =
Announcements<br>* Happy New Year!<br>* 25.03 release schedule is:<br>=C2=
=A0 =C2=A0* (-rc1): 7 February 2025<br>=C2=A0 =C2=A0* (-rc2): 28 February 2=
025<br>=C2=A0 =C2=A0* (-rc3): 7 March 2025<br>=C2=A0 =C2=A0* Release: 26 Ma=
rch 2025<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>CI Status<br><br>------------------------------------------------------=
---------------<br>UNH-IOL Community Lab<br>* OvS install now requires pyth=
on 3.7, which opensuse 15.6 does not ship with. So, options are to either u=
pgrade python on this test container, or discontinue the test for this dist=
ro.<br>* Lab Dashboard updates:<br>=C2=A0 =C2=A0* We are adding a patch ser=
ies search feature for searching by series title or series # id. This will =
deploy before end of week.<br>=C2=A0 =C2=A0* Working on embedding the code =
coverage reports in the dashboard<br>=C2=A0 =C2=A0* Working on embedding th=
e code coverage reports in the dashboard such that the reports don=E2=80=99=
t have to be manually downloaded and opened by users<br>=C2=A0 =C2=A0 =C2=
=A0 * We should also begin running the coverage reports on a per series bas=
is<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Can produce json output from gcov=
/lcov, and compare the =E2=80=9Cbasline=E2=80=9D json coverage to a new res=
ult<br>* ABI testing: We have been running ABI tests for 24.11 and main for=
 the past few weeks, but still need to backfill ABI results for patches sub=
mitted immediately after 24.11 released. We can put these into queue today.=
<br>* The lab will have a little downtime next week for infra maintenance, =
which will be announced the day before on the mailing list.<br><br>--------=
-------------------------------------------------------------<br>Intel Lab<=
br>* None<br><br>----------------------------------------------------------=
-----------<br>Github Actions<br>* None<br><br>----------------------------=
-----------------------------------------<br>Loongarch Lab<br>* None<br><br=
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improve=
ments &amp; Test Development<br>* Series Patrick should review:<br>=C2=A0 =
=C2=A0* Dean: queue start stop<br>=C2=A0 =C2=A0* Nick: ethertype test suite=
<br>=C2=A0 =C2=A0* Softnic testsuite<br>=C2=A0 =C2=A0 =C2=A0 * V3 is submit=
ted<br>=C2=A0 =C2=A0 =C2=A0 * * Perf testing:<br>=C2=A0 =C2=A0* UNH team ha=
s been investigating performance traffic generators<br>=C2=A0 =C2=A0 =C2=A0=
 * Trex<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Have just been testing the t=
rex api for setting traffic streams, collecting stats etc.<br>=C2=A0 =C2=A0=
 =C2=A0 * Dperf<br>=C2=A0 =C2=A0 =C2=A0 * Need to decide on collecting stat=
s via trex API vs testpmd when writing the single core forwarding perf test=
<br>=C2=A0 =C2=A0* Luca proposes an abstraction for creating files on the D=
TS nodes, such that we don=E2=80=99t have to manually create and copy files=
 requires for DTS testsuites.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Next Meeting January 23<br=
>* Azure:<br>=C2=A0 =C2=A0* Currently using a =E2=80=9CLisa=E2=80=9D test f=
ramework for managing nodes and running some tests<br>=C2=A0 =C2=A0* Aiming=
 to leverage DTS in the future<br>=C2=A0 =C2=A0* Can we get 2 nodes on the =
same l2 networking?<br>=C2=A0 =C2=A0 =C2=A0 * Not really on Azure, so we wo=
uld need to provide support for tests through l3 routing.</div>

--000000000000f7f09f0630414298--
