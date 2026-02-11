Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25771E9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:21:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5749F40608;
	Wed, 11 Feb 2026 15:20:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 4F6F340268
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:20:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819658; x=1802355658;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=SIxRx3VfLsKxVQ4FLmz1iF4qFy1OCYXqQgOMhZ2GWb8=;
 b=MUbxgoC5f1baFBUCos8eMGhv6cReoxWI8CJ5dONZV4yEO+AsXeB49rQQ
 WdHaneqKMLT17Rv5G2ID5GHQWpweJxY70RCJG08zTTl00zy0N8NoUG3c3
 AitdkguhYAw5W+i8kZXGMp7Rw7opvpPSlWrFaGUPBICQ3x9iZOkEhy3oD
 ertS50H0+h0ormHRTpympP3jXzNtzPCsMKPPEsS/IvvJob52vZyS+SD4O
 nn4eO3zHrZ128VeI2ouvVnTpPOzdotg+bcq2k7uM++GqXQ+nkqRqm3dKO
 hDEA6cUgI2UEnNOKwYiKVoqwQEALUflwHhRAHIcFEdPAgHlqTg/X0lgKj A==;
X-CSE-ConnectionGUID: vK8+a6gwSUu4XhG0I/ZTgw==
X-CSE-MsgGUID: 7itft/rfR4SCz5Gilo1JmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866718"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866718"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:20:57 -0800
X-CSE-ConnectionGUID: JU7wj5FoRFKkOekJZI8QCQ==
X-CSE-MsgGUID: auy9DKmASFe+9j0mKDyDoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569079"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:20:57 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 00/25] Add common flow attr/action parsing infrastructure
 to Intel PMD's
Date: Wed, 11 Feb 2026 14:20:17 +0000
Message-ID: <cover.1770819433.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

Note: this patchset depends on the following other patchsets:

1) PMD bug fix patchset: https://patches.dpdk.org/project/dpdk/list/?series=37333
2) PMD cleanups patchset: https://patches.dpdk.org/project/dpdk/list/?series=37334

Anatoly Burakov (20):
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

 drivers/net/intel/common/flow_check.h      |  308 ++++++
 drivers/net/intel/i40e/i40e_ethdev.h       |    1 -
 drivers/net/intel/i40e/i40e_flow.c         |  433 +++-----
 drivers/net/intel/i40e/i40e_hash.c         |  427 +++++---
 drivers/net/intel/i40e/i40e_hash.h         |    2 +-
 drivers/net/intel/iavf/iavf_fdir.c         |  367 +++----
 drivers/net/intel/iavf/iavf_fsub.c         |  266 +++--
 drivers/net/intel/iavf/iavf_generic_flow.c |  103 +-
 drivers/net/intel/iavf/iavf_generic_flow.h |    2 +-
 drivers/net/intel/iavf/iavf_hash.c         |  153 +--
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |   42 +-
 drivers/net/intel/ice/ice_acl_filter.c     |  146 ++-
 drivers/net/intel/ice/ice_fdir_filter.c    |  384 ++++---
 drivers/net/intel/ice/ice_generic_flow.c   |   59 +-
 drivers/net/intel/ice/ice_generic_flow.h   |    2 +-
 drivers/net/intel/ice/ice_hash.c           |  189 ++--
 drivers/net/intel/ice/ice_switch_filter.c  |  388 +++----
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 1136 +++++++-------------
 18 files changed, 2157 insertions(+), 2251 deletions(-)
 create mode 100644 drivers/net/intel/common/flow_check.h

-- 
2.47.3

