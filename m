Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B53C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0D6140E54;
	Thu,  6 Feb 2025 17:09:06 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C508140E44
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858146; x=1770394146;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7mCVJcUfvNRTl9/Ola8c7q+2eDEeRNtuegwzEIH/HhA=;
 b=ged/x/VwyDrlVi/DBp2fU7chOi2pAjwV+qOBLDGykvE/MoaI6JyVts8u
 uHQMm0+Gq7ZqwkNq/lJOrs/WEl8iwd4cp/gzv+gq3+rYUBn63aAbmuuSF
 uRKxsVGrWVwZEecs3YBO1Qc8xO5lyOnH2pjkqfLyW4Xgt4luFVqznZ4TW
 qc5Y3wkxo7BE3L9/UVVOi2244GCTYVClw2w0mjzz3Hnlkqsfu216BWTna
 /i+auiDL8l5CgDilv6YPdK644kbogMbc6jq8NxtZKB2FRqSfmqQOiQTsQ
 SxN+IGx7tzfjWQod5goxMVBWebE3x49fX82bmQOrMiBZ3Ev9AuCDgI6Qe Q==;
X-CSE-ConnectionGUID: As3Gm0OnQU2rJljyxT9FVw==
X-CSE-MsgGUID: 6aIre8L4QjmX2Sev9/hT8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860713"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860713"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:03 -0800
X-CSE-ConnectionGUID: nF6FJb10STac1NH+pfHe5w==
X-CSE-MsgGUID: Rl+pzFAiS5qY8sXaDyjSYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166623"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:01 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Ferruh Yigit <ferruh.yigit@intel.com>,
 Alvin Zhang <alvinx.zhang@intel.com>
Subject: [PATCH v1 02/24] net/igc/base: fix infinite loop
Date: Thu,  6 Feb 2025 16:08:25 +0000
Message-ID: <2681cc33ab04cc2655605f73dc12ef7470187428.1738858026.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

When the driver fails to acquire HW semaphore, there is nothing that can be
done to address it, so just leave to avoid an infinite loop.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_i225.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/igc/base/igc_i225.c b/drivers/net/intel/igc/base/igc_i225.c
index 17a1573064..8f01f8d918 100644
--- a/drivers/net/intel/igc/base/igc_i225.c
+++ b/drivers/net/intel/igc/base/igc_i225.c
@@ -333,8 +333,15 @@ void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask)
 
 	DEBUGFUNC("igc_release_swfw_sync_i225");
 
-	while (igc_get_hw_semaphore_i225(hw) != IGC_SUCCESS)
-		; /* Empty */
+	/* Releasing the resource requires first getting the HW semaphore.
+	 * If we fail to get the semaphore, there is nothing we can do,
+	 * except log an error and quit. We are not allowed to hang here
+	 * indefinitely, as it may cause denial of service or system crash.
+	 */
+	if (igc_get_hw_semaphore_i225(hw) != IGC_SUCCESS) {
+		DEBUGOUT("Failed to release SW_FW_SYNC.\n");
+		return;
+	}
 
 	swfw_sync = IGC_READ_REG(hw, IGC_SW_FW_SYNC);
 	swfw_sync &= ~mask;
-- 
2.43.5

