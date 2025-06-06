Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CDB5C5AD49
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 17:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1599C402F2;
	Fri,  6 Jun 2025 19:09:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id E6BF440263
 for <dev@dpdk.org>; Fri,  6 Jun 2025 19:09:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749229770; x=1780765770;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1ElObv5DRfqnW0oj6L2MY2J0/CsDeaMsXCjAne13nHY=;
 b=AvAeR2BJPeRVdGyUAGWA+Ufcev/mAclb3zg2UV4nJxPe+h+WO/pShN94
 4lmetUMMJQzzEZ7absBbYcd3VmltbtphyqoOMD1H2ZXhZ0yjxs/kx6Z89
 ZEPJ//IaXV2GvjIDTXGtmJHuX9xCyytR8fds2wPTlcWfluULKRQ11+pG9
 +PckmqU+MX/dU8EanvVpo/uEdnJ4IU+lMAccV/l2Z4TIjLdXoeqLXZPgH
 jVjrQEJXWJQ6kKv6pSmRwi98dOAQMhweYvPObkst9yNop1Zb4zIRJMiOL
 PXSskV4xNO2LphvjBgR7qN7l/XK5fdwUfE/Imtu4VThA79KoOIl080K2M Q==;
X-CSE-ConnectionGUID: JX5WKnW5Q/udLDET3Rcr1Q==
X-CSE-MsgGUID: 10SQLGD4RMyQn/u6bPnuKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11456"; a="68828375"
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="68828375"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jun 2025 10:09:29 -0700
X-CSE-ConnectionGUID: o5Z8uqfPQ32nWUao+xl0yQ==
X-CSE-MsgGUID: TvwMu+g/QBm60VSZKwULqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,215,1744095600"; d="scan'208";a="145808041"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa010.jf.intel.com with ESMTP; 06 Jun 2025 10:09:28 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v5 00/34] Intel PMD drivers Rx cleanup
Date: Fri,  6 Jun 2025 18:08:39 +0100
Message-ID: <cover.1749229650.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
References: <c92131e8fcce1901018450bdf97ae004253addf7.1746538072.git.anatoly.burakov@intel.com>
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

There is certain amount of duplication between different ixgbe, i40e, ice, and
iavf. This patchset specifically focuses on laying groundwork for deduplicating
the Rx side of things - providing common queue definitions, using common Rx
descriptor formats, and some low hanging fruit in terms of Rx code
deduplication, including vectorized implementations.

The first bunch of patches focus on small cleanups:

- variable renames
- definition renames
- using one definition for 16-byte descriptors instead per-driver
- fixing some cruft in IXGBE headers and source code
- refactoring of IXGBE vector code
- removing support for 16-byte descriptors from IAVF

Starting with patch 24 comes the meat of the patchset:

- creating common Rx queue structure
- unifying Rx rearm code to make use of new unified structures and definitions
- expanding Rx rearm code to have SSE, AVX2, and AVX512 implementations

At the end, there are a couple of patches that unify Rx and Tx mbuf recycle
for some drivers, but more work is needed on that front because we only touch
two drivers in each case - the others do have them, but they're implemented
differently from the ones that were deduplicated.

v5:
- Added refactors in IXGBE
- Addressed various bits of feedback
- Removed support for 16-byte descriptors from IAVF

v3 -> v4:
- Added a lot of cleanups to the patchset
- Moved to using unified Rx descriptor definitions
- Using a single compilation flag to support 16-byte descriptors
- Fixes for whitespace, syntax, etc.

