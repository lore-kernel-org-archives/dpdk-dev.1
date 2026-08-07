Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FDDC2A09B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:48:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 739A540E4F;
	Fri,  7 Aug 2026 16:47:05 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id D890140E09
 for <dev@dpdk.org>; Fri,  7 Aug 2026 16:47:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786114022; x=1817650022;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9Cvi+7p4t9ogamKKX92YNG3CsflnfVGQoHLRLn8FbcI=;
 b=YWCm0p8p8LwbKlpy/WbRsNCzArjjznNzB28N/JzsDx2FhCmxYhEOWsNm
 WnKo8XqT6/pW5QXj8KviHKlLNRqr5qQTIF83xdP+RctW27qx9GwUm1tFO
 LgNTU/HWiD0udSe+IPqY6SC51DbuAeCwz0r62nbtvl8LP/FJOMgPMs8FE
 ySgzwz6Sy7f4DduxnU0Ol8Y6DunsMEraWPPoThVpx2SyZblgTnxNcTDJm
 RJ42a0WpZBDicFMN5jtJ5r8f598CRpeAdpTVe1da8muz5/frIvQzcKghV
 ApEhwq3UX/+pOjdMncUiZRW5OF1/TOz+FFQbp3a/kr8NLju8fg6fA2Aah w==;
X-CSE-ConnectionGUID: 0ga//1YXRwGZFiwElOMdDQ==
X-CSE-MsgGUID: CEAn9gtQSpK+dmpKZPjY+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="104257352"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="104257352"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 07:47:01 -0700
X-CSE-ConnectionGUID: nS35VlM9RkyN7EQii2fKvg==
X-CSE-MsgGUID: vi0B0ZoYQZmZRwAsYtO6VQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="300623303"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 07 Aug 2026 07:47:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v11 17/20] net/hinic3: use the new VFIO mode API
Date: Fri,  7 Aug 2026 15:46:26 +0100
Message-ID: <c7c61c709648ecbea74e131fa4544993468ce68d.1786113800.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786113799.git.anatoly.burakov@intel.com>
 <cover.1786113799.git.anatoly.burakov@intel.com>
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

