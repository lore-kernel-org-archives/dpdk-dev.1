Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D982DF8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:47:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A53A402B0;
	Thu, 16 Apr 2026 20:47:38 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id CD43840297
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:47:36 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-2d832f2f44cso6050447eec.0
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365256;
 x=1776970056; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X1CTf1GI7/itNBS+nl1HeqxbRqr8bzEpaqVDXJ4uatQ=;
 b=HAMzS6ch58ab8Prsf/a8lSARNNVjhBLopzjwq1ConnrzHa1iYW5sihoFeq3jD9B18c
 nVHHRQly7VuID7FJKXkqfSqN1q6P1MjaOOyiWsPJ5GX4ssIHIqPisLveQaYX+Hf++p41
 GStJi5PLL3GY+ocvzxS+aRPxuHX+inVSGvXTwPzidtt0PQV66eml4XJSny7HWUBA30/k
 jzuduvcOzH5r2brVpNU7rAU3/pFbJ0U4YNfG3DYEvN+1cqFnT9qq+iwD3we/7K/fy6Fe
 vnM4DMLODFxaJkHOk2iQx7NlRspqjrJ0KB9Nz56JxqYRSzyDGTJejy0B1b5e3JZ82f/y
 L2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365256; x=1776970056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=X1CTf1GI7/itNBS+nl1HeqxbRqr8bzEpaqVDXJ4uatQ=;
 b=Ft4ExKYIZ/Dii0hCpBzyixnKRiyFQ0DJ9HaliBrpG4JF4oGtBqoSM84cyto5ihDQSi
 6NKkrI2MS689d5hvoS01s3jt8gMqE4JEZO+ywx00bK4qhknCibvoj0dLMLL06HFuIqkB
 1Gxp8vxI07+XXHHd+c2NbXDslC6K8Np7sxA7g6CLdGLJt+CCLeSXaHN3/JkX3jsdyaNI
 V2AT2m5tbA4KYSshqX4JhBDATAnlpjmFGY45XF9ACmFa7mlDD8bHqJdqah3kGp9YBfuR
 pC9fKHF1sfMareK0VfjnSrE2qQuQcGaN6qauYfxrrsEWCKv7CGAZbpZIz9djy2IJLwv2
 ucCQ==
X-Gm-Message-State: AOJu0YySIAwIayZinWQ9Y5HslZU9ZKJZHckDtdjlUkkQo/XnyLjN/2Dq
 BWFUEmzPxZFwcb/bmNRLyTpyLZfCgJIfiDPOlPBss0DrMpHSrdDXw8HwUaAKxmZhKG2Pw9xOaYs
 VVjn0
X-Gm-Gg: AeBDiesSmFt5k9ricEpUeWTGTc7vpE7lmXXJqcMGrgc4/uK61ktsYlsoGLCB5l4ZuDv
 SH2IU2yYxwflzjs3apYrHf4kvDu/xBP5pbwElep8Z/BUC2N7wMVO7paqTSpayo6jRVauG702kwj
 IRNR2XqzLGYs8mKUaM0C/mowpnB6KoI8a0y5ix/NzcM+TOEvQI6WRfsAVYNMXs+CtrGAMrGYHjj
 TM0+P/wc5+XhF7mWrEZgOhixOuNEgORbrtbHNWg/MqztkkmN0Elila7t1ovGJzUyeiEaEU9935o
 TR8N3xLVh3Shtn2WTUWaUeJcn5/S+pJGSlbN4bI9Xzqjy/yf3hJpYD4G+nMShQMmPmKWI9SKpBa
 opcCaCuP/lsLoOaspV/vygEgtC2h1+9T5LtuS3zoA+OU8+xMrQIQzvSkczNWobSzbcR9rMfHJFc
 FlRWcicbel8k3p4P11Jf9ysm4IIskDeZyEe/a0iVkkDxY=
X-Received: by 2002:a05:7301:607:b0:2dd:649d:750c with SMTP id
 5a478bee46e88-2e2e35842femr274934eec.9.1776365255585; 
 Thu, 16 Apr 2026 11:47:35 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8c606222sm10741314eec.8.2026.04.16.11.47.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:47:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v24 00/24] net/pcap: fixes, test and enhancements
Date: Thu, 16 Apr 2026 11:45:22 -0700
Message-ID: <20260416184731.1347342-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

v24 - fix format string in test.

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
  net/pcap: clean up TX dumper return value and types
  net/pcap: add datapath debug logging
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN strip and insert offloads
  net/pcap: add link status for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reject non-Ethernet interfaces
  net/pcap: reduce scope of file-level variables
  net/pcap: clarify maximum received packet
  eal/windows: add wrapper for access function
  net/pcap: add snapshot length devarg
  net/pcap: add Rx scatter offload
  net/pcap: add link status change support for iface mode
  net/pcap: add EOF notification via link status change
  test: add comprehensive test suite for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 3452 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/nics/pcap.rst               |   47 +
 doc/guides/rel_notes/release_26_07.rst |   12 +
 drivers/net/pcap/pcap_ethdev.c         |  859 ++++--
 drivers/net/pcap/pcap_osdep.h          |   27 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   43 +-
 drivers/net/pcap/pcap_osdep_linux.c    |   33 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   76 +-
 lib/eal/windows/include/rte_os_shim.h  |    1 +
 lib/eal/windows/include/unistd.h       |    7 +
 13 files changed, 4354 insertions(+), 215 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.53.0

