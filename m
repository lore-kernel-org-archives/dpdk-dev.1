Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E725ECD4F54
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:36:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 404CD40262;
	Fri, 29 May 2026 17:36:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id F2B83400D6
 for <dev@dpdk.org>; Fri, 29 May 2026 17:36:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780068998; x=1811604998;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nPZjRhSWnxMx6V+AO8ffghy2idHutHAIfj7XhphL81o=;
 b=nAJK7g618lmUZ6Nya+UH+wYFvdX0aBrncV41OiGC72A486zEScWJUr1T
 Dgz3rRUJdD/osCj+bddXGUfa+w2VnjtGeC8bbVKFpTJSDf9ielZDwF75A
 lmLex2r5Qi9A/LTbmmL9ymgUTaRFT+PRsSwNknxzJrIcZPkUJnFcTTp75
 jX8lXGRMon/2N8wtAQA0AM0Ip2CD8n2SKGF9Rp7RFN2HBlsG6I5RPNZQ9
 zTTpnnDH6KOnkZLorIv+IGQuS7p65Xus1btnl9xj7za6Is4eGAAbRQ6ns
 Dv+lDszR91CWKv/CRD47dwby3I8rGWyjwgu70KRNBK+riTJAAuu3qwZnn w==;
X-CSE-ConnectionGUID: 83WCNyiORKCAGsnmwH0o2g==
X-CSE-MsgGUID: rEuP9JcgRGSQhH26hzYITA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84549761"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84549761"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:36:37 -0700
X-CSE-ConnectionGUID: IqM6RVJZS0ydV/ymdwEqUw==
X-CSE-MsgGUID: 0QBv8RwSTim9X2+ngrpxCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="281001191"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 29 May 2026 08:36:37 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v6 00/27] Add common flow attr/action parsing infrastructure
 to Intel PMD's
Date: Fri, 29 May 2026 16:36:02 +0100
Message-ID: <cover.1780068633.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770819433.git.anatoly.burakov@intel.com>
References: <cover.1770819433.git.anatoly.burakov@intel.com>
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

This patchset introduces common flow attr/action checking infrastructure to
some Intel PMD's (IXGBE, I40E, IAVF, and ICE). The aim is to reduce code
duplication, simplify implementation of new parsers/verification of existing
ones, and make action/attr handling more consistent across drivers.

v6:
- Increase max number of actions to 32
- Add missing flow item types from list of types needing conf
- Improved egress/ingress handling
- ixgbe: allow mark and drop combination of actions
- ixgbe: fix set-then-reset when initializing rules for fdir engine

v5:
- Add missing patch for component/class name compile time constant
- Fixed missing RSS queue contiguousness checks

v4:
- First few commits were integrated as part of a different patchset
- Added more logging to common infrastructure
- RSS validation now allows discontiguous queue lists by default
- Fixed some checks being too stringent and failing common validation

v3:
- Rebase on latest next-net-intel
- Added 4 new commits that have to do with not using `rte_eth_dev` in rte_flow
- Converted the remaining commits to use adapter structures everywhere
- Minor fixes in how return values are handled
- Fixed incorrect check in i40e RSS validation

v2:
- Rebase on latest main
- Now depends on series 37585 [1]

[1] https://patches.dpdk.org/project/dpdk/list/?series=37585

Anatoly Burakov (21):
  eal/common: add token concatenation macro
  net/intel/common: add common flow action parsing
  net/intel/common: add common flow attr validation
  net/ixgbe: use common checks in ethertype filter
  net/ixgbe: use common checks in syn filter
  net/ixgbe: use common checks in L2 tunnel filter
  net/ixgbe: use common checks in ntuple filter
  net/ixgbe: use common checks in security filter
  net/ixgbe: use common checks in FDIR filters
  net/ixgbe: use common checks in RSS filter
  net/i40e: use common flow attribute checks
  net/i40e: refactor RSS flow parameter checks
  net/i40e: use common action checks for ethertype
  net/i40e: use common action checks for FDIR
  net/i40e: use common action checks for tunnel
  net/iavf: use common flow attribute checks
  net/iavf: use common action checks for IPsec
  net/iavf: use common action checks for hash
  net/iavf: use common action checks for FDIR
  net/iavf: use common action checks for fsub
  net/iavf: use common action checks for flow query

Bruce Richardson (1):
  build: add build defines for component name and class

Vladimir Medvedkin (5):
  net/ice: use common flow attribute checks
  net/ice: use common action checks for hash
  net/ice: use common action checks for FDIR
  net/ice: use common action checks for switch
  net/ice: use common action checks for ACL

 drivers/meson.build                        |    2 +
 drivers/net/intel/common/flow_check.h      |  349 ++++++
 drivers/net/intel/common/log.h             |   40 +
 drivers/net/intel/i40e/i40e_ethdev.h       |    1 -
 drivers/net/intel/i40e/i40e_flow.c         |  433 +++-----
 drivers/net/intel/i40e/i40e_hash.c         |  438 +++++---
 drivers/net/intel/i40e/i40e_hash.h         |    2 +-
 drivers/net/intel/iavf/iavf_fdir.c         |  368 +++----
 drivers/net/intel/iavf/iavf_fsub.c         |  262 ++---
 drivers/net/intel/iavf/iavf_generic_flow.c |  107 +-
 drivers/net/intel/iavf/iavf_generic_flow.h |    2 +-
 drivers/net/intel/iavf/iavf_hash.c         |  153 +--
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |   43 +-
 drivers/net/intel/ice/ice_acl_filter.c     |  146 ++-
 drivers/net/intel/ice/ice_fdir_filter.c    |  384 ++++---
 drivers/net/intel/ice/ice_generic_flow.c   |   59 +-
 drivers/net/intel/ice/ice_generic_flow.h   |    2 +-
 drivers/net/intel/ice/ice_hash.c           |  189 ++--
 drivers/net/intel/ice/ice_switch_filter.c  |  389 +++----
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 1161 +++++++-------------
 lib/eal/include/rte_common.h               |    4 +
 lib/meson.build                            |    2 +
 22 files changed, 2264 insertions(+), 2272 deletions(-)
 create mode 100644 drivers/net/intel/common/flow_check.h
 create mode 100644 drivers/net/intel/common/log.h

-- 
2.47.3