Anatoly Burakov (34):
  net/ixgbe: remove unused field in Rx queue struct
  net/iavf: make IPsec stats dynamically allocated
  net/ixgbe: match variable names to other drivers
  net/i40e: match variable name to other drivers
  net/ice: match variable name to other drivers
  net/i40e: rename 16-byte descriptor define
  net/ice: rename 16-byte descriptor define
  net/iavf: remove 16-byte descriptor define
  net/ixgbe: simplify packet type support check
  net/ixgbe: adjust indentation
  net/ixgbe: remove unnecessary platform checks
  net/ixgbe: make context desc creation non-static
  net/ixgbe: decouple scalar and vec rxq free mbufs
  net/ixgbe: rename vector txq free mbufs
  net/ixgbe: refactor vector common code
  net/ixgbe: move vector Rx/Tx code to vec common
  net/ixgbe: simplify vector PMD compilation
  net/ixgbe: replace always-true check
  net/ixgbe: add a desc done function
  net/ixgbe: clean up definitions
  net/i40e: clean up definitions
  net/ice: clean up definitions
  net/iavf: clean up definitions
  net/ixgbe: create common Rx queue structure
  net/i40e: use the common Rx queue structure
  net/ice: use the common Rx queue structure
  net/iavf: use the common Rx queue structure
  net/intel: generalize vectorized Rx rearm
  net/i40e: use common Rx rearm code
  net/iavf: use common Rx rearm code
  net/ixgbe: use common Rx rearm code
  net/intel: support wider x86 vectors for Rx rearm
  net/intel: add common Rx mbuf recycle
  net/intel: add common Tx mbuf recycle

 app/test-pmd/config.c                         |   4 +-
 config/rte_config.h                           |   2 +-
 doc/guides/nics/i40e.rst                      |   4 +-
 drivers/net/intel/common/desc.h               | 157 ++++++++
 .../recycle_mbufs.h}                          |  94 +++--
 drivers/net/intel/common/rx.h                 | 119 +++++-
 drivers/net/intel/common/rx_vec_arm.h         | 105 +++++
 drivers/net/intel/common/rx_vec_ppc.h         | 121 ++++++
 drivers/net/intel/common/rx_vec_x86.h         | 346 ++++++++++++++++
 drivers/net/intel/i40e/i40e_ethdev.c          |   4 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   4 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  18 +-
 drivers/net/intel/i40e/i40e_pf.c              |   2 +-
 .../i40e/i40e_recycle_mbufs_vec_common.c      | 127 +-----
 drivers/net/intel/i40e/i40e_rxtx.c            | 194 ++++-----
 drivers/net/intel/i40e/i40e_rxtx.h            |  87 +---
 drivers/net/intel/i40e/i40e_rxtx_common_avx.h | 215 ----------
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    | 135 ++-----
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  59 ++-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  59 ++-
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   4 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   | 124 ++----
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    | 130 ++----
 drivers/net/intel/iavf/iavf.h                 |   4 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |  13 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 269 ++++++-------
 drivers/net/intel/iavf/iavf_rxtx.h            | 178 +--------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  92 ++---
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c |  85 ++--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h | 219 +---------
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |  80 +---
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    | 153 ++-----
 drivers/net/intel/iavf/iavf_vchnl.c           |  20 +-
 drivers/net/intel/ice/ice_dcf.c               |   7 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |  27 +-
 drivers/net/intel/ice/ice_ethdev.c            |   2 +-
 drivers/net/intel/ice/ice_ethdev.h            |   4 +-
 drivers/net/intel/ice/ice_rxtx.c              | 222 +++++------
 drivers/net/intel/ice/ice_rxtx.h              |  92 +----
 drivers/net/intel/ice/ice_rxtx_common_avx.h   | 233 -----------
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  45 +--
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  53 ++-
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |   6 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c      | 125 ++----
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  25 +-
 drivers/net/intel/ixgbe/ixgbe_ipsec.c         |  10 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 377 +++++++-----------
 drivers/net/intel/ixgbe/ixgbe_rxtx.h          | 108 +----
 ...x_vec_common.h => ixgbe_rxtx_vec_common.c} | 206 +++++-----
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.h   | 148 ++-----
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_neon.c | 163 ++------
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c  | 176 ++------
 drivers/net/intel/ixgbe/meson.build           |   6 +-
 53 files changed, 2090 insertions(+), 3172 deletions(-)
 create mode 100644 drivers/net/intel/common/desc.h
 rename drivers/net/intel/{ixgbe/ixgbe_recycle_mbufs_vec_common.c => common/recycle_mbufs.h} (60%)
 create mode 100644 drivers/net/intel/common/rx_vec_arm.h
 create mode 100644 drivers/net/intel/common/rx_vec_ppc.h
 create mode 100644 drivers/net/intel/common/rx_vec_x86.h
 delete mode 100644 drivers/net/intel/i40e/i40e_rxtx_common_avx.h
 delete mode 100644 drivers/net/intel/ice/ice_rxtx_common_avx.h
 copy drivers/net/intel/ixgbe/{ixgbe_rxtx_vec_common.h => ixgbe_rxtx_vec_common.c} (53%)

-- 
2.47.1

