Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E493C28B30
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Mar 2025 17:16:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCE3C40277;
	Sun, 23 Mar 2025 18:16:33 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id DEA5040150
 for <dev@dpdk.org>; Sun, 23 Mar 2025 18:16:31 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-30332dfc821so1010220a91.3
 for <dev@dpdk.org>; Sun, 23 Mar 2025 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1742750191; x=1743354991; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=opCZYwGGdgfqshZLjp4uBog8cIN/pECe2B1Xd1FLy4k=;
 b=Y0PWsnylBsm6wVzN69upUshx0LfldrR770QVNE/7yaHUJGK5MmpKiKPSgwZdDO6rsQ
 R1lnLT4H/M2DevyKrbie+QjtJB2/oe/7T3nUrfDpcdYQUiKalCEt7YVAvxLUT5K48Xbb
 gxZf9liXODwuoa24UeyQKOHrhcQTVRqzV2w9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742750191; x=1743354991;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=opCZYwGGdgfqshZLjp4uBog8cIN/pECe2B1Xd1FLy4k=;
 b=ktqU4k7BYHwW07+yZgQDjJgmjfDJX4xnLrhHVMlxEGE0uC4ca7v869549YcTFYjlEx
 mGbnLhqJQeKLHRxbQcdhQNdBeMJlZg4hb4Mm5bu0KrFGLYfjZ6U7eNrtUanJcixzi0kf
 NddlRBDyeWoyRqM70eXP5dfKFUYAbksKxmWKB15wIOyywF0kT3FWQ5UVqCj6KVXFMxxE
 InE2Dwy3WnI4RwnoGToFgBg5n0Uj4K/UXF45+90Syiwf5on8kovXOkWoFFuNNmWANwr0
 Blr5WXvKMvVYbDxN5KP77g0Ap8smbHuwAhKXdZgx0Iqxej28eqI+dfjwoQg2b1Pr+F2s
 oQfg==
X-Gm-Message-State: AOJu0YzHDMmkB/yK6DHV/0N9kTVeOTlar6M1VuUf3BTQZLCFV24XYEao
 SlQLA6mnJu/i2qKWk/WTUQ6IR7Y4vvR7EnGea1zqbiHpWcTL02Cx76ZMLJ019Xh5UHFmoKWp9Y2
 +KqEnu1NnpPybsuUPkkud9kbsUXyybQj51aZ6mN/xQm28R7sXnEV3vg==
X-Gm-Gg: ASbGncs3T1U4ggETs83xnQeaLshIcEjLoN9aDuN50mH4bkAhrCltOmRKyn9NthCFjpV
 QUhJKH6pf/mZLN5MMlDUqM2ntniVtjq9jzhpdRhhniL9RRRigrTeaUqQT7JbfuXQ92llfkb06vp
 lNr5h9dZ3RkrLRN/XChbd2ZbT1
X-Google-Smtp-Source: AGHT+IHWmuKTSR63EqNL5VxObqRgQkY9XhUFR7g1gg0zx6yL6cFeeQ/16JpSy8aY/iV6K8BKIHDX2vbdMC+vaWEf948=
X-Received: by 2002:a17:90b:3906:b0:2ee:aa28:79aa with SMTP id
 98e67ed59e1d1-3030fe8be5dmr13253785a91.6.1742750190107; Sun, 23 Mar 2025
 10:16:30 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 23 Mar 2025 13:12:38 -0400
X-Gm-Features: AQ5f1Jo2Fwd1eMwYCtZtr3vbDGaVXtLjRCLF83YCnZEpBguX0CX8Ml7M2z1AqP8
Message-ID: <CAJvnSUDH6BG5V3whEcii8Cybm0e7mNqqgSFQO1JKWAOssLXkVA@mail.gmail.com>
Subject: Community CI Meeting Minutes - March 20, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000039ced063105a60c"
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

