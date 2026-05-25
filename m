Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF78CD5BC9
	for <dpdk-dev@archiver.kernel.org>; Mon, 25 May 2026 14:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2C2C4402D0;
	Mon, 25 May 2026 16:06:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 5EFDA40276
 for <dev@dpdk.org>; Mon, 25 May 2026 16:06:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779718014; x=1811254014;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=POCiXBWRx0knoRJtWzVlLx5PQTkba1h5mX5pF0mapgo=;
 b=b5mT1MFsjpDm3IZOPEAvvfKKXSLhUYYwMlQlQton5cYjrhT1uDP0B8ig
 niwGPwdbJVm/83DIxwTi1t7Jwzwqr8PHvZjzBkPY/DgZ9vXnDLQLt9o2M
 DhHkUbJOAoqGhL9T1ZFJRKkKu74mUKpXEKU1Y0XATH3e35T/1sQcc3FY/
 xjxJzkcnSut1srkjEO3SZ57/5GOzjke5z7zy7PRWdAfxQuHFwM4ExPw58
 ex91y4pUp+Wl3HBRNABKvc2Jv4jKen60YJDx49V6+4Ukpk/dR9FvheJaU
 cS13WpVP8mv2BBAPAfk3jU7zCQ6QeU/FIgc0sDl6oURvybsDi412i1Cfo g==;
X-CSE-ConnectionGUID: OtH8RbGMRiSC0hOz8w2LuQ==
X-CSE-MsgGUID: 7Ms85pZNTs6oTkTm5JwsRw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="84392471"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="84392471"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 07:06:53 -0700
X-CSE-ConnectionGUID: SpfBuCyGSkCo/kN18SPV1w==
X-CSE-MsgGUID: yC55oQC+TwmibGX3i5geyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="246692286"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa005.fm.intel.com with ESMTP; 25 May 2026 07:06:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v5 00/27] Add common flow attr/action parsing infrastructure
 to Intel PMD's
Date: Mon, 25 May 2026 15:06:19 +0100
Message-ID: <cover.1779717943.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/common/flow_check.h      |  347 ++++++
 drivers/net/intel/common/log.h             |   40 +
 drivers/net/intel/i40e/i40e_ethdev.h       |    1 -
 drivers/net/intel/i40e/i40e_flow.c         |  433 +++-----
 drivers/net/intel/i40e/i40e_hash.c         |  438 +++++---
 drivers/net/intel/i40e/i40e_hash.h         |    2 +-
 drivers/net/intel/iavf/iavf_fdir.c         |  368 +++---
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
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 1166 +++++++-------------
 lib/eal/include/rte_common.h               |    4 +
 lib/meson.build                            |    2 +
 22 files changed, 2271 insertions(+), 2268 deletions(-)
 create mode 100644 drivers/net/intel/common/flow_check.h
 create mode 100644 drivers/net/intel/common/log.h

-- 
2.47.3

