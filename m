Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16C5D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 11:46:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A27640A71;
	Mon,  1 Dec 2025 12:45:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 3C3FC4067A;
 Mon,  1 Dec 2025 12:45:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764589519; x=1796125519;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G/zgzM58Zsmx0reFA/PtYjUa8pn0rDrmQqw9mKZ8XoM=;
 b=MdTJS+O4udqdnvZ17V0Hmxy2qniy/WIO0Li4o8x0uSbfqaMSbi8ylH6n
 EI6PSN0mDLyE4DVKUhs9h3UsXm5AO11Mvpe5lPZea4s9JvcJg7VtslxIH
 wvXRnii/YD5qBVo3rYVhH+H27d/ePbqwD4yY+1sZeFUE3jxY4qdMHloAu
 ijDv805vyUIYeDGaJskLYBqh7qEENxE2EHmLXMKIl2xDBUgkBRMNGlV4f
 ZsxqneDVE5X5xXDOUzuE6eGEhYmq6v2ilI9O+QVAPRpA50WHI8G7yapJy
 71DNGQ9ToKkt0Eopykdw3QEdEEK2ITOwHRfFuxwNXPY6+6wcumcG0fMm8 Q==;
X-CSE-ConnectionGUID: /Xx4s5AxTfWjw3JjjNl3WQ==
X-CSE-MsgGUID: Eh4ecsDIQCiwPslzyCOLFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11629"; a="77991736"
X-IronPort-AV: E=Sophos;i="6.20,240,1758610800"; d="scan'208";a="77991736"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Dec 2025 03:45:18 -0800
X-CSE-ConnectionGUID: aLV7FFzfTAOq6vjrUvf0WA==
X-CSE-MsgGUID: OoKFiLgUSTOIo0VXbGTisA==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 01 Dec 2025 03:45:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 14/31] net/i40e: fix build with shadow warnings enabled
Date: Mon,  1 Dec 2025 11:44:31 +0000
Message-ID: <20251201114448.1441377-15-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201114448.1441377-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251201114448.1441377-1-bruce.richardson@intel.com>
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

The local variables defined with the I40E_WRITE_GLB_REG macro are
shadowing other variables. Rename the vars to start with "_" to avoid
this shadowing.

Fixes: 2bedd7277a10 ("net/i40e: print real global changes")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/i40e/i40e_ethdev.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index 3fca089d6c..70dc506037 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -92,11 +92,11 @@
 #define I40E_WRITE_GLB_REG(hw, reg, value)				\
 	do {								\
 		uint32_t ori_val;					\
-		struct rte_eth_dev *dev;				\
-		struct rte_eth_dev_data *dev_data;			\
+		struct rte_eth_dev *_dev;				\
+		struct rte_eth_dev_data *_dev_data;			\
 		ori_val = I40E_READ_REG((hw), (reg));			\
-		dev_data = ((struct i40e_adapter *)hw->back)->pf.dev_data; \
-		dev = &rte_eth_devices[dev_data->port_id];		\
+		_dev_data = ((struct i40e_adapter *)hw->back)->pf.dev_data; \
+		_dev = &rte_eth_devices[_dev_data->port_id];		\
 		I40E_PCI_REG_WRITE(I40E_PCI_REG_ADDR((hw),		\
 						     (reg)), (value));	\
 		if (ori_val != value)					\
@@ -104,7 +104,7 @@
 				    "i40e device %s changed global "	\
 				    "register [0x%08x]. original: 0x%08x, " \
 				    "new: 0x%08x ",			\
-				    (dev->device->name), (reg),		\
+				    (_dev->device->name), (reg),		\
 				    (ori_val), (value));		\
 	} while (0)
 
-- 
2.51.0

