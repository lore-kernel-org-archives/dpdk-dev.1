Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F154ED6CFA6
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 21:46:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 04AA440A6B;
	Thu, 22 Jan 2026 22:46:11 +0100 (CET)
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by mails.dpdk.org (Postfix) with ESMTP id F20A740696
 for <dev@dpdk.org>; Thu, 22 Jan 2026 22:46:09 +0100 (CET)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-121a0bcd376so4486491c88.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 13:46:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769118369; cv=none;
 d=google.com; s=arc-20240605;
 b=Sin8n+RIsA9uqAXAdlj7LJAI2btEZRoy7wwg1uNSStdzNQ0cXGuXsSKwhd6/2I+3Ry
 W4f2pgtxUQfXSpSkaMrZG7OR7CqHg+CqfnOEvIFjc/F0vtURx+W/uiP8zg8TNgF/Npxv
 9L5pY+oT+8dZa2A0o7Ff8D4i9aQYO+ZITkTY8cqgnqLvmxUVAZORqnk1QkXw6nXDnWXD
 OYujmiuUeNLQJp0sKk/OWbZEyos++4a+KidiwUahqOoMLK89LsrDk6JMfAcpPAbViLs5
 5XY8iYydLFTSQWv63cziBu7x6TG8iQa/fk+t1nvSt55oUPprON2jqnd1NJwn6LDv5AyC
 ndYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=Sa3Gjfn+flKsHYtdvUuzS72IQSBggYwoMaOZ9kpDv/Y=;
 fh=6iNmakO698nAyEze7EQZkGAKcKkZGLflACmRw2xLbpA=;
 b=gomHI5AvNthD8UlXvwJa/DjPYWmybIDUB3X26uWwPhSpA/CiLdimc0SfWEXFIaJHoH
 jagziaL+A2L0sW57t1LTtAR+66p22Q4cbmn7NPw3ldIeMSazT+maJ6mrPjuBmsphKRrP
 QyI8HzN8m/rTVf2kW2YPqKRa1K9cm4kQ3DH/wMeRj0j+ID60m4q06CTWjP6/zbbzISsI
 jr9MEkDiJUtqlTATi7kVFxwPluaKYNhpCIAKsZi8jPlnItmUQNOvoALgYBoFbb/YQEqJ
 PNq7/5eNg7Zt0MGSZoNNiVZOig8UHg9lq2Zc/qHiRLxE4fCWIXBLO/xvDNCMGFRaZt8l
 iRIQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769118369; x=1769723169; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Sa3Gjfn+flKsHYtdvUuzS72IQSBggYwoMaOZ9kpDv/Y=;
 b=bbTXuEel7ULSF5jrQkGwexHW1o8e+TW79kqKskyf8ixLDzEuwdrgbqZixp00l69NRN
 oBlKOfINsdKg8VEik1BnS6XloDy4Ai5bLm0isU6Dh+nNaZqZj+tNHN9KTjK1ouuvmRsN
 HDqzAjOe4byxaWpwMTF4FFvpkmCXJ+qxNoc0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769118369; x=1769723169;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sa3Gjfn+flKsHYtdvUuzS72IQSBggYwoMaOZ9kpDv/Y=;
 b=ri4szTdc9qejMarzhH9OUENI0r69tZUftGhZzRGmD+UcKxhPn9xWSCv5Ti5i8l3qks
 UcsXa5jzTWEL3/VPuvmZSsEBLLPlgcxPtCFrUTRqFDql5UFOEHIaFqVypPStdqAsPiFk
 9YWWIZYasU1GS7lTfQq0OOnQ7qNIP7jA/IcxHfp4WPVApm7we+VcJJByMrBJtZARt3SY
 dlG46/RWs9Kgfup1PigfgUj3qcPBuj0OCBw45s49Q/bfTVEBQ+SXSb5P0aHdhyXDhUXI
 Dmqgc7nB3LHKv5b81CsTHLH08xRwkypVR5RfviC3ilNfTma/nNQrL1pRy2VpgwWSccZS
 EZmA==
X-Gm-Message-State: AOJu0YwK3I7Zq2/I6C+1ZZQqSIRgD+uegWkDXOck+LPdEPhB6A2hIUfs
 SFiMK3exdBEGY4AZC4C7gpRmxRWrFLAnXPRerg9YNkPbkC0JS+68hGi5I2HlwD2cak1G54rZkVp
 ZwTmw9jXt2OSFIFR2W0ut8CnZ0VnBubYMnQ3EgkH6SWTW0xEUpiPeIMALJA==
