Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24896C79F82
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:32:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 169234026E;
	Tue,  8 Sep 2026 09:32:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 49C7D4026A
 for <dev@dpdk.org>; Tue,  8 Sep 2026 09:32:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788852749; x=1820388749;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zAMZxUup2LB+4c68ERl32UVGsfpM/cdzq+Ez/XhjQxM=;
 b=oDb2PFxTVEOXUXfnulIYjd7UW6MM9+MUdtRD0YnZ86Mf7zyKVnOwr0cZ
 aBVa0yoYMV6I0EwOX27S9uSiWySJYDQSvnKts16cdbUDwNMogo1DyE7JP
 MCjrypztki7U0cc3Gkfney381xGoRNN2ny3TVLOqo/AV7PK2/zSYWj5rv
 6tuZDKV8I0asei7bzwr4RSz/VzObxmNVPlrDzx8vH4Bvlk7/MqSipvaul
 UGup7eU706s9cj2TvevHW8ACSqGv0QvtNE/HyZHqUWi4ZsZC3alCvv6ZP
 8lhWxO3D2AzcnNkMYCJ9AYltmGDeSX5uy3xXlKSaYgfpgsRaBD1zpfYPW Q==;
X-CSE-ConnectionGUID: 6xJrP07iQjeouvOLXxynaA==
X-CSE-MsgGUID: Da2Wv4oJR/Ghwc2BXlk8yg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89290170"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89290170"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:32:28 -0700
X-CSE-ConnectionGUID: ia8KB+6HQqqy3wL6Lj5Pdw==
X-CSE-MsgGUID: 4/9UoMhYTOy8lU9NTJofYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="275057019"
Received: from unknown (HELO icx008-fc43.iind.intel.com) ([10.190.212.196])
 by orviesa005.jf.intel.com with ESMTP; 08 Sep 2026 00:32:25 -0700
From: Rajesh Kumar <rajesh3.kumar@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, bruce.richardson@intel.com,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org,
 aman.deep.singh@intel.com, Rajesh Kumar <rajesh3.kumar@intel.com>
Subject: [RFC PATCH v5 0/5] ethdev: add Tx timestamp slot APIs
Date: Tue,  8 Sep 2026 13:02:01 +0530
Message-ID: <20260908073206.1236372-1-rajesh3.kumar@intel.com>
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
* Programming guide documentation, split into a patch describing the
  pre-existing clock/Rx timesync API and a patch describing the new Tx
  timestamp slot feature.

The legacy rte_eth_timesync_read_tx_timestamp() API remains available on
devices using a shared timestamp register.

Changes since v4:

* Fixed review comments and AI observation.
* Consolidated the Tx timestamp slot API naming onto a single
  rte_eth_timesync_tx_slot_{caps,alloc,read,release,stamp} prefix,
  replacing the previous mix of tx_timestamp_slot_*, tx_ts_*, and
  tx_slot_* spellings across the public API, PMD ops, and the ice
  implementation.
* Dropped the per-port cached slot-info array in favor of a single
  process-local dynfield offset/dynflag pair.
* Split the programming guide documentation out of the ethdev patch
  into two dedicated patches: one documenting the pre-existing
  clock/Rx timesync API, and one documenting the new Tx timestamp slot
  feature, so review of the new functionality is not mixed with review
  of already-existing behavior.
* Fixed inconsistent TX/Tx casing in comments, log messages, and
  documentation to consistently use "Tx".

Comments and suggestions on the interface and the ice implementation are
welcome.

Rajesh Kumar (5):
  ethdev: add Tx timestamp slot management APIs
  doc: describe ethdev timesync clock and Rx timestamp API
  doc: describe ethdev Tx timestamp slot API
  net/ice: support per-packet Tx timestamp slots
  app/testpmd: add Tx timestamp capabilities command

 app/test-pmd/cmdline.c                    |  79 ++++++++
 doc/guides/nics/features.rst              |  15 +-
 doc/guides/prog_guide/ethdev/index.rst    |   1 +
 doc/guides/prog_guide/ethdev/timesync.rst | 219 +++++++++++++++++++++
 doc/guides/rel_notes/release_26_11.rst    |   7 +
 drivers/net/intel/ice/ice_ethdev.c        | 211 ++++++++++++++++++++-
 drivers/net/intel/ice/ice_ethdev.h        |   2 +
 drivers/net/intel/ice/ice_rxtx.c          |   9 +-
 lib/ethdev/ethdev_driver.h                |  28 +++
 lib/ethdev/rte_ethdev.c                   | 151 ++++++++++++++-
 lib/ethdev/rte_ethdev.h                   | 220 ++++++++++++++++++++++
 11 files changed, 933 insertions(+), 9 deletions(-)
 create mode 100644 doc/guides/prog_guide/ethdev/timesync.rst

-- 
2.55.0

