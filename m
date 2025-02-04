Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F73BC02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D880C42E60;
	Tue,  4 Feb 2025 16:12:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 84F5D42DD4;
 Tue,  4 Feb 2025 16:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681948; x=1770217948;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4XKDz2pFowVXSgxI/VxRcf4rEHBOHA5SAH8twIo5/fE=;
 b=gb1OG/zmLHJ3TqtBRmaH/J7iTOU8fCyWFBkZr4C3aSCDrm2tickaZmeM
 kaSvs7TGkOtX5BBaPX5MAOa+JY30JEUz18epJrznNXELuzuYKJ5U6WDmS
 ELwC80oVJa6Khem+JfQeQmyJjVkJduwhik4B4Y5dUgs05vPyfSIyD4CDZ
 Zumv7ovgmgRNJko9+wP1pg8vkbfnDv9dxbAT949mMOB5BowRxHZBAKnmF
 TOOHYndEwgW55Fo2dDWlduNRw69x0Aupjebynw3Jwcze5wCvd5qX7lrde
 qUsNUieNHggVMW5Uf4xnZw5lrxSo0XtY0TGXU8exUkalItvfuItOLRY8f A==;
X-CSE-ConnectionGUID: wP89RODORwWTmdP1iLOB1w==
X-CSE-MsgGUID: +OlHm7eFRqCPiahqDClAdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097190"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097190"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:12:28 -0800
X-CSE-ConnectionGUID: H9wilhaoR8+pw+6vwTASGg==
X-CSE-MsgGUID: 17t7SUruTqi/xwU1kpdQ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792777"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:12:26 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	stable@dpdk.org
Subject: [PATCH v2 47/54] net/e1000/base: fix static analysis warnings
Date: Tue,  4 Feb 2025 15:10:53 +0000
Message-ID: <c18fa0ca0bac6a59ae4559a8f4bb250d2730e653.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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
index 0d43a49c14..70259da090 100644
--- a/drivers/net/intel/e1000/base/e1000_nvm.c
+++ b/drivers/net/intel/e1000/base/e1000_nvm.c
@@ -934,14 +934,14 @@ s32 e1000_read_pba_num_generic(struct e1000_hw *hw, u32 *pba_num)
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

