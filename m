Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1FE2FCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:49:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF1CA4065E;
	Tue, 10 Mar 2026 03:49:30 +0100 (CET)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48]) by mails.dpdk.org (Postfix) with ESMTP id 930D64014F
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:29 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7d75d698ee6so98744a34.3
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110968;
 x=1773715768; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nqHBK611c2GoXfTEGmSUJzW+a+pUzrp5tgE83vpmLVo=;
 b=0Y/78fRXAocowumvlZOipgTdR4UAQkBZU7C56K4vsxuX1B7M3T35SJ1urd/yAIHfvt
 RjhFHpXtxZPakjeVLj9CyI4Pocl8CgCDVN2b7ST8JdTeCxR6rB36dYszY0jUTFtNrev0
 uPt3OgFqHG6PrA3eoMjV6KKYTY7azWkTf8TO/ARCRJkIKTQzzQbB7GBPN2cCpRLe5ykc
 M00DbrdrLe7njo6Uen/KfIOvfNmIx65zZ6haq7VSvl9lzmY2lipfZM8dUkN8LbACCgC7
 gc/E+ycztWqnOyU4KqINqxzKw3QKsgPQNwS2IdYadUXw9E1+sKi4W8Zsx8mkwueTGtRR
 TfqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110968; x=1773715768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nqHBK611c2GoXfTEGmSUJzW+a+pUzrp5tgE83vpmLVo=;
 b=uRdQmIzWqAjR1py1+mc0UqOspUXHXh0o6TaSiuafGr7O7Jkocn6suxwEtWWkCO47Mj
 gxVJ/0NQlob4CiCsxwrdAIfNOZ3v1EINlOItICBLmCmnwSfc4ybxQmfbVWBrBi/WvyQH
 TW5pFAKIxvNiVtJZw87XZT+b7ZMbH6LgYlQ6lGx65g35OhI+6bLNEAjlQLwge3os+P1Q
 YimyZXWdAlyvZVkSGLena0AvP9Sy2jkM0BOefhIgckL9mFbydb2Z7l1eUIx15gCiKbDg
 nzt8Kaa2CLiy96y+Nm89jBSQ+/54TaXNE4e1TQQZYQGqclLfJEyWVl2O144Ye53s7d0C
 IiqA==
X-Gm-Message-State: AOJu0YwecC4sDcd9/C6KkypYnfQn9qrygZaENJMCp/Q7WXxvG1LbOLfC
 ujGItkFbx4QrQYpUV4dYtM3QFgaqGq2SnxdH4X+dQJThLmsdjyBM/UVBoJTzEhIzx6gtg8CBjBV
 bl1MF4sA=
X-Gm-Gg: ATEYQzz7NENsQdjAsLsl2DkY7w5ceBlKwpJNUQHIecbThExW4sO6uFlR0pe6XrcGhvZ
 N6MEDCYJEFLUOm0PNb6hO8kwsEOt5yh3LaL8wzaEUCAXnbk6fponPB0wtqxTxs55L/BR22ixQxZ
 /HRsgNRNXAJBodI6GS7FrnHXTSmL1gB+oknb3GwVmi2+pqW+BwT7dh46WVxDFcEMHBSl+SN0r+2
 gVG6+TbdtzvIbR4yl9IfrkJX5NuxPLRJrmtZRuYgKZxwlOA2N61ncNda9ZMd3Ecxp0wxryOmR7g
 6+E8hgVEbbxMdQdLLRZqUiCyx8Mt1HndyTX7luA1yPmdE6l7x0Fy96+xO1gKDqgECpOt9VTsVGi
 OcJoicnRRZ6ru7Fs/6KNgrGXGDHZW/B33laNMkcGNhgviX4NKhRVmncu56nyXysvffN2bq7y7fR
 MtyiOmPy8ex/WnK1FvFZf+wB5EQon9HQlE
X-Received: by 2002:a05:6830:81ca:b0:7d7:55c2:d772 with SMTP id
 46e09a7af769-7d755c2db56mr1554715a34.4.1773110968441; 
 Mon, 09 Mar 2026 19:49:28 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 00/24] net/pcap: fixes, test, and enhancements
Date: Mon,  9 Mar 2026 19:47:35 -0700
Message-ID: <20260310024925.476543-1-stephen@networkplumber.org>
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

v19:
  - Restore Rx scatter offload patch
  - minor fix to tx_burst

v18:
  - Move VLAN insert from tx burst path to tx_prepare callback,
    consistent with virtio and af_packet driver patterns
  - Simplify link status patch to just report UP/DOWN state;
    remove speed and duplex querying that had cross-platform
    portability issues (FreeBSD ifmedia_baudrate not available
    in userspace, Windows GetIfEntry2 linking issues)
  - Fix test_vlan_insert_tx to call rte_eth_tx_prepare() before
    rte_eth_tx_burst() to match the new tx_prepare VLAN insert
    implementation

Stephen Hemminger (24):
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
  check patch warn in test

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
 13 files changed, 4643 insertions(+), 221 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

