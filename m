Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CB9D6CFA2
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 21:51:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5076E40A6B;
	Thu, 22 Jan 2026 22:51:12 +0100 (CET)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 1B9CC40696
 for <dev@dpdk.org>; Thu, 22 Jan 2026 22:51:11 +0100 (CET)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-121a0bcd376so4514400c88.0
 for <dev@dpdk.org>; Thu, 22 Jan 2026 13:51:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769118670; cv=none;
 d=google.com; s=arc-20240605;
 b=Dnkj+ibffBNWh8LlEMhO14RqreTJLMPeSJz80vD9GFO63eRLaT4SlzhkWUUNGnYLqf
 rilMFUBqKeRS4+joCi2dzIDH6vTW7dNlJ1veNYQXB+wBhndZqFGWj54/GRb0mpYA9NcI
 MyquGjc9m5mNwvwuOGuNzmBK5ilQUXlw0/jC1iTEG+412cNqbfe8PDwYRib5xqszP5/l
 dYJoMZxXivl8gPkMr5Dzzz9fBiW+fGKoEnN84/r+5tb4VQ4wg9rVfjTcGw7KQ4nQ6WFk
 bBp9s9QoABithGOKd2YkyNJJnsdoiZLbHLATNKra9QeHNeQnG8en2Gn9WC1UrbJKg6De
 OKAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=h6Ce+2gljOWGAw5+P2aPRoO4OU1WcN0dHoD/pvekfcw=;
 fh=7euqDaxz1VpO925eSPrKCFERDHr1bk2F5AP7yBDwrPg=;
 b=iCJhbv7exinrCGxRsHvncghgcOPjOaspLtgE8uM8rMQ1Q0/hybIN47x3+axYKhp5ly
 Jx47nykrawwImHtA2VIYwd/ZZVr7UbPT/SyFEUOYvyBsZ7PZjJ1XwZ3Jm0hixlmlUk87
 5JRQdRdi8kOm3mWo+jS9lR8zi8yqdCX9y6TDYapcBuYl+ByR3V5qT5RqY4qCdAPnpdSe
 7fVJDotNNqEVDj9x9dNFPQqxYZH9DANpkPNmz0f3lQFAXriAr23Cw94TL/m65qJc4SiB
 IX9l3J6CeMJMwsC1EaFqrAiheelLPOTVBXLYWoYab7rq4Q+jZDKuX1J5nlYwU1GbTywz
 0oYw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1769118670; x=1769723470; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=h6Ce+2gljOWGAw5+P2aPRoO4OU1WcN0dHoD/pvekfcw=;
 b=IcLBL693uZ5bqvY0Vm8uH6PCepszzzo7hpunQg1qzWIOz1AU6GEewEEHOdIA2o3BvX
 qK0Ij/fdpdfcg5hm4azLHLZ8iZuGgd/NXswZ2A5pL2B6sCE6s3hwK5JVWYsqnf3Ijk4H
 KrvDjVfZZTC57Z2snoZfL09qNlzjmH/lv2Ay8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769118670; x=1769723470;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h6Ce+2gljOWGAw5+P2aPRoO4OU1WcN0dHoD/pvekfcw=;
 b=uB83k0/lz8mgIfzVxSMB7eNciwBNPoCEASnOU42kOz7qfyNt5Z6ne9Iyl4l8TUWAnI
 RGjCYjhLNEZ/D8inumLdNMu2DKM785x8+UXjSY6BZmZScPxDUETiEYQKKN6YJsSzJ1GM
 jrKEzcKh6O1czf2W52zEw3rSaZP4gN1JDpH7OLVlddmdJkhYixEZw5E1TuNrym3AV425
 3xJZCOR18RsZd704GxX45CR6bFKcW0yj6ifOwik7Eygy/1W46SwXrGrJhsAhaIOh8bcU
 t3ctuF0HnSIaakcNeKMTWoZmTXDx8YU1oMyMsGocmhG/n+zPXNchFCRjizvihC9CZvlE
 l/Pw==
X-Gm-Message-State: AOJu0YyxVqTApkEP9KclomfFjo+nhmH6kV5OVPQF0a2IQnkdFjzLF91t
 RL1duZuipS/xFodPovQgN4CS6VecOoQ3UU5vDcPNJ0Jvu1HMYCV8tS0q4ONyBRso3b6zQlWEfO5
 jMG1Fm+r3tnM6UZb9Bz4TeM9NA2zqXBXyhaVDCI3fuA==
