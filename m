Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B895E7FDF8
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:12:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E66D4028B;
	Tue,  3 Feb 2026 00:12:53 +0100 (CET)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43]) by mails.dpdk.org (Postfix) with ESMTP id 4DFF740151
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:12:52 +0100 (CET)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso41511185e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770073972;
 x=1770678772; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XksLgVexPVeSqT00A65Cl/dwC3EJgmRgfPrzVmGd8+Y=;
 b=pXYybXbtwcQD1ShSS1FjwOAI9k2PU7ZoI7fOjwv57okaU5zxTPFIu6Io5TRysgAu4j
 Tp+4cZQJH3UdPSyC+0i1Vr301PEL9oJWIj1lQwbJ3eQH73udl7bNzxOHci9BSS/Q4hns
 Y4X6ecEhc6RJs+HQ69A1CBESk2X79Ub4qAnjmLmQw96DbAiPPXoJTOg8mmWOjAA4hKmC
 J2qMYARfGX2tUH/OEBtoB7BC+fUW0rXR0pyde9Iv6lmYJuKY9g+0/Mz7tMEnGWSOLNwr
 L7f7y28fTld9jmxI0sTL5wl4kHS/IaURGi2q3xhPG7mv5eXN/l0eidsdYLou1Eb+ZWOW
 ECOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770073972; x=1770678772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XksLgVexPVeSqT00A65Cl/dwC3EJgmRgfPrzVmGd8+Y=;
 b=RT+46nTbHuD+9oDq8whFdcETsqCOvXSAtX1PGuJGvMUkWM7efa7WB6UowSWn16j2FB
 juPAP18eI6GHOCVNc1czqLN5Vu3UYNSEtKrhFDU31qlWK+Qz7XV2/ae8DAjMV68qkC1+
 eDtbtbjrDaV5OYKiVVA72fKxug86SGLm1gUgZVSgiXJ5yIepKep1qEtGZ1Cn8YPmRID6
 myKlNkB7h4v2QzlBl6/aWOtv9fpKJbYfmmSSf6UtT7Rr5L1cYlZQynXhPgbeNN5KDHUJ
 VUeersdh8O4cAo7jHWSPj6s1aFVk2T76Owagh27cKriN7Ie48592dergU9i/8Zc2chCs
 faAw==
X-Gm-Message-State: AOJu0Yz6FO9bobShZrEpYEGmYOrQHp3cCfruZSgCfOylPayB7r/poczr
 Puuzu8i9CtsvwnDaePXoYmn+DaE7QDmoqsbPHBIypsd2/nDPPFYrA3iRxET55uMQGqShRsrYPBR
 J6ObN
X-Gm-Gg: AZuq6aILy2kc1uXOpTARH8Y++uzsBDaeD/hgfRKwDKyeWeorKOPrIkZqiosTog1b6ki
 3jk1IchBy6L0cuopksXd5cPKt6Hw9P+gfyFCnpLDxyfcblKQiOg0t0h7+pzYq4mDawVq1/xv0vx
 lqgE4LfQOmmN9tueY+uIUDuvv24LoFFdSLgrNnuks4M26lXzedgUs8BID9ywUUttUPf1I7kAaho
 By7j6t5scLn1M86H0I2NWCgf4Q/GcuCu6nKQb05fasD2ro4M38U6LWlvLxiCMoZoHjcr+lXoDT8
 1x8iC2Wf0NMiSRC+UhI0AJntc0pmmJPI/PHtwVHKlOGwRvIaL1Fy/cpsJZIR+hxjSAhbPc1KL64
 U22+UhgmLf9DV5ebDAtdre9QoYgMtx4Zhffpv4eW6R6PbuP0apjuOEdOyuCYnj3f7H9wXd1czES
 uEVxCFgEWD+CEmCN2T431cq7HEyNN0Gy8aD+p6rW1xtl+awEfMpQ==
X-Received: by 2002:a05:600d:6402:20b0:482:e5d4:b7ca with SMTP id
 5b1f17b1804b1-482e5d4b849mr110671975e9.8.1770073971657; 
 Mon, 02 Feb 2026 15:12:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:12:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v12 00/19] net/pcap: improvements and test suite
