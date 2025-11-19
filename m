Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F86CF319D
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:10:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E18840DD1;
	Wed, 19 Nov 2025 12:08:49 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1155840B8F
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550526; x=1795086526;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nwIgj9PDmbdUl3bpaGGCX7JJ1JQ7CR//Inm1lGWsPUc=;
 b=CisCMtnZ7Ol9kls9fO8hTu/mVGDUVevanS4ST05YpBLaKgn2k9JIkvnl
 Xda45W3nxKdmVyXS+FEureSlfFee/dXMB/gFD570NiU/qMH2igGH+Tyo2
 c2VL8oGeYYaVYdiFSkuWgp/DjmHvH0PL9OH7tiNBhwavVucdb12OQwHuh
 +F0X5YZnt595yZ4G8R5PuH7RxqEmVynYPWjgbKd1nU5HrwKsc0xP3ekuJ
 mvga2AfjqzBUAGsFlxk9A2UKG/m2om42P+9nHYUfF2+9xT58AvqzeEgXA
 kTsstIA6F40oPFI1gkQLFJTfDMqnh9sGbyLCFmqBBZEqhFSfomDsIzaan A==;
X-CSE-ConnectionGUID: 2XTki55KRcqCkP1yPL7+vA==
X-CSE-MsgGUID: G/T8lG2BTl2Aex9cjnbzlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65744995"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="65744995"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:08:46 -0800
X-CSE-ConnectionGUID: i9I2I4VKTvuGW7TOujTA2g==
X-CSE-MsgGUID: XkgrE6sgSGuThncCvUUq4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="191158235"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 19 Nov 2025 03:08:45 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v5 15/18] net/hinic3: use the new VFIO mode API
Date: Wed, 19 Nov 2025 11:08:13 +0000
Message-ID: <8a7c5d83c6562c3d06c8ba7b41b1d4054a9c8447.1763550470.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763550469.git.anatoly.burakov@intel.com>
 <cover.1763550469.git.anatoly.burakov@intel.com>
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