X-Gm-Gg: AZuq6aKUFcZn8pP9SNMmPW9bu3G8mPvRmu0UN+bwIms58Au1JUMa/g8JVz3wP/8XRlB
 s0eziLyGGxojoJkVGKqwnUpE6mwJHZRS41kQMsl13qT0qNnpNqeROboL2ulL66INSkgFlAVR4nz
 F5VKi0G/+5uTn6TXEJZKmzoo6XKoTacHtM55nQutmqCb5QlQ5H4kOCypp4mPtzEZcB41N/0eWyG
 zVFPyhOSg2xK+II1J3sEidXZkk1aCnz3kDn5QH+OyltnhTQRzrkd1re4sYX2BSBhQS3ZNUpKel/
 UnMwE2RxZ8LA+OaOvamkplid+cl6rH6IFmVZa0LL/g==
X-Received: by 2002:a05:7022:fa8:b0:11b:9386:7ed0 with SMTP id
 a92af1059eb24-1247dc14c25mr456555c88.45.1769118368533; Thu, 22 Jan 2026
 13:46:08 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 22 Jan 2026 16:43:49 -0500
X-Gm-Features: AZwV_Qhq3zIjVQ3TSfwwyVOpVaAaPmaGVpNDps5KPr1pgkU8KFRFDqmfhziWL_o
Message-ID: <CAJvnSUDsaWPXmtY_f8kL7aDb1CQdcm2o6Bg9DCouE2B4d1Rc8g@mail.gmail.com>
Subject: DTS WG Meeting Minutes - January 15, 2026
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000ec1cde064900f75e"
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

--000000000000ec1cde064900f75e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

January 15, 2026

Attendees
* Patrick Robb
* Andrew Bailey
* Luca Vizzarro
* Matthew Labrecque

Minutes

General Discussion
* Next-dts is rebased on DPDK main as of yesterday
* The release candidate 1 (RC1) date is 9 February 2026
* There was a mention on Slack of a legacy DTS testsuite needing to be
disabled in the Intel CI Lab. Patrick reached out to them to request that
they disable this, and mentioned the long term solution to these issues is
for them to switch from legacy DTS to the current DTS. Patrick to continue
this conversation with them.

Patch discussions
* Cryptodev:
   * Andrew to overview the config files changes:
      * Updating test_run.yaml to add a =E2=80=9Cuse_crypto_virtual_functio=
ns=E2=80=9D
value,
      * Nodes.yaml: Added a new =E2=80=9Ccrypto_interfaces=E2=80=9D list ju=
st like the
ports list
         * Ports list and crypto interfaces list are not mutually exclusive=
.
   * VF creation:
      * Echo the contents of sriov_max_vfs to sriov_numvfs.
         * E.g. For our QAT card, create 16 VFs per physical function.
      * Echo 1 > sys/bus/pci/device/driver/remove
      * Echo 1 > sys/bus/{something}/rescan
         * After this, the device can be bound again
   * What to do with testcase decorators for crypto tests? We don=E2=80=99t=
 need
TGs (which are provided by the func_test and perf_test decorators). It may
make sense to define a new crypto_test decorator.
* Virtio pvvp test suite:
   * RFC:
https://patcnasdaqhwork.dpdk.org/project/dpdk/patch/20251217195155.32350-1-=
dmarx@iol.unh.edu/
   * Patrick to review
* Flow offload:
   * Patrick to review
* add test case docstring checks to format script
   * Patrick can merge
* Automate loading vfio-pci module:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20251126141650.367633-1-abail=
ey@iol.unh.edu/
   * Patrick to review
      * Cryptodev: there is a need to load vfio-pci with special arguments
for some QAT devices
* Change default topology to one link:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20251121195511.322005-2-abail=
ey@iol.unh.edu/
   * Andrew has resolved the build error by updating a type hint
   * Patrick to do a review
   * Luca to review as well, and check the function decorator signature
* Adding the missing RSS rst file:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20251217184637.719487-1-abail=
ey@iol.unh.edu/
* Update testsuite names:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20251217184637.719487-1-abail=
ey@iol.unh.edu/
   * Patrick to merge

Bugzilla discussions
* N/A

Any other business
* Next meeting is Jan 29, 2026

