Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23F9CD6AAFD
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 19:14:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 39F8840E1F;
	Thu,  2 Apr 2026 21:14:02 +0200 (CEST)
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by mails.dpdk.org (Postfix) with ESMTP id EB4B04028E
 for <dev@dpdk.org>; Thu,  2 Apr 2026 21:14:00 +0200 (CEST)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-12a80c36350so1531072c88.1
 for <dev@dpdk.org>; Thu, 02 Apr 2026 12:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775157240; cv=none;
 d=google.com; s=arc-20240605;
 b=JM5DFE9cGQX0nVbGCorv8qbZpxtbJ5K6ifteYeIVZ2NReT9m7ZoGujHB1BsK/LFvL+
 Zzd6Y7moM0ROoZQLRVZMysSjufX6bEFgaZt7MQxTJf58w7QSuTa+04fXu+JDBRQH+hXd
 XxtkYomhptzNKVN6MazL8+JgsL1KUKb24+V5lZbe5ktuPbQo9CEUVxs9A7b6wemdpQKq
 Kzmgggg/AXYfZTvfkXANLzdW+B5NFF1voE/fNpLGAEnz61pqD1bXdxnxq6Gpe3q7gEkS
 u5+wT0dqo6brH6BC3oU3v+8G5lKILiq4Ro8r8v0Kdm3sWuKNEWrEgENM9BcaRiXbL3GH
 D+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=5ypPpKuXgTkWVXmYdqJKKq4/wpTpjArpiLWP+g78LzA=;
 fh=g5xW9wmna6DWVxXKl7LVYoNSiO3A0ENDUlE2PsQPJdc=;
 b=frVyBbqj2/V54VoHmrrlDsOyKwppkulXWLCphsfNMcGUrrT1Pd740mFiH7llbri1tt
 VR2lLto/d54tKo47fq/LeqFnQPXhgyt76uiidZzKUUjO3CjgixiumxqQp3bX6cjdZau3
 7m+pugQcxBbEYFLdYhofctI95BrpSAuc4HNbegw1eWmc0fm4vQC6i9juq7+atKGT32t/
 lXEBnDn8hUEgKw+z2LBW18Fv6pjuyrDMouKWemkxl1I+gScBaJM5hGnQQrsitBhIxYfu
 n+vhyKZo76hT+zuKplOcgES70LGhQ7H/NJsXthj8A1yEvRQ3ksAiTZT2Yl6JzXEnI8px
 F7Gw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775157240; x=1775762040; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=5ypPpKuXgTkWVXmYdqJKKq4/wpTpjArpiLWP+g78LzA=;
 b=NaGth5y/y8B9Al425pvk3ZgUezuMPLqhheEaUnIarG1neU3OKY8P3K332Yjo63I+yH
 btIBfDqUpaGadsODJfnuD/AtjFWbPs3Gc4ClPOWPPnwujtkSN3xNQQ0vxnQz+kAW4BBd
 1SbjxAnnrr+64IoimPRywojqIcr1pGktsm76w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775157240; x=1775762040;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ypPpKuXgTkWVXmYdqJKKq4/wpTpjArpiLWP+g78LzA=;
 b=Dit3m+dpaBu/0/4ygx5GDw3DT1xJNdb3Wk0MXhLVwmlCl1Etl3ghx92Qg+pn00Fs2V
 yGUrE/fNFMpulWwCMdatlJAdHg5UwyMmzxyORa908jAdtq4gaCKDAiQzOO5/jhII0Y+C
 xpmUh3htkcVUoBCg4OkY4nrdbF2Iy5JDh35mQ7OjDwfKQ8Fer1Cz1LfuaivH5dqYVomd
 sIZTTUW+0YDXbXqzyi7koY80/dReJ3eaSz00b1F3wkxbiR0mADDK2UWTwznktN/h4Lm4
 abtlT+n3grprxXYIBH+ZNtF8RXthbGaZRHStZvkHlNytoU/jZwv+a3fBzWSJSlkyWPCl
 dQPQ==
X-Gm-Message-State: AOJu0YwbdCFQMIA7vAslvlK9MQMLmwHydf0MI9/PoPmpCrXfa4EeZlrK
 +222/FOSRcWWwLmoCkYoL6ValsMTSPsm38v/BTIwQAIZHZp18U3CIFzSeBAfeW6aShWAY3lOm0d
 0Tf1ORMqX0Uah8EqZg+zp1nyUj8xV7zrZAqFSlA2lxjeBp6QoY64WV4rVKA==
X-Gm-Gg: ATEYQzydEOQOoU7e8ziroZGiJoFWlsR+kqwEVDDUOP1EgY+EN7XdknerPmvxHqt5j+5
 eaQUVQwMSW4dMOhlxTGd35iL04eRn4GZvMJP1nPRql1fdPDokjnACUUl0nIMY8pMgUDJprfa+4D
 HPcHp3N8iIOBTaR3jciotywHD/un98k9HLClNPX6614My6GFvZ6MmLhSYZ7AKV8jsrPG36vtEAb
 CcOx6oPNa1G0h+pwDZfHakDNsRv4rkQYYmKg2QwRYjs1u3KA7krhxNTOM2aVIw6wkdC326JhE1B
 pQSR1y9rB256k9o4b0d6sCMYS4qkB5pOxTrzJJIWSxPmFBJqm0K+Ig==
X-Received: by 2002:a05:7022:41a3:b0:12a:6ab7:3f71 with SMTP id
 a92af1059eb24-12bfb6ed48emr113294c88.7.1775157239569; Thu, 02 Apr 2026
 12:13:59 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 2 Apr 2026 15:10:34 -0400
