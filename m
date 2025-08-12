Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA65FCA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 16:40:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC72B40270;
	Tue, 12 Aug 2025 18:40:01 +0200 (CEST)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by mails.dpdk.org (Postfix) with ESMTP id EF2CA400EF
 for <dev@dpdk.org>; Tue, 12 Aug 2025 18:39:59 +0200 (CEST)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-76bfabdbef5so4759704b3a.1
 for <dev@dpdk.org>; Tue, 12 Aug 2025 09:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755016799; x=1755621599; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=fVBRGpAl/hqde7wHJNn3RWTjLCsXEwttewyEsnd1S70=;
 b=CV7nT9zMh72/wNoKG6WKKyXfVyRM0tSHW/+zsT3fOU5EdXnXTesdLTU1c4NRyiOpV3
 nSChA6uAaeQfvfBXOjiIhJeqCdFFfioXole6sNXV794ABV90j4Tk+vBo369f8wo1a6dy
 +dTtiG3mzUlw8OysoRKijsrXiwyliWo/s9Fj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755016799; x=1755621599;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fVBRGpAl/hqde7wHJNn3RWTjLCsXEwttewyEsnd1S70=;
 b=P4KstKeVC60SNInbg79xJEHw+7V7hiftcv81nbbutkZHLtxe38JEMhQi3F36cUaDQh
 DvOsTz70guetP87foRovISlbTTEHX4m2AzXk9kftvCygN/HlHGK8atSn2g2ldAjv5xpX
 OG5+22JiC45hyTcQ8B2ACZTx3Y/ym0sxsljKY484xURBs+vvZlXuWyTf346xrCPeThK1
 +TfImSuG/w5HAIj9BFgEinlb323CNU+BcjmlnzHsoYdRdJmBXSkU8qa4IqZQytyYTyEj
 SuQIZn0vCj3aJ616pSZLvZyDHZOnCILHuu4Y3uLJImhiSHIVmgz0FnzCPRntnw5cGBbU
 zvag==
X-Gm-Message-State: AOJu0Yxe4yn/usbrbvUiQ3+ABqjNv0vus8ifa8Lp4aMHB3nyeCZJWexi
 WlfnYI+17c6bOU2fM7PKdY/59eFR5iVS+DLP4GOHbGhBj0petHoOga/NcPEq9cWPAf4a6Q5yLA6
 FIevVajBEt0GG/n1Xiak+P5ShOFGUnR2DEtubEdSRng==
X-Gm-Gg: ASbGnct/mHrUdbxYym24QzVnHZ9MHgUoO2499YWlEzrOhtNMYWF3R7CanPP24TKnYL0
 FpoG+m9x1SmBgu1LjyVupEjvqqgK9/NP2QUlLuyq5BBr9lSsI9tGsdFfLrb4rwfc4nZ03qkDGBD
 Ndo+UOr0KK93+SaNUh3vJXXPAY0GtYQoANYQVpnSle8uJcwUJMrUWYFAXSEUP7WjLs3Hh+EIB7c
 aygMUmylOzdaZ3gpuJU+A==
X-Google-Smtp-Source: AGHT+IHg3RiFb+honf+3oZTrGSTV6PqbWieZgi77J8cGa1A9QBSnHMIt4vkAIvzpPJ0FfV65sHFGK/BEjsvQMaBhH0w=
X-Received: by 2002:a17:902:d58c:b0:234:8ec1:4af6 with SMTP id
 d9443c01a7336-2430c16b91dmr5139005ad.45.1755016798811; Tue, 12 Aug 2025
 09:39:58 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 12 Aug 2025 12:33:37 -0400
X-Gm-Features: Ac12FXykOj3HnCEOt3heFTkoYpmz9BWJcd4m6a1x_KtmeBlRhwX_Q6cK_CuJqdQ
Message-ID: <CAJvnSUDrZZsupFkSr+gBXA5aoGJ2BdespKWf143jbK0WsSw43A@mail.gmail.com>
Subject: Community CI Meeting Minutes - August 7, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Paul Szczepanek <Paul.Szczepanek@arm.com>, 
 Luca Vizzarro <Luca.Vizzarro@arm.com>, Dean Marx <dmarx@iol.unh.edu>, 
 Aaron Conole <aconole@redhat.com>
Content-Type: multipart/alternative; boundary="000000000000de4ffc063c2db022"
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

--000000000000de4ffc063c2db022
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Apologies for the delay in sending these notes out.

#####################################################################
August 7, 2025
Attendees
1. Patrick Robb
2. Luca Vizzarro
3. Dean Marx
4. Aaron Conole

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* Test rechecks:
   * DPDK.org patch recheck lab support list has been updated:
