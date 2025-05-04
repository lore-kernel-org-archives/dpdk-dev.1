Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C093C369DC
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 May 2025 21:54:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 40243402DF;
	Sun,  4 May 2025 23:54:38 +0200 (CEST)
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44]) by mails.dpdk.org (Postfix) with ESMTP id 4A8A44025D
 for <dev@dpdk.org>; Sun,  4 May 2025 23:54:37 +0200 (CEST)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-3015001f862so2787368a91.3
 for <dev@dpdk.org>; Sun, 04 May 2025 14:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1746395676; x=1747000476; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8kh2XZbhVMNMJG0o/f+1yskf/0RBlXldUQgPBa4ssrM=;
 b=apdWUscjbhBPnSITyXYCqVfGQZLnsGDqEnC2PeDUQeXRT7/RkDGLVmq2SdgQ1Gnwrp
 gbW0SW6CXX7ZqQhiWDzt0mD5buplcdRXHdPn7JoZwD6HOQ9V6G6+1lPJDu+APAbFH5q3
 Fy7ocR12ECx0b3E7KULxJUOyOgs3pVUdwS/cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395676; x=1747000476;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8kh2XZbhVMNMJG0o/f+1yskf/0RBlXldUQgPBa4ssrM=;
 b=Unlb1HOJvkiRntn8zbMVshDd4Ycm8lV1yZ3Sj7cfNy30mpeTS2auogsAE3GmtO+5eX
 LrEyK1aQ4ZvOyN/+GKOD1K6WM9LZPX60LKyrSWD/1yZAPVqLfJAH5kg7V9IGTmByc185
 a4/uUUOYAswonFutQJpl4pgeMmD+eT6KR0BTT7w+LX/HPjOsbTV3JGpqYoaZZ0ESVbDA
 iWLBEVxVFfmUJVHL8vbwIiYF02fFFI72ymwE+8A3HfPhgqBbag/F/7mjOd/ySsX19F45
 1VPRlfQVM0wOj92NfJ2pDMKvzsIJ19i9k344s1DU6OSryxh1UeE7cbRtAt3st3k01ZFX
 9hyA==
X-Gm-Message-State: AOJu0YyIaEUZHtQS01teLzymTmI16Te88P9DZP6Y6jIZqgguZqlZEvQ4
 2V9WyiNKNrESi/3NBC9EMTeAcLH+pe5cP8mXpDjtlx5pPIQ5F7DBXUw40hJ0uwPR31mfCNDbIl6
 OlS7Nt4BS/QvE8ZAkVwO4rzVedh10FJb+pHsP9Q==
X-Gm-Gg: ASbGnctIT/z1e8GCh83Lp4MjMsbWP2wBft2IKU1zj2+QUT1Z74J5Pn7jFXnHSRneOG4
 orNXKRL1DephffTn9e4W4Ug9i/KPzFyxdkrQ+BOzhr3ljUYYtwuQGrr90NIrJ6/DBaWk6EbylUi
 DibvkSLxajnE/3UlLUvNrgkH8UkEYVJMAPBmWDUz0Rz0d7cMEZw4F2YH4nETxpDbN2LQ==
X-Google-Smtp-Source: AGHT+IE38+FzXcF5iTRhOp7pRHHBgj63QuWJju97RT46C1v9q4IKt1IDSbYNZ0dniBCgBR6RkPvApSi7nsO7iH1JR20=
X-Received: by 2002:a17:90b:2d10:b0:30a:fe:140f with SMTP id
 98e67ed59e1d1-30a5aebfa2bmr10598045a91.28.1746395675942; Sun, 04 May 2025
 14:54:35 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 4 May 2025 17:50:02 -0400
X-Gm-Features: ATxdqUGE0UuxTMxtkMrW5HLJDe2BloGSumEJIXBUFHqNgKWVHLgT-HBHw85q9CQ
Message-ID: <CAJvnSUCUUaatq-8cNwoB2OTMVdXQxzp1YatYPasKM9gMz_g4yA@mail.gmail.com>
Subject: Community CI Meeting Minutes - May 1, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>, 
 "Brandes, Shai" <shaibran@amazon.com>, ian.stokes@intel.com
