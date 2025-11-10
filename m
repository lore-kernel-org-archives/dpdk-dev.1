Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3C0CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 07:45:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36045402E1;
	Mon, 10 Nov 2025 08:45:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id 383C8400D5;
 Mon, 10 Nov 2025 08:45:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762760715; x=1794296715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zfAZaAJZqCZnyCfGQ0fYDnOLv0zOSLGaLLsZF3qfRag=;
 b=RKBKKitdobqyiY2+0lKilcnXUBMr13GUMHb4hcQr9rPSJhzPx2i57SC9
 +T8eQpko4d65qupxHmBOkKTjTt11/zKs2OSJuWdN2dhMAwM1YvJ8hvajb
 GrdReI5ykCeLKDrbqI2kHG3Y5q7DJ8t90dq8HnpknffMJN2UQMnoRV+wR
 QhOxmrKbH0Ez5W0KDQ8rkxLz10d8SydQUePVSKyH6NbHhrMGb7BGASkGX
 DujXHJwiiYaY1IM+77Grwu5p1ACtQFSEvSKPpTTqaQ7H9KlnA/IPdyEkP
 GM0FES8tcVFHNSShZjwmr5EHYoCWL46iOk7Vyp5jcNcvHTud9ac2hajR9 w==;
X-CSE-ConnectionGUID: l6e4rj8VQQORKNqH60E4JQ==
X-CSE-MsgGUID: g7BwmhibT5KZS4R1XzxABQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="64507469"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; d="scan'208";a="64507469"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2025 23:45:14 -0800
X-CSE-ConnectionGUID: G4JYriOSRj+2cJ5y8kPxIg==
X-CSE-MsgGUID: qAtWj3LUQzmX4uwgoV/Ewg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; d="scan'208";a="192715948"
Received: from unknown (HELO zhichao-dpdk..) ([10.239.252.103])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2025 23:45:12 -0800
From: Zhichao Zeng <zhichaox.zeng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Zhichao Zeng <zhichaox.zeng@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>, Jeff Guo <jia.guo@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>
Subject: [PATCH v2] net/ice: fix statistics read error
Date: Mon, 10 Nov 2025 16:05:14 +0800
Message-Id: <20251110080514.2506769-1-zhichaox.zeng@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107074338.957352-1-zhichaox.zeng@intel.com>
References: <20251107074338.957352-1-zhichaox.zeng@intel.com>
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

The statistics contain 40 bits. The lower 32 bits are read first, followed
by the upper 8 bits.

In some cases, after reading the lower 32 bits, a carry occurs from
the lower bits, which causes the final statistics to be incorrect.

This commit fixes this issue.

Fixes: a37bde56314d ("net/ice: support statistics")
Cc: stable@dpdk.org

Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>

---
v2: replace single retries with loops
---
 drivers/net/intel/ice/ice_ethdev.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..016b25c63a 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -6351,10 +6351,16 @@ ice_stat_update_40(struct ice_hw *hw,
 		   uint64_t *stat)
 {
 	uint64_t new_data;
+	uint32_t lo_old, hi, lo;
 
-	new_data = (uint64_t)ICE_READ_REG(hw, loreg);
-	new_data |= (uint64_t)(ICE_READ_REG(hw, hireg) & ICE_8_BIT_MASK) <<
-		    ICE_32_BIT_WIDTH;
+	do {
+		lo_old = ICE_READ_REG(hw, loreg);
+		hi = ICE_READ_REG(hw, hireg);
+		lo = ICE_READ_REG(hw, loreg);
+	} while (lo_old > lo);
+
+	new_data = (uint64_t)lo;
+	new_data |= (uint64_t)(hi & ICE_8_BIT_MASK) << ICE_32_BIT_WIDTH;
 
 	if (!offset_loaded)
 		*offset = new_data;
@@ -6363,10 +6369,8 @@ ice_stat_update_40(struct ice_hw *hw,
 		*stat = new_data - *offset;
 	else
 		*stat = (uint64_t)((new_data +
-				    ((uint64_t)1 << ICE_40_BIT_WIDTH)) -
-				   *offset);
-
-	*stat &= ICE_40_BIT_MASK;
+					((uint64_t)1 << ICE_32_BIT_WIDTH))
+				   - *offset);
 }
 
 /**
-- 
2.34.1

