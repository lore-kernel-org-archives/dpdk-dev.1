Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E88BCEE33B
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 16:31:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 675BA40A70;
	Tue, 18 Nov 2025 17:29:59 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id B755C40A6B
 for <dev@dpdk.org>; Tue, 18 Nov 2025 17:29:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763483397; x=1795019397;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yWhlOMZgnKaEFgHe6BY0EiK65RuN3ZRqJAtpLwvP4lM=;
 b=dlXnmxLiW23aLjHQfXHvH1DvIVBjEeb2lTmXe80kpuZTUpHcovEBTbtc
 BiSHHNn4FqQcFJEeqmPvDWJzF9Enevy5ffH0/uExIiRBKPRz8lDeyHzXm
 Oh+xWOxdRylp3d4RVixMXiRKNQDq9cUSRhYYgxfAVCbgv9dyzURXjfH8m
 5atB9gDCEt3ptqaXzEUmlYAOtwjsHqrSeTWwBPfPCt9NN7jTGz3Bz3pbe
 8hQrcZGQXSNB3vmGgYFncER3mVSrkCX7QW0Ew52XNz8njBFVZ++Vw/Eyw
 yL4zfGWjvMO3Gfs5ulEd85rHERyiCk9UelcfTt0x7649y4MYmIDgjVDZc w==;
X-CSE-ConnectionGUID: +fzwXISbTAi6CB4DiQqnTw==
X-CSE-MsgGUID: av9FBu8rQGOx3XpxNQqUWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="65550661"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; d="scan'208";a="65550661"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2025 08:29:55 -0800
X-CSE-ConnectionGUID: lz5+sFlTReawq8+Elbx5mw==
X-CSE-MsgGUID: As9ttieuQA2qcd2fodqxHA==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 18 Nov 2025 08:29:55 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v3 18/20] net/ntnic: use the new VFIO mode API
Date: Tue, 18 Nov 2025 16:29:19 +0000
Message-ID: <aee0fbbd111c75e2345557aa1d8879b28e69d23e.1763483254.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763483253.git.anatoly.burakov@intel.com>
 <cover.1763483253.git.anatoly.burakov@intel.com>
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

