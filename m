Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627FCC2D0CD
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 May 2025 21:26:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D6225410F9;
	Thu, 15 May 2025 23:26:29 +0200 (CEST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id 84D25410D0
 for <dev@dpdk.org>; Thu, 15 May 2025 23:26:28 +0200 (CEST)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-22e8461d872so13833035ad.3
 for <dev@dpdk.org>; Thu, 15 May 2025 14:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747344387; x=1747949187; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cZ04/G0lJcvccDoz4jcjvfLFzNOSxwD5af48ZN5zZbw=;
 b=NNBMkwQgEZdVbZjMAUrtwFP11rCyD5EJS9VBT+dVsKyYd0vPVsYZvwtZ/OgRhTOymZ
 R0eGZQnFfEardSelpj0VoOzohSJzZyvtwj/gRmuW44DsV4oOrF3YuDGsbbBThfxC8lm8
 cQtp6WPBJUdAm4MJNuASyCqwMNUGJUFB0Aw3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747344387; x=1747949187;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cZ04/G0lJcvccDoz4jcjvfLFzNOSxwD5af48ZN5zZbw=;
 b=uIkspvHR6WhO7fHYpGQtDlv8eHLsqF70iNsilcuzqdKMaGxr0j+yu3t0wnhQ1xkqqo
 zKUGkqaGDb3+W45ZrllDWEqhHlWj276U4anOkXKuyz4X0DmdoJ00P9XtJG1GRK/r0+X0
 ghTBX+JNFXgSdiBuOCfbXiH+m4TXP4C/TqkX7z8znRhoByYTiDgrxIfp6AO4c1gnvSUU
 TBVmXKZoKjNZi+P+e2W52f6ZR2LnpUeYX5NdYLk5MvANssxplXxbBCMeZbyHyvQtWnID
 vxuPv78obuDVsBchY91m5JXUPNxRuBOUjE8Js9yXutpxI5mW8xYIgZz3Oh3S2G55AK0B
 A7+A==
X-Gm-Message-State: AOJu0YybdNiDDmzGjVXjoWrsX5107tEoETiflEms+M5OU0qjqSD9R87R
 Oi0E6BGZ7EFVHolzEGoOjsPzXQYdFTR6a6R/5UGBQnEjJ5H2oR7oaeBmS9wVdqGMJtlRH4TLBtL
 +XjwaYEymfrqYV/ZInhIARIuGoLiTtAaQQKCAj2/fbA==
X-Gm-Gg: ASbGncv3rQNSEerrWCNZNGkcrUBjRn8udwyqQLHIeWS3+Jh6m6/drdw3/rWRfb4H8c5
 0kqE/jG+LnTJVRmJnwA9Syfu/dPicUU3kn36FrZG4Ujvc2GiOAumcXR/UX/OZbvuU3y/0biybyy
 HQpn3NzwL7c8IEKineqPZTUr65ZGdWm1o69liuHEzot7dRv9CUiJHJT8RTT+JzeDbStvslz2/pv
 biw
X-Google-Smtp-Source: AGHT+IH/CI/3bKNRJWj72ucGmIzXLbaz/P7BD2TuwhySxMYFpN4ZEIzqmPtYgK7aYWvSBl5d5GNvIZFs8yvluIXJInY=
X-Received: by 2002:a17:902:d2cd:b0:22d:b305:e097 with SMTP id
 d9443c01a7336-231d45acb5bmr10963335ad.50.1747344386904; Thu, 15 May 2025
 14:26:26 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 15 May 2025 17:21:45 -0400
X-Gm-Features: AX0GCFtLFOU4MhYt5fOj4J4esPINfSUA7AndwKL4UKdjlH-BoxW3xj-kfeuZ-1s
Message-ID: <CAJvnSUD_F18_H4ZruPWBbdSBP+LRMAzU2Ot=+GDHsgtnaYY_UQ@mail.gmail.com>
Subject: Community CI Meeting Minutes - May 15, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="0000000000007b6ada0635335108"
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

--0000000000007b6ada0635335108
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
May 15, 2025
Attendees
1. Patrick Robb
2. Paul Szczepanek
3. Luca Vizzarro
4. Manit Mahajan
5. Aaron Conole

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* DPDK Summit Prague was held May 8-9
* From talking with Shai (AWS lab maintainer) at DPDK Summit, it sounds
like he has an interest in the CI meetings, but that they are not a good
time for him. Patrick should find one of those =E2=80=9Cfree timeslot polli=
ng=E2=80=9D
tools and send such a poll to all the maintainers to figure out a timeslot
which would work for everyone.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* Pcapng unit test timestamp error:
   * This is a known issue which is coming from how the unit test leverages
the TSC timestamp register. We had conducted a simple test on this last
year which confirmed that the TSC did not run backwards, but the
conversation petered out. There is another failure now, so we need to take
another look at this.
      * Does TSC wraparound?
      * Email:
https://inbox.dpdk.org/ci/CAJvnSUCXns=3DJXV0FsWENqsifNzCA2NQhqJBCwDsfh=3DS4=
BbWy2A@mail.gmail.com/T/#t
* Bruce meson version patchseries:
   * Adds a script which reports the minimum meson version for a given DPDK
version, and also adds that into the .ci/linux-setup.sh script
* Bruce is suggesting some changes for where the LTS branches live:
   * Currently on github:
      * DPDK Repo: contains DPDK and the tagged releases (get no backports)
      * DPDK-stable repo: Contains the LTS releases which get backports
   * Bruce proposes to bring the LTS releases with backports to the DPDK
repo
   * There should be no adverse affects on existing CI processes
   * This should also encourage people to use the github DPDK repo more
instead of git.dpdk.org. As a reminder, all ci labs should be doing this.
* Patrick is back from DPDK Summit starting today, and can start to address
a few CI lab issues which have been backlogged since last week:
   * MLX5 DTS func tests - After some reconfiguration right before DPDK
summit, we started to rx no packets for a few testsuites. Patrick will
investigate today and figure out what=E2=80=99s going on.
   * E810 performance test issues:
      * Cody was investigating this issue and he has a solution, but
Patrick needs to approve the new changes and merge them today.
      * New topology: 2 E810 NICs connected against 1 E810 DUT NIC.
      * TREX change on the single core forwarding test: Trex (not testpmd
or DUT E810) had an issue with sending rate given a certain mix of packets
which are used by default in the single core forwarding testsuite. Cody has
updated the testsuite to use a uniform packet model (instead of a mix),
which resolves the issue on the traffic generator side. The performance on
the DUT is still good (like it always was) but it is no longer affected by
the traffic generator issue.
         * Patrick will review this solution today - most likely we can
re-enable the test

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions
* None

---------------------------------------------------------------------
AWS
* We met with Shai at DPDK Prague. Some takeaways:
* He is interested in supporting the recheck framework, and would like to
sync with us on that at an upcoming meeting.
   * But we will have to wait 2 weeks for that, so Patrick might as well
start the conversation over email
* DTS: For sending packets between TG and DUT AWS EC2 instances, we cannot
send with a mac destination address - we have to send with an IP
destination address.

---------------------------------------------------------------------
Loongarch Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* DPDK-Pktgen:
   * The Suricata guys got to chatting with Patrick at DPDK Summit about
their DPDK-pktgen usage. They are able to use it for 100gbps+ TG
operations, and they have shared some code showing how they use dpdk-pktgen
in their CI testing. Patrick can share with the UNH team, and can probable
also overview what they shared at the DTS meeting next week.
* Flow checker tool:
   * There was a flow rule checker tool for DPDK 22.11 which is no longer
being maintained publicly, but the original creator still maintains it
privately for his usage, and can push the updates if we need.
   * Patrick will look at this tool from 22.11
* Rte_flow: MVP testsuite is done - he is submitting to patchwork this
morning.
* Birds of a Feather:
   * This was productive and there were some good suggestions:
   * Suggestions:
      * Code coverage reports for DTS
      * Support smaller topologies: namely testing DTS with 1 dual port NIC
connected in loopback.
         * Or, run DTS from a laptop using virtual ports
      * Write some blogs about how to use DTS this year
      * Support other programs (user apps)
* Reviews:
   * Patrick will send his review of the TREX patchseries today
   * Luca reviewed the l4 port matching series. They are conceptually fine,
but he had a few comment or docstring nits which he left. Dean can update
this today and resubmit.
   * Improve port handling series:
      * Groups all the port handling under the topology class - the
topology class becomes the interface for port handling.
      * Patrick and UNH guys need to review this
   * VF patchseries:
      * It would be better if these were integrated in the topology.
      * May have to make the next version a depends-on the =E2=80=9Cimprove=
 port
handling=E2=80=9D series
      * Confirmed that bnxt_en has the same promiscuous mdoe support
requirement as Intel (bind to kernel driver, then set =E2=80=9Ctrust=E2=80=
=9D mode on the
port, then bind to vfio-pci).
   * Patrick merged the port_stats testsuite, but it includes an error for
building the docs. There is a simple fix which Luca suggested, and Patrick
will submit it.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting May 29, 2025

--0000000000007b6ada0635335108
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>May 15, 2025<br>Attendees<br>1. Patrick Robb<br>2. Paul Szcz=
epanek<br>3. Luca Vizzarro<br>4. Manit Mahajan<br>5. Aaron Conole<br><br>##=
###################################################################<br>Minu=
tes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Ge=
neral Announcements<br>* DPDK Summit Prague was held May 8-9<br>* From talk=
ing with Shai (AWS lab maintainer) at DPDK Summit, it sounds like he has an=
 interest in the CI meetings, but that they are not a good time for him. Pa=
trick should find one of those =E2=80=9Cfree timeslot polling=E2=80=9D tool=
s and send such a poll to all the maintainers to figure out a timeslot whic=
h would work for everyone.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>------------------------------------=
---------------------------------<br>UNH-IOL Community Lab<br>* Pcapng unit=
 test timestamp error:<br>=C2=A0 =C2=A0* This is a known issue which is com=
ing from how the unit test leverages the TSC timestamp register. We had con=
ducted a simple test on this last year which confirmed that the TSC did not=
 run backwards, but the conversation petered out. There is another failure =
now, so we need to take another look at this. <br>=C2=A0 =C2=A0 =C2=A0 * Do=
es TSC wraparound?<br>=C2=A0 =C2=A0 =C2=A0 * Email: <a href=3D"https://inbo=
x.dpdk.org/ci/CAJvnSUCXns=3DJXV0FsWENqsifNzCA2NQhqJBCwDsfh=3DS4BbWy2A@mail.=
gmail.com/T/#t">https://inbox.dpdk.org/ci/CAJvnSUCXns=3DJXV0FsWENqsifNzCA2N=
QhqJBCwDsfh=3DS4BbWy2A@mail.gmail.com/T/#t</a><br>* Bruce meson version pat=
chseries:<br>=C2=A0 =C2=A0* Adds a script which reports the minimum meson v=
ersion for a given DPDK version, and also adds that into the .ci/linux-setu=
p.sh script<br>* Bruce is suggesting some changes for where the LTS branche=
s live:<br>=C2=A0 =C2=A0* Currently on github:<br>=C2=A0 =C2=A0 =C2=A0 * DP=
DK Repo: contains DPDK and the tagged releases (get no backports)<br>=C2=A0=
 =C2=A0 =C2=A0 * DPDK-stable repo: Contains the LTS releases which get back=
ports<br>=C2=A0 =C2=A0* Bruce proposes to bring the LTS releases with backp=
orts to the DPDK repo<br>=C2=A0 =C2=A0* There should be no adverse affects =
on existing CI processes<br>=C2=A0 =C2=A0* This should also encourage peopl=
e to use the github DPDK repo more instead of <a href=3D"http://git.dpdk.or=
g">git.dpdk.org</a>. As a reminder, all ci labs should be doing this.<br>* =
Patrick is back from DPDK Summit starting today, and can start to address a=
 few CI lab issues which have been backlogged since last week:<br>=C2=A0 =
=C2=A0* MLX5 DTS func tests - After some reconfiguration right before DPDK =
summit, we started to rx no packets for a few testsuites. Patrick will inve=
stigate today and figure out what=E2=80=99s going on.<br>=C2=A0 =C2=A0* E81=
0 performance test issues:<br>=C2=A0 =C2=A0 =C2=A0 * Cody was investigating=
 this issue and he has a solution, but Patrick needs to approve the new cha=
nges and merge them today.<br>=C2=A0 =C2=A0 =C2=A0 * New topology: 2 E810 N=
ICs connected against 1 E810 DUT NIC.<br>=C2=A0 =C2=A0 =C2=A0 * TREX change=
 on the single core forwarding test: Trex (not testpmd or DUT E810) had an =
issue with sending rate given a certain mix of packets which are used by de=
fault in the single core forwarding testsuite. Cody has updated the testsui=
te to use a uniform packet model (instead of a mix), which resolves the iss=
ue on the traffic generator side. The performance on the DUT is still good =
(like it always was) but it is no longer affected by the traffic generator =
issue.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Patrick will review this solu=
tion today - most likely we can re-enable the test<br><br>-----------------=
----------------------------------------------------<br>Intel Lab<br>* None=
<br><br>-------------------------------------------------------------------=
--<br>Github Actions<br>* None<br><br>-------------------------------------=
--------------------------------<br>AWS<br>* We met with Shai at DPDK Pragu=
e. Some takeaways:<br>* He is interested in supporting the recheck framewor=
k, and would like to sync with us on that at an upcoming meeting. <br>=C2=
=A0 =C2=A0* But we will have to wait 2 weeks for that, so Patrick might as =
well start the conversation over email<br>* DTS: For sending packets betwee=
n TG and DUT AWS EC2 instances, we cannot send with a mac destination addre=
ss - we have to send with an IP destination address.<br><br>---------------=
------------------------------------------------------<br>Loongarch Lab<br>=
* None<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br=
>DTS Improvements &amp; Test Development<br>* DPDK-Pktgen:<br>=C2=A0 =C2=A0=
* The Suricata guys got to chatting with Patrick at DPDK Summit about their=
 DPDK-pktgen usage. They are able to use it for 100gbps+ TG operations, and=
 they have shared some code showing how they use dpdk-pktgen in their CI te=
sting. Patrick can share with the UNH team, and can probable also overview =
what they shared at the DTS meeting next week.<br>* Flow checker tool:<br>=
=C2=A0 =C2=A0* There was a flow rule checker tool for DPDK 22.11 which is n=
o longer being maintained publicly, but the original creator still maintain=
s it privately for his usage, and can push the updates if we need.<br>=C2=
=A0 =C2=A0* Patrick will look at this tool from 22.11<br>* Rte_flow: MVP te=
stsuite is done - he is submitting to patchwork this morning.<br>* Birds of=
 a Feather:<br>=C2=A0 =C2=A0* This was productive and there were some good =
suggestions:<br>=C2=A0 =C2=A0* Suggestions:<br>=C2=A0 =C2=A0 =C2=A0 * Code =
coverage reports for DTS<br>=C2=A0 =C2=A0 =C2=A0 * Support smaller topologi=
es: namely testing DTS with 1 dual port NIC connected in loopback.<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Or, run DTS from a laptop using virtual po=
rts<br>=C2=A0 =C2=A0 =C2=A0 * Write some blogs about how to use DTS this ye=
ar<br>=C2=A0 =C2=A0 =C2=A0 * Support other programs (user apps)<br>* Review=
s:<br>=C2=A0 =C2=A0* Patrick will send his review of the TREX patchseries t=
oday<br>=C2=A0 =C2=A0* Luca reviewed the l4 port matching series. They are =
conceptually fine, but he had a few comment or docstring nits which he left=
. Dean can update this today and resubmit.<br>=C2=A0 =C2=A0* Improve port h=
andling series:<br>=C2=A0 =C2=A0 =C2=A0 * Groups all the port handling unde=
r the topology class - the topology class becomes the interface for port ha=
ndling.<br>=C2=A0 =C2=A0 =C2=A0 * Patrick and UNH guys need to review this<=
br>=C2=A0 =C2=A0* VF patchseries: <br>=C2=A0 =C2=A0 =C2=A0 * It would be be=
tter if these were integrated in the topology.<br>=C2=A0 =C2=A0 =C2=A0 * Ma=
y have to make the next version a depends-on the =E2=80=9Cimprove port hand=
ling=E2=80=9D series<br>=C2=A0 =C2=A0 =C2=A0 * Confirmed that bnxt_en has t=
he same promiscuous mdoe support requirement as Intel (bind to kernel drive=
r, then set =E2=80=9Ctrust=E2=80=9D mode on the port, then bind to vfio-pci=
).<br>=C2=A0 =C2=A0* Patrick merged the port_stats testsuite, but it includ=
es an error for building the docs. There is a simple fix which Luca suggest=
ed, and Patrick will submit it.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Next Meeting May 29, 2025<=
/div>

--0000000000007b6ada0635335108--
