Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF60C02196
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Feb 2025 15:12:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B472841611;
	Tue,  4 Feb 2025 16:11:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 6A17E410DF
 for <dev@dpdk.org>; Tue,  4 Feb 2025 16:11:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738681896; x=1770217896;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OfNrtlnbIhGxeKdbg3q7L/RI5CBSmvhpu6B91bnzQMo=;
 b=NqkdLaXr4JcibmauS2tdPgXE6RyeJxFsIRvcwCKWmLfjc9Wd/evsmTPG
 PDnB/yBU2zxD5EWA6eueeeWiRGQHgnZ5Spa6LmMfArY0nM6izdrJ/gYst
 F1wH+5BVkaWgJaRclZsy/YBfeJww+FcWqVkFBafXEpWEIJb54wHX9KAIY
 J4ZTiGWtyKWSq7YsvXei4LP+wGn5YFze7GjdcT49Z07+KnYbLSuRyG9J6
 LZhFa8j1XOwbEyi/61G1rn6jVl6ydcRLQ9DxeMseanRS8wfOkyn5knQx/
 D1LSwjBH8QUSs9CkY0cEzWnFhCUpyAWo2off+79twmwnuhqTrtU40VtpP w==;
X-CSE-ConnectionGUID: 18Vt8YILSv6YNPQe08NbWg==
X-CSE-MsgGUID: 4iVUT6bOQvC88myFJSqleg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39097097"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="39097097"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2025 07:11:36 -0800
X-CSE-ConnectionGUID: vUrgBwLdTGe5UfVFyiBw8g==
X-CSE-MsgGUID: VLCWpDX4SJ+yRMUDV6e0Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; d="scan'208";a="110792574"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa008.fm.intel.com with ESMTP; 04 Feb 2025 07:11:34 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com
Subject: [PATCH v2 06/54] net/e1000: add missing hardware support
Date: Tue,  4 Feb 2025 15:10:12 +0000
Message-ID: <92e3c0e70ff98a653ad4abd9269f9f16fa3f7e45.1738681726.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738681725.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
 <cover.1738681725.git.anatoly.burakov@intel.com>
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