Content-Type: multipart/alternative; boundary="000000000000e6f4e60634566d0a"
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

--000000000000e6f4e60634566d0a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
May 1, 2025
Attendees
1. Patrick Robb
2. Paul Szczepanek
3. Luca Vizzarro
4. Aaron Conole

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* DPDK Summit Prague is May 8-9

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* UNH shared out the x86 QAT cryptographic test metrics with Kai Ji, and
have enabled reporting to patchwork for this test in CI
* Baremetal updates:
   * X86 E810 - it looks like we finally have a working solution for this,
which is pairing up two separate E810 NICs (with trex on both) up against 1
dual port e810 NIC acting as the DUT
      * It also requires a patch for the single core forwarding test as it
pertains to how trex crafts the 64 byte frames. After this we can craft 64
byte frames and send at 250 MPPS, which is more than we need.
      * Cody & Patrick can dry run this and then bring it online this week.
* We are trying to add LTS tests for the ARM Grace server, and noticed
there is a meson error for 22.11 and 23.11, which the maintainers indicated
could be resolved by registering the neoverse v2 SOC
   * https://inbox.dpdk.org/dev/bug-1702-3@http.bugs.dpdk.org%2F/
   * https://inbox.dpdk.org/dev/bug-1703-3@http.bugs.dpdk.org%2F/

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions
* There was a partial outage 2 weeks ago. The tests still ran, but the
emails were not sent out (so, no results on patchwork). If you go to your
series URL on github, the results are there. All set now.
* Cirrus CI: work is paused for now. This requires good support for
FreeBSD, which is not happening now - builds are flaky and meson tests are
also not well supported and will not pass.
* Discussion pertaining to looking at polling for series using the events
API. This events endpoint (with series created event) returns info that a
series has been created, but returns a limited set of data in the payload,
and this necessitates a followup request to patchwork. So, this seems like
it would actually increase the amount of requests made to the patchwork
server. Some related issues discussed are:
   * You cannot query the events endpoint for only events from a particular
project (this matters for patchwork instances with many projects under
them). For DPDK there are only 4 projects under DPDK patchwork, so it=E2=80=
=99s not
a huge deal, but still a small issue.
   * The datetime that the series-created event returns is the datetimes of
one of the commits in the series, not the datetime of when the series was
submitted. So, this means that if you amend a commit (this does not update
commit datetime) and resubmit a patchseries, the datetime on the
series-created record will not be =E2=80=9Cupdated=E2=80=9D. This can cause=
 us to miss
series when polling via the events endpoint.

---------------------------------------------------------------------
AWS
* Their CI test lab is now online/reporting to patchwork, and runs a build
+ set of meson fast tests for x86 and ARM systems on AWS:
http://mails.dpdk.org/archives/test-report/2025-April/874152.html
   * Shai (aws) will be at DPDK Prague where we can discuss next steps with
him
   * Next steps is basically using DTS
* Patrick should encourage Shai to join this meeting periodically

---------------------------------------------------------------------
Loongarch Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Rte_flow: Dean sent out his new proposed test plan, based on Thomas
Monjalon=E2=80=99s feedback:
https://inbox.dpdk.org/dev/CABD7UXPfQcvLt4a5YrxSUaH5NNRJzZHjHUtXs9G-jBnNkiJ=
w8w@mail.gmail.com/
* VF tests: Ian Stokes had said a possible footgun for running these with
Intel NICs is that trust mode may have to be set before promiscuous mode
works correctly. Patrick has confirmed that although testpmd =E2=80=9Cshow =
port
info=E2=80=9D will return promiscuous=3Denabled without trust mode, it will=
 not work
properly until you enable trust like:
   * Enable trust: =E2=80=9Cip link set dev ethX vf 1 trust on=E2=80=9D
   * So, the testsuites requiring promisc mode will need this, and it needs