X-Gm-Features: AQROBzBwBQLyFMKUwDFuVypQszYrM6ubpO5JMsWdMJB-saQ4AjVFjuJsLqOkiUY
Message-ID: <CAJvnSUDuaUb4vm4pcjVApOHkxyYwPYuaQAPWjo29Tk4uRmDYPQ@mail.gmail.com>
Subject: DTS WG Meeting Minutes - March 12, 2026
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org, Luca Vizzarro <Luca.Vizzarro@arm.com>,
 Adam Hassick <ahassick@iol.unh.edu>, Lincoln Lavoie <lylavoie@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000af70d9064e7f00f5"
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

--000000000000af70d9064e7f00f5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

March 12, 2026
Attendees
* Patrick Robb
* Luca Vizzarro
* Minutes
General Discussion
* Thomas is currently pulling from next branches for RC2
   * Luca/Patrick let him know next-dts will not have any more patches
pushed for RC2
   * We have run the standard checks on tip of for-main
* DPDK Stockholm
* UNH to run testbeds of at least 1 of each =E2=80=9Ctopology=E2=80=9D type
Patch discussions
* Merged Patches:
   * V5 of flow_offload testsuite
      * We merged the v5 of the flow offload testsuite.
      * The v6 includes VXLAN rules, will merge this in the future
   * Cryptodev testsuite
      * Merged
   * Packet Sniffing
      * Merged a patch that forces the sniffer to only sniff incoming
packets
      * We used to have this but lost it in the most recent DTS sniffer
rework. This was noticed when we were further testing the single link
   * One link default topology:
      * Merged
* Port speed capabilities:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20260309202928.200755-1-abail=
ey@iol.unh.edu/
* Support for no link:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20260224163200.39360-1-abaile=
y@iol.unh.edu/
* Re-naming testsuites:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20260202170924.398261-1-abail=
ey@iol.unh.edu/
* PVVP Virtio testsuite:
   *
https://patchwork.dpdk.org/project/dpdk/patch/20251217195155.32350-1-dmarx@=
iol.unh.edu/
Bugzilla discussions
* Andrew is doing a great job keeping these up to date
Any other business
* Next meeting is Mar 26, 2026

--000000000000af70d9064e7f00f5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>March 12, 2026<br>Attendees<br>* Patrick Robb<br>* Luc=
a Vizzarro<br>* Minutes<br>General Discussion<br>* Thomas is currently pull=
ing from next branches for RC2<br>=C2=A0 =C2=A0* Luca/Patrick let him know =
next-dts will not have any more patches pushed for RC2<br>=C2=A0 =C2=A0* We=
 have run the standard checks on tip of for-main<br>* DPDK Stockholm<br>* U=
NH to run testbeds of at least 1 of each =E2=80=9Ctopology=E2=80=9D type<br=
>Patch discussions<br>* Merged Patches:<br>=C2=A0 =C2=A0* V5 of flow_offloa=
d testsuite<br>=C2=A0 =C2=A0 =C2=A0 * We merged the v5 of the flow offload =
testsuite. <br>=C2=A0 =C2=A0 =C2=A0 * The v6 includes VXLAN rules, will mer=
ge this in the future<br>=C2=A0 =C2=A0* Cryptodev testsuite<br>=C2=A0 =C2=
=A0 =C2=A0 * Merged<br>=C2=A0 =C2=A0* Packet Sniffing<br>=C2=A0 =C2=A0 =C2=
=A0 * Merged a patch that forces the sniffer to only sniff incoming packets=
<br>=C2=A0 =C2=A0 =C2=A0 * We used to have this but lost it in the most rec=
ent DTS sniffer rework. This was noticed when we were further testing the s=
ingle link<br>=C2=A0 =C2=A0* One link default topology:<br>=C2=A0 =C2=A0 =
=C2=A0 * Merged<br>* Port speed capabilities:<br>=C2=A0 =C2=A0* <a href=3D"=
https://patchwork.dpdk.org/project/dpdk/patch/20260309202928.200755-1-abail=
ey@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/patch/202603092029=
28.200755-1-abailey@iol.unh.edu/</a><br>* Support for no link:<br>=C2=A0 =
=C2=A0* <a href=3D"https://patchwork.dpdk.org/project/dpdk/patch/2026022416=
3200.39360-1-abailey@iol.unh.edu/">https://patchwork.dpdk.org/project/dpdk/=
patch/20260224163200.39360-1-abailey@iol.unh.edu/</a><br>* Re-naming testsu=
ites:<br>=C2=A0 =C2=A0* <a href=3D"https://patchwork.dpdk.org/project/dpdk/=
patch/20260202170924.398261-1-abailey@iol.unh.edu/">https://patchwork.dpdk.=
org/project/dpdk/patch/20260202170924.398261-1-abailey@iol.unh.edu/</a><br>=
* PVVP Virtio testsuite:<br>=C2=A0 =C2=A0* <a href=3D"https://patchwork.dpd=
k.org/project/dpdk/patch/20251217195155.32350-1-dmarx@iol.unh.edu/">https:/=
/patchwork.dpdk.org/project/dpdk/patch/20251217195155.32350-1-dmarx@iol.unh=
.edu/</a><br>Bugzilla discussions<br>* Andrew is doing a great job keeping =
these up to date<br>Any other business<br>* Next meeting is Mar 26, 2026<br=
></div>

--000000000000af70d9064e7f00f5--