https://patchwork.dpdk.org/project/web/patch/20250725163057.1059638-1-probb=
@iol.unh.edu/
* DTS 25.11 Roadmap:
https://inbox.dpdk.org/dev/CAJvnSUB2scYCkV4BKFyxHVpPLFmhLYVb20tV0LFDeUHLWfV=
W+Q@mail.gmail.com/
* Luca has been added as a DTS maintainer, taking Paul=E2=80=99s place

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
AWS Lab
* None
UNH-IOL Community Lab
* The Community Lab will have downtime for a few hours on Tuesday August
12, for system upgrades
* Pw-ci: Aaron visited the lab last week and was curious about whether the
Community Lab can leverage the pw-ci project, which handles patch polling,
patch apply, etc.
   * UNH guys to look at standing this up side by side with our existing
backend to evaluate its usefulness
   * https://github.com/ovsrobot/pw-ci
*  Had an infra failure on the ARM Grace server this week, and put in
reruns from August 4 - August 6 to correct this.
* Has been stable otherwise.

---------------------------------------------------------------------
Intel Lab
* There were some build failures from Intel CI from the docs build for DTS,
which should be fixed with this patch which removes autodoc_pydantic from
the build:
https://patchwork.dpdk.org/project/dpdk/patch/20250801114547.1128950-1-luca=
.vizzarro@arm.com/
* Nothing otherwise

---------------------------------------------------------------------
Github Actions Robot
* Started integration of pull request for Sourcery AI analysis.
   * This is inadvertently causing testing to run 2x because the extra PR
for Sourcery is being picked up by testing
   * Will have to decide which repo for the pull requests to live in, but
it can either be the DPDK repo or ovsrobot repo
   * Will publish the pull request link in the checkpatch email, so people
can click it and look at the AI bot=E2=80=99s comments
      * If the bot feedback/comments prove useful, then we can look at
setting up a system for sending the bot comments as mails on the mailing
list.

---------------------------------------------------------------------
Loongson Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Andrew is adding missing type hints to function args and return types:
https://patchwork.dpdk.org/project/dpdk/patch/20250806162900.273571-1-abail=
ey@iol.unh.edu/
   * No new comments
* QinQ: https://patchwork.dpdk.org/project/dpdk/list/?series=3D35734
   * Dean Marxadd a ticket for trackin vlan_tci and vlan_tci_outer as a
later patchseries
   * Bruce has produced the following table:
VLAN Stripping Behavior Table
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D


Input Pkt Tags       | VLAN Strip        | QinQ Strip           | VLAN+QinQ
Strip
---------------------|-------------------|----------------------|----------=
------------------------
0x8100               | Tag in vlan_tci   |          --          | Tag in
vlan_tci
---------------------|-------------------|----------------------|----------=
------------------------
0x88a8               |        --         | Tag in vlan_tci_outer| Tag in
vlan_tci_outer
---------------------|-------------------|----------------------|----------=
------------------------
0x9100               |        --         |          --          |
     --
---------------------|-------------------|----------------------|----------=
------------------------
                     |                   |                      |
---------------------|-------------------|----------------------|----------=
------------------------
0x8100 0x8100        | Tag in vlan_tci   |          --          | Tag in
vlan_tci
---------------------|-------------------|----------------------|----------=
------------------------
0x8100 0x88a8        | Tag in vlan_tci   |          --          | Tag in
vlan_tci
---------------------|-------------------|----------------------|----------=
------------------------
0x8100 0x9100        | Tag in vlan_tci   |          --          | Tag in
vlan_tci
---------------------|-------------------|----------------------|----------=
------------------------
0x88a8 0x8100        |        --         | Tag in vlan_tci_outer| Tag in
vlan_tci_outer &
                     |                   |                      | tag in
vlan_tci
---------------------|-------------------|----------------------|----------=
------------------------
0x88a8 0x88a8        |        --         | Tag in vlan_tci_outer| Tag in
vlan_tci_outer
---------------------|-------------------|----------------------|----------=
------------------------
0x88a8 0x9100        |        --         | Tag in vlan_tci_outer| Tag in
vlan_tci_outer
---------------------|-------------------|----------------------|----------=
------------------------
0x9100 [any]         |        --         |          --          |
     --
---------------------|-------------------|----------------------|----------=
------------------------
* VM Virtio Testing:
   * For the proof of concept, we are setting a PvP (physical virtual
physical) single VM PoC where both physical functions are leveraged by
virtio devices on the VM.
* Add file management:
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35807
   * Patrick to provide a review today.
