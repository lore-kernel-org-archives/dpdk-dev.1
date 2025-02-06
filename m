Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7A9C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC73941140;
	Thu,  6 Feb 2025 17:09:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id C6883410E7
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858161; x=1770394161;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6C+/1VxdEgqUaWvwWlNJg5oshNpuBlSd7RfXOShcyUc=;
 b=eBFVEICSq5CamYOYjKp1/kwyLHFfObS21HOCTuyVtexr+iglMg4WJuzK
 sZIC5MjyAIiF/WdY6+YMqtQYmZvWyBY0eINFhVAwUUA9ezXP7HVvfjnS6
 TecY1fFgyLGFq49LQQtKwCsMniRMQCNBYuqdYmOYbMtuc9G8iwQblZnDS
 wnrEG2C05SyfGZlCk5wDriSRksMkDwXQ8isI5+mP07rEvUGqx+V1fl520
 Yr6Id+y5GJpxMmFzekynZzIUV8GaqXC00Fty2I3c7Nt38bNaTsGuaioV1
 lkk0sv+nC86jTKBFzmg4eBwKa0/og4JiwSAaviQ4izgTJzVnd6EvdN1CO A==;
X-CSE-ConnectionGUID: lreLahqkShuRZabjdYASFA==
X-CSE-MsgGUID: 3cCY6z2kRuyL5AR5naALpQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860753"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860753"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:20 -0800
X-CSE-ConnectionGUID: 434hrBJ+RL68z2yOI+V6xQ==
X-CSE-MsgGUID: HEn+bXJkSTCpzeIWMn1iFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166779"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:19 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 14/24] net/e1000/base: fix semaphore timeout value
Date: Thu,  6 Feb 2025 16:08:37 +0000
Message-ID: <8d40b53efd125862541d424e4e5515a3edb857e2.1738858026.git.anatoly.burakov@intel.com>
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

