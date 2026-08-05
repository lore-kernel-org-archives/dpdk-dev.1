Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6549C55ABA
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Aug 2026 13:47:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B3DC40BA6;
	Wed,  5 Aug 2026 15:46:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTP id D7A9640B9C
 for <dev@dpdk.org>; Wed,  5 Aug 2026 15:46:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785937579; x=1817473579;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9Cvi+7p4t9ogamKKX92YNG3CsflnfVGQoHLRLn8FbcI=;
 b=bESmO/S62VVNdtBKNtxCgZGv9gR/J8cIjDA4ZeL0Ub7zMSY6M4EuLrAg
 sra96Jrger5dzwcStxn5eTJBhxiCPCHosn0t/EWAkJ7yPSiwnonw+CYRm
 aFxWhtED+9pPWEJaruKlnhkw4rsjxXglEvQv4Q7diSsdsjZZrfZ3uy7Fv
 tJruhVpb+nrZCh7nphJ9zGAld4w+aM2zfih9fnrPjESLfdhmKw0bjQ3+C
 /nd6ELV1oUdKorEeLGFu5pIBdT+4npiljHcR5Z+YRoJzxXyuzWUXw3y3U
 TXOS5IWAY5Au15FbutsAlCNJsShHV7x7kijeolSwnNTBZA0ThTQm77xMQ g==;
X-CSE-ConnectionGUID: gKMuVhxoTn64H5epIGQotQ==
X-CSE-MsgGUID: zwPHjUlYS1WXXz0uD0eVjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86284130"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86284130"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 06:46:18 -0700
X-CSE-ConnectionGUID: CJF8MWjhT/akg1AKYSZ8FQ==
X-CSE-MsgGUID: mXLBbHgkS/uG0E4TOtSo0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="258476815"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa007.fm.intel.com with ESMTP; 05 Aug 2026 06:46:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v9 16/19] net/hinic3: use the new VFIO mode API
Date: Wed,  5 Aug 2026 14:45:45 +0100
Message-ID: <146c1aeab91af96e4e9a8b6b3b34f7e058db3b35.1785937061.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1785937060.git.anatoly.burakov@intel.com>
 <cover.1785937060.git.anatoly.burakov@intel.com>
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

