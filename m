Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883C5CD5BB0
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:14:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A746840616;
	Fri, 22 May 2026 17:14:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 707C54003C
 for <dev@dpdk.org>; Fri, 22 May 2026 17:14:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462885; x=1810998885;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Bqq1PKtxE6yUDGhLEqzJzvQiFhjmTV3/ZemNb0XFVXU=;
 b=KtL6dDYI4SL7JhHCfi+6uqaUA0OzItUPTHJK7otPQaYMF1MNkwKbRcWJ
 dRKP7q3FfGJ2IaiUi9vigS4z+kL7dwUxrf7zwTj/fWCKWUSAw61yDbFQs
 6lIm/szjr9uyinTtq6AmWExnxd2nk+xNkZETYbKn1EMYFVoamv113+Stc
 SLoumqvOuDu9GUMXOnHhyXU5/XU3YzmB4xG8/5RGr4QGBCNMjEBr4Dq8q
 XX7ThpML4X6f5AU8eNbl+XmvSScdUewW7bCR2lkFoCgQvUoA5LCvz2Oa9
 ORKQh9JW2SDNvVcxcqbxpGaU/IWDf50rxfaTaJKdIxi1tWNWy8Ac1FlCu Q==;
X-CSE-ConnectionGUID: RmFvpOz3QmuA1LSS5BOJpA==
X-CSE-MsgGUID: 0mNw6CSoQQCDyub1L0ZtTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969148"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969148"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:14:43 -0700
X-CSE-ConnectionGUID: MqmDAPA6QBOSRUBmm9WW8g==
X-CSE-MsgGUID: u1SLYAxZTmiQV6OaH5an8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245213911"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:14:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v4 00/26] Add common flow attr/action parsing infrastructure
 to Intel PMD's
Date: Fri, 22 May 2026 16:14:09 +0100
Message-ID: <cover.1779462698.git.anatoly.burakov@intel.com>
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

Vladimir Medvedkin (5):
  net/ice: use common flow attribute checks
  net/ice: use common action checks for hash
  net/ice: use common action checks for FDIR
  net/ice: use common action checks for switch
  net/ice: use common action checks for ACL

 drivers/net/intel/common/flow_check.h      |  347 ++++++
 drivers/net/intel/common/log.h             |   40 +
 drivers/net/intel/i40e/i40e_ethdev.h       |    1 -
 drivers/net/intel/i40e/i40e_flow.c         |  433 +++-----
 drivers/net/intel/i40e/i40e_hash.c         |  437 +++++---
 drivers/net/intel/i40e/i40e_hash.h         |    2 +-
 drivers/net/intel/iavf/iavf_fdir.c         |  367 +++---
 drivers/net/intel/iavf/iavf_fsub.c         |  261 ++---
 drivers/net/intel/iavf/iavf_generic_flow.c |  107 +-
 drivers/net/intel/iavf/iavf_generic_flow.h |    2 +-
 drivers/net/intel/iavf/iavf_hash.c         |  153 +--
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |   43 +-
 drivers/net/intel/ice/ice_acl_filter.c     |  146 ++-
 drivers/net/intel/ice/ice_fdir_filter.c    |  384 ++++---
 drivers/net/intel/ice/ice_generic_flow.c   |   59 +-
 drivers/net/intel/ice/ice_generic_flow.h   |    2 +-
 drivers/net/intel/ice/ice_hash.c           |  190 ++--
 drivers/net/intel/ice/ice_switch_filter.c  |  388 +++----
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 1166 +++++++-------------
 lib/eal/include/rte_common.h               |    4 +
 20 files changed, 2264 insertions(+), 2268 deletions(-)
 create mode 100644 drivers/net/intel/common/flow_check.h
 create mode 100644 drivers/net/intel/common/log.h

-- 
2.47.3

