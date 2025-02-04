Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602C4C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:13:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22C504278D;
	Tue,  4 Feb 2025 16:11:56 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 29DB3410FC
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681902; x=1770217902;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1aylUZsTgDf3K4xQXReqQsEB0KOT6c1wR3eAToxWspo=;
 b=Yma4WbgPsQwQOjL6wL0Z60sRz7LUSCkPylNwXjg3w6/gJAzx2Wo3SQoW
 KIvtuxqCNMecYVKJNMBLK/oeYGIx3CDonc32UoFwaKnRVTNEXf9pQHqMT
 FXZ+vtULL9b1jU/kqjBeUP0a9t5m/Bj9jJ76q01am18Xflw2NVYaROB08
 DPS9BdanODFQx0hZQKQXhCYuri8+9DsZUoLEPocH6BP/Yds/iRoVWEeNA
 Tv+5MRoplJl+wvKFq+xlvjln7NVulD10nVEPrYa9Ggi1HpHNHAaikhD4O
 j0tj/OAH9jGZCZagvlT5IyRRLR/R5i5t+oTwnvuPTrWhsGxI7yItBAURZ A==;
X-CSE-ConnectionGUID: TmuzjwsJSAmjHG/lxzMiiw==
X-CSE-MsgGUID: sKG8NG7MSYmF9NsGXRiYCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097106"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097106"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:41 -0800
X-CSE-ConnectionGUID: IBE3uhn7QoKmOw3p5H0ImA==
X-CSE-MsgGUID: PiDqRQ+rRCG3HEdJnpb9Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792593"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:39 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 10/54] net/e1000/base: read PCIe bus info in i225
Date: Tue,  4 Feb 2025 15:10:16 +0000
Message-ID: <b68397f6cdb418c9497b0019c187805d10422513.1738681726.git.anatoly.burakov@intel.com>
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

Call e1000_get_bus_info_pcie_generic from i225 to read PCIe bus info.

Signed-off-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index 2b2ea6ed7b..13b4465b9c 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -94,7 +94,8 @@ static s32 e1000_init_mac_params_i225(struct e1000_hw *hw)
 	mac->mta_reg_count = 128;
 	/* Set rar entry count */
 	mac->rar_entry_count = E1000_RAR_ENTRIES_BASE;
-
+	/* bus type/speed/width */
+	mac->ops.get_bus_info = e1000_get_bus_info_pcie_generic;
 	/* reset */
 	mac->ops.reset_hw = e1000_reset_hw_i225;
 	/* hw initialization */
-- 
2.43.5

