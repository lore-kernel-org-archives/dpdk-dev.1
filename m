Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50349EEA84E
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 17:03:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B174402C1;
	Fri, 13 Feb 2026 18:03:40 +0100 (CET)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49]) by mails.dpdk.org (Postfix) with ESMTP id 92C52402B2
 for <dev@dpdk.org>; Fri, 13 Feb 2026 18:03:38 +0100 (CET)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4836f363d0dso9554725e9.3
 for <dev@dpdk.org>; Fri, 13 Feb 2026 09:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771002218;
 x=1771607018; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C54sI/zsISuVmwGX5+9vd+PVHLC9GS4J79nQCa9sLWM=;
 b=EVcOaetVPRROGWeRUxMKPRlG/WPfEixWyuKRgJa/po4Ux41NbAHQEy9kAtg/U3PE4f
 bkoKDT3b4aT77fnBq7wkuI+28w7q+v7cJQcATgaViaKx5K5IDjN9KuERJPzzJTclWy3U
 bIDoCPd99+YDTDmP2llvzZSx17SpN+IqfpIBXIDNnTDBdqedR/dcFYRKnnJWC/qHyXEu
 HayrB5WnAKvGGwIvadH/ktNdcifrzxoxZGsrf2t8VI76J10Us7he/EY4APQLgH4tZvCD
 3OX9sqlRthwYWXwAtWRU2+XQ8x15zR1WUo5fU6jqJ3OUrJyPb5axX5RflQq0o7m/kPtz
 oAXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771002218; x=1771607018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C54sI/zsISuVmwGX5+9vd+PVHLC9GS4J79nQCa9sLWM=;
 b=CEpjX3HLocnAfUQm9tfv24mhCgW0nUiv/tRdzuz7I1POzrSI1YVvFFJKtvJYWdcnCd
 VzKVHeNVzXqi6Y4d/7bdUH1lWuyHOvc6QtU2h3M3L02rX4HjymG2hxra1OYZXaJiyR1+
 9v7DS4yC0ZWQudVEJDOzLNdIceugm8zuJuFJIAgmjP5yybyChRPHaNsCY2ZhZ3IX/cu/
 TTKCnQJ2KOxxF14M3+Xp0sCJTda/d8sxKk5ENii6bib/zD9MwxCgP02W8sIdaaUAbLsT
 6zaWpZAdPglWkPut+QhJ8LrgJ1sSpgLh+IpsENZc/oE/vC5q7/E71saOsOgnABZUAz7I
 a2xA==
X-Gm-Message-State: AOJu0YxC1RJzes9X8SXg89bpUx8sZlv5gM9LpvRiCvDFvcirrgcQzpo8
 0kiTJS7/0pPTJMX+JoVt9PDA36gWMCGxiBKht8VhibiZoZH/32AoFMFdvYQ5czGqlCGdp5pQOje
 fU4qq
X-Gm-Gg: AZuq6aIGcigmKv5b1zVikUOFUL7CH+nRppnYemT1HkvC8/Nc25a2YavoIsPWdecPjRl
 Wv+gisOdpoBkqoFb4VPzcUJOaMiy+CqSTDX69nFk3VvhEq3Tup8Oi7ErfOS/ZQd3ruiS5DVSpIN
 E6+XI++ViYaN5vW2PZcYIWefFK37JirtmY9/biaXWGhme+Dfn9oSWs4iZrs5aDi4DmugYaNeWNj
 FyqUCVWTQJMbrnL9kCJ40RzNXXlb1VLn90ynaeInDe8tEIBFrn+5uIyOH3X2yKVRFUp40T2uAqV
 VgDz2VCXkC+I3tJ3Oh9GHBc2DGjWRlpv8LvZtusd9UIuyLn3VQB1El9dPtbS7DGj7Vem279XtPr
 S8x+i/xrToczzb0Fg84c7g1uNQgRZ0fUTT1ro79pFPtLlNZb+QF96UCnn6kN0eLF9OwwgTIngcZ
 gSFK0gSv+n7dTzCAUS0sN9dP8nRV/vSjTXslL8Y5tRLSHs2Tk+Z8GlRchsV371Aw==
X-Received: by 2002:a05:600c:1909:b0:480:1c10:5633 with SMTP id
 5b1f17b1804b1-48373a745aemr38995375e9.26.1771002217913; 
 Fri, 13 Feb 2026 09:03:37 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483740be167sm40963035e9.15.2026.02.13.09.03.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Feb 2026 09:03:37 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v15 00/18] net/pcap: improvements and test suite
Date: Fri, 13 Feb 2026 09:01:23 -0800
Message-ID: <20260213170333.40089-1-stephen@networkplumber.org>
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
  - Link status change (LSC) interrupt support in interface mode
  - EOF notification via link status change for rx_pcap mode
  - Support for Windows interface mode
  - Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS capability
  - Configurable snapshot length via snaplen devarg

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

v15:
  - Fix "Perodic" typo in LSC alarm comment
  - Fix missing space after comma in rte_eal_alarm_set() call
  - Use eth_link_update() instead of direct dev_link.link_status
    write in EOF rx path for proper atomic link status update
  - Add detailed comment block to eth_pcap_tx() documenting
    PF_PACKET backpressure semantics and tx_burst return convention
  - Add PMD_TX_LOG/PMD_RX_LOG conditional debug logging macros
    gated by RTE_ETHDEV_DEBUG_TX/RTE_ETHDEV_DEBUG_RX

v14:
  - Add LSC interrupt support for iface mode using alarm-based polling
  - Add EOF devarg for rx_pcap mode: signals end-of-file via link
    down and LSC event (mutually exclusive with infinite_rx)
  - Fix mbuf leak in eth_pcap_tx() when dropping oversized
    multi-segment packets (missing rte_pktmbuf_free before continue)
  - Fix rte_pktmbuf_read() NULL path falling through to success
    counters (num_tx/tx_bytes now inside else branch only)
  - Fix VLAN insert for indirect/shared mbufs: use rte_pktmbuf_adj()
    to advance data_off, preventing duplicated Ethernet header in
    the mbuf chain

v13:
  - Fix VLAN insert to pass mbuf by reference so caller sees
    updated pointer after indirect mbuf handling
  - Fix VLAN insert error path to not free mbuf (let bulk free
    handle it, avoiding double-free)
  - Fix handling of pcap_sendpacket() errors
  - Fix theoretical format string overflows in test suite


Stephen Hemminger (18):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: rework transmit burst handling
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN strip and insert offloads
  net/pcap: add link state and speed for interface mode
  net/pcap: support nanosecond timestamp precision
  net/pcap: reject non-Ethernet interfaces
  net/pcap: reduce scope of file-level variables
  net/pcap: avoid use of volatile
  net/pcap: clarify maximum received packet
  net/pcap: add snapshot length devarg
  net/pcap: add link status change support for iface mode
  net/pcap: add EOF notification via link status change
  test: add comprehensive test suite for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 3422 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/nics/pcap.rst               |   41 +
 doc/guides/rel_notes/release_26_03.rst |   12 +
 drivers/net/pcap/pcap_ethdev.c         |  921 +++++--
 drivers/net/pcap/pcap_osdep.h          |   39 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   98 +-
 drivers/net/pcap/pcap_osdep_linux.c    |  124 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 11 files changed, 4525 insertions(+), 239 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

