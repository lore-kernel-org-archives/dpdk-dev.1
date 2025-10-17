Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED1DCCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:19:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4E6EB40B8F;
	Fri, 17 Oct 2025 11:19:34 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 52AA640269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:32 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 34147200D88;
 Fri, 17 Oct 2025 11:19:32 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C847D200E78;
 Fri, 17 Oct 2025 11:19:31 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E4FC818000A0;
 Fri, 17 Oct 2025 17:19:30 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [v2 01/12] net/enetc: Add initial ENETC4 PMD driver support
Date: Fri, 17 Oct 2025 14:49:18 +0530
Message-Id: <20251017091929.2723044-2-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017091929.2723044-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251017091929.2723044-1-vanshika.shukla@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

This patch introduces a new ENETC4 PMD driver for NXP's multiple
SoC, enabling basic network operations. Key features include:

- Probe and teardown functions
- Hardware initialization for both Virtual Functions (VFs)
  and Physical Function (PF)

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 MAINTAINERS                            |   3 +
 config/arm/arm64_imx_linux_gcc         |  17 ++
 config/arm/meson.build                 |  14 ++
 doc/guides/nics/enetc4.rst             |  90 ++++++++
 doc/guides/nics/features/enetc4.ini    |   9 +
 doc/guides/nics/index.rst              |   1 +
 doc/guides/rel_notes/release_25_11.rst |   3 +
 drivers/net/enetc/base/enetc4_hw.h     | 113 ++++++++++
 drivers/net/enetc/base/enetc_hw.h      |   4 +-
 drivers/net/enetc/enetc.h              |  40 ++--
 drivers/net/enetc/enetc4_ethdev.c      | 297 +++++++++++++++++++++++++
 drivers/net/enetc/enetc4_vf.c          | 146 ++++++++++++
 drivers/net/enetc/enetc_ethdev.c       |   9 +-
 drivers/net/enetc/meson.build          |   4 +-
 14 files changed, 726 insertions(+), 24 deletions(-)
 create mode 100644 config/arm/arm64_imx_linux_gcc
 create mode 100644 doc/guides/nics/enetc4.rst
 create mode 100644 doc/guides/nics/features/enetc4.ini
 create mode 100644 drivers/net/enetc/base/enetc4_hw.h
 create mode 100644 drivers/net/enetc/enetc4_ethdev.c
 create mode 100644 drivers/net/enetc/enetc4_vf.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1a2729be66..6614e5ad38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -974,9 +974,12 @@ F: doc/guides/nics/features/dpaa2.ini
 NXP enetc
 M: Gagandeep Singh <g.singh@nxp.com>
 M: Sachin Saxena <sachin.saxena@oss.nxp.com>
+M: Vanshika Shukla <vanshika.shukla@nxp.com>
 F: drivers/net/enetc/
 F: doc/guides/nics/enetc.rst
+F: doc/guides/nics/enetc4.rst
 F: doc/guides/nics/features/enetc.ini
+F: doc/guides/nics/features/enetc4.ini
 
 NXP enetfec - EXPERIMENTAL
 M: Apeksha Gupta <apeksha.gupta@nxp.com>
diff --git a/config/arm/arm64_imx_linux_gcc b/config/arm/arm64_imx_linux_gcc
new file mode 100644
index 0000000000..c876ae1d2b
--- /dev/null
+++ b/config/arm/arm64_imx_linux_gcc
@@ -0,0 +1,17 @@
+[binaries]
+c = ['ccache', 'aarch64-linux-gnu-gcc']
+cpp = ['ccache', 'aarch64-linux-gnu-g++']
+ar = 'aarch64-linux-gnu-ar'
+as = 'aarch64-linux-gnu-as'
+strip = 'aarch64-linux-gnu-strip'
+pkgconfig = 'aarch64-linux-gnu-pkg-config'
+pcap-config = ''
+
+[host_machine]
+system = 'linux'
+cpu_family = 'aarch64'
+cpu = 'armv8.2-a'
+endian = 'little'
+
+[properties]
+platform = 'imx'
diff --git a/config/arm/meson.build b/config/arm/meson.build
index 665f3fa38f..f2567adf06 100644
--- a/config/arm/meson.build
+++ b/config/arm/meson.build
@@ -562,6 +562,18 @@ soc_hip10 = {
     'numa': true
 }
 
