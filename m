Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2B7C83F1A
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Jul 2025 17:36:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BED5D4067D;
	Tue, 22 Jul 2025 19:36:03 +0200 (CEST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id 0BEA440616
 for <dev@dpdk.org>; Tue, 22 Jul 2025 19:36:01 +0200 (CEST)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-7e62773cab8so52160085a.1
 for <dev@dpdk.org>; Tue, 22 Jul 2025 10:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753205760;
 x=1753810560; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/REcjIxnosVfuCC9Nz106e2i7kFVEYMbjmVnVpeTEc=;
 b=Vw9ckRiOf2i9JfslTmlYeoyDrq1p5fgK/+gCzZE2SED+DilwU6HCzR3t2z7Zok3jet
 pTzRBuur6/tfC/nPbpBJeuB6Vb8mcWWrQvM7/sG2G78d00PNDxwnajvSA3XIhIzVmALH
 u1En/XCvgm5ptA91v82+LbGx0U8/64OsyWtSFREzvHcgHbXKNqJRFMeg+kPCBhRGpAGo
 RCVJ/e7nkzos2bYWujmR+8/6rOwlwY3hQ/gEpgnZb8v3ALDTDcRKiT4IlcjHapT4m6Df
 4B6BpLC2ZPhJV+/0JHRrBTNVgAK5SuruNsLHiCOYSTpKJUJ4vS8xmg5KvCGfS27DBi5N
 /Q1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205760; x=1753810560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k/REcjIxnosVfuCC9Nz106e2i7kFVEYMbjmVnVpeTEc=;
 b=ffOdnhxbmsrIJqz7Par2I1oR2vTOnUf4MJEaFIf3pRA8dyN2zmGZQEeIhc3Tc6PGch
 FrhXRRVN0v/tk0GAtQ1zo1o5yhiL+cF8N+mKLia52LUM5WAbVtXtRfoT0p6Wdv4HsRHO
 CLpqOPSjI1V2WQUCXeVLdfM4X4f1Ek5ogvIOUoCna8F6siFKPZ9yNIyd1AHi8nRaa/bZ
 QYow6692DrdUAgEo9fgCc8sdq2UEwwUi4NJy7sOtO8iYu8fvxy6wAtW6SaT8dRsKmQ68
 gkz+tsU4XHsYOMIn9FgfkgtH88VK7ABSrz5llGPAlND7fN/p7u/4LUW5EzrCF/9gc8wP
 vzuA==
X-Gm-Message-State: AOJu0YyEuz49DewnP/BlWE4tDGBcnhooTUqULrXIHQXmG3ayiKkjhY6t
 JIJ0dllrb2QLgxRrqgiZ/5wQUBsLykN4q1jk2ESzWNsz4ZBLruesQ+ruFr8dhkav3MaYnaMG0aG
 ZKCbL
X-Gm-Gg: ASbGncu9lvxUnlDFsoLoD5QnCwCIMg/b9LpoYzoJgZtkMaD4R2BtXMF76V8avx461Pf
 c5yla9LM8vr3aY1v2avfUZGvUpBbMVS8um9kAHFwoKnc97nx4SfHGc7c9cOMdjA4bpkAY4QWv4f
 oKfxN49qOv1guxSb8ZuSwacM8rivdUs20LsIv8vXgwAKA47UgbqIF/BxqG5e0VwZC4WGaDwgFoj
 vowrsE85NDLJBRu0B9nmnXD4vhucueePvjGfO7s9IA+z1JCscbWSolto2lXdODvtQkqDXqJgfYw
 TDptbzKY4TtlNVOVe7dp10avElmj7smy/gSRtZgvrxNuuf5h3DMlgOSWe8cl+zzQeee97DJgz89
 VQhkyL9lAUicEyS3d4pYz18/8GPDecYWSLy4mOxYTG8AvxPf2GeHwXxTCSCoi0jUqe5goBp35
X-Google-Smtp-Source: AGHT+IGn3B56Fuw30basYyLZuUDiGAs37Q37p0VpX9+Gyi2EsSfrS8MqpIU4MNrf5LlYZ8SPrLNBRg==
X-Received: by 2002:a05:620a:191a:b0:7e3:3271:feb5 with SMTP id
 af79cd13be357-7e62a121647mr20057485a.9.1753205756162; 
 Tue, 22 Jul 2025 10:35:56 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7e356b282aasm552155885a.14.2025.07.22.10.35.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 10:35:55 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 00/13] Packet capture using port mirroring
