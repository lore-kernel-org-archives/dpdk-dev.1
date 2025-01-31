Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90708C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:03:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47A6C42E15;
	Fri, 31 Jan 2025 14:00:17 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 21E8B42E7B;
 Fri, 31 Jan 2025 14:00:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328408; x=1769864408;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1S2ffpMXypHD6YG2oIMQVMI2COlsTEWfj7Tml6FPnTE=;
 b=TIV0gafNNFg1LmEP6ov8SaBhq1RpW+JMj+zojeVhy1Kyq9N1O1aEtjZ3
 I3YzzJU80m+FVIJDUcGArS2GWco/7FLj3L1/lfbEAuaFrzLjuNmd6Iff3
 ykEKaPHs5mOiuNewAzFU3zR57e1Yrys3crh92jhXOF1zntwqIrLGhASVM
 ICvYmA20bbWDUhp5Jfnb4MW44CndeaImqDqJtqm7szmCvq0rxu/CVy6UM
 cICHVlJQsSkwpa/dlU3VXg5jBT+UjMtfMD5q5kBXVl/2VD4raaNx2BS6Q
 vveAsjhPRb/GyyKBCACFnaME/IneAX8VhBd2l3PWY1FyVGge5wimCRfIQ Q==;
X-CSE-ConnectionGUID: aUd0B6H7Q7yxN0n4ta4mQQ==
X-CSE-MsgGUID: Xg7tCeFCSnWz/KDTLDaGIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315679"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315679"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 05:00:07 -0800
X-CSE-ConnectionGUID: I4V4d0oXSmaV08spLfoCcA==
X-CSE-MsgGUID: Vyi+5XnySF22HdOdkJ9mzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503486"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 05:00:06 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 38/42] net/e1000/base: fix uninitialized variable usage
Date: Fri, 31 Jan 2025 12:58:51 +0000
Message-ID: <c43834b905a6ab1d3dbd3e5785522f9c9d2dadd2.1738328108.git.anatoly.burakov@intel.com>
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

From: Jakub Buchocki <101559614+jbuchocx@users.noreply.github.com>

Coverity has detected potential usage of uninitialized values inside the
array. Fix the warning by initializing array.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Jakub Buchocki <jakubx.buchocki@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_vf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/intel/e1000/base/e1000_vf.c b/drivers/net/intel/e1000/base/e1000_vf.c
index bb314e2f12..e0c95aa130 100644
--- a/drivers/net/intel/e1000/base/e1000_vf.c
+++ b/drivers/net/intel/e1000/base/e1000_vf.c
@@ -374,7 +374,7 @@ STATIC void e1000_write_msg_read_ack(struct e1000_hw *hw,
 void e1000_update_mc_addr_list_vf(struct e1000_hw *hw,
 				  u8 *mc_addr_list, u32 mc_addr_count)
 {
-	u32 msgbuf[E1000_VFMAILBOX_SIZE];
+	u32 msgbuf[E1000_VFMAILBOX_SIZE] = {0};
 	u16 *hash_list = (u16 *)&msgbuf[1];
 	u32 hash_value;
 	u32 i;
-- 
2.43.5

