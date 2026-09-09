Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198C5C79FAD
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Sep 2026 10:04:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16AAB427D4;
	Wed,  9 Sep 2026 12:03:04 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id AC128411F3
 for <dev@dpdk.org>; Wed,  9 Sep 2026 12:03:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788948182; x=1820484182;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=6nF46JWldmQLAMRFJNVUDR5ShKstwDQTQFdxhtj5jSc=;
 b=G6TFDhhb5vjKg7bSoyrBhn3sQDxYORgiX1UppHSk2Aivz1/VNhAYpekz
 KKENQcHOz8LUtAvi3MNKIroUW8Ly58l/z/k418ZCCYH22Eg7ImaW++uqV
 pSdvaUD1Jr4h+QGOXYvi+b7bRkYkIUa/hfQkDIBC7/Zd/EAMgmrYJGX+E
 HCQajaT91zyc8bczdyBUYMxMurlc/pfdQCx2RbFW3UUxEkhNjg1FEoeIs
 ksZ6NIvH3YAaSbQTayvXx9WiooGZ4cmBfcJebhIgLYgwZTdhadBGr0Z2e
 Aaocb78bD6Uwjcs+WzboVTzrV0TijnjALhkzeLxITVqVgffBLBiNWOFEi g==;
X-CSE-ConnectionGUID: +R+w8TZiTaieptN8OEo5Gw==
X-CSE-MsgGUID: hJhMGTAvS8SD5NodBsCeeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89492285"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; d="scan'208";a="89492285"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Sep 2026 03:03:01 -0700
X-CSE-ConnectionGUID: Yz4WKV/MQ8e04tU/UtYP1A==
X-CSE-MsgGUID: uVfrEoUBQtiaWSrR7zq7WQ==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 09 Sep 2026 03:03:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Chenbo Xia <chenbox@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>
Subject: [PATCH v16 21/26] bus/pci: use the new VFIO IOMMU mode API
Date: Wed,  9 Sep 2026 11:02:14 +0100
Message-ID: <cec247fe2b0e3dfdb4f6c382b49113f1d43783e4.1788947938.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1788947937.git.anatoly.burakov@intel.com>
 <cover.1788947937.git.anatoly.burakov@intel.com>
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

