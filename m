Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A30ECA0FE7
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 Aug 2025 17:56:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 638F4402DC;
	Mon, 25 Aug 2025 19:56:22 +0200 (CEST)
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com
 [209.85.210.178])
 by mails.dpdk.org (Postfix) with ESMTP id 6B59D4021E
 for <dev@dpdk.org>; Mon, 25 Aug 2025 19:56:21 +0200 (CEST)
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-76e1fc69f86so4424886b3a.0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 10:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756144580; x=1756749380; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=frIodcAEmPjQ2H0Fkbw/GlFgijjf6bBiqt+kWjnJEoM=;
 b=b/bYVsTOXPVh2YR/9zvpJDPYlXd4Cc2mI3EH6WExpTgp1/cNSv2DyO9wzTMBJU5V/i
 kxLiy8QR5V76efsE01xGvksc4srfu11efUsYa9F9KHsL+zSZ3eFILQL1XRXmDLzleqGG
 PGzcpYuV6olhjRBk0bBrpA8OCG8BieFfBCoHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756144580; x=1756749380;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=frIodcAEmPjQ2H0Fkbw/GlFgijjf6bBiqt+kWjnJEoM=;
 b=KZOhu29E5h4fGIoCrpK3qGsKO2VEB0ETdLe2fLuK2YMblLinNO18jrdOsFLipQzaPI
 pN2MwEbFhW0hF76MdGK1R+PgT5JYtXSAcUctP1tIXx7WTuEt4M8ZUame9cZOnsp1MeMb
 2pfj3tNp3KHl/mKzwOYaPE6MAZPys7eQ6347ThQs6GY0WCCVmTi/vJgBGaBzxPtw00YH
 i/zm6vbp2dHNONLZlcOo7fcM9p1NWAd00j0KCiS53+ybA4+1mssXbhJ5Li7pCIXX9sfm
 gD0KXH95ZAJGITOWlS5PA8/64yh5k8PJ5tWkgH1WpI+R87+9B1UawJ+1avZy7Iq91AmQ
 rf4Q==
X-Gm-Message-State: AOJu0YwPdoiW/PWDpkZ5bRBtKpNxHvASMd05bVjSWcqXtE1FoiXjceuP
 nNHA7lI4z0uztseFjcJwjobdl4F2RdTdT/KoD4r8Sb3S4MdCgAch50uP0g1KwSWlemoo4DrVIdY
 VDUdeYDTVt+EZ3795nvu0/fZspOxhRUM0Tp5e4mkzYOpPUn9HeKLqRlU=
X-Gm-Gg: ASbGncu08ERMMKlrubDOBEKJvNaSl/fzvPRFsx0W9kWFWtoHpNubtHy7JP8OuTyvb1M
 ibmqMjISLEk1xlIFUEz3QZ2I3IRl0DYil5ab/EXm8rvtNR/rn2M5IYZHFPDWaPDNSvCQ/JsVb+o
 ORNW9jE7FGZ2kYBeErUYJkPG/vfKoPft46FqmLBUzpQDho9OdFxE2Z7Gvux6pnMugY9n3nVWbpH
 qAIZ3Phm7LyfbEI2PGRGQ==
X-Google-Smtp-Source: AGHT+IEbmF2BxzZmbhKU9DCBmJHWwy3v8JoPgqsOmCCyCjAVUokUET1YjYLH5icRL50KXW5XZuoSZoZ88esAzxkHoxo=
X-Received: by 2002:a17:902:ebcb:b0:240:417d:8166 with SMTP id
 d9443c01a7336-2483df687ecmr4012235ad.19.1756144579970; Mon, 25 Aug 2025
 10:56:19 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 25 Aug 2025 13:49:43 -0400
X-Gm-Features: Ac12FXxWf3-JW0JgavmQSzO-vtkTxcXVhMDHo8VT0KnepgLYpwmG4Dbs4C3hjLw
Message-ID: <CAJvnSUDRLR74-HRpg+MPzHUR5h+7HNN2ax_rHuZ4c4+Hv-Bm6Q@mail.gmail.com>
Subject: Community CI Meeting Minutes - August 21, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org, Dean Marx <dmarx@iol.unh.edu>,
 Luca Vizzarro <Luca.Vizzarro@arm.com>, 
 Paul Szczepanek <Paul.Szczepanek@arm.com>, Aaron Conole <aconole@redhat.com>, 
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Andrew Bailey <abailey@iol.unh.edu>, 
 Manit Mahajan <mmahajan@iol.unh.edu>, "Brandes, Shai" <shaibran@amazon.com>, 
 "Gao, DaxueX" <daxuex.gao@intel.com>
