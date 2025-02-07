Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87641C02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 20:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAC9C402DC;
	Fri,  7 Feb 2025 21:49:43 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id C105940270
 for <dev@dpdk.org>; Fri,  7 Feb 2025 21:49:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738961382; x=1770497382;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cdkxvsC7BkWjiI2W9ouxX4Ri3ae4s5+5rcd+iHc+Cug=;
 b=Jch/H8XCB/cWPNXt6rZe1OIQySPtsJkerJUqWZbkT2BmOgqUm1PIbwft
 88EP5a9si57zsDGmC9ucTfKh9r+eYhYyMOUNzgMquv6lAdzFvxHNgxZcz
 quBrUbHBbuS8e2FY1iJWbYW76d2uQ0+1P4sde0L1jY5BQl0PBEJbSSYuR
 8PpUcElTR3x3HPkVWPrzWlkFH1WB9ppUcqUJYdzAHuHen0qz55yiv13ai
 VkiIvPQ3VdtGw9YvZ+i16wt2aXLsm6bHzXhE0TKM4Lj3gr8QEvy+9csKQ
 RQUm+wj4gy86Ea/Rw+s7DSfAfEFG2Pbx3gTsueXCx1IORFquPQ6lLlUVc Q==;
X-CSE-ConnectionGUID: 5GTjQLwfTSORJiWftEw5xA==
X-CSE-MsgGUID: gTrcCy+OS96p/GflyXZF9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11338"; a="39742354"
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; d="scan'208";a="39742354"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 12:49:07 -0800
X-CSE-ConnectionGUID: UfQrthCUQFuAu0g+/nBAvA==
X-CSE-MsgGUID: K6kapIGaROSVi2XbZbcVIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,268,1732608000"; d="scan'208";a="116631318"
Received: from unknown (HELO sprmax9..) ([10.138.182.122])
 by orviesa004.jf.intel.com with ESMTP; 07 Feb 2025 12:49:05 -0800
From: Soumyadeep Hore <soumyadeep.hore@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com
Cc: aman.deep.singh@intel.com,
	Paul Greenwalt <paul.greenwalt@intel.com>
Subject: [PATCH v1 2/3] net/intel: add E830 ETF offload timestamp resolution
Date: Fri,  7 Feb 2025 12:42:59 +0000
Message-ID: <20250207124300.1022523-3-soumyadeep.hore@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250207124300.1022523-1-soumyadeep.hore@intel.com>
References: <20250207124300.1022523-1-soumyadeep.hore@intel.com>
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

Update E830 ETF offload time stamp resolution to 128ns.

Signed-off-by: Soumyadeep Hore <soumyadeep.hore@intel.com>
Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
---
 drivers/net/intel/ice/base/ice_lan_tx_rx.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/ice/base/ice_lan_tx_rx.h b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
index 15aabf321d..940c6843d9 100644
--- a/drivers/net/intel/ice/base/ice_lan_tx_rx.h
+++ b/drivers/net/intel/ice/base/ice_lan_tx_rx.h
@@ -1306,6 +1306,7 @@ struct ice_txtime_ctx {
 #define ICE_TXTIME_CTX_DRBELL_MODE_32	1
 	u8 ts_res;
 #define ICE_TXTIME_CTX_FETCH_PROF_ID_0 0
+#define ICE_TXTIME_CTX_RESOLUTION_128NS 7
 	u8 ts_round_type;
 	u8 ts_pacing_slot;
 	u8 merging_ena;
-- 
2.43.0

