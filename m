Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77F2E83820
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 18:14:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 314E840296;
	Mon, 16 Feb 2026 19:14:13 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 14D8740289
 for <dev@dpdk.org>; Mon, 16 Feb 2026 19:14:11 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-43767807da6so2420001f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 10:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771265651;
 x=1771870451; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RbhXRg54+P49C0DNVRNSUPvUE+D/k4esNl9A7aki7/Y=;
 b=igPGuI7hXE9B9qTEsxCKRj3joDD9OHuPo4MGiYAOx5DNzndtRzYVou+7QHuud/NtP1
 oRuq+lzJzfuZ/+/wFo42OUyuDRJvLWXHQCwcIlHUXR7roc3/we+CyZR7KmkVHJ56EFi0
 FuSayJFeVS81zrQM5FQdOZQPg0KKS36D3xOK5wSqooTYgyKs4PNcwf51awQudZ0koX9Z
 +iU3yOeuVxFQwnC0ZTldRw6t+qatjxpleZUuAK75V9lJyoeCjlQWfFGyNO2P12TBn750
 EtJvkXKklWT3T/OkpR3ts8dGZ9yEEBgTK6eL+ykeZfStSwav/MXXSWeZihP9s5N/f1B6
 7JjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771265651; x=1771870451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RbhXRg54+P49C0DNVRNSUPvUE+D/k4esNl9A7aki7/Y=;
 b=a+skTXEBsyjTRXBd4k5d1aD15G9GJ5SKhb5Hqtk1nRyk2zG+T3sLXhRJAbW4b4Szec
 Kgsqv8XkRafyki7Oj+umO1Wf4UiucoUxPmtdBPqULHYilhHrbDfm8l9mDLDYDRLfyQrw
 dP+GXsOyiPQPZE88nZx/FXEniiGpDBiEQWYiIEceNEMxfHpQzAZCberoB6YRbRmVMhsk
 vaZS+6qjis6oguYfRSPEpjtjq1yHxJsj9nY1xRmE3b1xvuDccKK4RHFv69uD93lV2l0u
 VHsT8OlurQ8tqGYQVwCgLxDrd5K6WEbrwkYKs8G9oDCjglc7NCM4R8v0csxBbSaNBzJp
 8uxA==
X-Gm-Message-State: AOJu0Yw5OvWVQsIg4seXIjmUtmIkIuIyhw6/u1zxIM/r6sMQ1fq3104t
 4MzwZyLUf3jXuyKagFq7MF9hdepQ6iTSpgOvt+zRozxmDREHvjXALgkf0sZaHeHHNPN1fIq4iZr
 mFGKS2fc=
X-Gm-Gg: AZuq6aKOEo0rGuzVug3VKT6y8hrzLJ9drKNCl5EjB8HYZ1SV/+kvhFbSkU7R0C6CcQp
 AVFEdYXYqE/qu2Z7Ans79AYoy/x5j2RTnPwuV1zid//KjVVcX1+go9bBLSxsxrb8L4wtAx/FoUu
 9HIqhr/xkoLUXtTZ3ahVCA5dN6O2r0SRmwyzct1acwntFxv0G6eiJBSOR+YCtzmiGh6GmSiR1BX
 5HUqyV660rLnAcoJHP8xiOZyHtk0btMftGflAHWJ7bT74WYeDwGbtA1kDmf1Eifbs+WsluWx1xW
 rxOerob5GI8jflHh7qr16FiNXITl/1nhf1HjYDTFNM/z6TWHH+AdFAOOBXz3Q9Sn6qttscv55EC
 G6h17+lg2lfQnPmv3niO4XUXz/XYMW39B9+ffBlq8Pp9g7yWzPSKuT+GhWpRnlp6WMItjr4F6d0
 BVnOcvF1l4pXAPyFGjIZTjFvoKCsEvR6/t+MAl+Dwps6MOWORV0Md+c7viVcr16g==
X-Received: by 2002:a05:6000:24c4:b0:435:94dc:8c78 with SMTP id
 ffacd0b85a97d-4379790e785mr19869151f8f.40.1771265651427; 
 Mon, 16 Feb 2026 10:14:11 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796acffcesm26064725f8f.37.2026.02.16.10.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:14:11 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v16 00/21] net/pcap: improvements and test suite
Date: Mon, 16 Feb 2026 10:11:55 -0800
Message-ID: <20260216181407.428877-1-stephen@networkplumber.org>
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

v16:
  - Split up the patches around transmit logic

Stephen Hemminger (21):
  maintainers: update for pcap driver
  doc: update features for PCAP PMD
  net/pcap: include used headers
  net/pcap: remove unnecessary casts
  net/pcap: avoid using rte_malloc and rte_memcpy
  net/pcap: advertise Tx multi segment
  net/pcap: replace stack bounce buffer with per-queue allocation
  net/pcap: fix error accounting and backpressure on transmit
  net/pcap: add datapath debug logging
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
 doc/guides/rel_notes/release_26_03.rst |   13 +
 drivers/net/pcap/pcap_ethdev.c         |  923 +++++--
 drivers/net/pcap/pcap_osdep.h          |   39 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   98 +-
 drivers/net/pcap/pcap_osdep_linux.c    |  124 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   95 +-
 11 files changed, 4529 insertions(+), 238 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