Date: Mon,  2 Feb 2026 15:09:03 -0800
Message-ID: <20260202231245.216433-1-stephen@networkplumber.org>
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
  - Runtime VLAN offload configuration via vlan_offload_set callback
  - Nanosecond precision timestamps (when hardware/libpcap supports it)
  - Accurate link state, speed, and duplex reporting in interface mode
  - Support for Windows interface mode
  - Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS capability
  - Configurable snapshot length via snapshot_len devarg

Bug fixes:
  - Fix multi-segment transmit to dynamically allocate instead of
    silently truncating packets larger than 9K stack buffer
  - Change Tx burst to always consume all packets; failed sends
    increment error counter rather than leaving mbufs for retry
    (pcap_sendpacket failures are not transient)
  - Reject non-Ethernet interfaces to prevent malformed packets
    and kernel warnings on FreeBSD/macOS loopback
  - Fix infinite_rx ring fill applying VLAN strip and timestamp
    offloads to template packets, preventing those offloads from
    working correctly during packet delivery

Code cleanup:
  - Convert internal flags from int to bool
  - Remove unnecessary casts of void* from rte_zmalloc
  - Replace rte_malloc/rte_memcpy with libc equivalents in osdep code
  - Include headers explicitly rather than relying on indirect includes
  - Remove unnecessary volatile qualifier on statistics
  - Reduce scope of file-level variables
  - Defer pcap handle opening until device start
  - Use bulk free for better Tx performance

Testing:
  - Add comprehensive unit test suite covering basic operations,
    timestamps, jumbo frames, VLAN handling, multi-queue, and more
  - Test discovers network interfaces using pcap_findalldevs API
    for portable interface enumeration across Linux, FreeBSD, macOS,
    and Windows
  - New tests for runtime VLAN offload toggle, VLAN strip with
    infinite_rx mode, and timestamp generation in infinite_rx mode

v12:
  - Add vlan_offload_set callback to support runtime VLAN strip
    configuration via rte_eth_dev_set_vlan_offload()
  - Fix bugs in vlan strip and infinite rx mode
  - Rebase to main

v11:
  - Fix build on FreeBsd

v10:
  - Split transmit handling into separate patches for bulk free,
    bounce buffer allocation, and cleanup for easier review
  - Add patch to reject non-Ethernet interfaces (fixes loopback
    issues on FreeBSD/macOS where DLT_NULL is used)
  - Test uses pcap_findalldevs() for portable interface discovery
    instead of hardcoded interface names

v9:
  - Add configurable snapshot length parameter (snapshot_len devarg)
  - Defer opening of pcap files and interfaces until eth_dev_start()
    instead of during probe, passing configured snapshot length

Stephen Hemminger (19):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: use bulk free
  net/pcap: allocate Tx bounce buffer
  net/pcap: cleanup transmit buffer handling
  net/pcap: report multi-segment transmit capability
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN insert and strip
  net/pcap: add link state and speed for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reject non-Ethernet interfaces
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  net/pcap: clarify maximum received packet
  net/pcap: add snapshot length devarg
  test: add test for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c              | 2962 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    8 +
 doc/guides/nics/pcap_ring.rst          |   27 +
 doc/guides/rel_notes/release_26_03.rst |    9 +
 drivers/net/pcap/pcap_ethdev.c         |  670 ++++--
 drivers/net/pcap/pcap_osdep.h          |   23 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   98 +-
 drivers/net/pcap/pcap_osdep_linux.c    |  115 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 11 files changed, 3772 insertions(+), 238 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

Stephen Hemminger (19):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: use bulk free
  net/pcap: allocate Tx bounce buffer
  net/pcap: cleanup transmit buffer handling
  net/pcap: report multi-segment transmit capability
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN insert and strip
  net/pcap: add link state and speed for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reject non-Ethernet interfaces
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  net/pcap: clarify maximum received packet
  net/pcap: add snapshot length devarg
  test: add test for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 2962 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    8 +
 doc/guides/nics/pcap_ring.rst          |   27 +
 doc/guides/rel_notes/release_26_03.rst |    9 +
 drivers/net/pcap/pcap_ethdev.c         |  709 ++++--
 drivers/net/pcap/pcap_osdep.h          |   23 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   98 +-
 drivers/net/pcap/pcap_osdep_linux.c    |  124 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 11 files changed, 3819 insertions(+), 239 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

