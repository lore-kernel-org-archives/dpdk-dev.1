Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB76C369D5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Apr 2025 02:47:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 735FE40695;
	Tue, 29 Apr 2025 04:47:55 +0200 (CEST)
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49]) by mails.dpdk.org (Postfix) with ESMTP id 4425A40263
 for <dev@dpdk.org>; Tue, 29 Apr 2025 04:47:53 +0200 (CEST)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-306bf444ba2so5263650a91.1
 for <dev@dpdk.org>; Mon, 28 Apr 2025 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1745894872; x=1746499672; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Uu363Vsz6mEGABsQNmrUVOPWShrqG/uvQyevZ1PzQyI=;
 b=EOXWwGi+iFqOEfG/rQQIRuJOI9FzBhbpeuM+LNdWZznj0nfBc0Nn1NxaUT5XAPJKms
 K6cSIVL5qaguDZgUJartNP6RGnOHNE8zDKnaoYiHRzisn28j9YjPT1RRQ/+xM3TG/w5y
 sW7e5jpM78wevDh5SUr8FKRiQxOltky7CJZ5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745894872; x=1746499672;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uu363Vsz6mEGABsQNmrUVOPWShrqG/uvQyevZ1PzQyI=;
 b=Esz+jDAVgnSRMFDWu42DNSx2iOgBuQWaVKi9tiYcgrH8WlXXjMpid9Ear8W08NziVf
 2BFwbI8uq20120YCdWNNHW75QTbLXK/LzUxMrZD7j6wVYBjHqGTR1PB/ltguw06GyW3K
 1l8gKutNpSU2qHngTzf1qBloLkLJ7FdgbaY1NyLU0k1GbvDz44H0/pdestJaandslL7Z
 oasXvH1/awAGa4ZEmszYDbtMaM/c6ZQEeA/lkDFNwekZcz176QnrgsRvVq1509ve5Xa1
 PEsdo0NzOYSImnzArkvMzrDQ085VNdP1sPMyP4CAYmhGVvpBwkM855UbUd3TpP/hYBPF
 rdjw==
X-Gm-Message-State: AOJu0YxWsPmBziEgnoftwHWxrSepd274rNYmE9NOUO5fBPY30GRhh/3K
 3GqPpoiNWIq8FSQc5vsyi4rG9Tw2KsM4Q/Hw7MoLfUDPECEok2ZmuFZ1kQEPxjVb61uoIhf2sMx
 rP+sLckp2exm0aT1TUJBcimLKxFQp77FJHE0kaw==
X-Gm-Gg: ASbGncvBhuPy08t4E+2E4u4BnrY3qq9RcT8axdT5Ab/lc5rgs0o+8Ea0yehwwnJUecz
 yyQ6futgz2dRPjGdiTvNiZotnLgtqUbwBHQi2pYFiSqU3qllsi8YsAdOIpf1cFeg/p/ikWLJZaQ
 wqQIpT8no/7R4OLcDT/dKMz00q2fpSEJ4pBKpbuA==
X-Google-Smtp-Source: AGHT+IGlUr/HYzY8pO8D6hOX8CIGaZmFdecJQ4paZSgzE5GUxUUhbNLMNeVqvbf5iev9xHYfPzYQP1+ZRYF9eUv7PyM=
X-Received: by 2002:a17:90b:180d:b0:2ea:3f34:f18f with SMTP id
 98e67ed59e1d1-30a2155e3a9mr2692876a91.19.1745894872004; Mon, 28 Apr 2025
 19:47:52 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 28 Apr 2025 22:43:25 -0400
X-Gm-Features: ATxdqUEM7EVR1mFqfpurxwH_DA1wTFG1yuYbC9rmIMkY7NYYfixSn3WGTIs2Jvw
Message-ID: <CAJvnSUBzSvUbrTMmMDhX0+QUY7nCsW0rVBnv+q6aEB3LZQ3SSw@mail.gmail.com>
Subject: meson error on ARM Grace server 23.11/22.11
To: ci@dpdk.org
Cc: dev <dev@dpdk.org>, Honnappa Nagarahalli <honnappa.nagarahalli@arm.com>,
 stable@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000a959900633e1d342"
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

--000000000000a959900633e1d342
Content-Type: text/plain; charset="UTF-8"

Hi,

At the DPDK Community Lab we have been running CI tests with a new ARM
Grace server for the past couple of months on main and next-* branches. I
am trying to add LTS runs now, and ran into a snag with 23.11 and 22.11 for
this system. Stable maintainers I'm not sure whether this should be
addressed or not for hardware which is new and didn't exist when 22.11 and
23.11 were released... but I figured I'd make the tickets and find out. I
attached the meson logs to the tickets and if for whatever reason you guys
want to remote into this machine, I'm happy to setup the VPN and SSH
access.

22.11: https://bugs.dpdk.org/show_bug.cgi?id=1703
23.11: https://bugs.dpdk.org/show_bug.cgi?id=1702

--000000000000a959900633e1d342
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,=C2=A0</div><div><br></div><div>At the DPDK Commun=
ity Lab we have been running CI tests with a new ARM Grace server for the p=
ast couple of months on main and next-* branches. I am trying to add LTS ru=
ns now, and ran into a snag with 23.11 and 22.11 for this system. Stable ma=
intainers I&#39;m not sure whether this should be addressed or not for hard=
ware=C2=A0which is new and didn&#39;t exist when 22.11 and 23.11 were relea=
sed... but I figured I&#39;d make the tickets and find out. I attached the =
meson logs to the tickets and if for whatever reason you guys want to remot=
e into this machine, I&#39;m happy to setup the VPN and SSH access.=C2=A0</=
div><div><br></div><div>22.11:=C2=A0<a href=3D"https://bugs.dpdk.org/show_b=
ug.cgi?id=3D1703">https://bugs.dpdk.org/show_bug.cgi?id=3D1703</a></div><di=
v>23.11:=C2=A0<a href=3D"https://bugs.dpdk.org/show_bug.cgi?id=3D1702">http=
s://bugs.dpdk.org/show_bug.cgi?id=3D1702</a>=C2=A0</div></div>

--000000000000a959900633e1d342--
