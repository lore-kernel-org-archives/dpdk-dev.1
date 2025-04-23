Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0F2C3ABB0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 12:55:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E0B410EE;
	Mon,  5 May 2025 14:51:46 +0200 (CEST)
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by mails.dpdk.org (Postfix) with ESMTP id 247E14029D
 for <dev@dpdk.org>; Wed, 23 Apr 2025 07:52:53 +0200 (CEST)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-af6a315b491so5276933a12.1
 for <dev@dpdk.org>; Tue, 22 Apr 2025 22:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745387571; x=1745992371; darn=dpdk.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=2EMMhzytbNCQTegxKrAHqkXUhwEwMEIP5s4QYgbpGms=;
 b=B+7G7zGF5E3GDE1bimVO8P4FoAfk4YLnsYJsckOiYxOh2LmqM3fheLHym0tIM0Gxk5
 HoEyYlU1GVQKYGOWEYBquj8whStFvJGM6q29F4YWBMZkY2z7Hk/Wrj7+pX7C/shxpy7p
 iIn6L0IMEjxHGswCRQFekEz6xatT52vtyiFA90Mxo6y/Slx97j6y7M+tEUxAZ/MYRs1+
 NzvjoA1qH2Ef0343jIbY3yfh056xxcbMOP7R/DCpY7Q2vgEI9UC4lOWsXagLSP8/oVd9
 Twypi1JG04VBvEbMBFH0Dm1Iv4QAJZfmW06NpNS+aQIGkTwou2mp9FzAMid6AXS5LxQz
 94DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745387571; x=1745992371;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2EMMhzytbNCQTegxKrAHqkXUhwEwMEIP5s4QYgbpGms=;
 b=LQf2zocCeyserxIk9kVxaIaoeqxstQntn2ymMM+xEPwP5wU6ThuUpiXNZ11H3ShdUq
 VL3UXaQFPlMwlL2EQO6SsxxqwstgH34cDnbwpFCSbhcPIOUM6HYPS6MMgIneH48T+1r4
 rYqfnFJEPa10EopbdWkCYMlIjZisVEfks1pjy1Z7NHDa2xeExPFNxXYj92UXtoHx25Lx
 QfhevT8hPk06nAyTg0q+B7phMBRsURuJMBvghbjfHpCD3sIUwjLWoKFByRj1RcIHYwU+
 uZLsrnwsNjK11yKntsrermO6dUS9w7v83yuUUhecsPn0n0vhof9qUxy7/zWFKGgd1cIt
 JGhA==
X-Gm-Message-State: AOJu0Yy05AtQyPJ5mzKH3TjUAORsnwmkoC6afDyUZiufKryOFMgyV+vU
 rm59EYZ7R8sxmZgcFTWIflnZ1dyzJ7PyXLEqVJodG6tZCNk47DytKhtMThgc+n8ObdRYWfJ5KWe
 bI/Xp1F53Z5eH3HA6QaUgq4z/fXNdzvDIBG8=
X-Gm-Gg: ASbGnctQiErmXE0prm2r2kPN0cb9W1M6hbtuN5LhNZPbEI3YcDahGnLnoKJb9P9iT+5
 3GEODLw5ot1cjAl5VBMzLrAKVw9uWjLavWfAs9qlUTXl40SLqYgrp9VVZTearhRwI9X0gnp9lV3
 anuCpsO9oTFV1aMzejl26yOg==
X-Google-Smtp-Source: AGHT+IHDYjmtLwRMZ0F6X83zW3Fa9vYy9GdAlEd/ETmD8nBPM6k/fBs5PxkRVtnf3LGkwyjZca1OCvVNByhz/bVwWzA=
X-Received: by 2002:a17:90b:5690:b0:306:b593:4557 with SMTP id
 98e67ed59e1d1-3087bb40083mr27661014a91.4.1745387570890; Tue, 22 Apr 2025
 22:52:50 -0700 (PDT)
MIME-Version: 1.0
From: nan he <nhe295771@gmail.com>
Date: Wed, 23 Apr 2025 13:52:39 +0800
X-Gm-Features: ATxdqUEzCyqStBwoeDPew8fKUJ3q7TLEQixdeX5TES24oTZsKU2jQmAVywXrtdM
Message-ID: <CAFohB5uoG8Sx5LXiX8F8QihT=ov2yR5rzgbaVNeodmYedy5S5g@mail.gmail.com>
Subject: [Bug Report] KNI Module Causes Loopback Interface to Have Incorrect
 ifindex in Linux 5.4.46
To: dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000288df706336bb611"
X-Mailman-Approved-At: Mon, 05 May 2025 14:51:06 +0200
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

--000000000000288df706336bb611
Content-Type: text/plain; charset="UTF-8"

Dear DPDK Developers,

