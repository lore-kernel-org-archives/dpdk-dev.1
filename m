Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FBFC369AE
	for <dpdk-dev@archiver.kernel.org>; Sat, 12 Apr 2025 17:04:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B07A40285;
	Sat, 12 Apr 2025 19:04:47 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id 8A0D240041
 for <dev@dpdk.org>; Sat, 12 Apr 2025 19:04:46 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-af93cd64ef3so2123664a12.2
 for <dev@dpdk.org>; Sat, 12 Apr 2025 10:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744477485;
 x=1745082285; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5HL5TmvoPBnSvKPFhiP3fNFv35ggPuGW7BDw5qWEcc=;
 b=ZpBMZnUztBgMLwYlng7W1dNTzspK7FOTe5gqs3Oax8ERSa8ycWgjXW20BuoFnAOFeh
 wWmj9UcAA1AiOhn5NsY8IHw+X3WBUgeEx0LcIXMWCUYR/MZH2De5IjrjUEHcLa8ghS4v
 PXjUqw3jaTGXPxxkc/xxsNVBoEXS/fjlKhwFdR43Mg1Ar5aJ+3j2ZQ/u0Cy0fE4HlLch
 maCTbNWQQ+Mf9A0Ng/i8J/T5Fictw3cZX5RshhYBK4YM0ulZeC9Th/XRZpADvVNuPXmn
 RJKaRkFwai/vxbUVvGW/JeDp9CB4/+A5lYzIV8SLDdwTzhLSV+WhKFoPy3Mz8UqyIeDo
 AjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744477485; x=1745082285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5HL5TmvoPBnSvKPFhiP3fNFv35ggPuGW7BDw5qWEcc=;
 b=Iy5Cb7emSBf7n/eMnt284nBCAcv1rqMx/yRk15y7JWegC3+vfsQY5VXdEaFZGLJ9lj
 w0fu5sOwgDFr2Fuf+RVhwQi/hu7RToncjcaBuccipooEBJEvXoByMD+ehIevRD6WnZX2
 Pfi7pFL3ZBKSyu4F789E6dkro5ChOuWOtOZlA0/X9lWduh0++B4hHi1srxfEouUYesmn
 sTxkVFoK0F4eb/EPOo4i+K94iDiUTsLqFWjOQRxtAgkUmL29xY//mWqSYuym1mca46Zz
 A9BCqoYONZ5Jq9xeizuv2oqMqJt8TB5NGvs9aCX+BrEO4M3ZJtTILlfi2oIi9l3dB2P7
 aM6A==
X-Gm-Message-State: AOJu0YywmtQZ3Ew31C9kXW/oR8ZQeQ0WA6XBsLahPpuBixK+Gxf9k8ei
 wT+sEGXzEcJyOrnCDbWWTTYuPFvAliT5BbQmE8cBnHr2PAWFF09AjWbAQKsL8/o=
X-Gm-Gg: ASbGncseygmvMyZVtuvbsWEjXhngJ+9ppZ0dPcUFa5Y79aKXupsG/8xEZZFxfv6HjA2
 Jey6N+nGk6VWHg3PrjyI7Wbgn1iRgbKfl3PzKXuoEBam8QmNhvDXlRGuRLO3lMFnhyFWpKJi29t
 l/QSD4fxF+FuZ1wK9bWpplUr2a7AbTQ9/glg5etivX0ENBErLDf5M795Z0+xoRF8DiVA54vVIVl
 4ryActG7m3mt1mjjK3YEATxEFof0UNRfOKfqSyTQqxUJ2GnwNRZnBOYr5vQY5DJ+Z5lpXm6OJ3g
 8Y+BSI9fRqHmJJGgvmKLGHy3ZErO9QAazXBsQXEISdhgbAQhvhnLZ7iF7K898zA9lboM1cA7Hn6
 PtXtGh9pJJDf8vo7eQ/9odBhyA50=
