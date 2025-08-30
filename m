Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7F5CA0FFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 17:17:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F57D402E3;
	Sat, 30 Aug 2025 19:17:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 54EC640276
 for <dev@dpdk.org>; Sat, 30 Aug 2025 19:17:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756574234; x=1788110234;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4gdRw6nqo0L4AD5ISdNRnteLzv9rtQIe2mLc+fmC8NY=;
 b=dZNJZOME9M0vcZmAzrgm6LKWHo9D3TNBBnZXpn3i+O1v5IaMfehT7vmd
 rLyG680fG/OzP3r6Hs+CtdVV6+yt4Q/cJj2/XzxOyzHmy5oRT1OanAlKa
 K50Gm+9OkBywL/gNlxGUYkYxelYAlhdFkR67rryvx2NDvMojJYZZsJnKb
 /al61F3LeXO2ql+DMwOS1Me6J03Qew9SoW8zCcLJnwqb+N3nLRKSXbCjN
 UKRKlC1WTxduyWjxj2s9Ug9JuwbnRJ2qV/DMqaHmcAR6D+XCetOTbk8KK
 BAltVGFkfZ5OaC2Za5bgl9mPIfIFbH2IQBHVqRPebUmDEz2+GK9yzzK/t A==;
X-CSE-ConnectionGUID: Fb50pW4iRtaDHwbMIHKW0A==
X-CSE-MsgGUID: lNzEzggfQqO6aHSfGRLT1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58781185"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58781185"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2025 10:17:12 -0700
X-CSE-ConnectionGUID: YwTPuTpuSlmfR5715HhsjA==
X-CSE-MsgGUID: TBY3cRpqTYmPz4bbP7qnaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,225,1751266800"; d="scan'208";a="174966866"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 30 Aug 2025 10:17:10 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com, thomas@monjalon.net,
 andrew.rybchenko@oktetlabs.ru, stephen@networkplumber.org
Subject: [RFC PATCH 0/6] ethdev: refactor and extend DCB configuration API
Date: Sat, 30 Aug 2025 17:17:00 +0000
Message-ID: <20250830171706.428977-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
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

Hi all,

This series reworks the ethdev API related to advanced queueing configuration,
specifically Data Center Bridging (DCB) and Virtual Machine Device Queues
(VMDq). The existing API was designed years ago around ixgbe hardware
assumptions, which makes it difficult to properly support modern NICs and their
more flexible capabilities.

The main goals of this refactoring are:

Unify duplicated DCB configuration structures for Tx and Rx.

Extend the API to better align with the DCB specification (e.g., TSA, per-TC
bandwidth allocation).

Decouple VMDq and DCB configuration so they can be used independently.

Enable explicit configuration of queue mappings instead of relying on
driver-specific behavior.

Clean up legacy or redundant fields that were artifacts of early
implementations.

Place multi-queue mode settings in a more consistent location within the
configuration API.

Overall, this makes the API more expressive, more consistent, and more
future-proof for modern hardware, while simplifying driver implementations.

Patch summary:

ethdev: extend and refactor DCB configuration
Introduce a common structure for Rx/Tx DCB configuration and extend it with missing DCB spec features.

ethdev: remove nb_tcs from rte_eth_dcb_conf structure
Drop legacy traffic class count field which drivers can derive from config.

ethdev: decouple VMDq and DCB configuration
Remove unnecessary coupling and redundant structures

ethdev: extend VMDq/DCB configuration with queue mapping
Allow explicit queue mapping configuration in API.

ethdev: remove dcb_capability_en from rte_eth_conf
Drop unused or misused DCB capability flags in favor of per-TC PFC API.

ethdev: move mq_mode to [r,t]x_adv_conf
Relocate mq_mode to advanced config, and make it a flag field.

This is an API-breaking series, but it is expected to make the interface cleaner
and more aligned with modern NIC capabilities. Feedback on both the design
direction and implementation details is very welcome.

Note: This RFC series reflects changes only for ice PMD and testpmd app
(no other drivers or examples apps was changed) and depends on:
https://patches.dpdk.org/project/dpdk/list/?series=35948
thus configure your build like:
meson setup -Denable_drivers=net/intel/ice

Vladimir Medvedkin (6):
  ethdev: extend and refactor DCB configuration
  ethdev: remove nb_tcs from rte_eth_dcb_conf structure
  ethdev: decouple VMDq and DCB cofiguration
  ethdev: extend VMDq/DCB configuration with queue mapping
  ethdev: remove dcb_capability_en from rte_eth_conf
  ethdev: move mq_mode to [r,t]x_adv_conf

 app/graph/ethdev.c                       |   6 +-
 app/test-eventdev/test_perf_common.c     |   4 +-
 app/test-eventdev/test_pipeline_common.c |   4 +-
 app/test-pipeline/init.c                 |   2 +-
 app/test-pmd/cmdline.c                   |  27 +---
 app/test-pmd/parameters.c                |   4 +-
 app/test-pmd/testpmd.c                   | 153 +++++++++++---------
 app/test-pmd/testpmd.h                   |   5 +-
 app/test/test_event_eth_rx_adapter.c     |   4 +-
 app/test/test_link_bonding.c             |   4 +-
 app/test/test_link_bonding_rssconf.c     |   8 +-
 app/test/test_pmd_perf.c                 |   4 +-
 app/test/test_security_inline_macsec.c   |  12 +-
 app/test/test_security_inline_proto.c    |  12 +-
 drivers/net/intel/ice/ice_dcf.c          |   2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c   |   2 +-
 drivers/net/intel/ice/ice_ethdev.c       | 137 ++++++++++--------
 drivers/net/intel/ice/ice_rxtx.c         |  27 ++--
 lib/ethdev/ethdev_trace.h                |   4 +-
 lib/ethdev/rte_ethdev.c                  |  10 +-
 lib/ethdev/rte_ethdev.h                  | 169 ++++++++---------------
 21 files changed, 294 insertions(+), 306 deletions(-)

-- 
2.43.0

