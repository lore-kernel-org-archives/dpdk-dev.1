Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC32AFF886D
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Apr 2026 19:35:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C193240652;
	Mon, 27 Apr 2026 21:35:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 302C3402A3
 for <dev@dpdk.org>; Mon, 27 Apr 2026 21:35:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777318533; x=1808854533;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=bGG1+qEVaQx3ZCQoMoklgwCsMdAigwoack+sU4AqiwI=;
 b=dr/3U2An6R4Lzsw02P+8aYgTWKSqN5QQzeqmt6xsfyOHqynmG4iEmV+S
 tVzHLU3a+lxTzcWbkPobak+q5bTHFcg7GLCE6Kn+0dQgvYHgPaVEsfoGg
 51emIdwYwUXGxspaTp81J3joYxEYgOqv9JlFbw/5oqn9tVTemft29n00m
 89ii2VaY8NJ4aVaM+SrE/wyykl5N5bXeQqUC8bXupFzsdMQRi32B50jZ/
 WjKqRcBdghhNbjAt2Dqr5FS2RPK8WX7fL0kSMfTpP45Qbyq3m34EV4V3p
 1ARYX/orSIBw7plvQDzHA9tEW1y7G4W1hdmWCe3iG9bZC3crCIH8LNySw Q==;
X-CSE-ConnectionGUID: jmDciKLZS2CzzaQLHlLzBg==
X-CSE-MsgGUID: 9Y6GWX9XR1qSI9ttx+N1Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="81826666"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="81826666"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2026 12:35:32 -0700
X-CSE-ConnectionGUID: 3hK/xHSnSXevoIXpYzgIRg==
X-CSE-MsgGUID: XZFV/WJZTL2EOW+toy/GWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; d="scan'208";a="227210648"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by fmviesa009.fm.intel.com with ESMTP; 27 Apr 2026 12:35:30 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 rajesh3.kumar@intel.com
Subject: [RFC v1 0/4] introduce PTP protocol library and software relay example
Date: Tue, 28 Apr 2026 06:31:02 +0530
Message-ID: <20260428010117.692626-1-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
    (EtherType 0x88F7), VLAN-tagged L2, and UDP/IPv4 (ports 319/320)
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

Test Results
------------
Test setup: Intel E610 10GbE NIC (vfio-pci), ptp4l master with HW
timestamps on physical port, ptp4l slave with SW timestamps (-S) on TAP
interface, logSyncInterval=-4 (16 Sync/sec), 120s duration.

  Post-convergence (60s of locked data):
    Average RMS offset:   929 ns
    Worst max offset:     11615 ns (single transient)
    Steady-state range:   489 - 1055 ns RMS
    Corrections applied:  3635

linuxptp's PI servo uses relaxed gains for software timestamps
(kp=0.1, ki=0.001 vs kp=0.7, ki=0.3 for HW), expecting ~5-50 µs
jitter. Sub-microsecond RMS is achieved here because the master uses
HW timestamps and DPDK's poll-mode relay provides deterministic
low-latency forwarding.

Rajesh Kumar (4):
  ptp: introduce PTP protocol library
  doc: add PTP library programmer's guide
  examples/ptp_tap_relay_sw: add software PTP relay example
  doc: add PTP software relay sample app guide

 MAINTAINERS                                   |   7 +
 doc/api/doxy-api-index.md                     |   1 +
 doc/api/doxy-api.conf.in                      |   1 +
 doc/guides/prog_guide/index.rst               |   1 +
 doc/guides/prog_guide/ptp_lib.rst             | 195 ++++++++
 doc/guides/sample_app_ug/index.rst            |   1 +
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst | 210 +++++++++
 examples/meson.build                          |   1 +
 examples/ptp_tap_relay_sw/Makefile            |  41 ++
 examples/ptp_tap_relay_sw/meson.build         |  14 +
 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  | 424 ++++++++++++++++++
 lib/meson.build                               |   1 +
 lib/ptp/meson.build                           |   6 +
 lib/ptp/rte_ptp.c                             | 195 ++++++++
 lib/ptp/rte_ptp.h                             | 328 ++++++++++++++
 15 files changed, 1426 insertions(+)
 create mode 100644 doc/guides/prog_guide/ptp_lib.rst
 create mode 100644 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
 create mode 100644 examples/ptp_tap_relay_sw/Makefile
 create mode 100644 examples/ptp_tap_relay_sw/meson.build
 create mode 100644 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
 create mode 100644 lib/ptp/meson.build
 create mode 100644 lib/ptp/rte_ptp.c
 create mode 100644 lib/ptp/rte_ptp.h

-- 
2.52.0

