Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CA6C54FB3
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Jun 2025 17:30:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A9FE40268;
	Sun,  1 Jun 2025 19:30:26 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 122B4400D5
 for <dev@dpdk.org>; Sun,  1 Jun 2025 19:30:08 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so3471199a12.0
 for <dev@dpdk.org>; Sun, 01 Jun 2025 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748799007; x=1749403807; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=+KKG813cZON+SbHzlInMXPD43qFF2XaPv8iV0O3v61E=;
 b=gpLhUxA+0tKHuL1dWXqiEG+x+Vk5lm9UyZ8E4CxPJH84U+sfc4s7plloSUuAG5W+dV
 1m+I0HtEtLU3Hid/unE9EFErRc8BM9Efou2pPI+iDOZv2Vn0WFTHpcpkFobpJB1TCqKx
 u7Cl7k47TT2k0P6jrm1w1aPO60l9jqiHsXxsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748799007; x=1749403807;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+KKG813cZON+SbHzlInMXPD43qFF2XaPv8iV0O3v61E=;
 b=Lv2uyBZk410jrz9UI32Rkokw7wTvDFj3zB0dvsWSZdyLLy1uRvVJfKm023CdOHTHsN
 S0kwBjtsXSlUM0Qf0UCWOzPRVui4GIa8oIjHwAJMkbIqKxAsMiPpF7YJ8KNSM1tIT4A7
 dKadmeT+jbwv3iDr2clgyR9OY6XDrwsYsVH3MFv2DsDTda7EUrDxD6nUJbgipf6tWXYf
 wqSpbDC3kzJeT+RC4woJYqyOSpBimVjj9V60tKASXmMaWPY5AXQWqlmFk7AN5R/yZ4Wg
 9XkGKAMmrycclAOTWwvGXYQyO+y7c1xrrPN/BY3xOWGYi02P+fJH2iStieMWNkTVNwqj
 AKAw==
X-Gm-Message-State: AOJu0Yxjp10K4Is/zAe/RS5qUX6j/4t76LqRPBYdw1RCuR7v6pP8DmtT
 vilu422acJs/u2g93kjW8zDQe56he6CC4pz97taAfFLVwZ25wT0RzcYSS1mlbwDnq0/79QllG6A
 64JWYTJVWaW96Bb+emdnhhpANalSbv80pwGXF9h6lj8xfdTgMs1sVUojapg==
X-Gm-Gg: ASbGncsSgjFv/w6MQ5U/LhySnew0sUDx1YOs+8s8EB2jRBMXu+wTfFs01qQGdOBzysz
 MNbfYLkSsnZxSxCpnhCQG7Ui/bUc7Mo6p5nHPKSnM/oA76+Yr/p5uUHHPYojM+/N/kb+Q0xrA5g
 f62+kHcbEosf0ZKFH725caivFK39sVi1Lth+xIy5no1P6vsOvfdZGnncVYzw4PrvbyEQmyODkNs
 Nwo
X-Google-Smtp-Source: AGHT+IGXS669kFByNNMuKt1XL6u4JOMRDbAk6G0+d2VPjtSQAg1ivrGG+fYJ5HDp9a3leEMRkq/NXQHQ0BsDIjnrNBE=
X-Received: by 2002:a17:902:d4cd:b0:234:f4da:7eef with SMTP id
 d9443c01a7336-2353968853dmr130099895ad.52.1748799006778; Sun, 01 Jun 2025
 10:30:06 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 1 Jun 2025 13:25:07 -0400
X-Gm-Features: AX0GCFs06MJXBj57ST6XWUL7k71YF20Hx7mFlNQLduicOlVf8-d28hu8_2vopSE
Message-ID: <CAJvnSUAudjeWv_bobAzwXaWVcSX-yLT+asn9JKjrn=DibtwMLw@mail.gmail.com>
Subject: Community CI Meeting Minutes - May 29, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000953e24063685ffeb"
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

--000000000000953e24063685ffeb
Content-Type: text/plain; charset="UTF-8"

#####################################################################
May 29, 2025
Attendees
1. Patrick Robb
2. Paul Szczepanek
3. Aaron Conole
4. Manit Mahajan

#####################################################################
Minutes

=====================================================================
General Announcements
* LTS branches (with backports), which were previously only available on
the Github dpdk-stable repo, are now available on the github DPDK repo.
Example: https://github.com/DPDK/dpdk/tree/24.11
* Patrick still needs to send out a survey to CI meetings folks for finding
an agreeable new meeting timeslot.
   * In order to facilitate both Europe, Asia, and North America, we may
have to alternate the meeting time.

=====================================================================
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* Cody brought the x86 Intel e810 100G single core forwarding test back
online.
   * Necessitated making the TREX traffic profile homogeneous as the