* RSS Testsuite: https://patchwork.dpdk.org/project/dpdk/list/?series=3D358=
36
   * Do we need to run this on any particular hardware?
      * Has been tested on E810 and ConnectX6
      * UNH guys can try with Broadcom
   * Otherwise, Patrick can provide a review.
* Forwarding Performance Test:
   * v3 coming in the next few days
* Testcase Docstring Example:
https://patchwork.dpdk.org/project/dpdk/patch/20250722171957.200698-1-dmarx=
@iol.unh.edu/
   * Dean Marx to switch the =E2=80=9Csteps=E2=80=9D to be an unordered lis=
t, which will
render better in the docs

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting August 21 at the same time

--000000000000de4ffc063c2db022
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Apologies for the delay in sending these notes out.</=
div><div><br></div>########################################################=
#############<br>August 7, 2025<br>Attendees<br>1. Patrick Robb<br>2. Luca =
Vizzarro<br>3. Dean Marx<br>4. Aaron Conole<br><br>########################=
#############################################<br>Minutes<br><br>=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<b=
r>* Test rechecks:<br>=C2=A0 =C2=A0* DPDK.org patch recheck lab support lis=
t has been updated: <a href=3D"https://patchwork.dpdk.org/project/web/patch=
/20250725163057.1059638-1-probb@iol.unh.edu/">https://patchwork.dpdk.org/pr=
oject/web/patch/20250725163057.1059638-1-probb@iol.unh.edu/</a><br>* DTS 25=
.11 Roadmap: <a href=3D"https://inbox.dpdk.org/dev/CAJvnSUB2scYCkV4BKFyxHVp=
PLFmhLYVb20tV0LFDeUHLWfVW+Q@mail.gmail.com/">https://inbox.dpdk.org/dev/CAJ=
vnSUB2scYCkV4BKFyxHVpPLFmhLYVb20tV0LFDeUHLWfVW+Q@mail.gmail.com/</a><br>* L=
uca has been added as a DTS maintainer, taking Paul=E2=80=99s place<br><br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><=
br>---------------------------------------------------------------------<br=
>AWS Lab<br>* None<br>UNH-IOL Community Lab<br>* The Community Lab will hav=
e downtime for a few hours on Tuesday August 12, for system upgrades<br>* P=
w-ci: Aaron visited the lab last week and was curious about whether the Com=
munity Lab can leverage the pw-ci project, which handles patch polling, pat=
ch apply, etc.<br>=C2=A0 =C2=A0* UNH guys to look at standing this up side =
by side with our existing backend to evaluate its usefulness<br>=C2=A0 =C2=
=A0* <a href=3D"https://github.com/ovsrobot/pw-ci">https://github.com/ovsro=
bot/pw-ci</a><br>* =C2=A0Had an infra failure on the ARM Grace server this =
week, and put in reruns from August 4 - August 6 to correct this.<br>* Has =
been stable otherwise.<br><br>---------------------------------------------=
------------------------<br>Intel Lab<br>* There were some build failures f=
rom Intel CI from the docs build for DTS, which should be fixed with this p=
atch which removes autodoc_pydantic from the build: <a href=3D"https://patc=
hwork.dpdk.org/project/dpdk/patch/20250801114547.1128950-1-luca.vizzarro@ar=
m.com/">https://patchwork.dpdk.org/project/dpdk/patch/20250801114547.112895=
0-1-luca.vizzarro@arm.com/</a><br>* Nothing otherwise<br><br>--------------=
-------------------------------------------------------<br>Github Actions R=
obot<br>* Started integration of pull request for Sourcery AI analysis.<br>=
=C2=A0 =C2=A0* This is inadvertently causing testing to run 2x because the =
extra PR for Sourcery is being picked up by testing<br>=C2=A0 =C2=A0* Will =
have to decide which repo for the pull requests to live in, but it can eith=
er be the DPDK repo or ovsrobot repo<br>=C2=A0 =C2=A0* Will publish the pul=
l request link in the checkpatch email, so people can click it and look at =
the AI bot=E2=80=99s comments<br>=C2=A0 =C2=A0 =C2=A0 * If the bot feedback=
/comments prove useful, then we can look at setting up a system for sending=
 the bot comments as mails on the mailing list.<br><br>--------------------=
-------------------------------------------------<br>Loongson Lab<br>* None=
<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS I=
mprovements &amp; Test Development<br>* Andrew is adding missing type hints=
 to function args and return types: <a href=3D"https://patchwork.dpdk.org/p=
