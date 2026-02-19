Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49674E9A03B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Feb 2026 16:23:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12FA7402ED;
	Thu, 19 Feb 2026 17:23:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 097AD402AA
 for <dev@dpdk.org>; Thu, 19 Feb 2026 17:23:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771518199; x=1803054199;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=02Whfr21OWE2UNZuzBSirTSyotMkd39aC4Y2HjmDOsU=;
 b=Zvv4gWGl8oJPioz9nNwCvXPDeL4/NtFsPzVvot5/QRL0T1yJkRC+jIg3
 J6BWOD2NwnD9GB5rPR8yXehyBywxRy4nC2F+v5HJlQR1FpbLt+SHgi8Zn
 2FaKaZXgl/rcD0yfAz42hE16vu1PhKkmAj2TvYTu9GlpeYZbArRd9KiA8
 6ti00UK12G39jEyVdMPlDl7LD2RLs8MLHJ+TheGQbrn4gews+sXh7SXgY
 1K6Uugn/VO0Ow0+RNVyiHPyTj6PDxtxvXdQ4cR91RwwomefOtMOiH6zbx
 YaxNOmM9IThfsEHiqBJunhNz/WIxr848Bh0WKLcfScD+qAgnNovfIrzaW A==;
X-CSE-ConnectionGUID: lM/5ZfROStaWxlTxxy033Q==
X-CSE-MsgGUID: T5vk7DCVSKCkWrHXnXn07Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11706"; a="83231420"
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="83231420"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2026 08:23:18 -0800
X-CSE-ConnectionGUID: xbZgbhAkR8WNqWYkkvf/Xg==
X-CSE-MsgGUID: yQcT81lJSKOUdZTC5O1zkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,300,1763452800"; d="scan'208";a="218699771"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 19 Feb 2026 08:23:18 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 00/27] Cleanups for ixgbe, i40e, iavf, and ice PMD's
Date: Thu, 19 Feb 2026 16:22:43 +0000
Message-ID: <cover.1771518103.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770646012.git.anatoly.burakov@intel.com>
References: <cover.1770646012.git.anatoly.burakov@intel.com>
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

This patchset is an assortment of cleanups for ixgbe, i40e, iavf, and ice PMD.

IXGBE:

- Remove unnecessary macros and #ifdef's
- Disentangle unrelated flow API code paths

I40E:

- Get rid of global variables and unnecessary allocations
- Reduce code duplication around default RSS keys
- Use more appropriate integer types and definitions

IAVF:

- Remove dead code
- Remove unnecessary allocations
- Separate RSS uninit from hash flow parser uninit

ICE:

- Remove unnecessary allocations

This is done in preparation for further rework.

Note that this patchset depends on driver bug fix patchset [1] (already integrated into next-net-intel).

[1] https://patches.dpdk.org/project/dpdk/list/?series=37350

v1 -> v2:
- Added more cleanups around rte_malloc usage

v2 -> v3:
- Reworded some commit messages
- Added a new patch for ICE
- Rebased on latest bug fix patches

v3 -> v4:
- Rebased on latest bugfix patchset

v4 -> v5:
- Adjusted typing for queue size
- Fixed missing zero initializations for stack allocations

v5 -> v6:
- Addressed feedback for v3, v4, and v5
- Changed more allocations to be stack based
- Reworked queue and IRQ map related i40e patches for better logic

Anatoly Burakov (27):
  net/ixgbe: remove MAC type check macros
  net/ixgbe: remove security-related ifdefery
  net/ixgbe: split security and ntuple filters
  net/i40e: get rid of global filter variables
  net/i40e: make default RSS key global
  net/i40e: use unsigned types for queue comparisons
  net/i40e: use proper flex len define
  net/i40e: remove global pattern variable
  net/i40e: avoid rte malloc in tunnel set
  net/i40e: avoid rte malloc in RSS RETA operations
  net/i40e: avoid rte malloc in MAC/VLAN filtering
  net/i40e: avoid rte malloc in VF resource queries
  net/i40e: avoid rte malloc in adminq operations
  net/i40e: avoid rte malloc in DDP package handling
  net/i40e: avoid rte malloc in DDP ptype handling
  net/iavf: remove remnants of pipeline mode
  net/iavf: decouple hash uninit from parser uninit
  net/iavf: avoid rte malloc in VF mailbox for IPsec
  net/iavf: avoid rte malloc in RSS configuration
  net/iavf: avoid rte malloc in MAC address operations
  net/iavf: avoid rte malloc in IPsec operations
  net/iavf: avoid rte malloc in queue operations
  net/iavf: avoid rte malloc in irq map config
  net/ice: avoid rte malloc in RSS RETA operations
  net/ice: avoid rte malloc in MAC address operations
  net/ice: avoid rte malloc in raw pattern parsing
  net/ice: avoid rte malloc in flow pattern match

 drivers/net/intel/i40e/i40e_ethdev.c         | 370 +++++++----------
 drivers/net/intel/i40e/i40e_ethdev.h         |  26 +-
 drivers/net/intel/i40e/i40e_flow.c           | 147 ++++---
 drivers/net/intel/i40e/i40e_hash.c           |  27 +-
 drivers/net/intel/i40e/i40e_hash.h           |   3 +
 drivers/net/intel/i40e/i40e_pf.c             |  26 +-
 drivers/net/intel/i40e/rte_pmd_i40e.c        |  60 +--
 drivers/net/intel/iavf/iavf.h                |   7 +-
 drivers/net/intel/iavf/iavf_ethdev.c         |  37 +-
 drivers/net/intel/iavf/iavf_fdir.c           |   1 -
 drivers/net/intel/iavf/iavf_fsub.c           |   1 -
 drivers/net/intel/iavf/iavf_generic_flow.h   |  15 -
 drivers/net/intel/iavf/iavf_hash.c           |  13 +-
 drivers/net/intel/iavf/iavf_ipsec_crypto.c   | 283 +++++--------
 drivers/net/intel/iavf/iavf_vchnl.c          | 412 ++++++++++---------
 drivers/net/intel/ice/ice_acl_filter.c       |   3 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c       |  26 +-
 drivers/net/intel/ice/ice_ethdev.c           |  29 +-
 drivers/net/intel/ice/ice_fdir_filter.c      |  19 +-
 drivers/net/intel/ice/ice_generic_flow.c     |  15 +-
 drivers/net/intel/ice/ice_hash.c             |  13 +-
 drivers/net/intel/ice/ice_switch_filter.c    |   5 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c       |   8 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.h       |  16 -
 drivers/net/intel/ixgbe/ixgbe_flow.c         | 228 ++++++----
 drivers/net/intel/ixgbe/ixgbe_rxtx.c         |  26 --
 drivers/net/intel/ixgbe/ixgbe_rxtx.h         |   2 -
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c |   6 -
 28 files changed, 783 insertions(+), 1041 deletions(-)

-- 
2.47.3

