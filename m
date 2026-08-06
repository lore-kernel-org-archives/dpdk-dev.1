Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B029C55ABF
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 14:13:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BCB040E18;
	Thu,  6 Aug 2026 16:11:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id AADE04065A
 for <dev@dpdk.org>; Thu,  6 Aug 2026 16:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786025513; x=1817561513;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9Cvi+7p4t9ogamKKX92YNG3CsflnfVGQoHLRLn8FbcI=;
 b=OWap6UioXlE4pkYSOe3shNnUscvs87inbOBJb6io+i+nZpbgXldHZ2WX
 vDvQzQ+VCyh0fwzQ9B/hB7NjuocjUfBVJIakInayonE/aZEVJO9nsLz2c
 A8n4GMlhqdMPC5tUwczgM3Oev8GJXVlo3pNX6/EP1HuLhWbzlGNszDirp
 yj+OxhSuhyE9PAN//X7jHkf7eIXly5I8DJDvb4evuAMM1PdEKFCKIE0g9
 P3IRzcgnn/4zhJLvy1U4LAWYtbO+MAyy/Cr8DcOn1cf4haN/BjaFGcwzy
 d1rA67brxuPL1ENVGbFzP9a42kXFrskJsvFqjgAFsiZYbGviEpR6iMrF2 A==;
X-CSE-ConnectionGUID: 2bzhh9lMQaGh1MWJA4vbHg==
X-CSE-MsgGUID: eJ4YmMk5RjKgpZ1mYpK47g==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85590041"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="85590041"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 07:11:52 -0700
X-CSE-ConnectionGUID: dQIqWmW3T1qSHWTjAzbPNA==
X-CSE-MsgGUID: aI+0Sqc3S7qrj+lJErg/HA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="292015202"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 06 Aug 2026 07:11:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v10 17/20] net/hinic3: use the new VFIO mode API
Date: Thu,  6 Aug 2026 15:11:17 +0100
Message-ID: <ab109d9d647379aeaa5f9896ec04fd3325dfbe1e.1786025388.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1786025387.git.anatoly.burakov@intel.com>
 <cover.1786025387.git.anatoly.burakov@intel.com>
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
 drivers/net/hinic3/base/hinic3_hwdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index d09a8f7e7d..224be6f81c 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -78,7 +78,8 @@ hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
-	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO && rte_vfio_noiommu_is_enabled() != 1;
+	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO &&
+			rte_vfio_get_mode() != RTE_VFIO_MODE_NOIOMMU;
 }
 
 int
-- 
2.52.0

