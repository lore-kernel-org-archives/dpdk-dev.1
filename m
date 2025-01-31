Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6C1C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:04:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E5BFB42ECC;
	Fri, 31 Jan 2025 14:00:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A4CC0427B6;
 Fri, 31 Jan 2025 14:00:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328410; x=1769864410;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pMigtNfhufy1sMcPxAL8ocGnnqnQkPoDFrNXq9LfbwU=;
 b=H4ix8EB0BTmTRZABfK3G2jVHgzDZLJKGNH2MdbvNxi7CUy0iHvZTkWuv
 Ohg9LXht9FS6VPT3J6zN1nnay+3bl6yDJGxC59lwmnmjtwkx519BUHZQM
 Wqj9LKXdkeaDtqXyBvtDzGoawX1chF+CpLxhudVmFcEbku/6xSGIzccHr
 GdvA2Sx5WWPasYlo69GfVZJcgR4gOW7BExGrXeTFx4xNLsawXbA1kTFbY
 01wQMbZzffxOgX7VF3fwSKPyUKUQ0Znxr+GUXHhapdy45IMkcbQbjEq2i
 zplPC3HkljEG5lNJCY+QwkTzX7nqWpXAdppi6myYvjiWwYfij9DxoI8U6 Q==;
X-CSE-ConnectionGUID: m2tUOCIuRsyYzl5q3+WT0w==
X-CSE-MsgGUID: ZdGFmPXYQLSbqCCf/ZH8Og==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315683"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315683"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 05:00:09 -0800
X-CSE-ConnectionGUID: BNgNk+1RT+6xPqcEov2iaQ==
X-CSE-MsgGUID: 1MeBohc4Sqy9lHLs/Eyjwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503496"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 05:00:08 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 40/42] net/e1000/base: fix data type in MAC hash
Date: Fri, 31 Jan 2025 12:58:53 +0000
Message-ID: <08722285d17d8d42c78e0522c4558d48bbd8349d.1738328108.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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
index 4ec7cab7ab..2fa97d12a9 100644
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
index e0c95aa130..b02459900b 100644
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

