Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBD8C35FF1
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Mar 2025 23:19:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A67B402D9;
	Fri, 14 Mar 2025 00:19:05 +0100 (CET)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 4A02840269
 for <dev@dpdk.org>; Fri, 14 Mar 2025 00:19:03 +0100 (CET)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-3014cb646ecso783278a91.1
 for <dev@dpdk.org>; Thu, 13 Mar 2025 16:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1741907942; x=1742512742; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ygZcYPTEhY0dMIJyifcFE3HPZ10BwntWCdnO0MS8LHo=;
 b=YwAhT4Uebe9ARfX6Xel0O0n2sT/DVztx7aVHnGJ8BRWruJx60bgTh39I67aHeXfTCd
 MFOk04dSo0H5zg5DjFbqmxEmDNzVG7GAs0nXQWAOxy8JtFHXlnVIEarG/qNuyw2TTRg6
 xItYoLH5JMQggI8FOWXBWa2SqMp2n/pbBFhy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741907942; x=1742512742;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ygZcYPTEhY0dMIJyifcFE3HPZ10BwntWCdnO0MS8LHo=;
 b=fe7vH8HX/slz9l3RiIXFxuMX8HgKXGNjndmaznGr3xUTL4bvRW3S2OfRS4sQ/Mph5Z
 qp9szf62BgN43k0PL4SnOyNHxqFcpm7STT/FbZ7zvIO9euWzR3Wirwn+5kJpc9d/rZ1w
 WNRNeym3leSPlJKl/WsoUjo77fU4a5Vty6e4lAdQwDTocqtM/xkmFOqmHPT7DivQFzro
 A7ey9ihGMZhkyrFcm3hB9//ck3n7XpHcrKddhZ9Ug+aAqRaNPHvr/p27lvyRh6d7OTUc
 YQIZ0taQIw1J3NJ7G9QqJVw8BXU7M3qDWbzYnr030DGjN1gKv3L956xT3umFctIxGwIr
 iZ5g==
X-Gm-Message-State: AOJu0Yw+Ww3erX4/fKeGrIo87YYHwQQKAfLEozeEExeXL/r7OvMuu9EQ
 70kknmvb36s575K/bFBXj/roMfVZHNvmGBiogvxWzYxBnM8sVpL9wUacvmUpkbQW4GsKKGcQ5IS
 +0M2m5kb06/d5GfN4DthR+BdVf3PuIiNX+tVPBC1aFj7tYpuyVGeS6w==
X-Gm-Gg: ASbGncsAvioukNkQOwu7pBirlM3LSDJxJuGbF/x9x3r1EOgT8jH5rwPpINMBexf7zL8
 4EdiQhOKA/MJSbU57Kr4SXzNIt/2eadA3pc3y4hH/gnHxSkSEB4lhwyDIev5gFB78R8cYZoIeW7
 77iHbxRK+jAauMjeAjUibkAqTQ+aBhiVatqJKtgrHg0PEagSrZHvXFBbaXyRL/Iqr2DZu/xg==
X-Google-Smtp-Source: AGHT+IEWjXQd1Som4Hg4X7yDH95wMXw3KiVaVcxVwS+0hGQ4SSM3WJVmpxGNpf1hJvvr4Msdr75NpqeVMhlFZWy25zE=
X-Received: by 2002:a17:90b:3d8e:b0:2fa:1f1b:3db2 with SMTP id
 98e67ed59e1d1-30151daa46bmr390739a91.25.1741907941959; Thu, 13 Mar 2025
 16:19:01 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 13 Mar 2025 19:15:19 -0400
X-Gm-Features: AQ5f1Jpk3E-aDH1xvthAD7H1Na7qgcKMJHlRoMqbmccvvJJbVZ83lrbIIEis0_c
Message-ID: <CAJvnSUBXO+451xeLg8qDVj6D1r9kwhFvhh5enMVwtZHNdOMgjQ@mail.gmail.com>
Subject: Community CI Meeting Minutes - February 6, 2025
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000001cc4700630418c2a"
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

--0000000000001cc4700630418c2a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#####################################################################
February 6, 2025
Attendees
. Patrick Robb
. Aaron Conole
. Luca Vizzarro
. Paul Szczepanek
. Ali Alnubani
. Andre Muezerie
. Nicholas Pratte

#####################################################################
Minutes

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
General Announcements
* The discussion regarding patch submission policy for CI was discussed
yesterday. Tech board will write up a new policy which discourages sending
an excessive number of patch submissions within a single day. This is with
the goal of both helping the CI testing queue, and also encouraging reviews
by slowing down the mailing list activity.
   * Aaron is working on drafting the new policy
