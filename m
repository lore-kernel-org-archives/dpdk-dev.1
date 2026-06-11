Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFD9CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:10:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B74694332E;
	Thu, 11 Jun 2026 17:09:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id E7F19432F8
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:09:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781190584; x=1812726584;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=JvZZOZ6IweG0iyQCGFbl4yUYS49kNqJDGZ52iMvaKq0=;
 b=AhdJghwAC7M3jdqd+aaKzch5OXvS86cYqE1pQ81hyoMwZlsqX/Kg0qOb
 /yRTwH4tCQg9fXZg7p5rwEMGa6jzz/vSVpV6yuHvKf/Y005fo4+AfsU9g
 3+XP9qu8ftVxdLLDgjapJAUa3E7UyCM4dGronkb74HdNjEGUy6WTY9Pnn
 anZC/9gdJJKVg4LbG5Fn0MWKuSQtEEro7oub2yvq7C8DNN5egJ2gfpYjs
 uTCtFnrTmZcwc+dpKsiuseyS3L+nl03qWumm7R/H4jz3S8NPRmyc3jkyj
 SrqKdtvr19WskQRIhYEyM/GJun6EAF01XrnuMyEuydAD0HMdBJDb1Yhu4 g==;
X-CSE-ConnectionGUID: V0Svz7xYQiKB/TLUAUndEw==
X-CSE-MsgGUID: Gs347SlWT6WC39OeYghynQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85845413"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="85845413"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 08:09:43 -0700
X-CSE-ConnectionGUID: s72NZd9IQjSQkiKBSyXc8w==
X-CSE-MsgGUID: RiA8Tvn0Spa5M+whN6Ru3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="245625374"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Jun 2026 08:09:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v8 15/18] net/hinic3: use the new VFIO mode API
Date: Thu, 11 Jun 2026 16:09:07 +0100
Message-ID: <7f5981ef2de796f752de9809b388396ed5186a92.1781190152.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781190151.git.anatoly.burakov@intel.com>
 <cover.1781190151.git.anatoly.burakov@intel.com>
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
 drivers/net/hinic3/base/hinic3_hwdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index d09a8f7e7d..224be6f81c 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -78,7 +78,8 @@ hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
-	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO && rte_vfio_noiommu_is_enabled() != 1;
+	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO &&
+			rte_vfio_get_mode() != RTE_VFIO_MODE_NOIOMMU;
 }
 
 int
-- 
2.47.3

