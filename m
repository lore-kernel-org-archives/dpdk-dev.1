Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4110C61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:23:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6494B40BA4;
	Tue, 25 Aug 2026 15:21:54 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id D2E5540C35
 for <dev@dpdk.org>; Tue, 25 Aug 2026 15:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787664111; x=1819200111;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9Cvi+7p4t9ogamKKX92YNG3CsflnfVGQoHLRLn8FbcI=;
 b=Zv8sAmhjQ8VAzexiNZPQzypL3yElqxo/NraKX7RApjoI+tmoNFAG4NCx
 uorKPvQuJtCHkvbACeJYAgdhlJf8Q60IpIObpwoIle/AlyFBlHafJz1dH
 KVplgCwunggTfs2J5hnBqfAclwgWXy4HF8KF54/7IwU2+RFOXgW8/7pdP
 2p4Cb7KxfWTlleDfHGFqRtnBFb+8z1s+Y34iK/7DS+v9WXYFXlolRKk2T
 7fB6KCRGCu+R6Hau5+dqBassuW/wDCw+WiUwQUrjisZPuq3Tpl4v5Fcnl
 N0MnRQuJgjQQymtDA0AoASRbLM32GiPCD8e2ELmbZfXgj5q5+76wdjTb4 w==;
X-CSE-ConnectionGUID: AbpMMZW3Ts2O9hoTOtB90A==
X-CSE-MsgGUID: RFBIlW0kTDa64f9yXWmqDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88332741"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88332741"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 06:21:50 -0700
X-CSE-ConnectionGUID: TctGDCkmQ9WCaGB9Qk/TlA==
X-CSE-MsgGUID: YM7hkok1Sc2IHyjeh73h9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="264660907"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2026 06:21:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v12 17/20] net/hinic3: use the new VFIO mode API
Date: Tue, 25 Aug 2026 14:21:14 +0100
Message-ID: <9039c015d0ca447c97cf93fc6dbec4a0ec72b7cc.1787663787.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787663786.git.anatoly.burakov@intel.com>
 <cover.1787663786.git.anatoly.burakov@intel.com>
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
2.52.0

