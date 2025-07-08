Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E5EBC83F09
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Jul 2025 22:50:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 237C940649;
	Wed,  9 Jul 2025 00:50:29 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 7554C4013F
 for <dev@dpdk.org>; Wed,  9 Jul 2025 00:50:27 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-312e747d2d8so345151a91.0
 for <dev@dpdk.org>; Tue, 08 Jul 2025 15:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1752015026; x=1752619826; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aiwRyyQhodMQJ3aYFumtm0yEEd1AcKGLrRCmiMALlE0=;
 b=Mea2a6DkolYLpX/CDTuevbNjEEXM8tJm9J04JxOABBQvZuWGhyiDf6AWnXNBYNB2Po
 XEhPcsSbqhLXFg24rAcDRe+QscbRI5iytFI+6NSr/GTj8nhdPSxah7NQ26AD8KveX5UH
 a5a1u3ht8JqtH0p6kLxdZomvs8Lp731ZBwJRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752015026; x=1752619826;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aiwRyyQhodMQJ3aYFumtm0yEEd1AcKGLrRCmiMALlE0=;
 b=ecpzoByiimNaXEHpsjQwH41Y4w39OcznQbNlaOpeDdNepYfdZ8oO5RHZTA0AurUa8j
 JB/rm7uPE8ViUpRON8wXQYFT07w8nl35NSzL/JbmZ6OegzYKsF9IiC1g4vEhDaGuvO4O
 aJP9p8IQVnwra5Ml3mSnqbCeFlLmk2f8fCQ1YX+nmm+3csYu/uzcr90LjYnMbyGCicp/
 503/KZ5rz4wACyFDvHEoP3mjCLjf78B+xRyQVLhAoAE+Mz0BFkroXBgs/kJnq7noscgf
 2yHSwo5vMcHO5nm1cPJKFDOREVldZLpcLOlJ3FdOx8RTPhsqo26qVrbPJFFxbR101T5V
 4LYA==
X-Gm-Message-State: AOJu0YznpKKBiw//1F4GV9WUxDX8NW7WzPL6Em6s0OQg5eI6D923Pt8R
 lpo4epLLJAa/HTrA428vAZgmYT5KZZJj6Ih378gDdmXfG+iQH6H0bxWpcbAhhz6QtN6zYWx7AAL
 ZNU0HuT5LGRyj9GP0yDMNmCa3eCIvvNW8otvP/ZKgNDVdinQ8E0RztAQ=
X-Gm-Gg: ASbGncs0FdIzqwGHuwL+nXOWIO40aXhwECzcrbvqrcCv9bDGCphBvDycSaBi8fsa3lS
 PCspRRrbE9NUjI1XsZMazDjQX/9HptlucF44+r9fvRLkQG5ytCCwvleSliU5ITQkJSIk2X1+N68
 NTRqKwOAj2BrC6lkqwTOpRRc3Lo1uOAP/oooOWODV5FUc9MzHMuBc0oq3aMg==
X-Google-Smtp-Source: AGHT+IEqqXY182VWgd/xYo+YrsJ082SZbFuJoLfeO25uSEjawOGAL9GspQGAGInLtrInp/dmuET8s6kEZz6QqQydhVI=
X-Received: by 2002:a17:90b:134e:b0:2ff:4a8d:74f9 with SMTP id
 98e67ed59e1d1-31c306dc3d4mr153428a91.10.1752015026365; Tue, 08 Jul 2025
 15:50:26 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 8 Jul 2025 18:44:43 -0400
X-Gm-Features: Ac12FXwYy7py6N7VvXFF5dkXEuuPZkicQkZIVNOr8-AoXv2XEUXFCpQUmhBI6N4
Message-ID: <CAJvnSUAr78vbPCDnF_xav7Own8d_zgm5cK0ZuWU4+5yzLDCbcw@mail.gmail.com>
Subject: Community CI Meeting Minutes - June 25, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000049c1d3063972c99e"
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

