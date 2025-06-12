Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4ACC71149
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Jun 2025 15:58:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA9EE42796;
	Thu, 12 Jun 2025 17:58:00 +0200 (CEST)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by mails.dpdk.org (Postfix) with ESMTP id 601AF42789
 for <dev@dpdk.org>; Thu, 12 Jun 2025 17:57:59 +0200 (CEST)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-b2c40a7ca6eso989792a12.1
 for <dev@dpdk.org>; Thu, 12 Jun 2025 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1749743878; x=1750348678; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zSlTI1RzUIOuTNFmMA/QZx2W5I2IyNlir+VXfVR99Os=;
 b=JidJMmUnEf4fMB6co21IZgR5q4PzGHlwXegxvKpQ1bvDC5IDeJ2a1D8EqSb9oxqBha
 rBIqoJ9YNti04egWs/xPYcJJJtEj+9i8Xehw99PBroUOVLSSVEg23LFio41mFimTUuEs
 wId7SfqOYtFdhG/r1y8j5S6f1zsVCQoOmM5xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749743878; x=1750348678;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zSlTI1RzUIOuTNFmMA/QZx2W5I2IyNlir+VXfVR99Os=;
 b=DsRv8Km5qp7Bx5DTB8TP6dKZwvrURg9S6hkZC5lg1lneVUmaTu6DV7IzA9o71E+txt
 IXmfczILgds2Aq2IBFh6tcUt0FFm6Bd0rO/kjpAiinRRCCFSC3uLjX97a3a+tsw14+1T
 bp6MeN1z+DRKxGD47+LP6aYB+Tx3VMEJ/7OGi05briSFC8m4KZGddsy5k7vgNzoCYY7Y
 bDp+Xl5Z0Dy9jDkmgv1y+dw6/Drcnu/GIKW8tDiEcuZg1ekbi/+Rddno5fz5b9RVq1mn
 f/qwfQVhb3wNbzYS6/JGxpBx6anDXmsZnUDJodOIHhIDpDGza9FzgGrLGEPvtTqfIjQg
 O+uA==
X-Gm-Message-State: AOJu0YzXKCtPL75cSsOn97ievEat8OLzbuIWl4FYE9GqqtYKUDTPcTXG
 mDcGQOwp0ROWAd3Am0VY2c93RdilVZSb/xX9B+kZrP+qEXk8XL5ssZ9qPP06ihKVUGZaVyIFeoe
 anaKkkBZMw+XhKpV6H2GOLKujLcadZQaSV0iTHsTOEQ==
X-Gm-Gg: ASbGncvee2z+/wazCEB/UPqTrS6o6qu7cLVEEjJ6LmU5e09I9uRAbc39P+K5i4gQN1N
 vKg1W40Ec2977DvDWtq+th2RJH8XpU53F/ZM+sFjogj2kdNg3c2HOVLb6/xNSeggd4EhJ6YAm2N
 YDHZf4L0Zn6hS9AYpLqhMtUhBjdlovJCj0cqIKEoI6sMev4oIGTa2hcvvfWgIVxTdm+H6z/w==
X-Google-Smtp-Source: AGHT+IEMqASX8pCMLx4Hfpw9lqVlFbMQZmFrrG1/JIr363nQncG79O3EDPWDKGRjIgysg4vLStw/Mx6iAuA6jvdFJHs=
X-Received: by 2002:a17:90b:28c3:b0:311:f05b:86a5 with SMTP id
 98e67ed59e1d1-313aefe90b1mr14577444a91.0.1749743877900; Thu, 12 Jun 2025
 08:57:57 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 12 Jun 2025 11:52:47 -0400
X-Gm-Features: AX0GCFuBLuc1EdUtscwd89hs5vL2cIWOyz2XSILVQRn3LuU6ky2xzANLD1G7yXA
Message-ID: <CAJvnSUAnqP9j9ownmdAgZVOVvJRx3odrsLWiTxt+W5cc3dTCDg@mail.gmail.com>
Subject: Community CI Meeting Minutes - June 12, 2025
To: "ci@dpdk.org" <ci@dpdk.org>
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000004a5e88063761fee3"
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

