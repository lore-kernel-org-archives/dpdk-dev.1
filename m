Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B67C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:03:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA02C42EA7;
	Fri, 31 Jan 2025 14:00:13 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id CE1C142E37;
 Fri, 31 Jan 2025 14:00:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328404; x=1769864404;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MLdbANrFt/W0CKy07PttwrJ0cPNPS70nUOpx7zwcICQ=;
 b=VJq572SlDIFLLz94bcMiZVrWp1sR25ZnlEICsPsIx7V6nJo1yfqhZbf0
 CBgVcp6F8grUvc0XMOYC1R3d5EJh6FPay9yQpubR+FWcdEQb5nLRWnW+y
 qW30dsQIZRRW2QnrncNq2g9c4/24OgxfhmGAQjSIoleLrMEqGS0axvL1m
 XGIsSQD3WKj/pcoDS0UzR7elxMre/l32rv5/BCgX+tk+6hGrIfohR2E6+
 O1XUe/RTjsCQ12/lZyNEcH6stGTS7FBLwJFaSoS/NPJjW0vfzrv9mg1qd
 ybf5D8kVhjg3/7jKGOOlOwKo/iVTvrP5HArQ3O+p9wk0kag/aIxwhpPZG Q==;
X-CSE-ConnectionGUID: bkN7ap4HQdSraX3UFPwOnw==
X-CSE-MsgGUID: JAE3/X7JR9+Up1IQjn76Dg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315674"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315674"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 05:00:03 -0800
X-CSE-ConnectionGUID: cYmwQPSVTiaMol8pzAdtdQ==
X-CSE-MsgGUID: VLzJsa3yQC2SbuljJCAtAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503455"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 05:00:02 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 35/42] net/e1000/base: fix static analysis warnings
Date: Fri, 31 Jan 2025 12:58:48 +0000
Message-ID: <cd06498019cd319e874cb8ea6705b2a3cdda5ab7.1738328108.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Przemysław Ciesielski <przemyslaw.ciesielski@intel.com>

There are some static analysis warnings due to wrong data types being used
for various operations. Fix them with explicit typecasts.

Fixes: 5a32a257f957 ("e1000: more NICs in base driver")
Fixes: 38db3f7f50bd ("e1000: update base driver")
Cc: stable@dpdk.org

Signed-off-by: Przemysław Ciesielski <przemyslaw.ciesielski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_80003es2lan.c | 2 +-
 drivers/net/intel/e1000/base/e1000_nvm.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_80003es2lan.c b/drivers/net/intel/e1000/base/e1000_80003es2lan.c
index b1f2df3803..1cbce5bedd 100644
--- a/drivers/net/intel/e1000/base/e1000_80003es2lan.c
+++ b/drivers/net/intel/e1000/base/e1000_80003es2lan.c
@@ -426,7 +426,7 @@ STATIC void e1000_release_swfw_sync_80003es2lan(struct e1000_hw *hw, u16 mask)
 		; /* Empty */
 
 	swfw_sync = E1000_READ_REG(hw, E1000_SW_FW_SYNC);
-	swfw_sync &= ~mask;
+	swfw_sync &= ~(u32)mask;
 	E1000_WRITE_REG(hw, E1000_SW_FW_SYNC, swfw_sync);
 
 	e1000_put_hw_semaphore_generic(hw);
diff --git a/drivers/net/intel/e1000/base/e1000_nvm.c b/drivers/net/intel/e1000/base/e1000_nvm.c
index 2b38bbc117..1b49586c74 100644
--- a/drivers/net/intel/e1000/base/e1000_nvm.c
+++ b/drivers/net/intel/e1000/base/e1000_nvm.c
@@ -935,14 +935,14 @@ s32 e1000_read_pba_num_generic(struct e1000_hw *hw, u32 *pba_num)
 		DEBUGOUT("NVM Not Supported\n");
 		return -E1000_NOT_IMPLEMENTED;
 	}
-	*pba_num = (u32)(nvm_data << 16);
+	*pba_num = ((u32)nvm_data << 16);
 
 	ret_val = hw->nvm.ops.read(hw, NVM_PBA_OFFSET_1, 1, &nvm_data);
 	if (ret_val) {
 		DEBUGOUT("NVM Read Error\n");
 		return ret_val;
 	}
-	*pba_num |= nvm_data;
+	*pba_num |= (u32)nvm_data;
 
 	return E1000_SUCCESS;
 }
-- 
2.43.5

