Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F25C0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 12:59:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1DD76427C3;
	Fri, 31 Jan 2025 13:59:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 13B28400D7;
 Fri, 31 Jan 2025 13:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328363; x=1769864363;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6C+/1VxdEgqUaWvwWlNJg5oshNpuBlSd7RfXOShcyUc=;
 b=kDmLCWNGTVIdUs0wYJ+Znc/DjcYj8NXzBvngjJthlCIQgKdtBxRLX6Yc
 3lHRQCDAEUu0oVExm9bO8sHJYDwTRS16A8+r0zSlrkFzXesy4eR6YIdYT
 x4MwLm/7jitdtWMlDd7eN0vpGnqTuxpLOnlY+RTPH5XxHV7RFL1X0siQU
 xTyLb+gOt+RwcZk3iM7WBP2zBJdhtbwrKjuIe+wFK1G7JWSWMFTVYCnrc
 EbDMhVTRz+sVDfnlxS/1GlNAsogB1RSvMP7dUE68+yUO8w5z2sCwlvca+
 QZruMtxHbKf9wACedLmBGuOYSb05x27Nx5140ZqjMLLTGsrL4DYYmvxkg Q==;
X-CSE-ConnectionGUID: VCNT8vhdSyeoiyPRzj9J3w==
X-CSE-MsgGUID: ge14YlkZRjej/dmCdEsqCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315596"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315596"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:21 -0800
X-CSE-ConnectionGUID: HW7vOXm9S0+FGNSV9oIPbg==
X-CSE-MsgGUID: 19iJPuEBQXW3VmMvkIMiUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503332"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:20 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 01/42] net/e1000/base: fix semaphore timeout value
Date: Fri, 31 Jan 2025 12:58:14 +0000
Message-ID: <ed25ea82e9bd3263a45753c31df20c0dfedd8ee6.1738328107.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/e1000/base/e1000_mac.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_defines.h b/drivers/net/intel/e1000/base/e1000_defines.h
index 3fbb6c8ea4..97cc2797b2 100644
--- a/drivers/net/intel/e1000/base/e1000_defines.h
+++ b/drivers/net/intel/e1000/base/e1000_defines.h
@@ -504,6 +504,7 @@
 /* SW Semaphore Register */
 #define E1000_SWSM_SMBI		0x00000001 /* Driver Semaphore bit */
 #define E1000_SWSM_SWESMBI	0x00000002 /* FW Semaphore bit */
+#define E1000_SWSM_TIMEOUT	2000       /* Driver Semaphore max timeout counter */
 #define E1000_SWSM_DRV_LOAD	0x00000008 /* Driver Loaded Bit */
 
 #define E1000_SWSM2_LOCK	0x00000002 /* Secondary driver semaphore bit */
diff --git a/drivers/net/intel/e1000/base/e1000_mac.c b/drivers/net/intel/e1000/base/e1000_mac.c
index d3b3a6bac9..cf0a9f21e1 100644
--- a/drivers/net/intel/e1000/base/e1000_mac.c
+++ b/drivers/net/intel/e1000/base/e1000_mac.c
@@ -1688,7 +1688,7 @@ s32 e1000_get_speed_and_duplex_fiber_serdes_generic(struct e1000_hw E1000_UNUSED
 s32 e1000_get_hw_semaphore_generic(struct e1000_hw *hw)
 {
 	u32 swsm;
-	s32 timeout = hw->nvm.word_size + 1;
+	s32 timeout = E1000_SWSM_TIMEOUT;
 	s32 i = 0;
 
 	DEBUGFUNC("e1000_get_hw_semaphore_generic");
-- 
2.43.5