--00000000000049c1d3063972c99e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
June 25, 2025
Attendees
1. Patrick Robb
2. Manit Mahajan
3. Dean Marx

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* Expected RC schedule:
   * RC2 - June 27
   * RC3 - July 2
* Results from the =E2=80=9Cwhen to meet=E2=80=9D survey:
https://www.when2meet.com/?30965992-3ijyI
   * Basically, options going forward are Tuesdays from 12:00 UTC to 14:00
UTC, Wednesdays from 13:00 UTC to 14:00 UTC, and Thursdays from 12:00 UTC
to 13:00 UTC.
* DPDK-CI Test Recheck script has been updated to capture the =E2=80=9Creba=
se=E2=80=9D flag
for rebasing onto specific branches by developer request:
   *
https://patchwork.dpdk.org/project/ci/patch/20250611205849.72165-1-probb@io=
l.unh.edu/
   * https://core.dpdk.org/testing/#requesting-a-patch-retest
* CFP for the Santa Clara Summit is closed
   * The testing group does not have any talks submitted for this
conference, but Patrick will probably go to attend

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
AWS Lab
* Test recheck support plans:
* David noticed some failures due to timeout on the telemetry test, other
CIs run with -t 3 (30s timeout, instead of 10):
* Review on apply failure on .rst files discussion from the previous meetin=
g
UNH-IOL Community Lab
* Apply patchset process: Skipping making a tarball if the patch is a docs
patch only.
   * Labeling as =E2=80=9Cnot applicable=E2=80=9D on the lab dashboard
* Windows Builds:
   * Clang build is not picking up the devx lib file - Patrick needs to
check if this behavior is new.
   * WARN/FAIL email reporting error for Windows builds has been resolved.

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions Robot
* None

---------------------------------------------------------------------
Loongson Lab
* Patchseries recheck support: Min Zhou has tested out the new version of
the get_reruns.py script, and has indicated he will use it to support the
rebase argument.
   * When this happens we need to update the DPDK website testing page to
update the supported labs list

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* README and dts.rst updates are merged.
* Virtual Function testing:
   * Packet forwarding from DTS created VFs is working (on Intel)
   * Dean is refactoring the existing testsuites to ensure that they will
work for both PFs and VFs
* Performance testing and nic_single_core_perf:
   * Removing the usage of Invoke Promise from the V2.
      * This time, we start the trex server process and collect PID, then
loop on trying to connect to the trex server process with STLClient, then
kill the trex PID at the end
   * Resolving a few other small issues
   * Some minor config updates are needed
      * For instance, we don=E2=80=99t need to be including an app path for=
 func
TGs, only perf TGs
* Rte_flow testing:
   * Same status as before - appears to be running fine but requires
additional review.
      * Tested on Mellanox and Intel
* Remaining func testsuites:
   * Qinq: Needs a review
   * Ethertype: Needs a review but probably moving to 25.11

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting Jul 9, 2025

--00000000000049c1d3063972c99e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>June 25, 2025<br>Attendees<br>1. Patrick Robb<br>2. Manit Ma=
hajan<br>3. Dean Marx<br><br>##############################################=
#######################<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<br>* Expected RC schedule=
:<br>=C2=A0 =C2=A0* RC2 - June 27<br>=C2=A0 =C2=A0* RC3 - July 2<br>* Resul=
ts from the =E2=80=9Cwhen to meet=E2=80=9D survey: <a href=3D"https://www.w=
hen2meet.com/?30965992-3ijyI">https://www.when2meet.com/?30965992-3ijyI</a>=
<br>=C2=A0 =C2=A0* Basically, options going forward are Tuesdays from 12:00=
 UTC to 14:00 UTC, Wednesdays from 13:00 UTC to 14:00 UTC, and Thursdays fr=
