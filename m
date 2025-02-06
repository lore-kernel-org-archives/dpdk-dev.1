Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB3EC02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9869A42792;
	Thu,  6 Feb 2025 17:09:34 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 096CC410E8
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858169; x=1770394169;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DZ4Cc5cBTVjxRA/SBLK0H0z704obdprj+pf92o8zV8w=;
 b=Is2GY+Z8M7F+07Arkd0VnHzjlrf+6KJnRxxwA9kCR/M7f1P6mCbwRg/9
 DdO65gznZOS2N9OpJjrBQ+oczVW+8tSoJQldi+p4t48W1gYBGFOR1q30U
 E3N15auwBwf7lLahLt0uxQi6UoiKt4rWU13+E4NYDJOnJxS8SnmGbb59c
 vk6Qo4uuXQUT3o278E2VwuDBsN7tyK4jWNr1/yG8wmMhWU2jrkEnrPsL2
 UERO3RXLK/Eee0YHv3lwsm4vcGkH3xUNPEJU0sdq8xTseRgJkRhYjpe5m
 GgQCOoPrI+Cp08GYwQRZF1kXuqaTWGEyMX64DWflX5h2Hj6RUbCRxa9Qz A==;
X-CSE-ConnectionGUID: I5VB108uTWyZRMTkXwuVCw==
X-CSE-MsgGUID: CMeEoe1BRXWTVwuf4fNPCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860770"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860770"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:28 -0800
X-CSE-ConnectionGUID: nTQTmBPxTqatOTb93zPulw==
X-CSE-MsgGUID: t/6LcX3QTlGZtHOgYHLQBQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166823"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:28 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 21/24] net/e1000/base: fix static analysis warning
Date: Thu,  6 Feb 2025 16:08:44 +0000
Message-ID: <f53bdc46ff3a1f2cd50d061661043e59e466eeae.1738858026.git.anatoly.burakov@intel.com>
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
NVM read data shifts. Fix it via explicit type cast.

Fixes: 38db3f7f50bd ("e1000: update base driver")
Cc: stable@dpdk.org

Signed-off-by: Przemyslaw Ciesielski <przemyslaw.ciesielski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_nvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_nvm.c b/drivers/net/intel/e1000/base/e1000_nvm.c
index 430fecaf6d..d171bea649 100644
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

