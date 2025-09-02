Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEEDCA1007
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 17:28:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3290340B90;
	Tue,  2 Sep 2025 19:27:39 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id 8A4B740678
 for <dev@dpdk.org>; Tue,  2 Sep 2025 19:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756834049; x=1788370049;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=rwXGnEh+rt6JpaRht4/sAHww9UL2Zyw5NpEZtAQiUpM=;
 b=cWUncbYb/vz8rs8ZdfJYSymOh9qlZNo6zIdr9eAFJRBfeiLTT0iIYl1V
 anNNiGoqn+aURryGuRiRwwo47ZEjBfhmz+M7R89Y/1UPT4B/KbCSZixQv
 WAWyEMIOGBFv92V2UGS7uKTMU/7+XsFi3JAHSlyGP20rV01iuBKdOOdWB
 aCO465GhcOGmT4f1xSFgM6V7hNcLi02YbRMAyoGLbcjy0Rok7IUPITEYI
 lI5TyMzR9KDf0Vb8pmwWSrlU6YWgOvubkFSxJwFjqnE9AV1q26neBaqfC
 9BRyCVsJ++yDzEldZSYxeMEq7CN8Q6PFLuMsie694UPC0WTZ3QIz9S4d1 g==;
X-CSE-ConnectionGUID: aMf/86+ESA+smis5oRGm3Q==
X-CSE-MsgGUID: UxHmqWP3RDSAro2BxecJTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="69732028"
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="69732028"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 10:27:29 -0700
X-CSE-ConnectionGUID: PzsLGAeoRWqVD5PVZUQ3fA==
X-CSE-MsgGUID: 9LEaZ8JJQ5KQoN3y0YkYXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,233,1751266800"; d="scan'208";a="171229145"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by orviesa007.jf.intel.com with ESMTP; 02 Sep 2025 10:27:29 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 11/12] net/ice/base: add E835 device ID's
Date: Tue,  2 Sep 2025 18:27:01 +0100
Message-ID: <0a69285f4371dbbe1f2445d566987781e25720fe.1756833701.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1756833701.git.anatoly.burakov@intel.com>
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

E835 is an enhanced version of the E830, and uses the same interfaces as
E830.

Following device IDs are added:
- 0x1248: Intel(R) Ethernet Controller E835-CC for backplane
- 0x1249: Intel(R) Ethernet Controller E835-CC for QSFP
- 0x124A: Intel(R) Ethernet Controller E835-CC for SFP
- 0x1261: Intel(R) Ethernet Controller E835-C for backplane
- 0x1262: Intel(R) Ethernet Controller E835-C for QSFP
- 0x1263: Intel(R) Ethernet Controller E835-C for SFP
- 0x1265: Intel(R) Ethernet Controller E835-L for backplane
- 0x1266: Intel(R) Ethernet Controller E835-L for QSFP
- 0x1267: Intel(R) Ethernet Controller E835-L for SFP

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/base/ice_common.c |  9 +++++++++
 drivers/net/intel/ice/base/ice_devids.h | 18 ++++++++++++++++++
 drivers/net/intel/ice/ice_ethdev.c      |  9 +++++++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/net/intel/ice/base/ice_common.c b/drivers/net/intel/ice/base/ice_common.c
index 8be56f0aab..d9520097bd 100644
--- a/drivers/net/intel/ice/base/ice_common.c
+++ b/drivers/net/intel/ice/base/ice_common.c
@@ -189,6 +189,15 @@ static int ice_set_mac_type(struct ice_hw *hw)
 	case ICE_DEV_ID_E830_L_QSFP:
 	case ICE_DEV_ID_E830C_SFP:
 	case ICE_DEV_ID_E830_L_SFP:
+	case ICE_DEV_ID_E835CC_BACKPLANE:
+	case ICE_DEV_ID_E835CC_QSFP56:
+	case ICE_DEV_ID_E835CC_SFP:
+	case ICE_DEV_ID_E835C_BACKPLANE:
+	case ICE_DEV_ID_E835C_QSFP:
+	case ICE_DEV_ID_E835C_SFP:
+	case ICE_DEV_ID_E835_L_BACKPLANE:
+	case ICE_DEV_ID_E835_L_QSFP:
+	case ICE_DEV_ID_E835_L_SFP:
 		hw->mac_type = ICE_MAC_E830;
 		break;
 	default:
diff --git a/drivers/net/intel/ice/base/ice_devids.h b/drivers/net/intel/ice/base/ice_devids.h
index 20c6dbd4a5..9a38ebf15b 100644
--- a/drivers/net/intel/ice/base/ice_devids.h
+++ b/drivers/net/intel/ice/base/ice_devids.h
@@ -35,6 +35,24 @@
 #define ICE_DEV_ID_E830C_SFP            0x12DA
 /* Intel(R) Ethernet Controller E830-L for SFP */
 #define ICE_DEV_ID_E830_L_SFP         0x12DE
+/* Intel(R) Ethernet Controller E835-CC for backplane */
+#define ICE_DEV_ID_E835CC_BACKPLANE	0x1248
+/* Intel(R) Ethernet Controller E835-CC for QSFP */
+#define ICE_DEV_ID_E835CC_QSFP56	0x1249
+/* Intel(R) Ethernet Controller E835-CC for SFP */
+#define ICE_DEV_ID_E835CC_SFP		0x124A
+/* Intel(R) Ethernet Controller E835-C for backplane */
+#define ICE_DEV_ID_E835C_BACKPLANE	0x1261
+/* Intel(R) Ethernet Controller E835-C for QSFP */
+#define ICE_DEV_ID_E835C_QSFP		0x1262
+/* Intel(R) Ethernet Controller E835-C for SFP */
+#define ICE_DEV_ID_E835C_SFP		0x1263
+/* Intel(R) Ethernet Controller E835-L for backplane */
+#define ICE_DEV_ID_E835_L_BACKPLANE	0x1265
+/* Intel(R) Ethernet Controller E835-L for QSFP */
+#define ICE_DEV_ID_E835_L_QSFP		0x1266
+/* Intel(R) Ethernet Controller E835-L for SFP */
+#define ICE_DEV_ID_E835_L_SFP		0x1267
 /* Intel(R) Ethernet Controller E810-C for backplane */
 #define ICE_DEV_ID_E810C_BACKPLANE	0x1591
 /* Intel(R) Ethernet Controller E810-C for QSFP */
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 0ebe58f858..ee1adb6b67 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -237,6 +237,15 @@ static const struct rte_pci_id pci_id_ice_map[] = {
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E830_L_QSFP) },
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E830C_SFP) },
 	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E830_L_SFP) },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835CC_BACKPLANE), },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835CC_QSFP56), },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835CC_SFP), },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835C_BACKPLANE), },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835C_QSFP), },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835C_SFP), },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835_L_BACKPLANE), },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835_L_QSFP), },
+	{ RTE_PCI_DEVICE(ICE_INTEL_VENDOR_ID, ICE_DEV_ID_E835_L_SFP), },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
-- 
2.47.3