Content-Type: multipart/alternative; boundary="000000000000dd1fbd063d3445c3"
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

--000000000000dd1fbd063d3445c3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
August 21, 2025
Attendees
1. Patrick Robb
2. Luca Vizzarro
3. Maxime Coquelin
4. Dean Marx

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
AWS Lab
* How can we access a EC2 ENA instance(s) to test DTS with?
   * Patrick emailed Shai asking if he can get a credit for us to book
something - no word yet
   * Otherwise, Patrick might be able to just get a little spend auth from
the UNH Lab to do this
* Otherwise, AWS Lab has been running consistently.

---------------------------------------------------------------------
UNH-IOL Community Lab
* DTS: From reviewing DTS results from previous weeks, there are 3
testsuites that are occasionally (like 1% of testruns) reporting a false
failure due to dropping packets:
   * Scatter
   * Vlan
   * Packet_capture
   * Checksum offload
   * UNH team to remove these from CI temporarily and check their packet
matching scheme for an implementation issue
   * Patrick to create tickets for these testsuite
* Pw-ci: UNH guys have not deployed an instance of this yet but it=E2=80=99=
s in the
queue.

---------------------------------------------------------------------
Intel Lab
* None
* They had a failure for the mbuf_fast_free tx_offload testcase in legacy
DTS. Morten and the intel lab team had a back and forth. Morten has now
rewritten the testplan for mbuf_fast_free.

---------------------------------------------------------------------
Github Actions Robot
* None

---------------------------------------------------------------------
Loongson Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Virtio VM testing:
   * One path is a vhost + Virtio type scenario where we are sending
packets between physical systems
   * It may be a good idea to have a test not involving physical NICs,
would make it easier to test for contributors broadly.
   * Vhost kernel is an accel implementation for TAP interfaces
   * Another option to simplify is to have vhost kernel for providing TAP
interface, and connecting to virtio_user PMD, don=E2=80=99t create a VM. Wi=
ll not
be testing the pci layer, rather the virtio-user PMD directly connected to
the TAP interface, but the datapath will be the same.
      * Does not require having a VM to be installed, which reduces the
setup burden both for DTS framework and for the =E2=80=9Cuser=E2=80=9D in t=
erms of system
dependencies
   * Doc:
https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html
      * Our first virtio testsuite will use this method
   * Doc:
https://doc.dpdk.org/guides/howto/virtio_user_for_container_networking.html
   * Could test vduse - create vhost-vdpa devices
      * Can connect to QEMU like you can connect vhost-user devices
      * Or can connect to virtio_user PMD
      * But, this is lower priority
   * If DTS team has questions, we can reach out to Maxime on Slack.
   * Vhost virtio test without a VM would be using virtio vdevs for testpmd
on the host
* Enable driver binding on the TG:
   * Patrick thinks the implementation looks good. He ran a testrun from
this patch with the TG driver unbound, and it did correctly bind, but then
the link was down on the TG interface so the sniffer could not be created.
   * Patrick to check where the ip link set dev up command is run in the
port setup, and see if that is missing now, or if it is being called too
early, or something else.
* Andrew is adding the mbuf_fast_free testcase to new DTS based on Morten=
=E2=80=99s
testplan.
* artifacts: https://patchwork.dpdk.org/project/dpdk/list/?series=3D35807
   * Will submit a new version in the next few weeks
   * Original intention was to have a global log and a testsuite specific
log.
      * There is no intention to have testcase specific log files (as is
the case with the V1)
* QinQ strip: Next step is to test on Broadcom and share back to Ajit and
maybe Morten/Bruce if those results are meaningful
* RSS: Patrick needs to do a review on this ASAP
   * This is top priority for the UNH guys
* Change default topology to 1 link:
   * Patrick to merge
   * https://patchwork.dpdk.org/project/dpdk/list/?series=3D35971