* We met with Shai from AWS last Thursday. They have setup the
infrastructure for an AWS ci =E2=80=9Clab=E2=80=9D with public reporting to=
 Patchwork. I am
adding and AWS section to the =E2=80=9CCI status=E2=80=9D section below.
* RC1 is this Friday

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
CI Status

---------------------------------------------------------------------
UNH-IOL Community Lab
* The Grace server setup is going well. The first two devices installed are
the Intel E810 and Broadcom p2100G, and the single core performance testing
will be online this week.
* OvS testing:
   * Discussed with tech board, and UNH will decrease distros tested to
latest Ubuntu and latest Fedora
* Windows:
   * UNH team shared out the windows compile toolchains in use in UNH CI on
the CI mailing list and to Andre. We also renamed the Clang unit test based
on discussion at the previous meeting, and in the process caused some
builds to fail to trigger in the ensuing days. This was caught early this
week and test reruns for this windows build put in.
* New DTS in CI testing:
   * Patrick is still working on this but it=E2=80=99s a top priority
* Check Meson:
   * UNH caught a check meson failure this week, but did not indicate the
specific failure clearly enough (just reported build failure) and sent the
report to the first patch in the patchseries instead of the last. UNH team
will fix this.
* Depends on:
   * Adam discussed the requirement to have an opt out with the PW
maintainer, and what they are doing is adding a boolean field to the
project model for depends-on support. He has submitted his new version.
* Intel E810 failures:
   * There were 2 failures for this yesterday, on patches which should not
have caused it. Patrick will take a look today.

---------------------------------------------------------------------
Intel Lab
* None

---------------------------------------------------------------------
Github Actions
* Cirrus CI:
   * Aaron submitted an RFC which includes FreeBSD testing
   * Dpdk-test fast tests do not pass on FreeBSD for the most recent
FreeBSD versions.
   * Part of the failure is because the contigmem module is not loaded.

---------------------------------------------------------------------
AWS
* Ali has whitelisted their email which they will use to send test results
to the test-report mailing list.
* They currently have pipelines setup for build and meson fast tests.
* They have set aside x64 and ARM Graviton resources

---------------------------------------------------------------------
Loongarch Lab
* None

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
DTS Improvements & Test Development
* Can we mark Nick=E2=80=99s old topology series superseded, based on Luca=
=E2=80=99s
=E2=80=9Crevamp framework=E2=80=9D patchseries?
https://patchwork.dpdk.org/project/dpdk/list/?series=3D32804
* Luca=E2=80=99s docs generation fix for python 3.13+ was merged
* Nick=E2=80=99s patch adding the forward restart decorator (to be used on =
set mtu)
was removed.
   * New rule: start and stop forwarding should be written explicitly into
testsuites.
* Dpdk build delete: Reviewed by Patrick and Dean submitted a v2 responding
to comments. Patrick will merge today after the meeting unless there are
any concerns.
* Luca=E2=80=99s revamp framework series:
   * Change runner.py to a state machine.
   * Exposes a new topology class to testsuites
   * Nick and Dean are providing reviews
* Tg driver binding:
   * It may make sense to use dpdk_setup_ports.py script from trex instead
of copying dpdk/usrtools/dpdk-devbind.py to the TG and running it
* Please go over patches and provide reviews, maintainers please merge
patches or mark as superseded.
* Async sniffer instability:
   * Have not seen an issues with this in the past week. It may have been
resolved by the link up bugfix but we need to keep an eye on this.
* Ethertype testsuite:
   * Nick needs to add a capability check for the ethertype testsuite
   * Just checks the capability by setting to x9100

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Any other business
* Next Meeting Feb 20, 2025

--0000000000001cc4700630418c2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">##########################################################=
###########<br>February 6, 2025<br>Attendees<br>. Patrick Robb<br>. Aaron C=
onole<br>. Luca Vizzarro<br>. Paul Szczepanek<br>. Ali Alnubani<br>. Andre =
Muezerie<br>. Nicholas Pratte<br><br>######################################=
###############################<br>Minutes<br><br>=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>General Announcements<br>* The discuss=
ion regarding patch submission policy for CI was discussed yesterday. Tech =
board will write up a new policy which discourages sending an excessive num=
ber of patch submissions within a single day. This is with the goal of both=
 helping the CI testing queue, and also encouraging reviews by slowing down=
 the mailing list activity.<br>=C2=A0 =C2=A0* Aaron is working on drafting =
