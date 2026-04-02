Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F55D6AAFE
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:14:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D7764028E;
	Thu,  2 Apr 2026 21:14:54 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id 7C2B24027A
 for <dev@dpdk.org>; Thu,  2 Apr 2026 21:14:52 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-126ea4b77adso1776467c88.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 12:14:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157291; cv=none;
 d=google.com; s=arc-20240605;
 b=jZOhY6GuXewmg558LUJ0QKKjEaEGChCSeiJPTx+/rOVgLSNToffIYyFW9P6pZ7GGbX
 BhMPdV5UaRp3U9eJ2NPJAZ8KvW08yFbqCAy6giADmLQL7SSJvMxyVzYfSb5iCN8zwR8q
 xgL8mljaaGlUQiNJGWwOEV4SkBMns6xBBONM2XcVxEFz8MGXIoNU4AlQ5aswB5N9r51Q
 1y1i5u/DKhAFbjr3jsjTlp1jhf0YkwVaQevnvPwQvKifUBMjgpE4dso/mmvTiYLT6uhR
 BUQuL3q4V84ml/hvTGTKvMn2DZU8yK4K11wLv9SA9/HhVNi3eu9+mf/ecUz3BYLsSTY6
 qZ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=bXGX55bpUG+mTB6dIY+J7qcFnxK8GRkhqC9YvFUpQuM=;
 fh=jCCdCBhxRx6n1P60zMborTuk4JYshNJ7SYiK8DmmIYQ=;
 b=Bt8g6w4jacX5lYBlm+X5KLOXnVHlNEHYfkC1VS+QCMorRxA+e5mTurOmvl+O0yzCvk
 Ihp6M3eifsdRDYor4rcms8E/iuO2CWYoidUR2G4PXKlRRFVqIpMKViY4Ce4WqY8SvZeX
 +mf2z0EGXwxY9GCXIhKqXujibSQdqzvCpTFaOJk49j31zzdzg/Ke50ff+re06G9/50Ix
 sANMQTxOZNU70+FGYUCwl7jZQwVs6EQdo0YXqBwhAo1HCwlxHa5BtLMCk5ANMD2vm2me
 R9ASEQlnenux+sJ8eaSqEZpEO4jRR64eYkRYAEJ3u1F0I/cn5QlSnubt89H9XX5ODCq+
 VPUQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775157291; x=1775762091; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=bXGX55bpUG+mTB6dIY+J7qcFnxK8GRkhqC9YvFUpQuM=;
 b=jG7Vvs0v8NnWLOycWjwyuRqOnMwAlWyk90tVEfrRcCRnuXFnD30DQF59zDUp0OGdLC
 nc7zJh4yiDqoTNCowHIi4UHFoTRff7wFWACYrrXunMNeDF4HkRgT4I/xJDIXZGjdeQKl
 8A5ppA/SHRbct8g+FzjjDE2P/QjbQBFHn8sWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775157291; x=1775762091;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bXGX55bpUG+mTB6dIY+J7qcFnxK8GRkhqC9YvFUpQuM=;
 b=CfC2COc+9j9Sac+pw4ghLE8NEUdqoRaD+2lOCo7hy/PjLSuPDtpvTe3gCY+jibJ8MV
 A6YSfPAjsLRsfqzJO9aV6ifGJrr0LX7yJWoUkotZrprs3EvZZXRZ6J+yXYzAV/vtu0um
 MjbftUNzZGJtEf1a4UDXrSo5ozIstkeQreNhq0XZZBSR7sU2CEQTiHS+r0PvWB3TW1Oa
 3FoVJm0Zv5yQI21SGgH3UeJ4imtbhhTDiipnXSenDYI4DtxAt7ZTdd1i8KxgvpDpT8d/
 tPvVkmgMPZniOk2fsGkNN2QSXvYOBWXnev3+YXCvUWBShtEnIobIB/UvldF+5KidFSbC
 2Now==
