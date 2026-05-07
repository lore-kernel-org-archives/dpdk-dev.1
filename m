Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF38DCD3442
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 08:20:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFED840265;
	Thu,  7 May 2026 10:19:59 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id D23C14025A
 for <dev@dpdk.org>; Thu,  7 May 2026 10:19:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778141998; x=1809677998;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GEXvHRlyEVIcfbWOOfcgKAehK/BDOJ59eReRrjkMSTk=;
 b=TJojEXHLWY8gmGnFCIb9v1HcZjmIq78TYH7ryEjWd35U/zIhERE8e2xD
 zJnT9wcbW9EaCrESypN4T3fqb4VS3dUt/niwL1ev1plcj2dz28M3on4i+
 Qd1AvbFwoELX0lQ3sZfUMAZw5NBtEx32Vy/7GITYSFjr2vkfkC4sM380q
 irDHC1OG6sX6d13jUpKJRe+91yPDlCQ2qEvgdg4bFuHU685nGW+BmnOue
 HdeHK/0df6GyF9lZ8qN78pfxSowR3JsHJCYPcPgTowwSgBJbksli1w8Wo
 dsnZy+EYIsX1IkmonqcXKZ7M+xRcB74ye2UvFZ5nrMpGWPz6ERfmpzTCd g==;
X-CSE-ConnectionGUID: Xc1jdnmBTzSa0DW6glQ7Mg==
X-CSE-MsgGUID: dk1kDrK6TIqI/YCST0mdGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79075739"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="79075739"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 01:19:57 -0700
X-CSE-ConnectionGUID: 6gugCS56SvKVQUnYLv6cFQ==
X-CSE-MsgGUID: 0FCUqe1ETtWkttjqiiAJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; d="scan'208";a="236313751"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa008.jf.intel.com with ESMTP; 07 May 2026 01:19:56 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v7 0/4] IEEE 1588 PTP v2 protocol support in lib/net
Date: Thu,  7 May 2026 19:15:25 +0530
Message-ID: <20260507134529.2573300-1-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428010117.692626-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
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

Add IEEE 1588-2019 Precision Time Protocol (PTP) support to DPDK via a
new header library in lib/net/. This patchset provides wire-format packet
structure definitions and inline helpers for Transparent Clock and
ordinary clock applications.

Design Rationale
================

Following DPDK conventions for protocol libraries (rte_tcp.h, rte_ip.h),
PTP definitions are provided as a header-only library with inline functions
for zero-overhead packet processing. All functions are suitable for
real-time, performance-critical code paths.

Contents
========

Patch 1: lib/net/rte_ptp.h - Header structures and inline helpers
  - rte_ptp_port_id: 10-byte port identity with EUI-64 clock ID
  - rte_ptp_hdr: 34-byte PTP v2 common message header
  - rte_ptp_timestamp: 10-byte nanosecond-precision timestamp
  - Message type constants (Sync, Delay_Req, Announce, etc.)
  - Flag field bits (two-step, unicast, leap indicator)
  - Inline helpers: rte_ptp_msg_type(), rte_ptp_seq_id(),
    rte_ptp_is_event(), rte_ptp_correction_ns(), rte_ptp_add_correction(),
    rte_ptp_timestamp_to_ns()

Patch 2: examples/ptp_tap_relay_sw - Software PTP Transparent Clock relay
  - Relays PTP packets between a DPDK-bound physical NIC and Linux TAP
  - Software timestamp-based residence time measurement (CLOCK_MONOTONIC)
  - Accumulates residence time to correctionField per IEEE 1588-2019 §10.2
  - Handles L2, VLAN/QinQ, UDP/IPv4, UDP/IPv6 PTP encapsulations
  - Works with unmodified Linux kernel and stock DPDK (no patches required)
  - Compatible with standard linuxptp (ptp4l) tooling

Patch 3: doc/guides/rel_notes/release_26_07.rst - Release notes update

Patch 4: examples/ptpclient - Update to use lib/net PTP definitions
  - Replace local struct ptp_header with struct rte_ptp_hdr
  - Replace local struct tstamp with struct rte_ptp_timestamp
  - Replace local struct clock_id with uint8_t[8] arrays
  - Use RTE_PTP_MSGTYPE_* constants instead of local defines
  - Use rte_ptp_msg_type(), rte_ptp_seq_id() inline helpers
  - Remove local PTP_PROTOCOL macro (use RTE_ETHER_TYPE_1588)
  - Add lib/net dependency in meson.build

Testing
=======

- Build: `ninja -C build` - clean compilation
- Examples: Both ptpclient and ptp_tap_relay_sw compile and link correctly
- No stale references to old patterns or removed functions

Changelog
=========

v7 changes:
  - Added sample app guide to sample_app_ug toctree to fix Sphinx warning
  - Fixed all checkpatch warnings (commit message line lengths <= 75 chars)
  - Refactored ptpclient to use shared lib/net/rte_ptp.h definitions
  - All 5 patches (cover + 4 functional) pass checkpatch validation

v6 changes:
  - Restructured to lib/net (header-only, following lib/net conventions)
  - Removed separate DPI library functions (moved to example local parser)
  - Removed app/test unit tests (header-only, example-driven testing)
  - Removed programmer's guide (lib/net headers use Doxygen API docs only)

Rajesh Kumar (4):
  lib/net: add IEEE 1588 PTP v2 protocol header definitions
  examples/ptp_tap_relay_sw: add PTP software transparent clock relay
  doc: update release notes for PTP protocol library
  examples/ptpclient: use shared PTP library definitions

 MAINTAINERS                                   |   6 +
 doc/guides/rel_notes/release_26_07.rst        |  12 +
 doc/guides/sample_app_ug/index.rst            |   1 +
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst | 212 +++++++++
 examples/ptp_tap_relay_sw/Makefile            |  41 ++
 examples/ptp_tap_relay_sw/meson.build         |  13 +
 examples/ptp_tap_relay_sw/ptp_parse.h         | 211 +++++++++
 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  | 432 ++++++++++++++++++
 examples/ptpclient/meson.build                |   1 +
 examples/ptpclient/ptpclient.c                | 204 ++++-----
 lib/net/meson.build                           |   1 +
 lib/net/rte_ptp.h                             | 264 +++++++++++
 12 files changed, 1274 insertions(+), 124 deletions(-)
 create mode 100644 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
 create mode 100644 examples/ptp_tap_relay_sw/Makefile
 create mode 100644 examples/ptp_tap_relay_sw/meson.build
 create mode 100644 examples/ptp_tap_relay_sw/ptp_parse.h
 create mode 100644 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
 create mode 100644 lib/net/rte_ptp.h

-- 
2.53.0