* Docs updates:
   * Fix missing type hints (Andrew is working on this)
   * Rewrite steps and verify sections, and add a new script under
dts-check-format which validates conformance to this test/verify docstring
for each testcase (Dean has submitted this)
      * The python check script that Dean is proposing to add to the DPDK
devtools dir needs to be prefixed with dts-* in the name so that it is
clear it is to be used for DTS
   * Reduce duplication between module docstrings, class docstrings, and
function docstrings. Thomas Wilks will work on this one.
* Remove test_ prefix from testcases:
https://patchwork.dpdk.org/project/dpdk/patch/20250820151215.47742-1-dmarx@=
iol.unh.edu/
   * Patrick to merge this
* Adding missing type hints:
https://patchwork.dpdk.org/project/dpdk/patch/20250820151850.484576-1-abail=
ey@iol.unh.edu/
   * Patrick to give a final review and merge it
* API dir:
   * Goal is that tests only import from api/* and nothing from framework/*

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting is Sep 4, 2025

--000000000000dd1fbd063d3445c3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>August 21, 2025<br>Attendees<br>1. Patrick Robb<br>2. Luca V=
izzarro<br>3. Maxime Coquelin<br>4. Dean Marx<br><br>######################=
###############################################<br>Minutes<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<b=
r>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>CI Status<br><br>------------------------------------------------------=
---------------<br>AWS Lab<br>* How can we access a EC2 ENA instance(s) to =
test DTS with?<br>=C2=A0 =C2=A0* Patrick emailed Shai asking if he can get =
a credit for us to book something - no word yet<br>=C2=A0 =C2=A0* Otherwise=
, Patrick might be able to just get a little spend auth from the UNH Lab to=
 do this<br>* Otherwise, AWS Lab has been running consistently.<br><br>----=
-----------------------------------------------------------------<br>UNH-IO=
L Community Lab<br>* DTS: From reviewing DTS results from previous weeks, t=
here are 3 testsuites that are occasionally (like 1% of testruns) reporting=
 a false failure due to dropping packets:<br>=C2=A0 =C2=A0* Scatter<br>=C2=
=A0 =C2=A0* Vlan<br>=C2=A0 =C2=A0* Packet_capture<br>=C2=A0 =C2=A0* Checksu=
m offload<br>=C2=A0 =C2=A0* UNH team to remove these from CI temporarily an=
d check their packet matching scheme for an implementation issue<br>=C2=A0 =
=C2=A0* Patrick to create tickets for these testsuite<br>* Pw-ci: UNH guys =
have not deployed an instance of this yet but it=E2=80=99s in the queue.<br=
><br>---------------------------------------------------------------------<=
br>Intel Lab<br>* None<br>* They had a failure for the mbuf_fast_free tx_of=
fload testcase in legacy DTS. Morten and the intel lab team had a back and =
forth. Morten has now rewritten the testplan for mbuf_fast_free.<br><br>---=
------------------------------------------------------------------<br>Githu=
b Actions Robot<br>* None<br><br>------------------------------------------=
---------------------------<br>Loongson Lab<br>* None<br><br>=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Tes=
t Development<br>* Virtio VM testing:<br>=C2=A0 =C2=A0* One path is a vhost=
 + Virtio type scenario where we are sending packets between physical syste=
ms<br>=C2=A0 =C2=A0* It may be a good idea to have a test not involving phy=
sical NICs, would make it easier to test for contributors broadly.<br>=C2=
=A0 =C2=A0* Vhost kernel is an accel implementation for TAP interfaces<br>=
=C2=A0 =C2=A0* Another option to simplify is to have vhost kernel for provi=
ding TAP interface, and connecting to virtio_user PMD, don=E2=80=99t create=
 a VM. Will not be testing the pci layer, rather the virtio-user PMD direct=
ly connected to the TAP interface, but the datapath will be the same.<br>=
=C2=A0 =C2=A0 =C2=A0 * Does not require having a VM to be installed, which =
reduces the setup burden both for DTS framework and for the =E2=80=9Cuser=
=E2=80=9D in terms of system dependencies<br>=C2=A0 =C2=A0* Doc: <a href=3D=
"https://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html">http=
s://doc.dpdk.org/guides/howto/virtio_user_as_exception_path.html</a><br>=C2=
=A0 =C2=A0 =C2=A0 * Our first virtio testsuite will use this method<br>=C2=
=A0 =C2=A0* Doc: <a href=3D"https://doc.dpdk.org/guides/howto/virtio_user_f=
or_container_networking.html">https://doc.dpdk.org/guides/howto/virtio_user=
_for_container_networking.html</a><br>=C2=A0 =C2=A0* Could test vduse - cre=
ate vhost-vdpa devices<br>=C2=A0 =C2=A0 =C2=A0 * Can connect to QEMU like y=
ou can connect vhost-user devices<br>=C2=A0 =C2=A0 =C2=A0 * Or can connect =
to virtio_user PMD<br>=C2=A0 =C2=A0 =C2=A0 * But, this is lower priority<br=
>=C2=A0 =C2=A0* If DTS team has questions, we can reach out to Maxime on Sl=
ack.<br>=C2=A0 =C2=A0* Vhost virtio test without a VM would be using virtio=
 vdevs for testpmd on the host<br>* Enable driver binding on the TG:<br>=C2=
=A0 =C2=A0* Patrick thinks the implementation looks good. He ran a testrun =
from this patch with the TG driver unbound, and it did correctly bind, but =
then the link was down on the TG interface so the sniffer could not be crea=
ted.<br>=C2=A0 =C2=A0* Patrick to check where the ip link set dev up comman=
d is run in the port setup, and see if that is missing now, or if it is bei=
ng called too early, or something else.<br>* Andrew is adding the mbuf_fast=
_free testcase to new DTS based on Morten=E2=80=99s testplan.<br>* artifact=
s: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D35807"=
>https://patchwork.dpdk.org/project/dpdk/list/?series=3D35807</a><br>=C2=A0=
 =C2=A0* Will submit a new version in the next few weeks<br>=C2=A0 =C2=A0* =
Original intention was to have a global log and a testsuite specific log.<b=
r>=C2=A0 =C2=A0 =C2=A0 * There is no intention to have testcase specific lo=
g files (as is the case with the V1)<br>* QinQ strip: Next step is to test =
on Broadcom and share back to Ajit and maybe Morten/Bruce if those results =
are meaningful<br>* RSS: Patrick needs to do a review on this ASAP<br>=C2=
=A0 =C2=A0* This is top priority for the UNH guys<br>* Change default topol=
ogy to 1 link:<br>=C2=A0 =C2=A0* Patrick to merge<br>=C2=A0 =C2=A0* <a href=
=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D35971">https://p=
atchwork.dpdk.org/project/dpdk/list/?series=3D35971</a><br>* Docs updates:<=
br>=C2=A0 =C2=A0* Fix missing type hints (Andrew is working on this)<br>=C2=
=A0 =C2=A0* Rewrite steps and verify sections, and add a new script under d=
ts-check-format which validates conformance to this test/verify docstring f=
or each testcase (Dean has submitted this)<br>=C2=A0 =C2=A0 =C2=A0 * The py=
thon check script that Dean is proposing to add to the DPDK devtools dir ne=
eds to be prefixed with dts-* in the name so that it is clear it is to be u=
sed for DTS<br>=C2=A0 =C2=A0* Reduce duplication between module docstrings,=
 class docstrings, and function docstrings. Thomas Wilks will work on this =
one.<br>* Remove test_ prefix from testcases: <a href=3D"https://patchwork.=
dpdk.org/project/dpdk/patch/20250820151215.47742-1-dmarx@iol.unh.edu/">http=
s://patchwork.dpdk.org/project/dpdk/patch/20250820151215.47742-1-dmarx@iol.=
unh.edu/</a><br>=C2=A0 =C2=A0* Patrick to merge this<br>* Adding missing ty=
pe hints: <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/20250820=
151850.484576-1-abailey@iol.unh.edu/">https://patchwork.dpdk.org/project/dp=
dk/patch/20250820151850.484576-1-abailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0*=
 Patrick to give a final review and merge it<br>* API dir:<br>=C2=A0 =C2=A0=
* Goal is that tests only import from api/* and nothing from framework/*<br=
><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any othe=
r business<br>* Next Meeting is Sep 4, 2025</div>

--000000000000dd1fbd063d3445c3--
