Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92127CF3195
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Nov 2025 11:03:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3295440A6E;
	Wed, 19 Nov 2025 12:02:31 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1C8AF40697
 for <dev@dpdk.org>; Wed, 19 Nov 2025 12:02:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763550148; x=1795086148;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yWhlOMZgnKaEFgHe6BY0EiK65RuN3ZRqJAtpLwvP4lM=;
 b=CkIPK2ph0NlUxJBDwUXENRrkJGutwuxNT5jSfHdudXrgcqFY1hkvTWyA
 c4UK2EYB7mhKMHVINIzoLMtCYWUqBJDsAVcuwHSHCuhBpSxFx/oMRZB+y
 2f0XpBtmHgTVo4G0Umd84MUp4oNDixWahnyR83bzqr5oVQrsTPmT115mC
 ZHvbMFZ0dKT+tFq3pnhKz8bueE39QH7vnUBZOWzJvMcU1lP66zGhGTt8f
 hlOmTsrAnvppevY9h0/bFseKvIqRqXF2IQNECpvPainXvP9XVQMROnK/w
 iNERU2XJu2DP2QTWKKINJeanweRxb9EBHQbNlX1Xj4Om6o7CZ6x5xIEoS g==;
X-CSE-ConnectionGUID: VUSwO+UmT++AKLCt+J39kA==
X-CSE-MsgGUID: b1TTtdlsRy+v0508sJhg8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76942151"
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="76942151"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2025 03:02:27 -0800
X-CSE-ConnectionGUID: 4h38uknWTZWWpoF3v6bkrA==
X-CSE-MsgGUID: nS0uCyWwSlm2wLNGRxwOzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,315,1754982000"; d="scan'208";a="214409265"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 19 Nov 2025 03:02:26 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v4 15/17] net/ntnic: use the new VFIO mode API
Date: Wed, 19 Nov 2025 11:01:58 +0000
Message-ID: <aa2ae2064aa0e929805f48ac64c4939952e87b1a.1763549737.git.anatoly.burakov@intel.com>
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
 drivers/net/ntnic/ntnic_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 23c3452d2d..c1195e5fbe 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2692,7 +2692,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_noiommu_is_enabled();
+	const int n_rte_vfio_no_io_mmu_enabled = rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_rte_vfio_no_io_mmu_enabled);
 
 	if (n_rte_vfio_no_io_mmu_enabled) {
-- 
2.47.3