Date: Tue, 22 Jul 2025 10:34:31 -0700
Message-ID: <20250722173552.184141-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250411234927.114568-1-stephen@networkplumber.org>
References: <20250411234927.114568-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This is a rework of how packet capture is done in DPDK.
The existing mechanism using callbacks has a number of problems:
  - can't work when packets are sent and received in secondary process
    because callbacks only function in the primary process
  - requires "opt-in" from application

The new mechanism builds on the concept of port mirroring used
in Linux/FreeBSD and also router vendors (SPAN ports).
See: https://en.wikipedia.org/wiki/Port_mirroring for a general description.

The implementation uses two new ethdev API's:
one to add a port mirror, and one to remove it.

The internals of dumpcap are redone but the program command syntax is
unchanged (no doc change needed). Using the new mirror mechanism, the
dumpcap program creates a port using ring PMD and then directs a port
mirror to that new ring PMD instance.  Then the packets are extracted
from the ring.  If capturing on multiple devices, they all get
mirrored to the same ring PMD.

The dumpcap program needs to be able to start the ring PMD it created
but the existing ethdev API is broken when used from secondary process.
One of the patches fixes that, it was also reported previously in Bugzilla.

The mirror API has a restriction that the port being mirrored to must allow
lock free transmit. This is because both Rx and Tx as well as multiple
queues need to go over the same transmit queue. Although it might be possible
to have some complex mapping between multiple ports/queues being mirrored
to multiple transmit queues, that gets to be a lot of overhead in API's
and implementation. Fixing the ring and null PMD to allow lockless
transmit is good enough.

Added tests for the mirror features.
The performance has not been measured but the overhead of checking for
mirror port is no more that the overhead of looking at the callback list.

TODO items:
  - need release notes for new features (will wait till 25.11)
  - more through testing on real hardware

v6 - fix build errors on Windows
   - use libpcap BPF not DPDK bpf to allow Windows support.

Stephen Hemminger (13):
  ethdev: allow start/stop from secondary process
  ethdev: make sure all necessary headers included
  test: add test for hotplug and secondary process operations
  net/ring: allow lockfree transmit if ring supports it
  net/ring: add new devarg to create vdev from existing ring
  mbuf: add dynamic flag for use by port mirroring
  ethdev: add port mirroring feature
  pcapng: split packet copy from header insertion
  pcapng: make queue optional
  test: add tests for ethdev mirror
  app/testpmd: support for port mirroring
  app/dumpcap: use port mirror instead of pdump
  pdump: mark API and application as deprecated

 app/dumpcap/main.c                            | 468 ++++++++++++++----
 app/dumpcap/meson.build                       |   8 +-
 app/pdump/main.c                              |   3 +
 app/pdump/meson.build                         |   1 +
 app/test-pmd/cmdline.c                        |   1 +
 app/test-pmd/cmdline_mirror.c                 | 129 +++++
 app/test-pmd/cmdline_mirror.h                 |  12 +
 app/test-pmd/meson.build                      |   2 +
 app/test/meson.build                          |   7 +-
 app/test/test_ethdev_mirror.c                 | 286 +++++++++++
 app/test/test_mp_secondary.c                  |  51 +-
 config/rte_config.h                           |   1 +
 doc/guides/howto/packet_capture_framework.rst |  15 +-
 doc/guides/nics/bnxt.rst                      |   2 +-
 doc/guides/prog_guide/ethdev/index.rst        |   1 +
 doc/guides/prog_guide/pdump_lib.rst           |   4 +
 doc/guides/rel_notes/deprecation.rst          |   3 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst   |  15 +
 doc/guides/tools/pdump.rst                    |   2 +
 drivers/net/ring/rte_eth_ring.c               |  49 ++
 lib/ethdev/ethdev_driver.c                    |  11 +-
 lib/ethdev/ethdev_driver.h                    |   6 +
 lib/ethdev/ethdev_private.c                   | 142 ++++++
 lib/ethdev/ethdev_private.h                   |  29 ++
 lib/ethdev/ethdev_trace.h                     |  17 +
 lib/ethdev/ethdev_trace_points.c              |   6 +
 lib/ethdev/meson.build                        |   1 +
 lib/ethdev/rte_ethdev.c                       | 101 ++--
 lib/ethdev/rte_ethdev.h                       |  23 +-
 lib/ethdev/rte_ethdev_core.h                  |  12 +-
 lib/ethdev/rte_mirror.c                       | 375 ++++++++++++++
 lib/ethdev/rte_mirror.h                       |  99 ++++
 lib/mbuf/rte_mbuf_dyn.h                       |   9 +
 lib/pcapng/rte_pcapng.c                       | 179 +++----
 lib/pcapng/rte_pcapng.h                       |  27 +-
 lib/pdump/rte_pdump.h                         |  12 +-
 36 files changed, 1866 insertions(+), 243 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

-- 
2.47.2

