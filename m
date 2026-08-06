Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E153DC56208
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 14:13:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ECF3440E17;
	Thu,  6 Aug 2026 16:11:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 4B9BA40E03
 for <dev@dpdk.org>; Thu,  6 Aug 2026 16:11:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786025515; x=1817561515;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pRTtLvOFrQNIvTlICY58eHZ46QAC5vqp9NOIv+jyQ9s=;
 b=hKZ8AD2xtKb+upYDNpRqJ865siZOW3ETVFSz7xmhY+loFeMcWwnNVk88
 aROo87n31laxi4VM6lucKBtKjVx5XHTPZ9lC9zS+4yriAPks/6I1FA1JR
 UYnb+hKeT3clYwgkaQZsK6OlJyM6OtVz+J7qe5WfG6DHxT4hZJUEEj7Ty
 YhxDUDFGvl4Zvb1gw8GW5dotlNKD7w2gvUTPSdY8AoUmsQK40Z5r/HVN/
 AdsY0fSiVu5SY5dU0OBD5knH9NWNYxK11tE2L4DzmE2SWDoeiU30qzMyZ
 /DoJaLwLP0cCpyRZn7PFYi08nvoOwi8azHeHv59YeipTvvcaT1SMBk7FE w==;
X-CSE-ConnectionGUID: tJiOw3sNRJiIR0Z1AaXl3A==
X-CSE-MsgGUID: 7sbH0erlTNS/3UOdf37pww==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85590045"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="85590045"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:11:54 -0700
X-CSE-ConnectionGUID: NJMPdfS6TSq+4s3P7tyreA==
X-CSE-MsgGUID: A/tZS4ckSJuWULcLPHKWdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="292015205"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 06 Aug 2026 07:11:53 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v10 18/20] net/ntnic: use the new VFIO mode API
Date: Thu,  6 Aug 2026 15:11:18 +0100
Message-ID: <e696ee32fd1c859901d10568090fbba1fa24bb0e.1786025388.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786025387.git.anatoly.burakov@intel.com>
 <cover.1786025387.git.anatoly.burakov@intel.com>
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
 drivers/net/ntnic/ntnic_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 7cc90a7a5b..8b6bca974c 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2690,7 +2690,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_noiommu_is_enabled();
+	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_rte_vfio_no_io_mmu_enabled);
 
 	if (n_rte_vfio_no_io_mmu_enabled) {
-- 
2.52.0