traffic mix used before was causing issues with the TREX software.
* New environment info update process:
   * Runs once every 48 hours when there is a periodic (no patch) run on
dpdk mainline
   * Added a stage to all our testing pipelines which will run a python
subprocess script to collect software information. Then, sends a PATCH http
request to our DPDK dashboard, which updates the database.
   * Collects these values from the system:
      * Compiler version
      * Kernel version
      * Kernel cmdline
      * Os distro
   * Followup values we want to grab in the future:
      * Libc version
* Working on some internal tooling to help our maintenance:
   * Refactoring our ansible playbooks so that we have a larger set of
discrete provisioning playbooks instead of our monolithic playbook which we
have been managing for years, and is becoming a maintenance burden.
* Currently we have 2 racks at UNH set aside for DPDK servers, one is
completely full and the other half full. We had a couple parties at DPDK
Prague offer to help fill the remaining 24U in the second rack, and we are
following up with these parties.

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions Robot
* Aaron started looking at changes to the patchwork events API.
   * Adam Hassickshould review the email thread on this and see if he can
suggest any ideas for improving the patchwork API
* There was a little discussion about how developers would benefit from
forking DPDK on github and leveraging the GHA pipelines, which would help
with the simplest type of failures (like just failing build on linux)
* Aaron notes that ovs and netdev are seeing similar issues as DPDK in
terms of developers relying too much on CI, and completely forgoing
personally testing their patches ahead of submission to the mailing list.

---------------------------------------------------------------------
AWS Lab
* No updates, but Patrick will try to find some CI meeting scheduling
solution which will work for Shai.

---------------------------------------------------------------------
Loongson Lab
* It is confirmed that Loongson lab is supporting the email based test
recheck framework. However, we have not synced with Min Zhou about
supporting the rebase={branch} argument for rechecks. Patrick has emailed
on the old loongson recheck support email thread asking for the latest
status.
   * We need to send a patch to the testing page for dpdk.org adding
loongson as a lab which supports this.

=====================================================================
DTS Improvements & Test Development
* README and dts.rst rewrite to simplify user onboarding instructions:
   * Reviewed by Patrick and Paul. Looks good mostly but needs a v2 for
some minor nits, and has a warning which needs to be resolved.
* Reminder - when submitting a DTS patchseries:
   * Run dts-check-format.py, checkpatch, check-git-log.sh, and ideally do
a docs build.
* Rte_flow: Dean has submitted a v2, which adds a flow validate call ahead
of each flow create call.
   * Patrick to review for a v3 or merge.
* Docs patch which adds explanation of per testsuite config file
   * Patrick to review and merge
* dts: use tmp dir and DPDK tree dir
   * Tested and reviewed by Dean
   * Patrick to review and merge
* Improve port handling:
   * Dean has reviewed
   * Paul to merge
   *
https://patchwork.dpdk.org/project/dpdk/patch/20250506131657.1576152-1-luca.vizzarro@arm.com/
* Docs builds are a big burden, as there are lots of warnings:
   * Should be a discussion item at the next meeting
   * If you have ideas on how the process (on the DTS side or the DPDK
side) can be improved to make this less of a maintenance burden, please
bring those to the next meeting

=====================================================================
Any other business
* Next Meeting Jun 12, 2025

--000000000000953e24063685ffeb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>May 29, 2025<br>Attendees<br>1. Patrick Robb<br>2. Paul Szcz=
epanek<br>3. Aaron Conole<br>4. Manit Mahajan<br><br>######################=
###############################################<br>Minutes<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<b=
r>* LTS branches (with backports), which were previously only available on =
the Github dpdk-stable repo, are now available on the github DPDK repo. Exa=
mple: <a href=3D"https://github.com/DPDK/dpdk/tree/24.11">https://github.co=
m/DPDK/dpdk/tree/24.11</a><br>* Patrick still needs to send out a survey to=
 CI meetings folks for finding an agreeable new meeting timeslot.<br>=C2=A0=
 =C2=A0* In order to facilitate both Europe, Asia, and North America, we ma=
y have to alternate the meeting time.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>---------------------------=
------------------------------------------<br>UNH-IOL Community Lab<br>* Co=
dy brought the x86 Intel e810 100G single core forwarding test back online.=
<br>=C2=A0 =C2=A0* Necessitated making the TREX traffic profile homogeneous=
 as the traffic mix used before was causing issues with the TREX software.<=
br>* New environment info update process:<br>=C2=A0 =C2=A0* Runs once every=
 48 hours when there is a periodic (no patch) run on dpdk mainline<br>=C2=
