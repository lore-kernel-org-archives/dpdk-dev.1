Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCF2CD342C
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 May 2026 04:47:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B516402F1;
	Thu,  7 May 2026 06:47:44 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 5788E40265
 for <dev@dpdk.org>; Thu,  7 May 2026 06:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778129263; x=1809665263;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kof9tYU7WtZ7fDaGulApaq4Qx++edYS3KqWNnrrTkUQ=;
 b=k9+a31vL8TuX2zr8PipPdEO7eB+1IO+m3EojAcURDPy5rRVVa8AIJHmK
 BlXq78ZmSApX4TkliWBItrjXp3gTw+F1+m1G6uRmZVKJcqFZm/C8H+N3H
 6UbujaKQ01/TlRYmL/dHM5ZdHcJHKorbqVjBi97JTQ8tRBs3BVZSxL+u+
 mnfQQpe1wStIp783JkPoEqcIOEmpvTZuMl/MvUcC8ChnuS6diCTiNQRPW
 KrXYOGy8ICzg5/y4jREeDm66eBU6KRSyDpNC/Xc5ukNbbTZywRU4sv90G
 DFaEONFJ7BradHYfEG3PFx9aqQe77iJFleRp35pmmrl7YFYHbWRrhEObN Q==;
X-CSE-ConnectionGUID: DSO4mTwgRB+ic7VNDtwILA==
X-CSE-MsgGUID: uaD0ir2NT92AjBkyRHj7vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79180234"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="79180234"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 21:47:41 -0700
X-CSE-ConnectionGUID: CUuRf8MCQuSouhIhiIoH/w==
X-CSE-MsgGUID: nrUBXMGCS1WfBHAlxbxexg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; d="scan'208";a="233680717"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by fmviesa008.fm.intel.com with ESMTP; 06 May 2026 21:47:39 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, mb@smartsharesystems.com,
 Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [PATCH v6 0/4] PTP protocol support in lib/net
Date: Thu,  7 May 2026 15:43:10 +0530
Message-ID: <20260507101314.2456467-1-rajesh3.kumar@intel.com>
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

## Design Rationale

Following DPDK conventions for protocol libraries (rte_tcp.h, rte_ip.h),
PTP definitions are provided as a header-only library with inline functions
for zero-overhead packet processing. All functions are suitable for
real-time, performance-critical code paths.

## Contents

**Patch 1:** lib/net/rte_ptp.h - Header structures and inline helpers
  - rte_ptp_port_id: 10-byte port identity with EUI-64 clock ID
  - rte_ptp_hdr: 34-byte PTP v2 common message header
  - rte_ptp_timestamp: 10-byte nanosecond-precision timestamp
  - Message type constants (Sync, Delay_Req, Announce, etc.)
  - Flag field bits (two-step, unicast, leap indicator)
  - Inline helpers: rte_ptp_msg_type(), rte_ptp_seq_id(), rte_ptp_is_event(),
    rte_ptp_correction_ns(), rte_ptp_add_correction(), rte_ptp_timestamp_to_ns()

**Patch 2:** examples/ptp_tap_relay_sw - Software PTP Transparent Clock relay
  - Relays PTP packets between a DPDK-bound physical NIC and Linux TAP interface
  - Software timestamp-based residence time measurement (CLOCK_MONOTONIC)
  - Accumulates residence time to PTP correctionField per IEEE 1588-2019 §10.2
  - Handles L2, VLAN/QinQ, UDP/IPv4, UDP/IPv6 PTP encapsulations
  - Works with unmodified Linux kernel and stock DPDK (no patches required)
  - Compatible with standard linuxptp (ptp4l) tooling

**Patch 3:** doc/guides/rel_notes/release_26_07.rst - Release notes update

**Patch 4:** examples/ptpclient - Update to use lib/net PTP definitions
  - Uses RTE_ETHER_TYPE_1588 constant
  - Adds lib/net dependency

## Testing

- Build: `ninja -C build` — clean compilation
- Examples: Both ptpclient and ptp_tap_relay_sw compile and link correctly
- No stale references to old patterns or removed functions

## Changelog

v6 changes:
  - Restructured to lib/net (header-only, following lib/net conventions)
  - Removed separate DPI library functions (moved to example-local ptp_parse.h)
  - Removed app/test unit tests (library now header-only, example-driven testing)
  - Removed programmer's guide doc (lib/net headers use Doxygen API docs only)

Rajesh Kumar (4):
  lib/net: add IEEE 1588 PTP v2 protocol header definitions
  examples/ptp_tap_relay_sw: add PTP software transparent clock relay
  doc: update release notes for PTP protocol library
  examples/ptpclient: use shared PTP library definitions

 MAINTAINERS                                   |   6 +
 doc/guides/rel_notes/release_26_07.rst        |  12 +
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst | 212 +++++++++
 examples/ptp_tap_relay_sw/Makefile            |  41 ++
 examples/ptp_tap_relay_sw/meson.build         |  13 +
 examples/ptp_tap_relay_sw/ptp_parse.h         | 211 +++++++++
 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  | 432 ++++++++++++++++++
 examples/ptpclient/meson.build                |   1 +
 examples/ptpclient/ptpclient.c                |   4 +-
 lib/net/meson.build                           |   1 +
 lib/net/rte_ptp.h                             | 264 +++++++++++
 11 files changed, 1195 insertions(+), 2 deletions(-)
 create mode 100644 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
 create mode 100644 examples/ptp_tap_relay_sw/Makefile
 create mode 100644 examples/ptp_tap_relay_sw/meson.build
 create mode 100644 examples/ptp_tap_relay_sw/ptp_parse.h
 create mode 100644 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
 create mode 100644 lib/net/rte_ptp.h

-- 
2.53.0