X-Gm-Message-State: AOJu0Yx3Z2nKNtyqs5RlmIIX4HPqGd5CgpT0k37fRMFZXU9FleoSwA5g
 Ecyz1hJhRimzFUP1EUWR/4RBZihghEcaFUEqOQhHWOIv8zAZjKglVo3zregD2gkx3h87Wocsjpa
 OEfWT2LeIYBoAc0eRfoLf51XHVGPhkPHAiOUJ04YVgw==
X-Gm-Gg: ATEYQzyezkRGZF1GhZkbzyFFYMe9WqOUOfXhptNCKSkIylIpVDcLPZasCAdWi2BS5kT
 23A6K7TVLCAGMsupZ7FXOxa0gvWdMEBPGGlmNA8HcseMGeZZdX7aLgeZXAGDEe+9R4sHou36YBr
 YtxkCIvMY76Q9dpZXIITIxn2J8ZYqgUAOb+yl7Pe+Ef3P0W5+M5NCjfsnhDuO2jA1Q+GBJOAQvD
 0L6OIFkcextrvBoT9FZHZVGik52uBnclbNc9zw5mDeNsiddvtnf0FIbcsZcDsEhzRE6Ubmd8eel
 7quJ0riVxspwvABl2jP+eLOlb6yMLQOl/MeLnfb++hxHthCkcALSkA==
X-Received: by 2002:a05:7022:52b:b0:12b:ee92:a60e with SMTP id
 a92af1059eb24-12bfb6ecb28mr104583c88.8.1775157291321; Thu, 02 Apr 2026
 12:14:51 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 2 Apr 2026 15:11:26 -0400
X-Gm-Features: AQROBzDkR_AlHAyqx8ftZEbuZGfPS0ihHvorkOkzsUJEgH7PSEK4KfMCYSab18A
Message-ID: <CAJvnSUBJjGoOLmde6ca01D1WXQDBKfw0RUp_TodwiZapwdc1FA@mail.gmail.com>
Subject: Community CI Meeting Minutes - March 19, 2026
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Lincoln Lavoie <lylavoie@iol.unh.edu>, 
 Adam Hassick <ahassick@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000c51b4c064e7f03fe"
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

--000000000000c51b4c064e7f03fe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

March 19, 2026
Attendees
   5. Patrick Robb
   6. Aaron Conole
   7. Adam Hassick
   8. Dean Marx
   9. Andrew Bailey
   10. Lincoln Lavoie
   11. Luca Vizzarro
Minutes
General Announcements
   * AI Code Review:
   * Patrick has created a PR which adds the jenkins scripting for driving
the AI code review scripting, depending on the =E2=80=9Cgate conditions=E2=
=80=9D described
in the previous meeting minutes
   * Adam added as reviewer
   * Aaron to come into the UNH Lab soon to review the AI code review
process with the team.
   * Aaron will probably come in the latter portion of next week to
finalize our CI process / look over the scripting with us and then we can
launch the AI code reviews in production
   * We are swapping in Aaron=E2=80=99s review-start.md in place of Stephen=
=E2=80=99s
AGENTS.md because we are token constrained (need to spend less per patch)
   * In the long term there will be a CI usable AGENTS.md which is merged
into DPDK and we will just use this
   * RC2 was released this week
   * RC3 will be released next Tuesday
CI Status
AWS Lab
   * None, they are running normally
UNH-IOL Community Lab
   * Cryptodev testing:
   * The cryptodev series was merged in RC2, which modifies the
test_run.yaml =E2=80=9Cschema=E2=80=9D so this is breaking. We are using ne=
w config file
which align with the new schema. A few next branches in DPDK have not
rebased off of main, which means that CI runs which apply to these branches
cannot run DTS. Patrick to check which branches are not rebased and ask the
maintainers to rebase on main.
   * Adding the new DTS testsuite to CI:
   * Andrew is staging adding the new testsuite to our CI runs. This will
be reporting to patchwork very soon for Intel QAT, then we will add other
cryptodevs.
   * AMD cryptodev: UNH Lab has a system with an AMD cryptodevice which is
included in the processor package, and has a DPDK poll mode driver. Andrew
to test adding this to our CI runs after he gets the Intel QAT online.
   * Rte_flow testsuite:
   * Merged to mainline, all devices have at least 1 failure, so we cannot
