Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885D7CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 10:07:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E7A3402C9;
	Wed, 15 Oct 2025 12:07:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6F731402C9
 for <dev@dpdk.org>; Wed, 15 Oct 2025 12:07:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760522851; x=1792058851;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uWWZFzdV7qYQltkEu21vjzPlet5LNdwYLHu08L9ctnE=;
 b=JCy0QbB/M3yaLHGIwtfWbMqscx/+TpEdUHWSYcrzeMJ/Cjo37oR461G/
 36PX/pyraGb4AQ8BwZEBV+fJrILNO2Q3U4UmQBx/5xKPJ1ZA8IeGu4bB0
 iqa80KKD/RZPG0Lps5cg0MFyeKnQdWlL7jz4QQX8ttu9K7zAHv3scIf2R
 kY1QXxyx30Nhrgg4YqIHbgZqbYzw/y1WXzcK5ERJEX/zLN+MaxjC9eH3h
 KP/7t4RRZjZ/oPbgsSSvgGIxj/5Uo+MgkudmPrVcLCfaNR6oSD7GQ5hk/
 bCznzcqO+MWLxknMyAJsAUjfa1TPOATT+CH4n30IxaxWAADBliT6l/pLO g==;
X-CSE-ConnectionGUID: qf0cEQ7GRL2NG64i8uB7NA==
X-CSE-MsgGUID: RDyuOFcxRi+elXGMyjTEIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73371771"
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="73371771"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 03:07:30 -0700
X-CSE-ConnectionGUID: y1DjH7mHSky8HjWyGTTLRg==
X-CSE-MsgGUID: xeF/3+b6S4uWew6wkdKaTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="181262588"
Received: from silpixa00401177.ir.intel.com ([10.20.224.214])
 by orviesa006.jf.intel.com with ESMTP; 15 Oct 2025 03:07:29 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 0/7] net/intel: fixes and improvements to rx path selection
Date: Wed, 15 Oct 2025 10:07:16 +0000
Message-Id: <20251015100723.1603296-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251014084517.1407407-1-ciara.loftus@intel.com>
References: <20251014084517.1407407-1-ciara.loftus@intel.com>
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

This series contains a number of fixes and improvements to the logic
concerned with selecting an rx path in the intel drivers.

Patch 1 fixes incorrect behaviour in the ci_rxq_vec_capable function
which would disqualify rxqs that have the timestamp offload enabled from
selecting vector paths. This was incorrect because iavf vector paths
support timestamp offload.

Patch 2 removes a reduntant check from the ci_rxq_vec_capable function
that disqualifies rxqs that have the buffer split offload enabled from
selecting vector paths. This check is performed during the common rx
path selection for three of the drivers and during dev_configure for the
fourth, so the check in ci_rxq_vec_capable is unneeded. Although it is
similar this patch was kept separate from patch 1 because it is only
relevant after the three aformention drivers adopted the common rx path
selection infrastructure, whereas patch 1 is a fix for an issue that
existed prior to that.

Patches 3 and 4 make fixes to the iavf rx path definitions, ensuring the
correct offloads and features are defined for all paths.

The final three patches reformat the arrays in the i40e iavf and ice
drivers that hold information for each Rx path that are used in the
common selection process, in an attempt to improve readability.

v2:
* Added a new patch (2) that removes the reduntant check for the buffer
split offload in the common function.
* Removed the useless defines IAVF_RX_NO_OFFLOADS and ICE_RX_NO_OFFLOADS
* Use a newline for closing braces in the rx path infos arrays
* Let a simd width of zero represent scalar paths instead of 64 which
lessens the number of fields that need to be initialised for scalar path
definitions

Ciara Loftus (7):
  net/intel: fix Rx vector capability detection
  net/intel: remove redundant Rx offload check
  net/iavf: fix Rx paths feature definitions
  net/iavf: fix Rx path selection for scalar flex bulk alloc
  net/iavf: reformat the Rx path infos array
  net/i40e: reformat the Rx path infos array
  net/ice: reformat the Rx path infos array

 drivers/net/intel/common/rx.h                 |   7 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 149 ++++++--
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   2 +-
 drivers/net/intel/iavf/iavf.h                 |   1 +
 drivers/net/intel/iavf/iavf_rxtx.c            | 335 ++++++++++++++----
 drivers/net/intel/iavf/iavf_rxtx.h            |   2 -
 drivers/net/intel/ice/ice_rxtx.c              | 147 ++++++--
 drivers/net/intel/ice/ice_rxtx.h              |   1 -
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |   2 +-
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |   2 +-
 10 files changed, 498 insertions(+), 150 deletions(-)

-- 
2.34.1