roject/dpdk/patch/20250806162900.273571-1-abailey@iol.unh.edu/">https://pat=
chwork.dpdk.org/project/dpdk/patch/20250806162900.273571-1-abailey@iol.unh.=
edu/</a><br>=C2=A0 =C2=A0* No new comments<br>* QinQ: <a href=3D"https://pa=
tchwork.dpdk.org/project/dpdk/list/?series=3D35734">https://patchwork.dpdk.=
org/project/dpdk/list/?series=3D35734</a><br>=C2=A0 =C2=A0* Dean Marxadd a =
ticket for trackin vlan_tci and vlan_tci_outer as a later patchseries<br>=
=C2=A0 =C2=A0* Bruce has produced the following table:<br>VLAN Stripping Be=
havior Table<br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br><br><br>Input Pkt Tags =C2=A0 =C2=A0 =C2=
=A0 | VLAN Strip =C2=A0 =C2=A0 =C2=A0 =C2=A0| QinQ Strip =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 | VLAN+QinQ Strip<br>---------------------|--------------=
-----|----------------------|----------------------------------<br>0x8100 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | Tag in vlan_tci =C2=A0 |=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| T=
ag in vlan_tci<br>---------------------|-------------------|---------------=
-------|----------------------------------<br>0x88a8 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | Tag in vlan_tci_outer| Tag in vlan_tci_outer<br>-----------=
----------|-------------------|----------------------|---------------------=
-------------<br>0x9100 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--<br>---------------------|------=
-------------|----------------------|----------------------------------<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|<=
br>---------------------|-------------------|----------------------|-------=
---------------------------<br>0x8100 0x8100 =C2=A0 =C2=A0 =C2=A0 =C2=A0| T=
ag in vlan_tci =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0| Tag in vlan_tci<br>---------------------|------------=
-------|----------------------|----------------------------------<br>0x8100=
 0x88a8 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Tag in vlan_tci =C2=A0 | =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| Tag in vlan_tci=
<br>---------------------|-------------------|----------------------|------=
----------------------------<br>0x8100 0x9100 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
Tag in vlan_tci =C2=A0 | =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0| Tag in vlan_tci<br>---------------------|-----------=
--------|----------------------|----------------------------------<br>0x88a=
8 0x8100 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 | Tag in vlan_tci_outer| Tag in vlan_tci_outer &amp;<b=
r>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =
tag in vlan_tci<br>---------------------|-------------------|--------------=
--------|----------------------------------<br>0x88a8 0x88a8 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
Tag in vlan_tci_outer| Tag in vlan_tci_outer<br>---------------------|-----=
--------------|----------------------|----------------------------------<br=
>0x88a8 0x9100 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =C2=A0 =C2=A0-- =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 | Tag in vlan_tci_outer| Tag in vlan_tci_outer<=
br>---------------------|-------------------|----------------------|-------=
---------------------------<br>0x9100 [any] =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =
=C2=A0 =C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0-- =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0--<br>---------------------|------=
-------------|----------------------|----------------------------------<br>=
* VM Virtio Testing:<br>=C2=A0 =C2=A0* For the proof of concept, we are set=
ting a PvP (physical virtual physical) single VM PoC where both physical fu=
nctions are leveraged by virtio devices on the VM.<br>* Add file management=
: <a href=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D35807">=
https://patchwork.dpdk.org/project/dpdk/list/?series=3D35807</a><br>=C2=A0 =
=C2=A0* Patrick to provide a review today.<br>* RSS Testsuite: <a href=3D"h=
ttps://patchwork.dpdk.org/project/dpdk/list/?series=3D35836">https://patchw=
ork.dpdk.org/project/dpdk/list/?series=3D35836</a><br>=C2=A0 =C2=A0* Do we =
need to run this on any particular hardware?<br>=C2=A0 =C2=A0 =C2=A0 * Has =
been tested on E810 and ConnectX6<br>=C2=A0 =C2=A0 =C2=A0 * UNH guys can tr=
y with Broadcom<br>=C2=A0 =C2=A0* Otherwise, Patrick can provide a review.<=
br>* Forwarding Performance Test:<br>=C2=A0 =C2=A0* v3 coming in the next f=
ew days<br>* Testcase Docstring Example: <a href=3D"https://patchwork.dpdk.=
org/project/dpdk/patch/20250722171957.200698-1-dmarx@iol.unh.edu/">https://=
patchwork.dpdk.org/project/dpdk/patch/20250722171957.200698-1-dmarx@iol.unh=
.edu/</a><br>=C2=A0 =C2=A0* Dean Marx to switch the =E2=80=9Csteps=E2=80=9D=
 to be an unordered list, which will render better in the docs<br><br>=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other busines=
s<br>* Next Meeting August 21 at the same time<br><br></div>

--000000000000de4ffc063c2db022--
