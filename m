Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6886C02198
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Feb 2025 16:10:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D05241133;
	Thu,  6 Feb 2025 17:09:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id D0F13410E7
 for <dev@dpdk.org>; Thu,  6 Feb 2025 17:09:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738858160; x=1770394160;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=vvZ+5HtEF+uD4XlFXoLgzuApT1pzq+WxXgOAmMCe020=;
 b=Pqszm1togteyihOA3X9dkhExSGPu5062fHI1O1Mbr/T7wfo4lXzmhkKA
 r1GoSjEASEi64Si/eRaGiGnVRzJQeuZIVrTiBetQoQz2PlLwyhK3cBHty
 Hj8wVNPXyl7koGvv9bt5aOdPEJ/BL0NmAUDGeXKPLGmCCygDLOz2SPOXY
 iqyGiidfuxzpfEFK+Xtf/a1tTDhHuu64AhPmIT4ejmgbBzh8PZxE90jBV
 2+AROPj7idIfFHFXxzG7FUc2KgYteNZyopNPUmNoC646mmdzME4V+8pyo
 IChiIwzUUM+Qj5BFjle3HyOYjesFvoBGT+mNw2KaGH4wMIrGtondOWt8O A==;
X-CSE-ConnectionGUID: z44R1iFVQMSCJSX+q8SlcQ==
X-CSE-MsgGUID: 01ymyiChTO6Efq26+E7ekg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50860750"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="50860750"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Feb 2025 08:09:19 -0800
X-CSE-ConnectionGUID: Xkaz/dVqTGq8nwDadNcZCg==
X-CSE-MsgGUID: on/wRSclSySkXgTHdN5Mbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; d="scan'208";a="111166776"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa007.fm.intel.com with ESMTP; 06 Feb 2025 08:09:18 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Alvin Zhang <alvinx.zhang@intel.com>,
 Ferruh Yigit <ferruh.yigit@intel.com>
Subject: [PATCH v1 13/24] net/igc/base: fix static analysis warning
Date: Thu,  6 Feb 2025 16:08:36 +0000
Message-ID: <9cd682fbcac1564e48e4fcadea6e29f0ec84e073.1738858026.git.anatoly.burakov@intel.com>
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

Fixes: 8cb7c57d9b3c ("net/igc: support device initialization")
Cc: stable@dpdk.org

Signed-off-by: Przemyslaw Ciesielski <przemyslaw.ciesielski@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/igc/base/igc_nvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/igc/base/igc_nvm.c b/drivers/net/intel/igc/base/igc_nvm.c
index a7c901ab56..d37a3ffb0e 100644
--- a/drivers/net/intel/igc/base/igc_nvm.c
+++ b/drivers/net/intel/igc/base/igc_nvm.c
@@ -926,14 +926,14 @@ s32 igc_read_pba_num_generic(struct igc_hw *hw, u32 *pba_num)
 		DEBUGOUT("NVM Not Supported\n");
 		return -IGC_NOT_IMPLEMENTED;
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
 
 	return IGC_SUCCESS;
 }
-- 
2.43.5

