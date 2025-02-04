Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE459C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0995427D9;
	Tue,  4 Feb 2025 16:12:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 41E7B410FB;
 Tue,  4 Feb 2025 16:11:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681920; x=1770217920;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=+PLmudy1IlgEWBR9Bw3Ow6WGRzX7KZzgf8cPIhCUUTk=;
 b=B99Z+WFjDVZXtBtzM4ZPy9HhRFrWTvKir5S81bOfvQ/pnSsUJtcCy8Ii
 8KR1LVvLlFcq0mjpZHuh9s+P3pMO0hwWJTNeaFKyUGVH9hPm7Mn3E+LLS
 Q+kTdTG5PXYelMRGinUUxlu3fU7hCYnSNjN0d7N2cuY5+OWECWFapwKe5
 NMdz0Jr6Oylr9xKGD9V1AAX/Nx9u4oVd36DPAGDqIhB/Jv1libqRncF1l
 vFmizIwYGSS/Dv10ExK45qS19HnxB9rkqL+zN8DkErmCe6Im2A8MEnZzr
 sg7bJK6k2iew57tqFDDZXYaPcPIQrpV2AtlTaPfUs4qzGT6wnWcsKLRZv A==;
X-CSE-ConnectionGUID: C+4UVwtlSgO335rS07lWxA==
X-CSE-MsgGUID: qiuplNFmSm65t1TszHGNVQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097135"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097135"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:59 -0800
X-CSE-ConnectionGUID: vR9DB6+kSGiSc98bACHDbQ==
X-CSE-MsgGUID: lhgO6CStQt2namqky5KL9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792681"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:57 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 25/54] net/e1000/base: fix semaphore timeout value
Date: Tue,  4 Feb 2025 15:10:31 +0000
Message-ID: <df101d04f896a7fe27a2bee90cbadbcf8041c867.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Pawel Malinowski <pawel.malinowski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_defines.h | 1 +
 drivers/net/intel/e1000/base/e1000_i225.c    | 2 +-
 drivers/net/intel/e1000/base/e1000_mac.c     | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 8dfdce7dad..2c3b806c92 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -521,6 +521,7 @@
 /* SW Semaphore Register */
 #define E1000_SWSM_SMBI		0x00000001 /* Driver Semaphore bit */
 #define E1000_SWSM_SWESMBI	0x00000002 /* FW Semaphore bit */
+#define E1000_SWSM_TIMEOUT	2000       /* Driver Semaphore max timeout counter */
 #define E1000_SWSM_DRV_LOAD	0x00000008 /* Driver Loaded Bit */
 
 #define E1000_SWSM2_LOCK	0x00000002 /* Secondary driver semaphore bit */
diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index a4f5b73724..c8d3114c28 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -395,7 +395,7 @@ s32 e1000_setup_copper_link_i225(struct e1000_hw *hw)
 static s32 e1000_get_hw_semaphore_i225(struct e1000_hw *hw)
 {
 	u32 swsm;
-	s32 timeout = hw->nvm.word_size + 1;
+	s32 timeout = E1000_SWSM_TIMEOUT;
 	s32 i = 0;
 
 	DEBUGFUNC("e1000_get_hw_semaphore_i225");
diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 7e53da613c..0db114c0df 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -1702,7 +1702,7 @@ s32 e1000_get_speed_and_duplex_fiber_serdes_generic(struct e1000_hw E1000_UNUSED
 s32 e1000_get_hw_semaphore_generic(struct e1000_hw *hw)
 {
 	u32 swsm;
-	s32 timeout = hw->nvm.word_size + 1;
+	s32 timeout = E1000_SWSM_TIMEOUT;
 	s32 i = 0;
 
 	DEBUGFUNC("e1000_get_hw_semaphore_generic");
-- 
2.43.5