om 12:00 UTC to 13:00 UTC.<br>* DPDK-CI Test Recheck script has been update=
d to capture the =E2=80=9Crebase=E2=80=9D flag for rebasing onto specific b=
ranches by developer request:<br>=C2=A0 =C2=A0* <a href=3D"https://patchwor=
k.dpdk.org/project/ci/patch/20250611205849.72165-1-probb@iol.unh.edu/">http=
s://patchwork.dpdk.org/project/ci/patch/20250611205849.72165-1-probb@iol.un=
h.edu/</a><br>=C2=A0 =C2=A0* <a href=3D"https://core.dpdk.org/testing/#requ=
esting-a-patch-retest">https://core.dpdk.org/testing/#requesting-a-patch-re=
test</a><br>* CFP for the Santa Clara Summit is closed<br>=C2=A0 =C2=A0* Th=
e testing group does not have any talks submitted for this conference, but =
Patrick will probably go to attend<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>------------------------------=
---------------------------------------<br>AWS Lab<br>* Test recheck suppor=
t plans:<br>* David noticed some failures due to timeout on the telemetry t=
est, other CIs run with -t 3 (30s timeout, instead of 10):<br>* Review on a=
pply failure on .rst files discussion from the previous meeting<br>UNH-IOL =
Community Lab<br>* Apply patchset process: Skipping making a tarball if the=
 patch is a docs patch only.<br>=C2=A0 =C2=A0* Labeling as =E2=80=9Cnot app=
licable=E2=80=9D on the lab dashboard<br>* Windows Builds:<br>=C2=A0 =C2=A0=
* Clang build is not picking up the devx lib file - Patrick needs to check =
if this behavior is new.<br>=C2=A0 =C2=A0* WARN/FAIL email reporting error =
for Windows builds has been resolved.<br><br>------------------------------=
---------------------------------------<br>Intel Lab<br>* None<br><br>-----=
----------------------------------------------------------------<br>Github =
Actions Robot<br>* None<br><br>--------------------------------------------=
-------------------------<br>Loongson Lab<br>* Patchseries recheck support:=
 Min Zhou has tested out the new version of the get_reruns.py script, and h=
as indicated he will use it to support the rebase argument.<br>=C2=A0 =C2=
=A0* When this happens we need to update the DPDK website testing page to u=
pdate the supported labs list<br>=C2=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Developmen=
t<br>* README and dts.rst updates are merged.<br>* Virtual Function testing=
:<br>=C2=A0 =C2=A0* Packet forwarding from DTS created VFs is working (on I=
ntel)<br>=C2=A0 =C2=A0* Dean is refactoring the existing testsuites to ensu=
re that they will work for both PFs and VFs<br>* Performance testing and ni=
c_single_core_perf:<br>=C2=A0 =C2=A0* Removing the usage of Invoke Promise =
from the V2.<br>=C2=A0 =C2=A0 =C2=A0 * This time, we start the trex server =
process and collect PID, then loop on trying to connect to the trex server =
process with STLClient, then kill the trex PID at the end<br>=C2=A0 =C2=A0*=
 Resolving a few other small issues<br>=C2=A0 =C2=A0* Some minor config upd=
ates are needed<br>=C2=A0 =C2=A0 =C2=A0 * For instance, we don=E2=80=99t ne=
ed to be including an app path for func TGs, only perf TGs<br>* Rte_flow te=
sting:<br>=C2=A0 =C2=A0* Same status as before - appears to be running fine=
 but requires additional review.<br>=C2=A0 =C2=A0 =C2=A0 * Tested on Mellan=
ox and Intel<br>* Remaining func testsuites:<br>=C2=A0 =C2=A0* Qinq: Needs =
a review<br>=C2=A0 =C2=A0* Ethertype: Needs a review but probably moving to=
 25.11<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>Any other business<br>* Next Meeting Jul 9, 2025</div>

--00000000000049c1d3063972c99e--
