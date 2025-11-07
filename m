Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7519CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 07:23:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1046C40280;
	Fri,  7 Nov 2025 08:23:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id B4A3940264;
 Fri,  7 Nov 2025 08:23:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762500218; x=1794036218;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=l7gHsan+19zfxbGmo/YMh4N6hdDTOYMBEd8QFGFcaIQ=;
 b=HixxRcHFuITQtoVj8kX/b/oruGqGZzBwbrZB0GlohmoF+9EDzMKd9beQ
 4/qLN1/qNRvEr/2k2LWsCRHjwo733PHhVCCvhl2Eb/uMOMXYuTgInH69r
 +M30IZO6cTuRyHNBXuQFe6lKdj6CFVhyP7uB2RjnI1JOyYtpAZxog3yj9
 xDu3dE6vaLYJh0J1j6PT9aIRNXlWSWxjaza1ubEpD0Ag5+wiRwfY0V+R0
 w74Xm8rlYg/KCHjdaJGTumiDY/Vqf2l5I6LaFDsPQ5FLrL6G8jdIGlzk2
 XAbP65f6mFlmW3hAlr4JXSZYdmAvcdxD0ms5NdogNZu/1OxpFIp/KIwQM Q==;
X-CSE-ConnectionGUID: RXc3gMByRHyr53yESEGRzw==
X-CSE-MsgGUID: uZdMWXczRp+2fT+kUpX40A==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64574230"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="64574230"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 23:23:37 -0800
X-CSE-ConnectionGUID: MQawvkVfT0C2aXOf67uQ0g==
X-CSE-MsgGUID: SLX81ijoSdyoMM3J9+MBiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,286,1754982000"; d="scan'208";a="192334131"
Received: from unknown (HELO zhichao-dpdk..) ([10.239.252.103])
 by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 23:23:34 -0800
From: Zhichao Zeng <zhichaox.zeng@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org, Zhichao Zeng <zhichaox.zeng@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Ferruh Yigit <ferruh.yigit@amd.com>, Wenzhuo Lu <wenzhuo.lu@intel.com>,
 Jeff Guo <jia.guo@intel.com>
Subject: [PATCH] net/ice: fix statistics read error
Date: Fri,  7 Nov 2025 15:43:38 +0800
Message-Id: <20251107074338.957352-1-zhichaox.zeng@intel.com>
X-Mailer: git-send-email 2.34.1
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

In some cases, after reading the lower 32 bits, a carry occurs from the
lower bits, which causes the final statistics to be incorrect.

This commit fixes this issue.

Fixes: a37bde56314d ("net/ice: support statistics")
Cc: stable@dpdk.org

Signed-off-by: Zhichao Zeng <zhichaox.zeng@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 513777e372..be08be0826 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -6036,10 +6036,19 @@ ice_stat_update_40(struct ice_hw *hw,
 		   uint64_t *stat)
 {
 	uint64_t new_data;
+	uint32_t lo, hi, lo2;
 
-	new_data = (uint64_t)ICE_READ_REG(hw, loreg);
-	new_data |= (uint64_t)(ICE_READ_REG(hw, hireg) & ICE_8_BIT_MASK) <<
-		    ICE_32_BIT_WIDTH;
+	lo = ICE_READ_REG(hw, loreg);
+	hi = ICE_READ_REG(hw, hireg);
+	lo2 = ICE_READ_REG(hw, loreg);
+
+	if (lo2 < lo) {
+		lo = ICE_READ_REG(hw, loreg);
+		hi = ICE_READ_REG(hw, hireg);
+	}
+
+	new_data = (uint64_t)lo;
+	new_data |= (uint64_t)(hi & ICE_8_BIT_MASK) << ICE_32_BIT_WIDTH;
 
 	if (!offset_loaded)
 		*offset = new_data;
-- 
2.34.1

