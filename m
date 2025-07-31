Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C303C87FC9
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 00:11:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BD014026A;
	Thu, 31 Jul 2025 02:11:47 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id E03544025A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 02:11:45 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-31ee880f7d2so423116a91.0
 for <dev@dpdk.org>; Wed, 30 Jul 2025 17:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753920705; x=1754525505; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=xHQyCtJnkorCnw4veDIWHVhZv/gTxCiLggFDMM/jyEM=;
 b=Tl8SEsJ1yRAxVTZBjzE4Hrr1J8miq70C9K0lL+EELEm/J7rB7jDuHxzby/PIR57aSs
 3qP4f5vCsgA3agrofU927sAZWldGbMiSDYdxNnkEXt4wliKPUCa3GDEUEABW7a+ZeWZX
 24LZdT5ZjnqHwW7ZgX1ljysPq1uFEvYLyOiMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753920705; x=1754525505;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xHQyCtJnkorCnw4veDIWHVhZv/gTxCiLggFDMM/jyEM=;
 b=ujD71kge1q7HUxuqSCi3lVF945UmdW21zkvb2nVo6eAio6jGS4tOwTtcQomtq8aDUJ
 iN6X2zfb2Bkb8GFN9R3x3/EpN1Q2x0B8e2k4O8l7MKRfwb1m5ckaiL62NsvCpdbmLgzY
 3zl8+bZbsmuQXxInl69ZqeG4RV2EOcT8mbf9NgrZmPJzNNjGmxVeuFntYw8VJO2Ug4cl
 HackbZgiEE5etKlNIDVaNk59T3He1I1tbKdp5KzRtUib6MnyDgTHt+6wU5FXgIo6HFch
 amc9vCBFnS7F+ZlIci2FtnZuTkvevWw9bnMPp5V3MdWMskgaf1KHT+2ficd7MDA+iXNZ
 gTXg==
X-Gm-Message-State: AOJu0Yz5qu0UPBJt9BFzbk/vvcjkKAANh7LU5CAS/CfTwW7GmoLaMVUQ
 VGhJkiidwLj3fEhhI+hcpWalSFto2R4D+xc03PIj+eBOqV/TLnyPDTam63+IQWshcXompPKuY9g
 9YM4FGHmw31ux072zu1W+V+rVdViFSEN6iK2+36LViQ==
X-Gm-Gg: ASbGnctV+0UUsmnaz+T1c7FBI+tMOtJu0ObnSSbKFHGzdKtkd5EWZt9Fv+MkJW2/ejZ
 QZJkyLBCjSCTezXC7nCz0Gm/rUfocVjvpsk6Ho2Q/BfjeL5pq9gUDJCF6CaQcOP0AXpbKW+2W/S
 7N/MtUV6UVatIYPhmSkTDLVyV1dg5pyCZGgtoSENwN2NTIzGa8UUXU8RcWrmhmElgrddb/GHo22
 VVHZLRel8DUGelFNyvp6w==
X-Google-Smtp-Source: AGHT+IGtf2+OPPloGHX62KeEuxASBnQk7P9NQ1kygPuvpYKUp84W5m/kAcS5kqkmjhhP0oESx037yAD1p9JLBiw03Jk=
X-Received: by 2002:a17:90b:3c8c:b0:313:db0b:75db with SMTP id
 98e67ed59e1d1-31f5de7ba65mr7605452a91.33.1753920704798; Wed, 30 Jul 2025
 17:11:44 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 30 Jul 2025 20:05:37 -0400
X-Gm-Features: Ac12FXxZYYdm4KPFhc7H05T4OW2XcoJ4aYZ1cgOFGkYD7W4vCTLiKfhw9wp1Vck
Message-ID: <CAJvnSUDUq3OqfgL=Sam_iCRX7OBqU1H+u6czSO=UgK2TFyhmGQ@mail.gmail.com>
Subject: Community CI Meeting Minutes - July 24, 2025
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Paul Szczepanek <Paul.Szczepanek@arm.com>, 
 Luca Vizzarro <Luca.Vizzarro@arm.com>, Dean Marx <dmarx@iol.unh.edu>, 
 Aaron Conole <aconole@redhat.com>, Manit Mahajan <mmahajan@iol.unh.edu>, 
 "Brandes, Shai" <shaibran@amazon.com>, 
 "Puttaswamy, Rajesh T" <rajesh.t.puttaswamy@intel.com>,
 zhoumin <zhoumin@loongson.cn>, ivan.malov@arknetworks.am
Content-Type: multipart/alternative; boundary="00000000000092f548063b2e7c9c"
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

--00000000000092f548063b2e7c9c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
July 24, 2025
Attendees
1. Patrick Robb
2. Luca Vizzarro
3. Dean Marx
4. Adam Hassick
5. Paul Szczepanek

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* DPDK 25.07 is released.
* DPDK Santa Clara is cancelled
* Aaron will be visiting the UNH Lab next week, and will collaborate with
the UNH group on dpdk-ci scripting and CI testing goals.
   * Adam Hassickplease be sure to review the draft polling script that
