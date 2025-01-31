Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9538BC02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:00:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95F2042DD0;
	Fri, 31 Jan 2025 13:59:41 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 04E7242DA7
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328376; x=1769864376;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=OfNrtlnbIhGxeKdbg3q7L/RI5CBSmvhpu6B91bnzQMo=;
 b=ffO4V4c2WvNeEBa/XT68skDuFmeyNFgT1DBFPTl+MU4fastRR7VIdYOh
 kXkUElI605AhiliWYoOnwT/r0DuN4vSrJ2Q81pYmHsATUw3SLIeQJCD3M
 KnyyTPdFn0VYkvde7GyLSRXODMyE8nay/TwhsKZlMwN702j9j9ax42IHI
 NlrNJxhWB9W7ibhcX4RT3/Unn4NLhM8hDKJ5RXeu85D1xLdxi1RaZgxmD
 CsPOARFrULBJ1E8ViPg52HrqDj67OkU3nw8VrnYsdIFSWtBqS+qEdEbvM
 miW41LtiP0Q7S6azbl3mYqBkpvlSllC7KPegBr+iYTXcHkUWnTWfPjxUt w==;
X-CSE-ConnectionGUID: ZVtZJOboQGir2WOoaH8Kng==
X-CSE-MsgGUID: Vgu+sNrhTHSa4KoP3BULPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315626"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315626"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:36 -0800
X-CSE-ConnectionGUID: E3hUn5A5SIC6ydtqTS4FpA==
X-CSE-MsgGUID: kfnr49elRmiIUyWyCJbIgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503374"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:35 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 11/42] net/e1000: add missing hardware support
Date: Fri, 31 Jan 2025 12:58:24 +0000
Message-ID: <ced91ef3410ea1d97636570fcc051f3a02a525b4.1738328107.git.anatoly.burakov@intel.com>
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

