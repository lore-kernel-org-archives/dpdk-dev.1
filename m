Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134B1C61DFD
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Sep 2026 05:51:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E076C40A6F;
	Wed,  2 Sep 2026 07:51:38 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id BE418402F0
 for <dev@dpdk.org>; Wed,  2 Sep 2026 07:51:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788328298; x=1819864298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xSTsegAoukH+o8pqKPYnhpgbIpGqO/ARAQDZ/Bdu934=;
 b=mWkhgWdHVLiuS15r8NifSrlwnCb9CRvWChgNzyiRm2n0EsyehV2ILubi
 8hx9hwAsIWQDkqQp64nzcLFg94zlTkwOug04oH07MnRQIDPnD++8AxCJd
 KaDLOYQ20O1TM2yd83/oM7nU0Bu7nWbl60xi/q7gF8I+zxbnjw6vZmyPa
 BK16qGT/lfFgubgYFDJovpIdLEa0zGejc4yFodAMqpyj62HKRqBWpbklk
 uYHBa2j9J0Baz1yvpAtl4jeS1Or3Txb4zxIftNrlO2pT25QkxecG5AFRF
 lcwQjwdnkODEL2F92W3Mgsc1Ioh6/WE2FFv7gCfK0+ftNr/SxXmjTopF9 A==;
X-CSE-ConnectionGUID: OEXazsvjRbeAeFDgnHQU3Q==
X-CSE-MsgGUID: rKLal4RYSR+TBRn1upKriQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88624803"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88624803"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:51:37 -0700
X-CSE-ConnectionGUID: 6+1e5spcSxuWNXWaZladeQ==
X-CSE-MsgGUID: 3Q4lN6uUS0a41VChfW1DKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="267538533"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by orviesa006.jf.intel.com with ESMTP; 01 Sep 2026 22:51:35 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v4 0/3] ethdev: add Tx timestamp slot APIs
Date: Wed,  2 Sep 2026 11:21:21 +0530
Message-ID: <20260902055125.836268-1-rajesh3.kumar@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827122200.339388-2-rajesh3.kumar@intel.com>
References: <20260827122200.339388-2-rajesh3.kumar@intel.com>
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

The ethdev timesync API currently exposes Tx timestamps through a shared
hardware register. This requires applications to serialize timestamped
packets and does not allow correlation when multiple packets are in
flight.

This RFC proposes an ethdev interface for hardware with independent Tx
timestamp slots. The interface reports the supported timestamping
mechanism, provides a port-global slot lifecycle, and lets applications
poll each slot asynchronously after transmission.

The proposal includes the following components:

* Capability reporting for shared-register and per-packet timestamping.
* Slot allocation, asynchronous timestamp retrieval, and slot release.
* A dual-domain timestamp structure for adjusted PHC and raw hardware
  time.
* Mbuf dynamic field and dynflag support for passing slot handles to Tx,
  with a helper that stamps a slot handle onto an mbuf.
* Registration and process-local reset of the cached dynfield state.
* An ice PMD implementation using the 64 per-port PHY timestamp slots.
* A testpmd command to report the slot capabilities of a port.
* Programmer-guide and NIC feature documentation.

The legacy rte_eth_timesync_read_tx_timestamp() API remains available on
devices using a shared timestamp register.

Changes since v3:

* Added an ice PMD implementation of the new slot ops. The ice PHY
  exposes 64 Tx timestamp slots per port, which are now tracked in an
  atomic per-adapter bitmap instead of the single static slot the driver
  used before. On E822 the 64 quad slots are split evenly between the
  PFs sharing the quad so allocations never overlap.
* The ice Tx context descriptor now takes the timestamp index from the
  mbuf dynamic field when the packet carries the slot dynflag, and falls
  back to the legacy static index otherwise.
* The ice legacy single-slot read path now uses ptp_tx_index instead of
  a hardcoded slot 0, and clears the PHY timestamp on E810 after a read
  or a timeout so a stale entry cannot block later requests.
* Added a testpmd command, "show port <port_id> tx_timestamp_caps", that
  reports the slot capabilities of a port and performs an allocate and
  release round-trip to exercise the API.

Comments and suggestions on the interface and the ice implementation are
welcome.

Rajesh Kumar (3):
  ethdev: add Tx timestamp slot management APIs
  net/ice: support per-packet Tx timestamp slots
  app/testpmd: add Tx timestamp capabilities command

 app/test-pmd/cmdline.c                    |  79 ++++++
 doc/guides/nics/features.rst              |  16 +-
 doc/guides/prog_guide/ethdev/index.rst    |   1 +
 doc/guides/prog_guide/ethdev/timesync.rst | 223 +++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst    |   7 +
 drivers/net/intel/ice/ice_ethdev.c        | 210 +++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h        |   2 +
 drivers/net/intel/ice/ice_rxtx.c          |  11 +-
 lib/ethdev/ethdev_driver.h                |  25 ++
 lib/ethdev/rte_ethdev.c                   | 202 ++++++++++++++++
 lib/ethdev/rte_ethdev.h                   | 278 ++++++++++++++++++++++
 11 files changed, 1047 insertions(+), 7 deletions(-)
 create mode 100644 doc/guides/prog_guide/ethdev/timesync.rst

-- 
2.55.0

