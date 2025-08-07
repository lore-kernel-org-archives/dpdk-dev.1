Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11090C87FCA
	for <dpdk-dev@archiver.kernel.org>; Thu,  7 Aug 2025 12:39:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A91E402D0;
	Thu,  7 Aug 2025 14:39:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id E17654027C
 for <dev@dpdk.org>; Thu,  7 Aug 2025 14:39:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754570395; x=1786106395;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Efh1cI8OvVUwwBrdRjk+phhRdjgH+je3UX4NJfA9Fo8=;
 b=bO5aXP4BgqPkNmCTtnDc0u6D7N45dUk20iuVjAvjco0Dgs0732zBG0EJ
 2IOP4wjB11vE2K+K7iQu3rL9rXdjxc5DH3nIt8rFKM4LZuk8TpgJ+SMwo
 gHdvLe2X0Q73kanHPPoPyPQF1Qu0e4TNw0E6CMXRl2oMjsU0TBSgJuXds
 jnN4w9KOc33VnfHqvpRHfJXQpEfLJxil5bsqHNVct34aK9T3LGWUWSa/a
 NSkURHTRdazCMl3znT9hqRJRbbiLAEyfRIyHJLXDkmKq1nwv6laMKTVVI
 cwiTkxjk+TJ3DUafvrk6vYSFXN+d5jKiXbfp7gIQjPs1MDPH0VFuU2oP2 w==;
X-CSE-ConnectionGUID: dPPzOsF8S72TdbIr1iaMcQ==
X-CSE-MsgGUID: BqnLzUQzS8mm/w/YURq+mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="56981109"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="56981109"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2025 05:39:53 -0700
X-CSE-ConnectionGUID: i0DOtjjnSvamwPvqRuON1g==
X-CSE-MsgGUID: z1zMJagQQZqKxwMOc7iAXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; d="scan'208";a="195886694"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by fmviesa001.fm.intel.com with ESMTP; 07 Aug 2025 05:39:53 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 00/15] net/intel: rx path selection simplification
Date: Thu,  7 Aug 2025 12:39:34 +0000
Message-Id: <20250807123949.4063416-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725124919.3564890-1-ciara.loftus@intel.com>
References: <20250725124919.3564890-1-ciara.loftus@intel.com>
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

This series aims to simplify the process of selecting an Rx burst
function for the i40e, iavf and ice drivers. Three main simplifications
are made:
1. enforcing the same rx burst function for both primary and secondary
processes.
2. using a common function for determining the maximum SIMD width based
on compiler flags, CPU flags and user-defined limits.
3. using a common function for selecting the rx burst function based on
maximum SIMD width, function features (flex desc, scattered, bulk alloc)
and requested rx offloads.

v2:
* use booleans instead of a mask to represent path features
* updated ci_rx_path_select() to improve readability
* removed check for RTE_CPUFLAG_AVX512F in AVX2 support check
* reordered enum i40e_rx_func_type and i40e_rx_path_infos array
* renamed "burst" to "path" in various places
* reordered iavf_rx_func_type and iavf_rx_path_infos array
* reordered ice_rx_func_type and ice_rx_path_infos array
* fixed secondary process path selection for ice

Bruce Richardson (1):
  net/intel: introduce common vector capability function

Ciara Loftus (14):
  net/ice: use the same Rx path across process types
  net/iavf: rename Rx/Tx function type variables
  net/iavf: use the same Rx path across process types
  net/i40e: use the same Rx path across process types
  net/ice: use the new common vector capability function
  net/iavf: use the new common vector capability function
  net/i40e: use the new common vector capability function
  net/iavf: remove redundant field from iavf adapter struct
  net/ice: remove unsupported Rx offload
  net/iavf: reorder enum of Rx function types
  net/intel: introduce infrastructure for Rx path selection
  net/ice: use the common Rx path selection infrastructure
  net/iavf: use the common Rx path selection infrastructure
  net/i40e: use the common Rx path selection infrastructure

 drivers/net/intel/common/rx.h                 | 103 ++++
 drivers/net/intel/common/rx_vec_x86.h         |  22 +
 drivers/net/intel/i40e/i40e_ethdev.h          |  25 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 251 ++++------
 drivers/net/intel/i40e/i40e_rxtx.h            |  16 +
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 +
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   9 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 +
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |   6 +
 drivers/net/intel/iavf/iavf.h                 |  31 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |   1 -
 drivers/net/intel/iavf/iavf_rxtx.c            | 444 ++++++------------
 drivers/net/intel/iavf/iavf_rxtx.h            |  51 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  14 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |   6 +
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |   6 +
 drivers/net/intel/ice/ice_ethdev.c            |   2 +
 drivers/net/intel/ice/ice_ethdev.h            |  25 +-
 drivers/net/intel/ice/ice_rxtx.c              | 274 ++++-------
 drivers/net/intel/ice/ice_rxtx.h              |  29 ++
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  18 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c      |   6 +
 22 files changed, 644 insertions(+), 707 deletions(-)

-- 
2.34.1

