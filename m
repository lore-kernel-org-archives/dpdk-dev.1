Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB312606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QbPMxVU/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3C7A406BA;
	Thu, 22 Oct 2026 18:52:23 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 3A65740A6C
 for <dev@dpdk.org>; Thu, 22 Oct 2026 18:52:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792687940; x=1824223940;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Nt0XCh0C4qv4JlRk0xNvBQh2CwR2vM4/w7c3q6LDSPA=;
 b=QbPMxVU/sJ5sZAQ/Nchh50gR9nONgTB4f6IxixHItiL8/M8QUz7kZFX/
 0FpWqCMf3okw/w7S46LatuJeAO0jjEAD6CNpQw5OJDDfENieH1zas+Df6
 jrkII+ah6K9HNIiFcuHg9Z26TNblkLJKJ7QOPUdPpNJjlrTgQj9abhZVz
 lQCO3PliVkDt6/Q8yXh9wKxoEprw0pT1H2WYI0h8A8k7tKm5TnKKpV1cx
 UnvuklbNXWK7vL7dtauyctg1mqnutSe1RuvcyblFUx9Xu7qXNN3+vVyAR
 ZJ81zWh4zLna01EyRuS90Nnn3kumO8WOYwOzqYc4nFDVJR9Lg10Wye1Y6 w==;
X-CSE-ConnectionGUID: nMLDiih5QQK/ux1Z/1K+nQ==
X-CSE-MsgGUID: gvIhQY41Rp+LKDFd0Bw6lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1341052"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1341052"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Oct 2026 09:52:19 -0700
X-CSE-ConnectionGUID: tmOsQy7eQQOADVoZmrT9rA==
X-CSE-MsgGUID: EZTaDK57SZ2l+6h+f89xBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3507854"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by fmviesa003.fm.intel.com with ESMTP; 22 Oct 2026 09:52:17 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, anatoly.burakov@intel.com,
 Chinh Cao <chinh.t.cao@intel.com>
Subject: [PATCH 8/9] net/ice/base: add E835 10GBASE-T device ID
Date: Thu, 22 Oct 2026 16:52:04 +0000
Message-ID: <20261022165205.1830735-9-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
References: <20261022165205.1830735-1-vladimir.medvedkin@intel.com>
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

From: Chinh Cao <chinh.t.cao@intel.com>

Following device ID is added:
- 0x1256: Intel(R) Ethernet Controller E830(E835)-CC/X557-AT 10GBASE-T

While at it, fix the alignment of the E830 device ID definitions.

Signed-off-by: Chinh Cao <chinh.t.cao@intel.com>
Signed-off-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c |  1 +
 drivers/net/intel/ice/base/ice_devids.h | 14 ++++++++------
 drivers/net/intel/ice/ice_ethdev.c      |  1 +
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 1a8f4e7a6e..c379c4921d 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -189,6 +189,7 @@ static int ice_set_mac_type(struct ice_hw *hw)
 	case ICE_DEV_ID_E830_L_QSFP:
 	case ICE_DEV_ID_E830C_SFP:
 	case ICE_DEV_ID_E830_L_SFP:
+	case ICE_DEV_ID_E835_10G_BASE_T:
 	case ICE_DEV_ID_E835CC_BACKPLANE:
 	case ICE_DEV_ID_E835CC_QSFP56:
 	case ICE_DEV_ID_E835CC_SFP:
diff --git a/drivers/net/intel/ice/base/ice_devids.h b/drivers/net/intel/ice/base/ice_devids.h
index 9a38ebf15b..05448c9bbf 100644
--- a/drivers/net/intel/ice/base/ice_devids.h
+++ b/drivers/net/intel/ice/base/ice_devids.h
@@ -24,17 +24,19 @@
 /* Intel(R) Ethernet Controller E830-CC for SFP */
 #define ICE_DEV_ID_E830_SFP		0x12D3
 /* Intel(R) Ethernet Controller E830-C for backplane */
-#define ICE_DEV_ID_E830C_BACKPLANE      0x12D5
+#define ICE_DEV_ID_E830C_BACKPLANE	0x12D5
 /* Intel(R) Ethernet Controller E830-L for backplane */
-#define ICE_DEV_ID_E830_L_BACKPLANE   0x12DC
+#define ICE_DEV_ID_E830_L_BACKPLANE	0x12DC
 /* Intel(R) Ethernet Controller E830-C for QSFP */
-#define ICE_DEV_ID_E830C_QSFP           0x12D8
+#define ICE_DEV_ID_E830C_QSFP		0x12D8
 /* Intel(R) Ethernet Controller E830-L for QSFP */
-#define ICE_DEV_ID_E830_L_QSFP        0x12DD
+#define ICE_DEV_ID_E830_L_QSFP		0x12DD
 /* Intel(R) Ethernet Controller E830-C for SFP */
-#define ICE_DEV_ID_E830C_SFP            0x12DA
+#define ICE_DEV_ID_E830C_SFP		0x12DA
 /* Intel(R) Ethernet Controller E830-L for SFP */
-#define ICE_DEV_ID_E830_L_SFP         0x12DE
+#define ICE_DEV_ID_E830_L_SFP		0x12DE
+/* Intel(R) Ethernet Controller E830(E835)-CC/X557-AT 10GBASE-T */
+#define ICE_DEV_ID_E835_10G_BASE_T	0x1256
 /* Intel(R) Ethernet Controller E835-CC for backplane */
 #define ICE_DEV_ID_E835CC_BACKPLANE	0x1248
 /* Intel(R) Ethernet Controller E835-CC for QSFP */
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index d6dfc07ad5..b846555b97 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -265,6 +265,7 @@ static const struct rte_pci_id pci_id_ice_map[] = {
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E830_L_QSFP) },
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E830C_SFP) },
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E830_L_SFP) },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835_10G_BASE_T) },
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835CC_BACKPLANE), },
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835CC_QSFP56), },
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835CC_SFP), },
-- 
2.43.0

