Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4CBC61DBE
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 13:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C48240B94;
	Tue, 25 Aug 2026 15:21:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 006B3406FF
 for <dev@dpdk.org>; Tue, 25 Aug 2026 15:21:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787664109; x=1819200109;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FC9vvjRHLqbXC1r2vzS0DMFyLMuSBlAVhdTcCIRnetY=;
 b=DSdUe5RWFN3s3VISf2WrNH4ncw5eJcRDIad8T0h7xYFzKbHL6qybcGZ/
 FRXmLDVHbg6jMwKk0MsDrMhydilxFqH5Sgs/R8PClmjUnKG2y3G3LETJ6
 i6xJQeT3LxU+/Y0R8PGixkG4Wi3q0QWWaGdqln7N4xqyUlq9l6MLO2fCX
 I4xIz3WL4F6h14SWg+w1NwM939mNRNnYHE/LnFuAxGwgBMikq4vVDwKpz
 xs32NQ8Dxb5bIfdqYTUA4Qr9okPiUkG5gQlpKC9LgNBooost3N4eySCOx
 MXPGhrXbeuwa/QAFqGW0PZV0pxN/ZPkFk/St3XQ0P1KE6CJ5dZQzb9Dtq Q==;
X-CSE-ConnectionGUID: ciq4KZP4S2aq5n+2Wz/3cA==
X-CSE-MsgGUID: ymSUKR5MShSSqeq1kSlDXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88332735"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="88332735"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Aug 2026 06:21:48 -0700
X-CSE-ConnectionGUID: fT/FUvfNSlCiNRah7t+LCg==
X-CSE-MsgGUID: cedS5b4MQJG4ICghAunTdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; d="scan'208";a="264660905"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 25 Aug 2026 06:21:48 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v12 15/20] bus/pci: use the new VFIO mode API
Date: Tue, 25 Aug 2026 14:21:12 +0100
Message-ID: <332a7de40d218626c9a9c99277819a2e9c5e0ee7.1787663787.git.anatoly.burakov@intel.com>
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

Use the new VFIO mode API to query no-IOMMU status. This requires moving
the VFIO init earlier in the init sequence, as now checking no-IOMMU mode
is not a sysfs check but instead relies on full VFIO subsystem to be
initialized and available.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci.c |  2 +-
 lib/eal/linux/eal.c         | 15 ++++++++++-----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index 9aae0a5d14..a1575b84e2 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -596,7 +596,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (rte_vfio_noiommu_is_enabled() == 1)
+			if (rte_vfio_get_mode() == RTE_VFIO_MODE_NOIOMMU)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index fc2e9b8c0e..5bc095bd61 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -677,6 +677,16 @@ rte_eal_init(int argc, char **argv)
 		}
 	}
 
+	/*
+	 * VFIO must be initialized before bus scan because buses need to know
+	 * about no-IOMMU mode status.
+	 */
+	if (rte_vfio_enable("vfio")) {
+		rte_eal_init_alert("Cannot init VFIO");
+		rte_errno = EAGAIN;
+		goto err_out;
+	}
+
 	if (rte_bus_scan()) {
 		rte_eal_init_alert("Cannot scan the buses for devices");
 		rte_errno = ENODEV;
@@ -772,11 +782,6 @@ rte_eal_init(int argc, char **argv)
 #endif
 	}
 
-	if (rte_vfio_enable("vfio")) {
-		rte_eal_init_alert("Cannot init VFIO");
-		rte_errno = EAGAIN;
-		goto err_out;
-	}
 	/* in secondary processes, memory init may allocate additional fbarrays
 	 * not present in primary processes, so to avoid any potential issues,
 	 * initialize memzones first.
-- 
2.52.0

