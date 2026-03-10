Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D83FD4F03
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:14:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03517402DC;
	Tue, 10 Mar 2026 17:14:04 +0100 (CET)
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by mails.dpdk.org (Postfix) with ESMTP id 3339A402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:02 +0100 (CET)
Received: by mail-oi1-f177.google.com with SMTP id
 5614622812f47-4670676ba03so887157b6e.1
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159241;
 x=1773764041; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bT3/QhfJOu3T1tXKPTkEIRDizp+md9jJsBzYEzYJ9+U=;
 b=TXjxV8L4iH/p2b4Wv+kJGCAWnzOUNdy08R5YQJmfOthfDDoZYk2uRqLjy3lu4N2f61
 hIKWrnfq/+sMiRI1y/AMNLTtuXQ6DZ22EKeCSwwWsubXkRarIpOJfqxB5sckpJ/TCcKX
 G4ZqlQp7p8PYGj6mhthgR2C3hLsLUe2CYWUNc9JsX6R3tMWtSkhA/NVvEC5dogeDaWwG
 nswx1Lw9Acz+A6vdBCkmBfcJQ/4MRJpcP62rru7HAEP1D1IThBOz8ieF5eA/dhcQTApl
 /DoW6MWrWf0RPH3I5AjZjz/8D3rlUPyxExOdFfknlBeGP6OCfduPRbEmy5NuXHrCyiS5
 v2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159241; x=1773764041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bT3/QhfJOu3T1tXKPTkEIRDizp+md9jJsBzYEzYJ9+U=;
 b=Cmr/G9QgoSHgnKBME+TX0Gd/9eY2MkOQMSoXy1rWZzHjsfzNQz3XvxreVHM0sNvscy
 2Yn8qHUcfICxOh2oAm7mQX1ANgyB1l4BBt8ZmXE/bcioNhXp+7PsJML3QBXkcTC7xiZX
 1qzz2o5tBw7o4EdxcWEg5CBgOwzF6vHN0K7m22j33FJgeLVMpkHHXjfNYpcjz85beS5Z
 XJbFs3PKhSbqUtgyTXzG4ZdErqJTloycr/M+x0IxLNM7SOn8V2DGIKsRfMR2liMlEWsC
 0s/Lex5AtGmPpnu2IZKQtJ+M4PRj0xoft+7f3eeoFg2rzfqEVoxY66mJWue4Sbno+xdU
 IqXA==
X-Gm-Message-State: AOJu0Yz5K7Y+fNXj2/u2n0tkFubIOI7ShORwq36XKyR4sj76PQ3RzLhK
 l+UM/l/w0mm8AuoqLGmuHZsujOvfCT8e+g+a6+2iTDrKr7dxh7eEa7Hpk7bNbryfRCsGBrjjKaL
 3z4T+FzM=
X-Gm-Gg: ATEYQzxoLHnTYq0d8ESOte4ZnGrHQAMwID/WnfPUXr1Cd0+Xovn8TY2cVM90wsSh3LI
 INeHiZC7nzzznvmYY16oFyCKz6NFtRM272EQ2YDcXYbwYamTfU1C8WTgUBcYLWaXuHdJyBsm76z
 6KVRQiwVjYlmhZ6NJtUDL8BVlGyePbiX+NDseNDq8cxMh5WHAI+zogbVoO1U09hrnbxnIdWextj
 CZMV3LScksKgVZdapxfilEGdbv8Q5MXAWEDnKhwT1NsuIsWMmrxjv52+HufquuPkzZdnvKqE+TD
 5co1AygmF+dXdIYMcRbHZHnb9to/UM/pz3RmGrD/nKfPVYQyD89dlRwmzG8BTMVKjt0qjasjmD9
 048++aCdVy832gzgrX2D+3/lYbaWjDV//GsWrjKLwb9Aq8fKROF8RMVEjCScNXOM8giRlxZLWfP
 z3B5EawtkjBWFAbVf28GuhHktM7uT0xSNj
