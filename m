Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552D0C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:11:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D41F04270A;
	Thu,  6 Feb 2025 17:09:32 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 05B454114B
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858168; x=1770394168;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gQS6Iqaj0UfiuRARmBKdPVYViEmDt6BK34rvepludkc=;
 b=TvJdiyM0/vP8P2AEH+R++DhbMgdmddGrNFZ6edDcU7/alrlBRX8UitFw
 5KjYssaZhPpvjj4jgW8PSpZ9a0DSISuYP977YkO2slbatZ5Tr9FrQ5naB
 a4i6CFbnNVk9RNP82R73Pu6ZEn1fckt4BQKcNy/PVHQ3JbzGUEqlPArb5
 +l0T4Ez/v+VO2H9nB9dwNyFXF83oe8oOG//Uwk2ujUmcurILy8PpbzgQb
 6w60H4UULodl8OHmpwn5eixMD+F5KZl5MtHzkDCz0qKrW3qDgw5qWo5Lw
 Jtp/RZLTUUUPQHyjrC5H4f7GbgmSC3vp45G9Xo8TfexdEF97WljSaNhCJ Q==;
X-CSE-ConnectionGUID: x91tzo9uShK1XT0hY6osBA==
X-CSE-MsgGUID: Ld+O6Qb7QqShNVBkdgQS5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860766"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860766"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:27 -0800
X-CSE-ConnectionGUID: DmaIQB2URHGYM4Me2jCA3A==
X-CSE-MsgGUID: kDdVHS6TTBqvQKr55VWahQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166819"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:27 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 20/24] net/e1000/base: fix static analysis warning
Date: Thu,  6 Feb 2025 16:08:43 +0000
Message-ID: <890d3900ac086b69c94ae5c6f5ec4c099b671cef.1738858026.git.anatoly.burakov@intel.com>
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

From: Przemyslaw Ciesielski <przemyslaw.ciesielski@intel.com>

There is a static analysis warning due to wrong data types being used for
SW/FW semaphore masking. Fix it via explicit type cast.

Fixes: 5a32a257f957 ("e1000: more NICs in base driver")
Cc: stable@dpdk.org

Signed-off-by: Przemyslaw Ciesielski <przemyslaw.ciesielski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_80003es2lan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_80003es2lan.c b/drivers/net/intel/e1000/base/e1000_80003es2lan.c
index 243bc6fe3e..3516ff2246 100644
--- a/drivers/net/intel/e1000/base/e1000_80003es2lan.c
+++ b/drivers/net/intel/e1000/base/e1000_80003es2lan.c
@@ -426,7 +426,7 @@ STATIC void e1000_release_swfw_sync_80003es2lan(struct e1000_hw *hw, u16 mask)
 		; /* Empty */
 
 	swfw_sync = E1000_READ_REG(hw, E1000_SW_FW_SYNC);
-	swfw_sync &= ~mask;
+	swfw_sync &= ~(u32)mask;
 	E1000_WRITE_REG(hw, E1000_SW_FW_SYNC, swfw_sync);
 
 	e1000_put_hw_semaphore_generic(hw);
-- 
2.43.5

