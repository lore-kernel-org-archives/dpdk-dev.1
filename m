Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CAECA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:44:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACCFB402A8;
	Thu, 14 Aug 2025 23:44:32 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id A161C40265
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:44:30 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-24457f581aeso11911585ad.0
 for <dev@dpdk.org>; Thu, 14 Aug 2025 14:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1755207869; x=1755812669; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Uw8IllTm+Un23rBpE1d2PePY4N0OWSUHyVJ1fdgHzXI=;
 b=PiG/EuZkAkmhAwnCYDeRSbu1wBwcGaXNu3dA/oo1IHSH1Rey8oASplKi85xCO8GmOR
 9tiUAapmYBMQNn4cYwNCY/k9D+FRI1dKD+yZDOV0yCdvJJMxqC3G/sRlevvQZT9vZIHV
 LONcRS2tGFSASfuL38HKbjHmj1nM9rxPY+a4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755207869; x=1755812669;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uw8IllTm+Un23rBpE1d2PePY4N0OWSUHyVJ1fdgHzXI=;
 b=cd/4B+HbZKhzYrociZR3KoebxtkZo+PFJSJDYTsbR77aLLQFrR5gCBWUnING0dCqV9
 IPPHutsFBQt6wcUCIaNwBbmwDo1YgOwWeDtd6YWS8o0Pcn3hF7qpJnotuRB5CvLjHHID
 5x1DJYbpe0/iGk14L0ICN6/rKJmIKQGhlmK/UaRl3KusD3QLP0EavxkNWOoYp/S94kwI
 8oiDWZiXmwpguVB6v0IJNaPg3/G5WFVdCfeeQbI2TXGFhj6MZpIPXhT78BB4vS9Qwhpy
 jHVZHcnnz75j+g7Ke2K75uQHGQZ1fWYlXVJh8OVvarQqH+2lgdRABu0zBjpLeSKrNRyF
 Tp5A==
X-Gm-Message-State: AOJu0YyDG2yyAtXpFnaIBeot9YQyHuYAyvKqGCVeKiAIHVTLJ9W8RL2B
 JcWLUQjBUSrbt9Fu9GgRkF5VtPQ5NJlYLENIhzw/uDIcQYvJUlcg18gRxWAzaGudl/dYp7g2MWw
 +0SnOV+1MKo1ppbzAFibjKujChSlzsFmfVYdSPOsXdTQ31c3VH7kJ2ZI=
X-Gm-Gg: ASbGncta1l/+BQ0ywuk6MZpU4DknLFtKba677biXfUbBy8mnC17JW1ks2XbGZ+NOMOs
 TTS8qb8TtkvepLvFQF4seDM3JlAWvASnMpd/+UB/NSyXeNipVCiPzwRcsAftR6jPE2BuA/mIo0h
 dwPIPYxlKuoxMZ18WkCcePzuJQ/jiq195ksTs2ZLP8ZNiGpaTSRS/bV0ZuXDr4FM1QjaLeTAMv9
 nyNvosaKVByfoMIJvaDMqvTZUaGNdCzRIhQw3/9
X-Google-Smtp-Source: AGHT+IFP216j9G8BJEnMDG7LoxRfSvbKFqJ3Zi7v64nypNPwx3tQGXqbfEtHS5zUIrMHnfiz2S02fd7AlPbVjGRMiPM=
X-Received: by 2002:a17:903:230c:b0:240:5549:708e with SMTP id
 d9443c01a7336-244586c501emr73772565ad.46.1755207869197; Thu, 14 Aug 2025
 14:44:29 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 14 Aug 2025 17:38:04 -0400
X-Gm-Features: Ac12FXzmU2NBhSCkrl_hrKaNlXo-ldGwRUCQplAW3axptO7gnSXzypKukmpW4c0
Message-ID: <CAJvnSUBN_X4cWYCZtmMRZgpgayCxqkCk9iDNc4Jkw+k3Ch-vQg@mail.gmail.com>
Subject: DTS WG Meeting Minutes - August 14, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org, dts@dpdk.org, Luca Vizzarro <Luca.Vizzarro@arm.com>, 
 Dean Marx <dmarx@iol.unh.edu>, Paul Szczepanek <Paul.Szczepanek@arm.com>, 
 Andrew Bailey <abailey@iol.unh.edu>, Manit Mahajan <mmahajan@iol.unh.edu>, 
 =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Content-Type: multipart/alternative; boundary="0000000000008d0960063c5a2dd1"
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

--0000000000008d0960063c5a2dd1
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
August 14, 2025
Attendees
* Patrick Robb
* Luca Vizzarro
* Paul Szczepanek
* Andrew Bailey
* Manit Mahajan
* Dean Marx

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Discussion
* RFC deadline for 25.11 development is August 31.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Patch discussions
* DPDKRuntimeEnvironment:
   * Currently various methods in DPDKRuntimeEnvironment basically have a
switch for =E2=80=9CSUT=E2=80=9D or =E2=80=9CTG=E2=80=9D in various methods=
, though the
DPDKRuntimeEnvironment is only ever instantiated for the TG Node.
      * So, proposal is to introduce an abstract class for
DPDKRuntimeEnvironment, with TG and SUT specific implementations of this
abstract class
   * The main practical reason why we want to be able to instantiate a