--0000000000004a5e88063761fee3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
June 12, 2025
Attendees
1. Patrick Robb
2. Paul Szczepanek
3. Aaron Conole
4. Manit Mahajan
5. Dean Marx

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* DPDK 25.07 RC1 has been released. RC2 is expected in two weeks.
* We should consider setting a new regular timeslot(s) for this meeting. To
that end, participants please fill out this =E2=80=9Cwhen to meet=E2=80=9D =
survey:
https://www.when2meet.com/?30965992-3ijyI
* Will we have CI Community representation at DPDK Summit Santa Clara in
September?
   * Yes, Patrick will most likely be able to go
   * There may be limited tech board representation there
   * If it were possible to do a demo demonstrating DTS running with a
limited hardware topology (even single dual interface NIC connected with
single link loopback between the two ports) that would be interesting for
participants.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* Manit=E2=80=99s new =E2=80=9Ctest system environment info updater=E2=80=
=9D tool which updates
test system info (like gcc version, kernel version, etc.) has been running
for a few weeks mostly without issue.
   * David did find one issue, which is that it broke the Arch Linux badge
(shows current arch compile status) for Patchwork, since the arch
environment had some info updated which broke how the Community Lab
Dashboard accessed the arch info. This is now fixed:
https://lab.dpdk.org/badges/archlinux
* Thomas raised the subject of testing wait times on Slack. There were a
couple of blocked test jobs yesterday which contributed to this but we are
mostly caught up now.
   * Also, we failed to grab a particular patchseries off Patchwork
yesterday, and this is because the latest series that had come in had a
very old series id (UNH guys were unaware that this behavior was possible).
We will need to adjust our series polling script.
   * It may make sense to make series polling process more common across
labs. UNH lab uses a database to store the most recent patch processed, and
poll-pw.sh stores the most recent patch timestamp in a file, so any new
polling script should allow the series filter timestamp to be passed in as
a script argument.
* Windows MSVC Build:
   * This test has been failing on mainline, and the compile results table
we are emailing out properly represents this, but the topline test status
for the test report is WARN instead of FAIL which is incorrect. UNH guys
will resolve ASAP.

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions Robot
* Discussion at tech board about using the github robot infra to
incorporate creating PRs against a DPDK repo for an AI tool (sourcery.ai)
which will provide summaries of patchseries.
   * It would be nice if this could be pulled from Github and pushed to the
mailing list so people don=E2=80=99t have to look at two places.

---------------------------------------------------------------------
AWS Lab
* There have been some patches which got a meson fast tests failure
reported from AWS, though the logs in the test report body indicate all the
tests passed or skipped.
   * Shai emailed back saying it was due to an apply failure for the
release notes .rst file, and that he has seen this a couple of times
previously from other labs too and asked about us adopting a strategy to
mitigate this:
https://mails.dpdk.org/archives/test-report/2025-May/881787.html
   * Also, regardless of us adopting a strategy to mitigate this, they
should report an apply failure and bail out of running testing when this
happens
* Do we have any strategies for mitigating apply errors coming from patches
which update the release notes .rst file? No, we don=E2=80=99t have any str=
ategies
for this right now other than in dpdk-ci create_series_artifact.py we try
to apply on multiple trees before reporting an apply failure.
   * Users can submit a recheck request and specify the rebase=3D{branch}
argument to manually fix this situation if the issue is that their patch
was applied to the wrong tree.

---------------------------------------------------------------------
Loongson Lab
* Patchseries recheck support: Loongson lab is supporting the recheck
framework. Their default behavior to re-apply commits on HEAD when a
recheck is requested.
   * Patrick and Min Zhou are discussing support for the branch rebase
argument. To that end, there is a patch submitted for dpdk-ci which allows
for capturing the branch rebase argument:
https://patchwork.dpdk.org/project/ci/patch/20250611205849.72165-1-probb@io=
l.unh.edu/

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Virtual Function testing:
   * v3 is refactored such that topology.py handles creating the VFs on
