Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F97CC61DB9
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:23:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4952740DD7;
	Tue, 25 Aug 2026 15:21:55 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 1852D4064A
 for <dev@dpdk.org>; Tue, 25 Aug 2026 15:21:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787664112; x=1819200112;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pRTtLvOFrQNIvTlICY58eHZ46QAC5vqp9NOIv+jyQ9s=;
 b=H1JGjHONV2gxHdFWgBfieHrck/OJ689yQ71gQeYMOnt6YdPv23ImU0CJ
 XE/Om6vYguR/KyNbaGkrSBCPx9uVj9JxB/BDiQ0eKmxbAGhwyyxfkR3gb
 3qbTam4cck7fWO7CGt/j+f23gIgTbYbVlW/hxjpyNKBtEES5wCPH/+lWU
 Ieo5mEulDrxRH/eimCxaoSyQMPEKwqffoLn37U+MGdIUU7wsepNjU4ZhG
 nEuMH2Pp6XOqH0tk9QJY2bEbV5mDzOJzGXugXbyRddagH5qJvkV6ZjMdj
 hLqE1WFsYtKhM9VtfrpQeAwhE2kOCI+/KpOPokCzGKb757tuHMNehwVeJ A==;
X-CSE-ConnectionGUID: hwO/qJb0Q/6OAqX8GAxE9Q==
X-CSE-MsgGUID: me1f7PufQl6kWkdfm4pB8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88332743"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88332743"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 06:21:51 -0700
X-CSE-ConnectionGUID: 4jGLLosMQMyGJf/3EUgIeQ==
X-CSE-MsgGUID: tJ9Gpod5Q1mc7eva8DhE/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="264660908"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2026 06:21:51 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v12 18/20] net/ntnic: use the new VFIO mode API
Date: Tue, 25 Aug 2026 14:21:15 +0100
Message-ID: <d39a5e51f4ffdade80d90d0baf0f9de8bde496bf.1787663787.git.anatoly.burakov@intel.com>
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

