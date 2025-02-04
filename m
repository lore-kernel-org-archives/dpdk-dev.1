Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7A1C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:14:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA2F2427BA;
	Tue,  4 Feb 2025 16:12:05 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 965E842792
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681910; x=1770217910;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/e045J4eq5nCrqHFpikolyUFlirn1QjvuZQ4ZRoqYVU=;
 b=b1l6O051JqQjqvsRnXRBilXESwiEV0qEPmDTV4XXGIwXWH+4x2ybE5lx
 DrHIgM5s+u/B0WDSJ1udORKBWZpapKsxT8lzJwc3LCT854hf3Ch3aq6EM
 xIPu1K02x6lUhf0b6CuQFD/gbBZ1J1ZXEu1Y6kvHFY9XK/+BhrbuXr4CZ
 fdxxsQ7LcO/Q0QSxvLA6N8UUGPeUyndv6EWDN02M/SGq69SNEXpI1Btt9
 G8wF4hcINW6oojromPvJDHeHgpVQwElHhdhy6UkSkHXLcU0gTbktTuYvB
 zvHhgFMcITMwfz38AIS3xFk7Z89EBttJYaZDCqEa6qv1y+mO4tYhcCHHz A==;
X-CSE-ConnectionGUID: U9zi/NePTJC/PL9jnktHAQ==
X-CSE-MsgGUID: WJ+cQhzgRC2qFjq/w3Op2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097120"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097120"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:50 -0800
X-CSE-ConnectionGUID: onVt17coROG4nCWO3ZQ7yQ==
X-CSE-MsgGUID: 3EMPZMFGSR6lYkqnKE+U8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792634"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:48 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 17/54] net/e1000/base: add PHY reset support for i225
Date: Tue,  4 Feb 2025 15:10:23 +0000
Message-ID: <71083603ed7fdcff8e2c032e90fe3f50b9106f14.1738681726.git.anatoly.burakov@intel.com>
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

From: Evgeny Efimov <evgeny.efimov@intel.com>

Use PHY reset generic implementation for i225.

Signed-off-by: Evgeny Efimov <evgeny.efimov@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i225.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/e1000/base/e1000_i225.c b/drivers/net/intel/e1000/base/e1000_i225.c
index a2d4faa0a9..d7dc982ac3 100644
--- a/drivers/net/intel/e1000/base/e1000_i225.c
+++ b/drivers/net/intel/e1000/base/e1000_i225.c
@@ -165,6 +165,7 @@ static s32 e1000_init_phy_params_i225(struct e1000_hw *hw)
 	phy->ops.check_reset_block = e1000_check_reset_block_generic;
 	phy->ops.commit		= e1000_phy_sw_reset_generic;
 	phy->ops.release	= e1000_release_phy_base;
+	phy->ops.reset		= e1000_phy_hw_reset_generic;
 
 	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
 
-- 
2.43.5

