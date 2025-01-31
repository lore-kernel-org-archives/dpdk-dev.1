Return-Path: <dev-bounces@dpdk.org>
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA74EC0218F
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2D77A42DCD;
	Fri, 31 Jan 2025 13:59:40 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 1C32442DA3
 for <dev@dpdk.org>; Fri, 31 Jan 2025 13:59:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328374; x=1769864374;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=5b8ty4qxP5H+u2cFPGBDYiYb7rOTsD3lryvoaS6j0xo=;
 b=D0PsvTQxCVqjx8dNsXGJatj6P0IawKAOWAYE2lz2HVadTi1uUGuK2izc
 20Rz7GfG3STeDMVVGYqecxN2nLbxMenE/lzPydlzaWen1Mv+Q3ZWFR46x
 2zwca6ybN4LPPTHg1hN8YDjx2swbkwHYoK+DvzmINeXJn1XiZHLvEGy3Z
 R1MsW4oI/MXiSEnfGKO88D9i85Z2rvQMcm+DtyWVG+wRswZ09B/o9sj1G
 RyAZ3EvOdOUX3me0DkY1I7SPWISBDWCDZBIrUWDuAbW0dM1usHKwShH72
 tWQ85SEco06gPum2A/yVKmM+SUxYvfpw2CVZ8Uvl00FLhSi2YmFItTlYh w==;
X-CSE-ConnectionGUID: tNRcRlZoR0mYXEoVzsR40A==
X-CSE-MsgGUID: TmkdOVGJRbe2WvZskJbDRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315621"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315621"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 04:59:34 -0800
X-CSE-ConnectionGUID: jxSahJu7Qru1ZnfOByopnw==
X-CSE-MsgGUID: XhtXAgT3RiOZY8MW08vB0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503362"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 04:59:31 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 09/42] net/e1000: merge igc with e1000
Date: Fri, 31 Jan 2025 12:58:22 +0000
Message-ID: <b74b934af577b7f0f3126862502cf00afbac7fe5.1738328107.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

IGC and E1000 drivers are derived from the same base code. Now that e1000
code has enabled support for i225 devices, move IGC ethdev code to e1000
directory (renaming references to base code from igc_* to e1000_*), and
remove igc directory and base code.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_osdep.h    |   33 +-
 drivers/net/intel/{igc => e1000}/igc_ethdev.c |  910 ++--
 drivers/net/intel/{igc => e1000}/igc_ethdev.h |   32 +-
 drivers/net/intel/{igc => e1000}/igc_filter.c |   84 +-
 drivers/net/intel/{igc => e1000}/igc_filter.h |    0
 drivers/net/intel/{igc => e1000}/igc_flow.c   |    2 +-
 drivers/net/intel/{igc => e1000}/igc_flow.h   |    0
 drivers/net/intel/{igc => e1000}/igc_logs.c   |    2 +-
 drivers/net/intel/{igc => e1000}/igc_txrx.c   |  376 +-
 drivers/net/intel/{igc => e1000}/igc_txrx.h   |    6 +-
 drivers/net/intel/e1000/meson.build           |   11 +
 drivers/net/intel/igc/base/README             |   29 -
 drivers/net/intel/igc/base/igc_82571.h        |   36 -
 drivers/net/intel/igc/base/igc_82575.h        |  351 --
 drivers/net/intel/igc/base/igc_api.c          | 1853 -------
 drivers/net/intel/igc/base/igc_api.h          |  111 -
 drivers/net/intel/igc/base/igc_base.c         |  190 -
 drivers/net/intel/igc/base/igc_base.h         |  127 -
 drivers/net/intel/igc/base/igc_defines.h      | 1670 -------
 drivers/net/intel/igc/base/igc_hw.h           | 1059 ----
 drivers/net/intel/igc/base/igc_i225.c         | 1372 -----
 drivers/net/intel/igc/base/igc_i225.h         |  110 -
 drivers/net/intel/igc/base/igc_ich8lan.h      |  296 --
 drivers/net/intel/igc/base/igc_mac.c          | 2100 --------
 drivers/net/intel/igc/base/igc_mac.h          |   64 -
 drivers/net/intel/igc/base/igc_manage.c       |  547 --
 drivers/net/intel/igc/base/igc_manage.h       |   65 -
 drivers/net/intel/igc/base/igc_nvm.c          | 1324 -----
 drivers/net/intel/igc/base/igc_nvm.h          |   69 -
 drivers/net/intel/igc/base/igc_osdep.c        |   64 -
 drivers/net/intel/igc/base/igc_osdep.h        |  163 -
 drivers/net/intel/igc/base/igc_phy.c          | 4420 -----------------
 drivers/net/intel/igc/base/igc_phy.h          |  337 --
 drivers/net/intel/igc/base/igc_regs.h         |  732 ---
 drivers/net/intel/igc/base/meson.build        |   19 -
 drivers/net/intel/igc/igc_logs.h              |   43 -
 drivers/net/intel/igc/meson.build             |   21 -
 drivers/net/meson.build                       |    1 -
 38 files changed, 743 insertions(+), 17886 deletions(-)
 rename drivers/net/intel/{igc => e1000}/igc_ethdev.c (73%)
 rename drivers/net/intel/{igc => e1000}/igc_ethdev.h (91%)
 rename drivers/net/intel/{igc => e1000}/igc_filter.c (81%)
 rename drivers/net/intel/{igc => e1000}/igc_filter.h (100%)
 rename drivers/net/intel/{igc => e1000}/igc_flow.c (99%)
 rename drivers/net/intel/{igc => e1000}/igc_flow.h (100%)
 rename drivers/net/intel/{igc => e1000}/igc_logs.c (90%)
 rename drivers/net/intel/{igc => e1000}/igc_txrx.c (87%)
 rename drivers/net/intel/{igc => e1000}/igc_txrx.h (97%)
 delete mode 100644 drivers/net/intel/igc/base/README
 delete mode 100644 drivers/net/intel/igc/base/igc_82571.h
 delete mode 100644 drivers/net/intel/igc/base/igc_82575.h
 delete mode 100644 drivers/net/intel/igc/base/igc_api.c
 delete mode 100644 drivers/net/intel/igc/base/igc_api.h
 delete mode 100644 drivers/net/intel/igc/base/igc_base.c
 delete mode 100644 drivers/net/intel/igc/base/igc_base.h
 delete mode 100644 drivers/net/intel/igc/base/igc_defines.h
 delete mode 100644 drivers/net/intel/igc/base/igc_hw.h
 delete mode 100644 drivers/net/intel/igc/base/igc_i225.c
 delete mode 100644 drivers/net/intel/igc/base/igc_i225.h
 delete mode 100644 drivers/net/intel/igc/base/igc_ich8lan.h
 delete mode 100644 drivers/net/intel/igc/base/igc_mac.c
 delete mode 100644 drivers/net/intel/igc/base/igc_mac.h
 delete mode 100644 drivers/net/intel/igc/base/igc_manage.c
 delete mode 100644 drivers/net/intel/igc/base/igc_manage.h
 delete mode 100644 drivers/net/intel/igc/base/igc_nvm.c
 delete mode 100644 drivers/net/intel/igc/base/igc_nvm.h
 delete mode 100644 drivers/net/intel/igc/base/igc_osdep.c
 delete mode 100644 drivers/net/intel/igc/base/igc_osdep.h
 delete mode 100644 drivers/net/intel/igc/base/igc_phy.c
 delete mode 100644 drivers/net/intel/igc/base/igc_phy.h
 delete mode 100644 drivers/net/intel/igc/base/igc_regs.h
 delete mode 100644 drivers/net/intel/igc/base/meson.build
 delete mode 100644 drivers/net/intel/igc/igc_logs.h
 delete mode 100644 drivers/net/intel/igc/meson.build

diff --git a/drivers/net/intel/e1000/base/e1000_osdep.h b/drivers/net/intel/e1000/base/e1000_osdep.h
index 46565d05e7..fb48eb7d2b 100644
--- a/drivers/net/intel/e1000/base/e1000_osdep.h
+++ b/drivers/net/intel/e1000/base/e1000_osdep.h
@@ -34,13 +34,26 @@
 #define DEBUGOUT6(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
 #define DEBUGOUT7(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
 
-#ifndef UNREFERENCED_PARAMETER
-#define UNREFERENCED_PARAMETER(_p)
-#endif
-#define UNREFERENCED_1PARAMETER(_p)
-#define UNREFERENCED_2PARAMETER(_p, _q)
-#define UNREFERENCED_3PARAMETER(_p, _q, _r)
-#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s)
+#define UNREFERENCED_PARAMETER(_p)	(void)(_p)
+#define UNREFERENCED_1PARAMETER(_p)	(void)(_p)
+#define UNREFERENCED_2PARAMETER(_p, _q)	\
+	do {				\
+		(void)(_p);		\
+		(void)(_q);		\
+	} while (0)
+#define UNREFERENCED_3PARAMETER(_p, _q, _r)	\
+	do {					\
+		(void)(_p);			\
+		(void)(_q);			\
+		(void)(_r);			\
+	} while (0)
+#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s)	\
+	do {					\
+		(void)(_p);			\
+		(void)(_q);			\
+		(void)(_r);			\
+		(void)(_s);			\
+	} while (0)
 
 #define FALSE			0
 #define TRUE			1
@@ -117,9 +130,15 @@ static inline uint16_t e1000_read_addr16(volatile void *addr)
 #define E1000_READ_REG(hw, reg) \
 	e1000_read_addr(E1000_PCI_REG_ADDR((hw), (reg)))
 
+#define E1000_READ_REG_LE_VALUE(hw, reg) \
+	rte_read32(E1000_PCI_REG_ADDR((hw), (reg)))
+
 #define E1000_WRITE_REG(hw, reg, value) \
 	E1000_PCI_REG_WRITE(E1000_PCI_REG_ADDR((hw), (reg)), (value))
 
+#define E1000_WRITE_REG_LE_VALUE(hw, reg, value) \
+	rte_write32(value, E1000_PCI_REG_ADDR((hw), (reg)))
+
 #define E1000_READ_REG_ARRAY(hw, reg, index) \
 	E1000_PCI_REG(E1000_PCI_REG_ARRAY_ADDR((hw), (reg), (index)))
 
diff --git a/drivers/net/intel/igc/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
similarity index 73%
rename from drivers/net/intel/igc/igc_ethdev.c
rename to drivers/net/intel/e1000/igc_ethdev.c
index 87d7f7caa0..5563cee09c 100644
--- a/drivers/net/intel/igc/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -13,7 +13,7 @@
 #include <rte_malloc.h>
 #include <rte_alarm.h>
 
-#include "igc_logs.h"
+#include "e1000_logs.h"
 #include "igc_txrx.h"
 #include "igc_filter.h"
 #include "igc_flow.h"
@@ -106,18 +106,18 @@ static const struct rte_eth_desc_lim tx_desc_lim = {
 };
 
 static const struct rte_pci_id pci_id_igc_map[] = {
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_LM) },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_LMVP) },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_V)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_I)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_IT)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I225_K)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_K)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_LMVP)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_LM)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_V)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_IT)  },
-	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, IGC_DEV_ID_I226_BLANK_NVM)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LM) },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_LMVP) },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_V)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_I)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_IT)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I225_K)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_K)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LMVP)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_LM)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_V)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_IT)  },
+	{ RTE_PCI_DEVICE(IGC_INTEL_VENDOR_ID, E1000_DEV_ID_I226_BLANK_NVM)  },
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
@@ -128,64 +128,64 @@ struct rte_igc_xstats_name_off {
 };
 
 static const struct rte_igc_xstats_name_off rte_igc_stats_strings[] = {
-	{"rx_crc_errors", offsetof(struct igc_hw_stats, crcerrs)},
-	{"rx_align_errors", offsetof(struct igc_hw_stats, algnerrc)},
-	{"rx_errors", offsetof(struct igc_hw_stats, rxerrc)},
-	{"rx_missed_packets", offsetof(struct igc_hw_stats, mpc)},
-	{"tx_single_collision_packets", offsetof(struct igc_hw_stats, scc)},
-	{"tx_multiple_collision_packets", offsetof(struct igc_hw_stats, mcc)},
-	{"tx_excessive_collision_packets", offsetof(struct igc_hw_stats,
+	{"rx_crc_errors", offsetof(struct e1000_hw_stats, crcerrs)},
+	{"rx_align_errors", offsetof(struct e1000_hw_stats, algnerrc)},
+	{"rx_errors", offsetof(struct e1000_hw_stats, rxerrc)},
+	{"rx_missed_packets", offsetof(struct e1000_hw_stats, mpc)},
+	{"tx_single_collision_packets", offsetof(struct e1000_hw_stats, scc)},
+	{"tx_multiple_collision_packets", offsetof(struct e1000_hw_stats, mcc)},
+	{"tx_excessive_collision_packets", offsetof(struct e1000_hw_stats,
 		ecol)},
-	{"tx_late_collisions", offsetof(struct igc_hw_stats, latecol)},
-	{"tx_total_collisions", offsetof(struct igc_hw_stats, colc)},
-	{"tx_deferred_packets", offsetof(struct igc_hw_stats, dc)},
-	{"tx_no_carrier_sense_packets", offsetof(struct igc_hw_stats, tncrs)},
-	{"tx_discarded_packets", offsetof(struct igc_hw_stats, htdpmc)},
-	{"rx_length_errors", offsetof(struct igc_hw_stats, rlec)},
-	{"rx_xon_packets", offsetof(struct igc_hw_stats, xonrxc)},
-	{"tx_xon_packets", offsetof(struct igc_hw_stats, xontxc)},
-	{"rx_xoff_packets", offsetof(struct igc_hw_stats, xoffrxc)},
-	{"tx_xoff_packets", offsetof(struct igc_hw_stats, xofftxc)},
-	{"rx_flow_control_unsupported_packets", offsetof(struct igc_hw_stats,
+	{"tx_late_collisions", offsetof(struct e1000_hw_stats, latecol)},
+	{"tx_total_collisions", offsetof(struct e1000_hw_stats, colc)},
+	{"tx_deferred_packets", offsetof(struct e1000_hw_stats, dc)},
+	{"tx_no_carrier_sense_packets", offsetof(struct e1000_hw_stats, tncrs)},
+	{"tx_discarded_packets", offsetof(struct e1000_hw_stats, htdpmc)},
+	{"rx_length_errors", offsetof(struct e1000_hw_stats, rlec)},
+	{"rx_xon_packets", offsetof(struct e1000_hw_stats, xonrxc)},
+	{"tx_xon_packets", offsetof(struct e1000_hw_stats, xontxc)},
+	{"rx_xoff_packets", offsetof(struct e1000_hw_stats, xoffrxc)},
+	{"tx_xoff_packets", offsetof(struct e1000_hw_stats, xofftxc)},
+	{"rx_flow_control_unsupported_packets", offsetof(struct e1000_hw_stats,
 		fcruc)},
-	{"rx_size_64_packets", offsetof(struct igc_hw_stats, prc64)},
-	{"rx_size_65_to_127_packets", offsetof(struct igc_hw_stats, prc127)},
-	{"rx_size_128_to_255_packets", offsetof(struct igc_hw_stats, prc255)},
-	{"rx_size_256_to_511_packets", offsetof(struct igc_hw_stats, prc511)},
-	{"rx_size_512_to_1023_packets", offsetof(struct igc_hw_stats,
+	{"rx_size_64_packets", offsetof(struct e1000_hw_stats, prc64)},
+	{"rx_size_65_to_127_packets", offsetof(struct e1000_hw_stats, prc127)},
+	{"rx_size_128_to_255_packets", offsetof(struct e1000_hw_stats, prc255)},
+	{"rx_size_256_to_511_packets", offsetof(struct e1000_hw_stats, prc511)},
+	{"rx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
 		prc1023)},
-	{"rx_size_1024_to_max_packets", offsetof(struct igc_hw_stats,
+	{"rx_size_1024_to_max_packets", offsetof(struct e1000_hw_stats,
 		prc1522)},
-	{"rx_broadcast_packets", offsetof(struct igc_hw_stats, bprc)},
-	{"rx_multicast_packets", offsetof(struct igc_hw_stats, mprc)},
-	{"rx_undersize_errors", offsetof(struct igc_hw_stats, ruc)},
-	{"rx_fragment_errors", offsetof(struct igc_hw_stats, rfc)},
-	{"rx_oversize_errors", offsetof(struct igc_hw_stats, roc)},
-	{"rx_jabber_errors", offsetof(struct igc_hw_stats, rjc)},
-	{"rx_no_buffers", offsetof(struct igc_hw_stats, rnbc)},
-	{"rx_management_packets", offsetof(struct igc_hw_stats, mgprc)},
-	{"rx_management_dropped", offsetof(struct igc_hw_stats, mgpdc)},
-	{"tx_management_packets", offsetof(struct igc_hw_stats, mgptc)},
-	{"rx_total_packets", offsetof(struct igc_hw_stats, tpr)},
-	{"tx_total_packets", offsetof(struct igc_hw_stats, tpt)},
-	{"rx_total_bytes", offsetof(struct igc_hw_stats, tor)},
-	{"tx_total_bytes", offsetof(struct igc_hw_stats, tot)},
-	{"tx_size_64_packets", offsetof(struct igc_hw_stats, ptc64)},
-	{"tx_size_65_to_127_packets", offsetof(struct igc_hw_stats, ptc127)},
-	{"tx_size_128_to_255_packets", offsetof(struct igc_hw_stats, ptc255)},
-	{"tx_size_256_to_511_packets", offsetof(struct igc_hw_stats, ptc511)},
-	{"tx_size_512_to_1023_packets", offsetof(struct igc_hw_stats,
+	{"rx_broadcast_packets", offsetof(struct e1000_hw_stats, bprc)},
+	{"rx_multicast_packets", offsetof(struct e1000_hw_stats, mprc)},
+	{"rx_undersize_errors", offsetof(struct e1000_hw_stats, ruc)},
+	{"rx_fragment_errors", offsetof(struct e1000_hw_stats, rfc)},
+	{"rx_oversize_errors", offsetof(struct e1000_hw_stats, roc)},
+	{"rx_jabber_errors", offsetof(struct e1000_hw_stats, rjc)},
+	{"rx_no_buffers", offsetof(struct e1000_hw_stats, rnbc)},
+	{"rx_management_packets", offsetof(struct e1000_hw_stats, mgprc)},
+	{"rx_management_dropped", offsetof(struct e1000_hw_stats, mgpdc)},
+	{"tx_management_packets", offsetof(struct e1000_hw_stats, mgptc)},
+	{"rx_total_packets", offsetof(struct e1000_hw_stats, tpr)},
+	{"tx_total_packets", offsetof(struct e1000_hw_stats, tpt)},
+	{"rx_total_bytes", offsetof(struct e1000_hw_stats, tor)},
+	{"tx_total_bytes", offsetof(struct e1000_hw_stats, tot)},
+	{"tx_size_64_packets", offsetof(struct e1000_hw_stats, ptc64)},
+	{"tx_size_65_to_127_packets", offsetof(struct e1000_hw_stats, ptc127)},
+	{"tx_size_128_to_255_packets", offsetof(struct e1000_hw_stats, ptc255)},
+	{"tx_size_256_to_511_packets", offsetof(struct e1000_hw_stats, ptc511)},
+	{"tx_size_512_to_1023_packets", offsetof(struct e1000_hw_stats,
 		ptc1023)},
-	{"tx_size_1023_to_max_packets", offsetof(struct igc_hw_stats,
+	{"tx_size_1023_to_max_packets", offsetof(struct e1000_hw_stats,
 		ptc1522)},
-	{"tx_multicast_packets", offsetof(struct igc_hw_stats, mptc)},
-	{"tx_broadcast_packets", offsetof(struct igc_hw_stats, bptc)},
-	{"tx_tso_packets", offsetof(struct igc_hw_stats, tsctc)},
-	{"rx_sent_to_host_packets", offsetof(struct igc_hw_stats, rpthc)},
-	{"tx_sent_by_host_packets", offsetof(struct igc_hw_stats, hgptc)},
-	{"interrupt_assert_count", offsetof(struct igc_hw_stats, iac)},
+	{"tx_multicast_packets", offsetof(struct e1000_hw_stats, mptc)},
+	{"tx_broadcast_packets", offsetof(struct e1000_hw_stats, bptc)},
+	{"tx_tso_packets", offsetof(struct e1000_hw_stats, tsctc)},
+	{"rx_sent_to_host_packets", offsetof(struct e1000_hw_stats, rpthc)},
+	{"tx_sent_by_host_packets", offsetof(struct e1000_hw_stats, hgptc)},
+	{"interrupt_assert_count", offsetof(struct e1000_hw_stats, iac)},
 	{"rx_descriptor_lower_threshold",
-		offsetof(struct igc_hw_stats, icrxdmtc)},
+		offsetof(struct e1000_hw_stats, icrxdmtc)},
 };
 
 #define IGC_NB_XSTATS (sizeof(rte_igc_stats_strings) / \
@@ -391,24 +391,24 @@ eth_igc_configure(struct rte_eth_dev *dev)
 static int
 eth_igc_set_link_up(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	if (hw->phy.media_type == igc_media_type_copper)
-		igc_power_up_phy(hw);
+	if (hw->phy.media_type == e1000_media_type_copper)
+		e1000_power_up_phy(hw);
 	else
-		igc_power_up_fiber_serdes_link(hw);
+		e1000_power_up_fiber_serdes_link(hw);
 	return 0;
 }
 
 static int
 eth_igc_set_link_down(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	if (hw->phy.media_type == igc_media_type_copper)
-		igc_power_down_phy(hw);
+	if (hw->phy.media_type == e1000_media_type_copper)
+		e1000_power_down_phy(hw);
 	else
-		igc_shutdown_fiber_serdes_link(hw);
+		e1000_shutdown_fiber_serdes_link(hw);
 	return 0;
 }
 
@@ -418,17 +418,17 @@ eth_igc_set_link_down(struct rte_eth_dev *dev)
 static void
 igc_intr_other_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (rte_intr_allow_others(intr_handle) &&
 		dev->data->dev_conf.intr_conf.lsc) {
-		IGC_WRITE_REG(hw, IGC_EIMC, 1u << IGC_MSIX_OTHER_INTR_VEC);
+		E1000_WRITE_REG(hw, E1000_EIMC, 1u << IGC_MSIX_OTHER_INTR_VEC);
 	}
 
-	IGC_WRITE_REG(hw, IGC_IMC, ~0);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_IMC, ~0);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /*
@@ -438,17 +438,17 @@ static inline void
 igc_intr_other_enable(struct rte_eth_dev *dev)
 {
 	struct igc_interrupt *intr = IGC_DEV_PRIVATE_INTR(dev);
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
 	if (rte_intr_allow_others(intr_handle) &&
 		dev->data->dev_conf.intr_conf.lsc) {
-		IGC_WRITE_REG(hw, IGC_EIMS, 1u << IGC_MSIX_OTHER_INTR_VEC);
+		E1000_WRITE_REG(hw, E1000_EIMS, 1u << IGC_MSIX_OTHER_INTR_VEC);
 	}
 
-	IGC_WRITE_REG(hw, IGC_IMS, intr->mask);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_IMS, intr->mask);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /*
@@ -459,14 +459,14 @@ static void
 eth_igc_interrupt_get_status(struct rte_eth_dev *dev)
 {
 	uint32_t icr;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_interrupt *intr = IGC_DEV_PRIVATE_INTR(dev);
 
 	/* read-on-clear nic registers here */
-	icr = IGC_READ_REG(hw, IGC_ICR);
+	icr = E1000_READ_REG(hw, E1000_ICR);
 
 	intr->flags = 0;
-	if (icr & IGC_ICR_LSC)
+	if (icr & E1000_ICR_LSC)
 		intr->flags |= IGC_FLAG_NEED_LINK_UPDATE;
 }
 
@@ -474,7 +474,7 @@ eth_igc_interrupt_get_status(struct rte_eth_dev *dev)
 static int
 eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_eth_link link;
 	int link_check, count;
 
@@ -485,20 +485,20 @@ eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 	for (count = 0; count < IGC_LINK_UPDATE_CHECK_TIMEOUT; count++) {
 		/* Read the real link status */
 		switch (hw->phy.media_type) {
-		case igc_media_type_copper:
+		case e1000_media_type_copper:
 			/* Do the work to read phy */
-			igc_check_for_link(hw);
+			e1000_check_for_link(hw);
 			link_check = !hw->mac.get_link_status;
 			break;
 
-		case igc_media_type_fiber:
-			igc_check_for_link(hw);
-			link_check = (IGC_READ_REG(hw, IGC_STATUS) &
-				      IGC_STATUS_LU);
+		case e1000_media_type_fiber:
+			e1000_check_for_link(hw);
+			link_check = (E1000_READ_REG(hw, E1000_STATUS) &
+				      E1000_STATUS_LU);
 			break;
 
-		case igc_media_type_internal_serdes:
-			igc_check_for_link(hw);
+		case e1000_media_type_internal_serdes:
+			e1000_check_for_link(hw);
 			link_check = hw->mac.serdes_has_link;
 			break;
 
@@ -524,11 +524,11 @@ eth_igc_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 				RTE_ETH_LINK_SPEED_FIXED);
 
 		if (speed == SPEED_2500) {
-			uint32_t tipg = IGC_READ_REG(hw, IGC_TIPG);
-			if ((tipg & IGC_TIPG_IPGT_MASK) != 0x0b) {
-				tipg &= ~IGC_TIPG_IPGT_MASK;
+			uint32_t tipg = E1000_READ_REG(hw, E1000_TIPG);
+			if ((tipg & E1000_TIPG_IPGT_MASK) != 0x0b) {
+				tipg &= ~E1000_TIPG_IPGT_MASK;
 				tipg |= 0x0b;
-				IGC_WRITE_REG(hw, IGC_TIPG, tipg);
+				E1000_WRITE_REG(hw, E1000_TIPG, tipg);
 			}
 		}
 	} else {
@@ -622,24 +622,24 @@ igc_update_queue_stats_handler(void *param)
 static void
 eth_igc_rxtx_control(struct rte_eth_dev *dev, bool enable)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t tctl, rctl;
 
-	tctl = IGC_READ_REG(hw, IGC_TCTL);
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
+	tctl = E1000_READ_REG(hw, E1000_TCTL);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
 
 	if (enable) {
 		/* enable Tx/Rx */
-		tctl |= IGC_TCTL_EN;
-		rctl |= IGC_RCTL_EN;
+		tctl |= E1000_TCTL_EN;
+		rctl |= E1000_RCTL_EN;
 	} else {
 		/* disable Tx/Rx */
-		tctl &= ~IGC_TCTL_EN;
-		rctl &= ~IGC_RCTL_EN;
+		tctl &= ~E1000_TCTL_EN;
+		rctl &= ~E1000_RCTL_EN;
 	}
-	IGC_WRITE_REG(hw, IGC_TCTL, tctl);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_TCTL, tctl);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /*
@@ -650,7 +650,7 @@ static int
 eth_igc_stop(struct rte_eth_dev *dev)
 {
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct rte_eth_link link;
@@ -662,11 +662,11 @@ eth_igc_stop(struct rte_eth_dev *dev)
 	eth_igc_rxtx_control(dev, false);
 
 	/* disable all MSI-X interrupts */
-	IGC_WRITE_REG(hw, IGC_EIMC, 0x1f);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_EIMC, 0x1f);
+	E1000_WRITE_FLUSH(hw);
 
 	/* clear all MSI-X interrupts */
-	IGC_WRITE_REG(hw, IGC_EICR, 0x1f);
+	E1000_WRITE_REG(hw, E1000_EICR, 0x1f);
 
 	igc_intr_other_disable(dev);
 
@@ -675,17 +675,17 @@ eth_igc_stop(struct rte_eth_dev *dev)
 	/* disable intr eventfd mapping */
 	rte_intr_disable(intr_handle);
 
-	igc_reset_hw(hw);
+	e1000_reset_hw(hw);
 
 	/* disable all wake up */
-	IGC_WRITE_REG(hw, IGC_WUC, 0);
+	E1000_WRITE_REG(hw, E1000_WUC, 0);
 
 	/* disable checking EEE operation in MAC loopback mode */
-	igc_read_reg_check_clear_bits(hw, IGC_EEER, IGC_EEER_EEE_FRC_AN);
+	igc_read_reg_check_clear_bits(hw, E1000_EEER, IGC_EEER_EEE_FRC_AN);
 
 	/* Set bit for Go Link disconnect */
-	igc_read_reg_check_set_bits(hw, IGC_82580_PHY_POWER_MGMT,
-			IGC_82580_PM_GO_LINKD);
+	igc_read_reg_check_set_bits(hw, E1000_82580_PHY_POWER_MGMT,
+			E1000_82580_PM_GO_LINKD);
 
 	/* Power down the phy. Needed to make the link go Down */
 	eth_igc_set_link_down(dev);
@@ -721,7 +721,7 @@ eth_igc_stop(struct rte_eth_dev *dev)
  *  msix-vector, valid 0,1,2,3,4
  */
 static void
-igc_write_ivar(struct igc_hw *hw, uint8_t queue_index,
+igc_write_ivar(struct e1000_hw *hw, uint8_t queue_index,
 		bool tx, uint8_t msix_vector)
 {
 	uint8_t offset = 0;
@@ -744,15 +744,15 @@ igc_write_ivar(struct igc_hw *hw, uint8_t queue_index,
 	if (queue_index & 1)
 		offset += 16;
 
-	val = IGC_READ_REG_ARRAY(hw, IGC_IVAR0, reg_index);
+	val = E1000_READ_REG_ARRAY(hw, E1000_IVAR0, reg_index);
 
 	/* clear bits */
 	val &= ~((uint32_t)0xFF << offset);
 
 	/* write vector and valid bit */
-	val |= (uint32_t)(msix_vector | IGC_IVAR_VALID) << offset;
+	val |= (uint32_t)(msix_vector | E1000_IVAR_VALID) << offset;
 
-	IGC_WRITE_REG_ARRAY(hw, IGC_IVAR0, reg_index, val);
+	E1000_WRITE_REG_ARRAY(hw, E1000_IVAR0, reg_index, val);
 }
 
 /* Sets up the hardware to generate MSI-X interrupts properly
@@ -762,7 +762,7 @@ igc_write_ivar(struct igc_hw *hw, uint8_t queue_index,
 static void
 igc_configure_msix_intr(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 
@@ -785,9 +785,9 @@ igc_configure_msix_intr(struct rte_eth_dev *dev)
 	}
 
 	/* turn on MSI-X capability first */
-	IGC_WRITE_REG(hw, IGC_GPIE, IGC_GPIE_MSIX_MODE |
-				IGC_GPIE_PBA | IGC_GPIE_EIAME |
-				IGC_GPIE_NSICR);
+	E1000_WRITE_REG(hw, E1000_GPIE, E1000_GPIE_MSIX_MODE |
+				E1000_GPIE_PBA | E1000_GPIE_EIAME |
+				E1000_GPIE_NSICR);
 
 	nb_efd = rte_intr_nb_efd_get(intr_handle);
 	if (nb_efd < 0)
@@ -799,14 +799,14 @@ igc_configure_msix_intr(struct rte_eth_dev *dev)
 		intr_mask |= (1u << IGC_MSIX_OTHER_INTR_VEC);
 
 	/* enable msix auto-clear */
-	igc_read_reg_check_set_bits(hw, IGC_EIAC, intr_mask);
+	igc_read_reg_check_set_bits(hw, E1000_EIAC, intr_mask);
 
 	/* set other cause interrupt vector */
-	igc_read_reg_check_set_bits(hw, IGC_IVAR_MISC,
-		(uint32_t)(IGC_MSIX_OTHER_INTR_VEC | IGC_IVAR_VALID) << 8);
+	igc_read_reg_check_set_bits(hw, E1000_IVAR_MISC,
+		(uint32_t)(IGC_MSIX_OTHER_INTR_VEC | E1000_IVAR_VALID) << 8);
 
 	/* enable auto-mask */
-	igc_read_reg_check_set_bits(hw, IGC_EIAM, intr_mask);
+	igc_read_reg_check_set_bits(hw, E1000_EIAM, intr_mask);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		igc_write_ivar(hw, i, 0, vec);
@@ -815,7 +815,7 @@ igc_configure_msix_intr(struct rte_eth_dev *dev)
 			vec++;
 	}
 
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /**
@@ -832,9 +832,9 @@ igc_lsc_interrupt_setup(struct rte_eth_dev *dev, uint8_t on)
 	struct igc_interrupt *intr = IGC_DEV_PRIVATE_INTR(dev);
 
 	if (on)
-		intr->mask |= IGC_ICR_LSC;
+		intr->mask |= E1000_ICR_LSC;
 	else
-		intr->mask &= ~IGC_ICR_LSC;
+		intr->mask &= ~E1000_ICR_LSC;
 }
 
 /*
@@ -845,7 +845,7 @@ static void
 igc_rxq_interrupt_setup(struct rte_eth_dev *dev)
 {
 	uint32_t mask;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	int misc_shift = rte_intr_allow_others(intr_handle) ? 1 : 0;
@@ -862,16 +862,16 @@ igc_rxq_interrupt_setup(struct rte_eth_dev *dev)
 		return;
 
 	mask = RTE_LEN2MASK(nb_efd, uint32_t) << misc_shift;
-	IGC_WRITE_REG(hw, IGC_EIMS, mask);
+	E1000_WRITE_REG(hw, E1000_EIMS, mask);
 }
 
 /*
  *  Get hardware rx-buffer size.
  */
 static inline int
-igc_get_rx_buffer_size(struct igc_hw *hw)
+igc_get_rx_buffer_size(struct e1000_hw *hw)
 {
-	return (IGC_READ_REG(hw, IGC_RXPBS) & 0x3f) << 10;
+	return (E1000_READ_REG(hw, E1000_RXPBS) & 0x3f) << 10;
 }
 
 /*
@@ -880,13 +880,13 @@ igc_get_rx_buffer_size(struct igc_hw *hw)
  * that the driver is loaded.
  */
 static void
-igc_hw_control_acquire(struct igc_hw *hw)
+igc_hw_control_acquire(struct e1000_hw *hw)
 {
 	uint32_t ctrl_ext;
 
 	/* Let firmware know the driver has taken over */
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext | IGC_CTRL_EXT_DRV_LOAD);
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext | E1000_CTRL_EXT_DRV_LOAD);
 }
 
 /*
@@ -895,18 +895,18 @@ igc_hw_control_acquire(struct igc_hw *hw)
  * driver is no longer loaded.
  */
 static void
-igc_hw_control_release(struct igc_hw *hw)
+igc_hw_control_release(struct e1000_hw *hw)
 {
 	uint32_t ctrl_ext;
 
 	/* Let firmware taken over control of h/w */
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT,
-			ctrl_ext & ~IGC_CTRL_EXT_DRV_LOAD);
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT,
+			ctrl_ext & ~E1000_CTRL_EXT_DRV_LOAD);
 }
 
 static int
-igc_hardware_init(struct igc_hw *hw)
+igc_hardware_init(struct e1000_hw *hw)
 {
 	uint32_t rx_buf_size;
 	int diag;
@@ -915,10 +915,10 @@ igc_hardware_init(struct igc_hw *hw)
 	igc_hw_control_acquire(hw);
 
 	/* Issue a global reset */
-	igc_reset_hw(hw);
+	e1000_reset_hw(hw);
 
 	/* disable all wake up */
-	IGC_WRITE_REG(hw, IGC_WUC, 0);
+	E1000_WRITE_REG(hw, E1000_WUC, 0);
 
 	/*
 	 * Hardware flow control
@@ -937,14 +937,14 @@ igc_hardware_init(struct igc_hw *hw)
 	hw->fc.low_water = hw->fc.high_water - 1500;
 	hw->fc.pause_time = IGC_FC_PAUSE_TIME;
 	hw->fc.send_xon = 1;
-	hw->fc.requested_mode = igc_fc_full;
+	hw->fc.requested_mode = e1000_fc_full;
 
-	diag = igc_init_hw(hw);
+	diag = e1000_init_hw(hw);
 	if (diag < 0)
 		return diag;
 
-	igc_get_phy_info(hw);
-	igc_check_for_link(hw);
+	e1000_get_phy_info(hw);
+	e1000_check_for_link(hw);
 
 	return 0;
 }
@@ -952,7 +952,7 @@ igc_hardware_init(struct igc_hw *hw)
 static int
 eth_igc_start(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
@@ -967,11 +967,11 @@ eth_igc_start(struct rte_eth_dev *dev)
 	PMD_INIT_FUNC_TRACE();
 
 	/* disable all MSI-X interrupts */
-	IGC_WRITE_REG(hw, IGC_EIMC, 0x1f);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_EIMC, 0x1f);
+	E1000_WRITE_FLUSH(hw);
 
 	/* clear all MSI-X interrupts */
-	IGC_WRITE_REG(hw, IGC_EICR, 0x1f);
+	E1000_WRITE_REG(hw, E1000_EICR, 0x1f);
 
 	/* disable uio/vfio intr/eventfd mapping */
 	if (!adapter->stopped)
@@ -981,7 +981,7 @@ eth_igc_start(struct rte_eth_dev *dev)
 	eth_igc_set_link_up(dev);
 
 	/* Put the address into the Receive Address Array */
-	igc_rar_set(hw, hw->mac.addr, 0);
+	e1000_rar_set(hw, hw->mac.addr, 0);
 
 	/* Initialize the hardware */
 	if (igc_hardware_init(hw)) {
@@ -1025,36 +1025,36 @@ eth_igc_start(struct rte_eth_dev *dev)
 		adapter->base_time = 0;
 		adapter->cycle_time = NSEC_PER_SEC;
 
-		IGC_WRITE_REG(hw, IGC_TSSDP, 0);
-		IGC_WRITE_REG(hw, IGC_TSIM, TSINTR_TXTS);
-		IGC_WRITE_REG(hw, IGC_IMS, IGC_ICR_TS);
+		E1000_WRITE_REG(hw, E1000_TSSDP, 0);
+		E1000_WRITE_REG(hw, E1000_TSIM, TSINTR_TXTS);
+		E1000_WRITE_REG(hw, E1000_IMS, E1000_ICR_TS);
 
-		IGC_WRITE_REG(hw, IGC_TSAUXC, 0);
-		IGC_WRITE_REG(hw, IGC_I350_DTXMXPKTSZ, IGC_DTXMXPKTSZ_TSN);
-		IGC_WRITE_REG(hw, IGC_TXPBS, IGC_TXPBSIZE_TSN);
+		E1000_WRITE_REG(hw, E1000_TSAUXC, 0);
+		E1000_WRITE_REG(hw, E1000_I350_DTXMXPKTSZ, E1000_DTXMXPKTSZ_TSN);
+		E1000_WRITE_REG(hw, E1000_TXPBS, E1000_TXPBSIZE_TSN);
 
-		tqavctrl = IGC_READ_REG(hw, IGC_I210_TQAVCTRL);
-		tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
-			    IGC_TQAVCTRL_ENHANCED_QAV;
-		IGC_WRITE_REG(hw, IGC_I210_TQAVCTRL, tqavctrl);
+		tqavctrl = E1000_READ_REG(hw, E1000_I210_TQAVCTRL);
+		tqavctrl |= E1000_TQAVCTRL_TRANSMIT_MODE_TSN |
+			    E1000_TQAVCTRL_ENHANCED_QAV;
+		E1000_WRITE_REG(hw, E1000_I210_TQAVCTRL, tqavctrl);
 
-		IGC_WRITE_REG(hw, IGC_QBVCYCLET_S, adapter->cycle_time);
-		IGC_WRITE_REG(hw, IGC_QBVCYCLET, adapter->cycle_time);
+		E1000_WRITE_REG(hw, E1000_QBVCYCLET_S, adapter->cycle_time);
+		E1000_WRITE_REG(hw, E1000_QBVCYCLET, adapter->cycle_time);
 
 		for (i = 0; i < dev->data->nb_tx_queues; i++) {
-			IGC_WRITE_REG(hw, IGC_STQT(i), 0);
-			IGC_WRITE_REG(hw, IGC_ENDQT(i), NSEC_PER_SEC);
+			E1000_WRITE_REG(hw, E1000_STQT(i), 0);
+			E1000_WRITE_REG(hw, E1000_ENDQT(i), NSEC_PER_SEC);
 
-			txqctl |= IGC_TXQCTL_QUEUE_MODE_LAUNCHT;
-			IGC_WRITE_REG(hw, IGC_TXQCTL(i), txqctl);
+			txqctl |= E1000_TXQCTL_QUEUE_MODE_LAUNCHT;
+			E1000_WRITE_REG(hw, E1000_TXQCTL(i), txqctl);
 		}
 
 		clock_gettime(CLOCK_REALTIME, &system_time);
-		IGC_WRITE_REG(hw, IGC_SYSTIML, system_time.tv_nsec);
-		IGC_WRITE_REG(hw, IGC_SYSTIMH, system_time.tv_sec);
+		E1000_WRITE_REG(hw, E1000_SYSTIML, system_time.tv_nsec);
+		E1000_WRITE_REG(hw, E1000_SYSTIMH, system_time.tv_sec);
 
-		nsec = IGC_READ_REG(hw, IGC_SYSTIML);
-		sec = IGC_READ_REG(hw, IGC_SYSTIMH);
+		nsec = E1000_READ_REG(hw, E1000_SYSTIML);
+		sec = E1000_READ_REG(hw, E1000_SYSTIMH);
 		systime = (int64_t)sec * NSEC_PER_SEC + (int64_t)nsec;
 
 		if (systime > adapter->base_time) {
@@ -1066,11 +1066,11 @@ eth_igc_start(struct rte_eth_dev *dev)
 
 		baset_h = adapter->base_time / NSEC_PER_SEC;
 		baset_l = adapter->base_time % NSEC_PER_SEC;
-		IGC_WRITE_REG(hw, IGC_BASET_H, baset_h);
-		IGC_WRITE_REG(hw, IGC_BASET_L, baset_l);
+		E1000_WRITE_REG(hw, E1000_BASET_H, baset_h);
+		E1000_WRITE_REG(hw, E1000_BASET_L, baset_l);
 	}
 
-	igc_clear_hw_cntrs_base_generic(hw);
+	e1000_clear_hw_cntrs_base_generic(hw);
 
 	/* VLAN Offload Settings */
 	eth_igc_vlan_offload_set(dev,
@@ -1080,7 +1080,7 @@ eth_igc_start(struct rte_eth_dev *dev)
 	/* Setup link speed and duplex */
 	speeds = &dev->data->dev_conf.link_speeds;
 	if (*speeds == RTE_ETH_LINK_SPEED_AUTONEG) {
-		hw->phy.autoneg_advertised = IGC_ALL_SPEED_DUPLEX_2500;
+		hw->phy.autoneg_advertised = E1000_ALL_SPEED_DUPLEX_2500;
 		hw->mac.autoneg = 1;
 	} else {
 		int num_speeds = 0;
@@ -1129,7 +1129,7 @@ eth_igc_start(struct rte_eth_dev *dev)
 			goto error_invalid_config;
 	}
 
-	igc_setup_link(hw);
+	e1000_setup_link(hw);
 
 	if (rte_intr_allow_others(intr_handle)) {
 		/* check if lsc interrupt is enabled */
@@ -1167,13 +1167,13 @@ eth_igc_start(struct rte_eth_dev *dev)
 	if (dev->data->dev_conf.lpbk_mode == 1) {
 		uint32_t reg_val;
 
-		reg_val = IGC_READ_REG(hw, IGC_CTRL);
+		reg_val = E1000_READ_REG(hw, E1000_CTRL);
 		reg_val &= ~IGC_CTRL_SPEED_MASK;
-		reg_val |= IGC_CTRL_SLU | IGC_CTRL_FRCSPD |
-			IGC_CTRL_FRCDPX | IGC_CTRL_FD | IGC_CTRL_SPEED_2500;
-		IGC_WRITE_REG(hw, IGC_CTRL, reg_val);
+		reg_val |= E1000_CTRL_SLU | E1000_CTRL_FRCSPD |
+			E1000_CTRL_FRCDPX | E1000_CTRL_FD | IGC_CTRL_SPEED_2500;
+		E1000_WRITE_REG(hw, E1000_CTRL, reg_val);
 
-		igc_read_reg_check_set_bits(hw, IGC_EEER, IGC_EEER_EEE_FRC_AN);
+		igc_read_reg_check_set_bits(hw, E1000_EEER, IGC_EEER_EEE_FRC_AN);
 	}
 
 	return 0;
@@ -1186,7 +1186,7 @@ eth_igc_start(struct rte_eth_dev *dev)
 }
 
 static int
-igc_reset_swfw_lock(struct igc_hw *hw)
+igc_reset_swfw_lock(struct e1000_hw *hw)
 {
 	int ret_val;
 
@@ -1194,7 +1194,7 @@ igc_reset_swfw_lock(struct igc_hw *hw)
 	 * Do mac ops initialization manually here, since we will need
 	 * some function pointers set by this call.
 	 */
-	ret_val = igc_init_mac_params(hw);
+	ret_val = e1000_init_mac_params(hw);
 	if (ret_val)
 		return ret_val;
 
@@ -1203,10 +1203,10 @@ igc_reset_swfw_lock(struct igc_hw *hw)
 	 * it is due to an improper exit of the application.
 	 * So force the release of the faulty lock.
 	 */
-	if (igc_get_hw_semaphore_generic(hw) < 0)
+	if (e1000_get_hw_semaphore_generic(hw) < 0)
 		PMD_DRV_LOG(DEBUG, "SMBI lock released");
 
-	igc_put_hw_semaphore_generic(hw);
+	e1000_put_hw_semaphore_generic(hw);
 
 	if (hw->mac.ops.acquire_swfw_sync != NULL) {
 		uint16_t mask;
@@ -1216,7 +1216,7 @@ igc_reset_swfw_lock(struct igc_hw *hw)
 		 * If this is the case, it is due to an improper exit of the
 		 * application. So force the release of the faulty lock.
 		 */
-		mask = IGC_SWFW_PHY0_SM;
+		mask = E1000_SWFW_PHY0_SM;
 		if (hw->mac.ops.acquire_swfw_sync(hw, mask) < 0) {
 			PMD_DRV_LOG(DEBUG, "SWFW phy%d lock released",
 				    hw->bus.func);
@@ -1229,14 +1229,14 @@ igc_reset_swfw_lock(struct igc_hw *hw)
 		 * that if lock can not be taken it is due to an improper lock
 		 * of the semaphore.
 		 */
-		mask = IGC_SWFW_EEP_SM;
+		mask = E1000_SWFW_EEP_SM;
 		if (hw->mac.ops.acquire_swfw_sync(hw, mask) < 0)
 			PMD_DRV_LOG(DEBUG, "SWFW common locks released");
 
 		hw->mac.ops.release_swfw_sync(hw, mask);
 	}
 
-	return IGC_SUCCESS;
+	return E1000_SUCCESS;
 }
 
 /*
@@ -1265,7 +1265,7 @@ eth_igc_close(struct rte_eth_dev *dev)
 {
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *adapter = IGC_DEV_PRIVATE(dev);
 	int retry = 0;
 	int ret = 0;
@@ -1291,7 +1291,7 @@ eth_igc_close(struct rte_eth_dev *dev)
 		DELAY(200 * 1000); /* delay 200ms */
 	} while (retry++ < 5);
 
-	igc_phy_hw_reset(hw);
+	e1000_phy_hw_reset(hw);
 	igc_hw_control_release(hw);
 	igc_dev_free_queues(dev);
 
@@ -1304,7 +1304,7 @@ eth_igc_close(struct rte_eth_dev *dev)
 static void
 igc_identify_hardware(struct rte_eth_dev *dev, struct rte_pci_device *pci_dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
 	hw->vendor_id = pci_dev->id.vendor_id;
 	hw->device_id = pci_dev->id.device_id;
@@ -1317,7 +1317,7 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 {
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	int i, error = 0;
 
 	PMD_INIT_FUNC_TRACE();
@@ -1348,50 +1348,50 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 	hw->hw_addr = (void *)pci_dev->mem_resource[0].addr;
 
 	igc_identify_hardware(dev, pci_dev);
-	if (igc_setup_init_funcs(hw, false) != IGC_SUCCESS) {
+	if (e1000_setup_init_funcs(hw, false) != E1000_SUCCESS) {
 		error = -EIO;
 		goto err_late;
 	}
 
-	igc_get_bus_info(hw);
+	e1000_get_bus_info(hw);
 
 	/* Reset any pending lock */
-	if (igc_reset_swfw_lock(hw) != IGC_SUCCESS) {
+	if (igc_reset_swfw_lock(hw) != E1000_SUCCESS) {
 		error = -EIO;
 		goto err_late;
 	}
 
 	/* Finish initialization */
-	if (igc_setup_init_funcs(hw, true) != IGC_SUCCESS) {
+	if (e1000_setup_init_funcs(hw, true) != E1000_SUCCESS) {
 		error = -EIO;
 		goto err_late;
 	}
 
 	hw->mac.autoneg = 1;
 	hw->phy.autoneg_wait_to_complete = 0;
-	hw->phy.autoneg_advertised = IGC_ALL_SPEED_DUPLEX_2500;
+	hw->phy.autoneg_advertised = E1000_ALL_SPEED_DUPLEX_2500;
 
 	/* Copper options */
-	if (hw->phy.media_type == igc_media_type_copper) {
+	if (hw->phy.media_type == e1000_media_type_copper) {
 		hw->phy.mdix = 0; /* AUTO_ALL_MODES */
 		hw->phy.disable_polarity_correction = 0;
-		hw->phy.ms_type = igc_ms_hw_default;
+		hw->phy.ms_type = e1000_ms_hw_default;
 	}
 
 	/*
 	 * Start from a known state, this is important in reading the nvm
 	 * and mac from that.
 	 */
-	igc_reset_hw(hw);
+	e1000_reset_hw(hw);
 
 	/* Make sure we have a good EEPROM before we read from it */
-	if (igc_validate_nvm_checksum(hw) < 0) {
+	if (e1000_validate_nvm_checksum(hw) < 0) {
 		/*
 		 * Some PCI-E parts fail the first check due to
 		 * the link being in sleep state, call it again,
 		 * if it fails a second time its a real issue.
 		 */
-		if (igc_validate_nvm_checksum(hw) < 0) {
+		if (e1000_validate_nvm_checksum(hw) < 0) {
 			PMD_INIT_LOG(ERR, "EEPROM checksum invalid");
 			error = -EIO;
 			goto err_late;
@@ -1399,7 +1399,7 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 	}
 
 	/* Read the permanent MAC address out of the EEPROM */
-	if (igc_read_mac_addr(hw) != 0) {
+	if (e1000_read_mac_addr(hw) != 0) {
 		PMD_INIT_LOG(ERR, "EEPROM error while reading MAC address");
 		error = -EIO;
 		goto err_late;
@@ -1432,7 +1432,7 @@ eth_igc_dev_init(struct rte_eth_dev *dev)
 	igc->stopped = 0;
 
 	/* Indicate SOL/IDER usage */
-	if (igc_check_reset_block(hw) < 0)
+	if (e1000_check_reset_block(hw) < 0)
 		PMD_INIT_LOG(ERR,
 			"PHY reset is blocked due to SOL/IDER session.");
 
@@ -1489,55 +1489,55 @@ eth_igc_reset(struct rte_eth_dev *dev)
 static int
 eth_igc_promiscuous_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rctl;
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	rctl |= (IGC_RCTL_UPE | IGC_RCTL_MPE);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	rctl |= (E1000_RCTL_UPE | E1000_RCTL_MPE);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 	return 0;
 }
 
 static int
 eth_igc_promiscuous_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rctl;
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	rctl &= (~IGC_RCTL_UPE);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	rctl &= (~E1000_RCTL_UPE);
 	if (dev->data->all_multicast == 1)
-		rctl |= IGC_RCTL_MPE;
+		rctl |= E1000_RCTL_MPE;
 	else
-		rctl &= (~IGC_RCTL_MPE);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+		rctl &= (~E1000_RCTL_MPE);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 	return 0;
 }
 
 static int
 eth_igc_allmulticast_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rctl;
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	rctl |= IGC_RCTL_MPE;
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	rctl |= E1000_RCTL_MPE;
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 	return 0;
 }
 
 static int
 eth_igc_allmulticast_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rctl;
 
 	if (dev->data->promiscuous == 1)
 		return 0;	/* must remain in all_multicast mode */
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	rctl &= (~IGC_RCTL_MPE);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	rctl &= (~E1000_RCTL_MPE);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 	return 0;
 }
 
@@ -1545,11 +1545,11 @@ static int
 eth_igc_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 		       size_t fw_size)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_fw_version fw;
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_fw_version fw;
 	int ret;
 
-	igc_get_fw_version(hw, &fw);
+	e1000_get_fw_version(hw, &fw);
 
 	/* if option rom is valid, display its version too */
 	if (fw.or_valid) {
@@ -1584,7 +1584,7 @@ eth_igc_fw_version_get(struct rte_eth_dev *dev, char *fw_version,
 static int
 eth_igc_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
 	dev_info->min_rx_bufsize = 256; /* See BSIZE field of RCTL register. */
 	dev_info->max_rx_pktlen = MAX_RX_JUMBO_FRAME_SIZE;
@@ -1637,17 +1637,17 @@ eth_igc_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 static int
 eth_igc_led_on(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	return igc_led_on(hw) == IGC_SUCCESS ? 0 : -ENOTSUP;
+	return e1000_led_on(hw) == E1000_SUCCESS ? 0 : -ENOTSUP;
 }
 
 static int
 eth_igc_led_off(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	return igc_led_off(hw) == IGC_SUCCESS ? 0 : -ENOTSUP;
+	return e1000_led_off(hw) == E1000_SUCCESS ? 0 : -ENOTSUP;
 }
 
 static const uint32_t *
@@ -1678,12 +1678,12 @@ eth_igc_supported_ptypes_get(__rte_unused struct rte_eth_dev *dev,
 static int
 eth_igc_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t frame_size = mtu + IGC_ETH_OVERHEAD;
 	uint32_t rctl;
 
 	/* if extend vlan has been enabled */
-	if (IGC_READ_REG(hw, IGC_CTRL_EXT) & IGC_CTRL_EXT_EXT_VLAN)
+	if (E1000_READ_REG(hw, E1000_CTRL_EXT) & IGC_CTRL_EXT_EXT_VLAN)
 		frame_size += VLAN_TAG_SIZE;
 
 	/*
@@ -1696,14 +1696,14 @@ eth_igc_mtu_set(struct rte_eth_dev *dev, uint16_t mtu)
 		return -EINVAL;
 	}
 
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
 	if (mtu > RTE_ETHER_MTU)
-		rctl |= IGC_RCTL_LPE;
+		rctl |= E1000_RCTL_LPE;
 	else
-		rctl &= ~IGC_RCTL_LPE;
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+		rctl &= ~E1000_RCTL_LPE;
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 
-	IGC_WRITE_REG(hw, IGC_RLPML, frame_size);
+	E1000_WRITE_REG(hw, E1000_RLPML, frame_size);
 
 	return 0;
 }
@@ -1712,9 +1712,9 @@ static int
 eth_igc_rar_set(struct rte_eth_dev *dev, struct rte_ether_addr *mac_addr,
 		uint32_t index, uint32_t pool)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	igc_rar_set(hw, mac_addr->addr_bytes, index);
+	e1000_rar_set(hw, mac_addr->addr_bytes, index);
 	RTE_SET_USED(pool);
 	return 0;
 }
@@ -1723,18 +1723,18 @@ static void
 eth_igc_rar_clear(struct rte_eth_dev *dev, uint32_t index)
 {
 	uint8_t addr[RTE_ETHER_ADDR_LEN];
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
 	memset(addr, 0, sizeof(addr));
-	igc_rar_set(hw, addr, index);
+	e1000_rar_set(hw, addr, index);
 }
 
 static int
 eth_igc_default_mac_addr_set(struct rte_eth_dev *dev,
 			struct rte_ether_addr *addr)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	igc_rar_set(hw, addr->addr_bytes, 0);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	e1000_rar_set(hw, addr->addr_bytes, 0);
 	return 0;
 }
 
@@ -1743,8 +1743,8 @@ eth_igc_set_mc_addr_list(struct rte_eth_dev *dev,
 			 struct rte_ether_addr *mc_addr_set,
 			 uint32_t nb_mc_addr)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	igc_update_mc_addr_list(hw, (u8 *)mc_addr_set, nb_mc_addr);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	e1000_update_mc_addr_list(hw, (u8 *)mc_addr_set, nb_mc_addr);
 	return 0;
 }
 
@@ -1752,7 +1752,7 @@ eth_igc_set_mc_addr_list(struct rte_eth_dev *dev,
  * Read hardware registers
  */
 static void
-igc_read_stats_registers(struct igc_hw *hw, struct igc_hw_stats *stats)
+igc_read_stats_registers(struct e1000_hw *hw, struct e1000_hw_stats *stats)
 {
 	int pause_frames;
 
@@ -1763,119 +1763,119 @@ igc_read_stats_registers(struct igc_hw *hw, struct igc_hw_stats *stats)
 	uint64_t old_rpthc = stats->rpthc;
 	uint64_t old_hgptc = stats->hgptc;
 
-	stats->crcerrs += IGC_READ_REG(hw, IGC_CRCERRS);
-	stats->algnerrc += IGC_READ_REG(hw, IGC_ALGNERRC);
-	stats->rxerrc += IGC_READ_REG(hw, IGC_RXERRC);
-	stats->mpc += IGC_READ_REG(hw, IGC_MPC);
-	stats->scc += IGC_READ_REG(hw, IGC_SCC);
-	stats->ecol += IGC_READ_REG(hw, IGC_ECOL);
+	stats->crcerrs += E1000_READ_REG(hw, E1000_CRCERRS);
+	stats->algnerrc += E1000_READ_REG(hw, E1000_ALGNERRC);
+	stats->rxerrc += E1000_READ_REG(hw, E1000_RXERRC);
+	stats->mpc += E1000_READ_REG(hw, E1000_MPC);
+	stats->scc += E1000_READ_REG(hw, E1000_SCC);
+	stats->ecol += E1000_READ_REG(hw, E1000_ECOL);
 
-	stats->mcc += IGC_READ_REG(hw, IGC_MCC);
-	stats->latecol += IGC_READ_REG(hw, IGC_LATECOL);
-	stats->colc += IGC_READ_REG(hw, IGC_COLC);
+	stats->mcc += E1000_READ_REG(hw, E1000_MCC);
+	stats->latecol += E1000_READ_REG(hw, E1000_LATECOL);
+	stats->colc += E1000_READ_REG(hw, E1000_COLC);
 
-	stats->dc += IGC_READ_REG(hw, IGC_DC);
-	stats->tncrs += IGC_READ_REG(hw, IGC_TNCRS);
-	stats->htdpmc += IGC_READ_REG(hw, IGC_HTDPMC);
-	stats->rlec += IGC_READ_REG(hw, IGC_RLEC);
-	stats->xonrxc += IGC_READ_REG(hw, IGC_XONRXC);
-	stats->xontxc += IGC_READ_REG(hw, IGC_XONTXC);
+	stats->dc += E1000_READ_REG(hw, E1000_DC);
+	stats->tncrs += E1000_READ_REG(hw, E1000_TNCRS);
+	stats->htdpmc += E1000_READ_REG(hw, E1000_HTDPMC);
+	stats->rlec += E1000_READ_REG(hw, E1000_RLEC);
+	stats->xonrxc += E1000_READ_REG(hw, E1000_XONRXC);
+	stats->xontxc += E1000_READ_REG(hw, E1000_XONTXC);
 
 	/*
 	 * For watchdog management we need to know if we have been
 	 * paused during the last interval, so capture that here.
 	 */
-	pause_frames = IGC_READ_REG(hw, IGC_XOFFRXC);
+	pause_frames = E1000_READ_REG(hw, E1000_XOFFRXC);
 	stats->xoffrxc += pause_frames;
-	stats->xofftxc += IGC_READ_REG(hw, IGC_XOFFTXC);
-	stats->fcruc += IGC_READ_REG(hw, IGC_FCRUC);
-	stats->prc64 += IGC_READ_REG(hw, IGC_PRC64);
-	stats->prc127 += IGC_READ_REG(hw, IGC_PRC127);
-	stats->prc255 += IGC_READ_REG(hw, IGC_PRC255);
-	stats->prc511 += IGC_READ_REG(hw, IGC_PRC511);
-	stats->prc1023 += IGC_READ_REG(hw, IGC_PRC1023);
-	stats->prc1522 += IGC_READ_REG(hw, IGC_PRC1522);
-	stats->gprc += IGC_READ_REG(hw, IGC_GPRC);
-	stats->bprc += IGC_READ_REG(hw, IGC_BPRC);
-	stats->mprc += IGC_READ_REG(hw, IGC_MPRC);
-	stats->gptc += IGC_READ_REG(hw, IGC_GPTC);
+	stats->xofftxc += E1000_READ_REG(hw, E1000_XOFFTXC);
+	stats->fcruc += E1000_READ_REG(hw, E1000_FCRUC);
+	stats->prc64 += E1000_READ_REG(hw, E1000_PRC64);
+	stats->prc127 += E1000_READ_REG(hw, E1000_PRC127);
+	stats->prc255 += E1000_READ_REG(hw, E1000_PRC255);
+	stats->prc511 += E1000_READ_REG(hw, E1000_PRC511);
+	stats->prc1023 += E1000_READ_REG(hw, E1000_PRC1023);
+	stats->prc1522 += E1000_READ_REG(hw, E1000_PRC1522);
+	stats->gprc += E1000_READ_REG(hw, E1000_GPRC);
+	stats->bprc += E1000_READ_REG(hw, E1000_BPRC);
+	stats->mprc += E1000_READ_REG(hw, E1000_MPRC);
+	stats->gptc += E1000_READ_REG(hw, E1000_GPTC);
 
 	/* For the 64-bit byte counters the low dword must be read first. */
 	/* Both registers clear on the read of the high dword */
 
 	/* Workaround CRC bytes included in size, take away 4 bytes/packet */
-	stats->gorc += IGC_READ_REG(hw, IGC_GORCL);
-	stats->gorc += ((uint64_t)IGC_READ_REG(hw, IGC_GORCH) << 32);
+	stats->gorc += E1000_READ_REG(hw, E1000_GORCL);
+	stats->gorc += ((uint64_t)E1000_READ_REG(hw, E1000_GORCH) << 32);
 	stats->gorc -= (stats->gprc - old_gprc) * RTE_ETHER_CRC_LEN;
-	stats->gotc += IGC_READ_REG(hw, IGC_GOTCL);
-	stats->gotc += ((uint64_t)IGC_READ_REG(hw, IGC_GOTCH) << 32);
+	stats->gotc += E1000_READ_REG(hw, E1000_GOTCL);
+	stats->gotc += ((uint64_t)E1000_READ_REG(hw, E1000_GOTCH) << 32);
 	stats->gotc -= (stats->gptc - old_gptc) * RTE_ETHER_CRC_LEN;
 
-	stats->rnbc += IGC_READ_REG(hw, IGC_RNBC);
-	stats->ruc += IGC_READ_REG(hw, IGC_RUC);
-	stats->rfc += IGC_READ_REG(hw, IGC_RFC);
-	stats->roc += IGC_READ_REG(hw, IGC_ROC);
-	stats->rjc += IGC_READ_REG(hw, IGC_RJC);
+	stats->rnbc += E1000_READ_REG(hw, E1000_RNBC);
+	stats->ruc += E1000_READ_REG(hw, E1000_RUC);
+	stats->rfc += E1000_READ_REG(hw, E1000_RFC);
+	stats->roc += E1000_READ_REG(hw, E1000_ROC);
+	stats->rjc += E1000_READ_REG(hw, E1000_RJC);
 
-	stats->mgprc += IGC_READ_REG(hw, IGC_MGTPRC);
-	stats->mgpdc += IGC_READ_REG(hw, IGC_MGTPDC);
-	stats->mgptc += IGC_READ_REG(hw, IGC_MGTPTC);
-	stats->b2ospc += IGC_READ_REG(hw, IGC_B2OSPC);
-	stats->b2ogprc += IGC_READ_REG(hw, IGC_B2OGPRC);
-	stats->o2bgptc += IGC_READ_REG(hw, IGC_O2BGPTC);
-	stats->o2bspc += IGC_READ_REG(hw, IGC_O2BSPC);
+	stats->mgprc += E1000_READ_REG(hw, E1000_MGTPRC);
+	stats->mgpdc += E1000_READ_REG(hw, E1000_MGTPDC);
+	stats->mgptc += E1000_READ_REG(hw, E1000_MGTPTC);
+	stats->b2ospc += E1000_READ_REG(hw, E1000_B2OSPC);
+	stats->b2ogprc += E1000_READ_REG(hw, E1000_B2OGPRC);
+	stats->o2bgptc += E1000_READ_REG(hw, E1000_O2BGPTC);
+	stats->o2bspc += E1000_READ_REG(hw, E1000_O2BSPC);
 
-	stats->tpr += IGC_READ_REG(hw, IGC_TPR);
-	stats->tpt += IGC_READ_REG(hw, IGC_TPT);
+	stats->tpr += E1000_READ_REG(hw, E1000_TPR);
+	stats->tpt += E1000_READ_REG(hw, E1000_TPT);
 
-	stats->tor += IGC_READ_REG(hw, IGC_TORL);
-	stats->tor += ((uint64_t)IGC_READ_REG(hw, IGC_TORH) << 32);
+	stats->tor += E1000_READ_REG(hw, E1000_TORL);
+	stats->tor += ((uint64_t)E1000_READ_REG(hw, E1000_TORH) << 32);
 	stats->tor -= (stats->tpr - old_tpr) * RTE_ETHER_CRC_LEN;
-	stats->tot += IGC_READ_REG(hw, IGC_TOTL);
-	stats->tot += ((uint64_t)IGC_READ_REG(hw, IGC_TOTH) << 32);
+	stats->tot += E1000_READ_REG(hw, E1000_TOTL);
+	stats->tot += ((uint64_t)E1000_READ_REG(hw, E1000_TOTH) << 32);
 	stats->tot -= (stats->tpt - old_tpt) * RTE_ETHER_CRC_LEN;
 
-	stats->ptc64 += IGC_READ_REG(hw, IGC_PTC64);
-	stats->ptc127 += IGC_READ_REG(hw, IGC_PTC127);
-	stats->ptc255 += IGC_READ_REG(hw, IGC_PTC255);
-	stats->ptc511 += IGC_READ_REG(hw, IGC_PTC511);
-	stats->ptc1023 += IGC_READ_REG(hw, IGC_PTC1023);
-	stats->ptc1522 += IGC_READ_REG(hw, IGC_PTC1522);
-	stats->mptc += IGC_READ_REG(hw, IGC_MPTC);
-	stats->bptc += IGC_READ_REG(hw, IGC_BPTC);
-	stats->tsctc += IGC_READ_REG(hw, IGC_TSCTC);
+	stats->ptc64 += E1000_READ_REG(hw, E1000_PTC64);
+	stats->ptc127 += E1000_READ_REG(hw, E1000_PTC127);
+	stats->ptc255 += E1000_READ_REG(hw, E1000_PTC255);
+	stats->ptc511 += E1000_READ_REG(hw, E1000_PTC511);
+	stats->ptc1023 += E1000_READ_REG(hw, E1000_PTC1023);
+	stats->ptc1522 += E1000_READ_REG(hw, E1000_PTC1522);
+	stats->mptc += E1000_READ_REG(hw, E1000_MPTC);
+	stats->bptc += E1000_READ_REG(hw, E1000_BPTC);
+	stats->tsctc += E1000_READ_REG(hw, E1000_TSCTC);
 
-	stats->iac += IGC_READ_REG(hw, IGC_IAC);
-	stats->rpthc += IGC_READ_REG(hw, IGC_RPTHC);
-	stats->hgptc += IGC_READ_REG(hw, IGC_HGPTC);
-	stats->icrxdmtc += IGC_READ_REG(hw, IGC_ICRXDMTC);
+	stats->iac += E1000_READ_REG(hw, E1000_IAC);
+	stats->rpthc += E1000_READ_REG(hw, E1000_RPTHC);
+	stats->hgptc += E1000_READ_REG(hw, E1000_HGPTC);
+	stats->icrxdmtc += E1000_READ_REG(hw, E1000_ICRXDMTC);
 
 	/* Host to Card Statistics */
-	stats->hgorc += IGC_READ_REG(hw, IGC_HGORCL);
-	stats->hgorc += ((uint64_t)IGC_READ_REG(hw, IGC_HGORCH) << 32);
+	stats->hgorc += E1000_READ_REG(hw, E1000_HGORCL);
+	stats->hgorc += ((uint64_t)E1000_READ_REG(hw, E1000_HGORCH) << 32);
 	stats->hgorc -= (stats->rpthc - old_rpthc) * RTE_ETHER_CRC_LEN;
-	stats->hgotc += IGC_READ_REG(hw, IGC_HGOTCL);
-	stats->hgotc += ((uint64_t)IGC_READ_REG(hw, IGC_HGOTCH) << 32);
+	stats->hgotc += E1000_READ_REG(hw, E1000_HGOTCL);
+	stats->hgotc += ((uint64_t)E1000_READ_REG(hw, E1000_HGOTCH) << 32);
 	stats->hgotc -= (stats->hgptc - old_hgptc) * RTE_ETHER_CRC_LEN;
-	stats->lenerrs += IGC_READ_REG(hw, IGC_LENERRS);
+	stats->lenerrs += E1000_READ_REG(hw, E1000_LENERRS);
 }
 
 /*
  * Write 0 to all queue status registers
  */
 static void
-igc_reset_queue_stats_register(struct igc_hw *hw)
+igc_reset_queue_stats_register(struct e1000_hw *hw)
 {
 	int i;
 
 	for (i = 0; i < IGC_QUEUE_PAIRS_NUM; i++) {
-		IGC_WRITE_REG(hw, IGC_PQGPRC(i), 0);
-		IGC_WRITE_REG(hw, IGC_PQGPTC(i), 0);
-		IGC_WRITE_REG(hw, IGC_PQGORC(i), 0);
-		IGC_WRITE_REG(hw, IGC_PQGOTC(i), 0);
-		IGC_WRITE_REG(hw, IGC_PQMPRC(i), 0);
-		IGC_WRITE_REG(hw, IGC_RQDPC(i), 0);
-		IGC_WRITE_REG(hw, IGC_TQDPC(i), 0);
+		E1000_WRITE_REG(hw, IGC_PQGPRC(i), 0);
+		E1000_WRITE_REG(hw, E1000_PQGPTC(i), 0);
+		E1000_WRITE_REG(hw, IGC_PQGORC(i), 0);
+		E1000_WRITE_REG(hw, IGC_PQGOTC(i), 0);
+		E1000_WRITE_REG(hw, IGC_PQMPRC(i), 0);
+		E1000_WRITE_REG(hw, E1000_RQDPC(i), 0);
+		E1000_WRITE_REG(hw, IGC_TQDPC(i), 0);
 	}
 }
 
@@ -1885,7 +1885,7 @@ igc_reset_queue_stats_register(struct igc_hw *hw)
 static void
 igc_read_queue_stats_register(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_hw_queue_stats *queue_stats =
 				IGC_DEV_PRIVATE_QUEUE_STATS(dev);
 	int i;
@@ -1908,49 +1908,49 @@ igc_read_queue_stats_register(struct rte_eth_dev *dev)
 		 * then we add the high 4 bytes by 1 and replace the low 4
 		 * bytes by the new value.
 		 */
-		tmp = IGC_READ_REG(hw, IGC_PQGPRC(i));
+		tmp = E1000_READ_REG(hw, IGC_PQGPRC(i));
 		value.ddword = queue_stats->pqgprc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqgprc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_PQGPTC(i));
+		tmp = E1000_READ_REG(hw, E1000_PQGPTC(i));
 		value.ddword = queue_stats->pqgptc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqgptc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_PQGORC(i));
+		tmp = E1000_READ_REG(hw, IGC_PQGORC(i));
 		value.ddword = queue_stats->pqgorc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqgorc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_PQGOTC(i));
+		tmp = E1000_READ_REG(hw, IGC_PQGOTC(i));
 		value.ddword = queue_stats->pqgotc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqgotc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_PQMPRC(i));
+		tmp = E1000_READ_REG(hw, IGC_PQMPRC(i));
 		value.ddword = queue_stats->pqmprc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->pqmprc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_RQDPC(i));
+		tmp = E1000_READ_REG(hw, E1000_RQDPC(i));
 		value.ddword = queue_stats->rqdpc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
 		value.dword[U32_0_IN_U64] = tmp;
 		queue_stats->rqdpc[i] = value.ddword;
 
-		tmp = IGC_READ_REG(hw, IGC_TQDPC(i));
+		tmp = E1000_READ_REG(hw, IGC_TQDPC(i));
 		value.ddword = queue_stats->tqdpc[i];
 		if (value.dword[U32_0_IN_U64] > tmp)
 			value.dword[U32_1_IN_U64]++;
@@ -1963,8 +1963,8 @@ static int
 eth_igc_stats_get(struct rte_eth_dev *dev, struct rte_eth_stats *rte_stats)
 {
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_hw_stats *stats = IGC_DEV_PRIVATE_STATS(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw_stats *stats = IGC_DEV_PRIVATE_STATS(dev);
 	struct igc_hw_queue_stats *queue_stats =
 			IGC_DEV_PRIVATE_QUEUE_STATS(dev);
 	int i;
@@ -2025,8 +2025,8 @@ static int
 eth_igc_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 		   unsigned int n)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_hw_stats *hw_stats =
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw_stats *hw_stats =
 			IGC_DEV_PRIVATE_STATS(dev);
 	unsigned int i;
 
@@ -2054,8 +2054,8 @@ eth_igc_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 static int
 eth_igc_xstats_reset(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_hw_stats *hw_stats = IGC_DEV_PRIVATE_STATS(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw_stats *hw_stats = IGC_DEV_PRIVATE_STATS(dev);
 	struct igc_hw_queue_stats *queue_stats =
 			IGC_DEV_PRIVATE_QUEUE_STATS(dev);
 
@@ -2124,8 +2124,8 @@ static int
 eth_igc_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
 		uint64_t *values, unsigned int n)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	struct igc_hw_stats *hw_stats = IGC_DEV_PRIVATE_STATS(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw_stats *hw_stats = IGC_DEV_PRIVATE_STATS(dev);
 	unsigned int i;
 
 	igc_read_stats_registers(hw, hw_stats);
@@ -2185,7 +2185,7 @@ eth_igc_queue_stats_mapping_set(struct rte_eth_dev *dev,
 static int
 eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IGC_MISC_VEC_ID;
@@ -2195,8 +2195,8 @@ eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 
 	uint32_t mask = 1u << (queue_id + vec);
 
-	IGC_WRITE_REG(hw, IGC_EIMC, mask);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_EIMC, mask);
+	E1000_WRITE_FLUSH(hw);
 
 	return 0;
 }
@@ -2204,7 +2204,7 @@ eth_igc_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 static int
 eth_igc_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	uint32_t vec = IGC_MISC_VEC_ID;
@@ -2214,8 +2214,8 @@ eth_igc_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 
 	uint32_t mask = 1u << (queue_id + vec);
 
-	IGC_WRITE_REG(hw, IGC_EIMS, mask);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_EIMS, mask);
+	E1000_WRITE_FLUSH(hw);
 
 	rte_intr_enable(intr_handle);
 
@@ -2225,7 +2225,7 @@ eth_igc_rx_queue_intr_enable(struct rte_eth_dev *dev, uint16_t queue_id)
 static int
 eth_igc_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t ctrl;
 	int tx_pause;
 	int rx_pause;
@@ -2240,13 +2240,13 @@ eth_igc_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	 * Return rx_pause and tx_pause status according to actual setting of
 	 * the TFCE and RFCE bits in the CTRL register.
 	 */
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-	if (ctrl & IGC_CTRL_TFCE)
+	ctrl = E1000_READ_REG(hw, E1000_CTRL);
+	if (ctrl & E1000_CTRL_TFCE)
 		tx_pause = 1;
 	else
 		tx_pause = 0;
 
-	if (ctrl & IGC_CTRL_RFCE)
+	if (ctrl & E1000_CTRL_RFCE)
 		rx_pause = 1;
 	else
 		rx_pause = 0;
@@ -2266,7 +2266,7 @@ eth_igc_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 static int
 eth_igc_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t rx_buf_size;
 	uint32_t max_high_water;
 	uint32_t rctl;
@@ -2291,16 +2291,16 @@ eth_igc_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 
 	switch (fc_conf->mode) {
 	case RTE_ETH_FC_NONE:
-		hw->fc.requested_mode = igc_fc_none;
+		hw->fc.requested_mode = e1000_fc_none;
 		break;
 	case RTE_ETH_FC_RX_PAUSE:
-		hw->fc.requested_mode = igc_fc_rx_pause;
+		hw->fc.requested_mode = e1000_fc_rx_pause;
 		break;
 	case RTE_ETH_FC_TX_PAUSE:
-		hw->fc.requested_mode = igc_fc_tx_pause;
+		hw->fc.requested_mode = e1000_fc_tx_pause;
 		break;
 	case RTE_ETH_FC_FULL:
-		hw->fc.requested_mode = igc_fc_full;
+		hw->fc.requested_mode = e1000_fc_full;
 		break;
 	default:
 		PMD_DRV_LOG(ERR, "unsupported fc mode: %u", fc_conf->mode);
@@ -2312,23 +2312,23 @@ eth_igc_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	hw->fc.low_water      = fc_conf->low_water;
 	hw->fc.send_xon	      = fc_conf->send_xon;
 
-	err = igc_setup_link_generic(hw);
-	if (err == IGC_SUCCESS) {
+	err = e1000_setup_link_generic(hw);
+	if (err == E1000_SUCCESS) {
 		/**
 		 * check if we want to forward MAC frames - driver doesn't have
 		 * native capability to do that, so we'll write the registers
 		 * ourselves
 		 **/
-		rctl = IGC_READ_REG(hw, IGC_RCTL);
+		rctl = E1000_READ_REG(hw, E1000_RCTL);
 
 		/* set or clear MFLCN.PMCF bit depending on configuration */
 		if (fc_conf->mac_ctrl_frame_fwd != 0)
-			rctl |= IGC_RCTL_PMCF;
+			rctl |= E1000_RCTL_PMCF;
 		else
-			rctl &= ~IGC_RCTL_PMCF;
+			rctl &= ~E1000_RCTL_PMCF;
 
-		IGC_WRITE_REG(hw, IGC_RCTL, rctl);
-		IGC_WRITE_FLUSH(hw);
+		E1000_WRITE_REG(hw, E1000_RCTL, rctl);
+		E1000_WRITE_FLUSH(hw);
 
 		return 0;
 	}
@@ -2342,7 +2342,7 @@ eth_igc_rss_reta_update(struct rte_eth_dev *dev,
 			struct rte_eth_rss_reta_entry64 *reta_conf,
 			uint16_t reta_size)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint16_t i;
 
 	if (reta_size != RTE_ETH_RSS_RETA_SIZE_128) {
@@ -2374,8 +2374,8 @@ eth_igc_rss_reta_update(struct rte_eth_dev *dev,
 		if (mask == IGC_RSS_RDT_REG_SIZE_MASK)
 			reg.dword = 0;
 		else
-			reg.dword = IGC_READ_REG_LE_VALUE(hw,
-					IGC_RETA(i / IGC_RSS_RDT_REG_SIZE));
+			reg.dword = E1000_READ_REG_LE_VALUE(hw,
+					E1000_RETA(i / IGC_RSS_RDT_REG_SIZE));
 
 		/* update the register */
 		RTE_BUILD_BUG_ON(sizeof(reta.bytes) != IGC_RSS_RDT_REG_SIZE);
@@ -2386,8 +2386,8 @@ eth_igc_rss_reta_update(struct rte_eth_dev *dev,
 			else
 				reta.bytes[j] = reg.bytes[j];
 		}
-		IGC_WRITE_REG_LE_VALUE(hw,
-			IGC_RETA(i / IGC_RSS_RDT_REG_SIZE), reta.dword);
+		E1000_WRITE_REG_LE_VALUE(hw,
+			E1000_RETA(i / IGC_RSS_RDT_REG_SIZE), reta.dword);
 	}
 
 	return 0;
@@ -2398,7 +2398,7 @@ eth_igc_rss_reta_query(struct rte_eth_dev *dev,
 		       struct rte_eth_rss_reta_entry64 *reta_conf,
 		       uint16_t reta_size)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint16_t i;
 
 	if (reta_size != RTE_ETH_RSS_RETA_SIZE_128) {
@@ -2428,8 +2428,8 @@ eth_igc_rss_reta_query(struct rte_eth_dev *dev,
 
 		/* read register and get the queue index */
 		RTE_BUILD_BUG_ON(sizeof(reta.bytes) != IGC_RSS_RDT_REG_SIZE);
-		reta.dword = IGC_READ_REG_LE_VALUE(hw,
-				IGC_RETA(i / IGC_RSS_RDT_REG_SIZE));
+		reta.dword = E1000_READ_REG_LE_VALUE(hw,
+				E1000_RETA(i / IGC_RSS_RDT_REG_SIZE));
 		for (j = 0; j < IGC_RSS_RDT_REG_SIZE; j++) {
 			if (mask & (1u << j))
 				reta_conf[idx].reta[shift + j] = reta.bytes[j];
@@ -2443,7 +2443,7 @@ static int
 eth_igc_rss_hash_update(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	igc_hw_rss_hash_set(hw, rss_conf);
 	return 0;
 }
@@ -2452,7 +2452,7 @@ static int
 eth_igc_rss_hash_conf_get(struct rte_eth_dev *dev,
 			struct rte_eth_rss_conf *rss_conf)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t *hash_key = (uint32_t *)rss_conf->rss_key;
 	uint32_t mrqc;
 	uint64_t rss_hf;
@@ -2470,32 +2470,32 @@ eth_igc_rss_hash_conf_get(struct rte_eth_dev *dev,
 
 		/* read RSS key from register */
 		for (i = 0; i < IGC_HKEY_MAX_INDEX; i++)
-			hash_key[i] = IGC_READ_REG_LE_VALUE(hw, IGC_RSSRK(i));
+			hash_key[i] = E1000_READ_REG_LE_VALUE(hw, E1000_RSSRK(i));
 	}
 
 	/* get RSS functions configured in MRQC register */
-	mrqc = IGC_READ_REG(hw, IGC_MRQC);
-	if ((mrqc & IGC_MRQC_ENABLE_RSS_4Q) == 0)
+	mrqc = E1000_READ_REG(hw, E1000_MRQC);
+	if ((mrqc & E1000_MRQC_ENABLE_RSS_4Q) == 0)
 		return 0;
 
 	rss_hf = 0;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV4)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV4)
 		rss_hf |= RTE_ETH_RSS_IPV4;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV4_TCP)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV4_TCP)
 		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_TCP;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6)
 		rss_hf |= RTE_ETH_RSS_IPV6;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_EX)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_EX)
 		rss_hf |= RTE_ETH_RSS_IPV6_EX;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_TCP)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_TCP)
 		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_TCP;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_TCP_EX)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_TCP_EX)
 		rss_hf |= RTE_ETH_RSS_IPV6_TCP_EX;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV4_UDP)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV4_UDP)
 		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV4_UDP;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_UDP)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_UDP)
 		rss_hf |= RTE_ETH_RSS_NONFRAG_IPV6_UDP;
-	if (mrqc & IGC_MRQC_RSS_FIELD_IPV6_UDP_EX)
+	if (mrqc & E1000_MRQC_RSS_FIELD_IPV6_UDP_EX)
 		rss_hf |= RTE_ETH_RSS_IPV6_UDP_EX;
 
 	rss_conf->rss_hf |= rss_hf;
@@ -2505,20 +2505,20 @@ eth_igc_rss_hash_conf_get(struct rte_eth_dev *dev,
 static int
 eth_igc_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_vfta *shadow_vfta = IGC_DEV_PRIVATE_VFTA(dev);
 	uint32_t vfta;
 	uint32_t vid_idx;
 	uint32_t vid_bit;
 
-	vid_idx = (vlan_id >> IGC_VFTA_ENTRY_SHIFT) & IGC_VFTA_ENTRY_MASK;
-	vid_bit = 1u << (vlan_id & IGC_VFTA_ENTRY_BIT_SHIFT_MASK);
+	vid_idx = (vlan_id >> E1000_VFTA_ENTRY_SHIFT) & E1000_VFTA_ENTRY_MASK;
+	vid_bit = 1u << (vlan_id & E1000_VFTA_ENTRY_BIT_SHIFT_MASK);
 	vfta = shadow_vfta->vfta[vid_idx];
 	if (on)
 		vfta |= vid_bit;
 	else
 		vfta &= ~vid_bit;
-	IGC_WRITE_REG_ARRAY(hw, IGC_VFTA, vid_idx, vfta);
+	E1000_WRITE_REG_ARRAY(hw, E1000_VFTA, vid_idx, vfta);
 
 	/* update local VFTA copy */
 	shadow_vfta->vfta[vid_idx] = vfta;
@@ -2529,54 +2529,54 @@ eth_igc_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
 static void
 igc_vlan_hw_filter_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
-	igc_read_reg_check_clear_bits(hw, IGC_RCTL,
-			IGC_RCTL_CFIEN | IGC_RCTL_VFE);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	igc_read_reg_check_clear_bits(hw, E1000_RCTL,
+			E1000_RCTL_CFIEN | E1000_RCTL_VFE);
 }
 
 static void
 igc_vlan_hw_filter_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_vfta *shadow_vfta = IGC_DEV_PRIVATE_VFTA(dev);
 	uint32_t reg_val;
 	int i;
 
 	/* Filter Table Enable, CFI not used for packet acceptance */
-	reg_val = IGC_READ_REG(hw, IGC_RCTL);
-	reg_val &= ~IGC_RCTL_CFIEN;
-	reg_val |= IGC_RCTL_VFE;
-	IGC_WRITE_REG(hw, IGC_RCTL, reg_val);
+	reg_val = E1000_READ_REG(hw, E1000_RCTL);
+	reg_val &= ~E1000_RCTL_CFIEN;
+	reg_val |= E1000_RCTL_VFE;
+	E1000_WRITE_REG(hw, E1000_RCTL, reg_val);
 
 	/* restore VFTA table */
 	for (i = 0; i < IGC_VFTA_SIZE; i++)
-		IGC_WRITE_REG_ARRAY(hw, IGC_VFTA, i, shadow_vfta->vfta[i]);
+		E1000_WRITE_REG_ARRAY(hw, E1000_VFTA, i, shadow_vfta->vfta[i]);
 }
 
 static void
 igc_vlan_hw_strip_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	igc_read_reg_check_clear_bits(hw, IGC_CTRL, IGC_CTRL_VME);
+	igc_read_reg_check_clear_bits(hw, E1000_CTRL, E1000_CTRL_VME);
 }
 
 static void
 igc_vlan_hw_strip_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	igc_read_reg_check_set_bits(hw, IGC_CTRL, IGC_CTRL_VME);
+	igc_read_reg_check_set_bits(hw, E1000_CTRL, E1000_CTRL_VME);
 }
 
 static int
 igc_vlan_hw_extend_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t frame_size = dev->data->mtu + IGC_ETH_OVERHEAD;
 	uint32_t ctrl_ext;
 
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
 
 	/* if extend vlan hasn't been enabled */
 	if ((ctrl_ext & IGC_CTRL_EXT_EXT_VLAN) == 0)
@@ -2588,20 +2588,20 @@ igc_vlan_hw_extend_disable(struct rte_eth_dev *dev)
 			frame_size, VLAN_TAG_SIZE + RTE_ETHER_MIN_MTU);
 		return -EINVAL;
 	}
-	IGC_WRITE_REG(hw, IGC_RLPML, frame_size - VLAN_TAG_SIZE);
+	E1000_WRITE_REG(hw, E1000_RLPML, frame_size - VLAN_TAG_SIZE);
 
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext & ~IGC_CTRL_EXT_EXT_VLAN);
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext & ~IGC_CTRL_EXT_EXT_VLAN);
 	return 0;
 }
 
 static int
 igc_vlan_hw_extend_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t frame_size = dev->data->mtu + IGC_ETH_OVERHEAD;
 	uint32_t ctrl_ext;
 
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
+	ctrl_ext = E1000_READ_REG(hw, E1000_CTRL_EXT);
 
 	/* if extend vlan has been enabled */
 	if (ctrl_ext & IGC_CTRL_EXT_EXT_VLAN)
@@ -2613,9 +2613,9 @@ igc_vlan_hw_extend_enable(struct rte_eth_dev *dev)
 			frame_size, MAX_RX_JUMBO_FRAME_SIZE);
 		return -EINVAL;
 	}
-	IGC_WRITE_REG(hw, IGC_RLPML, frame_size);
+	E1000_WRITE_REG(hw, E1000_RLPML, frame_size);
 
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext | IGC_CTRL_EXT_EXT_VLAN);
+	E1000_WRITE_REG(hw, E1000_CTRL_EXT, ctrl_ext | IGC_CTRL_EXT_EXT_VLAN);
 	return 0;
 }
 
@@ -2654,15 +2654,15 @@ eth_igc_vlan_tpid_set(struct rte_eth_dev *dev,
 		      enum rte_vlan_type vlan_type,
 		      uint16_t tpid)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t reg_val;
 
 	/* only outer TPID of double VLAN can be configured*/
 	if (vlan_type == RTE_ETH_VLAN_TYPE_OUTER) {
-		reg_val = IGC_READ_REG(hw, IGC_VET);
+		reg_val = E1000_READ_REG(hw, E1000_VET);
 		reg_val = (reg_val & (~IGC_VET_EXT)) |
 			((uint32_t)tpid << IGC_VET_EXT_SHIFT);
-		IGC_WRITE_REG(hw, IGC_VET, reg_val);
+		E1000_WRITE_REG(hw, E1000_VET, reg_val);
 
 		return 0;
 	}
@@ -2675,42 +2675,42 @@ eth_igc_vlan_tpid_set(struct rte_eth_dev *dev,
 static int
 eth_igc_timesync_enable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct timespec system_time;
 	struct igc_rx_queue *rxq;
 	uint32_t val;
 	uint16_t i;
 
-	IGC_WRITE_REG(hw, IGC_TSAUXC, 0x0);
+	E1000_WRITE_REG(hw, E1000_TSAUXC, 0x0);
 
 	clock_gettime(CLOCK_REALTIME, &system_time);
-	IGC_WRITE_REG(hw, IGC_SYSTIML, system_time.tv_nsec);
-	IGC_WRITE_REG(hw, IGC_SYSTIMH, system_time.tv_sec);
+	E1000_WRITE_REG(hw, E1000_SYSTIML, system_time.tv_nsec);
+	E1000_WRITE_REG(hw, E1000_SYSTIMH, system_time.tv_sec);
 
 	/* Enable timestamping of received PTP packets. */
-	val = IGC_READ_REG(hw, IGC_RXPBS);
-	val |= IGC_RXPBS_CFG_TS_EN;
-	IGC_WRITE_REG(hw, IGC_RXPBS, val);
+	val = E1000_READ_REG(hw, E1000_RXPBS);
+	val |= E1000_RXPBS_CFG_TS_EN;
+	E1000_WRITE_REG(hw, E1000_RXPBS, val);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
-		val = IGC_READ_REG(hw, IGC_SRRCTL(i));
+		val = E1000_READ_REG(hw, E1000_SRRCTL(i));
 		/* For now, only support retrieving Rx timestamp from timer0. */
-		val |= IGC_SRRCTL_TIMER1SEL(0) | IGC_SRRCTL_TIMER0SEL(0) |
-		       IGC_SRRCTL_TIMESTAMP;
-		IGC_WRITE_REG(hw, IGC_SRRCTL(i), val);
+		val |= E1000_SRRCTL_TIMER1SEL(0) | E1000_SRRCTL_TIMER0SEL(0) |
+		       E1000_SRRCTL_TIMESTAMP;
+		E1000_WRITE_REG(hw, E1000_SRRCTL(i), val);
 	}
 
-	val = IGC_TSYNCRXCTL_ENABLED | IGC_TSYNCRXCTL_TYPE_ALL |
-	      IGC_TSYNCRXCTL_RXSYNSIG;
-	IGC_WRITE_REG(hw, IGC_TSYNCRXCTL, val);
+	val = E1000_TSYNCRXCTL_ENABLED | E1000_TSYNCRXCTL_TYPE_ALL |
+	      E1000_TSYNCRXCTL_RXSYNSIG;
+	E1000_WRITE_REG(hw, E1000_TSYNCRXCTL, val);
 
 	/* Enable Timestamping of transmitted PTP packets. */
-	IGC_WRITE_REG(hw, IGC_TSYNCTXCTL, IGC_TSYNCTXCTL_ENABLED |
-		      IGC_TSYNCTXCTL_TXSYNSIG);
+	E1000_WRITE_REG(hw, E1000_TSYNCTXCTL, E1000_TSYNCTXCTL_ENABLED |
+		      E1000_TSYNCTXCTL_TXSYNSIG);
 
 	/* Read TXSTMP registers to discard any timestamp previously stored. */
-	IGC_READ_REG(hw, IGC_TXSTMPL);
-	IGC_READ_REG(hw, IGC_TXSTMPH);
+	E1000_READ_REG(hw, E1000_TXSTMPL);
+	E1000_READ_REG(hw, E1000_TXSTMPH);
 
 	for (i = 0; i < dev->data->nb_rx_queues; i++) {
 		rxq = dev->data->rx_queues[i];
@@ -2723,10 +2723,10 @@ eth_igc_timesync_enable(struct rte_eth_dev *dev)
 static int
 eth_igc_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	ts->tv_nsec = IGC_READ_REG(hw, IGC_SYSTIML);
-	ts->tv_sec = IGC_READ_REG(hw, IGC_SYSTIMH);
+	ts->tv_nsec = E1000_READ_REG(hw, E1000_SYSTIML);
+	ts->tv_sec = E1000_READ_REG(hw, E1000_SYSTIMH);
 
 	return 0;
 }
@@ -2734,10 +2734,10 @@ eth_igc_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
 static int
 eth_igc_timesync_write_time(struct rte_eth_dev *dev, const struct timespec *ts)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	IGC_WRITE_REG(hw, IGC_SYSTIML, ts->tv_nsec);
-	IGC_WRITE_REG(hw, IGC_SYSTIMH, ts->tv_sec);
+	E1000_WRITE_REG(hw, E1000_SYSTIML, ts->tv_nsec);
+	E1000_WRITE_REG(hw, E1000_SYSTIMH, ts->tv_sec);
 
 	return 0;
 }
@@ -2745,20 +2745,20 @@ eth_igc_timesync_write_time(struct rte_eth_dev *dev, const struct timespec *ts)
 static int
 eth_igc_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t nsec, sec;
 	uint64_t systime, ns;
 	struct timespec ts;
 
-	nsec = (uint64_t)IGC_READ_REG(hw, IGC_SYSTIML);
-	sec = (uint64_t)IGC_READ_REG(hw, IGC_SYSTIMH);
+	nsec = (uint64_t)E1000_READ_REG(hw, E1000_SYSTIML);
+	sec = (uint64_t)E1000_READ_REG(hw, E1000_SYSTIMH);
 	systime = sec * NSEC_PER_SEC + nsec;
 
 	ns = systime + delta;
 	ts = rte_ns_to_timespec(ns);
 
-	IGC_WRITE_REG(hw, IGC_SYSTIML, ts.tv_nsec);
-	IGC_WRITE_REG(hw, IGC_SYSTIMH, ts.tv_sec);
+	E1000_WRITE_REG(hw, E1000_SYSTIML, ts.tv_nsec);
+	E1000_WRITE_REG(hw, E1000_SYSTIMH, ts.tv_sec);
 
 	return 0;
 }
@@ -2803,18 +2803,18 @@ static int
 eth_igc_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 			       struct timespec *timestamp)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct rte_eth_link link;
 	uint32_t val, nsec, sec;
 	uint64_t tx_timestamp;
 	int adjust = 0;
 
-	val = IGC_READ_REG(hw, IGC_TSYNCTXCTL);
-	if (!(val & IGC_TSYNCTXCTL_VALID))
+	val = E1000_READ_REG(hw, E1000_TSYNCTXCTL);
+	if (!(val & E1000_TSYNCTXCTL_VALID))
 		return -EINVAL;
 
-	nsec = (uint64_t)IGC_READ_REG(hw, IGC_TXSTMPL);
-	sec = (uint64_t)IGC_READ_REG(hw, IGC_TXSTMPH);
+	nsec = (uint64_t)E1000_READ_REG(hw, E1000_TXSTMPL);
+	sec = (uint64_t)E1000_READ_REG(hw, E1000_TXSTMPH);
 	tx_timestamp = sec * NSEC_PER_SEC + nsec;
 
 	/* Get current link speed. */
@@ -2845,22 +2845,22 @@ eth_igc_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 static int
 eth_igc_timesync_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t val;
 
 	/* Disable timestamping of transmitted PTP packets. */
-	IGC_WRITE_REG(hw, IGC_TSYNCTXCTL, 0);
+	E1000_WRITE_REG(hw, E1000_TSYNCTXCTL, 0);
 
 	/* Disable timestamping of received PTP packets. */
-	IGC_WRITE_REG(hw, IGC_TSYNCRXCTL, 0);
+	E1000_WRITE_REG(hw, E1000_TSYNCRXCTL, 0);
 
-	val = IGC_READ_REG(hw, IGC_RXPBS);
-	val &= ~IGC_RXPBS_CFG_TS_EN;
-	IGC_WRITE_REG(hw, IGC_RXPBS, val);
+	val = E1000_READ_REG(hw, E1000_RXPBS);
+	val &= ~E1000_RXPBS_CFG_TS_EN;
+	E1000_WRITE_REG(hw, E1000_RXPBS, val);
 
-	val = IGC_READ_REG(hw, IGC_SRRCTL(0));
-	val &= ~IGC_SRRCTL_TIMESTAMP;
-	IGC_WRITE_REG(hw, IGC_SRRCTL(0), val);
+	val = E1000_READ_REG(hw, E1000_SRRCTL(0));
+	val &= ~E1000_SRRCTL_TIMESTAMP;
+	E1000_WRITE_REG(hw, E1000_SRRCTL(0), val);
 
 	return 0;
 }
diff --git a/drivers/net/intel/igc/igc_ethdev.h b/drivers/net/intel/e1000/igc_ethdev.h
similarity index 91%
rename from drivers/net/intel/igc/igc_ethdev.h
rename to drivers/net/intel/e1000/igc_ethdev.h
index d3d3ddd6f6..7fa7877adf 100644
--- a/drivers/net/intel/igc/igc_ethdev.h
+++ b/drivers/net/intel/e1000/igc_ethdev.h
@@ -9,10 +9,10 @@
 #include <rte_flow.h>
 #include <rte_time.h>
 
-#include "base/igc_osdep.h"
-#include "base/igc_hw.h"
-#include "base/igc_i225.h"
-#include "base/igc_api.h"
+#include "base/e1000_osdep.h"
+#include "base/e1000_hw.h"
+#include "base/e1000_i225.h"
+#include "base/e1000_api.h"
 
 #ifdef __cplusplus
 extern "C" {
@@ -55,13 +55,13 @@ extern "C" {
 #define IGC_RX_DESCRIPTOR_MULTIPLE	8
 
 #define IGC_RXD_ALIGN	((uint16_t)(IGC_ALIGN / \
-		sizeof(union igc_adv_rx_desc)))
+		sizeof(union e1000_adv_rx_desc)))
 #define IGC_TXD_ALIGN	((uint16_t)(IGC_ALIGN / \
-		sizeof(union igc_adv_tx_desc)))
+		sizeof(union e1000_adv_tx_desc)))
 #define IGC_MIN_TXD	IGC_TX_DESCRIPTOR_MULTIPLE
-#define IGC_MAX_TXD	((uint16_t)(0x80000 / sizeof(union igc_adv_tx_desc)))
+#define IGC_MAX_TXD	((uint16_t)(0x80000 / sizeof(union e1000_adv_tx_desc)))
 #define IGC_MIN_RXD	IGC_RX_DESCRIPTOR_MULTIPLE
-#define IGC_MAX_RXD	((uint16_t)(0x80000 / sizeof(union igc_adv_rx_desc)))
+#define IGC_MAX_RXD	((uint16_t)(0x80000 / sizeof(union e1000_adv_rx_desc)))
 
 #define IGC_TX_MAX_SEG		UINT8_MAX
 #define IGC_TX_MAX_MTU_SEG	UINT8_MAX
@@ -224,8 +224,8 @@ TAILQ_HEAD(igc_flow_list, rte_flow);
  * Structure to store private data for each driver instance (for each port).
  */
 struct igc_adapter {
-	struct igc_hw		hw;
-	struct igc_hw_stats	stats;
+	struct e1000_hw		hw;
+	struct e1000_hw_stats	stats;
 	struct igc_hw_queue_stats queue_stats;
 	int16_t txq_stats_map[IGC_QUEUE_PAIRS_NUM];
 	int16_t rxq_stats_map[IGC_QUEUE_PAIRS_NUM];
@@ -268,27 +268,27 @@ struct igc_adapter {
 	(&((struct igc_adapter *)(_dev)->data->dev_private)->flow_list)
 
 static inline void
-igc_read_reg_check_set_bits(struct igc_hw *hw, uint32_t reg, uint32_t bits)
+igc_read_reg_check_set_bits(struct e1000_hw *hw, uint32_t reg, uint32_t bits)
 {
-	uint32_t reg_val = IGC_READ_REG(hw, reg);
+	uint32_t reg_val = E1000_READ_REG(hw, reg);
 
 	bits |= reg_val;
 	if (bits == reg_val)
 		return;	/* no need to write back */
 
-	IGC_WRITE_REG(hw, reg, bits);
+	E1000_WRITE_REG(hw, reg, bits);
 }
 
 static inline void
-igc_read_reg_check_clear_bits(struct igc_hw *hw, uint32_t reg, uint32_t bits)
+igc_read_reg_check_clear_bits(struct e1000_hw *hw, uint32_t reg, uint32_t bits)
 {
-	uint32_t reg_val = IGC_READ_REG(hw, reg);
+	uint32_t reg_val = E1000_READ_REG(hw, reg);
 
 	bits = reg_val & ~bits;
 	if (bits == reg_val)
 		return;	/* no need to write back */
 
-	IGC_WRITE_REG(hw, reg, bits);
+	E1000_WRITE_REG(hw, reg, bits);
 }
 
 #ifdef __cplusplus
diff --git a/drivers/net/intel/igc/igc_filter.c b/drivers/net/intel/e1000/igc_filter.c
similarity index 81%
rename from drivers/net/intel/igc/igc_filter.c
rename to drivers/net/intel/e1000/igc_filter.c
index bff98df200..3df7183dbb 100644
--- a/drivers/net/intel/igc/igc_filter.c
+++ b/drivers/net/intel/e1000/igc_filter.c
@@ -3,7 +3,7 @@
  */
 
 #include "rte_malloc.h"
-#include "igc_logs.h"
+#include "e1000_logs.h"
 #include "igc_txrx.h"
 #include "igc_filter.h"
 #include "igc_flow.h"
@@ -57,7 +57,7 @@ int
 igc_del_ethertype_filter(struct rte_eth_dev *dev,
 			const struct igc_ethertype_filter *filter)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	int ret;
 
@@ -77,8 +77,8 @@ igc_del_ethertype_filter(struct rte_eth_dev *dev,
 
 	igc->ethertype_filters[ret].ether_type = 0;
 
-	IGC_WRITE_REG(hw, IGC_ETQF(ret), 0);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_ETQF(ret), 0);
+	E1000_WRITE_FLUSH(hw);
 	return 0;
 }
 
@@ -86,7 +86,7 @@ int
 igc_add_ethertype_filter(struct rte_eth_dev *dev,
 			const struct igc_ethertype_filter *filter)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	uint32_t etqf;
 	int ret, empty;
@@ -114,13 +114,13 @@ igc_add_ethertype_filter(struct rte_eth_dev *dev,
 	ret = empty;
 
 	etqf = filter->ether_type;
-	etqf |= IGC_ETQF_FILTER_ENABLE | IGC_ETQF_QUEUE_ENABLE;
+	etqf |= E1000_ETQF_FILTER_ENABLE | E1000_ETQF_QUEUE_ENABLE;
 	etqf |= (uint32_t)filter->queue << IGC_ETQF_QUEUE_SHIFT;
 
 	memcpy(&igc->ethertype_filters[ret], filter, sizeof(*filter));
 
-	IGC_WRITE_REG(hw, IGC_ETQF(ret), etqf);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_ETQF(ret), etqf);
+	E1000_WRITE_FLUSH(hw);
 	return 0;
 }
 
@@ -128,13 +128,13 @@ igc_add_ethertype_filter(struct rte_eth_dev *dev,
 static void
 igc_clear_all_ethertype_filter(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 	int i;
 
 	for (i = 0; i < IGC_MAX_ETQF_FILTERS; i++)
-		IGC_WRITE_REG(hw, IGC_ETQF(i), 0);
-	IGC_WRITE_FLUSH(hw);
+		E1000_WRITE_REG(hw, E1000_ETQF(i), 0);
+	E1000_WRITE_FLUSH(hw);
 
 	memset(&igc->ethertype_filters, 0, sizeof(igc->ethertype_filters));
 }
@@ -196,59 +196,59 @@ static void
 igc_enable_tuple_filter(struct rte_eth_dev *dev,
 			const struct igc_adapter *igc, uint8_t index)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	const struct igc_ntuple_filter *filter = &igc->ntuple_filters[index];
 	const struct igc_ntuple_info *info = &filter->tuple_info;
-	uint32_t ttqf, imir, imir_ext = IGC_IMIREXT_SIZE_BP;
+	uint32_t ttqf, imir, imir_ext = E1000_IMIREXT_SIZE_BP;
 
 	imir = info->dst_port;
-	imir |= (uint32_t)info->priority << IGC_IMIR_PRIORITY_SHIFT;
+	imir |= (uint32_t)info->priority << E1000_IMIR_PRIORITY_SHIFT;
 
 	/* 0b means not compare. */
 	if (info->dst_port_mask == 0)
-		imir |= IGC_IMIR_PORT_BP;
+		imir |= E1000_IMIR_PORT_BP;
 
-	ttqf = IGC_TTQF_DISABLE_MASK | IGC_TTQF_QUEUE_ENABLE;
-	ttqf |= (uint32_t)filter->queue << IGC_TTQF_QUEUE_SHIFT;
+	ttqf = E1000_TTQF_DISABLE_MASK | E1000_TTQF_QUEUE_ENABLE;
+	ttqf |= (uint32_t)filter->queue << E1000_TTQF_QUEUE_SHIFT;
 	ttqf |= info->proto;
 
 	if (info->proto_mask)
-		ttqf &= ~IGC_TTQF_MASK_ENABLE;
+		ttqf &= ~E1000_TTQF_MASK_ENABLE;
 
 	/* TCP flags bits setting. */
 	if (info->tcp_flags & RTE_NTUPLE_TCP_FLAGS_MASK) {
 		if (info->tcp_flags & RTE_TCP_URG_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_URG;
+			imir_ext |= E1000_IMIREXT_CTRL_URG;
 		if (info->tcp_flags & RTE_TCP_ACK_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_ACK;
+			imir_ext |= E1000_IMIREXT_CTRL_ACK;
 		if (info->tcp_flags & RTE_TCP_PSH_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_PSH;
+			imir_ext |= E1000_IMIREXT_CTRL_PSH;
 		if (info->tcp_flags & RTE_TCP_RST_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_RST;
+			imir_ext |= E1000_IMIREXT_CTRL_RST;
 		if (info->tcp_flags & RTE_TCP_SYN_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_SYN;
+			imir_ext |= E1000_IMIREXT_CTRL_SYN;
 		if (info->tcp_flags & RTE_TCP_FIN_FLAG)
-			imir_ext |= IGC_IMIREXT_CTRL_FIN;
+			imir_ext |= E1000_IMIREXT_CTRL_FIN;
 	} else {
-		imir_ext |= IGC_IMIREXT_CTRL_BP;
+		imir_ext |= E1000_IMIREXT_CTRL_BP;
 	}
 
-	IGC_WRITE_REG(hw, IGC_IMIR(index), imir);
-	IGC_WRITE_REG(hw, IGC_TTQF(index), ttqf);
-	IGC_WRITE_REG(hw, IGC_IMIREXT(index), imir_ext);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_IMIR(index), imir);
+	E1000_WRITE_REG(hw, E1000_TTQF(index), ttqf);
+	E1000_WRITE_REG(hw, E1000_IMIREXT(index), imir_ext);
+	E1000_WRITE_FLUSH(hw);
 }
 
 /* Reset hardware register values */
 static void
 igc_disable_tuple_filter(struct rte_eth_dev *dev, uint8_t index)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
-	IGC_WRITE_REG(hw, IGC_TTQF(index), IGC_TTQF_DISABLE_MASK);
-	IGC_WRITE_REG(hw, IGC_IMIR(index), 0);
-	IGC_WRITE_REG(hw, IGC_IMIREXT(index), 0);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_TTQF(index), E1000_TTQF_DISABLE_MASK);
+	E1000_WRITE_REG(hw, E1000_IMIR(index), 0);
+	E1000_WRITE_REG(hw, E1000_IMIREXT(index), 0);
+	E1000_WRITE_FLUSH(hw);
 }
 
 int
@@ -310,7 +310,7 @@ int
 igc_set_syn_filter(struct rte_eth_dev *dev,
 		const struct igc_syn_filter *filter)
 {
-	struct igc_hw *hw;
+	struct e1000_hw *hw;
 	struct igc_adapter *igc;
 	uint32_t synqf, rfctl;
 
@@ -331,7 +331,7 @@ igc_set_syn_filter(struct rte_eth_dev *dev,
 	synqf = (uint32_t)filter->queue << IGC_SYN_FILTER_QUEUE_SHIFT;
 	synqf |= IGC_SYN_FILTER_ENABLE;
 
-	rfctl = IGC_READ_REG(hw, IGC_RFCTL);
+	rfctl = E1000_READ_REG(hw, E1000_RFCTL);
 	if (filter->hig_pri)
 		rfctl |= IGC_RFCTL_SYNQFP;
 	else
@@ -340,9 +340,9 @@ igc_set_syn_filter(struct rte_eth_dev *dev,
 	memcpy(&igc->syn_filter, filter, sizeof(igc->syn_filter));
 	igc->syn_filter.enable = 1;
 
-	IGC_WRITE_REG(hw, IGC_RFCTL, rfctl);
-	IGC_WRITE_REG(hw, IGC_SYNQF(0), synqf);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_RFCTL, rfctl);
+	E1000_WRITE_REG(hw, E1000_SYNQF(0), synqf);
+	E1000_WRITE_FLUSH(hw);
 	return 0;
 }
 
@@ -350,11 +350,11 @@ igc_set_syn_filter(struct rte_eth_dev *dev,
 void
 igc_clear_syn_filter(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_adapter *igc = IGC_DEV_PRIVATE(dev);
 
-	IGC_WRITE_REG(hw, IGC_SYNQF(0), 0);
-	IGC_WRITE_FLUSH(hw);
+	E1000_WRITE_REG(hw, E1000_SYNQF(0), 0);
+	E1000_WRITE_FLUSH(hw);
 
 	memset(&igc->syn_filter, 0, sizeof(igc->syn_filter));
 }
diff --git a/drivers/net/intel/igc/igc_filter.h b/drivers/net/intel/e1000/igc_filter.h
similarity index 100%
rename from drivers/net/intel/igc/igc_filter.h
rename to drivers/net/intel/e1000/igc_filter.h
diff --git a/drivers/net/intel/igc/igc_flow.c b/drivers/net/intel/e1000/igc_flow.c
similarity index 99%
rename from drivers/net/intel/igc/igc_flow.c
rename to drivers/net/intel/e1000/igc_flow.c
index b778ac2613..b947cf8b08 100644
--- a/drivers/net/intel/igc/igc_flow.c
+++ b/drivers/net/intel/e1000/igc_flow.c
@@ -3,7 +3,7 @@
  */
 
 #include "rte_malloc.h"
-#include "igc_logs.h"
+#include "e1000_logs.h"
 #include "igc_txrx.h"
 #include "igc_filter.h"
 #include "igc_flow.h"
diff --git a/drivers/net/intel/igc/igc_flow.h b/drivers/net/intel/e1000/igc_flow.h
similarity index 100%
rename from drivers/net/intel/igc/igc_flow.h
rename to drivers/net/intel/e1000/igc_flow.h
diff --git a/drivers/net/intel/igc/igc_logs.c b/drivers/net/intel/e1000/igc_logs.c
similarity index 90%
rename from drivers/net/intel/igc/igc_logs.c
rename to drivers/net/intel/e1000/igc_logs.c
index 9cb8da527e..df91d173dd 100644
--- a/drivers/net/intel/igc/igc_logs.c
+++ b/drivers/net/intel/e1000/igc_logs.c
@@ -4,7 +4,7 @@
 
 #include <rte_common.h>
 
-#include "igc_logs.h"
+#include "e1000_logs.h"
 
 RTE_LOG_REGISTER_SUFFIX(igc_logtype_init, init, INFO);
 RTE_LOG_REGISTER_SUFFIX(igc_logtype_driver, driver, INFO);
diff --git a/drivers/net/intel/igc/igc_txrx.c b/drivers/net/intel/e1000/igc_txrx.c
similarity index 87%
rename from drivers/net/intel/igc/igc_txrx.c
rename to drivers/net/intel/e1000/igc_txrx.c
index fabab5b1a3..9b2eb343ef 100644
--- a/drivers/net/intel/igc/igc_txrx.c
+++ b/drivers/net/intel/e1000/igc_txrx.c
@@ -8,7 +8,7 @@
 #include <ethdev_driver.h>
 #include <rte_net.h>
 
-#include "igc_logs.h"
+#include "e1000_logs.h"
 #include "igc_txrx.h"
 
 #ifdef RTE_PMD_USE_PREFETCH
@@ -24,16 +24,16 @@
 #endif
 
 /* Multicast / Unicast table offset mask. */
-#define IGC_RCTL_MO_MSK			(3u << IGC_RCTL_MO_SHIFT)
+#define E1000_RCTL_MO_MSK			(3u << E1000_RCTL_MO_SHIFT)
 
 /* Loopback mode. */
-#define IGC_RCTL_LBM_SHIFT		6
-#define IGC_RCTL_LBM_MSK		(3u << IGC_RCTL_LBM_SHIFT)
+#define E1000_RCTL_LBM_SHIFT		6
+#define E1000_RCTL_LBM_MSK		(3u << E1000_RCTL_LBM_SHIFT)
 
 /* Hash select for MTA */
-#define IGC_RCTL_HSEL_SHIFT		8
-#define IGC_RCTL_HSEL_MSK		(3u << IGC_RCTL_HSEL_SHIFT)
-#define IGC_RCTL_PSP			(1u << 21)
+#define E1000_RCTL_HSEL_SHIFT		8
+#define E1000_RCTL_HSEL_MSK		(3u << E1000_RCTL_HSEL_SHIFT)
+#define E1000_RCTL_PSP			(1u << 21)
 
 /* Receive buffer size for header buffer */
 #define IGC_SRRCTL_BSIZEHEADER_SHIFT	8
@@ -109,14 +109,14 @@ rx_desc_statuserr_to_pkt_flags(uint32_t statuserr)
 	uint64_t pkt_flags = 0;
 	uint32_t tmp;
 
-	if (statuserr & IGC_RXD_STAT_VP)
+	if (statuserr & E1000_RXD_STAT_VP)
 		pkt_flags |= RTE_MBUF_F_RX_VLAN_STRIPPED;
 
-	tmp = !!(statuserr & (IGC_RXD_STAT_L4CS | IGC_RXD_STAT_UDPCS));
+	tmp = !!(statuserr & (IGC_RXD_STAT_L4CS | E1000_RXD_STAT_UDPCS));
 	tmp = (tmp << 1) | (uint32_t)!!(statuserr & IGC_RXD_EXT_ERR_L4E);
 	pkt_flags |= l4_chksum_flags[tmp];
 
-	tmp = !!(statuserr & IGC_RXD_STAT_IPCS);
+	tmp = !!(statuserr & E1000_RXD_STAT_IPCS);
 	tmp = (tmp << 1) | (uint32_t)!!(statuserr & IGC_RXD_EXT_ERR_IPE);
 	pkt_flags |= l3_chksum_flags[tmp];
 
@@ -193,7 +193,7 @@ rx_desc_pkt_info_to_pkt_type(uint32_t pkt_info)
 		[IGC_PACKET_TYPE_IPV4_EXT_SCTP] = RTE_PTYPE_L2_ETHER |
 			RTE_PTYPE_L3_IPV4_EXT | RTE_PTYPE_L4_SCTP,
 	};
-	if (unlikely(pkt_info & IGC_RXDADV_PKTTYPE_ETQF))
+	if (unlikely(pkt_info & E1000_RXDADV_PKTTYPE_ETQF))
 		return RTE_PTYPE_UNKNOWN;
 
 	pkt_info = (pkt_info >> IGC_PACKET_TYPE_SHIFT) & IGC_PACKET_TYPE_MASK;
@@ -203,7 +203,7 @@ rx_desc_pkt_info_to_pkt_type(uint32_t pkt_info)
 
 static inline void
 rx_desc_get_pkt_info(struct igc_rx_queue *rxq, struct rte_mbuf *rxm,
-		union igc_adv_rx_desc *rxd, uint32_t staterr)
+		union e1000_adv_rx_desc *rxd, uint32_t staterr)
 {
 	uint64_t pkt_flags;
 	uint32_t hlen_type_rss;
@@ -237,18 +237,18 @@ uint16_t
 igc_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
 	struct igc_rx_queue * const rxq = rx_queue;
-	volatile union igc_adv_rx_desc * const rx_ring = rxq->rx_ring;
+	volatile union e1000_adv_rx_desc * const rx_ring = rxq->rx_ring;
 	struct igc_rx_entry * const sw_ring = rxq->sw_ring;
 	uint16_t rx_id = rxq->rx_tail;
 	uint16_t nb_rx = 0;
 	uint16_t nb_hold = 0;
 
 	while (nb_rx < nb_pkts) {
-		volatile union igc_adv_rx_desc *rxdp;
+		volatile union e1000_adv_rx_desc *rxdp;
 		struct igc_rx_entry *rxe;
 		struct rte_mbuf *rxm;
 		struct rte_mbuf *nmb;
-		union igc_adv_rx_desc rxd;
+		union e1000_adv_rx_desc rxd;
 		uint32_t staterr;
 		uint16_t data_len;
 
@@ -262,14 +262,14 @@ igc_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 		 */
 		rxdp = &rx_ring[rx_id];
 		staterr = rte_cpu_to_le_32(rxdp->wb.upper.status_error);
-		if (!(staterr & IGC_RXD_STAT_DD))
+		if (!(staterr & E1000_RXD_STAT_DD))
 			break;
 		rxd = *rxdp;
 
 		/*
 		 * End of packet.
 		 *
-		 * If the IGC_RXD_STAT_EOP flag is not set, the RX packet is
+		 * If the E1000_RXD_STAT_EOP flag is not set, the RX packet is
 		 * likely to be invalid and to be dropped by the various
 		 * validation checks performed by the network stack.
 		 *
@@ -391,7 +391,7 @@ igc_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 			"port_id=%u queue_id=%u rx_tail=%u nb_hold=%u nb_rx=%u",
 			rxq->port_id, rxq->queue_id, rx_id, nb_hold, nb_rx);
 		rx_id = (rx_id == 0) ? (rxq->nb_rx_desc - 1) : (rx_id - 1);
-		IGC_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
+		E1000_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
 		nb_hold = 0;
 	}
 	rxq->nb_rx_hold = nb_hold;
@@ -403,7 +403,7 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			uint16_t nb_pkts)
 {
 	struct igc_rx_queue * const rxq = rx_queue;
-	volatile union igc_adv_rx_desc * const rx_ring = rxq->rx_ring;
+	volatile union e1000_adv_rx_desc * const rx_ring = rxq->rx_ring;
 	struct igc_rx_entry * const sw_ring = rxq->sw_ring;
 	struct rte_mbuf *first_seg = rxq->pkt_first_seg;
 	struct rte_mbuf *last_seg = rxq->pkt_last_seg;
@@ -413,11 +413,11 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	uint16_t nb_hold = 0;
 
 	while (nb_rx < nb_pkts) {
-		volatile union igc_adv_rx_desc *rxdp;
+		volatile union e1000_adv_rx_desc *rxdp;
 		struct igc_rx_entry *rxe;
 		struct rte_mbuf *rxm;
 		struct rte_mbuf *nmb;
-		union igc_adv_rx_desc rxd;
+		union e1000_adv_rx_desc rxd;
 		uint32_t staterr;
 		uint16_t data_len;
 
@@ -432,7 +432,7 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 */
 		rxdp = &rx_ring[rx_id];
 		staterr = rte_cpu_to_le_32(rxdp->wb.upper.status_error);
-		if (!(staterr & IGC_RXD_STAT_DD))
+		if (!(staterr & E1000_RXD_STAT_DD))
 			break;
 		rxd = *rxdp;
 
@@ -559,7 +559,7 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 		 * update the pointer to the last mbuf of the current scattered
 		 * packet and continue to parse the RX ring.
 		 */
-		if (!(staterr & IGC_RXD_STAT_EOP)) {
+		if (!(staterr & E1000_RXD_STAT_EOP)) {
 			last_seg = rxm;
 			goto next_desc;
 		}
@@ -631,7 +631,7 @@ igc_recv_scattered_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			"port_id=%u queue_id=%u rx_tail=%u nb_hold=%u nb_rx=%u",
 			rxq->port_id, rxq->queue_id, rx_id, nb_hold, nb_rx);
 		rx_id = (rx_id == 0) ? (rxq->nb_rx_desc - 1) : (rx_id - 1);
-		IGC_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
+		E1000_PCI_REG_WRITE(rxq->rdt_reg_addr, rx_id);
 		nb_hold = 0;
 	}
 	rxq->nb_rx_hold = nb_hold;
@@ -676,7 +676,7 @@ uint32_t eth_igc_rx_queue_count(void *rx_queue)
 	 */
 #define IGC_RXQ_SCAN_INTERVAL 4
 
-	volatile union igc_adv_rx_desc *rxdp;
+	volatile union e1000_adv_rx_desc *rxdp;
 	struct igc_rx_queue *rxq;
 	uint16_t desc = 0;
 
@@ -685,7 +685,7 @@ uint32_t eth_igc_rx_queue_count(void *rx_queue)
 
 	while (desc < rxq->nb_rx_desc - rxq->rx_tail) {
 		if (unlikely(!(rxdp->wb.upper.status_error &
-				IGC_RXD_STAT_DD)))
+				E1000_RXD_STAT_DD)))
 			return desc;
 		desc += IGC_RXQ_SCAN_INTERVAL;
 		rxdp += IGC_RXQ_SCAN_INTERVAL;
@@ -693,7 +693,7 @@ uint32_t eth_igc_rx_queue_count(void *rx_queue)
 	rxdp = &rxq->rx_ring[rxq->rx_tail + desc - rxq->nb_rx_desc];
 
 	while (desc < rxq->nb_rx_desc &&
-		(rxdp->wb.upper.status_error & IGC_RXD_STAT_DD)) {
+		(rxdp->wb.upper.status_error & E1000_RXD_STAT_DD)) {
 		desc += IGC_RXQ_SCAN_INTERVAL;
 		rxdp += IGC_RXQ_SCAN_INTERVAL;
 	}
@@ -718,7 +718,7 @@ int eth_igc_rx_descriptor_status(void *rx_queue, uint16_t offset)
 		desc -= rxq->nb_rx_desc;
 
 	status = &rxq->rx_ring[desc].wb.upper.status_error;
-	if (*status & rte_cpu_to_le_32(IGC_RXD_STAT_DD))
+	if (*status & rte_cpu_to_le_32(E1000_RXD_STAT_DD))
 		return RTE_ETH_RX_DESC_DONE;
 
 	return RTE_ETH_RX_DESC_AVAIL;
@@ -733,7 +733,7 @@ igc_alloc_rx_queue_mbufs(struct igc_rx_queue *rxq)
 
 	/* Initialize software ring entries. */
 	for (i = 0; i < rxq->nb_rx_desc; i++) {
-		volatile union igc_adv_rx_desc *rxd;
+		volatile union e1000_adv_rx_desc *rxd;
 		struct rte_mbuf *mbuf = rte_mbuf_raw_alloc(rxq->mb_pool);
 
 		if (mbuf == NULL) {
@@ -769,16 +769,16 @@ static uint8_t default_rss_key[40] = {
 void
 igc_rss_disable(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint32_t mrqc;
 
-	mrqc = IGC_READ_REG(hw, IGC_MRQC);
-	mrqc &= ~IGC_MRQC_ENABLE_MASK;
-	IGC_WRITE_REG(hw, IGC_MRQC, mrqc);
+	mrqc = E1000_READ_REG(hw, E1000_MRQC);
+	mrqc &= ~E1000_MRQC_ENABLE_MASK;
+	E1000_WRITE_REG(hw, E1000_MRQC, mrqc);
 }
 
 void
-igc_hw_rss_hash_set(struct igc_hw *hw, struct rte_eth_rss_conf *rss_conf)
+igc_hw_rss_hash_set(struct e1000_hw *hw, struct rte_eth_rss_conf *rss_conf)
 {
 	uint32_t *hash_key = (uint32_t *)rss_conf->rss_key;
 	uint32_t mrqc;
@@ -789,38 +789,38 @@ igc_hw_rss_hash_set(struct igc_hw *hw, struct rte_eth_rss_conf *rss_conf)
 
 		/* Fill in RSS hash key */
 		for (i = 0; i < IGC_HKEY_MAX_INDEX; i++)
-			IGC_WRITE_REG_LE_VALUE(hw, IGC_RSSRK(i), hash_key[i]);
+			E1000_WRITE_REG_LE_VALUE(hw, E1000_RSSRK(i), hash_key[i]);
 	}
 
 	/* Set configured hashing protocols in MRQC register */
 	rss_hf = rss_conf->rss_hf;
-	mrqc = IGC_MRQC_ENABLE_RSS_4Q; /* RSS enabled. */
+	mrqc = E1000_MRQC_ENABLE_RSS_4Q; /* RSS enabled. */
 	if (rss_hf & RTE_ETH_RSS_IPV4)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV4;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV4;
 	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_TCP)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV4_TCP;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV4_TCP;
 	if (rss_hf & RTE_ETH_RSS_IPV6)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6;
 	if (rss_hf & RTE_ETH_RSS_IPV6_EX)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_EX;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_EX;
 	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_TCP)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_TCP;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_TCP;
 	if (rss_hf & RTE_ETH_RSS_IPV6_TCP_EX)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_TCP_EX;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_TCP_EX;
 	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV4_UDP)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV4_UDP;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV4_UDP;
 	if (rss_hf & RTE_ETH_RSS_NONFRAG_IPV6_UDP)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_UDP;
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_UDP;
 	if (rss_hf & RTE_ETH_RSS_IPV6_UDP_EX)
-		mrqc |= IGC_MRQC_RSS_FIELD_IPV6_UDP_EX;
-	IGC_WRITE_REG(hw, IGC_MRQC, mrqc);
+		mrqc |= E1000_MRQC_RSS_FIELD_IPV6_UDP_EX;
+	E1000_WRITE_REG(hw, E1000_MRQC, mrqc);
 }
 
 static void
 igc_rss_configure(struct rte_eth_dev *dev)
 {
 	struct rte_eth_rss_conf rss_conf;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint16_t i;
 
 	/* Fill in redirection table. */
@@ -833,8 +833,8 @@ igc_rss_configure(struct rte_eth_dev *dev)
 		reta_idx = i % sizeof(reta);
 		reta.bytes[reta_idx] = q_idx;
 		if (reta_idx == sizeof(reta) - 1)
-			IGC_WRITE_REG_LE_VALUE(hw,
-				IGC_RETA(i / sizeof(reta)), reta.dword);
+			E1000_WRITE_REG_LE_VALUE(hw,
+				E1000_RETA(i / sizeof(reta)), reta.dword);
 	}
 
 	/*
@@ -903,7 +903,7 @@ igc_add_rss_filter(struct rte_eth_dev *dev, struct igc_rss_filter *rss)
 		.rss_key_len = rss->conf.key_len,
 		.rss_hf = rss->conf.types,
 	};
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_rss_filter *rss_filter = IGC_DEV_PRIVATE_RSS_FILTER(dev);
 	uint32_t i, j;
 
@@ -950,8 +950,8 @@ igc_add_rss_filter(struct rte_eth_dev *dev, struct igc_rss_filter *rss)
 		reta_idx = i % sizeof(reta);
 		reta.bytes[reta_idx] = q_idx;
 		if (reta_idx == sizeof(reta) - 1)
-			IGC_WRITE_REG_LE_VALUE(hw,
-				IGC_RETA(i / sizeof(reta)), reta.dword);
+			E1000_WRITE_REG_LE_VALUE(hw,
+				E1000_RETA(i / sizeof(reta)), reta.dword);
 	}
 
 	if (rss_conf.rss_key == NULL)
@@ -1008,7 +1008,7 @@ int
 igc_rx_init(struct rte_eth_dev *dev)
 {
 	struct igc_rx_queue *rxq;
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint64_t offloads = dev->data->dev_conf.rxmode.offloads;
 	uint32_t max_rx_pktlen;
 	uint32_t rctl;
@@ -1024,21 +1024,21 @@ igc_rx_init(struct rte_eth_dev *dev)
 	 * Make sure receives are disabled while setting
 	 * up the descriptor ring.
 	 */
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl & ~IGC_RCTL_EN);
+	rctl = E1000_READ_REG(hw, E1000_RCTL);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl & ~E1000_RCTL_EN);
 
 	/* Configure support of jumbo frames, if any. */
 	if (dev->data->mtu > RTE_ETHER_MTU)
-		rctl |= IGC_RCTL_LPE;
+		rctl |= E1000_RCTL_LPE;
 	else
-		rctl &= ~IGC_RCTL_LPE;
+		rctl &= ~E1000_RCTL_LPE;
 
 	max_rx_pktlen = dev->data->mtu + IGC_ETH_OVERHEAD;
 	/*
 	 * Set maximum packet length by default, and might be updated
 	 * together with enabling/disabling dual VLAN.
 	 */
-	IGC_WRITE_REG(hw, IGC_RLPML, max_rx_pktlen);
+	E1000_WRITE_REG(hw, E1000_RLPML, max_rx_pktlen);
 
 	/* Configure and enable each RX queue. */
 	rctl_bsize = 0;
@@ -1066,16 +1066,16 @@ igc_rx_init(struct rte_eth_dev *dev)
 				RTE_ETHER_CRC_LEN : 0;
 
 		bus_addr = rxq->rx_ring_phys_addr;
-		IGC_WRITE_REG(hw, IGC_RDLEN(rxq->reg_idx),
+		E1000_WRITE_REG(hw, E1000_RDLEN(rxq->reg_idx),
 				rxq->nb_rx_desc *
-				sizeof(union igc_adv_rx_desc));
-		IGC_WRITE_REG(hw, IGC_RDBAH(rxq->reg_idx),
+				sizeof(union e1000_adv_rx_desc));
+		E1000_WRITE_REG(hw, E1000_RDBAH(rxq->reg_idx),
 				(uint32_t)(bus_addr >> 32));
-		IGC_WRITE_REG(hw, IGC_RDBAL(rxq->reg_idx),
+		E1000_WRITE_REG(hw, E1000_RDBAL(rxq->reg_idx),
 				(uint32_t)bus_addr);
 
 		/* set descriptor configuration */
-		srrctl = IGC_SRRCTL_DESCTYPE_ADV_ONEBUF;
+		srrctl = E1000_SRRCTL_DESCTYPE_ADV_ONEBUF;
 
 		srrctl |= (uint32_t)(RTE_PKTMBUF_HEADROOM / 64) <<
 				IGC_SRRCTL_BSIZEHEADER_SHIFT;
@@ -1093,11 +1093,11 @@ igc_rx_init(struct rte_eth_dev *dev)
 			 * determines the RX packet buffer size.
 			 */
 
-			srrctl |= ((buf_size >> IGC_SRRCTL_BSIZEPKT_SHIFT) &
-				   IGC_SRRCTL_BSIZEPKT_MASK);
+			srrctl |= ((buf_size >> E1000_SRRCTL_BSIZEPKT_SHIFT) &
+				   E1000_SRRCTL_BSIZEPKT_MASK);
 			buf_size = (uint16_t)((srrctl &
-					IGC_SRRCTL_BSIZEPKT_MASK) <<
-					IGC_SRRCTL_BSIZEPKT_SHIFT);
+					E1000_SRRCTL_BSIZEPKT_MASK) <<
+					E1000_SRRCTL_BSIZEPKT_SHIFT);
 
 			/* It adds dual VLAN length for supporting dual VLAN */
 			if (max_rx_pktlen > buf_size)
@@ -1113,19 +1113,19 @@ igc_rx_init(struct rte_eth_dev *dev)
 
 		/* Set if packets are dropped when no descriptors available */
 		if (rxq->drop_en)
-			srrctl |= IGC_SRRCTL_DROP_EN;
+			srrctl |= E1000_SRRCTL_DROP_EN;
 
-		IGC_WRITE_REG(hw, IGC_SRRCTL(rxq->reg_idx), srrctl);
+		E1000_WRITE_REG(hw, E1000_SRRCTL(rxq->reg_idx), srrctl);
 
 		/* Enable this RX queue. */
-		rxdctl = IGC_RXDCTL_QUEUE_ENABLE;
+		rxdctl = E1000_RXDCTL_QUEUE_ENABLE;
 		rxdctl |= ((uint32_t)rxq->pthresh << IGC_RXDCTL_PTHRESH_SHIFT) &
 				IGC_RXDCTL_PTHRESH_MSK;
 		rxdctl |= ((uint32_t)rxq->hthresh << IGC_RXDCTL_HTHRESH_SHIFT) &
 				IGC_RXDCTL_HTHRESH_MSK;
 		rxdctl |= ((uint32_t)rxq->wthresh << IGC_RXDCTL_WTHRESH_SHIFT) &
 				IGC_RXDCTL_WTHRESH_MSK;
-		IGC_WRITE_REG(hw, IGC_RXDCTL(rxq->reg_idx), rxdctl);
+		E1000_WRITE_REG(hw, E1000_RXDCTL(rxq->reg_idx), rxdctl);
 	}
 
 	if (offloads & RTE_ETH_RX_OFFLOAD_SCATTER)
@@ -1141,19 +1141,19 @@ igc_rx_init(struct rte_eth_dev *dev)
 	 * register, since the code above configures the SRRCTL register of
 	 * the RX queue in such a case.
 	 * All configurable sizes are:
-	 * 16384: rctl |= (IGC_RCTL_SZ_16384 | IGC_RCTL_BSEX);
-	 *  8192: rctl |= (IGC_RCTL_SZ_8192  | IGC_RCTL_BSEX);
-	 *  4096: rctl |= (IGC_RCTL_SZ_4096  | IGC_RCTL_BSEX);
-	 *  2048: rctl |= IGC_RCTL_SZ_2048;
-	 *  1024: rctl |= IGC_RCTL_SZ_1024;
-	 *   512: rctl |= IGC_RCTL_SZ_512;
-	 *   256: rctl |= IGC_RCTL_SZ_256;
+	 * 16384: rctl |= (E1000_RCTL_SZ_16384 | E1000_RCTL_BSEX);
+	 *  8192: rctl |= (E1000_RCTL_SZ_8192  | E1000_RCTL_BSEX);
+	 *  4096: rctl |= (E1000_RCTL_SZ_4096  | E1000_RCTL_BSEX);
+	 *  2048: rctl |= E1000_RCTL_SZ_2048;
+	 *  1024: rctl |= E1000_RCTL_SZ_1024;
+	 *   512: rctl |= E1000_RCTL_SZ_512;
+	 *   256: rctl |= E1000_RCTL_SZ_256;
 	 */
 	if (rctl_bsize > 0) {
 		if (rctl_bsize >= 512) /* 512 <= buf_size < 1024 - use 512 */
-			rctl |= IGC_RCTL_SZ_512;
+			rctl |= E1000_RCTL_SZ_512;
 		else /* 256 <= buf_size < 512 - use 256 */
-			rctl |= IGC_RCTL_SZ_256;
+			rctl |= E1000_RCTL_SZ_256;
 	}
 
 	/*
@@ -1162,61 +1162,61 @@ igc_rx_init(struct rte_eth_dev *dev)
 	igc_dev_mq_rx_configure(dev);
 
 	/* Update the rctl since igc_dev_mq_rx_configure may change its value */
-	rctl |= IGC_READ_REG(hw, IGC_RCTL);
+	rctl |= E1000_READ_REG(hw, E1000_RCTL);
 
 	/*
 	 * Setup the Checksum Register.
 	 * Receive Full-Packet Checksum Offload is mutually exclusive with RSS.
 	 */
-	rxcsum = IGC_READ_REG(hw, IGC_RXCSUM);
-	rxcsum |= IGC_RXCSUM_PCSD;
+	rxcsum = E1000_READ_REG(hw, E1000_RXCSUM);
+	rxcsum |= E1000_RXCSUM_PCSD;
 
 	/* Enable both L3/L4 rx checksum offload */
 	if (offloads & RTE_ETH_RX_OFFLOAD_IPV4_CKSUM)
-		rxcsum |= IGC_RXCSUM_IPOFL;
+		rxcsum |= E1000_RXCSUM_IPOFL;
 	else
-		rxcsum &= ~IGC_RXCSUM_IPOFL;
+		rxcsum &= ~E1000_RXCSUM_IPOFL;
 
 	if (offloads &
 		(RTE_ETH_RX_OFFLOAD_TCP_CKSUM | RTE_ETH_RX_OFFLOAD_UDP_CKSUM)) {
-		rxcsum |= IGC_RXCSUM_TUOFL;
+		rxcsum |= E1000_RXCSUM_TUOFL;
 		offloads |= RTE_ETH_RX_OFFLOAD_SCTP_CKSUM;
 	} else {
-		rxcsum &= ~IGC_RXCSUM_TUOFL;
+		rxcsum &= ~E1000_RXCSUM_TUOFL;
 	}
 
 	if (offloads & RTE_ETH_RX_OFFLOAD_SCTP_CKSUM)
-		rxcsum |= IGC_RXCSUM_CRCOFL;
+		rxcsum |= E1000_RXCSUM_CRCOFL;
 	else
-		rxcsum &= ~IGC_RXCSUM_CRCOFL;
+		rxcsum &= ~E1000_RXCSUM_CRCOFL;
 
-	IGC_WRITE_REG(hw, IGC_RXCSUM, rxcsum);
+	E1000_WRITE_REG(hw, E1000_RXCSUM, rxcsum);
 
 	/* Setup the Receive Control Register. */
 	if (offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
-		rctl &= ~IGC_RCTL_SECRC; /* Do not Strip Ethernet CRC. */
+		rctl &= ~E1000_RCTL_SECRC; /* Do not Strip Ethernet CRC. */
 	else
-		rctl |= IGC_RCTL_SECRC; /* Strip Ethernet CRC. */
+		rctl |= E1000_RCTL_SECRC; /* Strip Ethernet CRC. */
 
-	rctl &= ~IGC_RCTL_MO_MSK;
-	rctl &= ~IGC_RCTL_LBM_MSK;
-	rctl |= IGC_RCTL_EN | IGC_RCTL_BAM | IGC_RCTL_LBM_NO |
-			IGC_RCTL_DPF |
-			(hw->mac.mc_filter_type << IGC_RCTL_MO_SHIFT);
+	rctl &= ~E1000_RCTL_MO_MSK;
+	rctl &= ~E1000_RCTL_LBM_MSK;
+	rctl |= E1000_RCTL_EN | E1000_RCTL_BAM | E1000_RCTL_LBM_NO |
+			E1000_RCTL_DPF |
+			(hw->mac.mc_filter_type << E1000_RCTL_MO_SHIFT);
 
 	if (dev->data->dev_conf.lpbk_mode == 1)
-		rctl |= IGC_RCTL_LBM_MAC;
+		rctl |= E1000_RCTL_LBM_MAC;
 
-	rctl &= ~(IGC_RCTL_HSEL_MSK | IGC_RCTL_CFIEN | IGC_RCTL_CFI |
-			IGC_RCTL_PSP | IGC_RCTL_PMCF);
+	rctl &= ~(E1000_RCTL_HSEL_MSK | E1000_RCTL_CFIEN | E1000_RCTL_CFI |
+			E1000_RCTL_PSP | E1000_RCTL_PMCF);
 
 	/* Make sure VLAN Filters are off. */
-	rctl &= ~IGC_RCTL_VFE;
+	rctl &= ~E1000_RCTL_VFE;
 	/* Don't store bad packets. */
-	rctl &= ~IGC_RCTL_SBP;
+	rctl &= ~E1000_RCTL_SBP;
 
 	/* Enable Receives. */
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
+	E1000_WRITE_REG(hw, E1000_RCTL, rctl);
 
 	/*
 	 * Setup the HW Rx Head and Tail Descriptor Pointers.
@@ -1226,21 +1226,21 @@ igc_rx_init(struct rte_eth_dev *dev)
 		uint32_t dvmolr;
 
 		rxq = dev->data->rx_queues[i];
-		IGC_WRITE_REG(hw, IGC_RDH(rxq->reg_idx), 0);
-		IGC_WRITE_REG(hw, IGC_RDT(rxq->reg_idx), rxq->nb_rx_desc - 1);
+		E1000_WRITE_REG(hw, E1000_RDH(rxq->reg_idx), 0);
+		E1000_WRITE_REG(hw, E1000_RDT(rxq->reg_idx), rxq->nb_rx_desc - 1);
 
-		dvmolr = IGC_READ_REG(hw, IGC_DVMOLR(rxq->reg_idx));
+		dvmolr = E1000_READ_REG(hw, E1000_DVMOLR(rxq->reg_idx));
 		if (rxq->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
-			dvmolr |= IGC_DVMOLR_STRVLAN;
+			dvmolr |= E1000_DVMOLR_STRVLAN;
 		else
-			dvmolr &= ~IGC_DVMOLR_STRVLAN;
+			dvmolr &= ~E1000_DVMOLR_STRVLAN;
 
 		if (offloads & RTE_ETH_RX_OFFLOAD_KEEP_CRC)
-			dvmolr &= ~IGC_DVMOLR_STRCRC;
+			dvmolr &= ~E1000_DVMOLR_STRCRC;
 		else
-			dvmolr |= IGC_DVMOLR_STRCRC;
+			dvmolr |= E1000_DVMOLR_STRCRC;
 
-		IGC_WRITE_REG(hw, IGC_DVMOLR(rxq->reg_idx), dvmolr);
+		E1000_WRITE_REG(hw, E1000_DVMOLR(rxq->reg_idx), dvmolr);
 		dev->data->rx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 	}
 
@@ -1250,7 +1250,7 @@ igc_rx_init(struct rte_eth_dev *dev)
 static void
 igc_reset_rx_queue(struct igc_rx_queue *rxq)
 {
-	static const union igc_adv_rx_desc zeroed_desc = { {0} };
+	static const union e1000_adv_rx_desc zeroed_desc = { {0} };
 	unsigned int i;
 
 	/* Zero out HW ring memory */
@@ -1270,7 +1270,7 @@ eth_igc_rx_queue_setup(struct rte_eth_dev *dev,
 			 const struct rte_eth_rxconf *rx_conf,
 			 struct rte_mempool *mp)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	const struct rte_memzone *rz;
 	struct igc_rx_queue *rxq;
 	unsigned int size;
@@ -1317,17 +1317,17 @@ eth_igc_rx_queue_setup(struct rte_eth_dev *dev,
 	 *  handle the maximum ring size is allocated in order to allow for
 	 *  resizing in later calls to the queue setup function.
 	 */
-	size = sizeof(union igc_adv_rx_desc) * IGC_MAX_RXD;
+	size = sizeof(union e1000_adv_rx_desc) * IGC_MAX_RXD;
 	rz = rte_eth_dma_zone_reserve(dev, "rx_ring", queue_idx, size,
 				      IGC_ALIGN, socket_id);
 	if (rz == NULL) {
 		igc_rx_queue_release(rxq);
 		return -ENOMEM;
 	}
-	rxq->rdt_reg_addr = IGC_PCI_REG_ADDR(hw, IGC_RDT(rxq->reg_idx));
-	rxq->rdh_reg_addr = IGC_PCI_REG_ADDR(hw, IGC_RDH(rxq->reg_idx));
+	rxq->rdt_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_RDT(rxq->reg_idx));
+	rxq->rdh_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_RDH(rxq->reg_idx));
 	rxq->rx_ring_phys_addr = rz->iova;
-	rxq->rx_ring = (union igc_adv_rx_desc *)rz->addr;
+	rxq->rx_ring = (union e1000_adv_rx_desc *)rz->addr;
 
 	/* Allocate software ring. */
 	rxq->sw_ring = rte_zmalloc("rxq->sw_ring",
@@ -1457,7 +1457,7 @@ static uint32_t igc_tx_launchtime(uint64_t txtime, uint16_t port_id)
  */
 static inline void
 igc_set_xmit_ctx(struct igc_tx_queue *txq,
-		volatile struct igc_adv_tx_context_desc *ctx_txd,
+		volatile struct e1000_adv_tx_context_desc *ctx_txd,
 		uint64_t ol_flags, union igc_tx_offload tx_offload,
 		uint64_t txtime)
 {
@@ -1475,7 +1475,7 @@ igc_set_xmit_ctx(struct igc_tx_queue *txq,
 	type_tucmd_mlhl = 0;
 
 	/* Specify which HW CTX to upload. */
-	mss_l4len_idx = (ctx_curr << IGC_ADVTXD_IDX_SHIFT);
+	mss_l4len_idx = (ctx_curr << E1000_ADVTXD_IDX_SHIFT);
 
 	if (ol_flags & RTE_MBUF_F_TX_VLAN)
 		tx_offload_mask.vlan_tci = 0xffff;
@@ -1484,51 +1484,51 @@ igc_set_xmit_ctx(struct igc_tx_queue *txq,
 	if (ol_flags & IGC_TX_OFFLOAD_SEG) {
 		/* implies IP cksum in IPv4 */
 		if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM)
-			type_tucmd_mlhl = IGC_ADVTXD_TUCMD_IPV4 |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl = E1000_ADVTXD_TUCMD_IPV4 |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 		else
-			type_tucmd_mlhl = IGC_ADVTXD_TUCMD_IPV6 |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl = E1000_ADVTXD_TUCMD_IPV6 |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 
 		if (ol_flags & RTE_MBUF_F_TX_TCP_SEG)
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_TCP;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_TCP;
 		else
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_UDP;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_UDP;
 
 		tx_offload_mask.data |= TX_TSO_CMP_MASK;
 		mss_l4len_idx |= (uint32_t)tx_offload.tso_segsz <<
-				IGC_ADVTXD_MSS_SHIFT;
+				E1000_ADVTXD_MSS_SHIFT;
 		mss_l4len_idx |= (uint32_t)tx_offload.l4_len <<
-				IGC_ADVTXD_L4LEN_SHIFT;
+				E1000_ADVTXD_L4LEN_SHIFT;
 	} else { /* no TSO, check if hardware checksum is needed */
 		if (ol_flags & (RTE_MBUF_F_TX_IP_CKSUM | RTE_MBUF_F_TX_L4_MASK))
 			tx_offload_mask.data |= TX_MACIP_LEN_CMP_MASK;
 
 		if (ol_flags & RTE_MBUF_F_TX_IP_CKSUM)
-			type_tucmd_mlhl = IGC_ADVTXD_TUCMD_IPV4;
+			type_tucmd_mlhl = E1000_ADVTXD_TUCMD_IPV4;
 
 		switch (ol_flags & RTE_MBUF_F_TX_L4_MASK) {
 		case RTE_MBUF_F_TX_TCP_CKSUM:
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_TCP |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_TCP |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 			mss_l4len_idx |= (uint32_t)sizeof(struct rte_tcp_hdr)
-				<< IGC_ADVTXD_L4LEN_SHIFT;
+				<< E1000_ADVTXD_L4LEN_SHIFT;
 			break;
 		case RTE_MBUF_F_TX_UDP_CKSUM:
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_UDP |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_UDP |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 			mss_l4len_idx |= (uint32_t)sizeof(struct rte_udp_hdr)
-				<< IGC_ADVTXD_L4LEN_SHIFT;
+				<< E1000_ADVTXD_L4LEN_SHIFT;
 			break;
 		case RTE_MBUF_F_TX_SCTP_CKSUM:
-			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_SCTP |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+			type_tucmd_mlhl |= E1000_ADVTXD_TUCMD_L4T_SCTP |
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 			mss_l4len_idx |= (uint32_t)sizeof(struct rte_sctp_hdr)
-				<< IGC_ADVTXD_L4LEN_SHIFT;
+				<< E1000_ADVTXD_L4LEN_SHIFT;
 			break;
 		default:
 			type_tucmd_mlhl |= IGC_ADVTXD_TUCMD_L4T_RSV |
-				IGC_ADVTXD_DTYP_CTXT | IGC_ADVTXD_DCMD_DEXT;
+				E1000_ADVTXD_DTYP_CTXT | E1000_ADVTXD_DCMD_DEXT;
 			break;
 		}
 	}
@@ -1556,8 +1556,8 @@ static inline uint32_t
 tx_desc_vlan_flags_to_cmdtype(uint64_t ol_flags)
 {
 	uint32_t cmdtype;
-	static uint32_t vlan_cmd[2] = {0, IGC_ADVTXD_DCMD_VLE};
-	static uint32_t tso_cmd[2] = {0, IGC_ADVTXD_DCMD_TSE};
+	static uint32_t vlan_cmd[2] = {0, E1000_ADVTXD_DCMD_VLE};
+	static uint32_t tso_cmd[2] = {0, E1000_ADVTXD_DCMD_TSE};
 	cmdtype = vlan_cmd[(ol_flags & RTE_MBUF_F_TX_VLAN) != 0];
 	cmdtype |= tso_cmd[(ol_flags & IGC_TX_OFFLOAD_SEG) != 0];
 	return cmdtype;
@@ -1582,8 +1582,8 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	struct igc_tx_queue * const txq = tx_queue;
 	struct igc_tx_entry * const sw_ring = txq->sw_ring;
 	struct igc_tx_entry *txe, *txn;
-	volatile union igc_adv_tx_desc * const txr = txq->tx_ring;
-	volatile union igc_adv_tx_desc *txd;
+	volatile union e1000_adv_tx_desc * const txr = txq->tx_ring;
+	volatile union e1000_adv_tx_desc *txd;
 	struct rte_mbuf *tx_pkt;
 	struct rte_mbuf *m_seg;
 	uint64_t buf_dma_addr;
@@ -1691,7 +1691,7 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		/*
 		 * Check that this descriptor is free.
 		 */
-		if (!(txr[tx_end].wb.status & IGC_TXD_STAT_DD)) {
+		if (!(txr[tx_end].wb.status & E1000_TXD_STAT_DD)) {
 			if (nb_tx == 0)
 				return 0;
 			goto end_of_tx;
@@ -1701,43 +1701,43 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		 * Set common flags of all TX Data Descriptors.
 		 *
 		 * The following bits must be set in all Data Descriptors:
-		 *   - IGC_ADVTXD_DTYP_DATA
-		 *   - IGC_ADVTXD_DCMD_DEXT
+		 *   - E1000_ADVTXD_DTYP_DATA
+		 *   - E1000_ADVTXD_DCMD_DEXT
 		 *
 		 * The following bits must be set in the first Data Descriptor
 		 * and are ignored in the other ones:
-		 *   - IGC_ADVTXD_DCMD_IFCS
-		 *   - IGC_ADVTXD_MAC_1588
-		 *   - IGC_ADVTXD_DCMD_VLE
+		 *   - E1000_ADVTXD_DCMD_IFCS
+		 *   - E1000_ADVTXD_MAC_1588
+		 *   - E1000_ADVTXD_DCMD_VLE
 		 *
 		 * The following bits must only be set in the last Data
 		 * Descriptor:
-		 *   - IGC_TXD_CMD_EOP
+		 *   - E1000_TXD_CMD_EOP
 		 *
 		 * The following bits can be set in any Data Descriptor, but
 		 * are only set in the last Data Descriptor:
-		 *   - IGC_TXD_CMD_RS
+		 *   - E1000_TXD_CMD_RS
 		 */
 		cmd_type_len = txq->txd_type |
-			IGC_ADVTXD_DCMD_IFCS | IGC_ADVTXD_DCMD_DEXT;
+			E1000_ADVTXD_DCMD_IFCS | E1000_ADVTXD_DCMD_DEXT;
 		if (tx_ol_req & IGC_TX_OFFLOAD_SEG)
 			pkt_len -= (tx_pkt->l2_len + tx_pkt->l3_len +
 					tx_pkt->l4_len);
-		olinfo_status = (pkt_len << IGC_ADVTXD_PAYLEN_SHIFT);
+		olinfo_status = (pkt_len << E1000_ADVTXD_PAYLEN_SHIFT);
 
 		/*
 		 * Timer 0 should be used to for packet timestamping,
 		 * sample the packet timestamp to reg 0
 		 */
 		if (ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST)
-			cmd_type_len |= IGC_ADVTXD_MAC_TSTAMP;
+			cmd_type_len |= E1000_ADVTXD_MAC_TSTAMP;
 
 		if (tx_ol_req) {
 			/* Setup TX Advanced context descriptor if required */
 			if (new_ctx) {
-				volatile struct igc_adv_tx_context_desc *
+				volatile struct e1000_adv_tx_context_desc *
 					ctx_txd = (volatile struct
-					igc_adv_tx_context_desc *)&txr[tx_id];
+					e1000_adv_tx_context_desc *)&txr[tx_id];
 
 				txn = &sw_ring[txe->next_id];
 				RTE_MBUF_PREFETCH_TO_FREE(txn->mbuf);
@@ -1769,7 +1769,7 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 			olinfo_status |=
 				tx_desc_cksum_flags_to_olinfo(tx_ol_req);
 			olinfo_status |= (uint32_t)txq->ctx_curr <<
-					IGC_ADVTXD_IDX_SHIFT;
+					E1000_ADVTXD_IDX_SHIFT;
 		}
 
 		m_seg = tx_pkt;
@@ -1803,7 +1803,7 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		 * and Report Status (RS).
 		 */
 		txd->read.cmd_type_len |=
-			rte_cpu_to_le_32(IGC_TXD_CMD_EOP | IGC_TXD_CMD_RS);
+			rte_cpu_to_le_32(E1000_TXD_CMD_EOP | E1000_TXD_CMD_RS);
 	}
 end_of_tx:
 	rte_wmb();
@@ -1811,7 +1811,7 @@ igc_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 	/*
 	 * Set the Transmit Descriptor Tail (TDT).
 	 */
-	IGC_PCI_REG_WRITE_RELAXED(txq->tdt_reg_addr, tx_id);
+	E1000_PCI_REG_WRITE_RELAXED(txq->tdt_reg_addr, tx_id);
 	PMD_TX_LOG(DEBUG, "port_id=%u queue_id=%u tx_tail=%u nb_tx=%u",
 		txq->port_id, txq->queue_id, tx_id, nb_tx);
 	txq->tx_tail = tx_id;
@@ -1833,7 +1833,7 @@ int eth_igc_tx_descriptor_status(void *tx_queue, uint16_t offset)
 		desc -= txq->nb_tx_desc;
 
 	status = &txq->tx_ring[desc].wb.status;
-	if (*status & rte_cpu_to_le_32(IGC_TXD_STAT_DD))
+	if (*status & rte_cpu_to_le_32(E1000_TXD_STAT_DD))
 		return RTE_ETH_TX_DESC_DONE;
 
 	return RTE_ETH_TX_DESC_FULL;
@@ -1887,16 +1887,16 @@ igc_reset_tx_queue(struct igc_tx_queue *txq)
 	/* Initialize ring entries */
 	prev = (uint16_t)(txq->nb_tx_desc - 1);
 	for (i = 0; i < txq->nb_tx_desc; i++) {
-		volatile union igc_adv_tx_desc *txd = &txq->tx_ring[i];
+		volatile union e1000_adv_tx_desc *txd = &txq->tx_ring[i];
 
-		txd->wb.status = IGC_TXD_STAT_DD;
+		txd->wb.status = E1000_TXD_STAT_DD;
 		txe[i].mbuf = NULL;
 		txe[i].last_id = i;
 		txe[prev].next_id = i;
 		prev = i;
 	}
 
-	txq->txd_type = IGC_ADVTXD_DTYP_DATA;
+	txq->txd_type = E1000_ADVTXD_DTYP_DATA;
 	igc_reset_tx_queue_stat(txq);
 }
 
@@ -1935,7 +1935,7 @@ int eth_igc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 {
 	const struct rte_memzone *tz;
 	struct igc_tx_queue *txq;
-	struct igc_hw *hw;
+	struct e1000_hw *hw;
 	uint32_t size;
 
 	if (nb_desc % IGC_TX_DESCRIPTOR_MULTIPLE != 0 ||
@@ -1980,7 +1980,7 @@ int eth_igc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	 * handle the maximum ring size is allocated in order to allow for
 	 * resizing in later calls to the queue setup function.
 	 */
-	size = sizeof(union igc_adv_tx_desc) * IGC_MAX_TXD;
+	size = sizeof(union e1000_adv_tx_desc) * IGC_MAX_TXD;
 	tz = rte_eth_dma_zone_reserve(dev, "tx_ring", queue_idx, size,
 				      IGC_ALIGN, socket_id);
 	if (tz == NULL) {
@@ -1997,10 +1997,10 @@ int eth_igc_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	txq->reg_idx = queue_idx;
 	txq->port_id = dev->data->port_id;
 
-	txq->tdt_reg_addr = IGC_PCI_REG_ADDR(hw, IGC_TDT(txq->reg_idx));
+	txq->tdt_reg_addr = E1000_PCI_REG_ADDR(hw, E1000_TDT(txq->reg_idx));
 	txq->tx_ring_phys_addr = tz->iova;
 
-	txq->tx_ring = (union igc_adv_tx_desc *)tz->addr;
+	txq->tx_ring = (union e1000_adv_tx_desc *)tz->addr;
 	/* Allocate software ring */
 	txq->sw_ring = rte_zmalloc("txq->sw_ring",
 				   sizeof(struct igc_tx_entry) * nb_desc,
@@ -2026,7 +2026,7 @@ eth_igc_tx_done_cleanup(void *txqueue, uint32_t free_cnt)
 {
 	struct igc_tx_queue *txq = txqueue;
 	struct igc_tx_entry *sw_ring;
-	volatile union igc_adv_tx_desc *txr;
+	volatile union e1000_adv_tx_desc *txr;
 	uint16_t tx_first; /* First segment analyzed. */
 	uint16_t tx_id;    /* Current segment being processed. */
 	uint16_t tx_last;  /* Last segment in the current packet. */
@@ -2067,7 +2067,7 @@ eth_igc_tx_done_cleanup(void *txqueue, uint32_t free_cnt)
 
 		if (sw_ring[tx_last].mbuf) {
 			if (!(txr[tx_last].wb.status &
-					rte_cpu_to_le_32(IGC_TXD_STAT_DD)))
+					rte_cpu_to_le_32(E1000_TXD_STAT_DD)))
 				break;
 
 			/* Get the start of the next packet. */
@@ -2139,7 +2139,7 @@ eth_igc_tx_done_cleanup(void *txqueue, uint32_t free_cnt)
 void
 igc_tx_init(struct rte_eth_dev *dev)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	uint64_t offloads = dev->data->dev_conf.txmode.offloads;
 	uint32_t tctl;
 	uint32_t txdctl;
@@ -2151,17 +2151,17 @@ igc_tx_init(struct rte_eth_dev *dev)
 		struct igc_tx_queue *txq = dev->data->tx_queues[i];
 		uint64_t bus_addr = txq->tx_ring_phys_addr;
 
-		IGC_WRITE_REG(hw, IGC_TDLEN(txq->reg_idx),
+		E1000_WRITE_REG(hw, E1000_TDLEN(txq->reg_idx),
 				txq->nb_tx_desc *
-				sizeof(union igc_adv_tx_desc));
-		IGC_WRITE_REG(hw, IGC_TDBAH(txq->reg_idx),
+				sizeof(union e1000_adv_tx_desc));
+		E1000_WRITE_REG(hw, E1000_TDBAH(txq->reg_idx),
 				(uint32_t)(bus_addr >> 32));
-		IGC_WRITE_REG(hw, IGC_TDBAL(txq->reg_idx),
+		E1000_WRITE_REG(hw, E1000_TDBAL(txq->reg_idx),
 				(uint32_t)bus_addr);
 
 		/* Setup the HW Tx Head and Tail descriptor pointers. */
-		IGC_WRITE_REG(hw, IGC_TDT(txq->reg_idx), 0);
-		IGC_WRITE_REG(hw, IGC_TDH(txq->reg_idx), 0);
+		E1000_WRITE_REG(hw, E1000_TDT(txq->reg_idx), 0);
+		E1000_WRITE_REG(hw, E1000_TDH(txq->reg_idx), 0);
 
 		/* Setup Transmit threshold registers. */
 		txdctl = ((uint32_t)txq->pthresh << IGC_TXDCTL_PTHRESH_SHIFT) &
@@ -2170,8 +2170,8 @@ igc_tx_init(struct rte_eth_dev *dev)
 				IGC_TXDCTL_HTHRESH_MSK;
 		txdctl |= ((uint32_t)txq->wthresh << IGC_TXDCTL_WTHRESH_SHIFT) &
 				IGC_TXDCTL_WTHRESH_MSK;
-		txdctl |= IGC_TXDCTL_QUEUE_ENABLE;
-		IGC_WRITE_REG(hw, IGC_TXDCTL(txq->reg_idx), txdctl);
+		txdctl |= E1000_TXDCTL_QUEUE_ENABLE;
+		E1000_WRITE_REG(hw, E1000_TXDCTL(txq->reg_idx), txdctl);
 		dev->data->tx_queue_state[i] = RTE_ETH_QUEUE_STATE_STARTED;
 	}
 
@@ -2185,16 +2185,16 @@ igc_tx_init(struct rte_eth_dev *dev)
 		}
 	}
 
-	igc_config_collision_dist(hw);
+	e1000_config_collision_dist(hw);
 
 	/* Program the Transmit Control Register. */
-	tctl = IGC_READ_REG(hw, IGC_TCTL);
-	tctl &= ~IGC_TCTL_CT;
-	tctl |= (IGC_TCTL_PSP | IGC_TCTL_RTLC | IGC_TCTL_EN |
-		 ((uint32_t)IGC_COLLISION_THRESHOLD << IGC_CT_SHIFT));
+	tctl = E1000_READ_REG(hw, E1000_TCTL);
+	tctl &= ~E1000_TCTL_CT;
+	tctl |= (E1000_TCTL_PSP | E1000_TCTL_RTLC | E1000_TCTL_EN |
+		 ((uint32_t)E1000_COLLISION_THRESHOLD << E1000_CT_SHIFT));
 
 	/* This write will effectively turn on the transmit unit. */
-	IGC_WRITE_REG(hw, IGC_TCTL, tctl);
+	E1000_WRITE_REG(hw, E1000_TCTL, tctl);
 }
 
 void
@@ -2237,7 +2237,7 @@ void
 eth_igc_vlan_strip_queue_set(struct rte_eth_dev *dev,
 			uint16_t rx_queue_id, int on)
 {
-	struct igc_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 	struct igc_rx_queue *rxq = dev->data->rx_queues[rx_queue_id];
 	uint32_t reg_val;
 
@@ -2247,14 +2247,14 @@ eth_igc_vlan_strip_queue_set(struct rte_eth_dev *dev,
 		return;
 	}
 
-	reg_val = IGC_READ_REG(hw, IGC_DVMOLR(rx_queue_id));
+	reg_val = E1000_READ_REG(hw, E1000_DVMOLR(rx_queue_id));
 	if (on) {
-		reg_val |= IGC_DVMOLR_STRVLAN;
+		reg_val |= E1000_DVMOLR_STRVLAN;
 		rxq->offloads |= RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 	} else {
-		reg_val &= ~(IGC_DVMOLR_STRVLAN | IGC_DVMOLR_HIDVLAN);
+		reg_val &= ~(E1000_DVMOLR_STRVLAN | E1000_DVMOLR_HIDVLAN);
 		rxq->offloads &= ~RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 	}
 
-	IGC_WRITE_REG(hw, IGC_DVMOLR(rx_queue_id), reg_val);
+	E1000_WRITE_REG(hw, E1000_DVMOLR(rx_queue_id), reg_val);
 }
diff --git a/drivers/net/intel/igc/igc_txrx.h b/drivers/net/intel/e1000/igc_txrx.h
similarity index 97%
rename from drivers/net/intel/igc/igc_txrx.h
rename to drivers/net/intel/e1000/igc_txrx.h
index ad7d3b4ca5..1e63ddb5aa 100644
--- a/drivers/net/intel/igc/igc_txrx.h
+++ b/drivers/net/intel/e1000/igc_txrx.h
@@ -23,7 +23,7 @@ struct igc_rx_entry {
  */
 struct igc_rx_queue {
 	struct rte_mempool  *mb_pool;   /**< mbuf pool to populate RX ring. */
-	volatile union igc_adv_rx_desc *rx_ring;
+	volatile union e1000_adv_rx_desc *rx_ring;
 	/**< RX ring virtual address. */
 	uint64_t            rx_ring_phys_addr; /**< RX ring DMA address. */
 	volatile uint32_t   *rdt_reg_addr; /**< RDT register address. */
@@ -107,7 +107,7 @@ struct igc_tx_entry {
  * Structure associated with each TX queue.
  */
 struct igc_tx_queue {
-	volatile union igc_adv_tx_desc *tx_ring; /**< TX ring address */
+	volatile union e1000_adv_tx_desc *tx_ring; /**< TX ring address */
 	uint64_t               tx_ring_phys_addr; /**< TX ring DMA address. */
 	struct igc_tx_entry    *sw_ring; /**< virtual address of SW ring. */
 	volatile uint32_t      *tdt_reg_addr; /**< Address of TDT register. */
@@ -156,7 +156,7 @@ int igc_rx_init(struct rte_eth_dev *dev);
 void igc_tx_init(struct rte_eth_dev *dev);
 void igc_rss_disable(struct rte_eth_dev *dev);
 void
-igc_hw_rss_hash_set(struct igc_hw *hw, struct rte_eth_rss_conf *rss_conf);
+igc_hw_rss_hash_set(struct e1000_hw *hw, struct rte_eth_rss_conf *rss_conf);
 int igc_del_rss_filter(struct rte_eth_dev *dev);
 void igc_rss_conf_set(struct igc_rss_filter *out,
 		const struct rte_flow_action_rss *rss);
diff --git a/drivers/net/intel/e1000/meson.build b/drivers/net/intel/e1000/meson.build
index 296ec25f2c..620c877283 100644
--- a/drivers/net/intel/e1000/meson.build
+++ b/drivers/net/intel/e1000/meson.build
@@ -14,4 +14,15 @@ sources = files(
         'igb_rxtx.c',
 )
 
+# do not build IGC on Windows
+if not is_windows
+    sources += files(
+        'igc_ethdev.c',
+        'igc_logs.c',
+        'igc_filter.c',
+        'igc_flow.c',
+        'igc_txrx.c',
+    )
+endif
+
 includes += include_directories('base')
diff --git a/drivers/net/intel/igc/base/README b/drivers/net/intel/igc/base/README
deleted file mode 100644
index 0ff8307004..0000000000
--- a/drivers/net/intel/igc/base/README
+++ /dev/null
@@ -1,29 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2020 Intel Corporation
- */
-
-Intel® IGC driver
-==================
-
-This directory contains source code of FreeBSD igc driver of version
-2019.10.18 released by the team which develops basic drivers for any
-i225 NIC.
-The directory of base/ contains the original source package.
-This driver is valid for the product(s) listed below
-
-* Intel® Ethernet Network Adapters I225
-
-Updating the driver
-===================
-
-NOTE:
-- To avoid namespace issues with e1000 PMD, all prefix e1000_ or E1000_
-of the definition, macro and file names ware replaced with igc_ or IGC_.
-- Since some codes are not required, they have been removed from the
-base codes, such as the I350 and I210 series NICs related codes.
-- Some registers are used by the base codes but not defined in the base
-codes, so they ware added to them.
-- OS and DPDK specified definitions and macros ware added in following
-files:
-  igc_osdep.h
-  igc_osdep.c
diff --git a/drivers/net/intel/igc/base/igc_82571.h b/drivers/net/intel/igc/base/igc_82571.h
deleted file mode 100644
index 764e77d857..0000000000
--- a/drivers/net/intel/igc/base/igc_82571.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_82571_H_
-#define _IGC_82571_H_
-
-#define ID_LED_RESERVED_F746	0xF746
-#define ID_LED_DEFAULT_82573	((ID_LED_DEF1_DEF2 << 12) | \
-				 (ID_LED_OFF1_ON2  <<  8) | \
-				 (ID_LED_DEF1_DEF2 <<  4) | \
-				 (ID_LED_DEF1_DEF2))
-
-#define IGC_GCR_L1_ACT_WITHOUT_L0S_RX	0x08000000
-#define AN_RETRY_COUNT		5 /* Autoneg Retry Count value */
-
-/* Intr Throttling - RW */
-#define IGC_EITR_82574(_n)	(0x000E8 + (0x4 * (_n)))
-
-#define IGC_EIAC_82574	0x000DC /* Ext. Interrupt Auto Clear - RW */
-#define IGC_EIAC_MASK_82574	0x01F00000
-
-#define IGC_IVAR_INT_ALLOC_VALID	0x8
-
-/* Manageability Operation Mode mask */
-#define IGC_NVM_INIT_CTRL2_MNGM	0x6000
-
-#define IGC_BASE1000T_STATUS		10
-#define IGC_IDLE_ERROR_COUNT_MASK	0xFF
-#define IGC_RECEIVE_ERROR_COUNTER	21
-#define IGC_RECEIVE_ERROR_MAX		0xFFFF
-bool igc_check_phy_82574(struct igc_hw *hw);
-bool igc_get_laa_state_82571(struct igc_hw *hw);
-void igc_set_laa_state_82571(struct igc_hw *hw, bool state);
-
-#endif
diff --git a/drivers/net/intel/igc/base/igc_82575.h b/drivers/net/intel/igc/base/igc_82575.h
deleted file mode 100644
index be060b4071..0000000000
--- a/drivers/net/intel/igc/base/igc_82575.h
+++ /dev/null
@@ -1,351 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_82575_H_
-#define _IGC_82575_H_
-
-#define ID_LED_DEFAULT_82575_SERDES	((ID_LED_DEF1_DEF2 << 12) | \
-					 (ID_LED_DEF1_DEF2 <<  8) | \
-					 (ID_LED_DEF1_DEF2 <<  4) | \
-					 (ID_LED_OFF1_ON2))
-/*
- * Receive Address Register Count
- * Number of high/low register pairs in the RAR.  The RAR (Receive Address
- * Registers) holds the directed and multicast addresses that we monitor.
- * These entries are also used for MAC-based filtering.
- */
-/*
- * For 82576, there are an additional set of RARs that begin at an offset
- * separate from the first set of RARs.
- */
-#define IGC_RAR_ENTRIES_82575	16
-#define IGC_RAR_ENTRIES_82576	24
-#define IGC_RAR_ENTRIES_82580	24
-#define IGC_RAR_ENTRIES_I350	32
-#define IGC_SW_SYNCH_MB	0x00000100
-#define IGC_STAT_DEV_RST_SET	0x00100000
-
-struct igc_adv_data_desc {
-	__le64 buffer_addr;    /* Address of the descriptor's data buffer */
-	union {
-		u32 data;
-		struct {
-			u32 datalen:16; /* Data buffer length */
-			u32 rsvd:4;
-			u32 dtyp:4;  /* Descriptor type */
-			u32 dcmd:8;  /* Descriptor command */
-		} config;
-	} lower;
-	union {
-		u32 data;
-		struct {
-			u32 status:4;  /* Descriptor status */
-			u32 idx:4;
-			u32 popts:6;  /* Packet Options */
-			u32 paylen:18; /* Payload length */
-		} options;
-	} upper;
-};
-
-#define IGC_TXD_DTYP_ADV_C	0x2  /* Advanced Context Descriptor */
-#define IGC_TXD_DTYP_ADV_D	0x3  /* Advanced Data Descriptor */
-#define IGC_ADV_TXD_CMD_DEXT	0x20 /* Descriptor extension (0 = legacy) */
-#define IGC_ADV_TUCMD_IPV4	0x2  /* IP Packet Type: 1=IPv4 */
-#define IGC_ADV_TUCMD_IPV6	0x0  /* IP Packet Type: 0=IPv6 */
-#define IGC_ADV_TUCMD_L4T_UDP	0x0  /* L4 Packet TYPE of UDP */
-#define IGC_ADV_TUCMD_L4T_TCP	0x4  /* L4 Packet TYPE of TCP */
-#define IGC_ADV_TUCMD_MKRREQ	0x10 /* Indicates markers are required */
-#define IGC_ADV_DCMD_EOP	0x1  /* End of Packet */
-#define IGC_ADV_DCMD_IFCS	0x2  /* Insert FCS (Ethernet CRC) */
-#define IGC_ADV_DCMD_RS	0x8  /* Report Status */
-#define IGC_ADV_DCMD_VLE	0x40 /* Add VLAN tag */
-#define IGC_ADV_DCMD_TSE	0x80 /* TCP Seg enable */
-/* Extended Device Control */
-#define IGC_CTRL_EXT_NSICR	0x00000001 /* Disable Intr Clear all on read */
-
-struct igc_adv_context_desc {
-	union {
-		u32 ip_config;
-		struct {
-			u32 iplen:9;
-			u32 maclen:7;
-			u32 vlan_tag:16;
-		} fields;
-	} ip_setup;
-	u32 seq_num;
-	union {
-		u64 l4_config;
-		struct {
-			u32 mkrloc:9;
-			u32 tucmd:11;
-			u32 dtyp:4;
-			u32 adv:8;
-			u32 rsvd:4;
-			u32 idx:4;
-			u32 l4len:8;
-			u32 mss:16;
-		} fields;
-	} l4_setup;
-};
-
-/* SRRCTL bit definitions */
-#define IGC_SRRCTL_BSIZEHDRSIZE_MASK		0x00000F00
-#define IGC_SRRCTL_DESCTYPE_LEGACY		0x00000000
-#define IGC_SRRCTL_DESCTYPE_HDR_SPLIT		0x04000000
-#define IGC_SRRCTL_DESCTYPE_HDR_SPLIT_ALWAYS	0x0A000000
-#define IGC_SRRCTL_DESCTYPE_HDR_REPLICATION	0x06000000
-#define IGC_SRRCTL_DESCTYPE_HDR_REPLICATION_LARGE_PKT 0x08000000
-#define IGC_SRRCTL_DESCTYPE_MASK		0x0E000000
-#define IGC_SRRCTL_TIMESTAMP			0x40000000
-#define IGC_SRRCTL_DROP_EN			0x80000000
-
-#define IGC_SRRCTL_BSIZEPKT_MASK		0x0000007F
-#define IGC_SRRCTL_BSIZEHDR_MASK		0x00003F00
-
-#define IGC_TX_HEAD_WB_ENABLE		0x1
-#define IGC_TX_SEQNUM_WB_ENABLE	0x2
-
-#define IGC_MRQC_ENABLE_RSS_4Q		0x00000002
-#define IGC_MRQC_ENABLE_VMDQ			0x00000003
-#define IGC_MRQC_ENABLE_VMDQ_RSS_2Q		0x00000005
-#define IGC_MRQC_RSS_FIELD_IPV4_UDP		0x00400000
-#define IGC_MRQC_RSS_FIELD_IPV6_UDP		0x00800000
-#define IGC_MRQC_RSS_FIELD_IPV6_UDP_EX	0x01000000
-#define IGC_MRQC_ENABLE_RSS_8Q		0x00000002
-
-#define IGC_VMRCTL_MIRROR_PORT_SHIFT		8
-#define IGC_VMRCTL_MIRROR_DSTPORT_MASK	(7 << \
-						 IGC_VMRCTL_MIRROR_PORT_SHIFT)
-#define IGC_VMRCTL_POOL_MIRROR_ENABLE		(1 << 0)
-#define IGC_VMRCTL_UPLINK_MIRROR_ENABLE	(1 << 1)
-#define IGC_VMRCTL_DOWNLINK_MIRROR_ENABLE	(1 << 2)
-
-#define IGC_EICR_TX_QUEUE ( \
-	IGC_EICR_TX_QUEUE0 |    \
-	IGC_EICR_TX_QUEUE1 |    \
-	IGC_EICR_TX_QUEUE2 |    \
-	IGC_EICR_TX_QUEUE3)
-
-#define IGC_EICR_RX_QUEUE ( \
-	IGC_EICR_RX_QUEUE0 |    \
-	IGC_EICR_RX_QUEUE1 |    \
-	IGC_EICR_RX_QUEUE2 |    \
-	IGC_EICR_RX_QUEUE3)
-
-#define IGC_EIMS_RX_QUEUE	IGC_EICR_RX_QUEUE
-#define IGC_EIMS_TX_QUEUE	IGC_EICR_TX_QUEUE
-
-#define EIMS_ENABLE_MASK ( \
-	IGC_EIMS_RX_QUEUE  | \
-	IGC_EIMS_TX_QUEUE  | \
-	IGC_EIMS_TCP_TIMER | \
-	IGC_EIMS_OTHER)
-
-/* Immediate Interrupt Rx (A.K.A. Low Latency Interrupt) */
-#define IGC_IMIR_PORT_IM_EN	0x00010000  /* TCP port enable */
-#define IGC_IMIR_PORT_BP	0x00020000  /* TCP port check bypass */
-#define IGC_IMIREXT_CTRL_URG	0x00002000  /* Check URG bit in header */
-#define IGC_IMIREXT_CTRL_ACK	0x00004000  /* Check ACK bit in header */
-#define IGC_IMIREXT_CTRL_PSH	0x00008000  /* Check PSH bit in header */
-#define IGC_IMIREXT_CTRL_RST	0x00010000  /* Check RST bit in header */
-#define IGC_IMIREXT_CTRL_SYN	0x00020000  /* Check SYN bit in header */
-#define IGC_IMIREXT_CTRL_FIN	0x00040000  /* Check FIN bit in header */
-
-#define IGC_RXDADV_RSSTYPE_MASK	0x0000000F
-#define IGC_RXDADV_RSSTYPE_SHIFT	12
-#define IGC_RXDADV_HDRBUFLEN_MASK	0x7FE0
-#define IGC_RXDADV_HDRBUFLEN_SHIFT	5
-#define IGC_RXDADV_SPLITHEADER_EN	0x00001000
-#define IGC_RXDADV_SPH		0x8000
-#define IGC_RXDADV_STAT_TS		0x10000 /* Pkt was time stamped */
-#define IGC_RXDADV_ERR_HBO		0x00800000
-
-/* RSS Hash results */
-#define IGC_RXDADV_RSSTYPE_NONE	0x00000000
-#define IGC_RXDADV_RSSTYPE_IPV4_TCP	0x00000001
-#define IGC_RXDADV_RSSTYPE_IPV4	0x00000002
-#define IGC_RXDADV_RSSTYPE_IPV6_TCP	0x00000003
-#define IGC_RXDADV_RSSTYPE_IPV6_EX	0x00000004
-#define IGC_RXDADV_RSSTYPE_IPV6	0x00000005
-#define IGC_RXDADV_RSSTYPE_IPV6_TCP_EX 0x00000006
-#define IGC_RXDADV_RSSTYPE_IPV4_UDP	0x00000007
-#define IGC_RXDADV_RSSTYPE_IPV6_UDP	0x00000008
-#define IGC_RXDADV_RSSTYPE_IPV6_UDP_EX 0x00000009
-
-/* RSS Packet Types as indicated in the receive descriptor */
-#define IGC_RXDADV_PKTTYPE_ILMASK	0x000000F0
-#define IGC_RXDADV_PKTTYPE_TLMASK	0x00000F00
-#define IGC_RXDADV_PKTTYPE_NONE	0x00000000
-#define IGC_RXDADV_PKTTYPE_IPV4	0x00000010 /* IPV4 hdr present */
-#define IGC_RXDADV_PKTTYPE_IPV4_EX	0x00000020 /* IPV4 hdr + extensions */
-#define IGC_RXDADV_PKTTYPE_IPV6	0x00000040 /* IPV6 hdr present */
-#define IGC_RXDADV_PKTTYPE_IPV6_EX	0x00000080 /* IPV6 hdr + extensions */
-#define IGC_RXDADV_PKTTYPE_TCP	0x00000100 /* TCP hdr present */
-#define IGC_RXDADV_PKTTYPE_UDP	0x00000200 /* UDP hdr present */
-#define IGC_RXDADV_PKTTYPE_SCTP	0x00000400 /* SCTP hdr present */
-#define IGC_RXDADV_PKTTYPE_NFS	0x00000800 /* NFS hdr present */
-
-#define IGC_RXDADV_PKTTYPE_IPSEC_ESP	0x00001000 /* IPSec ESP */
-#define IGC_RXDADV_PKTTYPE_IPSEC_AH	0x00002000 /* IPSec AH */
-#define IGC_RXDADV_PKTTYPE_LINKSEC	0x00004000 /* LinkSec Encap */
-#define IGC_RXDADV_PKTTYPE_ETQF	0x00008000 /* PKTTYPE is ETQF index */
-#define IGC_RXDADV_PKTTYPE_ETQF_MASK	0x00000070 /* ETQF has 8 indices */
-#define IGC_RXDADV_PKTTYPE_ETQF_SHIFT	4 /* Right-shift 4 bits */
-
-/* LinkSec results */
-/* Security Processing bit Indication */
-#define IGC_RXDADV_LNKSEC_STATUS_SECP		0x00020000
-#define IGC_RXDADV_LNKSEC_ERROR_BIT_MASK	0x18000000
-#define IGC_RXDADV_LNKSEC_ERROR_NO_SA_MATCH	0x08000000
-#define IGC_RXDADV_LNKSEC_ERROR_REPLAY_ERROR	0x10000000
-#define IGC_RXDADV_LNKSEC_ERROR_BAD_SIG	0x18000000
-
-#define IGC_RXDADV_IPSEC_STATUS_SECP			0x00020000
-#define IGC_RXDADV_IPSEC_ERROR_BIT_MASK		0x18000000
-#define IGC_RXDADV_IPSEC_ERROR_INVALID_PROTOCOL	0x08000000
-#define IGC_RXDADV_IPSEC_ERROR_INVALID_LENGTH		0x10000000
-#define IGC_RXDADV_IPSEC_ERROR_AUTHENTICATION_FAILED	0x18000000
-
-#define IGC_TXDCTL_SWFLSH		0x04000000 /* Tx Desc. wbk flushing */
-/* Tx Queue Arbitration Priority 0=low, 1=high */
-#define IGC_TXDCTL_PRIORITY		0x08000000
-
-#define IGC_RXDCTL_SWFLSH		0x04000000 /* Rx Desc. wbk flushing */
-
-/* Direct Cache Access (DCA) definitions */
-#define IGC_DCA_CTRL_DCA_ENABLE	0x00000000 /* DCA Enable */
-#define IGC_DCA_CTRL_DCA_DISABLE	0x00000001 /* DCA Disable */
-
-#define IGC_DCA_CTRL_DCA_MODE_CB1	0x00 /* DCA Mode CB1 */
-#define IGC_DCA_CTRL_DCA_MODE_CB2	0x02 /* DCA Mode CB2 */
-
-#define IGC_DCA_RXCTRL_CPUID_MASK	0x0000001F /* Rx CPUID Mask */
-#define IGC_DCA_RXCTRL_DESC_DCA_EN	(1 << 5) /* DCA Rx Desc enable */
-#define IGC_DCA_RXCTRL_HEAD_DCA_EN	(1 << 6) /* DCA Rx Desc header ena */
-#define IGC_DCA_RXCTRL_DATA_DCA_EN	(1 << 7) /* DCA Rx Desc payload ena */
-#define IGC_DCA_RXCTRL_DESC_RRO_EN	(1 << 9) /* DCA Rx Desc Relax Order */
-
-#define IGC_DCA_TXCTRL_CPUID_MASK	0x0000001F /* Tx CPUID Mask */
-#define IGC_DCA_TXCTRL_DESC_DCA_EN	(1 << 5) /* DCA Tx Desc enable */
-#define IGC_DCA_TXCTRL_DESC_RRO_EN	(1 << 9) /* Tx rd Desc Relax Order */
-#define IGC_DCA_TXCTRL_TX_WB_RO_EN	(1 << 11) /* Tx Desc writeback RO bit */
-#define IGC_DCA_TXCTRL_DATA_RRO_EN	(1 << 13) /* Tx rd data Relax Order */
-
-#define IGC_DCA_TXCTRL_CPUID_MASK_82576	0xFF000000 /* Tx CPUID Mask */
-#define IGC_DCA_RXCTRL_CPUID_MASK_82576	0xFF000000 /* Rx CPUID Mask */
-#define IGC_DCA_TXCTRL_CPUID_SHIFT_82576	24 /* Tx CPUID */
-#define IGC_DCA_RXCTRL_CPUID_SHIFT_82576	24 /* Rx CPUID */
-
-/* Additional interrupt register bit definitions */
-#define IGC_ICR_LSECPNS	0x00000020 /* PN threshold - server */
-#define IGC_IMS_LSECPNS	IGC_ICR_LSECPNS /* PN threshold - server */
-#define IGC_ICS_LSECPNS	IGC_ICR_LSECPNS /* PN threshold - server */
-
-/* ETQF register bit definitions */
-#define IGC_ETQF_FILTER_ENABLE	(1 << 26)
-#define IGC_ETQF_IMM_INT		(1 << 29)
-#define IGC_ETQF_QUEUE_ENABLE		(1 << 31)
-/*
- * ETQF filter list: one static filter per filter consumer. This is
- *                   to avoid filter collisions later. Add new filters
- *                   here!!
- *
- * Current filters:
- *    EAPOL 802.1x (0x888e): Filter 0
- */
-#define IGC_ETQF_FILTER_EAPOL		0
-
-#define IGC_FTQF_MASK_SOURCE_ADDR_BP	0x20000000
-#define IGC_FTQF_MASK_DEST_ADDR_BP	0x40000000
-#define IGC_FTQF_MASK_SOURCE_PORT_BP	0x80000000
-
-#define IGC_NVM_APME_82575		0x0400
-#define MAX_NUM_VFS			7
-
-#define IGC_DTXSWC_MAC_SPOOF_MASK	0x000000FF /* Per VF MAC spoof cntrl */
-#define IGC_DTXSWC_VLAN_SPOOF_MASK	0x0000FF00 /* Per VF VLAN spoof cntrl */
-#define IGC_DTXSWC_LLE_MASK		0x00FF0000 /* Per VF Local LB enables */
-#define IGC_DTXSWC_VLAN_SPOOF_SHIFT	8
-#define IGC_DTXSWC_LLE_SHIFT		16
-#define IGC_DTXSWC_VMDQ_LOOPBACK_EN	(1 << 31)  /* global VF LB enable */
-
-/* Easy defines for setting default pool, would normally be left a zero */
-#define IGC_VT_CTL_DEFAULT_POOL_SHIFT	7
-#define IGC_VT_CTL_DEFAULT_POOL_MASK	(0x7 << IGC_VT_CTL_DEFAULT_POOL_SHIFT)
-
-/* Other useful VMD_CTL register defines */
-#define IGC_VT_CTL_IGNORE_MAC		(1 << 28)
-#define IGC_VT_CTL_DISABLE_DEF_POOL	(1 << 29)
-#define IGC_VT_CTL_VM_REPL_EN		(1 << 30)
-
-/* Per VM Offload register setup */
-#define IGC_VMOLR_RLPML_MASK	0x00003FFF /* Long Packet Maximum Length mask */
-#define IGC_VMOLR_LPE		0x00010000 /* Accept Long packet */
-#define IGC_VMOLR_RSSE	0x00020000 /* Enable RSS */
-#define IGC_VMOLR_AUPE	0x01000000 /* Accept untagged packets */
-#define IGC_VMOLR_ROMPE	0x02000000 /* Accept overflow multicast */
-#define IGC_VMOLR_ROPE	0x04000000 /* Accept overflow unicast */
-#define IGC_VMOLR_BAM		0x08000000 /* Accept Broadcast packets */
-#define IGC_VMOLR_MPME	0x10000000 /* Multicast promiscuous mode */
-#define IGC_VMOLR_STRVLAN	0x40000000 /* Vlan stripping enable */
-#define IGC_VMOLR_STRCRC	0x80000000 /* CRC stripping enable */
-
-#define IGC_VMOLR_VPE		0x00800000 /* VLAN promiscuous enable */
-#define IGC_VMOLR_UPE		0x20000000 /* Unicast promisuous enable */
-#define IGC_DVMOLR_HIDVLAN	0x20000000 /* Vlan hiding enable */
-#define IGC_DVMOLR_STRVLAN	0x40000000 /* Vlan stripping enable */
-#define IGC_DVMOLR_STRCRC	0x80000000 /* CRC stripping enable */
-
-#define IGC_PBRWAC_WALPB	0x00000007 /* Wrap around event on LAN Rx PB */
-#define IGC_PBRWAC_PBE	0x00000008 /* Rx packet buffer empty */
-
-#define IGC_VLVF_ARRAY_SIZE		32
-#define IGC_VLVF_VLANID_MASK		0x00000FFF
-#define IGC_VLVF_POOLSEL_SHIFT	12
-#define IGC_VLVF_POOLSEL_MASK		(0xFF << IGC_VLVF_POOLSEL_SHIFT)
-#define IGC_VLVF_LVLAN		0x00100000
-#define IGC_VLVF_VLANID_ENABLE	0x80000000
-
-#define IGC_VMVIR_VLANA_DEFAULT	0x40000000 /* Always use default VLAN */
-#define IGC_VMVIR_VLANA_NEVER		0x80000000 /* Never insert VLAN tag */
-
-#define IGC_VF_INIT_TIMEOUT	200 /* Number of retries to clear RSTI */
-
-#define IGC_IOVCTL		0x05BBC
-#define IGC_IOVCTL_REUSE_VFQ	0x00000001
-
-#define IGC_RPLOLR_STRVLAN	0x40000000
-#define IGC_RPLOLR_STRCRC	0x80000000
-
-#define IGC_TCTL_EXT_COLD	0x000FFC00
-#define IGC_TCTL_EXT_COLD_SHIFT	10
-
-#define IGC_DTXCTL_8023LL	0x0004
-#define IGC_DTXCTL_VLAN_ADDED	0x0008
-#define IGC_DTXCTL_OOS_ENABLE	0x0010
-#define IGC_DTXCTL_MDP_EN	0x0020
-#define IGC_DTXCTL_SPOOF_INT	0x0040
-
-#define IGC_EEPROM_PCS_AUTONEG_DISABLE_BIT	(1 << 14)
-
-#define ALL_QUEUES		0xFFFF
-
-s32 igc_reset_init_script_82575(struct igc_hw *hw);
-s32 igc_init_nvm_params_82575(struct igc_hw *hw);
-
-/* Rx packet buffer size defines */
-#define IGC_RXPBS_SIZE_MASK_82576	0x0000007F
-void igc_vmdq_set_loopback_pf(struct igc_hw *hw, bool enable);
-void igc_vmdq_set_anti_spoofing_pf(struct igc_hw *hw, bool enable, int pf);
-void igc_vmdq_set_replication_pf(struct igc_hw *hw, bool enable);
-
-enum igc_promisc_type {
-	igc_promisc_disabled = 0,   /* all promisc modes disabled */
-	igc_promisc_unicast = 1,    /* unicast promiscuous enabled */
-	igc_promisc_multicast = 2,  /* multicast promiscuous enabled */
-	igc_promisc_enabled = 3,    /* both uni and multicast promisc */
-	igc_num_promisc_types
-};
-
-#endif /* _IGC_82575_H_ */
diff --git a/drivers/net/intel/igc/base/igc_api.c b/drivers/net/intel/igc/base/igc_api.c
deleted file mode 100644
index 228b8c8f0e..0000000000
--- a/drivers/net/intel/igc/base/igc_api.c
+++ /dev/null
@@ -1,1853 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#include "igc_api.h"
-
-/**
- *  igc_get_i2c_data - Reads the I2C SDA data bit
- *  @i2cctl: Current value of I2CCTL register
- *
- *  Returns the I2C data bit value
- **/
-static bool igc_get_i2c_data(u32 *i2cctl)
-{
-	bool data;
-
-	DEBUGFUNC("igc_get_i2c_data");
-
-	if (*i2cctl & IGC_I2C_DATA_IN)
-		data = 1;
-	else
-		data = 0;
-
-	return data;
-}
-
-/**
- *  igc_set_i2c_data - Sets the I2C data bit
- *  @hw: pointer to hardware structure
- *  @i2cctl: Current value of I2CCTL register
- *  @data: I2C data value (0 or 1) to set
- *
- *  Sets the I2C data bit
- **/
-static s32 igc_set_i2c_data(struct igc_hw *hw, u32 *i2cctl, bool data)
-{
-	s32 status = IGC_SUCCESS;
-
-	DEBUGFUNC("igc_set_i2c_data");
-
-	if (data)
-		*i2cctl |= IGC_I2C_DATA_OUT;
-	else
-		*i2cctl &= ~IGC_I2C_DATA_OUT;
-
-	*i2cctl &= ~IGC_I2C_DATA_OE_N;
-	*i2cctl |= IGC_I2C_CLK_OE_N;
-	IGC_WRITE_REG(hw, IGC_I2CPARAMS, *i2cctl);
-	IGC_WRITE_FLUSH(hw);
-
-	/* Data rise/fall (1000ns/300ns) and set-up time (250ns) */
-	usec_delay(IGC_I2C_T_RISE + IGC_I2C_T_FALL + IGC_I2C_T_SU_DATA);
-
-	*i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-	if (data != igc_get_i2c_data(i2cctl)) {
-		status = IGC_ERR_I2C;
-		DEBUGOUT1("Error - I2C data was not set to %X.\n", data);
-	}
-
-	return status;
-}
-
-/**
- *  igc_raise_i2c_clk - Raises the I2C SCL clock
- *  @hw: pointer to hardware structure
- *  @i2cctl: Current value of I2CCTL register
- *
- *  Raises the I2C clock line '0'->'1'
- **/
-static void igc_raise_i2c_clk(struct igc_hw *hw, u32 *i2cctl)
-{
-	DEBUGFUNC("igc_raise_i2c_clk");
-
-	*i2cctl |= IGC_I2C_CLK_OUT;
-	*i2cctl &= ~IGC_I2C_CLK_OE_N;
-	IGC_WRITE_REG(hw, IGC_I2CPARAMS, *i2cctl);
-	IGC_WRITE_FLUSH(hw);
-
-	/* SCL rise time (1000ns) */
-	usec_delay(IGC_I2C_T_RISE);
-}
-
-/**
- *  igc_lower_i2c_clk - Lowers the I2C SCL clock
- *  @hw: pointer to hardware structure
- *  @i2cctl: Current value of I2CCTL register
- *
- *  Lowers the I2C clock line '1'->'0'
- **/
-static void igc_lower_i2c_clk(struct igc_hw *hw, u32 *i2cctl)
-{
-	DEBUGFUNC("igc_lower_i2c_clk");
-
-	*i2cctl &= ~IGC_I2C_CLK_OUT;
-	*i2cctl &= ~IGC_I2C_CLK_OE_N;
-	IGC_WRITE_REG(hw, IGC_I2CPARAMS, *i2cctl);
-	IGC_WRITE_FLUSH(hw);
-
-	/* SCL fall time (300ns) */
-	usec_delay(IGC_I2C_T_FALL);
-}
-
-/**
- *  igc_i2c_start - Sets I2C start condition
- *  @hw: pointer to hardware structure
- *
- *  Sets I2C start condition (High -> Low on SDA while SCL is High)
- **/
-static void igc_i2c_start(struct igc_hw *hw)
-{
-	u32 i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-
-	DEBUGFUNC("igc_i2c_start");
-
-	/* Start condition must begin with data and clock high */
-	igc_set_i2c_data(hw, &i2cctl, 1);
-	igc_raise_i2c_clk(hw, &i2cctl);
-
-	/* Setup time for start condition (4.7us) */
-	usec_delay(IGC_I2C_T_SU_STA);
-
-	igc_set_i2c_data(hw, &i2cctl, 0);
-
-	/* Hold time for start condition (4us) */
-	usec_delay(IGC_I2C_T_HD_STA);
-
-	igc_lower_i2c_clk(hw, &i2cctl);
-
-	/* Minimum low period of clock is 4.7 us */
-	usec_delay(IGC_I2C_T_LOW);
-}
-
-/**
- *  igc_i2c_stop - Sets I2C stop condition
- *  @hw: pointer to hardware structure
- *
- *  Sets I2C stop condition (Low -> High on SDA while SCL is High)
- **/
-static void igc_i2c_stop(struct igc_hw *hw)
-{
-	u32 i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-
-	DEBUGFUNC("igc_i2c_stop");
-
-	/* Stop condition must begin with data low and clock high */
-	igc_set_i2c_data(hw, &i2cctl, 0);
-	igc_raise_i2c_clk(hw, &i2cctl);
-
-	/* Setup time for stop condition (4us) */
-	usec_delay(IGC_I2C_T_SU_STO);
-
-	igc_set_i2c_data(hw, &i2cctl, 1);
-
-	/* bus free time between stop and start (4.7us)*/
-	usec_delay(IGC_I2C_T_BUF);
-}
-
-/**
- *  igc_clock_in_i2c_bit - Clocks in one bit via I2C data/clock
- *  @hw: pointer to hardware structure
- *  @data: read data value
- *
- *  Clocks in one bit via I2C data/clock
- **/
-static void igc_clock_in_i2c_bit(struct igc_hw *hw, bool *data)
-{
-	u32 i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-
-	DEBUGFUNC("igc_clock_in_i2c_bit");
-
-	igc_raise_i2c_clk(hw, &i2cctl);
-
-	/* Minimum high period of clock is 4us */
-	usec_delay(IGC_I2C_T_HIGH);
-
-	i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-	*data = igc_get_i2c_data(&i2cctl);
-
-	igc_lower_i2c_clk(hw, &i2cctl);
-
-	/* Minimum low period of clock is 4.7 us */
-	usec_delay(IGC_I2C_T_LOW);
-}
-
-/**
- *  igc_clock_in_i2c_byte - Clocks in one byte via I2C
- *  @hw: pointer to hardware structure
- *  @data: data byte to clock in
- *
- *  Clocks in one byte data via I2C data/clock
- **/
-static void igc_clock_in_i2c_byte(struct igc_hw *hw, u8 *data)
-{
-	s32 i;
-	bool bit = 0;
-
-	DEBUGFUNC("igc_clock_in_i2c_byte");
-
-	*data = 0;
-	for (i = 7; i >= 0; i--) {
-		igc_clock_in_i2c_bit(hw, &bit);
-		*data |= bit << i;
-	}
-}
-
-/**
- *  igc_clock_out_i2c_bit - Clocks in/out one bit via I2C data/clock
- *  @hw: pointer to hardware structure
- *  @data: data value to write
- *
- *  Clocks out one bit via I2C data/clock
- **/
-static s32 igc_clock_out_i2c_bit(struct igc_hw *hw, bool data)
-{
-	s32 status;
-	u32 i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-
-	DEBUGFUNC("igc_clock_out_i2c_bit");
-
-	status = igc_set_i2c_data(hw, &i2cctl, data);
-	if (status == IGC_SUCCESS) {
-		igc_raise_i2c_clk(hw, &i2cctl);
-
-		/* Minimum high period of clock is 4us */
-		usec_delay(IGC_I2C_T_HIGH);
-
-		igc_lower_i2c_clk(hw, &i2cctl);
-
-		/* Minimum low period of clock is 4.7 us.
-		 * This also takes care of the data hold time.
-		 */
-		usec_delay(IGC_I2C_T_LOW);
-	} else {
-		status = IGC_ERR_I2C;
-		DEBUGOUT1("I2C data was not set to %X\n", data);
-	}
-
-	return status;
-}
-
-/**
- *  igc_clock_out_i2c_byte - Clocks out one byte via I2C
- *  @hw: pointer to hardware structure
- *  @data: data byte clocked out
- *
- *  Clocks out one byte data via I2C data/clock
- **/
-static s32 igc_clock_out_i2c_byte(struct igc_hw *hw, u8 data)
-{
-	s32 status = IGC_SUCCESS;
-	s32 i;
-	u32 i2cctl;
-	bool bit = 0;
-
-	DEBUGFUNC("igc_clock_out_i2c_byte");
-
-	for (i = 7; i >= 0; i--) {
-		bit = (data >> i) & 0x1;
-		status = igc_clock_out_i2c_bit(hw, bit);
-
-		if (status != IGC_SUCCESS)
-			break;
-	}
-
-	/* Release SDA line (set high) */
-	i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-
-	i2cctl |= IGC_I2C_DATA_OE_N;
-	IGC_WRITE_REG(hw, IGC_I2CPARAMS, i2cctl);
-	IGC_WRITE_FLUSH(hw);
-
-	return status;
-}
-
-/**
- *  igc_get_i2c_ack - Polls for I2C ACK
- *  @hw: pointer to hardware structure
- *
- *  Clocks in/out one bit via I2C data/clock
- **/
-static s32 igc_get_i2c_ack(struct igc_hw *hw)
-{
-	s32 status = IGC_SUCCESS;
-	u32 i = 0;
-	u32 i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-	u32 timeout = 10;
-	bool ack = true;
-
-	DEBUGFUNC("igc_get_i2c_ack");
-
-	igc_raise_i2c_clk(hw, &i2cctl);
-
-	/* Minimum high period of clock is 4us */
-	usec_delay(IGC_I2C_T_HIGH);
-
-	/* Wait until SCL returns high */
-	for (i = 0; i < timeout; i++) {
-		usec_delay(1);
-		i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-		if (i2cctl & IGC_I2C_CLK_IN)
-			break;
-	}
-	if (!(i2cctl & IGC_I2C_CLK_IN))
-		return IGC_ERR_I2C;
-
-	ack = igc_get_i2c_data(&i2cctl);
-	if (ack) {
-		DEBUGOUT("I2C ack was not received.\n");
-		status = IGC_ERR_I2C;
-	}
-
-	igc_lower_i2c_clk(hw, &i2cctl);
-
-	/* Minimum low period of clock is 4.7 us */
-	usec_delay(IGC_I2C_T_LOW);
-
-	return status;
-}
-
-/**
- *  igc_set_i2c_bb - Enable I2C bit-bang
- *  @hw: pointer to the HW structure
- *
- *  Enable I2C bit-bang interface
- *
- **/
-s32 igc_set_i2c_bb(struct igc_hw *hw)
-{
-	s32 ret_val = IGC_SUCCESS;
-	u32 ctrl_ext, i2cparams;
-
-	DEBUGFUNC("igc_set_i2c_bb");
-
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
-	ctrl_ext |= IGC_CTRL_I2C_ENA;
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext);
-	IGC_WRITE_FLUSH(hw);
-
-	i2cparams = IGC_READ_REG(hw, IGC_I2CPARAMS);
-	i2cparams |= IGC_I2CBB_EN;
-	i2cparams |= IGC_I2C_DATA_OE_N;
-	i2cparams |= IGC_I2C_CLK_OE_N;
-	IGC_WRITE_REG(hw, IGC_I2CPARAMS, i2cparams);
-	IGC_WRITE_FLUSH(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_read_i2c_byte_generic - Reads 8 bit word over I2C
- *  @hw: pointer to hardware structure
- *  @byte_offset: byte offset to read
- *  @dev_addr: device address
- *  @data: value read
- *
- *  Performs byte read operation over I2C interface at
- *  a specified device address.
- **/
-s32 igc_read_i2c_byte_generic(struct igc_hw *hw, u8 byte_offset,
-				u8 dev_addr, u8 *data)
-{
-	s32 status = IGC_SUCCESS;
-	u32 max_retry = 10;
-	u32 retry = 1;
-	u16 swfw_mask = 0;
-
-	bool nack = true;
-
-	DEBUGFUNC("igc_read_i2c_byte_generic");
-
-	swfw_mask = IGC_SWFW_PHY0_SM;
-
-	do {
-		if (hw->mac.ops.acquire_swfw_sync(hw, swfw_mask)
-		    != IGC_SUCCESS) {
-			status = IGC_ERR_SWFW_SYNC;
-			goto read_byte_out;
-		}
-
-		igc_i2c_start(hw);
-
-		/* Device Address and write indication */
-		status = igc_clock_out_i2c_byte(hw, dev_addr);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		status = igc_get_i2c_ack(hw);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		status = igc_clock_out_i2c_byte(hw, byte_offset);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		status = igc_get_i2c_ack(hw);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		igc_i2c_start(hw);
-
-		/* Device Address and read indication */
-		status = igc_clock_out_i2c_byte(hw, (dev_addr | 0x1));
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		status = igc_get_i2c_ack(hw);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		igc_clock_in_i2c_byte(hw, data);
-
-		status = igc_clock_out_i2c_bit(hw, nack);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		igc_i2c_stop(hw);
-		break;
-
-fail:
-		hw->mac.ops.release_swfw_sync(hw, swfw_mask);
-		msec_delay(100);
-		igc_i2c_bus_clear(hw);
-		retry++;
-		if (retry < max_retry)
-			DEBUGOUT("I2C byte read error - Retrying.\n");
-		else
-			DEBUGOUT("I2C byte read error.\n");
-
-	} while (retry < max_retry);
-
-	hw->mac.ops.release_swfw_sync(hw, swfw_mask);
-
-read_byte_out:
-
-	return status;
-}
-
-/**
- *  igc_write_i2c_byte_generic - Writes 8 bit word over I2C
- *  @hw: pointer to hardware structure
- *  @byte_offset: byte offset to write
- *  @dev_addr: device address
- *  @data: value to write
- *
- *  Performs byte write operation over I2C interface at
- *  a specified device address.
- **/
-s32 igc_write_i2c_byte_generic(struct igc_hw *hw, u8 byte_offset,
-				 u8 dev_addr, u8 data)
-{
-	s32 status = IGC_SUCCESS;
-	u32 max_retry = 1;
-	u32 retry = 0;
-	u16 swfw_mask = 0;
-
-	DEBUGFUNC("igc_write_i2c_byte_generic");
-
-	swfw_mask = IGC_SWFW_PHY0_SM;
-
-	if (hw->mac.ops.acquire_swfw_sync(hw, swfw_mask) != IGC_SUCCESS) {
-		status = IGC_ERR_SWFW_SYNC;
-		goto write_byte_out;
-	}
-
-	do {
-		igc_i2c_start(hw);
-
-		status = igc_clock_out_i2c_byte(hw, dev_addr);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		status = igc_get_i2c_ack(hw);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		status = igc_clock_out_i2c_byte(hw, byte_offset);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		status = igc_get_i2c_ack(hw);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		status = igc_clock_out_i2c_byte(hw, data);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		status = igc_get_i2c_ack(hw);
-		if (status != IGC_SUCCESS)
-			goto fail;
-
-		igc_i2c_stop(hw);
-		break;
-
-fail:
-		igc_i2c_bus_clear(hw);
-		retry++;
-		if (retry < max_retry)
-			DEBUGOUT("I2C byte write error - Retrying.\n");
-		else
-			DEBUGOUT("I2C byte write error.\n");
-	} while (retry < max_retry);
-
-	hw->mac.ops.release_swfw_sync(hw, swfw_mask);
-
-write_byte_out:
-
-	return status;
-}
-
-/**
- *  igc_i2c_bus_clear - Clears the I2C bus
- *  @hw: pointer to hardware structure
- *
- *  Clears the I2C bus by sending nine clock pulses.
- *  Used when data line is stuck low.
- **/
-void igc_i2c_bus_clear(struct igc_hw *hw)
-{
-	u32 i2cctl = IGC_READ_REG(hw, IGC_I2CPARAMS);
-	u32 i;
-
-	DEBUGFUNC("igc_i2c_bus_clear");
-
-	igc_i2c_start(hw);
-
-	igc_set_i2c_data(hw, &i2cctl, 1);
-
-	for (i = 0; i < 9; i++) {
-		igc_raise_i2c_clk(hw, &i2cctl);
-
-		/* Min high period of clock is 4us */
-		usec_delay(IGC_I2C_T_HIGH);
-
-		igc_lower_i2c_clk(hw, &i2cctl);
-
-		/* Min low period of clock is 4.7us*/
-		usec_delay(IGC_I2C_T_LOW);
-	}
-
-	igc_i2c_start(hw);
-
-	/* Put the i2c bus back to default state */
-	igc_i2c_stop(hw);
-}
-
-/**
- *  igc_init_mac_params - Initialize MAC function pointers
- *  @hw: pointer to the HW structure
- *
- *  This function initializes the function pointers for the MAC
- *  set of functions.  Called by drivers or by igc_setup_init_funcs.
- **/
-s32 igc_init_mac_params(struct igc_hw *hw)
-{
-	s32 ret_val = IGC_SUCCESS;
-
-	if (hw->mac.ops.init_params) {
-		ret_val = hw->mac.ops.init_params(hw);
-		if (ret_val) {
-			DEBUGOUT("MAC Initialization Error\n");
-			goto out;
-		}
-	} else {
-		DEBUGOUT("mac.init_mac_params was NULL\n");
-		ret_val = -IGC_ERR_CONFIG;
-	}
-
-out:
-	return ret_val;
-}
-
-/**
- *  igc_init_nvm_params - Initialize NVM function pointers
- *  @hw: pointer to the HW structure
- *
- *  This function initializes the function pointers for the NVM
- *  set of functions.  Called by drivers or by igc_setup_init_funcs.
- **/
-s32 igc_init_nvm_params(struct igc_hw *hw)
-{
-	s32 ret_val = IGC_SUCCESS;
-
-	if (hw->nvm.ops.init_params) {
-		ret_val = hw->nvm.ops.init_params(hw);
-		if (ret_val) {
-			DEBUGOUT("NVM Initialization Error\n");
-			goto out;
-		}
-	} else {
-		DEBUGOUT("nvm.init_nvm_params was NULL\n");
-		ret_val = -IGC_ERR_CONFIG;
-	}
-
-out:
-	return ret_val;
-}
-
-/**
- *  igc_init_phy_params - Initialize PHY function pointers
- *  @hw: pointer to the HW structure
- *
- *  This function initializes the function pointers for the PHY
- *  set of functions.  Called by drivers or by igc_setup_init_funcs.
- **/
-s32 igc_init_phy_params(struct igc_hw *hw)
-{
-	s32 ret_val = IGC_SUCCESS;
-
-	if (hw->phy.ops.init_params) {
-		ret_val = hw->phy.ops.init_params(hw);
-		if (ret_val) {
-			DEBUGOUT("PHY Initialization Error\n");
-			goto out;
-		}
-	} else {
-		DEBUGOUT("phy.init_phy_params was NULL\n");
-		ret_val =  -IGC_ERR_CONFIG;
-	}
-
-out:
-	return ret_val;
-}
-
-/**
- *  igc_init_mbx_params - Initialize mailbox function pointers
- *  @hw: pointer to the HW structure
- *
- *  This function initializes the function pointers for the PHY
- *  set of functions.  Called by drivers or by igc_setup_init_funcs.
- **/
-s32 igc_init_mbx_params(struct igc_hw *hw)
-{
-	s32 ret_val = IGC_SUCCESS;
-
-	if (hw->mbx.ops.init_params) {
-		ret_val = hw->mbx.ops.init_params(hw);
-		if (ret_val) {
-			DEBUGOUT("Mailbox Initialization Error\n");
-			goto out;
-		}
-	} else {
-		DEBUGOUT("mbx.init_mbx_params was NULL\n");
-		ret_val =  -IGC_ERR_CONFIG;
-	}
-
-out:
-	return ret_val;
-}
-
-/**
- *  igc_set_mac_type - Sets MAC type
- *  @hw: pointer to the HW structure
- *
- *  This function sets the mac type of the adapter based on the
- *  device ID stored in the hw structure.
- *  MUST BE FIRST FUNCTION CALLED (explicitly or through
- *  igc_setup_init_funcs()).
- **/
-s32 igc_set_mac_type(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	s32 ret_val = IGC_SUCCESS;
-
-	DEBUGFUNC("igc_set_mac_type");
-
-	switch (hw->device_id) {
-	case IGC_DEV_ID_82542:
-		mac->type = igc_82542;
-		break;
-	case IGC_DEV_ID_82543GC_FIBER:
-	case IGC_DEV_ID_82543GC_COPPER:
-		mac->type = igc_82543;
-		break;
-	case IGC_DEV_ID_82544EI_COPPER:
-	case IGC_DEV_ID_82544EI_FIBER:
-	case IGC_DEV_ID_82544GC_COPPER:
-	case IGC_DEV_ID_82544GC_LOM:
-		mac->type = igc_82544;
-		break;
-	case IGC_DEV_ID_82540EM:
-	case IGC_DEV_ID_82540EM_LOM:
-	case IGC_DEV_ID_82540EP:
-	case IGC_DEV_ID_82540EP_LOM:
-	case IGC_DEV_ID_82540EP_LP:
-		mac->type = igc_82540;
-		break;
-	case IGC_DEV_ID_82545EM_COPPER:
-	case IGC_DEV_ID_82545EM_FIBER:
-		mac->type = igc_82545;
-		break;
-	case IGC_DEV_ID_82545GM_COPPER:
-	case IGC_DEV_ID_82545GM_FIBER:
-	case IGC_DEV_ID_82545GM_SERDES:
-		mac->type = igc_82545_rev_3;
-		break;
-	case IGC_DEV_ID_82546EB_COPPER:
-	case IGC_DEV_ID_82546EB_FIBER:
-	case IGC_DEV_ID_82546EB_QUAD_COPPER:
-		mac->type = igc_82546;
-		break;
-	case IGC_DEV_ID_82546GB_COPPER:
-	case IGC_DEV_ID_82546GB_FIBER:
-	case IGC_DEV_ID_82546GB_SERDES:
-	case IGC_DEV_ID_82546GB_PCIE:
-	case IGC_DEV_ID_82546GB_QUAD_COPPER:
-	case IGC_DEV_ID_82546GB_QUAD_COPPER_KSP3:
-		mac->type = igc_82546_rev_3;
-		break;
-	case IGC_DEV_ID_82541EI:
-	case IGC_DEV_ID_82541EI_MOBILE:
-	case IGC_DEV_ID_82541ER_LOM:
-		mac->type = igc_82541;
-		break;
-	case IGC_DEV_ID_82541ER:
-	case IGC_DEV_ID_82541GI:
-	case IGC_DEV_ID_82541GI_LF:
-	case IGC_DEV_ID_82541GI_MOBILE:
-		mac->type = igc_82541_rev_2;
-		break;
-	case IGC_DEV_ID_82547EI:
-	case IGC_DEV_ID_82547EI_MOBILE:
-		mac->type = igc_82547;
-		break;
-	case IGC_DEV_ID_82547GI:
-		mac->type = igc_82547_rev_2;
-		break;
-	case IGC_DEV_ID_82571EB_COPPER:
-	case IGC_DEV_ID_82571EB_FIBER:
-	case IGC_DEV_ID_82571EB_SERDES:
-	case IGC_DEV_ID_82571EB_SERDES_DUAL:
-	case IGC_DEV_ID_82571EB_SERDES_QUAD:
-	case IGC_DEV_ID_82571EB_QUAD_COPPER:
-	case IGC_DEV_ID_82571PT_QUAD_COPPER:
-	case IGC_DEV_ID_82571EB_QUAD_FIBER:
-	case IGC_DEV_ID_82571EB_QUAD_COPPER_LP:
-		mac->type = igc_82571;
-		break;
-	case IGC_DEV_ID_82572EI:
-	case IGC_DEV_ID_82572EI_COPPER:
-	case IGC_DEV_ID_82572EI_FIBER:
-	case IGC_DEV_ID_82572EI_SERDES:
-		mac->type = igc_82572;
-		break;
-	case IGC_DEV_ID_82573E:
-	case IGC_DEV_ID_82573E_IAMT:
-	case IGC_DEV_ID_82573L:
-		mac->type = igc_82573;
-		break;
-	case IGC_DEV_ID_82574L:
-	case IGC_DEV_ID_82574LA:
-		mac->type = igc_82574;
-		break;
-	case IGC_DEV_ID_82583V:
-		mac->type = igc_82583;
-		break;
-	case IGC_DEV_ID_80003ES2LAN_COPPER_DPT:
-	case IGC_DEV_ID_80003ES2LAN_SERDES_DPT:
-	case IGC_DEV_ID_80003ES2LAN_COPPER_SPT:
-	case IGC_DEV_ID_80003ES2LAN_SERDES_SPT:
-		mac->type = igc_80003es2lan;
-		break;
-	case IGC_DEV_ID_ICH8_IFE:
-	case IGC_DEV_ID_ICH8_IFE_GT:
-	case IGC_DEV_ID_ICH8_IFE_G:
-	case IGC_DEV_ID_ICH8_IGP_M:
-	case IGC_DEV_ID_ICH8_IGP_M_AMT:
-	case IGC_DEV_ID_ICH8_IGP_AMT:
-	case IGC_DEV_ID_ICH8_IGP_C:
-	case IGC_DEV_ID_ICH8_82567V_3:
-		mac->type = igc_ich8lan;
-		break;
-	case IGC_DEV_ID_ICH9_IFE:
-	case IGC_DEV_ID_ICH9_IFE_GT:
-	case IGC_DEV_ID_ICH9_IFE_G:
-	case IGC_DEV_ID_ICH9_IGP_M:
-	case IGC_DEV_ID_ICH9_IGP_M_AMT:
-	case IGC_DEV_ID_ICH9_IGP_M_V:
-	case IGC_DEV_ID_ICH9_IGP_AMT:
-	case IGC_DEV_ID_ICH9_BM:
-	case IGC_DEV_ID_ICH9_IGP_C:
-	case IGC_DEV_ID_ICH10_R_BM_LM:
-	case IGC_DEV_ID_ICH10_R_BM_LF:
-	case IGC_DEV_ID_ICH10_R_BM_V:
-		mac->type = igc_ich9lan;
-		break;
-	case IGC_DEV_ID_ICH10_D_BM_LM:
-	case IGC_DEV_ID_ICH10_D_BM_LF:
-	case IGC_DEV_ID_ICH10_D_BM_V:
-		mac->type = igc_ich10lan;
-		break;
-	case IGC_DEV_ID_PCH_D_HV_DM:
-	case IGC_DEV_ID_PCH_D_HV_DC:
-	case IGC_DEV_ID_PCH_M_HV_LM:
-	case IGC_DEV_ID_PCH_M_HV_LC:
-		mac->type = igc_pchlan;
-		break;
-	case IGC_DEV_ID_PCH2_LV_LM:
-	case IGC_DEV_ID_PCH2_LV_V:
-		mac->type = igc_pch2lan;
-		break;
-	case IGC_DEV_ID_PCH_LPT_I217_LM:
-	case IGC_DEV_ID_PCH_LPT_I217_V:
-	case IGC_DEV_ID_PCH_LPTLP_I218_LM:
-	case IGC_DEV_ID_PCH_LPTLP_I218_V:
-	case IGC_DEV_ID_PCH_I218_LM2:
-	case IGC_DEV_ID_PCH_I218_V2:
-	case IGC_DEV_ID_PCH_I218_LM3:
-	case IGC_DEV_ID_PCH_I218_V3:
-		mac->type = igc_pch_lpt;
-		break;
-	case IGC_DEV_ID_PCH_SPT_I219_LM:
-	case IGC_DEV_ID_PCH_SPT_I219_V:
-	case IGC_DEV_ID_PCH_SPT_I219_LM2:
-	case IGC_DEV_ID_PCH_SPT_I219_V2:
-	case IGC_DEV_ID_PCH_LBG_I219_LM3:
-	case IGC_DEV_ID_PCH_SPT_I219_LM4:
-	case IGC_DEV_ID_PCH_SPT_I219_V4:
-	case IGC_DEV_ID_PCH_SPT_I219_LM5:
-	case IGC_DEV_ID_PCH_SPT_I219_V5:
-		mac->type = igc_pch_spt;
-		break;
-	case IGC_DEV_ID_PCH_CNP_I219_LM6:
-	case IGC_DEV_ID_PCH_CNP_I219_V6:
-	case IGC_DEV_ID_PCH_CNP_I219_LM7:
-	case IGC_DEV_ID_PCH_CNP_I219_V7:
-	case IGC_DEV_ID_PCH_ICP_I219_LM8:
-	case IGC_DEV_ID_PCH_ICP_I219_V8:
-	case IGC_DEV_ID_PCH_ICP_I219_LM9:
-	case IGC_DEV_ID_PCH_ICP_I219_V9:
-		mac->type = igc_pch_cnp;
-		break;
-	case IGC_DEV_ID_82575EB_COPPER:
-	case IGC_DEV_ID_82575EB_FIBER_SERDES:
-	case IGC_DEV_ID_82575GB_QUAD_COPPER:
-		mac->type = igc_82575;
-		break;
-	case IGC_DEV_ID_82576:
-	case IGC_DEV_ID_82576_FIBER:
-	case IGC_DEV_ID_82576_SERDES:
-	case IGC_DEV_ID_82576_QUAD_COPPER:
-	case IGC_DEV_ID_82576_QUAD_COPPER_ET2:
-	case IGC_DEV_ID_82576_NS:
-	case IGC_DEV_ID_82576_NS_SERDES:
-	case IGC_DEV_ID_82576_SERDES_QUAD:
-		mac->type = igc_82576;
-		break;
-	case IGC_DEV_ID_82576_VF:
-	case IGC_DEV_ID_82576_VF_HV:
-		mac->type = igc_vfadapt;
-		break;
-	case IGC_DEV_ID_82580_COPPER:
-	case IGC_DEV_ID_82580_FIBER:
-	case IGC_DEV_ID_82580_SERDES:
-	case IGC_DEV_ID_82580_SGMII:
-	case IGC_DEV_ID_82580_COPPER_DUAL:
-	case IGC_DEV_ID_82580_QUAD_FIBER:
-	case IGC_DEV_ID_DH89XXCC_SGMII:
-	case IGC_DEV_ID_DH89XXCC_SERDES:
-	case IGC_DEV_ID_DH89XXCC_BACKPLANE:
-	case IGC_DEV_ID_DH89XXCC_SFP:
-		mac->type = igc_82580;
-		break;
-	case IGC_DEV_ID_I350_COPPER:
-	case IGC_DEV_ID_I350_FIBER:
-	case IGC_DEV_ID_I350_SERDES:
-	case IGC_DEV_ID_I350_SGMII:
-	case IGC_DEV_ID_I350_DA4:
-		mac->type = igc_i350;
-		break;
-	case IGC_DEV_ID_I210_COPPER_FLASHLESS:
-	case IGC_DEV_ID_I210_SERDES_FLASHLESS:
-	case IGC_DEV_ID_I210_SGMII_FLASHLESS:
-	case IGC_DEV_ID_I210_COPPER:
-	case IGC_DEV_ID_I210_COPPER_OEM1:
-	case IGC_DEV_ID_I210_COPPER_IT:
-	case IGC_DEV_ID_I210_FIBER:
-	case IGC_DEV_ID_I210_SERDES:
-	case IGC_DEV_ID_I210_SGMII:
-		mac->type = igc_i210;
-		break;
-	case IGC_DEV_ID_I211_COPPER:
-		mac->type = igc_i211;
-		break;
-	case IGC_DEV_ID_I225_LM:
-	case IGC_DEV_ID_I225_LMVP:
-	case IGC_DEV_ID_I225_V:
-	case IGC_DEV_ID_I225_K:
-	case IGC_DEV_ID_I225_I:
-	case IGC_DEV_ID_I225_IT:
-	case IGC_DEV_ID_I220_V:
-	case IGC_DEV_ID_I225_BLANK_NVM:
-	case IGC_DEV_ID_I226_K:
-	case IGC_DEV_ID_I226_LMVP:
-	case IGC_DEV_ID_I226_LM:
-	case IGC_DEV_ID_I226_V:
-	case IGC_DEV_ID_I226_IT:
-	case IGC_DEV_ID_I226_BLANK_NVM:
-		mac->type = igc_i225;
-		break;
-	case IGC_DEV_ID_I350_VF:
-	case IGC_DEV_ID_I350_VF_HV:
-		mac->type = igc_vfadapt_i350;
-		break;
-	case IGC_DEV_ID_I354_BACKPLANE_1GBPS:
-	case IGC_DEV_ID_I354_SGMII:
-	case IGC_DEV_ID_I354_BACKPLANE_2_5GBPS:
-		mac->type = igc_i354;
-		break;
-	default:
-		/* Should never have loaded on this device */
-		ret_val = -IGC_ERR_MAC_INIT;
-		break;
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_setup_init_funcs - Initializes function pointers
- *  @hw: pointer to the HW structure
- *  @init_device: true will initialize the rest of the function pointers
- *		  getting the device ready for use.  false will only set
- *		  MAC type and the function pointers for the other init
- *		  functions.  Passing false will not generate any hardware
- *		  reads or writes.
- *
- *  This function must be called by a driver in order to use the rest
- *  of the 'shared' code files. Called by drivers only.
- **/
-s32 igc_setup_init_funcs(struct igc_hw *hw, bool init_device)
-{
-	s32 ret_val;
-
-	/* Can't do much good without knowing the MAC type. */
-	ret_val = igc_set_mac_type(hw);
-	if (ret_val) {
-		DEBUGOUT("ERROR: MAC type could not be set properly.\n");
-		goto out;
-	}
-
-	if (!hw->hw_addr) {
-		DEBUGOUT("ERROR: Registers not mapped\n");
-		ret_val = -IGC_ERR_CONFIG;
-		goto out;
-	}
-
-	/*
-	 * Init function pointers to generic implementations. We do this first
-	 * allowing a driver module to override it afterward.
-	 */
-	igc_init_mac_ops_generic(hw);
-	igc_init_phy_ops_generic(hw);
-	igc_init_nvm_ops_generic(hw);
-
-	/*
-	 * Set up the init function pointers. These are functions within the
-	 * adapter family file that sets up function pointers for the rest of
-	 * the functions in that family.
-	 */
-	switch (hw->mac.type) {
-	case igc_i225:
-		igc_init_function_pointers_i225(hw);
-		break;
-	default:
-		DEBUGOUT("Hardware not supported\n");
-		ret_val = -IGC_ERR_CONFIG;
-		break;
-	}
-
-	/*
-	 * Initialize the rest of the function pointers. These require some
-	 * register reads/writes in some cases.
-	 */
-	if (!(ret_val) && init_device) {
-		ret_val = igc_init_mac_params(hw);
-		if (ret_val)
-			goto out;
-
-		ret_val = igc_init_nvm_params(hw);
-		if (ret_val)
-			goto out;
-
-		ret_val = igc_init_phy_params(hw);
-		if (ret_val)
-			goto out;
-	}
-
-out:
-	return ret_val;
-}
-
-/**
- *  igc_get_bus_info - Obtain bus information for adapter
- *  @hw: pointer to the HW structure
- *
- *  This will obtain information about the HW bus for which the
- *  adapter is attached and stores it in the hw structure. This is a
- *  function pointer entry point called by drivers.
- **/
-s32 igc_get_bus_info(struct igc_hw *hw)
-{
-	if (hw->mac.ops.get_bus_info)
-		return hw->mac.ops.get_bus_info(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_clear_vfta - Clear VLAN filter table
- *  @hw: pointer to the HW structure
- *
- *  This clears the VLAN filter table on the adapter. This is a function
- *  pointer entry point called by drivers.
- **/
-void igc_clear_vfta(struct igc_hw *hw)
-{
-	if (hw->mac.ops.clear_vfta)
-		hw->mac.ops.clear_vfta(hw);
-}
-
-/**
- *  igc_write_vfta - Write value to VLAN filter table
- *  @hw: pointer to the HW structure
- *  @offset: the 32-bit offset in which to write the value to.
- *  @value: the 32-bit value to write at location offset.
- *
- *  This writes a 32-bit value to a 32-bit offset in the VLAN filter
- *  table. This is a function pointer entry point called by drivers.
- **/
-void igc_write_vfta(struct igc_hw *hw, u32 offset, u32 value)
-{
-	if (hw->mac.ops.write_vfta)
-		hw->mac.ops.write_vfta(hw, offset, value);
-}
-
-/**
- *  igc_update_mc_addr_list - Update Multicast addresses
- *  @hw: pointer to the HW structure
- *  @mc_addr_list: array of multicast addresses to program
- *  @mc_addr_count: number of multicast addresses to program
- *
- *  Updates the Multicast Table Array.
- *  The caller must have a packed mc_addr_list of multicast addresses.
- **/
-void igc_update_mc_addr_list(struct igc_hw *hw, u8 *mc_addr_list,
-			       u32 mc_addr_count)
-{
-	if (hw->mac.ops.update_mc_addr_list)
-		hw->mac.ops.update_mc_addr_list(hw, mc_addr_list,
-						mc_addr_count);
-}
-
-/**
- *  igc_force_mac_fc - Force MAC flow control
- *  @hw: pointer to the HW structure
- *
- *  Force the MAC's flow control settings. Currently no func pointer exists
- *  and all implementations are handled in the generic version of this
- *  function.
- **/
-s32 igc_force_mac_fc(struct igc_hw *hw)
-{
-	return igc_force_mac_fc_generic(hw);
-}
-
-/**
- *  igc_check_for_link - Check/Store link connection
- *  @hw: pointer to the HW structure
- *
- *  This checks the link condition of the adapter and stores the
- *  results in the hw->mac structure. This is a function pointer entry
- *  point called by drivers.
- **/
-s32 igc_check_for_link(struct igc_hw *hw)
-{
-	if (hw->mac.ops.check_for_link)
-		return hw->mac.ops.check_for_link(hw);
-
-	return -IGC_ERR_CONFIG;
-}
-
-/**
- *  igc_check_mng_mode - Check management mode
- *  @hw: pointer to the HW structure
- *
- *  This checks if the adapter has manageability enabled.
- *  This is a function pointer entry point called by drivers.
- **/
-bool igc_check_mng_mode(struct igc_hw *hw)
-{
-	if (hw->mac.ops.check_mng_mode)
-		return hw->mac.ops.check_mng_mode(hw);
-
-	return false;
-}
-
-/**
- *  igc_mng_write_dhcp_info - Writes DHCP info to host interface
- *  @hw: pointer to the HW structure
- *  @buffer: pointer to the host interface
- *  @length: size of the buffer
- *
- *  Writes the DHCP information to the host interface.
- **/
-s32 igc_mng_write_dhcp_info(struct igc_hw *hw, u8 *buffer, u16 length)
-{
-	return igc_mng_write_dhcp_info_generic(hw, buffer, length);
-}
-
-/**
- *  igc_reset_hw - Reset hardware
- *  @hw: pointer to the HW structure
- *
- *  This resets the hardware into a known state. This is a function pointer
- *  entry point called by drivers.
- **/
-s32 igc_reset_hw(struct igc_hw *hw)
-{
-	if (hw->mac.ops.reset_hw)
-		return hw->mac.ops.reset_hw(hw);
-
-	return -IGC_ERR_CONFIG;
-}
-
-/**
- *  igc_init_hw - Initialize hardware
- *  @hw: pointer to the HW structure
- *
- *  This inits the hardware readying it for operation. This is a function
- *  pointer entry point called by drivers.
- **/
-s32 igc_init_hw(struct igc_hw *hw)
-{
-	if (hw->mac.ops.init_hw)
-		return hw->mac.ops.init_hw(hw);
-
-	return -IGC_ERR_CONFIG;
-}
-
-/**
- *  igc_setup_link - Configures link and flow control
- *  @hw: pointer to the HW structure
- *
- *  This configures link and flow control settings for the adapter. This
- *  is a function pointer entry point called by drivers. While modules can
- *  also call this, they probably call their own version of this function.
- **/
-s32 igc_setup_link(struct igc_hw *hw)
-{
-	if (hw->mac.ops.setup_link)
-		return hw->mac.ops.setup_link(hw);
-
-	return -IGC_ERR_CONFIG;
-}
-
-/**
- *  igc_get_speed_and_duplex - Returns current speed and duplex
- *  @hw: pointer to the HW structure
- *  @speed: pointer to a 16-bit value to store the speed
- *  @duplex: pointer to a 16-bit value to store the duplex.
- *
- *  This returns the speed and duplex of the adapter in the two 'out'
- *  variables passed in. This is a function pointer entry point called
- *  by drivers.
- **/
-s32 igc_get_speed_and_duplex(struct igc_hw *hw, u16 *speed, u16 *duplex)
-{
-	if (hw->mac.ops.get_link_up_info)
-		return hw->mac.ops.get_link_up_info(hw, speed, duplex);
-
-	return -IGC_ERR_CONFIG;
-}
-
-/**
- *  igc_setup_led - Configures SW controllable LED
- *  @hw: pointer to the HW structure
- *
- *  This prepares the SW controllable LED for use and saves the current state
- *  of the LED so it can be later restored. This is a function pointer entry
- *  point called by drivers.
- **/
-s32 igc_setup_led(struct igc_hw *hw)
-{
-	if (hw->mac.ops.setup_led)
-		return hw->mac.ops.setup_led(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_cleanup_led - Restores SW controllable LED
- *  @hw: pointer to the HW structure
- *
- *  This restores the SW controllable LED to the value saved off by
- *  igc_setup_led. This is a function pointer entry point called by drivers.
- **/
-s32 igc_cleanup_led(struct igc_hw *hw)
-{
-	if (hw->mac.ops.cleanup_led)
-		return hw->mac.ops.cleanup_led(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_blink_led - Blink SW controllable LED
- *  @hw: pointer to the HW structure
- *
- *  This starts the adapter LED blinking. Request the LED to be setup first
- *  and cleaned up after. This is a function pointer entry point called by
- *  drivers.
- **/
-s32 igc_blink_led(struct igc_hw *hw)
-{
-	if (hw->mac.ops.blink_led)
-		return hw->mac.ops.blink_led(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_id_led_init - store LED configurations in SW
- *  @hw: pointer to the HW structure
- *
- *  Initializes the LED config in SW. This is a function pointer entry point
- *  called by drivers.
- **/
-s32 igc_id_led_init(struct igc_hw *hw)
-{
-	if (hw->mac.ops.id_led_init)
-		return hw->mac.ops.id_led_init(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_led_on - Turn on SW controllable LED
- *  @hw: pointer to the HW structure
- *
- *  Turns the SW defined LED on. This is a function pointer entry point
- *  called by drivers.
- **/
-s32 igc_led_on(struct igc_hw *hw)
-{
-	if (hw->mac.ops.led_on)
-		return hw->mac.ops.led_on(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_led_off - Turn off SW controllable LED
- *  @hw: pointer to the HW structure
- *
- *  Turns the SW defined LED off. This is a function pointer entry point
- *  called by drivers.
- **/
-s32 igc_led_off(struct igc_hw *hw)
-{
-	if (hw->mac.ops.led_off)
-		return hw->mac.ops.led_off(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_reset_adaptive - Reset adaptive IFS
- *  @hw: pointer to the HW structure
- *
- *  Resets the adaptive IFS. Currently no func pointer exists and all
- *  implementations are handled in the generic version of this function.
- **/
-void igc_reset_adaptive(struct igc_hw *hw)
-{
-	igc_reset_adaptive_generic(hw);
-}
-
-/**
- *  igc_update_adaptive - Update adaptive IFS
- *  @hw: pointer to the HW structure
- *
- *  Updates adapter IFS. Currently no func pointer exists and all
- *  implementations are handled in the generic version of this function.
- **/
-void igc_update_adaptive(struct igc_hw *hw)
-{
-	igc_update_adaptive_generic(hw);
-}
-
-/**
- *  igc_disable_pcie_master - Disable PCI-Express master access
- *  @hw: pointer to the HW structure
- *
- *  Disables PCI-Express master access and verifies there are no pending
- *  requests. Currently no func pointer exists and all implementations are
- *  handled in the generic version of this function.
- **/
-s32 igc_disable_pcie_master(struct igc_hw *hw)
-{
-	return igc_disable_pcie_master_generic(hw);
-}
-
-/**
- *  igc_config_collision_dist - Configure collision distance
- *  @hw: pointer to the HW structure
- *
- *  Configures the collision distance to the default value and is used
- *  during link setup.
- **/
-void igc_config_collision_dist(struct igc_hw *hw)
-{
-	if (hw->mac.ops.config_collision_dist)
-		hw->mac.ops.config_collision_dist(hw);
-}
-
-/**
- *  igc_rar_set - Sets a receive address register
- *  @hw: pointer to the HW structure
- *  @addr: address to set the RAR to
- *  @index: the RAR to set
- *
- *  Sets a Receive Address Register (RAR) to the specified address.
- **/
-int igc_rar_set(struct igc_hw *hw, u8 *addr, u32 index)
-{
-	if (hw->mac.ops.rar_set)
-		return hw->mac.ops.rar_set(hw, addr, index);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_validate_mdi_setting - Ensures valid MDI/MDIX SW state
- *  @hw: pointer to the HW structure
- *
- *  Ensures that the MDI/MDIX SW state is valid.
- **/
-s32 igc_validate_mdi_setting(struct igc_hw *hw)
-{
-	if (hw->mac.ops.validate_mdi_setting)
-		return hw->mac.ops.validate_mdi_setting(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_hash_mc_addr - Determines address location in multicast table
- *  @hw: pointer to the HW structure
- *  @mc_addr: Multicast address to hash.
- *
- *  This hashes an address to determine its location in the multicast
- *  table. Currently no func pointer exists and all implementations
- *  are handled in the generic version of this function.
- **/
-u32 igc_hash_mc_addr(struct igc_hw *hw, u8 *mc_addr)
-{
-	return igc_hash_mc_addr_generic(hw, mc_addr);
-}
-
-/**
- *  igc_enable_tx_pkt_filtering - Enable packet filtering on TX
- *  @hw: pointer to the HW structure
- *
- *  Enables packet filtering on transmit packets if manageability is enabled
- *  and host interface is enabled.
- *  Currently no func pointer exists and all implementations are handled in the
- *  generic version of this function.
- **/
-bool igc_enable_tx_pkt_filtering(struct igc_hw *hw)
-{
-	return igc_enable_tx_pkt_filtering_generic(hw);
-}
-
-/**
- *  igc_mng_host_if_write - Writes to the manageability host interface
- *  @hw: pointer to the HW structure
- *  @buffer: pointer to the host interface buffer
- *  @length: size of the buffer
- *  @offset: location in the buffer to write to
- *  @sum: sum of the data (not checksum)
- *
- *  This function writes the buffer content at the offset given on the host if.
- *  It also does alignment considerations to do the writes in most efficient
- *  way.  Also fills up the sum of the buffer in *buffer parameter.
- **/
-s32 igc_mng_host_if_write(struct igc_hw *hw, u8 *buffer, u16 length,
-			    u16 offset, u8 *sum)
-{
-	return igc_mng_host_if_write_generic(hw, buffer, length, offset, sum);
-}
-
-/**
- *  igc_mng_write_cmd_header - Writes manageability command header
- *  @hw: pointer to the HW structure
- *  @hdr: pointer to the host interface command header
- *
- *  Writes the command header after does the checksum calculation.
- **/
-s32 igc_mng_write_cmd_header(struct igc_hw *hw,
-			       struct igc_host_mng_command_header *hdr)
-{
-	return igc_mng_write_cmd_header_generic(hw, hdr);
-}
-
-/**
- *  igc_mng_enable_host_if - Checks host interface is enabled
- *  @hw: pointer to the HW structure
- *
- *  Returns IGC_success upon success, else IGC_ERR_HOST_INTERFACE_COMMAND
- *
- *  This function checks whether the HOST IF is enabled for command operation
- *  and also checks whether the previous command is completed.  It busy waits
- *  in case of previous command is not completed.
- **/
-s32 igc_mng_enable_host_if(struct igc_hw *hw)
-{
-	return igc_mng_enable_host_if_generic(hw);
-}
-
-/**
- *  igc_check_reset_block - Verifies PHY can be reset
- *  @hw: pointer to the HW structure
- *
- *  Checks if the PHY is in a state that can be reset or if manageability
- *  has it tied up. This is a function pointer entry point called by drivers.
- **/
-s32 igc_check_reset_block(struct igc_hw *hw)
-{
-	if (hw->phy.ops.check_reset_block)
-		return hw->phy.ops.check_reset_block(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_phy_reg - Reads PHY register
- *  @hw: pointer to the HW structure
- *  @offset: the register to read
- *  @data: the buffer to store the 16-bit read.
- *
- *  Reads the PHY register and returns the value in data.
- *  This is a function pointer entry point called by drivers.
- **/
-s32 igc_read_phy_reg(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	if (hw->phy.ops.read_reg)
-		return hw->phy.ops.read_reg(hw, offset, data);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_phy_reg - Writes PHY register
- *  @hw: pointer to the HW structure
- *  @offset: the register to write
- *  @data: the value to write.
- *
- *  Writes the PHY register at offset with the value in data.
- *  This is a function pointer entry point called by drivers.
- **/
-s32 igc_write_phy_reg(struct igc_hw *hw, u32 offset, u16 data)
-{
-	if (hw->phy.ops.write_reg)
-		return hw->phy.ops.write_reg(hw, offset, data);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_release_phy - Generic release PHY
- *  @hw: pointer to the HW structure
- *
- *  Return if silicon family does not require a semaphore when accessing the
- *  PHY.
- **/
-void igc_release_phy(struct igc_hw *hw)
-{
-	if (hw->phy.ops.release)
-		hw->phy.ops.release(hw);
-}
-
-/**
- *  igc_acquire_phy - Generic acquire PHY
- *  @hw: pointer to the HW structure
- *
- *  Return success if silicon family does not require a semaphore when
- *  accessing the PHY.
- **/
-s32 igc_acquire_phy(struct igc_hw *hw)
-{
-	if (hw->phy.ops.acquire)
-		return hw->phy.ops.acquire(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_cfg_on_link_up - Configure PHY upon link up
- *  @hw: pointer to the HW structure
- **/
-s32 igc_cfg_on_link_up(struct igc_hw *hw)
-{
-	if (hw->phy.ops.cfg_on_link_up)
-		return hw->phy.ops.cfg_on_link_up(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_kmrn_reg - Reads register using Kumeran interface
- *  @hw: pointer to the HW structure
- *  @offset: the register to read
- *  @data: the location to store the 16-bit value read.
- *
- *  Reads a register out of the Kumeran interface. Currently no func pointer
- *  exists and all implementations are handled in the generic version of
- *  this function.
- **/
-s32 igc_read_kmrn_reg(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	return igc_read_kmrn_reg_generic(hw, offset, data);
-}
-
-/**
- *  igc_write_kmrn_reg - Writes register using Kumeran interface
- *  @hw: pointer to the HW structure
- *  @offset: the register to write
- *  @data: the value to write.
- *
- *  Writes a register to the Kumeran interface. Currently no func pointer
- *  exists and all implementations are handled in the generic version of
- *  this function.
- **/
-s32 igc_write_kmrn_reg(struct igc_hw *hw, u32 offset, u16 data)
-{
-	return igc_write_kmrn_reg_generic(hw, offset, data);
-}
-
-/**
- *  igc_get_cable_length - Retrieves cable length estimation
- *  @hw: pointer to the HW structure
- *
- *  This function estimates the cable length and stores them in
- *  hw->phy.min_length and hw->phy.max_length. This is a function pointer
- *  entry point called by drivers.
- **/
-s32 igc_get_cable_length(struct igc_hw *hw)
-{
-	if (hw->phy.ops.get_cable_length)
-		return hw->phy.ops.get_cable_length(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_get_phy_info - Retrieves PHY information from registers
- *  @hw: pointer to the HW structure
- *
- *  This function gets some information from various PHY registers and
- *  populates hw->phy values with it. This is a function pointer entry
- *  point called by drivers.
- **/
-s32 igc_get_phy_info(struct igc_hw *hw)
-{
-	if (hw->phy.ops.get_info)
-		return hw->phy.ops.get_info(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_phy_hw_reset - Hard PHY reset
- *  @hw: pointer to the HW structure
- *
- *  Performs a hard PHY reset. This is a function pointer entry point called
- *  by drivers.
- **/
-s32 igc_phy_hw_reset(struct igc_hw *hw)
-{
-	if (hw->phy.ops.reset)
-		return hw->phy.ops.reset(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_phy_commit - Soft PHY reset
- *  @hw: pointer to the HW structure
- *
- *  Performs a soft PHY reset on those that apply. This is a function pointer
- *  entry point called by drivers.
- **/
-s32 igc_phy_commit(struct igc_hw *hw)
-{
-	if (hw->phy.ops.commit)
-		return hw->phy.ops.commit(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_set_d0_lplu_state - Sets low power link up state for D0
- *  @hw: pointer to the HW structure
- *  @active: boolean used to enable/disable lplu
- *
- *  Success returns 0, Failure returns 1
- *
- *  The low power link up (lplu) state is set to the power management level D0
- *  and SmartSpeed is disabled when active is true, else clear lplu for D0
- *  and enable Smartspeed.  LPLU and Smartspeed are mutually exclusive.  LPLU
- *  is used during Dx states where the power conservation is most important.
- *  During driver activity, SmartSpeed should be enabled so performance is
- *  maintained.  This is a function pointer entry point called by drivers.
- **/
-s32 igc_set_d0_lplu_state(struct igc_hw *hw, bool active)
-{
-	if (hw->phy.ops.set_d0_lplu_state)
-		return hw->phy.ops.set_d0_lplu_state(hw, active);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_set_d3_lplu_state - Sets low power link up state for D3
- *  @hw: pointer to the HW structure
- *  @active: boolean used to enable/disable lplu
- *
- *  Success returns 0, Failure returns 1
- *
- *  The low power link up (lplu) state is set to the power management level D3
- *  and SmartSpeed is disabled when active is true, else clear lplu for D3
- *  and enable Smartspeed.  LPLU and Smartspeed are mutually exclusive.  LPLU
- *  is used during Dx states where the power conservation is most important.
- *  During driver activity, SmartSpeed should be enabled so performance is
- *  maintained.  This is a function pointer entry point called by drivers.
- **/
-s32 igc_set_d3_lplu_state(struct igc_hw *hw, bool active)
-{
-	if (hw->phy.ops.set_d3_lplu_state)
-		return hw->phy.ops.set_d3_lplu_state(hw, active);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_mac_addr - Reads MAC address
- *  @hw: pointer to the HW structure
- *
- *  Reads the MAC address out of the adapter and stores it in the HW structure.
- *  Currently no func pointer exists and all implementations are handled in the
- *  generic version of this function.
- **/
-s32 igc_read_mac_addr(struct igc_hw *hw)
-{
-	if (hw->mac.ops.read_mac_addr)
-		return hw->mac.ops.read_mac_addr(hw);
-
-	return igc_read_mac_addr_generic(hw);
-}
-
-/**
- *  igc_read_pba_string - Read device part number string
- *  @hw: pointer to the HW structure
- *  @pba_num: pointer to device part number
- *  @pba_num_size: size of part number buffer
- *
- *  Reads the product board assembly (PBA) number from the EEPROM and stores
- *  the value in pba_num.
- *  Currently no func pointer exists and all implementations are handled in the
- *  generic version of this function.
- **/
-s32 igc_read_pba_string(struct igc_hw *hw, u8 *pba_num, u32 pba_num_size)
-{
-	return igc_read_pba_string_generic(hw, pba_num, pba_num_size);
-}
-
-/**
- *  igc_read_pba_length - Read device part number string length
- *  @hw: pointer to the HW structure
- *  @pba_num_size: size of part number buffer
- *
- *  Reads the product board assembly (PBA) number length from the EEPROM and
- *  stores the value in pba_num.
- *  Currently no func pointer exists and all implementations are handled in the
- *  generic version of this function.
- **/
-s32 igc_read_pba_length(struct igc_hw *hw, u32 *pba_num_size)
-{
-	return igc_read_pba_length_generic(hw, pba_num_size);
-}
-
-/**
- *  igc_read_pba_num - Read device part number
- *  @hw: pointer to the HW structure
- *  @pba_num: pointer to device part number
- *
- *  Reads the product board assembly (PBA) number from the EEPROM and stores
- *  the value in pba_num.
- *  Currently no func pointer exists and all implementations are handled in the
- *  generic version of this function.
- **/
-s32 igc_read_pba_num(struct igc_hw *hw, u32 *pba_num)
-{
-	return igc_read_pba_num_generic(hw, pba_num);
-}
-
-/**
- *  igc_validate_nvm_checksum - Verifies NVM (EEPROM) checksum
- *  @hw: pointer to the HW structure
- *
- *  Validates the NVM checksum is correct. This is a function pointer entry
- *  point called by drivers.
- **/
-s32 igc_validate_nvm_checksum(struct igc_hw *hw)
-{
-	if (hw->nvm.ops.validate)
-		return hw->nvm.ops.validate(hw);
-
-	return -IGC_ERR_CONFIG;
-}
-
-/**
- *  igc_update_nvm_checksum - Updates NVM (EEPROM) checksum
- *  @hw: pointer to the HW structure
- *
- *  Updates the NVM checksum. Currently no func pointer exists and all
- *  implementations are handled in the generic version of this function.
- **/
-s32 igc_update_nvm_checksum(struct igc_hw *hw)
-{
-	if (hw->nvm.ops.update)
-		return hw->nvm.ops.update(hw);
-
-	return -IGC_ERR_CONFIG;
-}
-
-/**
- *  igc_reload_nvm - Reloads EEPROM
- *  @hw: pointer to the HW structure
- *
- *  Reloads the EEPROM by setting the "Reinitialize from EEPROM" bit in the
- *  extended control register.
- **/
-void igc_reload_nvm(struct igc_hw *hw)
-{
-	if (hw->nvm.ops.reload)
-		hw->nvm.ops.reload(hw);
-}
-
-/**
- *  igc_read_nvm - Reads NVM (EEPROM)
- *  @hw: pointer to the HW structure
- *  @offset: the word offset to read
- *  @words: number of 16-bit words to read
- *  @data: pointer to the properly sized buffer for the data.
- *
- *  Reads 16-bit chunks of data from the NVM (EEPROM). This is a function
- *  pointer entry point called by drivers.
- **/
-s32 igc_read_nvm(struct igc_hw *hw, u16 offset, u16 words, u16 *data)
-{
-	if (hw->nvm.ops.read)
-		return hw->nvm.ops.read(hw, offset, words, data);
-
-	return -IGC_ERR_CONFIG;
-}
-
-/**
- *  igc_write_nvm - Writes to NVM (EEPROM)
- *  @hw: pointer to the HW structure
- *  @offset: the word offset to read
- *  @words: number of 16-bit words to write
- *  @data: pointer to the properly sized buffer for the data.
- *
- *  Writes 16-bit chunks of data to the NVM (EEPROM). This is a function
- *  pointer entry point called by drivers.
- **/
-s32 igc_write_nvm(struct igc_hw *hw, u16 offset, u16 words, u16 *data)
-{
-	if (hw->nvm.ops.write)
-		return hw->nvm.ops.write(hw, offset, words, data);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_8bit_ctrl_reg - Writes 8bit Control register
- *  @hw: pointer to the HW structure
- *  @reg: 32bit register offset
- *  @offset: the register to write
- *  @data: the value to write.
- *
- *  Writes the PHY register at offset with the value in data.
- *  This is a function pointer entry point called by drivers.
- **/
-s32 igc_write_8bit_ctrl_reg(struct igc_hw *hw, u32 reg, u32 offset,
-			      u8 data)
-{
-	return igc_write_8bit_ctrl_reg_generic(hw, reg, offset, data);
-}
-
-/**
- * igc_power_up_phy - Restores link in case of PHY power down
- * @hw: pointer to the HW structure
- *
- * The phy may be powered down to save power, to turn off link when the
- * driver is unloaded, or wake on lan is not enabled (among others).
- **/
-void igc_power_up_phy(struct igc_hw *hw)
-{
-	if (hw->phy.ops.power_up)
-		hw->phy.ops.power_up(hw);
-
-	igc_setup_link(hw);
-}
-
-/**
- * igc_power_down_phy - Power down PHY
- * @hw: pointer to the HW structure
- *
- * The phy may be powered down to save power, to turn off link when the
- * driver is unloaded, or wake on lan is not enabled (among others).
- **/
-void igc_power_down_phy(struct igc_hw *hw)
-{
-	if (hw->phy.ops.power_down)
-		hw->phy.ops.power_down(hw);
-}
-
-/**
- *  igc_power_up_fiber_serdes_link - Power up serdes link
- *  @hw: pointer to the HW structure
- *
- *  Power on the optics and PCS.
- **/
-void igc_power_up_fiber_serdes_link(struct igc_hw *hw)
-{
-	if (hw->mac.ops.power_up_serdes)
-		hw->mac.ops.power_up_serdes(hw);
-}
-
-/**
- *  igc_shutdown_fiber_serdes_link - Remove link during power down
- *  @hw: pointer to the HW structure
- *
- *  Shutdown the optics and PCS on driver unload.
- **/
-void igc_shutdown_fiber_serdes_link(struct igc_hw *hw)
-{
-	if (hw->mac.ops.shutdown_serdes)
-		hw->mac.ops.shutdown_serdes(hw);
-}
diff --git a/drivers/net/intel/igc/base/igc_api.h b/drivers/net/intel/igc/base/igc_api.h
deleted file mode 100644
index 00681ee4f8..0000000000
--- a/drivers/net/intel/igc/base/igc_api.h
+++ /dev/null
@@ -1,111 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_API_H_
-#define _IGC_API_H_
-
-#include "igc_hw.h"
-
-/* I2C SDA and SCL timing parameters for standard mode */
-#define IGC_I2C_T_HD_STA	4
-#define IGC_I2C_T_LOW		5
-#define IGC_I2C_T_HIGH		4
-#define IGC_I2C_T_SU_STA	5
-#define IGC_I2C_T_HD_DATA	5
-#define IGC_I2C_T_SU_DATA	1
-#define IGC_I2C_T_RISE		1
-#define IGC_I2C_T_FALL		1
-#define IGC_I2C_T_SU_STO	4
-#define IGC_I2C_T_BUF		5
-
-s32 igc_set_i2c_bb(struct igc_hw *hw);
-s32 igc_read_i2c_byte_generic(struct igc_hw *hw, u8 byte_offset,
-				u8 dev_addr, u8 *data);
-s32 igc_write_i2c_byte_generic(struct igc_hw *hw, u8 byte_offset,
-				 u8 dev_addr, u8 data);
-void igc_i2c_bus_clear(struct igc_hw *hw);
-
-void igc_init_function_pointers_82542(struct igc_hw *hw);
-void igc_init_function_pointers_82543(struct igc_hw *hw);
-void igc_init_function_pointers_82540(struct igc_hw *hw);
-void igc_init_function_pointers_82571(struct igc_hw *hw);
-void igc_init_function_pointers_82541(struct igc_hw *hw);
-void igc_init_function_pointers_80003es2lan(struct igc_hw *hw);
-void igc_init_function_pointers_ich8lan(struct igc_hw *hw);
-void igc_init_function_pointers_82575(struct igc_hw *hw);
-void igc_init_function_pointers_vf(struct igc_hw *hw);
-void igc_power_up_fiber_serdes_link(struct igc_hw *hw);
-void igc_shutdown_fiber_serdes_link(struct igc_hw *hw);
-void igc_init_function_pointers_i210(struct igc_hw *hw);
-void igc_init_function_pointers_i225(struct igc_hw *hw);
-
-s32 igc_set_obff_timer(struct igc_hw *hw, u32 itr);
-s32 igc_set_mac_type(struct igc_hw *hw);
-s32 igc_setup_init_funcs(struct igc_hw *hw, bool init_device);
-s32 igc_init_mac_params(struct igc_hw *hw);
-s32 igc_init_nvm_params(struct igc_hw *hw);
-s32 igc_init_phy_params(struct igc_hw *hw);
-s32 igc_init_mbx_params(struct igc_hw *hw);
-s32 igc_get_bus_info(struct igc_hw *hw);
-void igc_clear_vfta(struct igc_hw *hw);
-void igc_write_vfta(struct igc_hw *hw, u32 offset, u32 value);
-s32 igc_force_mac_fc(struct igc_hw *hw);
-s32 igc_check_for_link(struct igc_hw *hw);
-s32 igc_reset_hw(struct igc_hw *hw);
-s32 igc_init_hw(struct igc_hw *hw);
-s32 igc_setup_link(struct igc_hw *hw);
-s32 igc_get_speed_and_duplex(struct igc_hw *hw, u16 *speed, u16 *duplex);
-s32 igc_disable_pcie_master(struct igc_hw *hw);
-void igc_config_collision_dist(struct igc_hw *hw);
-int igc_rar_set(struct igc_hw *hw, u8 *addr, u32 index);
-u32 igc_hash_mc_addr(struct igc_hw *hw, u8 *mc_addr);
-void igc_update_mc_addr_list(struct igc_hw *hw, u8 *mc_addr_list,
-			       u32 mc_addr_count);
-s32 igc_setup_led(struct igc_hw *hw);
-s32 igc_cleanup_led(struct igc_hw *hw);
-s32 igc_check_reset_block(struct igc_hw *hw);
-s32 igc_blink_led(struct igc_hw *hw);
-s32 igc_led_on(struct igc_hw *hw);
-s32 igc_led_off(struct igc_hw *hw);
-s32 igc_id_led_init(struct igc_hw *hw);
-void igc_reset_adaptive(struct igc_hw *hw);
-void igc_update_adaptive(struct igc_hw *hw);
-s32 igc_get_cable_length(struct igc_hw *hw);
-s32 igc_validate_mdi_setting(struct igc_hw *hw);
-s32 igc_read_phy_reg(struct igc_hw *hw, u32 offset, u16 *data);
-s32 igc_write_phy_reg(struct igc_hw *hw, u32 offset, u16 data);
-s32 igc_write_8bit_ctrl_reg(struct igc_hw *hw, u32 reg, u32 offset,
-			      u8 data);
-s32 igc_get_phy_info(struct igc_hw *hw);
-void igc_release_phy(struct igc_hw *hw);
-s32 igc_acquire_phy(struct igc_hw *hw);
-s32 igc_cfg_on_link_up(struct igc_hw *hw);
-s32 igc_phy_hw_reset(struct igc_hw *hw);
-s32 igc_phy_commit(struct igc_hw *hw);
-void igc_power_up_phy(struct igc_hw *hw);
-void igc_power_down_phy(struct igc_hw *hw);
-s32 igc_read_mac_addr(struct igc_hw *hw);
-s32 igc_read_pba_num(struct igc_hw *hw, u32 *part_num);
-s32 igc_read_pba_string(struct igc_hw *hw, u8 *pba_num, u32 pba_num_size);
-s32 igc_read_pba_length(struct igc_hw *hw, u32 *pba_num_size);
-void igc_reload_nvm(struct igc_hw *hw);
-s32 igc_update_nvm_checksum(struct igc_hw *hw);
-s32 igc_validate_nvm_checksum(struct igc_hw *hw);
-s32 igc_read_nvm(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
-s32 igc_read_kmrn_reg(struct igc_hw *hw, u32 offset, u16 *data);
-s32 igc_write_kmrn_reg(struct igc_hw *hw, u32 offset, u16 data);
-s32 igc_write_nvm(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
-s32 igc_set_d3_lplu_state(struct igc_hw *hw, bool active);
-s32 igc_set_d0_lplu_state(struct igc_hw *hw, bool active);
-bool igc_check_mng_mode(struct igc_hw *hw);
-bool igc_enable_tx_pkt_filtering(struct igc_hw *hw);
-s32 igc_mng_enable_host_if(struct igc_hw *hw);
-s32 igc_mng_host_if_write(struct igc_hw *hw, u8 *buffer, u16 length,
-			    u16 offset, u8 *sum);
-s32 igc_mng_write_cmd_header(struct igc_hw *hw,
-			       struct igc_host_mng_command_header *hdr);
-s32 igc_mng_write_dhcp_info(struct igc_hw *hw, u8 *buffer, u16 length);
-u32  igc_translate_register_82542(u32 reg);
-
-#endif /* _IGC_API_H_ */
diff --git a/drivers/net/intel/igc/base/igc_base.c b/drivers/net/intel/igc/base/igc_base.c
deleted file mode 100644
index 1e8b908902..0000000000
--- a/drivers/net/intel/igc/base/igc_base.c
+++ /dev/null
@@ -1,190 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#include "igc_hw.h"
-#include "igc_i225.h"
-#include "igc_mac.h"
-#include "igc_base.h"
-#include "igc_manage.h"
-
-/**
- *  igc_acquire_phy_base - Acquire rights to access PHY
- *  @hw: pointer to the HW structure
- *
- *  Acquire access rights to the correct PHY.
- **/
-s32 igc_acquire_phy_base(struct igc_hw *hw)
-{
-	u16 mask = IGC_SWFW_PHY0_SM;
-
-	DEBUGFUNC("igc_acquire_phy_base");
-
-	if (hw->bus.func == IGC_FUNC_1)
-		mask = IGC_SWFW_PHY1_SM;
-	else if (hw->bus.func == IGC_FUNC_2)
-		mask = IGC_SWFW_PHY2_SM;
-	else if (hw->bus.func == IGC_FUNC_3)
-		mask = IGC_SWFW_PHY3_SM;
-
-	return hw->mac.ops.acquire_swfw_sync(hw, mask);
-}
-
-/**
- *  igc_release_phy_base - Release rights to access PHY
- *  @hw: pointer to the HW structure
- *
- *  A wrapper to release access rights to the correct PHY.
- **/
-void igc_release_phy_base(struct igc_hw *hw)
-{
-	u16 mask = IGC_SWFW_PHY0_SM;
-
-	DEBUGFUNC("igc_release_phy_base");
-
-	if (hw->bus.func == IGC_FUNC_1)
-		mask = IGC_SWFW_PHY1_SM;
-	else if (hw->bus.func == IGC_FUNC_2)
-		mask = IGC_SWFW_PHY2_SM;
-	else if (hw->bus.func == IGC_FUNC_3)
-		mask = IGC_SWFW_PHY3_SM;
-
-	hw->mac.ops.release_swfw_sync(hw, mask);
-}
-
-/**
- *  igc_init_hw_base - Initialize hardware
- *  @hw: pointer to the HW structure
- *
- *  This inits the hardware readying it for operation.
- **/
-s32 igc_init_hw_base(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	s32 ret_val;
-	u16 i, rar_count = mac->rar_entry_count;
-
-	DEBUGFUNC("igc_init_hw_base");
-
-	/* Setup the receive address */
-	igc_init_rx_addrs_generic(hw, rar_count);
-
-	/* Zero out the Multicast HASH table */
-	DEBUGOUT("Zeroing the MTA\n");
-	for (i = 0; i < mac->mta_reg_count; i++)
-		IGC_WRITE_REG_ARRAY(hw, IGC_MTA, i, 0);
-
-	/* Zero out the Unicast HASH table */
-	DEBUGOUT("Zeroing the UTA\n");
-	for (i = 0; i < mac->uta_reg_count; i++)
-		IGC_WRITE_REG_ARRAY(hw, IGC_UTA, i, 0);
-
-	/* Setup link and flow control */
-	ret_val = mac->ops.setup_link(hw);
-	/*
-	 * Clear all of the statistics registers (clear on read).  It is
-	 * important that we do this after we have tried to establish link
-	 * because the symbol error count will increment wildly if there
-	 * is no link.
-	 */
-	igc_clear_hw_cntrs_base_generic(hw);
-
-	return ret_val;
-}
-
-/**
- * igc_power_down_phy_copper_base - Remove link during PHY power down
- * @hw: pointer to the HW structure
- *
- * In the case of a PHY power down to save power, or to turn off link during a
- * driver unload, or wake on lan is not enabled, remove the link.
- **/
-void igc_power_down_phy_copper_base(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-
-	if (!(phy->ops.check_reset_block))
-		return;
-
-	/* If the management interface is not enabled, then power down */
-	if (!phy->ops.check_reset_block(hw))
-		igc_power_down_phy_copper(hw);
-}
-
-/**
- *  igc_rx_fifo_flush_base - Clean Rx FIFO after Rx enable
- *  @hw: pointer to the HW structure
- *
- *  After Rx enable, if manageability is enabled then there is likely some
- *  bad data at the start of the FIFO and possibly in the DMA FIFO.  This
- *  function clears the FIFOs and flushes any packets that came in as Rx was
- *  being enabled.
- **/
-void igc_rx_fifo_flush_base(struct igc_hw *hw)
-{
-	u32 rctl, rlpml, rxdctl[4], rfctl, temp_rctl, rx_enabled;
-	int i, ms_wait;
-
-	DEBUGFUNC("igc_rx_fifo_flush_base");
-
-	/* disable IPv6 options as per hardware errata */
-	rfctl = IGC_READ_REG(hw, IGC_RFCTL);
-	rfctl |= IGC_RFCTL_IPV6_EX_DIS;
-	IGC_WRITE_REG(hw, IGC_RFCTL, rfctl);
-
-	if (!(IGC_READ_REG(hw, IGC_MANC) & IGC_MANC_RCV_TCO_EN))
-		return;
-
-	/* Disable all Rx queues */
-	for (i = 0; i < 4; i++) {
-		rxdctl[i] = IGC_READ_REG(hw, IGC_RXDCTL(i));
-		IGC_WRITE_REG(hw, IGC_RXDCTL(i),
-				rxdctl[i] & ~IGC_RXDCTL_QUEUE_ENABLE);
-	}
-	/* Poll all queues to verify they have shut down */
-	for (ms_wait = 0; ms_wait < 10; ms_wait++) {
-		msec_delay(1);
-		rx_enabled = 0;
-		for (i = 0; i < 4; i++)
-			rx_enabled |= IGC_READ_REG(hw, IGC_RXDCTL(i));
-		if (!(rx_enabled & IGC_RXDCTL_QUEUE_ENABLE))
-			break;
-	}
-
-	if (ms_wait == 10)
-		DEBUGOUT("Queue disable timed out after 10ms\n");
-
-	/* Clear RLPML, RCTL.SBP, RFCTL.LEF, and set RCTL.LPE so that all
-	 * incoming packets are rejected.  Set enable and wait 2ms so that
-	 * any packet that was coming in as RCTL.EN was set is flushed
-	 */
-	IGC_WRITE_REG(hw, IGC_RFCTL, rfctl & ~IGC_RFCTL_LEF);
-
-	rlpml = IGC_READ_REG(hw, IGC_RLPML);
-	IGC_WRITE_REG(hw, IGC_RLPML, 0);
-
-	rctl = IGC_READ_REG(hw, IGC_RCTL);
-	temp_rctl = rctl & ~(IGC_RCTL_EN | IGC_RCTL_SBP);
-	temp_rctl |= IGC_RCTL_LPE;
-
-	IGC_WRITE_REG(hw, IGC_RCTL, temp_rctl);
-	IGC_WRITE_REG(hw, IGC_RCTL, temp_rctl | IGC_RCTL_EN);
-	IGC_WRITE_FLUSH(hw);
-	msec_delay(2);
-
-	/* Enable Rx queues that were previously enabled and restore our
-	 * previous state
-	 */
-	for (i = 0; i < 4; i++)
-		IGC_WRITE_REG(hw, IGC_RXDCTL(i), rxdctl[i]);
-	IGC_WRITE_REG(hw, IGC_RCTL, rctl);
-	IGC_WRITE_FLUSH(hw);
-
-	IGC_WRITE_REG(hw, IGC_RLPML, rlpml);
-	IGC_WRITE_REG(hw, IGC_RFCTL, rfctl);
-
-	/* Flush receive errors generated by workaround */
-	IGC_READ_REG(hw, IGC_ROC);
-	IGC_READ_REG(hw, IGC_RNBC);
-	IGC_READ_REG(hw, IGC_MPC);
-}
diff --git a/drivers/net/intel/igc/base/igc_base.h b/drivers/net/intel/igc/base/igc_base.h
deleted file mode 100644
index 5f342af7ee..0000000000
--- a/drivers/net/intel/igc/base/igc_base.h
+++ /dev/null
@@ -1,127 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_BASE_H_
-#define _IGC_BASE_H_
-
-/* forward declaration */
-s32 igc_init_hw_base(struct igc_hw *hw);
-void igc_power_down_phy_copper_base(struct igc_hw *hw);
-void igc_rx_fifo_flush_base(struct igc_hw *hw);
-s32 igc_acquire_phy_base(struct igc_hw *hw);
-void igc_release_phy_base(struct igc_hw *hw);
-
-/* Transmit Descriptor - Advanced */
-union igc_adv_tx_desc {
-	struct {
-		__le64 buffer_addr;    /* Address of descriptor's data buf */
-		__le32 cmd_type_len;
-		__le32 olinfo_status;
-	} read;
-	struct {
-		__le64 rsvd;       /* Reserved */
-		__le32 nxtseq_seed;
-		__le32 status;
-	} wb;
-};
-
-/* Context descriptors */
-struct igc_adv_tx_context_desc {
-	__le32 vlan_macip_lens;
-	union {
-		__le32 launch_time;
-		__le32 seqnum_seed;
-	} u;
-	__le32 type_tucmd_mlhl;
-	__le32 mss_l4len_idx;
-};
-
-/* Adv Transmit Descriptor Config Masks */
-#define IGC_ADVTXD_DTYP_CTXT	0x00200000 /* Advanced Context Descriptor */
-#define IGC_ADVTXD_DTYP_DATA	0x00300000 /* Advanced Data Descriptor */
-#define IGC_ADVTXD_DCMD_EOP	0x01000000 /* End of Packet */
-#define IGC_ADVTXD_DCMD_IFCS	0x02000000 /* Insert FCS (Ethernet CRC) */
-#define IGC_ADVTXD_DCMD_RS	0x08000000 /* Report Status */
-#define IGC_ADVTXD_DCMD_DDTYP_ISCSI	0x10000000 /* DDP hdr type or iSCSI */
-#define IGC_ADVTXD_DCMD_DEXT	0x20000000 /* Descriptor extension (1=Adv) */
-#define IGC_ADVTXD_DCMD_VLE	0x40000000 /* VLAN pkt enable */
-#define IGC_ADVTXD_DCMD_TSE	0x80000000 /* TCP Seg enable */
-#define IGC_ADVTXD_MAC_LINKSEC	0x00040000 /* Apply LinkSec on pkt */
-#define IGC_ADVTXD_MAC_TSTAMP		0x00080000 /* IEEE1588 Timestamp pkt */
-#define IGC_ADVTXD_STAT_SN_CRC	0x00000002 /* NXTSEQ/SEED prsnt in WB */
-#define IGC_ADVTXD_IDX_SHIFT		4  /* Adv desc Index shift */
-#define IGC_ADVTXD_POPTS_ISCO_1ST	0x00000000 /* 1st TSO of iSCSI PDU */
-#define IGC_ADVTXD_POPTS_ISCO_MDL	0x00000800 /* Middle TSO of iSCSI PDU */
-#define IGC_ADVTXD_POPTS_ISCO_LAST	0x00001000 /* Last TSO of iSCSI PDU */
-/* 1st & Last TSO-full iSCSI PDU*/
-#define IGC_ADVTXD_POPTS_ISCO_FULL	0x00001800
-#define IGC_ADVTXD_POPTS_IPSEC	0x00000400 /* IPSec offload request */
-#define IGC_ADVTXD_PAYLEN_SHIFT	14 /* Adv desc PAYLEN shift */
-
-/* Advanced Transmit Context Descriptor Config */
-#define IGC_ADVTXD_MACLEN_SHIFT	9  /* Adv ctxt desc mac len shift */
-#define IGC_ADVTXD_VLAN_SHIFT		16  /* Adv ctxt vlan tag shift */
-#define IGC_ADVTXD_TUCMD_IPV4		0x00000400  /* IP Packet Type: 1=IPv4 */
-#define IGC_ADVTXD_TUCMD_IPV6		0x00000000  /* IP Packet Type: 0=IPv6 */
-#define IGC_ADVTXD_TUCMD_L4T_UDP	0x00000000  /* L4 Packet TYPE of UDP */
-#define IGC_ADVTXD_TUCMD_L4T_TCP	0x00000800  /* L4 Packet TYPE of TCP */
-#define IGC_ADVTXD_TUCMD_L4T_SCTP	0x00001000  /* L4 Packet TYPE of SCTP */
-#define IGC_ADVTXD_TUCMD_IPSEC_TYPE_ESP	0x00002000 /* IPSec Type ESP */
-/* IPSec Encrypt Enable for ESP */
-#define IGC_ADVTXD_TUCMD_IPSEC_ENCRYPT_EN	0x00004000
-/* Req requires Markers and CRC */
-#define IGC_ADVTXD_TUCMD_MKRREQ	0x00002000
-#define IGC_ADVTXD_L4LEN_SHIFT	8  /* Adv ctxt L4LEN shift */
-#define IGC_ADVTXD_MSS_SHIFT		16  /* Adv ctxt MSS shift */
-/* Adv ctxt IPSec SA IDX mask */
-#define IGC_ADVTXD_IPSEC_SA_INDEX_MASK	0x000000FF
-/* Adv ctxt IPSec ESP len mask */
-#define IGC_ADVTXD_IPSEC_ESP_LEN_MASK		0x000000FF
-
-#define IGC_RAR_ENTRIES_BASE		16
-
-/* Receive Descriptor - Advanced */
-union igc_adv_rx_desc {
-	struct {
-		__le64 pkt_addr; /* Packet buffer address */
-		__le64 hdr_addr; /* Header buffer address */
-	} read;
-	struct {
-		struct {
-			union {
-				__le32 data;
-				struct {
-					__le16 pkt_info; /*RSS type, Pkt type*/
-					/* Split Header, header buffer len */
-					__le16 hdr_info;
-				} hs_rss;
-			} lo_dword;
-			union {
-				__le32 rss; /* RSS Hash */
-				struct {
-					__le16 ip_id; /* IP id */
-					__le16 csum; /* Packet Checksum */
-				} csum_ip;
-			} hi_dword;
-		} lower;
-		struct {
-			__le32 status_error; /* ext status/error */
-			__le16 length; /* Packet length */
-			__le16 vlan; /* VLAN tag */
-		} upper;
-	} wb;  /* writeback */
-};
-
-/* Additional Transmit Descriptor Control definitions */
-#define IGC_TXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Tx Queue */
-
-/* Additional Receive Descriptor Control definitions */
-#define IGC_RXDCTL_QUEUE_ENABLE	0x02000000 /* Ena specific Rx Queue */
-
-/* SRRCTL bit definitions */
-#define IGC_SRRCTL_BSIZEPKT_SHIFT		10 /* Shift _right_ */
-#define IGC_SRRCTL_BSIZEHDRSIZE_SHIFT		2  /* Shift _left_ */
-#define IGC_SRRCTL_DESCTYPE_ADV_ONEBUF	0x02000000
-
-#endif /* _IGC_BASE_H_ */
diff --git a/drivers/net/intel/igc/base/igc_defines.h b/drivers/net/intel/igc/base/igc_defines.h
deleted file mode 100644
index 280570b157..0000000000
--- a/drivers/net/intel/igc/base/igc_defines.h
+++ /dev/null
@@ -1,1670 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_DEFINES_H_
-#define _IGC_DEFINES_H_
-
-/* Number of Transmit and Receive Descriptors must be a multiple of 8 */
-#define REQ_TX_DESCRIPTOR_MULTIPLE  8
-#define REQ_RX_DESCRIPTOR_MULTIPLE  8
-
-/* Definitions for power management and wakeup registers */
-/* Wake Up Control */
-#define IGC_WUC_APME		0x00000001 /* APM Enable */
-#define IGC_WUC_PME_EN	0x00000002 /* PME Enable */
-#define IGC_WUC_PME_STATUS	0x00000004 /* PME Status */
-#define IGC_WUC_APMPME	0x00000008 /* Assert PME on APM Wakeup */
-#define IGC_WUC_PHY_WAKE	0x00000100 /* if PHY supports wakeup */
-
-/* Wake Up Filter Control */
-#define IGC_WUFC_LNKC	0x00000001 /* Link Status Change Wakeup Enable */
-#define IGC_WUFC_MAG	0x00000002 /* Magic Packet Wakeup Enable */
-#define IGC_WUFC_EX	0x00000004 /* Directed Exact Wakeup Enable */
-#define IGC_WUFC_MC	0x00000008 /* Directed Multicast Wakeup Enable */
-#define IGC_WUFC_BC	0x00000010 /* Broadcast Wakeup Enable */
-#define IGC_WUFC_ARP	0x00000020 /* ARP Request Packet Wakeup Enable */
-#define IGC_WUFC_IPV4	0x00000040 /* Directed IPv4 Packet Wakeup Enable */
-#define IGC_WUFC_FLX0		0x00010000 /* Flexible Filter 0 Enable */
-
-/* Wake Up Status */
-#define IGC_WUS_LNKC		IGC_WUFC_LNKC
-#define IGC_WUS_MAG		IGC_WUFC_MAG
-#define IGC_WUS_EX		IGC_WUFC_EX
-#define IGC_WUS_MC		IGC_WUFC_MC
-#define IGC_WUS_BC		IGC_WUFC_BC
-
-/* Extended Device Control */
-#define IGC_CTRL_EXT_LPCD		0x00000004 /* LCD Power Cycle Done */
-#define IGC_CTRL_EXT_SDP4_DATA	0x00000010 /* SW Definable Pin 4 data */
-#define IGC_CTRL_EXT_SDP6_DATA	0x00000040 /* SW Definable Pin 6 data */
-#define IGC_CTRL_EXT_SDP3_DATA	0x00000080 /* SW Definable Pin 3 data */
-/* SDP 4/5 (bits 8,9) are reserved in >= 82575 */
-#define IGC_CTRL_EXT_SDP4_DIR	0x00000100 /* Direction of SDP4 0=in 1=out */
-#define IGC_CTRL_EXT_SDP6_DIR	0x00000400 /* Direction of SDP6 0=in 1=out */
-#define IGC_CTRL_EXT_SDP3_DIR	0x00000800 /* Direction of SDP3 0=in 1=out */
-#define IGC_CTRL_EXT_FORCE_SMBUS	0x00000800 /* Force SMBus mode */
-#define IGC_CTRL_EXT_EE_RST	0x00002000 /* Reinitialize from EEPROM */
-/* Physical Func Reset Done Indication */
-#define IGC_CTRL_EXT_PFRSTD	0x00004000
-#define IGC_CTRL_EXT_SDLPE	0X00040000  /* SerDes Low Power Enable */
-#define IGC_CTRL_EXT_SPD_BYPS	0x00008000 /* Speed Select Bypass */
-#define IGC_CTRL_EXT_RO_DIS	0x00020000 /* Relaxed Ordering disable */
-#define IGC_CTRL_EXT_DMA_DYN_CLK_EN	0x00080000 /* DMA Dynamic Clk Gating */
-#define IGC_CTRL_EXT_LINK_MODE_MASK	0x00C00000
-/* Offset of the link mode field in Ctrl Ext register */
-#define IGC_CTRL_EXT_LINK_MODE_OFFSET	22
-#define IGC_CTRL_EXT_LINK_MODE_1000BASE_KX	0x00400000
-#define IGC_CTRL_EXT_LINK_MODE_GMII	0x00000000
-#define IGC_CTRL_EXT_LINK_MODE_PCIE_SERDES	0x00C00000
-#define IGC_CTRL_EXT_LINK_MODE_SGMII	0x00800000
-#define IGC_CTRL_EXT_EIAME		0x01000000
-#define IGC_CTRL_EXT_IRCA		0x00000001
-#define IGC_CTRL_EXT_DRV_LOAD		0x10000000 /* Drv loaded bit for FW */
-#define IGC_CTRL_EXT_IAME		0x08000000 /* Int ACK Auto-mask */
-#define IGC_CTRL_EXT_PBA_CLR		0x80000000 /* PBA Clear */
-#define IGC_CTRL_EXT_LSECCK		0x00001000
-#define IGC_CTRL_EXT_PHYPDEN		0x00100000
-#define IGC_I2CCMD_REG_ADDR_SHIFT	16
-#define IGC_I2CCMD_PHY_ADDR_SHIFT	24
-#define IGC_I2CCMD_OPCODE_READ	0x08000000
-#define IGC_I2CCMD_OPCODE_WRITE	0x00000000
-#define IGC_I2CCMD_READY		0x20000000
-#define IGC_I2CCMD_ERROR		0x80000000
-#define IGC_I2CCMD_SFP_DATA_ADDR(a)	(0x0000 + (a))
-#define IGC_I2CCMD_SFP_DIAG_ADDR(a)	(0x0100 + (a))
-#define IGC_MAX_SGMII_PHY_REG_ADDR	255
-#define IGC_I2CCMD_PHY_TIMEOUT	200
-#define IGC_IVAR_VALID	0x80
-#define IGC_GPIE_NSICR	0x00000001
-#define IGC_GPIE_MSIX_MODE	0x00000010
-#define IGC_GPIE_EIAME	0x40000000
-#define IGC_GPIE_PBA		0x80000000
-
-/* Receive Descriptor bit definitions */
-#define IGC_RXD_STAT_DD	0x01    /* Descriptor Done */
-#define IGC_RXD_STAT_EOP	0x02    /* End of Packet */
-#define IGC_RXD_STAT_IXSM	0x04    /* Ignore checksum */
-#define IGC_RXD_STAT_VP	0x08    /* IEEE VLAN Packet */
-#define IGC_RXD_STAT_UDPCS	0x10    /* UDP xsum calculated */
-#define IGC_RXD_STAT_TCPCS	0x20    /* TCP xsum calculated */
-#define IGC_RXD_STAT_IPCS	0x40    /* IP xsum calculated */
-#define IGC_RXD_STAT_PIF	0x80    /* passed in-exact filter */
-#define IGC_RXD_STAT_IPIDV	0x200   /* IP identification valid */
-#define IGC_RXD_STAT_UDPV	0x400   /* Valid UDP checksum */
-#define IGC_RXD_STAT_DYNINT	0x800   /* Pkt caused INT via DYNINT */
-#define IGC_RXD_ERR_CE	0x01    /* CRC Error */
-#define IGC_RXD_ERR_SE	0x02    /* Symbol Error */
-#define IGC_RXD_ERR_SEQ	0x04    /* Sequence Error */
-#define IGC_RXD_ERR_CXE	0x10    /* Carrier Extension Error */
-#define IGC_RXD_ERR_TCPE	0x20    /* TCP/UDP Checksum Error */
-#define IGC_RXD_ERR_IPE	0x40    /* IP Checksum Error */
-#define IGC_RXD_ERR_RXE	0x80    /* Rx Data Error */
-#define IGC_RXD_SPC_VLAN_MASK	0x0FFF  /* VLAN ID is in lower 12 bits */
-
-#define IGC_RXDEXT_STATERR_TST	0x00000100 /* Time Stamp taken */
-#define IGC_RXDEXT_STATERR_LB		0x00040000
-#define IGC_RXDEXT_STATERR_CE		0x01000000
-#define IGC_RXDEXT_STATERR_SE		0x02000000
-#define IGC_RXDEXT_STATERR_SEQ	0x04000000
-#define IGC_RXDEXT_STATERR_CXE	0x10000000
-#define IGC_RXDEXT_STATERR_TCPE	0x20000000
-#define IGC_RXDEXT_STATERR_IPE	0x40000000
-#define IGC_RXDEXT_STATERR_RXE	0x80000000
-
-/* mask to determine if packets should be dropped due to frame errors */
-#define IGC_RXD_ERR_FRAME_ERR_MASK ( \
-	IGC_RXD_ERR_CE  |		\
-	IGC_RXD_ERR_SE  |		\
-	IGC_RXD_ERR_SEQ |		\
-	IGC_RXD_ERR_CXE |		\
-	IGC_RXD_ERR_RXE)
-
-/* Same mask, but for extended and packet split descriptors */
-#define IGC_RXDEXT_ERR_FRAME_ERR_MASK ( \
-	IGC_RXDEXT_STATERR_CE  |	\
-	IGC_RXDEXT_STATERR_SE  |	\
-	IGC_RXDEXT_STATERR_SEQ |	\
-	IGC_RXDEXT_STATERR_CXE |	\
-	IGC_RXDEXT_STATERR_RXE)
-
-#define IGC_MRQC_ENABLE_RSS_2Q		0x00000001
-#define IGC_MRQC_RSS_FIELD_MASK		0xFFFF0000
-#define IGC_MRQC_RSS_FIELD_IPV4_TCP		0x00010000
-#define IGC_MRQC_RSS_FIELD_IPV4		0x00020000
-#define IGC_MRQC_RSS_FIELD_IPV6_TCP_EX	0x00040000
-#define IGC_MRQC_RSS_FIELD_IPV6		0x00100000
-#define IGC_MRQC_RSS_FIELD_IPV6_TCP		0x00200000
-
-#define IGC_RXDPS_HDRSTAT_HDRSP		0x00008000
-
-/* Management Control */
-#define IGC_MANC_SMBUS_EN	0x00000001 /* SMBus Enabled - RO */
-#define IGC_MANC_ASF_EN	0x00000002 /* ASF Enabled - RO */
-#define IGC_MANC_ARP_EN	0x00002000 /* Enable ARP Request Filtering */
-#define IGC_MANC_RCV_TCO_EN	0x00020000 /* Receive TCO Packets Enabled */
-#define IGC_MANC_BLK_PHY_RST_ON_IDE	0x00040000 /* Block phy resets */
-/* Enable MAC address filtering */
-#define IGC_MANC_EN_MAC_ADDR_FILTER	0x00100000
-/* Enable MNG packets to host memory */
-#define IGC_MANC_EN_MNG2HOST		0x00200000
-
-#define IGC_MANC2H_PORT_623		0x00000020 /* Port 0x26f */
-#define IGC_MANC2H_PORT_664		0x00000040 /* Port 0x298 */
-#define IGC_MDEF_PORT_623		0x00000800 /* Port 0x26f */
-#define IGC_MDEF_PORT_664		0x00000400 /* Port 0x298 */
-
-/* Receive Control */
-#define IGC_RCTL_RST		0x00000001 /* Software reset */
-#define IGC_RCTL_EN		0x00000002 /* enable */
-#define IGC_RCTL_SBP		0x00000004 /* store bad packet */
-#define IGC_RCTL_UPE		0x00000008 /* unicast promisc enable */
-#define IGC_RCTL_MPE		0x00000010 /* multicast promisc enable */
-#define IGC_RCTL_LPE		0x00000020 /* long packet enable */
-#define IGC_RCTL_LBM_NO	0x00000000 /* no loopback mode */
-#define IGC_RCTL_LBM_MAC	0x00000040 /* MAC loopback mode */
-#define IGC_RCTL_LBM_TCVR	0x000000C0 /* tcvr loopback mode */
-#define IGC_RCTL_DTYP_PS	0x00000400 /* Packet Split descriptor */
-#define IGC_RCTL_RDMTS_HALF	0x00000000 /* Rx desc min thresh size */
-#define IGC_RCTL_RDMTS_HEX	0x00010000
-#define IGC_RCTL_RDMTS1_HEX	IGC_RCTL_RDMTS_HEX
-#define IGC_RCTL_MO_SHIFT	12 /* multicast offset shift */
-#define IGC_RCTL_MO_3		0x00003000 /* multicast offset 15:4 */
-#define IGC_RCTL_BAM		0x00008000 /* broadcast enable */
-/* these buffer sizes are valid if IGC_RCTL_BSEX is 0 */
-#define IGC_RCTL_SZ_2048	0x00000000 /* Rx buffer size 2048 */
-#define IGC_RCTL_SZ_1024	0x00010000 /* Rx buffer size 1024 */
-#define IGC_RCTL_SZ_512	0x00020000 /* Rx buffer size 512 */
-#define IGC_RCTL_SZ_256	0x00030000 /* Rx buffer size 256 */
-/* these buffer sizes are valid if IGC_RCTL_BSEX is 1 */
-#define IGC_RCTL_SZ_16384	0x00010000 /* Rx buffer size 16384 */
-#define IGC_RCTL_SZ_8192	0x00020000 /* Rx buffer size 8192 */
-#define IGC_RCTL_SZ_4096	0x00030000 /* Rx buffer size 4096 */
-#define IGC_RCTL_VFE		0x00040000 /* vlan filter enable */
-#define IGC_RCTL_CFIEN	0x00080000 /* canonical form enable */
-#define IGC_RCTL_CFI		0x00100000 /* canonical form indicator */
-#define IGC_RCTL_DPF		0x00400000 /* discard pause frames */
-#define IGC_RCTL_PMCF		0x00800000 /* pass MAC control frames */
-#define IGC_RCTL_BSEX		0x02000000 /* Buffer size extension */
-#define IGC_RCTL_SECRC	0x04000000 /* Strip Ethernet CRC */
-
-#define IGC_DTXMXPKTSZ_TSN     0x19 /* 1600 bytes of max TX DMA packet size */
-#define IGC_TXPBSIZE_TSN       0x04145145 /* 5k bytes buffer for each queue */
-
-/* Transmit Scheduling */
-#define IGC_TQAVCTRL_TRANSMIT_MODE_TSN 0x00000001
-#define IGC_TQAVCTRL_ENHANCED_QAV      0x00000008
-
-#define IGC_TXQCTL_QUEUE_MODE_LAUNCHT  0x00000001
-
-/* Use byte values for the following shift parameters
- * Usage:
- *     psrctl |= (((ROUNDUP(value0, 128) >> IGC_PSRCTL_BSIZE0_SHIFT) &
- *		  IGC_PSRCTL_BSIZE0_MASK) |
- *		((ROUNDUP(value1, 1024) >> IGC_PSRCTL_BSIZE1_SHIFT) &
- *		  IGC_PSRCTL_BSIZE1_MASK) |
- *		((ROUNDUP(value2, 1024) << IGC_PSRCTL_BSIZE2_SHIFT) &
- *		  IGC_PSRCTL_BSIZE2_MASK) |
- *		((ROUNDUP(value3, 1024) << IGC_PSRCTL_BSIZE3_SHIFT) |;
- *		  IGC_PSRCTL_BSIZE3_MASK))
- * where value0 = [128..16256],  default=256
- *       value1 = [1024..64512], default=4096
- *       value2 = [0..64512],    default=4096
- *       value3 = [0..64512],    default=0
- */
-
-#define IGC_PSRCTL_BSIZE0_MASK	0x0000007F
-#define IGC_PSRCTL_BSIZE1_MASK	0x00003F00
-#define IGC_PSRCTL_BSIZE2_MASK	0x003F0000
-#define IGC_PSRCTL_BSIZE3_MASK	0x3F000000
-
-#define IGC_PSRCTL_BSIZE0_SHIFT	7    /* Shift _right_ 7 */
-#define IGC_PSRCTL_BSIZE1_SHIFT	2    /* Shift _right_ 2 */
-#define IGC_PSRCTL_BSIZE2_SHIFT	6    /* Shift _left_ 6 */
-#define IGC_PSRCTL_BSIZE3_SHIFT	14   /* Shift _left_ 14 */
-
-/* SWFW_SYNC Definitions */
-#define IGC_SWFW_EEP_SM	0x01
-#define IGC_SWFW_PHY0_SM	0x02
-#define IGC_SWFW_PHY1_SM	0x04
-#define IGC_SWFW_CSR_SM	0x08
-#define IGC_SWFW_PHY2_SM	0x20
-#define IGC_SWFW_PHY3_SM	0x40
-#define IGC_SWFW_SW_MNG_SM	0x400
-
-/* Device Control */
-#define IGC_CTRL_FD		0x00000001  /* Full duplex.0=half; 1=full */
-#define IGC_CTRL_PRIOR	0x00000004  /* Priority on PCI. 0=rx,1=fair */
-#define IGC_CTRL_GIO_MASTER_DISABLE 0x00000004 /*Blocks new Master reqs */
-#define IGC_CTRL_LRST		0x00000008  /* Link reset. 0=normal,1=reset */
-#define IGC_CTRL_ASDE		0x00000020  /* Auto-speed detect enable */
-#define IGC_CTRL_SLU		0x00000040  /* Set link up (Force Link) */
-#define IGC_CTRL_ILOS		0x00000080  /* Invert Loss-Of Signal */
-#define IGC_CTRL_SPD_SEL	0x00000300  /* Speed Select Mask */
-#define IGC_CTRL_SPD_10	0x00000000  /* Force 10Mb */
-#define IGC_CTRL_SPD_100	0x00000100  /* Force 100Mb */
-#define IGC_CTRL_SPD_1000	0x00000200  /* Force 1Gb */
-#define IGC_CTRL_FRCSPD	0x00000800  /* Force Speed */
-#define IGC_CTRL_FRCDPX	0x00001000  /* Force Duplex */
-#define IGC_CTRL_LANPHYPC_OVERRIDE	0x00010000 /* SW control of LANPHYPC */
-#define IGC_CTRL_LANPHYPC_VALUE	0x00020000 /* SW value of LANPHYPC */
-#define IGC_CTRL_MEHE		0x00080000 /* Memory Error Handling Enable */
-#define IGC_CTRL_SWDPIN0	0x00040000 /* SWDPIN 0 value */
-#define IGC_CTRL_SWDPIN1	0x00080000 /* SWDPIN 1 value */
-#define IGC_CTRL_SWDPIN2	0x00100000 /* SWDPIN 2 value */
-#define IGC_CTRL_ADVD3WUC	0x00100000 /* D3 WUC */
-#define IGC_CTRL_EN_PHY_PWR_MGMT	0x00200000 /* PHY PM enable */
-#define IGC_CTRL_SWDPIN3	0x00200000 /* SWDPIN 3 value */
-#define IGC_CTRL_SWDPIO0	0x00400000 /* SWDPIN 0 Input or output */
-#define IGC_CTRL_SWDPIO2	0x01000000 /* SWDPIN 2 input or output */
-#define IGC_CTRL_SWDPIO3	0x02000000 /* SWDPIN 3 input or output */
-#define IGC_CTRL_DEV_RST	0x20000000 /* Device reset */
-#define IGC_CTRL_RST		0x04000000 /* Global reset */
-#define IGC_CTRL_RFCE		0x08000000 /* Receive Flow Control enable */
-#define IGC_CTRL_TFCE		0x10000000 /* Transmit flow control enable */
-#define IGC_CTRL_VME		0x40000000 /* IEEE VLAN mode enable */
-#define IGC_CTRL_PHY_RST	0x80000000 /* PHY Reset */
-#define IGC_CTRL_I2C_ENA	0x02000000 /* I2C enable */
-
-#define IGC_CTRL_MDIO_DIR		IGC_CTRL_SWDPIO2
-#define IGC_CTRL_MDIO			IGC_CTRL_SWDPIN2
-#define IGC_CTRL_MDC_DIR		IGC_CTRL_SWDPIO3
-#define IGC_CTRL_MDC			IGC_CTRL_SWDPIN3
-
-#define IGC_CONNSW_AUTOSENSE_EN	0x1
-#define IGC_CONNSW_ENRGSRC		0x4
-#define IGC_CONNSW_PHYSD		0x400
-#define IGC_CONNSW_PHY_PDN		0x800
-#define IGC_CONNSW_SERDESD		0x200
-#define IGC_CONNSW_AUTOSENSE_CONF	0x2
-#define IGC_PCS_CFG_PCS_EN		8
-#define IGC_PCS_LCTL_FLV_LINK_UP	1
-#define IGC_PCS_LCTL_FSV_10		0
-#define IGC_PCS_LCTL_FSV_100		2
-#define IGC_PCS_LCTL_FSV_1000		4
-#define IGC_PCS_LCTL_FDV_FULL		8
-#define IGC_PCS_LCTL_FSD		0x10
-#define IGC_PCS_LCTL_FORCE_LINK	0x20
-#define IGC_PCS_LCTL_FORCE_FCTRL	0x80
-#define IGC_PCS_LCTL_AN_ENABLE	0x10000
-#define IGC_PCS_LCTL_AN_RESTART	0x20000
-#define IGC_PCS_LCTL_AN_TIMEOUT	0x40000
-#define IGC_ENABLE_SERDES_LOOPBACK	0x0410
-
-#define IGC_PCS_LSTS_LINK_OK		1
-#define IGC_PCS_LSTS_SPEED_100	2
-#define IGC_PCS_LSTS_SPEED_1000	4
-#define IGC_PCS_LSTS_DUPLEX_FULL	8
-#define IGC_PCS_LSTS_SYNK_OK		0x10
-#define IGC_PCS_LSTS_AN_COMPLETE	0x10000
-
-/* Device Status */
-#define IGC_STATUS_FD			0x00000001 /* Duplex 0=half 1=full */
-#define IGC_STATUS_LU			0x00000002 /* Link up.0=no,1=link */
-#define IGC_STATUS_FUNC_MASK		0x0000000C /* PCI Function Mask */
-#define IGC_STATUS_FUNC_SHIFT		2
-#define IGC_STATUS_FUNC_1		0x00000004 /* Function 1 */
-#define IGC_STATUS_TXOFF		0x00000010 /* transmission paused */
-#define IGC_STATUS_SPEED_MASK	0x000000C0
-#define IGC_STATUS_SPEED_10		0x00000000 /* Speed 10Mb/s */
-#define IGC_STATUS_SPEED_100		0x00000040 /* Speed 100Mb/s */
-#define IGC_STATUS_SPEED_1000		0x00000080 /* Speed 1000Mb/s */
-/* Speed 2.5Gb/s indication for I225 */
-#define IGC_STATUS_SPEED_2500		0x00400000
-#define IGC_STATUS_LAN_INIT_DONE	0x00000200 /* Lan Init Compltn by NVM */
-#define IGC_STATUS_PHYRA		0x00000400 /* PHY Reset Asserted */
-#define IGC_STATUS_GIO_MASTER_ENABLE	0x00080000 /* Master request status */
-#define IGC_STATUS_PCI66		0x00000800 /* In 66Mhz slot */
-#define IGC_STATUS_BUS64		0x00001000 /* In 64 bit slot */
-#define IGC_STATUS_2P5_SKU		0x00001000 /* Val of 2.5GBE SKU strap */
-#define IGC_STATUS_2P5_SKU_OVER	0x00002000 /* Val of 2.5GBE SKU Over */
-#define IGC_STATUS_PCIX_MODE		0x00002000 /* PCI-X mode */
-#define IGC_STATUS_PCIX_SPEED		0x0000C000 /* PCI-X bus speed */
-
-/* Constants used to interpret the masked PCI-X bus speed. */
-#define IGC_STATUS_PCIX_SPEED_66	0x00000000 /* PCI-X bus spd 50-66MHz */
-#define IGC_STATUS_PCIX_SPEED_100	0x00004000 /* PCI-X bus spd 66-100MHz */
-#define IGC_STATUS_PCIX_SPEED_133	0x00008000 /* PCI-X bus spd 100-133MHz*/
-#define IGC_STATUS_PCIM_STATE		0x40000000 /* PCIm function state */
-
-#define SPEED_10	10
-#define SPEED_100	100
-#define SPEED_1000	1000
-#define SPEED_2500	2500
-#define HALF_DUPLEX	1
-#define FULL_DUPLEX	2
-
-#define PHY_FORCE_TIME	20
-
-#define ADVERTISE_10_HALF		0x0001
-#define ADVERTISE_10_FULL		0x0002
-#define ADVERTISE_100_HALF		0x0004
-#define ADVERTISE_100_FULL		0x0008
-#define ADVERTISE_1000_HALF		0x0010 /* Not used, just FYI */
-#define ADVERTISE_1000_FULL		0x0020
-#define ADVERTISE_2500_HALF		0x0040 /* NOT used, just FYI */
-#define ADVERTISE_2500_FULL		0x0080
-
-/* 1000/H is not supported, nor spec-compliant. */
-#define IGC_ALL_SPEED_DUPLEX	( \
-	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
-	ADVERTISE_100_FULL | ADVERTISE_1000_FULL)
-#define IGC_ALL_SPEED_DUPLEX_2500 ( \
-	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
-	ADVERTISE_100_FULL | ADVERTISE_1000_FULL | ADVERTISE_2500_FULL)
-#define IGC_ALL_NOT_GIG	( \
-	ADVERTISE_10_HALF | ADVERTISE_10_FULL | ADVERTISE_100_HALF | \
-	ADVERTISE_100_FULL)
-#define IGC_ALL_100_SPEED	(ADVERTISE_100_HALF | ADVERTISE_100_FULL)
-#define IGC_ALL_10_SPEED	(ADVERTISE_10_HALF | ADVERTISE_10_FULL)
-#define IGC_ALL_HALF_DUPLEX	(ADVERTISE_10_HALF | ADVERTISE_100_HALF)
-
-#define AUTONEG_ADVERTISE_SPEED_DEFAULT		IGC_ALL_SPEED_DUPLEX
-#define AUTONEG_ADVERTISE_SPEED_DEFAULT_2500	IGC_ALL_SPEED_DUPLEX_2500
-
-/* LED Control */
-#define IGC_PHY_LED0_MODE_MASK	0x00000007
-#define IGC_PHY_LED0_IVRT		0x00000008
-#define IGC_PHY_LED0_MASK		0x0000001F
-
-#define IGC_LEDCTL_LED0_MODE_MASK	0x0000000F
-#define IGC_LEDCTL_LED0_MODE_SHIFT	0
-#define IGC_LEDCTL_LED0_IVRT		0x00000040
-#define IGC_LEDCTL_LED0_BLINK		0x00000080
-
-#define IGC_LEDCTL_MODE_LINK_UP	0x2
-#define IGC_LEDCTL_MODE_LED_ON	0xE
-#define IGC_LEDCTL_MODE_LED_OFF	0xF
-
-/* Transmit Descriptor bit definitions */
-#define IGC_TXD_DTYP_D	0x00100000 /* Data Descriptor */
-#define IGC_TXD_DTYP_C	0x00000000 /* Context Descriptor */
-#define IGC_TXD_POPTS_IXSM	0x01       /* Insert IP checksum */
-#define IGC_TXD_POPTS_TXSM	0x02       /* Insert TCP/UDP checksum */
-#define IGC_TXD_CMD_EOP	0x01000000 /* End of Packet */
-#define IGC_TXD_CMD_IFCS	0x02000000 /* Insert FCS (Ethernet CRC) */
-#define IGC_TXD_CMD_IC	0x04000000 /* Insert Checksum */
-#define IGC_TXD_CMD_RS	0x08000000 /* Report Status */
-#define IGC_TXD_CMD_RPS	0x10000000 /* Report Packet Sent */
-#define IGC_TXD_CMD_DEXT	0x20000000 /* Desc extension (0 = legacy) */
-#define IGC_TXD_CMD_VLE	0x40000000 /* Add VLAN tag */
-#define IGC_TXD_CMD_IDE	0x80000000 /* Enable Tidv register */
-#define IGC_TXD_STAT_DD	0x00000001 /* Descriptor Done */
-#define IGC_TXD_STAT_EC	0x00000002 /* Excess Collisions */
-#define IGC_TXD_STAT_LC	0x00000004 /* Late Collisions */
-#define IGC_TXD_STAT_TU	0x00000008 /* Transmit underrun */
-#define IGC_TXD_CMD_TCP	0x01000000 /* TCP packet */
-#define IGC_TXD_CMD_IP	0x02000000 /* IP packet */
-#define IGC_TXD_CMD_TSE	0x04000000 /* TCP Seg enable */
-#define IGC_TXD_STAT_TC	0x00000004 /* Tx Underrun */
-#define IGC_TXD_EXTCMD_TSTAMP	0x00000010 /* IEEE1588 Timestamp packet */
-
-/* Transmit Control */
-#define IGC_TCTL_EN		0x00000002 /* enable Tx */
-#define IGC_TCTL_PSP		0x00000008 /* pad short packets */
-#define IGC_TCTL_CT		0x00000ff0 /* collision threshold */
-#define IGC_TCTL_COLD		0x003ff000 /* collision distance */
-#define IGC_TCTL_RTLC		0x01000000 /* Re-transmit on late collision */
-#define IGC_TCTL_MULR		0x10000000 /* Multiple request support */
-
-/* Transmit Arbitration Count */
-#define IGC_TARC0_ENABLE	0x00000400 /* Enable Tx Queue 0 */
-
-/* SerDes Control */
-#define IGC_SCTL_DISABLE_SERDES_LOOPBACK	0x0400
-#define IGC_SCTL_ENABLE_SERDES_LOOPBACK	0x0410
-
-/* Receive Checksum Control */
-#define IGC_RXCSUM_IPOFL	0x00000100 /* IPv4 checksum offload */
-#define IGC_RXCSUM_TUOFL	0x00000200 /* TCP / UDP checksum offload */
-#define IGC_RXCSUM_CRCOFL	0x00000800 /* CRC32 offload enable */
-#define IGC_RXCSUM_IPPCSE	0x00001000 /* IP payload checksum enable */
-#define IGC_RXCSUM_PCSD	0x00002000 /* packet checksum disabled */
-
-/* GPY211 - I225 defines */
-#define GPY_MMD_MASK		0xFFFF0000
-#define GPY_MMD_SHIFT		16
-#define GPY_REG_MASK		0x0000FFFF
-/* Header split receive */
-#define IGC_RFCTL_NFSW_DIS		0x00000040
-#define IGC_RFCTL_NFSR_DIS		0x00000080
-#define IGC_RFCTL_ACK_DIS		0x00001000
-#define IGC_RFCTL_EXTEN		0x00008000
-#define IGC_RFCTL_IPV6_EX_DIS		0x00010000
-#define IGC_RFCTL_NEW_IPV6_EXT_DIS	0x00020000
-#define IGC_RFCTL_LEF			0x00040000
-
-/* Collision related configuration parameters */
-#define IGC_CT_SHIFT			4
-#define IGC_COLLISION_THRESHOLD	15
-#define IGC_COLLISION_DISTANCE	63
-#define IGC_COLD_SHIFT		12
-
-/* Default values for the transmit IPG register */
-#define DEFAULT_82542_TIPG_IPGT		10
-#define DEFAULT_82543_TIPG_IPGT_FIBER	9
-#define DEFAULT_82543_TIPG_IPGT_COPPER	8
-
-#define IGC_TIPG_IPGT_MASK		0x000003FF
-
-#define DEFAULT_82542_TIPG_IPGR1	2
-#define DEFAULT_82543_TIPG_IPGR1	8
-#define IGC_TIPG_IPGR1_SHIFT		10
-
-#define DEFAULT_82542_TIPG_IPGR2	10
-#define DEFAULT_82543_TIPG_IPGR2	6
-#define DEFAULT_80003ES2LAN_TIPG_IPGR2	7
-#define IGC_TIPG_IPGR2_SHIFT		20
-
-/* Ethertype field values */
-#define ETHERNET_IEEE_VLAN_TYPE		0x8100  /* 802.3ac packet */
-
-#define ETHERNET_FCS_SIZE		4
-#define MAX_JUMBO_FRAME_SIZE		0x3F00
-/* The datasheet maximum supported RX size is 9.5KB (9728 bytes) */
-#define MAX_RX_JUMBO_FRAME_SIZE		0x2600
-#define IGC_TX_PTR_GAP		0x1F
-
-/* Extended Configuration Control and Size */
-#define IGC_EXTCNF_CTRL_MDIO_SW_OWNERSHIP	0x00000020
-#define IGC_EXTCNF_CTRL_LCD_WRITE_ENABLE	0x00000001
-#define IGC_EXTCNF_CTRL_OEM_WRITE_ENABLE	0x00000008
-#define IGC_EXTCNF_CTRL_SWFLAG		0x00000020
-#define IGC_EXTCNF_CTRL_GATE_PHY_CFG		0x00000080
-#define IGC_EXTCNF_SIZE_EXT_PCIE_LENGTH_MASK	0x00FF0000
-#define IGC_EXTCNF_SIZE_EXT_PCIE_LENGTH_SHIFT	16
-#define IGC_EXTCNF_CTRL_EXT_CNF_POINTER_MASK	0x0FFF0000
-#define IGC_EXTCNF_CTRL_EXT_CNF_POINTER_SHIFT	16
-
-#define IGC_PHY_CTRL_D0A_LPLU			0x00000002
-#define IGC_PHY_CTRL_NOND0A_LPLU		0x00000004
-#define IGC_PHY_CTRL_NOND0A_GBE_DISABLE	0x00000008
-#define IGC_PHY_CTRL_GBE_DISABLE		0x00000040
-
-#define IGC_KABGTXD_BGSQLBIAS			0x00050000
-
-/* Low Power IDLE Control */
-#define IGC_LPIC_LPIET_SHIFT		24	/* Low Power Idle Entry Time */
-
-/* PBA constants */
-#define IGC_PBA_8K		0x0008    /* 8KB */
-#define IGC_PBA_10K		0x000A    /* 10KB */
-#define IGC_PBA_12K		0x000C    /* 12KB */
-#define IGC_PBA_14K		0x000E    /* 14KB */
-#define IGC_PBA_16K		0x0010    /* 16KB */
-#define IGC_PBA_18K		0x0012
-#define IGC_PBA_20K		0x0014
-#define IGC_PBA_22K		0x0016
-#define IGC_PBA_24K		0x0018
-#define IGC_PBA_26K		0x001A
-#define IGC_PBA_30K		0x001E
-#define IGC_PBA_32K		0x0020
-#define IGC_PBA_34K		0x0022
-#define IGC_PBA_35K		0x0023
-#define IGC_PBA_38K		0x0026
-#define IGC_PBA_40K		0x0028
-#define IGC_PBA_48K		0x0030    /* 48KB */
-#define IGC_PBA_64K		0x0040    /* 64KB */
-
-#define IGC_PBA_RXA_MASK	0xFFFF
-
-#define IGC_PBS_16K		IGC_PBA_16K
-
-/* Uncorrectable/correctable ECC Error counts and enable bits */
-#define IGC_PBECCSTS_CORR_ERR_CNT_MASK	0x000000FF
-#define IGC_PBECCSTS_UNCORR_ERR_CNT_MASK	0x0000FF00
-#define IGC_PBECCSTS_UNCORR_ERR_CNT_SHIFT	8
-#define IGC_PBECCSTS_ECC_ENABLE		0x00010000
-
-#define IFS_MAX			80
-#define IFS_MIN			40
-#define IFS_RATIO		4
-#define IFS_STEP		10
-#define MIN_NUM_XMITS		1000
-
-/* SW Semaphore Register */
-#define IGC_SWSM_SMBI		0x00000001 /* Driver Semaphore bit */
-#define IGC_SWSM_SWESMBI	0x00000002 /* FW Semaphore bit */
-#define IGC_SWSM_DRV_LOAD	0x00000008 /* Driver Loaded Bit */
-
-#define IGC_SWSM2_LOCK	0x00000002 /* Secondary driver semaphore bit */
-
-/* Interrupt Cause Read */
-#define IGC_ICR_TXDW		0x00000001 /* Transmit desc written back */
-#define IGC_ICR_TXQE		0x00000002 /* Transmit Queue empty */
-#define IGC_ICR_LSC		0x00000004 /* Link Status Change */
-#define IGC_ICR_RXSEQ		0x00000008 /* Rx sequence error */
-#define IGC_ICR_RXDMT0	0x00000010 /* Rx desc min. threshold (0) */
-#define IGC_ICR_RXO		0x00000040 /* Rx overrun */
-#define IGC_ICR_RXT0		0x00000080 /* Rx timer intr (ring 0) */
-#define IGC_ICR_VMMB		0x00000100 /* VM MB event */
-#define IGC_ICR_RXCFG		0x00000400 /* Rx /c/ ordered set */
-#define IGC_ICR_GPI_EN0	0x00000800 /* GP Int 0 */
-#define IGC_ICR_GPI_EN1	0x00001000 /* GP Int 1 */
-#define IGC_ICR_GPI_EN2	0x00002000 /* GP Int 2 */
-#define IGC_ICR_GPI_EN3	0x00004000 /* GP Int 3 */
-#define IGC_ICR_TXD_LOW	0x00008000
-#define IGC_ICR_MNG		0x00040000 /* Manageability event */
-#define IGC_ICR_ECCER		0x00400000 /* Uncorrectable ECC Error */
-#define IGC_ICR_TS		0x00080000 /* Time Sync Interrupt */
-#define IGC_ICR_DRSTA		0x40000000 /* Device Reset Asserted */
-/* If this bit asserted, the driver should claim the interrupt */
-#define IGC_ICR_INT_ASSERTED	0x80000000
-#define IGC_ICR_DOUTSYNC	0x10000000 /* NIC DMA out of sync */
-#define IGC_ICR_RXQ0		0x00100000 /* Rx Queue 0 Interrupt */
-#define IGC_ICR_RXQ1		0x00200000 /* Rx Queue 1 Interrupt */
-#define IGC_ICR_TXQ0		0x00400000 /* Tx Queue 0 Interrupt */
-#define IGC_ICR_TXQ1		0x00800000 /* Tx Queue 1 Interrupt */
-#define IGC_ICR_OTHER		0x01000000 /* Other Interrupts */
-#define IGC_ICR_FER		0x00400000 /* Fatal Error */
-
-#define IGC_ICR_THS		0x00800000 /* ICR.THS: Thermal Sensor Event*/
-#define IGC_ICR_MDDET		0x10000000 /* Malicious Driver Detect */
-
-/* PBA ECC Register */
-#define IGC_PBA_ECC_COUNTER_MASK	0xFFF00000 /* ECC counter mask */
-#define IGC_PBA_ECC_COUNTER_SHIFT	20 /* ECC counter shift value */
-#define IGC_PBA_ECC_CORR_EN	0x00000001 /* Enable ECC error correction */
-#define IGC_PBA_ECC_STAT_CLR	0x00000002 /* Clear ECC error counter */
-#define IGC_PBA_ECC_INT_EN	0x00000004 /* Enable ICR bit 5 on ECC error */
-
-/* Extended Interrupt Cause Read */
-#define IGC_EICR_RX_QUEUE0	0x00000001 /* Rx Queue 0 Interrupt */
-#define IGC_EICR_RX_QUEUE1	0x00000002 /* Rx Queue 1 Interrupt */
-#define IGC_EICR_RX_QUEUE2	0x00000004 /* Rx Queue 2 Interrupt */
-#define IGC_EICR_RX_QUEUE3	0x00000008 /* Rx Queue 3 Interrupt */
-#define IGC_EICR_TX_QUEUE0	0x00000100 /* Tx Queue 0 Interrupt */
-#define IGC_EICR_TX_QUEUE1	0x00000200 /* Tx Queue 1 Interrupt */
-#define IGC_EICR_TX_QUEUE2	0x00000400 /* Tx Queue 2 Interrupt */
-#define IGC_EICR_TX_QUEUE3	0x00000800 /* Tx Queue 3 Interrupt */
-#define IGC_EICR_TCP_TIMER	0x40000000 /* TCP Timer */
-#define IGC_EICR_OTHER	0x80000000 /* Interrupt Cause Active */
-/* TCP Timer */
-#define IGC_TCPTIMER_KS	0x00000100 /* KickStart */
-#define IGC_TCPTIMER_COUNT_ENABLE	0x00000200 /* Count Enable */
-#define IGC_TCPTIMER_COUNT_FINISH	0x00000400 /* Count finish */
-#define IGC_TCPTIMER_LOOP	0x00000800 /* Loop */
-
-/* This defines the bits that are set in the Interrupt Mask
- * Set/Read Register.  Each bit is documented below:
- *   o RXT0   = Receiver Timer Interrupt (ring 0)
- *   o TXDW   = Transmit Descriptor Written Back
- *   o RXDMT0 = Receive Descriptor Minimum Threshold hit (ring 0)
- *   o RXSEQ  = Receive Sequence Error
- *   o LSC    = Link Status Change
- */
-#define IMS_ENABLE_MASK ( \
-	IGC_IMS_RXT0   |    \
-	IGC_IMS_TXDW   |    \
-	IGC_IMS_RXDMT0 |    \
-	IGC_IMS_RXSEQ  |    \
-	IGC_IMS_LSC)
-
-/* Interrupt Mask Set */
-#define IGC_IMS_TXDW		IGC_ICR_TXDW    /* Tx desc written back */
-#define IGC_IMS_TXQE		IGC_ICR_TXQE    /* Transmit Queue empty */
-#define IGC_IMS_LSC		IGC_ICR_LSC     /* Link Status Change */
-#define IGC_IMS_VMMB		IGC_ICR_VMMB    /* Mail box activity */
-#define IGC_IMS_RXSEQ		IGC_ICR_RXSEQ   /* Rx sequence error */
-#define IGC_IMS_RXDMT0	IGC_ICR_RXDMT0  /* Rx desc min. threshold */
-#define IGC_QVECTOR_MASK	0x7FFC		/* Q-vector mask */
-#define IGC_ITR_VAL_MASK	0x04		/* ITR value mask */
-#define IGC_IMS_RXO		IGC_ICR_RXO     /* Rx overrun */
-#define IGC_IMS_RXT0		IGC_ICR_RXT0    /* Rx timer intr */
-#define IGC_IMS_TXD_LOW	IGC_ICR_TXD_LOW
-#define IGC_IMS_ECCER		IGC_ICR_ECCER   /* Uncorrectable ECC Error */
-#define IGC_IMS_TS		IGC_ICR_TS      /* Time Sync Interrupt */
-#define IGC_IMS_DRSTA		IGC_ICR_DRSTA   /* Device Reset Asserted */
-#define IGC_IMS_DOUTSYNC	IGC_ICR_DOUTSYNC /* NIC DMA out of sync */
-#define IGC_IMS_RXQ0		IGC_ICR_RXQ0 /* Rx Queue 0 Interrupt */
-#define IGC_IMS_RXQ1		IGC_ICR_RXQ1 /* Rx Queue 1 Interrupt */
-#define IGC_IMS_TXQ0		IGC_ICR_TXQ0 /* Tx Queue 0 Interrupt */
-#define IGC_IMS_TXQ1		IGC_ICR_TXQ1 /* Tx Queue 1 Interrupt */
-#define IGC_IMS_OTHER		IGC_ICR_OTHER /* Other Interrupts */
-#define IGC_IMS_FER		IGC_ICR_FER /* Fatal Error */
-
-#define IGC_IMS_THS		IGC_ICR_THS /* ICR.TS: Thermal Sensor Event*/
-#define IGC_IMS_MDDET		IGC_ICR_MDDET /* Malicious Driver Detect */
-/* Extended Interrupt Mask Set */
-#define IGC_EIMS_RX_QUEUE0	IGC_EICR_RX_QUEUE0 /* Rx Queue 0 Interrupt */
-#define IGC_EIMS_RX_QUEUE1	IGC_EICR_RX_QUEUE1 /* Rx Queue 1 Interrupt */
-#define IGC_EIMS_RX_QUEUE2	IGC_EICR_RX_QUEUE2 /* Rx Queue 2 Interrupt */
-#define IGC_EIMS_RX_QUEUE3	IGC_EICR_RX_QUEUE3 /* Rx Queue 3 Interrupt */
-#define IGC_EIMS_TX_QUEUE0	IGC_EICR_TX_QUEUE0 /* Tx Queue 0 Interrupt */
-#define IGC_EIMS_TX_QUEUE1	IGC_EICR_TX_QUEUE1 /* Tx Queue 1 Interrupt */
-#define IGC_EIMS_TX_QUEUE2	IGC_EICR_TX_QUEUE2 /* Tx Queue 2 Interrupt */
-#define IGC_EIMS_TX_QUEUE3	IGC_EICR_TX_QUEUE3 /* Tx Queue 3 Interrupt */
-#define IGC_EIMS_TCP_TIMER	IGC_EICR_TCP_TIMER /* TCP Timer */
-#define IGC_EIMS_OTHER	IGC_EICR_OTHER   /* Interrupt Cause Active */
-
-/* Interrupt Cause Set */
-#define IGC_ICS_LSC		IGC_ICR_LSC       /* Link Status Change */
-#define IGC_ICS_RXSEQ		IGC_ICR_RXSEQ     /* Rx sequence error */
-#define IGC_ICS_RXDMT0	IGC_ICR_RXDMT0    /* Rx desc min. threshold */
-#define IGC_ICS_DRSTA		IGC_ICR_DRSTA     /* Device Reset Aserted */
-
-/* Extended Interrupt Cause Set */
-#define IGC_EICS_RX_QUEUE0	IGC_EICR_RX_QUEUE0 /* Rx Queue 0 Interrupt */
-#define IGC_EICS_RX_QUEUE1	IGC_EICR_RX_QUEUE1 /* Rx Queue 1 Interrupt */
-#define IGC_EICS_RX_QUEUE2	IGC_EICR_RX_QUEUE2 /* Rx Queue 2 Interrupt */
-#define IGC_EICS_RX_QUEUE3	IGC_EICR_RX_QUEUE3 /* Rx Queue 3 Interrupt */
-#define IGC_EICS_TX_QUEUE0	IGC_EICR_TX_QUEUE0 /* Tx Queue 0 Interrupt */
-#define IGC_EICS_TX_QUEUE1	IGC_EICR_TX_QUEUE1 /* Tx Queue 1 Interrupt */
-#define IGC_EICS_TX_QUEUE2	IGC_EICR_TX_QUEUE2 /* Tx Queue 2 Interrupt */
-#define IGC_EICS_TX_QUEUE3	IGC_EICR_TX_QUEUE3 /* Tx Queue 3 Interrupt */
-#define IGC_EICS_TCP_TIMER	IGC_EICR_TCP_TIMER /* TCP Timer */
-#define IGC_EICS_OTHER	IGC_EICR_OTHER   /* Interrupt Cause Active */
-
-#define IGC_EITR_ITR_INT_MASK	0x0000FFFF
-#define IGC_EITR_INTERVAL 0x00007FFC
-/* IGC_EITR_CNT_IGNR is only for 82576 and newer */
-#define IGC_EITR_CNT_IGNR	0x80000000 /* Don't reset counters on write */
-
-/* Transmit Descriptor Control */
-#define IGC_TXDCTL_PTHRESH	0x0000003F /* TXDCTL Prefetch Threshold */
-#define IGC_TXDCTL_HTHRESH	0x00003F00 /* TXDCTL Host Threshold */
-#define IGC_TXDCTL_WTHRESH	0x003F0000 /* TXDCTL Writeback Threshold */
-#define IGC_TXDCTL_GRAN	0x01000000 /* TXDCTL Granularity */
-#define IGC_TXDCTL_FULL_TX_DESC_WB	0x01010000 /* GRAN=1, WTHRESH=1 */
-#define IGC_TXDCTL_MAX_TX_DESC_PREFETCH 0x0100001F /* GRAN=1, PTHRESH=31 */
-/* Enable the counting of descriptors still to be processed. */
-#define IGC_TXDCTL_COUNT_DESC	0x00400000
-
-/* Flow Control Constants */
-#define FLOW_CONTROL_ADDRESS_LOW	0x00C28001
-#define FLOW_CONTROL_ADDRESS_HIGH	0x00000100
-#define FLOW_CONTROL_TYPE		0x8808
-
-/* 802.1q VLAN Packet Size */
-#define VLAN_TAG_SIZE			4    /* 802.3ac tag (not DMA'd) */
-#define IGC_VLAN_FILTER_TBL_SIZE	128  /* VLAN Filter Table (4096 bits) */
-
-/* Receive Address
- * Number of high/low register pairs in the RAR. The RAR (Receive Address
- * Registers) holds the directed and multicast addresses that we monitor.
- * Technically, we have 16 spots.  However, we reserve one of these spots
- * (RAR[15]) for our directed address used by controllers with
- * manageability enabled, allowing us room for 15 multicast addresses.
- */
-#define IGC_RAR_ENTRIES	15
-#define IGC_RAH_AV		0x80000000 /* Receive descriptor valid */
-#define IGC_RAL_MAC_ADDR_LEN	4
-#define IGC_RAH_MAC_ADDR_LEN	2
-#define IGC_RAH_QUEUE_MASK_82575	0x000C0000
-#define IGC_RAH_POOL_1	0x00040000
-
-/* Error Codes */
-#define IGC_SUCCESS			0
-#define IGC_ERR_NVM			1
-#define IGC_ERR_PHY			2
-#define IGC_ERR_CONFIG		3
-#define IGC_ERR_PARAM			4
-#define IGC_ERR_MAC_INIT		5
-#define IGC_ERR_PHY_TYPE		6
-#define IGC_ERR_RESET			9
-#define IGC_ERR_MASTER_REQUESTS_PENDING	10
-#define IGC_ERR_HOST_INTERFACE_COMMAND	11
-#define IGC_BLK_PHY_RESET		12
-#define IGC_ERR_SWFW_SYNC		13
-#define IGC_NOT_IMPLEMENTED		14
-#define IGC_ERR_MBX			15
-#define IGC_ERR_INVALID_ARGUMENT	16
-#define IGC_ERR_NO_SPACE		17
-#define IGC_ERR_NVM_PBA_SECTION	18
-#define IGC_ERR_I2C			19
-#define IGC_ERR_INVM_VALUE_NOT_FOUND	20
-
-/* Loop limit on how long we wait for auto-negotiation to complete */
-#define FIBER_LINK_UP_LIMIT		50
-#define COPPER_LINK_UP_LIMIT		10
-#define PHY_AUTO_NEG_LIMIT		45
-#define PHY_FORCE_LIMIT			20
-/* Number of 100 microseconds we wait for PCI Express master disable */
-#define MASTER_DISABLE_TIMEOUT		800
-/* Number of milliseconds we wait for PHY configuration done after MAC reset */
-#define PHY_CFG_TIMEOUT			100
-/* Number of 2 milliseconds we wait for acquiring MDIO ownership. */
-#define MDIO_OWNERSHIP_TIMEOUT		10
-/* Number of milliseconds for NVM auto read done after MAC reset. */
-#define AUTO_READ_DONE_TIMEOUT		10
-
-/* Flow Control */
-#define IGC_FCRTH_RTH		0x0000FFF8 /* Mask Bits[15:3] for RTH */
-#define IGC_FCRTL_RTL		0x0000FFF8 /* Mask Bits[15:3] for RTL */
-#define IGC_FCRTL_XONE	0x80000000 /* Enable XON frame transmission */
-
-/* Transmit Configuration Word */
-#define IGC_TXCW_FD		0x00000020 /* TXCW full duplex */
-#define IGC_TXCW_PAUSE	0x00000080 /* TXCW sym pause request */
-#define IGC_TXCW_ASM_DIR	0x00000100 /* TXCW astm pause direction */
-#define IGC_TXCW_PAUSE_MASK	0x00000180 /* TXCW pause request mask */
-#define IGC_TXCW_ANE		0x80000000 /* Auto-neg enable */
-
-/* Receive Configuration Word */
-#define IGC_RXCW_CW		0x0000ffff /* RxConfigWord mask */
-#define IGC_RXCW_IV		0x08000000 /* Receive config invalid */
-#define IGC_RXCW_C		0x20000000 /* Receive config */
-#define IGC_RXCW_SYNCH	0x40000000 /* Receive config synch */
-
-#define IGC_TSYNCTXCTL_VALID		0x00000001 /* Tx timestamp valid */
-#define IGC_TSYNCTXCTL_ENABLED	0x00000010 /* enable Tx timestamping */
-
-/* HH Time Sync */
-#define IGC_TSYNCTXCTL_MAX_ALLOWED_DLY_MASK	0x0000F000 /* max delay */
-#define IGC_TSYNCTXCTL_SYNC_COMP_ERR		0x20000000 /* sync err */
-#define IGC_TSYNCTXCTL_SYNC_COMP		0x40000000 /* sync complete */
-#define IGC_TSYNCTXCTL_START_SYNC		0x80000000 /* initiate sync */
-
-#define IGC_TSYNCRXCTL_VALID		0x00000001 /* Rx timestamp valid */
-#define IGC_TSYNCRXCTL_TYPE_MASK	0x0000000E /* Rx type mask */
-#define IGC_TSYNCRXCTL_TYPE_L2_V2	0x00
-#define IGC_TSYNCRXCTL_TYPE_L4_V1	0x02
-#define IGC_TSYNCRXCTL_TYPE_L2_L4_V2	0x04
-#define IGC_TSYNCRXCTL_TYPE_ALL	0x08
-#define IGC_TSYNCRXCTL_TYPE_EVENT_V2	0x0A
-#define IGC_TSYNCRXCTL_ENABLED	0x00000010 /* enable Rx timestamping */
-#define IGC_TSYNCRXCTL_SYSCFI		0x00000020 /* Sys clock frequency */
-
-#define IGC_RXMTRL_PTP_V1_SYNC_MESSAGE	0x00000000
-#define IGC_RXMTRL_PTP_V1_DELAY_REQ_MESSAGE	0x00010000
-
-#define IGC_RXMTRL_PTP_V2_SYNC_MESSAGE	0x00000000
-#define IGC_RXMTRL_PTP_V2_DELAY_REQ_MESSAGE	0x01000000
-
-#define IGC_TSYNCRXCFG_PTP_V1_CTRLT_MASK		0x000000FF
-#define IGC_TSYNCRXCFG_PTP_V1_SYNC_MESSAGE		0x00
-#define IGC_TSYNCRXCFG_PTP_V1_DELAY_REQ_MESSAGE	0x01
-#define IGC_TSYNCRXCFG_PTP_V1_FOLLOWUP_MESSAGE	0x02
-#define IGC_TSYNCRXCFG_PTP_V1_DELAY_RESP_MESSAGE	0x03
-#define IGC_TSYNCRXCFG_PTP_V1_MANAGEMENT_MESSAGE	0x04
-
-#define IGC_TSYNCRXCFG_PTP_V2_MSGID_MASK		0x00000F00
-#define IGC_TSYNCRXCFG_PTP_V2_SYNC_MESSAGE		0x0000
-#define IGC_TSYNCRXCFG_PTP_V2_DELAY_REQ_MESSAGE	0x0100
-#define IGC_TSYNCRXCFG_PTP_V2_PATH_DELAY_REQ_MESSAGE	0x0200
-#define IGC_TSYNCRXCFG_PTP_V2_PATH_DELAY_RESP_MESSAGE	0x0300
-#define IGC_TSYNCRXCFG_PTP_V2_FOLLOWUP_MESSAGE	0x0800
-#define IGC_TSYNCRXCFG_PTP_V2_DELAY_RESP_MESSAGE	0x0900
-#define IGC_TSYNCRXCFG_PTP_V2_PATH_DELAY_FOLLOWUP_MESSAGE 0x0A00
-#define IGC_TSYNCRXCFG_PTP_V2_ANNOUNCE_MESSAGE	0x0B00
-#define IGC_TSYNCRXCFG_PTP_V2_SIGNALLING_MESSAGE	0x0C00
-#define IGC_TSYNCRXCFG_PTP_V2_MANAGEMENT_MESSAGE	0x0D00
-
-#define IGC_TIMINCA_16NS_SHIFT	24
-#define IGC_TIMINCA_INCPERIOD_SHIFT	24
-#define IGC_TIMINCA_INCVALUE_MASK	0x00FFFFFF
-
-/* Time Sync Interrupt Cause/Mask Register Bits */
-#define TSINTR_SYS_WRAP	(1 << 0) /* SYSTIM Wrap around. */
-#define TSINTR_TXTS	(1 << 1) /* Transmit Timestamp. */
-#define TSINTR_TT0	(1 << 3) /* Target Time 0 Trigger. */
-#define TSINTR_TT1	(1 << 4) /* Target Time 1 Trigger. */
-#define TSINTR_AUTT0	(1 << 5) /* Auxiliary Timestamp 0 Taken. */
-#define TSINTR_AUTT1	(1 << 6) /* Auxiliary Timestamp 1 Taken. */
-
-#define TSYNC_INTERRUPTS	TSINTR_TXTS
-
-/* Split Replication Receive Control */
-#define IGC_SRRCTL_TIMESTAMP           0x40000000
-#define IGC_SRRCTL_TIMER1SEL(timer)    (((timer) & 0x3) << 14)
-#define IGC_SRRCTL_TIMER0SEL(timer)    (((timer) & 0x3) << 17)
-
-/* Sample RX tstamp in PHY sop */
-#define IGC_TSYNCRXCTL_RXSYNSIG         0x00000400
-
-/* Sample TX tstamp in PHY sop */
-#define IGC_TSYNCTXCTL_TXSYNSIG         0x00000020
-
-/* TSAUXC Configuration Bits */
-#define TSAUXC_EN_TT0	(1 << 0)  /* Enable target time 0. */
-#define TSAUXC_EN_TT1	(1 << 1)  /* Enable target time 1. */
-#define TSAUXC_EN_CLK0	(1 << 2)  /* Enable Configurable Frequency Clock 0. */
-#define TSAUXC_ST0	(1 << 4)  /* Start Clock 0 Toggle on Target Time 0. */
-#define TSAUXC_EN_CLK1	(1 << 5)  /* Enable Configurable Frequency Clock 1. */
-#define TSAUXC_ST1	(1 << 7)  /* Start Clock 1 Toggle on Target Time 1. */
-#define TSAUXC_EN_TS0	(1 << 8)  /* Enable hardware timestamp 0. */
-#define TSAUXC_EN_TS1	(1 << 10) /* Enable hardware timestamp 0. */
-
-/* SDP Configuration Bits */
-#define AUX0_SEL_SDP0	(0u << 0)  /* Assign SDP0 to auxiliary time stamp 0. */
-#define AUX0_SEL_SDP1	(1u << 0)  /* Assign SDP1 to auxiliary time stamp 0. */
-#define AUX0_SEL_SDP2	(2u << 0)  /* Assign SDP2 to auxiliary time stamp 0. */
-#define AUX0_SEL_SDP3	(3u << 0)  /* Assign SDP3 to auxiliary time stamp 0. */
-#define AUX0_TS_SDP_EN	(1u << 2)  /* Enable auxiliary time stamp trigger 0. */
-#define AUX1_SEL_SDP0	(0u << 3)  /* Assign SDP0 to auxiliary time stamp 1. */
-#define AUX1_SEL_SDP1	(1u << 3)  /* Assign SDP1 to auxiliary time stamp 1. */
-#define AUX1_SEL_SDP2	(2u << 3)  /* Assign SDP2 to auxiliary time stamp 1. */
-#define AUX1_SEL_SDP3	(3u << 3)  /* Assign SDP3 to auxiliary time stamp 1. */
-#define AUX1_TS_SDP_EN	(1u << 5)  /* Enable auxiliary time stamp trigger 1. */
-#define TS_SDP0_EN	(1u << 8)  /* SDP0 is assigned to Tsync. */
-#define TS_SDP1_EN	(1u << 11) /* SDP1 is assigned to Tsync. */
-#define TS_SDP2_EN	(1u << 14) /* SDP2 is assigned to Tsync. */
-#define TS_SDP3_EN	(1u << 17) /* SDP3 is assigned to Tsync. */
-#define TS_SDP0_SEL_TT0	(0u << 6)  /* Target time 0 is output on SDP0. */
-#define TS_SDP0_SEL_TT1	(1u << 6)  /* Target time 1 is output on SDP0. */
-#define TS_SDP1_SEL_TT0	(0u << 9)  /* Target time 0 is output on SDP1. */
-#define TS_SDP1_SEL_TT1	(1u << 9)  /* Target time 1 is output on SDP1. */
-#define TS_SDP0_SEL_FC0	(2u << 6)  /* Freq clock  0 is output on SDP0. */
-#define TS_SDP0_SEL_FC1	(3u << 6)  /* Freq clock  1 is output on SDP0. */
-#define TS_SDP1_SEL_FC0	(2u << 9)  /* Freq clock  0 is output on SDP1. */
-#define TS_SDP1_SEL_FC1	(3u << 9)  /* Freq clock  1 is output on SDP1. */
-#define TS_SDP2_SEL_TT0	(0u << 12) /* Target time 0 is output on SDP2. */
-#define TS_SDP2_SEL_TT1	(1u << 12) /* Target time 1 is output on SDP2. */
-#define TS_SDP2_SEL_FC0	(2u << 12) /* Freq clock  0 is output on SDP2. */
-#define TS_SDP2_SEL_FC1	(3u << 12) /* Freq clock  1 is output on SDP2. */
-#define TS_SDP3_SEL_TT0	(0u << 15) /* Target time 0 is output on SDP3. */
-#define TS_SDP3_SEL_TT1	(1u << 15) /* Target time 1 is output on SDP3. */
-#define TS_SDP3_SEL_FC0	(2u << 15) /* Freq clock  0 is output on SDP3. */
-#define TS_SDP3_SEL_FC1	(3u << 15) /* Freq clock  1 is output on SDP3. */
-
-#define IGC_CTRL_SDP0_DIR	0x00400000  /* SDP0 Data direction */
-#define IGC_CTRL_SDP1_DIR	0x00800000  /* SDP1 Data direction */
-
-/* Extended Device Control */
-#define IGC_CTRL_EXT_SDP2_DIR	0x00000400 /* SDP2 Data direction */
-
-/* ETQF register bit definitions */
-#define IGC_ETQF_1588			(1 << 30)
-#define IGC_FTQF_VF_BP		0x00008000
-#define IGC_FTQF_1588_TIME_STAMP	0x08000000
-#define IGC_FTQF_MASK			0xF0000000
-#define IGC_FTQF_MASK_PROTO_BP	0x10000000
-/* Immediate Interrupt Rx (A.K.A. Low Latency Interrupt) */
-#define IGC_IMIREXT_CTRL_BP	0x00080000  /* Bypass check of ctrl bits */
-#define IGC_IMIREXT_SIZE_BP	0x00001000  /* Packet size bypass */
-
-#define IGC_RXDADV_STAT_TSIP		0x08000 /* timestamp in packet */
-#define IGC_TSICR_TXTS		0x00000002
-#define IGC_TSIM_TXTS			0x00000002
-/* TUPLE Filtering Configuration */
-#define IGC_TTQF_DISABLE_MASK		0xF0008000 /* TTQF Disable Mask */
-#define IGC_TTQF_QUEUE_ENABLE		0x100   /* TTQF Queue Enable Bit */
-#define IGC_TTQF_PROTOCOL_MASK	0xFF    /* TTQF Protocol Mask */
-/* TTQF TCP Bit, shift with IGC_TTQF_PROTOCOL SHIFT */
-#define IGC_TTQF_PROTOCOL_TCP		0x0
-/* TTQF UDP Bit, shift with IGC_TTQF_PROTOCOL_SHIFT */
-#define IGC_TTQF_PROTOCOL_UDP		0x1
-/* TTQF SCTP Bit, shift with IGC_TTQF_PROTOCOL_SHIFT */
-#define IGC_TTQF_PROTOCOL_SCTP	0x2
-#define IGC_TTQF_PROTOCOL_SHIFT	5       /* TTQF Protocol Shift */
-#define IGC_TTQF_QUEUE_SHIFT		16      /* TTQF Queue Shfit */
-#define IGC_TTQF_RX_QUEUE_MASK	0x70000 /* TTQF Queue Mask */
-#define IGC_TTQF_MASK_ENABLE		0x10000000 /* TTQF Mask Enable Bit */
-#define IGC_IMIR_CLEAR_MASK		0xF001FFFF /* IMIR Reg Clear Mask */
-#define IGC_IMIR_PORT_BYPASS		0x20000 /* IMIR Port Bypass Bit */
-#define IGC_IMIR_PRIORITY_SHIFT	29 /* IMIR Priority Shift */
-#define IGC_IMIREXT_CLEAR_MASK	0x7FFFF /* IMIREXT Reg Clear Mask */
-
-#define IGC_MDICNFG_EXT_MDIO		0x80000000 /* MDI ext/int destination */
-#define IGC_MDICNFG_COM_MDIO		0x40000000 /* MDI shared w/ lan 0 */
-#define IGC_MDICNFG_PHY_MASK		0x03E00000
-#define IGC_MDICNFG_PHY_SHIFT		21
-
-#define IGC_MEDIA_PORT_COPPER			1
-#define IGC_MEDIA_PORT_OTHER			2
-#define IGC_M88E1112_AUTO_COPPER_SGMII	0x2
-#define IGC_M88E1112_AUTO_COPPER_BASEX	0x3
-#define IGC_M88E1112_STATUS_LINK		0x0004 /* Interface Link Bit */
-#define IGC_M88E1112_MAC_CTRL_1		0x10
-#define IGC_M88E1112_MAC_CTRL_1_MODE_MASK	0x0380 /* Mode Select */
-#define IGC_M88E1112_MAC_CTRL_1_MODE_SHIFT	7
-#define IGC_M88E1112_PAGE_ADDR		0x16
-#define IGC_M88E1112_STATUS			0x01
-
-#define IGC_THSTAT_LOW_EVENT		0x20000000 /* Low thermal threshold */
-#define IGC_THSTAT_MID_EVENT		0x00200000 /* Mid thermal threshold */
-#define IGC_THSTAT_HIGH_EVENT		0x00002000 /* High thermal threshold */
-#define IGC_THSTAT_PWR_DOWN		0x00000001 /* Power Down Event */
-#define IGC_THSTAT_LINK_THROTTLE	0x00000002 /* Link Spd Throttle Event */
-
-/* EEE defines */
-#define IGC_IPCNFG_EEE_2_5G_AN	0x00000010 /* IPCNFG EEE Ena 2.5G AN */
-#define IGC_IPCNFG_EEE_1G_AN		0x00000008 /* IPCNFG EEE Ena 1G AN */
-#define IGC_IPCNFG_EEE_100M_AN	0x00000004 /* IPCNFG EEE Ena 100M AN */
-#define IGC_EEER_TX_LPI_EN		0x00010000 /* EEER Tx LPI Enable */
-#define IGC_EEER_RX_LPI_EN		0x00020000 /* EEER Rx LPI Enable */
-#define IGC_EEER_LPI_FC		0x00040000 /* EEER Ena on Flow Cntrl */
-/* EEE status */
-#define IGC_EEER_EEE_NEG		0x20000000 /* EEE capability nego */
-#define IGC_EEER_RX_LPI_STATUS	0x40000000 /* Rx in LPI state */
-#define IGC_EEER_TX_LPI_STATUS	0x80000000 /* Tx in LPI state */
-#define IGC_EEE_LP_ADV_ADDR_I350	0x040F     /* EEE LP Advertisement */
-#define IGC_M88E1543_PAGE_ADDR	0x16       /* Page Offset Register */
-#define IGC_M88E1543_EEE_CTRL_1	0x0
-#define IGC_M88E1543_EEE_CTRL_1_MS	0x0001     /* EEE Master/Slave */
-#define IGC_M88E1543_FIBER_CTRL	0x0        /* Fiber Control Register */
-#define IGC_EEE_ADV_DEV_I354		7
-#define IGC_EEE_ADV_ADDR_I354		60
-#define IGC_EEE_ADV_100_SUPPORTED	(1 << 1)   /* 100BaseTx EEE Supported */
-#define IGC_EEE_ADV_1000_SUPPORTED	(1 << 2)   /* 1000BaseT EEE Supported */
-#define IGC_PCS_STATUS_DEV_I354	3
-#define IGC_PCS_STATUS_ADDR_I354	1
-#define IGC_PCS_STATUS_RX_LPI_RCVD	0x0400
-#define IGC_PCS_STATUS_TX_LPI_RCVD	0x0800
-#define IGC_M88E1512_CFG_REG_1	0x0010
-#define IGC_M88E1512_CFG_REG_2	0x0011
-#define IGC_M88E1512_CFG_REG_3	0x0007
-#define IGC_M88E1512_MODE		0x0014
-#define IGC_EEE_SU_LPI_CLK_STP	0x00800000 /* EEE LPI Clock Stop */
-#define IGC_EEE_LP_ADV_DEV_I210	7          /* EEE LP Adv Device */
-#define IGC_EEE_LP_ADV_ADDR_I210	61         /* EEE LP Adv Register */
-#define IGC_EEE_SU_LPI_CLK_STP	0x00800000 /* EEE LPI Clock Stop */
-#define IGC_EEE_LP_ADV_DEV_I225	7          /* EEE LP Adv Device */
-#define IGC_EEE_LP_ADV_ADDR_I225	61         /* EEE LP Adv Register */
-
-/* PCI Express Control */
-#define IGC_GCR_RXD_NO_SNOOP		0x00000001
-#define IGC_GCR_RXDSCW_NO_SNOOP	0x00000002
-#define IGC_GCR_RXDSCR_NO_SNOOP	0x00000004
-#define IGC_GCR_TXD_NO_SNOOP		0x00000008
-#define IGC_GCR_TXDSCW_NO_SNOOP	0x00000010
-#define IGC_GCR_TXDSCR_NO_SNOOP	0x00000020
-#define IGC_GCR_CMPL_TMOUT_MASK	0x0000F000
-#define IGC_GCR_CMPL_TMOUT_10ms	0x00001000
-#define IGC_GCR_CMPL_TMOUT_RESEND	0x00010000
-#define IGC_GCR_CAP_VER2		0x00040000
-
-#define PCIE_NO_SNOOP_ALL	(IGC_GCR_RXD_NO_SNOOP | \
-				 IGC_GCR_RXDSCW_NO_SNOOP | \
-				 IGC_GCR_RXDSCR_NO_SNOOP | \
-				 IGC_GCR_TXD_NO_SNOOP    | \
-				 IGC_GCR_TXDSCW_NO_SNOOP | \
-				 IGC_GCR_TXDSCR_NO_SNOOP)
-
-#define IGC_MMDAC_FUNC_DATA	0x4000 /* Data, no post increment */
-
-/* mPHY address control and data registers */
-#define IGC_MPHY_ADDR_CTL		0x0024 /* Address Control Reg */
-#define IGC_MPHY_ADDR_CTL_OFFSET_MASK	0xFFFF0000
-#define IGC_MPHY_DATA			0x0E10 /* Data Register */
-
-/* AFE CSR Offset for PCS CLK */
-#define IGC_MPHY_PCS_CLK_REG_OFFSET	0x0004
-/* Override for near end digital loopback. */
-#define IGC_MPHY_PCS_CLK_REG_DIGINELBEN	0x10
-
-/* PHY Control Register */
-#define MII_CR_SPEED_SELECT_MSB	0x0040  /* bits 6,13: 10=1000, 01=100, 00=10 */
-#define MII_CR_COLL_TEST_ENABLE	0x0080  /* Collision test enable */
-#define MII_CR_FULL_DUPLEX	0x0100  /* FDX =1, half duplex =0 */
-#define MII_CR_RESTART_AUTO_NEG	0x0200  /* Restart auto negotiation */
-#define MII_CR_ISOLATE		0x0400  /* Isolate PHY from MII */
-#define MII_CR_POWER_DOWN	0x0800  /* Power down */
-#define MII_CR_AUTO_NEG_EN	0x1000  /* Auto Neg Enable */
-#define MII_CR_SPEED_SELECT_LSB	0x2000  /* bits 6,13: 10=1000, 01=100, 00=10 */
-#define MII_CR_LOOPBACK		0x4000  /* 0 = normal, 1 = loopback */
-#define MII_CR_RESET		0x8000  /* 0 = normal, 1 = PHY reset */
-#define MII_CR_SPEED_1000	0x0040
-#define MII_CR_SPEED_100	0x2000
-#define MII_CR_SPEED_10		0x0000
-
-/* PHY Status Register */
-#define MII_SR_EXTENDED_CAPS	0x0001 /* Extended register capabilities */
-#define MII_SR_JABBER_DETECT	0x0002 /* Jabber Detected */
-#define MII_SR_LINK_STATUS	0x0004 /* Link Status 1 = link */
-#define MII_SR_AUTONEG_CAPS	0x0008 /* Auto Neg Capable */
-#define MII_SR_REMOTE_FAULT	0x0010 /* Remote Fault Detect */
-#define MII_SR_AUTONEG_COMPLETE	0x0020 /* Auto Neg Complete */
-#define MII_SR_PREAMBLE_SUPPRESS 0x0040 /* Preamble may be suppressed */
-#define MII_SR_EXTENDED_STATUS	0x0100 /* Ext. status info in Reg 0x0F */
-#define MII_SR_100T2_HD_CAPS	0x0200 /* 100T2 Half Duplex Capable */
-#define MII_SR_100T2_FD_CAPS	0x0400 /* 100T2 Full Duplex Capable */
-#define MII_SR_10T_HD_CAPS	0x0800 /* 10T   Half Duplex Capable */
-#define MII_SR_10T_FD_CAPS	0x1000 /* 10T   Full Duplex Capable */
-#define MII_SR_100X_HD_CAPS	0x2000 /* 100X  Half Duplex Capable */
-#define MII_SR_100X_FD_CAPS	0x4000 /* 100X  Full Duplex Capable */
-#define MII_SR_100T4_CAPS	0x8000 /* 100T4 Capable */
-
-/* Autoneg Advertisement Register */
-#define NWAY_AR_SELECTOR_FIELD	0x0001   /* indicates IEEE 802.3 CSMA/CD */
-#define NWAY_AR_10T_HD_CAPS	0x0020   /* 10T   Half Duplex Capable */
-#define NWAY_AR_10T_FD_CAPS	0x0040   /* 10T   Full Duplex Capable */
-#define NWAY_AR_100TX_HD_CAPS	0x0080   /* 100TX Half Duplex Capable */
-#define NWAY_AR_100TX_FD_CAPS	0x0100   /* 100TX Full Duplex Capable */
-#define NWAY_AR_100T4_CAPS	0x0200   /* 100T4 Capable */
-#define NWAY_AR_PAUSE		0x0400   /* Pause operation desired */
-#define NWAY_AR_ASM_DIR		0x0800   /* Asymmetric Pause Direction bit */
-#define NWAY_AR_REMOTE_FAULT	0x2000   /* Remote Fault detected */
-#define NWAY_AR_NEXT_PAGE	0x8000   /* Next Page ability supported */
-
-/* Link Partner Ability Register (Base Page) */
-#define NWAY_LPAR_SELECTOR_FIELD	0x0000 /* LP protocol selector field */
-#define NWAY_LPAR_10T_HD_CAPS		0x0020 /* LP 10T Half Dplx Capable */
-#define NWAY_LPAR_10T_FD_CAPS		0x0040 /* LP 10T Full Dplx Capable */
-#define NWAY_LPAR_100TX_HD_CAPS		0x0080 /* LP 100TX Half Dplx Capable */
-#define NWAY_LPAR_100TX_FD_CAPS		0x0100 /* LP 100TX Full Dplx Capable */
-#define NWAY_LPAR_100T4_CAPS		0x0200 /* LP is 100T4 Capable */
-#define NWAY_LPAR_PAUSE			0x0400 /* LP Pause operation desired */
-#define NWAY_LPAR_ASM_DIR		0x0800 /* LP Asym Pause Direction bit */
-#define NWAY_LPAR_REMOTE_FAULT		0x2000 /* LP detected Remote Fault */
-#define NWAY_LPAR_ACKNOWLEDGE		0x4000 /* LP rx'd link code word */
-#define NWAY_LPAR_NEXT_PAGE		0x8000 /* Next Page ability supported */
-
-/* Autoneg Expansion Register */
-#define NWAY_ER_LP_NWAY_CAPS		0x0001 /* LP has Auto Neg Capability */
-#define NWAY_ER_PAGE_RXD		0x0002 /* LP 10T Half Dplx Capable */
-#define NWAY_ER_NEXT_PAGE_CAPS		0x0004 /* LP 10T Full Dplx Capable */
-#define NWAY_ER_LP_NEXT_PAGE_CAPS	0x0008 /* LP 100TX Half Dplx Capable */
-#define NWAY_ER_PAR_DETECT_FAULT	0x0010 /* LP 100TX Full Dplx Capable */
-
-/* 1000BASE-T Control Register */
-#define CR_1000T_ASYM_PAUSE	0x0080 /* Advertise asymmetric pause bit */
-#define CR_1000T_HD_CAPS	0x0100 /* Advertise 1000T HD capability */
-#define CR_1000T_FD_CAPS	0x0200 /* Advertise 1000T FD capability  */
-/* 1=Repeater/switch device port 0=DTE device */
-#define CR_1000T_REPEATER_DTE	0x0400
-/* 1=Configure PHY as Master 0=Configure PHY as Slave */
-#define CR_1000T_MS_VALUE	0x0800
-/* 1=Master/Slave manual config value 0=Automatic Master/Slave config */
-#define CR_1000T_MS_ENABLE	0x1000
-#define CR_1000T_TEST_MODE_NORMAL 0x0000 /* Normal Operation */
-#define CR_1000T_TEST_MODE_1	0x2000 /* Transmit Waveform test */
-#define CR_1000T_TEST_MODE_2	0x4000 /* Master Transmit Jitter test */
-#define CR_1000T_TEST_MODE_3	0x6000 /* Slave Transmit Jitter test */
-#define CR_1000T_TEST_MODE_4	0x8000 /* Transmitter Distortion test */
-
-/* 1000BASE-T Status Register */
-#define SR_1000T_IDLE_ERROR_CNT		0x00FF /* Num idle err since last rd */
-#define SR_1000T_ASYM_PAUSE_DIR		0x0100 /* LP asym pause direction bit */
-#define SR_1000T_LP_HD_CAPS		0x0400 /* LP is 1000T HD capable */
-#define SR_1000T_LP_FD_CAPS		0x0800 /* LP is 1000T FD capable */
-#define SR_1000T_REMOTE_RX_STATUS	0x1000 /* Remote receiver OK */
-#define SR_1000T_LOCAL_RX_STATUS	0x2000 /* Local receiver OK */
-#define SR_1000T_MS_CONFIG_RES		0x4000 /* 1=Local Tx Master, 0=Slave */
-#define SR_1000T_MS_CONFIG_FAULT	0x8000 /* Master/Slave config fault */
-
-#define SR_1000T_PHY_EXCESSIVE_IDLE_ERR_COUNT	5
-
-/* PHY 1000 MII Register/Bit Definitions */
-/* PHY Registers defined by IEEE */
-#define PHY_CONTROL		0x00 /* Control Register */
-#define PHY_STATUS		0x01 /* Status Register */
-#define PHY_ID1			0x02 /* Phy Id Reg (word 1) */
-#define PHY_ID2			0x03 /* Phy Id Reg (word 2) */
-#define PHY_AUTONEG_ADV		0x04 /* Autoneg Advertisement */
-#define PHY_LP_ABILITY		0x05 /* Link Partner Ability (Base Page) */
-#define PHY_AUTONEG_EXP		0x06 /* Autoneg Expansion Reg */
-#define PHY_NEXT_PAGE_TX	0x07 /* Next Page Tx */
-#define PHY_LP_NEXT_PAGE	0x08 /* Link Partner Next Page */
-#define PHY_1000T_CTRL		0x09 /* 1000Base-T Control Reg */
-#define PHY_1000T_STATUS	0x0A /* 1000Base-T Status Reg */
-#define PHY_EXT_STATUS		0x0F /* Extended Status Reg */
-
-/* PHY GPY 211 registers */
-#define STANDARD_AN_REG_MASK	0x0007 /* MMD */
-#define ANEG_MULTIGBT_AN_CTRL	0x0020 /* MULTI GBT AN Control Register */
-#define MMD_DEVADDR_SHIFT	16     /* Shift MMD to higher bits */
-#define CR_2500T_FD_CAPS	0x0080 /* Advertise 2500T FD capability */
-
-#define PHY_CONTROL_LB		0x4000 /* PHY Loopback bit */
-
-/* NVM Control */
-#define IGC_EECD_SK		0x00000001 /* NVM Clock */
-#define IGC_EECD_CS		0x00000002 /* NVM Chip Select */
-#define IGC_EECD_DI		0x00000004 /* NVM Data In */
-#define IGC_EECD_DO		0x00000008 /* NVM Data Out */
-#define IGC_EECD_REQ		0x00000040 /* NVM Access Request */
-#define IGC_EECD_GNT		0x00000080 /* NVM Access Grant */
-#define IGC_EECD_PRES		0x00000100 /* NVM Present */
-#define IGC_EECD_SIZE		0x00000200 /* NVM Size (0=64 word 1=256 word) */
-#define IGC_EECD_BLOCKED	0x00008000 /* Bit banging access blocked flag */
-#define IGC_EECD_ABORT	0x00010000 /* NVM operation aborted flag */
-#define IGC_EECD_TIMEOUT	0x00020000 /* NVM read operation timeout flag */
-#define IGC_EECD_ERROR_CLR	0x00040000 /* NVM error status clear bit */
-/* NVM Addressing bits based on type 0=small, 1=large */
-#define IGC_EECD_ADDR_BITS	0x00000400
-#define IGC_EECD_TYPE		0x00002000 /* NVM Type (1-SPI, 0-Microwire) */
-#define IGC_NVM_GRANT_ATTEMPTS	1000 /* NVM # attempts to gain grant */
-#define IGC_EECD_AUTO_RD		0x00000200  /* NVM Auto Read done */
-#define IGC_EECD_SIZE_EX_MASK		0x00007800  /* NVM Size */
-#define IGC_EECD_SIZE_EX_SHIFT	11
-#define IGC_EECD_FLUPD		0x00080000 /* Update FLASH */
-#define IGC_EECD_AUPDEN		0x00100000 /* Ena Auto FLASH update */
-#define IGC_EECD_SEC1VAL		0x00400000 /* Sector One Valid */
-#define IGC_EECD_SEC1VAL_VALID_MASK	(IGC_EECD_AUTO_RD | IGC_EECD_PRES)
-#define IGC_EECD_FLUPD_I210		0x00800000 /* Update FLASH */
-#define IGC_EECD_FLUDONE_I210		0x04000000 /* Update FLASH done */
-#define IGC_EECD_FLASH_DETECTED_I210	0x00080000 /* FLASH detected */
-#define IGC_EECD_SEC1VAL_I210		0x02000000 /* Sector One Valid */
-#define IGC_FLUDONE_ATTEMPTS		20000
-#define IGC_EERD_EEWR_MAX_COUNT	512 /* buffered EEPROM words rw */
-#define IGC_I210_FIFO_SEL_RX		0x00
-#define IGC_I210_FIFO_SEL_TX_QAV(_i)	(0x02 + (_i))
-#define IGC_I210_FIFO_SEL_TX_LEGACY	IGC_I210_FIFO_SEL_TX_QAV(0)
-#define IGC_I210_FIFO_SEL_BMC2OS_TX	0x06
-#define IGC_I210_FIFO_SEL_BMC2OS_RX	0x01
-
-#define IGC_I210_FLASH_SECTOR_SIZE	0x1000 /* 4KB FLASH sector unit size */
-/* Secure FLASH mode requires removing MSb */
-#define IGC_I210_FW_PTR_MASK		0x7FFF
-/* Firmware code revision field word offset*/
-#define IGC_I210_FW_VER_OFFSET	328
-
-#define IGC_EECD_FLUPD_I225		0x00800000 /* Update FLASH */
-#define IGC_EECD_FLUDONE_I225		0x04000000 /* Update FLASH done */
-#define IGC_EECD_FLASH_DETECTED_I225	0x00080000 /* FLASH detected */
-#define IGC_FLUDONE_ATTEMPTS		20000
-#define IGC_EERD_EEWR_MAX_COUNT	512 /* buffered EEPROM words rw */
-#define IGC_EECD_SEC1VAL_I225		0x02000000 /* Sector One Valid */
-#define IGC_FLSECU_BLK_SW_ACCESS_I225	0x00000004 /* Block SW access */
-#define IGC_FWSM_FW_VALID_I225	0x8000 /* FW valid bit */
-
-#define IGC_NVM_RW_REG_DATA	16  /* Offset to data in NVM read/write regs */
-#define IGC_NVM_RW_REG_DONE	2   /* Offset to READ/WRITE done bit */
-#define IGC_NVM_RW_REG_START	1   /* Start operation */
-#define IGC_NVM_RW_ADDR_SHIFT	2   /* Shift to the address bits */
-#define IGC_NVM_POLL_WRITE	1   /* Flag for polling for write complete */
-#define IGC_NVM_POLL_READ	0   /* Flag for polling for read complete */
-#define IGC_FLASH_UPDATES	2000
-
-/* NVM Word Offsets */
-#define NVM_COMPAT			0x0003
-#define NVM_ID_LED_SETTINGS		0x0004
-#define NVM_VERSION			0x0005
-#define NVM_SERDES_AMPLITUDE		0x0006 /* SERDES output amplitude */
-#define NVM_PHY_CLASS_WORD		0x0007
-#define IGC_I210_NVM_FW_MODULE_PTR	0x0010
-#define IGC_I350_NVM_FW_MODULE_PTR	0x0051
-#define NVM_FUTURE_INIT_WORD1		0x0019
-#define NVM_ETRACK_WORD			0x0042
-#define NVM_ETRACK_HIWORD		0x0043
-#define NVM_COMB_VER_OFF		0x0083
-#define NVM_COMB_VER_PTR		0x003d
-
-/* NVM version defines */
-#define NVM_MAJOR_MASK			0xF000
-#define NVM_MINOR_MASK			0x0FF0
-#define NVM_IMAGE_ID_MASK		0x000F
-#define NVM_COMB_VER_MASK		0x00FF
-#define NVM_MAJOR_SHIFT			12
-#define NVM_MINOR_SHIFT			4
-#define NVM_COMB_VER_SHFT		8
-#define NVM_VER_INVALID			0xFFFF
-#define NVM_ETRACK_SHIFT		16
-#define NVM_ETRACK_VALID		0x8000
-#define NVM_NEW_DEC_MASK		0x0F00
-#define NVM_HEX_CONV			16
-#define NVM_HEX_TENS			10
-
-/* FW version defines */
-/* Offset of "Loader patch ptr" in Firmware Header */
-#define IGC_I350_NVM_FW_LOADER_PATCH_PTR_OFFSET	0x01
-/* Patch generation hour & minutes */
-#define IGC_I350_NVM_FW_VER_WORD1_OFFSET		0x04
-/* Patch generation month & day */
-#define IGC_I350_NVM_FW_VER_WORD2_OFFSET		0x05
-/* Patch generation year */
-#define IGC_I350_NVM_FW_VER_WORD3_OFFSET		0x06
-/* Patch major & minor numbers */
-#define IGC_I350_NVM_FW_VER_WORD4_OFFSET		0x07
-
-#define NVM_MAC_ADDR			0x0000
-#define NVM_SUB_DEV_ID			0x000B
-#define NVM_SUB_VEN_ID			0x000C
-#define NVM_DEV_ID			0x000D
-#define NVM_VEN_ID			0x000E
-#define NVM_INIT_CTRL_2			0x000F
-#define NVM_INIT_CTRL_4			0x0013
-#define NVM_LED_1_CFG			0x001C
-#define NVM_LED_0_2_CFG			0x001F
-
-#define NVM_COMPAT_VALID_CSUM		0x0001
-#define NVM_FUTURE_INIT_WORD1_VALID_CSUM	0x0040
-
-#define NVM_INIT_CONTROL2_REG		0x000F
-#define NVM_INIT_CONTROL3_PORT_B	0x0014
-#define NVM_INIT_3GIO_3			0x001A
-#define NVM_SWDEF_PINS_CTRL_PORT_0	0x0020
-#define NVM_INIT_CONTROL3_PORT_A	0x0024
-#define NVM_CFG				0x0012
-#define NVM_ALT_MAC_ADDR_PTR		0x0037
-#define NVM_CHECKSUM_REG		0x003F
-#define NVM_COMPATIBILITY_REG_3		0x0003
-#define NVM_COMPATIBILITY_BIT_MASK	0x8000
-
-#define IGC_NVM_CFG_DONE_PORT_0	0x040000 /* MNG config cycle done */
-#define IGC_NVM_CFG_DONE_PORT_1	0x080000 /* ...for second port */
-#define IGC_NVM_CFG_DONE_PORT_2	0x100000 /* ...for third port */
-#define IGC_NVM_CFG_DONE_PORT_3	0x200000 /* ...for fourth port */
-
-#define NVM_82580_LAN_FUNC_OFFSET(a)	(	\
-	__extension__ ({			\
-		typeof(a) _a = (a);		\
-		_a ? (0x40 + 0x40 * _a) : 0;	\
-	}))
-
-/* Mask bits for fields in Word 0x24 of the NVM */
-#define NVM_WORD24_COM_MDIO		0x0008 /* MDIO interface shared */
-#define NVM_WORD24_EXT_MDIO		0x0004 /* MDIO accesses routed extrnl */
-/* Offset of Link Mode bits for 82575/82576 */
-#define NVM_WORD24_LNK_MODE_OFFSET	8
-/* Offset of Link Mode bits for 82580 up */
-#define NVM_WORD24_82580_LNK_MODE_OFFSET	4
-
-
-/* Mask bits for fields in Word 0x0f of the NVM */
-#define NVM_WORD0F_PAUSE_MASK		0x3000
-#define NVM_WORD0F_PAUSE		0x1000
-#define NVM_WORD0F_ASM_DIR		0x2000
-#define NVM_WORD0F_SWPDIO_EXT_MASK	0x00F0
-
-/* Mask bits for fields in Word 0x1a of the NVM */
-#define NVM_WORD1A_ASPM_MASK		0x000C
-
-/* Mask bits for fields in Word 0x03 of the EEPROM */
-#define NVM_COMPAT_LOM			0x0800
-
-/* length of string needed to store PBA number */
-#define IGC_PBANUM_LENGTH		11
-
-/* For checksumming, the sum of all words in the NVM should equal 0xBABA. */
-#define NVM_SUM				0xBABA
-
-/* PBA (printed board assembly) number words */
-#define NVM_PBA_OFFSET_0		8
-#define NVM_PBA_OFFSET_1		9
-#define NVM_PBA_PTR_GUARD		0xFAFA
-#define NVM_RESERVED_WORD		0xFFFF
-#define NVM_PHY_CLASS_A			0x8000
-#define NVM_SERDES_AMPLITUDE_MASK	0x000F
-#define NVM_SIZE_MASK			0x1C00
-#define NVM_SIZE_SHIFT			10
-#define NVM_WORD_SIZE_BASE_SHIFT	6
-#define NVM_SWDPIO_EXT_SHIFT		4
-
-/* NVM Commands - Microwire */
-#define NVM_READ_OPCODE_MICROWIRE	0x6  /* NVM read opcode */
-#define NVM_WRITE_OPCODE_MICROWIRE	0x5  /* NVM write opcode */
-#define NVM_ERASE_OPCODE_MICROWIRE	0x7  /* NVM erase opcode */
-#define NVM_EWEN_OPCODE_MICROWIRE	0x13 /* NVM erase/write enable */
-#define NVM_EWDS_OPCODE_MICROWIRE	0x10 /* NVM erase/write disable */
-
-/* NVM Commands - SPI */
-#define NVM_MAX_RETRY_SPI	5000 /* Max wait of 5ms, for RDY signal */
-#define NVM_READ_OPCODE_SPI	0x03 /* NVM read opcode */
-#define NVM_WRITE_OPCODE_SPI	0x02 /* NVM write opcode */
-#define NVM_A8_OPCODE_SPI	0x08 /* opcode bit-3 = address bit-8 */
-#define NVM_WREN_OPCODE_SPI	0x06 /* NVM set Write Enable latch */
-#define NVM_RDSR_OPCODE_SPI	0x05 /* NVM read Status register */
-
-/* SPI NVM Status Register */
-#define NVM_STATUS_RDY_SPI	0x01
-
-/* Word definitions for ID LED Settings */
-#define ID_LED_RESERVED_0000	0x0000
-#define ID_LED_RESERVED_FFFF	0xFFFF
-#define ID_LED_DEFAULT		((ID_LED_OFF1_ON2  << 12) | \
-				 (ID_LED_OFF1_OFF2 <<  8) | \
-				 (ID_LED_DEF1_DEF2 <<  4) | \
-				 (ID_LED_DEF1_DEF2))
-#define ID_LED_DEF1_DEF2	0x1
-#define ID_LED_DEF1_ON2		0x2
-#define ID_LED_DEF1_OFF2	0x3
-#define ID_LED_ON1_DEF2		0x4
-#define ID_LED_ON1_ON2		0x5
-#define ID_LED_ON1_OFF2		0x6
-#define ID_LED_OFF1_DEF2	0x7
-#define ID_LED_OFF1_ON2		0x8
-#define ID_LED_OFF1_OFF2	0x9
-
-#define IGP_ACTIVITY_LED_MASK	0xFFFFF0FF
-#define IGP_ACTIVITY_LED_ENABLE	0x0300
-#define IGP_LED3_MODE		0x07000000
-
-/* PCI/PCI-X/PCI-EX Config space */
-#define PCIX_COMMAND_REGISTER		0xE6
-#define PCIX_STATUS_REGISTER_LO		0xE8
-#define PCIX_STATUS_REGISTER_HI		0xEA
-#define PCI_HEADER_TYPE_REGISTER	0x0E
-#define PCIE_LINK_STATUS		0x12
-#define PCIE_DEVICE_CONTROL2		0x28
-
-#define PCIX_COMMAND_MMRBC_MASK		0x000C
-#define PCIX_COMMAND_MMRBC_SHIFT	0x2
-#define PCIX_STATUS_HI_MMRBC_MASK	0x0060
-#define PCIX_STATUS_HI_MMRBC_SHIFT	0x5
-#define PCIX_STATUS_HI_MMRBC_4K		0x3
-#define PCIX_STATUS_HI_MMRBC_2K		0x2
-#define PCIX_STATUS_LO_FUNC_MASK	0x7
-#define PCI_HEADER_TYPE_MULTIFUNC	0x80
-#define PCIE_LINK_WIDTH_MASK		0x3F0
-#define PCIE_LINK_WIDTH_SHIFT		4
-#define PCIE_LINK_SPEED_MASK		0x0F
-#define PCIE_LINK_SPEED_2500		0x01
-#define PCIE_LINK_SPEED_5000		0x02
-#define PCIE_DEVICE_CONTROL2_16ms	0x0005
-
-#define ETH_ADDR_LEN			6
-
-#define PHY_REVISION_MASK		0xFFFFFFF0
-#define MAX_PHY_REG_ADDRESS		0x1F  /* 5 bit address bus (0-0x1F) */
-#define MAX_PHY_MULTI_PAGE_REG		0xF
-
-/* Bit definitions for valid PHY IDs.
- * I = Integrated
- * E = External
- */
-#define M88IGC_E_PHY_ID	0x01410C50
-#define M88IGC_I_PHY_ID	0x01410C30
-#define M88E1011_I_PHY_ID	0x01410C20
-#define IGP01IGC_I_PHY_ID	0x02A80380
-#define M88E1111_I_PHY_ID	0x01410CC0
-#define M88E1543_E_PHY_ID	0x01410EA0
-#define M88E1512_E_PHY_ID	0x01410DD0
-#define M88E1112_E_PHY_ID	0x01410C90
-#define I347AT4_E_PHY_ID	0x01410DC0
-#define M88E1340M_E_PHY_ID	0x01410DF0
-#define GG82563_E_PHY_ID	0x01410CA0
-#define IGP03IGC_E_PHY_ID	0x02A80390
-#define IFE_E_PHY_ID		0x02A80330
-#define IFE_PLUS_E_PHY_ID	0x02A80320
-#define IFE_C_E_PHY_ID		0x02A80310
-#define BMIGC_E_PHY_ID	0x01410CB0
-#define BMIGC_E_PHY_ID_R2	0x01410CB1
-#define I82577_E_PHY_ID		0x01540050
-#define I82578_E_PHY_ID		0x004DD040
-#define I82579_E_PHY_ID		0x01540090
-#define I217_E_PHY_ID		0x015400A0
-#define I82580_I_PHY_ID		0x015403A0
-#define I350_I_PHY_ID		0x015403B0
-#define I210_I_PHY_ID		0x01410C00
-#define IGP04IGC_E_PHY_ID	0x02A80391
-#define M88_VENDOR		0x0141
-#define I225_I_PHY_ID		0x67C9DC00
-#define I226_LM_PHY_ID          0x67C9DC10
-
-/* M88E1000 Specific Registers */
-#define M88IGC_PHY_SPEC_CTRL		0x10  /* PHY Specific Control Reg */
-#define M88IGC_PHY_SPEC_STATUS	0x11  /* PHY Specific Status Reg */
-#define M88IGC_EXT_PHY_SPEC_CTRL	0x14  /* Extended PHY Specific Cntrl */
-#define M88IGC_RX_ERR_CNTR		0x15  /* Receive Error Counter */
-
-#define M88IGC_PHY_EXT_CTRL		0x1A  /* PHY extend control register */
-#define M88IGC_PHY_PAGE_SELECT	0x1D  /* Reg 29 for pg number setting */
-#define M88IGC_PHY_GEN_CONTROL	0x1E  /* meaning depends on reg 29 */
-#define M88IGC_PHY_VCO_REG_BIT8	0x100 /* Bits 8 & 11 are adjusted for */
-#define M88IGC_PHY_VCO_REG_BIT11	0x800 /* improved BER performance */
-
-/* M88E1000 PHY Specific Control Register */
-#define M88IGC_PSCR_POLARITY_REVERSAL	0x0002 /* 1=Polarity Reverse enabled */
-/* MDI Crossover Mode bits 6:5 Manual MDI configuration */
-#define M88IGC_PSCR_MDI_MANUAL_MODE	0x0000
-#define M88IGC_PSCR_MDIX_MANUAL_MODE	0x0020  /* Manual MDIX configuration */
-/* 1000BASE-T: Auto crossover, 100BASE-TX/10BASE-T: MDI Mode */
-#define M88IGC_PSCR_AUTO_X_1000T	0x0040
-/* Auto crossover enabled all speeds */
-#define M88IGC_PSCR_AUTO_X_MODE	0x0060
-#define M88IGC_PSCR_ASSERT_CRS_ON_TX	0x0800 /* 1=Assert CRS on Tx */
-
-/* M88E1000 PHY Specific Status Register */
-#define M88IGC_PSSR_REV_POLARITY	0x0002 /* 1=Polarity reversed */
-#define M88IGC_PSSR_DOWNSHIFT		0x0020 /* 1=Downshifted */
-#define M88IGC_PSSR_MDIX		0x0040 /* 1=MDIX; 0=MDI */
-/* 0 = <50M
- * 1 = 50-80M
- * 2 = 80-110M
- * 3 = 110-140M
- * 4 = >140M
- */
-#define M88IGC_PSSR_CABLE_LENGTH	0x0380
-#define M88IGC_PSSR_LINK		0x0400 /* 1=Link up, 0=Link down */
-#define M88IGC_PSSR_SPD_DPLX_RESOLVED	0x0800 /* 1=Speed & Duplex resolved */
-#define M88IGC_PSSR_DPLX		0x2000 /* 1=Duplex 0=Half Duplex */
-#define M88IGC_PSSR_SPEED		0xC000 /* Speed, bits 14:15 */
-#define M88IGC_PSSR_100MBS		0x4000 /* 01=100Mbs */
-#define M88IGC_PSSR_1000MBS		0x8000 /* 10=1000Mbs */
-
-#define M88IGC_PSSR_CABLE_LENGTH_SHIFT	7
-
-/* Number of times we will attempt to autonegotiate before downshifting if we
- * are the master
- */
-#define M88IGC_EPSCR_MASTER_DOWNSHIFT_MASK	0x0C00
-#define M88IGC_EPSCR_MASTER_DOWNSHIFT_1X	0x0000
-/* Number of times we will attempt to autonegotiate before downshifting if we
- * are the slave
- */
-#define M88IGC_EPSCR_SLAVE_DOWNSHIFT_MASK	0x0300
-#define M88IGC_EPSCR_SLAVE_DOWNSHIFT_1X	0x0100
-#define M88IGC_EPSCR_TX_CLK_25	0x0070 /* 25  MHz TX_CLK */
-
-/* Intel I347AT4 Registers */
-#define I347AT4_PCDL		0x10 /* PHY Cable Diagnostics Length */
-#define I347AT4_PCDC		0x15 /* PHY Cable Diagnostics Control */
-#define I347AT4_PAGE_SELECT	0x16
-
-/* I347AT4 Extended PHY Specific Control Register */
-
-/* Number of times we will attempt to autonegotiate before downshifting if we
- * are the master
- */
-#define I347AT4_PSCR_DOWNSHIFT_ENABLE	0x0800
-#define I347AT4_PSCR_DOWNSHIFT_MASK	0x7000
-#define I347AT4_PSCR_DOWNSHIFT_1X	0x0000
-#define I347AT4_PSCR_DOWNSHIFT_2X	0x1000
-#define I347AT4_PSCR_DOWNSHIFT_3X	0x2000
-#define I347AT4_PSCR_DOWNSHIFT_4X	0x3000
-#define I347AT4_PSCR_DOWNSHIFT_5X	0x4000
-#define I347AT4_PSCR_DOWNSHIFT_6X	0x5000
-#define I347AT4_PSCR_DOWNSHIFT_7X	0x6000
-#define I347AT4_PSCR_DOWNSHIFT_8X	0x7000
-
-/* I347AT4 PHY Cable Diagnostics Control */
-#define I347AT4_PCDC_CABLE_LENGTH_UNIT	0x0400 /* 0=cm 1=meters */
-
-/* M88E1112 only registers */
-#define M88E1112_VCT_DSP_DISTANCE	0x001A
-
-/* M88EC018 Rev 2 specific DownShift settings */
-#define M88EC018_EPSCR_DOWNSHIFT_COUNTER_MASK	0x0E00
-#define M88EC018_EPSCR_DOWNSHIFT_COUNTER_5X	0x0800
-
-#define I82578_EPSCR_DOWNSHIFT_ENABLE		0x0020
-#define I82578_EPSCR_DOWNSHIFT_COUNTER_MASK	0x001C
-
-/* BME1000 PHY Specific Control Register */
-#define BMIGC_PSCR_ENABLE_DOWNSHIFT	0x0800 /* 1 = enable downshift */
-
-/* Bits...
- * 15-5: page
- * 4-0: register offset
- */
-#define GG82563_PAGE_SHIFT	5
-#define GG82563_REG(page, reg)	\
-	(((page) << GG82563_PAGE_SHIFT) | ((reg) & MAX_PHY_REG_ADDRESS))
-#define GG82563_MIN_ALT_REG	30
-
-/* GG82563 Specific Registers */
-#define GG82563_PHY_SPEC_CTRL		GG82563_REG(0, 16) /* PHY Spec Cntrl */
-#define GG82563_PHY_PAGE_SELECT		GG82563_REG(0, 22) /* Page Select */
-#define GG82563_PHY_SPEC_CTRL_2		GG82563_REG(0, 26) /* PHY Spec Cntrl2 */
-#define GG82563_PHY_PAGE_SELECT_ALT	GG82563_REG(0, 29) /* Alt Page Select */
-
-/* MAC Specific Control Register */
-#define GG82563_PHY_MAC_SPEC_CTRL	GG82563_REG(2, 21)
-
-#define GG82563_PHY_DSP_DISTANCE	GG82563_REG(5, 26) /* DSP Distance */
-
-/* Page 193 - Port Control Registers */
-/* Kumeran Mode Control */
-#define GG82563_PHY_KMRN_MODE_CTRL	GG82563_REG(193, 16)
-#define GG82563_PHY_PWR_MGMT_CTRL	GG82563_REG(193, 20) /* Pwr Mgt Ctrl */
-
-/* Page 194 - KMRN Registers */
-#define GG82563_PHY_INBAND_CTRL		GG82563_REG(194, 18) /* Inband Ctrl */
-
-/* MDI Control */
-#define IGC_MDIC_DATA_MASK	0x0000FFFF
-#define IGC_MDIC_INT_EN		0x20000000
-#define IGC_MDIC_REG_MASK	0x001F0000
-#define IGC_MDIC_REG_SHIFT	16
-#define IGC_MDIC_PHY_MASK	0x03E00000
-#define IGC_MDIC_PHY_SHIFT	21
-#define IGC_MDIC_OP_WRITE	0x04000000
-#define IGC_MDIC_OP_READ	0x08000000
-#define IGC_MDIC_READY	0x10000000
-#define IGC_MDIC_ERROR	0x40000000
-#define IGC_MDIC_DEST		0x80000000
-
-#define IGC_N0_QUEUE -1
-
-#define IGC_MAX_MAC_HDR_LEN	127
-#define IGC_MAX_NETWORK_HDR_LEN	511
-
-#define IGC_VLAPQF_QUEUE_SEL(_n, q_idx) ((q_idx) << ((_n) * 4))
-#define IGC_VLAPQF_P_VALID(_n)	(0x1 << (3 + (_n) * 4))
-#define IGC_VLAPQF_QUEUE_MASK	0x03
-#define IGC_VFTA_BLOCK_SIZE	8
-/* SerDes Control */
-#define IGC_GEN_CTL_READY		0x80000000
-#define IGC_GEN_CTL_ADDRESS_SHIFT	8
-#define IGC_GEN_POLL_TIMEOUT		640
-
-/* LinkSec register fields */
-#define IGC_LSECTXCAP_SUM_MASK	0x00FF0000
-#define IGC_LSECTXCAP_SUM_SHIFT	16
-#define IGC_LSECRXCAP_SUM_MASK	0x00FF0000
-#define IGC_LSECRXCAP_SUM_SHIFT	16
-
-#define IGC_LSECTXCTRL_EN_MASK	0x00000003
-#define IGC_LSECTXCTRL_DISABLE	0x0
-#define IGC_LSECTXCTRL_AUTH		0x1
-#define IGC_LSECTXCTRL_AUTH_ENCRYPT	0x2
-#define IGC_LSECTXCTRL_AISCI		0x00000020
-#define IGC_LSECTXCTRL_PNTHRSH_MASK	0xFFFFFF00
-#define IGC_LSECTXCTRL_RSV_MASK	0x000000D8
-
-#define IGC_LSECRXCTRL_EN_MASK	0x0000000C
-#define IGC_LSECRXCTRL_EN_SHIFT	2
-#define IGC_LSECRXCTRL_DISABLE	0x0
-#define IGC_LSECRXCTRL_CHECK		0x1
-#define IGC_LSECRXCTRL_STRICT		0x2
-#define IGC_LSECRXCTRL_DROP		0x3
-#define IGC_LSECRXCTRL_PLSH		0x00000040
-#define IGC_LSECRXCTRL_RP		0x00000080
-#define IGC_LSECRXCTRL_RSV_MASK	0xFFFFFF33
-
-/* Tx Rate-Scheduler Config fields */
-#define IGC_RTTBCNRC_RS_ENA		0x80000000
-#define IGC_RTTBCNRC_RF_DEC_MASK	0x00003FFF
-#define IGC_RTTBCNRC_RF_INT_SHIFT	14
-#define IGC_RTTBCNRC_RF_INT_MASK	\
-	(IGC_RTTBCNRC_RF_DEC_MASK << IGC_RTTBCNRC_RF_INT_SHIFT)
-
-/* DMA Coalescing register fields */
-/* DMA Coalescing Watchdog Timer */
-#define IGC_DMACR_DMACWT_MASK		0x00003FFF
-/* DMA Coalescing Rx Threshold */
-#define IGC_DMACR_DMACTHR_MASK	0x00FF0000
-#define IGC_DMACR_DMACTHR_SHIFT	16
-/* Lx when no PCIe transactions */
-#define IGC_DMACR_DMAC_LX_MASK	0x30000000
-#define IGC_DMACR_DMAC_LX_SHIFT	28
-#define IGC_DMACR_DMAC_EN		0x80000000 /* Enable DMA Coalescing */
-/* DMA Coalescing BMC-to-OS Watchdog Enable */
-#define IGC_DMACR_DC_BMC2OSW_EN	0x00008000
-
-/* DMA Coalescing Transmit Threshold */
-#define IGC_DMCTXTH_DMCTTHR_MASK	0x00000FFF
-
-#define IGC_DMCTLX_TTLX_MASK		0x00000FFF /* Time to LX request */
-
-/* Rx Traffic Rate Threshold */
-#define IGC_DMCRTRH_UTRESH_MASK	0x0007FFFF
-/* Rx packet rate in current window */
-#define IGC_DMCRTRH_LRPRCW		0x80000000
-
-/* DMA Coal Rx Traffic Current Count */
-#define IGC_DMCCNT_CCOUNT_MASK	0x01FFFFFF
-
-/* Flow ctrl Rx Threshold High val */
-#define IGC_FCRTC_RTH_COAL_MASK	0x0003FFF0
-#define IGC_FCRTC_RTH_COAL_SHIFT	4
-/* Lx power decision based on DMA coal */
-#define IGC_PCIEMISC_LX_DECISION	0x00000080
-
-#define IGC_RXPBS_CFG_TS_EN		0x80000000 /* Timestamp in Rx buffer */
-#define IGC_RXPBS_SIZE_I210_MASK	0x0000003F /* Rx packet buffer size */
-#define IGC_TXPB0S_SIZE_I210_MASK	0x0000003F /* Tx packet buffer 0 size */
-#define I210_RXPBSIZE_DEFAULT		0x000000A2 /* RXPBSIZE default */
-#define I210_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
-
-
-#define I225_RXPBSIZE_DEFAULT		0x000000A2 /* RXPBSIZE default */
-#define I225_TXPBSIZE_DEFAULT		0x04000014 /* TXPBSIZE default */
-#define IGC_RXPBS_SIZE_I225_MASK	0x0000003F /* Rx packet buffer size */
-#define IGC_TXPB0S_SIZE_I225_MASK	0x0000003F /* Tx packet buffer 0 size */
-#define IGC_STM_OPCODE		0xDB00
-#define IGC_EEPROM_FLASH_SIZE_WORD	0x11
-#define INVM_DWORD_TO_RECORD_TYPE(invm_dword) \
-	(u8)((invm_dword) & 0x7)
-#define INVM_DWORD_TO_WORD_ADDRESS(invm_dword) \
-	(u8)(((invm_dword) & 0x0000FE00) >> 9)
-#define INVM_DWORD_TO_WORD_DATA(invm_dword) \
-	(u16)(((invm_dword) & 0xFFFF0000) >> 16)
-#define IGC_INVM_RSA_KEY_SHA256_DATA_SIZE_IN_DWORDS	8
-#define IGC_INVM_CSR_AUTOLOAD_DATA_SIZE_IN_DWORDS	1
-#define IGC_INVM_ULT_BYTES_SIZE		8
-#define IGC_INVM_RECORD_SIZE_IN_BYTES	4
-#define IGC_INVM_VER_FIELD_ONE		0x1FF8
-#define IGC_INVM_VER_FIELD_TWO		0x7FE000
-#define IGC_INVM_IMGTYPE_FIELD		0x1F800000
-
-#define IGC_INVM_MAJOR_MASK	0x3F0
-#define IGC_INVM_MINOR_MASK	0xF
-#define IGC_INVM_MAJOR_SHIFT	4
-
-/* PLL Defines */
-#define IGC_PCI_PMCSR		0x44
-#define IGC_PCI_PMCSR_D3		0x03
-#define IGC_MAX_PLL_TRIES		5
-#define IGC_PHY_PLL_UNCONF		0xFF
-#define IGC_PHY_PLL_FREQ_PAGE	0xFC0000
-#define IGC_PHY_PLL_FREQ_REG		0x000E
-#define IGC_INVM_DEFAULT_AL		0x202F
-#define IGC_INVM_AUTOLOAD		0x0A
-#define IGC_INVM_PLL_WO_VAL		0x0010
-
-/* Proxy Filter Control Extended */
-#define IGC_PROXYFCEX_MDNS		0x00000001 /* mDNS */
-#define IGC_PROXYFCEX_MDNS_M		0x00000002 /* mDNS Multicast */
-#define IGC_PROXYFCEX_MDNS_U		0x00000004 /* mDNS Unicast */
-#define IGC_PROXYFCEX_IPV4_M		0x00000008 /* IPv4 Multicast */
-#define IGC_PROXYFCEX_IPV6_M		0x00000010 /* IPv6 Multicast */
-#define IGC_PROXYFCEX_IGMP		0x00000020 /* IGMP */
-#define IGC_PROXYFCEX_IGMP_M		0x00000040 /* IGMP Multicast */
-#define IGC_PROXYFCEX_ARPRES		0x00000080 /* ARP Response */
-#define IGC_PROXYFCEX_ARPRES_D	0x00000100 /* ARP Response Directed */
-#define IGC_PROXYFCEX_ICMPV4		0x00000200 /* ICMPv4 */
-#define IGC_PROXYFCEX_ICMPV4_D	0x00000400 /* ICMPv4 Directed */
-#define IGC_PROXYFCEX_ICMPV6		0x00000800 /* ICMPv6 */
-#define IGC_PROXYFCEX_ICMPV6_D	0x00001000 /* ICMPv6 Directed */
-#define IGC_PROXYFCEX_DNS		0x00002000 /* DNS */
-
-/* Proxy Filter Control */
-#define IGC_PROXYFC_D0		0x00000001 /* Enable offload in D0 */
-#define IGC_PROXYFC_EX		0x00000004 /* Directed exact proxy */
-#define IGC_PROXYFC_MC		0x00000008 /* Directed MC Proxy */
-#define IGC_PROXYFC_BC		0x00000010 /* Broadcast Proxy Enable */
-#define IGC_PROXYFC_ARP_DIRECTED	0x00000020 /* Directed ARP Proxy Ena */
-#define IGC_PROXYFC_IPV4		0x00000040 /* Directed IPv4 Enable */
-#define IGC_PROXYFC_IPV6		0x00000080 /* Directed IPv6 Enable */
-#define IGC_PROXYFC_NS		0x00000200 /* IPv6 Neighbor Solicitation */
-#define IGC_PROXYFC_NS_DIRECTED	0x00000400 /* Directed NS Proxy Ena */
-#define IGC_PROXYFC_ARP		0x00000800 /* ARP Request Proxy Ena */
-/* Proxy Status */
-#define IGC_PROXYS_CLEAR		0xFFFFFFFF /* Clear */
-
-/* Firmware Status */
-#define IGC_FWSTS_FWRI		0x80000000 /* FW Reset Indication */
-/* VF Control */
-#define IGC_VTCTRL_RST		0x04000000 /* Reset VF */
-
-#define IGC_STATUS_LAN_ID_MASK	0x00000000C /* Mask for Lan ID field */
-/* Lan ID bit field offset in status register */
-#define IGC_STATUS_LAN_ID_OFFSET	2
-#define IGC_VFTA_ENTRIES		128
-
-#define IGC_UNUSEDARG
-#define ERROR_REPORT(fmt)	do { } while (0)
-#endif /* _IGC_DEFINES_H_ */
diff --git a/drivers/net/intel/igc/base/igc_hw.h b/drivers/net/intel/igc/base/igc_hw.h
deleted file mode 100644
index f779bac094..0000000000
--- a/drivers/net/intel/igc/base/igc_hw.h
+++ /dev/null
@@ -1,1059 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_HW_H_
-#define _IGC_HW_H_
-
-#include "igc_osdep.h"
-#include "igc_regs.h"
-#include "igc_defines.h"
-
-struct igc_hw;
-
-#define IGC_DEV_ID_82542			0x1000
-#define IGC_DEV_ID_82543GC_FIBER		0x1001
-#define IGC_DEV_ID_82543GC_COPPER		0x1004
-#define IGC_DEV_ID_82544EI_COPPER		0x1008
-#define IGC_DEV_ID_82544EI_FIBER		0x1009
-#define IGC_DEV_ID_82544GC_COPPER		0x100C
-#define IGC_DEV_ID_82544GC_LOM		0x100D
-#define IGC_DEV_ID_82540EM			0x100E
-#define IGC_DEV_ID_82540EM_LOM		0x1015
-#define IGC_DEV_ID_82540EP_LOM		0x1016
-#define IGC_DEV_ID_82540EP			0x1017
-#define IGC_DEV_ID_82540EP_LP			0x101E
-#define IGC_DEV_ID_82545EM_COPPER		0x100F
-#define IGC_DEV_ID_82545EM_FIBER		0x1011
-#define IGC_DEV_ID_82545GM_COPPER		0x1026
-#define IGC_DEV_ID_82545GM_FIBER		0x1027
-#define IGC_DEV_ID_82545GM_SERDES		0x1028
-#define IGC_DEV_ID_82546EB_COPPER		0x1010
-#define IGC_DEV_ID_82546EB_FIBER		0x1012
-#define IGC_DEV_ID_82546EB_QUAD_COPPER	0x101D
-#define IGC_DEV_ID_82546GB_COPPER		0x1079
-#define IGC_DEV_ID_82546GB_FIBER		0x107A
-#define IGC_DEV_ID_82546GB_SERDES		0x107B
-#define IGC_DEV_ID_82546GB_PCIE		0x108A
-#define IGC_DEV_ID_82546GB_QUAD_COPPER	0x1099
-#define IGC_DEV_ID_82546GB_QUAD_COPPER_KSP3	0x10B5
-#define IGC_DEV_ID_82541EI			0x1013
-#define IGC_DEV_ID_82541EI_MOBILE		0x1018
-#define IGC_DEV_ID_82541ER_LOM		0x1014
-#define IGC_DEV_ID_82541ER			0x1078
-#define IGC_DEV_ID_82541GI			0x1076
-#define IGC_DEV_ID_82541GI_LF			0x107C
-#define IGC_DEV_ID_82541GI_MOBILE		0x1077
-#define IGC_DEV_ID_82547EI			0x1019
-#define IGC_DEV_ID_82547EI_MOBILE		0x101A
-#define IGC_DEV_ID_82547GI			0x1075
-#define IGC_DEV_ID_82571EB_COPPER		0x105E
-#define IGC_DEV_ID_82571EB_FIBER		0x105F
-#define IGC_DEV_ID_82571EB_SERDES		0x1060
-#define IGC_DEV_ID_82571EB_SERDES_DUAL	0x10D9
-#define IGC_DEV_ID_82571EB_SERDES_QUAD	0x10DA
-#define IGC_DEV_ID_82571EB_QUAD_COPPER	0x10A4
-#define IGC_DEV_ID_82571PT_QUAD_COPPER	0x10D5
-#define IGC_DEV_ID_82571EB_QUAD_FIBER		0x10A5
-#define IGC_DEV_ID_82571EB_QUAD_COPPER_LP	0x10BC
-#define IGC_DEV_ID_82572EI_COPPER		0x107D
-#define IGC_DEV_ID_82572EI_FIBER		0x107E
-#define IGC_DEV_ID_82572EI_SERDES		0x107F
-#define IGC_DEV_ID_82572EI			0x10B9
-#define IGC_DEV_ID_82573E			0x108B
-#define IGC_DEV_ID_82573E_IAMT		0x108C
-#define IGC_DEV_ID_82573L			0x109A
-#define IGC_DEV_ID_82574L			0x10D3
-#define IGC_DEV_ID_82574LA			0x10F6
-#define IGC_DEV_ID_82583V			0x150C
-#define IGC_DEV_ID_80003ES2LAN_COPPER_DPT	0x1096
-#define IGC_DEV_ID_80003ES2LAN_SERDES_DPT	0x1098
-#define IGC_DEV_ID_80003ES2LAN_COPPER_SPT	0x10BA
-#define IGC_DEV_ID_80003ES2LAN_SERDES_SPT	0x10BB
-#define IGC_DEV_ID_ICH8_82567V_3		0x1501
-#define IGC_DEV_ID_ICH8_IGP_M_AMT		0x1049
-#define IGC_DEV_ID_ICH8_IGP_AMT		0x104A
-#define IGC_DEV_ID_ICH8_IGP_C			0x104B
-#define IGC_DEV_ID_ICH8_IFE			0x104C
-#define IGC_DEV_ID_ICH8_IFE_GT		0x10C4
-#define IGC_DEV_ID_ICH8_IFE_G			0x10C5
-#define IGC_DEV_ID_ICH8_IGP_M			0x104D
-#define IGC_DEV_ID_ICH9_IGP_M			0x10BF
-#define IGC_DEV_ID_ICH9_IGP_M_AMT		0x10F5
-#define IGC_DEV_ID_ICH9_IGP_M_V		0x10CB
-#define IGC_DEV_ID_ICH9_IGP_AMT		0x10BD
-#define IGC_DEV_ID_ICH9_BM			0x10E5
-#define IGC_DEV_ID_ICH9_IGP_C			0x294C
-#define IGC_DEV_ID_ICH9_IFE			0x10C0
-#define IGC_DEV_ID_ICH9_IFE_GT		0x10C3
-#define IGC_DEV_ID_ICH9_IFE_G			0x10C2
-#define IGC_DEV_ID_ICH10_R_BM_LM		0x10CC
-#define IGC_DEV_ID_ICH10_R_BM_LF		0x10CD
-#define IGC_DEV_ID_ICH10_R_BM_V		0x10CE
-#define IGC_DEV_ID_ICH10_D_BM_LM		0x10DE
-#define IGC_DEV_ID_ICH10_D_BM_LF		0x10DF
-#define IGC_DEV_ID_ICH10_D_BM_V		0x1525
-#define IGC_DEV_ID_PCH_M_HV_LM		0x10EA
-#define IGC_DEV_ID_PCH_M_HV_LC		0x10EB
-#define IGC_DEV_ID_PCH_D_HV_DM		0x10EF
-#define IGC_DEV_ID_PCH_D_HV_DC		0x10F0
-#define IGC_DEV_ID_PCH2_LV_LM			0x1502
-#define IGC_DEV_ID_PCH2_LV_V			0x1503
-#define IGC_DEV_ID_PCH_LPT_I217_LM		0x153A
-#define IGC_DEV_ID_PCH_LPT_I217_V		0x153B
-#define IGC_DEV_ID_PCH_LPTLP_I218_LM		0x155A
-#define IGC_DEV_ID_PCH_LPTLP_I218_V		0x1559
-#define IGC_DEV_ID_PCH_I218_LM2		0x15A0
-#define IGC_DEV_ID_PCH_I218_V2		0x15A1
-#define IGC_DEV_ID_PCH_I218_LM3		0x15A2 /* Wildcat Point PCH */
-#define IGC_DEV_ID_PCH_I218_V3		0x15A3 /* Wildcat Point PCH */
-#define IGC_DEV_ID_PCH_SPT_I219_LM		0x156F /* Sunrise Point PCH */
-#define IGC_DEV_ID_PCH_SPT_I219_V		0x1570 /* Sunrise Point PCH */
-#define IGC_DEV_ID_PCH_SPT_I219_LM2		0x15B7 /* Sunrise Point-H PCH */
-#define IGC_DEV_ID_PCH_SPT_I219_V2		0x15B8 /* Sunrise Point-H PCH */
-#define IGC_DEV_ID_PCH_LBG_I219_LM3		0x15B9 /* LEWISBURG PCH */
-#define IGC_DEV_ID_PCH_SPT_I219_LM4		0x15D7
-#define IGC_DEV_ID_PCH_SPT_I219_V4		0x15D8
-#define IGC_DEV_ID_PCH_SPT_I219_LM5		0x15E3
-#define IGC_DEV_ID_PCH_SPT_I219_V5		0x15D6
-#define IGC_DEV_ID_PCH_CNP_I219_LM6		0x15BD
-#define IGC_DEV_ID_PCH_CNP_I219_V6		0x15BE
-#define IGC_DEV_ID_PCH_CNP_I219_LM7		0x15BB
-#define IGC_DEV_ID_PCH_CNP_I219_V7		0x15BC
-#define IGC_DEV_ID_PCH_ICP_I219_LM8		0x15DF
-#define IGC_DEV_ID_PCH_ICP_I219_V8		0x15E0
-#define IGC_DEV_ID_PCH_ICP_I219_LM9		0x15E1
-#define IGC_DEV_ID_PCH_ICP_I219_V9		0x15E2
-#define IGC_DEV_ID_82576			0x10C9
-#define IGC_DEV_ID_82576_FIBER		0x10E6
-#define IGC_DEV_ID_82576_SERDES		0x10E7
-#define IGC_DEV_ID_82576_QUAD_COPPER		0x10E8
-#define IGC_DEV_ID_82576_QUAD_COPPER_ET2	0x1526
-#define IGC_DEV_ID_82576_NS			0x150A
-#define IGC_DEV_ID_82576_NS_SERDES		0x1518
-#define IGC_DEV_ID_82576_SERDES_QUAD		0x150D
-#define IGC_DEV_ID_82576_VF			0x10CA
-#define IGC_DEV_ID_82576_VF_HV		0x152D
-#define IGC_DEV_ID_I350_VF			0x1520
-#define IGC_DEV_ID_I350_VF_HV			0x152F
-#define IGC_DEV_ID_82575EB_COPPER		0x10A7
-#define IGC_DEV_ID_82575EB_FIBER_SERDES	0x10A9
-#define IGC_DEV_ID_82575GB_QUAD_COPPER	0x10D6
-#define IGC_DEV_ID_82580_COPPER		0x150E
-#define IGC_DEV_ID_82580_FIBER		0x150F
-#define IGC_DEV_ID_82580_SERDES		0x1510
-#define IGC_DEV_ID_82580_SGMII		0x1511
-#define IGC_DEV_ID_82580_COPPER_DUAL		0x1516
-#define IGC_DEV_ID_82580_QUAD_FIBER		0x1527
-#define IGC_DEV_ID_I350_COPPER		0x1521
-#define IGC_DEV_ID_I350_FIBER			0x1522
-#define IGC_DEV_ID_I350_SERDES		0x1523
-#define IGC_DEV_ID_I350_SGMII			0x1524
-#define IGC_DEV_ID_I350_DA4			0x1546
-#define IGC_DEV_ID_I210_COPPER		0x1533
-#define IGC_DEV_ID_I210_COPPER_OEM1		0x1534
-#define IGC_DEV_ID_I210_COPPER_IT		0x1535
-#define IGC_DEV_ID_I210_FIBER			0x1536
-#define IGC_DEV_ID_I210_SERDES		0x1537
-#define IGC_DEV_ID_I210_SGMII			0x1538
-#define IGC_DEV_ID_I210_COPPER_FLASHLESS	0x157B
-#define IGC_DEV_ID_I210_SERDES_FLASHLESS	0x157C
-#define IGC_DEV_ID_I210_SGMII_FLASHLESS	0x15F6
-#define IGC_DEV_ID_I211_COPPER		0x1539
-#define IGC_DEV_ID_I225_LM			0x15F2
-#define IGC_DEV_ID_I225_LMVP			0x5502
-#define IGC_DEV_ID_I225_V			0x15F3
-#define IGC_DEV_ID_I225_K			0x3100
-#define IGC_DEV_ID_I225_I			0x15F8
-#define IGC_DEV_ID_I225_IT			0x0D9F
-#define IGC_DEV_ID_I220_V			0x15F7
-#define IGC_DEV_ID_I225_BLANK_NVM		0x15FD
-#define IGC_DEV_ID_I226_K           0x3102
-#define IGC_DEV_ID_I226_LMVP        0x5503
-#define IGC_DEV_ID_I226_LM          0x125B
-#define IGC_DEV_ID_I226_V           0x125C
-#define IGC_DEV_ID_I226_IT          0x125D
-#define IGC_DEV_ID_I226_BLANK_NVM   0x125F
-#define IGC_DEV_ID_I354_BACKPLANE_1GBPS	0x1F40
-#define IGC_DEV_ID_I354_SGMII			0x1F41
-#define IGC_DEV_ID_I354_BACKPLANE_2_5GBPS	0x1F45
-#define IGC_DEV_ID_DH89XXCC_SGMII		0x0438
-#define IGC_DEV_ID_DH89XXCC_SERDES		0x043A
-#define IGC_DEV_ID_DH89XXCC_BACKPLANE		0x043C
-#define IGC_DEV_ID_DH89XXCC_SFP		0x0440
-
-#define IGC_REVISION_0	0
-#define IGC_REVISION_1	1
-#define IGC_REVISION_2	2
-#define IGC_REVISION_3	3
-#define IGC_REVISION_4	4
-
-#define IGC_FUNC_0		0
-#define IGC_FUNC_1		1
-#define IGC_FUNC_2		2
-#define IGC_FUNC_3		3
-
-#define IGC_ALT_MAC_ADDRESS_OFFSET_LAN0	0
-#define IGC_ALT_MAC_ADDRESS_OFFSET_LAN1	3
-#define IGC_ALT_MAC_ADDRESS_OFFSET_LAN2	6
-#define IGC_ALT_MAC_ADDRESS_OFFSET_LAN3	9
-
-enum igc_mac_type {
-	igc_undefined = 0,
-	igc_82542,
-	igc_82543,
-	igc_82544,
-	igc_82540,
-	igc_82545,
-	igc_82545_rev_3,
-	igc_82546,
-	igc_82546_rev_3,
-	igc_82541,
-	igc_82541_rev_2,
-	igc_82547,
-	igc_82547_rev_2,
-	igc_82571,
-	igc_82572,
-	igc_82573,
-	igc_82574,
-	igc_82583,
-	igc_80003es2lan,
-	igc_ich8lan,
-	igc_ich9lan,
-	igc_ich10lan,
-	igc_pchlan,
-	igc_pch2lan,
-	igc_pch_lpt,
-	igc_pch_spt,
-	igc_pch_cnp,
-	igc_82575,
-	igc_82576,
-	igc_82580,
-	igc_i350,
-	igc_i354,
-	igc_i210,
-	igc_i211,
-	igc_i225,
-	igc_vfadapt,
-	igc_vfadapt_i350,
-	igc_num_macs  /* List is 1-based, so subtract 1 for true count. */
-};
-
-enum igc_media_type {
-	igc_media_type_unknown = 0,
-	igc_media_type_copper = 1,
-	igc_media_type_fiber = 2,
-	igc_media_type_internal_serdes = 3,
-	igc_num_media_types
-};
-
-enum igc_nvm_type {
-	igc_nvm_unknown = 0,
-	igc_nvm_none,
-	igc_nvm_eeprom_spi,
-	igc_nvm_eeprom_microwire,
-	igc_nvm_flash_hw,
-	igc_nvm_invm,
-	igc_nvm_flash_sw
-};
-
-enum igc_nvm_override {
-	igc_nvm_override_none = 0,
-	igc_nvm_override_spi_small,
-	igc_nvm_override_spi_large,
-	igc_nvm_override_microwire_small,
-	igc_nvm_override_microwire_large
-};
-
-enum igc_phy_type {
-	igc_phy_unknown = 0,
-	igc_phy_none,
-	igc_phy_m88,
-	igc_phy_igp,
-	igc_phy_igp_2,
-	igc_phy_gg82563,
-	igc_phy_igp_3,
-	igc_phy_ife,
-	igc_phy_bm,
-	igc_phy_82578,
-	igc_phy_82577,
-	igc_phy_82579,
-	igc_phy_i217,
-	igc_phy_82580,
-	igc_phy_vf,
-	igc_phy_i210,
-	igc_phy_i225,
-};
-
-enum igc_bus_type {
-	igc_bus_type_unknown = 0,
-	igc_bus_type_pci,
-	igc_bus_type_pcix,
-	igc_bus_type_pci_express,
-	igc_bus_type_reserved
-};
-
-enum igc_bus_speed {
-	igc_bus_speed_unknown = 0,
-	igc_bus_speed_33,
-	igc_bus_speed_66,
-	igc_bus_speed_100,
-	igc_bus_speed_120,
-	igc_bus_speed_133,
-	igc_bus_speed_2500,
-	igc_bus_speed_5000,
-	igc_bus_speed_reserved
-};
-
-enum igc_bus_width {
-	igc_bus_width_unknown = 0,
-	igc_bus_width_pcie_x1,
-	igc_bus_width_pcie_x2,
-	igc_bus_width_pcie_x4 = 4,
-	igc_bus_width_pcie_x8 = 8,
-	igc_bus_width_32,
-	igc_bus_width_64,
-	igc_bus_width_reserved
-};
-
-enum igc_1000t_rx_status {
-	igc_1000t_rx_status_not_ok = 0,
-	igc_1000t_rx_status_ok,
-	igc_1000t_rx_status_undefined = 0xFF
-};
-
-enum igc_rev_polarity {
-	igc_rev_polarity_normal = 0,
-	igc_rev_polarity_reversed,
-	igc_rev_polarity_undefined = 0xFF
-};
-
-enum igc_fc_mode {
-	igc_fc_none = 0,
-	igc_fc_rx_pause,
-	igc_fc_tx_pause,
-	igc_fc_full,
-	igc_fc_default = 0xFF
-};
-
-enum igc_ffe_config {
-	igc_ffe_config_enabled = 0,
-	igc_ffe_config_active,
-	igc_ffe_config_blocked
-};
-
-enum igc_dsp_config {
-	igc_dsp_config_disabled = 0,
-	igc_dsp_config_enabled,
-	igc_dsp_config_activated,
-	igc_dsp_config_undefined = 0xFF
-};
-
-enum igc_ms_type {
-	igc_ms_hw_default = 0,
-	igc_ms_force_master,
-	igc_ms_force_slave,
-	igc_ms_auto
-};
-
-enum igc_smart_speed {
-	igc_smart_speed_default = 0,
-	igc_smart_speed_on,
-	igc_smart_speed_off
-};
-
-enum igc_serdes_link_state {
-	igc_serdes_link_down = 0,
-	igc_serdes_link_autoneg_progress,
-	igc_serdes_link_autoneg_complete,
-	igc_serdes_link_forced_up
-};
-
-enum igc_invm_structure_type {
-	igc_invm_uninitialized_structure		= 0x00,
-	igc_invm_word_autoload_structure		= 0x01,
-	igc_invm_csr_autoload_structure		= 0x02,
-	igc_invm_phy_register_autoload_structure	= 0x03,
-	igc_invm_rsa_key_sha256_structure		= 0x04,
-	igc_invm_invalidated_structure		= 0x0f,
-};
-
-#define __le16 u16
-#define __le32 u32
-#define __le64 u64
-/* Receive Descriptor */
-struct igc_rx_desc {
-	__le64 buffer_addr; /* Address of the descriptor's data buffer */
-	__le16 length;      /* Length of data DMAed into data buffer */
-	__le16 csum; /* Packet checksum */
-	u8  status;  /* Descriptor status */
-	u8  errors;  /* Descriptor Errors */
-	__le16 special;
-};
-
-/* Receive Descriptor - Extended */
-union igc_rx_desc_extended {
-	struct {
-		__le64 buffer_addr;
-		__le64 reserved;
-	} read;
-	struct {
-		struct {
-			__le32 mrq; /* Multiple Rx Queues */
-			union {
-				__le32 rss; /* RSS Hash */
-				struct {
-					__le16 ip_id;  /* IP id */
-					__le16 csum;   /* Packet Checksum */
-				} csum_ip;
-			} hi_dword;
-		} lower;
-		struct {
-			__le32 status_error;  /* ext status/error */
-			__le16 length;
-			__le16 vlan; /* VLAN tag */
-		} upper;
-	} wb;  /* writeback */
-};
-
-#define MAX_PS_BUFFERS 4
-
-/* Number of packet split data buffers (not including the header buffer) */
-#define PS_PAGE_BUFFERS	(MAX_PS_BUFFERS - 1)
-
-/* Receive Descriptor - Packet Split */
-union igc_rx_desc_packet_split {
-	struct {
-		/* one buffer for protocol header(s), three data buffers */
-		__le64 buffer_addr[MAX_PS_BUFFERS];
-	} read;
-	struct {
-		struct {
-			__le32 mrq;  /* Multiple Rx Queues */
-			union {
-				__le32 rss; /* RSS Hash */
-				struct {
-					__le16 ip_id;    /* IP id */
-					__le16 csum;     /* Packet Checksum */
-				} csum_ip;
-			} hi_dword;
-		} lower;
-		struct {
-			__le32 status_error;  /* ext status/error */
-			__le16 length0;  /* length of buffer 0 */
-			__le16 vlan;  /* VLAN tag */
-		} middle;
-		struct {
-			__le16 header_status;
-			/* length of buffers 1-3 */
-			__le16 length[PS_PAGE_BUFFERS];
-		} upper;
-		__le64 reserved;
-	} wb; /* writeback */
-};
-
-/* Transmit Descriptor */
-struct igc_tx_desc {
-	__le64 buffer_addr;   /* Address of the descriptor's data buffer */
-	union {
-		__le32 data;
-		struct {
-			__le16 length;  /* Data buffer length */
-			u8 cso;  /* Checksum offset */
-			u8 cmd;  /* Descriptor control */
-		} flags;
-	} lower;
-	union {
-		__le32 data;
-		struct {
-			u8 status; /* Descriptor status */
-			u8 css;  /* Checksum start */
-			__le16 special;
-		} fields;
-	} upper;
-};
-
-/* Offload Context Descriptor */
-struct igc_context_desc {
-	union {
-		__le32 ip_config;
-		struct {
-			u8 ipcss;  /* IP checksum start */
-			u8 ipcso;  /* IP checksum offset */
-			__le16 ipcse;  /* IP checksum end */
-		} ip_fields;
-	} lower_setup;
-	union {
-		__le32 tcp_config;
-		struct {
-			u8 tucss;  /* TCP checksum start */
-			u8 tucso;  /* TCP checksum offset */
-			__le16 tucse;  /* TCP checksum end */
-		} tcp_fields;
-	} upper_setup;
-	__le32 cmd_and_length;
-	union {
-		__le32 data;
-		struct {
-			u8 status;  /* Descriptor status */
-			u8 hdr_len;  /* Header length */
-			__le16 mss;  /* Maximum segment size */
-		} fields;
-	} tcp_seg_setup;
-};
-
-/* Offload data descriptor */
-struct igc_data_desc {
-	__le64 buffer_addr;  /* Address of the descriptor's buffer address */
-	union {
-		__le32 data;
-		struct {
-			__le16 length;  /* Data buffer length */
-			u8 typ_len_ext;
-			u8 cmd;
-		} flags;
-	} lower;
-	union {
-		__le32 data;
-		struct {
-			u8 status;  /* Descriptor status */
-			u8 popts;  /* Packet Options */
-			__le16 special;
-		} fields;
-	} upper;
-};
-
-/* Statistics counters collected by the MAC */
-struct igc_hw_stats {
-	u64 crcerrs;
-	u64 algnerrc;
-	u64 symerrs;
-	u64 rxerrc;
-	u64 mpc;
-	u64 scc;
-	u64 ecol;
-	u64 mcc;
-	u64 latecol;
-	u64 colc;
-	u64 dc;
-	u64 tncrs;
-	u64 sec;
-	u64 cexterr;
-	u64 rlec;
-	u64 xonrxc;
-	u64 xontxc;
-	u64 xoffrxc;
-	u64 xofftxc;
-	u64 fcruc;
-	u64 prc64;
-	u64 prc127;
-	u64 prc255;
-	u64 prc511;
-	u64 prc1023;
-	u64 prc1522;
-	u64 gprc;
-	u64 bprc;
-	u64 mprc;
-	u64 gptc;
-	u64 gorc;
-	u64 gotc;
-	u64 rnbc;
-	u64 ruc;
-	u64 rfc;
-	u64 roc;
-	u64 rjc;
-	u64 mgprc;
-	u64 mgpdc;
-	u64 mgptc;
-	u64 tor;
-	u64 tot;
-	u64 tpr;
-	u64 tpt;
-	u64 ptc64;
-	u64 ptc127;
-	u64 ptc255;
-	u64 ptc511;
-	u64 ptc1023;
-	u64 ptc1522;
-	u64 mptc;
-	u64 bptc;
-	u64 tsctc;
-	u64 tsctfc;
-	u64 iac;
-	u64 icrxptc;
-	u64 icrxatc;
-	u64 ictxptc;
-	u64 ictxatc;
-	u64 ictxqec;
-	u64 ictxqmtc;
-	u64 icrxdmtc;
-	u64 icrxoc;
-	u64 cbtmpc;
-	u64 htdpmc;
-	u64 cbrdpc;
-	u64 cbrmpc;
-	u64 rpthc;
-	u64 hgptc;
-	u64 htcbdpc;
-	u64 hgorc;
-	u64 hgotc;
-	u64 lenerrs;
-	u64 scvpc;
-	u64 hrmpc;
-	u64 doosync;
-	u64 o2bgptc;
-	u64 o2bspc;
-	u64 b2ospc;
-	u64 b2ogprc;
-};
-
-struct igc_vf_stats {
-	u64 base_gprc;
-	u64 base_gptc;
-	u64 base_gorc;
-	u64 base_gotc;
-	u64 base_mprc;
-	u64 base_gotlbc;
-	u64 base_gptlbc;
-	u64 base_gorlbc;
-	u64 base_gprlbc;
-
-	u32 last_gprc;
-	u32 last_gptc;
-	u32 last_gorc;
-	u32 last_gotc;
-	u32 last_mprc;
-	u32 last_gotlbc;
-	u32 last_gptlbc;
-	u32 last_gorlbc;
-	u32 last_gprlbc;
-
-	u64 gprc;
-	u64 gptc;
-	u64 gorc;
-	u64 gotc;
-	u64 mprc;
-	u64 gotlbc;
-	u64 gptlbc;
-	u64 gorlbc;
-	u64 gprlbc;
-};
-
-struct igc_phy_stats {
-	u32 idle_errors;
-	u32 receive_errors;
-};
-
-struct igc_host_mng_dhcp_cookie {
-	u32 signature;
-	u8  status;
-	u8  reserved0;
-	u16 vlan_id;
-	u32 reserved1;
-	u16 reserved2;
-	u8  reserved3;
-	u8  checksum;
-};
-
-/* Host Interface "Rev 1" */
-struct igc_host_command_header {
-	u8 command_id;
-	u8 command_length;
-	u8 command_options;
-	u8 checksum;
-};
-
-#define IGC_HI_MAX_DATA_LENGTH	252
-struct igc_host_command_info {
-	struct igc_host_command_header command_header;
-	u8 command_data[IGC_HI_MAX_DATA_LENGTH];
-};
-
-/* Host Interface "Rev 2" */
-struct igc_host_mng_command_header {
-	u8  command_id;
-	u8  checksum;
-	u16 reserved1;
-	u16 reserved2;
-	u16 command_length;
-};
-
-#define IGC_HI_MAX_MNG_DATA_LENGTH	0x6F8
-struct igc_host_mng_command_info {
-	struct igc_host_mng_command_header command_header;
-	u8 command_data[IGC_HI_MAX_MNG_DATA_LENGTH];
-};
-
-#include "igc_mac.h"
-#include "igc_phy.h"
-#include "igc_nvm.h"
-#include "igc_manage.h"
-
-/* Function pointers for the MAC. */
-struct igc_mac_operations {
-	s32  (*init_params)(struct igc_hw *hw);
-	s32  (*id_led_init)(struct igc_hw *hw);
-	s32  (*blink_led)(struct igc_hw *hw);
-	bool (*check_mng_mode)(struct igc_hw *hw);
-	s32  (*check_for_link)(struct igc_hw *hw);
-	s32  (*cleanup_led)(struct igc_hw *hw);
-	void (*clear_hw_cntrs)(struct igc_hw *hw);
-	void (*clear_vfta)(struct igc_hw *hw);
-	s32  (*get_bus_info)(struct igc_hw *hw);
-	void (*set_lan_id)(struct igc_hw *hw);
-	s32  (*get_link_up_info)(struct igc_hw *hw, u16 *speed, u16 *duplex);
-	s32  (*led_on)(struct igc_hw *hw);
-	s32  (*led_off)(struct igc_hw *hw);
-	void (*update_mc_addr_list)(struct igc_hw *hw,
-			u8 *mc_addr_list, u32 count);
-	s32  (*reset_hw)(struct igc_hw *hw);
-	s32  (*init_hw)(struct igc_hw *hw);
-	void (*shutdown_serdes)(struct igc_hw *hw);
-	void (*power_up_serdes)(struct igc_hw *hw);
-	s32  (*setup_link)(struct igc_hw *hw);
-	s32  (*setup_physical_interface)(struct igc_hw *hw);
-	s32  (*setup_led)(struct igc_hw *hw);
-	void (*write_vfta)(struct igc_hw *hw, u32 offset, u32 value);
-	void (*config_collision_dist)(struct igc_hw *hw);
-	int  (*rar_set)(struct igc_hw *hw, u8 *addr, u32 index);
-	s32  (*read_mac_addr)(struct igc_hw *hw);
-	s32  (*validate_mdi_setting)(struct igc_hw *hw);
-	s32  (*acquire_swfw_sync)(struct igc_hw *hw, u16 mask);
-	void (*release_swfw_sync)(struct igc_hw *hw, u16 mask);
-};
-
-/* When to use various PHY register access functions:
- *
- *                 Func   Caller
- *   Function      Does   Does    When to use
- *   ~~~~~~~~~~~~  ~~~~~  ~~~~~~  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *   X_reg         L,P,A  n/a     for simple PHY reg accesses
- *   X_reg_locked  P,A    L       for multiple accesses of different regs
- *                                on different pages
- *   X_reg_page    A      L,P     for multiple accesses of different regs
- *                                on the same page
- *
- * Where X=[read|write], L=locking, P=sets page, A=register access
- *
- */
-struct igc_phy_operations {
-	s32  (*init_params)(struct igc_hw *hw);
-	s32  (*acquire)(struct igc_hw *hw);
-	s32  (*cfg_on_link_up)(struct igc_hw *hw);
-	s32  (*check_polarity)(struct igc_hw *hw);
-	s32  (*check_reset_block)(struct igc_hw *hw);
-	s32  (*commit)(struct igc_hw *hw);
-	s32  (*force_speed_duplex)(struct igc_hw *hw);
-	s32  (*get_cfg_done)(struct igc_hw *hw);
-	s32  (*get_cable_length)(struct igc_hw *hw);
-	s32  (*get_info)(struct igc_hw *hw);
-	s32  (*set_page)(struct igc_hw *hw, u16 page);
-	s32  (*read_reg)(struct igc_hw *hw, u32 offset, u16 *data);
-	s32  (*read_reg_locked)(struct igc_hw *hw, u32 offset, u16 *data);
-	s32  (*read_reg_page)(struct igc_hw *hw, u32 offset, u16 *data);
-	void (*release)(struct igc_hw *hw);
-	s32  (*reset)(struct igc_hw *hw);
-	s32  (*set_d0_lplu_state)(struct igc_hw *hw, bool active);
-	s32  (*set_d3_lplu_state)(struct igc_hw *hw, bool active);
-	s32  (*write_reg)(struct igc_hw *hw, u32 offset, u16 data);
-	s32  (*write_reg_locked)(struct igc_hw *hw, u32 offset, u16 data);
-	s32  (*write_reg_page)(struct igc_hw *hw, u32 offset, u16 data);
-	void (*power_up)(struct igc_hw *hw);
-	void (*power_down)(struct igc_hw *hw);
-	s32 (*read_i2c_byte)(struct igc_hw *hw, u8 byte_offset,
-			u8 dev_addr, u8 *data);
-	s32 (*write_i2c_byte)(struct igc_hw *hw, u8 byte_offset,
-			u8 dev_addr, u8 data);
-};
-
-/* Function pointers for the NVM. */
-struct igc_nvm_operations {
-	s32  (*init_params)(struct igc_hw *hw);
-	s32  (*acquire)(struct igc_hw *hw);
-	s32  (*read)(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
-	void (*release)(struct igc_hw *hw);
-	void (*reload)(struct igc_hw *hw);
-	s32  (*update)(struct igc_hw *hw);
-	s32  (*valid_led_default)(struct igc_hw *hw, u16 *data);
-	s32  (*validate)(struct igc_hw *hw);
-	s32  (*write)(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
-};
-
-struct igc_info {
-	s32 (*get_invariants)(struct igc_hw *hw);
-	struct igc_mac_operations *mac_ops;
-	const struct igc_phy_operations *phy_ops;
-	struct igc_nvm_operations *nvm_ops;
-};
-
-extern const struct igc_info igc_i225_info;
-
-struct igc_mac_info {
-	struct igc_mac_operations ops;
-	u8 addr[ETH_ADDR_LEN];
-	u8 perm_addr[ETH_ADDR_LEN];
-
-	enum igc_mac_type type;
-
-	u32 collision_delta;
-	u32 ledctl_default;
-	u32 ledctl_mode1;
-	u32 ledctl_mode2;
-	u32 mc_filter_type;
-	u32 tx_packet_delta;
-	u32 txcw;
-
-	u16 current_ifs_val;
-	u16 ifs_max_val;
-	u16 ifs_min_val;
-	u16 ifs_ratio;
-	u16 ifs_step_size;
-	u16 mta_reg_count;
-	u16 uta_reg_count;
-
-	/* Maximum size of the MTA register table in all supported adapters */
-#define MAX_MTA_REG 128
-	u32 mta_shadow[MAX_MTA_REG];
-	u16 rar_entry_count;
-
-	u8  forced_speed_duplex;
-
-	bool adaptive_ifs;
-	bool has_fwsm;
-	bool arc_subsystem_valid;
-	bool asf_firmware_present;
-	bool autoneg;
-	bool autoneg_failed;
-	bool get_link_status;
-	bool in_ifs_mode;
-	bool report_tx_early;
-	enum igc_serdes_link_state serdes_link_state;
-	bool serdes_has_link;
-	bool tx_pkt_filtering;
-};
-
-struct igc_phy_info {
-	struct igc_phy_operations ops;
-	enum igc_phy_type type;
-
-	enum igc_1000t_rx_status local_rx;
-	enum igc_1000t_rx_status remote_rx;
-	enum igc_ms_type ms_type;
-	enum igc_ms_type original_ms_type;
-	enum igc_rev_polarity cable_polarity;
-	enum igc_smart_speed smart_speed;
-
-	u32 addr;
-	u32 id;
-	u32 reset_delay_us; /* in usec */
-	u32 revision;
-
-	enum igc_media_type media_type;
-
-	u16 autoneg_advertised;
-	u16 autoneg_mask;
-	u16 cable_length;
-	u16 max_cable_length;
-	u16 min_cable_length;
-
-	u8 mdix;
-
-	bool disable_polarity_correction;
-	bool is_mdix;
-	bool polarity_correction;
-	bool speed_downgraded;
-	bool autoneg_wait_to_complete;
-};
-
-struct igc_nvm_info {
-	struct igc_nvm_operations ops;
-	enum igc_nvm_type type;
-	enum igc_nvm_override override;
-
-	u32 flash_bank_size;
-	u32 flash_base_addr;
-
-	u16 word_size;
-	u16 delay_usec;
-	u16 address_bits;
-	u16 opcode_bits;
-	u16 page_size;
-};
-
-struct igc_bus_info {
-	enum igc_bus_type type;
-	enum igc_bus_speed speed;
-	enum igc_bus_width width;
-
-	u16 func;
-	u16 pci_cmd_word;
-};
-
-struct igc_fc_info {
-	u32 high_water;  /* Flow control high-water mark */
-	u32 low_water;  /* Flow control low-water mark */
-	u16 pause_time;  /* Flow control pause timer */
-	u16 refresh_time;  /* Flow control refresh timer */
-	bool send_xon;  /* Flow control send XON */
-	bool strict_ieee;  /* Strict IEEE mode */
-	enum igc_fc_mode current_mode;  /* FC mode in effect */
-	enum igc_fc_mode requested_mode;  /* FC mode requested by caller */
-};
-
-struct igc_mbx_operations {
-	s32 (*init_params)(struct igc_hw *hw);
-};
-
-struct igc_mbx_stats {
-	u32 msgs_tx;
-	u32 msgs_rx;
-
-	u32 acks;
-	u32 reqs;
-	u32 rsts;
-};
-
-struct igc_mbx_info {
-	struct igc_mbx_operations ops;
-	struct igc_mbx_stats stats;
-	u32 timeout;
-	u32 usec_delay;
-	u16 size;
-};
-
-struct igc_dev_spec_82541 {
-	enum igc_dsp_config dsp_config;
-	enum igc_ffe_config ffe_config;
-	u16 spd_default;
-	bool phy_init_script;
-};
-
-struct igc_dev_spec_82542 {
-	bool dma_fairness;
-};
-
-struct igc_dev_spec_82543 {
-	u32  tbi_compatibility;
-	bool dma_fairness;
-	bool init_phy_disabled;
-};
-
-struct igc_dev_spec_82571 {
-	bool laa_is_present;
-	u32 smb_counter;
-	IGC_MUTEX swflag_mutex;
-};
-
-struct igc_dev_spec_80003es2lan {
-	bool  mdic_wa_enable;
-};
-
-struct igc_shadow_ram {
-	u16  value;
-	bool modified;
-};
-
-#define IGC_SHADOW_RAM_WORDS		2048
-
-/* I218 PHY Ultra Low Power (ULP) states */
-enum igc_ulp_state {
-	igc_ulp_state_unknown,
-	igc_ulp_state_off,
-	igc_ulp_state_on,
-};
-
-struct igc_dev_spec_ich8lan {
-	bool kmrn_lock_loss_workaround_enabled;
-	struct igc_shadow_ram shadow_ram[IGC_SHADOW_RAM_WORDS];
-	IGC_MUTEX nvm_mutex;
-	IGC_MUTEX swflag_mutex;
-	bool nvm_k1_enabled;
-	bool disable_k1_off;
-	bool eee_disable;
-	u16 eee_lp_ability;
-	enum igc_ulp_state ulp_state;
-	bool ulp_capability_disabled;
-	bool during_suspend_flow;
-	bool during_dpg_exit;
-	u16 lat_enc;
-	u16 max_ltr_enc;
-	bool smbus_disable;
-};
-
-struct igc_dev_spec_82575 {
-	bool sgmii_active;
-	bool global_device_reset;
-	bool eee_disable;
-	bool module_plugged;
-	bool clear_semaphore_once;
-	u32 mtu;
-	struct sfp_igc_flags eth_flags;
-	u8 media_port;
-	bool media_changed;
-};
-
-struct igc_dev_spec_vf {
-	u32 vf_number;
-	u32 v2p_mailbox;
-};
-
-struct igc_dev_spec_i225 {
-	bool global_device_reset;
-	bool eee_disable;
-	bool clear_semaphore_once;
-	bool module_plugged;
-	u8 media_port;
-	bool mas_capable;
-	u32 mtu;
-};
-
-struct igc_hw {
-	void *back;
-
-	u8 *hw_addr;
-	u8 *flash_address;
-	unsigned long io_base;
-
-	struct igc_mac_info  mac;
-	struct igc_fc_info   fc;
-	struct igc_phy_info  phy;
-	struct igc_nvm_info  nvm;
-	struct igc_bus_info  bus;
-	struct igc_mbx_info mbx;
-	struct igc_host_mng_dhcp_cookie mng_cookie;
-
-	union {
-		struct igc_dev_spec_82541 _82541;
-		struct igc_dev_spec_82542 _82542;
-		struct igc_dev_spec_82543 _82543;
-		struct igc_dev_spec_82571 _82571;
-		struct igc_dev_spec_80003es2lan _80003es2lan;
-		struct igc_dev_spec_ich8lan ich8lan;
-		struct igc_dev_spec_82575 _82575;
-		struct igc_dev_spec_vf vf;
-		struct igc_dev_spec_i225 _i225;
-	} dev_spec;
-
-	u16 device_id;
-	u16 subsystem_vendor_id;
-	u16 subsystem_device_id;
-	u16 vendor_id;
-
-	u8  revision_id;
-};
-
-#include "igc_82571.h"
-#include "igc_ich8lan.h"
-#include "igc_82575.h"
-#include "igc_i225.h"
-#include "igc_base.h"
-
-/* These functions must be implemented by drivers */
-void igc_pci_clear_mwi(struct igc_hw *hw);
-void igc_pci_set_mwi(struct igc_hw *hw);
-s32  igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
-s32  igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value);
-void igc_read_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value);
-void igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value);
-
-#endif
diff --git a/drivers/net/intel/igc/base/igc_i225.c b/drivers/net/intel/igc/base/igc_i225.c
deleted file mode 100644
index 17a1573064..0000000000
--- a/drivers/net/intel/igc/base/igc_i225.c
+++ /dev/null
@@ -1,1372 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#include "igc_api.h"
-
-static s32 igc_init_nvm_params_i225(struct igc_hw *hw);
-static s32 igc_init_mac_params_i225(struct igc_hw *hw);
-static s32 igc_init_phy_params_i225(struct igc_hw *hw);
-static s32 igc_reset_hw_i225(struct igc_hw *hw);
-static s32 igc_acquire_nvm_i225(struct igc_hw *hw);
-static void igc_release_nvm_i225(struct igc_hw *hw);
-static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw);
-static s32 __igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
-				  u16 *data);
-static s32 igc_pool_flash_update_done_i225(struct igc_hw *hw);
-static s32 igc_valid_led_default_i225(struct igc_hw *hw, u16 *data);
-
-/**
- *  igc_init_nvm_params_i225 - Init NVM func ptrs.
- *  @hw: pointer to the HW structure
- **/
-static s32 igc_init_nvm_params_i225(struct igc_hw *hw)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	u32 eecd = IGC_READ_REG(hw, IGC_EECD);
-	u16 size;
-
-	DEBUGFUNC("igc_init_nvm_params_i225");
-
-	size = (u16)((eecd & IGC_EECD_SIZE_EX_MASK) >>
-		     IGC_EECD_SIZE_EX_SHIFT);
-	/*
-	 * Added to a constant, "size" becomes the left-shift value
-	 * for setting word_size.
-	 */
-	size += NVM_WORD_SIZE_BASE_SHIFT;
-
-	/* Just in case size is out of range, cap it to the largest
-	 * EEPROM size supported
-	 */
-	if (size > 15)
-		size = 15;
-
-	nvm->word_size = 1 << size;
-	nvm->opcode_bits = 8;
-	nvm->delay_usec = 1;
-	nvm->type = igc_nvm_eeprom_spi;
-
-
-	nvm->page_size = eecd & IGC_EECD_ADDR_BITS ? 32 : 8;
-	nvm->address_bits = eecd & IGC_EECD_ADDR_BITS ?
-			    16 : 8;
-
-	if (nvm->word_size == (1 << 15))
-		nvm->page_size = 128;
-
-	nvm->ops.acquire = igc_acquire_nvm_i225;
-	nvm->ops.release = igc_release_nvm_i225;
-	nvm->ops.valid_led_default = igc_valid_led_default_i225;
-	if (igc_get_flash_presence_i225(hw)) {
-		hw->nvm.type = igc_nvm_flash_hw;
-		nvm->ops.read    = igc_read_nvm_srrd_i225;
-		nvm->ops.write   = igc_write_nvm_srwr_i225;
-		nvm->ops.validate = igc_validate_nvm_checksum_i225;
-		nvm->ops.update   = igc_update_nvm_checksum_i225;
-	} else {
-		hw->nvm.type = igc_nvm_invm;
-		nvm->ops.write    = igc_null_write_nvm;
-		nvm->ops.validate = igc_null_ops_generic;
-		nvm->ops.update   = igc_null_ops_generic;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_init_mac_params_i225 - Init MAC func ptrs.
- *  @hw: pointer to the HW structure
- **/
-static s32 igc_init_mac_params_i225(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	struct igc_dev_spec_i225 *dev_spec = &hw->dev_spec._i225;
-
-	DEBUGFUNC("igc_init_mac_params_i225");
-
-	/* Initialize function pointer */
-	igc_init_mac_ops_generic(hw);
-
-	/* Set media type */
-	hw->phy.media_type = igc_media_type_copper;
-	/* Set mta register count */
-	mac->mta_reg_count = 128;
-	/* Set rar entry count */
-	mac->rar_entry_count = IGC_RAR_ENTRIES_BASE;
-
-	/* reset */
-	mac->ops.reset_hw = igc_reset_hw_i225;
-	/* hw initialization */
-	mac->ops.init_hw = igc_init_hw_i225;
-	/* link setup */
-	mac->ops.setup_link = igc_setup_link_generic;
-	/* check for link */
-	mac->ops.check_for_link = igc_check_for_link_i225;
-	/* link info */
-	mac->ops.get_link_up_info = igc_get_speed_and_duplex_copper_generic;
-	/* acquire SW_FW sync */
-	mac->ops.acquire_swfw_sync = igc_acquire_swfw_sync_i225;
-	/* release SW_FW sync */
-	mac->ops.release_swfw_sync = igc_release_swfw_sync_i225;
-
-	/* Allow a single clear of the SW semaphore on I225 */
-	dev_spec->clear_semaphore_once = true;
-	mac->ops.setup_physical_interface = igc_setup_copper_link_i225;
-
-	/* Set if part includes ASF firmware */
-	mac->asf_firmware_present = true;
-
-	/* multicast address update */
-	mac->ops.update_mc_addr_list = igc_update_mc_addr_list_generic;
-
-	mac->ops.write_vfta = igc_write_vfta_generic;
-
-	/* Disable EEE by default */
-	dev_spec->eee_disable = true;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_init_phy_params_i225 - Init PHY func ptrs.
- *  @hw: pointer to the HW structure
- **/
-static s32 igc_init_phy_params_i225(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val = IGC_SUCCESS;
-	u32 ctrl_ext;
-
-	DEBUGFUNC("igc_init_phy_params_i225");
-
-	phy->ops.read_i2c_byte = igc_read_i2c_byte_generic;
-	phy->ops.write_i2c_byte = igc_write_i2c_byte_generic;
-
-	if (hw->phy.media_type != igc_media_type_copper) {
-		phy->type = igc_phy_none;
-		goto out;
-	}
-
-	phy->ops.power_up   = igc_power_up_phy_copper;
-	phy->ops.power_down = igc_power_down_phy_copper_base;
-
-	phy->autoneg_mask = AUTONEG_ADVERTISE_SPEED_DEFAULT_2500;
-
-	phy->reset_delay_us	= 100;
-
-	phy->ops.acquire	= igc_acquire_phy_base;
-	phy->ops.check_reset_block = igc_check_reset_block_generic;
-	phy->ops.commit		= igc_phy_sw_reset_generic;
-	phy->ops.release	= igc_release_phy_base;
-
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
-
-	/* Make sure the PHY is in a good state. Several people have reported
-	 * firmware leaving the PHY's page select register set to something
-	 * other than the default of zero, which causes the PHY ID read to
-	 * access something other than the intended register.
-	 */
-	ret_val = hw->phy.ops.reset(hw);
-	if (ret_val)
-		goto out;
-
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext);
-	phy->ops.read_reg = igc_read_phy_reg_gpy;
-	phy->ops.write_reg = igc_write_phy_reg_gpy;
-
-	ret_val = igc_get_phy_id(hw);
-	phy->type = igc_phy_i225;
-
-
-out:
-	return ret_val;
-}
-
-/**
- *  igc_reset_hw_i225 - Reset hardware
- *  @hw: pointer to the HW structure
- *
- *  This resets the hardware into a known state.
- **/
-static s32 igc_reset_hw_i225(struct igc_hw *hw)
-{
-	u32 ctrl;
-	s32 ret_val;
-
-	DEBUGFUNC("igc_reset_hw_i225");
-
-	/*
-	 * Prevent the PCI-E bus from sticking if there is no TLP connection
-	 * on the last TLP read/write transaction when MAC is reset.
-	 */
-	ret_val = igc_disable_pcie_master_generic(hw);
-	if (ret_val)
-		DEBUGOUT("PCI-E Master disable polling has failed.\n");
-
-	DEBUGOUT("Masking off all interrupts\n");
-	IGC_WRITE_REG(hw, IGC_IMC, 0xffffffff);
-
-	IGC_WRITE_REG(hw, IGC_RCTL, 0);
-	IGC_WRITE_REG(hw, IGC_TCTL, IGC_TCTL_PSP);
-	IGC_WRITE_FLUSH(hw);
-
-	msec_delay(10);
-
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-
-	DEBUGOUT("Issuing a global reset to MAC\n");
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl | IGC_CTRL_RST);
-
-	ret_val = igc_get_auto_rd_done_generic(hw);
-	if (ret_val) {
-		/*
-		 * When auto config read does not complete, do not
-		 * return with an error. This can happen in situations
-		 * where there is no eeprom and prevents getting link.
-		 */
-		DEBUGOUT("Auto Read Done did not complete\n");
-	}
-
-	/* Clear any pending interrupt events. */
-	IGC_WRITE_REG(hw, IGC_IMC, 0xffffffff);
-	IGC_READ_REG(hw, IGC_ICR);
-
-	/* Install any alternate MAC address into RAR0 */
-	ret_val = igc_check_alt_mac_addr_generic(hw);
-
-	return ret_val;
-}
-
-/* igc_acquire_nvm_i225 - Request for access to EEPROM
- * @hw: pointer to the HW structure
- *
- * Acquire the necessary semaphores for exclusive access to the EEPROM.
- * Set the EEPROM access request bit and wait for EEPROM access grant bit.
- * Return successful if access grant bit set, else clear the request for
- * EEPROM access and return -IGC_ERR_NVM (-1).
- */
-static s32 igc_acquire_nvm_i225(struct igc_hw *hw)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("igc_acquire_nvm_i225");
-
-	ret_val = igc_acquire_swfw_sync_i225(hw, IGC_SWFW_EEP_SM);
-
-	return ret_val;
-}
-
-/* igc_release_nvm_i225 - Release exclusive access to EEPROM
- * @hw: pointer to the HW structure
- *
- * Stop any current commands to the EEPROM and clear the EEPROM request bit,
- * then release the semaphores acquired.
- */
-static void igc_release_nvm_i225(struct igc_hw *hw)
-{
-	DEBUGFUNC("igc_release_nvm_i225");
-
-	igc_release_swfw_sync_i225(hw, IGC_SWFW_EEP_SM);
-}
-
-/* igc_acquire_swfw_sync_i225 - Acquire SW/FW semaphore
- * @hw: pointer to the HW structure
- * @mask: specifies which semaphore to acquire
- *
- * Acquire the SW/FW semaphore to access the PHY or NVM.  The mask
- * will also specify which port we're acquiring the lock for.
- */
-s32 igc_acquire_swfw_sync_i225(struct igc_hw *hw, u16 mask)
-{
-	u32 swfw_sync;
-	u32 swmask = mask;
-	u32 fwmask = mask << 16;
-	s32 ret_val = IGC_SUCCESS;
-	s32 i = 0, timeout = 200; /* FIXME: find real value to use here */
-
-	DEBUGFUNC("igc_acquire_swfw_sync_i225");
-
-	while (i < timeout) {
-		if (igc_get_hw_semaphore_i225(hw)) {
-			ret_val = -IGC_ERR_SWFW_SYNC;
-			goto out;
-		}
-
-		swfw_sync = IGC_READ_REG(hw, IGC_SW_FW_SYNC);
-		if (!(swfw_sync & (fwmask | swmask)))
-			break;
-
-		/* Firmware currently using resource (fwmask)
-		 * or other software thread using resource (swmask)
-		 */
-		igc_put_hw_semaphore_generic(hw);
-		msec_delay_irq(5);
-		i++;
-	}
-
-	if (i == timeout) {
-		DEBUGOUT("Driver can't access resource, SW_FW_SYNC timeout.\n");
-		ret_val = -IGC_ERR_SWFW_SYNC;
-		goto out;
-	}
-
-	swfw_sync |= swmask;
-	IGC_WRITE_REG(hw, IGC_SW_FW_SYNC, swfw_sync);
-
-	igc_put_hw_semaphore_generic(hw);
-
-out:
-	return ret_val;
-}
-
-/* igc_release_swfw_sync_i225 - Release SW/FW semaphore
- * @hw: pointer to the HW structure
- * @mask: specifies which semaphore to acquire
- *
- * Release the SW/FW semaphore used to access the PHY or NVM.  The mask
- * will also specify which port we're releasing the lock for.
- */
-void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask)
-{
-	u32 swfw_sync;
-
-	DEBUGFUNC("igc_release_swfw_sync_i225");
-
-	while (igc_get_hw_semaphore_i225(hw) != IGC_SUCCESS)
-		; /* Empty */
-
-	swfw_sync = IGC_READ_REG(hw, IGC_SW_FW_SYNC);
-	swfw_sync &= ~mask;
-	IGC_WRITE_REG(hw, IGC_SW_FW_SYNC, swfw_sync);
-
-	igc_put_hw_semaphore_generic(hw);
-}
-
-/*
- * igc_setup_copper_link_i225 - Configure copper link settings
- * @hw: pointer to the HW structure
- *
- * Configures the link for auto-neg or forced speed and duplex.  Then we check
- * for link, once link is established calls to configure collision distance
- * and flow control are called.
- */
-s32 igc_setup_copper_link_i225(struct igc_hw *hw)
-{
-	u32 phpm_reg;
-	s32 ret_val;
-	u32 ctrl;
-
-	DEBUGFUNC("igc_setup_copper_link_i225");
-
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-	ctrl |= IGC_CTRL_SLU;
-	ctrl &= ~(IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX);
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-
-	phpm_reg = IGC_READ_REG(hw, IGC_I225_PHPM);
-	phpm_reg &= ~IGC_I225_PHPM_GO_LINKD;
-	IGC_WRITE_REG(hw, IGC_I225_PHPM, phpm_reg);
-
-	ret_val = igc_setup_copper_link_generic(hw);
-
-	return ret_val;
-}
-
-/* igc_get_hw_semaphore_i225 - Acquire hardware semaphore
- * @hw: pointer to the HW structure
- *
- * Acquire the HW semaphore to access the PHY or NVM
- */
-static s32 igc_get_hw_semaphore_i225(struct igc_hw *hw)
-{
-	u32 swsm;
-	s32 timeout = hw->nvm.word_size + 1;
-	s32 i = 0;
-
-	DEBUGFUNC("igc_get_hw_semaphore_i225");
-
-	/* Get the SW semaphore */
-	while (i < timeout) {
-		swsm = IGC_READ_REG(hw, IGC_SWSM);
-		if (!(swsm & IGC_SWSM_SMBI))
-			break;
-
-		usec_delay(50);
-		i++;
-	}
-
-	if (i == timeout) {
-		/* In rare circumstances, the SW semaphore may already be held
-		 * unintentionally. Clear the semaphore once before giving up.
-		 */
-		if (hw->dev_spec._i225.clear_semaphore_once) {
-			hw->dev_spec._i225.clear_semaphore_once = false;
-			igc_put_hw_semaphore_generic(hw);
-			for (i = 0; i < timeout; i++) {
-				swsm = IGC_READ_REG(hw, IGC_SWSM);
-				if (!(swsm & IGC_SWSM_SMBI))
-					break;
-
-				usec_delay(50);
-			}
-		}
-
-		/* If we do not have the semaphore here, we have to give up. */
-		if (i == timeout) {
-			DEBUGOUT("Driver can't access device -\n");
-			DEBUGOUT("SMBI bit is set.\n");
-			return -IGC_ERR_NVM;
-		}
-	}
-
-	/* Get the FW semaphore. */
-	for (i = 0; i < timeout; i++) {
-		swsm = IGC_READ_REG(hw, IGC_SWSM);
-		IGC_WRITE_REG(hw, IGC_SWSM, swsm | IGC_SWSM_SWESMBI);
-
-		/* Semaphore acquired if bit latched */
-		if (IGC_READ_REG(hw, IGC_SWSM) & IGC_SWSM_SWESMBI)
-			break;
-
-		usec_delay(50);
-	}
-
-	if (i == timeout) {
-		/* Release semaphores */
-		igc_put_hw_semaphore_generic(hw);
-		DEBUGOUT("Driver can't access the NVM\n");
-		return -IGC_ERR_NVM;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/* igc_read_nvm_srrd_i225 - Reads Shadow Ram using EERD register
- * @hw: pointer to the HW structure
- * @offset: offset of word in the Shadow Ram to read
- * @words: number of words to read
- * @data: word read from the Shadow Ram
- *
- * Reads a 16 bit word from the Shadow Ram using the EERD register.
- * Uses necessary synchronization semaphores.
- */
-s32 igc_read_nvm_srrd_i225(struct igc_hw *hw, u16 offset, u16 words,
-			     u16 *data)
-{
-	s32 status = IGC_SUCCESS;
-	u16 i, count;
-
-	DEBUGFUNC("igc_read_nvm_srrd_i225");
-
-	/* We cannot hold synchronization semaphores for too long,
-	 * because of forceful takeover procedure. However it is more efficient
-	 * to read in bursts than synchronizing access for each word.
-	 */
-	for (i = 0; i < words; i += IGC_EERD_EEWR_MAX_COUNT) {
-		count = (words - i) / IGC_EERD_EEWR_MAX_COUNT > 0 ?
-			IGC_EERD_EEWR_MAX_COUNT : (words - i);
-		if (hw->nvm.ops.acquire(hw) == IGC_SUCCESS) {
-			status = igc_read_nvm_eerd(hw, offset, count,
-						     data + i);
-			hw->nvm.ops.release(hw);
-		} else {
-			status = IGC_ERR_SWFW_SYNC;
-		}
-
-		if (status != IGC_SUCCESS)
-			break;
-	}
-
-	return status;
-}
-
-/* igc_write_nvm_srwr_i225 - Write to Shadow RAM using EEWR
- * @hw: pointer to the HW structure
- * @offset: offset within the Shadow RAM to be written to
- * @words: number of words to write
- * @data: 16 bit word(s) to be written to the Shadow RAM
- *
- * Writes data to Shadow RAM at offset using EEWR register.
- *
- * If igc_update_nvm_checksum is not called after this function , the
- * data will not be committed to FLASH and also Shadow RAM will most likely
- * contain an invalid checksum.
- *
- * If error code is returned, data and Shadow RAM may be inconsistent - buffer
- * partially written.
- */
-s32 igc_write_nvm_srwr_i225(struct igc_hw *hw, u16 offset, u16 words,
-			      u16 *data)
-{
-	s32 status = IGC_SUCCESS;
-	u16 i, count;
-
-	DEBUGFUNC("igc_write_nvm_srwr_i225");
-
-	/* We cannot hold synchronization semaphores for too long,
-	 * because of forceful takeover procedure. However it is more efficient
-	 * to write in bursts than synchronizing access for each word.
-	 */
-	for (i = 0; i < words; i += IGC_EERD_EEWR_MAX_COUNT) {
-		count = (words - i) / IGC_EERD_EEWR_MAX_COUNT > 0 ?
-			IGC_EERD_EEWR_MAX_COUNT : (words - i);
-		if (hw->nvm.ops.acquire(hw) == IGC_SUCCESS) {
-			status = __igc_write_nvm_srwr(hw, offset, count,
-							data + i);
-			hw->nvm.ops.release(hw);
-		} else {
-			status = IGC_ERR_SWFW_SYNC;
-		}
-
-		if (status != IGC_SUCCESS)
-			break;
-	}
-
-	return status;
-}
-
-/* __igc_write_nvm_srwr - Write to Shadow Ram using EEWR
- * @hw: pointer to the HW structure
- * @offset: offset within the Shadow Ram to be written to
- * @words: number of words to write
- * @data: 16 bit word(s) to be written to the Shadow Ram
- *
- * Writes data to Shadow Ram at offset using EEWR register.
- *
- * If igc_update_nvm_checksum is not called after this function , the
- * Shadow Ram will most likely contain an invalid checksum.
- */
-static s32 __igc_write_nvm_srwr(struct igc_hw *hw, u16 offset, u16 words,
-				  u16 *data)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	u32 i, k, eewr = 0;
-	u32 attempts = 100000;
-	s32 ret_val = IGC_SUCCESS;
-
-	DEBUGFUNC("__igc_write_nvm_srwr");
-
-	/* A check for invalid values:  offset too large, too many words,
-	 * too many words for the offset, and not enough words.
-	 */
-	if (offset >= nvm->word_size || words > (nvm->word_size - offset) ||
-			words == 0) {
-		DEBUGOUT("nvm parameter(s) out of bounds\n");
-		ret_val = -IGC_ERR_NVM;
-		goto out;
-	}
-
-	for (i = 0; i < words; i++) {
-		eewr = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) |
-			(data[i] << IGC_NVM_RW_REG_DATA) |
-			IGC_NVM_RW_REG_START;
-
-		IGC_WRITE_REG(hw, IGC_SRWR, eewr);
-
-		for (k = 0; k < attempts; k++) {
-			if (IGC_NVM_RW_REG_DONE &
-			    IGC_READ_REG(hw, IGC_SRWR)) {
-				ret_val = IGC_SUCCESS;
-				break;
-			}
-			usec_delay(5);
-		}
-
-		if (ret_val != IGC_SUCCESS) {
-			DEBUGOUT("Shadow RAM write EEWR timed out\n");
-			break;
-		}
-	}
-
-out:
-	return ret_val;
-}
-
-/* igc_read_invm_version_i225 - Reads iNVM version and image type
- * @hw: pointer to the HW structure
- * @invm_ver: version structure for the version read
- *
- * Reads iNVM version and image type.
- */
-s32 igc_read_invm_version_i225(struct igc_hw *hw,
-				 struct igc_fw_version *invm_ver)
-{
-	u32 *record = NULL;
-	u32 *next_record = NULL;
-	u32 i = 0;
-	u32 invm_dword = 0;
-	u32 invm_blocks = IGC_INVM_SIZE - (IGC_INVM_ULT_BYTES_SIZE /
-					     IGC_INVM_RECORD_SIZE_IN_BYTES);
-	u32 buffer[IGC_INVM_SIZE];
-	s32 status = -IGC_ERR_INVM_VALUE_NOT_FOUND;
-	u16 version = 0;
-
-	DEBUGFUNC("igc_read_invm_version_i225");
-
-	/* Read iNVM memory */
-	for (i = 0; i < IGC_INVM_SIZE; i++) {
-		invm_dword = IGC_READ_REG(hw, IGC_INVM_DATA_REG(i));
-		buffer[i] = invm_dword;
-	}
-
-	/* Read version number */
-	for (i = 1; i < invm_blocks; i++) {
-		record = &buffer[invm_blocks - i];
-		next_record = &buffer[invm_blocks - i + 1];
-
-		/* Check if we have first version location used */
-		if (i == 1 && (*record & IGC_INVM_VER_FIELD_ONE) == 0) {
-			version = 0;
-			status = IGC_SUCCESS;
-			break;
-		}
-		/* Check if we have second version location used */
-		else if ((i == 1) &&
-			 ((*record & IGC_INVM_VER_FIELD_TWO) == 0)) {
-			version = (*record & IGC_INVM_VER_FIELD_ONE) >> 3;
-			status = IGC_SUCCESS;
-			break;
-		}
-		/* Check if we have odd version location
-		 * used and it is the last one used
-		 */
-		else if ((((*record & IGC_INVM_VER_FIELD_ONE) == 0) &&
-			  ((*record & 0x3) == 0)) || (((*record & 0x3) != 0) &&
-			   (i != 1))) {
-			version = (*next_record & IGC_INVM_VER_FIELD_TWO)
-				  >> 13;
-			status = IGC_SUCCESS;
-			break;
-		}
-		/* Check if we have even version location
-		 * used and it is the last one used
-		 */
-		else if (((*record & IGC_INVM_VER_FIELD_TWO) == 0) &&
-			 ((*record & 0x3) == 0)) {
-			version = (*record & IGC_INVM_VER_FIELD_ONE) >> 3;
-			status = IGC_SUCCESS;
-			break;
-		}
-	}
-
-	if (status == IGC_SUCCESS) {
-		invm_ver->invm_major = (version & IGC_INVM_MAJOR_MASK)
-					>> IGC_INVM_MAJOR_SHIFT;
-		invm_ver->invm_minor = version & IGC_INVM_MINOR_MASK;
-	}
-	/* Read Image Type */
-	for (i = 1; i < invm_blocks; i++) {
-		record = &buffer[invm_blocks - i];
-		next_record = &buffer[invm_blocks - i + 1];
-
-		/* Check if we have image type in first location used */
-		if (i == 1 && (*record & IGC_INVM_IMGTYPE_FIELD) == 0) {
-			invm_ver->invm_img_type = 0;
-			status = IGC_SUCCESS;
-			break;
-		}
-		/* Check if we have image type in first location used */
-		else if ((((*record & 0x3) == 0) &&
-			  ((*record & IGC_INVM_IMGTYPE_FIELD) == 0)) ||
-			    ((((*record & 0x3) != 0) && (i != 1)))) {
-			invm_ver->invm_img_type =
-				(*next_record & IGC_INVM_IMGTYPE_FIELD) >> 23;
-			status = IGC_SUCCESS;
-			break;
-		}
-	}
-	return status;
-}
-
-/* igc_validate_nvm_checksum_i225 - Validate EEPROM checksum
- * @hw: pointer to the HW structure
- *
- * Calculates the EEPROM checksum by reading/adding each word of the EEPROM
- * and then verifies that the sum of the EEPROM is equal to 0xBABA.
- */
-s32 igc_validate_nvm_checksum_i225(struct igc_hw *hw)
-{
-	s32 status = IGC_SUCCESS;
-	s32 (*read_op_ptr)(struct igc_hw *hw, u16 offset,
-			u16 count, u16 *data);
-
-	DEBUGFUNC("igc_validate_nvm_checksum_i225");
-
-	if (hw->nvm.ops.acquire(hw) == IGC_SUCCESS) {
-		/* Replace the read function with semaphore grabbing with
-		 * the one that skips this for a while.
-		 * We have semaphore taken already here.
-		 */
-		read_op_ptr = hw->nvm.ops.read;
-		hw->nvm.ops.read = igc_read_nvm_eerd;
-
-		status = igc_validate_nvm_checksum_generic(hw);
-
-		/* Revert original read operation. */
-		hw->nvm.ops.read = read_op_ptr;
-
-		hw->nvm.ops.release(hw);
-	} else {
-		status = IGC_ERR_SWFW_SYNC;
-	}
-
-	return status;
-}
-
-/* igc_update_nvm_checksum_i225 - Update EEPROM checksum
- * @hw: pointer to the HW structure
- *
- * Updates the EEPROM checksum by reading/adding each word of the EEPROM
- * up to the checksum.  Then calculates the EEPROM checksum and writes the
- * value to the EEPROM. Next commit EEPROM data onto the Flash.
- */
-s32 igc_update_nvm_checksum_i225(struct igc_hw *hw)
-{
-	s32 ret_val;
-	u16 checksum = 0;
-	u16 i, nvm_data;
-
-	DEBUGFUNC("igc_update_nvm_checksum_i225");
-
-	/* Read the first word from the EEPROM. If this times out or fails, do
-	 * not continue or we could be in for a very long wait while every
-	 * EEPROM read fails
-	 */
-	ret_val = igc_read_nvm_eerd(hw, 0, 1, &nvm_data);
-	if (ret_val != IGC_SUCCESS) {
-		DEBUGOUT("EEPROM read failed\n");
-		goto out;
-	}
-
-	if (hw->nvm.ops.acquire(hw) == IGC_SUCCESS) {
-		/* Do not use hw->nvm.ops.write, hw->nvm.ops.read
-		 * because we do not want to take the synchronization
-		 * semaphores twice here.
-		 */
-
-		for (i = 0; i < NVM_CHECKSUM_REG; i++) {
-			ret_val = igc_read_nvm_eerd(hw, i, 1, &nvm_data);
-			if (ret_val) {
-				hw->nvm.ops.release(hw);
-				DEBUGOUT("NVM Read Error while updating\n");
-				DEBUGOUT("checksum.\n");
-				goto out;
-			}
-			checksum += nvm_data;
-		}
-		checksum = (u16)NVM_SUM - checksum;
-		ret_val = __igc_write_nvm_srwr(hw, NVM_CHECKSUM_REG, 1,
-						 &checksum);
-		if (ret_val != IGC_SUCCESS) {
-			hw->nvm.ops.release(hw);
-			DEBUGOUT("NVM Write Error while updating checksum.\n");
-			goto out;
-		}
-
-		hw->nvm.ops.release(hw);
-
-		ret_val = igc_update_flash_i225(hw);
-	} else {
-		ret_val = IGC_ERR_SWFW_SYNC;
-	}
-out:
-	return ret_val;
-}
-
-/* igc_get_flash_presence_i225 - Check if flash device is detected.
- * @hw: pointer to the HW structure
- */
-bool igc_get_flash_presence_i225(struct igc_hw *hw)
-{
-	u32 eec = 0;
-	bool ret_val = false;
-
-	DEBUGFUNC("igc_get_flash_presence_i225");
-
-	eec = IGC_READ_REG(hw, IGC_EECD);
-
-	if (eec & IGC_EECD_FLASH_DETECTED_I225)
-		ret_val = true;
-
-	return ret_val;
-}
-
-/* igc_set_flsw_flash_burst_counter_i225 - sets FLSW NVM Burst
- * Counter in FLSWCNT register.
- *
- * @hw: pointer to the HW structure
- * @burst_counter: size in bytes of the Flash burst to read or write
- */
-s32 igc_set_flsw_flash_burst_counter_i225(struct igc_hw *hw,
-					    u32 burst_counter)
-{
-	s32 ret_val = IGC_SUCCESS;
-
-	DEBUGFUNC("igc_set_flsw_flash_burst_counter_i225");
-
-	/* Validate input data */
-	if (burst_counter < IGC_I225_SHADOW_RAM_SIZE) {
-		/* Write FLSWCNT - burst counter */
-		IGC_WRITE_REG(hw, IGC_I225_FLSWCNT, burst_counter);
-	} else {
-		ret_val = IGC_ERR_INVALID_ARGUMENT;
-	}
-
-	return ret_val;
-}
-
-/* igc_write_erase_flash_command_i225 - write/erase to a sector
- * region on a given address.
- *
- * @hw: pointer to the HW structure
- * @opcode: opcode to be used for the write command
- * @address: the offset to write into the FLASH image
- */
-s32 igc_write_erase_flash_command_i225(struct igc_hw *hw, u32 opcode,
-					 u32 address)
-{
-	u32 flswctl = 0;
-	s32 timeout = IGC_NVM_GRANT_ATTEMPTS;
-	s32 ret_val = IGC_SUCCESS;
-
-	DEBUGFUNC("igc_write_erase_flash_command_i225");
-
-	flswctl = IGC_READ_REG(hw, IGC_I225_FLSWCTL);
-	/* Polling done bit on FLSWCTL register */
-	while (timeout) {
-		if (flswctl & IGC_FLSWCTL_DONE)
-			break;
-		usec_delay(5);
-		flswctl = IGC_READ_REG(hw, IGC_I225_FLSWCTL);
-		timeout--;
-	}
-
-	if (!timeout) {
-		DEBUGOUT("Flash transaction was not done\n");
-		return -IGC_ERR_NVM;
-	}
-
-	/* Build and issue command on FLSWCTL register */
-	flswctl = address | opcode;
-	IGC_WRITE_REG(hw, IGC_I225_FLSWCTL, flswctl);
-
-	/* Check if issued command is valid on FLSWCTL register */
-	flswctl = IGC_READ_REG(hw, IGC_I225_FLSWCTL);
-	if (!(flswctl & IGC_FLSWCTL_CMDV)) {
-		DEBUGOUT("Write flash command failed\n");
-		ret_val = IGC_ERR_INVALID_ARGUMENT;
-	}
-
-	return ret_val;
-}
-
-/* igc_update_flash_i225 - Commit EEPROM to the flash
- * if fw_valid_bit is set, FW is active. setting FLUPD bit in EEC
- * register makes the FW load the internal shadow RAM into the flash.
- * Otherwise, fw_valid_bit is 0. if FL_SECU.block_prtotected_sw = 0
- * then FW is not active so the SW is responsible shadow RAM dump.
- *
- * @hw: pointer to the HW structure
- */
-s32 igc_update_flash_i225(struct igc_hw *hw)
-{
-	u16 current_offset_data = 0;
-	u32 block_sw_protect = 1;
-	u16 base_address = 0x0;
-	u32 i, fw_valid_bit;
-	u16 current_offset;
-	s32 ret_val = 0;
-	u32 flup;
-
-	DEBUGFUNC("igc_update_flash_i225");
-
-	block_sw_protect = IGC_READ_REG(hw, IGC_I225_FLSECU) &
-					  IGC_FLSECU_BLK_SW_ACCESS_I225;
-	fw_valid_bit = IGC_READ_REG(hw, IGC_FWSM) &
-				      IGC_FWSM_FW_VALID_I225;
-	if (fw_valid_bit) {
-		ret_val = igc_pool_flash_update_done_i225(hw);
-		if (ret_val == -IGC_ERR_NVM) {
-			DEBUGOUT("Flash update time out\n");
-			goto out;
-		}
-
-		flup = IGC_READ_REG(hw, IGC_EECD) | IGC_EECD_FLUPD_I225;
-		IGC_WRITE_REG(hw, IGC_EECD, flup);
-
-		ret_val = igc_pool_flash_update_done_i225(hw);
-		if (ret_val == IGC_SUCCESS)
-			DEBUGOUT("Flash update complete\n");
-		else
-			DEBUGOUT("Flash update time out\n");
-	} else if (!block_sw_protect) {
-		/* FW is not active and security protection is disabled.
-		 * therefore, SW is in charge of shadow RAM dump.
-		 * Check which sector is valid. if sector 0 is valid,
-		 * base address remains 0x0. otherwise, sector 1 is
-		 * valid and it's base address is 0x1000
-		 */
-		if (IGC_READ_REG(hw, IGC_EECD) & IGC_EECD_SEC1VAL_I225)
-			base_address = 0x1000;
-
-		/* Valid sector erase */
-		ret_val = igc_write_erase_flash_command_i225(hw,
-						  IGC_I225_ERASE_CMD_OPCODE,
-						  base_address);
-		if (!ret_val) {
-			DEBUGOUT("Sector erase failed\n");
-			goto out;
-		}
-
-		current_offset = base_address;
-
-		/* Write */
-		for (i = 0; i < IGC_I225_SHADOW_RAM_SIZE / 2; i++) {
-			/* Set burst write length */
-			ret_val = igc_set_flsw_flash_burst_counter_i225(hw,
-									  0x2);
-			if (ret_val != IGC_SUCCESS)
-				break;
-
-			/* Set address and opcode */
-			ret_val = igc_write_erase_flash_command_i225(hw,
-						IGC_I225_WRITE_CMD_OPCODE,
-						2 * current_offset);
-			if (ret_val != IGC_SUCCESS)
-				break;
-
-			ret_val = igc_read_nvm_eerd(hw, current_offset,
-						      1, &current_offset_data);
-			if (ret_val) {
-				DEBUGOUT("Failed to read from EEPROM\n");
-				goto out;
-			}
-
-			/* Write CurrentOffseData to FLSWDATA register */
-			IGC_WRITE_REG(hw, IGC_I225_FLSWDATA,
-					current_offset_data);
-			current_offset++;
-
-			/* Wait till operation has finished */
-			ret_val = igc_poll_eerd_eewr_done(hw,
-						IGC_NVM_POLL_READ);
-			if (ret_val)
-				break;
-
-			usec_delay(1000);
-		}
-	}
-out:
-	return ret_val;
-}
-
-/* igc_pool_flash_update_done_i225 - Pool FLUDONE status.
- * @hw: pointer to the HW structure
- */
-s32 igc_pool_flash_update_done_i225(struct igc_hw *hw)
-{
-	s32 ret_val = -IGC_ERR_NVM;
-	u32 i, reg;
-
-	DEBUGFUNC("igc_pool_flash_update_done_i225");
-
-	for (i = 0; i < IGC_FLUDONE_ATTEMPTS; i++) {
-		reg = IGC_READ_REG(hw, IGC_EECD);
-		if (reg & IGC_EECD_FLUDONE_I225) {
-			ret_val = IGC_SUCCESS;
-			break;
-		}
-		usec_delay(5);
-	}
-
-	return ret_val;
-}
-
-/* igc_set_ltr_i225 - Set Latency Tolerance Reporting thresholds.
- * @hw: pointer to the HW structure
- * @link: bool indicating link status
- *
- * Set the LTR thresholds based on the link speed (Mbps), EEE, and DMAC
- * settings, otherwise specify that there is no LTR requirement.
- */
-static s32 igc_set_ltr_i225(struct igc_hw *hw, bool link)
-{
-	u16 speed, duplex;
-	u32 tw_system, ltrc, ltrv, ltr_min, ltr_max, scale_min, scale_max;
-	s32 size;
-
-	DEBUGFUNC("igc_set_ltr_i225");
-
-	/* If we do not have link, LTR thresholds are zero. */
-	if (link) {
-		hw->mac.ops.get_link_up_info(hw, &speed, &duplex);
-
-		/* Check if using copper interface with EEE enabled or if the
-		 * link speed is 10 Mbps.
-		 */
-		if (hw->phy.media_type == igc_media_type_copper &&
-				!hw->dev_spec._i225.eee_disable &&
-				speed != SPEED_10) {
-			/* EEE enabled, so send LTRMAX threshold. */
-			ltrc = IGC_READ_REG(hw, IGC_LTRC) |
-				IGC_LTRC_EEEMS_EN;
-			IGC_WRITE_REG(hw, IGC_LTRC, ltrc);
-
-			/* Calculate tw_system (nsec). */
-			if (speed == SPEED_100)
-				tw_system = ((IGC_READ_REG(hw, IGC_EEE_SU) &
-					IGC_TW_SYSTEM_100_MASK) >>
-					IGC_TW_SYSTEM_100_SHIFT) * 500;
-			else
-				tw_system = (IGC_READ_REG(hw, IGC_EEE_SU) &
-					IGC_TW_SYSTEM_1000_MASK) * 500;
-		} else {
-			tw_system = 0;
-		}
-
-		/* Get the Rx packet buffer size. */
-		size = IGC_READ_REG(hw, IGC_RXPBS) &
-			IGC_RXPBS_SIZE_I225_MASK;
-
-		/* Calculations vary based on DMAC settings. */
-		if (IGC_READ_REG(hw, IGC_DMACR) & IGC_DMACR_DMAC_EN) {
-			size -= (IGC_READ_REG(hw, IGC_DMACR) &
-				 IGC_DMACR_DMACTHR_MASK) >>
-				 IGC_DMACR_DMACTHR_SHIFT;
-			/* Convert size to bits. */
-			size *= 1024 * 8;
-		} else {
-			/* Convert size to bytes, subtract the MTU, and then
-			 * convert the size to bits.
-			 */
-			size *= 1024;
-			size -= hw->dev_spec._i225.mtu;
-			size *= 8;
-		}
-
-		if (size < 0) {
-			DEBUGOUT1("Invalid effective Rx buffer size %d\n",
-				  size);
-			return -IGC_ERR_CONFIG;
-		}
-
-		/* Calculate the thresholds. Since speed is in Mbps, simplify
-		 * the calculation by multiplying size/speed by 1000 for result
-		 * to be in nsec before dividing by the scale in nsec. Set the
-		 * scale such that the LTR threshold fits in the register.
-		 */
-		ltr_min = (1000 * size) / speed;
-		ltr_max = ltr_min + tw_system;
-		scale_min = (ltr_min / 1024) < 1024 ? IGC_LTRMINV_SCALE_1024 :
-			    IGC_LTRMINV_SCALE_32768;
-		scale_max = (ltr_max / 1024) < 1024 ? IGC_LTRMAXV_SCALE_1024 :
-			    IGC_LTRMAXV_SCALE_32768;
-		ltr_min /= scale_min == IGC_LTRMINV_SCALE_1024 ? 1024 : 32768;
-		ltr_max /= scale_max == IGC_LTRMAXV_SCALE_1024 ? 1024 : 32768;
-
-		/* Only write the LTR thresholds if they differ from before. */
-		ltrv = IGC_READ_REG(hw, IGC_LTRMINV);
-		if (ltr_min != (ltrv & IGC_LTRMINV_LTRV_MASK)) {
-			ltrv = IGC_LTRMINV_LSNP_REQ | ltr_min |
-			      (scale_min << IGC_LTRMINV_SCALE_SHIFT);
-			IGC_WRITE_REG(hw, IGC_LTRMINV, ltrv);
-		}
-
-		ltrv = IGC_READ_REG(hw, IGC_LTRMAXV);
-		if (ltr_max != (ltrv & IGC_LTRMAXV_LTRV_MASK)) {
-			ltrv = IGC_LTRMAXV_LSNP_REQ | ltr_max |
-			      (scale_min << IGC_LTRMAXV_SCALE_SHIFT);
-			IGC_WRITE_REG(hw, IGC_LTRMAXV, ltrv);
-		}
-	}
-
-	return IGC_SUCCESS;
-}
-
-/* igc_check_for_link_i225 - Check for link
- * @hw: pointer to the HW structure
- *
- * Checks to see of the link status of the hardware has changed.  If a
- * change in link status has been detected, then we read the PHY registers
- * to get the current speed/duplex if link exists.
- */
-s32 igc_check_for_link_i225(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	s32 ret_val;
-	bool link = false;
-
-	DEBUGFUNC("igc_check_for_link_i225");
-
-	/* We only want to go out to the PHY registers to see if
-	 * Auto-Neg has completed and/or if our link status has
-	 * changed.  The get_link_status flag is set upon receiving
-	 * a Link Status Change or Rx Sequence Error interrupt.
-	 */
-	if (!mac->get_link_status) {
-		ret_val = IGC_SUCCESS;
-		goto out;
-	}
-
-	/* First we want to see if the MII Status Register reports
-	 * link.  If so, then we want to get the current speed/duplex
-	 * of the PHY.
-	 */
-	ret_val = igc_phy_has_link_generic(hw, 1, 0, &link);
-	if (ret_val)
-		goto out;
-
-	if (!link)
-		goto out; /* No link detected */
-
-	mac->get_link_status = false;
-
-	/* Check if there was DownShift, must be checked
-	 * immediately after link-up
-	 */
-	igc_check_downshift_generic(hw);
-
-	/* If we are forcing speed/duplex, then we simply return since
-	 * we have already determined whether we have link or not.
-	 */
-	if (!mac->autoneg)
-		goto out;
-
-	/* Auto-Neg is enabled.  Auto Speed Detection takes care
-	 * of MAC speed/duplex configuration.  So we only need to
-	 * configure Collision Distance in the MAC.
-	 */
-	mac->ops.config_collision_dist(hw);
-
-	/* Configure Flow Control now that Auto-Neg has completed.
-	 * First, we need to restore the desired flow control
-	 * settings because we may have had to re-autoneg with a
-	 * different link partner.
-	 */
-	ret_val = igc_config_fc_after_link_up_generic(hw);
-	if (ret_val)
-		DEBUGOUT("Error configuring flow control\n");
-out:
-	/* Now that we are aware of our link settings, we can set the LTR
-	 * thresholds.
-	 */
-	ret_val = igc_set_ltr_i225(hw, link);
-
-	return ret_val;
-}
-
-/* igc_init_function_pointers_i225 - Init func ptrs.
- * @hw: pointer to the HW structure
- *
- * Called to initialize all function pointers and parameters.
- */
-void igc_init_function_pointers_i225(struct igc_hw *hw)
-{
-	igc_init_mac_ops_generic(hw);
-	igc_init_phy_ops_generic(hw);
-	igc_init_nvm_ops_generic(hw);
-	hw->mac.ops.init_params = igc_init_mac_params_i225;
-	hw->nvm.ops.init_params = igc_init_nvm_params_i225;
-	hw->phy.ops.init_params = igc_init_phy_params_i225;
-}
-
-/* igc_valid_led_default_i225 - Verify a valid default LED config
- * @hw: pointer to the HW structure
- * @data: pointer to the NVM (EEPROM)
- *
- * Read the EEPROM for the current default LED configuration.  If the
- * LED configuration is not valid, set to a valid LED configuration.
- */
-static s32 igc_valid_led_default_i225(struct igc_hw *hw, u16 *data)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("igc_valid_led_default_i225");
-
-	ret_val = hw->nvm.ops.read(hw, NVM_ID_LED_SETTINGS, 1, data);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		goto out;
-	}
-
-	if (*data == ID_LED_RESERVED_0000 || *data == ID_LED_RESERVED_FFFF) {
-		switch (hw->phy.media_type) {
-		case igc_media_type_internal_serdes:
-			*data = ID_LED_DEFAULT_I225_SERDES;
-			break;
-		case igc_media_type_copper:
-		default:
-			*data = ID_LED_DEFAULT_I225;
-			break;
-		}
-	}
-out:
-	return ret_val;
-}
-
-/* igc_get_cfg_done_i225 - Read config done bit
- * @hw: pointer to the HW structure
- *
- * Read the management control register for the config done bit for
- * completion status.  NOTE: silicon which is EEPROM-less will fail trying
- * to read the config done bit, so an error is *ONLY* logged and returns
- * IGC_SUCCESS.  If we were to return with error, EEPROM-less silicon
- * would not be able to be reset or change link.
- */
-static s32 igc_get_cfg_done_i225(struct igc_hw *hw)
-{
-	s32 timeout = PHY_CFG_TIMEOUT;
-	u32 mask = IGC_NVM_CFG_DONE_PORT_0;
-
-	DEBUGFUNC("igc_get_cfg_done_i225");
-
-	while (timeout) {
-		if (IGC_READ_REG(hw, IGC_EEMNGCTL_I225) & mask)
-			break;
-		msec_delay(1);
-		timeout--;
-	}
-	if (!timeout)
-		DEBUGOUT("MNG configuration cycle has not completed.\n");
-
-	return IGC_SUCCESS;
-}
-
-/* igc_init_hw_i225 - Init hw for I225
- * @hw: pointer to the HW structure
- *
- * Called to initialize hw for i225 hw family.
- */
-s32 igc_init_hw_i225(struct igc_hw *hw)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("igc_init_hw_i225");
-
-	hw->phy.ops.get_cfg_done = igc_get_cfg_done_i225;
-	ret_val = igc_init_hw_base(hw);
-	igc_set_eee_i225(hw, false, false, false);
-	return ret_val;
-}
-
-/*
- * igc_set_d0_lplu_state_i225 - Set Low-Power-Link-Up (LPLU) D0 state
- * @hw: pointer to the HW structure
- * @active: true to enable LPLU, false to disable
- *
- * Note: since I225 does not actually support LPLU, this function
- * simply enables/disables 1G and 2.5G speeds in D0.
- */
-s32 igc_set_d0_lplu_state_i225(struct igc_hw *hw, bool active)
-{
-	u32 data;
-
-	DEBUGFUNC("igc_set_d0_lplu_state_i225");
-
-	data = IGC_READ_REG(hw, IGC_I225_PHPM);
-
-	if (active) {
-		data |= IGC_I225_PHPM_DIS_1000;
-		data |= IGC_I225_PHPM_DIS_2500;
-	} else {
-		data &= ~IGC_I225_PHPM_DIS_1000;
-		data &= ~IGC_I225_PHPM_DIS_2500;
-	}
-
-	IGC_WRITE_REG(hw, IGC_I225_PHPM, data);
-	return IGC_SUCCESS;
-}
-
-/*
- * igc_set_d3_lplu_state_i225 - Set Low-Power-Link-Up (LPLU) D3 state
- * @hw: pointer to the HW structure
- * @active: true to enable LPLU, false to disable
- *
- * Note: since I225 does not actually support LPLU, this function
- * simply enables/disables 100M, 1G and 2.5G speeds in D3.
- */
-s32 igc_set_d3_lplu_state_i225(struct igc_hw *hw, bool active)
-{
-	u32 data;
-
-	DEBUGFUNC("igc_set_d3_lplu_state_i225");
-
-	data = IGC_READ_REG(hw, IGC_I225_PHPM);
-
-	if (active) {
-		data |= IGC_I225_PHPM_DIS_100_D3;
-		data |= IGC_I225_PHPM_DIS_1000_D3;
-		data |= IGC_I225_PHPM_DIS_2500_D3;
-	} else {
-		data &= ~IGC_I225_PHPM_DIS_100_D3;
-		data &= ~IGC_I225_PHPM_DIS_1000_D3;
-		data &= ~IGC_I225_PHPM_DIS_2500_D3;
-	}
-
-	IGC_WRITE_REG(hw, IGC_I225_PHPM, data);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_set_eee_i225 - Enable/disable EEE support
- *  @hw: pointer to the HW structure
- *  @adv2p5G: boolean flag enabling 2.5G EEE advertisement
- *  @adv1G: boolean flag enabling 1G EEE advertisement
- *  @adv100M: boolean flag enabling 100M EEE advertisement
- *
- *  Enable/disable EEE based on setting in dev_spec structure.
- *
- **/
-s32 igc_set_eee_i225(struct igc_hw *hw, bool adv2p5G, bool adv1G,
-		       bool adv100M)
-{
-	u32 ipcnfg, eeer;
-
-	DEBUGFUNC("igc_set_eee_i225");
-
-	if (hw->mac.type != igc_i225 ||
-	    hw->phy.media_type != igc_media_type_copper)
-		goto out;
-	ipcnfg = IGC_READ_REG(hw, IGC_IPCNFG);
-	eeer = IGC_READ_REG(hw, IGC_EEER);
-
-	/* enable or disable per user setting */
-	if (!(hw->dev_spec._i225.eee_disable)) {
-		u32 eee_su = IGC_READ_REG(hw, IGC_EEE_SU);
-
-		if (adv100M)
-			ipcnfg |= IGC_IPCNFG_EEE_100M_AN;
-		else
-			ipcnfg &= ~IGC_IPCNFG_EEE_100M_AN;
-
-		if (adv1G)
-			ipcnfg |= IGC_IPCNFG_EEE_1G_AN;
-		else
-			ipcnfg &= ~IGC_IPCNFG_EEE_1G_AN;
-
-		if (adv2p5G)
-			ipcnfg |= IGC_IPCNFG_EEE_2_5G_AN;
-		else
-			ipcnfg &= ~IGC_IPCNFG_EEE_2_5G_AN;
-
-		eeer |= (IGC_EEER_TX_LPI_EN | IGC_EEER_RX_LPI_EN |
-			IGC_EEER_LPI_FC);
-
-		/* This bit should not be set in normal operation. */
-		if (eee_su & IGC_EEE_SU_LPI_CLK_STP)
-			DEBUGOUT("LPI Clock Stop Bit should not be set!\n");
-	} else {
-		ipcnfg &= ~(IGC_IPCNFG_EEE_2_5G_AN | IGC_IPCNFG_EEE_1G_AN |
-			IGC_IPCNFG_EEE_100M_AN);
-		eeer &= ~(IGC_EEER_TX_LPI_EN | IGC_EEER_RX_LPI_EN |
-			IGC_EEER_LPI_FC);
-	}
-	IGC_WRITE_REG(hw, IGC_IPCNFG, ipcnfg);
-	IGC_WRITE_REG(hw, IGC_EEER, eeer);
-	IGC_READ_REG(hw, IGC_IPCNFG);
-	IGC_READ_REG(hw, IGC_EEER);
-out:
-
-	return IGC_SUCCESS;
-}
diff --git a/drivers/net/intel/igc/base/igc_i225.h b/drivers/net/intel/igc/base/igc_i225.h
deleted file mode 100644
index c61ece0e82..0000000000
--- a/drivers/net/intel/igc/base/igc_i225.h
+++ /dev/null
@@ -1,110 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_I225_H_
-#define _IGC_I225_H_
-
-bool igc_get_flash_presence_i225(struct igc_hw *hw);
-s32 igc_update_flash_i225(struct igc_hw *hw);
-s32 igc_update_nvm_checksum_i225(struct igc_hw *hw);
-s32 igc_validate_nvm_checksum_i225(struct igc_hw *hw);
-s32 igc_write_nvm_srwr_i225(struct igc_hw *hw, u16 offset,
-			      u16 words, u16 *data);
-s32 igc_read_nvm_srrd_i225(struct igc_hw *hw, u16 offset,
-			     u16 words, u16 *data);
-s32 igc_read_invm_version_i225(struct igc_hw *hw,
-				 struct igc_fw_version *invm_ver);
-s32 igc_set_flsw_flash_burst_counter_i225(struct igc_hw *hw,
-					    u32 burst_counter);
-s32 igc_write_erase_flash_command_i225(struct igc_hw *hw, u32 opcode,
-					 u32 address);
-s32 igc_check_for_link_i225(struct igc_hw *hw);
-s32 igc_acquire_swfw_sync_i225(struct igc_hw *hw, u16 mask);
-void igc_release_swfw_sync_i225(struct igc_hw *hw, u16 mask);
-s32 igc_init_hw_i225(struct igc_hw *hw);
-s32 igc_setup_copper_link_i225(struct igc_hw *hw);
-s32 igc_set_d0_lplu_state_i225(struct igc_hw *hw, bool active);
-s32 igc_set_d3_lplu_state_i225(struct igc_hw *hw, bool active);
-s32 igc_set_eee_i225(struct igc_hw *hw, bool adv2p5G, bool adv1G,
-		       bool adv100M);
-
-#define ID_LED_DEFAULT_I225		((ID_LED_OFF1_ON2  << 8) | \
-					 (ID_LED_DEF1_DEF2 <<  4) | \
-					 (ID_LED_OFF1_OFF2))
-#define ID_LED_DEFAULT_I225_SERDES	((ID_LED_DEF1_DEF2 << 8) | \
-					 (ID_LED_DEF1_DEF2 <<  4) | \
-					 (ID_LED_OFF1_ON2))
-
-/* NVM offset defaults for I225 devices */
-#define NVM_INIT_CTRL_2_DEFAULT_I225	0X7243
-#define NVM_INIT_CTRL_4_DEFAULT_I225	0x00C1
-#define NVM_LED_1_CFG_DEFAULT_I225	0x0184
-#define NVM_LED_0_2_CFG_DEFAULT_I225	0x200C
-
-#define IGC_MRQC_ENABLE_RSS_4Q		0x00000002
-#define IGC_MRQC_ENABLE_VMDQ			0x00000003
-#define IGC_MRQC_ENABLE_VMDQ_RSS_2Q		0x00000005
-#define IGC_MRQC_RSS_FIELD_IPV4_UDP		0x00400000
-#define IGC_MRQC_RSS_FIELD_IPV6_UDP		0x00800000
-#define IGC_MRQC_RSS_FIELD_IPV6_UDP_EX	0x01000000
-#define IGC_I225_SHADOW_RAM_SIZE		4096
-#define IGC_I225_ERASE_CMD_OPCODE		0x02000000
-#define IGC_I225_WRITE_CMD_OPCODE		0x01000000
-#define IGC_FLSWCTL_DONE			0x40000000
-#define IGC_FLSWCTL_CMDV			0x10000000
-
-/* SRRCTL bit definitions */
-#define IGC_SRRCTL_BSIZEHDRSIZE_MASK		0x00000F00
-#define IGC_SRRCTL_DESCTYPE_LEGACY		0x00000000
-#define IGC_SRRCTL_DESCTYPE_HDR_SPLIT		0x04000000
-#define IGC_SRRCTL_DESCTYPE_HDR_SPLIT_ALWAYS	0x0A000000
-#define IGC_SRRCTL_DESCTYPE_HDR_REPLICATION	0x06000000
-#define IGC_SRRCTL_DESCTYPE_HDR_REPLICATION_LARGE_PKT 0x08000000
-#define IGC_SRRCTL_DESCTYPE_MASK		0x0E000000
-#define IGC_SRRCTL_DROP_EN			0x80000000
-#define IGC_SRRCTL_BSIZEPKT_MASK		0x0000007F
-#define IGC_SRRCTL_BSIZEHDR_MASK		0x00003F00
-
-#define IGC_RXDADV_RSSTYPE_MASK	0x0000000F
-#define IGC_RXDADV_RSSTYPE_SHIFT	12
-#define IGC_RXDADV_HDRBUFLEN_MASK	0x7FE0
-#define IGC_RXDADV_HDRBUFLEN_SHIFT	5
-#define IGC_RXDADV_SPLITHEADER_EN	0x00001000
-#define IGC_RXDADV_SPH		0x8000
-#define IGC_RXDADV_STAT_TS		0x10000 /* Pkt was time stamped */
-#define IGC_RXDADV_ERR_HBO		0x00800000
-
-/* RSS Hash results */
-#define IGC_RXDADV_RSSTYPE_NONE	0x00000000
-#define IGC_RXDADV_RSSTYPE_IPV4_TCP	0x00000001
-#define IGC_RXDADV_RSSTYPE_IPV4	0x00000002
-#define IGC_RXDADV_RSSTYPE_IPV6_TCP	0x00000003
-#define IGC_RXDADV_RSSTYPE_IPV6_EX	0x00000004
-#define IGC_RXDADV_RSSTYPE_IPV6	0x00000005
-#define IGC_RXDADV_RSSTYPE_IPV6_TCP_EX 0x00000006
-#define IGC_RXDADV_RSSTYPE_IPV4_UDP	0x00000007
-#define IGC_RXDADV_RSSTYPE_IPV6_UDP	0x00000008
-#define IGC_RXDADV_RSSTYPE_IPV6_UDP_EX 0x00000009
-
-/* RSS Packet Types as indicated in the receive descriptor */
-#define IGC_RXDADV_PKTTYPE_ILMASK	0x000000F0
-#define IGC_RXDADV_PKTTYPE_TLMASK	0x00000F00
-#define IGC_RXDADV_PKTTYPE_NONE	0x00000000
-#define IGC_RXDADV_PKTTYPE_IPV4	0x00000010 /* IPV4 hdr present */
-#define IGC_RXDADV_PKTTYPE_IPV4_EX	0x00000020 /* IPV4 hdr + extensions */
-#define IGC_RXDADV_PKTTYPE_IPV6	0x00000040 /* IPV6 hdr present */
-#define IGC_RXDADV_PKTTYPE_IPV6_EX	0x00000080 /* IPV6 hdr + extensions */
-#define IGC_RXDADV_PKTTYPE_TCP	0x00000100 /* TCP hdr present */
-#define IGC_RXDADV_PKTTYPE_UDP	0x00000200 /* UDP hdr present */
-#define IGC_RXDADV_PKTTYPE_SCTP	0x00000400 /* SCTP hdr present */
-#define IGC_RXDADV_PKTTYPE_NFS	0x00000800 /* NFS hdr present */
-
-#define IGC_RXDADV_PKTTYPE_IPSEC_ESP	0x00001000 /* IPSec ESP */
-#define IGC_RXDADV_PKTTYPE_IPSEC_AH	0x00002000 /* IPSec AH */
-#define IGC_RXDADV_PKTTYPE_LINKSEC	0x00004000 /* LinkSec Encap */
-#define IGC_RXDADV_PKTTYPE_ETQF	0x00008000 /* PKTTYPE is ETQF index */
-#define IGC_RXDADV_PKTTYPE_ETQF_MASK	0x00000070 /* ETQF has 8 indices */
-#define IGC_RXDADV_PKTTYPE_ETQF_SHIFT	4 /* Right-shift 4 bits */
-
-#endif
diff --git a/drivers/net/intel/igc/base/igc_ich8lan.h b/drivers/net/intel/igc/base/igc_ich8lan.h
deleted file mode 100644
index ff32fc687c..0000000000
--- a/drivers/net/intel/igc/base/igc_ich8lan.h
+++ /dev/null
@@ -1,296 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_ICH8LAN_H_
-#define _IGC_ICH8LAN_H_
-
-#define ICH_FLASH_GFPREG		0x0000
-#define ICH_FLASH_HSFSTS		0x0004
-#define ICH_FLASH_HSFCTL		0x0006
-#define ICH_FLASH_FADDR			0x0008
-#define ICH_FLASH_FDATA0		0x0010
-
-/* Requires up to 10 seconds when MNG might be accessing part. */
-#define ICH_FLASH_READ_COMMAND_TIMEOUT	10000000
-#define ICH_FLASH_WRITE_COMMAND_TIMEOUT	10000000
-#define ICH_FLASH_ERASE_COMMAND_TIMEOUT	10000000
-#define ICH_FLASH_LINEAR_ADDR_MASK	0x00FFFFFF
-#define ICH_FLASH_CYCLE_REPEAT_COUNT	10
-
-#define ICH_CYCLE_READ			0
-#define ICH_CYCLE_WRITE			2
-#define ICH_CYCLE_ERASE			3
-
-#define FLASH_GFPREG_BASE_MASK		0x1FFF
-#define FLASH_SECTOR_ADDR_SHIFT		12
-
-#define ICH_FLASH_SEG_SIZE_256		256
-#define ICH_FLASH_SEG_SIZE_4K		4096
-#define ICH_FLASH_SEG_SIZE_8K		8192
-#define ICH_FLASH_SEG_SIZE_64K		65536
-
-#define IGC_ICH_FWSM_RSPCIPHY	0x00000040 /* Reset PHY on PCI Reset */
-/* FW established a valid mode */
-#define IGC_ICH_FWSM_FW_VALID	0x00008000
-#define IGC_ICH_FWSM_PCIM2PCI	0x01000000 /* ME PCIm-to-PCI active */
-#define IGC_ICH_FWSM_PCIM2PCI_COUNT	2000
-
-#define IGC_ICH_MNG_IAMT_MODE		0x2
-
-#define IGC_FWSM_WLOCK_MAC_MASK	0x0380
-#define IGC_FWSM_WLOCK_MAC_SHIFT	7
-#define IGC_FWSM_ULP_CFG_DONE		0x00000400  /* Low power cfg done */
-
-/* Shared Receive Address Registers */
-#define IGC_SHRAL_PCH_LPT(_i)		(0x05408 + ((_i) * 8))
-#define IGC_SHRAH_PCH_LPT(_i)		(0x0540C + ((_i) * 8))
-
-#define IGC_H2ME		0x05B50    /* Host to ME */
-#define IGC_H2ME_ULP		0x00000800 /* ULP Indication Bit */
-#define IGC_H2ME_ENFORCE_SETTINGS	0x00001000 /* Enforce Settings */
-
-#define ID_LED_DEFAULT_ICH8LAN	((ID_LED_DEF1_DEF2 << 12) | \
-				 (ID_LED_OFF1_OFF2 <<  8) | \
-				 (ID_LED_OFF1_ON2  <<  4) | \
-				 (ID_LED_DEF1_DEF2))
-
-#define IGC_ICH_NVM_SIG_WORD		0x13
-#define IGC_ICH_NVM_SIG_MASK		0xC000
-#define IGC_ICH_NVM_VALID_SIG_MASK	0xC0
-#define IGC_ICH_NVM_SIG_VALUE		0x80
-
-#define IGC_ICH8_LAN_INIT_TIMEOUT	1500
-
-/* FEXT register bit definition */
-#define IGC_FEXT_PHY_CABLE_DISCONNECTED	0x00000004
-
-#define IGC_FEXTNVM_SW_CONFIG		1
-#define IGC_FEXTNVM_SW_CONFIG_ICH8M	(1 << 27) /* different on ICH8M */
-
-#define IGC_FEXTNVM3_PHY_CFG_COUNTER_MASK	0x0C000000
-#define IGC_FEXTNVM3_PHY_CFG_COUNTER_50MSEC	0x08000000
-
-#define IGC_FEXTNVM4_BEACON_DURATION_MASK	0x7
-#define IGC_FEXTNVM4_BEACON_DURATION_8USEC	0x7
-#define IGC_FEXTNVM4_BEACON_DURATION_16USEC	0x3
-
-#define IGC_FEXTNVM6_REQ_PLL_CLK	0x00000100
-#define IGC_FEXTNVM6_ENABLE_K1_ENTRY_CONDITION	0x00000200
-#define IGC_FEXTNVM6_K1_OFF_ENABLE	0x80000000
-/* bit for disabling packet buffer read */
-#define IGC_FEXTNVM7_DISABLE_PB_READ	0x00040000
-#define IGC_FEXTNVM7_SIDE_CLK_UNGATE	0x00000004
-#define IGC_FEXTNVM7_DISABLE_SMB_PERST	0x00000020
-#define IGC_FEXTNVM9_IOSFSB_CLKGATE_DIS	0x00000800
-#define IGC_FEXTNVM9_IOSFSB_CLKREQ_DIS	0x00001000
-#define IGC_FEXTNVM11_DISABLE_PB_READ		0x00000200
-#define IGC_FEXTNVM11_DISABLE_MULR_FIX	0x00002000
-
-/* bit24: RXDCTL thresholds granularity: 0 - cache lines, 1 - descriptors */
-#define IGC_RXDCTL_THRESH_UNIT_DESC	0x01000000
-
-#define NVM_SIZE_MULTIPLIER 4096  /*multiplier for NVMS field*/
-#define IGC_FLASH_BASE_ADDR 0xE000 /*offset of NVM access regs*/
-#define IGC_CTRL_EXT_NVMVS 0x3 /*NVM valid sector */
-#define IGC_TARC0_CB_MULTIQ_3_REQ	0x30000000
-#define IGC_TARC0_CB_MULTIQ_2_REQ	0x20000000
-#define PCIE_ICH8_SNOOP_ALL	PCIE_NO_SNOOP_ALL
-
-#define IGC_ICH_RAR_ENTRIES	7
-#define IGC_PCH2_RAR_ENTRIES	5 /* RAR[0], SHRA[0-3] */
-#define IGC_PCH_LPT_RAR_ENTRIES	12 /* RAR[0], SHRA[0-10] */
-
-#define PHY_PAGE_SHIFT		5
-#define PHY_REG(page, reg)	(((page) << PHY_PAGE_SHIFT) | \
-				 ((reg) & MAX_PHY_REG_ADDRESS))
-#define IGP3_KMRN_DIAG	PHY_REG(770, 19) /* KMRN Diagnostic */
-#define IGP3_VR_CTRL	PHY_REG(776, 18) /* Voltage Regulator Control */
-
-#define IGP3_KMRN_DIAG_PCS_LOCK_LOSS		0x0002
-#define IGP3_VR_CTRL_DEV_POWERDOWN_MODE_MASK	0x0300
-#define IGP3_VR_CTRL_MODE_SHUTDOWN		0x0200
-
-/* PHY Wakeup Registers and defines */
-#define BM_PORT_GEN_CFG		PHY_REG(BM_PORT_CTRL_PAGE, 17)
-#define BM_RCTL			PHY_REG(BM_WUC_PAGE, 0)
-#define BM_WUC			PHY_REG(BM_WUC_PAGE, 1)
-#define BM_WUFC			PHY_REG(BM_WUC_PAGE, 2)
-#define BM_WUS			PHY_REG(BM_WUC_PAGE, 3)
-#define BM_RAR_L(_i)		(BM_PHY_REG(BM_WUC_PAGE, 16 + ((_i) << 2)))
-#define BM_RAR_M(_i)		(BM_PHY_REG(BM_WUC_PAGE, 17 + ((_i) << 2)))
-#define BM_RAR_H(_i)		(BM_PHY_REG(BM_WUC_PAGE, 18 + ((_i) << 2)))
-#define BM_RAR_CTRL(_i)		(BM_PHY_REG(BM_WUC_PAGE, 19 + ((_i) << 2)))
-#define BM_MTA(_i)		(BM_PHY_REG(BM_WUC_PAGE, 128 + ((_i) << 1)))
-
-#define BM_RCTL_UPE		0x0001 /* Unicast Promiscuous Mode */
-#define BM_RCTL_MPE		0x0002 /* Multicast Promiscuous Mode */
-#define BM_RCTL_MO_SHIFT	3      /* Multicast Offset Shift */
-#define BM_RCTL_MO_MASK		(3 << 3) /* Multicast Offset Mask */
-#define BM_RCTL_BAM		0x0020 /* Broadcast Accept Mode */
-#define BM_RCTL_PMCF		0x0040 /* Pass MAC Control Frames */
-#define BM_RCTL_RFCE		0x0080 /* Rx Flow Control Enable */
-
-#define HV_LED_CONFIG		PHY_REG(768, 30) /* LED Configuration */
-#define HV_MUX_DATA_CTRL	PHY_REG(776, 16)
-#define HV_MUX_DATA_CTRL_GEN_TO_MAC	0x0400
-#define HV_MUX_DATA_CTRL_FORCE_SPEED	0x0004
-#define HV_STATS_PAGE	778
-/* Half-duplex collision counts */
-#define HV_SCC_UPPER	PHY_REG(HV_STATS_PAGE, 16) /* Single Collision */
-#define HV_SCC_LOWER	PHY_REG(HV_STATS_PAGE, 17)
-#define HV_ECOL_UPPER	PHY_REG(HV_STATS_PAGE, 18) /* Excessive Coll. */
-#define HV_ECOL_LOWER	PHY_REG(HV_STATS_PAGE, 19)
-#define HV_MCC_UPPER	PHY_REG(HV_STATS_PAGE, 20) /* Multiple Collision */
-#define HV_MCC_LOWER	PHY_REG(HV_STATS_PAGE, 21)
-#define HV_LATECOL_UPPER PHY_REG(HV_STATS_PAGE, 23) /* Late Collision */
-#define HV_LATECOL_LOWER PHY_REG(HV_STATS_PAGE, 24)
-#define HV_COLC_UPPER	PHY_REG(HV_STATS_PAGE, 25) /* Collision */
-#define HV_COLC_LOWER	PHY_REG(HV_STATS_PAGE, 26)
-#define HV_DC_UPPER	PHY_REG(HV_STATS_PAGE, 27) /* Defer Count */
-#define HV_DC_LOWER	PHY_REG(HV_STATS_PAGE, 28)
-#define HV_TNCRS_UPPER	PHY_REG(HV_STATS_PAGE, 29) /* Tx with no CRS */
-#define HV_TNCRS_LOWER	PHY_REG(HV_STATS_PAGE, 30)
-
-#define IGC_FCRTV_PCH	0x05F40 /* PCH Flow Control Refresh Timer Value */
-
-#define IGC_NVM_K1_CONFIG	0x1B /* NVM K1 Config Word */
-#define IGC_NVM_K1_ENABLE	0x1  /* NVM Enable K1 bit */
-#define K1_ENTRY_LATENCY	0
-#define K1_MIN_TIME		1
-
-/* SMBus Control Phy Register */
-#define CV_SMB_CTRL		PHY_REG(769, 23)
-#define CV_SMB_CTRL_FORCE_SMBUS	0x0001
-
-/* I218 Ultra Low Power Configuration 1 Register */
-#define I218_ULP_CONFIG1		PHY_REG(779, 16)
-#define I218_ULP_CONFIG1_START		0x0001 /* Start auto ULP config */
-#define I218_ULP_CONFIG1_IND		0x0004 /* Pwr up from ULP indication */
-#define I218_ULP_CONFIG1_STICKY_ULP	0x0010 /* Set sticky ULP mode */
-#define I218_ULP_CONFIG1_INBAND_EXIT	0x0020 /* Inband on ULP exit */
-#define I218_ULP_CONFIG1_WOL_HOST	0x0040 /* WoL Host on ULP exit */
-#define I218_ULP_CONFIG1_RESET_TO_SMBUS	0x0100 /* Reset to SMBus mode */
-/* enable ULP even if when phy powered down via lanphypc */
-#define I218_ULP_CONFIG1_EN_ULP_LANPHYPC	0x0400
-/* disable clear of sticky ULP on PERST */
-#define I218_ULP_CONFIG1_DIS_CLR_STICKY_ON_PERST	0x0800
-#define I218_ULP_CONFIG1_DISABLE_SMB_PERST	0x1000 /* Disable on PERST# */
-
-
-/* SMBus Address Phy Register */
-#define HV_SMB_ADDR		PHY_REG(768, 26)
-#define HV_SMB_ADDR_MASK	0x007F
-#define HV_SMB_ADDR_PEC_EN	0x0200
-#define HV_SMB_ADDR_VALID	0x0080
-#define HV_SMB_ADDR_FREQ_MASK		0x1100
-#define HV_SMB_ADDR_FREQ_LOW_SHIFT	8
-#define HV_SMB_ADDR_FREQ_HIGH_SHIFT	12
-
-/* Strapping Option Register - RO */
-#define IGC_STRAP			0x0000C
-#define IGC_STRAP_SMBUS_ADDRESS_MASK	0x00FE0000
-#define IGC_STRAP_SMBUS_ADDRESS_SHIFT	17
-#define IGC_STRAP_SMT_FREQ_MASK	0x00003000
-#define IGC_STRAP_SMT_FREQ_SHIFT	12
-
-/* OEM Bits Phy Register */
-#define HV_OEM_BITS		PHY_REG(768, 25)
-#define HV_OEM_BITS_LPLU	0x0004 /* Low Power Link Up */
-#define HV_OEM_BITS_GBE_DIS	0x0040 /* Gigabit Disable */
-#define HV_OEM_BITS_RESTART_AN	0x0400 /* Restart Auto-negotiation */
-
-/* KMRN Mode Control */
-#define HV_KMRN_MODE_CTRL	PHY_REG(769, 16)
-#define HV_KMRN_MDIO_SLOW	0x0400
-
-/* KMRN FIFO Control and Status */
-#define HV_KMRN_FIFO_CTRLSTA			PHY_REG(770, 16)
-#define HV_KMRN_FIFO_CTRLSTA_PREAMBLE_MASK	0x7000
-#define HV_KMRN_FIFO_CTRLSTA_PREAMBLE_SHIFT	12
-
-/* PHY Power Management Control */
-#define HV_PM_CTRL		PHY_REG(770, 17)
-#define HV_PM_CTRL_K1_CLK_REQ		0x200
-#define HV_PM_CTRL_K1_ENABLE		0x4000
-
-#define I217_PLL_CLOCK_GATE_REG	PHY_REG(772, 28)
-#define I217_PLL_CLOCK_GATE_MASK	0x07FF
-
-#define SW_FLAG_TIMEOUT		1000 /* SW Semaphore flag timeout in ms */
-
-/* Inband Control */
-#define I217_INBAND_CTRL				PHY_REG(770, 18)
-#define I217_INBAND_CTRL_LINK_STAT_TX_TIMEOUT_MASK	0x3F00
-#define I217_INBAND_CTRL_LINK_STAT_TX_TIMEOUT_SHIFT	8
-
-/* Low Power Idle GPIO Control */
-#define I217_LPI_GPIO_CTRL			PHY_REG(772, 18)
-#define I217_LPI_GPIO_CTRL_AUTO_EN_LPI		0x0800
-
-/* PHY Low Power Idle Control */
-#define I82579_LPI_CTRL				PHY_REG(772, 20)
-#define I82579_LPI_CTRL_100_ENABLE		0x2000
-#define I82579_LPI_CTRL_1000_ENABLE		0x4000
-#define I82579_LPI_CTRL_ENABLE_MASK		0x6000
-
-/* 82579 DFT Control */
-#define I82579_DFT_CTRL			PHY_REG(769, 20)
-#define I82579_DFT_CTRL_GATE_PHY_RESET	0x0040 /* Gate PHY Reset on MAC Reset */
-
-/* Extended Management Interface (EMI) Registers */
-#define I82579_EMI_ADDR		0x10
-#define I82579_EMI_DATA		0x11
-#define I82579_LPI_UPDATE_TIMER	0x4805 /* in 40ns units + 40 ns base value */
-#define I82579_MSE_THRESHOLD	0x084F /* 82579 Mean Square Error Threshold */
-#define I82577_MSE_THRESHOLD	0x0887 /* 82577 Mean Square Error Threshold */
-#define I82579_MSE_LINK_DOWN	0x2411 /* MSE count before dropping link */
-#define I82579_RX_CONFIG		0x3412 /* Receive configuration */
-#define I82579_LPI_PLL_SHUT		0x4412 /* LPI PLL Shut Enable */
-#define I82579_EEE_PCS_STATUS		0x182E	/* IEEE MMD Register 3.1 >> 8 */
-#define I82579_EEE_CAPABILITY		0x0410 /* IEEE MMD Register 3.20 */
-#define I82579_EEE_ADVERTISEMENT	0x040E /* IEEE MMD Register 7.60 */
-#define I82579_EEE_LP_ABILITY		0x040F /* IEEE MMD Register 7.61 */
-#define I82579_EEE_100_SUPPORTED	(1 << 1) /* 100BaseTx EEE */
-#define I82579_EEE_1000_SUPPORTED	(1 << 2) /* 1000BaseTx EEE */
-#define I82579_LPI_100_PLL_SHUT	(1 << 2) /* 100M LPI PLL Shut Enabled */
-#define I217_EEE_PCS_STATUS	0x9401   /* IEEE MMD Register 3.1 */
-#define I217_EEE_CAPABILITY	0x8000   /* IEEE MMD Register 3.20 */
-#define I217_EEE_ADVERTISEMENT	0x8001   /* IEEE MMD Register 7.60 */
-#define I217_EEE_LP_ABILITY	0x8002   /* IEEE MMD Register 7.61 */
-#define I217_RX_CONFIG		0xB20C /* Receive configuration */
-
-#define IGC_EEE_RX_LPI_RCVD	0x0400	/* Tx LP idle received */
-#define IGC_EEE_TX_LPI_RCVD	0x0800	/* Rx LP idle received */
-
-/* Intel Rapid Start Technology Support */
-#define I217_PROXY_CTRL		BM_PHY_REG(BM_WUC_PAGE, 70)
-#define I217_PROXY_CTRL_AUTO_DISABLE	0x0080
-#define I217_CGFREG			PHY_REG(772, 29)
-#define I217_CGFREG_ENABLE_MTA_RESET	0x0002
-#define I217_MEMPWR			PHY_REG(772, 26)
-#define I217_MEMPWR_DISABLE_SMB_RELEASE	0x0010
-
-/* Receive Address Initial CRC Calculation */
-#define IGC_PCH_RAICC(_n)	(0x05F50 + ((_n) * 4))
-
-#define IGC_PCI_VENDOR_ID_REGISTER	0x00
-
-#define IGC_PCI_REVISION_ID_REG	0x08
-void igc_set_kmrn_lock_loss_workaround_ich8lan(struct igc_hw *hw,
-						 bool state);
-void igc_igp3_phy_powerdown_workaround_ich8lan(struct igc_hw *hw);
-void igc_gig_downshift_workaround_ich8lan(struct igc_hw *hw);
-void igc_suspend_workarounds_ich8lan(struct igc_hw *hw);
-u32 igc_resume_workarounds_pchlan(struct igc_hw *hw);
-s32 igc_configure_k1_ich8lan(struct igc_hw *hw, bool k1_enable);
-s32 igc_configure_k0s_lpt(struct igc_hw *hw, u8 entry_latency, u8 min_time);
-void igc_copy_rx_addrs_to_phy_ich8lan(struct igc_hw *hw);
-s32 igc_lv_jumbo_workaround_ich8lan(struct igc_hw *hw, bool enable);
-s32 igc_read_emi_reg_locked(struct igc_hw *hw, u16 addr, u16 *data);
-s32 igc_write_emi_reg_locked(struct igc_hw *hw, u16 addr, u16 data);
-s32 igc_set_eee_pchlan(struct igc_hw *hw);
-s32 igc_enable_ulp_lpt_lp(struct igc_hw *hw, bool to_sx);
-s32 igc_disable_ulp_lpt_lp(struct igc_hw *hw, bool force);
-#endif /* _IGC_ICH8LAN_H_ */
-void igc_demote_ltr(struct igc_hw *hw, bool demote, bool link);
diff --git a/drivers/net/intel/igc/base/igc_mac.c b/drivers/net/intel/igc/base/igc_mac.c
deleted file mode 100644
index 3cd6506e5e..0000000000
--- a/drivers/net/intel/igc/base/igc_mac.c
+++ /dev/null
@@ -1,2100 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#include "igc_api.h"
-
-static s32 igc_validate_mdi_setting_generic(struct igc_hw *hw);
-static void igc_set_lan_id_multi_port_pcie(struct igc_hw *hw);
-static void igc_config_collision_dist_generic(struct igc_hw *hw);
-static int igc_rar_set_generic(struct igc_hw *hw, u8 *addr, u32 index);
-
-/**
- *  igc_init_mac_ops_generic - Initialize MAC function pointers
- *  @hw: pointer to the HW structure
- *
- *  Setups up the function pointers to no-op functions
- **/
-void igc_init_mac_ops_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	DEBUGFUNC("igc_init_mac_ops_generic");
-
-	/* General Setup */
-	mac->ops.init_params = igc_null_ops_generic;
-	mac->ops.init_hw = igc_null_ops_generic;
-	mac->ops.reset_hw = igc_null_ops_generic;
-	mac->ops.setup_physical_interface = igc_null_ops_generic;
-	mac->ops.get_bus_info = igc_null_ops_generic;
-	mac->ops.set_lan_id = igc_set_lan_id_multi_port_pcie;
-	mac->ops.read_mac_addr = igc_read_mac_addr_generic;
-	mac->ops.config_collision_dist = igc_config_collision_dist_generic;
-	mac->ops.clear_hw_cntrs = igc_null_mac_generic;
-	/* LED */
-	mac->ops.cleanup_led = igc_null_ops_generic;
-	mac->ops.setup_led = igc_null_ops_generic;
-	mac->ops.blink_led = igc_null_ops_generic;
-	mac->ops.led_on = igc_null_ops_generic;
-	mac->ops.led_off = igc_null_ops_generic;
-	/* LINK */
-	mac->ops.setup_link = igc_null_ops_generic;
-	mac->ops.get_link_up_info = igc_null_link_info;
-	mac->ops.check_for_link = igc_null_ops_generic;
-	/* Management */
-	mac->ops.check_mng_mode = igc_null_mng_mode;
-	/* VLAN, MC, etc. */
-	mac->ops.update_mc_addr_list = igc_null_update_mc;
-	mac->ops.clear_vfta = igc_null_mac_generic;
-	mac->ops.write_vfta = igc_null_write_vfta;
-	mac->ops.rar_set = igc_rar_set_generic;
-	mac->ops.validate_mdi_setting = igc_validate_mdi_setting_generic;
-}
-
-/**
- *  igc_null_ops_generic - No-op function, returns 0
- *  @hw: pointer to the HW structure
- **/
-s32 igc_null_ops_generic(struct igc_hw IGC_UNUSEDARG * hw)
-{
-	DEBUGFUNC("igc_null_ops_generic");
-	UNREFERENCED_1PARAMETER(hw);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_null_mac_generic - No-op function, return void
- *  @hw: pointer to the HW structure
- **/
-void igc_null_mac_generic(struct igc_hw IGC_UNUSEDARG * hw)
-{
-	DEBUGFUNC("igc_null_mac_generic");
-	UNREFERENCED_1PARAMETER(hw);
-}
-
-/**
- *  igc_null_link_info - No-op function, return 0
- *  @hw: pointer to the HW structure
- *  @s: dummy variable
- *  @d: dummy variable
- **/
-s32 igc_null_link_info(struct igc_hw IGC_UNUSEDARG * hw,
-			 u16 IGC_UNUSEDARG * s, u16 IGC_UNUSEDARG * d)
-{
-	DEBUGFUNC("igc_null_link_info");
-	UNREFERENCED_3PARAMETER(hw, s, d);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_null_mng_mode - No-op function, return false
- *  @hw: pointer to the HW structure
- **/
-bool igc_null_mng_mode(struct igc_hw IGC_UNUSEDARG * hw)
-{
-	DEBUGFUNC("igc_null_mng_mode");
-	UNREFERENCED_1PARAMETER(hw);
-	return false;
-}
-
-/**
- *  igc_null_update_mc - No-op function, return void
- *  @hw: pointer to the HW structure
- *  @h: dummy variable
- *  @a: dummy variable
- **/
-void igc_null_update_mc(struct igc_hw IGC_UNUSEDARG * hw,
-			  u8 IGC_UNUSEDARG * h, u32 IGC_UNUSEDARG a)
-{
-	DEBUGFUNC("igc_null_update_mc");
-	UNREFERENCED_3PARAMETER(hw, h, a);
-}
-
-/**
- *  igc_null_write_vfta - No-op function, return void
- *  @hw: pointer to the HW structure
- *  @a: dummy variable
- *  @b: dummy variable
- **/
-void igc_null_write_vfta(struct igc_hw IGC_UNUSEDARG * hw,
-			   u32 IGC_UNUSEDARG a, u32 IGC_UNUSEDARG b)
-{
-	DEBUGFUNC("igc_null_write_vfta");
-	UNREFERENCED_3PARAMETER(hw, a, b);
-}
-
-/**
- *  igc_null_rar_set - No-op function, return 0
- *  @hw: pointer to the HW structure
- *  @h: dummy variable
- *  @a: dummy variable
- **/
-int igc_null_rar_set(struct igc_hw IGC_UNUSEDARG * hw,
-			u8 IGC_UNUSEDARG * h, u32 IGC_UNUSEDARG a)
-{
-	DEBUGFUNC("igc_null_rar_set");
-	UNREFERENCED_3PARAMETER(hw, h, a);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_get_bus_info_pci_generic - Get PCI(x) bus information
- *  @hw: pointer to the HW structure
- *
- *  Determines and stores the system bus information for a particular
- *  network interface.  The following bus information is determined and stored:
- *  bus speed, bus width, type (PCI/PCIx), and PCI(-x) function.
- **/
-s32 igc_get_bus_info_pci_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	struct igc_bus_info *bus = &hw->bus;
-	u32 status = IGC_READ_REG(hw, IGC_STATUS);
-	s32 ret_val = IGC_SUCCESS;
-
-	DEBUGFUNC("igc_get_bus_info_pci_generic");
-
-	/* PCI or PCI-X? */
-	bus->type = (status & IGC_STATUS_PCIX_MODE)
-			? igc_bus_type_pcix
-			: igc_bus_type_pci;
-
-	/* Bus speed */
-	if (bus->type == igc_bus_type_pci) {
-		bus->speed = (status & IGC_STATUS_PCI66)
-			     ? igc_bus_speed_66
-			     : igc_bus_speed_33;
-	} else {
-		switch (status & IGC_STATUS_PCIX_SPEED) {
-		case IGC_STATUS_PCIX_SPEED_66:
-			bus->speed = igc_bus_speed_66;
-			break;
-		case IGC_STATUS_PCIX_SPEED_100:
-			bus->speed = igc_bus_speed_100;
-			break;
-		case IGC_STATUS_PCIX_SPEED_133:
-			bus->speed = igc_bus_speed_133;
-			break;
-		default:
-			bus->speed = igc_bus_speed_reserved;
-			break;
-		}
-	}
-
-	/* Bus width */
-	bus->width = (status & IGC_STATUS_BUS64)
-		     ? igc_bus_width_64
-		     : igc_bus_width_32;
-
-	/* Which PCI(-X) function? */
-	mac->ops.set_lan_id(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_get_bus_info_pcie_generic - Get PCIe bus information
- *  @hw: pointer to the HW structure
- *
- *  Determines and stores the system bus information for a particular
- *  network interface.  The following bus information is determined and stored:
- *  bus speed, bus width, type (PCIe), and PCIe function.
- **/
-s32 igc_get_bus_info_pcie_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	struct igc_bus_info *bus = &hw->bus;
-	s32 ret_val;
-	u16 pcie_link_status;
-
-	DEBUGFUNC("igc_get_bus_info_pcie_generic");
-
-	bus->type = igc_bus_type_pci_express;
-
-	ret_val = igc_read_pcie_cap_reg(hw, PCIE_LINK_STATUS,
-					  &pcie_link_status);
-	if (ret_val) {
-		bus->width = igc_bus_width_unknown;
-		bus->speed = igc_bus_speed_unknown;
-	} else {
-		switch (pcie_link_status & PCIE_LINK_SPEED_MASK) {
-		case PCIE_LINK_SPEED_2500:
-			bus->speed = igc_bus_speed_2500;
-			break;
-		case PCIE_LINK_SPEED_5000:
-			bus->speed = igc_bus_speed_5000;
-			break;
-		default:
-			bus->speed = igc_bus_speed_unknown;
-			break;
-		}
-
-		bus->width = (enum igc_bus_width)((pcie_link_status &
-			      PCIE_LINK_WIDTH_MASK) >> PCIE_LINK_WIDTH_SHIFT);
-	}
-
-	mac->ops.set_lan_id(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_set_lan_id_multi_port_pcie - Set LAN id for PCIe multiple port devices
- *
- *  @hw: pointer to the HW structure
- *
- *  Determines the LAN function id by reading memory-mapped registers
- *  and swaps the port value if requested.
- **/
-static void igc_set_lan_id_multi_port_pcie(struct igc_hw *hw)
-{
-	struct igc_bus_info *bus = &hw->bus;
-	u32 reg;
-
-	/* The status register reports the correct function number
-	 * for the device regardless of function swap state.
-	 */
-	reg = IGC_READ_REG(hw, IGC_STATUS);
-	bus->func = (reg & IGC_STATUS_FUNC_MASK) >> IGC_STATUS_FUNC_SHIFT;
-}
-
-/**
- *  igc_set_lan_id_multi_port_pci - Set LAN id for PCI multiple port devices
- *  @hw: pointer to the HW structure
- *
- *  Determines the LAN function id by reading PCI config space.
- **/
-void igc_set_lan_id_multi_port_pci(struct igc_hw *hw)
-{
-	struct igc_bus_info *bus = &hw->bus;
-	u16 pci_header_type;
-	u32 status;
-
-	igc_read_pci_cfg(hw, PCI_HEADER_TYPE_REGISTER, &pci_header_type);
-	if (pci_header_type & PCI_HEADER_TYPE_MULTIFUNC) {
-		status = IGC_READ_REG(hw, IGC_STATUS);
-		bus->func = (status & IGC_STATUS_FUNC_MASK)
-			    >> IGC_STATUS_FUNC_SHIFT;
-	} else {
-		bus->func = 0;
-	}
-}
-
-/**
- *  igc_set_lan_id_single_port - Set LAN id for a single port device
- *  @hw: pointer to the HW structure
- *
- *  Sets the LAN function id to zero for a single port device.
- **/
-void igc_set_lan_id_single_port(struct igc_hw *hw)
-{
-	struct igc_bus_info *bus = &hw->bus;
-
-	bus->func = 0;
-}
-
-/**
- *  igc_clear_vfta_generic - Clear VLAN filter table
- *  @hw: pointer to the HW structure
- *
- *  Clears the register array which contains the VLAN filter table by
- *  setting all the values to 0.
- **/
-void igc_clear_vfta_generic(struct igc_hw *hw)
-{
-	u32 offset;
-
-	DEBUGFUNC("igc_clear_vfta_generic");
-
-	for (offset = 0; offset < IGC_VLAN_FILTER_TBL_SIZE; offset++) {
-		IGC_WRITE_REG_ARRAY(hw, IGC_VFTA, offset, 0);
-		IGC_WRITE_FLUSH(hw);
-	}
-}
-
-/**
- *  igc_write_vfta_generic - Write value to VLAN filter table
- *  @hw: pointer to the HW structure
- *  @offset: register offset in VLAN filter table
- *  @value: register value written to VLAN filter table
- *
- *  Writes value at the given offset in the register array which stores
- *  the VLAN filter table.
- **/
-void igc_write_vfta_generic(struct igc_hw *hw, u32 offset, u32 value)
-{
-	DEBUGFUNC("igc_write_vfta_generic");
-
-	IGC_WRITE_REG_ARRAY(hw, IGC_VFTA, offset, value);
-	IGC_WRITE_FLUSH(hw);
-}
-
-/**
- *  igc_init_rx_addrs_generic - Initialize receive address's
- *  @hw: pointer to the HW structure
- *  @rar_count: receive address registers
- *
- *  Setup the receive address registers by setting the base receive address
- *  register to the devices MAC address and clearing all the other receive
- *  address registers to 0.
- **/
-void igc_init_rx_addrs_generic(struct igc_hw *hw, u16 rar_count)
-{
-	u32 i;
-	u8 mac_addr[ETH_ADDR_LEN] = {0};
-
-	DEBUGFUNC("igc_init_rx_addrs_generic");
-
-	/* Setup the receive address */
-	DEBUGOUT("Programming MAC Address into RAR[0]\n");
-
-	hw->mac.ops.rar_set(hw, hw->mac.addr, 0);
-
-	/* Zero out the other (rar_entry_count - 1) receive addresses */
-	DEBUGOUT1("Clearing RAR[1-%u]\n", rar_count - 1);
-	for (i = 1; i < rar_count; i++)
-		hw->mac.ops.rar_set(hw, mac_addr, i);
-}
-
-/**
- *  igc_check_alt_mac_addr_generic - Check for alternate MAC addr
- *  @hw: pointer to the HW structure
- *
- *  Checks the nvm for an alternate MAC address.  An alternate MAC address
- *  can be setup by pre-boot software and must be treated like a permanent
- *  address and must override the actual permanent MAC address. If an
- *  alternate MAC address is found it is programmed into RAR0, replacing
- *  the permanent address that was installed into RAR0 by the Si on reset.
- *  This function will return SUCCESS unless it encounters an error while
- *  reading the EEPROM.
- **/
-s32 igc_check_alt_mac_addr_generic(struct igc_hw *hw)
-{
-	u32 i;
-	s32 ret_val;
-	u16 offset, nvm_alt_mac_addr_offset, nvm_data;
-	u8 alt_mac_addr[ETH_ADDR_LEN];
-
-	DEBUGFUNC("igc_check_alt_mac_addr_generic");
-
-	ret_val = hw->nvm.ops.read(hw, NVM_COMPAT, 1, &nvm_data);
-	if (ret_val)
-		return ret_val;
-
-	/* not supported on older hardware or 82573 */
-	if (hw->mac.type < igc_82571 || hw->mac.type == igc_82573)
-		return IGC_SUCCESS;
-
-	/* Alternate MAC address is handled by the option ROM for 82580
-	 * and newer. SW support not required.
-	 */
-	if (hw->mac.type >= igc_82580)
-		return IGC_SUCCESS;
-
-	ret_val = hw->nvm.ops.read(hw, NVM_ALT_MAC_ADDR_PTR, 1,
-				   &nvm_alt_mac_addr_offset);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-
-	if (nvm_alt_mac_addr_offset == 0xFFFF ||
-	    nvm_alt_mac_addr_offset == 0x0000)
-		/* There is no Alternate MAC Address */
-		return IGC_SUCCESS;
-
-	if (hw->bus.func == IGC_FUNC_1)
-		nvm_alt_mac_addr_offset += IGC_ALT_MAC_ADDRESS_OFFSET_LAN1;
-	if (hw->bus.func == IGC_FUNC_2)
-		nvm_alt_mac_addr_offset += IGC_ALT_MAC_ADDRESS_OFFSET_LAN2;
-
-	if (hw->bus.func == IGC_FUNC_3)
-		nvm_alt_mac_addr_offset += IGC_ALT_MAC_ADDRESS_OFFSET_LAN3;
-	for (i = 0; i < ETH_ADDR_LEN; i += 2) {
-		offset = nvm_alt_mac_addr_offset + (i >> 1);
-		ret_val = hw->nvm.ops.read(hw, offset, 1, &nvm_data);
-		if (ret_val) {
-			DEBUGOUT("NVM Read Error\n");
-			return ret_val;
-		}
-
-		alt_mac_addr[i] = (u8)(nvm_data & 0xFF);
-		alt_mac_addr[i + 1] = (u8)(nvm_data >> 8);
-	}
-
-	/* if multicast bit is set, the alternate address will not be used */
-	if (alt_mac_addr[0] & 0x01) {
-		DEBUGOUT("Ignoring Alternate Mac Address with MC bit set\n");
-		return IGC_SUCCESS;
-	}
-
-	/* We have a valid alternate MAC address, and we want to treat it the
-	 * same as the normal permanent MAC address stored by the HW into the
-	 * RAR. Do this by mapping this address into RAR0.
-	 */
-	hw->mac.ops.rar_set(hw, alt_mac_addr, 0);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_rar_set_generic - Set receive address register
- *  @hw: pointer to the HW structure
- *  @addr: pointer to the receive address
- *  @index: receive address array register
- *
- *  Sets the receive address array register at index to the address passed
- *  in by addr.
- **/
-static int igc_rar_set_generic(struct igc_hw *hw, u8 *addr, u32 index)
-{
-	u32 rar_low, rar_high;
-
-	DEBUGFUNC("igc_rar_set_generic");
-
-	/* HW expects these in little endian so we reverse the byte order
-	 * from network order (big endian) to little endian
-	 */
-	rar_low = ((u32)addr[0] | ((u32)addr[1] << 8) |
-		   ((u32)addr[2] << 16) | ((u32)addr[3] << 24));
-
-	rar_high = ((u32)addr[4] | ((u32)addr[5] << 8));
-
-	/* If MAC address zero, no need to set the AV bit */
-	if (rar_low || rar_high)
-		rar_high |= IGC_RAH_AV;
-
-	/* Some bridges will combine consecutive 32-bit writes into
-	 * a single burst write, which will malfunction on some parts.
-	 * The flushes avoid this.
-	 */
-	IGC_WRITE_REG(hw, IGC_RAL(index), rar_low);
-	IGC_WRITE_FLUSH(hw);
-	IGC_WRITE_REG(hw, IGC_RAH(index), rar_high);
-	IGC_WRITE_FLUSH(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_hash_mc_addr_generic - Generate a multicast hash value
- *  @hw: pointer to the HW structure
- *  @mc_addr: pointer to a multicast address
- *
- *  Generates a multicast address hash value which is used to determine
- *  the multicast filter table array address and new table value.
- **/
-u32 igc_hash_mc_addr_generic(struct igc_hw *hw, u8 *mc_addr)
-{
-	u32 hash_value, hash_mask;
-	u8 bit_shift = 0;
-
-	DEBUGFUNC("igc_hash_mc_addr_generic");
-
-	/* Register count multiplied by bits per register */
-	hash_mask = (hw->mac.mta_reg_count * 32) - 1;
-
-	/* For a mc_filter_type of 0, bit_shift is the number of left-shifts
-	 * where 0xFF would still fall within the hash mask.
-	 */
-	while (hash_mask >> bit_shift != 0xFF)
-		bit_shift++;
-
-	/* The portion of the address that is used for the hash table
-	 * is determined by the mc_filter_type setting.
-	 * The algorithm is such that there is a total of 8 bits of shifting.
-	 * The bit_shift for a mc_filter_type of 0 represents the number of
-	 * left-shifts where the MSB of mc_addr[5] would still fall within
-	 * the hash_mask.  Case 0 does this exactly.  Since there are a total
-	 * of 8 bits of shifting, then mc_addr[4] will shift right the
-	 * remaining number of bits. Thus 8 - bit_shift.  The rest of the
-	 * cases are a variation of this algorithm...essentially raising the
-	 * number of bits to shift mc_addr[5] left, while still keeping the
-	 * 8-bit shifting total.
-	 *
-	 * For example, given the following Destination MAC Address and an
-	 * mta register count of 128 (thus a 4096-bit vector and 0xFFF mask),
-	 * we can see that the bit_shift for case 0 is 4.  These are the hash
-	 * values resulting from each mc_filter_type...
-	 * [0] [1] [2] [3] [4] [5]
-	 * 01  AA  00  12  34  56
-	 * LSB		 MSB
-	 *
-	 * case 0: hash_value = ((0x34 >> 4) | (0x56 << 4)) & 0xFFF = 0x563
-	 * case 1: hash_value = ((0x34 >> 3) | (0x56 << 5)) & 0xFFF = 0xAC6
-	 * case 2: hash_value = ((0x34 >> 2) | (0x56 << 6)) & 0xFFF = 0x163
-	 * case 3: hash_value = ((0x34 >> 0) | (0x56 << 8)) & 0xFFF = 0x634
-	 */
-	switch (hw->mac.mc_filter_type) {
-	default:
-	case 0:
-		break;
-	case 1:
-		bit_shift += 1;
-		break;
-	case 2:
-		bit_shift += 2;
-		break;
-	case 3:
-		bit_shift += 4;
-		break;
-	}
-
-	hash_value = hash_mask & (((mc_addr[4] >> (8 - bit_shift)) |
-				  (((u16)mc_addr[5]) << bit_shift)));
-
-	return hash_value;
-}
-
-/**
- *  igc_update_mc_addr_list_generic - Update Multicast addresses
- *  @hw: pointer to the HW structure
- *  @mc_addr_list: array of multicast addresses to program
- *  @mc_addr_count: number of multicast addresses to program
- *
- *  Updates entire Multicast Table Array.
- *  The caller must have a packed mc_addr_list of multicast addresses.
- **/
-void igc_update_mc_addr_list_generic(struct igc_hw *hw,
-				       u8 *mc_addr_list, u32 mc_addr_count)
-{
-	u32 hash_value, hash_bit, hash_reg;
-	int i;
-
-	DEBUGFUNC("igc_update_mc_addr_list_generic");
-
-	/* clear mta_shadow */
-	memset(&hw->mac.mta_shadow, 0, sizeof(hw->mac.mta_shadow));
-
-	/* update mta_shadow from mc_addr_list */
-	for (i = 0; (u32)i < mc_addr_count; i++) {
-		hash_value = igc_hash_mc_addr_generic(hw, mc_addr_list);
-
-		hash_reg = (hash_value >> 5) & (hw->mac.mta_reg_count - 1);
-		hash_bit = hash_value & 0x1F;
-
-		hw->mac.mta_shadow[hash_reg] |= (1 << hash_bit);
-		mc_addr_list += (ETH_ADDR_LEN);
-	}
-
-	/* replace the entire MTA table */
-	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
-		IGC_WRITE_REG_ARRAY(hw, IGC_MTA, i, hw->mac.mta_shadow[i]);
-	IGC_WRITE_FLUSH(hw);
-}
-
-/**
- *  igc_pcix_mmrbc_workaround_generic - Fix incorrect MMRBC value
- *  @hw: pointer to the HW structure
- *
- *  In certain situations, a system BIOS may report that the PCIx maximum
- *  memory read byte count (MMRBC) value is higher than than the actual
- *  value. We check the PCIx command register with the current PCIx status
- *  register.
- **/
-void igc_pcix_mmrbc_workaround_generic(struct igc_hw *hw)
-{
-	u16 cmd_mmrbc;
-	u16 pcix_cmd;
-	u16 pcix_stat_hi_word;
-	u16 stat_mmrbc;
-
-	DEBUGFUNC("igc_pcix_mmrbc_workaround_generic");
-
-	/* Workaround for PCI-X issue when BIOS sets MMRBC incorrectly */
-	if (hw->bus.type != igc_bus_type_pcix)
-		return;
-
-	igc_read_pci_cfg(hw, PCIX_COMMAND_REGISTER, &pcix_cmd);
-	igc_read_pci_cfg(hw, PCIX_STATUS_REGISTER_HI, &pcix_stat_hi_word);
-	cmd_mmrbc = (pcix_cmd & PCIX_COMMAND_MMRBC_MASK) >>
-		     PCIX_COMMAND_MMRBC_SHIFT;
-	stat_mmrbc = (pcix_stat_hi_word & PCIX_STATUS_HI_MMRBC_MASK) >>
-		      PCIX_STATUS_HI_MMRBC_SHIFT;
-	if (stat_mmrbc == PCIX_STATUS_HI_MMRBC_4K)
-		stat_mmrbc = PCIX_STATUS_HI_MMRBC_2K;
-	if (cmd_mmrbc > stat_mmrbc) {
-		pcix_cmd &= ~PCIX_COMMAND_MMRBC_MASK;
-		pcix_cmd |= stat_mmrbc << PCIX_COMMAND_MMRBC_SHIFT;
-		igc_write_pci_cfg(hw, PCIX_COMMAND_REGISTER, &pcix_cmd);
-	}
-}
-
-/**
- *  igc_clear_hw_cntrs_base_generic - Clear base hardware counters
- *  @hw: pointer to the HW structure
- *
- *  Clears the base hardware counters by reading the counter registers.
- **/
-void igc_clear_hw_cntrs_base_generic(struct igc_hw *hw)
-{
-	DEBUGFUNC("igc_clear_hw_cntrs_base_generic");
-
-	IGC_READ_REG(hw, IGC_CRCERRS);
-	IGC_READ_REG(hw, IGC_SYMERRS);
-	IGC_READ_REG(hw, IGC_MPC);
-	IGC_READ_REG(hw, IGC_SCC);
-	IGC_READ_REG(hw, IGC_ECOL);
-	IGC_READ_REG(hw, IGC_MCC);
-	IGC_READ_REG(hw, IGC_LATECOL);
-	IGC_READ_REG(hw, IGC_COLC);
-	IGC_READ_REG(hw, IGC_DC);
-	IGC_READ_REG(hw, IGC_SEC);
-	IGC_READ_REG(hw, IGC_RLEC);
-	IGC_READ_REG(hw, IGC_XONRXC);
-	IGC_READ_REG(hw, IGC_XONTXC);
-	IGC_READ_REG(hw, IGC_XOFFRXC);
-	IGC_READ_REG(hw, IGC_XOFFTXC);
-	IGC_READ_REG(hw, IGC_FCRUC);
-	IGC_READ_REG(hw, IGC_GPRC);
-	IGC_READ_REG(hw, IGC_BPRC);
-	IGC_READ_REG(hw, IGC_MPRC);
-	IGC_READ_REG(hw, IGC_GPTC);
-	IGC_READ_REG(hw, IGC_GORCL);
-	IGC_READ_REG(hw, IGC_GORCH);
-	IGC_READ_REG(hw, IGC_GOTCL);
-	IGC_READ_REG(hw, IGC_GOTCH);
-	IGC_READ_REG(hw, IGC_RNBC);
-	IGC_READ_REG(hw, IGC_RUC);
-	IGC_READ_REG(hw, IGC_RFC);
-	IGC_READ_REG(hw, IGC_ROC);
-	IGC_READ_REG(hw, IGC_RJC);
-	IGC_READ_REG(hw, IGC_TORL);
-	IGC_READ_REG(hw, IGC_TORH);
-	IGC_READ_REG(hw, IGC_TOTL);
-	IGC_READ_REG(hw, IGC_TOTH);
-	IGC_READ_REG(hw, IGC_TPR);
-	IGC_READ_REG(hw, IGC_TPT);
-	IGC_READ_REG(hw, IGC_MPTC);
-	IGC_READ_REG(hw, IGC_BPTC);
-}
-
-/**
- *  igc_check_for_copper_link_generic - Check for link (Copper)
- *  @hw: pointer to the HW structure
- *
- *  Checks to see of the link status of the hardware has changed.  If a
- *  change in link status has been detected, then we read the PHY registers
- *  to get the current speed/duplex if link exists.
- **/
-s32 igc_check_for_copper_link_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	s32 ret_val;
-	bool link;
-
-	DEBUGFUNC("igc_check_for_copper_link");
-
-	/* We only want to go out to the PHY registers to see if Auto-Neg
-	 * has completed and/or if our link status has changed.  The
-	 * get_link_status flag is set upon receiving a Link Status
-	 * Change or Rx Sequence Error interrupt.
-	 */
-	if (!mac->get_link_status)
-		return IGC_SUCCESS;
-
-	/* First we want to see if the MII Status Register reports
-	 * link.  If so, then we want to get the current speed/duplex
-	 * of the PHY.
-	 */
-	ret_val = igc_phy_has_link_generic(hw, 1, 0, &link);
-	if (ret_val)
-		return ret_val;
-
-	if (!link)
-		return IGC_SUCCESS; /* No link detected */
-
-	mac->get_link_status = false;
-
-	/* Check if there was DownShift, must be checked
-	 * immediately after link-up
-	 */
-	igc_check_downshift_generic(hw);
-
-	/* If we are forcing speed/duplex, then we simply return since
-	 * we have already determined whether we have link or not.
-	 */
-	if (!mac->autoneg)
-		return -IGC_ERR_CONFIG;
-
-	/* Auto-Neg is enabled.  Auto Speed Detection takes care
-	 * of MAC speed/duplex configuration.  So we only need to
-	 * configure Collision Distance in the MAC.
-	 */
-	mac->ops.config_collision_dist(hw);
-
-	/* Configure Flow Control now that Auto-Neg has completed.
-	 * First, we need to restore the desired flow control
-	 * settings because we may have had to re-autoneg with a
-	 * different link partner.
-	 */
-	ret_val = igc_config_fc_after_link_up_generic(hw);
-	if (ret_val)
-		DEBUGOUT("Error configuring flow control\n");
-
-	return ret_val;
-}
-
-/**
- *  igc_check_for_fiber_link_generic - Check for link (Fiber)
- *  @hw: pointer to the HW structure
- *
- *  Checks for link up on the hardware.  If link is not up and we have
- *  a signal, then we need to force link up.
- **/
-s32 igc_check_for_fiber_link_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	u32 rxcw;
-	u32 ctrl;
-	u32 status;
-	s32 ret_val;
-
-	DEBUGFUNC("igc_check_for_fiber_link_generic");
-
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-	status = IGC_READ_REG(hw, IGC_STATUS);
-	rxcw = IGC_READ_REG(hw, IGC_RXCW);
-
-	/* If we don't have link (auto-negotiation failed or link partner
-	 * cannot auto-negotiate), the cable is plugged in (we have signal),
-	 * and our link partner is not trying to auto-negotiate with us (we
-	 * are receiving idles or data), we need to force link up. We also
-	 * need to give auto-negotiation time to complete, in case the cable
-	 * was just plugged in. The autoneg_failed flag does this.
-	 */
-	/* (ctrl & IGC_CTRL_SWDPIN1) == 1 == have signal */
-	if ((ctrl & IGC_CTRL_SWDPIN1) && !(status & IGC_STATUS_LU) &&
-	    !(rxcw & IGC_RXCW_C)) {
-		if (!mac->autoneg_failed) {
-			mac->autoneg_failed = true;
-			return IGC_SUCCESS;
-		}
-		DEBUGOUT("NOT Rx'ing /C/, disable AutoNeg and force link.\n");
-
-		/* Disable auto-negotiation in the TXCW register */
-		IGC_WRITE_REG(hw, IGC_TXCW, (mac->txcw & ~IGC_TXCW_ANE));
-
-		/* Force link-up and also force full-duplex. */
-		ctrl = IGC_READ_REG(hw, IGC_CTRL);
-		ctrl |= (IGC_CTRL_SLU | IGC_CTRL_FD);
-		IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-
-		/* Configure Flow Control after forcing link up. */
-		ret_val = igc_config_fc_after_link_up_generic(hw);
-		if (ret_val) {
-			DEBUGOUT("Error configuring flow control\n");
-			return ret_val;
-		}
-	} else if ((ctrl & IGC_CTRL_SLU) && (rxcw & IGC_RXCW_C)) {
-		/* If we are forcing link and we are receiving /C/ ordered
-		 * sets, re-enable auto-negotiation in the TXCW register
-		 * and disable forced link in the Device Control register
-		 * in an attempt to auto-negotiate with our link partner.
-		 */
-		DEBUGOUT("Rx'ing /C/, enable AutoNeg and stop forcing link.\n");
-		IGC_WRITE_REG(hw, IGC_TXCW, mac->txcw);
-		IGC_WRITE_REG(hw, IGC_CTRL, (ctrl & ~IGC_CTRL_SLU));
-
-		mac->serdes_has_link = true;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_check_for_serdes_link_generic - Check for link (Serdes)
- *  @hw: pointer to the HW structure
- *
- *  Checks for link up on the hardware.  If link is not up and we have
- *  a signal, then we need to force link up.
- **/
-s32 igc_check_for_serdes_link_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	u32 rxcw;
-	u32 ctrl;
-	u32 status;
-	s32 ret_val;
-
-	DEBUGFUNC("igc_check_for_serdes_link_generic");
-
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-	status = IGC_READ_REG(hw, IGC_STATUS);
-	rxcw = IGC_READ_REG(hw, IGC_RXCW);
-
-	/* If we don't have link (auto-negotiation failed or link partner
-	 * cannot auto-negotiate), and our link partner is not trying to
-	 * auto-negotiate with us (we are receiving idles or data),
-	 * we need to force link up. We also need to give auto-negotiation
-	 * time to complete.
-	 */
-	/* (ctrl & IGC_CTRL_SWDPIN1) == 1 == have signal */
-	if (!(status & IGC_STATUS_LU) && !(rxcw & IGC_RXCW_C)) {
-		if (!mac->autoneg_failed) {
-			mac->autoneg_failed = true;
-			return IGC_SUCCESS;
-		}
-		DEBUGOUT("NOT Rx'ing /C/, disable AutoNeg and force link.\n");
-
-		/* Disable auto-negotiation in the TXCW register */
-		IGC_WRITE_REG(hw, IGC_TXCW, (mac->txcw & ~IGC_TXCW_ANE));
-
-		/* Force link-up and also force full-duplex. */
-		ctrl = IGC_READ_REG(hw, IGC_CTRL);
-		ctrl |= (IGC_CTRL_SLU | IGC_CTRL_FD);
-		IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-
-		/* Configure Flow Control after forcing link up. */
-		ret_val = igc_config_fc_after_link_up_generic(hw);
-		if (ret_val) {
-			DEBUGOUT("Error configuring flow control\n");
-			return ret_val;
-		}
-	} else if ((ctrl & IGC_CTRL_SLU) && (rxcw & IGC_RXCW_C)) {
-		/* If we are forcing link and we are receiving /C/ ordered
-		 * sets, re-enable auto-negotiation in the TXCW register
-		 * and disable forced link in the Device Control register
-		 * in an attempt to auto-negotiate with our link partner.
-		 */
-		DEBUGOUT("Rx'ing /C/, enable AutoNeg and stop forcing link.\n");
-		IGC_WRITE_REG(hw, IGC_TXCW, mac->txcw);
-		IGC_WRITE_REG(hw, IGC_CTRL, (ctrl & ~IGC_CTRL_SLU));
-
-		mac->serdes_has_link = true;
-	} else if (!(IGC_TXCW_ANE & IGC_READ_REG(hw, IGC_TXCW))) {
-		/* If we force link for non-auto-negotiation switch, check
-		 * link status based on MAC synchronization for internal
-		 * serdes media type.
-		 */
-		/* SYNCH bit and IV bit are sticky. */
-		usec_delay(10);
-		rxcw = IGC_READ_REG(hw, IGC_RXCW);
-		if (rxcw & IGC_RXCW_SYNCH) {
-			if (!(rxcw & IGC_RXCW_IV)) {
-				mac->serdes_has_link = true;
-				DEBUGOUT("SERDES: Link up - forced.\n");
-			}
-		} else {
-			mac->serdes_has_link = false;
-			DEBUGOUT("SERDES: Link down - force failed.\n");
-		}
-	}
-
-	if (IGC_TXCW_ANE & IGC_READ_REG(hw, IGC_TXCW)) {
-		status = IGC_READ_REG(hw, IGC_STATUS);
-		if (status & IGC_STATUS_LU) {
-			/* SYNCH bit and IV bit are sticky, so reread rxcw. */
-			usec_delay(10);
-			rxcw = IGC_READ_REG(hw, IGC_RXCW);
-			if (rxcw & IGC_RXCW_SYNCH) {
-				if (!(rxcw & IGC_RXCW_IV)) {
-					mac->serdes_has_link = true;
-					DEBUGOUT("SERDES: Link up - autoneg completed successfully.\n");
-				} else {
-					mac->serdes_has_link = false;
-					DEBUGOUT("SERDES: Link down - invalid codewords detected in autoneg.\n");
-				}
-			} else {
-				mac->serdes_has_link = false;
-				DEBUGOUT("SERDES: Link down - no sync.\n");
-			}
-		} else {
-			mac->serdes_has_link = false;
-			DEBUGOUT("SERDES: Link down - autoneg failed\n");
-		}
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_set_default_fc_generic - Set flow control default values
- *  @hw: pointer to the HW structure
- *
- *  Read the EEPROM for the default values for flow control and store the
- *  values.
- **/
-s32 igc_set_default_fc_generic(struct igc_hw *hw)
-{
-	s32 ret_val;
-	u16 nvm_data;
-	u16 nvm_offset = 0;
-
-	DEBUGFUNC("igc_set_default_fc_generic");
-
-	/* Read and store word 0x0F of the EEPROM. This word contains bits
-	 * that determine the hardware's default PAUSE (flow control) mode,
-	 * a bit that determines whether the HW defaults to enabling or
-	 * disabling auto-negotiation, and the direction of the
-	 * SW defined pins. If there is no SW over-ride of the flow
-	 * control setting, then the variable hw->fc will
-	 * be initialized based on a value in the EEPROM.
-	 */
-	if (hw->mac.type == igc_i350) {
-		nvm_offset = NVM_82580_LAN_FUNC_OFFSET(hw->bus.func);
-		ret_val = hw->nvm.ops.read(hw,
-					   NVM_INIT_CONTROL2_REG +
-					   nvm_offset,
-					   1, &nvm_data);
-	} else {
-		ret_val = hw->nvm.ops.read(hw,
-					   NVM_INIT_CONTROL2_REG,
-					   1, &nvm_data);
-	}
-
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-
-	if (!(nvm_data & NVM_WORD0F_PAUSE_MASK))
-		hw->fc.requested_mode = igc_fc_none;
-	else if ((nvm_data & NVM_WORD0F_PAUSE_MASK) ==
-		 NVM_WORD0F_ASM_DIR)
-		hw->fc.requested_mode = igc_fc_tx_pause;
-	else
-		hw->fc.requested_mode = igc_fc_full;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_setup_link_generic - Setup flow control and link settings
- *  @hw: pointer to the HW structure
- *
- *  Determines which flow control settings to use, then configures flow
- *  control.  Calls the appropriate media-specific link configuration
- *  function.  Assuming the adapter has a valid link partner, a valid link
- *  should be established.  Assumes the hardware has previously been reset
- *  and the transmitter and receiver are not enabled.
- **/
-s32 igc_setup_link_generic(struct igc_hw *hw)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("igc_setup_link_generic");
-
-	/* In the case of the phy reset being blocked, we already have a link.
-	 * We do not need to set it up again.
-	 */
-	if (hw->phy.ops.check_reset_block && hw->phy.ops.check_reset_block(hw))
-		return IGC_SUCCESS;
-
-	/* If requested flow control is set to default, set flow control
-	 * based on the EEPROM flow control settings.
-	 */
-	if (hw->fc.requested_mode == igc_fc_default)
-		hw->fc.requested_mode = igc_fc_full;
-
-	/* Save off the requested flow control mode for use later.  Depending
-	 * on the link partner's capabilities, we may or may not use this mode.
-	 */
-	hw->fc.current_mode = hw->fc.requested_mode;
-
-	DEBUGOUT1("After fix-ups FlowControl is now = %x\n",
-		hw->fc.current_mode);
-
-	/* Call the necessary media_type subroutine to configure the link. */
-	ret_val = hw->mac.ops.setup_physical_interface(hw);
-	if (ret_val)
-		return ret_val;
-
-	/* Initialize the flow control address, type, and PAUSE timer
-	 * registers to their default values.  This is done even if flow
-	 * control is disabled, because it does not hurt anything to
-	 * initialize these registers.
-	 */
-	DEBUGOUT("Initializing the Flow Control address, type and timer regs\n");
-	IGC_WRITE_REG(hw, IGC_FCT, FLOW_CONTROL_TYPE);
-	IGC_WRITE_REG(hw, IGC_FCAH, FLOW_CONTROL_ADDRESS_HIGH);
-	IGC_WRITE_REG(hw, IGC_FCAL, FLOW_CONTROL_ADDRESS_LOW);
-
-	IGC_WRITE_REG(hw, IGC_FCTTV, hw->fc.pause_time);
-
-	return igc_set_fc_watermarks_generic(hw);
-}
-
-/**
- *  igc_commit_fc_settings_generic - Configure flow control
- *  @hw: pointer to the HW structure
- *
- *  Write the flow control settings to the Transmit Config Word Register (TXCW)
- *  base on the flow control settings in igc_mac_info.
- **/
-s32 igc_commit_fc_settings_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	u32 txcw;
-
-	DEBUGFUNC("igc_commit_fc_settings_generic");
-
-	/* Check for a software override of the flow control settings, and
-	 * setup the device accordingly.  If auto-negotiation is enabled, then
-	 * software will have to set the "PAUSE" bits to the correct value in
-	 * the Transmit Config Word Register (TXCW) and re-start auto-
-	 * negotiation.  However, if auto-negotiation is disabled, then
-	 * software will have to manually configure the two flow control enable
-	 * bits in the CTRL register.
-	 *
-	 * The possible values of the "fc" parameter are:
-	 *      0:  Flow control is completely disabled
-	 *      1:  Rx flow control is enabled (we can receive pause frames,
-	 *          but not send pause frames).
-	 *      2:  Tx flow control is enabled (we can send pause frames but we
-	 *          do not support receiving pause frames).
-	 *      3:  Both Rx and Tx flow control (symmetric) are enabled.
-	 */
-	switch (hw->fc.current_mode) {
-	case igc_fc_none:
-		/* Flow control completely disabled by a software over-ride. */
-		txcw = (IGC_TXCW_ANE | IGC_TXCW_FD);
-		break;
-	case igc_fc_rx_pause:
-		/* Rx Flow control is enabled and Tx Flow control is disabled
-		 * by a software over-ride. Since there really isn't a way to
-		 * advertise that we are capable of Rx Pause ONLY, we will
-		 * advertise that we support both symmetric and asymmetric Rx
-		 * PAUSE.  Later, we will disable the adapter's ability to send
-		 * PAUSE frames.
-		 */
-		txcw = (IGC_TXCW_ANE | IGC_TXCW_FD | IGC_TXCW_PAUSE_MASK);
-		break;
-	case igc_fc_tx_pause:
-		/* Tx Flow control is enabled, and Rx Flow control is disabled,
-		 * by a software over-ride.
-		 */
-		txcw = (IGC_TXCW_ANE | IGC_TXCW_FD | IGC_TXCW_ASM_DIR);
-		break;
-	case igc_fc_full:
-		/* Flow control (both Rx and Tx) is enabled by a software
-		 * over-ride.
-		 */
-		txcw = (IGC_TXCW_ANE | IGC_TXCW_FD | IGC_TXCW_PAUSE_MASK);
-		break;
-	default:
-		DEBUGOUT("Flow control param set incorrectly\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	IGC_WRITE_REG(hw, IGC_TXCW, txcw);
-	mac->txcw = txcw;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_poll_fiber_serdes_link_generic - Poll for link up
- *  @hw: pointer to the HW structure
- *
- *  Polls for link up by reading the status register, if link fails to come
- *  up with auto-negotiation, then the link is forced if a signal is detected.
- **/
-s32 igc_poll_fiber_serdes_link_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	u32 i, status;
-	s32 ret_val;
-
-	DEBUGFUNC("igc_poll_fiber_serdes_link_generic");
-
-	/* If we have a signal (the cable is plugged in, or assumed true for
-	 * serdes media) then poll for a "Link-Up" indication in the Device
-	 * Status Register.  Time-out if a link isn't seen in 500 milliseconds
-	 * seconds (Auto-negotiation should complete in less than 500
-	 * milliseconds even if the other end is doing it in SW).
-	 */
-	for (i = 0; i < FIBER_LINK_UP_LIMIT; i++) {
-		msec_delay(10);
-		status = IGC_READ_REG(hw, IGC_STATUS);
-		if (status & IGC_STATUS_LU)
-			break;
-	}
-	if (i == FIBER_LINK_UP_LIMIT) {
-		DEBUGOUT("Never got a valid link from auto-neg!!!\n");
-		mac->autoneg_failed = true;
-		/* AutoNeg failed to achieve a link, so we'll call
-		 * mac->check_for_link. This routine will force the
-		 * link up if we detect a signal. This will allow us to
-		 * communicate with non-autonegotiating link partners.
-		 */
-		ret_val = mac->ops.check_for_link(hw);
-		if (ret_val) {
-			DEBUGOUT("Error while checking for link\n");
-			return ret_val;
-		}
-		mac->autoneg_failed = false;
-	} else {
-		mac->autoneg_failed = false;
-		DEBUGOUT("Valid Link Found\n");
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_setup_fiber_serdes_link_generic - Setup link for fiber/serdes
- *  @hw: pointer to the HW structure
- *
- *  Configures collision distance and flow control for fiber and serdes
- *  links.  Upon successful setup, poll for link.
- **/
-s32 igc_setup_fiber_serdes_link_generic(struct igc_hw *hw)
-{
-	u32 ctrl;
-	s32 ret_val;
-
-	DEBUGFUNC("igc_setup_fiber_serdes_link_generic");
-
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-
-	/* Take the link out of reset */
-	ctrl &= ~IGC_CTRL_LRST;
-
-	hw->mac.ops.config_collision_dist(hw);
-
-	ret_val = igc_commit_fc_settings_generic(hw);
-	if (ret_val)
-		return ret_val;
-
-	/* Since auto-negotiation is enabled, take the link out of reset (the
-	 * link will be in reset, because we previously reset the chip). This
-	 * will restart auto-negotiation.  If auto-negotiation is successful
-	 * then the link-up status bit will be set and the flow control enable
-	 * bits (RFCE and TFCE) will be set according to their negotiated value.
-	 */
-	DEBUGOUT("Auto-negotiation enabled\n");
-
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-	IGC_WRITE_FLUSH(hw);
-	msec_delay(1);
-
-	/* For these adapters, the SW definable pin 1 is set when the optics
-	 * detect a signal.  If we have a signal, then poll for a "Link-Up"
-	 * indication.
-	 */
-	if (hw->phy.media_type == igc_media_type_internal_serdes ||
-	    (IGC_READ_REG(hw, IGC_CTRL) & IGC_CTRL_SWDPIN1)) {
-		ret_val = igc_poll_fiber_serdes_link_generic(hw);
-	} else {
-		DEBUGOUT("No signal detected\n");
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_config_collision_dist_generic - Configure collision distance
- *  @hw: pointer to the HW structure
- *
- *  Configures the collision distance to the default value and is used
- *  during link setup.
- **/
-static void igc_config_collision_dist_generic(struct igc_hw *hw)
-{
-	u32 tctl;
-
-	DEBUGFUNC("igc_config_collision_dist_generic");
-
-	tctl = IGC_READ_REG(hw, IGC_TCTL);
-
-	tctl &= ~IGC_TCTL_COLD;
-	tctl |= IGC_COLLISION_DISTANCE << IGC_COLD_SHIFT;
-
-	IGC_WRITE_REG(hw, IGC_TCTL, tctl);
-	IGC_WRITE_FLUSH(hw);
-}
-
-/**
- *  igc_set_fc_watermarks_generic - Set flow control high/low watermarks
- *  @hw: pointer to the HW structure
- *
- *  Sets the flow control high/low threshold (watermark) registers.  If
- *  flow control XON frame transmission is enabled, then set XON frame
- *  transmission as well.
- **/
-s32 igc_set_fc_watermarks_generic(struct igc_hw *hw)
-{
-	u32 fcrtl = 0, fcrth = 0;
-
-	DEBUGFUNC("igc_set_fc_watermarks_generic");
-
-	/* Set the flow control receive threshold registers.  Normally,
-	 * these registers will be set to a default threshold that may be
-	 * adjusted later by the driver's runtime code.  However, if the
-	 * ability to transmit pause frames is not enabled, then these
-	 * registers will be set to 0.
-	 */
-	if (hw->fc.current_mode & igc_fc_tx_pause) {
-		/* We need to set up the Receive Threshold high and low water
-		 * marks as well as (optionally) enabling the transmission of
-		 * XON frames.
-		 */
-		fcrtl = hw->fc.low_water;
-		if (hw->fc.send_xon)
-			fcrtl |= IGC_FCRTL_XONE;
-
-		fcrth = hw->fc.high_water;
-	}
-	IGC_WRITE_REG(hw, IGC_FCRTL, fcrtl);
-	IGC_WRITE_REG(hw, IGC_FCRTH, fcrth);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_force_mac_fc_generic - Force the MAC's flow control settings
- *  @hw: pointer to the HW structure
- *
- *  Force the MAC's flow control settings.  Sets the TFCE and RFCE bits in the
- *  device control register to reflect the adapter settings.  TFCE and RFCE
- *  need to be explicitly set by software when a copper PHY is used because
- *  autonegotiation is managed by the PHY rather than the MAC.  Software must
- *  also configure these bits when link is forced on a fiber connection.
- **/
-s32 igc_force_mac_fc_generic(struct igc_hw *hw)
-{
-	u32 ctrl;
-
-	DEBUGFUNC("igc_force_mac_fc_generic");
-
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-
-	/* Because we didn't get link via the internal auto-negotiation
-	 * mechanism (we either forced link or we got link via PHY
-	 * auto-neg), we have to manually enable/disable transmit an
-	 * receive flow control.
-	 *
-	 * The "Case" statement below enables/disable flow control
-	 * according to the "hw->fc.current_mode" parameter.
-	 *
-	 * The possible values of the "fc" parameter are:
-	 *      0:  Flow control is completely disabled
-	 *      1:  Rx flow control is enabled (we can receive pause
-	 *          frames but not send pause frames).
-	 *      2:  Tx flow control is enabled (we can send pause frames
-	 *          frames but we do not receive pause frames).
-	 *      3:  Both Rx and Tx flow control (symmetric) is enabled.
-	 *  other:  No other values should be possible at this point.
-	 */
-	DEBUGOUT1("hw->fc.current_mode = %u\n", hw->fc.current_mode);
-
-	switch (hw->fc.current_mode) {
-	case igc_fc_none:
-		ctrl &= (~(IGC_CTRL_TFCE | IGC_CTRL_RFCE));
-		break;
-	case igc_fc_rx_pause:
-		ctrl &= (~IGC_CTRL_TFCE);
-		ctrl |= IGC_CTRL_RFCE;
-		break;
-	case igc_fc_tx_pause:
-		ctrl &= (~IGC_CTRL_RFCE);
-		ctrl |= IGC_CTRL_TFCE;
-		break;
-	case igc_fc_full:
-		ctrl |= (IGC_CTRL_TFCE | IGC_CTRL_RFCE);
-		break;
-	default:
-		DEBUGOUT("Flow control param set incorrectly\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_config_fc_after_link_up_generic - Configures flow control after link
- *  @hw: pointer to the HW structure
- *
- *  Checks the status of auto-negotiation after link up to ensure that the
- *  speed and duplex were not forced.  If the link needed to be forced, then
- *  flow control needs to be forced also.  If auto-negotiation is enabled
- *  and did not fail, then we configure flow control based on our link
- *  partner.
- **/
-s32 igc_config_fc_after_link_up_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	s32 ret_val = IGC_SUCCESS;
-	u16 mii_status_reg, mii_nway_adv_reg, mii_nway_lp_ability_reg;
-	u16 speed, duplex;
-
-	DEBUGFUNC("igc_config_fc_after_link_up_generic");
-
-	/* Check for the case where we have fiber media and auto-neg failed
-	 * so we had to force link.  In this case, we need to force the
-	 * configuration of the MAC to match the "fc" parameter.
-	 */
-	if (mac->autoneg_failed) {
-		if (hw->phy.media_type == igc_media_type_copper)
-			ret_val = igc_force_mac_fc_generic(hw);
-	}
-
-	if (ret_val) {
-		DEBUGOUT("Error forcing flow control settings\n");
-		return ret_val;
-	}
-
-	/* Check for the case where we have copper media and auto-neg is
-	 * enabled.  In this case, we need to check and see if Auto-Neg
-	 * has completed, and if so, how the PHY and link partner has
-	 * flow control configured.
-	 */
-	if (hw->phy.media_type == igc_media_type_copper && mac->autoneg) {
-		/* Read the MII Status Register and check to see if AutoNeg
-		 * has completed.  We read this twice because this reg has
-		 * some "sticky" (latched) bits.
-		 */
-		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &mii_status_reg);
-		if (ret_val)
-			return ret_val;
-		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &mii_status_reg);
-		if (ret_val)
-			return ret_val;
-
-		if (!(mii_status_reg & MII_SR_AUTONEG_COMPLETE)) {
-			DEBUGOUT("Copper PHY and Auto Neg has not completed.\n");
-			return ret_val;
-		}
-
-		/* The AutoNeg process has completed, so we now need to
-		 * read both the Auto Negotiation Advertisement
-		 * Register (Address 4) and the Auto_Negotiation Base
-		 * Page Ability Register (Address 5) to determine how
-		 * flow control was negotiated.
-		 */
-		ret_val = hw->phy.ops.read_reg(hw, PHY_AUTONEG_ADV,
-					       &mii_nway_adv_reg);
-		if (ret_val)
-			return ret_val;
-		ret_val = hw->phy.ops.read_reg(hw, PHY_LP_ABILITY,
-					       &mii_nway_lp_ability_reg);
-		if (ret_val)
-			return ret_val;
-
-		/* Two bits in the Auto Negotiation Advertisement Register
-		 * (Address 4) and two bits in the Auto Negotiation Base
-		 * Page Ability Register (Address 5) determine flow control
-		 * for both the PHY and the link partner.  The following
-		 * table, taken out of the IEEE 802.3ab/D6.0 dated March 25,
-		 * 1999, describes these PAUSE resolution bits and how flow
-		 * control is determined based upon these settings.
-		 * NOTE:  DC = Don't Care
-		 *
-		 *   LOCAL DEVICE  |   LINK PARTNER
-		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | NIC Resolution
-		 *-------|---------|-------|---------|--------------------
-		 *   0   |    0    |  DC   |   DC    | igc_fc_none
-		 *   0   |    1    |   0   |   DC    | igc_fc_none
-		 *   0   |    1    |   1   |    0    | igc_fc_none
-		 *   0   |    1    |   1   |    1    | igc_fc_tx_pause
-		 *   1   |    0    |   0   |   DC    | igc_fc_none
-		 *   1   |   DC    |   1   |   DC    | igc_fc_full
-		 *   1   |    1    |   0   |    0    | igc_fc_none
-		 *   1   |    1    |   0   |    1    | igc_fc_rx_pause
-		 *
-		 * Are both PAUSE bits set to 1?  If so, this implies
-		 * Symmetric Flow Control is enabled at both ends.  The
-		 * ASM_DIR bits are irrelevant per the spec.
-		 *
-		 * For Symmetric Flow Control:
-		 *
-		 *   LOCAL DEVICE  |   LINK PARTNER
-		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
-		 *-------|---------|-------|---------|--------------------
-		 *   1   |   DC    |   1   |   DC    | IGC_fc_full
-		 *
-		 */
-		if ((mii_nway_adv_reg & NWAY_AR_PAUSE) &&
-		    (mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE)) {
-			/* Now we need to check if the user selected Rx ONLY
-			 * of pause frames.  In this case, we had to advertise
-			 * FULL flow control because we could not advertise Rx
-			 * ONLY. Hence, we must now check to see if we need to
-			 * turn OFF the TRANSMISSION of PAUSE frames.
-			 */
-			if (hw->fc.requested_mode == igc_fc_full) {
-				hw->fc.current_mode = igc_fc_full;
-				DEBUGOUT("Flow Control = FULL.\n");
-			} else {
-				hw->fc.current_mode = igc_fc_rx_pause;
-				DEBUGOUT("Flow Control = Rx PAUSE frames only.\n");
-			}
-		}
-		/* For receiving PAUSE frames ONLY.
-		 *
-		 *   LOCAL DEVICE  |   LINK PARTNER
-		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
-		 *-------|---------|-------|---------|--------------------
-		 *   0   |    1    |   1   |    1    | igc_fc_tx_pause
-		 */
-		else if (!(mii_nway_adv_reg & NWAY_AR_PAUSE) &&
-			  (mii_nway_adv_reg & NWAY_AR_ASM_DIR) &&
-			  (mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
-			  (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
-			hw->fc.current_mode = igc_fc_tx_pause;
-			DEBUGOUT("Flow Control = Tx PAUSE frames only.\n");
-		}
-		/* For transmitting PAUSE frames ONLY.
-		 *
-		 *   LOCAL DEVICE  |   LINK PARTNER
-		 * PAUSE | ASM_DIR | PAUSE | ASM_DIR | Result
-		 *-------|---------|-------|---------|--------------------
-		 *   1   |    1    |   0   |    1    | igc_fc_rx_pause
-		 */
-		else if ((mii_nway_adv_reg & NWAY_AR_PAUSE) &&
-			 (mii_nway_adv_reg & NWAY_AR_ASM_DIR) &&
-			 !(mii_nway_lp_ability_reg & NWAY_LPAR_PAUSE) &&
-			 (mii_nway_lp_ability_reg & NWAY_LPAR_ASM_DIR)) {
-			hw->fc.current_mode = igc_fc_rx_pause;
-			DEBUGOUT("Flow Control = Rx PAUSE frames only.\n");
-		} else {
-			/* Per the IEEE spec, at this point flow control
-			 * should be disabled.
-			 */
-			hw->fc.current_mode = igc_fc_none;
-			DEBUGOUT("Flow Control = NONE.\n");
-		}
-
-		/* Now we need to do one last check...  If we auto-
-		 * negotiated to HALF DUPLEX, flow control should not be
-		 * enabled per IEEE 802.3 spec.
-		 */
-		ret_val = mac->ops.get_link_up_info(hw, &speed, &duplex);
-		if (ret_val) {
-			DEBUGOUT("Error getting link speed and duplex\n");
-			return ret_val;
-		}
-
-		if (duplex == HALF_DUPLEX)
-			hw->fc.current_mode = igc_fc_none;
-
-		/* Now we call a subroutine to actually force the MAC
-		 * controller to use the correct flow control settings.
-		 */
-		ret_val = igc_force_mac_fc_generic(hw);
-		if (ret_val) {
-			DEBUGOUT("Error forcing flow control settings\n");
-			return ret_val;
-		}
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_get_speed_and_duplex_copper_generic - Retrieve current speed/duplex
- *  @hw: pointer to the HW structure
- *  @speed: stores the current speed
- *  @duplex: stores the current duplex
- *
- *  Read the status register for the current speed/duplex and store the current
- *  speed and duplex for copper connections.
- **/
-s32 igc_get_speed_and_duplex_copper_generic(struct igc_hw *hw, u16 *speed,
-					      u16 *duplex)
-{
-	u32 status;
-
-	DEBUGFUNC("igc_get_speed_and_duplex_copper_generic");
-
-	status = IGC_READ_REG(hw, IGC_STATUS);
-	if (status & IGC_STATUS_SPEED_1000) {
-		/* For I225, STATUS will indicate 1G speed in both 1 Gbps
-		 * and 2.5 Gbps link modes. An additional bit is used
-		 * to differentiate between 1 Gbps and 2.5 Gbps.
-		 */
-		if (hw->mac.type == igc_i225 &&
-		    (status & IGC_STATUS_SPEED_2500)) {
-			*speed = SPEED_2500;
-			DEBUGOUT("2500 Mbs, ");
-		} else {
-			*speed = SPEED_1000;
-			DEBUGOUT("1000 Mbs, ");
-		}
-	} else if (status & IGC_STATUS_SPEED_100) {
-		*speed = SPEED_100;
-		DEBUGOUT("100 Mbs, ");
-	} else {
-		*speed = SPEED_10;
-		DEBUGOUT("10 Mbs, ");
-	}
-
-	if (status & IGC_STATUS_FD) {
-		*duplex = FULL_DUPLEX;
-		DEBUGOUT("Full Duplex\n");
-	} else {
-		*duplex = HALF_DUPLEX;
-		DEBUGOUT("Half Duplex\n");
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_get_speed_and_duplex_fiber_generic - Retrieve current speed/duplex
- *  @hw: pointer to the HW structure
- *  @speed: stores the current speed
- *  @duplex: stores the current duplex
- *
- *  Sets the speed and duplex to gigabit full duplex (the only possible option)
- *  for fiber/serdes links.
- **/
-s32
-igc_get_speed_and_duplex_fiber_serdes_generic(struct igc_hw *hw,
-				u16 *speed, u16 *duplex)
-{
-	DEBUGFUNC("igc_get_speed_and_duplex_fiber_serdes_generic");
-	UNREFERENCED_1PARAMETER(hw);
-
-	*speed = SPEED_1000;
-	*duplex = FULL_DUPLEX;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_get_hw_semaphore_generic - Acquire hardware semaphore
- *  @hw: pointer to the HW structure
- *
- *  Acquire the HW semaphore to access the PHY or NVM
- **/
-s32 igc_get_hw_semaphore_generic(struct igc_hw *hw)
-{
-	u32 swsm;
-	s32 timeout = hw->nvm.word_size + 1;
-	s32 i = 0;
-
-	DEBUGFUNC("igc_get_hw_semaphore_generic");
-
-	/* Get the SW semaphore */
-	while (i < timeout) {
-		swsm = IGC_READ_REG(hw, IGC_SWSM);
-		if (!(swsm & IGC_SWSM_SMBI))
-			break;
-
-		usec_delay(50);
-		i++;
-	}
-
-	if (i == timeout) {
-		DEBUGOUT("Driver can't access device - SMBI bit is set.\n");
-		return -IGC_ERR_NVM;
-	}
-
-	/* Get the FW semaphore. */
-	for (i = 0; i < timeout; i++) {
-		swsm = IGC_READ_REG(hw, IGC_SWSM);
-		IGC_WRITE_REG(hw, IGC_SWSM, swsm | IGC_SWSM_SWESMBI);
-
-		/* Semaphore acquired if bit latched */
-		if (IGC_READ_REG(hw, IGC_SWSM) & IGC_SWSM_SWESMBI)
-			break;
-
-		usec_delay(50);
-	}
-
-	if (i == timeout) {
-		/* Release semaphores */
-		igc_put_hw_semaphore_generic(hw);
-		DEBUGOUT("Driver can't access the NVM\n");
-		return -IGC_ERR_NVM;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_put_hw_semaphore_generic - Release hardware semaphore
- *  @hw: pointer to the HW structure
- *
- *  Release hardware semaphore used to access the PHY or NVM
- **/
-void igc_put_hw_semaphore_generic(struct igc_hw *hw)
-{
-	u32 swsm;
-
-	DEBUGFUNC("igc_put_hw_semaphore_generic");
-
-	swsm = IGC_READ_REG(hw, IGC_SWSM);
-
-	swsm &= ~(IGC_SWSM_SMBI | IGC_SWSM_SWESMBI);
-
-	IGC_WRITE_REG(hw, IGC_SWSM, swsm);
-}
-
-/**
- *  igc_get_auto_rd_done_generic - Check for auto read completion
- *  @hw: pointer to the HW structure
- *
- *  Check EEPROM for Auto Read done bit.
- **/
-s32 igc_get_auto_rd_done_generic(struct igc_hw *hw)
-{
-	s32 i = 0;
-
-	DEBUGFUNC("igc_get_auto_rd_done_generic");
-
-	while (i < AUTO_READ_DONE_TIMEOUT) {
-		if (IGC_READ_REG(hw, IGC_EECD) & IGC_EECD_AUTO_RD)
-			break;
-		msec_delay(1);
-		i++;
-	}
-
-	if (i == AUTO_READ_DONE_TIMEOUT) {
-		DEBUGOUT("Auto read by HW from NVM has not completed.\n");
-		return -IGC_ERR_RESET;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_valid_led_default_generic - Verify a valid default LED config
- *  @hw: pointer to the HW structure
- *  @data: pointer to the NVM (EEPROM)
- *
- *  Read the EEPROM for the current default LED configuration.  If the
- *  LED configuration is not valid, set to a valid LED configuration.
- **/
-s32 igc_valid_led_default_generic(struct igc_hw *hw, u16 *data)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("igc_valid_led_default_generic");
-
-	ret_val = hw->nvm.ops.read(hw, NVM_ID_LED_SETTINGS, 1, data);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-
-	if (*data == ID_LED_RESERVED_0000 || *data == ID_LED_RESERVED_FFFF)
-		*data = ID_LED_DEFAULT;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_id_led_init_generic -
- *  @hw: pointer to the HW structure
- *
- **/
-s32 igc_id_led_init_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	s32 ret_val;
-	const u32 ledctl_mask = 0x000000FF;
-	const u32 ledctl_on = IGC_LEDCTL_MODE_LED_ON;
-	const u32 ledctl_off = IGC_LEDCTL_MODE_LED_OFF;
-	u16 data, i, temp;
-	const u16 led_mask = 0x0F;
-
-	DEBUGFUNC("igc_id_led_init_generic");
-
-	ret_val = hw->nvm.ops.valid_led_default(hw, &data);
-	if (ret_val)
-		return ret_val;
-
-	mac->ledctl_default = IGC_READ_REG(hw, IGC_LEDCTL);
-	mac->ledctl_mode1 = mac->ledctl_default;
-	mac->ledctl_mode2 = mac->ledctl_default;
-
-	for (i = 0; i < 4; i++) {
-		temp = (data >> (i << 2)) & led_mask;
-		switch (temp) {
-		case ID_LED_ON1_DEF2:
-		case ID_LED_ON1_ON2:
-		case ID_LED_ON1_OFF2:
-			mac->ledctl_mode1 &= ~(ledctl_mask << (i << 3));
-			mac->ledctl_mode1 |= ledctl_on << (i << 3);
-			break;
-		case ID_LED_OFF1_DEF2:
-		case ID_LED_OFF1_ON2:
-		case ID_LED_OFF1_OFF2:
-			mac->ledctl_mode1 &= ~(ledctl_mask << (i << 3));
-			mac->ledctl_mode1 |= ledctl_off << (i << 3);
-			break;
-		default:
-			/* Do nothing */
-			break;
-		}
-		switch (temp) {
-		case ID_LED_DEF1_ON2:
-		case ID_LED_ON1_ON2:
-		case ID_LED_OFF1_ON2:
-			mac->ledctl_mode2 &= ~(ledctl_mask << (i << 3));
-			mac->ledctl_mode2 |= ledctl_on << (i << 3);
-			break;
-		case ID_LED_DEF1_OFF2:
-		case ID_LED_ON1_OFF2:
-		case ID_LED_OFF1_OFF2:
-			mac->ledctl_mode2 &= ~(ledctl_mask << (i << 3));
-			mac->ledctl_mode2 |= ledctl_off << (i << 3);
-			break;
-		default:
-			/* Do nothing */
-			break;
-		}
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_setup_led_generic - Configures SW controllable LED
- *  @hw: pointer to the HW structure
- *
- *  This prepares the SW controllable LED for use and saves the current state
- *  of the LED so it can be later restored.
- **/
-s32 igc_setup_led_generic(struct igc_hw *hw)
-{
-	u32 ledctl;
-
-	DEBUGFUNC("igc_setup_led_generic");
-
-	if (hw->mac.ops.setup_led != igc_setup_led_generic)
-		return -IGC_ERR_CONFIG;
-
-	if (hw->phy.media_type == igc_media_type_fiber) {
-		ledctl = IGC_READ_REG(hw, IGC_LEDCTL);
-		hw->mac.ledctl_default = ledctl;
-		/* Turn off LED0 */
-		ledctl &= ~(IGC_LEDCTL_LED0_IVRT | IGC_LEDCTL_LED0_BLINK |
-			    IGC_LEDCTL_LED0_MODE_MASK);
-		ledctl |= (IGC_LEDCTL_MODE_LED_OFF <<
-			   IGC_LEDCTL_LED0_MODE_SHIFT);
-		IGC_WRITE_REG(hw, IGC_LEDCTL, ledctl);
-	} else if (hw->phy.media_type == igc_media_type_copper) {
-		IGC_WRITE_REG(hw, IGC_LEDCTL, hw->mac.ledctl_mode1);
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_cleanup_led_generic - Set LED config to default operation
- *  @hw: pointer to the HW structure
- *
- *  Remove the current LED configuration and set the LED configuration
- *  to the default value, saved from the EEPROM.
- **/
-s32 igc_cleanup_led_generic(struct igc_hw *hw)
-{
-	DEBUGFUNC("igc_cleanup_led_generic");
-
-	IGC_WRITE_REG(hw, IGC_LEDCTL, hw->mac.ledctl_default);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_blink_led_generic - Blink LED
- *  @hw: pointer to the HW structure
- *
- *  Blink the LEDs which are set to be on.
- **/
-s32 igc_blink_led_generic(struct igc_hw *hw)
-{
-	u32 ledctl_blink = 0;
-	u32 i;
-
-	DEBUGFUNC("igc_blink_led_generic");
-
-	if (hw->phy.media_type == igc_media_type_fiber) {
-		/* always blink LED0 for PCI-E fiber */
-		ledctl_blink = IGC_LEDCTL_LED0_BLINK |
-		     (IGC_LEDCTL_MODE_LED_ON << IGC_LEDCTL_LED0_MODE_SHIFT);
-	} else {
-		/* Set the blink bit for each LED that's "on" (0x0E)
-		 * (or "off" if inverted) in ledctl_mode2.  The blink
-		 * logic in hardware only works when mode is set to "on"
-		 * so it must be changed accordingly when the mode is
-		 * "off" and inverted.
-		 */
-		ledctl_blink = hw->mac.ledctl_mode2;
-		for (i = 0; i < 32; i += 8) {
-			u32 mode = (hw->mac.ledctl_mode2 >> i) &
-			    IGC_LEDCTL_LED0_MODE_MASK;
-			u32 led_default = hw->mac.ledctl_default >> i;
-
-			if ((!(led_default & IGC_LEDCTL_LED0_IVRT) &&
-			     mode == IGC_LEDCTL_MODE_LED_ON) ||
-			    ((led_default & IGC_LEDCTL_LED0_IVRT) &&
-			     mode == IGC_LEDCTL_MODE_LED_OFF)) {
-				ledctl_blink &=
-				    ~(IGC_LEDCTL_LED0_MODE_MASK << i);
-				ledctl_blink |= (IGC_LEDCTL_LED0_BLINK |
-						 IGC_LEDCTL_MODE_LED_ON) << i;
-			}
-		}
-	}
-
-	IGC_WRITE_REG(hw, IGC_LEDCTL, ledctl_blink);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_led_on_generic - Turn LED on
- *  @hw: pointer to the HW structure
- *
- *  Turn LED on.
- **/
-s32 igc_led_on_generic(struct igc_hw *hw)
-{
-	u32 ctrl;
-
-	DEBUGFUNC("igc_led_on_generic");
-
-	switch (hw->phy.media_type) {
-	case igc_media_type_fiber:
-		ctrl = IGC_READ_REG(hw, IGC_CTRL);
-		ctrl &= ~IGC_CTRL_SWDPIN0;
-		ctrl |= IGC_CTRL_SWDPIO0;
-		IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-		break;
-	case igc_media_type_copper:
-		IGC_WRITE_REG(hw, IGC_LEDCTL, hw->mac.ledctl_mode2);
-		break;
-	default:
-		break;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_led_off_generic - Turn LED off
- *  @hw: pointer to the HW structure
- *
- *  Turn LED off.
- **/
-s32 igc_led_off_generic(struct igc_hw *hw)
-{
-	u32 ctrl;
-
-	DEBUGFUNC("igc_led_off_generic");
-
-	switch (hw->phy.media_type) {
-	case igc_media_type_fiber:
-		ctrl = IGC_READ_REG(hw, IGC_CTRL);
-		ctrl |= IGC_CTRL_SWDPIN0;
-		ctrl |= IGC_CTRL_SWDPIO0;
-		IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-		break;
-	case igc_media_type_copper:
-		IGC_WRITE_REG(hw, IGC_LEDCTL, hw->mac.ledctl_mode1);
-		break;
-	default:
-		break;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_set_pcie_no_snoop_generic - Set PCI-express capabilities
- *  @hw: pointer to the HW structure
- *  @no_snoop: bitmap of snoop events
- *
- *  Set the PCI-express register to snoop for events enabled in 'no_snoop'.
- **/
-void igc_set_pcie_no_snoop_generic(struct igc_hw *hw, u32 no_snoop)
-{
-	u32 gcr;
-
-	DEBUGFUNC("igc_set_pcie_no_snoop_generic");
-
-	if (hw->bus.type != igc_bus_type_pci_express)
-		return;
-
-	if (no_snoop) {
-		gcr = IGC_READ_REG(hw, IGC_GCR);
-		gcr &= ~(PCIE_NO_SNOOP_ALL);
-		gcr |= no_snoop;
-		IGC_WRITE_REG(hw, IGC_GCR, gcr);
-	}
-}
-
-/**
- *  igc_disable_pcie_master_generic - Disables PCI-express master access
- *  @hw: pointer to the HW structure
- *
- *  Returns IGC_SUCCESS if successful, else returns -10
- *  (-IGC_ERR_MASTER_REQUESTS_PENDING) if master disable bit has not caused
- *  the master requests to be disabled.
- *
- *  Disables PCI-Express master access and verifies there are no pending
- *  requests.
- **/
-s32 igc_disable_pcie_master_generic(struct igc_hw *hw)
-{
-	u32 ctrl;
-	s32 timeout = MASTER_DISABLE_TIMEOUT;
-
-	DEBUGFUNC("igc_disable_pcie_master_generic");
-
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-	ctrl |= IGC_CTRL_GIO_MASTER_DISABLE;
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-
-	while (timeout) {
-		if (!(IGC_READ_REG(hw, IGC_STATUS) &
-		      IGC_STATUS_GIO_MASTER_ENABLE) ||
-				IGC_REMOVED(hw->hw_addr))
-			break;
-		usec_delay(100);
-		timeout--;
-	}
-
-	if (!timeout) {
-		DEBUGOUT("Master requests are pending.\n");
-		return -IGC_ERR_MASTER_REQUESTS_PENDING;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_reset_adaptive_generic - Reset Adaptive Interframe Spacing
- *  @hw: pointer to the HW structure
- *
- *  Reset the Adaptive Interframe Spacing throttle to default values.
- **/
-void igc_reset_adaptive_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-
-	DEBUGFUNC("igc_reset_adaptive_generic");
-
-	if (!mac->adaptive_ifs) {
-		DEBUGOUT("Not in Adaptive IFS mode!\n");
-		return;
-	}
-
-	mac->current_ifs_val = 0;
-	mac->ifs_min_val = IFS_MIN;
-	mac->ifs_max_val = IFS_MAX;
-	mac->ifs_step_size = IFS_STEP;
-	mac->ifs_ratio = IFS_RATIO;
-
-	mac->in_ifs_mode = false;
-	IGC_WRITE_REG(hw, IGC_AIT, 0);
-}
-
-/**
- *  igc_update_adaptive_generic - Update Adaptive Interframe Spacing
- *  @hw: pointer to the HW structure
- *
- *  Update the Adaptive Interframe Spacing Throttle value based on the
- *  time between transmitted packets and time between collisions.
- **/
-void igc_update_adaptive_generic(struct igc_hw *hw)
-{
-	struct igc_mac_info *mac = &hw->mac;
-
-	DEBUGFUNC("igc_update_adaptive_generic");
-
-	if (!mac->adaptive_ifs) {
-		DEBUGOUT("Not in Adaptive IFS mode!\n");
-		return;
-	}
-
-	if ((mac->collision_delta * mac->ifs_ratio) > mac->tx_packet_delta) {
-		if (mac->tx_packet_delta > MIN_NUM_XMITS) {
-			mac->in_ifs_mode = true;
-			if (mac->current_ifs_val < mac->ifs_max_val) {
-				if (!mac->current_ifs_val)
-					mac->current_ifs_val = mac->ifs_min_val;
-				else
-					mac->current_ifs_val +=
-						mac->ifs_step_size;
-				IGC_WRITE_REG(hw, IGC_AIT,
-						mac->current_ifs_val);
-			}
-		}
-	} else {
-		if (mac->in_ifs_mode &&
-		    mac->tx_packet_delta <= MIN_NUM_XMITS) {
-			mac->current_ifs_val = 0;
-			mac->in_ifs_mode = false;
-			IGC_WRITE_REG(hw, IGC_AIT, 0);
-		}
-	}
-}
-
-/**
- *  igc_validate_mdi_setting_generic - Verify MDI/MDIx settings
- *  @hw: pointer to the HW structure
- *
- *  Verify that when not using auto-negotiation that MDI/MDIx is correctly
- *  set, which is forced to MDI mode only.
- **/
-static s32 igc_validate_mdi_setting_generic(struct igc_hw *hw)
-{
-	DEBUGFUNC("igc_validate_mdi_setting_generic");
-
-	if (!hw->mac.autoneg && (hw->phy.mdix == 0 || hw->phy.mdix == 3)) {
-		DEBUGOUT("Invalid MDI setting detected\n");
-		hw->phy.mdix = 1;
-		return -IGC_ERR_CONFIG;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_validate_mdi_setting_crossover_generic - Verify MDI/MDIx settings
- *  @hw: pointer to the HW structure
- *
- *  Validate the MDI/MDIx setting, allowing for auto-crossover during forced
- *  operation.
- **/
-s32
-igc_validate_mdi_setting_crossover_generic(struct igc_hw IGC_UNUSEDARG * hw)
-{
-	DEBUGFUNC("igc_validate_mdi_setting_crossover_generic");
-	UNREFERENCED_1PARAMETER(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_8bit_ctrl_reg_generic - Write a 8bit CTRL register
- *  @hw: pointer to the HW structure
- *  @reg: 32bit register offset such as IGC_SCTL
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Writes an address/data control type register.  There are several of these
- *  and they all have the format address << 8 | data and bit 31 is polled for
- *  completion.
- **/
-s32 igc_write_8bit_ctrl_reg_generic(struct igc_hw *hw, u32 reg,
-				      u32 offset, u8 data)
-{
-	u32 i, regvalue = 0;
-
-	DEBUGFUNC("igc_write_8bit_ctrl_reg_generic");
-
-	/* Set up the address and data */
-	regvalue = ((u32)data) | (offset << IGC_GEN_CTL_ADDRESS_SHIFT);
-	IGC_WRITE_REG(hw, reg, regvalue);
-
-	/* Poll the ready bit to see if the MDI read completed */
-	for (i = 0; i < IGC_GEN_POLL_TIMEOUT; i++) {
-		usec_delay(5);
-		regvalue = IGC_READ_REG(hw, reg);
-		if (regvalue & IGC_GEN_CTL_READY)
-			break;
-	}
-	if (!(regvalue & IGC_GEN_CTL_READY)) {
-		DEBUGOUT1("Reg %08x did not indicate ready\n", reg);
-		return -IGC_ERR_PHY;
-	}
-
-	return IGC_SUCCESS;
-}
diff --git a/drivers/net/intel/igc/base/igc_mac.h b/drivers/net/intel/igc/base/igc_mac.h
deleted file mode 100644
index 035a371e1e..0000000000
--- a/drivers/net/intel/igc/base/igc_mac.h
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_MAC_H_
-#define _IGC_MAC_H_
-
-void igc_init_mac_ops_generic(struct igc_hw *hw);
-#define IGC_REMOVED(a) (0)
-void igc_null_mac_generic(struct igc_hw *hw);
-s32  igc_null_ops_generic(struct igc_hw *hw);
-s32  igc_null_link_info(struct igc_hw *hw, u16 *s, u16 *d);
-bool igc_null_mng_mode(struct igc_hw *hw);
-void igc_null_update_mc(struct igc_hw *hw, u8 *h, u32 a);
-void igc_null_write_vfta(struct igc_hw *hw, u32 a, u32 b);
-int  igc_null_rar_set(struct igc_hw *hw, u8 *h, u32 a);
-s32  igc_blink_led_generic(struct igc_hw *hw);
-s32  igc_check_for_copper_link_generic(struct igc_hw *hw);
-s32  igc_check_for_fiber_link_generic(struct igc_hw *hw);
-s32  igc_check_for_serdes_link_generic(struct igc_hw *hw);
-s32  igc_cleanup_led_generic(struct igc_hw *hw);
-s32  igc_commit_fc_settings_generic(struct igc_hw *hw);
-s32  igc_poll_fiber_serdes_link_generic(struct igc_hw *hw);
-s32  igc_config_fc_after_link_up_generic(struct igc_hw *hw);
-s32  igc_disable_pcie_master_generic(struct igc_hw *hw);
-s32  igc_force_mac_fc_generic(struct igc_hw *hw);
-s32  igc_get_auto_rd_done_generic(struct igc_hw *hw);
-s32  igc_get_bus_info_pci_generic(struct igc_hw *hw);
-s32  igc_get_bus_info_pcie_generic(struct igc_hw *hw);
-void igc_set_lan_id_single_port(struct igc_hw *hw);
-void igc_set_lan_id_multi_port_pci(struct igc_hw *hw);
-s32  igc_get_hw_semaphore_generic(struct igc_hw *hw);
-s32  igc_get_speed_and_duplex_copper_generic(struct igc_hw *hw, u16 *speed,
-					       u16 *duplex);
-s32  igc_get_speed_and_duplex_fiber_serdes_generic(struct igc_hw *hw,
-						     u16 *speed, u16 *duplex);
-s32  igc_id_led_init_generic(struct igc_hw *hw);
-s32  igc_led_on_generic(struct igc_hw *hw);
-s32  igc_led_off_generic(struct igc_hw *hw);
-void igc_update_mc_addr_list_generic(struct igc_hw *hw,
-				       u8 *mc_addr_list, u32 mc_addr_count);
-s32  igc_set_default_fc_generic(struct igc_hw *hw);
-s32  igc_set_fc_watermarks_generic(struct igc_hw *hw);
-s32  igc_setup_fiber_serdes_link_generic(struct igc_hw *hw);
-s32  igc_setup_led_generic(struct igc_hw *hw);
-s32  igc_setup_link_generic(struct igc_hw *hw);
-s32  igc_validate_mdi_setting_crossover_generic(struct igc_hw *hw);
-s32  igc_write_8bit_ctrl_reg_generic(struct igc_hw *hw, u32 reg,
-				       u32 offset, u8 data);
-
-u32  igc_hash_mc_addr_generic(struct igc_hw *hw, u8 *mc_addr);
-
-void igc_clear_hw_cntrs_base_generic(struct igc_hw *hw);
-void igc_clear_vfta_generic(struct igc_hw *hw);
-void igc_init_rx_addrs_generic(struct igc_hw *hw, u16 rar_count);
-void igc_pcix_mmrbc_workaround_generic(struct igc_hw *hw);
-void igc_put_hw_semaphore_generic(struct igc_hw *hw);
-s32  igc_check_alt_mac_addr_generic(struct igc_hw *hw);
-void igc_reset_adaptive_generic(struct igc_hw *hw);
-void igc_set_pcie_no_snoop_generic(struct igc_hw *hw, u32 no_snoop);
-void igc_update_adaptive_generic(struct igc_hw *hw);
-void igc_write_vfta_generic(struct igc_hw *hw, u32 offset, u32 value);
-
-#endif
diff --git a/drivers/net/intel/igc/base/igc_manage.c b/drivers/net/intel/igc/base/igc_manage.c
deleted file mode 100644
index 563ab81603..0000000000
--- a/drivers/net/intel/igc/base/igc_manage.c
+++ /dev/null
@@ -1,547 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#include "igc_api.h"
-#include "igc_manage.h"
-
-/**
- *  igc_calculate_checksum - Calculate checksum for buffer
- *  @buffer: pointer to EEPROM
- *  @length: size of EEPROM to calculate a checksum for
- *
- *  Calculates the checksum for some buffer on a specified length.  The
- *  checksum calculated is returned.
- **/
-u8 igc_calculate_checksum(u8 *buffer, u32 length)
-{
-	u32 i;
-	u8 sum = 0;
-
-	DEBUGFUNC("igc_calculate_checksum");
-
-	if (!buffer)
-		return 0;
-
-	for (i = 0; i < length; i++)
-		sum += buffer[i];
-
-	return (u8)(0 - sum);
-}
-
-/**
- *  igc_mng_enable_host_if_generic - Checks host interface is enabled
- *  @hw: pointer to the HW structure
- *
- *  Returns IGC_success upon success, else IGC_ERR_HOST_INTERFACE_COMMAND
- *
- *  This function checks whether the HOST IF is enabled for command operation
- *  and also checks whether the previous command is completed.  It busy waits
- *  in case of previous command is not completed.
- **/
-s32 igc_mng_enable_host_if_generic(struct igc_hw *hw)
-{
-	u32 hicr;
-	u8 i;
-
-	DEBUGFUNC("igc_mng_enable_host_if_generic");
-
-	if (!hw->mac.arc_subsystem_valid) {
-		DEBUGOUT("ARC subsystem not valid.\n");
-		return -IGC_ERR_HOST_INTERFACE_COMMAND;
-	}
-
-	/* Check that the host interface is enabled. */
-	hicr = IGC_READ_REG(hw, IGC_HICR);
-	if (!(hicr & IGC_HICR_EN)) {
-		DEBUGOUT("IGC_HOST_EN bit disabled.\n");
-		return -IGC_ERR_HOST_INTERFACE_COMMAND;
-	}
-	/* check the previous command is completed */
-	for (i = 0; i < IGC_MNG_DHCP_COMMAND_TIMEOUT; i++) {
-		hicr = IGC_READ_REG(hw, IGC_HICR);
-		if (!(hicr & IGC_HICR_C))
-			break;
-		msec_delay_irq(1);
-	}
-
-	if (i == IGC_MNG_DHCP_COMMAND_TIMEOUT) {
-		DEBUGOUT("Previous command timeout failed .\n");
-		return -IGC_ERR_HOST_INTERFACE_COMMAND;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_check_mng_mode_generic - Generic check management mode
- *  @hw: pointer to the HW structure
- *
- *  Reads the firmware semaphore register and returns true (>0) if
- *  manageability is enabled, else false (0).
- **/
-bool igc_check_mng_mode_generic(struct igc_hw *hw)
-{
-	u32 fwsm = IGC_READ_REG(hw, IGC_FWSM);
-
-	DEBUGFUNC("igc_check_mng_mode_generic");
-
-
-	return (fwsm & IGC_FWSM_MODE_MASK) ==
-		(IGC_MNG_IAMT_MODE << IGC_FWSM_MODE_SHIFT);
-}
-
-/**
- *  igc_enable_tx_pkt_filtering_generic - Enable packet filtering on Tx
- *  @hw: pointer to the HW structure
- *
- *  Enables packet filtering on transmit packets if manageability is enabled
- *  and host interface is enabled.
- **/
-bool igc_enable_tx_pkt_filtering_generic(struct igc_hw *hw)
-{
-	struct igc_host_mng_dhcp_cookie *hdr = &hw->mng_cookie;
-	u32 *buffer = (u32 *)&hw->mng_cookie;
-	u32 offset;
-	s32 ret_val, hdr_csum, csum;
-	u8 i, len;
-
-	DEBUGFUNC("igc_enable_tx_pkt_filtering_generic");
-
-	hw->mac.tx_pkt_filtering = true;
-
-	/* No manageability, no filtering */
-	if (!hw->mac.ops.check_mng_mode(hw)) {
-		hw->mac.tx_pkt_filtering = false;
-		return hw->mac.tx_pkt_filtering;
-	}
-
-	/* If we can't read from the host interface for whatever
-	 * reason, disable filtering.
-	 */
-	ret_val = igc_mng_enable_host_if_generic(hw);
-	if (ret_val != IGC_SUCCESS) {
-		hw->mac.tx_pkt_filtering = false;
-		return hw->mac.tx_pkt_filtering;
-	}
-
-	/* Read in the header.  Length and offset are in dwords. */
-	len    = IGC_MNG_DHCP_COOKIE_LENGTH >> 2;
-	offset = IGC_MNG_DHCP_COOKIE_OFFSET >> 2;
-	for (i = 0; i < len; i++)
-		*(buffer + i) = IGC_READ_REG_ARRAY_DWORD(hw, IGC_HOST_IF,
-							   offset + i);
-	hdr_csum = hdr->checksum;
-	hdr->checksum = 0;
-	csum = igc_calculate_checksum((u8 *)hdr,
-					IGC_MNG_DHCP_COOKIE_LENGTH);
-	/* If either the checksums or signature don't match, then
-	 * the cookie area isn't considered valid, in which case we
-	 * take the safe route of assuming Tx filtering is enabled.
-	 */
-	if (hdr_csum != csum || hdr->signature != IGC_IAMT_SIGNATURE) {
-		hw->mac.tx_pkt_filtering = true;
-		return hw->mac.tx_pkt_filtering;
-	}
-
-	/* Cookie area is valid, make the final check for filtering. */
-	if (!(hdr->status & IGC_MNG_DHCP_COOKIE_STATUS_PARSING))
-		hw->mac.tx_pkt_filtering = false;
-
-	return hw->mac.tx_pkt_filtering;
-}
-
-/**
- *  igc_mng_write_cmd_header_generic - Writes manageability command header
- *  @hw: pointer to the HW structure
- *  @hdr: pointer to the host interface command header
- *
- *  Writes the command header after does the checksum calculation.
- **/
-s32 igc_mng_write_cmd_header_generic(struct igc_hw *hw,
-				      struct igc_host_mng_command_header *hdr)
-{
-	u16 i, length = sizeof(struct igc_host_mng_command_header);
-
-	DEBUGFUNC("igc_mng_write_cmd_header_generic");
-
-	/* Write the whole command header structure with new checksum. */
-
-	hdr->checksum = igc_calculate_checksum((u8 *)hdr, length);
-
-	length >>= 2;
-	/* Write the relevant command block into the ram area. */
-	for (i = 0; i < length; i++) {
-		IGC_WRITE_REG_ARRAY_DWORD(hw, IGC_HOST_IF, i,
-					*((u32 *)hdr + i));
-		IGC_WRITE_FLUSH(hw);
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_mng_host_if_write_generic - Write to the manageability host interface
- *  @hw: pointer to the HW structure
- *  @buffer: pointer to the host interface buffer
- *  @length: size of the buffer
- *  @offset: location in the buffer to write to
- *  @sum: sum of the data (not checksum)
- *
- *  This function writes the buffer content at the offset given on the host if.
- *  It also does alignment considerations to do the writes in most efficient
- *  way.  Also fills up the sum of the buffer in *buffer parameter.
- **/
-s32 igc_mng_host_if_write_generic(struct igc_hw *hw, u8 *buffer,
-				    u16 length, u16 offset, u8 *sum)
-{
-	u8 *tmp;
-	u8 *bufptr = buffer;
-	u32 data = 0;
-	u16 remaining, i, j, prev_bytes;
-
-	DEBUGFUNC("igc_mng_host_if_write_generic");
-
-	/* sum = only sum of the data and it is not checksum */
-
-	if (length == 0 || offset + length > IGC_HI_MAX_MNG_DATA_LENGTH)
-		return -IGC_ERR_PARAM;
-
-	tmp = (u8 *)&data;
-	prev_bytes = offset & 0x3;
-	offset >>= 2;
-
-	if (prev_bytes) {
-		data = IGC_READ_REG_ARRAY_DWORD(hw, IGC_HOST_IF, offset);
-		for (j = prev_bytes; j < sizeof(u32); j++) {
-			*(tmp + j) = *bufptr++;
-			*sum += *(tmp + j);
-		}
-		IGC_WRITE_REG_ARRAY_DWORD(hw, IGC_HOST_IF, offset, data);
-		length -= j - prev_bytes;
-		offset++;
-	}
-
-	remaining = length & 0x3;
-	length -= remaining;
-
-	/* Calculate length in DWORDs */
-	length >>= 2;
-
-	/* The device driver writes the relevant command block into the
-	 * ram area.
-	 */
-	for (i = 0; i < length; i++) {
-		for (j = 0; j < sizeof(u32); j++) {
-			*(tmp + j) = *bufptr++;
-			*sum += *(tmp + j);
-		}
-
-		IGC_WRITE_REG_ARRAY_DWORD(hw, IGC_HOST_IF, offset + i,
-					    data);
-	}
-	if (remaining) {
-		for (j = 0; j < sizeof(u32); j++) {
-			if (j < remaining)
-				*(tmp + j) = *bufptr++;
-			else
-				*(tmp + j) = 0;
-
-			*sum += *(tmp + j);
-		}
-		IGC_WRITE_REG_ARRAY_DWORD(hw, IGC_HOST_IF, offset + i,
-					    data);
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_mng_write_dhcp_info_generic - Writes DHCP info to host interface
- *  @hw: pointer to the HW structure
- *  @buffer: pointer to the host interface
- *  @length: size of the buffer
- *
- *  Writes the DHCP information to the host interface.
- **/
-s32 igc_mng_write_dhcp_info_generic(struct igc_hw *hw, u8 *buffer,
-				      u16 length)
-{
-	struct igc_host_mng_command_header hdr;
-	s32 ret_val;
-	u32 hicr;
-
-	DEBUGFUNC("igc_mng_write_dhcp_info_generic");
-
-	hdr.command_id = IGC_MNG_DHCP_TX_PAYLOAD_CMD;
-	hdr.command_length = length;
-	hdr.reserved1 = 0;
-	hdr.reserved2 = 0;
-	hdr.checksum = 0;
-
-	/* Enable the host interface */
-	ret_val = igc_mng_enable_host_if_generic(hw);
-	if (ret_val)
-		return ret_val;
-
-	/* Populate the host interface with the contents of "buffer". */
-	ret_val = igc_mng_host_if_write_generic(hw, buffer, length,
-						sizeof(hdr), &hdr.checksum);
-	if (ret_val)
-		return ret_val;
-
-	/* Write the manageability command header */
-	ret_val = igc_mng_write_cmd_header_generic(hw, &hdr);
-	if (ret_val)
-		return ret_val;
-
-	/* Tell the ARC a new command is pending. */
-	hicr = IGC_READ_REG(hw, IGC_HICR);
-	IGC_WRITE_REG(hw, IGC_HICR, hicr | IGC_HICR_C);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_enable_mng_pass_thru - Check if management passthrough is needed
- *  @hw: pointer to the HW structure
- *
- *  Verifies the hardware needs to leave interface enabled so that frames can
- *  be directed to and from the management interface.
- **/
-bool igc_enable_mng_pass_thru(struct igc_hw *hw)
-{
-	u32 manc;
-	u32 fwsm, factps;
-
-	DEBUGFUNC("igc_enable_mng_pass_thru");
-
-	if (!hw->mac.asf_firmware_present)
-		return false;
-
-	manc = IGC_READ_REG(hw, IGC_MANC);
-
-	if (!(manc & IGC_MANC_RCV_TCO_EN))
-		return false;
-
-	if (hw->mac.has_fwsm) {
-		fwsm = IGC_READ_REG(hw, IGC_FWSM);
-		factps = IGC_READ_REG(hw, IGC_FACTPS);
-
-		if (!(factps & IGC_FACTPS_MNGCG) &&
-		    ((fwsm & IGC_FWSM_MODE_MASK) ==
-		     (igc_mng_mode_pt << IGC_FWSM_MODE_SHIFT)))
-			return true;
-	} else if ((hw->mac.type == igc_82574) ||
-		   (hw->mac.type == igc_82583)) {
-		u16 data;
-		s32 ret_val;
-
-		factps = IGC_READ_REG(hw, IGC_FACTPS);
-		ret_val = igc_read_nvm(hw, NVM_INIT_CONTROL2_REG, 1, &data);
-		if (ret_val)
-			return false;
-
-		if (!(factps & IGC_FACTPS_MNGCG) &&
-		    ((data & IGC_NVM_INIT_CTRL2_MNGM) ==
-		     (igc_mng_mode_pt << 13)))
-			return true;
-	} else if ((manc & IGC_MANC_SMBUS_EN) &&
-		   !(manc & IGC_MANC_ASF_EN)) {
-		return true;
-	}
-
-	return false;
-}
-
-/**
- *  igc_host_interface_command - Writes buffer to host interface
- *  @hw: pointer to the HW structure
- *  @buffer: contains a command to write
- *  @length: the byte length of the buffer, must be multiple of 4 bytes
- *
- *  Writes a buffer to the Host Interface.  Upon success, returns IGC_SUCCESS
- *  else returns IGC_ERR_HOST_INTERFACE_COMMAND.
- **/
-s32 igc_host_interface_command(struct igc_hw *hw, u8 *buffer, u32 length)
-{
-	u32 hicr, i;
-
-	DEBUGFUNC("igc_host_interface_command");
-
-	if (!(hw->mac.arc_subsystem_valid)) {
-		DEBUGOUT("Hardware doesn't support host interface command.\n");
-		return IGC_SUCCESS;
-	}
-
-	if (!hw->mac.asf_firmware_present) {
-		DEBUGOUT("Firmware is not present.\n");
-		return IGC_SUCCESS;
-	}
-
-	if (length == 0 || length & 0x3 ||
-	    length > IGC_HI_MAX_BLOCK_BYTE_LENGTH) {
-		DEBUGOUT("Buffer length failure.\n");
-		return -IGC_ERR_HOST_INTERFACE_COMMAND;
-	}
-
-	/* Check that the host interface is enabled. */
-	hicr = IGC_READ_REG(hw, IGC_HICR);
-	if (!(hicr & IGC_HICR_EN)) {
-		DEBUGOUT("IGC_HOST_EN bit disabled.\n");
-		return -IGC_ERR_HOST_INTERFACE_COMMAND;
-	}
-
-	/* Calculate length in DWORDs */
-	length >>= 2;
-
-	/* The device driver writes the relevant command block
-	 * into the ram area.
-	 */
-	for (i = 0; i < length; i++)
-		IGC_WRITE_REG_ARRAY_DWORD(hw, IGC_HOST_IF, i,
-					    *((u32 *)buffer + i));
-
-	/* Setting this bit tells the ARC that a new command is pending. */
-	IGC_WRITE_REG(hw, IGC_HICR, hicr | IGC_HICR_C);
-
-	for (i = 0; i < IGC_HI_COMMAND_TIMEOUT; i++) {
-		hicr = IGC_READ_REG(hw, IGC_HICR);
-		if (!(hicr & IGC_HICR_C))
-			break;
-		msec_delay(1);
-	}
-
-	/* Check command successful completion. */
-	if (i == IGC_HI_COMMAND_TIMEOUT ||
-	    (!(IGC_READ_REG(hw, IGC_HICR) & IGC_HICR_SV))) {
-		DEBUGOUT("Command has failed with no status valid.\n");
-		return -IGC_ERR_HOST_INTERFACE_COMMAND;
-	}
-
-	for (i = 0; i < length; i++)
-		*((u32 *)buffer + i) = IGC_READ_REG_ARRAY_DWORD(hw,
-								  IGC_HOST_IF,
-								  i);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_load_firmware - Writes proxy FW code buffer to host interface
- *                        and execute.
- *  @hw: pointer to the HW structure
- *  @buffer: contains a firmware to write
- *  @length: the byte length of the buffer, must be multiple of 4 bytes
- *
- *  Upon success returns IGC_SUCCESS, returns IGC_ERR_CONFIG if not enabled
- *  in HW else returns IGC_ERR_HOST_INTERFACE_COMMAND.
- **/
-s32 igc_load_firmware(struct igc_hw *hw, u8 *buffer, u32 length)
-{
-	u32 hicr, hibba, fwsm, icr, i;
-
-	DEBUGFUNC("igc_load_firmware");
-
-	if (hw->mac.type < igc_i210) {
-		DEBUGOUT("Hardware doesn't support loading FW by the driver\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	/* Check that the host interface is enabled. */
-	hicr = IGC_READ_REG(hw, IGC_HICR);
-	if (!(hicr & IGC_HICR_EN)) {
-		DEBUGOUT("IGC_HOST_EN bit disabled.\n");
-		return -IGC_ERR_CONFIG;
-	}
-	if (!(hicr & IGC_HICR_MEMORY_BASE_EN)) {
-		DEBUGOUT("IGC_HICR_MEMORY_BASE_EN bit disabled.\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	if (length == 0 || length & 0x3 || length > IGC_HI_FW_MAX_LENGTH) {
-		DEBUGOUT("Buffer length failure.\n");
-		return -IGC_ERR_INVALID_ARGUMENT;
-	}
-
-	/* Clear notification from ROM-FW by reading ICR register */
-	icr = IGC_READ_REG(hw, IGC_ICR_V2);
-
-	/* Reset ROM-FW */
-	hicr = IGC_READ_REG(hw, IGC_HICR);
-	hicr |= IGC_HICR_FW_RESET_ENABLE;
-	IGC_WRITE_REG(hw, IGC_HICR, hicr);
-	hicr |= IGC_HICR_FW_RESET;
-	IGC_WRITE_REG(hw, IGC_HICR, hicr);
-	IGC_WRITE_FLUSH(hw);
-
-	/* Wait till MAC notifies about its readiness after ROM-FW reset */
-	for (i = 0; i < (IGC_HI_COMMAND_TIMEOUT * 2); i++) {
-		icr = IGC_READ_REG(hw, IGC_ICR_V2);
-		if (icr & IGC_ICR_MNG)
-			break;
-		msec_delay(1);
-	}
-
-	/* Check for timeout */
-	if (i == IGC_HI_COMMAND_TIMEOUT) {
-		DEBUGOUT("FW reset failed.\n");
-		return -IGC_ERR_HOST_INTERFACE_COMMAND;
-	}
-
-	/* Wait till MAC is ready to accept new FW code */
-	for (i = 0; i < IGC_HI_COMMAND_TIMEOUT; i++) {
-		fwsm = IGC_READ_REG(hw, IGC_FWSM);
-		if ((fwsm & IGC_FWSM_FW_VALID) &&
-		    ((fwsm & IGC_FWSM_MODE_MASK) >> IGC_FWSM_MODE_SHIFT ==
-		    IGC_FWSM_HI_EN_ONLY_MODE))
-			break;
-		msec_delay(1);
-	}
-
-	/* Check for timeout */
-	if (i == IGC_HI_COMMAND_TIMEOUT) {
-		DEBUGOUT("FW reset failed.\n");
-		return -IGC_ERR_HOST_INTERFACE_COMMAND;
-	}
-
-	/* Calculate length in DWORDs */
-	length >>= 2;
-
-	/* The device driver writes the relevant FW code block
-	 * into the ram area in DWORDs via 1kB ram addressing window.
-	 */
-	for (i = 0; i < length; i++) {
-		if (!(i % IGC_HI_FW_BLOCK_DWORD_LENGTH)) {
-			/* Point to correct 1kB ram window */
-			hibba = IGC_HI_FW_BASE_ADDRESS +
-				((IGC_HI_FW_BLOCK_DWORD_LENGTH << 2) *
-				(i / IGC_HI_FW_BLOCK_DWORD_LENGTH));
-
-			IGC_WRITE_REG(hw, IGC_HIBBA, hibba);
-		}
-
-		IGC_WRITE_REG_ARRAY_DWORD(hw, IGC_HOST_IF,
-					    i % IGC_HI_FW_BLOCK_DWORD_LENGTH,
-					    *((u32 *)buffer + i));
-	}
-
-	/* Setting this bit tells the ARC that a new FW is ready to execute. */
-	hicr = IGC_READ_REG(hw, IGC_HICR);
-	IGC_WRITE_REG(hw, IGC_HICR, hicr | IGC_HICR_C);
-
-	for (i = 0; i < IGC_HI_COMMAND_TIMEOUT; i++) {
-		hicr = IGC_READ_REG(hw, IGC_HICR);
-		if (!(hicr & IGC_HICR_C))
-			break;
-		msec_delay(1);
-	}
-
-	/* Check for successful FW start. */
-	if (i == IGC_HI_COMMAND_TIMEOUT) {
-		DEBUGOUT("New FW did not start within timeout period.\n");
-		return -IGC_ERR_HOST_INTERFACE_COMMAND;
-	}
-
-	return IGC_SUCCESS;
-}
diff --git a/drivers/net/intel/igc/base/igc_manage.h b/drivers/net/intel/igc/base/igc_manage.h
deleted file mode 100644
index 10cae6d7f8..0000000000
--- a/drivers/net/intel/igc/base/igc_manage.h
+++ /dev/null
@@ -1,65 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_MANAGE_H_
-#define _IGC_MANAGE_H_
-
-bool igc_check_mng_mode_generic(struct igc_hw *hw);
-bool igc_enable_tx_pkt_filtering_generic(struct igc_hw *hw);
-s32  igc_mng_enable_host_if_generic(struct igc_hw *hw);
-s32  igc_mng_host_if_write_generic(struct igc_hw *hw, u8 *buffer,
-				     u16 length, u16 offset, u8 *sum);
-s32  igc_mng_write_cmd_header_generic(struct igc_hw *hw,
-				     struct igc_host_mng_command_header *hdr);
-s32  igc_mng_write_dhcp_info_generic(struct igc_hw *hw,
-				       u8 *buffer, u16 length);
-bool igc_enable_mng_pass_thru(struct igc_hw *hw);
-u8 igc_calculate_checksum(u8 *buffer, u32 length);
-s32 igc_host_interface_command(struct igc_hw *hw, u8 *buffer, u32 length);
-s32 igc_load_firmware(struct igc_hw *hw, u8 *buffer, u32 length);
-
-enum igc_mng_mode {
-	igc_mng_mode_none = 0,
-	igc_mng_mode_asf,
-	igc_mng_mode_pt,
-	igc_mng_mode_ipmi,
-	igc_mng_mode_host_if_only
-};
-
-#define IGC_FACTPS_MNGCG			0x20000000
-
-#define IGC_FWSM_MODE_MASK			0xE
-#define IGC_FWSM_MODE_SHIFT			1
-#define IGC_FWSM_FW_VALID			0x00008000
-#define IGC_FWSM_HI_EN_ONLY_MODE		0x4
-
-#define IGC_MNG_IAMT_MODE			0x3
-#define IGC_MNG_DHCP_COOKIE_LENGTH		0x10
-#define IGC_MNG_DHCP_COOKIE_OFFSET		0x6F0
-#define IGC_MNG_DHCP_COMMAND_TIMEOUT		10
-#define IGC_MNG_DHCP_TX_PAYLOAD_CMD		64
-#define IGC_MNG_DHCP_COOKIE_STATUS_PARSING	0x1
-#define IGC_MNG_DHCP_COOKIE_STATUS_VLAN	0x2
-
-#define IGC_VFTA_ENTRY_SHIFT			5
-#define IGC_VFTA_ENTRY_MASK			0x7F
-#define IGC_VFTA_ENTRY_BIT_SHIFT_MASK		0x1F
-
-#define IGC_HI_MAX_BLOCK_BYTE_LENGTH		1792 /* Num of bytes in range */
-#define IGC_HI_MAX_BLOCK_DWORD_LENGTH		448 /* Num of dwords in range */
-#define IGC_HI_COMMAND_TIMEOUT		500 /* Process HI cmd limit */
-#define IGC_HI_FW_BASE_ADDRESS		0x10000
-#define IGC_HI_FW_MAX_LENGTH			(64 * 1024) /* Num of bytes */
-#define IGC_HI_FW_BLOCK_DWORD_LENGTH		256 /* Num of DWORDs per page */
-#define IGC_HICR_MEMORY_BASE_EN		0x200 /* MB Enable bit - RO */
-#define IGC_HICR_EN			0x01  /* Enable bit - RO */
-/* Driver sets this bit when done to put command in RAM */
-#define IGC_HICR_C			0x02
-#define IGC_HICR_SV			0x04  /* Status Validity */
-#define IGC_HICR_FW_RESET_ENABLE	0x40
-#define IGC_HICR_FW_RESET		0x80
-
-/* Intel(R) Active Management Technology signature */
-#define IGC_IAMT_SIGNATURE		0x544D4149
-#endif
diff --git a/drivers/net/intel/igc/base/igc_nvm.c b/drivers/net/intel/igc/base/igc_nvm.c
deleted file mode 100644
index a7c901ab56..0000000000
--- a/drivers/net/intel/igc/base/igc_nvm.c
+++ /dev/null
@@ -1,1324 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#include "igc_api.h"
-
-static void igc_reload_nvm_generic(struct igc_hw *hw);
-
-/**
- *  igc_init_nvm_ops_generic - Initialize NVM function pointers
- *  @hw: pointer to the HW structure
- *
- *  Setups up the function pointers to no-op functions
- **/
-void igc_init_nvm_ops_generic(struct igc_hw *hw)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	DEBUGFUNC("igc_init_nvm_ops_generic");
-
-	/* Initialize function pointers */
-	nvm->ops.init_params = igc_null_ops_generic;
-	nvm->ops.acquire = igc_null_ops_generic;
-	nvm->ops.read = igc_null_read_nvm;
-	nvm->ops.release = igc_null_nvm_generic;
-	nvm->ops.reload = igc_reload_nvm_generic;
-	nvm->ops.update = igc_null_ops_generic;
-	nvm->ops.valid_led_default = igc_null_led_default;
-	nvm->ops.validate = igc_null_ops_generic;
-	nvm->ops.write = igc_null_write_nvm;
-}
-
-/**
- *  igc_null_nvm_read - No-op function, return 0
- *  @hw: pointer to the HW structure
- *  @a: dummy variable
- *  @b: dummy variable
- *  @c: dummy variable
- **/
-s32 igc_null_read_nvm(struct igc_hw IGC_UNUSEDARG * hw,
-			u16 IGC_UNUSEDARG a, u16 IGC_UNUSEDARG b,
-			u16 IGC_UNUSEDARG * c)
-{
-	DEBUGFUNC("igc_null_read_nvm");
-	UNREFERENCED_4PARAMETER(hw, a, b, c);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_null_nvm_generic - No-op function, return void
- *  @hw: pointer to the HW structure
- **/
-void igc_null_nvm_generic(struct igc_hw IGC_UNUSEDARG * hw)
-{
-	DEBUGFUNC("igc_null_nvm_generic");
-	UNREFERENCED_1PARAMETER(hw);
-}
-
-/**
- *  igc_null_led_default - No-op function, return 0
- *  @hw: pointer to the HW structure
- *  @data: dummy variable
- **/
-s32 igc_null_led_default(struct igc_hw IGC_UNUSEDARG * hw,
-			   u16 IGC_UNUSEDARG * data)
-{
-	DEBUGFUNC("igc_null_led_default");
-	UNREFERENCED_2PARAMETER(hw, data);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_null_write_nvm - No-op function, return 0
- *  @hw: pointer to the HW structure
- *  @a: dummy variable
- *  @b: dummy variable
- *  @c: dummy variable
- **/
-s32 igc_null_write_nvm(struct igc_hw IGC_UNUSEDARG * hw,
-			 u16 IGC_UNUSEDARG a, u16 IGC_UNUSEDARG b,
-			 u16 IGC_UNUSEDARG * c)
-{
-	DEBUGFUNC("igc_null_write_nvm");
-	UNREFERENCED_4PARAMETER(hw, a, b, c);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_raise_eec_clk - Raise EEPROM clock
- *  @hw: pointer to the HW structure
- *  @eecd: pointer to the EEPROM
- *
- *  Enable/Raise the EEPROM clock bit.
- **/
-static void igc_raise_eec_clk(struct igc_hw *hw, u32 *eecd)
-{
-	*eecd = *eecd | IGC_EECD_SK;
-	IGC_WRITE_REG(hw, IGC_EECD, *eecd);
-	IGC_WRITE_FLUSH(hw);
-	usec_delay(hw->nvm.delay_usec);
-}
-
-/**
- *  igc_lower_eec_clk - Lower EEPROM clock
- *  @hw: pointer to the HW structure
- *  @eecd: pointer to the EEPROM
- *
- *  Clear/Lower the EEPROM clock bit.
- **/
-static void igc_lower_eec_clk(struct igc_hw *hw, u32 *eecd)
-{
-	*eecd = *eecd & ~IGC_EECD_SK;
-	IGC_WRITE_REG(hw, IGC_EECD, *eecd);
-	IGC_WRITE_FLUSH(hw);
-	usec_delay(hw->nvm.delay_usec);
-}
-
-/**
- *  igc_shift_out_eec_bits - Shift data bits our to the EEPROM
- *  @hw: pointer to the HW structure
- *  @data: data to send to the EEPROM
- *  @count: number of bits to shift out
- *
- *  We need to shift 'count' bits out to the EEPROM.  So, the value in the
- *  "data" parameter will be shifted out to the EEPROM one bit at a time.
- *  In order to do this, "data" must be broken down into bits.
- **/
-static void igc_shift_out_eec_bits(struct igc_hw *hw, u16 data, u16 count)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	u32 eecd = IGC_READ_REG(hw, IGC_EECD);
-	u32 mask;
-
-	DEBUGFUNC("igc_shift_out_eec_bits");
-
-	mask = 0x01 << (count - 1);
-	if (nvm->type == igc_nvm_eeprom_microwire)
-		eecd &= ~IGC_EECD_DO;
-	else if (nvm->type == igc_nvm_eeprom_spi)
-		eecd |= IGC_EECD_DO;
-
-	do {
-		eecd &= ~IGC_EECD_DI;
-
-		if (data & mask)
-			eecd |= IGC_EECD_DI;
-
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-		IGC_WRITE_FLUSH(hw);
-
-		usec_delay(nvm->delay_usec);
-
-		igc_raise_eec_clk(hw, &eecd);
-		igc_lower_eec_clk(hw, &eecd);
-
-		mask >>= 1;
-	} while (mask);
-
-	eecd &= ~IGC_EECD_DI;
-	IGC_WRITE_REG(hw, IGC_EECD, eecd);
-}
-
-/**
- *  igc_shift_in_eec_bits - Shift data bits in from the EEPROM
- *  @hw: pointer to the HW structure
- *  @count: number of bits to shift in
- *
- *  In order to read a register from the EEPROM, we need to shift 'count' bits
- *  in from the EEPROM.  Bits are "shifted in" by raising the clock input to
- *  the EEPROM (setting the SK bit), and then reading the value of the data out
- *  "DO" bit.  During this "shifting in" process the data in "DI" bit should
- *  always be clear.
- **/
-static u16 igc_shift_in_eec_bits(struct igc_hw *hw, u16 count)
-{
-	u32 eecd;
-	u32 i;
-	u16 data;
-
-	DEBUGFUNC("igc_shift_in_eec_bits");
-
-	eecd = IGC_READ_REG(hw, IGC_EECD);
-
-	eecd &= ~(IGC_EECD_DO | IGC_EECD_DI);
-	data = 0;
-
-	for (i = 0; i < count; i++) {
-		data <<= 1;
-		igc_raise_eec_clk(hw, &eecd);
-
-		eecd = IGC_READ_REG(hw, IGC_EECD);
-
-		eecd &= ~IGC_EECD_DI;
-		if (eecd & IGC_EECD_DO)
-			data |= 1;
-
-		igc_lower_eec_clk(hw, &eecd);
-	}
-
-	return data;
-}
-
-/**
- *  igc_poll_eerd_eewr_done - Poll for EEPROM read/write completion
- *  @hw: pointer to the HW structure
- *  @ee_reg: EEPROM flag for polling
- *
- *  Polls the EEPROM status bit for either read or write completion based
- *  upon the value of 'ee_reg'.
- **/
-s32 igc_poll_eerd_eewr_done(struct igc_hw *hw, int ee_reg)
-{
-	u32 attempts = 100000;
-	u32 i, reg = 0;
-
-	DEBUGFUNC("igc_poll_eerd_eewr_done");
-
-	for (i = 0; i < attempts; i++) {
-		if (ee_reg == IGC_NVM_POLL_READ)
-			reg = IGC_READ_REG(hw, IGC_EERD);
-		else
-			reg = IGC_READ_REG(hw, IGC_EEWR);
-
-		if (reg & IGC_NVM_RW_REG_DONE)
-			return IGC_SUCCESS;
-
-		usec_delay(5);
-	}
-
-	return -IGC_ERR_NVM;
-}
-
-/**
- *  igc_acquire_nvm_generic - Generic request for access to EEPROM
- *  @hw: pointer to the HW structure
- *
- *  Set the EEPROM access request bit and wait for EEPROM access grant bit.
- *  Return successful if access grant bit set, else clear the request for
- *  EEPROM access and return -IGC_ERR_NVM (-1).
- **/
-s32 igc_acquire_nvm_generic(struct igc_hw *hw)
-{
-	u32 eecd = IGC_READ_REG(hw, IGC_EECD);
-	s32 timeout = IGC_NVM_GRANT_ATTEMPTS;
-
-	DEBUGFUNC("igc_acquire_nvm_generic");
-
-	IGC_WRITE_REG(hw, IGC_EECD, eecd | IGC_EECD_REQ);
-	eecd = IGC_READ_REG(hw, IGC_EECD);
-
-	while (timeout) {
-		if (eecd & IGC_EECD_GNT)
-			break;
-		usec_delay(5);
-		eecd = IGC_READ_REG(hw, IGC_EECD);
-		timeout--;
-	}
-
-	if (!timeout) {
-		eecd &= ~IGC_EECD_REQ;
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-		DEBUGOUT("Could not acquire NVM grant\n");
-		return -IGC_ERR_NVM;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_standby_nvm - Return EEPROM to standby state
- *  @hw: pointer to the HW structure
- *
- *  Return the EEPROM to a standby state.
- **/
-static void igc_standby_nvm(struct igc_hw *hw)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	u32 eecd = IGC_READ_REG(hw, IGC_EECD);
-
-	DEBUGFUNC("igc_standby_nvm");
-
-	if (nvm->type == igc_nvm_eeprom_microwire) {
-		eecd &= ~(IGC_EECD_CS | IGC_EECD_SK);
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-		IGC_WRITE_FLUSH(hw);
-		usec_delay(nvm->delay_usec);
-
-		igc_raise_eec_clk(hw, &eecd);
-
-		/* Select EEPROM */
-		eecd |= IGC_EECD_CS;
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-		IGC_WRITE_FLUSH(hw);
-		usec_delay(nvm->delay_usec);
-
-		igc_lower_eec_clk(hw, &eecd);
-	} else if (nvm->type == igc_nvm_eeprom_spi) {
-		/* Toggle CS to flush commands */
-		eecd |= IGC_EECD_CS;
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-		IGC_WRITE_FLUSH(hw);
-		usec_delay(nvm->delay_usec);
-		eecd &= ~IGC_EECD_CS;
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-		IGC_WRITE_FLUSH(hw);
-		usec_delay(nvm->delay_usec);
-	}
-}
-
-/**
- *  igc_stop_nvm - Terminate EEPROM command
- *  @hw: pointer to the HW structure
- *
- *  Terminates the current command by inverting the EEPROM's chip select pin.
- **/
-void igc_stop_nvm(struct igc_hw *hw)
-{
-	u32 eecd;
-
-	DEBUGFUNC("igc_stop_nvm");
-
-	eecd = IGC_READ_REG(hw, IGC_EECD);
-	if (hw->nvm.type == igc_nvm_eeprom_spi) {
-		/* Pull CS high */
-		eecd |= IGC_EECD_CS;
-		igc_lower_eec_clk(hw, &eecd);
-	} else if (hw->nvm.type == igc_nvm_eeprom_microwire) {
-		/* CS on Microwire is active-high */
-		eecd &= ~(IGC_EECD_CS | IGC_EECD_DI);
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-		igc_raise_eec_clk(hw, &eecd);
-		igc_lower_eec_clk(hw, &eecd);
-	}
-}
-
-/**
- *  igc_release_nvm_generic - Release exclusive access to EEPROM
- *  @hw: pointer to the HW structure
- *
- *  Stop any current commands to the EEPROM and clear the EEPROM request bit.
- **/
-void igc_release_nvm_generic(struct igc_hw *hw)
-{
-	u32 eecd;
-
-	DEBUGFUNC("igc_release_nvm_generic");
-
-	igc_stop_nvm(hw);
-
-	eecd = IGC_READ_REG(hw, IGC_EECD);
-	eecd &= ~IGC_EECD_REQ;
-	IGC_WRITE_REG(hw, IGC_EECD, eecd);
-}
-
-/**
- *  igc_ready_nvm_eeprom - Prepares EEPROM for read/write
- *  @hw: pointer to the HW structure
- *
- *  Setups the EEPROM for reading and writing.
- **/
-static s32 igc_ready_nvm_eeprom(struct igc_hw *hw)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	u32 eecd = IGC_READ_REG(hw, IGC_EECD);
-	u8 spi_stat_reg;
-
-	DEBUGFUNC("igc_ready_nvm_eeprom");
-
-	if (nvm->type == igc_nvm_eeprom_microwire) {
-		/* Clear SK and DI */
-		eecd &= ~(IGC_EECD_DI | IGC_EECD_SK);
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-		/* Set CS */
-		eecd |= IGC_EECD_CS;
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-	} else if (nvm->type == igc_nvm_eeprom_spi) {
-		u16 timeout = NVM_MAX_RETRY_SPI;
-
-		/* Clear SK and CS */
-		eecd &= ~(IGC_EECD_CS | IGC_EECD_SK);
-		IGC_WRITE_REG(hw, IGC_EECD, eecd);
-		IGC_WRITE_FLUSH(hw);
-		usec_delay(1);
-
-		/* Read "Status Register" repeatedly until the LSB is cleared.
-		 * The EEPROM will signal that the command has been completed
-		 * by clearing bit 0 of the internal status register.  If it's
-		 * not cleared within 'timeout', then error out.
-		 */
-		while (timeout) {
-			igc_shift_out_eec_bits(hw, NVM_RDSR_OPCODE_SPI,
-						 hw->nvm.opcode_bits);
-			spi_stat_reg = (u8)igc_shift_in_eec_bits(hw, 8);
-			if (!(spi_stat_reg & NVM_STATUS_RDY_SPI))
-				break;
-
-			usec_delay(5);
-			igc_standby_nvm(hw);
-			timeout--;
-		}
-
-		if (!timeout) {
-			DEBUGOUT("SPI NVM Status error\n");
-			return -IGC_ERR_NVM;
-		}
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_nvm_spi - Read EEPROM's using SPI
- *  @hw: pointer to the HW structure
- *  @offset: offset of word in the EEPROM to read
- *  @words: number of words to read
- *  @data: word read from the EEPROM
- *
- *  Reads a 16 bit word from the EEPROM.
- **/
-s32 igc_read_nvm_spi(struct igc_hw *hw, u16 offset, u16 words, u16 *data)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	u32 i = 0;
-	s32 ret_val;
-	u16 word_in;
-	u8 read_opcode = NVM_READ_OPCODE_SPI;
-
-	DEBUGFUNC("igc_read_nvm_spi");
-
-	/* A check for invalid values:  offset too large, too many words,
-	 * and not enough words.
-	 */
-	if (offset >= nvm->word_size || words > (nvm->word_size - offset) ||
-			words == 0) {
-		DEBUGOUT("nvm parameter(s) out of bounds\n");
-		return -IGC_ERR_NVM;
-	}
-
-	ret_val = nvm->ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = igc_ready_nvm_eeprom(hw);
-	if (ret_val)
-		goto release;
-
-	igc_standby_nvm(hw);
-
-	if (nvm->address_bits == 8 && offset >= 128)
-		read_opcode |= NVM_A8_OPCODE_SPI;
-
-	/* Send the READ command (opcode + addr) */
-	igc_shift_out_eec_bits(hw, read_opcode, nvm->opcode_bits);
-	igc_shift_out_eec_bits(hw, (u16)(offset * 2), nvm->address_bits);
-
-	/* Read the data.  SPI NVMs increment the address with each byte
-	 * read and will roll over if reading beyond the end.  This allows
-	 * us to read the whole NVM from any offset
-	 */
-	for (i = 0; i < words; i++) {
-		word_in = igc_shift_in_eec_bits(hw, 16);
-		data[i] = (word_in >> 8) | (word_in << 8);
-	}
-
-release:
-	nvm->ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_read_nvm_microwire - Reads EEPROM's using microwire
- *  @hw: pointer to the HW structure
- *  @offset: offset of word in the EEPROM to read
- *  @words: number of words to read
- *  @data: word read from the EEPROM
- *
- *  Reads a 16 bit word from the EEPROM.
- **/
-s32 igc_read_nvm_microwire(struct igc_hw *hw, u16 offset, u16 words,
-			     u16 *data)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	u32 i = 0;
-	s32 ret_val;
-	u8 read_opcode = NVM_READ_OPCODE_MICROWIRE;
-
-	DEBUGFUNC("igc_read_nvm_microwire");
-
-	/* A check for invalid values:  offset too large, too many words,
-	 * and not enough words.
-	 */
-	if (offset >= nvm->word_size || words > (nvm->word_size - offset) ||
-			words == 0) {
-		DEBUGOUT("nvm parameter(s) out of bounds\n");
-		return -IGC_ERR_NVM;
-	}
-
-	ret_val = nvm->ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = igc_ready_nvm_eeprom(hw);
-	if (ret_val)
-		goto release;
-
-	for (i = 0; i < words; i++) {
-		/* Send the READ command (opcode + addr) */
-		igc_shift_out_eec_bits(hw, read_opcode, nvm->opcode_bits);
-		igc_shift_out_eec_bits(hw, (u16)(offset + i),
-					nvm->address_bits);
-
-		/* Read the data.  For microwire, each word requires the
-		 * overhead of setup and tear-down.
-		 */
-		data[i] = igc_shift_in_eec_bits(hw, 16);
-		igc_standby_nvm(hw);
-	}
-
-release:
-	nvm->ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_read_nvm_eerd - Reads EEPROM using EERD register
- *  @hw: pointer to the HW structure
- *  @offset: offset of word in the EEPROM to read
- *  @words: number of words to read
- *  @data: word read from the EEPROM
- *
- *  Reads a 16 bit word from the EEPROM using the EERD register.
- **/
-s32 igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words, u16 *data)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	u32 i, eerd = 0;
-	s32 ret_val = IGC_SUCCESS;
-
-	DEBUGFUNC("igc_read_nvm_eerd");
-
-	/* A check for invalid values:  offset too large, too many words,
-	 * too many words for the offset, and not enough words.
-	 */
-	if (offset >= nvm->word_size || words > (nvm->word_size - offset) ||
-			words == 0) {
-		DEBUGOUT("nvm parameter(s) out of bounds\n");
-		return -IGC_ERR_NVM;
-	}
-
-	for (i = 0; i < words; i++) {
-		eerd = ((offset + i) << IGC_NVM_RW_ADDR_SHIFT) +
-		       IGC_NVM_RW_REG_START;
-
-		IGC_WRITE_REG(hw, IGC_EERD, eerd);
-		ret_val = igc_poll_eerd_eewr_done(hw, IGC_NVM_POLL_READ);
-		if (ret_val)
-			break;
-
-		data[i] = (IGC_READ_REG(hw, IGC_EERD) >>
-			   IGC_NVM_RW_REG_DATA);
-	}
-
-	if (ret_val)
-		DEBUGOUT1("NVM read error: %d\n", ret_val);
-
-	return ret_val;
-}
-
-/**
- *  igc_write_nvm_spi - Write to EEPROM using SPI
- *  @hw: pointer to the HW structure
- *  @offset: offset within the EEPROM to be written to
- *  @words: number of words to write
- *  @data: 16 bit word(s) to be written to the EEPROM
- *
- *  Writes data to EEPROM at offset using SPI interface.
- *
- *  If igc_update_nvm_checksum is not called after this function , the
- *  EEPROM will most likely contain an invalid checksum.
- **/
-s32 igc_write_nvm_spi(struct igc_hw *hw, u16 offset, u16 words, u16 *data)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	s32 ret_val = -IGC_ERR_NVM;
-	u16 widx = 0;
-
-	DEBUGFUNC("igc_write_nvm_spi");
-
-	/* A check for invalid values:  offset too large, too many words,
-	 * and not enough words.
-	 */
-	if (offset >= nvm->word_size || words > (nvm->word_size - offset) ||
-			words == 0) {
-		DEBUGOUT("nvm parameter(s) out of bounds\n");
-		return -IGC_ERR_NVM;
-	}
-
-	while (widx < words) {
-		u8 write_opcode = NVM_WRITE_OPCODE_SPI;
-
-		ret_val = nvm->ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
-
-		ret_val = igc_ready_nvm_eeprom(hw);
-		if (ret_val) {
-			nvm->ops.release(hw);
-			return ret_val;
-		}
-
-		igc_standby_nvm(hw);
-
-		/* Send the WRITE ENABLE command (8 bit opcode) */
-		igc_shift_out_eec_bits(hw, NVM_WREN_OPCODE_SPI,
-					 nvm->opcode_bits);
-
-		igc_standby_nvm(hw);
-
-		/* Some SPI eeproms use the 8th address bit embedded in the
-		 * opcode
-		 */
-		if (nvm->address_bits == 8 && offset >= 128)
-			write_opcode |= NVM_A8_OPCODE_SPI;
-
-		/* Send the Write command (8-bit opcode + addr) */
-		igc_shift_out_eec_bits(hw, write_opcode, nvm->opcode_bits);
-		igc_shift_out_eec_bits(hw, (u16)((offset + widx) * 2),
-					 nvm->address_bits);
-
-		/* Loop to allow for up to whole page write of eeprom */
-		while (widx < words) {
-			u16 word_out = data[widx];
-			word_out = (word_out >> 8) | (word_out << 8);
-			igc_shift_out_eec_bits(hw, word_out, 16);
-			widx++;
-
-			if ((((offset + widx) * 2) % nvm->page_size) == 0) {
-				igc_standby_nvm(hw);
-				break;
-			}
-		}
-		msec_delay(10);
-		nvm->ops.release(hw);
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_write_nvm_microwire - Writes EEPROM using microwire
- *  @hw: pointer to the HW structure
- *  @offset: offset within the EEPROM to be written to
- *  @words: number of words to write
- *  @data: 16 bit word(s) to be written to the EEPROM
- *
- *  Writes data to EEPROM at offset using microwire interface.
- *
- *  If igc_update_nvm_checksum is not called after this function , the
- *  EEPROM will most likely contain an invalid checksum.
- **/
-s32 igc_write_nvm_microwire(struct igc_hw *hw, u16 offset, u16 words,
-			      u16 *data)
-{
-	struct igc_nvm_info *nvm = &hw->nvm;
-	s32  ret_val;
-	u32 eecd;
-	u16 words_written = 0;
-	u16 widx = 0;
-
-	DEBUGFUNC("igc_write_nvm_microwire");
-
-	/* A check for invalid values:  offset too large, too many words,
-	 * and not enough words.
-	 */
-	if (offset >= nvm->word_size || words > (nvm->word_size - offset) ||
-			words == 0) {
-		DEBUGOUT("nvm parameter(s) out of bounds\n");
-		return -IGC_ERR_NVM;
-	}
-
-	ret_val = nvm->ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = igc_ready_nvm_eeprom(hw);
-	if (ret_val)
-		goto release;
-
-	igc_shift_out_eec_bits(hw, NVM_EWEN_OPCODE_MICROWIRE,
-				 (u16)(nvm->opcode_bits + 2));
-
-	igc_shift_out_eec_bits(hw, 0, (u16)(nvm->address_bits - 2));
-
-	igc_standby_nvm(hw);
-
-	while (words_written < words) {
-		igc_shift_out_eec_bits(hw, NVM_WRITE_OPCODE_MICROWIRE,
-					 nvm->opcode_bits);
-
-		igc_shift_out_eec_bits(hw, (u16)(offset + words_written),
-					 nvm->address_bits);
-
-		igc_shift_out_eec_bits(hw, data[words_written], 16);
-
-		igc_standby_nvm(hw);
-
-		for (widx = 0; widx < 200; widx++) {
-			eecd = IGC_READ_REG(hw, IGC_EECD);
-			if (eecd & IGC_EECD_DO)
-				break;
-			usec_delay(50);
-		}
-
-		if (widx == 200) {
-			DEBUGOUT("NVM Write did not complete\n");
-			ret_val = -IGC_ERR_NVM;
-			goto release;
-		}
-
-		igc_standby_nvm(hw);
-
-		words_written++;
-	}
-
-	igc_shift_out_eec_bits(hw, NVM_EWDS_OPCODE_MICROWIRE,
-				 (u16)(nvm->opcode_bits + 2));
-
-	igc_shift_out_eec_bits(hw, 0, (u16)(nvm->address_bits - 2));
-
-release:
-	nvm->ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_read_pba_string_generic - Read device part number
- *  @hw: pointer to the HW structure
- *  @pba_num: pointer to device part number
- *  @pba_num_size: size of part number buffer
- *
- *  Reads the product board assembly (PBA) number from the EEPROM and stores
- *  the value in pba_num.
- **/
-s32 igc_read_pba_string_generic(struct igc_hw *hw, u8 *pba_num,
-				  u32 pba_num_size)
-{
-	s32 ret_val;
-	u16 nvm_data;
-	u16 pba_ptr;
-	u16 offset;
-	u16 length;
-
-	DEBUGFUNC("igc_read_pba_string_generic");
-
-	if (pba_num == NULL) {
-		DEBUGOUT("PBA string buffer was null\n");
-		return -IGC_ERR_INVALID_ARGUMENT;
-	}
-
-	ret_val = hw->nvm.ops.read(hw, NVM_PBA_OFFSET_0, 1, &nvm_data);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-
-	ret_val = hw->nvm.ops.read(hw, NVM_PBA_OFFSET_1, 1, &pba_ptr);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-
-	/* if nvm_data is not ptr guard the PBA must be in legacy format which
-	 * means pba_ptr is actually our second data word for the PBA number
-	 * and we can decode it into an ascii string
-	 */
-	if (nvm_data != NVM_PBA_PTR_GUARD) {
-		DEBUGOUT("NVM PBA number is not stored as string\n");
-
-		/* make sure callers buffer is big enough to store the PBA */
-		if (pba_num_size < IGC_PBANUM_LENGTH) {
-			DEBUGOUT("PBA string buffer too small\n");
-			return IGC_ERR_NO_SPACE;
-		}
-
-		/* extract hex string from data and pba_ptr */
-		pba_num[0] = (nvm_data >> 12) & 0xF;
-		pba_num[1] = (nvm_data >> 8) & 0xF;
-		pba_num[2] = (nvm_data >> 4) & 0xF;
-		pba_num[3] = nvm_data & 0xF;
-		pba_num[4] = (pba_ptr >> 12) & 0xF;
-		pba_num[5] = (pba_ptr >> 8) & 0xF;
-		pba_num[6] = '-';
-		pba_num[7] = 0;
-		pba_num[8] = (pba_ptr >> 4) & 0xF;
-		pba_num[9] = pba_ptr & 0xF;
-
-		/* put a null character on the end of our string */
-		pba_num[10] = '\0';
-
-		/* switch all the data but the '-' to hex char */
-		for (offset = 0; offset < 10; offset++) {
-			if (pba_num[offset] < 0xA)
-				pba_num[offset] += '0';
-			else if (pba_num[offset] < 0x10)
-				pba_num[offset] += 'A' - 0xA;
-		}
-
-		return IGC_SUCCESS;
-	}
-
-	ret_val = hw->nvm.ops.read(hw, pba_ptr, 1, &length);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-
-	if (length == 0xFFFF || length == 0) {
-		DEBUGOUT("NVM PBA number section invalid length\n");
-		return -IGC_ERR_NVM_PBA_SECTION;
-	}
-	/* check if pba_num buffer is big enough */
-	if (pba_num_size < (((u32)length * 2) - 1)) {
-		DEBUGOUT("PBA string buffer too small\n");
-		return -IGC_ERR_NO_SPACE;
-	}
-
-	/* trim pba length from start of string */
-	pba_ptr++;
-	length--;
-
-	for (offset = 0; offset < length; offset++) {
-		ret_val = hw->nvm.ops.read(hw, pba_ptr + offset, 1, &nvm_data);
-		if (ret_val) {
-			DEBUGOUT("NVM Read Error\n");
-			return ret_val;
-		}
-		pba_num[offset * 2] = (u8)(nvm_data >> 8);
-		pba_num[(offset * 2) + 1] = (u8)(nvm_data & 0xFF);
-	}
-	pba_num[offset * 2] = '\0';
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_pba_length_generic - Read device part number length
- *  @hw: pointer to the HW structure
- *  @pba_num_size: size of part number buffer
- *
- *  Reads the product board assembly (PBA) number length from the EEPROM and
- *  stores the value in pba_num_size.
- **/
-s32 igc_read_pba_length_generic(struct igc_hw *hw, u32 *pba_num_size)
-{
-	s32 ret_val;
-	u16 nvm_data;
-	u16 pba_ptr;
-	u16 length;
-
-	DEBUGFUNC("igc_read_pba_length_generic");
-
-	if (pba_num_size == NULL) {
-		DEBUGOUT("PBA buffer size was null\n");
-		return -IGC_ERR_INVALID_ARGUMENT;
-	}
-
-	ret_val = hw->nvm.ops.read(hw, NVM_PBA_OFFSET_0, 1, &nvm_data);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-
-	ret_val = hw->nvm.ops.read(hw, NVM_PBA_OFFSET_1, 1, &pba_ptr);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-
-	 /* if data is not ptr guard the PBA must be in legacy format */
-	if (nvm_data != NVM_PBA_PTR_GUARD) {
-		*pba_num_size = IGC_PBANUM_LENGTH;
-		return IGC_SUCCESS;
-	}
-
-	ret_val = hw->nvm.ops.read(hw, pba_ptr, 1, &length);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-
-	if (length == 0xFFFF || length == 0) {
-		DEBUGOUT("NVM PBA number section invalid length\n");
-		return -IGC_ERR_NVM_PBA_SECTION;
-	}
-
-	/* Convert from length in u16 values to u8 chars, add 1 for NULL,
-	 * and subtract 2 because length field is included in length.
-	 */
-	*pba_num_size = ((u32)length * 2) - 1;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_pba_num_generic - Read device part number
- *  @hw: pointer to the HW structure
- *  @pba_num: pointer to device part number
- *
- *  Reads the product board assembly (PBA) number from the EEPROM and stores
- *  the value in pba_num.
- **/
-s32 igc_read_pba_num_generic(struct igc_hw *hw, u32 *pba_num)
-{
-	s32 ret_val;
-	u16 nvm_data;
-
-	DEBUGFUNC("igc_read_pba_num_generic");
-
-	ret_val = hw->nvm.ops.read(hw, NVM_PBA_OFFSET_0, 1, &nvm_data);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	} else if (nvm_data == NVM_PBA_PTR_GUARD) {
-		DEBUGOUT("NVM Not Supported\n");
-		return -IGC_NOT_IMPLEMENTED;
-	}
-	*pba_num = (u32)(nvm_data << 16);
-
-	ret_val = hw->nvm.ops.read(hw, NVM_PBA_OFFSET_1, 1, &nvm_data);
-	if (ret_val) {
-		DEBUGOUT("NVM Read Error\n");
-		return ret_val;
-	}
-	*pba_num |= nvm_data;
-
-	return IGC_SUCCESS;
-}
-
-
-/**
- *  igc_read_pba_raw
- *  @hw: pointer to the HW structure
- *  @eeprom_buf: optional pointer to EEPROM image
- *  @eeprom_buf_size: size of EEPROM image in words
- *  @max_pba_block_size: PBA block size limit
- *  @pba: pointer to output PBA structure
- *
- *  Reads PBA from EEPROM image when eeprom_buf is not NULL.
- *  Reads PBA from physical EEPROM device when eeprom_buf is NULL.
- *
- **/
-s32 igc_read_pba_raw(struct igc_hw *hw, u16 *eeprom_buf,
-		       u32 eeprom_buf_size, u16 max_pba_block_size,
-		       struct igc_pba *pba)
-{
-	s32 ret_val;
-	u16 pba_block_size;
-
-	if (pba == NULL)
-		return -IGC_ERR_PARAM;
-
-	if (eeprom_buf == NULL) {
-		ret_val = igc_read_nvm(hw, NVM_PBA_OFFSET_0, 2,
-					 &pba->word[0]);
-		if (ret_val)
-			return ret_val;
-	} else {
-		if (eeprom_buf_size > NVM_PBA_OFFSET_1) {
-			pba->word[0] = eeprom_buf[NVM_PBA_OFFSET_0];
-			pba->word[1] = eeprom_buf[NVM_PBA_OFFSET_1];
-		} else {
-			return -IGC_ERR_PARAM;
-		}
-	}
-
-	if (pba->word[0] == NVM_PBA_PTR_GUARD) {
-		if (pba->pba_block == NULL)
-			return -IGC_ERR_PARAM;
-
-		ret_val = igc_get_pba_block_size(hw, eeprom_buf,
-						   eeprom_buf_size,
-						   &pba_block_size);
-		if (ret_val)
-			return ret_val;
-
-		if (pba_block_size > max_pba_block_size)
-			return -IGC_ERR_PARAM;
-
-		if (eeprom_buf == NULL) {
-			ret_val = igc_read_nvm(hw, pba->word[1],
-						 pba_block_size,
-						 pba->pba_block);
-			if (ret_val)
-				return ret_val;
-		} else {
-			if (eeprom_buf_size > (u32)(pba->word[1] +
-					      pba_block_size)) {
-				memcpy(pba->pba_block,
-				       &eeprom_buf[pba->word[1]],
-				       pba_block_size * sizeof(u16));
-			} else {
-				return -IGC_ERR_PARAM;
-			}
-		}
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_pba_raw
- *  @hw: pointer to the HW structure
- *  @eeprom_buf: optional pointer to EEPROM image
- *  @eeprom_buf_size: size of EEPROM image in words
- *  @pba: pointer to PBA structure
- *
- *  Writes PBA to EEPROM image when eeprom_buf is not NULL.
- *  Writes PBA to physical EEPROM device when eeprom_buf is NULL.
- *
- **/
-s32 igc_write_pba_raw(struct igc_hw *hw, u16 *eeprom_buf,
-			u32 eeprom_buf_size, struct igc_pba *pba)
-{
-	s32 ret_val;
-
-	if (pba == NULL)
-		return -IGC_ERR_PARAM;
-
-	if (eeprom_buf == NULL) {
-		ret_val = igc_write_nvm(hw, NVM_PBA_OFFSET_0, 2,
-					  &pba->word[0]);
-		if (ret_val)
-			return ret_val;
-	} else {
-		if (eeprom_buf_size > NVM_PBA_OFFSET_1) {
-			eeprom_buf[NVM_PBA_OFFSET_0] = pba->word[0];
-			eeprom_buf[NVM_PBA_OFFSET_1] = pba->word[1];
-		} else {
-			return -IGC_ERR_PARAM;
-		}
-	}
-
-	if (pba->word[0] == NVM_PBA_PTR_GUARD) {
-		if (pba->pba_block == NULL)
-			return -IGC_ERR_PARAM;
-
-		if (eeprom_buf == NULL) {
-			ret_val = igc_write_nvm(hw, pba->word[1],
-						  pba->pba_block[0],
-						  pba->pba_block);
-			if (ret_val)
-				return ret_val;
-		} else {
-			if (eeprom_buf_size > (u32)(pba->word[1] +
-					      pba->pba_block[0])) {
-				memcpy(&eeprom_buf[pba->word[1]],
-				       pba->pba_block,
-				       pba->pba_block[0] * sizeof(u16));
-			} else {
-				return -IGC_ERR_PARAM;
-			}
-		}
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_get_pba_block_size
- *  @hw: pointer to the HW structure
- *  @eeprom_buf: optional pointer to EEPROM image
- *  @eeprom_buf_size: size of EEPROM image in words
- *  @pba_data_size: pointer to output variable
- *
- *  Returns the size of the PBA block in words. Function operates on EEPROM
- *  image if the eeprom_buf pointer is not NULL otherwise it accesses physical
- *  EEPROM device.
- *
- **/
-s32 igc_get_pba_block_size(struct igc_hw *hw, u16 *eeprom_buf,
-			     u32 eeprom_buf_size, u16 *pba_block_size)
-{
-	s32 ret_val;
-	u16 pba_word[2];
-	u16 length;
-
-	DEBUGFUNC("igc_get_pba_block_size");
-
-	if (eeprom_buf == NULL) {
-		ret_val = igc_read_nvm(hw, NVM_PBA_OFFSET_0, 2, &pba_word[0]);
-		if (ret_val)
-			return ret_val;
-	} else {
-		if (eeprom_buf_size > NVM_PBA_OFFSET_1) {
-			pba_word[0] = eeprom_buf[NVM_PBA_OFFSET_0];
-			pba_word[1] = eeprom_buf[NVM_PBA_OFFSET_1];
-		} else {
-			return -IGC_ERR_PARAM;
-		}
-	}
-
-	if (pba_word[0] == NVM_PBA_PTR_GUARD) {
-		if (eeprom_buf == NULL) {
-			ret_val = igc_read_nvm(hw, pba_word[1] + 0, 1,
-						 &length);
-			if (ret_val)
-				return ret_val;
-		} else {
-			if (eeprom_buf_size > pba_word[1])
-				length = eeprom_buf[pba_word[1] + 0];
-			else
-				return -IGC_ERR_PARAM;
-		}
-
-		if (length == 0xFFFF || length == 0)
-			return -IGC_ERR_NVM_PBA_SECTION;
-	} else {
-		/* PBA number in legacy format, there is no PBA Block. */
-		length = 0;
-	}
-
-	if (pba_block_size != NULL)
-		*pba_block_size = length;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_mac_addr_generic - Read device MAC address
- *  @hw: pointer to the HW structure
- *
- *  Reads the device MAC address from the EEPROM and stores the value.
- *  Since devices with two ports use the same EEPROM, we increment the
- *  last bit in the MAC address for the second port.
- **/
-s32 igc_read_mac_addr_generic(struct igc_hw *hw)
-{
-	u32 rar_high;
-	u32 rar_low;
-	u16 i;
-
-	rar_high = IGC_READ_REG(hw, IGC_RAH(0));
-	rar_low = IGC_READ_REG(hw, IGC_RAL(0));
-
-	for (i = 0; i < IGC_RAL_MAC_ADDR_LEN; i++)
-		hw->mac.perm_addr[i] = (u8)(rar_low >> (i * 8));
-
-	for (i = 0; i < IGC_RAH_MAC_ADDR_LEN; i++)
-		hw->mac.perm_addr[i + 4] = (u8)(rar_high >> (i * 8));
-
-	for (i = 0; i < ETH_ADDR_LEN; i++)
-		hw->mac.addr[i] = hw->mac.perm_addr[i];
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_validate_nvm_checksum_generic - Validate EEPROM checksum
- *  @hw: pointer to the HW structure
- *
- *  Calculates the EEPROM checksum by reading/adding each word of the EEPROM
- *  and then verifies that the sum of the EEPROM is equal to 0xBABA.
- **/
-s32 igc_validate_nvm_checksum_generic(struct igc_hw *hw)
-{
-	s32 ret_val;
-	u16 checksum = 0;
-	u16 i, nvm_data;
-
-	DEBUGFUNC("igc_validate_nvm_checksum_generic");
-
-	for (i = 0; i < (NVM_CHECKSUM_REG + 1); i++) {
-		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
-		if (ret_val) {
-			DEBUGOUT("NVM Read Error\n");
-			return ret_val;
-		}
-		checksum += nvm_data;
-	}
-
-	if (checksum != (u16)NVM_SUM) {
-		DEBUGOUT("NVM Checksum Invalid\n");
-		return -IGC_ERR_NVM;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_update_nvm_checksum_generic - Update EEPROM checksum
- *  @hw: pointer to the HW structure
- *
- *  Updates the EEPROM checksum by reading/adding each word of the EEPROM
- *  up to the checksum.  Then calculates the EEPROM checksum and writes the
- *  value to the EEPROM.
- **/
-s32 igc_update_nvm_checksum_generic(struct igc_hw *hw)
-{
-	s32 ret_val;
-	u16 checksum = 0;
-	u16 i, nvm_data;
-
-	DEBUGFUNC("igc_update_nvm_checksum");
-
-	for (i = 0; i < NVM_CHECKSUM_REG; i++) {
-		ret_val = hw->nvm.ops.read(hw, i, 1, &nvm_data);
-		if (ret_val) {
-			DEBUGOUT("NVM Read Error while updating checksum.\n");
-			return ret_val;
-		}
-		checksum += nvm_data;
-	}
-	checksum = (u16)NVM_SUM - checksum;
-	ret_val = hw->nvm.ops.write(hw, NVM_CHECKSUM_REG, 1, &checksum);
-	if (ret_val)
-		DEBUGOUT("NVM Write Error while updating checksum.\n");
-
-	return ret_val;
-}
-
-/**
- *  igc_reload_nvm_generic - Reloads EEPROM
- *  @hw: pointer to the HW structure
- *
- *  Reloads the EEPROM by setting the "Reinitialize from EEPROM" bit in the
- *  extended control register.
- **/
-static void igc_reload_nvm_generic(struct igc_hw *hw)
-{
-	u32 ctrl_ext;
-
-	DEBUGFUNC("igc_reload_nvm_generic");
-
-	usec_delay(10);
-	ctrl_ext = IGC_READ_REG(hw, IGC_CTRL_EXT);
-	ctrl_ext |= IGC_CTRL_EXT_EE_RST;
-	IGC_WRITE_REG(hw, IGC_CTRL_EXT, ctrl_ext);
-	IGC_WRITE_FLUSH(hw);
-}
-
-/**
- *  igc_get_fw_version - Get firmware version information
- *  @hw: pointer to the HW structure
- *  @fw_vers: pointer to output version structure
- *
- *  unsupported/not present features return 0 in version structure
- **/
-void igc_get_fw_version(struct igc_hw *hw, struct igc_fw_version *fw_vers)
-{
-	u16 eeprom_verh, eeprom_verl, etrack_test, fw_version;
-	u8 q, hval, rem, result;
-	u16 comb_verh, comb_verl, comb_offset;
-
-	memset(fw_vers, 0, sizeof(struct igc_fw_version));
-
-	/*
-	 * basic eeprom version numbers, bits used vary by part and by tool
-	 * used to create the nvm images. Check which data format we have.
-	 */
-	switch (hw->mac.type) {
-	case igc_i225:
-		hw->nvm.ops.read(hw, NVM_ETRACK_HIWORD, 1, &etrack_test);
-		/* find combo image version */
-		hw->nvm.ops.read(hw, NVM_COMB_VER_PTR, 1, &comb_offset);
-		if (comb_offset && comb_offset != NVM_VER_INVALID) {
-			hw->nvm.ops.read(hw, NVM_COMB_VER_OFF + comb_offset + 1,
-					1, &comb_verh);
-			hw->nvm.ops.read(hw, NVM_COMB_VER_OFF + comb_offset,
-					1, &comb_verl);
-
-			/* get Option Rom version if it exists and is valid */
-			if (comb_verh && comb_verl &&
-					comb_verh != NVM_VER_INVALID &&
-					comb_verl != NVM_VER_INVALID) {
-				fw_vers->or_valid = true;
-				fw_vers->or_major = comb_verl >>
-						NVM_COMB_VER_SHFT;
-				fw_vers->or_build = (comb_verl <<
-						NVM_COMB_VER_SHFT) |
-						(comb_verh >>
-						NVM_COMB_VER_SHFT);
-				fw_vers->or_patch = comb_verh &
-						NVM_COMB_VER_MASK;
-			}
-		}
-		break;
-	default:
-		hw->nvm.ops.read(hw, NVM_ETRACK_HIWORD, 1, &etrack_test);
-		return;
-	}
-	hw->nvm.ops.read(hw, NVM_VERSION, 1, &fw_version);
-	fw_vers->eep_major = (fw_version & NVM_MAJOR_MASK)
-			      >> NVM_MAJOR_SHIFT;
-
-	/* check for old style version format in newer images*/
-	if ((fw_version & NVM_NEW_DEC_MASK) == 0x0) {
-		eeprom_verl = (fw_version & NVM_COMB_VER_MASK);
-	} else {
-		eeprom_verl = (fw_version & NVM_MINOR_MASK)
-				>> NVM_MINOR_SHIFT;
-	}
-	/* Convert minor value to hex before assigning to output struct
-	 * Val to be converted will not be higher than 99, per tool output
-	 */
-	q = eeprom_verl / NVM_HEX_CONV;
-	hval = q * NVM_HEX_TENS;
-	rem = eeprom_verl % NVM_HEX_CONV;
-	result = hval + rem;
-	fw_vers->eep_minor = result;
-
-	if ((etrack_test &  NVM_MAJOR_MASK) == NVM_ETRACK_VALID) {
-		hw->nvm.ops.read(hw, NVM_ETRACK_WORD, 1, &eeprom_verl);
-		hw->nvm.ops.read(hw, (NVM_ETRACK_WORD + 1), 1, &eeprom_verh);
-		fw_vers->etrack_id = (eeprom_verh << NVM_ETRACK_SHIFT)
-			| eeprom_verl;
-	} else if ((etrack_test & NVM_ETRACK_VALID) == 0) {
-		hw->nvm.ops.read(hw, NVM_ETRACK_WORD, 1, &eeprom_verh);
-		hw->nvm.ops.read(hw, (NVM_ETRACK_WORD + 1), 1, &eeprom_verl);
-		fw_vers->etrack_id = (eeprom_verh << NVM_ETRACK_SHIFT) |
-				     eeprom_verl;
-	}
-}
diff --git a/drivers/net/intel/igc/base/igc_nvm.h b/drivers/net/intel/igc/base/igc_nvm.h
deleted file mode 100644
index 0eee5e4571..0000000000
--- a/drivers/net/intel/igc/base/igc_nvm.h
+++ /dev/null
@@ -1,69 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_NVM_H_
-#define _IGC_NVM_H_
-
-struct igc_pba {
-	u16 word[2];
-	u16 *pba_block;
-};
-
-struct igc_fw_version {
-	u32 etrack_id;
-	u16 eep_major;
-	u16 eep_minor;
-	u16 eep_build;
-
-	u8 invm_major;
-	u8 invm_minor;
-	u8 invm_img_type;
-
-	bool or_valid;
-	u16 or_major;
-	u16 or_build;
-	u16 or_patch;
-};
-
-
-void igc_init_nvm_ops_generic(struct igc_hw *hw);
-s32  igc_null_read_nvm(struct igc_hw *hw, u16 a, u16 b, u16 *c);
-void igc_null_nvm_generic(struct igc_hw *hw);
-s32  igc_null_led_default(struct igc_hw *hw, u16 *data);
-s32  igc_null_write_nvm(struct igc_hw *hw, u16 a, u16 b, u16 *c);
-s32  igc_acquire_nvm_generic(struct igc_hw *hw);
-
-s32  igc_poll_eerd_eewr_done(struct igc_hw *hw, int ee_reg);
-s32  igc_read_mac_addr_generic(struct igc_hw *hw);
-s32  igc_read_pba_num_generic(struct igc_hw *hw, u32 *pba_num);
-s32  igc_read_pba_string_generic(struct igc_hw *hw, u8 *pba_num,
-				   u32 pba_num_size);
-s32  igc_read_pba_length_generic(struct igc_hw *hw, u32 *pba_num_size);
-s32 igc_read_pba_raw(struct igc_hw *hw, u16 *eeprom_buf,
-		       u32 eeprom_buf_size, u16 max_pba_block_size,
-		       struct igc_pba *pba);
-s32 igc_write_pba_raw(struct igc_hw *hw, u16 *eeprom_buf,
-			u32 eeprom_buf_size, struct igc_pba *pba);
-s32 igc_get_pba_block_size(struct igc_hw *hw, u16 *eeprom_buf,
-			     u32 eeprom_buf_size, u16 *pba_block_size);
-s32  igc_read_nvm_spi(struct igc_hw *hw, u16 offset, u16 words, u16 *data);
-s32  igc_read_nvm_microwire(struct igc_hw *hw, u16 offset,
-			      u16 words, u16 *data);
-s32  igc_read_nvm_eerd(struct igc_hw *hw, u16 offset, u16 words,
-			 u16 *data);
-s32  igc_valid_led_default_generic(struct igc_hw *hw, u16 *data);
-s32  igc_validate_nvm_checksum_generic(struct igc_hw *hw);
-s32  igc_write_nvm_microwire(struct igc_hw *hw, u16 offset,
-			       u16 words, u16 *data);
-s32  igc_write_nvm_spi(struct igc_hw *hw, u16 offset, u16 words,
-			 u16 *data);
-s32  igc_update_nvm_checksum_generic(struct igc_hw *hw);
-void igc_stop_nvm(struct igc_hw *hw);
-void igc_release_nvm_generic(struct igc_hw *hw);
-void igc_get_fw_version(struct igc_hw *hw,
-			  struct igc_fw_version *fw_vers);
-
-#define IGC_STM_OPCODE	0xDB00
-
-#endif
diff --git a/drivers/net/intel/igc/base/igc_osdep.c b/drivers/net/intel/igc/base/igc_osdep.c
deleted file mode 100644
index 508f2e07ad..0000000000
--- a/drivers/net/intel/igc/base/igc_osdep.c
+++ /dev/null
@@ -1,64 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2019-2020 Intel Corporation
- */
-
-#include "igc_api.h"
-
-/*
- * NOTE: the following routines using the igc
- * naming style are provided to the shared
- * code but are OS specific
- */
-
-void
-igc_write_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	(void)hw;
-	(void)reg;
-	(void)value;
-}
-
-void
-igc_read_pci_cfg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	(void)hw;
-	(void)reg;
-	*value = 0;
-}
-
-void
-igc_pci_set_mwi(struct igc_hw *hw)
-{
-	(void)hw;
-}
-
-void
-igc_pci_clear_mwi(struct igc_hw *hw)
-{
-	(void)hw;
-}
-
-/*
- * Read the PCI Express capabilities
- */
-int32_t
-igc_read_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	(void)hw;
-	(void)reg;
-	(void)value;
-	return IGC_NOT_IMPLEMENTED;
-}
-
-/*
- * Write the PCI Express capabilities
- */
-int32_t
-igc_write_pcie_cap_reg(struct igc_hw *hw, u32 reg, u16 *value)
-{
-	(void)hw;
-	(void)reg;
-	(void)value;
-
-	return IGC_NOT_IMPLEMENTED;
-}
diff --git a/drivers/net/intel/igc/base/igc_osdep.h b/drivers/net/intel/igc/base/igc_osdep.h
deleted file mode 100644
index 92a41bb051..0000000000
--- a/drivers/net/intel/igc/base/igc_osdep.h
+++ /dev/null
@@ -1,163 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2019-2020 Intel Corporation
- */
-
-
-#ifndef _IGC_OSDEP_H_
-#define _IGC_OSDEP_H_
-
-#include <stdint.h>
-#include <stdio.h>
-#include <stdarg.h>
-#include <string.h>
-#include <stdbool.h>
-#include <rte_common.h>
-#include <rte_cycles.h>
-#include <rte_log.h>
-#include <rte_debug.h>
-#include <rte_byteorder.h>
-#include <rte_io.h>
-
-#include "../igc_logs.h"
-
-#define DELAY(x) rte_delay_us(x)
-#define usec_delay(x) DELAY(x)
-#define usec_delay_irq(x) DELAY(x)
-#define msec_delay(x) DELAY(1000 * (x))
-#define msec_delay_irq(x) DELAY(1000 * (x))
-
-#define DEBUGFUNC(F)            DEBUGOUT(F "\n")
-#define DEBUGOUT(S, ...)        RTE_LOG(DEBUG, IGC_DRIVER, "%s(): " S, __func__, ## __VA_ARGS__)
-#define DEBUGOUT1(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
-#define DEBUGOUT2(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
-#define DEBUGOUT3(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
-#define DEBUGOUT6(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
-#define DEBUGOUT7(S, ...)       DEBUGOUT(S, ##__VA_ARGS__)
-
-#define UNREFERENCED_PARAMETER(_p)	(void)(_p)
-#define UNREFERENCED_1PARAMETER(_p)	(void)(_p)
-#define UNREFERENCED_2PARAMETER(_p, _q)	\
-	do {				\
-		(void)(_p);		\
-		(void)(_q);		\
-	} while (0)
-#define UNREFERENCED_3PARAMETER(_p, _q, _r)	\
-	do {					\
-		(void)(_p);			\
-		(void)(_q);			\
-		(void)(_r);			\
-	} while (0)
-#define UNREFERENCED_4PARAMETER(_p, _q, _r, _s)	\
-	do {					\
-		(void)(_p);			\
-		(void)(_q);			\
-		(void)(_r);			\
-		(void)(_s);			\
-	} while (0)
-
-#define	CMD_MEM_WRT_INVALIDATE	0x0010  /* BIT_4 */
-
-/* Mutex used in the shared code */
-#define IGC_MUTEX                     uintptr_t
-#define IGC_MUTEX_INIT(mutex)         (*(mutex) = 0)
-#define IGC_MUTEX_LOCK(mutex)         (*(mutex) = 1)
-#define IGC_MUTEX_UNLOCK(mutex)       (*(mutex) = 0)
-
-typedef uint64_t	u64;
-typedef uint32_t	u32;
-typedef uint16_t	u16;
-typedef uint8_t		u8;
-typedef int64_t		s64;
-typedef int32_t		s32;
-typedef int16_t		s16;
-typedef int8_t		s8;
-
-#define __le16		u16
-#define __le32		u32
-#define __le64		u64
-
-#define IGC_WRITE_FLUSH(a) IGC_READ_REG(a, IGC_STATUS)
-
-#define IGC_PCI_REG(reg)	rte_read32(reg)
-
-#define IGC_PCI_REG16(reg)	rte_read16(reg)
-
-#define IGC_PCI_REG_WRITE(reg, value)			\
-	rte_write32((rte_cpu_to_le_32(value)), reg)
-
-#define IGC_PCI_REG_WRITE_RELAXED(reg, value)		\
-	rte_write32_relaxed((rte_cpu_to_le_32(value)), reg)
-
-#define IGC_PCI_REG_WRITE16(reg, value)		\
-	rte_write16((rte_cpu_to_le_16(value)), reg)
-
-#define IGC_PCI_REG_ADDR(hw, reg) \
-	((volatile uint32_t *)((char *)(hw)->hw_addr + (reg)))
-
-#define IGC_PCI_REG_ARRAY_ADDR(hw, reg, index) \
-	IGC_PCI_REG_ADDR((hw), (reg) + ((index) << 2))
-
-#define IGC_PCI_REG_FLASH_ADDR(hw, reg) \
-	((volatile uint32_t *)((char *)(hw)->flash_address + (reg)))
-
-static inline uint32_t igc_read_addr(volatile void *addr)
-{
-	return rte_le_to_cpu_32(IGC_PCI_REG(addr));
-}
-
-static inline uint16_t igc_read_addr16(volatile void *addr)
-{
-	return rte_le_to_cpu_16(IGC_PCI_REG16(addr));
-}
-
-/* Register READ/WRITE macros */
-
-#define IGC_READ_REG(hw, reg) \
-	igc_read_addr(IGC_PCI_REG_ADDR((hw), (reg)))
-
-#define IGC_READ_REG_LE_VALUE(hw, reg) \
-	rte_read32(IGC_PCI_REG_ADDR((hw), (reg)))
-
-#define IGC_WRITE_REG(hw, reg, value) \
-	IGC_PCI_REG_WRITE(IGC_PCI_REG_ADDR((hw), (reg)), (value))
-
-#define IGC_WRITE_REG_LE_VALUE(hw, reg, value) \
-	rte_write32(value, IGC_PCI_REG_ADDR((hw), (reg)))
-
-#define IGC_READ_REG_ARRAY(hw, reg, index) \
-	IGC_PCI_REG(IGC_PCI_REG_ARRAY_ADDR((hw), (reg), (index)))
-
-#define IGC_WRITE_REG_ARRAY(hw, reg, index, value) \
-	IGC_PCI_REG_WRITE(IGC_PCI_REG_ARRAY_ADDR((hw), (reg), (index)), \
-			(value))
-
-#define IGC_READ_REG_ARRAY_DWORD IGC_READ_REG_ARRAY
-#define IGC_WRITE_REG_ARRAY_DWORD IGC_WRITE_REG_ARRAY
-
-/*
- * To be able to do IO write, we need to map IO BAR
- * (bar 2/4 depending on device).
- * Right now mapping multiple BARs is not supported by DPDK.
- * Fortunatelly we need it only for legacy hw support.
- */
-
-#define IGC_WRITE_REG_IO(hw, reg, value) \
-	IGC_WRITE_REG(hw, reg, value)
-
-/*
- * Tested on I217/I218 chipset.
- */
-
-#define IGC_READ_FLASH_REG(hw, reg) \
-	igc_read_addr(IGC_PCI_REG_FLASH_ADDR((hw), (reg)))
-
-#define IGC_READ_FLASH_REG16(hw, reg)  \
-	igc_read_addr16(IGC_PCI_REG_FLASH_ADDR((hw), (reg)))
-
-#define IGC_WRITE_FLASH_REG(hw, reg, value)  \
-	IGC_PCI_REG_WRITE(IGC_PCI_REG_FLASH_ADDR((hw), (reg)), (value))
-
-#define IGC_WRITE_FLASH_REG16(hw, reg, value) \
-	IGC_PCI_REG_WRITE16(IGC_PCI_REG_FLASH_ADDR((hw), (reg)), (value))
-
-#endif /* _IGC_OSDEP_H_ */
diff --git a/drivers/net/intel/igc/base/igc_phy.c b/drivers/net/intel/igc/base/igc_phy.c
deleted file mode 100644
index 2906bae21a..0000000000
--- a/drivers/net/intel/igc/base/igc_phy.c
+++ /dev/null
@@ -1,4420 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#include "igc_api.h"
-
-static s32 igc_wait_autoneg(struct igc_hw *hw);
-static s32 igc_access_phy_wakeup_reg_bm(struct igc_hw *hw, u32 offset,
-					  u16 *data, bool read, bool page_set);
-static u32 igc_get_phy_addr_for_hv_page(u32 page);
-static s32 igc_access_phy_debug_regs_hv(struct igc_hw *hw, u32 offset,
-					  u16 *data, bool read);
-
-/* Cable length tables */
-static const u16 igc_m88_cable_length_table[] = {
-	0, 50, 80, 110, 140, 140, IGC_CABLE_LENGTH_UNDEFINED };
-#define M88IGC_CABLE_LENGTH_TABLE_SIZE \
-		(sizeof(igc_m88_cable_length_table) / \
-		 sizeof(igc_m88_cable_length_table[0]))
-
-static const u16 igc_igp_2_cable_length_table[] = {
-	0, 0, 0, 0, 0, 0, 0, 0, 3, 5, 8, 11, 13, 16, 18, 21, 0, 0, 0, 3,
-	6, 10, 13, 16, 19, 23, 26, 29, 32, 35, 38, 41, 6, 10, 14, 18, 22,
-	26, 30, 33, 37, 41, 44, 48, 51, 54, 58, 61, 21, 26, 31, 35, 40,
-	44, 49, 53, 57, 61, 65, 68, 72, 75, 79, 82, 40, 45, 51, 56, 61,
-	66, 70, 75, 79, 83, 87, 91, 94, 98, 101, 104, 60, 66, 72, 77, 82,
-	87, 92, 96, 100, 104, 108, 111, 114, 117, 119, 121, 83, 89, 95,
-	100, 105, 109, 113, 116, 119, 122, 124, 104, 109, 114, 118, 121,
-	124};
-#define IGP02IGC_CABLE_LENGTH_TABLE_SIZE \
-		(sizeof(igc_igp_2_cable_length_table) / \
-		 sizeof(igc_igp_2_cable_length_table[0]))
-
-/**
- *  igc_init_phy_ops_generic - Initialize PHY function pointers
- *  @hw: pointer to the HW structure
- *
- *  Setups up the function pointers to no-op functions
- **/
-void igc_init_phy_ops_generic(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	DEBUGFUNC("igc_init_phy_ops_generic");
-
-	/* Initialize function pointers */
-	phy->ops.init_params = igc_null_ops_generic;
-	phy->ops.acquire = igc_null_ops_generic;
-	phy->ops.check_polarity = igc_null_ops_generic;
-	phy->ops.check_reset_block = igc_null_ops_generic;
-	phy->ops.commit = igc_null_ops_generic;
-	phy->ops.force_speed_duplex = igc_null_ops_generic;
-	phy->ops.get_cfg_done = igc_null_ops_generic;
-	phy->ops.get_cable_length = igc_null_ops_generic;
-	phy->ops.get_info = igc_null_ops_generic;
-	phy->ops.set_page = igc_null_set_page;
-	phy->ops.read_reg = igc_null_read_reg;
-	phy->ops.read_reg_locked = igc_null_read_reg;
-	phy->ops.read_reg_page = igc_null_read_reg;
-	phy->ops.release = igc_null_phy_generic;
-	phy->ops.reset = igc_null_ops_generic;
-	phy->ops.set_d0_lplu_state = igc_null_lplu_state;
-	phy->ops.set_d3_lplu_state = igc_null_lplu_state;
-	phy->ops.write_reg = igc_null_write_reg;
-	phy->ops.write_reg_locked = igc_null_write_reg;
-	phy->ops.write_reg_page = igc_null_write_reg;
-	phy->ops.power_up = igc_null_phy_generic;
-	phy->ops.power_down = igc_null_phy_generic;
-	phy->ops.read_i2c_byte = igc_read_i2c_byte_null;
-	phy->ops.write_i2c_byte = igc_write_i2c_byte_null;
-	phy->ops.cfg_on_link_up = igc_null_ops_generic;
-}
-
-/**
- *  igc_null_set_page - No-op function, return 0
- *  @hw: pointer to the HW structure
- *  @data: dummy variable
- **/
-s32 igc_null_set_page(struct igc_hw IGC_UNUSEDARG * hw,
-			u16 IGC_UNUSEDARG data)
-{
-	DEBUGFUNC("igc_null_set_page");
-	UNREFERENCED_2PARAMETER(hw, data);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_null_read_reg - No-op function, return 0
- *  @hw: pointer to the HW structure
- *  @offset: dummy variable
- *  @data: dummy variable
- **/
-s32 igc_null_read_reg(struct igc_hw IGC_UNUSEDARG * hw,
-			u32 IGC_UNUSEDARG offset, u16 IGC_UNUSEDARG * data)
-{
-	DEBUGFUNC("igc_null_read_reg");
-	UNREFERENCED_3PARAMETER(hw, offset, data);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_null_phy_generic - No-op function, return void
- *  @hw: pointer to the HW structure
- **/
-void igc_null_phy_generic(struct igc_hw IGC_UNUSEDARG * hw)
-{
-	DEBUGFUNC("igc_null_phy_generic");
-	UNREFERENCED_1PARAMETER(hw);
-}
-
-/**
- *  igc_null_lplu_state - No-op function, return 0
- *  @hw: pointer to the HW structure
- *  @active: dummy variable
- **/
-s32 igc_null_lplu_state(struct igc_hw IGC_UNUSEDARG * hw,
-			  bool IGC_UNUSEDARG active)
-{
-	DEBUGFUNC("igc_null_lplu_state");
-	UNREFERENCED_2PARAMETER(hw, active);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_null_write_reg - No-op function, return 0
- *  @hw: pointer to the HW structure
- *  @offset: dummy variable
- *  @data: dummy variable
- **/
-s32 igc_null_write_reg(struct igc_hw IGC_UNUSEDARG * hw,
-			 u32 IGC_UNUSEDARG offset, u16 IGC_UNUSEDARG data)
-{
-	DEBUGFUNC("igc_null_write_reg");
-	UNREFERENCED_3PARAMETER(hw, offset, data);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_i2c_byte_null - No-op function, return 0
- *  @hw: pointer to hardware structure
- *  @byte_offset: byte offset to write
- *  @dev_addr: device address
- *  @data: data value read
- *
- **/
-s32 igc_read_i2c_byte_null(struct igc_hw IGC_UNUSEDARG * hw,
-			     u8 IGC_UNUSEDARG byte_offset,
-			     u8 IGC_UNUSEDARG dev_addr,
-			     u8 IGC_UNUSEDARG * data)
-{
-	DEBUGFUNC("igc_read_i2c_byte_null");
-	UNREFERENCED_4PARAMETER(hw, byte_offset, dev_addr, data);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_i2c_byte_null - No-op function, return 0
- *  @hw: pointer to hardware structure
- *  @byte_offset: byte offset to write
- *  @dev_addr: device address
- *  @data: data value to write
- *
- **/
-s32 igc_write_i2c_byte_null(struct igc_hw IGC_UNUSEDARG * hw,
-			      u8 IGC_UNUSEDARG byte_offset,
-			      u8 IGC_UNUSEDARG dev_addr,
-			      u8 IGC_UNUSEDARG data)
-{
-	DEBUGFUNC("igc_write_i2c_byte_null");
-	UNREFERENCED_4PARAMETER(hw, byte_offset, dev_addr, data);
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_check_reset_block_generic - Check if PHY reset is blocked
- *  @hw: pointer to the HW structure
- *
- *  Read the PHY management control register and check whether a PHY reset
- *  is blocked.  If a reset is not blocked return IGC_SUCCESS, otherwise
- *  return IGC_BLK_PHY_RESET (12).
- **/
-s32 igc_check_reset_block_generic(struct igc_hw *hw)
-{
-	u32 manc;
-
-	DEBUGFUNC("igc_check_reset_block");
-
-	manc = IGC_READ_REG(hw, IGC_MANC);
-
-	return (manc & IGC_MANC_BLK_PHY_RST_ON_IDE) ?
-	       IGC_BLK_PHY_RESET : IGC_SUCCESS;
-}
-
-/**
- *  igc_get_phy_id - Retrieve the PHY ID and revision
- *  @hw: pointer to the HW structure
- *
- *  Reads the PHY registers and stores the PHY ID and possibly the PHY
- *  revision in the hardware structure.
- **/
-s32 igc_get_phy_id(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val = IGC_SUCCESS;
-	u16 phy_id;
-	u16 retry_count = 0;
-
-	DEBUGFUNC("igc_get_phy_id");
-
-	if (!phy->ops.read_reg)
-		return IGC_SUCCESS;
-
-	while (retry_count < 2) {
-		ret_val = phy->ops.read_reg(hw, PHY_ID1, &phy_id);
-		if (ret_val)
-			return ret_val;
-
-		phy->id = (u32)(phy_id << 16);
-		usec_delay(20);
-		ret_val = phy->ops.read_reg(hw, PHY_ID2, &phy_id);
-		if (ret_val)
-			return ret_val;
-
-		phy->id |= (u32)(phy_id & PHY_REVISION_MASK);
-		phy->revision = (u32)(phy_id & ~PHY_REVISION_MASK);
-
-		if (phy->id != 0 && phy->id != PHY_REVISION_MASK)
-			return IGC_SUCCESS;
-
-		retry_count++;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_phy_reset_dsp_generic - Reset PHY DSP
- *  @hw: pointer to the HW structure
- *
- *  Reset the digital signal processor.
- **/
-s32 igc_phy_reset_dsp_generic(struct igc_hw *hw)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("igc_phy_reset_dsp_generic");
-
-	if (!hw->phy.ops.write_reg)
-		return IGC_SUCCESS;
-
-	ret_val = hw->phy.ops.write_reg(hw, M88IGC_PHY_GEN_CONTROL, 0xC1);
-	if (ret_val)
-		return ret_val;
-
-	return hw->phy.ops.write_reg(hw, M88IGC_PHY_GEN_CONTROL, 0);
-}
-
-/**
- *  igc_read_phy_reg_mdic - Read MDI control register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Reads the MDI control register in the PHY at offset and stores the
- *  information read to data.
- **/
-s32 igc_read_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
-
-	DEBUGFUNC("igc_read_phy_reg_mdic");
-
-	if (offset > MAX_PHY_REG_ADDRESS) {
-		DEBUGOUT1("PHY Address %d is out of range\n", offset);
-		return -IGC_ERR_PARAM;
-	}
-
-	/* Set up Op-code, Phy Address, and register offset in the MDI
-	 * Control register.  The MAC will take care of interfacing with the
-	 * PHY to retrieve the desired data.
-	 */
-	mdic = ((offset << IGC_MDIC_REG_SHIFT) |
-		(phy->addr << IGC_MDIC_PHY_SHIFT) |
-		(IGC_MDIC_OP_READ));
-
-	IGC_WRITE_REG(hw, IGC_MDIC, mdic);
-
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (IGC_GEN_POLL_TIMEOUT * 3); i++) {
-		usec_delay_irq(50);
-		mdic = IGC_READ_REG(hw, IGC_MDIC);
-		if (mdic & IGC_MDIC_READY)
-			break;
-	}
-	if (!(mdic & IGC_MDIC_READY)) {
-		DEBUGOUT("MDI Read did not complete\n");
-		return -IGC_ERR_PHY;
-	}
-	if (mdic & IGC_MDIC_ERROR) {
-		DEBUGOUT("MDI Error\n");
-		return -IGC_ERR_PHY;
-	}
-	if (((mdic & IGC_MDIC_REG_MASK) >> IGC_MDIC_REG_SHIFT) != offset) {
-		DEBUGOUT2("MDI Read offset error - requested %d, returned %d\n",
-			  offset,
-			  (mdic & IGC_MDIC_REG_MASK) >> IGC_MDIC_REG_SHIFT);
-		return -IGC_ERR_PHY;
-	}
-	*data = (u16)mdic;
-
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == igc_pch2lan)
-		usec_delay_irq(100);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_phy_reg_mdic - Write MDI control register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write to register at offset
- *
- *  Writes data to MDI control register in the PHY at offset.
- **/
-s32 igc_write_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 data)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	u32 i, mdic = 0;
-
-	DEBUGFUNC("igc_write_phy_reg_mdic");
-
-	if (offset > MAX_PHY_REG_ADDRESS) {
-		DEBUGOUT1("PHY Address %d is out of range\n", offset);
-		return -IGC_ERR_PARAM;
-	}
-
-	/* Set up Op-code, Phy Address, and register offset in the MDI
-	 * Control register.  The MAC will take care of interfacing with the
-	 * PHY to retrieve the desired data.
-	 */
-	mdic = (((u32)data) |
-		(offset << IGC_MDIC_REG_SHIFT) |
-		(phy->addr << IGC_MDIC_PHY_SHIFT) |
-		(IGC_MDIC_OP_WRITE));
-
-	IGC_WRITE_REG(hw, IGC_MDIC, mdic);
-
-	/* Poll the ready bit to see if the MDI read completed
-	 * Increasing the time out as testing showed failures with
-	 * the lower time out
-	 */
-	for (i = 0; i < (IGC_GEN_POLL_TIMEOUT * 3); i++) {
-		usec_delay_irq(50);
-		mdic = IGC_READ_REG(hw, IGC_MDIC);
-		if (mdic & IGC_MDIC_READY)
-			break;
-	}
-	if (!(mdic & IGC_MDIC_READY)) {
-		DEBUGOUT("MDI Write did not complete\n");
-		return -IGC_ERR_PHY;
-	}
-	if (mdic & IGC_MDIC_ERROR) {
-		DEBUGOUT("MDI Error\n");
-		return -IGC_ERR_PHY;
-	}
-	if (((mdic & IGC_MDIC_REG_MASK) >> IGC_MDIC_REG_SHIFT) != offset) {
-		DEBUGOUT2("MDI Write offset error - requested %d, returned %d\n",
-			  offset,
-			  (mdic & IGC_MDIC_REG_MASK) >> IGC_MDIC_REG_SHIFT);
-		return -IGC_ERR_PHY;
-	}
-
-	/* Allow some time after each MDIC transaction to avoid
-	 * reading duplicate data in the next MDIC transaction.
-	 */
-	if (hw->mac.type == igc_pch2lan)
-		usec_delay_irq(100);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_phy_reg_i2c - Read PHY register using i2c
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Reads the PHY register at offset using the i2c interface and stores the
- *  retrieved information in data.
- **/
-s32 igc_read_phy_reg_i2c(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	u32 i, i2ccmd = 0;
-
-	DEBUGFUNC("igc_read_phy_reg_i2c");
-
-	/* Set up Op-code, Phy Address, and register address in the I2CCMD
-	 * register.  The MAC will take care of interfacing with the
-	 * PHY to retrieve the desired data.
-	 */
-	i2ccmd = ((offset << IGC_I2CCMD_REG_ADDR_SHIFT) |
-		  (phy->addr << IGC_I2CCMD_PHY_ADDR_SHIFT) |
-		  (IGC_I2CCMD_OPCODE_READ));
-
-	IGC_WRITE_REG(hw, IGC_I2CCMD, i2ccmd);
-
-	/* Poll the ready bit to see if the I2C read completed */
-	for (i = 0; i < IGC_I2CCMD_PHY_TIMEOUT; i++) {
-		usec_delay(50);
-		i2ccmd = IGC_READ_REG(hw, IGC_I2CCMD);
-		if (i2ccmd & IGC_I2CCMD_READY)
-			break;
-	}
-	if (!(i2ccmd & IGC_I2CCMD_READY)) {
-		DEBUGOUT("I2CCMD Read did not complete\n");
-		return -IGC_ERR_PHY;
-	}
-	if (i2ccmd & IGC_I2CCMD_ERROR) {
-		DEBUGOUT("I2CCMD Error bit set\n");
-		return -IGC_ERR_PHY;
-	}
-
-	/* Need to byte-swap the 16-bit value. */
-	*data = ((i2ccmd >> 8) & 0x00FF) | ((i2ccmd << 8) & 0xFF00);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_phy_reg_i2c - Write PHY register using i2c
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Writes the data to PHY register at the offset using the i2c interface.
- **/
-s32 igc_write_phy_reg_i2c(struct igc_hw *hw, u32 offset, u16 data)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	u32 i, i2ccmd = 0;
-	u16 phy_data_swapped;
-
-	DEBUGFUNC("igc_write_phy_reg_i2c");
-
-	/* Prevent overwriting SFP I2C EEPROM which is at A0 address. */
-	if (hw->phy.addr == 0 || hw->phy.addr > 7) {
-		DEBUGOUT1("PHY I2C Address %d is out of range.\n",
-			hw->phy.addr);
-		return -IGC_ERR_CONFIG;
-	}
-
-	/* Swap the data bytes for the I2C interface */
-	phy_data_swapped = ((data >> 8) & 0x00FF) | ((data << 8) & 0xFF00);
-
-	/* Set up Op-code, Phy Address, and register address in the I2CCMD
-	 * register.  The MAC will take care of interfacing with the
-	 * PHY to retrieve the desired data.
-	 */
-	i2ccmd = ((offset << IGC_I2CCMD_REG_ADDR_SHIFT) |
-		  (phy->addr << IGC_I2CCMD_PHY_ADDR_SHIFT) |
-		  IGC_I2CCMD_OPCODE_WRITE |
-		  phy_data_swapped);
-
-	IGC_WRITE_REG(hw, IGC_I2CCMD, i2ccmd);
-
-	/* Poll the ready bit to see if the I2C read completed */
-	for (i = 0; i < IGC_I2CCMD_PHY_TIMEOUT; i++) {
-		usec_delay(50);
-		i2ccmd = IGC_READ_REG(hw, IGC_I2CCMD);
-		if (i2ccmd & IGC_I2CCMD_READY)
-			break;
-	}
-	if (!(i2ccmd & IGC_I2CCMD_READY)) {
-		DEBUGOUT("I2CCMD Write did not complete\n");
-		return -IGC_ERR_PHY;
-	}
-	if (i2ccmd & IGC_I2CCMD_ERROR) {
-		DEBUGOUT("I2CCMD Error bit set\n");
-		return -IGC_ERR_PHY;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_sfp_data_byte - Reads SFP module data.
- *  @hw: pointer to the HW structure
- *  @offset: byte location offset to be read
- *  @data: read data buffer pointer
- *
- *  Reads one byte from SFP module data stored
- *  in SFP resided EEPROM memory or SFP diagnostic area.
- *  Function should be called with
- *  IGC_I2CCMD_SFP_DATA_ADDR(<byte offset>) for SFP module database access
- *  IGC_I2CCMD_SFP_DIAG_ADDR(<byte offset>) for SFP diagnostics parameters
- *  access
- **/
-s32 igc_read_sfp_data_byte(struct igc_hw *hw, u16 offset, u8 *data)
-{
-	u32 i = 0;
-	u32 i2ccmd = 0;
-	u32 data_local = 0;
-
-	DEBUGFUNC("igc_read_sfp_data_byte");
-
-	if (offset > IGC_I2CCMD_SFP_DIAG_ADDR(255)) {
-		DEBUGOUT("I2CCMD command address exceeds upper limit\n");
-		return -IGC_ERR_PHY;
-	}
-
-	/* Set up Op-code, EEPROM Address,in the I2CCMD
-	 * register. The MAC will take care of interfacing with the
-	 * EEPROM to retrieve the desired data.
-	 */
-	i2ccmd = ((offset << IGC_I2CCMD_REG_ADDR_SHIFT) |
-		  IGC_I2CCMD_OPCODE_READ);
-
-	IGC_WRITE_REG(hw, IGC_I2CCMD, i2ccmd);
-
-	/* Poll the ready bit to see if the I2C read completed */
-	for (i = 0; i < IGC_I2CCMD_PHY_TIMEOUT; i++) {
-		usec_delay(50);
-		data_local = IGC_READ_REG(hw, IGC_I2CCMD);
-		if (data_local & IGC_I2CCMD_READY)
-			break;
-	}
-	if (!(data_local & IGC_I2CCMD_READY)) {
-		DEBUGOUT("I2CCMD Read did not complete\n");
-		return -IGC_ERR_PHY;
-	}
-	if (data_local & IGC_I2CCMD_ERROR) {
-		DEBUGOUT("I2CCMD Error bit set\n");
-		return -IGC_ERR_PHY;
-	}
-	*data = (u8)data_local & 0xFF;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_sfp_data_byte - Writes SFP module data.
- *  @hw: pointer to the HW structure
- *  @offset: byte location offset to write to
- *  @data: data to write
- *
- *  Writes one byte to SFP module data stored
- *  in SFP resided EEPROM memory or SFP diagnostic area.
- *  Function should be called with
- *  IGC_I2CCMD_SFP_DATA_ADDR(<byte offset>) for SFP module database access
- *  IGC_I2CCMD_SFP_DIAG_ADDR(<byte offset>) for SFP diagnostics parameters
- *  access
- **/
-s32 igc_write_sfp_data_byte(struct igc_hw *hw, u16 offset, u8 data)
-{
-	u32 i = 0;
-	u32 i2ccmd = 0;
-	u32 data_local = 0;
-
-	DEBUGFUNC("igc_write_sfp_data_byte");
-
-	if (offset > IGC_I2CCMD_SFP_DIAG_ADDR(255)) {
-		DEBUGOUT("I2CCMD command address exceeds upper limit\n");
-		return -IGC_ERR_PHY;
-	}
-	/* The programming interface is 16 bits wide
-	 * so we need to read the whole word first
-	 * then update appropriate byte lane and write
-	 * the updated word back.
-	 */
-	/* Set up Op-code, EEPROM Address,in the I2CCMD
-	 * register. The MAC will take care of interfacing
-	 * with an EEPROM to write the data given.
-	 */
-	i2ccmd = ((offset << IGC_I2CCMD_REG_ADDR_SHIFT) |
-		  IGC_I2CCMD_OPCODE_READ);
-	/* Set a command to read single word */
-	IGC_WRITE_REG(hw, IGC_I2CCMD, i2ccmd);
-	for (i = 0; i < IGC_I2CCMD_PHY_TIMEOUT; i++) {
-		usec_delay(50);
-		/* Poll the ready bit to see if lastly
-		 * launched I2C operation completed
-		 */
-		i2ccmd = IGC_READ_REG(hw, IGC_I2CCMD);
-		if (i2ccmd & IGC_I2CCMD_READY) {
-			/* Check if this is READ or WRITE phase */
-			if ((i2ccmd & IGC_I2CCMD_OPCODE_READ) ==
-			    IGC_I2CCMD_OPCODE_READ) {
-				/* Write the selected byte
-				 * lane and update whole word
-				 */
-				data_local = i2ccmd & 0xFF00;
-				data_local |= (u32)data;
-				i2ccmd = ((offset <<
-					IGC_I2CCMD_REG_ADDR_SHIFT) |
-					IGC_I2CCMD_OPCODE_WRITE | data_local);
-				IGC_WRITE_REG(hw, IGC_I2CCMD, i2ccmd);
-			} else {
-				break;
-			}
-		}
-	}
-	if (!(i2ccmd & IGC_I2CCMD_READY)) {
-		DEBUGOUT("I2CCMD Write did not complete\n");
-		return -IGC_ERR_PHY;
-	}
-	if (i2ccmd & IGC_I2CCMD_ERROR) {
-		DEBUGOUT("I2CCMD Error bit set\n");
-		return -IGC_ERR_PHY;
-	}
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_phy_reg_m88 - Read m88 PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Acquires semaphore, if necessary, then reads the PHY register at offset
- *  and storing the retrieved information in data.  Release any acquired
- *  semaphores before exiting.
- **/
-s32 igc_read_phy_reg_m88(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("igc_read_phy_reg_m88");
-
-	if (!hw->phy.ops.acquire)
-		return IGC_SUCCESS;
-
-	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = igc_read_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & offset,
-					  data);
-
-	hw->phy.ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_write_phy_reg_m88 - Write m88 PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Acquires semaphore, if necessary, then writes the data to PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-s32 igc_write_phy_reg_m88(struct igc_hw *hw, u32 offset, u16 data)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("igc_write_phy_reg_m88");
-
-	if (!hw->phy.ops.acquire)
-		return IGC_SUCCESS;
-
-	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = igc_write_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & offset,
-					   data);
-
-	hw->phy.ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_set_page_igp - Set page as on IGP-like PHY(s)
- *  @hw: pointer to the HW structure
- *  @page: page to set (shifted left when necessary)
- *
- *  Sets PHY page required for PHY register access.  Assumes semaphore is
- *  already acquired.  Note, this function sets phy.addr to 1 so the caller
- *  must set it appropriately (if necessary) after this function returns.
- **/
-s32 igc_set_page_igp(struct igc_hw *hw, u16 page)
-{
-	DEBUGFUNC("igc_set_page_igp");
-
-	DEBUGOUT1("Setting page 0x%x\n", page);
-
-	hw->phy.addr = 1;
-
-	return igc_write_phy_reg_mdic(hw, IGP01IGC_PHY_PAGE_SELECT, page);
-}
-
-/**
- *  __igc_read_phy_reg_igp - Read igp PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *  @locked: semaphore has already been acquired or not
- *
- *  Acquires semaphore, if necessary, then reads the PHY register at offset
- *  and stores the retrieved information in data.  Release any acquired
- *  semaphores before exiting.
- **/
-static s32 __igc_read_phy_reg_igp(struct igc_hw *hw, u32 offset, u16 *data,
-				    bool locked)
-{
-	s32 ret_val = IGC_SUCCESS;
-
-	DEBUGFUNC("__igc_read_phy_reg_igp");
-
-	if (!locked) {
-		if (!hw->phy.ops.acquire)
-			return IGC_SUCCESS;
-
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
-	}
-
-	if (offset > MAX_PHY_MULTI_PAGE_REG)
-		ret_val = igc_write_phy_reg_mdic(hw,
-						   IGP01IGC_PHY_PAGE_SELECT,
-						   (u16)offset);
-	if (!ret_val)
-		ret_val = igc_read_phy_reg_mdic(hw,
-						  MAX_PHY_REG_ADDRESS & offset,
-						  data);
-	if (!locked)
-		hw->phy.ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_read_phy_reg_igp - Read igp PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Acquires semaphore then reads the PHY register at offset and stores the
- *  retrieved information in data.
- *  Release the acquired semaphore before exiting.
- **/
-s32 igc_read_phy_reg_igp(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	return __igc_read_phy_reg_igp(hw, offset, data, false);
-}
-
-/**
- *  igc_read_phy_reg_igp_locked - Read igp PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Reads the PHY register at offset and stores the retrieved information
- *  in data.  Assumes semaphore already acquired.
- **/
-s32 igc_read_phy_reg_igp_locked(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	return __igc_read_phy_reg_igp(hw, offset, data, true);
-}
-
-/**
- *  igc_write_phy_reg_igp - Write igp PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *  @locked: semaphore has already been acquired or not
- *
- *  Acquires semaphore, if necessary, then writes the data to PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-static s32 __igc_write_phy_reg_igp(struct igc_hw *hw, u32 offset, u16 data,
-				     bool locked)
-{
-	s32 ret_val = IGC_SUCCESS;
-
-	DEBUGFUNC("igc_write_phy_reg_igp");
-
-	if (!locked) {
-		if (!hw->phy.ops.acquire)
-			return IGC_SUCCESS;
-
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
-	}
-
-	if (offset > MAX_PHY_MULTI_PAGE_REG)
-		ret_val = igc_write_phy_reg_mdic(hw,
-						   IGP01IGC_PHY_PAGE_SELECT,
-						   (u16)offset);
-	if (!ret_val)
-		ret_val = igc_write_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS &
-						       offset,
-						   data);
-	if (!locked)
-		hw->phy.ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_write_phy_reg_igp - Write igp PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Acquires semaphore then writes the data to PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-s32 igc_write_phy_reg_igp(struct igc_hw *hw, u32 offset, u16 data)
-{
-	return __igc_write_phy_reg_igp(hw, offset, data, false);
-}
-
-/**
- *  igc_write_phy_reg_igp_locked - Write igp PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Writes the data to PHY register at the offset.
- *  Assumes semaphore already acquired.
- **/
-s32 igc_write_phy_reg_igp_locked(struct igc_hw *hw, u32 offset, u16 data)
-{
-	return __igc_write_phy_reg_igp(hw, offset, data, true);
-}
-
-/**
- *  __igc_read_kmrn_reg - Read kumeran register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *  @locked: semaphore has already been acquired or not
- *
- *  Acquires semaphore, if necessary.  Then reads the PHY register at offset
- *  using the kumeran interface.  The information retrieved is stored in data.
- *  Release any acquired semaphores before exiting.
- **/
-static s32 __igc_read_kmrn_reg(struct igc_hw *hw, u32 offset, u16 *data,
-				 bool locked)
-{
-	u32 kmrnctrlsta;
-
-	DEBUGFUNC("__igc_read_kmrn_reg");
-
-	if (!locked) {
-		s32 ret_val = IGC_SUCCESS;
-
-		if (!hw->phy.ops.acquire)
-			return IGC_SUCCESS;
-
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
-	}
-
-	kmrnctrlsta = ((offset << IGC_KMRNCTRLSTA_OFFSET_SHIFT) &
-		       IGC_KMRNCTRLSTA_OFFSET) | IGC_KMRNCTRLSTA_REN;
-	IGC_WRITE_REG(hw, IGC_KMRNCTRLSTA, kmrnctrlsta);
-	IGC_WRITE_FLUSH(hw);
-
-	usec_delay(2);
-
-	kmrnctrlsta = IGC_READ_REG(hw, IGC_KMRNCTRLSTA);
-	*data = (u16)kmrnctrlsta;
-
-	if (!locked)
-		hw->phy.ops.release(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_read_kmrn_reg_generic -  Read kumeran register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Acquires semaphore then reads the PHY register at offset using the
- *  kumeran interface.  The information retrieved is stored in data.
- *  Release the acquired semaphore before exiting.
- **/
-s32 igc_read_kmrn_reg_generic(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	return __igc_read_kmrn_reg(hw, offset, data, false);
-}
-
-/**
- *  igc_read_kmrn_reg_locked -  Read kumeran register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Reads the PHY register at offset using the kumeran interface.  The
- *  information retrieved is stored in data.
- *  Assumes semaphore already acquired.
- **/
-s32 igc_read_kmrn_reg_locked(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	return __igc_read_kmrn_reg(hw, offset, data, true);
-}
-
-/**
- *  __igc_write_kmrn_reg - Write kumeran register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *  @locked: semaphore has already been acquired or not
- *
- *  Acquires semaphore, if necessary.  Then write the data to PHY register
- *  at the offset using the kumeran interface.  Release any acquired semaphores
- *  before exiting.
- **/
-static s32 __igc_write_kmrn_reg(struct igc_hw *hw, u32 offset, u16 data,
-				  bool locked)
-{
-	u32 kmrnctrlsta;
-
-	DEBUGFUNC("igc_write_kmrn_reg_generic");
-
-	if (!locked) {
-		s32 ret_val = IGC_SUCCESS;
-
-		if (!hw->phy.ops.acquire)
-			return IGC_SUCCESS;
-
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
-	}
-
-	kmrnctrlsta = ((offset << IGC_KMRNCTRLSTA_OFFSET_SHIFT) &
-		       IGC_KMRNCTRLSTA_OFFSET) | data;
-	IGC_WRITE_REG(hw, IGC_KMRNCTRLSTA, kmrnctrlsta);
-	IGC_WRITE_FLUSH(hw);
-
-	usec_delay(2);
-
-	if (!locked)
-		hw->phy.ops.release(hw);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_kmrn_reg_generic -  Write kumeran register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Acquires semaphore then writes the data to the PHY register at the offset
- *  using the kumeran interface.  Release the acquired semaphore before exiting.
- **/
-s32 igc_write_kmrn_reg_generic(struct igc_hw *hw, u32 offset, u16 data)
-{
-	return __igc_write_kmrn_reg(hw, offset, data, false);
-}
-
-/**
- *  igc_write_kmrn_reg_locked -  Write kumeran register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Write the data to PHY register at the offset using the kumeran interface.
- *  Assumes semaphore already acquired.
- **/
-s32 igc_write_kmrn_reg_locked(struct igc_hw *hw, u32 offset, u16 data)
-{
-	return __igc_write_kmrn_reg(hw, offset, data, true);
-}
-
-/**
- *  igc_set_master_slave_mode - Setup PHY for Master/slave mode
- *  @hw: pointer to the HW structure
- *
- *  Sets up Master/slave mode
- **/
-static s32 igc_set_master_slave_mode(struct igc_hw *hw)
-{
-	s32 ret_val;
-	u16 phy_data;
-
-	/* Resolve Master/Slave mode */
-	ret_val = hw->phy.ops.read_reg(hw, PHY_1000T_CTRL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	/* load defaults for future use */
-	hw->phy.original_ms_type = (phy_data & CR_1000T_MS_ENABLE) ?
-				   ((phy_data & CR_1000T_MS_VALUE) ?
-				    igc_ms_force_master :
-				    igc_ms_force_slave) : igc_ms_auto;
-
-	switch (hw->phy.ms_type) {
-	case igc_ms_force_master:
-		phy_data |= (CR_1000T_MS_ENABLE | CR_1000T_MS_VALUE);
-		break;
-	case igc_ms_force_slave:
-		phy_data |= CR_1000T_MS_ENABLE;
-		phy_data &= ~(CR_1000T_MS_VALUE);
-		break;
-	case igc_ms_auto:
-		phy_data &= ~CR_1000T_MS_ENABLE;
-		/* fall-through */
-	default:
-		break;
-	}
-
-	return hw->phy.ops.write_reg(hw, PHY_1000T_CTRL, phy_data);
-}
-
-/**
- *  igc_copper_link_setup_82577 - Setup 82577 PHY for copper link
- *  @hw: pointer to the HW structure
- *
- *  Sets up Carrier-sense on Transmit and downshift values.
- **/
-s32 igc_copper_link_setup_82577(struct igc_hw *hw)
-{
-	s32 ret_val;
-	u16 phy_data;
-
-	DEBUGFUNC("igc_copper_link_setup_82577");
-
-	if (hw->phy.type == igc_phy_82580) {
-		ret_val = hw->phy.ops.reset(hw);
-		if (ret_val) {
-			DEBUGOUT("Error resetting the PHY.\n");
-			return ret_val;
-		}
-	}
-
-	/* Enable CRS on Tx. This must be set for half-duplex operation. */
-	ret_val = hw->phy.ops.read_reg(hw, I82577_CFG_REG, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	phy_data |= I82577_CFG_ASSERT_CRS_ON_TX;
-
-	/* Enable downshift */
-	phy_data |= I82577_CFG_ENABLE_DOWNSHIFT;
-
-	ret_val = hw->phy.ops.write_reg(hw, I82577_CFG_REG, phy_data);
-	if (ret_val)
-		return ret_val;
-
-	/* Set MDI/MDIX mode */
-	ret_val = hw->phy.ops.read_reg(hw, I82577_PHY_CTRL_2, &phy_data);
-	if (ret_val)
-		return ret_val;
-	phy_data &= ~I82577_PHY_CTRL2_MDIX_CFG_MASK;
-	/* Options:
-	 *   0 - Auto (default)
-	 *   1 - MDI mode
-	 *   2 - MDI-X mode
-	 */
-	switch (hw->phy.mdix) {
-	case 1:
-		break;
-	case 2:
-		phy_data |= I82577_PHY_CTRL2_MANUAL_MDIX;
-		break;
-	case 0:
-	default:
-		phy_data |= I82577_PHY_CTRL2_AUTO_MDI_MDIX;
-		break;
-	}
-	ret_val = hw->phy.ops.write_reg(hw, I82577_PHY_CTRL_2, phy_data);
-	if (ret_val)
-		return ret_val;
-
-	return igc_set_master_slave_mode(hw);
-}
-
-/**
- *  igc_copper_link_setup_m88 - Setup m88 PHY's for copper link
- *  @hw: pointer to the HW structure
- *
- *  Sets up MDI/MDI-X and polarity for m88 PHY's.  If necessary, transmit clock
- *  and downshift values are set also.
- **/
-s32 igc_copper_link_setup_m88(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data;
-
-	DEBUGFUNC("igc_copper_link_setup_m88");
-
-
-	/* Enable CRS on Tx. This must be set for half-duplex operation. */
-	ret_val = phy->ops.read_reg(hw, M88IGC_PHY_SPEC_CTRL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	/* For BM PHY this bit is downshift enable */
-	if (phy->type != igc_phy_bm)
-		phy_data |= M88IGC_PSCR_ASSERT_CRS_ON_TX;
-
-	/* Options:
-	 *   MDI/MDI-X = 0 (default)
-	 *   0 - Auto for all speeds
-	 *   1 - MDI mode
-	 *   2 - MDI-X mode
-	 *   3 - Auto for 1000Base-T only (MDI-X for 10/100Base-T modes)
-	 */
-	phy_data &= ~M88IGC_PSCR_AUTO_X_MODE;
-
-	switch (phy->mdix) {
-	case 1:
-		phy_data |= M88IGC_PSCR_MDI_MANUAL_MODE;
-		break;
-	case 2:
-		phy_data |= M88IGC_PSCR_MDIX_MANUAL_MODE;
-		break;
-	case 3:
-		phy_data |= M88IGC_PSCR_AUTO_X_1000T;
-		break;
-	case 0:
-	default:
-		phy_data |= M88IGC_PSCR_AUTO_X_MODE;
-		break;
-	}
-
-	/* Options:
-	 *   disable_polarity_correction = 0 (default)
-	 *       Automatic Correction for Reversed Cable Polarity
-	 *   0 - Disabled
-	 *   1 - Enabled
-	 */
-	phy_data &= ~M88IGC_PSCR_POLARITY_REVERSAL;
-	if (phy->disable_polarity_correction)
-		phy_data |= M88IGC_PSCR_POLARITY_REVERSAL;
-
-	/* Enable downshift on BM (disabled by default) */
-	if (phy->type == igc_phy_bm) {
-		/* For 82574/82583, first disable then enable downshift */
-		if (phy->id == BMIGC_E_PHY_ID_R2) {
-			phy_data &= ~BMIGC_PSCR_ENABLE_DOWNSHIFT;
-			ret_val = phy->ops.write_reg(hw, M88IGC_PHY_SPEC_CTRL,
-						     phy_data);
-			if (ret_val)
-				return ret_val;
-			/* Commit the changes. */
-			ret_val = phy->ops.commit(hw);
-			if (ret_val) {
-				DEBUGOUT("Error committing the PHY changes\n");
-				return ret_val;
-			}
-		}
-
-		phy_data |= BMIGC_PSCR_ENABLE_DOWNSHIFT;
-	}
-
-	ret_val = phy->ops.write_reg(hw, M88IGC_PHY_SPEC_CTRL, phy_data);
-	if (ret_val)
-		return ret_val;
-
-	if (phy->type == igc_phy_m88 && phy->revision < IGC_REVISION_4 &&
-			phy->id != BMIGC_E_PHY_ID_R2) {
-		/* Force TX_CLK in the Extended PHY Specific Control Register
-		 * to 25MHz clock.
-		 */
-		ret_val = phy->ops.read_reg(hw, M88IGC_EXT_PHY_SPEC_CTRL,
-					    &phy_data);
-		if (ret_val)
-			return ret_val;
-
-		phy_data |= M88IGC_EPSCR_TX_CLK_25;
-
-		if (phy->revision == IGC_REVISION_2 &&
-				phy->id == M88E1111_I_PHY_ID) {
-			/* 82573L PHY - set the downshift counter to 5x. */
-			phy_data &= ~M88EC018_EPSCR_DOWNSHIFT_COUNTER_MASK;
-			phy_data |= M88EC018_EPSCR_DOWNSHIFT_COUNTER_5X;
-		} else {
-			/* Configure Master and Slave downshift values */
-			phy_data &= ~(M88IGC_EPSCR_MASTER_DOWNSHIFT_MASK |
-				     M88IGC_EPSCR_SLAVE_DOWNSHIFT_MASK);
-			phy_data |= (M88IGC_EPSCR_MASTER_DOWNSHIFT_1X |
-				     M88IGC_EPSCR_SLAVE_DOWNSHIFT_1X);
-		}
-		ret_val = phy->ops.write_reg(hw, M88IGC_EXT_PHY_SPEC_CTRL,
-					     phy_data);
-		if (ret_val)
-			return ret_val;
-	}
-
-	if (phy->type == igc_phy_bm && phy->id == BMIGC_E_PHY_ID_R2) {
-		/* Set PHY page 0, register 29 to 0x0003 */
-		ret_val = phy->ops.write_reg(hw, 29, 0x0003);
-		if (ret_val)
-			return ret_val;
-
-		/* Set PHY page 0, register 30 to 0x0000 */
-		ret_val = phy->ops.write_reg(hw, 30, 0x0000);
-		if (ret_val)
-			return ret_val;
-	}
-
-	/* Commit the changes. */
-	ret_val = phy->ops.commit(hw);
-	if (ret_val) {
-		DEBUGOUT("Error committing the PHY changes\n");
-		return ret_val;
-	}
-
-	if (phy->type == igc_phy_82578) {
-		ret_val = phy->ops.read_reg(hw, M88IGC_EXT_PHY_SPEC_CTRL,
-					    &phy_data);
-		if (ret_val)
-			return ret_val;
-
-		/* 82578 PHY - set the downshift count to 1x. */
-		phy_data |= I82578_EPSCR_DOWNSHIFT_ENABLE;
-		phy_data &= ~I82578_EPSCR_DOWNSHIFT_COUNTER_MASK;
-		ret_val = phy->ops.write_reg(hw, M88IGC_EXT_PHY_SPEC_CTRL,
-					     phy_data);
-		if (ret_val)
-			return ret_val;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_copper_link_setup_m88_gen2 - Setup m88 PHY's for copper link
- *  @hw: pointer to the HW structure
- *
- *  Sets up MDI/MDI-X and polarity for i347-AT4, m88e1322 and m88e1112 PHY's.
- *  Also enables and sets the downshift parameters.
- **/
-s32 igc_copper_link_setup_m88_gen2(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data;
-
-	DEBUGFUNC("igc_copper_link_setup_m88_gen2");
-
-
-	/* Enable CRS on Tx. This must be set for half-duplex operation. */
-	ret_val = phy->ops.read_reg(hw, M88IGC_PHY_SPEC_CTRL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	/* Options:
-	 *   MDI/MDI-X = 0 (default)
-	 *   0 - Auto for all speeds
-	 *   1 - MDI mode
-	 *   2 - MDI-X mode
-	 *   3 - Auto for 1000Base-T only (MDI-X for 10/100Base-T modes)
-	 */
-	phy_data &= ~M88IGC_PSCR_AUTO_X_MODE;
-
-	switch (phy->mdix) {
-	case 1:
-		phy_data |= M88IGC_PSCR_MDI_MANUAL_MODE;
-		break;
-	case 2:
-		phy_data |= M88IGC_PSCR_MDIX_MANUAL_MODE;
-		break;
-	case 3:
-		/* M88E1112 does not support this mode) */
-		if (phy->id != M88E1112_E_PHY_ID) {
-			phy_data |= M88IGC_PSCR_AUTO_X_1000T;
-			break;
-		}
-		/* Fall through */
-	case 0:
-	default:
-		phy_data |= M88IGC_PSCR_AUTO_X_MODE;
-		break;
-	}
-
-	/* Options:
-	 *   disable_polarity_correction = 0 (default)
-	 *       Automatic Correction for Reversed Cable Polarity
-	 *   0 - Disabled
-	 *   1 - Enabled
-	 */
-	phy_data &= ~M88IGC_PSCR_POLARITY_REVERSAL;
-	if (phy->disable_polarity_correction)
-		phy_data |= M88IGC_PSCR_POLARITY_REVERSAL;
-
-	/* Enable downshift and setting it to X6 */
-	if (phy->id == M88E1543_E_PHY_ID) {
-		phy_data &= ~I347AT4_PSCR_DOWNSHIFT_ENABLE;
-		ret_val =
-		    phy->ops.write_reg(hw, M88IGC_PHY_SPEC_CTRL, phy_data);
-		if (ret_val)
-			return ret_val;
-
-		ret_val = phy->ops.commit(hw);
-		if (ret_val) {
-			DEBUGOUT("Error committing the PHY changes\n");
-			return ret_val;
-		}
-	}
-
-	phy_data &= ~I347AT4_PSCR_DOWNSHIFT_MASK;
-	phy_data |= I347AT4_PSCR_DOWNSHIFT_6X;
-	phy_data |= I347AT4_PSCR_DOWNSHIFT_ENABLE;
-
-	ret_val = phy->ops.write_reg(hw, M88IGC_PHY_SPEC_CTRL, phy_data);
-	if (ret_val)
-		return ret_val;
-
-	/* Commit the changes. */
-	ret_val = phy->ops.commit(hw);
-	if (ret_val) {
-		DEBUGOUT("Error committing the PHY changes\n");
-		return ret_val;
-	}
-
-	ret_val = igc_set_master_slave_mode(hw);
-	if (ret_val)
-		return ret_val;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_copper_link_setup_igp - Setup igp PHY's for copper link
- *  @hw: pointer to the HW structure
- *
- *  Sets up LPLU, MDI/MDI-X, polarity, Smartspeed and Master/Slave config for
- *  igp PHY's.
- **/
-s32 igc_copper_link_setup_igp(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 data;
-
-	DEBUGFUNC("igc_copper_link_setup_igp");
-
-
-	ret_val = hw->phy.ops.reset(hw);
-	if (ret_val) {
-		DEBUGOUT("Error resetting the PHY.\n");
-		return ret_val;
-	}
-
-	/* Wait 100ms for MAC to configure PHY from NVM settings, to avoid
-	 * timeout issues when LFS is enabled.
-	 */
-	msec_delay(100);
-
-	/* The NVM settings will configure LPLU in D3 for
-	 * non-IGP1 PHYs.
-	 */
-	if (phy->type == igc_phy_igp) {
-		/* disable lplu d3 during driver init */
-		ret_val = hw->phy.ops.set_d3_lplu_state(hw, false);
-		if (ret_val) {
-			DEBUGOUT("Error Disabling LPLU D3\n");
-			return ret_val;
-		}
-	}
-
-	/* disable lplu d0 during driver init */
-	if (hw->phy.ops.set_d0_lplu_state) {
-		ret_val = hw->phy.ops.set_d0_lplu_state(hw, false);
-		if (ret_val) {
-			DEBUGOUT("Error Disabling LPLU D0\n");
-			return ret_val;
-		}
-	}
-	/* Configure mdi-mdix settings */
-	ret_val = phy->ops.read_reg(hw, IGP01IGC_PHY_PORT_CTRL, &data);
-	if (ret_val)
-		return ret_val;
-
-	data &= ~IGP01IGC_PSCR_AUTO_MDIX;
-
-	switch (phy->mdix) {
-	case 1:
-		data &= ~IGP01IGC_PSCR_FORCE_MDI_MDIX;
-		break;
-	case 2:
-		data |= IGP01IGC_PSCR_FORCE_MDI_MDIX;
-		break;
-	case 0:
-	default:
-		data |= IGP01IGC_PSCR_AUTO_MDIX;
-		break;
-	}
-	ret_val = phy->ops.write_reg(hw, IGP01IGC_PHY_PORT_CTRL, data);
-	if (ret_val)
-		return ret_val;
-
-	/* set auto-master slave resolution settings */
-	if (hw->mac.autoneg) {
-		/* when autonegotiation advertisement is only 1000Mbps then we
-		 * should disable SmartSpeed and enable Auto MasterSlave
-		 * resolution as hardware default.
-		 */
-		if (phy->autoneg_advertised == ADVERTISE_1000_FULL) {
-			/* Disable SmartSpeed */
-			ret_val = phy->ops.read_reg(hw,
-						    IGP01IGC_PHY_PORT_CONFIG,
-						    &data);
-			if (ret_val)
-				return ret_val;
-
-			data &= ~IGP01IGC_PSCFR_SMART_SPEED;
-			ret_val = phy->ops.write_reg(hw,
-						     IGP01IGC_PHY_PORT_CONFIG,
-						     data);
-			if (ret_val)
-				return ret_val;
-
-			/* Set auto Master/Slave resolution process */
-			ret_val = phy->ops.read_reg(hw, PHY_1000T_CTRL, &data);
-			if (ret_val)
-				return ret_val;
-
-			data &= ~CR_1000T_MS_ENABLE;
-			ret_val = phy->ops.write_reg(hw, PHY_1000T_CTRL, data);
-			if (ret_val)
-				return ret_val;
-		}
-
-		ret_val = igc_set_master_slave_mode(hw);
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_phy_setup_autoneg - Configure PHY for auto-negotiation
- *  @hw: pointer to the HW structure
- *
- *  Reads the MII auto-neg advertisement register and/or the 1000T control
- *  register and if the PHY is already setup for auto-negotiation, then
- *  return successful.  Otherwise, setup advertisement and flow control to
- *  the appropriate values for the wanted auto-negotiation.
- **/
-s32 igc_phy_setup_autoneg(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 mii_autoneg_adv_reg;
-	u16 mii_1000t_ctrl_reg = 0;
-	u16 aneg_multigbt_an_ctrl = 0;
-
-	DEBUGFUNC("igc_phy_setup_autoneg");
-
-	phy->autoneg_advertised &= phy->autoneg_mask;
-
-	/* Read the MII Auto-Neg Advertisement Register (Address 4). */
-	ret_val = phy->ops.read_reg(hw, PHY_AUTONEG_ADV, &mii_autoneg_adv_reg);
-	if (ret_val)
-		return ret_val;
-
-	if (phy->autoneg_mask & ADVERTISE_1000_FULL) {
-		/* Read the MII 1000Base-T Control Register (Address 9). */
-		ret_val = phy->ops.read_reg(hw, PHY_1000T_CTRL,
-					    &mii_1000t_ctrl_reg);
-		if (ret_val)
-			return ret_val;
-	}
-
-	if (phy->autoneg_mask & ADVERTISE_2500_FULL) {
-	/* Read the MULTI GBT AN Control Register - reg 7.32 */
-		ret_val = phy->ops.read_reg(hw, (STANDARD_AN_REG_MASK <<
-					    MMD_DEVADDR_SHIFT) |
-					    ANEG_MULTIGBT_AN_CTRL,
-					    &aneg_multigbt_an_ctrl);
-
-		if (ret_val)
-			return ret_val;
-	}
-
-	/* Need to parse both autoneg_advertised and fc and set up
-	 * the appropriate PHY registers.  First we will parse for
-	 * autoneg_advertised software override.  Since we can advertise
-	 * a plethora of combinations, we need to check each bit
-	 * individually.
-	 */
-
-	/* First we clear all the 10/100 mb speed bits in the Auto-Neg
-	 * Advertisement Register (Address 4) and the 1000 mb speed bits in
-	 * the  1000Base-T Control Register (Address 9).
-	 */
-	mii_autoneg_adv_reg &= ~(NWAY_AR_100TX_FD_CAPS |
-				 NWAY_AR_100TX_HD_CAPS |
-				 NWAY_AR_10T_FD_CAPS   |
-				 NWAY_AR_10T_HD_CAPS);
-	mii_1000t_ctrl_reg &= ~(CR_1000T_HD_CAPS | CR_1000T_FD_CAPS);
-
-	DEBUGOUT1("autoneg_advertised %x\n", phy->autoneg_advertised);
-
-	/* Do we want to advertise 10 Mb Half Duplex? */
-	if (phy->autoneg_advertised & ADVERTISE_10_HALF) {
-		DEBUGOUT("Advertise 10mb Half duplex\n");
-		mii_autoneg_adv_reg |= NWAY_AR_10T_HD_CAPS;
-	}
-
-	/* Do we want to advertise 10 Mb Full Duplex? */
-	if (phy->autoneg_advertised & ADVERTISE_10_FULL) {
-		DEBUGOUT("Advertise 10mb Full duplex\n");
-		mii_autoneg_adv_reg |= NWAY_AR_10T_FD_CAPS;
-	}
-
-	/* Do we want to advertise 100 Mb Half Duplex? */
-	if (phy->autoneg_advertised & ADVERTISE_100_HALF) {
-		DEBUGOUT("Advertise 100mb Half duplex\n");
-		mii_autoneg_adv_reg |= NWAY_AR_100TX_HD_CAPS;
-	}
-
-	/* Do we want to advertise 100 Mb Full Duplex? */
-	if (phy->autoneg_advertised & ADVERTISE_100_FULL) {
-		DEBUGOUT("Advertise 100mb Full duplex\n");
-		mii_autoneg_adv_reg |= NWAY_AR_100TX_FD_CAPS;
-	}
-
-	/* We do not allow the Phy to advertise 1000 Mb Half Duplex */
-	if (phy->autoneg_advertised & ADVERTISE_1000_HALF)
-		DEBUGOUT("Advertise 1000mb Half duplex request denied!\n");
-
-	/* Do we want to advertise 1000 Mb Full Duplex? */
-	if (phy->autoneg_advertised & ADVERTISE_1000_FULL) {
-		DEBUGOUT("Advertise 1000mb Full duplex\n");
-		mii_1000t_ctrl_reg |= CR_1000T_FD_CAPS;
-	}
-
-	/* We do not allow the Phy to advertise 2500 Mb Half Duplex */
-	if (phy->autoneg_advertised & ADVERTISE_2500_HALF)
-		DEBUGOUT("Advertise 2500mb Half duplex request denied!\n");
-
-	/* Do we want to advertise 2500 Mb Full Duplex? */
-	if (phy->autoneg_advertised & ADVERTISE_2500_FULL) {
-		DEBUGOUT("Advertise 2500mb Full duplex\n");
-		aneg_multigbt_an_ctrl |= CR_2500T_FD_CAPS;
-	} else {
-		aneg_multigbt_an_ctrl &= ~CR_2500T_FD_CAPS;
-	}
-
-	/* Check for a software override of the flow control settings, and
-	 * setup the PHY advertisement registers accordingly.  If
-	 * auto-negotiation is enabled, then software will have to set the
-	 * "PAUSE" bits to the correct value in the Auto-Negotiation
-	 * Advertisement Register (PHY_AUTONEG_ADV) and re-start auto-
-	 * negotiation.
-	 *
-	 * The possible values of the "fc" parameter are:
-	 *      0:  Flow control is completely disabled
-	 *      1:  Rx flow control is enabled (we can receive pause frames
-	 *          but not send pause frames).
-	 *      2:  Tx flow control is enabled (we can send pause frames
-	 *          but we do not support receiving pause frames).
-	 *      3:  Both Rx and Tx flow control (symmetric) are enabled.
-	 *  other:  No software override.  The flow control configuration
-	 *          in the EEPROM is used.
-	 */
-	switch (hw->fc.current_mode) {
-	case igc_fc_none:
-		/* Flow control (Rx & Tx) is completely disabled by a
-		 * software over-ride.
-		 */
-		mii_autoneg_adv_reg &= ~(NWAY_AR_ASM_DIR | NWAY_AR_PAUSE);
-		break;
-	case igc_fc_rx_pause:
-		/* Rx Flow control is enabled, and Tx Flow control is
-		 * disabled, by a software over-ride.
-		 *
-		 * Since there really isn't a way to advertise that we are
-		 * capable of Rx Pause ONLY, we will advertise that we
-		 * support both symmetric and asymmetric Rx PAUSE.  Later
-		 * (in igc_config_fc_after_link_up) we will disable the
-		 * hw's ability to send PAUSE frames.
-		 */
-		mii_autoneg_adv_reg |= (NWAY_AR_ASM_DIR | NWAY_AR_PAUSE);
-		break;
-	case igc_fc_tx_pause:
-		/* Tx Flow control is enabled, and Rx Flow control is
-		 * disabled, by a software over-ride.
-		 */
-		mii_autoneg_adv_reg |= NWAY_AR_ASM_DIR;
-		mii_autoneg_adv_reg &= ~NWAY_AR_PAUSE;
-		break;
-	case igc_fc_full:
-		/* Flow control (both Rx and Tx) is enabled by a software
-		 * over-ride.
-		 */
-		mii_autoneg_adv_reg |= (NWAY_AR_ASM_DIR | NWAY_AR_PAUSE);
-		break;
-	default:
-		DEBUGOUT("Flow control param set incorrectly\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	ret_val = phy->ops.write_reg(hw, PHY_AUTONEG_ADV, mii_autoneg_adv_reg);
-	if (ret_val)
-		return ret_val;
-
-	DEBUGOUT1("Auto-Neg Advertising %x\n", mii_autoneg_adv_reg);
-
-	if (phy->autoneg_mask & ADVERTISE_1000_FULL)
-		ret_val = phy->ops.write_reg(hw, PHY_1000T_CTRL,
-					     mii_1000t_ctrl_reg);
-
-	if (phy->autoneg_mask & ADVERTISE_2500_FULL)
-		ret_val = phy->ops.write_reg(hw,
-					     (STANDARD_AN_REG_MASK <<
-					     MMD_DEVADDR_SHIFT) |
-					     ANEG_MULTIGBT_AN_CTRL,
-					     aneg_multigbt_an_ctrl);
-
-	return ret_val;
-}
-
-/**
- *  igc_copper_link_autoneg - Setup/Enable autoneg for copper link
- *  @hw: pointer to the HW structure
- *
- *  Performs initial bounds checking on autoneg advertisement parameter, then
- *  configure to advertise the full capability.  Setup the PHY to autoneg
- *  and restart the negotiation process between the link partner.  If
- *  autoneg_wait_to_complete, then wait for autoneg to complete before exiting.
- **/
-s32 igc_copper_link_autoneg(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_ctrl;
-
-	DEBUGFUNC("igc_copper_link_autoneg");
-
-	/* Perform some bounds checking on the autoneg advertisement
-	 * parameter.
-	 */
-	phy->autoneg_advertised &= phy->autoneg_mask;
-
-	/* If autoneg_advertised is zero, we assume it was not defaulted
-	 * by the calling code so we set to advertise full capability.
-	 */
-	if (!phy->autoneg_advertised)
-		phy->autoneg_advertised = phy->autoneg_mask;
-
-	DEBUGOUT("Reconfiguring auto-neg advertisement params\n");
-	ret_val = igc_phy_setup_autoneg(hw);
-	if (ret_val) {
-		DEBUGOUT("Error Setting up Auto-Negotiation\n");
-		return ret_val;
-	}
-	DEBUGOUT("Restarting Auto-Neg\n");
-
-	/* Restart auto-negotiation by setting the Auto Neg Enable bit and
-	 * the Auto Neg Restart bit in the PHY control register.
-	 */
-	ret_val = phy->ops.read_reg(hw, PHY_CONTROL, &phy_ctrl);
-	if (ret_val)
-		return ret_val;
-
-	phy_ctrl |= (MII_CR_AUTO_NEG_EN | MII_CR_RESTART_AUTO_NEG);
-	ret_val = phy->ops.write_reg(hw, PHY_CONTROL, phy_ctrl);
-	if (ret_val)
-		return ret_val;
-
-	/* Does the user want to wait for Auto-Neg to complete here, or
-	 * check at a later time (for example, callback routine).
-	 */
-	if (phy->autoneg_wait_to_complete) {
-		ret_val = igc_wait_autoneg(hw);
-		if (ret_val) {
-			DEBUGOUT("Error while waiting for autoneg to complete\n");
-			return ret_val;
-		}
-	}
-
-	hw->mac.get_link_status = true;
-
-	return ret_val;
-}
-
-/**
- *  igc_setup_copper_link_generic - Configure copper link settings
- *  @hw: pointer to the HW structure
- *
- *  Calls the appropriate function to configure the link for auto-neg or forced
- *  speed and duplex.  Then we check for link, once link is established calls
- *  to configure collision distance and flow control are called.  If link is
- *  not established, we return -IGC_ERR_PHY (-2).
- **/
-s32 igc_setup_copper_link_generic(struct igc_hw *hw)
-{
-	s32 ret_val;
-	bool link = false;
-
-	DEBUGFUNC("igc_setup_copper_link_generic");
-
-	if (hw->mac.autoneg) {
-		/* Setup autoneg and flow control advertisement and perform
-		 * autonegotiation.
-		 */
-		ret_val = igc_copper_link_autoneg(hw);
-		if (ret_val)
-			return ret_val;
-	} else {
-		/* PHY will be set to 10H, 10F, 100H or 100F
-		 * depending on user settings.
-		 */
-		DEBUGOUT("Forcing Speed and Duplex\n");
-		ret_val = hw->phy.ops.force_speed_duplex(hw);
-		if (ret_val) {
-			DEBUGOUT("Error Forcing Speed and Duplex\n");
-			return ret_val;
-		}
-	}
-
-	/* Check link status. Wait up to 100 microseconds for link to become
-	 * valid.
-	 */
-	ret_val = igc_phy_has_link_generic(hw, COPPER_LINK_UP_LIMIT, 10,
-					     &link);
-	if (ret_val)
-		return ret_val;
-
-	if (link) {
-		DEBUGOUT("Valid link established!!!\n");
-		hw->mac.ops.config_collision_dist(hw);
-		ret_val = igc_config_fc_after_link_up_generic(hw);
-	} else {
-		DEBUGOUT("Unable to establish link!!!\n");
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_phy_force_speed_duplex_igp - Force speed/duplex for igp PHY
- *  @hw: pointer to the HW structure
- *
- *  Calls the PHY setup function to force speed and duplex.  Clears the
- *  auto-crossover to force MDI manually.  Waits for link and returns
- *  successful if link up is successful, else -IGC_ERR_PHY (-2).
- **/
-s32 igc_phy_force_speed_duplex_igp(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data;
-	bool link;
-
-	DEBUGFUNC("igc_phy_force_speed_duplex_igp");
-
-	ret_val = phy->ops.read_reg(hw, PHY_CONTROL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	igc_phy_force_speed_duplex_setup(hw, &phy_data);
-
-	ret_val = phy->ops.write_reg(hw, PHY_CONTROL, phy_data);
-	if (ret_val)
-		return ret_val;
-
-	/* Clear Auto-Crossover to force MDI manually.  IGP requires MDI
-	 * forced whenever speed and duplex are forced.
-	 */
-	ret_val = phy->ops.read_reg(hw, IGP01IGC_PHY_PORT_CTRL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	phy_data &= ~IGP01IGC_PSCR_AUTO_MDIX;
-	phy_data &= ~IGP01IGC_PSCR_FORCE_MDI_MDIX;
-
-	ret_val = phy->ops.write_reg(hw, IGP01IGC_PHY_PORT_CTRL, phy_data);
-	if (ret_val)
-		return ret_val;
-
-	DEBUGOUT1("IGP PSCR: %X\n", phy_data);
-
-	usec_delay(1);
-
-	if (phy->autoneg_wait_to_complete) {
-		DEBUGOUT("Waiting for forced speed/duplex link on IGP phy.\n");
-
-		ret_val = igc_phy_has_link_generic(hw, PHY_FORCE_LIMIT,
-						     100000, &link);
-		if (ret_val)
-			return ret_val;
-
-		if (!link)
-			DEBUGOUT("Link taking longer than expected.\n");
-
-		/* Try once more */
-		ret_val = igc_phy_has_link_generic(hw, PHY_FORCE_LIMIT,
-						     100000, &link);
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_phy_force_speed_duplex_m88 - Force speed/duplex for m88 PHY
- *  @hw: pointer to the HW structure
- *
- *  Calls the PHY setup function to force speed and duplex.  Clears the
- *  auto-crossover to force MDI manually.  Resets the PHY to commit the
- *  changes.  If time expires while waiting for link up, we reset the DSP.
- *  After reset, TX_CLK and CRS on Tx must be set.  Return successful upon
- *  successful completion, else return corresponding error code.
- **/
-s32 igc_phy_force_speed_duplex_m88(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data;
-	bool link;
-
-	DEBUGFUNC("igc_phy_force_speed_duplex_m88");
-
-	/* I210 and I211 devices support Auto-Crossover in forced operation. */
-	if (phy->type != igc_phy_i210) {
-		/* Clear Auto-Crossover to force MDI manually.  M88E1000
-		 * requires MDI forced whenever speed and duplex are forced.
-		 */
-		ret_val = phy->ops.read_reg(hw, M88IGC_PHY_SPEC_CTRL,
-					    &phy_data);
-		if (ret_val)
-			return ret_val;
-
-		phy_data &= ~M88IGC_PSCR_AUTO_X_MODE;
-		ret_val = phy->ops.write_reg(hw, M88IGC_PHY_SPEC_CTRL,
-					     phy_data);
-		if (ret_val)
-			return ret_val;
-
-		DEBUGOUT1("M88E1000 PSCR: %X\n", phy_data);
-	}
-
-	ret_val = phy->ops.read_reg(hw, PHY_CONTROL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	igc_phy_force_speed_duplex_setup(hw, &phy_data);
-
-	ret_val = phy->ops.write_reg(hw, PHY_CONTROL, phy_data);
-	if (ret_val)
-		return ret_val;
-
-	/* Reset the phy to commit changes. */
-	ret_val = hw->phy.ops.commit(hw);
-	if (ret_val)
-		return ret_val;
-
-	if (phy->autoneg_wait_to_complete) {
-		DEBUGOUT("Waiting for forced speed/duplex link on M88 phy.\n");
-
-		ret_val = igc_phy_has_link_generic(hw, PHY_FORCE_LIMIT,
-						     100000, &link);
-		if (ret_val)
-			return ret_val;
-
-		if (!link) {
-			bool reset_dsp = true;
-
-			switch (hw->phy.id) {
-			case I347AT4_E_PHY_ID:
-			case M88E1340M_E_PHY_ID:
-			case M88E1112_E_PHY_ID:
-			case M88E1543_E_PHY_ID:
-			case M88E1512_E_PHY_ID:
-			case I210_I_PHY_ID:
-			/* fall-through */
-			case I225_I_PHY_ID:
-			/* fall-through */
-				reset_dsp = false;
-				break;
-			default:
-				if (hw->phy.type != igc_phy_m88)
-					reset_dsp = false;
-				break;
-			}
-
-			if (!reset_dsp) {
-				DEBUGOUT("Link taking longer than expected.\n");
-			} else {
-				/* We didn't get link.
-				 * Reset the DSP and cross our fingers.
-				 */
-				ret_val = phy->ops.write_reg(hw,
-						M88IGC_PHY_PAGE_SELECT,
-						0x001d);
-				if (ret_val)
-					return ret_val;
-				ret_val = igc_phy_reset_dsp_generic(hw);
-				if (ret_val)
-					return ret_val;
-			}
-		}
-
-		/* Try once more */
-		ret_val = igc_phy_has_link_generic(hw, PHY_FORCE_LIMIT,
-						     100000, &link);
-		if (ret_val)
-			return ret_val;
-	}
-
-	if (hw->phy.type != igc_phy_m88)
-		return IGC_SUCCESS;
-
-	if (hw->phy.id == I347AT4_E_PHY_ID ||
-		hw->phy.id == M88E1340M_E_PHY_ID ||
-		hw->phy.id == M88E1112_E_PHY_ID)
-		return IGC_SUCCESS;
-	if (hw->phy.id == I210_I_PHY_ID)
-		return IGC_SUCCESS;
-	if (hw->phy.id == I225_I_PHY_ID)
-		return IGC_SUCCESS;
-	if (hw->phy.id == M88E1543_E_PHY_ID || hw->phy.id == M88E1512_E_PHY_ID)
-		return IGC_SUCCESS;
-	ret_val = phy->ops.read_reg(hw, M88IGC_EXT_PHY_SPEC_CTRL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	/* Resetting the phy means we need to re-force TX_CLK in the
-	 * Extended PHY Specific Control Register to 25MHz clock from
-	 * the reset value of 2.5MHz.
-	 */
-	phy_data |= M88IGC_EPSCR_TX_CLK_25;
-	ret_val = phy->ops.write_reg(hw, M88IGC_EXT_PHY_SPEC_CTRL, phy_data);
-	if (ret_val)
-		return ret_val;
-
-	/* In addition, we must re-enable CRS on Tx for both half and full
-	 * duplex.
-	 */
-	ret_val = phy->ops.read_reg(hw, M88IGC_PHY_SPEC_CTRL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	phy_data |= M88IGC_PSCR_ASSERT_CRS_ON_TX;
-	ret_val = phy->ops.write_reg(hw, M88IGC_PHY_SPEC_CTRL, phy_data);
-
-	return ret_val;
-}
-
-/**
- *  igc_phy_force_speed_duplex_ife - Force PHY speed & duplex
- *  @hw: pointer to the HW structure
- *
- *  Forces the speed and duplex settings of the PHY.
- *  This is a function pointer entry point only called by
- *  PHY setup routines.
- **/
-s32 igc_phy_force_speed_duplex_ife(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 data;
-	bool link;
-
-	DEBUGFUNC("igc_phy_force_speed_duplex_ife");
-
-	ret_val = phy->ops.read_reg(hw, PHY_CONTROL, &data);
-	if (ret_val)
-		return ret_val;
-
-	igc_phy_force_speed_duplex_setup(hw, &data);
-
-	ret_val = phy->ops.write_reg(hw, PHY_CONTROL, data);
-	if (ret_val)
-		return ret_val;
-
-	/* Disable MDI-X support for 10/100 */
-	ret_val = phy->ops.read_reg(hw, IFE_PHY_MDIX_CONTROL, &data);
-	if (ret_val)
-		return ret_val;
-
-	data &= ~IFE_PMC_AUTO_MDIX;
-	data &= ~IFE_PMC_FORCE_MDIX;
-
-	ret_val = phy->ops.write_reg(hw, IFE_PHY_MDIX_CONTROL, data);
-	if (ret_val)
-		return ret_val;
-
-	DEBUGOUT1("IFE PMC: %X\n", data);
-
-	usec_delay(1);
-
-	if (phy->autoneg_wait_to_complete) {
-		DEBUGOUT("Waiting for forced speed/duplex link on IFE phy.\n");
-
-		ret_val = igc_phy_has_link_generic(hw, PHY_FORCE_LIMIT,
-						     100000, &link);
-		if (ret_val)
-			return ret_val;
-
-		if (!link)
-			DEBUGOUT("Link taking longer than expected.\n");
-
-		/* Try once more */
-		ret_val = igc_phy_has_link_generic(hw, PHY_FORCE_LIMIT,
-						     100000, &link);
-		if (ret_val)
-			return ret_val;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_phy_force_speed_duplex_setup - Configure forced PHY speed/duplex
- *  @hw: pointer to the HW structure
- *  @phy_ctrl: pointer to current value of PHY_CONTROL
- *
- *  Forces speed and duplex on the PHY by doing the following: disable flow
- *  control, force speed/duplex on the MAC, disable auto speed detection,
- *  disable auto-negotiation, configure duplex, configure speed, configure
- *  the collision distance, write configuration to CTRL register.  The
- *  caller must write to the PHY_CONTROL register for these settings to
- *  take affect.
- **/
-void igc_phy_force_speed_duplex_setup(struct igc_hw *hw, u16 *phy_ctrl)
-{
-	struct igc_mac_info *mac = &hw->mac;
-	u32 ctrl;
-
-	DEBUGFUNC("igc_phy_force_speed_duplex_setup");
-
-	/* Turn off flow control when forcing speed/duplex */
-	hw->fc.current_mode = igc_fc_none;
-
-	/* Force speed/duplex on the mac */
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-	ctrl |= (IGC_CTRL_FRCSPD | IGC_CTRL_FRCDPX);
-	ctrl &= ~IGC_CTRL_SPD_SEL;
-
-	/* Disable Auto Speed Detection */
-	ctrl &= ~IGC_CTRL_ASDE;
-
-	/* Disable autoneg on the phy */
-	*phy_ctrl &= ~MII_CR_AUTO_NEG_EN;
-
-	/* Forcing Full or Half Duplex? */
-	if (mac->forced_speed_duplex & IGC_ALL_HALF_DUPLEX) {
-		ctrl &= ~IGC_CTRL_FD;
-		*phy_ctrl &= ~MII_CR_FULL_DUPLEX;
-		DEBUGOUT("Half Duplex\n");
-	} else {
-		ctrl |= IGC_CTRL_FD;
-		*phy_ctrl |= MII_CR_FULL_DUPLEX;
-		DEBUGOUT("Full Duplex\n");
-	}
-
-	/* Forcing 10mb or 100mb? */
-	if (mac->forced_speed_duplex & IGC_ALL_100_SPEED) {
-		ctrl |= IGC_CTRL_SPD_100;
-		*phy_ctrl |= MII_CR_SPEED_100;
-		*phy_ctrl &= ~MII_CR_SPEED_1000;
-		DEBUGOUT("Forcing 100mb\n");
-	} else {
-		ctrl &= ~(IGC_CTRL_SPD_1000 | IGC_CTRL_SPD_100);
-		*phy_ctrl &= ~(MII_CR_SPEED_1000 | MII_CR_SPEED_100);
-		DEBUGOUT("Forcing 10mb\n");
-	}
-
-	hw->mac.ops.config_collision_dist(hw);
-
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-}
-
-/**
- *  igc_set_d3_lplu_state_generic - Sets low power link up state for D3
- *  @hw: pointer to the HW structure
- *  @active: boolean used to enable/disable lplu
- *
- *  Success returns 0, Failure returns 1
- *
- *  The low power link up (lplu) state is set to the power management level D3
- *  and SmartSpeed is disabled when active is true, else clear lplu for D3
- *  and enable Smartspeed.  LPLU and Smartspeed are mutually exclusive.  LPLU
- *  is used during Dx states where the power conservation is most important.
- *  During driver activity, SmartSpeed should be enabled so performance is
- *  maintained.
- **/
-s32 igc_set_d3_lplu_state_generic(struct igc_hw *hw, bool active)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 data;
-
-	DEBUGFUNC("igc_set_d3_lplu_state_generic");
-
-	if (!hw->phy.ops.read_reg)
-		return IGC_SUCCESS;
-
-	ret_val = phy->ops.read_reg(hw, IGP02IGC_PHY_POWER_MGMT, &data);
-	if (ret_val)
-		return ret_val;
-
-	if (!active) {
-		data &= ~IGP02IGC_PM_D3_LPLU;
-		ret_val = phy->ops.write_reg(hw, IGP02IGC_PHY_POWER_MGMT,
-					     data);
-		if (ret_val)
-			return ret_val;
-		/* LPLU and SmartSpeed are mutually exclusive.  LPLU is used
-		 * during Dx states where the power conservation is most
-		 * important.  During driver activity we should enable
-		 * SmartSpeed, so performance is maintained.
-		 */
-		if (phy->smart_speed == igc_smart_speed_on) {
-			ret_val = phy->ops.read_reg(hw,
-						    IGP01IGC_PHY_PORT_CONFIG,
-						    &data);
-			if (ret_val)
-				return ret_val;
-
-			data |= IGP01IGC_PSCFR_SMART_SPEED;
-			ret_val = phy->ops.write_reg(hw,
-						     IGP01IGC_PHY_PORT_CONFIG,
-						     data);
-			if (ret_val)
-				return ret_val;
-		} else if (phy->smart_speed == igc_smart_speed_off) {
-			ret_val = phy->ops.read_reg(hw,
-						    IGP01IGC_PHY_PORT_CONFIG,
-						    &data);
-			if (ret_val)
-				return ret_val;
-
-			data &= ~IGP01IGC_PSCFR_SMART_SPEED;
-			ret_val = phy->ops.write_reg(hw,
-						     IGP01IGC_PHY_PORT_CONFIG,
-						     data);
-			if (ret_val)
-				return ret_val;
-		}
-	} else if ((phy->autoneg_advertised == IGC_ALL_SPEED_DUPLEX) ||
-		   (phy->autoneg_advertised == IGC_ALL_NOT_GIG) ||
-		   (phy->autoneg_advertised == IGC_ALL_10_SPEED)) {
-		data |= IGP02IGC_PM_D3_LPLU;
-		ret_val = phy->ops.write_reg(hw, IGP02IGC_PHY_POWER_MGMT,
-					     data);
-		if (ret_val)
-			return ret_val;
-
-		/* When LPLU is enabled, we should disable SmartSpeed */
-		ret_val = phy->ops.read_reg(hw, IGP01IGC_PHY_PORT_CONFIG,
-					    &data);
-		if (ret_val)
-			return ret_val;
-
-		data &= ~IGP01IGC_PSCFR_SMART_SPEED;
-		ret_val = phy->ops.write_reg(hw, IGP01IGC_PHY_PORT_CONFIG,
-					     data);
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_check_downshift_generic - Checks whether a downshift in speed occurred
- *  @hw: pointer to the HW structure
- *
- *  Success returns 0, Failure returns 1
- *
- *  A downshift is detected by querying the PHY link health.
- **/
-s32 igc_check_downshift_generic(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data, offset, mask;
-
-	DEBUGFUNC("igc_check_downshift_generic");
-
-	switch (phy->type) {
-	case igc_phy_i210:
-	case igc_phy_m88:
-	case igc_phy_gg82563:
-	case igc_phy_bm:
-	case igc_phy_82578:
-		offset = M88IGC_PHY_SPEC_STATUS;
-		mask = M88IGC_PSSR_DOWNSHIFT;
-		break;
-	case igc_phy_igp:
-	case igc_phy_igp_2:
-	case igc_phy_igp_3:
-		offset = IGP01IGC_PHY_LINK_HEALTH;
-		mask = IGP01IGC_PLHR_SS_DOWNGRADE;
-		break;
-	default:
-		/* speed downshift not supported */
-		phy->speed_downgraded = false;
-		return IGC_SUCCESS;
-	}
-
-	ret_val = phy->ops.read_reg(hw, offset, &phy_data);
-
-	if (!ret_val)
-		phy->speed_downgraded = !!(phy_data & mask);
-
-	return ret_val;
-}
-
-/**
- *  igc_check_polarity_m88 - Checks the polarity.
- *  @hw: pointer to the HW structure
- *
- *  Success returns 0, Failure returns -IGC_ERR_PHY (-2)
- *
- *  Polarity is determined based on the PHY specific status register.
- **/
-s32 igc_check_polarity_m88(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 data;
-
-	DEBUGFUNC("igc_check_polarity_m88");
-
-	ret_val = phy->ops.read_reg(hw, M88IGC_PHY_SPEC_STATUS, &data);
-
-	if (!ret_val)
-		phy->cable_polarity = ((data & M88IGC_PSSR_REV_POLARITY)
-				       ? igc_rev_polarity_reversed
-				       : igc_rev_polarity_normal);
-
-	return ret_val;
-}
-
-/**
- *  igc_check_polarity_igp - Checks the polarity.
- *  @hw: pointer to the HW structure
- *
- *  Success returns 0, Failure returns -IGC_ERR_PHY (-2)
- *
- *  Polarity is determined based on the PHY port status register, and the
- *  current speed (since there is no polarity at 100Mbps).
- **/
-s32 igc_check_polarity_igp(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 data, offset, mask;
-
-	DEBUGFUNC("igc_check_polarity_igp");
-
-	/* Polarity is determined based on the speed of
-	 * our connection.
-	 */
-	ret_val = phy->ops.read_reg(hw, IGP01IGC_PHY_PORT_STATUS, &data);
-	if (ret_val)
-		return ret_val;
-
-	if ((data & IGP01IGC_PSSR_SPEED_MASK) ==
-	    IGP01IGC_PSSR_SPEED_1000MBPS) {
-		offset = IGP01IGC_PHY_PCS_INIT_REG;
-		mask = IGP01IGC_PHY_POLARITY_MASK;
-	} else {
-		/* This really only applies to 10Mbps since
-		 * there is no polarity for 100Mbps (always 0).
-		 */
-		offset = IGP01IGC_PHY_PORT_STATUS;
-		mask = IGP01IGC_PSSR_POLARITY_REVERSED;
-	}
-
-	ret_val = phy->ops.read_reg(hw, offset, &data);
-
-	if (!ret_val)
-		phy->cable_polarity = ((data & mask)
-				       ? igc_rev_polarity_reversed
-				       : igc_rev_polarity_normal);
-
-	return ret_val;
-}
-
-/**
- *  igc_check_polarity_ife - Check cable polarity for IFE PHY
- *  @hw: pointer to the HW structure
- *
- *  Polarity is determined on the polarity reversal feature being enabled.
- **/
-s32 igc_check_polarity_ife(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data, offset, mask;
-
-	DEBUGFUNC("igc_check_polarity_ife");
-
-	/* Polarity is determined based on the reversal feature being enabled.
-	 */
-	if (phy->polarity_correction) {
-		offset = IFE_PHY_EXTENDED_STATUS_CONTROL;
-		mask = IFE_PESC_POLARITY_REVERSED;
-	} else {
-		offset = IFE_PHY_SPECIAL_CONTROL;
-		mask = IFE_PSC_FORCE_POLARITY;
-	}
-
-	ret_val = phy->ops.read_reg(hw, offset, &phy_data);
-
-	if (!ret_val)
-		phy->cable_polarity = ((phy_data & mask)
-				       ? igc_rev_polarity_reversed
-				       : igc_rev_polarity_normal);
-
-	return ret_val;
-}
-
-/**
- *  igc_wait_autoneg - Wait for auto-neg completion
- *  @hw: pointer to the HW structure
- *
- *  Waits for auto-negotiation to complete or for the auto-negotiation time
- *  limit to expire, which ever happens first.
- **/
-static s32 igc_wait_autoneg(struct igc_hw *hw)
-{
-	s32 ret_val = IGC_SUCCESS;
-	u16 i, phy_status;
-
-	DEBUGFUNC("igc_wait_autoneg");
-
-	if (!hw->phy.ops.read_reg)
-		return IGC_SUCCESS;
-
-	/* Break after autoneg completes or PHY_AUTO_NEG_LIMIT expires. */
-	for (i = PHY_AUTO_NEG_LIMIT; i > 0; i--) {
-		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
-		if (ret_val)
-			break;
-		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
-		if (ret_val)
-			break;
-		if (phy_status & MII_SR_AUTONEG_COMPLETE)
-			break;
-		msec_delay(100);
-	}
-
-	/* PHY_AUTO_NEG_TIME expiration doesn't guarantee auto-negotiation
-	 * has completed.
-	 */
-	return ret_val;
-}
-
-/**
- *  igc_phy_has_link_generic - Polls PHY for link
- *  @hw: pointer to the HW structure
- *  @iterations: number of times to poll for link
- *  @usec_interval: delay between polling attempts
- *  @success: pointer to whether polling was successful or not
- *
- *  Polls the PHY status register for link, 'iterations' number of times.
- **/
-s32 igc_phy_has_link_generic(struct igc_hw *hw, u32 iterations,
-			       u32 usec_interval, bool *success)
-{
-	s32 ret_val = IGC_SUCCESS;
-	u16 i, phy_status;
-
-	DEBUGFUNC("igc_phy_has_link_generic");
-
-	if (!hw->phy.ops.read_reg)
-		return IGC_SUCCESS;
-
-	for (i = 0; i < iterations; i++) {
-		/* Some PHYs require the PHY_STATUS register to be read
-		 * twice due to the link bit being sticky.  No harm doing
-		 * it across the board.
-		 */
-		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
-		if (ret_val) {
-			/* If the first read fails, another entity may have
-			 * ownership of the resources, wait and try again to
-			 * see if they have relinquished the resources yet.
-			 */
-			if (usec_interval >= 1000)
-				msec_delay(usec_interval / 1000);
-			else
-				usec_delay(usec_interval);
-		}
-		ret_val = hw->phy.ops.read_reg(hw, PHY_STATUS, &phy_status);
-		if (ret_val)
-			break;
-		if (phy_status & MII_SR_LINK_STATUS)
-			break;
-		if (usec_interval >= 1000)
-			msec_delay(usec_interval / 1000);
-		else
-			usec_delay(usec_interval);
-	}
-
-	*success = (i < iterations);
-
-	return ret_val;
-}
-
-/**
- *  igc_get_cable_length_m88 - Determine cable length for m88 PHY
- *  @hw: pointer to the HW structure
- *
- *  Reads the PHY specific status register to retrieve the cable length
- *  information.  The cable length is determined by averaging the minimum and
- *  maximum values to get the "average" cable length.  The m88 PHY has four
- *  possible cable length values, which are:
- *	Register Value		Cable Length
- *	0			< 50 meters
- *	1			50 - 80 meters
- *	2			80 - 110 meters
- *	3			110 - 140 meters
- *	4			> 140 meters
- **/
-s32 igc_get_cable_length_m88(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data, index;
-
-	DEBUGFUNC("igc_get_cable_length_m88");
-
-	ret_val = phy->ops.read_reg(hw, M88IGC_PHY_SPEC_STATUS, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	index = ((phy_data & M88IGC_PSSR_CABLE_LENGTH) >>
-		 M88IGC_PSSR_CABLE_LENGTH_SHIFT);
-
-	if (index >= M88IGC_CABLE_LENGTH_TABLE_SIZE - 1)
-		return -IGC_ERR_PHY;
-
-	phy->min_cable_length = igc_m88_cable_length_table[index];
-	phy->max_cable_length = igc_m88_cable_length_table[index + 1];
-
-	phy->cable_length = (phy->min_cable_length + phy->max_cable_length) / 2;
-
-	return IGC_SUCCESS;
-}
-
-s32 igc_get_cable_length_m88_gen2(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val  = 0;
-	u16 phy_data, phy_data2, is_cm;
-	u16 index, default_page;
-
-	DEBUGFUNC("igc_get_cable_length_m88_gen2");
-
-	switch (hw->phy.id) {
-	case I210_I_PHY_ID:
-		/* Get cable length from PHY Cable Diagnostics Control Reg */
-		ret_val = phy->ops.read_reg(hw, (0x7 << GS40G_PAGE_SHIFT) +
-					    (I347AT4_PCDL + phy->addr),
-					    &phy_data);
-		if (ret_val)
-			return ret_val;
-
-		/* Check if the unit of cable length is meters or cm */
-		ret_val = phy->ops.read_reg(hw, (0x7 << GS40G_PAGE_SHIFT) +
-					    I347AT4_PCDC, &phy_data2);
-		if (ret_val)
-			return ret_val;
-
-		is_cm = !(phy_data2 & I347AT4_PCDC_CABLE_LENGTH_UNIT);
-
-		/* Populate the phy structure with cable length in meters */
-		phy->min_cable_length = phy_data / (is_cm ? 100 : 1);
-		phy->max_cable_length = phy_data / (is_cm ? 100 : 1);
-		phy->cable_length = phy_data / (is_cm ? 100 : 1);
-		break;
-	case I225_I_PHY_ID:
-		if (ret_val)
-			return ret_val;
-		/* TODO - complete with Foxville data */
-		break;
-	case M88E1543_E_PHY_ID:
-	case M88E1512_E_PHY_ID:
-	case M88E1340M_E_PHY_ID:
-	case I347AT4_E_PHY_ID:
-		/* Remember the original page select and set it to 7 */
-		ret_val = phy->ops.read_reg(hw, I347AT4_PAGE_SELECT,
-					    &default_page);
-		if (ret_val)
-			return ret_val;
-
-		ret_val = phy->ops.write_reg(hw, I347AT4_PAGE_SELECT, 0x07);
-		if (ret_val)
-			return ret_val;
-
-		/* Get cable length from PHY Cable Diagnostics Control Reg */
-		ret_val = phy->ops.read_reg(hw, (I347AT4_PCDL + phy->addr),
-					    &phy_data);
-		if (ret_val)
-			return ret_val;
-
-		/* Check if the unit of cable length is meters or cm */
-		ret_val = phy->ops.read_reg(hw, I347AT4_PCDC, &phy_data2);
-		if (ret_val)
-			return ret_val;
-
-		is_cm = !(phy_data2 & I347AT4_PCDC_CABLE_LENGTH_UNIT);
-
-		/* Populate the phy structure with cable length in meters */
-		phy->min_cable_length = phy_data / (is_cm ? 100 : 1);
-		phy->max_cable_length = phy_data / (is_cm ? 100 : 1);
-		phy->cable_length = phy_data / (is_cm ? 100 : 1);
-
-		/* Reset the page select to its original value */
-		ret_val = phy->ops.write_reg(hw, I347AT4_PAGE_SELECT,
-					     default_page);
-		if (ret_val)
-			return ret_val;
-		break;
-
-	case M88E1112_E_PHY_ID:
-		/* Remember the original page select and set it to 5 */
-		ret_val = phy->ops.read_reg(hw, I347AT4_PAGE_SELECT,
-					    &default_page);
-		if (ret_val)
-			return ret_val;
-
-		ret_val = phy->ops.write_reg(hw, I347AT4_PAGE_SELECT, 0x05);
-		if (ret_val)
-			return ret_val;
-
-		ret_val = phy->ops.read_reg(hw, M88E1112_VCT_DSP_DISTANCE,
-					    &phy_data);
-		if (ret_val)
-			return ret_val;
-
-		index = (phy_data & M88IGC_PSSR_CABLE_LENGTH) >>
-			M88IGC_PSSR_CABLE_LENGTH_SHIFT;
-
-		if (index >= M88IGC_CABLE_LENGTH_TABLE_SIZE - 1)
-			return -IGC_ERR_PHY;
-
-		phy->min_cable_length = igc_m88_cable_length_table[index];
-		phy->max_cable_length = igc_m88_cable_length_table[index + 1];
-
-		phy->cable_length = (phy->min_cable_length +
-				     phy->max_cable_length) / 2;
-
-		/* Reset the page select to its original value */
-		ret_val = phy->ops.write_reg(hw, I347AT4_PAGE_SELECT,
-					     default_page);
-		if (ret_val)
-			return ret_val;
-
-		break;
-	default:
-		return -IGC_ERR_PHY;
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_get_cable_length_igp_2 - Determine cable length for igp2 PHY
- *  @hw: pointer to the HW structure
- *
- *  The automatic gain control (agc) normalizes the amplitude of the
- *  received signal, adjusting for the attenuation produced by the
- *  cable.  By reading the AGC registers, which represent the
- *  combination of coarse and fine gain value, the value can be put
- *  into a lookup table to obtain the approximate cable length
- *  for each channel.
- **/
-s32 igc_get_cable_length_igp_2(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data, i, agc_value = 0;
-	u16 cur_agc_index, max_agc_index = 0;
-	u16 min_agc_index = IGP02IGC_CABLE_LENGTH_TABLE_SIZE - 1;
-	static const u16 agc_reg_array[IGP02IGC_PHY_CHANNEL_NUM] = {
-		IGP02IGC_PHY_AGC_A,
-		IGP02IGC_PHY_AGC_B,
-		IGP02IGC_PHY_AGC_C,
-		IGP02IGC_PHY_AGC_D
-	};
-
-	DEBUGFUNC("igc_get_cable_length_igp_2");
-
-	/* Read the AGC registers for all channels */
-	for (i = 0; i < IGP02IGC_PHY_CHANNEL_NUM; i++) {
-		ret_val = phy->ops.read_reg(hw, agc_reg_array[i], &phy_data);
-		if (ret_val)
-			return ret_val;
-
-		/* Getting bits 15:9, which represent the combination of
-		 * coarse and fine gain values.  The result is a number
-		 * that can be put into the lookup table to obtain the
-		 * approximate cable length.
-		 */
-		cur_agc_index = ((phy_data >> IGP02IGC_AGC_LENGTH_SHIFT) &
-				 IGP02IGC_AGC_LENGTH_MASK);
-
-		/* Array index bound check. */
-		if (cur_agc_index >= IGP02IGC_CABLE_LENGTH_TABLE_SIZE ||
-				cur_agc_index == 0)
-			return -IGC_ERR_PHY;
-
-		/* Remove min & max AGC values from calculation. */
-		if (igc_igp_2_cable_length_table[min_agc_index] >
-		    igc_igp_2_cable_length_table[cur_agc_index])
-			min_agc_index = cur_agc_index;
-		if (igc_igp_2_cable_length_table[max_agc_index] <
-		    igc_igp_2_cable_length_table[cur_agc_index])
-			max_agc_index = cur_agc_index;
-
-		agc_value += igc_igp_2_cable_length_table[cur_agc_index];
-	}
-
-	agc_value -= (igc_igp_2_cable_length_table[min_agc_index] +
-		      igc_igp_2_cable_length_table[max_agc_index]);
-	agc_value /= (IGP02IGC_PHY_CHANNEL_NUM - 2);
-
-	/* Calculate cable length with the error range of +/- 10 meters. */
-	phy->min_cable_length = (((agc_value - IGP02IGC_AGC_RANGE) > 0) ?
-				 (agc_value - IGP02IGC_AGC_RANGE) : 0);
-	phy->max_cable_length = agc_value + IGP02IGC_AGC_RANGE;
-
-	phy->cable_length = (phy->min_cable_length + phy->max_cable_length) / 2;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_get_phy_info_m88 - Retrieve PHY information
- *  @hw: pointer to the HW structure
- *
- *  Valid for only copper links.  Read the PHY status register (sticky read)
- *  to verify that link is up.  Read the PHY special control register to
- *  determine the polarity and 10base-T extended distance.  Read the PHY
- *  special status register to determine MDI/MDIx and current speed.  If
- *  speed is 1000, then determine cable length, local and remote receiver.
- **/
-s32 igc_get_phy_info_m88(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32  ret_val;
-	u16 phy_data;
-	bool link;
-
-	DEBUGFUNC("igc_get_phy_info_m88");
-
-	if (phy->media_type != igc_media_type_copper) {
-		DEBUGOUT("Phy info is only valid for copper media\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	ret_val = igc_phy_has_link_generic(hw, 1, 0, &link);
-	if (ret_val)
-		return ret_val;
-
-	if (!link) {
-		DEBUGOUT("Phy info is only valid if link is up\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	ret_val = phy->ops.read_reg(hw, M88IGC_PHY_SPEC_CTRL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	phy->polarity_correction = !!(phy_data &
-				      M88IGC_PSCR_POLARITY_REVERSAL);
-
-	ret_val = igc_check_polarity_m88(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = phy->ops.read_reg(hw, M88IGC_PHY_SPEC_STATUS, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	phy->is_mdix = !!(phy_data & M88IGC_PSSR_MDIX);
-
-	if ((phy_data & M88IGC_PSSR_SPEED) == M88IGC_PSSR_1000MBS) {
-		ret_val = hw->phy.ops.get_cable_length(hw);
-		if (ret_val)
-			return ret_val;
-
-		ret_val = phy->ops.read_reg(hw, PHY_1000T_STATUS, &phy_data);
-		if (ret_val)
-			return ret_val;
-
-		phy->local_rx = (phy_data & SR_1000T_LOCAL_RX_STATUS)
-				? igc_1000t_rx_status_ok
-				: igc_1000t_rx_status_not_ok;
-
-		phy->remote_rx = (phy_data & SR_1000T_REMOTE_RX_STATUS)
-				 ? igc_1000t_rx_status_ok
-				 : igc_1000t_rx_status_not_ok;
-	} else {
-		/* Set values to "undefined" */
-		phy->cable_length = IGC_CABLE_LENGTH_UNDEFINED;
-		phy->local_rx = igc_1000t_rx_status_undefined;
-		phy->remote_rx = igc_1000t_rx_status_undefined;
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_get_phy_info_igp - Retrieve igp PHY information
- *  @hw: pointer to the HW structure
- *
- *  Read PHY status to determine if link is up.  If link is up, then
- *  set/determine 10base-T extended distance and polarity correction.  Read
- *  PHY port status to determine MDI/MDIx and speed.  Based on the speed,
- *  determine on the cable length, local and remote receiver.
- **/
-s32 igc_get_phy_info_igp(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 data;
-	bool link;
-
-	DEBUGFUNC("igc_get_phy_info_igp");
-
-	ret_val = igc_phy_has_link_generic(hw, 1, 0, &link);
-	if (ret_val)
-		return ret_val;
-
-	if (!link) {
-		DEBUGOUT("Phy info is only valid if link is up\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	phy->polarity_correction = true;
-
-	ret_val = igc_check_polarity_igp(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = phy->ops.read_reg(hw, IGP01IGC_PHY_PORT_STATUS, &data);
-	if (ret_val)
-		return ret_val;
-
-	phy->is_mdix = !!(data & IGP01IGC_PSSR_MDIX);
-
-	if ((data & IGP01IGC_PSSR_SPEED_MASK) ==
-	    IGP01IGC_PSSR_SPEED_1000MBPS) {
-		ret_val = phy->ops.get_cable_length(hw);
-		if (ret_val)
-			return ret_val;
-
-		ret_val = phy->ops.read_reg(hw, PHY_1000T_STATUS, &data);
-		if (ret_val)
-			return ret_val;
-
-		phy->local_rx = (data & SR_1000T_LOCAL_RX_STATUS)
-				? igc_1000t_rx_status_ok
-				: igc_1000t_rx_status_not_ok;
-
-		phy->remote_rx = (data & SR_1000T_REMOTE_RX_STATUS)
-				 ? igc_1000t_rx_status_ok
-				 : igc_1000t_rx_status_not_ok;
-	} else {
-		phy->cable_length = IGC_CABLE_LENGTH_UNDEFINED;
-		phy->local_rx = igc_1000t_rx_status_undefined;
-		phy->remote_rx = igc_1000t_rx_status_undefined;
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_get_phy_info_ife - Retrieves various IFE PHY states
- *  @hw: pointer to the HW structure
- *
- *  Populates "phy" structure with various feature states.
- **/
-s32 igc_get_phy_info_ife(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 data;
-	bool link;
-
-	DEBUGFUNC("igc_get_phy_info_ife");
-
-	ret_val = igc_phy_has_link_generic(hw, 1, 0, &link);
-	if (ret_val)
-		return ret_val;
-
-	if (!link) {
-		DEBUGOUT("Phy info is only valid if link is up\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	ret_val = phy->ops.read_reg(hw, IFE_PHY_SPECIAL_CONTROL, &data);
-	if (ret_val)
-		return ret_val;
-	phy->polarity_correction = !(data & IFE_PSC_AUTO_POLARITY_DISABLE);
-
-	if (phy->polarity_correction) {
-		ret_val = igc_check_polarity_ife(hw);
-		if (ret_val)
-			return ret_val;
-	} else {
-		/* Polarity is forced */
-		phy->cable_polarity = ((data & IFE_PSC_FORCE_POLARITY)
-				       ? igc_rev_polarity_reversed
-				       : igc_rev_polarity_normal);
-	}
-
-	ret_val = phy->ops.read_reg(hw, IFE_PHY_MDIX_CONTROL, &data);
-	if (ret_val)
-		return ret_val;
-
-	phy->is_mdix = !!(data & IFE_PMC_MDIX_STATUS);
-
-	/* The following parameters are undefined for 10/100 operation. */
-	phy->cable_length = IGC_CABLE_LENGTH_UNDEFINED;
-	phy->local_rx = igc_1000t_rx_status_undefined;
-	phy->remote_rx = igc_1000t_rx_status_undefined;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_phy_sw_reset_generic - PHY software reset
- *  @hw: pointer to the HW structure
- *
- *  Does a software reset of the PHY by reading the PHY control register and
- *  setting/write the control register reset bit to the PHY.
- **/
-s32 igc_phy_sw_reset_generic(struct igc_hw *hw)
-{
-	s32 ret_val;
-	u16 phy_ctrl;
-
-	DEBUGFUNC("igc_phy_sw_reset_generic");
-
-	if (!hw->phy.ops.read_reg)
-		return IGC_SUCCESS;
-
-	ret_val = hw->phy.ops.read_reg(hw, PHY_CONTROL, &phy_ctrl);
-	if (ret_val)
-		return ret_val;
-
-	phy_ctrl |= MII_CR_RESET;
-	ret_val = hw->phy.ops.write_reg(hw, PHY_CONTROL, phy_ctrl);
-	if (ret_val)
-		return ret_val;
-
-	usec_delay(1);
-
-	return ret_val;
-}
-
-/**
- *  igc_phy_hw_reset_generic - PHY hardware reset
- *  @hw: pointer to the HW structure
- *
- *  Verify the reset block is not blocking us from resetting.  Acquire
- *  semaphore (if necessary) and read/set/write the device control reset
- *  bit in the PHY.  Wait the appropriate delay time for the device to
- *  reset and release the semaphore (if necessary).
- **/
-s32 igc_phy_hw_reset_generic(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u32 ctrl;
-
-	DEBUGFUNC("igc_phy_hw_reset_generic");
-
-	if (phy->ops.check_reset_block) {
-		ret_val = phy->ops.check_reset_block(hw);
-		if (ret_val)
-			return IGC_SUCCESS;
-	}
-
-	ret_val = phy->ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	ctrl = IGC_READ_REG(hw, IGC_CTRL);
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl | IGC_CTRL_PHY_RST);
-	IGC_WRITE_FLUSH(hw);
-
-	usec_delay(phy->reset_delay_us);
-
-	IGC_WRITE_REG(hw, IGC_CTRL, ctrl);
-	IGC_WRITE_FLUSH(hw);
-
-	usec_delay(150);
-
-	phy->ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_get_cfg_done_generic - Generic configuration done
- *  @hw: pointer to the HW structure
- *
- *  Generic function to wait 10 milli-seconds for configuration to complete
- *  and return success.
- **/
-s32 igc_get_cfg_done_generic(struct igc_hw IGC_UNUSEDARG * hw)
-{
-	DEBUGFUNC("igc_get_cfg_done_generic");
-	UNREFERENCED_1PARAMETER(hw);
-
-	msec_delay_irq(10);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_phy_init_script_igp3 - Inits the IGP3 PHY
- *  @hw: pointer to the HW structure
- *
- *  Initializes a Intel Gigabit PHY3 when an EEPROM is not present.
- **/
-s32 igc_phy_init_script_igp3(struct igc_hw *hw)
-{
-	DEBUGOUT("Running IGP 3 PHY init script\n");
-
-	/* PHY init IGP 3 */
-	/* Enable rise/fall, 10-mode work in class-A */
-	hw->phy.ops.write_reg(hw, 0x2F5B, 0x9018);
-	/* Remove all caps from Replica path filter */
-	hw->phy.ops.write_reg(hw, 0x2F52, 0x0000);
-	/* Bias trimming for ADC, AFE and Driver (Default) */
-	hw->phy.ops.write_reg(hw, 0x2FB1, 0x8B24);
-	/* Increase Hybrid poly bias */
-	hw->phy.ops.write_reg(hw, 0x2FB2, 0xF8F0);
-	/* Add 4% to Tx amplitude in Gig mode */
-	hw->phy.ops.write_reg(hw, 0x2010, 0x10B0);
-	/* Disable trimming (TTT) */
-	hw->phy.ops.write_reg(hw, 0x2011, 0x0000);
-	/* Poly DC correction to 94.6% + 2% for all channels */
-	hw->phy.ops.write_reg(hw, 0x20DD, 0x249A);
-	/* ABS DC correction to 95.9% */
-	hw->phy.ops.write_reg(hw, 0x20DE, 0x00D3);
-	/* BG temp curve trim */
-	hw->phy.ops.write_reg(hw, 0x28B4, 0x04CE);
-	/* Increasing ADC OPAMP stage 1 currents to max */
-	hw->phy.ops.write_reg(hw, 0x2F70, 0x29E4);
-	/* Force 1000 ( required for enabling PHY regs configuration) */
-	hw->phy.ops.write_reg(hw, 0x0000, 0x0140);
-	/* Set upd_freq to 6 */
-	hw->phy.ops.write_reg(hw, 0x1F30, 0x1606);
-	/* Disable NPDFE */
-	hw->phy.ops.write_reg(hw, 0x1F31, 0xB814);
-	/* Disable adaptive fixed FFE (Default) */
-	hw->phy.ops.write_reg(hw, 0x1F35, 0x002A);
-	/* Enable FFE hysteresis */
-	hw->phy.ops.write_reg(hw, 0x1F3E, 0x0067);
-	/* Fixed FFE for short cable lengths */
-	hw->phy.ops.write_reg(hw, 0x1F54, 0x0065);
-	/* Fixed FFE for medium cable lengths */
-	hw->phy.ops.write_reg(hw, 0x1F55, 0x002A);
-	/* Fixed FFE for long cable lengths */
-	hw->phy.ops.write_reg(hw, 0x1F56, 0x002A);
-	/* Enable Adaptive Clip Threshold */
-	hw->phy.ops.write_reg(hw, 0x1F72, 0x3FB0);
-	/* AHT reset limit to 1 */
-	hw->phy.ops.write_reg(hw, 0x1F76, 0xC0FF);
-	/* Set AHT master delay to 127 msec */
-	hw->phy.ops.write_reg(hw, 0x1F77, 0x1DEC);
-	/* Set scan bits for AHT */
-	hw->phy.ops.write_reg(hw, 0x1F78, 0xF9EF);
-	/* Set AHT Preset bits */
-	hw->phy.ops.write_reg(hw, 0x1F79, 0x0210);
-	/* Change integ_factor of channel A to 3 */
-	hw->phy.ops.write_reg(hw, 0x1895, 0x0003);
-	/* Change prop_factor of channels BCD to 8 */
-	hw->phy.ops.write_reg(hw, 0x1796, 0x0008);
-	/* Change cg_icount + enable integbp for channels BCD */
-	hw->phy.ops.write_reg(hw, 0x1798, 0xD008);
-	/* Change cg_icount + enable integbp + change prop_factor_master
-	 * to 8 for channel A
-	 */
-	hw->phy.ops.write_reg(hw, 0x1898, 0xD918);
-	/* Disable AHT in Slave mode on channel A */
-	hw->phy.ops.write_reg(hw, 0x187A, 0x0800);
-	/* Enable LPLU and disable AN to 1000 in non-D0a states,
-	 * Enable SPD+B2B
-	 */
-	hw->phy.ops.write_reg(hw, 0x0019, 0x008D);
-	/* Enable restart AN on an1000_dis change */
-	hw->phy.ops.write_reg(hw, 0x001B, 0x2080);
-	/* Enable wh_fifo read clock in 10/100 modes */
-	hw->phy.ops.write_reg(hw, 0x0014, 0x0045);
-	/* Restart AN, Speed selection is 1000 */
-	hw->phy.ops.write_reg(hw, 0x0000, 0x1340);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_get_phy_type_from_id - Get PHY type from id
- *  @phy_id: phy_id read from the phy
- *
- *  Returns the phy type from the id.
- **/
-enum igc_phy_type igc_get_phy_type_from_id(u32 phy_id)
-{
-	enum igc_phy_type phy_type = igc_phy_unknown;
-
-	switch (phy_id) {
-	case M88IGC_I_PHY_ID:
-	case M88IGC_E_PHY_ID:
-	case M88E1111_I_PHY_ID:
-	case M88E1011_I_PHY_ID:
-	case M88E1543_E_PHY_ID:
-	case M88E1512_E_PHY_ID:
-	case I347AT4_E_PHY_ID:
-	case M88E1112_E_PHY_ID:
-	case M88E1340M_E_PHY_ID:
-		phy_type = igc_phy_m88;
-		break;
-	case IGP01IGC_I_PHY_ID: /* IGP 1 & 2 share this */
-		phy_type = igc_phy_igp_2;
-		break;
-	case GG82563_E_PHY_ID:
-		phy_type = igc_phy_gg82563;
-		break;
-	case IGP03IGC_E_PHY_ID:
-		phy_type = igc_phy_igp_3;
-		break;
-	case IFE_E_PHY_ID:
-	case IFE_PLUS_E_PHY_ID:
-	case IFE_C_E_PHY_ID:
-		phy_type = igc_phy_ife;
-		break;
-	case BMIGC_E_PHY_ID:
-	case BMIGC_E_PHY_ID_R2:
-		phy_type = igc_phy_bm;
-		break;
-	case I82578_E_PHY_ID:
-		phy_type = igc_phy_82578;
-		break;
-	case I82577_E_PHY_ID:
-		phy_type = igc_phy_82577;
-		break;
-	case I82579_E_PHY_ID:
-		phy_type = igc_phy_82579;
-		break;
-	case I217_E_PHY_ID:
-		phy_type = igc_phy_i217;
-		break;
-	case I82580_I_PHY_ID:
-		phy_type = igc_phy_82580;
-		break;
-	case I210_I_PHY_ID:
-		phy_type = igc_phy_i210;
-		break;
-	case I225_I_PHY_ID:
-		phy_type = igc_phy_i225;
-		break;
-	default:
-		phy_type = igc_phy_unknown;
-		break;
-	}
-	return phy_type;
-}
-
-/**
- *  igc_determine_phy_address - Determines PHY address.
- *  @hw: pointer to the HW structure
- *
- *  This uses a trial and error method to loop through possible PHY
- *  addresses. It tests each by reading the PHY ID registers and
- *  checking for a match.
- **/
-s32 igc_determine_phy_address(struct igc_hw *hw)
-{
-	u32 phy_addr = 0;
-	u32 i;
-	enum igc_phy_type phy_type = igc_phy_unknown;
-
-	hw->phy.id = phy_type;
-
-	for (phy_addr = 0; phy_addr < IGC_MAX_PHY_ADDR; phy_addr++) {
-		hw->phy.addr = phy_addr;
-		i = 0;
-
-		do {
-			igc_get_phy_id(hw);
-			phy_type = igc_get_phy_type_from_id(hw->phy.id);
-
-			/* If phy_type is valid, break - we found our
-			 * PHY address
-			 */
-			if (phy_type != igc_phy_unknown)
-				return IGC_SUCCESS;
-
-			msec_delay(1);
-			i++;
-		} while (i < 10);
-	}
-
-	return -IGC_ERR_PHY_TYPE;
-}
-
-/**
- *  igc_get_phy_addr_for_bm_page - Retrieve PHY page address
- *  @page: page to access
- *  @reg: register to access
- *
- *  Returns the phy address for the page requested.
- **/
-static u32 igc_get_phy_addr_for_bm_page(u32 page, u32 reg)
-{
-	u32 phy_addr = 2;
-
-	if (page >= 768 || (page == 0 && reg == 25) || reg == 31)
-		phy_addr = 1;
-
-	return phy_addr;
-}
-
-/**
- *  igc_write_phy_reg_bm - Write BM PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Acquires semaphore, if necessary, then writes the data to PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-s32 igc_write_phy_reg_bm(struct igc_hw *hw, u32 offset, u16 data)
-{
-	s32 ret_val;
-	u32 page = offset >> IGP_PAGE_SHIFT;
-
-	DEBUGFUNC("igc_write_phy_reg_bm");
-
-	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	/* Page 800 works differently than the rest so it has its own func */
-	if (page == BM_WUC_PAGE) {
-		ret_val = igc_access_phy_wakeup_reg_bm(hw, offset, &data,
-							 false, false);
-		goto release;
-	}
-
-	hw->phy.addr = igc_get_phy_addr_for_bm_page(page, offset);
-
-	if (offset > MAX_PHY_MULTI_PAGE_REG) {
-		u32 page_shift, page_select;
-
-		/* Page select is register 31 for phy address 1 and 22 for
-		 * phy address 2 and 3. Page select is shifted only for
-		 * phy address 1.
-		 */
-		if (hw->phy.addr == 1) {
-			page_shift = IGP_PAGE_SHIFT;
-			page_select = IGP01IGC_PHY_PAGE_SELECT;
-		} else {
-			page_shift = 0;
-			page_select = BM_PHY_PAGE_SELECT;
-		}
-
-		/* Page is shifted left, PHY expects (page x 32) */
-		ret_val = igc_write_phy_reg_mdic(hw, page_select,
-						   (page << page_shift));
-		if (ret_val)
-			goto release;
-	}
-
-	ret_val = igc_write_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & offset,
-					   data);
-
-release:
-	hw->phy.ops.release(hw);
-	return ret_val;
-}
-
-/**
- *  igc_read_phy_reg_bm - Read BM PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Acquires semaphore, if necessary, then reads the PHY register at offset
- *  and storing the retrieved information in data.  Release any acquired
- *  semaphores before exiting.
- **/
-s32 igc_read_phy_reg_bm(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	s32 ret_val;
-	u32 page = offset >> IGP_PAGE_SHIFT;
-
-	DEBUGFUNC("igc_read_phy_reg_bm");
-
-	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	/* Page 800 works differently than the rest so it has its own func */
-	if (page == BM_WUC_PAGE) {
-		ret_val = igc_access_phy_wakeup_reg_bm(hw, offset, data,
-							 true, false);
-		goto release;
-	}
-
-	hw->phy.addr = igc_get_phy_addr_for_bm_page(page, offset);
-
-	if (offset > MAX_PHY_MULTI_PAGE_REG) {
-		u32 page_shift, page_select;
-
-		/* Page select is register 31 for phy address 1 and 22 for
-		 * phy address 2 and 3. Page select is shifted only for
-		 * phy address 1.
-		 */
-		if (hw->phy.addr == 1) {
-			page_shift = IGP_PAGE_SHIFT;
-			page_select = IGP01IGC_PHY_PAGE_SELECT;
-		} else {
-			page_shift = 0;
-			page_select = BM_PHY_PAGE_SELECT;
-		}
-
-		/* Page is shifted left, PHY expects (page x 32) */
-		ret_val = igc_write_phy_reg_mdic(hw, page_select,
-						   (page << page_shift));
-		if (ret_val)
-			goto release;
-	}
-
-	ret_val = igc_read_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & offset,
-					  data);
-release:
-	hw->phy.ops.release(hw);
-	return ret_val;
-}
-
-/**
- *  igc_read_phy_reg_bm2 - Read BM PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Acquires semaphore, if necessary, then reads the PHY register at offset
- *  and storing the retrieved information in data.  Release any acquired
- *  semaphores before exiting.
- **/
-s32 igc_read_phy_reg_bm2(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	s32 ret_val;
-	u16 page = (u16)(offset >> IGP_PAGE_SHIFT);
-
-	DEBUGFUNC("igc_read_phy_reg_bm2");
-
-	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	/* Page 800 works differently than the rest so it has its own func */
-	if (page == BM_WUC_PAGE) {
-		ret_val = igc_access_phy_wakeup_reg_bm(hw, offset, data,
-							 true, false);
-		goto release;
-	}
-
-	hw->phy.addr = 1;
-
-	if (offset > MAX_PHY_MULTI_PAGE_REG) {
-		/* Page is shifted left, PHY expects (page x 32) */
-		ret_val = igc_write_phy_reg_mdic(hw, BM_PHY_PAGE_SELECT,
-						   page);
-
-		if (ret_val)
-			goto release;
-	}
-
-	ret_val = igc_read_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & offset,
-					  data);
-release:
-	hw->phy.ops.release(hw);
-	return ret_val;
-}
-
-/**
- *  igc_write_phy_reg_bm2 - Write BM PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Acquires semaphore, if necessary, then writes the data to PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-s32 igc_write_phy_reg_bm2(struct igc_hw *hw, u32 offset, u16 data)
-{
-	s32 ret_val;
-	u16 page = (u16)(offset >> IGP_PAGE_SHIFT);
-
-	DEBUGFUNC("igc_write_phy_reg_bm2");
-
-	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	/* Page 800 works differently than the rest so it has its own func */
-	if (page == BM_WUC_PAGE) {
-		ret_val = igc_access_phy_wakeup_reg_bm(hw, offset, &data,
-							 false, false);
-		goto release;
-	}
-
-	hw->phy.addr = 1;
-
-	if (offset > MAX_PHY_MULTI_PAGE_REG) {
-		/* Page is shifted left, PHY expects (page x 32) */
-		ret_val = igc_write_phy_reg_mdic(hw, BM_PHY_PAGE_SELECT,
-						   page);
-
-		if (ret_val)
-			goto release;
-	}
-
-	ret_val = igc_write_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & offset,
-					   data);
-
-release:
-	hw->phy.ops.release(hw);
-	return ret_val;
-}
-
-/**
- *  igc_enable_phy_wakeup_reg_access_bm - enable access to BM wakeup registers
- *  @hw: pointer to the HW structure
- *  @phy_reg: pointer to store original contents of BM_WUC_ENABLE_REG
- *
- *  Assumes semaphore already acquired and phy_reg points to a valid memory
- *  address to store contents of the BM_WUC_ENABLE_REG register.
- **/
-s32 igc_enable_phy_wakeup_reg_access_bm(struct igc_hw *hw, u16 *phy_reg)
-{
-	s32 ret_val;
-	u16 temp;
-
-	DEBUGFUNC("igc_enable_phy_wakeup_reg_access_bm");
-
-	if (!phy_reg)
-		return -IGC_ERR_PARAM;
-
-	/* All page select, port ctrl and wakeup registers use phy address 1 */
-	hw->phy.addr = 1;
-
-	/* Select Port Control Registers page */
-	ret_val = igc_set_page_igp(hw, (BM_PORT_CTRL_PAGE << IGP_PAGE_SHIFT));
-	if (ret_val) {
-		DEBUGOUT("Could not set Port Control page\n");
-		return ret_val;
-	}
-
-	ret_val = igc_read_phy_reg_mdic(hw, BM_WUC_ENABLE_REG, phy_reg);
-	if (ret_val) {
-		DEBUGOUT2("Could not read PHY register %d.%d\n",
-			  BM_PORT_CTRL_PAGE, BM_WUC_ENABLE_REG);
-		return ret_val;
-	}
-
-	/* Enable both PHY wakeup mode and Wakeup register page writes.
-	 * Prevent a power state change by disabling ME and Host PHY wakeup.
-	 */
-	temp = *phy_reg;
-	temp |= BM_WUC_ENABLE_BIT;
-	temp &= ~(BM_WUC_ME_WU_BIT | BM_WUC_HOST_WU_BIT);
-
-	ret_val = igc_write_phy_reg_mdic(hw, BM_WUC_ENABLE_REG, temp);
-	if (ret_val) {
-		DEBUGOUT2("Could not write PHY register %d.%d\n",
-			  BM_PORT_CTRL_PAGE, BM_WUC_ENABLE_REG);
-		return ret_val;
-	}
-
-	/* Select Host Wakeup Registers page - caller now able to write
-	 * registers on the Wakeup registers page
-	 */
-	return igc_set_page_igp(hw, (BM_WUC_PAGE << IGP_PAGE_SHIFT));
-}
-
-/**
- *  igc_disable_phy_wakeup_reg_access_bm - disable access to BM wakeup regs
- *  @hw: pointer to the HW structure
- *  @phy_reg: pointer to original contents of BM_WUC_ENABLE_REG
- *
- *  Restore BM_WUC_ENABLE_REG to its original value.
- *
- *  Assumes semaphore already acquired and *phy_reg is the contents of the
- *  BM_WUC_ENABLE_REG before register(s) on BM_WUC_PAGE were accessed by
- *  caller.
- **/
-s32 igc_disable_phy_wakeup_reg_access_bm(struct igc_hw *hw, u16 *phy_reg)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("igc_disable_phy_wakeup_reg_access_bm");
-
-	if (!phy_reg)
-		return -IGC_ERR_PARAM;
-
-	/* Select Port Control Registers page */
-	ret_val = igc_set_page_igp(hw, (BM_PORT_CTRL_PAGE << IGP_PAGE_SHIFT));
-	if (ret_val) {
-		DEBUGOUT("Could not set Port Control page\n");
-		return ret_val;
-	}
-
-	/* Restore 769.17 to its original value */
-	ret_val = igc_write_phy_reg_mdic(hw, BM_WUC_ENABLE_REG, *phy_reg);
-	if (ret_val)
-		DEBUGOUT2("Could not restore PHY register %d.%d\n",
-			  BM_PORT_CTRL_PAGE, BM_WUC_ENABLE_REG);
-
-	return ret_val;
-}
-
-/**
- *  igc_access_phy_wakeup_reg_bm - Read/write BM PHY wakeup register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read or written
- *  @data: pointer to the data to read or write
- *  @read: determines if operation is read or write
- *  @page_set: BM_WUC_PAGE already set and access enabled
- *
- *  Read the PHY register at offset and store the retrieved information in
- *  data, or write data to PHY register at offset.  Note the procedure to
- *  access the PHY wakeup registers is different than reading the other PHY
- *  registers. It works as such:
- *  1) Set 769.17.2 (page 769, register 17, bit 2) = 1
- *  2) Set page to 800 for host (801 if we were manageability)
- *  3) Write the address using the address opcode (0x11)
- *  4) Read or write the data using the data opcode (0x12)
- *  5) Restore 769.17.2 to its original value
- *
- *  Steps 1 and 2 are done by igc_enable_phy_wakeup_reg_access_bm() and
- *  step 5 is done by igc_disable_phy_wakeup_reg_access_bm().
- *
- *  Assumes semaphore is already acquired.  When page_set==true, assumes
- *  the PHY page is set to BM_WUC_PAGE (i.e. a function in the call stack
- *  is responsible for calls to igc_[enable|disable]_phy_wakeup_reg_bm()).
- **/
-static s32 igc_access_phy_wakeup_reg_bm(struct igc_hw *hw, u32 offset,
-					  u16 *data, bool read, bool page_set)
-{
-	s32 ret_val;
-	u16 reg = BM_PHY_REG_NUM(offset);
-	u16 page = BM_PHY_REG_PAGE(offset);
-	u16 phy_reg = 0;
-
-	DEBUGFUNC("igc_access_phy_wakeup_reg_bm");
-
-	/* Gig must be disabled for MDIO accesses to Host Wakeup reg page */
-	if (hw->mac.type == igc_pchlan &&
-		!(IGC_READ_REG(hw, IGC_PHY_CTRL) & IGC_PHY_CTRL_GBE_DISABLE))
-		DEBUGOUT1("Attempting to access page %d while gig enabled.\n",
-			  page);
-
-	if (!page_set) {
-		/* Enable access to PHY wakeup registers */
-		ret_val = igc_enable_phy_wakeup_reg_access_bm(hw, &phy_reg);
-		if (ret_val) {
-			DEBUGOUT("Could not enable PHY wakeup reg access\n");
-			return ret_val;
-		}
-	}
-
-	DEBUGOUT2("Accessing PHY page %d reg 0x%x\n", page, reg);
-
-	/* Write the Wakeup register page offset value using opcode 0x11 */
-	ret_val = igc_write_phy_reg_mdic(hw, BM_WUC_ADDRESS_OPCODE, reg);
-	if (ret_val) {
-		DEBUGOUT1("Could not write address opcode to page %d\n", page);
-		return ret_val;
-	}
-
-	if (read) {
-		/* Read the Wakeup register page value using opcode 0x12 */
-		ret_val = igc_read_phy_reg_mdic(hw, BM_WUC_DATA_OPCODE,
-						  data);
-	} else {
-		/* Write the Wakeup register page value using opcode 0x12 */
-		ret_val = igc_write_phy_reg_mdic(hw, BM_WUC_DATA_OPCODE,
-						   *data);
-	}
-
-	if (ret_val) {
-		DEBUGOUT2("Could not access PHY reg %d.%d\n", page, reg);
-		return ret_val;
-	}
-
-	if (!page_set)
-		ret_val = igc_disable_phy_wakeup_reg_access_bm(hw, &phy_reg);
-
-	return ret_val;
-}
-
-/**
- * igc_power_up_phy_copper - Restore copper link in case of PHY power down
- * @hw: pointer to the HW structure
- *
- * In the case of a PHY power down to save power, or to turn off link during a
- * driver unload, or wake on lan is not enabled, restore the link to previous
- * settings.
- **/
-void igc_power_up_phy_copper(struct igc_hw *hw)
-{
-	u16 mii_reg = 0;
-
-	/* The PHY will retain its settings across a power down/up cycle */
-	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
-	mii_reg &= ~MII_CR_POWER_DOWN;
-	hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
-}
-
-/**
- * igc_power_down_phy_copper - Restore copper link in case of PHY power down
- * @hw: pointer to the HW structure
- *
- * In the case of a PHY power down to save power, or to turn off link during a
- * driver unload, or wake on lan is not enabled, restore the link to previous
- * settings.
- **/
-void igc_power_down_phy_copper(struct igc_hw *hw)
-{
-	u16 mii_reg = 0;
-
-	/* The PHY will retain its settings across a power down/up cycle */
-	hw->phy.ops.read_reg(hw, PHY_CONTROL, &mii_reg);
-	mii_reg |= MII_CR_POWER_DOWN;
-	hw->phy.ops.write_reg(hw, PHY_CONTROL, mii_reg);
-	msec_delay(1);
-}
-
-/**
- *  __igc_read_phy_reg_hv -  Read HV PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *  @locked: semaphore has already been acquired or not
- *  @page_set: BM_WUC_PAGE already set and access enabled
- *
- *  Acquires semaphore, if necessary, then reads the PHY register at offset
- *  and stores the retrieved information in data.  Release any acquired
- *  semaphore before exiting.
- **/
-static s32 __igc_read_phy_reg_hv(struct igc_hw *hw, u32 offset, u16 *data,
-				   bool locked, bool page_set)
-{
-	s32 ret_val;
-	u16 page = BM_PHY_REG_PAGE(offset);
-	u16 reg = BM_PHY_REG_NUM(offset);
-	u32 phy_addr = hw->phy.addr = igc_get_phy_addr_for_hv_page(page);
-
-	DEBUGFUNC("__igc_read_phy_reg_hv");
-
-	if (!locked) {
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
-	}
-	/* Page 800 works differently than the rest so it has its own func */
-	if (page == BM_WUC_PAGE) {
-		ret_val = igc_access_phy_wakeup_reg_bm(hw, offset, data,
-							 true, page_set);
-		goto out;
-	}
-
-	if (page > 0 && page < HV_INTC_FC_PAGE_START) {
-		ret_val = igc_access_phy_debug_regs_hv(hw, offset,
-							 data, true);
-		goto out;
-	}
-
-	if (!page_set) {
-		if (page == HV_INTC_FC_PAGE_START)
-			page = 0;
-
-		if (reg > MAX_PHY_MULTI_PAGE_REG) {
-			/* Page is shifted left, PHY expects (page x 32) */
-			ret_val = igc_set_page_igp(hw,
-						     (page << IGP_PAGE_SHIFT));
-
-			hw->phy.addr = phy_addr;
-
-			if (ret_val)
-				goto out;
-		}
-	}
-
-	DEBUGOUT3("reading PHY page %d (or 0x%x shifted) reg 0x%x\n", page,
-		  page << IGP_PAGE_SHIFT, reg);
-
-	ret_val = igc_read_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & reg,
-					  data);
-out:
-	if (!locked)
-		hw->phy.ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_read_phy_reg_hv -  Read HV PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Acquires semaphore then reads the PHY register at offset and stores
- *  the retrieved information in data.  Release the acquired semaphore
- *  before exiting.
- **/
-s32 igc_read_phy_reg_hv(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	return __igc_read_phy_reg_hv(hw, offset, data, false, false);
-}
-
-/**
- *  igc_read_phy_reg_hv_locked -  Read HV PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to be read
- *  @data: pointer to the read data
- *
- *  Reads the PHY register at offset and stores the retrieved information
- *  in data.  Assumes semaphore already acquired.
- **/
-s32 igc_read_phy_reg_hv_locked(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	return __igc_read_phy_reg_hv(hw, offset, data, true, false);
-}
-
-/**
- *  igc_read_phy_reg_page_hv - Read HV PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Reads the PHY register at offset and stores the retrieved information
- *  in data.  Assumes semaphore already acquired and page already set.
- **/
-s32 igc_read_phy_reg_page_hv(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	return __igc_read_phy_reg_hv(hw, offset, data, true, true);
-}
-
-/**
- *  __igc_write_phy_reg_hv - Write HV PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *  @locked: semaphore has already been acquired or not
- *  @page_set: BM_WUC_PAGE already set and access enabled
- *
- *  Acquires semaphore, if necessary, then writes the data to PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-static s32 __igc_write_phy_reg_hv(struct igc_hw *hw, u32 offset, u16 data,
-				    bool locked, bool page_set)
-{
-	s32 ret_val;
-	u16 page = BM_PHY_REG_PAGE(offset);
-	u16 reg = BM_PHY_REG_NUM(offset);
-	u32 phy_addr = hw->phy.addr = igc_get_phy_addr_for_hv_page(page);
-
-	DEBUGFUNC("__igc_write_phy_reg_hv");
-
-	if (!locked) {
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
-	}
-	/* Page 800 works differently than the rest so it has its own func */
-	if (page == BM_WUC_PAGE) {
-		ret_val = igc_access_phy_wakeup_reg_bm(hw, offset, &data,
-							 false, page_set);
-		goto out;
-	}
-
-	if (page > 0 && page < HV_INTC_FC_PAGE_START) {
-		ret_val = igc_access_phy_debug_regs_hv(hw, offset,
-							 &data, false);
-		goto out;
-	}
-
-	if (!page_set) {
-		if (page == HV_INTC_FC_PAGE_START)
-			page = 0;
-
-		/*
-		 * Workaround MDIO accesses being disabled after entering IEEE
-		 * Power Down (when bit 11 of the PHY Control register is set)
-		 */
-		if (hw->phy.type == igc_phy_82578 &&
-				hw->phy.revision >= 1 &&
-				hw->phy.addr == 2 &&
-				!(MAX_PHY_REG_ADDRESS & reg) &&
-				(data & (1 << 11))) {
-			u16 data2 = 0x7EFF;
-			ret_val = igc_access_phy_debug_regs_hv(hw,
-								(1 << 6) | 0x3,
-								&data2, false);
-			if (ret_val)
-				goto out;
-		}
-
-		if (reg > MAX_PHY_MULTI_PAGE_REG) {
-			/* Page is shifted left, PHY expects (page x 32) */
-			ret_val = igc_set_page_igp(hw,
-						     (page << IGP_PAGE_SHIFT));
-
-			hw->phy.addr = phy_addr;
-
-			if (ret_val)
-				goto out;
-		}
-	}
-
-	DEBUGOUT3("writing PHY page %d (or 0x%x shifted) reg 0x%x\n", page,
-		  page << IGP_PAGE_SHIFT, reg);
-
-	ret_val = igc_write_phy_reg_mdic(hw, MAX_PHY_REG_ADDRESS & reg,
-					   data);
-
-out:
-	if (!locked)
-		hw->phy.ops.release(hw);
-
-	return ret_val;
-}
-
-/**
- *  igc_write_phy_reg_hv - Write HV PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Acquires semaphore then writes the data to PHY register at the offset.
- *  Release the acquired semaphores before exiting.
- **/
-s32 igc_write_phy_reg_hv(struct igc_hw *hw, u32 offset, u16 data)
-{
-	return __igc_write_phy_reg_hv(hw, offset, data, false, false);
-}
-
-/**
- *  igc_write_phy_reg_hv_locked - Write HV PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Writes the data to PHY register at the offset.  Assumes semaphore
- *  already acquired.
- **/
-s32 igc_write_phy_reg_hv_locked(struct igc_hw *hw, u32 offset, u16 data)
-{
-	return __igc_write_phy_reg_hv(hw, offset, data, true, false);
-}
-
-/**
- *  igc_write_phy_reg_page_hv - Write HV PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Writes the data to PHY register at the offset.  Assumes semaphore
- *  already acquired and page already set.
- **/
-s32 igc_write_phy_reg_page_hv(struct igc_hw *hw, u32 offset, u16 data)
-{
-	return __igc_write_phy_reg_hv(hw, offset, data, true, true);
-}
-
-/**
- *  igc_get_phy_addr_for_hv_page - Get PHY address based on page
- *  @page: page to be accessed
- **/
-static u32 igc_get_phy_addr_for_hv_page(u32 page)
-{
-	u32 phy_addr = 2;
-
-	if (page >= HV_INTC_FC_PAGE_START)
-		phy_addr = 1;
-
-	return phy_addr;
-}
-
-/**
- * igc_access_phy_debug_regs_hv - Read HV PHY vendor specific high registers
- * @hw: pointer to the HW structure
- * @offset: register offset to be read or written
- * @data: pointer to the data to be read or written
- * @read: determines if operation is read or write
- *
- * Reads the PHY register at offset and stores the retrieved information
- * in data.  Assumes semaphore already acquired.  Note that the procedure
- * to access these regs uses the address port and data port to read/write.
- * These accesses done with PHY address 2 and without using pages.
- **/
-static s32 igc_access_phy_debug_regs_hv(struct igc_hw *hw, u32 offset,
-					  u16 *data, bool read)
-{
-	s32 ret_val;
-	u32 addr_reg;
-	u32 data_reg;
-
-	DEBUGFUNC("igc_access_phy_debug_regs_hv");
-
-	/* This takes care of the difference with desktop vs mobile phy */
-	addr_reg = ((hw->phy.type == igc_phy_82578) ?
-		    I82578_ADDR_REG : I82577_ADDR_REG);
-	data_reg = addr_reg + 1;
-
-	/* All operations in this function are phy address 2 */
-	hw->phy.addr = 2;
-
-	/* masking with 0x3F to remove the page from offset */
-	ret_val = igc_write_phy_reg_mdic(hw, addr_reg, (u16)offset & 0x3F);
-	if (ret_val) {
-		DEBUGOUT("Could not write the Address Offset port register\n");
-		return ret_val;
-	}
-
-	/* Read or write the data value next */
-	if (read)
-		ret_val = igc_read_phy_reg_mdic(hw, data_reg, data);
-	else
-		ret_val = igc_write_phy_reg_mdic(hw, data_reg, *data);
-
-	if (ret_val)
-		DEBUGOUT("Could not access the Data port register\n");
-
-	return ret_val;
-}
-
-/**
- *  igc_link_stall_workaround_hv - Si workaround
- *  @hw: pointer to the HW structure
- *
- *  This function works around a Si bug where the link partner can get
- *  a link up indication before the PHY does.  If small packets are sent
- *  by the link partner they can be placed in the packet buffer without
- *  being properly accounted for by the PHY and will stall preventing
- *  further packets from being received.  The workaround is to clear the
- *  packet buffer after the PHY detects link up.
- **/
-s32 igc_link_stall_workaround_hv(struct igc_hw *hw)
-{
-	s32 ret_val = IGC_SUCCESS;
-	u16 data;
-
-	DEBUGFUNC("igc_link_stall_workaround_hv");
-
-	if (hw->phy.type != igc_phy_82578)
-		return IGC_SUCCESS;
-
-	/* Do not apply workaround if in PHY loopback bit 14 set */
-	hw->phy.ops.read_reg(hw, PHY_CONTROL, &data);
-	if (data & PHY_CONTROL_LB)
-		return IGC_SUCCESS;
-
-	/* check if link is up and at 1Gbps */
-	ret_val = hw->phy.ops.read_reg(hw, BM_CS_STATUS, &data);
-	if (ret_val)
-		return ret_val;
-
-	data &= (BM_CS_STATUS_LINK_UP | BM_CS_STATUS_RESOLVED |
-		 BM_CS_STATUS_SPEED_MASK);
-
-	if (data != (BM_CS_STATUS_LINK_UP | BM_CS_STATUS_RESOLVED |
-		     BM_CS_STATUS_SPEED_1000))
-		return IGC_SUCCESS;
-
-	msec_delay(200);
-
-	/* flush the packets in the fifo buffer */
-	ret_val = hw->phy.ops.write_reg(hw, HV_MUX_DATA_CTRL,
-					(HV_MUX_DATA_CTRL_GEN_TO_MAC |
-					 HV_MUX_DATA_CTRL_FORCE_SPEED));
-	if (ret_val)
-		return ret_val;
-
-	return hw->phy.ops.write_reg(hw, HV_MUX_DATA_CTRL,
-				     HV_MUX_DATA_CTRL_GEN_TO_MAC);
-}
-
-/**
- *  igc_check_polarity_82577 - Checks the polarity.
- *  @hw: pointer to the HW structure
- *
- *  Success returns 0, Failure returns -IGC_ERR_PHY (-2)
- *
- *  Polarity is determined based on the PHY specific status register.
- **/
-s32 igc_check_polarity_82577(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 data;
-
-	DEBUGFUNC("igc_check_polarity_82577");
-
-	ret_val = phy->ops.read_reg(hw, I82577_PHY_STATUS_2, &data);
-
-	if (!ret_val)
-		phy->cable_polarity = ((data & I82577_PHY_STATUS2_REV_POLARITY)
-				       ? igc_rev_polarity_reversed
-				       : igc_rev_polarity_normal);
-
-	return ret_val;
-}
-
-/**
- *  igc_phy_force_speed_duplex_82577 - Force speed/duplex for I82577 PHY
- *  @hw: pointer to the HW structure
- *
- *  Calls the PHY setup function to force speed and duplex.
- **/
-s32 igc_phy_force_speed_duplex_82577(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data;
-	bool link = false;
-
-	DEBUGFUNC("igc_phy_force_speed_duplex_82577");
-
-	ret_val = phy->ops.read_reg(hw, PHY_CONTROL, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	igc_phy_force_speed_duplex_setup(hw, &phy_data);
-
-	ret_val = phy->ops.write_reg(hw, PHY_CONTROL, phy_data);
-	if (ret_val)
-		return ret_val;
-
-	usec_delay(1);
-
-	if (phy->autoneg_wait_to_complete) {
-		DEBUGOUT("Waiting for forced speed/duplex link on 82577 phy\n");
-
-		ret_val = igc_phy_has_link_generic(hw, PHY_FORCE_LIMIT,
-						     100000, &link);
-		if (ret_val)
-			return ret_val;
-
-		if (!link)
-			DEBUGOUT("Link taking longer than expected.\n");
-
-		/* Try once more */
-		ret_val = igc_phy_has_link_generic(hw, PHY_FORCE_LIMIT,
-						     100000, &link);
-	}
-
-	return ret_val;
-}
-
-/**
- *  igc_get_phy_info_82577 - Retrieve I82577 PHY information
- *  @hw: pointer to the HW structure
- *
- *  Read PHY status to determine if link is up.  If link is up, then
- *  set/determine 10base-T extended distance and polarity correction.  Read
- *  PHY port status to determine MDI/MDIx and speed.  Based on the speed,
- *  determine on the cable length, local and remote receiver.
- **/
-s32 igc_get_phy_info_82577(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 data;
-	bool link;
-
-	DEBUGFUNC("igc_get_phy_info_82577");
-
-	ret_val = igc_phy_has_link_generic(hw, 1, 0, &link);
-	if (ret_val)
-		return ret_val;
-
-	if (!link) {
-		DEBUGOUT("Phy info is only valid if link is up\n");
-		return -IGC_ERR_CONFIG;
-	}
-
-	phy->polarity_correction = true;
-
-	ret_val = igc_check_polarity_82577(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = phy->ops.read_reg(hw, I82577_PHY_STATUS_2, &data);
-	if (ret_val)
-		return ret_val;
-
-	phy->is_mdix = !!(data & I82577_PHY_STATUS2_MDIX);
-
-	if ((data & I82577_PHY_STATUS2_SPEED_MASK) ==
-	    I82577_PHY_STATUS2_SPEED_1000MBPS) {
-		ret_val = hw->phy.ops.get_cable_length(hw);
-		if (ret_val)
-			return ret_val;
-
-		ret_val = phy->ops.read_reg(hw, PHY_1000T_STATUS, &data);
-		if (ret_val)
-			return ret_val;
-
-		phy->local_rx = (data & SR_1000T_LOCAL_RX_STATUS)
-				? igc_1000t_rx_status_ok
-				: igc_1000t_rx_status_not_ok;
-
-		phy->remote_rx = (data & SR_1000T_REMOTE_RX_STATUS)
-				 ? igc_1000t_rx_status_ok
-				 : igc_1000t_rx_status_not_ok;
-	} else {
-		phy->cable_length = IGC_CABLE_LENGTH_UNDEFINED;
-		phy->local_rx = igc_1000t_rx_status_undefined;
-		phy->remote_rx = igc_1000t_rx_status_undefined;
-	}
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_get_cable_length_82577 - Determine cable length for 82577 PHY
- *  @hw: pointer to the HW structure
- *
- * Reads the diagnostic status register and verifies result is valid before
- * placing it in the phy_cable_length field.
- **/
-s32 igc_get_cable_length_82577(struct igc_hw *hw)
-{
-	struct igc_phy_info *phy = &hw->phy;
-	s32 ret_val;
-	u16 phy_data, length;
-
-	DEBUGFUNC("igc_get_cable_length_82577");
-
-	ret_val = phy->ops.read_reg(hw, I82577_PHY_DIAG_STATUS, &phy_data);
-	if (ret_val)
-		return ret_val;
-
-	length = ((phy_data & I82577_DSTATUS_CABLE_LENGTH) >>
-		  I82577_DSTATUS_CABLE_LENGTH_SHIFT);
-
-	if (length == IGC_CABLE_LENGTH_UNDEFINED)
-		return -IGC_ERR_PHY;
-
-	phy->cable_length = length;
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_phy_reg_gs40g - Write GS40G  PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Acquires semaphore, if necessary, then writes the data to PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-s32 igc_write_phy_reg_gs40g(struct igc_hw *hw, u32 offset, u16 data)
-{
-	s32 ret_val;
-	u16 page = offset >> GS40G_PAGE_SHIFT;
-
-	DEBUGFUNC("igc_write_phy_reg_gs40g");
-
-	offset = offset & GS40G_OFFSET_MASK;
-	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = igc_write_phy_reg_mdic(hw, GS40G_PAGE_SELECT, page);
-	if (ret_val)
-		goto release;
-	ret_val = igc_write_phy_reg_mdic(hw, offset, data);
-
-release:
-	hw->phy.ops.release(hw);
-	return ret_val;
-}
-
-/**
- *  igc_read_phy_reg_gs40g - Read GS40G  PHY register
- *  @hw: pointer to the HW structure
- *  @offset: lower half is register offset to read to
- *     upper half is page to use.
- *  @data: data to read at register offset
- *
- *  Acquires semaphore, if necessary, then reads the data in the PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-s32 igc_read_phy_reg_gs40g(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	s32 ret_val;
-	u16 page = offset >> GS40G_PAGE_SHIFT;
-
-	DEBUGFUNC("igc_read_phy_reg_gs40g");
-
-	offset = offset & GS40G_OFFSET_MASK;
-	ret_val = hw->phy.ops.acquire(hw);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = igc_write_phy_reg_mdic(hw, GS40G_PAGE_SELECT, page);
-	if (ret_val)
-		goto release;
-	ret_val = igc_read_phy_reg_mdic(hw, offset, data);
-
-release:
-	hw->phy.ops.release(hw);
-	return ret_val;
-}
-
-/**
- *  igc_write_phy_reg_gpy - Write GPY PHY register
- *  @hw: pointer to the HW structure
- *  @offset: register offset to write to
- *  @data: data to write at register offset
- *
- *  Acquires semaphore, if necessary, then writes the data to PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-s32 igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data)
-{
-	s32 ret_val;
-	u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
-
-	DEBUGFUNC("igc_write_phy_reg_gpy");
-
-	offset = offset & GPY_REG_MASK;
-
-	if (!dev_addr) {
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
-		ret_val = igc_write_phy_reg_mdic(hw, offset, data);
-		if (ret_val)
-			return ret_val;
-		hw->phy.ops.release(hw);
-	} else {
-		ret_val = igc_write_xmdio_reg(hw, (u16)offset, dev_addr,
-						data);
-	}
-	return ret_val;
-}
-
-/**
- *  igc_read_phy_reg_gpy - Read GPY PHY register
- *  @hw: pointer to the HW structure
- *  @offset: lower half is register offset to read to
- *     upper half is MMD to use.
- *  @data: data to read at register offset
- *
- *  Acquires semaphore, if necessary, then reads the data in the PHY register
- *  at the offset.  Release any acquired semaphores before exiting.
- **/
-s32 igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data)
-{
-	s32 ret_val;
-	u8 dev_addr = (offset & GPY_MMD_MASK) >> GPY_MMD_SHIFT;
-
-	DEBUGFUNC("igc_read_phy_reg_gpy");
-
-	offset = offset & GPY_REG_MASK;
-
-	if (!dev_addr) {
-		ret_val = hw->phy.ops.acquire(hw);
-		if (ret_val)
-			return ret_val;
-		ret_val = igc_read_phy_reg_mdic(hw, offset, data);
-		if (ret_val)
-			return ret_val;
-		hw->phy.ops.release(hw);
-	} else {
-		ret_val = igc_read_xmdio_reg(hw, (u16)offset, dev_addr,
-					       data);
-	}
-	return ret_val;
-}
-
-/**
- *  igc_read_phy_reg_mphy - Read mPHY control register
- *  @hw: pointer to the HW structure
- *  @address: address to be read
- *  @data: pointer to the read data
- *
- *  Reads the mPHY control register in the PHY at offset and stores the
- *  information read to data.
- **/
-s32 igc_read_phy_reg_mphy(struct igc_hw *hw, u32 address, u32 *data)
-{
-	u32 mphy_ctrl = 0;
-	bool locked = false;
-	bool ready;
-
-	DEBUGFUNC("igc_read_phy_reg_mphy");
-
-	/* Check if mPHY is ready to read/write operations */
-	ready = igc_is_mphy_ready(hw);
-	if (!ready)
-		return -IGC_ERR_PHY;
-
-	/* Check if mPHY access is disabled and enable it if so */
-	mphy_ctrl = IGC_READ_REG(hw, IGC_MPHY_ADDR_CTRL);
-	if (mphy_ctrl & IGC_MPHY_DIS_ACCESS) {
-		locked = true;
-		ready = igc_is_mphy_ready(hw);
-		if (!ready)
-			return -IGC_ERR_PHY;
-		mphy_ctrl |= IGC_MPHY_ENA_ACCESS;
-		IGC_WRITE_REG(hw, IGC_MPHY_ADDR_CTRL, mphy_ctrl);
-	}
-
-	/* Set the address that we want to read */
-	ready = igc_is_mphy_ready(hw);
-	if (!ready)
-		return -IGC_ERR_PHY;
-
-	/* We mask address, because we want to use only current lane */
-	mphy_ctrl = (mphy_ctrl & ~IGC_MPHY_ADDRESS_MASK &
-		~IGC_MPHY_ADDRESS_FNC_OVERRIDE) |
-		(address & IGC_MPHY_ADDRESS_MASK);
-	IGC_WRITE_REG(hw, IGC_MPHY_ADDR_CTRL, mphy_ctrl);
-
-	/* Read data from the address */
-	ready = igc_is_mphy_ready(hw);
-	if (!ready)
-		return -IGC_ERR_PHY;
-	*data = IGC_READ_REG(hw, IGC_MPHY_DATA);
-
-	/* Disable access to mPHY if it was originally disabled */
-	if (locked)
-		ready = igc_is_mphy_ready(hw);
-	if (!ready)
-		return -IGC_ERR_PHY;
-	IGC_WRITE_REG(hw, IGC_MPHY_ADDR_CTRL,
-			IGC_MPHY_DIS_ACCESS);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_write_phy_reg_mphy - Write mPHY control register
- *  @hw: pointer to the HW structure
- *  @address: address to write to
- *  @data: data to write to register at offset
- *  @line_override: used when we want to use different line than default one
- *
- *  Writes data to mPHY control register.
- **/
-s32 igc_write_phy_reg_mphy(struct igc_hw *hw, u32 address, u32 data,
-			     bool line_override)
-{
-	u32 mphy_ctrl = 0;
-	bool locked = false;
-	bool ready;
-
-	DEBUGFUNC("igc_write_phy_reg_mphy");
-
-	/* Check if mPHY is ready to read/write operations */
-	ready = igc_is_mphy_ready(hw);
-	if (!ready)
-		return -IGC_ERR_PHY;
-
-	/* Check if mPHY access is disabled and enable it if so */
-	mphy_ctrl = IGC_READ_REG(hw, IGC_MPHY_ADDR_CTRL);
-	if (mphy_ctrl & IGC_MPHY_DIS_ACCESS) {
-		locked = true;
-		ready = igc_is_mphy_ready(hw);
-		if (!ready)
-			return -IGC_ERR_PHY;
-		mphy_ctrl |= IGC_MPHY_ENA_ACCESS;
-		IGC_WRITE_REG(hw, IGC_MPHY_ADDR_CTRL, mphy_ctrl);
-	}
-
-	/* Set the address that we want to read */
-	ready = igc_is_mphy_ready(hw);
-	if (!ready)
-		return -IGC_ERR_PHY;
-
-	/* We mask address, because we want to use only current lane */
-	if (line_override)
-		mphy_ctrl |= IGC_MPHY_ADDRESS_FNC_OVERRIDE;
-	else
-		mphy_ctrl &= ~IGC_MPHY_ADDRESS_FNC_OVERRIDE;
-	mphy_ctrl = (mphy_ctrl & ~IGC_MPHY_ADDRESS_MASK) |
-		(address & IGC_MPHY_ADDRESS_MASK);
-	IGC_WRITE_REG(hw, IGC_MPHY_ADDR_CTRL, mphy_ctrl);
-
-	/* Read data from the address */
-	ready = igc_is_mphy_ready(hw);
-	if (!ready)
-		return -IGC_ERR_PHY;
-	IGC_WRITE_REG(hw, IGC_MPHY_DATA, data);
-
-	/* Disable access to mPHY if it was originally disabled */
-	if (locked)
-		ready = igc_is_mphy_ready(hw);
-	if (!ready)
-		return -IGC_ERR_PHY;
-	IGC_WRITE_REG(hw, IGC_MPHY_ADDR_CTRL,
-			IGC_MPHY_DIS_ACCESS);
-
-	return IGC_SUCCESS;
-}
-
-/**
- *  igc_is_mphy_ready - Check if mPHY control register is not busy
- *  @hw: pointer to the HW structure
- *
- *  Returns mPHY control register status.
- **/
-bool igc_is_mphy_ready(struct igc_hw *hw)
-{
-	u16 retry_count = 0;
-	u32 mphy_ctrl = 0;
-	bool ready = false;
-
-	while (retry_count < 2) {
-		mphy_ctrl = IGC_READ_REG(hw, IGC_MPHY_ADDR_CTRL);
-		if (mphy_ctrl & IGC_MPHY_BUSY) {
-			usec_delay(20);
-			retry_count++;
-			continue;
-		}
-		ready = true;
-		break;
-	}
-
-	if (!ready)
-		DEBUGOUT("ERROR READING mPHY control register, phy is busy.\n");
-
-	return ready;
-}
-
-/**
- *  __igc_access_xmdio_reg - Read/write XMDIO register
- *  @hw: pointer to the HW structure
- *  @address: XMDIO address to program
- *  @dev_addr: device address to program
- *  @data: pointer to value to read/write from/to the XMDIO address
- *  @read: boolean flag to indicate read or write
- **/
-static s32 __igc_access_xmdio_reg(struct igc_hw *hw, u16 address,
-				    u8 dev_addr, u16 *data, bool read)
-{
-	s32 ret_val;
-
-	DEBUGFUNC("__igc_access_xmdio_reg");
-
-	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, dev_addr);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAAD, address);
-	if (ret_val)
-		return ret_val;
-
-	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, IGC_MMDAC_FUNC_DATA |
-					dev_addr);
-	if (ret_val)
-		return ret_val;
-
-	if (read)
-		ret_val = hw->phy.ops.read_reg(hw, IGC_MMDAAD, data);
-	else
-		ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAAD, *data);
-	if (ret_val)
-		return ret_val;
-
-	/* Recalibrate the device back to 0 */
-	ret_val = hw->phy.ops.write_reg(hw, IGC_MMDAC, 0);
-	if (ret_val)
-		return ret_val;
-
-	return ret_val;
-}
-
-/**
- *  igc_read_xmdio_reg - Read XMDIO register
- *  @hw: pointer to the HW structure
- *  @addr: XMDIO address to program
- *  @dev_addr: device address to program
- *  @data: value to be read from the EMI address
- **/
-s32 igc_read_xmdio_reg(struct igc_hw *hw, u16 addr, u8 dev_addr, u16 *data)
-{
-	DEBUGFUNC("igc_read_xmdio_reg");
-
-	return __igc_access_xmdio_reg(hw, addr, dev_addr, data, true);
-}
-
-/**
- *  igc_write_xmdio_reg - Write XMDIO register
- *  @hw: pointer to the HW structure
- *  @addr: XMDIO address to program
- *  @dev_addr: device address to program
- *  @data: value to be written to the XMDIO address
- **/
-s32 igc_write_xmdio_reg(struct igc_hw *hw, u16 addr, u8 dev_addr, u16 data)
-{
-	DEBUGFUNC("igc_write_xmdio_reg");
-
-	return __igc_access_xmdio_reg(hw, addr, dev_addr, &data,
-				false);
-}
diff --git a/drivers/net/intel/igc/base/igc_phy.h b/drivers/net/intel/igc/base/igc_phy.h
deleted file mode 100644
index fbc0e7cbc9..0000000000
--- a/drivers/net/intel/igc/base/igc_phy.h
+++ /dev/null
@@ -1,337 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_PHY_H_
-#define _IGC_PHY_H_
-
-void igc_init_phy_ops_generic(struct igc_hw *hw);
-s32  igc_null_read_reg(struct igc_hw *hw, u32 offset, u16 *data);
-void igc_null_phy_generic(struct igc_hw *hw);
-s32  igc_null_lplu_state(struct igc_hw *hw, bool active);
-s32  igc_null_write_reg(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_null_set_page(struct igc_hw *hw, u16 data);
-s32 igc_read_i2c_byte_null(struct igc_hw *hw, u8 byte_offset,
-			     u8 dev_addr, u8 *data);
-s32 igc_write_i2c_byte_null(struct igc_hw *hw, u8 byte_offset,
-			      u8 dev_addr, u8 data);
-s32  igc_check_downshift_generic(struct igc_hw *hw);
-s32  igc_check_polarity_m88(struct igc_hw *hw);
-s32  igc_check_polarity_igp(struct igc_hw *hw);
-s32  igc_check_polarity_ife(struct igc_hw *hw);
-s32  igc_check_reset_block_generic(struct igc_hw *hw);
-s32  igc_phy_setup_autoneg(struct igc_hw *hw);
-s32  igc_copper_link_autoneg(struct igc_hw *hw);
-s32  igc_copper_link_setup_igp(struct igc_hw *hw);
-s32  igc_copper_link_setup_m88(struct igc_hw *hw);
-s32  igc_copper_link_setup_m88_gen2(struct igc_hw *hw);
-s32  igc_phy_force_speed_duplex_igp(struct igc_hw *hw);
-s32  igc_phy_force_speed_duplex_m88(struct igc_hw *hw);
-s32  igc_phy_force_speed_duplex_ife(struct igc_hw *hw);
-s32  igc_get_cable_length_m88(struct igc_hw *hw);
-s32  igc_get_cable_length_m88_gen2(struct igc_hw *hw);
-s32  igc_get_cable_length_igp_2(struct igc_hw *hw);
-s32  igc_get_cfg_done_generic(struct igc_hw *hw);
-s32  igc_get_phy_id(struct igc_hw *hw);
-s32  igc_get_phy_info_igp(struct igc_hw *hw);
-s32  igc_get_phy_info_m88(struct igc_hw *hw);
-s32  igc_get_phy_info_ife(struct igc_hw *hw);
-s32  igc_phy_sw_reset_generic(struct igc_hw *hw);
-void igc_phy_force_speed_duplex_setup(struct igc_hw *hw, u16 *phy_ctrl);
-s32  igc_phy_hw_reset_generic(struct igc_hw *hw);
-s32  igc_phy_reset_dsp_generic(struct igc_hw *hw);
-s32  igc_read_kmrn_reg_generic(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_read_kmrn_reg_locked(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_set_page_igp(struct igc_hw *hw, u16 page);
-s32  igc_read_phy_reg_igp(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_read_phy_reg_igp_locked(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_read_phy_reg_m88(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_set_d3_lplu_state_generic(struct igc_hw *hw, bool active);
-s32  igc_setup_copper_link_generic(struct igc_hw *hw);
-s32  igc_write_kmrn_reg_generic(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_write_kmrn_reg_locked(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_write_phy_reg_igp(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_write_phy_reg_igp_locked(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_write_phy_reg_m88(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_phy_has_link_generic(struct igc_hw *hw, u32 iterations,
-				u32 usec_interval, bool *success);
-s32  igc_phy_init_script_igp3(struct igc_hw *hw);
-enum igc_phy_type igc_get_phy_type_from_id(u32 phy_id);
-s32  igc_determine_phy_address(struct igc_hw *hw);
-s32  igc_write_phy_reg_bm(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_read_phy_reg_bm(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_enable_phy_wakeup_reg_access_bm(struct igc_hw *hw, u16 *phy_reg);
-s32  igc_disable_phy_wakeup_reg_access_bm(struct igc_hw *hw, u16 *phy_reg);
-s32  igc_read_phy_reg_bm2(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_write_phy_reg_bm2(struct igc_hw *hw, u32 offset, u16 data);
-void igc_power_up_phy_copper(struct igc_hw *hw);
-void igc_power_down_phy_copper(struct igc_hw *hw);
-s32  igc_read_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_write_phy_reg_mdic(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_read_phy_reg_i2c(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_write_phy_reg_i2c(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_read_sfp_data_byte(struct igc_hw *hw, u16 offset, u8 *data);
-s32  igc_write_sfp_data_byte(struct igc_hw *hw, u16 offset, u8 data);
-s32  igc_read_phy_reg_hv(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_read_phy_reg_hv_locked(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_read_phy_reg_page_hv(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_write_phy_reg_hv(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_write_phy_reg_hv_locked(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_write_phy_reg_page_hv(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_link_stall_workaround_hv(struct igc_hw *hw);
-s32  igc_copper_link_setup_82577(struct igc_hw *hw);
-s32  igc_check_polarity_82577(struct igc_hw *hw);
-s32  igc_get_phy_info_82577(struct igc_hw *hw);
-s32  igc_phy_force_speed_duplex_82577(struct igc_hw *hw);
-s32  igc_get_cable_length_82577(struct igc_hw *hw);
-s32  igc_write_phy_reg_gs40g(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_read_phy_reg_gs40g(struct igc_hw *hw, u32 offset, u16 *data);
-s32  igc_write_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 data);
-s32  igc_read_phy_reg_gpy(struct igc_hw *hw, u32 offset, u16 *data);
-s32 igc_read_phy_reg_mphy(struct igc_hw *hw, u32 address, u32 *data);
-s32 igc_write_phy_reg_mphy(struct igc_hw *hw, u32 address, u32 data,
-			     bool line_override);
-bool igc_is_mphy_ready(struct igc_hw *hw);
-
-s32 igc_read_xmdio_reg(struct igc_hw *hw, u16 addr, u8 dev_addr,
-			 u16 *data);
-s32 igc_write_xmdio_reg(struct igc_hw *hw, u16 addr, u8 dev_addr,
-			  u16 data);
-
-#define IGC_MAX_PHY_ADDR		8
-
-/* IGP01E1000 Specific Registers */
-#define IGP01IGC_PHY_PORT_CONFIG	0x10 /* Port Config */
-#define IGP01IGC_PHY_PORT_STATUS	0x11 /* Status */
-#define IGP01IGC_PHY_PORT_CTRL	0x12 /* Control */
-#define IGP01IGC_PHY_LINK_HEALTH	0x13 /* PHY Link Health */
-#define IGP01IGC_GMII_FIFO		0x14 /* GMII FIFO */
-#define IGP02IGC_PHY_POWER_MGMT	0x19 /* Power Management */
-#define IGP01IGC_PHY_PAGE_SELECT	0x1F /* Page Select */
-#define BM_PHY_PAGE_SELECT		22   /* Page Select for BM */
-#define IGP_PAGE_SHIFT			5
-#define PHY_REG_MASK			0x1F
-
-/* GS40G - I210 PHY defines */
-#define GS40G_PAGE_SELECT		0x16
-#define GS40G_PAGE_SHIFT		16
-#define GS40G_OFFSET_MASK		0xFFFF
-#define GS40G_PAGE_2			0x20000
-#define GS40G_MAC_REG2			0x15
-#define GS40G_MAC_LB			0x4140
-#define GS40G_MAC_SPEED_1G		0X0006
-#define GS40G_COPPER_SPEC		0x0010
-
-#define IGC_I225_PHPM			0x0E14 /* I225 PHY Power Management */
-#define IGC_I225_PHPM_DIS_1000_D3	0x0008 /* Disable 1G in D3 */
-#define IGC_I225_PHPM_LINK_ENERGY	0x0010 /* Link Energy Detect */
-#define IGC_I225_PHPM_GO_LINKD	0x0020 /* Go Link Disconnect */
-#define IGC_I225_PHPM_DIS_1000	0x0040 /* Disable 1G globally */
-#define IGC_I225_PHPM_SPD_B2B_EN	0x0080 /* Smart Power Down Back2Back */
-#define IGC_I225_PHPM_RST_COMPL	0x0100 /* PHY Reset Completed */
-#define IGC_I225_PHPM_DIS_100_D3	0x0200 /* Disable 100M in D3 */
-#define IGC_I225_PHPM_ULP		0x0400 /* Ultra Low-Power Mode */
-#define IGC_I225_PHPM_DIS_2500	0x0800 /* Disable 2.5G globally */
-#define IGC_I225_PHPM_DIS_2500_D3	0x1000 /* Disable 2.5G in D3 */
-/* GPY211 - I225 defines */
-#define GPY_MMD_MASK			0xFFFF0000
-#define GPY_MMD_SHIFT			16
-#define GPY_REG_MASK			0x0000FFFF
-/* BM/HV Specific Registers */
-#define BM_PORT_CTRL_PAGE		769
-#define BM_WUC_PAGE			800
-#define BM_WUC_ADDRESS_OPCODE		0x11
-#define BM_WUC_DATA_OPCODE		0x12
-#define BM_WUC_ENABLE_PAGE		BM_PORT_CTRL_PAGE
-#define BM_WUC_ENABLE_REG		17
-#define BM_WUC_ENABLE_BIT		(1 << 2)
-#define BM_WUC_HOST_WU_BIT		(1 << 4)
-#define BM_WUC_ME_WU_BIT		(1 << 5)
-
-#define PHY_UPPER_SHIFT			21
-
-#define BM_PHY_REG(page, reg)	(	\
-	__extension__ ({		\
-		typeof(page) _page = (page);	\
-		typeof(reg) _reg = (reg);	\
-		(_reg & MAX_PHY_REG_ADDRESS) |	\
-		((_page & 0xFFFF) << PHY_PAGE_SHIFT) |	\
-		((_reg & ~MAX_PHY_REG_ADDRESS) <<	\
-		(PHY_UPPER_SHIFT - PHY_PAGE_SHIFT));	\
-	}))
-
-#define BM_PHY_REG_PAGE(offset) \
-	((u16)(((offset) >> PHY_PAGE_SHIFT) & 0xFFFF))
-
-#define BM_PHY_REG_NUM(offset)	(	\
-	__extension__ ({		\
-		typeof(offset) _offset = (offset);	\
-		(u16)((_offset & MAX_PHY_REG_ADDRESS) |	\
-		((_offset >> (PHY_UPPER_SHIFT - PHY_PAGE_SHIFT)) &	\
-		~MAX_PHY_REG_ADDRESS));			\
-	}))
-
-#define HV_INTC_FC_PAGE_START		768
-#define I82578_ADDR_REG			29
-#define I82577_ADDR_REG			16
-#define I82577_CFG_REG			22
-#define I82577_CFG_ASSERT_CRS_ON_TX	(1 << 15)
-#define I82577_CFG_ENABLE_DOWNSHIFT	(3 << 10) /* auto downshift */
-#define I82577_CTRL_REG			23
-
-/* 82577 specific PHY registers */
-#define I82577_PHY_CTRL_2		18
-#define I82577_PHY_LBK_CTRL		19
-#define I82577_PHY_STATUS_2		26
-#define I82577_PHY_DIAG_STATUS		31
-
-/* I82577 PHY Status 2 */
-#define I82577_PHY_STATUS2_REV_POLARITY		0x0400
-#define I82577_PHY_STATUS2_MDIX			0x0800
-#define I82577_PHY_STATUS2_SPEED_MASK		0x0300
-#define I82577_PHY_STATUS2_SPEED_1000MBPS	0x0200
-
-/* I82577 PHY Control 2 */
-#define I82577_PHY_CTRL2_MANUAL_MDIX		0x0200
-#define I82577_PHY_CTRL2_AUTO_MDI_MDIX		0x0400
-#define I82577_PHY_CTRL2_MDIX_CFG_MASK		0x0600
-
-/* I82577 PHY Diagnostics Status */
-#define I82577_DSTATUS_CABLE_LENGTH		0x03FC
-#define I82577_DSTATUS_CABLE_LENGTH_SHIFT	2
-
-/* 82580 PHY Power Management */
-#define IGC_82580_PHY_POWER_MGMT	0xE14
-#define IGC_82580_PM_SPD		0x0001 /* Smart Power Down */
-#define IGC_82580_PM_D0_LPLU		0x0002 /* For D0a states */
-#define IGC_82580_PM_D3_LPLU		0x0004 /* For all other states */
-#define IGC_82580_PM_GO_LINKD		0x0020 /* Go Link Disconnect */
-
-#define IGC_MPHY_DIS_ACCESS		0x80000000 /* disable_access bit */
-#define IGC_MPHY_ENA_ACCESS		0x40000000 /* enable_access bit */
-#define IGC_MPHY_BUSY			0x00010000 /* busy bit */
-#define IGC_MPHY_ADDRESS_FNC_OVERRIDE	0x20000000 /* fnc_override bit */
-#define IGC_MPHY_ADDRESS_MASK		0x0000FFFF /* address mask */
-
-/* BM PHY Copper Specific Control 1 */
-#define BM_CS_CTRL1			16
-
-/* BM PHY Copper Specific Status */
-#define BM_CS_STATUS			17
-#define BM_CS_STATUS_LINK_UP		0x0400
-#define BM_CS_STATUS_RESOLVED		0x0800
-#define BM_CS_STATUS_SPEED_MASK		0xC000
-#define BM_CS_STATUS_SPEED_1000		0x8000
-
-/* 82577 Mobile Phy Status Register */
-#define HV_M_STATUS			26
-#define HV_M_STATUS_AUTONEG_COMPLETE	0x1000
-#define HV_M_STATUS_SPEED_MASK		0x0300
-#define HV_M_STATUS_SPEED_1000		0x0200
-#define HV_M_STATUS_SPEED_100		0x0100
-#define HV_M_STATUS_LINK_UP		0x0040
-
-#define IGP01IGC_PHY_PCS_INIT_REG	0x00B4
-#define IGP01IGC_PHY_POLARITY_MASK	0x0078
-
-#define IGP01IGC_PSCR_AUTO_MDIX	0x1000
-#define IGP01IGC_PSCR_FORCE_MDI_MDIX	0x2000 /* 0=MDI, 1=MDIX */
-
-#define IGP01IGC_PSCFR_SMART_SPEED	0x0080
-
-/* Enable flexible speed on link-up */
-#define IGP01IGC_GMII_FLEX_SPD	0x0010
-#define IGP01IGC_GMII_SPD		0x0020 /* Enable SPD */
-
-#define IGP02IGC_PM_SPD		0x0001 /* Smart Power Down */
-#define IGP02IGC_PM_D0_LPLU		0x0002 /* For D0a states */
-#define IGP02IGC_PM_D3_LPLU		0x0004 /* For all other states */
-
-#define IGP01IGC_PLHR_SS_DOWNGRADE	0x8000
-
-#define IGP01IGC_PSSR_POLARITY_REVERSED	0x0002
-#define IGP01IGC_PSSR_MDIX		0x0800
-#define IGP01IGC_PSSR_SPEED_MASK	0xC000
-#define IGP01IGC_PSSR_SPEED_1000MBPS	0xC000
-
-#define IGP02IGC_PHY_CHANNEL_NUM	4
-#define IGP02IGC_PHY_AGC_A		0x11B1
-#define IGP02IGC_PHY_AGC_B		0x12B1
-#define IGP02IGC_PHY_AGC_C		0x14B1
-#define IGP02IGC_PHY_AGC_D		0x18B1
-
-#define IGP02IGC_AGC_LENGTH_SHIFT	9   /* Course=15:13, Fine=12:9 */
-#define IGP02IGC_AGC_LENGTH_MASK	0x7F
-#define IGP02IGC_AGC_RANGE		15
-
-#define IGC_CABLE_LENGTH_UNDEFINED	0xFF
-
-#define IGC_KMRNCTRLSTA_OFFSET	0x001F0000
-#define IGC_KMRNCTRLSTA_OFFSET_SHIFT	16
-#define IGC_KMRNCTRLSTA_REN		0x00200000
-#define IGC_KMRNCTRLSTA_CTRL_OFFSET	0x1    /* Kumeran Control */
-#define IGC_KMRNCTRLSTA_DIAG_OFFSET	0x3    /* Kumeran Diagnostic */
-#define IGC_KMRNCTRLSTA_TIMEOUTS	0x4    /* Kumeran Timeouts */
-#define IGC_KMRNCTRLSTA_INBAND_PARAM	0x9    /* Kumeran InBand Parameters */
-#define IGC_KMRNCTRLSTA_IBIST_DISABLE	0x0200 /* Kumeran IBIST Disable */
-#define IGC_KMRNCTRLSTA_DIAG_NELPBK	0x1000 /* Nearend Loopback mode */
-#define IGC_KMRNCTRLSTA_K1_CONFIG	0x7
-#define IGC_KMRNCTRLSTA_K1_ENABLE	0x0002 /* enable K1 */
-#define IGC_KMRNCTRLSTA_HD_CTRL	0x10   /* Kumeran HD Control */
-#define IGC_KMRNCTRLSTA_K0S_CTRL	0x1E	/* Kumeran K0s Control */
-#define IGC_KMRNCTRLSTA_K0S_CTRL_ENTRY_LTNCY_SHIFT	0
-#define IGC_KMRNCTRLSTA_K0S_CTRL_MIN_TIME_SHIFT	4
-#define IGC_KMRNCTRLSTA_K0S_CTRL_ENTRY_LTNCY_MASK	\
-	(3 << IGC_KMRNCTRLSTA_K0S_CTRL_ENTRY_LTNCY_SHIFT)
-#define IGC_KMRNCTRLSTA_K0S_CTRL_MIN_TIME_MASK \
-	(7 << IGC_KMRNCTRLSTA_K0S_CTRL_MIN_TIME_SHIFT)
-#define IGC_KMRNCTRLSTA_OP_MODES	0x1F   /* Kumeran Modes of Operation */
-#define IGC_KMRNCTRLSTA_OP_MODES_LSC2CSC	0x0002 /* change LSC to CSC */
-
-#define IFE_PHY_EXTENDED_STATUS_CONTROL	0x10
-#define IFE_PHY_SPECIAL_CONTROL		0x11 /* 100BaseTx PHY Special Ctrl */
-#define IFE_PHY_SPECIAL_CONTROL_LED	0x1B /* PHY Special and LED Ctrl */
-#define IFE_PHY_MDIX_CONTROL		0x1C /* MDI/MDI-X Control */
-
-/* IFE PHY Extended Status Control */
-#define IFE_PESC_POLARITY_REVERSED	0x0100
-
-/* IFE PHY Special Control */
-#define IFE_PSC_AUTO_POLARITY_DISABLE	0x0010
-#define IFE_PSC_FORCE_POLARITY		0x0020
-
-/* IFE PHY Special Control and LED Control */
-#define IFE_PSCL_PROBE_MODE		0x0020
-#define IFE_PSCL_PROBE_LEDS_OFF		0x0006 /* Force LEDs 0 and 2 off */
-#define IFE_PSCL_PROBE_LEDS_ON		0x0007 /* Force LEDs 0 and 2 on */
-
-/* IFE PHY MDIX Control */
-#define IFE_PMC_MDIX_STATUS		0x0020 /* 1=MDI-X, 0=MDI */
-#define IFE_PMC_FORCE_MDIX		0x0040 /* 1=force MDI-X, 0=force MDI */
-#define IFE_PMC_AUTO_MDIX		0x0080 /* 1=enable auto, 0=disable */
-
-/* SFP modules ID memory locations */
-#define IGC_SFF_IDENTIFIER_OFFSET	0x00
-#define IGC_SFF_IDENTIFIER_SFF	0x02
-#define IGC_SFF_IDENTIFIER_SFP	0x03
-
-#define IGC_SFF_ETH_FLAGS_OFFSET	0x06
-/* Flags for SFP modules compatible with ETH up to 1Gb */
-struct sfp_igc_flags {
-	u8 igc_base_sx:1;
-	u8 igc_base_lx:1;
-	u8 igc_base_cx:1;
-	u8 igc_base_t:1;
-	u8 e100_base_lx:1;
-	u8 e100_base_fx:1;
-	u8 e10_base_bx10:1;
-	u8 e10_base_px:1;
-};
-
-/* Vendor OUIs: format of OUI is 0x[byte0][byte1][byte2][00] */
-#define IGC_SFF_VENDOR_OUI_TYCO	0x00407600
-#define IGC_SFF_VENDOR_OUI_FTL	0x00906500
-#define IGC_SFF_VENDOR_OUI_AVAGO	0x00176A00
-#define IGC_SFF_VENDOR_OUI_INTEL	0x001B2100
-
-#endif
diff --git a/drivers/net/intel/igc/base/igc_regs.h b/drivers/net/intel/igc/base/igc_regs.h
deleted file mode 100644
index e423814291..0000000000
--- a/drivers/net/intel/igc/base/igc_regs.h
+++ /dev/null
@@ -1,732 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2001-2020 Intel Corporation
- */
-
-#ifndef _IGC_REGS_H_
-#define _IGC_REGS_H_
-
-/* General Register Descriptions */
-#define IGC_CTRL	0x00000  /* Device Control - RW */
-#define IGC_CTRL_DUP	0x00004  /* Device Control Duplicate (Shadow) - RW */
-#define IGC_STATUS	0x00008  /* Device Status - RO */
-#define IGC_EECD	0x00010  /* EEPROM/Flash Control - RW */
-/* NVM  Register Descriptions */
-#define IGC_EERD		0x12014  /* EEprom mode read - RW */
-#define IGC_EEWR		0x12018  /* EEprom mode write - RW */
-#define IGC_CTRL_EXT	0x00018  /* Extended Device Control - RW */
-#define IGC_MDIC	0x00020  /* MDI Control - RW */
-#define IGC_MDICNFG	0x00E04  /* MDI Config - RW */
-#define IGC_REGISTER_SET_SIZE		0x20000 /* CSR Size */
-#define IGC_EEPROM_INIT_CTRL_WORD_2	0x0F /* EEPROM Init Ctrl Word 2 */
-#define IGC_EEPROM_PCIE_CTRL_WORD_2	0x28 /* EEPROM PCIe Ctrl Word 2 */
-#define IGC_BARCTRL			0x5BBC /* BAR ctrl reg */
-#define IGC_BARCTRL_FLSIZE		0x0700 /* BAR ctrl Flsize */
-#define IGC_BARCTRL_CSRSIZE		0x2000 /* BAR ctrl CSR size */
-#define IGC_MPHY_ADDR_CTRL	0x0024 /* GbE MPHY Address Control */
-#define IGC_MPHY_DATA		0x0E10 /* GBE MPHY Data */
-#define IGC_MPHY_STAT		0x0E0C /* GBE MPHY Statistics */
-#define IGC_PPHY_CTRL		0x5b48 /* PCIe PHY Control */
-#define IGC_I350_BARCTRL		0x5BFC /* BAR ctrl reg */
-#define IGC_I350_DTXMXPKTSZ		0x355C /* Maximum sent packet size reg*/
-#define IGC_SCTL	0x00024  /* SerDes Control - RW */
-#define IGC_FCAL	0x00028  /* Flow Control Address Low - RW */
-#define IGC_FCAH	0x0002C  /* Flow Control Address High -RW */
-#define IGC_FEXT	0x0002C  /* Future Extended - RW */
-#define IGC_I225_FLSWCTL	0x12048 /* FLASH control register */
-#define IGC_I225_FLSWDATA	0x1204C /* FLASH data register */
-#define IGC_I225_FLSWCNT	0x12050 /* FLASH Access Counter */
-#define IGC_I225_FLSECU	0x12114 /* FLASH Security */
-#define IGC_FEXTNVM	0x00028  /* Future Extended NVM - RW */
-#define IGC_FEXTNVM3	0x0003C  /* Future Extended NVM 3 - RW */
-#define IGC_FEXTNVM4	0x00024  /* Future Extended NVM 4 - RW */
-#define IGC_FEXTNVM5	0x00014  /* Future Extended NVM 5 - RW */
-#define IGC_FEXTNVM6	0x00010  /* Future Extended NVM 6 - RW */
-#define IGC_FEXTNVM7	0x000E4  /* Future Extended NVM 7 - RW */
-#define IGC_FEXTNVM9	0x5BB4  /* Future Extended NVM 9 - RW */
-#define IGC_FEXTNVM11	0x5BBC  /* Future Extended NVM 11 - RW */
-#define IGC_PCIEANACFG	0x00F18 /* PCIE Analog Config */
-#define IGC_FCT	0x00030  /* Flow Control Type - RW */
-#define IGC_CONNSW	0x00034  /* Copper/Fiber switch control - RW */
-#define IGC_VET	0x00038  /* VLAN Ether Type - RW */
-#define IGC_ICR			0x01500  /* Intr Cause Read - RC/W1C */
-#define IGC_ITR	0x000C4  /* Interrupt Throttling Rate - RW */
-#define IGC_ICS			0x01504  /* Intr Cause Set - WO */
-#define IGC_IMS			0x01508  /* Intr Mask Set/Read - RW */
-#define IGC_IMC			0x0150C  /* Intr Mask Clear - WO */
-#define IGC_IAM			0x01510  /* Intr Ack Auto Mask- RW */
-#define IGC_IVAR	0x000E4  /* Interrupt Vector Allocation Register - RW */
-#define IGC_SVCR	0x000F0
-#define IGC_SVT	0x000F4
-#define IGC_LPIC	0x000FC  /* Low Power IDLE control */
-#define IGC_RCTL	0x00100  /* Rx Control - RW */
-#define IGC_FCTTV	0x00170  /* Flow Control Transmit Timer Value - RW */
-#define IGC_TXCW	0x00178  /* Tx Configuration Word - RW */
-#define IGC_RXCW	0x00180  /* Rx Configuration Word - RO */
-#define IGC_PBA_ECC	0x01100  /* PBA ECC Register */
-#define IGC_EICR	0x01580  /* Ext. Interrupt Cause Read - R/clr */
-#define IGC_EITR(_n)	(0x01680 + (0x4 * (_n)))
-#define IGC_EICS	0x01520  /* Ext. Interrupt Cause Set - W0 */
-#define IGC_EIMS	0x01524  /* Ext. Interrupt Mask Set/Read - RW */
-#define IGC_EIMC	0x01528  /* Ext. Interrupt Mask Clear - WO */
-#define IGC_EIAC	0x0152C  /* Ext. Interrupt Auto Clear - RW */
-#define IGC_EIAM	0x01530  /* Ext. Interrupt Ack Auto Clear Mask - RW */
-#define IGC_GPIE	0x01514  /* General Purpose Interrupt Enable - RW */
-#define IGC_IVAR0	0x01700  /* Interrupt Vector Allocation (array) - RW */
-#define IGC_IVAR_MISC	0x01740 /* IVAR for "other" causes - RW */
-#define IGC_TCTL	0x00400  /* Tx Control - RW */
-#define IGC_TCTL_EXT	0x00404  /* Extended Tx Control - RW */
-#define IGC_TIPG	0x00410  /* Tx Inter-packet gap -RW */
-#define IGC_TBT	0x00448  /* Tx Burst Timer - RW */
-#define IGC_AIT	0x00458  /* Adaptive Interframe Spacing Throttle - RW */
-#define IGC_LEDCTL	0x00E00  /* LED Control - RW */
-#define IGC_LEDMUX	0x08130  /* LED MUX Control */
-#define IGC_EXTCNF_CTRL	0x00F00  /* Extended Configuration Control */
-#define IGC_EXTCNF_SIZE	0x00F08  /* Extended Configuration Size */
-#define IGC_PHY_CTRL	0x00F10  /* PHY Control Register in CSR */
-#define IGC_POEMB	IGC_PHY_CTRL /* PHY OEM Bits */
-#define IGC_PBA	0x01000  /* Packet Buffer Allocation - RW */
-#define IGC_PBS	0x01008  /* Packet Buffer Size */
-#define IGC_PBECCSTS	0x0100C  /* Packet Buffer ECC Status - RW */
-#define IGC_IOSFPC	0x00F28  /* TX corrupted data  */
-#define IGC_EEMNGCTL	0x01010  /* MNG EEprom Control */
-#define IGC_EEMNGCTL_I210	0x01010  /* i210 MNG EEprom Mode Control */
-#define IGC_EEMNGCTL_I225	0x01010  /* i225 MNG EEprom Mode Control */
-#define IGC_EEARBC	0x01024  /* EEPROM Auto Read Bus Control */
-#define IGC_EEARBC_I210	0x12024 /* EEPROM Auto Read Bus Control */
-#define IGC_EEARBC_I225	0x12024 /* EEPROM Auto Read Bus Control */
-#define IGC_FLASHT	0x01028  /* FLASH Timer Register */
-#define IGC_FLSWCTL	0x01030  /* FLASH control register */
-#define IGC_FLSWDATA	0x01034  /* FLASH data register */
-#define IGC_FLSWCNT	0x01038  /* FLASH Access Counter */
-#define IGC_FLOP	0x0103C  /* FLASH Opcode Register */
-#define IGC_I2CCMD	0x01028  /* SFPI2C Command Register - RW */
-#define IGC_I2CPARAMS	0x0102C /* SFPI2C Parameters Register - RW */
-#define IGC_I2CBB_EN	0x00000100  /* I2C - Bit Bang Enable */
-#define IGC_I2C_CLK_OUT	0x00000200  /* I2C- Clock */
-#define IGC_I2C_DATA_OUT	0x00000400  /* I2C- Data Out */
-#define IGC_I2C_DATA_OE_N	0x00000800  /* I2C- Data Output Enable */
-#define IGC_I2C_DATA_IN	0x00001000  /* I2C- Data In */
-#define IGC_I2C_CLK_OE_N	0x00002000  /* I2C- Clock Output Enable */
-#define IGC_I2C_CLK_IN	0x00004000  /* I2C- Clock In */
-#define IGC_I2C_CLK_STRETCH_DIS	0x00008000 /* I2C- Dis Clk Stretching */
-#define IGC_WDSTP	0x01040  /* Watchdog Setup - RW */
-#define IGC_SWDSTS	0x01044  /* SW Device Status - RW */
-#define IGC_FRTIMER	0x01048  /* Free Running Timer - RW */
-#define IGC_TCPTIMER	0x0104C  /* TCP Timer - RW */
-#define IGC_VPDDIAG	0x01060  /* VPD Diagnostic - RO */
-#define IGC_ICR_V2	0x01500  /* Intr Cause - new location - RC */
-#define IGC_ICS_V2	0x01504  /* Intr Cause Set - new location - WO */
-#define IGC_IMS_V2	0x01508  /* Intr Mask Set/Read - new location - RW */
-#define IGC_IMC_V2	0x0150C  /* Intr Mask Clear - new location - WO */
-#define IGC_IAM_V2	0x01510  /* Intr Ack Auto Mask - new location - RW */
-#define IGC_ERT	0x02008  /* Early Rx Threshold - RW */
-#define IGC_FCRTL	0x02160  /* Flow Control Receive Threshold Low - RW */
-#define IGC_FCRTH	0x02168  /* Flow Control Receive Threshold High - RW */
-#define IGC_PSRCTL	0x02170  /* Packet Split Receive Control - RW */
-#define IGC_RDFH	0x02410  /* Rx Data FIFO Head - RW */
-#define IGC_RDFT	0x02418  /* Rx Data FIFO Tail - RW */
-#define IGC_RDFHS	0x02420  /* Rx Data FIFO Head Saved - RW */
-#define IGC_RDFTS	0x02428  /* Rx Data FIFO Tail Saved - RW */
-#define IGC_RDFPC	0x02430  /* Rx Data FIFO Packet Count - RW */
-#define IGC_PBRTH	0x02458  /* PB Rx Arbitration Threshold - RW */
-#define IGC_FCRTV	0x02460  /* Flow Control Refresh Timer Value - RW */
-/* Split and Replication Rx Control - RW */
-#define IGC_RDPUMB	0x025CC  /* DMA Rx Descriptor uC Mailbox - RW */
-#define IGC_RDPUAD	0x025D0  /* DMA Rx Descriptor uC Addr Command - RW */
-#define IGC_RDPUWD	0x025D4  /* DMA Rx Descriptor uC Data Write - RW */
-#define IGC_RDPURD	0x025D8  /* DMA Rx Descriptor uC Data Read - RW */
-#define IGC_RDPUCTL	0x025DC  /* DMA Rx Descriptor uC Control - RW */
-#define IGC_PBDIAG	0x02458  /* Packet Buffer Diagnostic - RW */
-#define IGC_RXPBS	0x02404  /* Rx Packet Buffer Size - RW */
-#define IGC_IRPBS	0x02404 /* Same as RXPBS, renamed for newer Si - RW */
-#define IGC_PBRWAC	0x024E8 /* Rx packet buffer wrap around counter - RO */
-#define IGC_RDTR	0x02820  /* Rx Delay Timer - RW */
-#define IGC_RADV	0x0282C  /* Rx Interrupt Absolute Delay Timer - RW */
-#define IGC_EMIADD	0x10     /* Extended Memory Indirect Address */
-#define IGC_EMIDATA	0x11     /* Extended Memory Indirect Data */
-/* Shadow Ram Write Register - RW */
-#define IGC_SRWR		0x12018
-#define IGC_EEC_REG		0x12010
-
-#define IGC_I210_FLMNGCTL	0x12038
-#define IGC_I210_FLMNGDATA	0x1203C
-#define IGC_I210_FLMNGCNT	0x12040
-
-#define IGC_I210_FLSWCTL	0x12048
-#define IGC_I210_FLSWDATA	0x1204C
-#define IGC_I210_FLSWCNT	0x12050
-
-#define IGC_I210_FLA		0x1201C
-
-#define IGC_SHADOWINF		0x12068
-#define IGC_FLFWUPDATE	0x12108
-
-#define IGC_INVM_DATA_REG(_n)	(0x12120 + 4 * (_n))
-#define IGC_INVM_SIZE		64 /* Number of INVM Data Registers */
-
-/* QAV Tx mode control register */
-#define IGC_I210_TQAVCTRL	0x3570
-
-/* QAV Tx mode control register bitfields masks */
-/* QAV enable */
-#define IGC_TQAVCTRL_MODE			(1 << 0)
-/* Fetching arbitration type */
-#define IGC_TQAVCTRL_FETCH_ARB		(1 << 4)
-/* Fetching timer enable */
-#define IGC_TQAVCTRL_FETCH_TIMER_ENABLE	(1 << 5)
-/* Launch arbitration type */
-#define IGC_TQAVCTRL_LAUNCH_ARB		(1 << 8)
-/* Launch timer enable */
-#define IGC_TQAVCTRL_LAUNCH_TIMER_ENABLE	(1 << 9)
-/* SP waits for SR enable */
-#define IGC_TQAVCTRL_SP_WAIT_SR		(1 << 10)
-/* Fetching timer correction */
-#define IGC_TQAVCTRL_FETCH_TIMER_DELTA_OFFSET	16
-#define IGC_TQAVCTRL_FETCH_TIMER_DELTA	\
-			(0xFFFF << IGC_TQAVCTRL_FETCH_TIMER_DELTA_OFFSET)
-
-/* High credit registers where _n can be 0 or 1. */
-#define IGC_I210_TQAVHC(_n)			(0x300C + 0x40 * (_n))
-
-/* Queues fetch arbitration priority control register */
-#define IGC_I210_TQAVARBCTRL			0x3574
-/* Queues priority masks where _n and _p can be 0-3. */
-#define IGC_TQAVARBCTRL_QUEUE_PRI(_n, _p)	((_p) << (2 * (_n)))
-/* QAV Tx mode control registers where _n can be 0 or 1. */
-#define IGC_I210_TQAVCC(_n)			(0x3004 + 0x40 * (_n))
-
-/* QAV Tx mode control register bitfields masks */
-#define IGC_TQAVCC_IDLE_SLOPE		0xFFFF /* Idle slope */
-#define IGC_TQAVCC_KEEP_CREDITS	(1 << 30) /* Keep credits opt enable */
-#define IGC_TQAVCC_QUEUE_MODE		(1 << 31) /* SP vs. SR Tx mode */
-
-/* Good transmitted packets counter registers */
-#define IGC_PQGPTC(_n)		(0x010014 + (0x100 * (_n)))
-
-/* Queues packet buffer size masks where _n can be 0-3 and _s 0-63 [kB] */
-#define IGC_I210_TXPBS_SIZE(_n, _s)	((_s) << (6 * (_n)))
-
-#define IGC_MMDAC			13 /* MMD Access Control */
-#define IGC_MMDAAD			14 /* MMD Access Address/Data */
-
-/* Convenience macros
- *
- * Note: "_n" is the queue number of the register
- *
- * Example usage:
- * IGC_RDBAL_REG(current_rx_queue)
- */
-#define IGC_QUEUE_REG(n, low, high) (	\
-	__extension__ ({			\
-		typeof(n) _n = (n);		\
-		_n < 4 ? ((low) + _n * 0x100) : ((high) + _n * 0x40);	\
-	}))
-
-#define IGC_RDBAL(_n)		IGC_QUEUE_REG(_n, 0x02800, 0x0C000)
-#define IGC_RDBAH(_n)		IGC_QUEUE_REG(_n, 0x02804, 0x0C004)
-#define IGC_RDLEN(_n)		IGC_QUEUE_REG(_n, 0x02808, 0x0C008)
-#define IGC_SRRCTL(_n)		IGC_QUEUE_REG(_n, 0x0280C, 0x0C00C)
-#define IGC_RDH(_n)		IGC_QUEUE_REG(_n, 0x02810, 0x0C010)
-#define IGC_RXCTL(_n)		IGC_QUEUE_REG(_n, 0x02814, 0x0C014)
-#define IGC_DCA_RXCTRL(_n)	IGC_RXCTL(_n)
-#define IGC_RDT(_n)		IGC_QUEUE_REG(_n, 0x02818, 0x0C018)
-#define IGC_RXDCTL(_n)		IGC_QUEUE_REG(_n, 0x02828, 0x0C028)
-#define IGC_RQDPC(_n)		IGC_QUEUE_REG(_n, 0x02830, 0x0C030)
-#define IGC_TDBAL(_n)		IGC_QUEUE_REG(_n, 0x03800, 0x0E000)
-#define IGC_TDBAH(_n)		IGC_QUEUE_REG(_n, 0x03804, 0x0E004)
-#define IGC_TDLEN(_n)		IGC_QUEUE_REG(_n, 0x03808, 0x0E008)
-#define IGC_TDH(_n)		IGC_QUEUE_REG(_n, 0x03810, 0x0E010)
-#define IGC_TXCTL(_n)		IGC_QUEUE_REG(_n, 0x03814, 0x0E014)
-#define IGC_DCA_TXCTRL(_n)	IGC_TXCTL(_n)
-#define IGC_TDT(_n)		IGC_QUEUE_REG(_n, 0x03818, 0x0E018)
-#define IGC_TXDCTL(_n)		IGC_QUEUE_REG(_n, 0x03828, 0x0E028)
-#define IGC_TDWBAL(_n)		IGC_QUEUE_REG(_n, 0x03838, 0x0E038)
-#define IGC_TDWBAH(_n)		IGC_QUEUE_REG(_n, 0x0383C, 0x0E03C)
-#define IGC_TARC(_n)		(0x03840 + (_n) * 0x100)
-#define IGC_RSRPD		0x02C00  /* Rx Small Packet Detect - RW */
-#define IGC_RAID		0x02C08  /* Receive Ack Interrupt Delay - RW */
-#define IGC_TXDMAC		0x03000  /* Tx DMA Control - RW */
-#define IGC_KABGTXD		0x03004  /* AFE Band Gap Transmit Ref Data */
-#define IGC_PSRTYPE(_i)	(0x05480 + ((_i) * 4))
-
-#define IGC_RAL(n)		(	\
-	__extension__ ({		\
-		typeof(n) _n = (n);	\
-		_n < 16 ? (0x05400 + _n * 8) : (0x054E0 + (_n - 16) * 8); \
-	}))
-
-#define IGC_RAH(_n)		(IGC_RAL(_n) + 4)
-
-#define IGC_VLAPQF		0x055B0  /* VLAN Priority Queue Filter VLAPQF */
-
-#define IGC_SHRAL(_i)		(0x05438 + ((_i) * 8))
-#define IGC_SHRAH(_i)		(0x0543C + ((_i) * 8))
-#define IGC_IP4AT_REG(_i)	(0x05840 + ((_i) * 8))
-#define IGC_IP6AT_REG(_i)	(0x05880 + ((_i) * 4))
-#define IGC_WUPM_REG(_i)	(0x05A00 + ((_i) * 4))
-#define IGC_FFMT_REG(_i)	(0x09000 + ((_i) * 8))
-#define IGC_FFVT_REG(_i)	(0x09800 + ((_i) * 8))
-#define IGC_FFLT_REG(_i)	(0x05F00 + ((_i) * 8))
-#define IGC_PBSLAC		0x03100  /* Pkt Buffer Slave Access Control */
-#define IGC_PBSLAD(_n)	(0x03110 + (0x4 * (_n)))  /* Pkt Buffer DWORD */
-#define IGC_TXPBS		0x03404  /* Tx Packet Buffer Size - RW */
-/* Same as TXPBS, renamed for newer Si - RW */
-#define IGC_ITPBS		0x03404
-#define IGC_TDFH		0x03410  /* Tx Data FIFO Head - RW */
-#define IGC_TDFT		0x03418  /* Tx Data FIFO Tail - RW */
-#define IGC_TDFHS		0x03420  /* Tx Data FIFO Head Saved - RW */
-#define IGC_TDFTS		0x03428  /* Tx Data FIFO Tail Saved - RW */
-#define IGC_TDFPC		0x03430  /* Tx Data FIFO Packet Count - RW */
-#define IGC_TDPUMB		0x0357C  /* DMA Tx Desc uC Mail Box - RW */
-#define IGC_TDPUAD		0x03580  /* DMA Tx Desc uC Addr Command - RW */
-#define IGC_TDPUWD		0x03584  /* DMA Tx Desc uC Data Write - RW */
-#define IGC_TDPURD		0x03588  /* DMA Tx Desc uC Data  Read  - RW */
-#define IGC_TDPUCTL		0x0358C  /* DMA Tx Desc uC Control - RW */
-#define IGC_DTXCTL		0x03590  /* DMA Tx Control - RW */
-#define IGC_DTXTCPFLGL	0x0359C /* DMA Tx Control flag low - RW */
-#define IGC_DTXTCPFLGH	0x035A0 /* DMA Tx Control flag high - RW */
-/* DMA Tx Max Total Allow Size Reqs - RW */
-#define IGC_DTXMXSZRQ		0x03540
-#define IGC_TIDV	0x03820  /* Tx Interrupt Delay Value - RW */
-#define IGC_TADV	0x0382C  /* Tx Interrupt Absolute Delay Val - RW */
-#define IGC_TSPMT	0x03830  /* TCP Segmentation PAD & Min Threshold - RW */
-/* Statistics Register Descriptions */
-#define IGC_CRCERRS	0x04000  /* CRC Error Count - R/clr */
-#define IGC_ALGNERRC	0x04004  /* Alignment Error Count - R/clr */
-#define IGC_SYMERRS	0x04008  /* Symbol Error Count - R/clr */
-#define IGC_RXERRC	0x0400C  /* Receive Error Count - R/clr */
-#define IGC_MPC	0x04010  /* Missed Packet Count - R/clr */
-#define IGC_SCC	0x04014  /* Single Collision Count - R/clr */
-#define IGC_ECOL	0x04018  /* Excessive Collision Count - R/clr */
-#define IGC_MCC	0x0401C  /* Multiple Collision Count - R/clr */
-#define IGC_LATECOL	0x04020  /* Late Collision Count - R/clr */
-#define IGC_COLC	0x04028  /* Collision Count - R/clr */
-#define IGC_DC	0x04030  /* Defer Count - R/clr */
-#define IGC_TNCRS	0x04034  /* Tx-No CRS - R/clr */
-#define IGC_SEC	0x04038  /* Sequence Error Count - R/clr */
-#define IGC_CEXTERR	0x0403C  /* Carrier Extension Error Count - R/clr */
-#define IGC_RLEC	0x04040  /* Receive Length Error Count - R/clr */
-#define IGC_XONRXC	0x04048  /* XON Rx Count - R/clr */
-#define IGC_XONTXC	0x0404C  /* XON Tx Count - R/clr */
-#define IGC_XOFFRXC	0x04050  /* XOFF Rx Count - R/clr */
-#define IGC_XOFFTXC	0x04054  /* XOFF Tx Count - R/clr */
-#define IGC_FCRUC	0x04058  /* Flow Control Rx Unsupported Count- R/clr */
-#define IGC_PRC64	0x0405C  /* Packets Rx (64 bytes) - R/clr */
-#define IGC_PRC127	0x04060  /* Packets Rx (65-127 bytes) - R/clr */
-#define IGC_PRC255	0x04064  /* Packets Rx (128-255 bytes) - R/clr */
-#define IGC_PRC511	0x04068  /* Packets Rx (255-511 bytes) - R/clr */
-#define IGC_PRC1023	0x0406C  /* Packets Rx (512-1023 bytes) - R/clr */
-#define IGC_PRC1522	0x04070  /* Packets Rx (1024-1522 bytes) - R/clr */
-#define IGC_GPRC	0x04074  /* Good Packets Rx Count - R/clr */
-#define IGC_BPRC	0x04078  /* Broadcast Packets Rx Count - R/clr */
-#define IGC_MPRC	0x0407C  /* Multicast Packets Rx Count - R/clr */
-#define IGC_GPTC	0x04080  /* Good Packets Tx Count - R/clr */
-#define IGC_GORCL	0x04088  /* Good Octets Rx Count Low - R/clr */
-#define IGC_GORCH	0x0408C  /* Good Octets Rx Count High - R/clr */
-#define IGC_GOTCL	0x04090  /* Good Octets Tx Count Low - R/clr */
-#define IGC_GOTCH	0x04094  /* Good Octets Tx Count High - R/clr */
-#define IGC_RNBC	0x040A0  /* Rx No Buffers Count - R/clr */
-#define IGC_RUC	0x040A4  /* Rx Undersize Count - R/clr */
-#define IGC_RFC	0x040A8  /* Rx Fragment Count - R/clr */
-#define IGC_ROC	0x040AC  /* Rx Oversize Count - R/clr */
-#define IGC_RJC	0x040B0  /* Rx Jabber Count - R/clr */
-#define IGC_MGTPRC	0x040B4  /* Management Packets Rx Count - R/clr */
-#define IGC_MGTPDC	0x040B8  /* Management Packets Dropped Count - R/clr */
-#define IGC_MGTPTC	0x040BC  /* Management Packets Tx Count - R/clr */
-#define IGC_TORL	0x040C0  /* Total Octets Rx Low - R/clr */
-#define IGC_TORH	0x040C4  /* Total Octets Rx High - R/clr */
-#define IGC_TOTL	0x040C8  /* Total Octets Tx Low - R/clr */
-#define IGC_TOTH	0x040CC  /* Total Octets Tx High - R/clr */
-#define IGC_TPR	0x040D0  /* Total Packets Rx - R/clr */
-#define IGC_TPT	0x040D4  /* Total Packets Tx - R/clr */
-#define IGC_PTC64	0x040D8  /* Packets Tx (64 bytes) - R/clr */
-#define IGC_PTC127	0x040DC  /* Packets Tx (65-127 bytes) - R/clr */
-#define IGC_PTC255	0x040E0  /* Packets Tx (128-255 bytes) - R/clr */
-#define IGC_PTC511	0x040E4  /* Packets Tx (256-511 bytes) - R/clr */
-#define IGC_PTC1023	0x040E8  /* Packets Tx (512-1023 bytes) - R/clr */
-#define IGC_PTC1522	0x040EC  /* Packets Tx (1024-1522 Bytes) - R/clr */
-#define IGC_MPTC	0x040F0  /* Multicast Packets Tx Count - R/clr */
-#define IGC_BPTC	0x040F4  /* Broadcast Packets Tx Count - R/clr */
-#define IGC_TSCTC	0x040F8  /* TCP Segmentation Context Tx - R/clr */
-#define IGC_TSCTFC	0x040FC  /* TCP Segmentation Context Tx Fail - R/clr */
-#define IGC_IAC	0x04100  /* Interrupt Assertion Count */
-/* Interrupt Cause */
-#define IGC_ICRXPTC	0x04104  /* Interrupt Cause Rx Pkt Timer Expire Count */
-#define IGC_ICRXATC	0x04108  /* Interrupt Cause Rx Abs Timer Expire Count */
-#define IGC_ICTXPTC	0x0410C  /* Interrupt Cause Tx Pkt Timer Expire Count */
-#define IGC_ICTXATC	0x04110  /* Interrupt Cause Tx Abs Timer Expire Count */
-#define IGC_ICTXQEC	0x04118  /* Interrupt Cause Tx Queue Empty Count */
-#define IGC_ICTXQMTC	0x0411C  /* Interrupt Cause Tx Queue Min Thresh Count */
-#define IGC_ICRXDMTC	0x04120  /* Interrupt Cause Rx Desc Min Thresh Count */
-#define IGC_ICRXOC	0x04124  /* Interrupt Cause Receiver Overrun Count */
-#define IGC_CRC_OFFSET	0x05F50  /* CRC Offset register */
-
-#define IGC_VFGPRC	0x00F10
-#define IGC_VFGORC	0x00F18
-#define IGC_VFMPRC	0x00F3C
-#define IGC_VFGPTC	0x00F14
-#define IGC_VFGOTC	0x00F34
-#define IGC_VFGOTLBC	0x00F50
-#define IGC_VFGPTLBC	0x00F44
-#define IGC_VFGORLBC	0x00F48
-#define IGC_VFGPRLBC	0x00F40
-/* Virtualization statistical counters */
-#define IGC_PFVFGPRC(_n)	(0x010010 + (0x100 * (_n)))
-#define IGC_PFVFGPTC(_n)	(0x010014 + (0x100 * (_n)))
-#define IGC_PFVFGORC(_n)	(0x010018 + (0x100 * (_n)))
-#define IGC_PFVFGOTC(_n)	(0x010034 + (0x100 * (_n)))
-#define IGC_PFVFMPRC(_n)	(0x010038 + (0x100 * (_n)))
-#define IGC_PFVFGPRLBC(_n)	(0x010040 + (0x100 * (_n)))
-#define IGC_PFVFGPTLBC(_n)	(0x010044 + (0x100 * (_n)))
-#define IGC_PFVFGORLBC(_n)	(0x010048 + (0x100 * (_n)))
-#define IGC_PFVFGOTLBC(_n)	(0x010050 + (0x100 * (_n)))
-
-/* LinkSec */
-#define IGC_LSECTXUT		0x04300  /* Tx Untagged Pkt Cnt */
-#define IGC_LSECTXPKTE	0x04304  /* Encrypted Tx Pkts Cnt */
-#define IGC_LSECTXPKTP	0x04308  /* Protected Tx Pkt Cnt */
-#define IGC_LSECTXOCTE	0x0430C  /* Encrypted Tx Octets Cnt */
-#define IGC_LSECTXOCTP	0x04310  /* Protected Tx Octets Cnt */
-#define IGC_LSECRXUT		0x04314  /* Untagged non-Strict Rx Pkt Cnt */
-#define IGC_LSECRXOCTD	0x0431C  /* Rx Octets Decrypted Count */
-#define IGC_LSECRXOCTV	0x04320  /* Rx Octets Validated */
-#define IGC_LSECRXBAD		0x04324  /* Rx Bad Tag */
-#define IGC_LSECRXNOSCI	0x04328  /* Rx Packet No SCI Count */
-#define IGC_LSECRXUNSCI	0x0432C  /* Rx Packet Unknown SCI Count */
-#define IGC_LSECRXUNCH	0x04330  /* Rx Unchecked Packets Count */
-#define IGC_LSECRXDELAY	0x04340  /* Rx Delayed Packet Count */
-#define IGC_LSECRXLATE	0x04350  /* Rx Late Packets Count */
-#define IGC_LSECRXOK(_n)	(0x04360 + (0x04 * (_n))) /* Rx Pkt OK Cnt */
-#define IGC_LSECRXINV(_n)	(0x04380 + (0x04 * (_n))) /* Rx Invalid Cnt */
-#define IGC_LSECRXNV(_n)	(0x043A0 + (0x04 * (_n))) /* Rx Not Valid Cnt */
-#define IGC_LSECRXUNSA	0x043C0  /* Rx Unused SA Count */
-#define IGC_LSECRXNUSA	0x043D0  /* Rx Not Using SA Count */
-#define IGC_LSECTXCAP		0x0B000  /* Tx Capabilities Register - RO */
-#define IGC_LSECRXCAP		0x0B300  /* Rx Capabilities Register - RO */
-#define IGC_LSECTXCTRL	0x0B004  /* Tx Control - RW */
-#define IGC_LSECRXCTRL	0x0B304  /* Rx Control - RW */
-#define IGC_LSECTXSCL		0x0B008  /* Tx SCI Low - RW */
-#define IGC_LSECTXSCH		0x0B00C  /* Tx SCI High - RW */
-#define IGC_LSECTXSA		0x0B010  /* Tx SA0 - RW */
-#define IGC_LSECTXPN0		0x0B018  /* Tx SA PN 0 - RW */
-#define IGC_LSECTXPN1		0x0B01C  /* Tx SA PN 1 - RW */
-#define IGC_LSECRXSCL		0x0B3D0  /* Rx SCI Low - RW */
-#define IGC_LSECRXSCH		0x0B3E0  /* Rx SCI High - RW */
-/* LinkSec Tx 128-bit Key 0 - WO */
-#define IGC_LSECTXKEY0(_n)	(0x0B020 + (0x04 * (_n)))
-/* LinkSec Tx 128-bit Key 1 - WO */
-#define IGC_LSECTXKEY1(_n)	(0x0B030 + (0x04 * (_n)))
-#define IGC_LSECRXSA(_n)	(0x0B310 + (0x04 * (_n))) /* Rx SAs - RW */
-#define IGC_LSECRXPN(_n)	(0x0B330 + (0x04 * (_n))) /* Rx SAs - RW */
-/* LinkSec Rx Keys  - where _n is the SA no. and _m the 4 dwords of the 128 bit
- * key - RW.
- */
-#define IGC_LSECRXKEY(_n, _m)	(0x0B350 + (0x10 * (_n)) + (0x04 * (_m)))
-
-#define IGC_SSVPC		0x041A0 /* Switch Security Violation Pkt Cnt */
-#define IGC_IPSCTRL		0xB430  /* IpSec Control Register */
-#define IGC_IPSRXCMD		0x0B408 /* IPSec Rx Command Register - RW */
-#define IGC_IPSRXIDX		0x0B400 /* IPSec Rx Index - RW */
-/* IPSec Rx IPv4/v6 Address - RW */
-#define IGC_IPSRXIPADDR(_n)	(0x0B420 + (0x04 * (_n)))
-/* IPSec Rx 128-bit Key - RW */
-#define IGC_IPSRXKEY(_n)	(0x0B410 + (0x04 * (_n)))
-#define IGC_IPSRXSALT		0x0B404  /* IPSec Rx Salt - RW */
-#define IGC_IPSRXSPI		0x0B40C  /* IPSec Rx SPI - RW */
-/* IPSec Tx 128-bit Key - RW */
-#define IGC_IPSTXKEY(_n)	(0x0B460 + (0x04 * (_n)))
-#define IGC_IPSTXSALT		0x0B454  /* IPSec Tx Salt - RW */
-#define IGC_IPSTXIDX		0x0B450  /* IPSec Tx SA IDX - RW */
-#define IGC_PCS_CFG0	0x04200  /* PCS Configuration 0 - RW */
-#define IGC_PCS_LCTL	0x04208  /* PCS Link Control - RW */
-#define IGC_PCS_LSTAT	0x0420C  /* PCS Link Status - RO */
-#define IGC_CBTMPC	0x0402C  /* Circuit Breaker Tx Packet Count */
-#define IGC_HTDPMC	0x0403C  /* Host Transmit Discarded Packets */
-#define IGC_CBRDPC	0x04044  /* Circuit Breaker Rx Dropped Count */
-#define IGC_CBRMPC	0x040FC  /* Circuit Breaker Rx Packet Count */
-#define IGC_RPTHC	0x04104  /* Rx Packets To Host */
-#define IGC_HGPTC	0x04118  /* Host Good Packets Tx Count */
-#define IGC_HTCBDPC	0x04124  /* Host Tx Circuit Breaker Dropped Count */
-#define IGC_HGORCL	0x04128  /* Host Good Octets Received Count Low */
-#define IGC_HGORCH	0x0412C  /* Host Good Octets Received Count High */
-#define IGC_HGOTCL	0x04130  /* Host Good Octets Transmit Count Low */
-#define IGC_HGOTCH	0x04134  /* Host Good Octets Transmit Count High */
-#define IGC_LENERRS	0x04138  /* Length Errors Count */
-#define IGC_SCVPC	0x04228  /* SerDes/SGMII Code Violation Pkt Count */
-#define IGC_HRMPC	0x0A018  /* Header Redirection Missed Packet Count */
-#define IGC_PCS_ANADV	0x04218  /* AN advertisement - RW */
-#define IGC_PCS_LPAB	0x0421C  /* Link Partner Ability - RW */
-#define IGC_PCS_NPTX	0x04220  /* AN Next Page Transmit - RW */
-#define IGC_PCS_LPABNP	0x04224 /* Link Partner Ability Next Pg - RW */
-#define IGC_RXCSUM	0x05000  /* Rx Checksum Control - RW */
-#define IGC_RLPML	0x05004  /* Rx Long Packet Max Length */
-#define IGC_RFCTL	0x05008  /* Receive Filter Control*/
-#define IGC_MTA	0x05200  /* Multicast Table Array - RW Array */
-#define IGC_RA	0x05400  /* Receive Address - RW Array */
-#define IGC_RA2	0x054E0  /* 2nd half of Rx address array - RW Array */
-#define IGC_VFTA	0x05600  /* VLAN Filter Table Array - RW Array */
-#define IGC_VT_CTL	0x0581C  /* VMDq Control - RW */
-#define IGC_CIAA	0x05B88  /* Config Indirect Access Address - RW */
-#define IGC_CIAD	0x05B8C  /* Config Indirect Access Data - RW */
-#define IGC_VFQA0	0x0B000  /* VLAN Filter Queue Array 0 - RW Array */
-#define IGC_VFQA1	0x0B200  /* VLAN Filter Queue Array 1 - RW Array */
-#define IGC_WUC	0x05800  /* Wakeup Control - RW */
-#define IGC_WUFC	0x05808  /* Wakeup Filter Control - RW */
-#define IGC_WUS	0x05810  /* Wakeup Status - RO */
-/* Management registers */
-#define IGC_MANC	0x05820  /* Management Control - RW */
-#define IGC_IPAV	0x05838  /* IP Address Valid - RW */
-#define IGC_IP4AT	0x05840  /* IPv4 Address Table - RW Array */
-#define IGC_IP6AT	0x05880  /* IPv6 Address Table - RW Array */
-#define IGC_WUPL	0x05900  /* Wakeup Packet Length - RW */
-#define IGC_WUPM	0x05A00  /* Wakeup Packet Memory - RO A */
-#define IGC_WUPM_EXT	0x0B800  /* Wakeup Packet Memory Extended - RO Array */
-#define IGC_WUFC_EXT	0x0580C  /* Wakeup Filter Control Extended - RW */
-#define IGC_WUS_EXT	0x05814  /* Wakeup Status Extended - RW1C */
-#define IGC_FHFTSL	0x05804  /* Flex Filter Indirect Table Select - RW */
-#define IGC_PROXYFCEX	0x05590  /* Proxy Filter Control Extended - RW1C */
-#define IGC_PROXYEXS	0x05594  /* Proxy Extended Status - RO */
-#define IGC_WFUTPF	0x05500  /* Wake Flex UDP TCP Port Filter - RW Array */
-#define IGC_RFUTPF	0x05580  /* Range Flex UDP TCP Port Filter - RW */
-#define IGC_RWPFC	0x05584  /* Range Wake Port Filter Control - RW */
-#define IGC_WFUTPS	0x05588  /* Wake Filter UDP TCP Status - RW1C */
-#define IGC_WCS	0x0558C  /* Wake Control Status - RW1C */
-/* MSI-X Table Register Descriptions */
-#define IGC_PBACL	0x05B68  /* MSIx PBA Clear - Read/Write 1's to clear */
-#define IGC_FFLT	0x05F00  /* Flexible Filter Length Table - RW Array */
-#define IGC_HOST_IF	0x08800  /* Host Interface */
-#define IGC_HIBBA	0x8F40   /* Host Interface Buffer Base Address */
-/* Flexible Host Filter Table */
-#define IGC_FHFT(_n)	(0x09000 + ((_n) * 0x100))
-/* Ext Flexible Host Filter Table */
-#define IGC_FHFT_EXT(_n)	(0x09A00 + ((_n) * 0x100))
-
-
-#define IGC_KMRNCTRLSTA	0x00034 /* MAC-PHY interface - RW */
-#define IGC_MANC2H		0x05860 /* Management Control To Host - RW */
-/* Management Decision Filters */
-#define IGC_MDEF(_n)		(0x05890 + (4 * (_n)))
-/* Semaphore registers */
-#define IGC_SW_FW_SYNC	0x05B5C /* SW-FW Synchronization - RW */
-#define IGC_CCMCTL	0x05B48 /* CCM Control Register */
-#define IGC_GIOCTL	0x05B44 /* GIO Analog Control Register */
-#define IGC_SCCTL	0x05B4C /* PCIc PLL Configuration Register */
-/* PCIe Register Description */
-#define IGC_GCR	0x05B00 /* PCI-Ex Control */
-#define IGC_GCR2	0x05B64 /* PCI-Ex Control #2 */
-#define IGC_GSCL_1	0x05B10 /* PCI-Ex Statistic Control #1 */
-#define IGC_GSCL_2	0x05B14 /* PCI-Ex Statistic Control #2 */
-#define IGC_GSCL_3	0x05B18 /* PCI-Ex Statistic Control #3 */
-#define IGC_GSCL_4	0x05B1C /* PCI-Ex Statistic Control #4 */
-/* Function Active and Power State to MNG */
-#define IGC_FACTPS	0x05B30
-#define IGC_SWSM	0x05B50 /* SW Semaphore */
-#define IGC_FWSM	0x05B54 /* FW Semaphore */
-/* Driver-only SW semaphore (not used by BOOT agents) */
-#define IGC_SWSM2	0x05B58
-#define IGC_DCA_ID	0x05B70 /* DCA Requester ID Information - RO */
-#define IGC_DCA_CTRL	0x05B74 /* DCA Control - RW */
-#define IGC_UFUSE	0x05B78 /* UFUSE - RO */
-#define IGC_FFLT_DBG	0x05F04 /* Debug Register */
-#define IGC_HICR	0x08F00 /* Host Interface Control */
-#define IGC_FWSTS	0x08F0C /* FW Status */
-
-/* RSS registers */
-#define IGC_CPUVEC	0x02C10 /* CPU Vector Register - RW */
-#define IGC_MRQC	0x05818 /* Multiple Receive Control - RW */
-#define IGC_IMIR(_i)	(0x05A80 + ((_i) * 4))  /* Immediate Interrupt */
-#define IGC_IMIREXT(_i)	(0x05AA0 + ((_i) * 4)) /* Immediate INTR Ext*/
-#define IGC_IMIRVP		0x05AC0 /* Immediate INT Rx VLAN Priority -RW */
-#define IGC_MSIXBM(_i)	(0x01600 + ((_i) * 4)) /* MSI-X Alloc Reg -RW */
-/* Redirection Table - RW Array */
-#define IGC_RETA(_i)	(0x05C00 + ((_i) * 4))
-/* RSS Random Key - RW Array */
-#define IGC_RSSRK(_i)	(0x05C80 + ((_i) * 4))
-#define IGC_RSSIM	0x05864 /* RSS Interrupt Mask */
-#define IGC_RSSIR	0x05868 /* RSS Interrupt Request */
-#define IGC_UTA	0x0A000 /* Unicast Table Array - RW */
-/* VT Registers */
-#define IGC_SWPBS	0x03004 /* Switch Packet Buffer Size - RW */
-#define IGC_MBVFICR	0x00C80 /* Mailbox VF Cause - RWC */
-#define IGC_MBVFIMR	0x00C84 /* Mailbox VF int Mask - RW */
-#define IGC_VFLRE	0x00C88 /* VF Register Events - RWC */
-#define IGC_VFRE	0x00C8C /* VF Receive Enables */
-#define IGC_VFTE	0x00C90 /* VF Transmit Enables */
-#define IGC_QDE	0x02408 /* Queue Drop Enable - RW */
-#define IGC_DTXSWC	0x03500 /* DMA Tx Switch Control - RW */
-#define IGC_WVBR	0x03554 /* VM Wrong Behavior - RWS */
-#define IGC_RPLOLR	0x05AF0 /* Replication Offload - RW */
-#define IGC_IOVTCL	0x05BBC /* IOV Control Register */
-#define IGC_VMRCTL	0X05D80 /* Virtual Mirror Rule Control */
-#define IGC_VMRVLAN	0x05D90 /* Virtual Mirror Rule VLAN */
-#define IGC_VMRVM	0x05DA0 /* Virtual Mirror Rule VM */
-#define IGC_MDFB	0x03558 /* Malicious Driver free block */
-#define IGC_LVMMC	0x03548 /* Last VM Misbehavior cause */
-#define IGC_TXSWC	0x05ACC /* Tx Switch Control */
-#define IGC_SCCRL	0x05DB0 /* Storm Control Control */
-#define IGC_BSCTRH	0x05DB8 /* Broadcast Storm Control Threshold */
-#define IGC_MSCTRH	0x05DBC /* Multicast Storm Control Threshold */
-/* These act per VF so an array friendly macro is used */
-#define IGC_V2PMAILBOX(_n)	(0x00C40 + (4 * (_n)))
-#define IGC_P2VMAILBOX(_n)	(0x00C00 + (4 * (_n)))
-#define IGC_VMBMEM(_n)	(0x00800 + (64 * (_n)))
-#define IGC_VFVMBMEM(_n)	(0x00800 + (_n))
-#define IGC_VMOLR(_n)		(0x05AD0 + (4 * (_n)))
-/* VLAN Virtual Machine Filter - RW */
-#define IGC_VLVF(_n)		(0x05D00 + (4 * (_n)))
-#define IGC_VMVIR(_n)		(0x03700 + (4 * (_n)))
-#define IGC_DVMOLR(_n)	(0x0C038 + (0x40 * (_n))) /* DMA VM offload */
-#define IGC_VTCTRL(_n)	(0x10000 + (0x100 * (_n))) /* VT Control */
-#define IGC_TSYNCRXCTL	0x0B620 /* Rx Time Sync Control register - RW */
-#define IGC_TSYNCTXCTL	0x0B614 /* Tx Time Sync Control register - RW */
-#define IGC_TSYNCRXCFG	0x05F50 /* Time Sync Rx Configuration - RW */
-#define IGC_RXSTMPL	0x0B624 /* Rx timestamp Low - RO */
-#define IGC_RXSTMPH	0x0B628 /* Rx timestamp High - RO */
-#define IGC_RXSATRL	0x0B62C /* Rx timestamp attribute low - RO */
-#define IGC_RXSATRH	0x0B630 /* Rx timestamp attribute high - RO */
-#define IGC_TXSTMPL	0x0B618 /* Tx timestamp value Low - RO */
-#define IGC_TXSTMPH	0x0B61C /* Tx timestamp value High - RO */
-#define IGC_SYSTIML	0x0B600 /* System time register Low - RO */
-#define IGC_SYSTIMH	0x0B604 /* System time register High - RO */
-#define IGC_TIMINCA	0x0B608 /* Increment attributes register - RW */
-#define IGC_TIMADJL	0x0B60C /* Time sync time adjustment offset Low - RW */
-#define IGC_TIMADJH	0x0B610 /* Time sync time adjustment offset High - RW */
-#define IGC_TSAUXC	0x0B640 /* Timesync Auxiliary Control register */
-#define	IGC_SYSSTMPL	0x0B648 /* HH Timesync system stamp low register */
-#define	IGC_SYSSTMPH	0x0B64C /* HH Timesync system stamp hi register */
-#define	IGC_PLTSTMPL	0x0B640 /* HH Timesync platform stamp low register */
-#define	IGC_PLTSTMPH	0x0B644 /* HH Timesync platform stamp hi register */
-#define IGC_SYSTIMR	0x0B6F8 /* System time register Residue */
-#define IGC_TSICR	0x0B66C /* Interrupt Cause Register */
-#define IGC_TSIM	0x0B674 /* Interrupt Mask Register */
-#define IGC_RXMTRL	0x0B634 /* Time sync Rx EtherType and Msg Type - RW */
-#define IGC_RXUDP	0x0B638 /* Time Sync Rx UDP Port - RW */
-
-#define IGC_QBVCYCLET	0x331C
-#define IGC_QBVCYCLET_S 0x3320
-#define IGC_STQT(_n)	(0x3324 + 0x4 * (_n))
-#define IGC_ENDQT(_n)	(0x3334 + 0x4 * (_n))
-#define IGC_TXQCTL(_n)	(0x3344 + 0x4 * (_n))
-#define IGC_BASET_L	0x3314
-#define IGC_BASET_H	0x3318
-
-/* Filtering Registers */
-#define IGC_SAQF(_n)	(0x05980 + (4 * (_n))) /* Source Address Queue Fltr */
-#define IGC_DAQF(_n)	(0x059A0 + (4 * (_n))) /* Dest Address Queue Fltr */
-#define IGC_SPQF(_n)	(0x059C0 + (4 * (_n))) /* Source Port Queue Fltr */
-#define IGC_FTQF(_n)	(0x059E0 + (4 * (_n))) /* 5-tuple Queue Fltr */
-#define IGC_TTQF(_n)	(0x059E0 + (4 * (_n))) /* 2-tuple Queue Fltr */
-#define IGC_SYNQF(_n)	(0x055FC + (4 * (_n))) /* SYN Packet Queue Fltr */
-#define IGC_ETQF(_n)	(0x05CB0 + (4 * (_n))) /* EType Queue Fltr */
-
-#define IGC_RTTDCS	0x3600 /* Reedtown Tx Desc plane control and status */
-#define IGC_RTTPCS	0x3474 /* Reedtown Tx Packet Plane control and status */
-#define IGC_RTRPCS	0x2474 /* Rx packet plane control and status */
-#define IGC_RTRUP2TC	0x05AC4 /* Rx User Priority to Traffic Class */
-#define IGC_RTTUP2TC	0x0418 /* Transmit User Priority to Traffic Class */
-/* Tx Desc plane TC Rate-scheduler config */
-#define IGC_RTTDTCRC(_n)	(0x3610 + ((_n) * 4))
-/* Tx Packet plane TC Rate-Scheduler Config */
-#define IGC_RTTPTCRC(_n)	(0x3480 + ((_n) * 4))
-/* Rx Packet plane TC Rate-Scheduler Config */
-#define IGC_RTRPTCRC(_n)	(0x2480 + ((_n) * 4))
-/* Tx Desc Plane TC Rate-Scheduler Status */
-#define IGC_RTTDTCRS(_n)	(0x3630 + ((_n) * 4))
-/* Tx Desc Plane TC Rate-Scheduler MMW */
-#define IGC_RTTDTCRM(_n)	(0x3650 + ((_n) * 4))
-/* Tx Packet plane TC Rate-Scheduler Status */
-#define IGC_RTTPTCRS(_n)	(0x34A0 + ((_n) * 4))
-/* Tx Packet plane TC Rate-scheduler MMW */
-#define IGC_RTTPTCRM(_n)	(0x34C0 + ((_n) * 4))
-/* Rx Packet plane TC Rate-Scheduler Status */
-#define IGC_RTRPTCRS(_n)	(0x24A0 + ((_n) * 4))
-/* Rx Packet plane TC Rate-Scheduler MMW */
-#define IGC_RTRPTCRM(_n)	(0x24C0 + ((_n) * 4))
-/* Tx Desc plane VM Rate-Scheduler MMW*/
-#define IGC_RTTDVMRM(_n)	(0x3670 + ((_n) * 4))
-/* Tx BCN Rate-Scheduler MMW */
-#define IGC_RTTBCNRM(_n)	(0x3690 + ((_n) * 4))
-#define IGC_RTTDQSEL	0x3604  /* Tx Desc Plane Queue Select */
-#define IGC_RTTDVMRC	0x3608  /* Tx Desc Plane VM Rate-Scheduler Config */
-#define IGC_RTTDVMRS	0x360C  /* Tx Desc Plane VM Rate-Scheduler Status */
-#define IGC_RTTBCNRC	0x36B0  /* Tx BCN Rate-Scheduler Config */
-#define IGC_RTTBCNRS	0x36B4  /* Tx BCN Rate-Scheduler Status */
-#define IGC_RTTBCNCR	0xB200  /* Tx BCN Control Register */
-#define IGC_RTTBCNTG	0x35A4  /* Tx BCN Tagging */
-#define IGC_RTTBCNCP	0xB208  /* Tx BCN Congestion point */
-#define IGC_RTRBCNCR	0xB20C  /* Rx BCN Control Register */
-#define IGC_RTTBCNRD	0x36B8  /* Tx BCN Rate Drift */
-#define IGC_PFCTOP	0x1080  /* Priority Flow Control Type and Opcode */
-#define IGC_RTTBCNIDX	0xB204  /* Tx BCN Congestion Point */
-#define IGC_RTTBCNACH	0x0B214 /* Tx BCN Control High */
-#define IGC_RTTBCNACL	0x0B210 /* Tx BCN Control Low */
-
-/* DMA Coalescing registers */
-#define IGC_DMACR	0x02508 /* Control Register */
-#define IGC_DMCTXTH	0x03550 /* Transmit Threshold */
-#define IGC_DMCTLX	0x02514 /* Time to Lx Request */
-#define IGC_DMCRTRH	0x05DD0 /* Receive Packet Rate Threshold */
-#define IGC_DMCCNT	0x05DD4 /* Current Rx Count */
-#define IGC_FCRTC	0x02170 /* Flow Control Rx high watermark */
-#define IGC_PCIEMISC	0x05BB8 /* PCIE misc config register */
-
-/* PCIe Parity Status Register */
-#define IGC_PCIEERRSTS	0x05BA8
-
-#define IGC_PROXYS	0x5F64 /* Proxying Status */
-#define IGC_PROXYFC	0x5F60 /* Proxying Filter Control */
-/* Thermal sensor configuration and status registers */
-#define IGC_THMJT	0x08100 /* Junction Temperature */
-#define IGC_THLOWTC	0x08104 /* Low Threshold Control */
-#define IGC_THMIDTC	0x08108 /* Mid Threshold Control */
-#define IGC_THHIGHTC	0x0810C /* High Threshold Control */
-#define IGC_THSTAT	0x08110 /* Thermal Sensor Status */
-
-/* Energy Efficient Ethernet "EEE" registers */
-#define IGC_IPCNFG	0x0E38 /* Internal PHY Configuration */
-#define IGC_LTRC	0x01A0 /* Latency Tolerance Reporting Control */
-#define IGC_EEER	0x0E30 /* Energy Efficient Ethernet "EEE"*/
-#define IGC_EEE_SU	0x0E34 /* EEE Setup */
-#define IGC_EEE_SU_2P5	0x0E3C /* EEE 2.5G Setup */
-#define IGC_TLPIC	0x4148 /* EEE Tx LPI Count - TLPIC */
-#define IGC_RLPIC	0x414C /* EEE Rx LPI Count - RLPIC */
-
-/* OS2BMC Registers */
-#define IGC_B2OSPC	0x08FE0 /* BMC2OS packets sent by BMC */
-#define IGC_B2OGPRC	0x04158 /* BMC2OS packets received by host */
-#define IGC_O2BGPTC	0x08FE4 /* OS2BMC packets received by BMC */
-#define IGC_O2BSPC	0x0415C /* OS2BMC packets transmitted by host */
-
-#define IGC_LTRMINV	0x5BB0 /* LTR Minimum Value */
-#define IGC_LTRMAXV	0x5BB4 /* LTR Maximum Value */
-
-
-/* IEEE 1588 TIMESYNCH */
-#define IGC_TRGTTIML0	0x0B644 /* Target Time Register 0 Low  - RW */
-#define IGC_TRGTTIMH0	0x0B648 /* Target Time Register 0 High - RW */
-#define IGC_TRGTTIML1	0x0B64C /* Target Time Register 1 Low  - RW */
-#define IGC_TRGTTIMH1	0x0B650 /* Target Time Register 1 High - RW */
-#define IGC_FREQOUT0	0x0B654 /* Frequency Out 0 Control Register - RW */
-#define IGC_FREQOUT1	0x0B658 /* Frequency Out 1 Control Register - RW */
-#define IGC_TSSDP	0x0003C  /* Time Sync SDP Configuration Register - RW */
-
-#define IGC_LTRC_EEEMS_EN			(1 << 5)
-#define IGC_TW_SYSTEM_100_MASK		0xff00
-#define IGC_TW_SYSTEM_100_SHIFT	8
-#define IGC_TW_SYSTEM_1000_MASK	0xff
-#define IGC_LTRMINV_SCALE_1024		0x02
-#define IGC_LTRMINV_SCALE_32768	0x03
-#define IGC_LTRMAXV_SCALE_1024		0x02
-#define IGC_LTRMAXV_SCALE_32768	0x03
-#define IGC_LTRMINV_LTRV_MASK		0x1ff
-#define IGC_LTRMINV_LSNP_REQ		0x80
-#define IGC_LTRMINV_SCALE_SHIFT	10
-#define IGC_LTRMAXV_LTRV_MASK		0x1ff
-#define IGC_LTRMAXV_LSNP_REQ		0x80
-#define IGC_LTRMAXV_SCALE_SHIFT	10
-
-#define IGC_MRQC_ENABLE_MASK		0x00000007
-#define IGC_MRQC_RSS_FIELD_IPV6_EX	0x00080000
-#define IGC_RCTL_DTYP_MASK		0x00000C00 /* Descriptor type mask */
-
-#endif
diff --git a/drivers/net/intel/igc/base/meson.build b/drivers/net/intel/igc/base/meson.build
deleted file mode 100644
index f52421f7a9..0000000000
--- a/drivers/net/intel/igc/base/meson.build
+++ /dev/null
@@ -1,19 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2019-2020 Intel Corporation
-
-sources = [
-        'igc_api.c',
-        'igc_base.c',
-        'igc_i225.c',
-        'igc_mac.c',
-        'igc_manage.c',
-        'igc_nvm.c',
-        'igc_osdep.c',
-        'igc_phy.c',
-]
-
-base_lib = static_library('igc_base', sources,
-    dependencies: static_rte_eal,
-    c_args: cflags)
-
-base_objs = base_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/intel/igc/igc_logs.h b/drivers/net/intel/igc/igc_logs.h
deleted file mode 100644
index 3e6afd9f10..0000000000
--- a/drivers/net/intel/igc/igc_logs.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2019-2020 Intel Corporation
- */
-
-#ifndef _IGC_LOGS_H_
-#define _IGC_LOGS_H_
-
-#include <rte_log.h>
-
-#ifdef __cplusplus
-extern "C" {
-#endif
-
-extern int igc_logtype_init;
-#define RTE_LOGTYPE_IGC_INIT igc_logtype_init
-extern int igc_logtype_driver;
-#define RTE_LOGTYPE_IGC_DRIVER igc_logtype_driver
-
-#define PMD_INIT_LOG(level, ...) \
-	RTE_LOG_LINE_PREFIX(level, IGC_INIT, "%s(): ", __func__, __VA_ARGS__)
-
-#define PMD_INIT_FUNC_TRACE() PMD_INIT_LOG(DEBUG, " >>")
-
-#ifdef RTE_ETHDEV_DEBUG_RX
-#define PMD_RX_LOG(...) PMD_DRV_LOG(__VA_ARGS__)
-#else
-#define PMD_RX_LOG(...) do { } while (0)
-#endif
-
-#ifdef RTE_ETHDEV_DEBUG_TX
-#define PMD_TX_LOG(...) PMD_DRV_LOG(__VA_ARGS__)
-#else
-#define PMD_TX_LOG(...) do { } while (0)
-#endif
-
-#define PMD_DRV_LOG(level, ...) \
-	RTE_LOG_LINE_PREFIX(level, IGC_DRIVER, "%s(): ", __func__, __VA_ARGS__)
-
-#ifdef __cplusplus
-}
-#endif
-
-#endif /* _IGC_LOGS_H_ */
diff --git a/drivers/net/intel/igc/meson.build b/drivers/net/intel/igc/meson.build
deleted file mode 100644
index 9ab19ea9c3..0000000000
--- a/drivers/net/intel/igc/meson.build
+++ /dev/null
@@ -1,21 +0,0 @@
-# SPDX-License-Identifier: BSD-3-Clause
-# Copyright(c) 2019-2020 Intel Corporation
-
-if is_windows
-    build = false
-    reason = 'not supported on Windows'
-    subdir_done()
-endif
-
-subdir('base')
-objs = [base_objs]
-
-sources = files(
-        'igc_ethdev.c',
-        'igc_logs.c',
-        'igc_filter.c',
-        'igc_flow.c',
-        'igc_txrx.c',
-)
-
-includes += include_directories('base')
diff --git a/drivers/net/meson.build b/drivers/net/meson.build
index 02a3f5a0b6..060b79c85c 100644
--- a/drivers/net/meson.build
+++ b/drivers/net/meson.build
@@ -31,7 +31,6 @@ drivers = [
         'intel/iavf',
         'intel/ice',
         'intel/idpf',
-        'intel/igc',
         'intel/ipn3ke',
         'intel/ixgbe',
         'ionic',
-- 
2.43.5