+soc_imx = {
+    'description': 'NXP IMX',
+    'implementer': '0x41',
+    'part_number': '0xd05',
+    'flags': [
+        ['RTE_MACHINE', '"armv8a"'],
+        ['RTE_MAX_LCORE', 6],
+        ['RTE_MAX_NUMA_NODES', 1],
+    ],
+    'numa': false,
+}
+
 soc_kunpeng920 = {
     'description': 'HiSilicon Kunpeng 920',
     'implementer': '0x48',
@@ -746,6 +758,7 @@ graviton2:       AWS Graviton2
 graviton3:       AWS Graviton3
 graviton4:       AWS Graviton4
 hip10:           HiSilicon HIP10
+imx:             NXP IMX
 kunpeng920:      HiSilicon Kunpeng 920
 kunpeng930:      HiSilicon Kunpeng 930
 n1sdp:           Arm Neoverse N1SDP
@@ -788,6 +801,7 @@ socs = {
     'graviton3': soc_graviton3,
     'graviton4': soc_graviton4,
     'hip10': soc_hip10,
+    'imx': soc_imx,
     'kunpeng920': soc_kunpeng920,
     'kunpeng930': soc_kunpeng930,
     'n1sdp': soc_n1sdp,
diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
new file mode 100644
index 0000000000..4443185e08
--- /dev/null
+++ b/doc/guides/nics/enetc4.rst
@@ -0,0 +1,90 @@
+.. SPDX-License-Identifier: BSD-3-Clause
+   Copyright 2024-2025 NXP
+
+ENETC4 Poll Mode Driver
+=======================
+
+The ENETC4 NIC PMD (**librte_net_enetc**) provides poll mode driver
+support for the inbuilt NIC found in multiple NXP new generation SoCs.
+
+More information can be found at `NXP Official Website
+<https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-9-processors/i-mx-95-applications-processor-family-high-performance-safety-enabled-platform-with-eiq-neutron-npu:iMX95>`_.
+
+This section provides an overview of the NXP ENETC4
+and how it is integrated into the DPDK.
+
+Contents summary
+
+- ENETC4 overview
+- Supported ENETC4 SoCs
+- PCI bus driver
+- NIC driver
+- Prerequisites
+- Driver compilation and testing
+
+ENETC4 Overview
+---------------
+
+ENETC4 is a PCI Integrated End Point(IEP). IEP implements
+peripheral devices in an SoC such that software sees them as PCIe device.
+ENETC4 is an evolution of BDR(Buffer Descriptor Ring) based networking
+IPs.
+
+This infrastructure simplifies adding support for IEP and facilitates in following:
+
+- Device discovery and location
+- Resource requirement discovery and allocation (e.g. interrupt assignment,
+  device register address)
+- Event reporting
+
+Supported ENETC4 SoCs
+---------------------
+
+- i.MX95
+- i.MX943
+
+NIC Driver (PMD)
+----------------
+
+The ENETC4 PMD is a traditional DPDK PMD that bridges the RTE framework and
+ENETC4 internal drivers, supporting both Virtual Functions (VFs) and
+Physical Functions (PF). Key functionality includes:
+
+- Driver registration: The device vendor table is registered in the PCI subsystem.
+- Device discovery: The RTE framework scans the PCI bus for connected devices, triggering the ENETC4 driver's probe function.
+- Initialization: The probe function configures basic device registers and sets up Buffer Descriptor (BD) rings.
+- Receive processing: Upon packet reception, the BD Ring status bit is set, facilitating packet processing.
+- Transmission: Packet transmission precedes reception, ensuring efficient data transfer.
+
+Prerequisites
+-------------
+
+There are three main pre-requisites for executing ENETC4 PMD on ENETC4
+compatible boards:
+
+#. **ARM 64 Tool Chain**
+
+   For example, the `*aarch64* ARM Toolchain <https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-aarch64-none-linux-gnu.tar.xz>`_.
+
+#. **Linux Kernel**
+
+   It can be obtained from `NXP's Github hosting <https://github.com/nxp-imx/linux-imx>`_.
+
+The following dependencies are not part of DPDK and must be installed
+separately:
+
+- **NXP Linux LF**
+
+  NXP Linux LF refers to NXP's Linux Factory releases, which are specific Linux
+  distributions and Board Support Packages (BSPs) provided by NXP for their
+  i.MX family of applications processors and other embedded platforms.
+
+  i.MX LF release and related information can be obtained from:  `LF  <https://www.nxp.com/design/design-center/software/embedded-software/i-mx-software/embedded-linux-for-i-mx-applications-processors:IMXLINUX>`_
+  Refer section: Linux Current Release.
+
+Driver compilation and testing
+------------------------------
+
+Follow instructions available in the document
+:ref:`compiling and testing a PMD for a NIC <pmd_build_and_test>`
+to launch **testpmd**
diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
new file mode 100644
index 0000000000..ca3b9ae992
--- /dev/null
+++ b/doc/guides/nics/features/enetc4.ini
@@ -0,0 +1,9 @@
+;
+; Supported features of the 'enetc4' network poll mode driver.
+;
+; Refer to default.ini for the full list of available PMD features.
+;
+[Features]
+Linux                = Y
+ARMv8                = Y
+Usage doc            = Y
diff --git a/doc/guides/nics/index.rst b/doc/guides/nics/index.rst
index 57d161c526..c6e9a3a71d 100644
--- a/doc/guides/nics/index.rst
+++ b/doc/guides/nics/index.rst
@@ -27,6 +27,7 @@ Network Interface Controller Drivers
     e1000em
     ena
     enetc
+    enetc4
     enetfec
     enic
     fail_safe
diff --git a/doc/guides/rel_notes/release_25_11.rst b/doc/guides/rel_notes/release_25_11.rst
index 3c32b26e3b..cde10d3103 100644
--- a/doc/guides/rel_notes/release_25_11.rst
+++ b/doc/guides/rel_notes/release_25_11.rst
@@ -94,6 +94,9 @@ New Features
   The built-in help text function is available as a public function which can be reused by custom functions,
   if so desired.
 
+* **Added ENETC4 PMD**
+
+  * Added ENETC4 PMD for NXP multiple new generation SOC.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
new file mode 100644
index 0000000000..7cc1a4b276
--- /dev/null
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2024 NXP
+ *
+ * This header file defines the register offsets and bit fields
+ * of ENETC4 PF and VFs.
+ */
+
+#ifndef _ENETC4_HW_H_
+#define _ENETC4_HW_H_
+#include <rte_io.h>
+
+#define BIT(x)		((uint64_t)1 << ((x)))
+
+/* ENETC4 device IDs */
+#define ENETC4_DEV_ID		0xe101
+#define ENETC4_DEV_ID_VF	0xef00
+#define PCI_VENDOR_ID_NXP	0x1131
+
+/***************************ENETC port registers**************************/
+#define ENETC4_PMR		0x10
+#define ENETC4_PMR_EN		(BIT(16) | BIT(17) | BIT(18))
+
+/* Port Station interface promiscuous MAC mode register */
+#define ENETC4_PSIPMMR		0x200
+#define PSIPMMR_SI0_MAC_UP	BIT(0)
+#define PSIPMMR_SI_MAC_UP	(BIT(0) | BIT(1) | BIT(2))
+#define PSIPMMR_SI0_MAC_MP	BIT(16)
+#define PSIPMMR_SI_MAC_MP	(BIT(16) | BIT(17) | BIT(18))
+
+/* Port Station interface a primary MAC address registers */
+#define ENETC4_PSIPMAR0(a)	((a) * 0x80 + 0x2000)
+#define ENETC4_PSIPMAR1(a)	((a) * 0x80 + 0x2004)
+
+/* Port MAC address register 0/1 */
+#define ENETC4_PMAR0		0x4020
+#define ENETC4_PMAR1		0x4024
+
+/* Port operational register */
+#define ENETC4_POR		0x4100
+
+/* Port traffic class a transmit maximum SDU register */
+#define ENETC4_PTCTMSDUR(a)	((a) * 0x20 + 0x4208)
+#define SDU_TYPE_MPDU		BIT(16)
+
+#define ENETC4_PM_CMD_CFG(mac)		(0x5008 + (mac) * 0x400)
+#define PM_CMD_CFG_TX_EN		BIT(0)
+#define PM_CMD_CFG_RX_EN		BIT(1)
+
+/* i.MX95 supports jumbo frame, but it is recommended to set the max frame
+ * size to 2000 bytes.
+ */
+#define ENETC4_MAC_MAXFRM_SIZE  2000
+
+/* Port MAC 0/1 Maximum Frame Length Register */
+#define ENETC4_PM_MAXFRM(mac)		(0x5014 + (mac) * 0x400)
+
+/* Config register to reset counters */
+#define ENETC4_PM0_STAT_CONFIG		0x50e0
+/* Stats Reset Bit */
+#define ENETC4_CLEAR_STATS		BIT(2)
+
+/* Port MAC 0/1 Receive Ethernet Octets Counter */
+#define ENETC4_PM_REOCT(mac)            (0x5100 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Frame Error Counter */
+#define ENETC4_PM_RERR(mac)		(0x5138 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Dropped Packets Counter */
+#define ENETC4_PM_RDRP(mac)		(0x5158 + (mac) * 0x400)
+
+/* Port MAC 0/1 Receive Packets Counter */
+#define ENETC4_PM_RPKT(mac)		(0x5160 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Frame Error Counter */
+#define ENETC4_PM_TERR(mac)		(0x5238 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Ethernet Octets Counter */
+#define ENETC4_PM_TEOCT(mac)            (0x5200 + (mac) * 0x400)
+
+/* Port MAC 0/1 Transmit Packets Counter */
+#define ENETC4_PM_TPKT(mac)		(0x5260 + (mac) * 0x400)
+
+/* Port MAC 0 Interface Mode Control Register */
+#define ENETC4_PM_IF_MODE(mac)		(0x5300 + (mac) * 0x400)
+#define PM_IF_MODE_IFMODE		(BIT(0) | BIT(1) | BIT(2))
+#define IFMODE_XGMII			0
+#define IFMODE_RMII			3
+#define IFMODE_RGMII			4
+#define IFMODE_SGMII			5
+#define PM_IF_MODE_ENA			BIT(15)
+
+/* general register accessors */
+#define enetc4_rd_reg(reg)	rte_read32((void *)(reg))
+#define enetc4_wr_reg(reg, val)  rte_write32((val), (void *)(reg))
+
+#define enetc4_rd(hw, off)	 enetc4_rd_reg((size_t)(hw)->reg + (off))
+#define enetc4_wr(hw, off, val)  enetc4_wr_reg((size_t)(hw)->reg + (off), val)
+/* port register accessors - PF only */
+#define enetc4_port_rd(hw, off)  enetc4_rd_reg((size_t)(hw)->port + (off))
+#define enetc4_port_wr(hw, off, val) \
+				enetc4_wr_reg((size_t)(hw)->port + (off), val)
+/* BDR register accessors, see ENETC_BDR() */
+#define enetc4_bdr_rd(hw, t, n, off) \
+				enetc4_rd(hw, ENETC_BDR(t, n, off))
+#define enetc4_bdr_wr(hw, t, n, off, val) \
+				enetc4_wr(hw, ENETC_BDR(t, n, off), val)
+#define enetc4_txbdr_rd(hw, n, off) enetc4_bdr_rd(hw, TX, n, off)
+#define enetc4_rxbdr_rd(hw, n, off) enetc4_bdr_rd(hw, RX, n, off)
+#define enetc4_txbdr_wr(hw, n, off, val) \
+				enetc4_bdr_wr(hw, TX, n, off, val)
+#define enetc4_rxbdr_wr(hw, n, off, val) \
+				enetc4_bdr_wr(hw, RX, n, off, val)
+#endif
diff --git a/drivers/net/enetc/base/enetc_hw.h b/drivers/net/enetc/base/enetc_hw.h
index 66fad58e5e..95e01a466b 100644
--- a/drivers/net/enetc/base/enetc_hw.h
+++ b/drivers/net/enetc/base/enetc_hw.h
@@ -1,13 +1,13 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2020 NXP
+ * Copyright 2018-2024 NXP
  */
 
 #ifndef _ENETC_HW_H_
 #define _ENETC_HW_H_
 #include <rte_io.h>
+#include <ethdev_pci.h>
 
 #define BIT(x)		((uint64_t)1 << ((x)))
-
 /* ENETC device IDs */
 #define ENETC_DEV_ID_VF		0xef00
 #define ENETC_DEV_ID		0xe100
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 7163633bce..cd669171cb 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -1,13 +1,16 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2019 NXP
+ * Copyright 2018-2019,2024 NXP
  */
 
 #ifndef _ENETC_H_
 #define _ENETC_H_
 
 #include <rte_time.h>
+#include <ethdev_pci.h>
 
+#include "compat.h"
 #include "base/enetc_hw.h"
+#include "enetc_logs.h"
 
 #define PCI_VENDOR_ID_FREESCALE 0x1957
 
@@ -33,21 +36,11 @@
 #define ENETC_ETH_MAX_LEN (RTE_ETHER_MTU + \
 		RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN)
 
-/*
- * upper_32_bits - return bits 32-63 of a number
- * @n: the number we're accessing
- *
- * A basic shift-right of a 64- or 32-bit quantity.  Use this to suppress
- * the "right shift count >= width of type" warning when that quantity is
- * 32-bits.
- */
-#define upper_32_bits(n) ((uint32_t)(((n) >> 16) >> 16))
+/* eth name size */
+#define ENETC_ETH_NAMESIZE	20
 
-/*
- * lower_32_bits - return bits 0-31 of a number
- * @n: the number we're accessing
- */
-#define lower_32_bits(n) ((uint32_t)(n))
+/* size for marking hugepage non-cacheable */
+#define SIZE_2MB	0x200000
 
 #define ENETC_TXBD(BDR, i) (&(((struct enetc_tx_bd *)((BDR).bd_base))[i]))
 #define ENETC_RXBD(BDR, i) (&(((union enetc_rx_bd *)((BDR).bd_base))[i]))
@@ -96,6 +89,20 @@ struct enetc_eth_adapter {
 #define ENETC_DEV_PRIVATE_TO_INTR(adapter) \
 	(&((struct enetc_eth_adapter *)adapter)->intr)
 
+/*
+ * ENETC4 function prototypes
+ */
+int enetc4_pci_remove(struct rte_pci_device *pci_dev);
+int enetc4_dev_configure(struct rte_eth_dev *dev);
+int enetc4_dev_close(struct rte_eth_dev *dev);
+int enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
+			 struct rte_eth_dev_info *dev_info);
+
+/*
+ * enetc4_vf function prototype
+ */
+int enetc4_vf_dev_stop(struct rte_eth_dev *dev);
+
 /*
  * RX/TX ENETC function prototypes
  */
@@ -104,8 +111,9 @@ uint16_t enetc_xmit_pkts(void *txq, struct rte_mbuf **tx_pkts,
 uint16_t enetc_recv_pkts(void *rxq, struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts);
 
-
 int enetc_refill_rx_ring(struct enetc_bdr *rx_ring, const int buff_cnt);
+void enetc4_dev_hw_init(struct rte_eth_dev *eth_dev);
+void enetc_print_ethaddr(const char *name, const struct rte_ether_addr *eth_addr);
 
 static inline int
 enetc_bd_unused(struct enetc_bdr *bdr)
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
new file mode 100644
index 0000000000..b19e1fdbfa
--- /dev/null
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -0,0 +1,297 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2024 NXP
+ */
+
+#include <stdbool.h>
+#include <rte_random.h>
+#include <dpaax_iova_table.h>
+
+#include "base/enetc4_hw.h"
+#include "enetc_logs.h"
+#include "enetc.h"
+
+static int
+enetc4_dev_start(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t val;
+
+	PMD_INIT_FUNC_TRACE();
+
+	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(0));
+	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(0),
+		       val | PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
+
+	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(1));
+	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(1),
+		       val | PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN);
+
+	/* Enable port */
+	val = enetc4_port_rd(enetc_hw, ENETC4_PMR);
+	enetc4_port_wr(enetc_hw, ENETC4_PMR, val | ENETC4_PMR_EN);
+
+	/* Enable port transmit/receive */
+	enetc4_port_wr(enetc_hw, ENETC4_POR, 0);
+
+	return 0;
+}
+
+static int
+enetc4_dev_stop(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t val;
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* Disable port */
+	val = enetc4_port_rd(enetc_hw, ENETC4_PMR);
+	enetc4_port_wr(enetc_hw, ENETC4_PMR, val & (~ENETC4_PMR_EN));
+
+	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(0));
+	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(0),
+		      val & (~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN)));
+
+	val = enetc4_port_rd(enetc_hw, ENETC4_PM_CMD_CFG(1));
+	enetc4_port_wr(enetc_hw, ENETC4_PM_CMD_CFG(1),
+		      val & (~(PM_CMD_CFG_TX_EN | PM_CMD_CFG_RX_EN)));
+
+	return 0;
+}
+
+static int
+enetc4_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
+{
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t high_mac = 0;
+	uint16_t low_mac = 0;
+	char eth_name[ENETC_ETH_NAMESIZE];
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* Enabling Station Interface */
+	enetc4_wr(enetc_hw, ENETC_SIMR, ENETC_SIMR_EN);
+
+	high_mac = (uint32_t)enetc4_port_rd(enetc_hw, ENETC4_PSIPMAR0(0));
+	low_mac = (uint16_t)enetc4_port_rd(enetc_hw, ENETC4_PSIPMAR1(0));
+
+	if ((high_mac | low_mac) == 0) {
+		ENETC_PMD_NOTICE("MAC is not available for this SI, "
+				"set random MAC");
+		rte_eth_random_addr(hw->mac.addr);
+		high_mac = *(uint32_t *)hw->mac.addr;
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR0, high_mac);
+		low_mac = *(uint16_t *)(hw->mac.addr + 4);
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR1, low_mac);
+		enetc_print_ethaddr("New address: ",
+			      (const struct rte_ether_addr *)hw->mac.addr);
+	}
+
+	/* Allocate memory for storing MAC addresses */
+	snprintf(eth_name, sizeof(eth_name), "enetc4_eth_%d", eth_dev->data->port_id);
+	eth_dev->data->mac_addrs = rte_zmalloc(eth_name,
+					RTE_ETHER_ADDR_LEN, 0);
+	if (!eth_dev->data->mac_addrs) {
+		ENETC_PMD_ERR("Failed to allocate %d bytes needed to "
+			      "store MAC addresses",
+			      RTE_ETHER_ADDR_LEN * 1);
+		return -ENOMEM;
+	}
+
+	/* Copy the permanent MAC address */
+	rte_ether_addr_copy((struct rte_ether_addr *)hw->mac.addr,
+			&eth_dev->data->mac_addrs[0]);
+
+	return 0;
+}
+
+int
+enetc4_dev_infos_get(struct rte_eth_dev *dev __rte_unused,
+		    struct rte_eth_dev_info *dev_info)
+{
+	PMD_INIT_FUNC_TRACE();
+	dev_info->rx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = MAX_BD_COUNT,
+		.nb_min = MIN_BD_COUNT,
+		.nb_align = BD_ALIGN,
+	};
+	dev_info->tx_desc_lim = (struct rte_eth_desc_lim) {
+		.nb_max = MAX_BD_COUNT,
+		.nb_min = MIN_BD_COUNT,
+		.nb_align = BD_ALIGN,
+	};
+	dev_info->max_rx_queues = MAX_RX_RINGS;
+	dev_info->max_tx_queues = MAX_TX_RINGS;
+	dev_info->max_rx_pktlen = ENETC4_MAC_MAXFRM_SIZE;
+
+	return 0;
+}
+
+int
+enetc4_dev_close(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	int ret;
+
+	PMD_INIT_FUNC_TRACE();
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	if (hw->device_id == ENETC4_DEV_ID_VF)
+		ret = enetc4_vf_dev_stop(dev);
+	else
+		ret = enetc4_dev_stop(dev);
+
+	if (rte_eal_iova_mode() == RTE_IOVA_PA)
+		dpaax_iova_table_depopulate();
+
+	return ret;
+}
+
+int
+enetc4_dev_configure(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t max_len;
+	uint32_t val;
+
+	PMD_INIT_FUNC_TRACE();
+
+	max_len = dev->data->dev_conf.rxmode.mtu + RTE_ETHER_HDR_LEN +
+		  RTE_ETHER_CRC_LEN;
+	enetc4_port_wr(enetc_hw, ENETC4_PM_MAXFRM(0), ENETC_SET_MAXFRM(max_len));
+
+	val = ENETC4_MAC_MAXFRM_SIZE | SDU_TYPE_MPDU;
+	enetc4_port_wr(enetc_hw, ENETC4_PTCTMSDUR(0), val | SDU_TYPE_MPDU);
+
+	return 0;
+}
+
+
+
+/*
+ * The set of PCI devices this driver supports
+ */
+static const struct rte_pci_id pci_id_enetc4_map[] = {
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NXP, ENETC4_DEV_ID) },
+	{ .vendor_id = 0, /* sentinel */ },
+};
+
+/* Features supported by this driver */
+static const struct eth_dev_ops enetc4_ops = {
+	.dev_configure        = enetc4_dev_configure,
+	.dev_start            = enetc4_dev_start,
+	.dev_stop             = enetc4_dev_stop,
+	.dev_close            = enetc4_dev_close,
+	.dev_infos_get        = enetc4_dev_infos_get,
+};
+
+/*
+ * Storing the HW base addresses
+ *
+ * @param eth_dev
+ *   - Pointer to the structure rte_eth_dev
+ */
+void
+enetc4_dev_hw_init(struct rte_eth_dev *eth_dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+
+	eth_dev->rx_pkt_burst = &enetc_recv_pkts;
+	eth_dev->tx_pkt_burst = &enetc_xmit_pkts;
+
+	/* Retrieving and storing the HW base address of device */
+	hw->hw.reg = (void *)pci_dev->mem_resource[0].addr;
+	hw->device_id = pci_dev->id.device_id;
+
+	/* Calculating and storing the base HW addresses */
+	hw->hw.port = (void *)((size_t)hw->hw.reg + ENETC_PORT_BASE);
+	hw->hw.global = (void *)((size_t)hw->hw.reg + ENETC_GLOBAL_BASE);
+}
+
+/**
+ * Initialisation of the enetc4 device
+ *
+ * @param eth_dev
+ *   - Pointer to the structure rte_eth_dev
+ *
+ * @return
+ *   - On success, zero.
+ *   - On failure, negative value.
+ */
+
+static int
+enetc4_dev_init(struct rte_eth_dev *eth_dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	int error = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	eth_dev->dev_ops = &enetc4_ops;
+	enetc4_dev_hw_init(eth_dev);
+
+	error = enetc4_mac_init(hw, eth_dev);
+	if (error != 0) {
+		ENETC_PMD_ERR("MAC initialization failed");
+		return -1;
+	}
+
+	/* Set MTU */
+	enetc_port_wr(&hw->hw, ENETC4_PM_MAXFRM(0),
+		      ENETC_SET_MAXFRM(RTE_ETHER_MAX_LEN));
+	eth_dev->data->mtu = RTE_ETHER_MAX_LEN - RTE_ETHER_HDR_LEN -
+		RTE_ETHER_CRC_LEN;
+
+	if (rte_eal_iova_mode() == RTE_IOVA_PA)
+		dpaax_iova_table_populate();
+
+	ENETC_PMD_DEBUG("port_id %d vendorID=0x%x deviceID=0x%x",
+			eth_dev->data->port_id, pci_dev->id.vendor_id,
+			pci_dev->id.device_id);
+	return 0;
+}
+
+static int
+enetc4_dev_uninit(struct rte_eth_dev *eth_dev)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	return enetc4_dev_close(eth_dev);
+}
+
+static int
+enetc4_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
+			   struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_probe(pci_dev,
+					     sizeof(struct enetc_eth_adapter),
+					     enetc4_dev_init);
+}
+
+int
+enetc4_pci_remove(struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_remove(pci_dev, enetc4_dev_uninit);
+}
+
+static struct rte_pci_driver rte_enetc4_pmd = {
+	.id_table = pci_id_enetc4_map,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
+	.probe = enetc4_pci_probe,
+	.remove = enetc4_pci_remove,
+};
+
+RTE_PMD_REGISTER_PCI(net_enetc4, rte_enetc4_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_enetc4, pci_id_enetc4_map);
+RTE_PMD_REGISTER_KMOD_DEP(net_enetc4, "* vfio-pci");
+RTE_LOG_REGISTER_DEFAULT(enetc4_logtype_pmd, NOTICE);
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
new file mode 100644
index 0000000000..dc285688dc
--- /dev/null
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -0,0 +1,146 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2024 NXP
+ */
+
+#include <stdbool.h>
+#include <rte_random.h>
+#include <dpaax_iova_table.h>
+#include "base/enetc4_hw.h"
+#include "base/enetc_hw.h"
+#include "enetc_logs.h"
+#include "enetc.h"
+
+int
+enetc4_vf_dev_stop(struct rte_eth_dev *dev __rte_unused)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	return 0;
+}
+
+static int
+enetc4_vf_dev_start(struct rte_eth_dev *dev __rte_unused)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	return 0;
+}
+
+/*
+ * The set of PCI devices this driver supports
+ */
+static const struct rte_pci_id pci_vf_id_enetc4_map[] = {
+	{ RTE_PCI_DEVICE(PCI_VENDOR_ID_NXP, ENETC4_DEV_ID_VF) },
+	{ .vendor_id = 0, /* sentinel */ },
+};
+
+/* Features supported by this driver */
+static const struct eth_dev_ops enetc4_vf_ops = {
+	.dev_configure        = enetc4_dev_configure,
+	.dev_start            = enetc4_vf_dev_start,
+	.dev_stop             = enetc4_vf_dev_stop,
+	.dev_close            = enetc4_dev_close,
+	.dev_infos_get        = enetc4_dev_infos_get,
+};
+
+static int
+enetc4_vf_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
+{
+	uint32_t *mac = (uint32_t *)hw->mac.addr;
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t high_mac = 0;
+	uint16_t low_mac = 0;
+	char vf_eth_name[ENETC_ETH_NAMESIZE];
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* Enabling Station Interface */
+	enetc4_wr(enetc_hw, ENETC_SIMR, ENETC_SIMR_EN);
+	*mac = (uint32_t)enetc_rd(enetc_hw, ENETC_SIPMAR0);
+	high_mac = (uint32_t)*mac;
+	mac++;
+	*mac = (uint16_t)enetc_rd(enetc_hw, ENETC_SIPMAR1);
+	low_mac = (uint16_t)*mac;
+
+	if ((high_mac | low_mac) == 0) {
+		char *first_byte;
+		ENETC_PMD_NOTICE("MAC is not available for this SI, "
+				 "set random MAC");
+		mac = (uint32_t *)hw->mac.addr;
+		*mac = (uint32_t)rte_rand();
+		first_byte = (char *)mac;
+		*first_byte &= 0xfe;    /* clear multicast bit */
+		*first_byte |= 0x02;    /* set local assignment bit (IEEE802) */
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR0, *mac);
+		mac++;
+		*mac = (uint16_t)rte_rand();
+		enetc4_port_wr(enetc_hw, ENETC4_PMAR1, *mac);
+		enetc_print_ethaddr("New address: ",
+			(const struct rte_ether_addr *)hw->mac.addr);
+	}
+
+	/* Allocate memory for storing MAC addresses */
+	snprintf(vf_eth_name, sizeof(vf_eth_name), "enetc4_vf_eth_%d", eth_dev->data->port_id);
+	eth_dev->data->mac_addrs = rte_zmalloc(vf_eth_name,
+					RTE_ETHER_ADDR_LEN, 0);
+	if (!eth_dev->data->mac_addrs) {
+		ENETC_PMD_ERR("Failed to allocate %d bytes needed to "
+			      "store MAC addresses",
+			      RTE_ETHER_ADDR_LEN * 1);
+		return -ENOMEM;
+	}
+
+	/* Copy the permanent MAC address */
+	rte_ether_addr_copy((struct rte_ether_addr *)hw->mac.addr,
+			     &eth_dev->data->mac_addrs[0]);
+
+	return 0;
+}
+
+static int
+enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
+{
+	struct enetc_eth_hw *hw =
+			    ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	int error = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	eth_dev->dev_ops = &enetc4_vf_ops;
+	enetc4_dev_hw_init(eth_dev);
+
+	error = enetc4_vf_mac_init(hw, eth_dev);
+	if (error != 0) {
+		ENETC_PMD_ERR("MAC initialization failed!!");
+		return -1;
+	}
+
+	if (rte_eal_iova_mode() == RTE_IOVA_PA)
+		dpaax_iova_table_populate();
+
+	ENETC_PMD_DEBUG("port_id %d vendorID=0x%x deviceID=0x%x",
+			eth_dev->data->port_id, pci_dev->id.vendor_id,
+			pci_dev->id.device_id);
+	return 0;
+}
+
+static int
+enetc4_vf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
+		    struct rte_pci_device *pci_dev)
+{
+	return rte_eth_dev_pci_generic_probe(pci_dev,
+					     sizeof(struct enetc_eth_adapter),
+					     enetc4_vf_dev_init);
+}
+
+static struct rte_pci_driver rte_enetc4_vf_pmd = {
+	.id_table = pci_vf_id_enetc4_map,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
+	.probe = enetc4_vf_pci_probe,
+	.remove = enetc4_pci_remove,
+};
+
+RTE_PMD_REGISTER_PCI(net_enetc4_vf, rte_enetc4_vf_pmd);
+RTE_PMD_REGISTER_PCI_TABLE(net_enetc4_vf, pci_vf_id_enetc4_map);
+RTE_PMD_REGISTER_KMOD_DEP(net_enetc4_vf, "* uio_pci_generic");
+RTE_LOG_REGISTER_DEFAULT(enetc4_vf_logtype_pmd, NOTICE);
diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_ethdev.c
index ffbecc407c..498814cb13 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -1,9 +1,8 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2020 NXP
+ * Copyright 2018-2024 NXP
  */
 
 #include <stdbool.h>
