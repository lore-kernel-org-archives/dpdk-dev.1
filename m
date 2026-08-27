Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5861C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:17:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7DBD409FA;
	Thu, 27 Aug 2026 17:15:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 39ADA40A6B
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:15:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843718; x=1819379718;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=YlFlRozCrv4hf/PNQNyeeycmDzDj0RpxJdvuWWMXpcg=;
 b=aO8xcyFcee+qE25di2SzDQI7eggOBWwD1pIKvJSLqvAbqC+MW/AGz5tk
 8JII87pevlqsiV2Ycl9LeUyiJIuF+KlWWcasP+qyKiqXrS+rzmDYdZCV5
 UEi9LABRmKTVrNpCE2p9rKe+41NqesOULAiIkQJCHt0/9mk5vlyxREiAk
 3jibrtyHId5qrlEtfRk6q3eF8g0hvSPMOan2m/z1/gkBtXGPJovnXfr5s
 QngUc2nEfeM04T8BNMBZRrDjE2Tlm+gr77WbKCd+9wB9MKADPmGcvmQDl
 REWzmRM7HuAYQq/AzsSrOHH8jZbtuaKQ5os3/gQ4NM9q7PakkO3VDsRo+ Q==;
X-CSE-ConnectionGUID: MBJRgx8xRCGuBDJPNPWsGA==
X-CSE-MsgGUID: nsiNCQqzTCCT80GPvKPyWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88371662"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="88371662"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:15:17 -0700
X-CSE-ConnectionGUID: hBG6TsAcQSCVKxSorRYNLQ==
X-CSE-MsgGUID: YCrFzqy4SmCPICmQKKUL3w==
X-ExtLoop1: 1
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa003.fm.intel.com with ESMTP; 27 Aug 2026 08:15:17 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v13 21/24] net/hinic3: use the new VFIO mode API
Date: Thu, 27 Aug 2026 16:14:24 +0100
Message-ID: <bb33ecd12b94f89d59c18f9f54912d37c766027b.1787843386.git.anatoly.burakov@intel.com>
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

Use new VFIO mode API to query no-IOMMU status.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/hinic3/base/hinic3_hwdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 6a6cf44752..3486160ba1 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -78,7 +78,8 @@ hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *eth_dev)
 {
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);
 
-	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO && dev_vfio_noiommu_is_enabled() != 1;
+	return pci_dev->kdrv == RTE_PCI_KDRV_VFIO &&
+			dev_vfio_get_mode() != DEV_VFIO_MODE_NOIOMMU;
 }
 
 int
-- 
2.52.0

