Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE54C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1809840FDE;
	Thu,  6 Feb 2025 17:09:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 1689A40EF1
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858154; x=1770394154;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=wzonepda94RIkQrMNXeHca2qDdCmpyO4tEIhMhvSMUE=;
 b=nwsdqat67wT4B0+LC51P4P4PzKNniDUiRxMGB7UiofVdvNPpCk/CQroa
 P9/5bCdHCBCR+36YNQc5k+rv5DWljGJl66ToXPpnhPhIoyHAk+tsgm/yh
 XY22POtqDwNGOhXHB6r95rMA1/RxJHxo9ZN9jNiEhHLYUFFDS0PDs8Rty
 mvJxGdOlk8kMFq5WP5mWPbGfEOcxdNHB7BFGWVHPfKZ4iq7WZ9+a1sAgy
 6aPtIVfclvZfb9KNZVqslYU/JOti8exVYrrT6fBzCO6zzqjvTxSLgrZ9B
 zFcX9BhraVmYY+t/APxF9KvVLO14VSKW4U1R0Cshd7/lgAwSP0mrwPJto g==;
X-CSE-ConnectionGUID: oWFUdhWDR7K7gcB8sY9qbg==
X-CSE-MsgGUID: o4ApCu7eS3iN1Ri48Efj0w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860724"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860724"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:13 -0800
X-CSE-ConnectionGUID: NOe6OTurQq+GquAIR0mu5A==
X-CSE-MsgGUID: 69aEmRhoQl6isn9SJYnYZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166739"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:12 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Alvin Zhang <alvinx.zhang@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v1 09/24] net/igc/base: fix semaphore timeout value
Date: Thu,  6 Feb 2025 16:08:32 +0000
Message-ID: <5c9fdb9467947a1f77eae339a33844907be9033d.1738858026.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738858026.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738858026.git.anatoly.burakov@intel.com>
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

From: Pawel Malinowski <pawel.malinowski@intel.com>

According to datasheet software ownership of SWSM.SWESMBI bit should not
exceed 100ms. Current implementation caused incorrect timeout counter
values, where each iteration equals 50us delay. Because of that driver was
allowed to wait for semaphore even for 1,5s. This might trigger DPC
timeout.

This implementation hardcodes value to 2000, which multiplied by 50us,
gives 100ms of possible wait time.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Pawel Malinowski <pawel.malinowski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_defines.h | 1 +
 drivers/net/intel/igc/base/igc_i225.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/igc/base/igc_defines.h b/drivers/net/intel/igc/base/igc_defines.h
index 280570b157..3cb2f430c5 100644
--- a/drivers/net/intel/igc/base/igc_defines.h
+++ b/drivers/net/intel/igc/base/igc_defines.h
@@ -525,6 +525,7 @@
 /* SW Semaphore Register */
 #define IGC_SWSM_SMBI		0x00000001 /* Driver Semaphore bit */
 #define IGC_SWSM_SWESMBI	0x00000002 /* FW Semaphore bit */
+#define IGC_SWSM_TIMEOUT	2000       /* Driver Semaphore max timeout counter */
 #define IGC_SWSM_DRV_LOAD	0x00000008 /* Driver Loaded Bit */
 
 #define IGC_SWSM2_LOCK	0x00000002 /* Secondary driver semaphore bit */
diff --git a/drivers/net/intel/igc/base/igc_i225.c b/drivers/net/intel/igc/base/igc_i225.c
index 23c68a3948..7352ba240a 100644
--- a/drivers/net/intel/igc/base/igc_i225.c
+++ b/drivers/net/intel/igc/base/igc_i225.c
@@ -388,7 +388,7 @@ s32 igc_setup_copper_link_i225(struct igc_hw *hw)
 static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
 {
 	u32 swsm;
-	s32 timeout = hw->nvm.word_size + 1;
+	s32 timeout = IGC_SWSM_TIMEOUT;
 	s32 i = 0;
 
 	DEBUGFUNC("igc_get_hw_semaphore_i225");
-- 
2.43.5

