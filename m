Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB64C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:00:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0610442D90;
	Fri, 31 Jan 2025 13:59:39 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 56FE741611
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328376; x=1769864376;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=KJHVBibZGamjD3avK8UcRL18rs8OGVblD2krb7o/msg=;
 b=RfsTagPsyLEKgHCNAsOfSLrnu2hZ3ixFgeXCLV1YDHhtebBKl+mKsbBu
 ZqSugdmmQTMV/UOkz9znbnq5WBfhlLgyZ6d6JiHM9q9JRjduPWqbbMeNF
 mXZTAlqi2Iuoosk5uvW/zK+3ed8vQuyOW1MOpl3Mi3MxW7twRc8ID7PKB
 IKOp35irTsnoHjAP77TnEs0san/AC6olfatNFJLonjgDhOnSf+L5nySLX
 GewU7y/25B5XRt8RmoTgPhx1jojP2XPzBJglPM3rNPkPkGUukkv0469+G
 nNWL+YGawsSKECeNpVu6z0XDFB2mi1h7QLLgJSW6CYxGRzxVzozppenas A==;
X-CSE-ConnectionGUID: HWCCWK6HQEO5urh5oHBQ0A==
X-CSE-MsgGUID: Es7SMDGpS5O09bS4wCboYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315622"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315622"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:35 -0800
X-CSE-ConnectionGUID: YcWFQkgfTsqbgtVzkC3oUA==
X-CSE-MsgGUID: XQpFTzYeRBqBU8uiRYGISA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503371"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:33 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 10/42] net/e1000: add missing i225 devices
Date: Fri, 31 Jan 2025 12:58:23 +0000
Message-ID: <79225c61c08ecbda3f8a13ff50cb8f9a84d5e648.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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

Add missing i225 devices to the list of supported devices by IGC driver,
as well as resort the device list to match sorting order of definitions
in the base code.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/igc_ethdev.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index 5563cee09c..136f5af2a0 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -107,16 +107,20 @@ static const struct rte_eth_desc_lim tx_desc_lim = {
 
 static const struct rte_pci_id pci_id_igc_map[] = {
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LM) },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LMVP) },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_V)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_I)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_K) },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_K2) },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LMVP) },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_IT)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_K)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_K)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LMVP)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_I)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I220_V)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_BLANK_NVM)  },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LM)  },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_V)  },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_IT)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_K)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I221_V)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LMVP)  },
 	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_BLANK_NVM)  },
 	{ .vendor_id = 0, /* sentinel */ },
 };
-- 
2.43.5