--000000000000039ced063105a60c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
March 20, 2025
Attendees
1. Patrick Robb
2. Paul Szczepanek
3. Luca Vizzarro
4. Cody Cheng
5. Aaron Conole
6. Matthew McGovern
7. Dean Marx

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* RC3 has been released
   * Next-dts has been pulled to main
   * DPDK 25.03 will be released in a few days
* Pw-ci project: Aaron is syncing his internal repo to the upstream
   * Adds recheck support, and other reporting scripts

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* New DTS:
   * Running a broader set of =E2=80=9Cnew DTS=E2=80=9D tests on Intel XL71=
0 and CX5 NICs
now:
      * Unified Packet
      * Promiscuous Support
      * PMD Buffer Scatter
      * Dynamic Queue Config
      * Dynamic Config
      * MAC Filter
* Cody has begun work on setting up a VM which will be locked to the
minimum kernel version supported by DPDK - this system will do build tests.
   * According to DPDK docs, that is kernel version 4.19, but it links to a
kernel mirror site which indicates a newer minimum supported kernel - Cody
is going to reach out on the mailing list for clarification
* The patch adding patch series dependency support to DPDK Patchwork has
been accepted:
https://patchwork.ozlabs.org/project/patchwork/list/?series=3D442332&state=
=3D*
   * We will need to work with Ali after the next patchwork release to get
the DPDK Patchwork instance updated to the latest release
* Build failure emails:
   * Build failure emails were not including the Meson and Ninja logs due
to a bad HTTP server reconfiguration we had deployed. This issue is now
resolved and we see the most recent build failure comes with the relevant
logs.

   ---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions
* Cirrus CI: No one is working on the FreeBSD support, so unit tests still
fail, and this decreases the value added by Cirrus CI
* Working on an update which will associate a run number with a recheck
request

---------------------------------------------------------------------
AWS
* They are working on their test-report email templating script
* There was some conversation at the joint Governing Board and Tech Board
meeting about platforms AWS will run from and their testing goals:
   * Platforms: includes x86 and ARM Graviton based systems
   * Goals: Will setup a CI lab which will target build and unit tests
first, then target some functional and performance testing with DTS.

---------------------------------------------------------------------
Loongarch Lab
* None


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* DTS Packet Sniffer update:
   * Breaks the sniffer out into a new class which is run separately from
Scapy TG class
   * It can start/stop and collect packets whenever directed to do so via
the TestSuite API
   * Async sniffer will run throughout the entire testrun instead of
starting and stopping.
   * Adds a facility to trigger a stop condition for the sniffer (like stop
as soon as you sniff packet X)
      * This is not exposed via the TestSuite API currently
   * Currently Sniffer is integrated into the scapy class, but there is no
particular reason for this - it could reasonably be moved to the TestSuite
and exposed
* DTS Roadmap 25.07
   * Rte_flow
   * Performance TG and forwarding tests
   * Improved documentation
   * TestSuite API
      * Paul is interested in moving from the TestSuite class as API to a
=E2=80=9CDPDK=E2=80=9D API for DTS testsuites. This would involved committi=
ng to a stable
API. We would be able to change framework internals without breaking
testsuites.
      * The biggest advantage would be discoverability for a new test
writer who has not seen DTS before
   * Cloud environment support for DTS
   * VF Support
* VF support:
   * No movement on the VF support series
* TestSuite Development:
   * Dean has submitted updates for unified packet testsuite and checksum
offload testsuite which switches from matching packets on mac dst address
to relying on l4 port number.
* Testrun duration:
   * Perhaps we should profile the testsuites into different buckets and
add config options for running certain groups of tests
   * By keeping the sniffer process on the entire time, we will cut out a
lot of time waiting for sniffer to start and stop
   * One option would be to keep testpmd open through the entire testrun,
and just reset it for each testsuite without restarting it and going
through EAL bring up (takes a few seconds). On the other hand, the appeal
of restarting testpmd completely is we know it is totally reset.
      * Possible keep 1 testpmd shell per testsuite, and that testsuite is
responsible for cleaning up the shell properly in between testcases

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Azure: We got more details from Matthew about the DPDK testing goals for
Microsoft Azure
   * Environments: They can run testing on cloud instances based on Intel
