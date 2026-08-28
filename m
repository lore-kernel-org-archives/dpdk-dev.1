Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E71C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:09:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6E28540DD3;
	Fri, 28 Aug 2026 15:07:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 2FE7F40A79
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922468; x=1819458468;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=C3MYF0hjxfZNAxumfTAijSfCiAsGC3t4oi8t7OvZP20=;
 b=gjnCmIhC4J+OZVhIQmnJeY4njmivuwRR4YPgTRFS6MmxeLhDxaUEFCUE
 XATr8ZfAf9vPY+H+nx5GMUzAAOTlogsQ40G0F11bTH/k7EYr3iQU3F241
 sk0BMPvzsCOnwjzGK1k9BefEjeqbxnefrT3GWRCNojy6OtkzaswOpHV6z
 mm9jWjYuVX3zB1piaCTmRUdDdu6xFNjSpjsemVpW9LQf7FEPKzPIIj7U9
 T6B/+kR0vz+FPYnWWF04O6bhbiCWyKj04x5cXBEGiOygJ+gE1lFCFk1fT
 CTlP7ei8fRsMmlXRWtTNkrhVG7qGqRaoivAffsaY3bSn3XUeFaNRVEOAV A==;
X-CSE-ConnectionGUID: cyRFJeO6T5W9ye8Azj0y8Q==
X-CSE-MsgGUID: iuuv+UkLRtKJHOe+FRKVgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964647"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964647"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:48 -0700
X-CSE-ConnectionGUID: OuBiDEk4TQe5QLuCUHuCDQ==
X-CSE-MsgGUID: llNUcyeCSkefGVKY9kSWpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271960345"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:47 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Christian Koue Muf <ckm@napatech.com>,
 Serhii Iliushyk <sil-plv@napatech.com>
Subject: [PATCH v14 23/25] net/ntnic: use the new VFIO mode API
Date: Fri, 28 Aug 2026 14:06:51 +0100
Message-ID: <1d010f903d5c7952267c1639508a85d37e58006e.1787922363.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787922362.git.anatoly.burakov@intel.com>
 <cover.1787922362.git.anatoly.burakov@intel.com>
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
index d9744a7d05..45629a567d 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2690,7 +2690,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv, struct rte_pci_device *pci_dev)
 			(pci_dev->device.devargs->data ? pci_dev->device.devargs->data : "NULL"));
 	}
 
-	const int n_dev_vfio_no_io_mmu_enabled = dev_vfio_noiommu_is_enabled();
+	const int n_dev_vfio_no_io_mmu_enabled = dev_vfio_get_mode() == DEV_VFIO_MODE_NOIOMMU;
 	NT_LOG(DBG, NTNIC, "vfio_no_iommu_enabled=%d", n_dev_vfio_no_io_mmu_enabled);
 
 	if (n_dev_vfio_no_io_mmu_enabled) {
-- 
2.52.0

