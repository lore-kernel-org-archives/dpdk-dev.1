Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B250CFA76B
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 10:10:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81D34402DB;
	Fri, 21 Nov 2025 11:09:38 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id A79414066A
 for <dev@dpdk.org>; Fri, 21 Nov 2025 11:09:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763719775; x=1795255775;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=nwIgj9PDmbdUl3bpaGGCX7JJ1JQ7CR//Inm1lGWsPUc=;
 b=Lacep3oGsZ4ZPcV2AP7GC72Ns2D1qB0uzvtCxIuUyEIyDIMLTLCnaLZb
 x/XMRoW/QXgBVIOkOKwNsAmtWfmdXbjJWJqFwbboMUw+A9ssOB+kbBHZx
 863jZ7wiZ8Mk8MXhJqV0ixnw4pVyR/1BYKANla+f1pcbbnXGaZH/Si3ik
 lSwXrXWYOlHpdqib2ApIXI4Yi5OLsDHiM2ATPVJm95suQazuXNzFhzva5
 ewm9QqNnViOUZkUBzss1xd8qNOjuo3cMmZ2BkIluXLu0D5WKzVtIhtxue
 SwCxojwcwNQnuz5ljkm+WLz171/mBiPV04Ibe3dvm5Fqhhoi5bKBwjPgp g==;
X-CSE-ConnectionGUID: aqUYJpzQTw+PGd7SncYNLA==
X-CSE-MsgGUID: 80ifxGyVQOCzYiwEbfaJhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="76491043"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="76491043"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2025 02:09:34 -0800
X-CSE-ConnectionGUID: T5tVKEo4TEqnJIxbaJdQPg==
X-CSE-MsgGUID: gaxLmB9XSSC3zRy6+HaZzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; d="scan'208";a="196121589"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 21 Nov 2025 02:09:33 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH v6 15/18] net/hinic3: use the new VFIO mode API
Date: Fri, 21 Nov 2025 10:09:00 +0000
Message-ID: <78750cd2a279b4446d56d074632a688692d01d72.1763719707.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1763719706.git.anatoly.burakov@intel.com>
 <cover.1763719706.git.anatoly.burakov@intel.com>
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
 drivers/net/hinic3/base/hinic3_hwdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 668bbf4a0e..c5bf2bc8a4 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -77,7 +77,7 @@ bool
 hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev)
 {
 	return ((RTE_ETH_DEV_TO_PCI(rte_dev)->kdrv == RTE_PCI_KDRV_VFIO) &&
-		(rte_vfio_noiommu_is_enabled() != 1));
+		(rte_vfio_get_mode() != RTE_VFIO_MODE_NOIOMMU));
 }
 
 int
-- 
2.47.3

