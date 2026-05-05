Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97523CD342F
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 11:12:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA63A402B9;
	Tue,  5 May 2026 13:12:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 56CFB4026C
 for <dev@dpdk.org>; Tue,  5 May 2026 13:12:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777979569; x=1809515569;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4GgA4tAzazYHZcK0JC82cKVOJqpMvt/IeyY5UO9BTXc=;
 b=SXZbUmQgGvLbFPqpK/WQo4FY3gpUUqukfRBgCIBTC6X6H6GAWoDZdzfj
 rgm3FxiQMm71PjadtaBqdF1UC9P4ktAtMe7adyQ/T+bKSK4SvEcySVgwz
 Ileq55p0J5H3KdoeBHBOauUnuSPOmQ0IW5bQOUo5F7sMd2FYOmBsTCfJw
 AqcJ0lP9ftL6keMBskkcEDRFa/SI/SEPkuqNBJlg+9T9FfDZ8GugfKj8i
 rdVTg/5LD5qNV8Oq5lZsoSI7FBbadHr/J5c3eOrrJdhRYvZWXY3JrcSgF
 fEER5RkQGz5Rws/vzSOrI0Sbrj9QggIufK1YgQXgnLg5y8K+LVNfJDXYw g==;
X-CSE-ConnectionGUID: Ah3BchfOSUG0WURQp1XjvA==
X-CSE-MsgGUID: pzOGDMwwS6yYnapjiMajww==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="90220395"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="90220395"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 04:12:48 -0700
X-CSE-ConnectionGUID: lyLOTUOpSuayXMWwVZNqoA==
X-CSE-MsgGUID: jlBxOXNbRCqCIDEimX9h8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; d="scan'208";a="266126010"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa002.jf.intel.com with ESMTP; 05 May 2026 04:12:47 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC v4 0/6] introduce PTP protocol library and software relay
Date: Tue,  5 May 2026 22:08:49 +0530
Message-ID: <20260505163858.212158-1-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428010117.692626-1-rajesh3.kumar@intel.com>
References: <20260428010117.692626-1-rajesh3.kumar@intel.com>
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

Example: ptp_tap_relay_sw
-------------------------
A minimal PTP Transparent Clock relay between a DPDK-bound physical NIC
and a kernel TAP interface using software timestamps only. No patched
kernel modules, custom TAP PMD, or hardware timestamp support is
required.

The relay:
  1. Receives packets on the physical NIC via DPDK
  2. Parses packets using rte_ptp_hdr_get()
  3. For event messages, records software timestamps
     (clock_gettime(CLOCK_MONOTONIC)) at ingress and egress
  4. Adds residence time to correctionField via rte_ptp_add_correction()
     (IEEE 1588-2019 10.2 Transparent Clock)
  5. Forwards bidirectionally: PHY <-> TAP

Unit Tests: app/test
--------------------
A comprehensive test suite (ptp_autotest) covers all library APIs,
including VLAN/QinQ/IPv4/IPv6 transports, correctionField helpers,
flags, and negative tests. Also covers IPv4 options (IHL > 5).

v4:
  - Fixed C++ header check (chkincs) failure: moved #include directives
    above extern "C" guard in rte_ptp.h to prevent rte_bitops.h C++
    overloads from being forced into C linkage

v3:
  - Reused RTE_ETHER_TYPE_1588 via RTE_PTP_ETHERTYPE alias
  - Updated version field comment to minorVersionPTP|versionPTP
  - Fixed prog guide rte_ptp_hdr_get() signature (non-const mbuf)
  - Added ALLOW_EXPERIMENTAL_API to ptp_tap_relay_sw Makefile
  - Updated relay example to parse once (rte_ptp_hdr_get + msg_type)
  - Updated relay sample app limitations wording to match capabilities
  - Added hdr_get NULL checks in correction tests
  - Added IPv4 options classification test (IHL > 5)
  - Made correction counter update style consistent via pointer arg

v2:
  - Fixed flag bit positions for host-order representation after
    rte_be_to_cpu_16(): TWO_STEP (1<<9), UNICAST (1<<10),
    LI_61 (1<<0), LI_59 (1<<1)

Rajesh Kumar (6):
  ptp: introduce PTP protocol library
  doc: add PTP library programmer's guide
  examples/ptp_tap_relay_sw: add software PTP relay example
  doc: add PTP software relay sample app guide
  app/test: add PTP library unit tests
  examples/ptpclient: use shared PTP library definitions

 MAINTAINERS                                   |    8 +
 app/test/meson.build                          |    1 +
 app/test/test_ptp.c                           | 1106 +++++++++++++++++
 doc/api/doxy-api-index.md                     |    1 +
 doc/api/doxy-api.conf.in                      |    1 +
 doc/guides/prog_guide/index.rst               |    1 +
 doc/guides/prog_guide/ptp_lib.rst             |  205 +++
 doc/guides/rel_notes/release_26_07.rst        |   13 +
 doc/guides/sample_app_ug/index.rst            |    1 +
 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst |  212 ++++
 examples/meson.build                          |    1 +
 examples/ptp_tap_relay_sw/Makefile            |   43 +
 examples/ptp_tap_relay_sw/meson.build         |   14 +
 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c  |  433 +++++++
 examples/ptpclient/meson.build                |    1 +
 examples/ptpclient/ptpclient.c                |  188 ++-
 lib/meson.build                               |    1 +
 lib/ptp/meson.build                           |    6 +
 lib/ptp/rte_ptp.c                             |  185 +++
 lib/ptp/rte_ptp.h                             |  339 +++++
 20 files changed, 2644 insertions(+), 116 deletions(-)
 create mode 100644 app/test/test_ptp.c
 create mode 100644 doc/guides/prog_guide/ptp_lib.rst
 create mode 100644 doc/guides/sample_app_ug/ptp_tap_relay_sw.rst
 create mode 100644 examples/ptp_tap_relay_sw/Makefile
 create mode 100644 examples/ptp_tap_relay_sw/meson.build
 create mode 100644 examples/ptp_tap_relay_sw/ptp_tap_relay_sw.c
 create mode 100644 lib/ptp/meson.build
 create mode 100644 lib/ptp/rte_ptp.c
 create mode 100644 lib/ptp/rte_ptp.h


base-commit: 7baf81674a011ab8a2fe329566b6d43d7377244c
-- 
2.53.0

