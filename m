Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF3A606A31E
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lt6BphPS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 195144066C;
	Thu, 26 Nov 2026 14:29:23 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 8E65E402BD;
 Thu, 26 Nov 2026 14:29:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795699760; x=1827235760;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=KIZXyKIK8J2T2gpd8LFwTQbvm9Nszaqk3hdoSWaQtuQ=;
 b=lt6BphPS5s7j1zEHikQNphLVRoQhDavhDhlETyvSyacKREwK5XfTstDC
 96sGOQzJm0sgpM7W+liOXtYuzWXoXvY2gev34QX3ksbFhsDuMqHBT5qpD
 KLAzdHjYyDpSoURwh4J8Y6r5EjSLAOvqX78t1CKbQX7f7bnR1pvgj/RDd
 s9kT8y0o80mmgQYok45p/uQ+CJlmBlgOPthiRnOHFBgkC/tnmohut7w3x
 zpCXU1MnByJVFPkQqpJWi/s9qJ8Gmg8uWnG6BXgFXi3kYPJUdEl9uUQky
 C+ZQMNIzY7EHkvx33Ckton3Zs148Tm/iSEcufZ1CARrSaJnOSolDUPxSz A==;
X-CSE-ConnectionGUID: rhpHujCXTByyII6qxw7ILA==
X-CSE-MsgGUID: pytcayRxTr2TX3RGD3trEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4578860"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4578860"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:29:19 -0800
X-CSE-ConnectionGUID: zQ8n0PVVQr6ocj6mascvqQ==
X-CSE-MsgGUID: FbhsVSpKQfCmzNZscWUC2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12032054"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 26 Nov 2026 05:29:18 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Cunming Liang <cunming.liang@intel.com>
Subject: [PATCH 3/4] net/i40e: disallow interrupt support in secondaries
Date: Thu, 26 Nov 2026 13:29:07 +0000
Message-ID: <20261126132909.3488716-4-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126132909.3488716-1-bruce.richardson@intel.com>
References: <20261126132909.3488716-1-bruce.richardson@intel.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When interrupt mode rather than polling mode is used, interrupt delivery
will only happen in the primary process, and the existing code places
all data structures in process private memory. Therefore, explicitly
return ENOTSUP in secondary processes when they attempt to use the
ethdev APIs to enable/disable interrupts.

Fixes: be6c228d4da3 ("i40e: support Rx interrupt")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 0f3295fb3c..3ba5a61da3 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -10343,6 +10343,9 @@ i40e_dev_get_dcb_info(struct rte_eth_dev *dev,
 static int
 i40e_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
@@ -10373,6 +10376,9 @@ i40e_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 static int
 i40e_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return -ENOTSUP;
+
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-- 
2.55.0

