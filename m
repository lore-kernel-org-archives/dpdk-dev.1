Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 341CDD46BEF
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:41:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4A564014F;
	Wed, 28 Jan 2026 19:41:35 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 806F74003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:41:35 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47d59da3d81so9377345e9.0
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625695;
 x=1770230495; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYgdPMlc+2aRTKXPTL3Ml+ht31aWmoLKwZAjZCjHKPE=;
 b=Sw34QFu/u+IPswb3K8YM3siQi8RGGHF4iWxuzoRZLKf/0jNENYWozEn1UzlLTQ7ZVp
 exWtxWlH1Bq4Qy6k7Et2LFMgrR+HwNBDzk04LT2CAAneIn7n3SrmlDEFqiCpCw4xPY3J
 2oUtTJPmhDNKtz5YygC3oj3wpLTeFkUT+B4fb+d8NnPbVv37RpnubTYk3qkEczt12Ub8
 ctJuE/LuGbqkYVC/VBkRnLIGc3yTnxPMNFfgLDwe/cNXFaMQBYbC8c3rB+08I6jhpcaH
 nlhh2B2OXJjdHqd90U9MkhA20nLZfj3uCPUoqGh+FoilVkXu2p2EJvB4hPbGBaHYnI1Z
 vLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625695; x=1770230495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYgdPMlc+2aRTKXPTL3Ml+ht31aWmoLKwZAjZCjHKPE=;
 b=RnfYgG6Jsd7S/NSozURS0ltS33kob6tYmpbeXh8IfCzgeI41BVY9Oj57sKPRy+w3Gs
 HFlpezOvFRIWpfD5KODQ+FLgXytpVTjFP6MJl2muCl1x/YdA+bFs5gT+z6eYbeOtPuNF
 hs9zLPai5NQPHAW7yDdeXJ2mMxGBXZNwgUB6IiuaO9CSyP+CrGxCfvkZWMZ/MIcsV0z0
 mvBhui2IujTHBIOtcAtArWIbtMHqz+BWCf7anNLsdm8mNZ4TJ8TjyAWM09N9je5J9lpu
 FEOfspfm1koyyhd4xCmfNQ9mD4QRgI8PCPrJtIUsa96FxszCiS2GKDK/Z3T/r4fRkTzV
 sY8g==
X-Gm-Message-State: AOJu0Yw9Ml1lO829g9ImWqlnPtDj5ChUmCG3e0nWHYCvxRGeH5qnArnp
 SC+gA40J2mA2B8PcTBEEV4xqP7ulT+7+UIemO1zrdEN5tc5rnOOYTE/NNB9WSGym8GZsaHvHR2R
 KslXG
X-Gm-Gg: AZuq6aJDYzxZkio3PKwVXaQMvR8ookWUHIHPm1yBtICUwHgNsQpiZe/VfDDjwSrkN1N
 E1rXMenoraVztAh3qILgD+wh7YDNDR6hGIBK3tKZcnDuCN+clX/jswgLftr+tQWJVbvQH6bimrM
 1SBezqdYFOcVPGxKyDrOPtrf/CTkY7GzclzKsbZq32TOdxz9dI73VVYMS2m4pV+z2jt1h8+P8PN
 +zqSmYsJ9s4haXyWYjmtAtI2GQcXEiLMfJRmHjVCz47g86dQdZ00HOe/h3qLiw1L6xoPLnZj2l/
 KrINBAOv3SMCEja2ALPLfQ2iBwuDzimt8wr4ooxBDumVj8NhqhC7Jfvp4pF1B3LM4ck698EB05x
 igJumk56Y1RpQlefRHqxu+yJMbkn9m73Qoxkor/ha0s4RpFBZ3IlyVZUcO6pb+jSJN/GFxc9Ru4
 dtEct93oRWXz/h/LWtWFWOssqVeXQeQr1x++IgWc0CVXF5aFuaUElNMbO1YR6N
X-Received: by 2002:a7b:c302:0:b0:47e:e97e:11aa with SMTP id
 5b1f17b1804b1-480828745f3mr4311755e9.4.1769625694981; 
 Wed, 28 Jan 2026 10:41:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:34 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v9 00/15] net/pcap: improvements and test suite
Date: Wed, 28 Jan 2026 10:40:29 -0800
Message-ID: <20260128184130.445567-1-stephen@networkplumber.org>
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
  - Configurable snapshot length via snapshot_len devarg

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
  - Defer pcap handle opening until device start

Testing:
  - Add comprehensive unit test suite covering basic operations,
    timestamps, jumbo frames, VLAN handling, multi-queue, and more

v9:
  - Add configurable snapshot length parameter (snapshot_len devarg)
  - Defer opening of pcap files and interfaces until eth_dev_start()
    instead of during probe, passing configured snapshot length

v8:
  - Fix pcap header length in VLAN transmit
  - Fix clang warnings from ethtool link_mode array

v7:
  - Drop MTU configuration patch; not necessary as underlying OS
    commands (ip link, ifconfig) can be used directly
  - Add patch to remove unnecessary volatile on queue statistics
  - Add test_link_status to unit test suite
  - Add Acked-by from Marat Khalili on patch 11

Stephen Hemminger (15):
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
  net/pcap: add snapshot length devarg

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 2525 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    8 +
 doc/guides/nics/pcap_ring.rst          |   17 +
 doc/guides/rel_notes/release_26_03.rst |   10 +
 drivers/net/pcap/pcap_ethdev.c         |  608 ++++--
 drivers/net/pcap/pcap_osdep.h          |   23 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |  289 ++-
 drivers/net/pcap/pcap_osdep_linux.c    |  115 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 11 files changed, 3468 insertions(+), 225 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