x86, AMD x86, and ARM systems
   * Mellanox NICs are available to some cloud instances on Azure
   * They would like to run functional and performance tests and products
reports for those for dpdk.org
      * Performance tests: will be simple single and multi-queue testpmd
MPPS forwarding tests
   * They cannot commit to a report cadence right now, but discussed the
idea of releasing a report per DPDK release, as well as rolling reports on
main
* Next Meeting Apr 3, 2025

--000000000000039ced063105a60c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>March 20, 2025<br>Attendees<br>1. Patrick Robb<br>2. Paul Sz=
czepanek<br>3. Luca Vizzarro<br>4. Cody Cheng<br>5. Aaron Conole<br>6. Matt=
hew McGovern<br>7. Dean Marx<br><br>#######################################=
##############################<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<br>* RC3 has bee=
n released<br>=C2=A0 =C2=A0* Next-dts has been pulled to main<br>=C2=A0 =C2=
=A0* DPDK 25.03 will be released in a few days<br>* Pw-ci project: Aaron is=
 syncing his internal repo to the upstream<br>=C2=A0 =C2=A0* Adds recheck s=
upport, and other reporting scripts<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>---------------=
------------------------------------------------------<br>UNH-IOL Community=
 Lab<br>* New DTS:<br>=C2=A0 =C2=A0* Running a broader set of =E2=80=9Cnew =
DTS=E2=80=9D tests on Intel XL710 and CX5 NICs now:<br>=C2=A0 =C2=A0 =C2=A0=
 * Unified Packet<br>=C2=A0 =C2=A0 =C2=A0 * Promiscuous Support<br>=C2=A0 =
=C2=A0 =C2=A0 * PMD Buffer Scatter<br>=C2=A0 =C2=A0 =C2=A0 * Dynamic Queue =
Config<br>=C2=A0 =C2=A0 =C2=A0 * Dynamic Config<br>=C2=A0 =C2=A0 =C2=A0 * M=
AC Filter<br>* Cody has begun work on setting up a VM which will be locked =
to the minimum kernel version supported by DPDK - this system will do build=
 tests.<br>=C2=A0 =C2=A0* According to DPDK docs, that is kernel version 4.=
19, but it links to a kernel mirror site which indicates a newer minimum su=
pported kernel - Cody is going to reach out on the mailing list for clarifi=
cation<br>* The patch adding patch series dependency support to DPDK Patchw=
ork has been accepted: <a href=3D"https://patchwork.ozlabs.org/project/patc=
hwork/list/?series=3D442332&amp;state=3D*">https://patchwork.ozlabs.org/pro=
ject/patchwork/list/?series=3D442332&amp;state=3D*</a><br>=C2=A0 =C2=A0* We=
 will need to work with Ali after the next patchwork release to get the DPD=
K Patchwork instance updated to the latest release<br>* Build failure email=
s:<br>=C2=A0 =C2=A0* Build failure emails were not including the Meson and =
Ninja logs due to a bad HTTP server reconfiguration we had deployed. This i=
ssue is now resolved and we see the most recent build failure comes with th=
e relevant logs.<br>=C2=A0 =C2=A0<br>=C2=A0 =C2=A0-------------------------=
--------------------------------------------<br>Intel Lab<br>* None<br><br>=
---------------------------------------------------------------------<br>Gi=
thub Actions<br>* Cirrus CI: No one is working on the FreeBSD support, so u=
nit tests still fail, and this decreases the value added by Cirrus CI<br>* =
Working on an update which will associate a run number with a recheck reque=
st<br><br>-----------------------------------------------------------------=
----<br>AWS<br>* They are working on their test-report email templating scr=
ipt<br>* There was some conversation at the joint Governing Board and Tech =
Board meeting about platforms AWS will run from and their testing goals:<br=
>=C2=A0 =C2=A0* Platforms: includes x86 and ARM Graviton based systems<br>=
=C2=A0 =C2=A0* Goals: Will setup a CI lab which will target build and unit =
tests first, then target some functional and performance testing with DTS.<=
br>=C2=A0 =C2=A0<br>-------------------------------------------------------=
--------------<br>Loongarch Lab<br>* None<br><br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Develop=
ment<br>* DTS Packet Sniffer update:<br>=C2=A0 =C2=A0* Breaks the sniffer o=
ut into a new class which is run separately from Scapy TG class<br>=C2=A0 =
=C2=A0* It can start/stop and collect packets whenever directed to do so vi=
a the TestSuite API<br>=C2=A0 =C2=A0* Async sniffer will run throughout the=
 entire testrun instead of starting and stopping.<br>=C2=A0 =C2=A0* Adds a =