variant of DPDKRuntimeEnvironment on the TG is in order to call
_prepare_devbind_script() so that the TG ports will bind to the correct
driver.
   * Should we move the devbind responsibility to the topology class
      * Could remove devbind_script_path from linux session
      * and copy devbind to TG and SUT in the same way, meaning there is
one solution now for both nodes
* Add File Management:
   * Desired testlogs output dir structure
   * Testsuite logs and Testcase logs only include state information
* RSS:
   * Patrick Robband Andrew Baileyto review this and test it on lab devices
* Rxtx_offload testsuite:
   * Morten has drafted a required update to the testplan for mbuf fast
free. Patrick will send a new version in new DTS.
https://bugs.dpdk.org/show_bug.cgi?id=3D1769
* DTS API:
   * In progress
   * All of the files which are to be exposed to the testsuite surface will
be moved to a new =E2=80=9CAPI=E2=80=9D folder, and dts internals which sho=
uld not be
imported to the testsuite will be located elsewhere.
   * Splitting out some files, for instance for capabilities which users
will decorate their testsuites/cases with, the enums for those capabilities
are moved to the API dir, though the associated capability code will remain
outside of the API dir.
* Dean=E2=80=99s checksum testsuite doc updates were merged

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bugzilla discussions
* Review bugzilla tickets:
   *
https://bugs.dpdk.org/buglist.cgi?quicksearch=3Dcomponent%3Adts&list_id=3D9=
444

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* VM setup - Virtio:
   * Investigating different virtio workloads, topologies, and methods of
delivering a DPDK ready VM(s) to DTS
* Next meeting is Aug 28, 2025

--0000000000008d0960063c5a2dd1
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>August 14, 2025<br>Attendees<br>* Patrick Robb<br>* Luca Viz=
zarro<br>* Paul Szczepanek<br>* Andrew Bailey<br>* Manit Mahajan<br>* Dean =
Marx<br><br>###############################################################=
######<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>General Discussion<br>* RFC deadline for 25.11 development is =
August 31.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
<br>Patch discussions<br>* DPDKRuntimeEnvironment:<br>=C2=A0 =C2=A0* Curren=
tly various methods in DPDKRuntimeEnvironment basically have a switch for =
=E2=80=9CSUT=E2=80=9D or =E2=80=9CTG=E2=80=9D in various methods, though th=
e DPDKRuntimeEnvironment is only ever instantiated for the TG Node.<br>=C2=
=A0 =C2=A0 =C2=A0 * So, proposal is to introduce an abstract class for DPDK=
RuntimeEnvironment, with TG and SUT specific implementations of this abstra=
ct class<br>=C2=A0 =C2=A0* The main practical reason why we want to be able=
 to instantiate a variant of DPDKRuntimeEnvironment on the TG is in order t=
o call _prepare_devbind_script() so that the TG ports will bind to the corr=
ect driver.<br>=C2=A0 =C2=A0* Should we move the devbind responsibility to =
the topology class<br>=C2=A0 =C2=A0 =C2=A0 * Could remove devbind_script_pa=
th from linux session<br>=C2=A0 =C2=A0 =C2=A0 * and copy devbind to TG and =
SUT in the same way, meaning there is one solution now for both nodes<br>* =
Add File Management:<br>=C2=A0 =C2=A0* Desired testlogs output dir structur=
e<br>=C2=A0 =C2=A0* Testsuite logs and Testcase logs only include state inf=
ormation<br>* RSS:<br>=C2=A0 =C2=A0* Patrick Robband Andrew Baileyto review=
 this and test it on lab devices<br>* Rxtx_offload testsuite: =C2=A0 =C2=A0=
 =C2=A0 =C2=A0<br>=C2=A0 =C2=A0* Morten has drafted a required update to th=
e testplan for mbuf fast free. Patrick will send a new version in new DTS. =
<a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1769">https://bugs.dpdk.=
org/show_bug.cgi?id=3D1769</a><br>* DTS API:<br>=C2=A0 =C2=A0* In progress<=
br>=C2=A0 =C2=A0* All of the files which are to be exposed to the testsuite=
 surface will be moved to a new =E2=80=9CAPI=E2=80=9D folder, and dts inter=
nals which should not be imported to the testsuite will be located elsewher=
e.<br>=C2=A0 =C2=A0* Splitting out some files, for instance for capabilitie=
s which users will decorate their testsuites/cases with, the enums for thos=
e capabilities are moved to the API dir, though the associated capability c=
ode will remain outside of the API dir.<br>* Dean=E2=80=99s checksum testsu=
ite doc updates were merged<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D<br>Bugzilla discussions<br>* Review bugzilla tickets:<br=
>=C2=A0 =C2=A0* <a href=3D"https://bugs.dpdk.org/buglist.cgi?quicksearch=3D=
component%3Adts&amp;list_id=3D9444">https://bugs.dpdk.org/buglist.cgi?quick=
search=3Dcomponent%3Adts&amp;list_id=3D9444</a><br>=C2=A0 =C2=A0<br>=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<b=
r>* VM setup - Virtio:<br>=C2=A0 =C2=A0* Investigating different virtio wor=
kloads, topologies, and methods of delivering a DPDK ready VM(s) to DTS<br>=
* Next meeting is Aug 28, 2025<br><br><br></div>

--0000000000008d0960063c5a2dd1--