I am reporting an issue encountered in an environment running Linux kernel
version 5.4.46 with DPDK 19.11. When attempting to run Docker containers in
bridge mode, the container creation fails consistently. The kmsg indicate a
crash during the initialization of the loopback device within a new
*net_namespace*, specifically due to the loopback interface not being
assigned the expected ifindex of 1.

*Issue Description:*

During the creation of a  net_namespace, the kernel initializes network
devices in a specific order. It is expected that the loopback interface is
the first to be initialized, thereby receiving an ifindex of 1. This
assumption is enforced in the kernel code, where a BUG_ON check ensures
that the loopback interface has *ifindex == 1.* However, with the DPDK KNI
module loaded, this assumption fails, resulting in a kernel panic during
container creation.

*Root Cause Analysis:*

Upon investigation, it appears that the KNI module registers its network
operations using the *register_pernet_subsys()* function. This registration
method places the KNI initialization function before the loopback device's
initialization in *pernet_list*. Consequently, when a new * net_namespace*
is created, the KNI interface is initialized before the loopback interface,
causing the KNI interface to receive ifindex 1 and the loopback interface
to receive ifindex 2. This order violates the kernel's expectation and
triggers the BUG_ON check.

*Environment Details:*

   -

   DPDK Version: 19.11
   -

   Kernel Version: 5.4.46
   -

   Operating System:  Linux
   - Architecture: x86_64

*Reproduction Steps:*

   1.

   Load the DPDK KNI module.
   2.

   Use Docker to create a new container in bridge mode.
   3.

   Observe the kernel panic due to the loopback interface not having ifindex
   1.

*Additional Information:*

We would appreciate it if the DPDK development team could review this issue
and consider incorporating the proposed change into future releases. Please
let us know if further information or testing is required from our side.

Best regards,

--000000000000288df706336bb611
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<p class=3D"gmail-">Dear DPDK Developers,</p>
<p class=3D"gmail-">I am reporting an issue encountered in an environment r=
unning Linux kernel version 5.4.46 with DPDK 19.11. When attempting to run =
Docker containers in bridge mode, the container creation fails consistently=
. The kmsg indicate a crash during the initialization of the loopback devic=
e within a new <b>net_namespace</b>, specifically due to the loopback inter=
face not being assigned the expected <code>ifindex</code> of 1.</p>
<p class=3D"gmail-"><strong>Issue Description:</strong></p>
<p class=3D"gmail-">During the creation of a=C2=A0
net_namespace, the kernel initializes network devices in a specific order. =
It is expected that the loopback interface is the first to be initialized, =
thereby receiving an <code>ifindex</code> of 1. This assumption is enforced=
 in the kernel code, where a <code>BUG_ON</code> check ensures that the loo=
pback interface has <b><code>ifindex =3D=3D 1</code>.</b> However, with the=
 DPDK KNI module loaded, this assumption fails, resulting in a kernel panic=
 during container creation.</p>
<p class=3D"gmail-"><strong>Root Cause Analysis:</strong></p>
<p class=3D"gmail-">Upon investigation, it appears that the KNI module regi=
sters its network operations using the <code><b>register_pernet_subsys()</b=
></code> function. This registration method places the KNI initialization f=
unction before the loopback device&#39;s initialization in=C2=A0<span style=
=3D"font-family:monospace"><b>pernet_list</b></span>. Consequently, when a =
new
<b>
net_namespace</b>

 is created, the KNI interface is initialized before the loopback interface=
, causing the KNI interface to receive <code>ifindex</code> 1 and the loopb=
ack interface to receive <code>ifindex</code> 2. This order violates the ke=
rnel&#39;s expectation and triggers the <code>BUG_ON</code> check.</p><p cl=
ass=3D"gmail-"><strong>Environment Details:</strong></p>
<ul><li class=3D"gmail-">
<p class=3D"gmail-">DPDK Version: 19.11</p>
</li><li class=3D"gmail-">
<p class=3D"gmail-">Kernel Version: 5.4.46</p></li><li class=3D"gmail-">
<p class=3D"gmail-">Operating System:=C2=A0
Linux</p></li><li class=3D"gmail-">Architecture: x86_64</li></ul>
<p class=3D"gmail-"><strong>Reproduction Steps:</strong></p>
<ol><li class=3D"gmail-">
<p class=3D"gmail-">Load the DPDK KNI module.</p>
</li><li class=3D"gmail-">
<p class=3D"gmail-">Use Docker to create a new container in bridge mode.</p=
>
</li><li class=3D"gmail-">
<p class=3D"gmail-">Observe the kernel panic due to the loopback interface =
not having <code>ifindex</code> 1.</p>
</li></ol>
<p class=3D"gmail-"><strong>Additional Information:</strong></p><p class=3D=
"gmail-">We would appreciate it if the DPDK development team could review t=
his issue and consider incorporating the proposed change into future releas=
es. Please let us know if further information or testing is required from o=
ur side.</p>
<p class=3D"gmail-">Best regards,</p>

<br></div>

--000000000000288df706336bb611--
