Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87A4C61DD6
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:18:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66BA2410DD;
	Tue,  1 Sep 2026 18:16:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9E35440F1A
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:16:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788279376; x=1819815376;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=f5ZNOaupg92ut+Cp1QpxpwaA6B6KL9Fbr/eQyVsUKdE=;
 b=S9v599jAodkjlo3W9PNtMh6cD+PpdDo9OH1UFhmw5hXUE6nGg4BGvzol
 GPTEHpdKu2K/yRP4cHAsaEb/r3aaYM0BrIzeXWDQ4M/E8nWkpT6PkfdUE
 BpK0GpNrTwMJIEv0kq9Q1l+tBnjR7swfC9wVV/IsuuY7DqcnoHDHWbko3
 rD2RIGOVyT1VBV4OVidjXTLoHNJwlzudO5kbyu1kPGo6vLyl8zkBntab3
 L3ThkuevDbdWdGBeeBxy0QWNGBHAs4XJoD9DPbFX/VnyLve7ktxEsS884
 uRn5fIeaa+ajRG8o7xABJ/P3pl56/7eFf0bSvqQHd/ZYVrfBlDnqu2rqc Q==;
X-CSE-ConnectionGUID: vT71ZxyCQBSJSoKWmrCm8w==
X-CSE-MsgGUID: 2yaXkT7HQL+85EMciPdM7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87656127"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87656127"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:16:15 -0700
X-CSE-ConnectionGUID: 7ytzZblIQwG6qEmEfUnHIQ==
X-CSE-MsgGUID: cBObcqNuTl6k9kq4hLfxgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="299032604"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 01 Sep 2026 09:16:14 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v15 23/25] net/ntnic: use the new VFIO IOMMU mode API
Date: Tue,  1 Sep 2026 17:15:29 +0100
Message-ID: <db26e219a90e91e2ce111c5ef114787b9fc5de43.1788278993.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788278991.git.anatoly.burakov@intel.com>
 <cover.1788278991.git.anatoly.burakov@intel.com>
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

Use new VFIO IOMMU mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index d9744a7d05..79f4dd5279 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2690,7 +2690,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_dev_vfio_no_io_mmu_enabled = dev_vfio_noiommu_is_enabled();
+	const int n_dev_vfio_no_io_mmu_enabled = dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_UNSAFE;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_dev_vfio_no_io_mmu_enabled);
 
 	if (n_dev_vfio_no_io_mmu_enabled) {
-- 
2.52.0

