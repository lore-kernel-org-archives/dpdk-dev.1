Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1228F9D0E4
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Apr 2026 16:10:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C749402F0;
	Tue, 14 Apr 2026 18:10:15 +0200 (CEST)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com
 [209.85.167.174])
 by mails.dpdk.org (Postfix) with ESMTP id 28A5B402EE
 for <dev@dpdk.org>; Tue, 14 Apr 2026 18:10:15 +0200 (CEST)
Received: by mail-oi1-f174.google.com with SMTP id
 5614622812f47-4764484296eso3483688b6e.3
 for <dev@dpdk.org>; Tue, 14 Apr 2026 09:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776183014;
 x=1776787814; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmlMjJRVjUup1XQ+jJ4AIGS7iUlbviRi/Y7qkz+LpKE=;
 b=ttKFwIYfk/xiup2as16h2qAUJY0AVerB0dHRjrmms3F7cpKay1hBCduQaZQ2b+eroP
 AAMQgnpCZ5scviu3aDaGFdo+U9w/v4jQUedvixRKJXhgFZ5+j8yzgWfYay4+JyfIpBXs
 pc+uazGkv0+QcJJwQxQMPU6aI5zDtGWiP+MCW7B3XKfT2532+KEWx5EtJVfZtjjYMqzU
 IZD9NsrO3KR3l3NZ+5AIC1vn8VjYqNoYDbKPv0FRA1nryjY7bJPx+9ZVuWsGecZA+CK/
 seyhI9R45qkCuOJ+VD6bZN2/F7aP/3lew+45UmvEjCYpNTjzhxJX9zgcLAPgf8fif3h6
 q0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776183014; x=1776787814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RmlMjJRVjUup1XQ+jJ4AIGS7iUlbviRi/Y7qkz+LpKE=;
 b=R6tuw83FGpUlhpR8desuj6O5KKlRzFzPMLv+HwXH8U256YrLXLzWvLyzCOHXreH7z0
 WQ94flgu9xI9TPqg9liLBsazYFOUFSe90Qq6C+JMZSbpbkQWrMQkUfoll1r2WEJUpwtH
 rVYSgeD8LarE+hpkFapWVWAKTgjlTskDVXTgPU0jAzc8EPm3Vw3h7+1a1We15/GqsdGv
 s9fa+H+K0NNNi+HtZJwJYm0YGq+kpaaQ+gomCQbV37rAba5SyyohxqSmrXYs5B3cY3ht
 ViIV0XaZtB6jLYqRtjXTNnEzV9Qda+6o5LOlN61A8ekfGTrBIREBkiKtEGTF7i2WHAKu
 3a3Q==
X-Gm-Message-State: AOJu0YynH5VyUG4eFkG9FSqw9da6AVG5e+1RTEtnWVJgoe2feOb2ElGG
 2YlDH2Nx158tt934UzcGBxpiBNCe6BTK/DQ3s5yCRo0tEM++Yi2rPmenF6/ABe9kMUpeELLtTrj
 CFJ+s
X-Gm-Gg: AeBDieuNng8YobWMDWB2asdzlVLVE7Uj2x6aCxGCMQBbG5QwWJiCioDgAm0qccqR0+Q
 6vFKmauLAk/qHZeA3mN7JbCkI5GVrMgxZ1Eb+J4XcbLSzuPaEcNiRdHhv9NoR5ow9pWg3UKmOdl
 eOJD21t818YAiiTxUjONwYsd9htmbzjhf4DIgeUNVY4nlaKTFkWjBN+N5ypfLj4Evorw2Pb4w4Y
 5MnRbnMPgKZaMXdcyGPNv80MaOmVpnIenwba+zifMStQavyscnWizt7j+NkJrzS0vjBn9SapdyO
 Tekodf3ALB1xZ3i4ivWtyZqDQ4fKJKRWG8eLvs1KgaoQLeqUByxJicVbTyIGQikG6iFw6n6NtUb
 HbOd6p+Z5K0GsZywA48R3AXR741sjxfOv49ERna9chkBe7ohnkVwNjjOTN596EUseTCusai80CI
 MrSgGGnHgtWsnVXp1KGgG12m4o8tG/XU2DMJ9jzglqGOU=
X-Received: by 2002:a05:6808:ec8:b0:472:f551:7658 with SMTP id
 5614622812f47-4789f10c06cmr9384214b6e.35.1776183014095; 
 Tue, 14 Apr 2026 09:10:14 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-423dd396960sm11809554fac.2.2026.04.14.09.10.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 09:10:13 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v22 00/24] net/pcap: fixes, test and enhancements
Date: Tue, 14 Apr 2026 09:07:51 -0700
Message-ID: <20260414161011.756101-1-stephen@networkplumber.org>
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

v22 - don't use tx_prepare
      rebase for 26.07

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
 app/test/test_pmd_pcap.c               | 3448 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/nics/pcap.rst               |   47 +
 doc/guides/rel_notes/release_26_07.rst |   11 +
 drivers/net/pcap/pcap_ethdev.c         |  859 ++++--
 drivers/net/pcap/pcap_osdep.h          |   27 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   43 +-
 drivers/net/pcap/pcap_osdep_linux.c    |   33 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   76 +-
 lib/eal/windows/include/rte_os_shim.h  |    1 +
 lib/eal/windows/include/unistd.h       |    7 +
 13 files changed, 4349 insertions(+), 215 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.53.0