sut_node as needed, setting trust mode on the VFs, instantiating the VF
Ports in DTS, and assigning those VF Port objects to SUT =E2=80=9Cingress=
=E2=80=9D and SUT
=E2=80=9Cegress=E2=80=9D attribute on topology.py
      * Remaining work:
         * Add a teardown process (just echoing 0 into the sriov_numvfs
file)
         * Testsuite which sends packets between VFs
* Bugs:
   * Dean is currently investigating a bug coming from a recent patch in
which dpdk-devbind.py is not being copied to the SUT system in the correct
order, causing intermittent failures to bind the SUT ports.
   * Improve port handling patch: For one XL710 test system, no ports are
created and DTS fails during testrun setup with this patch applied.
* DTS orientation videos:
   * Dean has been filming some DTS orientation videos showing:
      * 1. How to run DTS
      * 2. Explaining the testsuite structure and how to write testsuites
      * 3. More topics to come=E2=80=A6
* The TREX Support and nic_single_core_perf testsuite needs the v2 version
submitted by next week at the latest.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting Jun 12, 2025

--0000000000004a5e88063761fee3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>June 12, 2025<br>Attendees<br>1. Patrick Robb<br>2. Paul Szc=
zepanek<br>3. Aaron Conole<br>4. Manit Mahajan<br>5. Dean Marx<br><br>#####=
################################################################<br>Minutes=
<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Gener=
al Announcements<br>* DPDK 25.07 RC1 has been released. RC2 is expected in =
two weeks.<br>* We should consider setting a new regular timeslot(s) for th=
is meeting. To that end, participants please fill out this =E2=80=9Cwhen to=
 meet=E2=80=9D survey: <a href=3D"https://www.when2meet.com/?30965992-3ijyI=
">https://www.when2meet.com/?30965992-3ijyI</a><br>* Will we have CI Commun=
ity representation at DPDK Summit Santa Clara in September?<br>=C2=A0 =C2=
=A0* Yes, Patrick will most likely be able to go<br>=C2=A0 =C2=A0* There ma=
y be limited tech board representation there<br>=C2=A0 =C2=A0* If it were p=
ossible to do a demo demonstrating DTS running with a limited hardware topo=
logy (even single dual interface NIC connected with single link loopback be=
tween the two ports) that would be interesting for participants.<br><br>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>=
---------------------------------------------------------------------<br>UN=
H-IOL Community Lab<br>* Manit=E2=80=99s new =E2=80=9Ctest system environme=
nt info updater=E2=80=9D tool which updates test system info (like gcc vers=
ion, kernel version, etc.) has been running for a few weeks mostly without =
issue.<br>=C2=A0 =C2=A0* David did find one issue, which is that it broke t=
he Arch Linux badge (shows current arch compile status) for Patchwork, sinc=
e the arch environment had some info updated which broke how the Community =
Lab Dashboard accessed the arch info. This is now fixed: <a href=3D"https:/=
/lab.dpdk.org/badges/archlinux">https://lab.dpdk.org/badges/archlinux</a><b=
r>* Thomas raised the subject of testing wait times on Slack. There were a =
couple of blocked test jobs yesterday which contributed to this but we are =
mostly caught up now.<br>=C2=A0 =C2=A0* Also, we failed to grab a particula=
r patchseries off Patchwork yesterday, and this is because the latest serie=
s that had come in had a very old series id (UNH guys were unaware that thi=
s behavior was possible). We will need to adjust our series polling script.=
<br>=C2=A0 =C2=A0* It may make sense to make series polling process more co=
mmon across labs. UNH lab uses a database to store the most recent patch pr=
ocessed, and poll-pw.sh stores the most recent patch timestamp in a file, s=
o any new polling script should allow the series filter timestamp to be pas=
sed in as a script argument.<br>* Windows MSVC Build:<br>=C2=A0 =C2=A0* Thi=
s test has been failing on mainline, and the compile results table we are e=
mailing out properly represents this, but the topline test status for the t=
est report is WARN instead of FAIL which is incorrect. UNH guys will resolv=
e ASAP.<br><br>------------------------------------------------------------=
---------<br>Intel Lab<br>* None<br><br>-----------------------------------=
----------------------------------<br>Github Actions Robot<br>* Discussion =
at tech board about using the github robot infra to incorporate creating PR=
s against a DPDK repo for an AI tool (<a href=3D"http://sourcery.ai">source=
ry.ai</a>) which will provide summaries of patchseries.<br>=C2=A0 =C2=A0* I=
t would be nice if this could be pulled from Github and pushed to the maili=
ng list so people don=E2=80=99t have to look at two places.<br><br>--------=
-------------------------------------------------------------<br>AWS Lab<br=
>* There have been some patches which got a meson fast tests failure report=
ed from AWS, though the logs in the test report body indicate all the tests=
 passed or skipped. <br>=C2=A0 =C2=A0* Shai emailed back saying it was due =
