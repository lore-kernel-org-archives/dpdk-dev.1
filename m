Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA28CD2FEC0
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:21:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAEB840E2A;
	Tue, 27 Jan 2026 18:21:40 +0100 (CET)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52]) by mails.dpdk.org (Postfix) with ESMTP id DC2BE40E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:21:39 +0100 (CET)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-47edd9024b1so49879565e9.3
 for <dev@dpdk.org>; Tue, 27 Jan 2026 09:21:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769534499;
 x=1770139299; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=62tHsCR6Ry059OWj4uO8lgKCzkvMy6a403Lnr/gYnOI=;
 b=quJblvETeVQ70ZSggq0kSOF/rMAu4huuDFIsLKkdBVY+aDU+482KT2Reamp5mgEGea
 YXmqo6Myuo84TDneQckrKUQw3Sabm19dR6gzcnNDzDwH+afFAzGlBa1N+GyBvD5OObsQ
 oDsKZeCTz5ZU1nqzPllGkfuP0lr2D+d0Ieqbtl2SR8LZ3Ew608sy+fZerQgSU3lSg6i4
 7rCmQw9IedSQfW4VEDeJDeigPZtBr7FNDR0w61m97DYpg5JMWij6jUtPpqXVwWLwwXZN
 EzJMmAA5a24BKQ+PQNSbiA1W9IsUJoEhgM2RGISDup2LCGoCOgK09YME6A4IQU2kaLRJ
 8U7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769534499; x=1770139299;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=62tHsCR6Ry059OWj4uO8lgKCzkvMy6a403Lnr/gYnOI=;
 b=VW8YhutEimBzU10WzpkcXfcGTCn2m+nfOzUQXKf2sNd2B/pt0j4g+Wwyi1w/OJSIza
 pNdpELPYJ91bXX/s6iKxDZ7iHy83CQKZruKmO7eKMM+X7fKbGc9vke8rvdxDtISCRPeH
 i5k1LGoyb4DUVCfdaDnhTBtJU+RHTnU/E/vEcto929LHsBqYwJFOXGTgLjf/BErCOLsk
 UnVywOqLSFuTtdV9+ZFn7lqAXefkBmnIM6sMoWj6Op3dZFRkb8X4Gt2K7cVsLmSHOxsn
 iHRNI3OLgjj+e3OvHPHwQ6MGVVHEDgUkcgPMgPVrbwRcKBKZg+LjMEdNEs2c+v7ZLGMt
 AIsw==
X-Gm-Message-State: AOJu0YxhkDWSVW3dzL7WOD3++36Ih9yClqME2oIQOnQ5/ViRQPw88pqW
 M4TM+UgLB4fPaOqvX5DYpeLiaEteGvydYvuzsJPnFHineD7EKY5jdoiN0X2ay6enknVpgqgt6FS
 WXPm0
X-Gm-Gg: AZuq6aK0LE0MGTWBvQx18zk+r3pj/LwGTlmDXYkUl0qk01cR/InLKuAK3V305ZnWJ7g
 0rjJDtZIgUoNYrmCW0IyakVUUCgEYwZPayh5ALrvA/QGNF+/gkLkkTVykkOWaLg/qktsDfXv/XP
 fEbz8p5T7Ln6pJVoD3HFBUTaMsD7hYj/8QqgXp/sjIRQPpXCxemyygUqLMY0V83IjQtDTosshpu
 ZmfU+wUMr/vhLfnmZNBp8WpfVTAccXhndOc+Xzhwz8G++M5OuogWlGkqgRrLaWAby/lukqHWkGR
 DYWfa6QXFAgagl4PiLJJilmVsDib4WHV0BxPulM70YVXuM90c/NmCMiH5ouBkrm9i6zScahq+Fc
 4kj3kY3i7dvy1OMb+VvhuSRk7V6idjnt8lKVBIVo77uOIeicObgBe1JjrxbrYXUc+xR+ghvbZ7W
 OKX09CRj7ldPuUIzMFdsH+JiUbFAAyG6HjVMf+Luw8LxC44fGqhQ==
X-Received: by 2002:a05:600c:3595:b0:477:a978:3a7b with SMTP id
 5b1f17b1804b1-48069c78bdamr31524355e9.22.1769534499099; 
 Tue, 27 Jan 2026 09:21:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4806ce56490sm4769395e9.12.2026.01.27.09.21.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 09:21:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v8 00/14] net/pcap: improvements and test suite
Date: Tue, 27 Jan 2026 09:18:41 -0800
Message-ID: <20260127172128.124473-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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

This series contains improvements to the PCAP PMD including new
features, bug fixes, code cleanup, and a comprehensive test suite.

New features:
  - VLAN tag insertion on Tx and stripping on Rx
  - Nanosecond precision timestamps (when hardware/libpcap supports it)
  - Accurate link state, speed, and duplex reporting in interface mode
  - Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS capability

Bug fixes:
  - Fix multi-segment transmit to dynamically allocate instead of
    silently truncating packets larger than 9K stack buffer
  - Change Tx burst to always consume all packets; failed sends
    increment error counter rather than leaving mbufs for retry
    (pcap_sendpacket failures are not transient)

Code cleanup:
  - Convert internal flags from int to bool
  - Remove unnecessary casts of void* from rte_zmalloc
  - Replace rte_malloc/rte_memcpy with libc equivalents in osdep code
  - Include headers explicitly rather than relying on indirect includes
  - Remove unnecessary volatile qualifier on statistics
  - Reduce scope of file-level variables

Testing:
  - Add comprehensive unit test suite covering basic operations,
    timestamps, jumbo frames, VLAN handling, multi-queue, and more

v8:
  - Fix pcap header length in VLAN transmit
  - Fix clang warnings from ethtool link_mode array

v7:
  - Drop MTU configuration patch; not necessary as underlying OS
    commands (ip link, ifconfig) can be used directly
  - Add patch to remove unnecessary volatile on queue statistics
  - Add test_link_status to unit test suite
  - Add Acked-by from Marat Khalili on patch 11

v6:
  - Rebase to latest main

Stephen Hemminger (14):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: improve multi-segment transmit handling
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN insert and strip
  net/pcap: add link state and speed for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  net/pcap: clarify maximum received packet
  test: add test for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 2337 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    8 +
 doc/guides/rel_notes/release_26_03.rst |    9 +
 drivers/net/pcap/pcap_ethdev.c         |  474 +++--
 drivers/net/pcap/pcap_osdep.h          |   23 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |  289 ++-
 drivers/net/pcap/pcap_osdep_linux.c    |  115 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 10 files changed, 3180 insertions(+), 173 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

