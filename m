Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B279AF4644B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:53:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77C944025E;
	Mon, 16 Mar 2026 11:53:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id CE22C400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658379; x=1805194379;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Bsi0+jCFLIfqGKuxajjiZEzzZiMOAD21H+jDbEOQOMQ=;
 b=cgV0+005q3zyjt2LcYF4EyiLExjCfoluXxM5MTM+Ke0n8al2EBDMEhg3
 Z6VtW0+q7KbMPmHNy9ubuAQpU12qhcusCFfT6ULG/stGBgVhS6MqmwONp
 zFy88pLey+hUWxwrxNTsQp+F8PJLgp0VelMwxWozCRVYPxKMh65jMIM24
 5+8JFzIvVArKKngxNEOq6Hhlgyx+OcfIkupRO2jkQtXptI6ZqUQhJiZ4n
 uD/nSB5NMmdXADh67WrGxa/QoAn9GeoRUcN2LaAV+yFgWoa55ebAOWz75
 1qL2ayTopbjqVhVMKUzcb3TLvodNz5ezBrNmOkStRUpUjcl2sZdyLbumF w==;
X-CSE-ConnectionGUID: r2ewf1EaQ8GNmqWFjH1cwA==
X-CSE-MsgGUID: jIZjujpqSvSZSdBnGIiwqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237407"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237407"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:52:58 -0700
X-CSE-ConnectionGUID: X+SjFjFGRui7qz0KLJSqTg==
X-CSE-MsgGUID: Ax1zrIeoSwajKI8fB0IsCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826531"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:52:57 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v2 00/25] Add common flow attr/action parsing infrastructure
 to Intel PMD's
Date: Mon, 16 Mar 2026 10:52:25 +0000
Message-ID: <cover.1773658289.git.anatoly.burakov@intel.com>
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

v2:
- Rebase on latest main
- Now depends on series 37585 [1]

[1] https://patches.dpdk.org/project/dpdk/list/?series=37585

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

 drivers/net/intel/common/flow_check.h      |  307 ++++++
 drivers/net/intel/i40e/i40e_ethdev.h       |    1 -
 drivers/net/intel/i40e/i40e_flow.c         |  434 +++-----
 drivers/net/intel/i40e/i40e_hash.c         |  425 +++++---
 drivers/net/intel/i40e/i40e_hash.h         |    2 +-
 drivers/net/intel/iavf/iavf_fdir.c         |  367 +++----
 drivers/net/intel/iavf/iavf_fsub.c         |  266 +++--
 drivers/net/intel/iavf/iavf_generic_flow.c |  103 +-
 drivers/net/intel/iavf/iavf_generic_flow.h |    2 +-
 drivers/net/intel/iavf/iavf_hash.c         |  153 +--
 drivers/net/intel/iavf/iavf_ipsec_crypto.c |   42 +-
 drivers/net/intel/ice/ice_acl_filter.c     |  146 ++-
 drivers/net/intel/ice/ice_fdir_filter.c    |  383 ++++---
 drivers/net/intel/ice/ice_generic_flow.c   |   59 +-
 drivers/net/intel/ice/ice_generic_flow.h   |    2 +-
 drivers/net/intel/ice/ice_hash.c           |  189 ++--
 drivers/net/intel/ice/ice_switch_filter.c  |  388 +++----
 drivers/net/intel/ixgbe/ixgbe_flow.c       | 1135 +++++++-------------
 18 files changed, 2151 insertions(+), 2253 deletions(-)
 create mode 100644 drivers/net/intel/common/flow_check.h

-- 
2.47.3

