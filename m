Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A5F7C2A09B
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 14:48:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5356740A7A;
	Fri,  7 Aug 2026 16:47:02 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id ADDAB40E31
 for <dev@dpdk.org>; Fri,  7 Aug 2026 16:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786114019; x=1817650019;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=FC9vvjRHLqbXC1r2vzS0DMFyLMuSBlAVhdTcCIRnetY=;
 b=gWOtUuy6L1mQpTrK3ZN8tRn9d2I1eBH62LjXyKzG/WO4S2NHyNOKs05h
 GQrrh3Kafc/bU5HPi8IAw0aTx2m4eaajwa1AWZ5UXdgvfdQ4aCG9hfsAH
 GhGphtHteiqoNAuxRO1mGsdvrDFfBoZY/PZxTZo7EAlZFoV/9hQP1zYys
 IcKqvw4eHE6JjPLrV2bln7i0kFtYi8e7ftA3lLloNaig5BgvpL52QRBxF
 +nMQp2vVKp486ryYrfS+5wOixXh9GIx3CoN5JP9QLc68bWVsEy4F+nslK
 h4uWhMa/aCsnreRhGjXndOR6M4tgN/VZSDVeLWkysRsSuMz5mKXU4P2Uv w==;
X-CSE-ConnectionGUID: 1YnR3urGRlK0S5hHPIdOMA==
X-CSE-MsgGUID: IvsAr6okSiGAQYz5GorThg==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="104257347"
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="104257347"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2026 07:46:58 -0700
X-CSE-ConnectionGUID: 4JRDEU/YRGaO7SPsNTHxXQ==
X-CSE-MsgGUID: 4+Pjc9I6SX+uweLZswlvhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,210,1779174000"; d="scan'208";a="300623297"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 07 Aug 2026 07:46:58 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v11 15/20] bus/pci: use the new VFIO mode API
Date: Fri,  7 Aug 2026 15:46:24 +0100
Message-ID: <4a077fc63ff9913a4da30598ea04a422411855f1.1786113800.git.anatoly.burakov@intel.com>
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