to be run before binding to vfio-pci as it is an ip command
   * From https://access.redhat.com/solutions/2620231 =E2=80=9CEnabling pro=
miscuous
mode on an SR-IOV VF requires "trusted" mode.=E2=80=9D
* Old testsuites which need to be rebased:
   * Port control has been updated and resubmitted:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35098
      * Nick, please test/review and we can merge it
* TREX patchseries:
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D35097
* Luca is refactoring the pdump packet capture testsuite to use the new
dumpcap

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Some lab maintainers have not been joining the CI meetings regularly
   * Does it make sense to have a quarterly =E2=80=9Call hands=E2=80=9D typ=
e meeting in
which all lab maintainers are expected to join? Major points of lab
cooperation could be discussed at these meetings, like patchwork usage
policy/strategies etc.
* Next Meeting May 15, 2025

--000000000000e6f4e60634566d0a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>May 1, 2025<br>Attendees<br>1. Patrick Robb<br>2. Paul Szcze=
panek<br>3. Luca Vizzarro<br>4. Aaron Conole<br><br>#######################=
##############################################<br>Minutes<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<b=
r>* DPDK Summit Prague is May 8-9<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>------------------------------=
---------------------------------------<br>UNH-IOL Community Lab<br>* UNH s=
hared out the x86 QAT cryptographic test metrics with Kai Ji, and have enab=
led reporting to patchwork for this test in CI <br>* Baremetal updates:<br>=
=C2=A0 =C2=A0* X86 E810 - it looks like we finally have a working solution =
for this, which is pairing up two separate E810 NICs (with trex on both) up=
 against 1 dual port e810 NIC acting as the DUT<br>=C2=A0 =C2=A0 =C2=A0 * I=
t also requires a patch for the single core forwarding test as it pertains =
to how trex crafts the 64 byte frames. After this we can craft 64 byte fram=
es and send at 250 MPPS, which is more than we need.<br>=C2=A0 =C2=A0 =C2=
=A0 * Cody &amp; Patrick can dry run this and then bring it online this wee=
k.<br>* We are trying to add LTS tests for the ARM Grace server, and notice=
d there is a meson error for 22.11 and 23.11, which the maintainers indicat=
ed could be resolved by registering the neoverse v2 SOC<br>=C2=A0 =C2=A0* <=
a href=3D"https://inbox.dpdk.org/dev/bug-1702-3@http.bugs.dpdk.org%2F/">htt=
ps://inbox.dpdk.org/dev/bug-1702-3@http.bugs.dpdk.org%2F/</a><br>=C2=A0 =C2=
=A0* <a href=3D"https://inbox.dpdk.org/dev/bug-1703-3@http.bugs.dpdk.org%2F=
/">https://inbox.dpdk.org/dev/bug-1703-3@http.bugs.dpdk.org%2F/</a><br>=C2=
=A0 =C2=A0<br>-------------------------------------------------------------=
--------<br>Intel Lab<br>* None<br><br>------------------------------------=
---------------------------------<br>Github Actions<br>* There was a partia=
l outage 2 weeks ago. The tests still ran, but the emails were not sent out=
 (so, no results on patchwork). If you go to your series URL on github, the=
 results are there. All set now. <br>* Cirrus CI: work is paused for now. T=
his requires good support for FreeBSD, which is not happening now - builds =
are flaky and meson tests are also not well supported and will not pass. <b=
r>* Discussion pertaining to looking at polling for series using the events=
 API. This events endpoint (with series created event) returns info that a =
series has been created, but returns a limited set of data in the payload, =
and this necessitates a followup request to patchwork. So, this seems like =
it would actually increase the amount of requests made to the patchwork ser=
ver. Some related issues discussed are:<br>=C2=A0 =C2=A0* You cannot query =
the events endpoint for only events from a particular project (this matters=
 for patchwork instances with many projects under them). For DPDK there are=
 only 4 projects under DPDK patchwork, so it=E2=80=99s not a huge deal, but=
 still a small issue. <br>=C2=A0 =C2=A0* The datetime that the series-creat=
