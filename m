Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 831EDC624D3
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 16:18:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8FA640EF0;
	Tue,  1 Sep 2026 18:16:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 7A9DE40EE6
 for <dev@dpdk.org>; Tue,  1 Sep 2026 18:16:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788279372; x=1819815372;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6nF46JWldmQLAMRFJNVUDR5ShKstwDQTQFdxhtj5jSc=;
 b=hlj6Htm9Qb7QU5AtfsERMYiqq616IJwLTe2c/CrW9/NCPrdRGnpfSqiV
 LZNrTK9SxYK85o+kR50kNBsE377TTnZxaASdtsD45JJtzaBGLrwoE7eDT
 5+D3Rszx2TdzY34A9zIohkL0djKhprHoVP09+z/v/+yL7141lBGw6ZEkD
 3C4saiQR5qP1p+1xOII9QPiZd1lIgPF+9fyMIjirw9t4z3b9xL53Zg8dV
 KfRRNKzjBD70SrIwFIxH08kX8DMbb78fHiujymMjbcVsu9aIPYR82EAJs
 7JQHKnpyTRg3k/qrceBFmO4vLmkJqSkMMe9vffA9CZopBKqzJyM7/yCXb A==;
X-CSE-ConnectionGUID: i0y5wJyoQp6INIZnCRgRww==
X-CSE-MsgGUID: dgujkhKXSmGAXk8TzDMuCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="87656117"
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="87656117"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 09:16:12 -0700
X-CSE-ConnectionGUID: wh10JZRARhWxBNXFxI/3JQ==
X-CSE-MsgGUID: IoNiaMOOQKSh3a35kaMALQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,256,1779174000"; d="scan'208";a="299032589"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 01 Sep 2026 09:16:10 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v15 20/25] bus/pci: use the new VFIO IOMMU mode API
Date: Tue,  1 Sep 2026 17:15:26 +0100
Message-ID: <2107ce5266ff42b4b6c7ad69daf375691adfb868.1788278993.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788278991.git.anatoly.burakov@intel.com>
 <cover.1788278991.git.anatoly.burakov@intel.com>
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

Use the new VFIO IOMMU mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/bus/pci/linux/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index af37a65c45..9961f5b2c9 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -596,7 +596,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 		static int is_vfio_noiommu_enabled = -1;
 
 		if (is_vfio_noiommu_enabled == -1) {
-			if (dev_vfio_noiommu_is_enabled() == 1)
+			if (dev_vfio_get_iommu_mode() == DEV_VFIO_IOMMU_MODE_UNSAFE)
 				is_vfio_noiommu_enabled = 1;
 			else
 				is_vfio_noiommu_enabled = 0;
-- 
2.52.0