=A0 =C2=A0* Added a stage to all our testing pipelines which will run a pyt=
hon subprocess script to collect software information. Then, sends a PATCH =
http request to our DPDK dashboard, which updates the database.<br>=C2=A0 =
=C2=A0* Collects these values from the system:<br>=C2=A0 =C2=A0 =C2=A0 * Co=
mpiler version<br>=C2=A0 =C2=A0 =C2=A0 * Kernel version<br>=C2=A0 =C2=A0 =
=C2=A0 * Kernel cmdline<br>=C2=A0 =C2=A0 =C2=A0 * Os distro<br>=C2=A0 =C2=
=A0* Followup values we want to grab in the future:<br>=C2=A0 =C2=A0 =C2=A0=
 * Libc version<br>* Working on some internal tooling to help our maintenan=
ce:<br>=C2=A0 =C2=A0* Refactoring our ansible playbooks so that we have a l=
arger set of discrete provisioning playbooks instead of our monolithic play=
book which we have been managing for years, and is becoming a maintenance b=
urden.<br>* Currently we have 2 racks at UNH set aside for DPDK servers, on=
e is completely full and the other half full. We had a couple parties at DP=
DK Prague offer to help fill the remaining 24U in the second rack, and we a=
re following up with these parties.<br><br>--------------------------------=
-------------------------------------<br>Intel Lab<br>* None<br><br>-------=
--------------------------------------------------------------<br>Github Ac=
tions Robot<br>* Aaron started looking at changes to the patchwork events A=
PI.<br>=C2=A0 =C2=A0* Adam Hassickshould review the email thread on this an=
d see if he can suggest any ideas for improving the patchwork API<br>* Ther=
e was a little discussion about how developers would benefit from forking D=
PDK on github and leveraging the GHA pipelines, which would help with the s=
implest type of failures (like just failing build on linux)<br>* Aaron note=
s that ovs and netdev are seeing similar issues as DPDK in terms of develop=
ers relying too much on CI, and completely forgoing personally testing thei=
r patches ahead of submission to the mailing list.<br><br>-----------------=
----------------------------------------------------<br>AWS Lab<br>* No upd=
ates, but Patrick will try to find some CI meeting scheduling solution whic=
h will work for Shai.<br><br>----------------------------------------------=
-----------------------<br>Loongson Lab<br>* It is confirmed that Loongson =
lab is supporting the email based test recheck framework. However, we have =
not synced with Min Zhou about supporting the rebase=3D{branch} argument fo=
r rechecks. Patrick has emailed on the old loongson recheck support email t=
hread asking for the latest status.<br>=C2=A0 =C2=A0* We need to send a pat=
ch to the testing page for <a href=3D"http://dpdk.org">dpdk.org</a> adding =
loongson as a lab which supports this.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Development<b=
r>* README and dts.rst rewrite to simplify user onboarding instructions:<br=
>=C2=A0 =C2=A0* Reviewed by Patrick and Paul. Looks good mostly but needs a=
 v2 for some minor nits, and has a warning which needs to be resolved.<br>*=
 Reminder - when submitting a DTS patchseries:<br>=C2=A0 =C2=A0* Run dts-ch=
eck-format.py, checkpatch, check-git-log.sh, and ideally do a docs build.<b=
r>* Rte_flow: Dean has submitted a v2, which adds a flow validate call ahea=
d of each flow create call.<br>=C2=A0 =C2=A0* Patrick to review for a v3 or=
 merge.<br>* Docs patch which adds explanation of per testsuite config file=
<br>=C2=A0 =C2=A0* Patrick to review and merge<br>* dts: use tmp dir and DP=
DK tree dir<br>=C2=A0 =C2=A0* Tested and reviewed by Dean<br>=C2=A0 =C2=A0*=
 Patrick to review and merge<br>* Improve port handling:<br>=C2=A0 =C2=A0* =
Dean has reviewed<br>=C2=A0 =C2=A0* Paul to merge<br>=C2=A0 =C2=A0* <a href=
=3D"https://patchwork.dpdk.org/project/dpdk/patch/20250506131657.1576152-1-=
luca.vizzarro@arm.com/">https://patchwork.dpdk.org/project/dpdk/patch/20250=
506131657.1576152-1-luca.vizzarro@arm.com/</a><br>* Docs builds are a big b=
urden, as there are lots of warnings:<br>=C2=A0 =C2=A0* Should be a discuss=
ion item at the next meeting<br>=C2=A0 =C2=A0* If you have ideas on how the=
 process (on the DTS side or the DPDK side) can be improved to make this le=
ss of a maintenance burden, please bring those to the next meeting<br>=C2=
=A0 =C2=A0<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>Any other business<br>* Next Meeting Jun 12, 2025</div>

--000000000000953e24063685ffeb--