to an apply failure for the release notes .rst file, and that he has seen t=
his a couple of times previously from other labs too and asked about us ado=
pting a strategy to mitigate this: <a href=3D"https://mails.dpdk.org/archiv=
es/test-report/2025-May/881787.html">https://mails.dpdk.org/archives/test-r=
eport/2025-May/881787.html</a><br>=C2=A0 =C2=A0* Also, regardless of us ado=
pting a strategy to mitigate this, they should report an apply failure and =
bail out of running testing when this happens<br>* Do we have any strategie=
s for mitigating apply errors coming from patches which update the release =
notes .rst file? No, we don=E2=80=99t have any strategies for this right no=
w other than in dpdk-ci create_series_artifact.py we try to apply on multip=
le trees before reporting an apply failure.<br>=C2=A0 =C2=A0* Users can sub=
mit a recheck request and specify the rebase=3D{branch} argument to manuall=
y fix this situation if the issue is that their patch was applied to the wr=
ong tree.<br><br>----------------------------------------------------------=
-----------<br>Loongson Lab<br>* Patchseries recheck support: Loongson lab =
is supporting the recheck framework. Their default behavior to re-apply com=
mits on HEAD when a recheck is requested. <br>=C2=A0 =C2=A0* Patrick and Mi=
n Zhou are discussing support for the branch rebase argument. To that end, =
there is a patch submitted for dpdk-ci which allows for capturing the branc=
h rebase argument: <a href=3D"https://patchwork.dpdk.org/project/ci/patch/2=
0250611205849.72165-1-probb@iol.unh.edu/">https://patchwork.dpdk.org/projec=
t/ci/patch/20250611205849.72165-1-probb@iol.unh.edu/</a><br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; =
Test Development<br>* Virtual Function testing:<br>=C2=A0 =C2=A0* v3 is ref=
actored such that topology.py handles creating the VFs on sut_node as neede=
d, setting trust mode on the VFs, instantiating the VF Ports in DTS, and as=
signing those VF Port objects to SUT =E2=80=9Cingress=E2=80=9D and SUT =E2=
=80=9Cegress=E2=80=9D attribute on topology.py <br>=C2=A0 =C2=A0 =C2=A0 * R=
emaining work:<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Add a teardown proces=
s (just echoing 0 into the sriov_numvfs file)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0* Testsuite which sends packets between VFs<br>* Bugs:<br>=C2=A0 =
=C2=A0* Dean is currently investigating a bug coming from a recent patch in=
 which dpdk-devbind.py is not being copied to the SUT system in the correct=
 order, causing intermittent failures to bind the SUT ports.<br>=C2=A0 =C2=
=A0* Improve port handling patch: For one XL710 test system, no ports are c=
reated and DTS fails during testrun setup with this patch applied.<br>* DTS=
 orientation videos:<br>=C2=A0 =C2=A0* Dean has been filming some DTS orien=
tation videos showing:<br>=C2=A0 =C2=A0 =C2=A0 * 1. How to run DTS<br>=C2=
=A0 =C2=A0 =C2=A0 * 2. Explaining the testsuite structure and how to write =
testsuites<br>=C2=A0 =C2=A0 =C2=A0 * 3. More topics to come=E2=80=A6<br>* T=
he TREX Support and nic_single_core_perf testsuite needs the v2 version sub=
mitted by next week at the latest.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Next Meeting Jun 12, 20=
25<br><br></div>

--0000000000004a5e88063761fee3--
