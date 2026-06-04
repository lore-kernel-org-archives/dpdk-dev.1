Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A64CD6E77
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:19:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B879D402E3;
	Thu,  4 Jun 2026 18:19:41 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id E5DD8402CC
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:19:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780589980; x=1812125980;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nIN/PWQZ4pym2evNO4AdQx8dJafgSlJAzCM7sjIKSko=;
 b=e56Rov9dvKyMQ9DYw0ENwSUnfG55nPGbjJvt2zqtX1LBGmVB4tvA84I8
 9tOozg9OzYFlY3LdWyRTQUj7vj6ILegJtRGkZMqhoufmvA/GkSO82UcGM
 1gd5+1PeKMy9sYiquU3SpvZdrkd82honggLWvtWrg2FlQrSM/VfFY+gEa
 mfnH84OR1t9HnGr6JemFm2d9EEfm5FuaBWRvTKnhAlSNx4TWNP4Ckgshc
 P+B3uiL3TXlKOAD5uf/OScFb7w2h1RgnClORDkkMkH0dMuOKWEU09qsTH
 Az3AiXuVU11tf+gSXI1Lt6ww1Lupm+9LGoD3cI1FYXE5nOcWhLjlQnPy6 w==;
X-CSE-ConnectionGUID: 9de8dy+jRsCBbvGz0AwGrA==
X-CSE-MsgGUID: 31Oh2pQXQLGn4gRiB4dz2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85045105"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85045105"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:19:39 -0700
X-CSE-ConnectionGUID: 8zXXPOOkTwGBXWgNWH+Wmg==
X-CSE-MsgGUID: pcLVtkMCSj+/+ChnoSCG0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="240403945"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 09:19:38 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v7 00/27] Add common flow attr/action parsing infrastructure
 to Intel PMD's
Date: Thu,  4 Jun 2026 17:19:04 +0100
Message-ID: <cover.1780589913.git.anatoly.burakov@intel.com>
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

v7:
- Fail on empty action list before calling into user callbacks
- Remove empty code

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
 drivers/net/intel/common/flow_check.h      |  354 ++++++
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
 22 files changed, 2269 insertions(+), 2272 deletions(-)
 create mode 100644 drivers/net/intel/common/flow_check.h
 create mode 100644 drivers/net/intel/common/log.h

-- 
2.47.3

