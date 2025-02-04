Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6D6C02194
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:18:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3209342E90;
	Tue,  4 Feb 2025 16:12:47 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id C912E427DA
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:12:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681957; x=1770217957;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=klH9RBk2geLI9UPAicBBAiORActepHblHtUfJa2m/HI=;
 b=QYn7vRq0kETFwhGCR+4PNna+z+5QVDnaVc8Lo4PvAUcV4KTAE5b44D1m
 5SGSC9ip6eMcTlFsbqBwAH8cSK0UXsgl8Mvuea3fn7b6LGa/Ga7c3mpzu
 67XNJ4OdBj9rX7zHvH7JLe5T7qAe7RE59Rzj+1SUGDtsIQeQ7ZkykwhiZ
 IsVVtQF1Fe20LA2BdTPHayXx/Vl8pGvh5ydeNmfXKBquM5WGRHedyjzH+
 ymzejFj3KB2Meilah8DiyEelEpJVSrmffFA0nu0VwfTtlWFZzdMwFnqqy
 hVltWxpfgf/JrYEmLEpWB0mw5SUYZ619lg6fucmaCmdmYy0JBKOUwKn+E g==;
X-CSE-ConnectionGUID: jOjSzldcQ+WG0X5s0YbC5A==
X-CSE-MsgGUID: ltC+tsw0REeNNH6mz99VNw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097213"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097213"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:36 -0800
X-CSE-ConnectionGUID: rOON4QPgSGeQ+ekA3fmgSA==
X-CSE-MsgGUID: cVqEPf1tQTal55P6Z14yGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792800"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:34 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 53/54] net/e1000/base: rename NVM version variable
Date: Tue,  4 Feb 2025 15:10:59 +0000
Message-ID: <ea1d73bafbd5a051619cdc5aab21187ca677fa25.1738681726.git.anatoly.burakov@intel.com>
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

From: Piotr Kubaj <piotrx.kubaj@intel.com>

Rename version to nvm_version to avoid shadowing global variables on some
systems.

Signed-off-by: Piotr Kubaj <piotrx.kubaj@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_i210.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_i210.c b/drivers/net/intel/e1000/base/e1000_i210.c
index 52800376e4..479d2dc2c2 100644
--- a/drivers/net/intel/e1000/base/e1000_i210.c
+++ b/drivers/net/intel/e1000/base/e1000_i210.c
@@ -479,7 +479,7 @@ s32 e1000_read_invm_version(struct e1000_hw *hw,
 					     E1000_INVM_RECORD_SIZE_IN_BYTES);
 	u32 buffer[E1000_INVM_SIZE];
 	s32 status = -E1000_ERR_INVM_VALUE_NOT_FOUND;
-	u16 version = 0;
+	u16 nvm_version = 0;
 
 	DEBUGFUNC("e1000_read_invm_version");
 
@@ -496,14 +496,14 @@ s32 e1000_read_invm_version(struct e1000_hw *hw,
 
 		/* Check if we have first version location used */
 		if ((i == 1) && ((*record & E1000_INVM_VER_FIELD_ONE) == 0)) {
-			version = 0;
+			nvm_version = 0;
 			status = E1000_SUCCESS;
 			break;
 		}
 		/* Check if we have second version location used */
 		else if ((i == 1) &&
 			 ((*record & E1000_INVM_VER_FIELD_TWO) == 0)) {
-			version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
+			nvm_version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
 			status = E1000_SUCCESS;
 			break;
 		}
@@ -514,7 +514,7 @@ s32 e1000_read_invm_version(struct e1000_hw *hw,
 		else if ((((*record & E1000_INVM_VER_FIELD_ONE) == 0) &&
 			 ((*record & 0x3) == 0)) || (((*record & 0x3) != 0) &&
 			 (i != 1))) {
-			version = (*next_record & E1000_INVM_VER_FIELD_TWO)
+			nvm_version = (*next_record & E1000_INVM_VER_FIELD_TWO)
 				  >> 13;
 			status = E1000_SUCCESS;
 			break;
@@ -525,16 +525,16 @@ s32 e1000_read_invm_version(struct e1000_hw *hw,
 		 */
 		else if (((*record & E1000_INVM_VER_FIELD_TWO) == 0) &&
 			 ((*record & 0x3) == 0)) {
-			version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
+			nvm_version = (*record & E1000_INVM_VER_FIELD_ONE) >> 3;
 			status = E1000_SUCCESS;
 			break;
 		}
 	}
 
 	if (status == E1000_SUCCESS) {
-		invm_ver->invm_major = (version & E1000_INVM_MAJOR_MASK)
+		invm_ver->invm_major = (nvm_version & E1000_INVM_MAJOR_MASK)
 					>> E1000_INVM_MAJOR_SHIFT;
-		invm_ver->invm_minor = version & E1000_INVM_MINOR_MASK;
+		invm_ver->invm_minor = nvm_version & E1000_INVM_MINOR_MASK;
 	}
 	/* Read Image Type */
 	for (i = 1; i < invm_blocks; i++) {
-- 
2.43.5

