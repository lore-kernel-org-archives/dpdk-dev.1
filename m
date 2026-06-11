Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4049CD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 15:11:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD9B143338;
	Thu, 11 Jun 2026 17:09:48 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by mails.dpdk.org (Postfix) with ESMTP id 94620432F8
 for <dev@dpdk.org>; Thu, 11 Jun 2026 17:09:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781190584; x=1812726584;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=0YTSAfcYmftZ9O8iCu0cN8FclZPv6CtZPlaC2/ac+M8=;
 b=cruYTK06cfbyiBBjZlb5QNI6kP6uZqW8wNF2Q7R6Pc8l/uBBVKOndfIe
 iongAbktlz9EhWkkz+3nWGCyCxpCB/Bl60BgHMONdMHgybOiZH1cKVIhm
 GiHEdceL3defRGbSxVUzy7GS0GoMjHkYh+j6CknSHihplXshcTScAyEZG
 3VjT9l032AaKFJayWB9DX3agv/2D/EobiDq8nJZb69x4Xo+R6nj0fRpyB
 155Yr6kDwdEjI9njN8ycXVDmSHqusIsQf97eVjAjXQ+ZyRpN/y8VKMlgP
 VVTYCfiOcE3UBcWmQRT0Fv4WoNtXQOXP27S/Q9nUyyiffxlBvdnWeFKF6 Q==;
X-CSE-ConnectionGUID: sSeIF7u6TuCHi/doHuFZdQ==
X-CSE-MsgGUID: oQwIjQonRVya4lZHnXBlNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85845418"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="85845418"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jun 2026 08:09:44 -0700
X-CSE-ConnectionGUID: K4g1J0MNQ7eizQS2E8FRqg==
X-CSE-MsgGUID: KXAX6vwSQDqYdq9/22xBiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; d="scan'208";a="245625404"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Jun 2026 08:09:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v8 16/18] net/ntnic: use the new VFIO mode API
Date: Thu, 11 Jun 2026 16:09:08 +0100
Message-ID: <789d91eb465d5143cc8a3a571e15193cacb07d61.1781190152.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781190151.git.anatoly.burakov@intel.com>
 <cover.1781190151.git.anatoly.burakov@intel.com>
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
2.47.3

