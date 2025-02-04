Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B269C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:14:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 03D80427BC;
	Tue,  4 Feb 2025 16:12:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id AF51C4278D
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681911; x=1770217911;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=d04H1r/BFKZQrYHutrc14wScu3h/jt78G13bPy4ZCCw=;
 b=eKMyRmaOVk4Tq6ocGn94J/NNtCB+BvhVSxuLO9Oo503XUK/1cW7wFll7
 qpodinjCMKmNQxMRuq3dCmuHDRVTXS+fLr2mxobdMzYzvu/H0fjkMMc8x
 fBj66PmYxJLoMKGzdHOa/MyN7qUQe2+RZ7kuSIkpdCklqllmL/IxUlXG6
 Vz50y156KdpuuEDVhRorQ8QOE+AxLbozH5mbpG/+3b1gAmTeYqhzt2VsY
 2J08Z/HYj/jKdAtm1T4gEkrosxKSwngo+qEVEuGJ4KVywc6A7gfr+sywj
 0K1M6Luz8d8BY2Qn9sXFlxMYYkZB0O9kDjFj1wR61yq3dr2Uys2Awh49a Q==;
X-CSE-ConnectionGUID: e9ykrgFCTL20vsqmCppYTg==
X-CSE-MsgGUID: y6CUsrEcS62TAstK2/MWpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097122"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097122"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:51 -0800
X-CSE-ConnectionGUID: JgKT72KLSj27GOYSUzOa0Q==
X-CSE-MsgGUID: 9Pb5067ATtiusaZLddMV4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792639"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:49 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 18/54] net/e1000/base: fix infinite loop
Date: Tue,  4 Feb 2025 15:10:24 +0000
Message-ID: <31373aa54ca6351e329f134234eea8633af3d2a6.1738681726.git.anatoly.burakov@intel.com>
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

From: Dima Ruinskiy <dima.ruinskiy@intel.com>

When the driver fails to acquire HW semaphore, there is nothing that can be
done to address it, so just leave to avoid an infinite loop.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index d7dc982ac3..18a4b38cba 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -340,8 +340,15 @@ void e1000_release_swfw_sync_i225(struct e1000_hw *hw, u16 mask)
 
 	DEBUGFUNC("e1000_release_swfw_sync_i225");
 
-	while (e1000_get_hw_semaphore_i225(hw) != E1000_SUCCESS)
-		; /* Empty */
+	/* Releasing the resource requires first getting the HW semaphore.
+	 * If we fail to get the semaphore, there is nothing we can do,
+	 * except log an error and quit. We are not allowed to hang here
+	 * indefinitely, as it may cause denial of service or system crash.
+	 */
+	if (e1000_get_hw_semaphore_i225(hw) != E1000_SUCCESS) {
+		DEBUGOUT("Failed to release SW_FW_SYNC.\n");
+		return;
+	}
 
 	swfw_sync = E1000_READ_REG(hw, E1000_SW_FW_SYNC);
 	swfw_sync &= ~mask;
-- 
2.43.5