X-Gm-Gg: AZuq6aI4FG77ebqlI/JQSu3NKbgIUGyxZUqGrVJu4cinfiRwRU8PiA0V8E8IZ/AVHZu
 sAGuyV7QsTslb9v4+80ociP2FWB75KO7vgstLXGEsKebVFTHV2h4Z0+nS6VXmaj8floV8mrWYmK
 4mST+7IrFDWL6adW436F7MBMVFTyIH4RjoVjfCpTgHqAyFTHvFEuLQGLecOCGTXQ8hU+XH9IZ4m
 parPCikCYhAcr7W8J6DlaMl6ZmIRdlMEdYBYE1TC4zNFgeoIWPYnSTh7R/vf9a+KInealtzb7BR
 RifNSFy15ILDMiN7CX4QiDFzgPkKTvd/x9A63kKXKA==
X-Received: by 2002:a05:7022:2397:b0:119:e56b:c75b with SMTP id
 a92af1059eb24-1247dbf84e3mr421835c88.32.1769118669933; Thu, 22 Jan 2026
 13:51:09 -0800 (PST)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 22 Jan 2026 16:48:50 -0500
X-Gm-Features: AZwV_QjeGoRq6FlUMPtw7CMK31nmqt7mv8KHrqrk820Vtw4IuwMecmwTHDMthrs
Message-ID: <CAJvnSUBQ7vsUf_vpq9BYAvhqDajRjMhaaUfGh0bVKP6L4DJFOQ@mail.gmail.com>
Subject: Community CI Meeting Minutes - January 22, 2026
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Aaron Conole <aconole@redhat.com>,
 Ali Alnubani <alialnu@nvidia.com>, 
 Dean Marx <dmarx@iol.unh.edu>, Andrew Bailey <abailey@iol.unh.edu>, 
 Luca Vizzarro <Luca.Vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000e321350649010979"
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

--000000000000e321350649010979
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

January 22, 2026

Attendees
1. Patrick Robb
2. Luca Vizzarro

Minutes

General Announcements
* Patchwork updates and CI Lab requirements:
   * Anubis traffic challenge on Patchwork now enforces https for external
URLs. Lab maintainers take note and ensure that your scripting is using
https urls:
https://inbox.dpdk.org/ci/20260114110814.54432-1-alialnu@nvidia.com/T/#t
   * Because there have been multiple updates to the patchwork server
recently, some of which caused temporary issues with lab requests to
patchwork, I would encourage all lab maintainers to review their test
reports for recent patches to ensure that none are missing or incorrect.
* AI Code review:
   * Budget approved by governing board
   * Aaron shared some of the scripting with UNH guys. Is a review needed?
* DPDK Stockholm:
   * Patrick wrote up a draft CFP titled =E2=80=9CDevelop with Confidence:
Integrate DTS into the DPDK development workflow=E2=80=9D which would be a =
demo
showing how a developer can add/fix/break a flow offload feature and then
validate that against the flow offload testsuite

CI Status

AWS Lab
* None

UNH-IOL Community Lab
* Single_core_forward tests:
   * Migrated the mellanox systems off of the legacy DTS testsuite - the
others are still in progress
* Testing queue is now low after there being a big queue the past couple
weeks because of retest requirements brought on by Patchwork issues and
other UNH infra problems
* Will need to schedule downtime soon to upgrade our lab LDAP, SSL CA, etc.
system

Intel Lab
* Did not get a response from them on email about disabling a problematic
checksum offload testcase from legacy DTS.

Github Actions Robot
* None

Loongson Lab
* Their patch recheck framework is updated to minimize requests to
Patchwork.

DTS Improvements & Test Development
* Cryptodev:
   * Akhil has answered some of our questions regarding cryptodev and is
looping in Kai Ji (Intel) on Andrew=E2=80=99s thread:
https://inbox.dpdk.org/dev/CAJvnSUAJB4vWcb-A3XYUb8T2fECsrc4UnBR73FnemjPX3=
=3Dx4EQ@mail.gmail.com/
      * It=E2=80=99s important for us to look through
https://doc.dpdk.org/guides/cryptodevs/overview.html to figure out the
combination of ciphers and devices which need to be tested. Some tests will
be written in a device agnostic manner, while others cannot be. For
instance, for openssl vdev tests we need to explicitly write an openssl
vdev test for each cipher algorithm, and some of those are missing from the
RFC currently.
* Doc builds now use werror:
https://inbox.dpdk.org/dev/CAJFAV8zMV-5kVAuCHwGu7JMONdewEERojpTyaWA8vv0asgG=
SVw@mail.gmail.com/
* Flow Offload:
   * Needs a review from Patrick and Luca
* Virtio:
   * Patrick to review
* DTS docstrings format script:
   * Dts-check-format is not actually calling the new script. Dean to
resolve and send a new version.
   * There is also a format issue with the docstring in dynamic_queue_conf,
which Dean will also resolve
* Luca has rebased the next-dts branch off of main now that the DTS docs
issue (double quotes within double quotes) has been fixed by Lucas Sismis.

Any other business
   * Next meeting is Feb 5, 2026