Manit has shared

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
AWS Lab
* Seems to be running fine
* UNH team wants to work with Shai during this release on getting some
partial support from DTS for the AWS environment working. To that end, is
it possible for the UNH DTS developers to get some SSH access to some
Amazon EC2 instances to try to run the DTS framework? Patrick to ask Shai
this.
UNH-IOL Community Lab
* Opensuse Leap 15 is shipping with a version of GCC which is now below the
DPDK Minimum (GCC 8). From some research it seems typical for SUSE distros
to include a relatively old system gcc, and users will install newer
toolchain GCC versions. It appears that the zypper repos distribute gcc 14,
so we will upgrade the container template engine to use this version.
   * Also, we are adding a blurb to the lab.dpdk.org about page explaining
the categories of distros we try to test, and how we determine what =E2=80=
=9Cbase=E2=80=9D
build utilities are included in the test environment.
* Windows:
   * Andre has sent new instructions for finding the devx library during
the meson compile, and the UNH team is updating their build pipelines to
include this:
https://patchwork.dpdk.org/project/dpdk/patch/1752588889-27133-1-git-send-e=
mail-andremue@linux.microsoft.com/
* QinQ: Dean is still working with Bruce and Morten on evaluating the QinQ
behavior on UNH Lab devices. He has published a latest version of the QinQ
testsuite which Morten thumbed up, and he shared the QinQ behavior for
Intel i40e and cx5 on the mailing list.
   * Broadcom NICs are supposed to support VLAN stripping but in the lab
are reporting that they don=E2=80=99t support vlan strip. Ajit Khapardeis l=
ooking.
* Lab downtime
   * UNH team needs to move the Jenkins instance to a new machine, which
will require some lab downtime. Patrick will take the lab offline on Friday
afternoon, and turn it back on on Saturday or Sunday.

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions Robot
* None

---------------------------------------------------------------------
Loongson Lab
* Min Zhou did reply back saying that they=E2=80=99re supporting the rebase=
 flag
now on test recheck requests.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* RSS Testsuite:
   * Ivan Malov has noted that the flow rules are overriding the global
RETA table
   * Thomas is reworking the testsuite to validate through the global RETA
table behavior
* DTS Roadmap:
   * VM tests: Framework update: Use QEMU to spin up a virtual machine on
the SUT, pass the VFs to it, run either some existing DTS testsuite across
it, and/or add some VM functional validation testsuites
   * VHost tests: General idea is to run some DPDK packet switching
application on the baremetal and pass traffic to virtio. Patrick needs to
assess if this is a valuable enough item to include in the roadmap.
   * DTS API
      * Single point of entry into the framework for all test suites,
allowing stable usage across releases and user friendly discoverability of
dts functionality
      * Where there is overlap between the DTS API and the existing =E2=80=
=9CAPI=E2=80=9D
methods available in the Testsuite class, remove the Testsuite class method=
s
   * Packet Forwarding Performance tests
   * Cryptodev support: Just adding support for the dpdk-crypto-perf
application, may require another DPDK Shell implementation
   * Cryptodev tests: Either as a func or perf test (compare against a
baseline), run some encrypt/decrypt workloads with the various supported
algorithms on DPDK nics.
   * Testing with single NIC with the 2 interfaces connected in a loopback
      * This appears to be working, but need to be documented
   * Additional functional ethdev testsuites:
      * Ethertype Testsuite
      * QinQ Testsuite
      * RSS Testsuite
      * Rx/Tx Offload
   * File manager:
      * Add a dedicated file manager to handle passing files and artifacts
between the test engine and nodes in a path agnostic manner.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Patrick Robb submit the website update with the latest recheck coverage.
* Next Meeting August 7th at the same time

--00000000000092f548063b2e7c9c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>######################################################=
###############<br>July 24, 2025<br>Attendees<br>1. Patrick Robb<br>2. Luca=
 Vizzarro<br>3. Dean Marx<br>4. Adam Hassick<br>5. Paul Szczepanek<br><br>#=
####################################################################<br>Min=
utes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Ge=
neral Announcements<br>* DPDK 25.07 is released.<br>* DPDK Santa Clara is c=
ancelled<br>* Aaron will be visiting the UNH Lab next week, and will collab=
orate with the UNH group on dpdk-ci scripting and CI testing goals.<br>=C2=
=A0 =C2=A0* Adam Hassickplease be sure to review the draft polling script t=
hat Manit has shared<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D<br>CI Status<br><br>------------------------------------------=
---------------------------<br>AWS Lab<br>* Seems to be running fine<br>* U=
NH team wants to work with Shai during this release on getting some partial=
 support from DTS for the AWS environment working. To that end, is it possi=
ble for the UNH DTS developers to get some SSH access to some Amazon EC2 in=
stances to try to run the DTS framework? Patrick to ask Shai this.<br>UNH-I=
OL Community Lab<br>* Opensuse Leap 15 is shipping with a version of GCC wh=
ich is now below the DPDK Minimum (GCC 8). From some research it seems typi=
cal for SUSE distros to include a relatively old system gcc, and users will=
 install newer toolchain GCC versions. It appears that the zypper repos dis=
