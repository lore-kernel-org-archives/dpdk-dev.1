Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A2DC02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:04:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11E5142EBB;
	Fri, 31 Jan 2025 14:00:21 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id A899D427B6
 for <dev@dpdk.org>; Fri, 31 Jan 2025 14:00:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328412; x=1769864412;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=klH9RBk2geLI9UPAicBBAiORActepHblHtUfJa2m/HI=;
 b=bjG79TVQiz1u7OIepORPqPVZDfhmBvKZTJXalILhsvgHtj58KInTkRqC
 aD6wcox4Ar9NScDWhqUioEYHS/o07zvgf24Es+pN8PBINYIHFuSZHLqwx
 aXOrX4KAWMSzHd9nT3q0sar8/j2Fc9drJiCLdvfXk1ZXqwJhab0mzvFUF
 U59B8+HoYuPvWaUBL4/SrTW4qt/CUbvrIToFX2N+PrAwM/HIKSrVY+198
 as8560QrohAqGkLx/YMZ1NLP2E9eRiOctqo9/3ihGGKfC1F/4TMQm4P7h
 +9JdBWEeDk6r64F/rLG1Zk+WYfBXBiwvxP7R7sNX6QMCmfLbXDvgFDoVL g==;
X-CSE-ConnectionGUID: 16IBue5VREuPH2+6QfoaRw==
X-CSE-MsgGUID: +KWpwfomTCy53ahIdxLd0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315687"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315687"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 05:00:10 -0800
X-CSE-ConnectionGUID: m29XmdVdTGCHHrjXTcJ+gA==
X-CSE-MsgGUID: GP64P/26QMqAHJWJ8JFVUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503499"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 05:00:09 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 41/42] net/e1000/base: rename NVM version variable
Date: Fri, 31 Jan 2025 12:58:54 +0000
Message-ID: <285a733f023a8038543187f6677fd70c480c0142.1738328108.git.anatoly.burakov@intel.com>
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

