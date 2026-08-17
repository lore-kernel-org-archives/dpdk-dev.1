Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB2C5B572
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Aug 2026 19:24:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 985F340612;
	Mon, 17 Aug 2026 21:24:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id F2E1540275
 for <dev@dpdk.org>; Mon, 17 Aug 2026 21:24:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786994665; x=1818530665;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=NVSDSb9zPl850shnHnVUXvZy+V1xVBgKKCzxDVFwX40=;
 b=Oxtm2uOc6WuRa/M9N2F4DVtcBa5mAX6zARdq0T9Mg0XLQCnd4/lort+K
 EXLugytnk5kMFv1DhuFZt27IwmEI1FEeoSDpHrqAjrfwiaelXrmJGAai5
 vM2HAj15X6TKK3CKcoYRrbMCTEXKtm0l4HwPOfTeYDUTf7GPaHIwLG7r0
 exC4rS1nYg/PtlcdOv5QZWuZarTe9JUnMc95DnSOv/WZlldKpFSgTz518
 Q+vy3GUduw11CM8UWPw1JntwfEr7L8YObmr1DJlBS/llQrvf2iZS0TmPN
 8D+KedssOLA7xNqdS8esaYRyWG8Gt9vMpSB1Uwa6EO3Cd4aEH+dy/AmNy Q==;
X-CSE-ConnectionGUID: gmi21RiwRd+8EZpjwenC3Q==
X-CSE-MsgGUID: si3nq/N3TUya29jSgNNVSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="113020421"
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="113020421"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 12:24:22 -0700
X-CSE-ConnectionGUID: 5bNaWBB5TtSSMNrTgLB4jw==
X-CSE-MsgGUID: 3oX2u74GQIecMfTS4EUtDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,229,1779174000"; d="scan'208";a="266977744"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by fmviesa004.fm.intel.com with ESMTP; 17 Aug 2026 12:24:21 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC 0/1] ethdev: per-packet Tx timestamp slot management
Date: Tue, 18 Aug 2026 00:54:14 +0530
Message-ID: <20260817192417.3009990-1-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.54.0
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

The current DPDK ethdev time synchronization framework is architected
around a single, shared hardware latch. The existing API,
`rte_eth_timesync_read_tx_timestamp()`, assumes a serialization model
where only one TX timestamp is outstanding at any given time.

This model creates severe limitations for modern high-throughput network
interface cards (NICs). When multiple packets requiring precise
transmit timestamps are sent concurrently, the shared latch becomes a
race-condition bottleneck. It makes timestamp retrieval unreliable and
drops accuracy. Furthermore, Poll Mode Drivers (PMDs) backed by
hardware that supports independent, per-packet timestamping slots have
no way to expose this capability to the user.

To solve this, this RFC introduces a formal slot-based lifecycle API
for per-packet Tx timestamp management. The API decouples timestamp
tracking from the global latch model, enabling true asynchronous,
parallel hardware timestamping.

Key Components of the Proposal:
================================
1. **Slot Lifecycle Management APIs**:
   - `rte_eth_timesync_tx_timestamp_slot_alloc()`: Allocates and locks
     a unique hardware slot prior to frame transmission.
   - `rte_eth_timesync_tx_timestamp_stamp_mbuf()`: Embeds the allocated
     slot handle into an mbuf dynamic field, allowing the PMD to
     program the specific hardware descriptor during the Tx burst.
   - `rte_eth_timesync_read_tx_timestamp_slot()`: Asynchronously polls
     a specific slot for its captured value, safely returning `-EAGAIN`
     if the hardware has not yet written back the timestamp.
   - `rte_eth_timesync_tx_timestamp_slot_release()`: Recycles the
     hardware slot back to the PMD resource pool after successful
     retrieval or an application timeout.

2. **Dual-Domain Timing Mechanics**:
   - Introduces `struct rte_eth_timesync_dual_domain_timestamp` to
     simultaneously capture both the adjusted PTP Hardware Clock (PHC)
     domain (`adjusted_ns`) and the raw, free-running cycles domain
     (`cycles_ns`).
   - A dedicated `valid_mask` tracks the validity of each time domain
     independently, giving applications granular telemetry options.

Scope of this RFC & Open Questions for the Community:
======================================================
This RFC establishes the structural definition of the APIs and driver
interfaces. Before proceeding to a full `v1` patch with active PMD
implementations, we would highly appreciate the community's feedback
on the following design choices:

- **Mbuf Dynamic Field Layout**: Is the encapsulation of the slot
  handle into an mbuf dynamic field using standard dynamic registration
  the preferred mechanism for passing steering context to the Tx
  descriptor path?
- **Dual-Domain Structure**: Does tracking both the adjusted PHC and
  the cycle counter within `rte_eth_timesync_dual_domain_timestamp`
  cover the needs of other hardware vendors supporting concurrent
  domains?
- **Error States**: Is `-EAGAIN` an acceptable return code for
  non-blocking polling of incomplete timestamps, or should we consider
  an explicit bitmask status?

Please review the proposed design. We welcome your feedback, design
suggestions, and critique.

Rajesh Kumar (1):
  ethdev: add per-packet Tx timestamp slot APIs

 lib/ethdev/ethdev_driver.h |  19 ++++++
 lib/ethdev/rte_ethdev.c    | 121 +++++++++++++++++++++++++++++++++++++
 lib/ethdev/rte_ethdev.h    | 108 +++++++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)

-- 
2.54.0