tribute gcc 14, so we will upgrade the container template engine to use thi=
s version.<br>=C2=A0 =C2=A0* Also, we are adding a blurb to the <a href=3D"=
http://lab.dpdk.org">lab.dpdk.org</a> about page explaining the categories =
of distros we try to test, and how we determine what =E2=80=9Cbase=E2=80=9D=
 build utilities are included in the test environment.<br>* Windows:<br>=C2=
=A0 =C2=A0* Andre has sent new instructions for finding the devx library du=
ring the meson compile, and the UNH team is updating their build pipelines =
to include this: <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/1=
752588889-27133-1-git-send-email-andremue@linux.microsoft.com/">https://pat=
chwork.dpdk.org/project/dpdk/patch/1752588889-27133-1-git-send-email-andrem=
ue@linux.microsoft.com/</a><br>* QinQ: Dean is still working with Bruce and=
 Morten on evaluating the QinQ behavior on UNH Lab devices. He has publishe=
d a latest version of the QinQ testsuite which Morten thumbed up, and he sh=
ared the QinQ behavior for Intel i40e and cx5 on the mailing list.<br>=C2=
=A0 =C2=A0* Broadcom NICs are supposed to support VLAN stripping but in the=
 lab are reporting that they don=E2=80=99t support vlan strip. Ajit Khapard=
eis looking.<br>* Lab downtime<br>=C2=A0 =C2=A0* UNH team needs to move the=
 Jenkins instance to a new machine, which will require some lab downtime. P=
atrick will take the lab offline on Friday afternoon, and turn it back on o=
n Saturday or Sunday.<br><br>----------------------------------------------=
-----------------------<br>Intel Lab<br>* None<br><br>---------------------=
------------------------------------------------<br>Github Actions Robot<br=
>* None<br><br>------------------------------------------------------------=
---------<br>Loongson Lab<br>* Min Zhou did reply back saying that they=E2=
=80=99re supporting the rebase flag now on test recheck requests. <br><br>=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvemen=
ts &amp; Test Development<br>* RSS Testsuite:<br>=C2=A0 =C2=A0* Ivan Malov =
has noted that the flow rules are overriding the global RETA table<br>=C2=
=A0 =C2=A0* Thomas is reworking the testsuite to validate through the globa=
l RETA table behavior<br>* DTS Roadmap:<br>=C2=A0 =C2=A0* VM tests: Framewo=
rk update: Use QEMU to spin up a virtual machine on the SUT, pass the VFs t=
o it, run either some existing DTS testsuite across it, and/or add some VM =
functional validation testsuites<br>=C2=A0 =C2=A0* VHost tests: General ide=
a is to run some DPDK packet switching application on the baremetal and pas=
s traffic to virtio. Patrick needs to assess if this is a valuable enough i=
tem to include in the roadmap.<br>=C2=A0 =C2=A0* DTS API<br>=C2=A0 =C2=A0 =
=C2=A0 * Single point of entry into the framework for all test suites, allo=
wing stable usage across releases and user friendly discoverability of dts =
functionality<br>=C2=A0 =C2=A0 =C2=A0 * Where there is overlap between the =
DTS API and the existing =E2=80=9CAPI=E2=80=9D methods available in the Tes=
tsuite class, remove the Testsuite class methods<br>=C2=A0 =C2=A0* Packet F=
orwarding Performance tests<br>=C2=A0 =C2=A0* Cryptodev support: Just addin=
g support for the dpdk-crypto-perf application, may require another DPDK Sh=
ell implementation<br>=C2=A0 =C2=A0* Cryptodev tests: Either as a func or p=
erf test (compare against a baseline), run some encrypt/decrypt workloads w=
ith the various supported algorithms on DPDK nics.<br>=C2=A0 =C2=A0* Testin=
g with single NIC with the 2 interfaces connected in a loopback<br>=C2=A0 =
=C2=A0 =C2=A0 * This appears to be working, but need to be documented<br>=
=C2=A0 =C2=A0* Additional functional ethdev testsuites:<br>=C2=A0 =C2=A0 =
=C2=A0 * Ethertype Testsuite<br>=C2=A0 =C2=A0 =C2=A0 * QinQ Testsuite<br>=
=C2=A0 =C2=A0 =C2=A0 * RSS Testsuite<br>=C2=A0 =C2=A0 =C2=A0 * Rx/Tx Offloa=
d<br>=C2=A0 =C2=A0* File manager:<br>=C2=A0 =C2=A0 =C2=A0 * Add a dedicated=
 file manager to handle passing files and artifacts<br>between the test eng=
ine and nodes in a path agnostic manner.<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any other business<br>* Patrick Robb subm=
it the website update with the latest recheck coverage.<br>* Next Meeting A=
ugust 7th at the same time<br></div>

--00000000000092f548063b2e7c9c--