--000000000000e321350649010979
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">January 22, 2026<br><br>Attendees<br>1. Patrick Robb<br>2.=
 Luca Vizzarro<br><br>Minutes<br><br>General Announcements<br>* Patchwork u=
pdates and CI Lab requirements:<br>=C2=A0 =C2=A0* Anubis traffic challenge =
on Patchwork now enforces https for external URLs. Lab maintainers take not=
e and ensure that your scripting is using https urls: <a href=3D"https://in=
box.dpdk.org/ci/20260114110814.54432-1-alialnu@nvidia.com/T/#t">https://inb=
ox.dpdk.org/ci/20260114110814.54432-1-alialnu@nvidia.com/T/#t</a><br>=C2=A0=
 =C2=A0* Because there have been multiple updates to the patchwork server r=
ecently, some of which caused temporary issues with lab requests to patchwo=
rk, I would encourage all lab maintainers to review their test reports for =
recent patches to ensure that none are missing or incorrect.<br>* AI Code r=
eview:<br>=C2=A0 =C2=A0* Budget approved by governing board<br>=C2=A0 =C2=
=A0* Aaron shared some of the scripting with UNH guys. Is a review needed?<=
br>* DPDK Stockholm:<br>=C2=A0 =C2=A0* Patrick wrote up a draft CFP titled =
=E2=80=9CDevelop with Confidence: Integrate DTS into the DPDK development w=
orkflow=E2=80=9D which would be a demo showing how a developer can add/fix/=
break a flow offload feature and then validate that against the flow offloa=
d testsuite<br><br>CI Status<br><br>AWS Lab<br>* None<div><br>UNH-IOL Commu=
nity Lab<br>* Single_core_forward tests:<br>=C2=A0 =C2=A0* Migrated the mel=
lanox systems off of the legacy DTS testsuite - the others are still in pro=
gress<br>* Testing queue is now low after there being a big queue the past =
couple weeks because of retest requirements brought on by Patchwork issues =
and other UNH infra problems<br>* Will need to schedule downtime soon to up=
grade our lab LDAP, SSL CA, etc. system<br><br>Intel Lab<br>* Did not get a=
 response from them on email about disabling a problematic checksum offload=
 testcase from legacy DTS.<br><br>Github Actions Robot<br>* None<br><br>Loo=
ngson Lab<br>* Their patch recheck framework is updated to minimize request=
s to Patchwork.<br><br>DTS Improvements &amp; Test Development<br>* Cryptod=
ev:<br>=C2=A0 =C2=A0* Akhil has answered some of our questions regarding cr=
yptodev and is looping in Kai Ji (Intel) on Andrew=E2=80=99s thread: <a hre=
f=3D"https://inbox.dpdk.org/dev/CAJvnSUAJB4vWcb-A3XYUb8T2fECsrc4UnBR73Fnemj=
PX3=3Dx4EQ@mail.gmail.com/">https://inbox.dpdk.org/dev/CAJvnSUAJB4vWcb-A3XY=
Ub8T2fECsrc4UnBR73FnemjPX3=3Dx4EQ@mail.gmail.com/</a><br>=C2=A0 =C2=A0 =C2=
=A0 * It=E2=80=99s important for us to look through <a href=3D"https://doc.=
dpdk.org/guides/cryptodevs/overview.html">https://doc.dpdk.org/guides/crypt=
odevs/overview.html</a> to figure out the combination of ciphers and device=
s which need to be tested. Some tests will be written in a device agnostic =
manner, while others cannot be. For instance, for openssl vdev tests we nee=
d to explicitly write an openssl vdev test for each cipher algorithm, and s=
ome of those are missing from the RFC currently.<br>* Doc builds now use we=
rror: <a href=3D"https://inbox.dpdk.org/dev/CAJFAV8zMV-5kVAuCHwGu7JMONdewEE=
RojpTyaWA8vv0asgGSVw@mail.gmail.com/">https://inbox.dpdk.org/dev/CAJFAV8zMV=
-5kVAuCHwGu7JMONdewEERojpTyaWA8vv0asgGSVw@mail.gmail.com/</a><br>* Flow Off=
load:<br>=C2=A0 =C2=A0* Needs a review from Patrick and Luca<br>* Virtio:<b=
r>=C2=A0 =C2=A0* Patrick to review<br>* DTS docstrings format script:<br>=
=C2=A0 =C2=A0* Dts-check-format is not actually calling the new script. Dea=
n to resolve and send a new version.<br>=C2=A0 =C2=A0* There is also a form=
at issue with the docstring in dynamic_queue_conf, which Dean will also res=
olve<br>* Luca has rebased the next-dts branch off of main now that the DTS=
 docs issue (double quotes within double quotes) has been fixed by Lucas Si=
smis.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <br>Any ot=
her business<br>=C2=A0 =C2=A0* Next meeting is Feb 5, 2026<br></div></div>

--000000000000e321350649010979--
