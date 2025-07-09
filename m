Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EE5C83F03
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 17:36:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6AD83402DF;
	Wed,  9 Jul 2025 19:36:16 +0200 (CEST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 655C04028C
 for <dev@dpdk.org>; Wed,  9 Jul 2025 19:36:15 +0200 (CEST)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2353a2bc210so1688255ad.2
 for <dev@dpdk.org>; Wed, 09 Jul 2025 10:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1752082574;
 x=1752687374; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hatNfMTlCAM6aiKspaTsH1eUDasoJkGRGrE2gChzlYg=;
 b=Q/F21NPByNkX+2bumTRgbFIREZDr+80AkBQvNVJevgrW9uJEh50mVlzERrDfB/qreo
 SzoGtYilD7atFHZobjPVvQ4qACfRPZPLVhMZlciCXwvp8OnVyfoqyUZ9WPqz6y4YdwIa
 4ydrmx5tmd9elNS0zGZyhyneYtJqQ9AzzT1lBQwxMJFlzFyfQKs+/BDm2VF27WBBlSWK
 uJPzrk4+Ri4AZiYETvNlY9Y0oP9IUGULUHXLherJF6Cf1u+K82XJFI1euso+Iqz9++tw
 JJo4alNQTXg1ABMi75AS/Z8a8lqQTOPnaEYHMjFNk2NnxsE12ra92r8VDK3/ARJ2/pCW
 rpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752082574; x=1752687374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hatNfMTlCAM6aiKspaTsH1eUDasoJkGRGrE2gChzlYg=;
 b=pZk0GprA/IvOXfp27ixHWKiVzygRJzWXS0jsUnAXg2qkJy7oUsVCCNdMy0IAM3nh5n
 STlnjnM8SUqHCrlaK8H97KI3qt3z2pfG/60ZRX6K9alzLt1xGoxANDwMwvmLVlN6NPZD
 SVdG3/DLJWjku5Z2APGJ9beKQrU+4LKJLkZ1jUur8Ece7i0CspkOh7LVWdy+n4TCMb/f
 GzY8CPPOiip1xQjmH8XHNLnuxFVPmHAngTgVMpPgCDrDmdDN7O9BplVaTVw8dDIeSle3
 qh1Q29S0NWcDV0XMM0xIbR2M/p5te3J01zfQS9GSMsjqErZZluBnuu8VYDKACYRIKPmy
 E90g==
X-Gm-Message-State: AOJu0YzkET2veUnISL3HiZb3JOBdXufUNiWKQr/JwyLJahXHQ6MBPRvM
 Fjj7ED4D5lmIV9EpsfSk14YyiNrmJKG4Ya1aVaDVrvtYgch/KwmuzjwS44kdJ27TILAyKqvKSYt
 z38ZO
X-Gm-Gg: ASbGncuTmNmKVcZL/FNFwuqbY1D0GV8BAWfehOcHPuJEhi+1I0xLPfUWraO6nc1woMB
 tfPJrWp6s2KZFBVs9/E3kJ+xg5Z/rZqH3bVhhFIPo/1TLuBoR+Q6ycCfY4/uO+GpUt/gRvVbVI0
 9kOh2+BkcDDJZTqXhuev4CS0vqE7uKDKrtxm8ZOCE5ytGtaCoQzBVCi5J7gXVTqnwilk4/0mq4R
 L6Dzp0SX7R7xBZBZ44v7HeX1PSwBEXqxQAcF5fqQTXJ+bjDB9yrFJ5WPj2cmGekYo5qWej4dhyD
 J7ZIhWNzyieHNQnms1lN84ch6xeRs2N2znYjzS8IZ5Kul45CgIsXHOUoS8FEppJRE4JjBdSlRu2
 N12PnsIHKS4Ua4+1P5pjjcQuyTfNZq1LHLq1FR5jXlkiKmhI=
X-Google-Smtp-Source: AGHT+IH1rTcgso+1nabQHWxUGViZwGTza71hAYsCnPv5u4/mPwJTxgE70vUxqiVa3UpktWmzWloqCg==
X-Received: by 2002:a17:903:17c6:b0:234:d2fb:2d13 with SMTP id
 d9443c01a7336-23de245fe3dmr10963935ad.18.1752082574323; 
 Wed, 09 Jul 2025 10:36:14 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23c845b7467sm138525475ad.230.2025.07.09.10.36.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 10:36:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [RFC v2 00/12] Packet capture using port mirroring
Date: Wed,  9 Jul 2025 10:33:26 -0700
Message-ID: <20250709173611.6390-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <0250411234927.114568-1-stephen@networkplumber.org>
References: <0250411234927.114568-1-stephen@networkplumber.org>
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
it won't work when packets are sent and received in secondary process because
callbacks only function in the primary process; pdump requires that the
main program "opt-in" to having packet capture which requires changes
to existing network appliances.

The new mechanism builds on the concept of port mirroring used
in Linux/FreeBSD and also router vendors (SPAN ports).
See: https://en.wikipedia.org/wiki/Port_mirroring for a general description.

The implementation uses two new ethdev API's one to add
a port mirror, and one to remove it.

The internals of dumpcap are redone but the program command
syntax is unchanged (no doc change needed). Using the new mirror mechanism,
the dumpcap program creates a port using ring PMD and
then directs a port mirror to that new ring PMD instance.
Then the packets are extracted from the ring.
If capturing on multiple devices, they all get mirrored to
the same ring PMD.

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

Added tests for the new features.
The performance has not been measured but the overhead of checking for
mirror port is no more that the overhead of looking at the callback list.

TODO items:
  - some names are too verbose
  - need release notes for new features
  - more through testing on real hardware

Stephen Hemminger (12):
  ethdev: allow start/stop from secondary process
  test: add test for hotplug and secondary process operations
  net/ring: allow lockfree transmit if ring supports it
  net/ring: add new devargs for dumpcap use
  mbuf: add dynamic flag for use by port mirroring
  ethdev: add port mirroring feature
  pcapng: split packet copy from header insertion
  pcapng: make queue optional
  test: add tests for ethdev mirror
  app/testpmd: support for port mirroring
  app/dumpcap: use port mirror instead of pdump
  pdump: mark API and application as deprecated

 app/dumpcap/main.c                          | 443 ++++++++++++++++----
 app/dumpcap/meson.build                     |   2 +-
 app/pdump/main.c                            |   3 +
 app/pdump/meson.build                       |   1 +
 app/test-pmd/cmdline.c                      |   1 +
 app/test-pmd/cmdline_mirror.c               | 129 ++++++
 app/test-pmd/cmdline_mirror.h               |  12 +
 app/test-pmd/meson.build                    |   2 +
 app/test/meson.build                        |   7 +-
 app/test/test_ethdev_mirror.c               | 285 +++++++++++++
 app/test/test_mp_secondary.c                |  51 ++-
 config/rte_config.h                         |   1 +
 doc/guides/rel_notes/deprecation.rst        |   3 +
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  15 +
 drivers/net/ring/rte_eth_ring.c             |  91 +++-
 lib/ethdev/ethdev_driver.c                  |  11 +-
 lib/ethdev/ethdev_driver.h                  |   6 +
 lib/ethdev/ethdev_private.c                 | 133 ++++++
 lib/ethdev/ethdev_private.h                 |  29 ++
 lib/ethdev/ethdev_trace.h                   |  17 +
 lib/ethdev/ethdev_trace_points.c            |   6 +
 lib/ethdev/meson.build                      |   1 +
 lib/ethdev/rte_ethdev.c                     | 101 +++--
 lib/ethdev/rte_ethdev.h                     |  23 +-
 lib/ethdev/rte_ethdev_core.h                |   6 +-
 lib/ethdev/rte_mirror.c                     | 344 +++++++++++++++
 lib/ethdev/rte_mirror.h                     | 113 +++++
 lib/mbuf/rte_mbuf_dyn.h                     |   9 +
 lib/pcapng/rte_pcapng.c                     | 179 ++++----
 lib/pcapng/rte_pcapng.h                     |  27 +-
 lib/pdump/rte_pdump.h                       |  12 +-
 31 files changed, 1851 insertions(+), 212 deletions(-)
 create mode 100644 app/test-pmd/cmdline_mirror.c
 create mode 100644 app/test-pmd/cmdline_mirror.h
 create mode 100644 app/test/test_ethdev_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.c
 create mode 100644 lib/ethdev/rte_mirror.h

-- 
2.47.2

