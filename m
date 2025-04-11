Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8C8C369AE
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Apr 2025 23:49:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC8F74021E;
	Sat, 12 Apr 2025 01:49:41 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 90ADE4021E
 for <dev@dpdk.org>; Sat, 12 Apr 2025 01:49:39 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-af589091049so1791601a12.1
 for <dev@dpdk.org>; Fri, 11 Apr 2025 16:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1744415378;
 x=1745020178; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=drUeGKd85Gh6Btmf1p7aUdpG0n7Se87neATysKLSODw=;
 b=ec/r6geeMOYvpq6i6C23o+L4FopDUu4FEuWYOnmfj/5NxJSYtOfF18nZoBxe1M8Fl9
 FWM37bQHubLxITEKpR3xNVReeeTDbSAqAYxyA2dJLYYk1XDxzoXwsuqa0quH/tJP7DC8
 hmyU+RJdMhJ4ztn/g1+G0eFxiS60qZFcHzYX4rcLaG6S2hbdlIBHIMNnNOj7eTTBbA0W
 1F6Yi0J4c4fBIerQ8M7j85d037gd85KH0/J2zYYN+64wPhoDgu3TQXFHVUqrvOk9TDDK
 HaqzfHMyJ0GuNAw5kn4K5mmT3JlYxggUynWvl6hIAOM276kklFMzN+do/qUX9MwTdsqO
 bYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744415378; x=1745020178;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=drUeGKd85Gh6Btmf1p7aUdpG0n7Se87neATysKLSODw=;
 b=JUPvFSCQBYLGmTXN0M57BVMsG4V2vZa1xigvChMygvAdMg4dncxwFB11xzlL+XXBgr
 5Im0hk5ffS8t6Qf2cCDvhFMFu09y/sdmA0Lz1mNAMDoYuplLoGNghBPfqwTMPeBOhpBT
 euWsY2emIvREJUY8ThuUKCFaB0/hGoo+EIZF+VQpd0Mxx4cQzWbSVuWZSXDV4mGvUIr7
 HSJSgnHPcsp9U3y6uAP8aTFVRrGr/3MTKtsWXcpxHIxIxI2LIpt8gA9jPmDzcSY2BleB
 FivF2+oNiN4jbyjl4Z6Has0APq2aQsklqHZFAqnKw27db4MDELSEysOqgLntqLrdAaEj
 UB/A==
X-Gm-Message-State: AOJu0YyKwHKa1kD+geEGOo9oDojoq9lTk7hJJlqg8ZvlW5TUxVAUzCpo
 fzRUbfQUIC6aoGA8ws2PtAwT3nd0QtpqDiGeA9vuFEit1y/MSGYQGmc1h/Mgny48iNsgXpOS3l3
 D
X-Gm-Gg: ASbGncsxFKKNBHV8eiwulkaMBQ0+4sZKly8fRqicIdz5sAaLQ6Gfh4oBaf48dy+nh/i
 C7mH5pCaQjHRx65xR5O0NeH4/mK8UnmM7OzXDWgjqXOVrKaNga8MCuPkS1p2hkhadZNNeGH8TeD
 rmoGcTJYO1NxOvNnfA1VylsT2YA/pXjLuSUCy8ATP8YCpKCfPflcGgpT2xZZ77GiiaZVGOJvkD/
 zOewMdx6OZxrS901QGajKNhF38k9PI0J7LgQUauAcDvFAZWsCyInGCdAMlgk45GLXt0oYcR/n7M
 h5lekAL6RCl60EbVMGALz9xipo1kKC8Kh5SqokKNuI/c8m4fyEnwkT3nQrjiRtcZC6W5kVHYBCX
 m1ka++iqdBhWHbhhm
X-Google-Smtp-Source: AGHT+IEks6W5DnFNGF72ND6/Wgfmglb/gO50TbsTQ0uyF6SK8DbMfiWh07OR2wo9oEYm9XIhxURzFQ==
X-Received: by 2002:a17:90b:4c04:b0:2fe:a336:fe65 with SMTP id
 98e67ed59e1d1-30823670176mr7687767a91.10.1744415378232; 
 Fri, 11 Apr 2025 16:49:38 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306dd11e643sm6538661a91.12.2025.04.11.16.49.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 16:49:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC 00/13] Packet capture using port mirroring
