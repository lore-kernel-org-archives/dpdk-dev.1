Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E91CF318B
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3871540A6B;
	Wed, 19 Nov 2025 12:02:30 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 80CE54066C
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:02:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550147; x=1795086147;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nwIgj9PDmbdUl3bpaGGCX7JJ1JQ7CR//Inm1lGWsPUc=;
 b=gnFcJnL7JVhq66ND07YYqI93GYw1yV4J7KOyPYGqTOfapckZnmgpCRlx
 dffkWa9/RBQaOc3IHJiPBbd5f8VS894nGavGSBlO6+9oXmZ0vbKqmocyU
 sj+wWX2T5SYqFvBGeHefVcwIhgzro0PVyKSKlObJgJt0TsusW09aGDSLM
 RmqmSlqCp1FzRkJf8hqATkmIbDC5zunfeUZvKjADZZe/Udw5X7kA+jlUB
 gWYf69+BalZQW1Xa4a4lixh0WUgXbm9AwKH5Wu9T3WUOQsZ3ErlfYPZPQ
 XeI0lAl0aolZSHrtYwVV5F4702uCNyKUQYmXjmDUYBnl6CcyLgQcEylE3 w==;
X-CSE-ConnectionGUID: bNK12mNuTza1/D6sYVzzTg==
X-CSE-MsgGUID: /RYGvEK0Q8SIbVDRWVVCnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76942143"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="76942143"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:02:26 -0800
X-CSE-ConnectionGUID: 5mdwvtOcS9GAqnmBqYaYPg==
X-CSE-MsgGUID: XojED2T8QKq+ogPBgZQx9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="214409262"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 19 Nov 2025 03:02:25 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v4 14/17] net/hinic3: use the new VFIO mode API
Date: Wed, 19 Nov 2025 11:01:57 +0000
Message-ID: <8a7c5d83c6562c3d06c8ba7b41b1d4054a9c8447.1763549737.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763549736.git.anatoly.burakov@intel.com>
 <cover.1763549736.git.anatoly.burakov@intel.com>
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

