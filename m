Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D0EACCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 07:25:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A4E240BA2;
	Thu, 13 Nov 2025 08:25:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 40C864003C;
 Thu, 13 Nov 2025 08:25:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763018701; x=1794554701;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KiFhBAPVa6BizJ/bINhQ83moGZsmq+o3mOqfw9/zm/M=;
 b=TRe270gREOV7atsEXDrDJ8Y9XsYgfV2D9cA0ioM3iz3Gn8u2JrB6SBcB
 OAnlSLtQn23W5eD4cf9XGWTxIVj2sxW5ASjvhLKJOpAfRBw+ucsJXtgvu
 XGFkz1E4TIGw5btHuU55XDa84wcd3gJy1Uku8bJmBJpR5gdBCYYPE0+2j
 LBe2zOmn2L5YT2dMJU1lWIo7XGCxc8tKmTwhAADOUGumKdn+eW2tSwi22
 F247VMpPLiTdngyMxNnJbvHkB1IPBPQ2pFnUSyUQ58z6xYulGZ1soCiB1
 rL8i2mpsdK7vO/6jha0NHnH4tf6tcqLKhBLnmIx/3k+W2cbnsQMBOOaoh w==;
X-CSE-ConnectionGUID: BvVJZTIhS3qcNhXHN7NpMw==
X-CSE-MsgGUID: eHlEqdmKRrOQ0hMeAKOc7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64977306"
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="64977306"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 23:25:00 -0800
X-CSE-ConnectionGUID: Uqkbh0UGQ6K8b0uHLG1GEQ==
X-CSE-MsgGUID: WZDgoGilTOGjszM2dvDZLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,301,1754982000"; d="scan'208";a="189091829"
Received: from unknown (HELO zhichao-dpdk..) ([10.239.252.103])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 23:24:57 -0800
From: Zhichao Zeng <zhichaox.zeng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Zhichao Zeng <zhichaox.zeng@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>,
 Jeff Guo <jia.guo@intel.com>
Subject: [PATCH v3] net/ice: fix statistics read error
Date: Thu, 13 Nov 2025 15:47:10 +0800
Message-Id: <20251113074710.8251-1-zhichaox.zeng@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251110080514.2506769-1-zhichaox.zeng@intel.com>
References: <20251110080514.2506769-1-zhichaox.zeng@intel.com>
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
v3: fix wrong logic
---
 drivers/net/intel/ice/ice_ethdev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 4669eba7c7..5ec57ee2b0 100644
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
-- 
2.34.1

