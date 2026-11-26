Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1827606A31C
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Nov 2026 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JJU1I+Wh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 307B140655;
	Thu, 26 Nov 2026 14:29:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by mails.dpdk.org (Postfix) with ESMTPS id B274F402BD;
 Thu, 26 Nov 2026 14:29:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795699759; x=1827235759;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BlIECNrSv4lojy6qEFI7hv6YDommQoCTV0pmvwpv1Ss=;
 b=JJU1I+Wh3F3+3psluj8R2ElOauqPuJmvWNFZ343mO2EgNaqCci8WyoCj
 YaWt7L55olGcrSpghcOnZFrz4oHPwktwectekONa4KxfAj97hks1ltFhf
 CgGoH70ToTblE+zVErKR+2GkUH48/BLJTMg+mkE2f9t9Uqe+tJ1JK8ptC
 gaJF72bNE4Jvtpak/zikOA2Zl34HT06h+TvWLUtxWZ1H+NPymG8/Fmvjl
 snxEDCeHMHvmOYubt2tBtxlRQ356o02mxtLC/Y371xD42E7Yz2vqqEs7T
 eZd+IFiMqozhKtEaKFYoy3qK9IHDk9ptXPn2mTCfFuw4onfJyag7g1YIt g==;
X-CSE-ConnectionGUID: 0Hmmj1SVQKSeKCZ7Vi8IPQ==
X-CSE-MsgGUID: /Fxilv6dRJWtXTqd0Q4jeg==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4578856"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4578856"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:29:17 -0800
X-CSE-ConnectionGUID: kTV5AoWITmqtmBU5ORiqIw==
X-CSE-MsgGUID: Ja/J1k94Qcm076B/CbRVeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12032049"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa004.jf.intel.com with ESMTP; 26 Nov 2026 05:29:17 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Hyong Youb Kim <hyonkim@cisco.com>, Harman Kalra <hkalra@marvell.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH 2/4] net/i40e: handle Rx interrupt vector lookup errors
Date: Thu, 26 Nov 2026 13:29:06 +0000
Message-ID: <20261126132909.3488716-3-bruce.richardson@intel.com>
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

The Rx interrupt enable and disable callbacks store the result of
`rte_intr_vec_list_index_get()` in a `uint16_t`. If the lookup fails,
the negative error code becomes a large vector index, and the driver
writes to the wrong register instead of reporting the failure.

Keep the result signed and return the lookup error before accessing
the hardware.

Fixes: d61138d4f0e2 ("drivers: remove direct access to interrupt handle")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/i40e/i40e_ethdev.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 5ea26c3348..0f3295fb3c 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -10346,9 +10346,11 @@ i40e_dev_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	uint16_t msix_intr;
+	const int msix_intr = rte_intr_vec_list_index_get(intr_handle, queue_id);
+
+	if (msix_intr < 0)
+		return msix_intr;
 
-	msix_intr = rte_intr_vec_list_index_get(intr_handle, queue_id);
 	if (msix_intr == I40E_MISC_VEC_ID)
 		I40E_WRITE_REG(hw, I40E_PFINT_DYN_CTL0,
 			       I40E_PFINT_DYN_CTL0_INTENA_MASK |
@@ -10374,9 +10376,11 @@ i40e_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 	struct rte_pci_device *pci_dev = RTE_CLASS_TO_BUS_DEVICE(dev, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct i40e_hw *hw = I40E_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	uint16_t msix_intr;
+	const int msix_intr = rte_intr_vec_list_index_get(intr_handle, queue_id);
+
+	if (msix_intr < 0)
+		return msix_intr;
 
-	msix_intr = rte_intr_vec_list_index_get(intr_handle, queue_id);
 	if (msix_intr == I40E_MISC_VEC_ID)
 		I40E_WRITE_REG(hw, I40E_PFINT_DYN_CTL0,
 			       I40E_PFINT_DYN_CTL0_ITR_INDX_MASK);
-- 
2.55.0