Date: Fri, 11 Apr 2025 16:44:37 -0700
Message-ID: <20250411234927.114568-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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
The existing mechanism using callbacks has a number of problems;
the main one is that any packets sent/received in a secondary process
are not visible. The root cause is that callbacks can not function
across process boundaries, they are specific to the role.

The new mechanism builds on the concept of port mirroring used
in Linux/FreeBSD and also router vendors (SPAN ports). The infrastructure
is built around a new ethdev call to mirror a port.

The internals of dumpcap are redone but the program command
syntax is unchanged (no doc change needed). Usingthe new mirror mechanism,
the dumpcap program creates a port using ring PMD and
then directs mirror to that. Then the packets are extracted from the ring.
If capturing on multiple devices, they all get mirrored to
the same ring PMD.

Doing this uncovered a bunch of additional missing features and bugs.
The first is that test-pmd auto attach introduced in 24.11 breaks this
(and it broke old pdump as well) so it is removed.

The dumpcap program needs to be able to start the ring PMD it created
but the existing ethdev API is broken when used from secondary process.
So fix that.

The mirror API has a restriction that the port being mirrored to must allow
lock free transmit. This is because both rx and tx as well as multiple
queues need to go over the same transmit queue. Although it might be possible
to have some complex mapping between multiple ports/queues being mirrored
to multiple transmit queues, that gets to be a lot of overhead in API's
and implementation. Fixing the ring and null PMD to allow lockeless
transmit is good enough.

Added tests for the new features.
The performance has not been measured but the overhead of checking for
mirror port is no more that the overhead of looking at the callback list.

TODO items:
  - need release notes for new features
  - more through testing on real hardware
  - mark old pdump API and application for deprecation in 25.07 and removal in 25.11
  - more cleanup of patch wording and docs needed.

Stephen Hemminger (13):
  app/testpmd: revert auto attach/detach
  ethdev: allow start/stop from secondary process
  test: add test for hotplug and secondary process operations
  net/ring: allow lockfree transmit if ring supports it
  net/ring: add argument to attach existing ring
  net/ring: add timestamp devargs
  net/null: all lockfree transmit
  mbuf: add fields for mirroring
  ethdev: add port mirror capability
  pcapng: split packet copy from header insertion
  test: add tests for ethdev mirror
  app/testpmd: support for port mirroring
  app/dumpcap: use port mirror instead of pdump

 app/dumpcap/main.c                          | 361 +++++++++++++++-----
 app/dumpcap/meson.build                     |   2 +-
 app/test-pmd/cmdline.c                      |   1 +
 app/test-pmd/cmdline_mirror.c               | 120 +++++++
 app/test-pmd/cmdline_mirror.h               |  12 +
 app/test-pmd/meson.build                    |   1 +
 app/test-pmd/testpmd.c                      |  77 ++---
 app/test/meson.build                        |   1 +
 app/test/test_ethdev_mirror.c               | 286 ++++++++++++++++
 app/test/test_mp_secondary.c                |  51 ++-
 config/rte_config.h                         |   2 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  15 +
 drivers/net/null/rte_eth_null.c             |   1 +
 drivers/net/ring/rte_eth_ring.c             |  91 ++++-
 lib/ethdev/ethdev_driver.c                  |  11 +-
 lib/ethdev/ethdev_driver.h                  |   3 +
 lib/ethdev/ethdev_private.c                 |  80 +++++
 lib/ethdev/ethdev_private.h                 |  23 ++
 lib/ethdev/ethdev_trace.h                   |  14 +
 lib/ethdev/ethdev_trace_points.c            |   6 +
 lib/ethdev/rte_ethdev.c                     | 275 +++++++++++++--
 lib/ethdev/rte_ethdev.h                     |  81 +++++
 lib/ethdev/rte_ethdev_core.h                |   6 +-
 lib/mbuf/rte_mbuf_core.h                    |   8 +
 lib/pcapng/rte_pcapng.c                     | 178 +++++-----
 lib/pcapng/rte_pcapng.h                     |  27 +-
 26 files changed, 1468 insertions(+), 265 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c

-- 
2.47.2

