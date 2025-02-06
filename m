Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B12C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:09:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E9B440ED9;
	Thu,  6 Feb 2025 17:09:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8341C4029A
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858150; x=1770394150;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=lmHpNwOd73Jr8FFXLunxCyGl12wFTwC7GBcMCJslrKk=;
 b=IWkus7W/QUIFW1Tqolymyqe1wH/hVOmOSIXlhnBIQzOxzvcLk7IdmPcr
 yr5NENP6V+DZDd70RVssLnY9VtzxeTCOoiFmNyVGQwLC6UyZP/xzd7A92
 zXFmpJJ89vayyihjnF4aB5EQLRoZXaDfpHXqlGRXP3DZhYfdAMJnpecXI
 08IpY91YyqDFkUZN6RwZXi+qKEIBq/ch7blwcYul47DLL6xNAKUOJum2y
 AqQ0/qcoHFFJjbOSbak/eCwdwOIk7d5Xk+oCVj8GnBuOWFWQGO4BQ+DfX
 ohfUUdcu6G/oJfYgKZ8bql40jupzy/0yYZnxQR01pjeP+lTQCC7naw+WP Q==;
X-CSE-ConnectionGUID: Fj5lxDO4Tgywc3Q4042pQQ==
X-CSE-MsgGUID: QfHWf+5vR5GTdLCCszI9xA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860718"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860718"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:08 -0800
X-CSE-ConnectionGUID: 7I5zJxRoQVayMm6dJqf9Fg==
X-CSE-MsgGUID: YE6EgJZ9QdyK0dS/4Z5KiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166676"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:06 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Alvin Zhang <alvinx.zhang@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v1 05/24] net/igc/base: reset loop variable
Date: Thu,  6 Feb 2025 16:08:28 +0000
Message-ID: <6538bb0ae11e2ae5c9787f925a8cf63251638f6c.1738858026.git.anatoly.burakov@intel.com>
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

From: Sasha Neftin <sasha.neftin@intel.com>

When writing to Shadow RAM, we set rev_val on success, but since the value
is already set to success initially, it is possible for none of the writes
to be successful, yet ret_val will still be set to success. Fix it by
resetting the ret_val to failure before every loop iteration.

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_i225.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/intel/igc/base/igc_i225.c b/drivers/net/intel/igc/base/igc_i225.c
index 1277f59885..003c060215 100644
--- a/drivers/net/intel/igc/base/igc_i225.c
+++ b/drivers/net/intel/igc/base/igc_i225.c
@@ -565,6 +565,7 @@ static s32 __igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
 	}
 
 	for (i = 0; i < words; i++) {
+		ret_val = -IGC_ERR_NVM;
 		eewr = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) |
 			(data[i] << IGC_NVM_RW_REG_DATA) |
 			IGC_NVM_RW_REG_START;
-- 
2.43.5