-#include <ethdev_pci.h>
 #include <rte_random.h>
 #include <dpaax_iova_table.h>
 
@@ -145,8 +144,8 @@ enetc_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
 	return rte_eth_linkstatus_set(dev, &link);
 }
 
-static void
-print_ethaddr(const char *name, const struct rte_ether_addr *eth_addr)
+void
+enetc_print_ethaddr(const char *name, const struct rte_ether_addr *eth_addr)
 {
 	char buf[RTE_ETHER_ADDR_FMT_SIZE];
 
@@ -209,7 +208,7 @@ enetc_hardware_init(struct enetc_eth_hw *hw)
 		mac++;
 		*mac = (uint16_t)rte_rand();
 		enetc_port_wr(enetc_hw, ENETC_PSIPMAR1(0), *mac);
-		print_ethaddr("New address: ",
+		enetc_print_ethaddr("New address: ",
 			      (const struct rte_ether_addr *)hw->mac.addr);
 	}
 
diff --git a/drivers/net/enetc/meson.build b/drivers/net/enetc/meson.build
index 966dc694fc..6e00758a36 100644
--- a/drivers/net/enetc/meson.build
+++ b/drivers/net/enetc/meson.build
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2018 NXP
+# Copyright 2018,2024 NXP
 
 if not is_linux
     build = false
@@ -8,6 +8,8 @@ endif
 
 deps += ['common_dpaax']
 sources = files(
+	'enetc4_ethdev.c',
+	'enetc4_vf.c',
         'enetc_ethdev.c',
         'enetc_rxtx.c',
 )
-- 
2.25.1

