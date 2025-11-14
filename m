Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58274CE8D67
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:42:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A99D9427B6;
	Fri, 14 Nov 2025 18:41:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id EDF494270A
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142058; x=1794678058;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nwIgj9PDmbdUl3bpaGGCX7JJ1JQ7CR//Inm1lGWsPUc=;
 b=A0+kX3l8sEsa1JH8cWlbWGQVHp7X6Dw9RmInPv4jJPGEYBH7VQc/SZZ8
 BLG44dgKPWZ79IkWJYSZ9r8vP9o9EzPCUb8q0p0jegcEEuuwbFYIPu4OC
 xDtL/oCkXh1e9AIfP/6ZpgN2iX+bS3DTcoLsrCEY/TsZBvPJVvQH5RS1p
 atxg6EfokLvvOe0Pn+WIi9wgcUyX1luwbkvOIs46rUlUP8mB6YezhhL0K
 9dJ/w9jjX8ipEB1mXHdhmu4cmSPrcxP6wjsXGyFe/RbsAlEnZhXHmvgvu
 aEMc/FL4x7Iw5voPRGogHffF/gziQoaeRgS4PcQBlwk1JyZPnZ/gsRupm Q==;
X-CSE-ConnectionGUID: 3pazixniSqOqSKMB0nyQlg==
X-CSE-MsgGUID: jboIVNQ2Tueqhv6jh9wgVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864310"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864310"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:57 -0800
X-CSE-ConnectionGUID: 5OpctQO6SGmvpSsNVHTcHw==
X-CSE-MsgGUID: XNqTMv/kRSiU31XxA5Nq0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650819"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:57 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v2 16/19] net/hinic3: use the new VFIO mode API
Date: Fri, 14 Nov 2025 17:40:26 +0000
Message-ID: <8e3d2a00b0274da38c146093c225040d8547bfb0.1763142008.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763142007.git.anatoly.burakov@intel.com>
 <cover.1763142007.git.anatoly.burakov@intel.com>
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

