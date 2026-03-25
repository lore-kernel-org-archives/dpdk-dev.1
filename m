Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22CC103A99F
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:40:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5442D402AA;
	Wed, 25 Mar 2026 03:40:24 +0100 (CET)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id 299AD4027A
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:22 +0100 (CET)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12732165d1eso2751411c88.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406421;
 x=1775011221; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fssya5SR8wqnNMnCvNmlH0ImA+SPLu0G62iA5kW4vSY=;
 b=ZYOfGJlAx67eko4djC3547fTjwM4cDhzEBb+FXGVk80llyPxcZl3KA1Pvc5H7CSMPS
 Gulg8pDbB0/UQjCXZobDGud67iekBtbBXcNB93QFgDO2E83Ot7+bdKr6oWIUdQ0IMIlJ
 I+ozyVTE/iaGFOxpEe+YkcNKCwyGwDcYwEyZv1y1f1OiTkD7B21AWpn8IuZpYG3hoUqu
 k6XhOLeUvXhd/JArIXmrSUbDHQCkrv5PYL38sYzmN6yqyBfmq0hLAkimlrvISwl8AqEY
 olHQV5kmZJSMSW08FGLeaMvYv4yFk53zJcbWKfSjSosTDge75eZeKvMj6DyIU0ofdFL2
 zgQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406421; x=1775011221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Fssya5SR8wqnNMnCvNmlH0ImA+SPLu0G62iA5kW4vSY=;
 b=Pjawu1ET1l0bh8pniGakVfyE5QRWFK0D7mnRGMXvM3sqaJKmGCyOy3zJmRVGo0Jqbd
 WeUOuAuxjSE1p83RAOjwdwJmFvZKpAetGzXNZOmjjL2rHl8+8mTlPkKBEhjRwNMiOUYc
 V1NG6ygMuNUIyphfu+RI0kNuAbaoGlIdyVRn/Vh137Bki3HVbsJIUZJfNzUM5qTEfA5r
 B9/ZXuGw4AJA1WzujqnZk2I3zh58FYxlorQNHYORZ2pOAmSH/SBIYmAKeKbBBJ+i8DXX
 zZcaVIbDRBrF2uC3UVsW5o/CtejdWRFQkCn6j3Sd+UuIeWNhjkpqfnf37rZzwNht5V7B
 iNaA==
X-Gm-Message-State: AOJu0YxQFUsEj3cvOkfLCi/uKiTKxlzEzWD0hZoFD6/hFPNYG8otQT3b
 EgZdTgN1kWrIlEDdtUgFgm1Tfz3IynBdwDsROUAuiS9VkM7L2Ig9m8BKKgIb3f1c26kgRFEaM6R
 k67bs
X-Gm-Gg: ATEYQzwVnDjr/atasp/mCfK5zHQR+qpsx+30DOl4hRC+pLX8Lz4K889nPLr/8Ctycft
 D0oNfTb3rLufu59CCOziSVmeutj2M6+PxE78HcJlNDOK9jjwiVX/GMMvsh7PTZ/CXFxFGI5W/05
 lml/dW3parN5GEqfaz5yTfFwoVcGPm+7teLe60l5QVJmCg9sdL21Hcz3veX8t1bw47TFjwHUWuX
 KFwEfJrRfyFbiTZ/pGtJ0xNu4W4qdxZJ25V2LHzAxPAJLHk/nS3su09DIMU/pfZCk+20QUxcnyT
 PnIP5eCs7LmrDl8dp//aN6bfo9H5/DTVxFB439owVGdBxpmQjeeGL/HF4u83WrNtnXl1lZ5+Tz2
 9fHgg7re8I9W/vZL3Bmk7qxis2w4UVclO7vcjrk3X3+tqdHzERGu3We3z0+oRYtFE1NQi1RxKk3
 bTidptKjyzsB27FmGSxCFyom8k86Nz2UUZYpf4ppPqMHA=
X-Received: by 2002:a05:7022:6983:b0:128:c1be:152b with SMTP id
 a92af1059eb24-12a96e46fc4mr1015566c88.4.1774406420954; 
 Tue, 24 Mar 2026 19:40:20 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v21 00/25] net/pcap: fixes, test, and enhancements
Date: Tue, 24 Mar 2026 19:37:31 -0700
Message-ID: <20260325024018.1275209-1-stephen@networkplumber.org>
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

v21:
  - Drop volatile patch, existing code is acceptable (Bruce)
  - Split Tx burst cleanup into two patches: error accounting
    fix and dumper return value cleanup (Bruce)
  - Add more tests

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
  net/pcap: clean up TX dumper return value and types
  net/pcap: add datapath debug logging
  net/pcap: consolidate boolean flag handling
  net/pcap: support VLAN strip and insert offloads
  app/pdump: preserve VLAN tags in captured packets
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
 app/test/test_pmd_pcap.c               | 4122 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/nics/pcap.rst               |   48 +
 doc/guides/rel_notes/release_26_03.rst |   11 +
 drivers/net/pcap/pcap_ethdev.c         |  842 +++--
 drivers/net/pcap/pcap_osdep.h          |   27 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   43 +-
 drivers/net/pcap/pcap_osdep_linux.c    |   33 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   76 +-
 lib/eal/windows/include/rte_os_shim.h  |    1 +
 lib/eal/windows/include/unistd.h       |    7 +
 lib/pdump/rte_pdump.c                  |   32 +-
 14 files changed, 5036 insertions(+), 218 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.53.0

