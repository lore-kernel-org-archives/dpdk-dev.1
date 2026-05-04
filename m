Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5700CD3423
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 03:51:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D55640270;
	Mon,  4 May 2026 05:51:21 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by mails.dpdk.org (Postfix) with ESMTP id 2CD774026C
 for <dev@dpdk.org>; Mon,  4 May 2026 05:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777866680; x=1809402680;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=l1jxJQZaDbDtN3k4fSCsruqsrwLoFdj9uJpfOihphRg=;
 b=Jalvpf+1lgTGKi2UXmaZ+ph61SmGZYHktzu1SHgSrWQpGqZ7a6Rw9y1K
 2qybpg9szK0BelS4ubWMcW140HNatxkyRUh+g7BWkH/UBYzDjlHHcISsO
 YwFkH808pvnAbfCNcCUBvmM1BwnIGPFmuWrkoYZzc/Jg5yHK4EtEbBp0P
 LNUaQgSZSIu5S4DMxwWtgg2yxTPHfEt9gMU6ZTC3KtgHj0AX7ZKfCFQsa
 Lq8eujqGE+00cDHNJMqyHVJmG017cDzKxImKbOXkVFOer+qoSGN+Q+UY9
 5PCAwuA3Nn3xzmZ8b6Pjn7O9D1roL31zzd7eHx6YBdq1Iw2hAdhc2pPBc Q==;
X-CSE-ConnectionGUID: FUr7FUxWTdGqWNehn2GnSA==
X-CSE-MsgGUID: IVTUIzJvRuSkncI/oNWjrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="101389197"
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; d="scan'208";a="101389197"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 May 2026 20:51:18 -0700
X-CSE-ConnectionGUID: lErKVsCiS2qL8vNyBpVGHA==
X-CSE-MsgGUID: maMgLUYkQJynuHSzJftwdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,214,1770624000"; d="scan'208";a="235282193"
Received: from icx008.iind.intel.com ([10.190.212.196])
 by orviesa008.jf.intel.com with ESMTP; 03 May 2026 20:51:15 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, aman.deep.singh@intel.com,
 stephen@networkplumber.org, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC v3 0/6] introduce PTP protocol library and software relay
Date: Mon,  4 May 2026 14:47:16 +0530
Message-ID: <20260504091728.1406661-1-rajesh3.kumar@intel.com>
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
flags, and negative tests. This v3 also adds coverage for IPv4 options
(IHL > 5).

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
  - Fixed QinQ classification: outer 0x88A8 now enters VLAN parser
  - Fixed signed left-shift UB in rte_ptp_add_correction()
  - Fixed promiscuous enable failure handling in relay port_init()
  - Replaced deprecated master/slave terminology with IEEE terms
  - Added and documented IHL validation for IPv4 PTP-over-UDP
  - Changed rte_ptp_is_event() parameter to int with negative guard
  - Changed rte_ptp_hdr_get() parameter to non-const mbuf
  - Added programmer's guide note about avoiding double-parse

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

