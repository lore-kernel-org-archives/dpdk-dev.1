Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BFFD0049
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Mar 2026 02:07:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 036AD402B5;
	Sun,  1 Mar 2026 03:07:37 +0100 (CET)
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by mails.dpdk.org (Postfix) with ESMTP id 20F71402AA
 for <dev@dpdk.org>; Sun,  1 Mar 2026 03:07:34 +0100 (CET)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-8cb513e860cso353761185a.2
 for <dev@dpdk.org>; Sat, 28 Feb 2026 18:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1772330854;
 x=1772935654; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QK5a4Jdsy7QY/eXunbZFwbzPnJhBEQZeh8UMwAhfSS0=;
 b=qp/leoaNInQjYIQ5XHCkUdTmOaDCanIMhY4ulR34n5yBM0+wf/Kg5zcY+lqY0QfeIN
 M+O9PVCnqICkz/UGmF61uxFf/KURfu3nG1PdJr9jj4jYcqpe03bjNJP9ny3Oq11+RJoG
 bq2WJKoq18l7AkJSzBGdZzq54WShivEVGl4ZON4aXEEk7ANRh3IrY7yLYXqW43yaaMdd
 4r1h21W+jsMR7ISWoanmsLvx9fMM08kzz631tZlnAp1e7fkPPPFNI7SPqtkWsfJvpt7I
 ad88144Em2iFYHfvbvEJ5aEUrUOA8wQ5pD3MwjZ9mHg+OLQE1PzagIN+beSOpVoGy90y
 KIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772330854; x=1772935654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QK5a4Jdsy7QY/eXunbZFwbzPnJhBEQZeh8UMwAhfSS0=;
 b=eqtCZmmbkrTwT3F06QPoX9Fk+/X2smsiQ5+Qk4sy8GtS1wvzj4BWbwqkPGoNYOqdm5
 PlzCgWaH3cSYhXk/IlmYMLMP7W44ZxOHDSN1Z1ldVwI+uBHRH9FU36FA2nZKH2IelBAT
 HtN6vJVnOsmIQb/nTU6jzXPGAuBzqX4OlXbJlNX/YGD4pp18y55FcY5o5zp+5Zuv8tyk
 m9BNzIYSiSsh4Ps52YtN0/PO+WezFh2YVWZDdMeKgm9gtcmHetGJjZzjVjCpIxY9Jtct
 +BYGVZghFRTf4wD4dYTs7CWBPAcnpYhPBtqzGz/lKuN8sfj0H7NdBJYo5q/kwxHcg06D
 tzVQ==
X-Gm-Message-State: AOJu0Yxwhg0Ffq3qvABGHLwnLDH+DLCZ0R/bzUHo+CmsM+sZI1bwXRc4
 rwZzUbClvrzNNF7gFA238RMwwTvQB64sL37LrgDEBW0KQ4BUKUnVZ+LA6AV574TJQ4fiPJwvgHR
 IiG0w
X-Gm-Gg: ATEYQzyO9rNE0ZkW5FHOtuNoJ45XidTXOXcuN8lzXFt+8iShbp3dcRQLnHCajXFszTk
 yEucCxQLZqknVle/hgGiPawZeQ+AxGhVAVi2AHrwLZrDY0ESPzKNCHjQJCTrjA4+ujcXPoA4R32
 wXko1aAsO+DtlWR5xGoO9fyjlzy8M8MBKdN3oOPCaDTTS/e+mZUNShHWRcJ9aEQHCUtO1dGki8Z
 DXdIX8aKLdCs81XZOtFZNuiXDjzfaOI9+zKlrRj+ItauWBElYfcaQH9cMh/h/9sg4Rw5IYqwqCg
 s0af2zQ0Nmz8CUSyEBsVut3sbgm4vpO+M8d3PMaQgM1UvVf9xcGOdRAR9S5/yCx1Fn3tqY1inZE
 2IApeL0vgEYVSoQ9L4sqKpz43nxS9qukFSDyHfeObmhK3XD1PPgYRjZqY3Ycj9t+qDWYixZ1goH
 UZjV+EX08vy+cCEIw7gCEf41NTBJ7Y4FCgFSJn3H3t7xNscX7WCBHrsI/5fv9wfA==
X-Received: by 2002:a05:620a:1a22:b0:8c6:abc5:f15e with SMTP id
 af79cd13be357-8cbc8e2e69fmr880567385a.67.1772330854015; 
 Sat, 28 Feb 2026 18:07:34 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cbbf736bffsm802292985a.50.2026.02.28.18.07.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Feb 2026 18:07:33 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v18 00/23] net/pcap: fixes, test, and enhancements
Date: Sat, 28 Feb 2026 18:05:33 -0800
Message-ID: <20260301020726.852401-1-stephen@networkplumber.org>
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
  - Add comprehensive unit test suite (26 test cases) covering basic
    file I/O, timestamps, jumbo frames, VLAN strip/insert, multi-queue,
    snaplen, EOF notification, and link status
  - Test discovers network interfaces using pcap_findalldevs API
    for portable interface enumeration across Linux, FreeBSD, macOS,
    and Windows
  - Tests use packet_burst_generator for standardized test packet
    creation

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

Stephen Hemminger (23):
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
  net/pcap: add link status change support for iface mode
  net/pcap: add EOF notification via link status change
  test: add comprehensive test suite for pcap PMD

 MAINTAINERS                            |    1 +
 app/test/meson.build                   |    2 +
 app/test/test_pmd_pcap.c               | 3574 ++++++++++++++++++++++++
 doc/guides/nics/features/pcap.ini      |    9 +
 doc/guides/nics/pcap.rst               |   48 +
 doc/guides/rel_notes/release_26_03.rst |   12 +
 drivers/net/pcap/pcap_ethdev.c         |  812 ++++--
 drivers/net/pcap/pcap_osdep.h          |   27 +
 drivers/net/pcap/pcap_osdep_freebsd.c  |   43 +-
 drivers/net/pcap/pcap_osdep_linux.c    |   33 +-
 drivers/net/pcap/pcap_osdep_windows.c  |   76 +-
 lib/eal/windows/include/rte_os_shim.h  |    1 +
 lib/eal/windows/include/unistd.h       |    7 +
 13 files changed, 4423 insertions(+), 222 deletions(-)
 create mode 100644 app/test/test_pmd_pcap.c

-- 
2.51.0

