Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE68BC02199
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 12:46:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9131E42E4B;
	Fri,  7 Feb 2025 13:46:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id 81C9242E00
 for <dev@dpdk.org>; Fri,  7 Feb 2025 13:45:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738932358; x=1770468358;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=OfNrtlnbIhGxeKdbg3q7L/RI5CBSmvhpu6B91bnzQMo=;
 b=Xe90i4uXQCIL5MmXN990D52Gedq2wQAX3T1z35g/BzbObYI/PPh3yCyD
 HQJTk0gFuwxgwWlDnz/6RJp1K9va9aWcklfYTd29QRFYQjHcHh7OhvhaA
 F/pbLLcHgVavmJZgD7JmtQTcUM2w2NGteW6Po5+S3qDIJc+g+1F9mbkGz
 lziVvx0dciafsmgvh7IaGZnhESCIzRtFbQvTS4B6mNrqc0DLdi6pDHa8X
 N8AfywJXJgZkZDuke43ORLg4ENyZuUSFSEcST7DPG19U6R5fGYjjuVEu8
 VNFOXWbJO/gW9h0Ks2m8jhoA/vWGRHVd8HmzNE+1GXqKb7DSBSlG7h5B+ w==;
X-CSE-ConnectionGUID: NzbyvSmpRkm7PDM9X4nFuw==
X-CSE-MsgGUID: TNJ000dvRpinsJsX3AWhFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="43331721"
X-IronPort-AV: E=Sophos;i="6.13,267,1732608000"; d="scan'208";a="43331721"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2025 04:45:57 -0800
X-CSE-ConnectionGUID: 4iho7LXrTuW3WHNuBudgnQ==
X-CSE-MsgGUID: tltjHpbISl+iuEZjhTz5aQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111953464"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 07 Feb 2025 04:45:56 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v3 06/36] net/e1000: add missing hardware support
Date: Fri,  7 Feb 2025 12:44:58 +0000
Message-ID: <f410d015e0a0d4fc0e54d994a5d292199095df6a.1738932115.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738932113.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738932113.git.anatoly.burakov@intel.com>
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

Some hardware device ID's from i210 and i219 series were added over the
years, but they were never added to the table of support PCI ID's for EM
and IGB drivers respectively. This commit adds the missing device ID's to
the table.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---

Notes:
    This commit is not considered a bugfix because while the hardware in
    question is now treated as supported by the driver, it was never
    validated.

 drivers/net/intel/e1000/em_ethdev.c  | 8 ++++++++
 drivers/net/intel/e1000/igb_ethdev.c | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index f6875b0762..80ad360a23 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -155,6 +155,14 @@ static const struct rte_pci_id pci_id_em_map[] = {
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_CNP_I219_V6) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_CNP_I219_LM7) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_CNP_I219_V7) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ICP_I219_LM8) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ICP_I219_V8) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ICP_I219_LM9) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ICP_I219_V9) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ADL_I219_LM16) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ADL_I219_V16) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ADL_I219_LM17) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_ADL_I219_V17) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_RPL_I219_LM22) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_RPL_I219_V22) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_PCH_RPL_I219_LM23) },
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index c695f44c4c..be3123572f 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -293,6 +293,7 @@ static const struct rte_pci_id pci_id_igb_map[] = {
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_I210_SGMII) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_I210_COPPER_FLASHLESS) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_I210_SERDES_FLASHLESS) },
+	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_I210_SGMII_FLASHLESS) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_I211_COPPER) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_I354_BACKPLANE_1GBPS) },
 	{ RTE_PCI_DEVICE(E1000_INTEL_VENDOR_ID, E1000_DEV_ID_I354_SGMII) },
-- 
2.43.5