X-Google-Smtp-Source: AGHT+IEMXQYsa99N0/Qshd/MxiSR4jqgasR4IsjETt36DDe07bYLdGeE1YtCCFJ5o8SEYFisaFJ2/A==
X-Received: by 2002:a17:903:2392:b0:21b:d2b6:ca7f with SMTP id
 d9443c01a7336-22bea4efffamr104649365ad.32.1744477485216; 
 Sat, 12 Apr 2025 10:04:45 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7b62b70sm69608935ad.39.2025.04.12.10.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Apr 2025 10:04:45 -0700 (PDT)
Date: Sat, 12 Apr 2025 10:04:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: <dev@dpdk.org>
Subject: Re: [RFC 00/13] Packet capture using port mirroring
Message-ID: <20250412100442.0c48971a@hermes.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35E9FBC9@smartserver.smartshare.dk>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <98CBD80474FA8B44BF855DF32C47DC35E9FBC9@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Sat, 12 Apr 2025 13:06:55 +0200
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Stephen Hemminger [mailto:stephen@networkplumber.org]
> > Sent: Saturday, 12 April 2025 01.45
> >=20
> > This is a rework of how packet capture is done in DPDK.
> > The existing mechanism using callbacks has a number of problems;
> > the main one is that any packets sent/received in a secondary process
> > are not visible. The root cause is that callbacks can not function
> > across process boundaries, they are specific to the role.
> >=20
> > The new mechanism builds on the concept of port mirroring used
> > in Linux/FreeBSD and also router vendors (SPAN ports). The
> > infrastructure
> > is built around a new ethdev call to mirror a port.
> >=20
> > The internals of dumpcap are redone but the program command
> > syntax is unchanged (no doc change needed). Usingthe new mirror
> > mechanism,
> > the dumpcap program creates a port using ring PMD and
> > then directs mirror to that. Then the packets are extracted from the
> > ring.
> > If capturing on multiple devices, they all get mirrored to
> > the same ring PMD. =20
>=20
> Here's some general feedback...
>=20
> I very much like the concept of using a shared ring for carrying the mirr=
ored packets.
> It allows other types of future consumers to process the mirrored packets=
, e.g. encapsulating and forwarding them into an L2 or L3 tunnel, or Wiresh=
ark remote capture.
>=20
> Using a Ring PMD instead of setting up a dedicated ring also has some adv=
antages, such as the ability to set up multiple separate mirror target inst=
ances.
> For performance reasons, we should ensure that a lightweight Ring PMD is =
available for mirroring, in case the Ring PMD is extended with new features=
 affecting its performance.
> Or maybe create a new type of mirror/capture virtual PMD. This would allo=
w applications to enqueue packets from non-ethdev interfaces into it.

The new modifications are simple, and do not impact performance of ring PMD.
We don't need another PMD for this.
It did uncover some broken API's in ring PMD, but those can be marked depre=
cated
and disappear in some future version.

>=20
> I'm not convinced you should undo the VLAN offloads when enqueueing a mir=
ror packet... If you do, you should also undo QinQ offloads. Undoing offloa=
ds is never going to end.
> And if you create a dedicated PMD type for carrying mirrored packets, you=
 can ensure that the offload fields remain intact on dequeue.

VLAN needs to be unoffloaded before filtering and writing to file.
Can move that logic to the other end of the ring (i.e in dumpcap).

The issue with filtering is that current DPDK BPF has no way to reference o=
ffload
meta data. There is a way to do that with Linux kernel BPF (via negative of=
fsets).
Looked into doing this in the DPDK BPF, but there are several blockers: not=
 all
the offloads are the same, and more importantly the pcap library to build f=
ilters
(pcap_compile) has some internal issues. The pcap library "knows" when it is
build a direct Linux socket filter, versus just class BPF. For example,
if you call pcap_compile() with "vlan 13", it will generate different code
based on whether it is a Linux filter or not.

> You should consider sampling and VLAN filtering as typical mirroring feat=
ures.
> It would improve the performance if such filtering is done before copying=
 the packets.

The problem is that filtering before going into the ring leads to creating =
BPF
dependency inside ethdev which is a build nightmare. Tried it and was not s=
uccessful.

>=20
> PS: I agree with your choice of copying (rather than cloning by refcount)=
 when mirroring the packets.