activate this series in CI
   * DTS failure ticketing:
   * We have been documenting some of the failures we see from DTS in the
ethdev component on Bugzilla along the way, but could be more intentional
about it. I.e. we should have a little downtime in the next couple of
weeks, it will be good if we can set aside time to do some testruns and
document the existing failures better.
   * Windows:
   * Server 2022 machine officially turned off - all CI runs moved to
server 2025
   * Getting a license for server 2025 from UNH
   * Bugzilla:
   * On the lab component, there are a bunch of old, unresolved tickets
that basically need to be updated or marked as resolved or will not do.
   * Once this is done, the lab component will be more usable again
Intel Lab
   * None
   * No news so far from Manju regarding their DTS usage - so gather that
is a work in progress
Github Actions Robot
   * None
Loongson Lab
   * None
DTS Improvements & Test Development
   * RC2
   * Merged our main initiatives per the roadmap
   * Patrick to email Maxime and notify him that we will merge the PVVP
virtio testcase at the start of the 26.07 window
   * RC3
   * Dean sent a bugfix for the logic which drives the overall testsuite
level outcome when there is a mix of PASS and SKIP results (PASS should
win).
   * Cryptodev:
   * Merged
   * Flow Offload:
   * Merged
   * https://bugs.dpdk.org/show_bug.cgi?id=3D1584
   * When we write dataclasses for a particular component in testpmd, it
makes sense to comprehensively support all valid fields allowed by testpmd,
not just the ones being used in our testsuites. This is what we have been
doing in most cases, but we should be doing it in all cases.
   * Patrick=E2=80=99s talk for DPDK Stockholm about integrating DTS in the
developer workflow (and demo-ing the rte flow testsuite) was accepted
yesterday.
   * Speed capabilities testsuite to be merged for RC3

Any other business
      * Next meeting is Mar 19, 2026

--000000000000c51b4c064e7f03fe
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">=C2=A0 =C2=A0<br>March 19, 2026<br>Attendees<br>=C2=A0 =C2=
=A05. Patrick Robb<br>=C2=A0 =C2=A06. Aaron Conole<br>=C2=A0 =C2=A07. Adam =
Hassick<br>=C2=A0 =C2=A08. Dean Marx<br>=C2=A0 =C2=A09. Andrew Bailey<br>=
=C2=A0 =C2=A010. Lincoln Lavoie<br>=C2=A0 =C2=A011. Luca Vizzarro<br>Minute=
s<br>General Announcements<br>=C2=A0 =C2=A0* AI Code Review:<br>=C2=A0 =C2=
=A0* Patrick has created a PR which adds the jenkins scripting for driving =
the AI code review scripting, depending on the =E2=80=9Cgate conditions=E2=
=80=9D described in the previous meeting minutes<br>=C2=A0 =C2=A0* Adam add=
ed as reviewer<br>=C2=A0 =C2=A0* Aaron to come into the UNH Lab soon to rev=
iew the AI code review process with the team.<br>=C2=A0 =C2=A0* Aaron will =
probably come in the latter portion of next week to finalize our CI process=
 / look over the scripting with us and then we can launch the AI code revie=
ws in production<br>=C2=A0 =C2=A0* We are swapping in Aaron=E2=80=99s revie=
w-start.md in place of Stephen=E2=80=99s AGENTS.md because we are token con=
strained (need to spend less per patch)<br>=C2=A0 =C2=A0* In the long term =
there will be a CI usable AGENTS.md which is merged into DPDK and we will j=
ust use this<br>=C2=A0 =C2=A0* RC2 was released this week<br>=C2=A0 =C2=A0*=
 RC3 will be released next Tuesday<br>CI Status<br>AWS Lab<br>=C2=A0 =C2=A0=
* None, they are running normally<br>UNH-IOL Community Lab<br>=C2=A0 =C2=A0=
* Cryptodev testing:<br>=C2=A0 =C2=A0* The cryptodev series was merged in R=
C2, which modifies the test_run.yaml =E2=80=9Cschema=E2=80=9D so this is br=
eaking. We are using new config file which align with the new schema. A few=
 next branches in DPDK have not rebased off of main, which means that CI ru=