X-Received: by 2002:a05:6808:c3ed:b0:467:2dc5:f4c7 with SMTP id
 5614622812f47-4672dc61b0bmr192641b6e.30.1773159241018; 
 Tue, 10 Mar 2026 09:14:01 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 00/25] net/pcap: fixes, test, and enhancements
Date: Tue, 10 Mar 2026 09:09:38 -0700
Message-ID: <20260310161356.194553-1-stephen@networkplumber.org>
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
  - VLAN tag insertion on Tx (via tx_prepare) and stripping on Rx
  - Runtime VLAN offload configuration via vlan_offload_set callback
  - Nanosecond precision timestamps (when libpcap supports it)
  - Link state reporting in interface mode
  - Link status change (LSC) interrupt support in interface mode
  - EOF notification via link status change for rx_pcap mode
  - Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS capability
  - Configurable snapshot length via snaplen devarg
  - Rx scatter offload support with mbuf pool validation

Bug fixes:
  - Fix build on Windows from RTE_LOG_LINE changes.
  - Fix multi-segment transmit to dynamically allocate instead of
    silently truncating packets larger than 9K stack buffer
  - Fix Tx burst error handling: distinguish malformed mbufs (counted
    as errors) from pcap_sendpacket backpressure (break and retry)
  - Reject non-Ethernet interfaces to prevent malformed packets
    and kernel warnings on FreeBSD/macOS loopback
  - Fix infinite_rx ring fill applying VLAN strip and timestamp
    offloads to template packets, preventing those offloads from
    working correctly during packet delivery
  - Preserve VLAN tags in dpdk-pdump captures by converting
    stripped VLAN metadata to Tx insert requests and calling
    rte_eth_tx_prepare() on the pcap vdev

Code cleanup:
  - Convert internal flags from int to bool
  - Remove unnecessary casts of void* from rte_zmalloc
  - Replace rte_malloc/rte_memcpy with libc equivalents in osdep code
  - Include headers explicitly rather than relying on indirect includes
  - Remove unnecessary volatile qualifier on statistics
  - Reduce scope of file-level variables

Testing:
  - Add comprehensive unit test suite covering basic file I/O,
    timestamps, jumbo frames, VLAN strip/insert, multi-queue,
    scatter receive, snaplen, EOF notification, and link status
  - Test discovers network interfaces using pcap_findalldevs API
    for portable interface enumeration across Linux, FreeBSD, macOS,
    and Windows
  - Tests use packet_burst_generator for standardized test packet
    creation

v20:
  - Add dpdk-pdump VLAN tag preservation patch

v19:
  - Restore Rx scatter offload patch that was inadvertently
    dropped in v18

Stephen Hemminger (25):
  maintainers: update for pcap driver
  net/pcap: fix build on Windows
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: advertise Tx multi segment
  net/pcap: replace stack bounce buffer
  net/pcap: fix error accounting and backpressure on transmit
  net/pcap: add datapath debug logging
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN strip and insert offloads
  net/pcap: add link status for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reject non-Ethernet interfaces
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  net/pcap: clarify maximum received packet
  eal/windows: add wrapper for access function
  net/pcap: add snapshot length devarg
  net/pcap: add Rx scatter offload
  net/pcap: add link status change support for iface mode
  net/pcap: add EOF notification via link status change
  test: add comprehensive test suite for pcap PMD
  app/pdump: preserve VLAN tags in captured packets

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 3755 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/nics/pcap.rst               |   48 +
 doc/guides/rel_notes/release_26_03.rst |   12 +
 drivers/net/pcap/pcap_ethdev.c         |  850 ++++--
 drivers/net/pcap/pcap_osdep.h          |   27 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   43 +-
 drivers/net/pcap/pcap_osdep_linux.c    |   33 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   76 +-
 lib/eal/windows/include/rte_os_shim.h  |    1 +
 lib/eal/windows/include/unistd.h       |    7 +
 lib/pdump/rte_pdump.c                  |   32 +-
 14 files changed, 4674 insertions(+), 222 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

