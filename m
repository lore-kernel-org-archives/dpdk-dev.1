Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA466EDF027
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Feb 2026 09:10:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7ABD402B2;
	Fri, 13 Feb 2026 10:10:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id BB3BA402A9
 for <dev@dpdk.org>; Fri, 13 Feb 2026 10:10:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770973821; x=1802509821;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=xKfSaSnRTO+dmlX+sLJYHkeCoPzciWZCPHoUDmJbZSQ=;
 b=EMYr4l4asxmYQow2GJqkoc3jK+H5e5h3bPb4sktkqSb6N/6jETVSUsO1
 TDt0quuzHWhbDZNc3QeEnQszkyB0gI73Run+MiQSs9+8L3L7Zl/roSRMc
 mW3ijWaom77biJ9rTQPh4sS/Cw4qIbi9P2xFJ4Kgn+W8X0iKuN9KaqiMR
 47NNJKqpxzzVBw1EX6Sg/3m/W/HTbcOQZkHR13fjfY5fjyUf+8po58Do7
 YS4VZdocuGYfaxOAs3JCDBC7FIym5ENrnURcMi9ITm/sxry0AjlZ5RKwj
 5ja8cBpVfBJTa92Y/Wq0nV/PDsrvrDrc5FQsrl/LxkVQG+wTzrFvDSDxq g==;
X-CSE-ConnectionGUID: RoXNbULHTTaO3/3fzjDcSA==
X-CSE-MsgGUID: eYECmyyOQ6C+DD7OWa6Hnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="89567848"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="89567848"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Feb 2026 01:10:20 -0800
X-CSE-ConnectionGUID: zQDIHf8lQVe/mD2efe1s+g==
X-CSE-MsgGUID: LwiHkyiqRI6C1Zyc+a3SbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; d="scan'208";a="211966023"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa006.jf.intel.com with ESMTP; 13 Feb 2026 01:10:19 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 00/12] Assortment of bug fixes for Intel PMD's
Date: Fri, 13 Feb 2026 09:10:02 +0000
Message-ID: <cover.1770973745.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <4084ed8c4f7c01852ca22c7975d0639fc4c8a066.1770641909.git.anatoly.burakov@intel.com>
References: <4084ed8c4f7c01852ca22c7975d0639fc4c8a066.1770641909.git.anatoly.burakov@intel.com>
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

Various bug fixes for Intel IXGBE, I40E, ICE, and IAVF drivers

v1 -> v2:
- Added patches [1] [2] that were previously sent separately
- Added patch fixing leak in DCF config

v2 -> v3:
- Added patch fixing leak in FDIR parser

v3 -> v4:
- Reordered patchsets by driver
- Added patch to fix ixgbe security flow memory leak

v4 -> v5:
- Fixed build issues in DCF patch
- Added three more patches to fix various bugs in IPsec

v5 -> v6:
- Brought back comment about constness and moved it to where
  casting away actually happens

[1] https://patches.dpdk.org/project/dpdk/patch/fbd32a8a688fd0ed90fcf497703edcc30f69d54d.1770643356.git.anatoly.burakov@intel.com/
[2] https://patches.dpdk.org/project/dpdk/patch/ab4f8d8cf24dcd18f0dd6da3359266083f31d789.1770642901.git.anatoly.burakov@intel.com/

Anatoly Burakov (12):
  net/ixgbe: add missing E610 MAC type checks
  net/ixgbe: fix memory leak in security flows
  net/ixgbe: fix potential null dereference in IPsec
  net/ixgbe: fix potential null dereference in IPsec
  net/ixgbe: fix wrong pointer handling in IPsec
  net/i40e: move FDIR config to flow create
  net/i40e: fix IPv6 GTPU handling
  net/iavf: fix memory leak on egress IPsec flows
  net/iavf: fix memory leak on uninit
  net/iavf: fix IPv4 flow subscription
  net/ice: fix memory leak in DCF QoS bandwidth config
  net/ice: fix memory leak in FDIR flow parsing

 drivers/net/intel/i40e/i40e_flow.c         | 64 ++++++++++++----------
 drivers/net/intel/iavf/iavf_fsub.c         |  4 +-
 drivers/net/intel/iavf/iavf_generic_flow.c | 37 +++++++++++--
 drivers/net/intel/iavf/iavf_generic_flow.h |  1 +
 drivers/net/intel/ice/ice_dcf_sched.c      | 15 +++--
 drivers/net/intel/ice/ice_fdir_filter.c    |  8 ++-
 drivers/net/intel/ixgbe/ixgbe_bypass_api.h |  8 +--
 drivers/net/intel/ixgbe/ixgbe_ethdev.c     | 29 ++++++----
 drivers/net/intel/ixgbe/ixgbe_ethdev.h     |  2 +
 drivers/net/intel/ixgbe/ixgbe_fdir.c       |  8 ++-
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 53 ++++++++++++++++--
 drivers/net/intel/ixgbe/ixgbe_ipsec.c      | 18 ++----
 drivers/net/intel/ixgbe/ixgbe_ipsec.h      | 16 +++++-
 drivers/net/intel/ixgbe/ixgbe_pf.c         |  5 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c       | 14 +++--
 15 files changed, 194 insertions(+), 88 deletions(-)

-- 
2.47.3

