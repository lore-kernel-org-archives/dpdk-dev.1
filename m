Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68322C2A09B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:48:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64D3A40E5A;
	Fri,  7 Aug 2026 16:47:06 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 4940B40E3E
 for <dev@dpdk.org>; Fri,  7 Aug 2026 16:47:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786114023; x=1817650023;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=pRTtLvOFrQNIvTlICY58eHZ46QAC5vqp9NOIv+jyQ9s=;
 b=DYB5JI7Iyvp+y2a0gP9pdzppgQuM8t7VEN4whskJoJXYqpbGtILqNKUT
 VqefhJSpSwzk7iUUgtyp2ySLAYGbi/jMuOEiupwXeoJYqVvX4e+nD7MLV
 3lRp8S2iODylV5bVrxgQCXF0Ni4ynpDVyKPAfUeWKo1bCibvejZu9/OtW
 ZL5Zx+0exHFXsQEjuaYhqqu+uGtvHFYJWIba5FmFLBT3h895NMH+6rV9i
 Ql580rDGmHjnxqufz/QGPZTDXakjInUQGc8VVr5Z46QPufY03pYDA0tyP
 jKBXh0b7bygd9vvY9fUiAi5eereQ4d9gYxXKIL3KiBLmVQU6/AVfdCSyC A==;
X-CSE-ConnectionGUID: m1DzKE2nQdmsh0Uo1VNxTA==
X-CSE-MsgGUID: qb/lZU2ITmWZwoIrOcNtpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="104257355"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="104257355"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 07:47:02 -0700
X-CSE-ConnectionGUID: zehzDKTUQpihGY+qZEEXSQ==
X-CSE-MsgGUID: PYMNC+3SQYSWWs9yuSrshw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="300623307"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 07 Aug 2026 07:47:01 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v11 18/20] net/ntnic: use the new VFIO mode API
Date: Fri,  7 Aug 2026 15:46:27 +0100
Message-ID: <f88f14497bc58a6b735532e7681822fdf7759c33.1786113800.git.anatoly.burakov@intel.com>
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

