Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67886CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 15:52:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 895AC40E17;
	Fri,  7 Nov 2025 16:51:20 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id BEBC240DD1;
 Fri,  7 Nov 2025 16:51:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762530679; x=1794066679;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=2n5WOwYkviOgcgorElTuU7zjirUsfhuD9gbBBcjGynY=;
 b=EOsA9mAi0rq3aeEhFV/SWBsstnctlOVpHdFiqn0p/wWbEkA9SZxH9rNK
 A391/Su/yD2zyMPcTgnMrndPBZUAIVAnXpl3qfOwPMnthrpOeaQBZom7N
 /4/6FI4I9cj6VNPqxltqSBLRjBi1zoqbxNSpjfqDCWTnOfao7AFYZWPHe
 vEaUXulvMGYK4MvqKPYX+M+xXQxSpcyE/RRNXQ/me/izHW9IEL836CjMJ
 42mX09UImOzK9dyT0t9hg6MibHhtoh1qa7PZE8gb88u+e7VO6Y46d2p4l
 1k0F5AwZsuroWmeF2zjp4WMlzFa5GclM3HhX9SqqLIv3L5TyIXW0KYstX A==;
X-CSE-ConnectionGUID: zHYQeYUUSYuP6bYssulevg==
X-CSE-MsgGUID: xLfqSsSaS0Sky8QwXc2Xvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="90151850"
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="90151850"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 07:51:18 -0800
X-CSE-ConnectionGUID: L+a/GhCsR/e4E4g7chNBTQ==
X-CSE-MsgGUID: ntsEeklISxC/yM9KUMjZCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,287,1754982000"; d="scan'208";a="187321699"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa006.jf.intel.com with ESMTP; 07 Nov 2025 07:51:18 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Qi Zhang <qi.z.zhang@intel.com>, Beilei Xing <beilei.xing@intel.com>
Subject: [RFC PATCH v2 15/33] net/i40e: fix build with shadow warnings enabled
Date: Fri,  7 Nov 2025 15:50:11 +0000
Message-ID: <20251107155034.436809-16-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107155034.436809-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20251107155034.436809-1-bruce.richardson@intel.com>
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
2.48.1

