Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C97EB4917
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Feb 2026 12:53:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 592914027A;
	Thu, 12 Feb 2026 13:53:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 9306540268
 for <dev@dpdk.org>; Thu, 12 Feb 2026 13:53:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770900823; x=1802436823;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ppTb1M1fs2t8feD/HX0Ej8V0D6Gk6ikyz2K9gDSL1sg=;
 b=TPncoG0jPP+qW13l3YquLSUalDECN73OOa/F9LZt/2i9BZGckOXofx0D
 bli2D5GFdqQfgm4VcjkkHBBd8RwP9fiGs7DcKieEUXiGTdl9LsfJ3MUs2
 Nxyu7Q7sM4E06FnMPpYi8UqHce8QOznj2GhcXiJR8Nk/cCtShjER191Ld
 TUZ3Wc8nQXwyzKQyKlEQM+i1MrgojP7py4t/bs6BHwspYoyuSly2KTuDg
 WiWveed65MCMqw2sx0pMZMsQFjXoD5TpFoVjim516s03S9pqONfbs1B/f
 75W93MUbXgUJZ7Y8a2M+7pCNVaT+3yXFn95G2ovwMZ0Zk1RPCgRuLUza6 Q==;
X-CSE-ConnectionGUID: G1w6odTzTd6t2A/o8vBPFw==
X-CSE-MsgGUID: 8XGEmtbHR1OaaPnyV0XG8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="71785481"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="71785481"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Feb 2026 04:53:41 -0800
X-CSE-ConnectionGUID: iRPq8r8oQTa8/gKlKuifHA==
X-CSE-MsgGUID: 8Rxp9hkpRvSLWd55OAe0oQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208";a="243179085"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 12 Feb 2026 04:53:40 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v5 00/12] Assortment of bug fixes for Intel PMD's
Date: Thu, 12 Feb 2026 12:53:23 +0000
Message-ID: <cover.1770900757.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 43 +++++++++++++--
 drivers/net/intel/ixgbe/ixgbe_ipsec.c      | 19 +++----
 drivers/net/intel/ixgbe/ixgbe_ipsec.h      | 16 +++++-
 drivers/net/intel/ixgbe/ixgbe_pf.c         |  5 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c       | 14 +++--
 15 files changed, 185 insertions(+), 88 deletions(-)

-- 
2.47.3

