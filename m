Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706F6FF886F
	for <dpdk-dev@archiver.kernel.org>; Tue, 28 Apr 2026 17:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8A7EA402E1;
	Tue, 28 Apr 2026 19:03:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 27EB74026E
 for <dev@dpdk.org>; Tue, 28 Apr 2026 19:03:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777395815; x=1808931815;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a3XjrTL6tEwRCQsk+1Zg7D1fo3OE4vNRhiR8bPyjTDs=;
 b=YXWelrNoS0yyzy2zTNb2wSZq0ze2L5wFQb1Hap9wgMRy1JPpahnh/iRP
 zrBomZFQUN6cU9BoenlsYX75+bmJcF1N576Png090WXKnenLyZSY8mrp4
 eFVW6IvkhckjWoV8NVXycXGcXAul9EgTNbLKow0cRm2CCJUQgVvhmIh49
 TRMOwzBDYS8jhSzLA1ZkKKQTjxCWmfQRuT5kgeF/1HAFmhcE+baaIcyDk
 GmsKdy1zKPfPb5nrzwYrzdQ+5stZhfftAp8Zb2HoSdZpHzb+edbrXHq95
 B1bWX1TFpzR8CI0wQnzcDabwdN3a4bn5Esk+PI5pETMQl4xBg395vBlXt A==;
X-CSE-ConnectionGUID: 6akopl9PQa+G/5UjgwJF6w==
X-CSE-MsgGUID: 0ia4K5njQ/iL1gj5qsqtMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="82180124"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="82180124"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Apr 2026 10:03:05 -0700
X-CSE-ConnectionGUID: fKyGnWWvSj6fkg0LBk/dkA==
X-CSE-MsgGUID: 4/SegcoST+aEzjjRVTAdsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; d="scan'208";a="233973002"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa009.jf.intel.com with ESMTP; 28 Apr 2026 10:03:02 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC v2 0/6] introduce PTP protocol library and software relay
Date: Wed, 29 Apr 2026 03:58:31 +0530
Message-ID: <cover.1777413123.git.rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428010117.692626-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
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

This series introduces a new DPDK library (lib/ptp) for IEEE 1588-2019
PTP protocol packet processing and a companion example application
(ptp_tap_relay_sw) that demonstrates its usage.

Motivation
----------
Several DPDK applications need to classify and manipulate PTP packets
(e.g. ptpclient, ptp_tap_relay, custom Transparent Clocks). Today each
application re-implements its own PTP header parsing and correctionField
handling. A shared library avoids duplication and provides a tested,
standards-compliant foundation.

Library: lib/ptp
----------------
The library provides:
  - PTP header structures (IEEE 1588-2019 common header, timestamp,
    port identity)
  - Packet classification: rte_ptp_classify() detects PTP over L2
    (EtherType 0x88F7), VLAN-tagged L2 (TPIDs 0x8100/0x88A8, single
    or double), UDP/IPv4, UDP/IPv6 (ports 319/320), and VLAN-tagged
    UDP variants
  - Header access: rte_ptp_hdr_get() returns a pointer to the PTP
    header inside an mbuf
  - Inline helpers: correctionField manipulation (48.16 fixed-point),
    message type extraction, two-step flag check, timestamp conversion
  - Debug: rte_ptp_msg_type_str() for human-readable message names

The API is experimental (targeted for 26.07). Dependencies are minimal:
mbuf and net libraries only.

Example: ptp_tap_relay_sw
-------------------------
A minimal PTP Transparent Clock relay between a DPDK-bound physical NIC
and a kernel TAP interface using software timestamps only. No patched
kernel modules, custom TAP PMD, or hardware timestamp support is
required.

The relay:
  1. Receives packets on the physical NIC via DPDK
  2. Classifies PTP packets using rte_ptp_classify()
  3. For event messages, records software timestamps
     (CLOCK_MONOTONIC_RAW) at ingress and egress
  4. Adds residence time to correctionField via rte_ptp_add_correction()
     (IEEE 1588-2019 §10.2 Transparent Clock)
  5. Forwards bidirectionally: PHY <-> TAP

A two-pass design takes the TX timestamp as close to rte_eth_tx_burst()
as possible, minimising untracked delay.

Unit Tests: app/test
--------------------
A comprehensive test suite (ptp_autotest) covers all library APIs:
  - Packet classification across L2, VLAN, QinQ, IPv4-UDP, IPv6-UDP,
    and VLAN-tagged UDP encapsulations
  - Flag bit position validation (TWO_STEP, UNICAST, LI_61, LI_59)
  - correctionField manipulation and round-trip accuracy
  - Timestamp conversion, message type helpers, edge cases
  - Negative tests: truncated packets, bad IHL, non-PTP traffic
