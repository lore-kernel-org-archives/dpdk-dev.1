Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE555CE8D67
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 17:42:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8DD83427AD;
	Fri, 14 Nov 2025 18:41:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 862C4427A2
 for <dev@dpdk.org>; Fri, 14 Nov 2025 18:40:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763142059; x=1794678059;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=yWhlOMZgnKaEFgHe6BY0EiK65RuN3ZRqJAtpLwvP4lM=;
 b=YjQK1hD8QUunlWucn0iB5XVs8dCf+r3rXbKxqAp5DLC63QcJBog3LIyj
 gZ/4eKR7acPCQom8PwXQx7T7exy1cvVYoewh9n1VetDmz2vjXG2+XDUQA
 mq4TKkUoIa+jdi+a2+2YtBTC9N8cXIBvRpTDk8vrMzisWmWqRAc+3zsU2
 Kd/fbeSiVjh3eh+O4TFKOAhJ+s1FjW7m2eQxRcv/fZLhE6FodrS5EtJo2
 cWWK1BR3vcmI3sELHBWkzv9D00ykZtiRJJ+ZoiFYcUEaADbI1omlSe0iC
 a7P4wvGLZPorSeMoqdm3cDwki555e/J4p/4gJeKyNmmlYx84kw2sokaFt w==;
X-CSE-ConnectionGUID: rZXtPlGOT3GzvYEgwVgWVg==
X-CSE-MsgGUID: YJrGbLs8Q+aC0n2TyotwuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="68864315"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="68864315"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Nov 2025 09:40:58 -0800
X-CSE-ConnectionGUID: GpNfCScvT52S+pGKiAWhqw==
X-CSE-MsgGUID: hRkOttmbTBaBibp5ZZXV8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; d="scan'208";a="189650835"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 14 Nov 2025 09:40:58 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v2 17/19] net/ntnic: use the new VFIO mode API
Date: Fri, 14 Nov 2025 17:40:27 +0000
Message-ID: <416a1ebf62f61d5ed3fe072954364ec442baefe3.1763142008.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763142007.git.anatoly.burakov@intel.com>
 <cover.1763142007.git.anatoly.burakov@intel.com>
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

