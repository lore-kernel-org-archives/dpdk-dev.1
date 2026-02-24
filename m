Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3849F3C997
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 15:14:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 258644027F;
	Tue, 24 Feb 2026 16:14:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 750E2400D5
 for <dev@dpdk.org>; Tue, 24 Feb 2026 16:14:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1771946081; x=1803482081;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=OAZoJhxJg44SRkaf5MBcbhsUDi/SoGls4Uxzz4KnDCw=;
 b=DmCTCAkFL/M7bNE0f1G2D9vpXEJLt9IjrJkphJy4nw6MQpdInw1MdVJy
 V1zsfvucqPIFbg8NyEypsirRTgiEwNstxcA5b4tta82O4GxT0eA8chSVr
 agp/Hnv3MiwPBRKiWsIAPgpKeAxK5F98BaL4CMJjG35Zi3j2CVajctUos
 2K74NLbAv3qkpxruXN8FqkX5elq6UbTeMSeEyO4EnEwYfn8oZhDlohWj9
 DYDVVYX3lDohi57cO5tF/C6wayILVKTOyVMz+bx6Rh82W+hcJ/HWbQtt7
 WWuLgQmauAU0SyksSzHY8smJMAOaq2PGxIdEXAI1hUBDakPXnt7giDfLS g==;
X-CSE-ConnectionGUID: bYgoN+1uT5CcxVlv2DYbMQ==
X-CSE-MsgGUID: VZxWdl4lQKaMzHY/13nOqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84056234"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="84056234"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2026 07:14:40 -0800
X-CSE-ConnectionGUID: HgFkas/zS3O38eyIzmULrw==
X-CSE-MsgGUID: in6bjLt7T2i1cIBXF/Y95w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; d="scan'208";a="220526060"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 24 Feb 2026 07:14:39 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v9 00/26] Cleanups for ixgbe, i40e, iavf, and ice PMD's
Date: Tue, 24 Feb 2026 15:14:05 +0000
Message-ID: <cover.1771945933.git.anatoly.burakov@intel.com>
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

Note that this patchset depends on driver bug fix patchset [1] as well as an
IPsec struct fix [2] (both already integrated into next-net-intel).

[1] https://patches.dpdk.org/project/dpdk/list/?series=37350
[2] https://patches.dpdk.org/project/dpdk/patch/c87355f75826ec90a506dc8d4548e3f6af2b7e93.1771581658.git.anatoly.burakov@intel.com/

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

v6 -> v7:
- Fixed offset logic in IRQ map
- (Hopefully) fixed zero-sized array initialization error for MSVC

v7 -> v8:
- Reverted to using calloc for IPsec patch because MSVC doesn't like
  stack-initialized structs with zero-sized array members
- Merged two IPsec patches together

v8 -> v9:
- Fixed testing failures in IAVF on account of "wrong" adminq buffer sizes

Anatoly Burakov (26):
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
  net/iavf: avoid rte malloc in queue operations
  net/iavf: avoid rte malloc in irq map config
  net/ice: avoid rte malloc in RSS RETA operations
  net/ice: avoid rte malloc in MAC address operations
  net/ice: avoid rte malloc in raw pattern parsing
  net/ice: avoid rte malloc in flow pattern match

 drivers/net/intel/i40e/i40e_ethdev.c         | 370 +++++++---------
 drivers/net/intel/i40e/i40e_ethdev.h         |  26 +-
 drivers/net/intel/i40e/i40e_flow.c           | 147 +++----
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
 drivers/net/intel/iavf/iavf_ipsec_crypto.c   |  61 ++-
 drivers/net/intel/iavf/iavf_vchnl.c          | 432 ++++++++++---------
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
 28 files changed, 740 insertions(+), 882 deletions(-)

-- 
2.47.3