33 test cases total.

ptpclient Conversion
--------------------
The existing ptpclient example is converted to use lib/ptp shared
definitions (rte_ptp_hdr, rte_ptp_timestamp, rte_ptp_port_id,
RTE_PTP_ETHERTYPE, RTE_PTP_MULTICAST_MAC), removing ~120 lines of
duplicate struct and constant definitions.


Test Results
------------
Test setup: Intel E610 10GbE NIC (vfio-pci), ptp4l time transmitter
with HW timestamps on physical port, ptp4l time receiver with SW
timestamps (-S) on TAP interface, logSyncInterval=-4 (16 Sync/sec),
120s duration.

  Post-convergence (60s of locked data):
    Average RMS offset:   929 ns
    Worst max offset:     11615 ns (single transient)
    Steady-state range:   489 - 1055 ns RMS
    Corrections applied:  3635

linuxptp's PI servo uses relaxed gains for software timestamps
(kp=0.1, ki=0.001 vs kp=0.7, ki=0.3 for HW), expecting ~5-50 µs
jitter. Sub-microsecond RMS is achieved here because the time
transmitter uses HW timestamps and DPDK's poll-mode relay provides
deterministic low-latency forwarding.

v2:
    Fixed below AI generated Review comments 
  - Fixed flag bit positions for host-order representation after
    rte_be_to_cpu_16(): TWO_STEP (1<<9), UNICAST (1<<10),
    LI_61 (1<<0), LI_59 (1<<1).  Added unit test for all flags.
  - Fixed QinQ classification: outer 0x88A8 (802.1ad S-tag) now
    enters the VLAN parser alongside 0x8100.
  - Fixed signed left-shift UB in rte_ptp_add_correction(): shift
    is now performed on uint64_t before casting back to int64_t.
  - Fixed promiscuous enable failure in relay example: port_init()
    now returns error instead of logging and continuing silently.
  - Replaced deprecated master/slave PTP terminology with IEEE
    1588-2019 terms (time transmitter / time receiver) throughout
    code and documentation.
  - Documented per-burst single-timestamp design choice and its
    accuracy characteristics in the relay example.
  - Added IHL validation (reject IHL < 20) in IPv4 PTP-over-UDP path.
  - Changed rte_ptp_is_event() parameter from uint8_t to int with
    negative value guard for safe use with rte_ptp_classify() return.
  - Changed rte_ptp_hdr_get() parameter from const to non-const mbuf
    since it returns a non-const pointer into packet data.
  - All pointer accesses use rte_pktmbuf_mtod_offset() — no raw
    pointer arithmetic.
  - Added programmer's guide note about avoiding double-parse when
    both message type and header pointer are needed.

Rajesh Kumar (6):
  ptp: introduce PTP protocol library
  doc: add PTP library programmer's guide
  examples/ptp_tap_relay_sw: add software PTP relay example
  doc: add PTP software relay sample app guide
  app/test: add PTP library unit tests
  examples/ptpclient: use shared PTP library definitions

 MAINTAINERS                                   |    8 +
 app/test/meson.build                          |    1 +
 app/test/test_ptp.c                           | 1052 +++++++++++++++++
 doc/api/doxy-api-index.md                     |    1 +
 doc/api/doxy-api.conf.in                      |    1 +
 doc/guides/prog_guide/index.rst               |    1 +
 doc/guides/prog_guide/ptp_lib.rst             |  205 ++++
 doc/guides/rel_notes/release_26_07.rst        |   13 +
 doc/guides/sample_app_ug/index.rst            |    1 +
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst |  210 ++++
 examples/meson.build                          |    1 +
 examples/ptp_tap_relay_sw/Makefile            |   41 +
 examples/ptp_tap_relay_sw/meson.build         |   14 +
 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  |  433 +++++++
 examples/ptpclient/meson.build                |    1 +
 examples/ptpclient/ptpclient.c                |  188 ++-
 lib/meson.build                               |    1 +
 lib/ptp/meson.build                           |    6 +
 lib/ptp/rte_ptp.c                             |  185 +++
 lib/ptp/rte_ptp.h                             |  338 ++++++
 20 files changed, 2585 insertions(+), 116 deletions(-)
 create mode 100644 app/test/test_ptp.c
 create mode 100644 doc/guides/prog_guide/ptp_lib.rst
 create mode 100644 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
 create mode 100644 examples/ptp_tap_relay_sw/Makefile
 create mode 100644 examples/ptp_tap_relay_sw/meson.build
 create mode 100644 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
 create mode 100644 lib/ptp/meson.build
 create mode 100644 lib/ptp/rte_ptp.c
 create mode 100644 lib/ptp/rte_ptp.h

-- 
2.53.0

