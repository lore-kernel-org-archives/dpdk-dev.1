Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE4C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 13:09:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7699940A79;
	Fri, 28 Aug 2026 15:07:49 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 91F4C40A79
 for <dev@dpdk.org>; Fri, 28 Aug 2026 15:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787922468; x=1819458468;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=YlFlRozCrv4hf/PNQNyeeycmDzDj0RpxJdvuWWMXpcg=;
 b=TGTi5TEp7kxe7tvWymi1qtwwGeKXlOH+MP++CJFThunkXfL6JKPn3G1H
 obDBRkH/CZGZ7p+PRE/2djaXGoA4sxv6IDighYMDPtLqwbvTbpuu5B5iD
 gN0ClMMI4yI4k7RSIhYCaPfmJ31jVA5GA8hjbmQ3y5S9tRYn09l6ccbZe
 bPzZq31I7qZfnqF4MBPT3Q/fgKsSKYHAdYSY99VsRWkmxfal/vn0JD80Z
 fmjOPBfxqvIGGDBWn+gpr4O95vj41sh5UiaG3gHDfm5RL2pJ8z2G9A6rD
 7MJH52xi54vxHlaiBh6BV1LX5Ab6qhYqb4G01RR6fL0uU938iOnyltp9z g==;
X-CSE-ConnectionGUID: wi1M8RDSSnCrMgQNb3Hc9g==
X-CSE-MsgGUID: 6T1PoRrURw20GwogCABpwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="113964643"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="113964643"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2026 06:07:47 -0700
X-CSE-ConnectionGUID: wH2g/V2FRqyNuPEIKu0aiQ==
X-CSE-MsgGUID: Bf7Nmi5uSvmo8O9laoRfzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="271960340"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 28 Aug 2026 06:07:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v14 22/25] net/hinic3: use the new VFIO mode API
Date: Fri, 28 Aug 2026 14:06:50 +0100
Message-ID: <8cca9e09bbdb8d3f5ae5acc63aadeb9e578c9efc.1787922363.git.anatoly.burakov@intel.com>
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