the new policy<br>* We met with Shai from AWS last Thursday. They have setu=
p the infrastructure for an AWS ci =E2=80=9Clab=E2=80=9D with public report=
ing to Patchwork. I am adding and AWS section to the =E2=80=9CCI status=E2=
=80=9D section below. <br>* RC1 is this Friday<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>CI Status<br><br>------------------=
---------------------------------------------------<br>UNH-IOL Community La=
b<br>* The Grace server setup is going well. The first two devices installe=
d are the Intel E810 and Broadcom p2100G, and the single core performance t=
esting will be online this week.<br>* OvS testing:<br>=C2=A0 =C2=A0* Discus=
sed with tech board, and UNH will decrease distros tested to latest Ubuntu =
and latest Fedora<br>* Windows:<br>=C2=A0 =C2=A0* UNH team shared out the w=
indows compile toolchains in use in UNH CI on the CI mailing list and to An=
dre. We also renamed the Clang unit test based on discussion at the previou=
s meeting, and in the process caused some builds to fail to trigger in the =
ensuing days. This was caught early this week and test reruns for this wind=
ows build put in.<br>* New DTS in CI testing:<br>=C2=A0 =C2=A0* Patrick is =
still working on this but it=E2=80=99s a top priority<br>* Check Meson:<br>=
=C2=A0 =C2=A0* UNH caught a check meson failure this week, but did not indi=
cate the specific failure clearly enough (just reported build failure) and =
sent the report to the first patch in the patchseries instead of the last. =
UNH team will fix this.<br>* Depends on:<br>=C2=A0 =C2=A0* Adam discussed t=
he requirement to have an opt out with the PW maintainer, and what they are=
 doing is adding a boolean field to the project model for depends-on suppor=
t. He has submitted his new version.<br>* Intel E810 failures:<br>=C2=A0 =
=C2=A0* There were 2 failures for this yesterday, on patches which should n=
ot have caused it. Patrick will take a look today.<br><br>-----------------=
----------------------------------------------------<br>Intel Lab<br>* None=
<br><br>-------------------------------------------------------------------=
--<br>Github Actions<br>* Cirrus CI:<br>=C2=A0 =C2=A0* Aaron submitted an R=
FC which includes FreeBSD testing<br>=C2=A0 =C2=A0* Dpdk-test fast tests do=
 not pass on FreeBSD for the most recent FreeBSD versions.<br>=C2=A0 =C2=A0=
* Part of the failure is because the contigmem module is not loaded.<br><br=
>---------------------------------------------------------------------<br>A=
WS<br>* Ali has whitelisted their email which they will use to send test re=
sults to the test-report mailing list.<br>* They currently have pipelines s=
etup for build and meson fast tests.<br>* They have set aside x64 and ARM G=
raviton resources<br><br>--------------------------------------------------=
-------------------<br>Loongarch Lab<br>* None<br><br>=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>DTS Improvements &amp; Test Develop=
ment<br>* Can we mark Nick=E2=80=99s old topology series superseded, based =
on Luca=E2=80=99s =E2=80=9Crevamp framework=E2=80=9D patchseries? <a href=
=3D"https://patchwork.dpdk.org/project/dpdk/list/?series=3D32804">https://p=
atchwork.dpdk.org/project/dpdk/list/?series=3D32804</a><br>* Luca=E2=80=99s=
 docs generation fix for python 3.13+ was merged<br>* Nick=E2=80=99s patch =
adding the forward restart decorator (to be used on set mtu) was removed. <=
br>=C2=A0 =C2=A0* New rule: start and stop forwarding should be written exp=
licitly into testsuites.<br>* Dpdk build delete: Reviewed by Patrick and De=
an submitted a v2 responding to comments. Patrick will merge today after th=
e meeting unless there are any concerns.<br>* Luca=E2=80=99s revamp framewo=
rk series:<br>=C2=A0 =C2=A0* Change runner.py to a state machine.<br>=C2=A0=
 =C2=A0* Exposes a new topology class to testsuites<br>=C2=A0 =C2=A0* Nick =
and Dean are providing reviews<br>* Tg driver binding:<br>=C2=A0 =C2=A0* It=
 may make sense to use dpdk_setup_ports.py script from trex instead of copy=
ing dpdk/usrtools/dpdk-devbind.py to the TG and running it<br>* Please go o=
ver patches and provide reviews, maintainers please merge patches or mark a=
s superseded.<br>* Async sniffer instability:<br>=C2=A0 =C2=A0* Have not se=
en an issues with this in the past week. It may have been resolved by the l=
ink up bugfix but we need to keep an eye on this.<br>* Ethertype testsuite:=
<br>=C2=A0 =C2=A0* Nick needs to add a capability check for the ethertype t=
estsuite<br>=C2=A0 =C2=A0* Just checks the capability by setting to x9100<b=
r><br>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D<br>Any othe=
r business<br>* Next Meeting Feb 20, 2025</div>

--0000000000001cc4700630418c2a--
