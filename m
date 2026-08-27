Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28FE6C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:17:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7AAA240E0B;
	Thu, 27 Aug 2026 17:15:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6E15740DD5
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:15:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843716; x=1819379716;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=a0eIxYwNurC7uQ3uB7gxRQMw3EwCRGOYQcAOFKclcRc=;
 b=XagirqchxW2/tnMWJD8iR2gxNOFlHojWWr1EOoId6cCtgVSJk7n//OOT
 9MliB6OpLwjlhAZfYCqKqDD7cBL1s1yf4h4kaMM3Y8I92YD7tSyfwbpWZ
 kQPZfbEquq6cPhiO+PUYG2fkZx4410T6bi58oO2v23z3O/N4t0ryBXBpC
 61dagxXZjha/NWv7ta7lQL+fZjOun6TbFaCqkofFre/VQNovxM4snDtwt
 zDgr6lDalKfPxAJKPh2NzG5+hm+JuVZ5xvp14FC48CLL3iPhkCMgBYUwP
 vw10oeaDhfez4g6BP8xDi0dXPxbnWZfl2mCtPKUS23cw46TFZeTggSyCp w==;
X-CSE-ConnectionGUID: TEtRjo0sQL25JmJ0bMozgA==
X-CSE-MsgGUID: RRbjCH/WTvuQcLNVSeP5ig==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371654"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371654"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:15:15 -0700
X-CSE-ConnectionGUID: Dg+sy5+aT+2X3LNo4djhxA==
X-CSE-MsgGUID: cMldag7cTiuPOYylXU6QHQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:15:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v13 19/24] bus/pci: use the new VFIO mode API
Date: Thu, 27 Aug 2026 16:14:22 +0100
Message-ID: <ca6fb41a92eba041398eb589fec74ee1ed334517.1787843386.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1787843385.git.anatoly.burakov@intel.com>
 <cover.1787843385.git.anatoly.burakov@intel.com>
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
index af37a65c45..b9fe4797fb 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -596,7 +596,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (dev_vfio_noiommu_is_enabled() == 1)
+			if (dev_vfio_get_mode() == DEV_VFIO_MODE_NOIOMMU)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index 77691a7908..11e6217826 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -676,6 +676,16 @@ rte_eal_init(int argc, char **argv)
 		}
 	}
 
+	/*
+	 * VFIO must be initialized before bus scan because buses need to know
+	 * about no-IOMMU mode status.
+	 */
+	if (dev_vfio_enable("vfio")) {
+		rte_eal_init_alert("Cannot init VFIO");
+		rte_errno = EAGAIN;
+		goto err_out;
+	}
+
 	if (rte_bus_scan()) {
 		rte_eal_init_alert("Cannot scan the buses for devices");
 		rte_errno = ENODEV;
@@ -771,11 +781,6 @@ rte_eal_init(int argc, char **argv)
 #endif
 	}
 
-	if (dev_vfio_enable("vfio")) {
-		rte_eal_init_alert("Cannot init VFIO");
-		rte_errno = EAGAIN;
-		goto err_out;
-	}
 	/* in secondary processes, memory init may allocate additional fbarrays
 	 * not present in primary processes, so to avoid any potential issues,
 	 * initialize memzones first.
-- 
2.52.0

