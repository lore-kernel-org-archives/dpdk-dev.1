Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0C0EA8130
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 16:14:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E045F40608;
	Tue, 10 Feb 2026 17:14:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 55BC7400D7
 for <dev@dpdk.org>; Tue, 10 Feb 2026 17:14:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770740046; x=1802276046;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=N7fsYwO3skkOepQLrlCg7aG2MbnHGT0eqnZmzvegOdI=;
 b=W5sNcHRMlGrQSZiA6O3WNZyaV3UqZfGbu+3fwmptwn0cRaiZ642OfxoF
 /6yfHUKG9oeph66o0IlbdlDafu5E4YFkIWe4VYWDKvc6UN6jnK5Pa38/Z
 r8e+ORnqOureRRwag8SUICy/Gso4J7OH/3UvUacE39ik9OKKy1regHt9J
 6cg9dLrAaw02eLw467m+soronpatlDmL2rRLGRP6k4NngPfUa9AzD0bzK
 lG1VkQtDy+30N6fMM5WJlB+9VDWmXD7DrE/+Bjxl2lTigzcORg+Hocivo
 ahPDz5nAArMKt889gx3zfUL3sYgCTgbrYI52ednUHmru/RHJx07pbZylu g==;
X-CSE-ConnectionGUID: 86pAaO4FQpmMrVC1XnEMWQ==
X-CSE-MsgGUID: nxVXMAV8R6yHWk+UpTmB4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="89286173"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="89286173"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 08:14:04 -0800
X-CSE-ConnectionGUID: 6+55NFPsRrGL6tVfMj+HlA==
X-CSE-MsgGUID: 3VLpDceITCaOeIbvNViAJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="216127698"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 10 Feb 2026 08:14:04 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 00/26] Cleanups for ixgbe, i40e, iavf, and ice PMD's
Date: Tue, 10 Feb 2026 16:13:29 +0000
Message-ID: <cover.1770739924.git.anatoly.burakov@intel.com>
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

Note that IXGBE part of this patchset depends on MAC type check fixes [1].

[1] https://patches.dpdk.org/project/dpdk/patch/23738c8f043b1f65742744caa9b725d5474cb059.1770738711.git.anatoly.burakov@intel.com/

v1 -> v2:
- Added more cleanups around rte_malloc usage

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
  net/iavf: do not use malloc in crypto VF commands
  net/iavf: decouple hash uninit from parser uninit
  net/iavf: avoid rte malloc in RSS configuration
  net/iavf: avoid rte malloc in MAC address operations
  net/iavf: avoid rte malloc in IPsec operations
  net/iavf: avoid rte malloc in queue operations
  net/iavf: avoid rte malloc in irq map config
  net/ice: avoid rte malloc in RSS RETA operations
  net/ice: avoid rte malloc in MAC address operations
  net/ice: avoid rte malloc in raw pattern parsing

 drivers/net/intel/i40e/i40e_ethdev.c         | 223 +++++++++----------
 drivers/net/intel/i40e/i40e_ethdev.h         |  24 +-
 drivers/net/intel/i40e/i40e_flow.c           | 146 ++++++------
 drivers/net/intel/i40e/i40e_hash.c           |  27 ++-
 drivers/net/intel/i40e/i40e_hash.h           |   3 +
 drivers/net/intel/i40e/i40e_pf.c             |  26 +--
 drivers/net/intel/i40e/rte_pmd_i40e.c        |  59 ++---
 drivers/net/intel/iavf/iavf_ethdev.c         |   8 +-
 drivers/net/intel/iavf/iavf_fdir.c           |   1 -
 drivers/net/intel/iavf/iavf_fsub.c           |   1 -
 drivers/net/intel/iavf/iavf_generic_flow.h   |  15 --
 drivers/net/intel/iavf/iavf_hash.c           |  14 +-
 drivers/net/intel/iavf/iavf_hash.h           |  13 ++
 drivers/net/intel/iavf/iavf_ipsec_crypto.c   | 216 ++++++------------
 drivers/net/intel/iavf/iavf_vchnl.c          |  85 +++----
 drivers/net/intel/ice/ice_dcf_ethdev.c       |   8 +-
 drivers/net/intel/ice/ice_ethdev.c           |   8 +-
 drivers/net/intel/ice/ice_fdir_filter.c      |  14 +-
 drivers/net/intel/ice/ice_hash.c             |  10 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c       |   8 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.h       |  16 --
 drivers/net/intel/ixgbe/ixgbe_flow.c         | 162 +++++++++-----
 drivers/net/intel/ixgbe/ixgbe_rxtx.c         |  26 ---
 drivers/net/intel/ixgbe/ixgbe_rxtx.h         |   2 -
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c |   6 -
 25 files changed, 496 insertions(+), 625 deletions(-)
 create mode 100644 drivers/net/intel/iavf/iavf_hash.h

-- 
2.47.3

