Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04776FCA188
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3521E4066F;
	Mon,  9 Mar 2026 22:19:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 3804840269
 for <dev@dpdk.org>; Mon,  9 Mar 2026 22:19:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773091171; x=1804627171;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SJ3ya6uLIgCLUuORMHXQGw46SFoUi82/3jTOdyO9ULA=;
 b=RM1zrXCjvjrK7ODVOh4yN3xbP0zHiRMi7U6oHUdedwQJsTcXdWzwVVNy
 Z7Y/SbN8ez6FTpkBI0B85iZBmvDU1kOeMMIo84cln32YuCUjgyKR/nw3+
 X9O4v/1qaw6xIZzlP6qv/VRJpyj5lNv8NHDRmkR/5HVA/A9CHX5vmZghi
 7xvXdzOJRnGGzTH99wYUVpusekq7ojMxusFGsADiO+GaRmbiE5Y/TxBAC
 3cQnyqcGVIUCCmbwurU4uM6Zdxi1VRCiCNX4NynaisYDsG9Hes/eLZSmU
 H7rG1TJ4CTgLadPh1S2fz0GVO0dTAbiro3LdVIuAH/xmaBgK8h1ZxYE37 w==;
X-CSE-ConnectionGUID: YPfaZHt9Q/23IxxXyFWVDA==
X-CSE-MsgGUID: U5Eg/u8VQ9WjzZJtj73IKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74241052"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="74241052"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 14:19:30 -0700
X-CSE-ConnectionGUID: T13Ubc2hTnW5Iunn8zTDVA==
X-CSE-MsgGUID: LkZDAewjSs+D/B+/J9esZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; d="scan'208";a="219016140"
Received: from fenlix-mobl.ccr.corp.intel.com ([10.239.252.5])
 by orviesa006.jf.intel.com with ESMTP; 09 Mar 2026 14:19:28 -0700
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: bruce.richardson@intel.com, manoj.kumar.subbarao@intel.com,
 aman.deep.singh@intel.com, dev@dpdk.org
Cc: Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH v1 4/6] net/ice/base: support RDMA on 4+ ports of E830
Date: Tue, 10 Mar 2026 05:52:16 -0400
Message-ID: <20260310095218.703423-14-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260310095218.703423-1-soumyadeep.hore@intel.com>
References: <20260310095218.703423-1-soumyadeep.hore@intel.com>
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

From: Paul Greenwalt <paul.greenwalt@intel.com>

E810/E82X devices do not support RDMA on 4+ ports configurations. This is
not true for E830 devices.

During device capability discovery do not apply RDMA limitation when
the device is E830.

Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 7d8f677c99..934e0c2d5b 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -2668,6 +2668,8 @@ ice_recalc_port_limited_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps)
 		caps->maxtc = 4;
 		ice_debug(hw, ICE_DBG_INIT, "reducing maxtc to %u (based on #ports)\n",
 			  caps->maxtc);
+		if (hw->mac_type == ICE_MAC_E830)
+			return;
 	}
 }
 
-- 
2.47.1

