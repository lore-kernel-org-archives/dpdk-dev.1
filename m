Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B5FCEE334
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:31:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 515D940A73;
	Tue, 18 Nov 2025 17:29:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id 57398402E4
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483395; x=1795019395;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nwIgj9PDmbdUl3bpaGGCX7JJ1JQ7CR//Inm1lGWsPUc=;
 b=fbGVdgcSxsnvuKda3fM/G65hrkXwtHoDfSMwXW35gqSbisq6okZis+s6
 KcguLUL8Gkhk7boZRGvv6vsserXF/Y/QllLyMQjBXH2xsbGqiuaDVZJm+
 FzS7VOqv0v/3E2rctL1HYKXxrx0HPiGbsaU4MbnBlRRo/Vbf8OndggZUx
 5cQVLtgNwPPhNkDCJusvI7c1crrZNYQaNveLGnibiT6lCFwdLMTHEZ73I
 kRPpphw5ZuuA3JGghuijx/EZLjwSX2wnj1tPe6/BRBrp8KqJsZX7uota7
 tJLVvryNUu+tfSPRkEkD8QTXO6ia32TptLkDSoUdHI96nWVmSq+c96UPX Q==;
X-CSE-ConnectionGUID: OJd56YM1Tja5GM1mcF6OHA==
X-CSE-MsgGUID: V00E4wTpT9+JTj+77cnHOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550655"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550655"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:54 -0800
X-CSE-ConnectionGUID: 9ZNApcRFSJKvSCpOMpclpQ==
X-CSE-MsgGUID: Td3pXf18SPOIO/yKgt4MtQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:54 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v3 17/20] net/hinic3: use the new VFIO mode API
Date: Tue, 18 Nov 2025 16:29:18 +0000
Message-ID: <28dda2b70f09f3ab9257f6fa8c8887e03989b087.1763483254.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763483253.git.anatoly.burakov@intel.com>
 <cover.1763483253.git.anatoly.burakov@intel.com>
References: 
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

Use new VFIO mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/hinic3/base/hinic3_hwdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 668bbf4a0e..c5bf2bc8a4 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -77,7 +77,7 @@ bool
 hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev)
 {
 	return ((RTE_ETH_DEV_TO_PCI(rte_dev)->kdrv == RTE_PCI_KDRV_VFIO) &&
-		(rte_vfio_noiommu_is_enabled() != 1));
+		(rte_vfio_get_mode() != RTE_VFIO_MODE_NOIOMMU));
 }
 
 int
-- 
2.47.3

