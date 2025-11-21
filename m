Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4756CCFA76B
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6CBCA40698;
	Fri, 21 Nov 2025 11:09:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 4FCD240693
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:09:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763719776; x=1795255776;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yWhlOMZgnKaEFgHe6BY0EiK65RuN3ZRqJAtpLwvP4lM=;
 b=Unt3gBb3SDhNN3mPWrahllfw6rSvcDq0XicP3IR6UAW2joIJxVl0TOQ9
 WoaUEhWqqzHV2FpTAIMU0ET8MYAPGEqiJwQvUveX0XT/AJIYy+JqUT2l6
 eVRknYqF+XBTgXaPV9sZHsAZegY+3ggVQDcZg5Iel0dgF1rbRX6I0cywK
 9sqjVMMX/OqggAXGlhaL04W7EwUjjq8+SryLOZgtIQ06RDY7Bz4YEGu+b
 rG9PRbid01TJbLDX4s//QROlylWCi8CxRQug6m6obQb4fsjh62PY26AU9
 a31s9KPcu7tJJSo7GjX7mQkdFx2q30LLB8i7MB1cLi5McgTz5dBDf69E4 g==;
X-CSE-ConnectionGUID: xlbv0rATRXmOkyeSYnbY8A==
X-CSE-MsgGUID: JdRVIM7IQ2aJf6dK7gyw3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76491047"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="76491047"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 02:09:35 -0800
X-CSE-ConnectionGUID: g9nyb7nGQfG2w5xWDubqpQ==
X-CSE-MsgGUID: M4J/422MSqy1pO1mCZxBXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="196121592"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 02:09:34 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v6 16/18] net/ntnic: use the new VFIO mode API
Date: Fri, 21 Nov 2025 10:09:01 +0000
Message-ID: <34050e6503b5a555ca8adb353557404b881d1d6f.1763719707.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763719706.git.anatoly.burakov@intel.com>
 <cover.1763719706.git.anatoly.burakov@intel.com>
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

