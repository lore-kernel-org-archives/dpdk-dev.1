Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E719F43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:48:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 195304064A;
	Wed, 15 Apr 2026 16:48:10 +0200 (CEST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com
 [209.85.167.178])
 by mails.dpdk.org (Postfix) with ESMTP id A18FF40611
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:08 +0200 (CEST)
Received: by mail-oi1-f178.google.com with SMTP id
 5614622812f47-47018d341f8so4506683b6e.3
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264488;
 x=1776869288; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ppCUyZ5qAp41FJcQuS+FXJjg348TLi5byl+s+q+a08=;
 b=VZMq9FkjPErlaHcQsZZts+brP0Jpb9JjDfBMX3EGb+adz1RNDknBt2OWKv9bpsE8ni
 UHfFNWwQRzP/rNTAfsPdySoTFQcjZlwhLB7Ge2bDKYXR2xVy0G6jnu3xkVlmPNl1ti+n
 V/D1fV17wuSbZyOktNpuSlRitJny88fg27FNzRQfRaQoviM+3I3MlqdM21/LOvYbiynf
 8TKMGjWvh6gI+MTZUYtDmunISzn10MoDX+wdpADDYy5ipm3eW8OXH/YAASB3cOxGcCi5
 l9nDhmgUTTtDV0YlrudJLrnZfjaPquF7OsK5x2AswfkXlyxXp5M88qux7PqjMk0bRYzS
 U5FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264488; x=1776869288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7ppCUyZ5qAp41FJcQuS+FXJjg348TLi5byl+s+q+a08=;
 b=GSiOCIE9H96RH73JO/E7kidnmQrXD1Rb232dPmSUWaY/eWqicHdcz553XxaZEIjn1q
 8IIpaQuve38WZhh6nwovUmY5i/9C2PJtKP/Ki+dYG4qmmUZrPmK/0p0bAGMRXDYnxI3S
 RiyvpIaQd1ICOKkheDClUE2I0Ehp9XsnTMJlkSVT2dzCeKpJeDZt/M2UsYrQwRkyZabi
 r69Wpq+IWINJJZShrtHT5FtqBNGBk4prCxt0n1Pr1+XGXKOOFBSJYVrsiBghPEWr5m4a
 Lt72TcN8Co+ArEBlBVYyzjJXcgiC+IiwBXmGwwP84TWaqA7MwGW5Nl/nvk/oLMGc4FBc
 HhXg==
X-Gm-Message-State: AOJu0Ywa85o7Nyr0g/BDZlTzr8egX9/mUhimn/e+wu3ypW8Fd/1v3cqu
 qgsVQzVGwYQk7UtZ1lmwMV79B/fgg0/+LjkM7vTH2TZfQBUCNsH/5ym3R/0+/6ldvZqUqteb7kl
 1kuWG
X-Gm-Gg: AeBDietex5ELhY5enyyZ9oGD5ZC5jn33dV0ScUdqAGhnXe5w/8DVt2Ax0954uNN9HR8
 I+JqmGZOZkyMUEH9hDblE7Wx1Mpgn7fWY8/nYOy1d5/h1DTjvkMF3nNNAdPUnOmVh7trgWVKR8X
 CfzSdVK6tB95Gts0bhpYoiFE+ReHY4bfvm3SiVlzI+J95xPpoIcfkadeJyp2zunYKrOrv92oH0l
 WRrcyEAo2Km4jCH+2fv5IxlOmMAW6vTXtCsaJf9ZGtrmzUeXzX1/WTpukzMNKG15BlDqOxMlpi0
 jCNxsKOQSvV+XzF0k/AqyYF2xISWXMASaL3YPPZ2EzxqRkhtiUDAgM1p3BwukuOJ0JICCTXKAFR
 u0H/+wObZDAPPRnJS57TZAs+NM8AC6TyPDkyxHb8eSAEl8v64CjF/ZZaRHE1ZmdDeWBjpeiR8rq
 mkN59v2hihXC/zP3jkpjqJ3+TdPwHiMobg8ofReNfEgZg=
X-Received: by 2002:a05:6808:518e:b0:467:1f38:bc19 with SMTP id
 5614622812f47-4789d94ddadmr10231481b6e.9.1776264487722; 
 Wed, 15 Apr 2026 07:48:07 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v23 00/24] net/pcap: fixes, test and enhancements
Date: Wed, 15 Apr 2026 07:45:49 -0700
Message-ID: <20260415144717.226161-1-stephen@networkplumber.org>
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

v23 - fix ASAN bugs in test code

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

