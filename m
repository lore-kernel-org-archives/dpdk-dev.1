Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 720D1F44863
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:13:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55629402D1;
	Fri, 10 Apr 2026 15:13:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id CE727402AF
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:13:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775826813; x=1807362813;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lzX2OZu6c+44ffxrhKMOl0PuaVYfICjQHhrVy6ESvS4=;
 b=kHWq4km8/Lpp4pSD2FWECdFzSYs3EvkSp0WuisgYuRNpVmu21Jf+mwpx
 QfexeEeh9D5gnwLIXzlwaNjKeryIzSjPBYVJAGMFNbPz+n9Saxwg+3Pld
 fFXT09Avdy6sr/G4E3imsfFXw+JMIPoXbLccbZn62OVlrzL0BBcw1F0VO
 PhQoU92DfRHSWG4yYj4v285niI0cHqylwFCSETAGx5L/YFANZxVxI6qcP
 GLuNS3I+RWmPnuvYLN5JpsTqSNoKWeVn3FAutGh2SG1Dg5ivGPUIROieY
 xLKH2BE7FfE/Jt/Q/NiVyxqyT16AP/qaYwxKvHFnRWGuDLM5CGeH7D4cA g==;
X-CSE-ConnectionGUID: FMmm5wctQAaszLVnhLPXXg==
X-CSE-MsgGUID: 8uz2qpNoQ2WinOwPsvOoCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76736308"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76736308"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:13:32 -0700
X-CSE-ConnectionGUID: jhCQCxTfR6eccpZZ39j4Ug==
X-CSE-MsgGUID: yVORbIkuSmS+pizHV8lDJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="234084607"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa005.jf.intel.com with ESMTP; 10 Apr 2026 06:13:30 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 00/29] Add common flow attr/action parsing infrastructure
 to Intel PMD's
Date: Fri, 10 Apr 2026 14:12:54 +0100
Message-ID: <cover.1775826526.git.anatoly.burakov@intel.com>
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

Anatoly Burakov (24):
  net/ixgbe: fix shared PF pointer in representor
  net/ixgbe: store max VFs in adapter
  net/ixgbe: reduce FDIR conf macro usage
  net/ixgbe: use adapter in flow-related calls
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

 drivers/net/intel/common/flow_check.h         |  307 +++++
 drivers/net/intel/i40e/i40e_ethdev.h          |    1 -
 drivers/net/intel/i40e/i40e_flow.c            |  433 +++---
 drivers/net/intel/i40e/i40e_hash.c            |  437 +++---
 drivers/net/intel/i40e/i40e_hash.h            |    2 +-
 drivers/net/intel/iavf/iavf_fdir.c            |  367 +++--
 drivers/net/intel/iavf/iavf_fsub.c            |  266 ++--
 drivers/net/intel/iavf/iavf_generic_flow.c    |  105 +-
 drivers/net/intel/iavf/iavf_generic_flow.h    |    2 +-
 drivers/net/intel/iavf/iavf_hash.c            |  153 +--
 drivers/net/intel/iavf/iavf_ipsec_crypto.c    |   43 +-
 drivers/net/intel/ice/ice_acl_filter.c        |  146 +-
 drivers/net/intel/ice/ice_fdir_filter.c       |  383 +++---
 drivers/net/intel/ice/ice_generic_flow.c      |   59 +-
 drivers/net/intel/ice/ice_generic_flow.h      |    2 +-
 drivers/net/intel/ice/ice_hash.c              |  189 +--
 drivers/net/intel/ice/ice_switch_filter.c     |  388 +++---
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  101 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   29 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |  113 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c          | 1187 ++++++-----------
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   10 +-
 .../net/intel/ixgbe/ixgbe_vf_representor.c    |   63 +-
 23 files changed, 2389 insertions(+), 2397 deletions(-)
 create mode 100644 drivers/net/intel/common/flow_check.h

-- 
2.47.3

