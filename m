Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05525C02194
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C38BE415D7;
	Thu,  6 Feb 2025 17:09:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8CD1540E4F
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858166; x=1770394166;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=zrMcnOuDGuCWe1CpOXR0MgiFSCNHOgk7185geHx3HRU=;
 b=SgxMz7oRIL4X2W06bot01JZpS5kGgoGBVND8GYiIak6NIgpsSCFAvGoX
 Zv0anUe6yhrG5TRKk+P7ktigERyickZwqNckD4ZhBBKobcS0XZY1Wsdjr
 FWSPX1xt7NUdEklGIOBCnKy7mYMk3dZxm55aTsiUl3Np4Mrkw7wZZ0F0W
 md1Wr2HYoeStcihSheXlqA8+giGM7H7oCs/DO3czLQFGV60QCHrDjXbD7
 mZFiaXbCPgnSjcttzW2bw8JzgwQK1o6OxfjdeGGJble8vDf3z7rStuq3m
 iZh8gGE1CTqNn3yCzVe8z/OTJg8/XGfoi7y/PJFZ18InwAfnzocmJd+wU w==;
X-CSE-ConnectionGUID: gKna+pP1SgKz9/+aqzXCRw==
X-CSE-MsgGUID: cjFmMb55SSCcdgxdsFY9rQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860762"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860762"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:25 -0800
X-CSE-ConnectionGUID: 0sH4SsaQTWildFoKnCxBRQ==
X-CSE-MsgGUID: XeqwHYuGSoq5Ls9w5L0qTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166805"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:24 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 18/24] net/e1000/base: fix data type in MAC hash
Date: Thu,  6 Feb 2025 16:08:41 +0000
Message-ID: <6740ac1e585f684668ec5da5e1fd72d0f6619e0a.1738858026.git.anatoly.burakov@intel.com>
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

From: Barbara Skobiej <barbara.skobiej@intel.com>

One of the bit shifts in MAC hash calculation triggers a static analysis
warning about a potential overflow. Fix the data type to avoid this.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Barbara Skobiej <barbara.skobiej@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_mac.c | 6 ++++--
 drivers/net/intel/e1000/base/e1000_vf.c  | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index 2b8482e114..5bb77d9e09 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -541,8 +541,10 @@ u32 e1000_hash_mc_addr_generic(struct e1000_hw *hw, u8 *mc_addr)
 		break;
 	}
 
-	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
-				  (((u16) mc_addr[5]) << bit_shift)));
+	hash_value = (u32)mc_addr[4];
+	hash_value = hash_value >> (8 - bit_shift);
+	hash_value |= (((u32)mc_addr[5]) << bit_shift);
+	hash_value &= hash_mask;
 
 	return hash_value;
 }
diff --git a/drivers/net/intel/e1000/base/e1000_vf.c b/drivers/net/intel/e1000/base/e1000_vf.c
index 3d0383fcbb..fc30357c17 100644
--- a/drivers/net/intel/e1000/base/e1000_vf.c
+++ b/drivers/net/intel/e1000/base/e1000_vf.c
@@ -345,8 +345,10 @@ STATIC u32 e1000_hash_mc_addr_vf(struct e1000_hw *hw, u8 *mc_addr)
 	while (hash_mask >> bit_shift != 0xFF && bit_shift < 4)
 		bit_shift++;
 
-	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
-				  (((u16) mc_addr[5]) << bit_shift)));
+	hash_value = (u32)mc_addr[4];
+	hash_value = hash_value >> (8 - bit_shift);
+	hash_value |= (((u32)mc_addr[5]) << bit_shift);
+	hash_value &= hash_mask;
 
 	return hash_value;
 }
-- 
2.43.5