--000000000000ec1cde064900f75e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">January 15, 2026<br><br>Attendees<br>* Patrick Robb<br>* A=
ndrew Bailey<br>* Luca Vizzarro<br>* Matthew Labrecque<br><br>Minutes<br><b=
r>General Discussion<br>* Next-dts is rebased on DPDK main as of yesterday<=
br>* The release candidate 1 (RC1) date is 9 February 2026<br>* There was a=
 mention on Slack of a legacy DTS testsuite needing to be disabled in the I=
ntel CI Lab. Patrick reached out to them to request that they disable this,=
 and mentioned the long term solution to these issues is for them to switch=
 from legacy DTS to the current DTS. Patrick to continue this conversation =
with them.<br><br>Patch discussions<br>* Cryptodev:<br>=C2=A0 =C2=A0* Andre=
w to overview the config files changes:<br>=C2=A0 =C2=A0 =C2=A0 * Updating =
test_run.yaml to add a =E2=80=9Cuse_crypto_virtual_functions=E2=80=9D value=
, <br>=C2=A0 =C2=A0 =C2=A0 * Nodes.yaml: Added a new =E2=80=9Ccrypto_interf=
aces=E2=80=9D list just like the ports list<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0* Ports list and crypto interfaces list are not mutually exclusive.<b=
r>=C2=A0 =C2=A0* VF creation:<br>=C2=A0 =C2=A0 =C2=A0 * Echo the contents o=
f sriov_max_vfs to sriov_numvfs. <br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* E.=
g. For our QAT card, create 16 VFs per physical function.<br>=C2=A0 =C2=A0 =
=C2=A0 * Echo 1 &gt; sys/bus/pci/device/driver/remove<br>=C2=A0 =C2=A0 =C2=
=A0 * Echo 1 &gt; sys/bus/{something}/rescan<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0* After this, the device can be bound again<br>=C2=A0 =C2=A0* What t=
o do with testcase decorators for crypto tests? We don=E2=80=99t need TGs (=
which are provided by the func_test and perf_test decorators). It may make =
sense to define a new crypto_test decorator.<br>* Virtio pvvp test suite:<b=
r>=C2=A0 =C2=A0* RFC: <a href=3D"https://patcnasdaqhwork.dpdk.org/project/d=
pdk/patch/20251217195155.32350-1-dmarx@iol.unh.edu/">https://patcnasdaqhwor=
k.dpdk.org/project/dpdk/patch/20251217195155.32350-1-dmarx@iol.unh.edu/</a>=
<br>=C2=A0 =C2=A0* Patrick to review<br>* Flow offload:<br>=C2=A0 =C2=A0* P=
atrick to review<br>* add test case docstring checks to format script<br>=
=C2=A0 =C2=A0* Patrick can merge<br>* Automate loading vfio-pci module:<br>=
=C2=A0 =C2=A0* <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/202=
51126141650.367633-1-abailey@iol.unh.edu/">https://patchwork.dpdk.org/proje=
ct/dpdk/patch/20251126141650.367633-1-abailey@iol.unh.edu/</a><br>=C2=A0 =
=C2=A0* Patrick to review<br>=C2=A0 =C2=A0 =C2=A0 * Cryptodev: there is a n=
eed to load vfio-pci with special arguments for some QAT devices<br>* Chang=
e default topology to one link:<br>=C2=A0 =C2=A0* <a href=3D"https://patchw=
ork.dpdk.org/project/dpdk/patch/20251121195511.322005-2-abailey@iol.unh.edu=
/">https://patchwork.dpdk.org/project/dpdk/patch/20251121195511.322005-2-ab=
ailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0* Andrew has resolved the build erro=
r by updating a type hint<br>=C2=A0 =C2=A0* Patrick to do a review<br>=C2=
=A0 =C2=A0* Luca to review as well, and check the function decorator signat=
ure<br>* Adding the missing RSS rst file:<br>=C2=A0 =C2=A0* <a href=3D"http=
s://patchwork.dpdk.org/project/dpdk/patch/20251217184637.719487-1-abailey@i=
ol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch/20251217184637.7=
19487-1-abailey@iol.unh.edu/</a><br>* Update testsuite names:<br>=C2=A0 =C2=
=A0* <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/2025121718463=
7.719487-1-abailey@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/pa=
tch/20251217184637.719487-1-abailey@iol.unh.edu/</a><br>=C2=A0 =C2=A0* Patr=
ick to merge<br><br>Bugzilla discussions<br>* N/A<br><br>Any other business=
<br>* Next meeting is Jan 29, 2026</div>

--000000000000ec1cde064900f75e--