facility to trigger a stop condition for the sniffer (like stop as soon as =
you sniff packet X)<br>=C2=A0 =C2=A0 =C2=A0 * This is not exposed via the T=
estSuite API currently<br>=C2=A0 =C2=A0* Currently Sniffer is integrated in=
to the scapy class, but there is no particular reason for this - it could r=
easonably be moved to the TestSuite and exposed <br>* DTS Roadmap 25.07<br>=
=C2=A0 =C2=A0* Rte_flow<br>=C2=A0 =C2=A0* Performance TG and forwarding tes=
ts<br>=C2=A0 =C2=A0* Improved documentation<br>=C2=A0 =C2=A0* TestSuite API=
<br>=C2=A0 =C2=A0 =C2=A0 * Paul is interested in moving from the TestSuite =
class as API to a =E2=80=9CDPDK=E2=80=9D API for DTS testsuites. This would=
 involved committing to a stable API. We would be able to change framework =
internals without breaking testsuites.<br>=C2=A0 =C2=A0 =C2=A0 * The bigges=
t advantage would be discoverability for a new test writer who has not seen=
 DTS before<br>=C2=A0 =C2=A0* Cloud environment support for DTS<br>=C2=A0 =
=C2=A0* VF Support<br>* VF support:<br>=C2=A0 =C2=A0* No movement on the VF=
 support series<br>* TestSuite Development:<br>=C2=A0 =C2=A0* Dean has subm=
itted updates for unified packet testsuite and checksum offload testsuite w=
hich switches from matching packets on mac dst address to relying on l4 por=
t number.<br>* Testrun duration:<br>=C2=A0 =C2=A0* Perhaps we should profil=
e the testsuites into different buckets and add config options for running =
certain groups of tests<br>=C2=A0 =C2=A0* By keeping the sniffer process on=
 the entire time, we will cut out a lot of time waiting for sniffer to star=
t and stop<br>=C2=A0 =C2=A0* One option would be to keep testpmd open throu=
gh the entire testrun, and just reset it for each testsuite without restart=
ing it and going through EAL bring up (takes a few seconds). On the other h=
and, the appeal of restarting testpmd completely is we know it is totally r=
eset.<br>=C2=A0 =C2=A0 =C2=A0 * Possible keep 1 testpmd shell per testsuite=
, and that testsuite is responsible for cleaning up the shell properly in b=
etween testcases<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D<br>Any other business<br>* Azure: We got more details from Matthew a=
bout the DPDK testing goals for Microsoft Azure<br>=C2=A0 =C2=A0* Environme=
nts: They can run testing on cloud instances based on Intel x86, AMD x86, a=
nd ARM systems<br>=C2=A0 =C2=A0* Mellanox NICs are available to some cloud =
instances on Azure<br>=C2=A0 =C2=A0* They would like to run functional and =
performance tests and products reports for those for <a href=3D"http://dpdk=
.org">dpdk.org</a><br>=C2=A0 =C2=A0 =C2=A0 * Performance tests: will be sim=
ple single and multi-queue testpmd MPPS forwarding tests<br>=C2=A0 =C2=A0* =
They cannot commit to a report cadence right now, but discussed the idea of=
 releasing a report per DPDK release, as well as rolling reports on main<br=
>* Next Meeting Apr 3, 2025<br></div>

--000000000000039ced063105a60c--