ed event returns is the datetimes of one of the commits in the series, not =
the datetime of when the series was submitted. So, this means that if you a=
mend a commit (this does not update commit datetime) and resubmit a patchse=
ries, the datetime on the series-created record will not be =E2=80=9Cupdate=
d=E2=80=9D. This can cause us to miss series when polling via the events en=
dpoint.<br>=C2=A0 =C2=A0<br>-----------------------------------------------=
----------------------<br>AWS<br>* Their CI test lab is now online/reportin=
g to patchwork, and runs a build + set of meson fast tests for x86 and ARM =
systems on AWS: <a href=3D"http://mails.dpdk.org/archives/test-report/2025-=
April/874152.html">http://mails.dpdk.org/archives/test-report/2025-April/87=
4152.html</a><br>=C2=A0 =C2=A0* Shai (aws) will be at DPDK Prague where we =
can discuss next steps with him<br>=C2=A0 =C2=A0* Next steps is basically u=
sing DTS<br>* Patrick should encourage Shai to join this meeting periodical=
ly<br><br>-----------------------------------------------------------------=
----<br>Loongarch Lab<br>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Development<br>* Rte_f=
low: Dean sent out his new proposed test plan, based on Thomas Monjalon=E2=
=80=99s feedback: <a href=3D"https://inbox.dpdk.org/dev/CABD7UXPfQcvLt4a5Yr=
xSUaH5NNRJzZHjHUtXs9G-jBnNkiJw8w@mail.gmail.com/">https://inbox.dpdk.org/de=
v/CABD7UXPfQcvLt4a5YrxSUaH5NNRJzZHjHUtXs9G-jBnNkiJw8w@mail.gmail.com/</a><b=
r>* VF tests: Ian Stokes had said a possible footgun for running these with=
 Intel NICs is that trust mode may have to be set before promiscuous mode w=
orks correctly. Patrick has confirmed that although testpmd =E2=80=9Cshow p=
ort info=E2=80=9D will return promiscuous=3Denabled without trust mode, it =
will not work properly until you enable trust like: <br>=C2=A0 =C2=A0* Enab=
le trust: =E2=80=9Cip link set dev ethX vf 1 trust on=E2=80=9D<br>=C2=A0 =
=C2=A0* So, the testsuites requiring promisc mode will need this, and it ne=
eds to be run before binding to vfio-pci as it is an ip command<br>=C2=A0 =
=C2=A0* From <a href=3D"https://access.redhat.com/solutions/2620231">https:=
//access.redhat.com/solutions/2620231</a> =E2=80=9CEnabling promiscuous mod=
e on an SR-IOV VF requires &quot;trusted&quot; mode.=E2=80=9D<br>* Old test=
suites which need to be rebased:<br>=C2=A0 =C2=A0* Port control has been up=
dated and resubmitted: <a href=3D"https://patchwork.dpdk.org/project/dpdk/l=
ist/?series=3D35098">https://patchwork.dpdk.org/project/dpdk/list/?series=
=3D35098</a><br>=C2=A0 =C2=A0 =C2=A0 * Nick, please test/review and we can =
merge it<br>* TREX patchseries: <br>=C2=A0 =C2=A0* <a href=3D"https://patch=
work.dpdk.org/project/dpdk/list/?series=3D35097">https://patchwork.dpdk.org=
/project/dpdk/list/?series=3D35097</a><br>* Luca is refactoring the pdump p=
acket capture testsuite to use the new dumpcap<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Some lab ma=
intainers have not been joining the CI meetings regularly<br>=C2=A0 =C2=A0*=
 Does it make sense to have a quarterly =E2=80=9Call hands=E2=80=9D type me=
eting in which all lab maintainers are expected to join? Major points of la=
b cooperation could be discussed at these meetings, like patchwork usage po=
licy/strategies etc.<br>* Next Meeting May 15, 2025<br><br></div>

--000000000000e6f4e60634566d0a--