ns which apply to these branches cannot run DTS. Patrick to check which bra=
nches are not rebased and ask the maintainers to rebase on main.<br>=C2=A0 =
=C2=A0* Adding the new DTS testsuite to CI:<br>=C2=A0 =C2=A0* Andrew is sta=
ging adding the new testsuite to our CI runs. This will be reporting to pat=
chwork very soon for Intel QAT, then we will add other cryptodevs.<br>=C2=
=A0 =C2=A0* AMD cryptodev: UNH Lab has a system with an AMD cryptodevice wh=
ich is included in the processor package, and has a DPDK poll mode driver. =
Andrew to test adding this to our CI runs after he gets the Intel QAT onlin=
e.<br>=C2=A0 =C2=A0* Rte_flow testsuite:<br>=C2=A0 =C2=A0* Merged to mainli=
ne, all devices have at least 1 failure, so we cannot activate this series =
in CI<br>=C2=A0 =C2=A0* DTS failure ticketing:<br>=C2=A0 =C2=A0* We have be=
en documenting some of the failures we see from DTS in the ethdev component=
 on Bugzilla along the way, but could be more intentional about it. I.e. we=
 should have a little downtime in the next couple of weeks, it will be good=
 if we can set aside time to do some testruns and document the existing fai=
lures better.<br>=C2=A0 =C2=A0* Windows:<br>=C2=A0 =C2=A0* Server 2022 mach=
ine officially turned off - all CI runs moved to server 2025<br>=C2=A0 =C2=
=A0* Getting a license for server 2025 from UNH<br>=C2=A0 =C2=A0* Bugzilla:=
<br>=C2=A0 =C2=A0* On the lab component, there are a bunch of old, unresolv=
ed tickets that basically need to be updated or marked as resolved or will =
not do.<br>=C2=A0 =C2=A0* Once this is done, the lab component will be more=
 usable again<br>Intel Lab<br>=C2=A0 =C2=A0* None<br>=C2=A0 =C2=A0* No news=
 so far from Manju regarding their DTS usage - so gather that is a work in =
progress<br>Github Actions Robot<br>=C2=A0 =C2=A0* None<br>Loongson Lab<br>=
=C2=A0 =C2=A0* None<br>DTS Improvements &amp; Test Development<br>=C2=A0 =
=C2=A0* RC2<br>=C2=A0 =C2=A0* Merged our main initiatives per the roadmap<b=
r>=C2=A0 =C2=A0* Patrick to email Maxime and notify him that we will merge =
the PVVP virtio testcase at the start of the 26.07 window<br>=C2=A0 =C2=A0*=
 RC3<br>=C2=A0 =C2=A0* Dean sent a bugfix for the logic which drives the ov=
erall testsuite level outcome when there is a mix of PASS and SKIP results =
(PASS should win).<br>=C2=A0 =C2=A0* Cryptodev:<br>=C2=A0 =C2=A0* Merged<br=
>=C2=A0 =C2=A0* Flow Offload:<br>=C2=A0 =C2=A0* Merged<br>=C2=A0 =C2=A0* <a=
 href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1584">https://bugs.dpdk.or=
g/show_bug.cgi?id=3D1584</a> <br>=C2=A0 =C2=A0* When we write dataclasses f=
or a particular component in testpmd, it makes sense to comprehensively sup=
port all valid fields allowed by testpmd, not just the ones being used in o=
ur testsuites. This is what we have been doing in most cases, but we should=
 be doing it in all cases.<br>=C2=A0 =C2=A0* Patrick=E2=80=99s talk for DPD=
K Stockholm about integrating DTS in the developer workflow (and demo-ing t=
he rte flow testsuite) was accepted yesterday. <br>=C2=A0 =C2=A0* Speed cap=
abilities testsuite to be merged for RC3<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 <br>Any other business<br>=C2=A0 =C2=A0 =C2=A0 * N=
ext meeting is Mar 19, 2026</div>

--000000000000c51b4c064e7f03fe--
