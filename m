Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A2DC369CB
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Apr 2025 16:02:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A06D40A87;
	Wed, 23 Apr 2025 18:00:33 +0200 (CEST)
Received: from agw.arknetworks.am (agw.arknetworks.am [79.141.165.80])
 by mails.dpdk.org (Postfix) with ESMTP id 03DC640687
 for <dev@dpdk.org>; Wed, 23 Apr 2025 18:00:28 +0200 (CEST)
Received: from localhost.localdomain (unknown [78.109.72.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by agw.arknetworks.am (Postfix) with ESMTPSA id F109EE013F;
 Wed, 23 Apr 2025 20:00:25 +0400 (+04)
DKIM-Filter: OpenDKIM Filter v2.11.0 agw.arknetworks.am F109EE013F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arknetworks.am;
 s=default; t=1745424027;
 bh=D+s7cSpqXlqqK3liBkMrTgAmEcumKk5nZ34hSLfkTgI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=h/0fzuT93jncB8qBKS8Y8f8JRBU9dj4cel5nZ1rOhx/j5tGfts4k374ht1bGuJIXk
 9cGIAXxp+5+Fon9FZR+JSj36IHZKW8tKAZs4bgVXSxQhJhBfOTR9ZW50K8zslhBAb2
 l0Wo5kx6HcXu9XYVGpM9KsViva6CN/romhNz5A0G9UxXA1SH9MvBAeK4tHxGd8QH6i
 GG34WlO9jXO6NVeWu7a8qdZZBqoTSN7lzR1wi1kY/btRTAPXje7SbL5hOH/z+EB2Y6
 ngQcc341v9niTUEeBwaQheZi49s+/hOM72BCxTbHjE3pfeyBMIpTNY549Phi+8qs0u
 pheYShiZUKlfg==
From: Ivan Malov <ivan.malov@arknetworks.am>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Andy Moreton <andy.moreton@amd.com>,
 Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Viacheslav Galaktionov <viacheslav.galaktionov@arknetworks.am>
Subject: [PATCH v2 18/45] common/sfc_efx/base: update MCDI headers
Date: Wed, 23 Apr 2025 19:59:35 +0400
Message-Id: <20250423160002.35706-19-ivan.malov@arknetworks.am>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250423160002.35706-1-ivan.malov@arknetworks.am>
References: <20250416140016.36127-1-ivan.malov@arknetworks.am>
 <20250423160002.35706-1-ivan.malov@arknetworks.am>
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

Pick up new X4 network port MCDI defines.

Signed-off-by: Ivan Malov <ivan.malov@arknetworks.am>
Reviewed-by: Andy Moreton <andy.moreton@amd.com>
Reviewed-by: Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
---
 .mailmap                                    |    1 +
 drivers/common/sfc_efx/base/efx_regs_mcdi.h | 5868 ++++++++++++++++++-
 2 files changed, 5816 insertions(+), 53 deletions(-)

diff --git a/.mailmap b/.mailmap
index baad1ebaf1..52f3a197ac 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1208,6 +1208,7 @@ Phil Yang <phil.yang@arm.com>
 Philip Prindeville <philipp@redfish-solutions.com>
 Pier Damouny <pdamouny@nvidia.com>
 Pierre Pfister <ppfister@cisco.com>
+Pieter Jansen Van Vuuren <pieter.jansen-van-vuuren@amd.com>
 Piotr Azarewicz <piotr.azarewicz@intel.com> <piotrx.t.azarewicz@intel.com>
 Piotr Bartosiewicz <piotr.bartosiewicz@atendesoftware.pl>
 Piotr Bronowski <piotrx.bronowski@intel.com>
diff --git a/drivers/common/sfc_efx/base/efx_regs_mcdi.h b/drivers/common/sfc_efx/base/efx_regs_mcdi.h
index 41751344b4..a981d0be5e 100644
--- a/drivers/common/sfc_efx/base/efx_regs_mcdi.h
+++ b/drivers/common/sfc_efx/base/efx_regs_mcdi.h
@@ -408,6 +408,12 @@
  */
 #define	MC_CMD_ERR_PIOBUFS_PRESENT 0x101b
 
+/* PORT_DIRECTION enum: Traffic direction for the port configuration APIs. */
+/* enum: Receive */
+#define	PORT_DIRECTION_RX 0x0
+/* enum: Transmit */
+#define	PORT_DIRECTION_TX 0x1
+
 /* MC_CMD_RESOURCE_SPECIFIER enum */
 /* enum: Any */
 #define	MC_CMD_RESOURCE_INSTANCE_ANY 0xffffffff
@@ -445,6 +451,14 @@
  * an on-NIC ARM module is expected to be connected.
  */
 #define	PCIE_INTERFACE_NIC_EMBEDDED 0x1
+/* enum: The PCIe logical interface 0. It is an alias for HOST_PRIMARY. */
+#define	PCIE_INTERFACE_PCIE_HOST_INTF_0 0x0
+/* enum: The PCIe logical interface 1. */
+#define	PCIE_INTERFACE_PCIE_HOST_INTF_1 0x2
+/* enum: The PCIe logical interface 2. */
+#define	PCIE_INTERFACE_PCIE_HOST_INTF_2 0x3
+/* enum: The PCIe logical interface 3. */
+#define	PCIE_INTERFACE_PCIE_HOST_INTF_3 0x4
 /* enum: For MCDI commands issued over a PCIe interface, this value is
  * translated into the interface over which the command was issued. Not
  * meaningful for other MCDI transports.
@@ -682,6 +696,53 @@
  */
 #define	MAE_COUNTER_ID_NULL 0xffffffff
 
+/* PR_METADATA_ITEM_CATEGORY enum: Meta-data item category */
+/* enum: A XCLBIN meta-data section */
+#define	PR_METADATA_ITEM_CATEGORY_SECTION 0x0
+/* enum: The active XCLBIN's UUID (axlf_header::uuid) */
+#define	PR_METADATA_ITEM_CATEGORY_UUID 0x1
+/* enum: The active XCLBIN's timestamp (axlf_header::m_timeStamp) */
+#define	PR_METADATA_ITEM_CATEGORY_TIMESTAMP 0x2
+/* enum: The active XCLBIN's signature (the last axlf::m_signature_length bytes
+ * of the XCLBIN data)
+ */
+#define	PR_METADATA_ITEM_CATEGORY_SIGNATURE 0x3
+
+/* PR_METADATA_ITEM_SUBCATEGORY enum: Meta-data item sub-category. For the
+ * SECTION category the subcategory matches AXLF section type identifiers (enum
+ * axlf_section_kind) and each subcategory contains an array of items as the
+ * AXLF container format supports multiple sections of the same type. Other
+ * categories (UUID, TIMESTAMP and SIGNATURE) do not currently use
+ * subcategories and must be 0 (NONE).
+ */
+#define	PR_METADATA_ITEM_SUBCATEGORY_NONE 0x0 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_BITSTREAM 0x0 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_CLEARING_BITSTREAM 0x1 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_EMBEDDED_METADATA 0x2 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_FIRMWARE 0x3 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_DEBUG_DATA 0x4 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_SCHED_FIRMWARE 0x5 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_MEM_TOPOLOGY 0x6 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_CONNECTIVITY 0x7 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_IP_LAYOUT 0x8 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_DEBUG_IP_LAYOUT 0x9 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_DESIGN_CHECK_POINT 0xa /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_CLOCK_FREQ_TOPOLOGY 0xb /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_MCS 0xc /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_BMC 0xd /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_BUILD_METADATA 0xe /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_KEYVALUE_METADATA 0xf /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_USER_METADATA 0x10 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_DNA_CERTIFICATE 0x11 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_PDI 0x12 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_BITSTREAM_PARTIAL_PDI 0x13 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_PARTITION_METADATA 0x14 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_EMULATION_DATA 0x15 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_SYSTEM_METADATA 0x16 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_SOFT_KERNEL 0x17 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_ASK_FLASH 0x18 /* enum */
+#define	PR_METADATA_ITEM_SUBCATEGORY_AIE_METADATA 0x19 /* enum */
+
 /* TABLE_ID enum: Unique IDs for tables. The 32-bit ID values have been
  * structured with bits [31:24] reserved (0), [23:16] indicating which major
  * block the tables belongs to (0=VNIC TX, none currently; 1=MAE; 2=VNIC RX),
@@ -1241,10 +1302,7 @@
 #define	TABLE_FIELD_ID_CRC_REFOUT 0x3f4
 /* enum: If set, invert every bit of the output value. */
 #define	TABLE_FIELD_ID_CRC_INVOUT 0x3f5
-/* enum: The CRC polynomial to use for checksumming, in normal form. See
- * https://en.wikipedia.org/wiki/Cyclic_redundancy_check#Specification for a
- * description of normal form.
- */
+/* enum: The CRC polynomial to use for checksumming, in normal form. */
 #define	TABLE_FIELD_ID_CRC_POLY 0x3f6
 /* enum: Operation for the checksum engine to perform - see DPU_CSUM_OP enum.
  */
@@ -1335,6 +1393,24 @@
 #define	MCDI_EVENT_LINKCHANGE_LINK_FLAGS_OFST 0
 #define	MCDI_EVENT_LINKCHANGE_LINK_FLAGS_LBN 24
 #define	MCDI_EVENT_LINKCHANGE_LINK_FLAGS_WIDTH 8
+#define	MCDI_EVENT_PORT_LINKCHANGE_PORT_HANDLE_OFST 0
+#define	MCDI_EVENT_PORT_LINKCHANGE_PORT_HANDLE_LBN 0
+#define	MCDI_EVENT_PORT_LINKCHANGE_PORT_HANDLE_WIDTH 24
+#define	MCDI_EVENT_PORT_LINKCHANGE_SEQ_NUM_OFST 0
+#define	MCDI_EVENT_PORT_LINKCHANGE_SEQ_NUM_LBN 24
+#define	MCDI_EVENT_PORT_LINKCHANGE_SEQ_NUM_WIDTH 7
+#define	MCDI_EVENT_PORT_LINKCHANGE_LINK_UP_OFST 0
+#define	MCDI_EVENT_PORT_LINKCHANGE_LINK_UP_LBN 31
+#define	MCDI_EVENT_PORT_LINKCHANGE_LINK_UP_WIDTH 1
+#define	MCDI_EVENT_PORT_MODULECHANGE_PORT_HANDLE_OFST 0
+#define	MCDI_EVENT_PORT_MODULECHANGE_PORT_HANDLE_LBN 0
+#define	MCDI_EVENT_PORT_MODULECHANGE_PORT_HANDLE_WIDTH 24
+#define	MCDI_EVENT_PORT_MODULECHANGE_SEQ_NUM_OFST 0
+#define	MCDI_EVENT_PORT_MODULECHANGE_SEQ_NUM_LBN 24
+#define	MCDI_EVENT_PORT_MODULECHANGE_SEQ_NUM_WIDTH 7
+#define	MCDI_EVENT_PORT_MODULECHANGE_MDI_CONNECTED_OFST 0
+#define	MCDI_EVENT_PORT_MODULECHANGE_MDI_CONNECTED_LBN 31
+#define	MCDI_EVENT_PORT_MODULECHANGE_MDI_CONNECTED_WIDTH 1
 #define	MCDI_EVENT_SENSOREVT_MONITOR_OFST 0
 #define	MCDI_EVENT_SENSOREVT_MONITOR_LBN 0
 #define	MCDI_EVENT_SENSOREVT_MONITOR_WIDTH 8
@@ -1709,6 +1785,25 @@
  * VI ID.
  */
 #define	MCDI_EVENT_CODE_DESC_PROXY_FUNC_QUEUE_START 0x28
+/* enum: Notification of a change in link state and/or link speed of a network
+ * port link. This event applies to a network port identified by a handle,
+ * PORT_HANDLE, which is discovered by the driver using the MC_CMD_ENUM_PORTS
+ * command.
+ */
+#define	MCDI_EVENT_CODE_PORT_LINKCHANGE 0x29
+/* enum: Notification of a change in the state of an MDI (external connector)
+ * of a network port. This typically corresponds to module plug/unplug for
+ * modular interfaces (e.g., SFP/QSFP and similar) or cable connect/disconnect.
+ * This event applies to a network port identified by a handle, PORT_HANDLE,
+ * which is discovered by the driver using the MC_CMD_ENUM_PORTS command.
+ */
+#define	MCDI_EVENT_CODE_PORT_MODULECHANGE 0x2a
+/* enum: Notification that the port enumeration journal has changed since it
+ * was last read and updates can be read using the MC_CMD_ENUM_PORTS command.
+ * The firmware may moderate the events so that an event is not sent for every
+ * change to the journal.
+ */
+#define	MCDI_EVENT_CODE_ENUM_PORTS_CHANGE 0x2b
 /* enum: Artificial event generated by host and posted via MC for test
  * purposes.
  */
@@ -1721,6 +1816,14 @@
 #define	MCDI_EVENT_LINKCHANGE_DATA_LEN 4
 #define	MCDI_EVENT_LINKCHANGE_DATA_LBN 0
 #define	MCDI_EVENT_LINKCHANGE_DATA_WIDTH 32
+#define	MCDI_EVENT_PORT_LINKCHANGE_DATA_OFST 0
+#define	MCDI_EVENT_PORT_LINKCHANGE_DATA_LEN 4
+#define	MCDI_EVENT_PORT_LINKCHANGE_DATA_LBN 0
+#define	MCDI_EVENT_PORT_LINKCHANGE_DATA_WIDTH 32
+#define	MCDI_EVENT_PORT_MODULECHANGE_DATA_OFST 0
+#define	MCDI_EVENT_PORT_MODULECHANGE_DATA_LEN 4
+#define	MCDI_EVENT_PORT_MODULECHANGE_DATA_LBN 0
+#define	MCDI_EVENT_PORT_MODULECHANGE_DATA_WIDTH 32
 #define	MCDI_EVENT_SENSOREVT_DATA_OFST 0
 #define	MCDI_EVENT_SENSOREVT_DATA_LEN 4
 #define	MCDI_EVENT_SENSOREVT_DATA_LBN 0
@@ -3302,8 +3405,11 @@
  * subscribers.
  */
 #define	MC_CMD_PTP_OP_SET_SYNC_STATUS 0x1b
-/* enum: Above this for future use. */
-#define	MC_CMD_PTP_OP_MAX 0x1c
+/* enum: X4 and later adapters should use this instead of
+ * PTP_OP_TIME_EVENT_SUBSCRIBE. Subscribe to receive periodic time events
+ * indicating the current NIC time
+ */
+#define	MC_CMD_PTP_OP_TIME_EVENT_SUBSCRIBE_V2 0x1c
 
 /* MC_CMD_PTP_IN_ENABLE msgrequest */
 #define	MC_CMD_PTP_IN_ENABLE_LEN 16
@@ -3744,6 +3850,22 @@
 #define	MC_CMD_PTP_IN_TIME_EVENT_UNSUBSCRIBE_QUEUE_OFST 12
 #define	MC_CMD_PTP_IN_TIME_EVENT_UNSUBSCRIBE_QUEUE_LEN 4
 
+/* MC_CMD_PTP_IN_TIME_EVENT_SUBSCRIBE_V2 msgrequest */
+#define	MC_CMD_PTP_IN_TIME_EVENT_SUBSCRIBE_V2_LEN 16
+/*            MC_CMD_PTP_IN_CMD_OFST 0 */
+/*            MC_CMD_PTP_IN_CMD_LEN 4 */
+/*            MC_CMD_PTP_IN_PERIPH_ID_OFST 4 */
+/*            MC_CMD_PTP_IN_PERIPH_ID_LEN 4 */
+/* Event queue ID */
+#define	MC_CMD_PTP_IN_TIME_EVENT_SUBSCRIBE_V2_QUEUE_ID_OFST 8
+#define	MC_CMD_PTP_IN_TIME_EVENT_SUBSCRIBE_V2_QUEUE_ID_LEN 4
+/* Space for flags. */
+#define	MC_CMD_PTP_IN_TIME_EVENT_SUBSCRIBE_V2_FLAGS_OFST 12
+#define	MC_CMD_PTP_IN_TIME_EVENT_SUBSCRIBE_V2_FLAGS_LEN 4
+#define	MC_CMD_PTP_IN_TIME_EVENT_SUBSCRIBE_V2_REPORT_SYNC_STATUS_OFST 12
+#define	MC_CMD_PTP_IN_TIME_EVENT_SUBSCRIBE_V2_REPORT_SYNC_STATUS_LBN 31
+#define	MC_CMD_PTP_IN_TIME_EVENT_SUBSCRIBE_V2_REPORT_SYNC_STATUS_WIDTH 1
+
 /* MC_CMD_PTP_IN_MANFTEST_PPS msgrequest */
 #define	MC_CMD_PTP_IN_MANFTEST_PPS_LEN 12
 /*            MC_CMD_PTP_IN_CMD_OFST 0 */
@@ -6262,13 +6384,837 @@
 #define	FEC_TYPE_TYPE_LEN 4
 /* enum: No FEC */
 #define	MC_CMD_FEC_NONE 0x0
-/* enum: Clause 74 BASE-R FEC (a.k.a Firecode) */
+/* enum: IEEE 802.3, Clause 74 BASE-R FEC (a.k.a Firecode) */
 #define	MC_CMD_FEC_BASER 0x1
-/* enum: Clause 91/Clause 108 Reed-Solomon FEC */
+/* enum: IEEE 802.3, Clause 91/Clause 108 Reed-Solomon FEC */
 #define	MC_CMD_FEC_RS 0x2
+/* enum: IEEE 802.3, Clause 161, interleaved RS-FEC sublayer for 100GBASE-R
+ * PHYs
+ */
+#define	MC_CMD_FEC_IEEE_RS_INT 0x3
+/* enum: Ethernet Consortium, Low Latency RS-FEC. RS(272, 258). Replaces FEC
+ * specified in Clause 119 for 100/200G PHY. Replaces FEC specified in Clause
+ * 134 for 50G PHY.
+ */
+#define	MC_CMD_FEC_ETCS_RS_LL 0x4
+/* enum: FEC mode selected automatically */
+#define	MC_CMD_FEC_AUTO 0x5
 #define	FEC_TYPE_TYPE_LBN 0
 #define	FEC_TYPE_TYPE_WIDTH 32
 
+/* MC_CMD_ETH_TECH structuredef: Ethernet technology as defined by IEEE802.3,
+ * Ethernet Technology Consortium, proprietary technologies. The driver must
+ * not use technologies labelled NONE and AUTO.
+ */
+#define	MC_CMD_ETH_TECH_LEN 16
+/* The enums in this field can be used either as bitwise indices into a tech
+ * mask (e.g. see MC_CMD_ETH_AN_FIELDS/TECH_MASK for example) or as regular
+ * enums (e.g. see MC_CMD_LINK_CTRL_IN/ADVERTISED_TECH_ABILITIES_MASK). This
+ * structure must be updated to add new technologies when projects that need
+ * them arise. An incomplete list of possible expansion in the future include:
+ * 100GBASE_KP4, 800GBASE_CR8, 800GBASE_KR8, 800GBASE_DR8, 800GBASE_SR8
+ * 800GBASE_VR8
+ */
+#define	MC_CMD_ETH_TECH_TECH_OFST 0
+#define	MC_CMD_ETH_TECH_TECH_LEN 16
+/* enum: 1000BASE-KX - 1000BASE-X PCS/PMA over an electrical backplane PMD. See
+ * IEEE 802.3 Clause 70
+ */
+#define	MC_CMD_ETH_TECH_1000BASEKX 0x0
+/* enum: 10GBASE-R - PCS/PMA over an electrical backplane PMD. Refer to IEEE
+ * 802.3 Clause 72
+ */
+#define	MC_CMD_ETH_TECH_10GBASE_KR 0x1
+/* enum: 40GBASE-R PCS/PMA over an electrical backplane PMD. See IEEE 802.3
+ * Clause 84.
+ */
+#define	MC_CMD_ETH_TECH_40GBASE_KR4 0x2
+/* enum: 40GBASE-R PCS/PMA over 4 lane shielded copper balanced cable PMD. See
+ * IEEE 802.3 Clause 85
+ */
+#define	MC_CMD_ETH_TECH_40GBASE_CR4 0x3
+/* enum: 40GBASE-R PCS/PMA over 4 lane multimode fiber PMD as specified in
+ * Clause 86
+ */
+#define	MC_CMD_ETH_TECH_40GBASE_SR4 0x4
+/* enum: 40GBASE-R PCS/PMA over 4 WDM lane single mode fiber PMD with long
+ * reach. See IEEE 802.3 Clause 87
+ */
+#define	MC_CMD_ETH_TECH_40GBASE_LR4 0x5
+/* enum: 25GBASE-R PCS/PMA over shielded balanced copper cable PMD. See IEEE
+ * 802.3 Clause 110
+ */
+#define	MC_CMD_ETH_TECH_25GBASE_CR 0x6
+/* enum: 25GBASE-R PCS/PMA over an electrical backplane PMD. See IEEE 802.3
+ * Clause 111
+ */
+#define	MC_CMD_ETH_TECH_25GBASE_KR 0x7
+/* enum: 25GBASE-R PCS/PMA over multimode fiber PMD. Refer to IEEE 802.3 Clause
+ * 112
+ */
+#define	MC_CMD_ETH_TECH_25GBASE_SR 0x8
+/* enum: An Ethernet Physical layer operating at 50 Gb/s on twin-axial copper
+ * cable. Refer to Ethernet Technology Consortium 25/50G Ethernet Spec.
+ */
+#define	MC_CMD_ETH_TECH_50GBASE_CR2 0x9
+/* enum: An Ethernet Physical layer operating at 50 Gb/s on copper backplane.
+ * Refer to Ethernet Technology Consortium 25/50G Ethernet Spec.
+ */
+#define	MC_CMD_ETH_TECH_50GBASE_KR2 0xa
+/* enum: 100GBASE-R PCS/PMA over an electrical backplane PMD. See IEEE 802.3
+ * Clause 93
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_KR4 0xb
+/* enum: 100GBASE-R PCS/PMA over 4 lane multimode fiber PMD. See IEEE 802.3
+ * Clause 95
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_SR4 0xc
+/* enum: 100GBASE-R PCS/PMA over 4 lane shielded copper balanced cable PMD. See
+ * IEEE 802.3 Clause 92
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_CR4 0xd
+/* enum: 100GBASE-R PCS/PMA over 4 WDM lane single mode fiber PMD, with
+ * long/extended reach,. See IEEE 802.3 Clause 88
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_LR4_ER4 0xe
+/* enum: An Ethernet Physical layer operating at 50 Gb/s on short reach fiber.
+ * Refer to Ethernet Technology Consortium 25/50G Ethernet Spec.
+ */
+#define	MC_CMD_ETH_TECH_50GBASE_SR2 0xf
+/* enum: 1000BASEX PCS/PMA. See IEEE 802.3 Clause 36 over undefined PMD, duplex
+ * mode unknown
+ */
+#define	MC_CMD_ETH_TECH_1000BASEX 0x10
+/* enum: Non-standardised. 10G direct attach */
+#define	MC_CMD_ETH_TECH_10GBASE_CR 0x11
+/* enum: 10GBASE-SR fiber over 850nm optics. See IEEE 802.3 Clause 52 */
+#define	MC_CMD_ETH_TECH_10GBASE_SR 0x12
+/* enum: 10GBASE-LR fiber over 1310nm optics. See IEEE 802.3 Clause 52 */
+#define	MC_CMD_ETH_TECH_10GBASE_LR 0x13
+/* enum: 10GBASE-LRM fiber over 1310 nm optics. See IEEE 802.3 Clause 68 */
+#define	MC_CMD_ETH_TECH_10GBASE_LRM 0x14
+/* enum: 10GBASE-ER fiber over 1550nm optics. See IEEE 802.3 Clause 52 */
+#define	MC_CMD_ETH_TECH_10GBASE_ER 0x15
+/* enum: 50GBASE-R PCS/PMA over an electrical backplane PMD. See IEEE 802.3
+ * Clause 137
+ */
+#define	MC_CMD_ETH_TECH_50GBASE_KR 0x16
+/* enum: 50GBASE-SR PCS/PMA over multimode fiber PMD as specified in Clause 138
+ */
+#define	MC_CMD_ETH_TECH_50GBASE_SR 0x17
+/* enum: 50GBASE-CR PCS/PMA over shielded copper balanced cable PMD. See IEEE
+ * 802.3 Clause 136
+ */
+#define	MC_CMD_ETH_TECH_50GBASE_CR 0x18
+/* enum: 50GBASE-R PCS/PMA over single mode fiber PMD as specified in Clause
+ * 139.
+ */
+#define	MC_CMD_ETH_TECH_50GBASE_LR_ER_FR 0x19
+/* enum: 100 Gb/s PHY using 100GBASE-R encoding over single-mode fiber with
+ * reach up to at least 500 m (see IEEE 802.3 Clause 140)
+ */
+#define	MC_CMD_ETH_TECH_50GBASE_DR 0x1a
+/* enum: 100GBASE-R PCS/PMA over an electrical backplane PMD. See IEEE 802.3
+ * Clause 137
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_KR2 0x1b
+/* enum: 100GBASE-R PCS/PMA over 2 lane multimode fiber PMD. See IEEE 802.3
+ * Clause 138
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_SR2 0x1c
+/* enum: 100GBASE-R PCS/PMA over 2 lane shielded copper balanced cable PMD. See
+ * IEEE 802.3 Clause 136
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_CR2 0x1d
+/* enum: Unknown source */
+#define	MC_CMD_ETH_TECH_100GBASE_LR2_ER2_FR2 0x1e
+/* enum: Unknown source */
+#define	MC_CMD_ETH_TECH_100GBASE_DR2 0x1f
+/* enum: 200GBASE-R PCS/PMA over an electrical backplane PMD. See IEEE 802.3
+ * Clause 137
+ */
+#define	MC_CMD_ETH_TECH_200GBASE_KR4 0x20
+/* enum: 200GBASE-R PCS/PMA over 4 lane multimode fiber PMD. See IEEE 802.3
+ * Clause 138
+ */
+#define	MC_CMD_ETH_TECH_200GBASE_SR4 0x21
+/* enum: 200GBASE-R PCS/PMA over 4 WDM lane single-mode fiber PMD as specified
+ * in Clause 122
+ */
+#define	MC_CMD_ETH_TECH_200GBASE_LR4_ER4_FR4 0x22
+/* enum: 200GBASE-R PCS/PMA over 4-lane single-mode fiber PMD. See IEEE 802.3
+ * Clause 121
+ */
+#define	MC_CMD_ETH_TECH_200GBASE_DR4 0x23
+/* enum: 200GBASE-R PCS/PMA over 4 lane shielded copper balanced cable PMD as
+ * specified in Clause 136
+ */
+#define	MC_CMD_ETH_TECH_200GBASE_CR4 0x24
+/* enum: Ethernet Technology Consortium 400G AN Spec. 400GBASE-KR8 PMD uses
+ * 802.3 Clause 137, but the number PMD lanes is 8.
+ */
+#define	MC_CMD_ETH_TECH_400GBASE_KR8 0x25
+/* enum: 400GBASE-R PCS/PMA over 8-lane multimode fiber PMD. See IEEE 802.3
+ * Clause 138
+ */
+#define	MC_CMD_ETH_TECH_400GBASE_SR8 0x26
+/* enum: 400GBASE-R PCS/PMA over 8 WDM lane single-mode fiber PMD. See IEEE
+ * 802.3 Clause 122
+ */
+#define	MC_CMD_ETH_TECH_400GBASE_LR8_ER8_FR8 0x27
+/* enum: Unknown source */
+#define	MC_CMD_ETH_TECH_400GBASE_DR8 0x28
+/* enum: Ethernet Technology Consortium 400G AN Spec. 400GBASE-CR8 PMD uses
+ * IEEE 802.3 Clause 136, but the number PMD lanes is 8.
+ */
+#define	MC_CMD_ETH_TECH_400GBASE_CR8 0x29
+/* enum: 100GBASE-R PCS/PMA over an electrical backplane PMD. See IEEE 802.3ck
+ * Clause 163.
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_KR 0x2a
+/* enum: IEEE 802.3ck. 100G PHY with PMD as specified in Clause 167 over short
+ * reach fiber
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_SR 0x2b
+/* enum: 100G PMD together with single-mode fiber medium. See IEEE 802.3 Clause
+ * 140
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_LR_ER_FR 0x2c
+/* enum: 100GBASE-R PCS/PMA over shielded balanced copper cable PMD. See IEEE
+ * 802.3 in Clause 162 IEEE 802.3ck.
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_CR 0x2d
+/* enum: 100G PMD together with single-mode fiber medium. See IEEE 802.3 Clause
+ * 140
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_DR 0x2e
+/* enum: 200GBASE-R PCS/PMA over an electrical backplane PMD as specified in
+ * Clause 163 IEEE 802.3ck
+ */
+#define	MC_CMD_ETH_TECH_200GBASE_KR2 0x2f
+/* enum: 200G PHY with PMD as specified in Clause 167 over short reach fiber
+ * IEEE 802.3ck
+ */
+#define	MC_CMD_ETH_TECH_200GBASE_SR2 0x30
+/* enum: Unknown source */
+#define	MC_CMD_ETH_TECH_200GBASE_LR2_ER2_FR2 0x31
+/* enum: Unknown source */
+#define	MC_CMD_ETH_TECH_200GBASE_DR2 0x32
+/* enum: 200GBASE-R PCS/PMA over 2 lane shielded balanced copper cable PMD as
+ * specified in Clause 162 IEEE 802.3ck.
+ */
+#define	MC_CMD_ETH_TECH_200GBASE_CR2 0x33
+/* enum: 400GBASE-R PCS/PMA over an electrical backplane PMD. See IEEE 802.3
+ * Clause 163 IEEE 802.3ck.
+ */
+#define	MC_CMD_ETH_TECH_400GBASE_KR4 0x34
+/* enum: 400G PHY with PMD over short reach fiber. See Clause 167 of IEEE
+ * 802.3ck.
+ */
+#define	MC_CMD_ETH_TECH_400GBASE_SR4 0x35
+/* enum: 400GBASE-R PCS/PMA over 4 WDM lane single-mode fiber PMD. See IEEE
+ * 802.3 Clause 151
+ */
+#define	MC_CMD_ETH_TECH_400GBASE_LR4_ER4_FR4 0x36
+/* enum: 400GBASE-R PCS/PMA over 4-lane single-mode fiber PMD as specified in
+ * Clause 124
+ */
+#define	MC_CMD_ETH_TECH_400GBASE_DR4 0x37
+/* enum: 400GBASE-R PCS/PMA over 4 lane shielded balanced copper cable PMD as
+ * specified in Clause 162 of IEEE 802.3ck.
+ */
+#define	MC_CMD_ETH_TECH_400GBASE_CR4 0x38
+/* enum: Automatic tech mode. The driver must not use this. */
+#define	MC_CMD_ETH_TECH_AUTO 0x39
+/* enum: See IEEE 802.3cc-2017 Clause 114 */
+#define	MC_CMD_ETH_TECH_25GBASE_LR_ER 0x3a
+/* enum: Up to 7 m over twinaxial copper cable assembly (10 lanes, 10 Gbit/s
+ * each) See IEEE 802.3ba-2010 Clause 85
+ */
+#define	MC_CMD_ETH_TECH_100GBASE_CR10 0x3b
+/* enum: Invalid tech mode. The driver must not use this. */
+#define	MC_CMD_ETH_TECH_NONE 0x7f
+#define	MC_CMD_ETH_TECH_TECH_LBN 0
+#define	MC_CMD_ETH_TECH_TECH_WIDTH 128
+
+/* MC_CMD_LINK_STATUS_FLAGS structuredef */
+#define	MC_CMD_LINK_STATUS_FLAGS_LEN 8
+/* Flags used to report the current configuration/state of the link. */
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_OFST 0
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_LEN 8
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_LO_OFST 0
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_LO_LEN 4
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_LO_LBN 0
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_LO_WIDTH 32
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_HI_OFST 4
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_HI_LEN 4
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_HI_LBN 32
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_HI_WIDTH 32
+/* enum property: bitshift */
+/* enum: Whether we have overall link up */
+#define	MC_CMD_LINK_STATUS_FLAGS_LINK_UP 0x0
+/* enum: If set, the PHY has no external RX link synchronisation */
+#define	MC_CMD_LINK_STATUS_FLAGS_NO_PHY_LINK 0x1
+/* enum: If set, PMD/MDI is not connected (e.g. cable disconnected, module cage
+ * empty)
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_PMD_MDI_DISCONNECTED 0x2
+/* enum: Set on error while decoding module data (e.g. module EEPROM does not
+ * contain valid values, has checksum errors, etc.)
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_PMD_BAD 0x3
+/* enum: Set when module unsupported (e.g. unsupported link rate or link
+ * technology)
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_PMD_UNSUPPORTED 0x4
+/* enum: Set on error while communicating with the module (e.g. I2C errors
+ * while reading EEPROM)
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_PMD_COMMS_FAULT 0x5
+/* enum: Set on module overcurrent/overvoltage condition */
+#define	MC_CMD_LINK_STATUS_FLAGS_PMD_POWER_FAULT 0x6
+/* enum: Set on module overtemperature condition */
+#define	MC_CMD_LINK_STATUS_FLAGS_PMD_THERMAL_FAULT 0x7
+/* enum: If set, the module is indicating Loss of Signal */
+#define	MC_CMD_LINK_STATUS_FLAGS_PMD_LOS 0x8
+/* enum: If set, PMA is indicating loss of CDR lock (clock sync) */
+#define	MC_CMD_LINK_STATUS_FLAGS_PMA_NO_CDR_LOCK 0x9
+/* enum: If set, PMA is indicating loss of analog signal */
+#define	MC_CMD_LINK_STATUS_FLAGS_PMA_LOS 0xa
+/* enum: If set, PCS is indicating loss of block lock */
+#define	MC_CMD_LINK_STATUS_FLAGS_PCS_NO_BLOCK_LOCK 0xb
+/* enum: If set, PCS is indicating loss of alignment marker lock on one or more
+ * lanes
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_PCS_NO_AM_LOCK 0xc
+/* enum: If set, PCS is indicating loss of overall alignment lock */
+#define	MC_CMD_LINK_STATUS_FLAGS_PCS_NO_ALIGN_LOCK 0xd
+/* enum: If set, PCS is indicating high bit error rate condition. */
+#define	MC_CMD_LINK_STATUS_FLAGS_PCS_HI_BER 0xe
+/* enum: If set, FEC is indicating loss of FEC lock */
+#define	MC_CMD_LINK_STATUS_FLAGS_FEC_NO_LOCK 0xf
+/* enum: If set, indicates that the number of symbol errors in a 8192-codeword
+ * window has exceeded the threshold K (417).
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_FEC_HI_SER 0x10
+/* enum: If set, the receiver has detected the local FEC has degraded. */
+#define	MC_CMD_LINK_STATUS_FLAGS_FEC_LOCAL_DEGRADED 0x11
+/* enum: If set, the receiver has detected the remote FEC has degraded. */
+#define	MC_CMD_LINK_STATUS_FLAGS_FEC_RM_DEGRADED 0x12
+/* enum: If set, the number of symbol errors is over an internal threshold. */
+#define	MC_CMD_LINK_STATUS_FLAGS_FEC_DEGRADED_SER 0x13
+/* enum: If set, autonegotiation has detected an auto-negotiation capable link
+ * partner
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_AN_ABLE 0x14
+/* enum: If set, autonegotiation base page exchange has failed */
+#define	MC_CMD_LINK_STATUS_FLAGS_AN_BP_FAILED 0x15
+/* enum: If set, autonegotiation next page exchange has failed */
+#define	MC_CMD_LINK_STATUS_FLAGS_AN_NP_FAILED 0x16
+/* enum: If set, autonegotiation has failed to negotiate a common set of
+ * capabilities
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_AN_NO_HCD 0x17
+/* enum: If set, local end link training has failed to establish link training
+ * frame lock on one or more lanes
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_LT_NO_LOCAL_FRAME_LOCK 0x18
+/* enum: If set, remote end link training has failed to establish link training
+ * frame lock on one or more lanes
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_LT_NO_RM_FRAME_LOCK 0x19
+/* enum: If set, remote end has failed to assert Receiver Ready (link training
+ * success) within the designated timeout
+ */
+#define	MC_CMD_LINK_STATUS_FLAGS_LT_NO_RX_READY 0x1a
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_LBN 0
+#define	MC_CMD_LINK_STATUS_FLAGS_STATUS_FLAGS_WIDTH 64
+
+/* MC_CMD_PAUSE_MODE structuredef */
+#define	MC_CMD_PAUSE_MODE_LEN 1
+#define	MC_CMD_PAUSE_MODE_TYPE_OFST 0
+#define	MC_CMD_PAUSE_MODE_TYPE_LEN 1
+/* enum: See IEEE 802.3 Clause 73.6.6 */
+#define	MC_CMD_PAUSE_MODE_AN_PAUSE 0x0
+/* enum: See IEEE 802.3 Clause 73.6.6 */
+#define	MC_CMD_PAUSE_MODE_AN_ASYM_DIR 0x1
+#define	MC_CMD_PAUSE_MODE_TYPE_LBN 0
+#define	MC_CMD_PAUSE_MODE_TYPE_WIDTH 8
+
+/* MC_CMD_ETH_AN_FIELDS structuredef: Fields used for IEEE 802.3 Clause 73
+ * Auto-Negotiation. Warning - This is fixed size and cannot be extended. This
+ * structure is used to define autonegotiable abilities (advertised, link
+ * partner and supported abilities).
+ */
+#define	MC_CMD_ETH_AN_FIELDS_LEN 25
+/* Mask of Ethernet technologies. The bit indices in this mask are taken from
+ * the TECH field in the MC_CMD_ETH_TECH structure.
+ */
+#define	MC_CMD_ETH_AN_FIELDS_TECH_MASK_OFST 0
+#define	MC_CMD_ETH_AN_FIELDS_TECH_MASK_LEN 16
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_ETH_TECH/TECH */
+#define	MC_CMD_ETH_AN_FIELDS_TECH_MASK_LBN 0
+#define	MC_CMD_ETH_AN_FIELDS_TECH_MASK_WIDTH 128
+/* Mask of supported FEC modes */
+#define	MC_CMD_ETH_AN_FIELDS_FEC_MASK_OFST 16
+#define	MC_CMD_ETH_AN_FIELDS_FEC_MASK_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               FEC_TYPE/TYPE */
+#define	MC_CMD_ETH_AN_FIELDS_FEC_MASK_LBN 128
+#define	MC_CMD_ETH_AN_FIELDS_FEC_MASK_WIDTH 32
+/* Mask of requested FEC modes */
+#define	MC_CMD_ETH_AN_FIELDS_FEC_REQ_OFST 20
+#define	MC_CMD_ETH_AN_FIELDS_FEC_REQ_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               FEC_TYPE/TYPE */
+#define	MC_CMD_ETH_AN_FIELDS_FEC_REQ_LBN 160
+#define	MC_CMD_ETH_AN_FIELDS_FEC_REQ_WIDTH 32
+/* Bitmask of negotiated pause modes */
+#define	MC_CMD_ETH_AN_FIELDS_PAUSE_MASK_OFST 24
+#define	MC_CMD_ETH_AN_FIELDS_PAUSE_MASK_LEN 1
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_PAUSE_MODE/TYPE */
+#define	MC_CMD_ETH_AN_FIELDS_PAUSE_MASK_LBN 192
+#define	MC_CMD_ETH_AN_FIELDS_PAUSE_MASK_WIDTH 8
+
+/* MC_CMD_LOOPBACK_V2 structuredef: Loopback modes for use with the new
+ * MC_CMD_LINK_CTRL and MC_CMD_LINK_STATE. These loopback modes are not
+ * supported in other getlink/setlink commands.
+ */
+#define	MC_CMD_LOOPBACK_V2_LEN 4
+#define	MC_CMD_LOOPBACK_V2_MODE_OFST 0
+#define	MC_CMD_LOOPBACK_V2_MODE_LEN 4
+/* enum: No loopback */
+#define	MC_CMD_LOOPBACK_V2_NONE 0x0
+/* enum: Let firmware choose a supported loopback mode */
+#define	MC_CMD_LOOPBACK_V2_AUTO 0x1
+/* enum: Loopback after the MAC */
+#define	MC_CMD_LOOPBACK_V2_POST_MAC 0x2
+/* enum: Loopback after the PCS */
+#define	MC_CMD_LOOPBACK_V2_POST_PCS 0x3
+/* enum: Loopback after the PMA */
+#define	MC_CMD_LOOPBACK_V2_POST_PMA 0x4
+/* enum: Loopback after the MDI Wireside */
+#define	MC_CMD_LOOPBACK_V2_POST_MDI_WS 0x5
+/* enum: Loopback after the PMA Wireside */
+#define	MC_CMD_LOOPBACK_V2_POST_PMA_WS 0x6
+/* enum: Loopback after the PCS Wireside */
+#define	MC_CMD_LOOPBACK_V2_POST_PCS_WS 0x7
+/* enum: Loopback after the MAC Wireside */
+#define	MC_CMD_LOOPBACK_V2_POST_MAC_WS 0x8
+/* enum: Loopback after the MAC FIFOs (before the MAC) */
+#define	MC_CMD_LOOPBACK_V2_PRE_MAC 0x9
+#define	MC_CMD_LOOPBACK_V2_MODE_LBN 0
+#define	MC_CMD_LOOPBACK_V2_MODE_WIDTH 32
+
+/* MC_CMD_FCNTL structuredef */
+#define	MC_CMD_FCNTL_LEN 4
+#define	MC_CMD_FCNTL_MASK_OFST 0
+#define	MC_CMD_FCNTL_MASK_LEN 4
+/* enum: Flow control is off. */
+#define	MC_CMD_FCNTL_OFF 0x0
+/* enum: Respond to flow control. */
+#define	MC_CMD_FCNTL_RESPOND 0x1
+/* enum: Respond to and Issue flow control. */
+#define	MC_CMD_FCNTL_BIDIR 0x2
+/* enum: Auto negotiate flow control. */
+#define	MC_CMD_FCNTL_AUTO 0x3
+/* enum: Priority flow control. This is only supported on KSB. */
+#define	MC_CMD_FCNTL_QBB 0x4
+/* enum: Issue flow control. */
+#define	MC_CMD_FCNTL_GENERATE 0x5
+#define	MC_CMD_FCNTL_MASK_LBN 0
+#define	MC_CMD_FCNTL_MASK_WIDTH 32
+
+/* MC_CMD_LINK_FLAGS structuredef */
+#define	MC_CMD_LINK_FLAGS_LEN 4
+/* The enums defined in this field are used as indices into the
+ * MC_CMD_LINK_FLAGS bitmask.
+ */
+#define	MC_CMD_LINK_FLAGS_MASK_OFST 0
+#define	MC_CMD_LINK_FLAGS_MASK_LEN 4
+/* enum property: bitshift */
+/* enum: Enable auto-negotiation. If AN is enabled, link technology and FEC
+ * mode are determined by advertised capabilities and requested FEC modes,
+ * combined with link partner capabilities. If AN is disabled, link technology
+ * is forced to LINK_TECHNOLOGY and FEC mode is forced to FEC_MODE. Not valid
+ * if loopback is enabled
+ */
+#define	MC_CMD_LINK_FLAGS_AUTONEG_EN 0x0
+/* enum: Enable parallel detect. In addition to AN, try to sense partner forced
+ * speed/FEC mode (when partner AN disabled). Only valid if AN is enabled.
+ */
+#define	MC_CMD_LINK_FLAGS_PARALLEL_DETECT_EN 0x1
+/* enum: Force link down, in electrical idle. */
+#define	MC_CMD_LINK_FLAGS_LINK_DISABLE 0x2
+/* enum: Ignore the sequence number and always apply. */
+#define	MC_CMD_LINK_FLAGS_IGNORE_MODULE_SEQ 0x3
+#define	MC_CMD_LINK_FLAGS_MASK_LBN 0
+#define	MC_CMD_LINK_FLAGS_MASK_WIDTH 32
+
+
+/***********************************/
+/* MC_CMD_LINK_CTRL
+ * Write the unified MAC/PHY link configuration. Locks required: None. Return
+ * code: 0, EINVAL, ETIME, EAGAIN
+ */
+#define	MC_CMD_LINK_CTRL 0x6b
+#define	MC_CMD_LINK_CTRL_MSGSET 0x6b
+#undef	MC_CMD_0x6b_PRIVILEGE_CTG
+
+#define	MC_CMD_0x6b_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_LINK_CTRL_IN msgrequest */
+#define	MC_CMD_LINK_CTRL_IN_LEN 40
+/* Handle to the port to set link state for. */
+#define	MC_CMD_LINK_CTRL_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_LINK_CTRL_IN_PORT_HANDLE_LEN 4
+/* Control flags */
+#define	MC_CMD_LINK_CTRL_IN_CONTROL_FLAGS_OFST 4
+#define	MC_CMD_LINK_CTRL_IN_CONTROL_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LINK_FLAGS/MASK */
+/* Reserved for future expansion, and included to provide padding for alignment
+ * purposes.
+ */
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_OFST 8
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_LEN 8
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_LO_OFST 8
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_LO_LEN 4
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_LO_LBN 64
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_LO_WIDTH 32
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_HI_OFST 12
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_HI_LEN 4
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_HI_LBN 96
+#define	MC_CMD_LINK_CTRL_IN_RESERVED_HI_WIDTH 32
+/* Technology abilities to advertise during auto-negotiation */
+#define	MC_CMD_LINK_CTRL_IN_ADVERTISED_TECH_ABILITIES_MASK_OFST 16
+#define	MC_CMD_LINK_CTRL_IN_ADVERTISED_TECH_ABILITIES_MASK_LEN 16
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_ETH_TECH/TECH */
+/* Pause abilities to advertise during auto-negotiation. Valid when auto-
+ * negotation is enabled and MC_CMD_SET_MAC_IN/FCTL is set to
+ * MC_CMD_FCNTL_AUTO. If auto-negotiation is disabled the driver must
+ * explicitly configure pause mode with MC_CMD_SET_MAC.
+ */
+#define	MC_CMD_LINK_CTRL_IN_ADVERTISED_PAUSE_ABILITIES_MASK_OFST 32
+#define	MC_CMD_LINK_CTRL_IN_ADVERTISED_PAUSE_ABILITIES_MASK_LEN 1
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_PAUSE_MODE/TYPE */
+/* When auto-negotiation is enabled, this is the FEC mode to request. Note that
+ * a weaker FEC mode may get negotiated, depending on what the link partner
+ * supports. The driver should subsequently use MC_CMD_GET_LINK to check the
+ * actual negotiated FEC mode. When auto-negotiation is disabled, this is the
+ * forced FEC mode.
+ */
+#define	MC_CMD_LINK_CTRL_IN_FEC_MODE_OFST 33
+#define	MC_CMD_LINK_CTRL_IN_FEC_MODE_LEN 1
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               FEC_TYPE/TYPE */
+/* This is only to be used when auto-negotiation is disabled (forced speed or
+ * loopback mode). If the specified value does not align with the values
+ * defined in the enum MC_CMD_ETH_TECH/TECH, it is considered invalid.
+ */
+#define	MC_CMD_LINK_CTRL_IN_LINK_TECHNOLOGY_OFST 36
+#define	MC_CMD_LINK_CTRL_IN_LINK_TECHNOLOGY_LEN 2
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_ETH_TECH/TECH */
+/* The sequence number of the last MODULECHANGE event. If this doesn't match,
+ * fail with EAGAIN.
+ */
+#define	MC_CMD_LINK_CTRL_IN_MODULE_SEQ_OFST 38
+#define	MC_CMD_LINK_CTRL_IN_MODULE_SEQ_LEN 1
+/* Loopback Mode. Only valid when auto-negotiation is disabled. */
+#define	MC_CMD_LINK_CTRL_IN_LOOPBACK_OFST 39
+#define	MC_CMD_LINK_CTRL_IN_LOOPBACK_LEN 1
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LOOPBACK_V2/MODE */
+
+/* MC_CMD_LINK_CTRL_OUT msgresponse */
+#define	MC_CMD_LINK_CTRL_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_LINK_STATE
+ */
+#define	MC_CMD_LINK_STATE 0x6c
+#define	MC_CMD_LINK_STATE_MSGSET 0x6c
+#undef	MC_CMD_0x6c_PRIVILEGE_CTG
+
+#define	MC_CMD_0x6c_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_LINK_STATE_IN msgrequest */
+#define	MC_CMD_LINK_STATE_IN_LEN 4
+/* Handle to the port to get link state for. */
+#define	MC_CMD_LINK_STATE_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_LINK_STATE_IN_PORT_HANDLE_LEN 4
+
+/* MC_CMD_LINK_STATE_OUT msgresponse */
+#define	MC_CMD_LINK_STATE_OUT_LEN 114
+/* Flags used to report the current configuration/state of the link. */
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_OFST 0
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_LEN 8
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_LO_OFST 0
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_LO_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_LO_LBN 0
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_LO_WIDTH 32
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_HI_OFST 4
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_HI_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_HI_LBN 32
+#define	MC_CMD_LINK_STATE_OUT_STATUS_FLAGS_HI_WIDTH 32
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LINK_STATUS_FLAGS/STATUS_FLAGS */
+/* Configured technology. If the specified value does not align with the values
+ * defined in the enum MC_CMD_ETH_TECH/TECH, it is considered invalid.
+ */
+#define	MC_CMD_LINK_STATE_OUT_LINK_TECHNOLOGY_OFST 8
+#define	MC_CMD_LINK_STATE_OUT_LINK_TECHNOLOGY_LEN 2
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_ETH_TECH/TECH */
+/* Configured FEC mode */
+#define	MC_CMD_LINK_STATE_OUT_FEC_MODE_OFST 10
+#define	MC_CMD_LINK_STATE_OUT_FEC_MODE_LEN 1
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               FEC_TYPE/TYPE */
+/* Bitmask of auto-negotiated pause modes */
+#define	MC_CMD_LINK_STATE_OUT_PAUSE_MASK_OFST 11
+#define	MC_CMD_LINK_STATE_OUT_PAUSE_MASK_LEN 1
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_PAUSE_MODE/TYPE */
+/* Configured loopback mode */
+#define	MC_CMD_LINK_STATE_OUT_LOOPBACK_OFST 12
+#define	MC_CMD_LINK_STATE_OUT_LOOPBACK_LEN 1
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LOOPBACK_V2/MODE */
+/* Abilities requested by the driver to advertise during auto-negotiation */
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_OFST 16
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_LEN 32
+/* See structuredef: MC_CMD_ETH_AN_FIELDS */
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_TECH_MASK_OFST 16
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_TECH_MASK_LEN 16
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_FEC_MASK_OFST 32
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_FEC_MASK_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_FEC_REQ_OFST 36
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_FEC_REQ_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_PAUSE_MASK_OFST 40
+#define	MC_CMD_LINK_STATE_OUT_ADVERTISED_ABILITIES_PAUSE_MASK_LEN 1
+/* Abilities advertised by the link partner during auto-negotiation */
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_OFST 48
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_LEN 32
+/* See structuredef: MC_CMD_ETH_AN_FIELDS */
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_TECH_MASK_OFST 48
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_TECH_MASK_LEN 16
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_FEC_MASK_OFST 64
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_FEC_MASK_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_FEC_REQ_OFST 68
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_FEC_REQ_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_PAUSE_MASK_OFST 72
+#define	MC_CMD_LINK_STATE_OUT_LINK_PARTNER_ABILITIES_PAUSE_MASK_LEN 1
+/* Abilities supported by the local device (including cable abilities) For
+ * fixed local device capbilities see MC_CMD_GET_LOCAL_DEVICE_INFO
+ */
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_OFST 80
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_LEN 28
+/* See structuredef: MC_CMD_ETH_AN_FIELDS */
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_TECH_MASK_OFST 80
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_TECH_MASK_LEN 16
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_FEC_MASK_OFST 96
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_FEC_MASK_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_FEC_REQ_OFST 100
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_FEC_REQ_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_PAUSE_MASK_OFST 104
+#define	MC_CMD_LINK_STATE_OUT_SUPPORTED_ABILITIES_PAUSE_MASK_LEN 1
+/* Control flags */
+#define	MC_CMD_LINK_STATE_OUT_CONTROL_FLAGS_OFST 108
+#define	MC_CMD_LINK_STATE_OUT_CONTROL_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LINK_FLAGS/MASK */
+/* Sequence number to synchronize link change events */
+#define	MC_CMD_LINK_STATE_OUT_PORT_LINKCHANGE_SEQ_NUM_OFST 112
+#define	MC_CMD_LINK_STATE_OUT_PORT_LINKCHANGE_SEQ_NUM_LEN 1
+/* Sequence number to synchronize module change events */
+#define	MC_CMD_LINK_STATE_OUT_PORT_MODULECHANGE_SEQ_NUM_OFST 113
+#define	MC_CMD_LINK_STATE_OUT_PORT_MODULECHANGE_SEQ_NUM_LEN 1
+
+/* MC_CMD_LINK_STATE_OUT_V2 msgresponse: Updated LINK_STATE_OUT with
+ * LOCAL_AN_SUPPORT
+ */
+#define	MC_CMD_LINK_STATE_OUT_V2_LEN 120
+/* Flags used to report the current configuration/state of the link. */
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_OFST 0
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_LEN 8
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_LO_OFST 0
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_LO_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_LO_LBN 0
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_LO_WIDTH 32
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_HI_OFST 4
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_HI_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_HI_LBN 32
+#define	MC_CMD_LINK_STATE_OUT_V2_STATUS_FLAGS_HI_WIDTH 32
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LINK_STATUS_FLAGS/STATUS_FLAGS */
+/* Configured technology. If the specified value does not align with the values
+ * defined in the enum MC_CMD_ETH_TECH/TECH, it is considered invalid.
+ */
+#define	MC_CMD_LINK_STATE_OUT_V2_LINK_TECHNOLOGY_OFST 8
+#define	MC_CMD_LINK_STATE_OUT_V2_LINK_TECHNOLOGY_LEN 2
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_ETH_TECH/TECH */
+/* Configured FEC mode */
+#define	MC_CMD_LINK_STATE_OUT_V2_FEC_MODE_OFST 10
+#define	MC_CMD_LINK_STATE_OUT_V2_FEC_MODE_LEN 1
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               FEC_TYPE/TYPE */
+/* Bitmask of auto-negotiated pause modes */
+#define	MC_CMD_LINK_STATE_OUT_V2_PAUSE_MASK_OFST 11
+#define	MC_CMD_LINK_STATE_OUT_V2_PAUSE_MASK_LEN 1
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_PAUSE_MODE/TYPE */
+/* Configured loopback mode */
+#define	MC_CMD_LINK_STATE_OUT_V2_LOOPBACK_OFST 12
+#define	MC_CMD_LINK_STATE_OUT_V2_LOOPBACK_LEN 1
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LOOPBACK_V2/MODE */
+/* Abilities requested by the driver to advertise during auto-negotiation */
+#define	MC_CMD_LINK_STATE_OUT_V2_ADVERTISED_ABILITIES_OFST 16
+#define	MC_CMD_LINK_STATE_OUT_V2_ADVERTISED_ABILITIES_LEN 32
+/* Abilities advertised by the link partner during auto-negotiation */
+#define	MC_CMD_LINK_STATE_OUT_V2_LINK_PARTNER_ABILITIES_OFST 48
+#define	MC_CMD_LINK_STATE_OUT_V2_LINK_PARTNER_ABILITIES_LEN 32
+/* Abilities supported by the local device (including cable abilities) For
+ * fixed local device capbilities see MC_CMD_GET_LOCAL_DEVICE_INFO
+ */
+#define	MC_CMD_LINK_STATE_OUT_V2_SUPPORTED_ABILITIES_OFST 80
+#define	MC_CMD_LINK_STATE_OUT_V2_SUPPORTED_ABILITIES_LEN 28
+/* Control flags */
+#define	MC_CMD_LINK_STATE_OUT_V2_CONTROL_FLAGS_OFST 108
+#define	MC_CMD_LINK_STATE_OUT_V2_CONTROL_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LINK_FLAGS/MASK */
+/* Sequence number to synchronize link change events */
+#define	MC_CMD_LINK_STATE_OUT_V2_PORT_LINKCHANGE_SEQ_NUM_OFST 112
+#define	MC_CMD_LINK_STATE_OUT_V2_PORT_LINKCHANGE_SEQ_NUM_LEN 1
+/* Sequence number to synchronize module change events */
+#define	MC_CMD_LINK_STATE_OUT_V2_PORT_MODULECHANGE_SEQ_NUM_OFST 113
+#define	MC_CMD_LINK_STATE_OUT_V2_PORT_MODULECHANGE_SEQ_NUM_LEN 1
+/* Reports the auto-negotiation supported by the local device. This depends on
+ * the port and module properties.
+ */
+#define	MC_CMD_LINK_STATE_OUT_V2_LOCAL_AN_SUPPORT_OFST 116
+#define	MC_CMD_LINK_STATE_OUT_V2_LOCAL_AN_SUPPORT_LEN 4
+/*            Enum values, see field(s): */
+/*               AN_TYPE/TYPE */
+
+/* MC_CMD_LINK_STATE_OUT_V3 msgresponse: Updated LINK_STATE_OUT_V2 for explicit
+ * reporting of the link speed and duplex mode.
+ */
+#define	MC_CMD_LINK_STATE_OUT_V3_LEN 128
+/* Flags used to report the current configuration/state of the link. */
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_OFST 0
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_LEN 8
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_LO_OFST 0
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_LO_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_LO_LBN 0
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_LO_WIDTH 32
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_HI_OFST 4
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_HI_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_HI_LBN 32
+#define	MC_CMD_LINK_STATE_OUT_V3_STATUS_FLAGS_HI_WIDTH 32
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LINK_STATUS_FLAGS/STATUS_FLAGS */
+/* Configured technology. If the specified value does not align with the values
+ * defined in the enum MC_CMD_ETH_TECH/TECH, it is considered invalid.
+ */
+#define	MC_CMD_LINK_STATE_OUT_V3_LINK_TECHNOLOGY_OFST 8
+#define	MC_CMD_LINK_STATE_OUT_V3_LINK_TECHNOLOGY_LEN 2
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_ETH_TECH/TECH */
+/* Configured FEC mode */
+#define	MC_CMD_LINK_STATE_OUT_V3_FEC_MODE_OFST 10
+#define	MC_CMD_LINK_STATE_OUT_V3_FEC_MODE_LEN 1
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               FEC_TYPE/TYPE */
+/* Bitmask of auto-negotiated pause modes */
+#define	MC_CMD_LINK_STATE_OUT_V3_PAUSE_MASK_OFST 11
+#define	MC_CMD_LINK_STATE_OUT_V3_PAUSE_MASK_LEN 1
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_PAUSE_MODE/TYPE */
+/* Configured loopback mode */
+#define	MC_CMD_LINK_STATE_OUT_V3_LOOPBACK_OFST 12
+#define	MC_CMD_LINK_STATE_OUT_V3_LOOPBACK_LEN 1
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LOOPBACK_V2/MODE */
+/* Abilities requested by the driver to advertise during auto-negotiation */
+#define	MC_CMD_LINK_STATE_OUT_V3_ADVERTISED_ABILITIES_OFST 16
+#define	MC_CMD_LINK_STATE_OUT_V3_ADVERTISED_ABILITIES_LEN 32
+/* Abilities advertised by the link partner during auto-negotiation */
+#define	MC_CMD_LINK_STATE_OUT_V3_LINK_PARTNER_ABILITIES_OFST 48
+#define	MC_CMD_LINK_STATE_OUT_V3_LINK_PARTNER_ABILITIES_LEN 32
+/* Abilities supported by the local device (including cable abilities) For
+ * fixed local device capbilities see MC_CMD_GET_LOCAL_DEVICE_INFO
+ */
+#define	MC_CMD_LINK_STATE_OUT_V3_SUPPORTED_ABILITIES_OFST 80
+#define	MC_CMD_LINK_STATE_OUT_V3_SUPPORTED_ABILITIES_LEN 28
+/* Control flags */
+#define	MC_CMD_LINK_STATE_OUT_V3_CONTROL_FLAGS_OFST 108
+#define	MC_CMD_LINK_STATE_OUT_V3_CONTROL_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LINK_FLAGS/MASK */
+/* Sequence number to synchronize link change events */
+#define	MC_CMD_LINK_STATE_OUT_V3_PORT_LINKCHANGE_SEQ_NUM_OFST 112
+#define	MC_CMD_LINK_STATE_OUT_V3_PORT_LINKCHANGE_SEQ_NUM_LEN 1
+/* Sequence number to synchronize module change events */
+#define	MC_CMD_LINK_STATE_OUT_V3_PORT_MODULECHANGE_SEQ_NUM_OFST 113
+#define	MC_CMD_LINK_STATE_OUT_V3_PORT_MODULECHANGE_SEQ_NUM_LEN 1
+/* Reports the auto-negotiation supported by the local device. This depends on
+ * the port and module properties.
+ */
+#define	MC_CMD_LINK_STATE_OUT_V3_LOCAL_AN_SUPPORT_OFST 116
+#define	MC_CMD_LINK_STATE_OUT_V3_LOCAL_AN_SUPPORT_LEN 4
+/*            Enum values, see field(s): */
+/*               AN_TYPE/TYPE */
+/* Autonegotiated speed in mbit/s. The link may still be down even if this
+ * reads non-zero. LINK_SPEED field is intended to be used by drivers without
+ * the most up-to-date MCDI definitions, unable to deduce the link speed from
+ * the reported LINK_TECHNOLOGY field.
+ */
+#define	MC_CMD_LINK_STATE_OUT_V3_LINK_SPEED_OFST 120
+#define	MC_CMD_LINK_STATE_OUT_V3_LINK_SPEED_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_V3_FLAGS_OFST 124
+#define	MC_CMD_LINK_STATE_OUT_V3_FLAGS_LEN 4
+#define	MC_CMD_LINK_STATE_OUT_V3_FULL_DUPLEX_OFST 124
+#define	MC_CMD_LINK_STATE_OUT_V3_FULL_DUPLEX_LBN 0
+#define	MC_CMD_LINK_STATE_OUT_V3_FULL_DUPLEX_WIDTH 1
+
 
 /***********************************/
 /* MC_CMD_GET_LINK
@@ -6383,6 +7329,7 @@
 /* This returns the negotiated flow control value. */
 #define	MC_CMD_GET_LINK_OUT_FCNTL_OFST 20
 #define	MC_CMD_GET_LINK_OUT_FCNTL_LEN 4
+/* enum property: value */
 /*            Enum values, see field(s): */
 /*               MC_CMD_SET_MAC/MC_CMD_SET_MAC_IN/FCNTL */
 #define	MC_CMD_GET_LINK_OUT_MAC_FAULT_OFST 24
@@ -6451,6 +7398,7 @@
 /* This returns the negotiated flow control value. */
 #define	MC_CMD_GET_LINK_OUT_V2_FCNTL_OFST 20
 #define	MC_CMD_GET_LINK_OUT_V2_FCNTL_LEN 4
+/* enum property: value */
 /*            Enum values, see field(s): */
 /*               MC_CMD_SET_MAC/MC_CMD_SET_MAC_IN/FCNTL */
 #define	MC_CMD_GET_LINK_OUT_V2_MAC_FAULT_OFST 24
@@ -6764,17 +7712,17 @@
 #define	MC_CMD_SET_MAC_IN_FCNTL_OFST 20
 #define	MC_CMD_SET_MAC_IN_FCNTL_LEN 4
 /* enum: Flow control is off. */
-#define	MC_CMD_FCNTL_OFF 0x0
+/*               MC_CMD_FCNTL_OFF 0x0 */
 /* enum: Respond to flow control. */
-#define	MC_CMD_FCNTL_RESPOND 0x1
+/*               MC_CMD_FCNTL_RESPOND 0x1 */
 /* enum: Respond to and Issue flow control. */
-#define	MC_CMD_FCNTL_BIDIR 0x2
-/* enum: Auto neg flow control. */
-#define	MC_CMD_FCNTL_AUTO 0x3
-/* enum: Priority flow control (eftest builds only). */
-#define	MC_CMD_FCNTL_QBB 0x4
+/*               MC_CMD_FCNTL_BIDIR 0x2 */
+/* enum: Auto negotiate flow control. */
+/*               MC_CMD_FCNTL_AUTO 0x3 */
+/* enum: Priority flow control. This is only supported on KSB. */
+/*               MC_CMD_FCNTL_QBB 0x4 */
 /* enum: Issue flow control. */
-#define	MC_CMD_FCNTL_GENERATE 0x5
+/*               MC_CMD_FCNTL_GENERATE 0x5 */
 #define	MC_CMD_SET_MAC_IN_FLAGS_OFST 24
 #define	MC_CMD_SET_MAC_IN_FLAGS_LEN 4
 #define	MC_CMD_SET_MAC_IN_FLAG_INCLUDE_FCS_OFST 24
@@ -6816,9 +7764,9 @@
 /*               MC_CMD_FCNTL_RESPOND 0x1 */
 /* enum: Respond to and Issue flow control. */
 /*               MC_CMD_FCNTL_BIDIR 0x2 */
-/* enum: Auto neg flow control. */
+/* enum: Auto negotiate flow control. */
 /*               MC_CMD_FCNTL_AUTO 0x3 */
-/* enum: Priority flow control (eftest builds only). */
+/* enum: Priority flow control. This is only supported on KSB. */
 /*               MC_CMD_FCNTL_QBB 0x4 */
 /* enum: Issue flow control. */
 /*               MC_CMD_FCNTL_GENERATE 0x5 */
@@ -6885,9 +7833,9 @@
 /*               MC_CMD_FCNTL_RESPOND 0x1 */
 /* enum: Respond to and Issue flow control. */
 /*               MC_CMD_FCNTL_BIDIR 0x2 */
-/* enum: Auto neg flow control. */
+/* enum: Auto negotiate flow control. */
 /*               MC_CMD_FCNTL_AUTO 0x3 */
-/* enum: Priority flow control (eftest builds only). */
+/* enum: Priority flow control. This is only supported on KSB. */
 /*               MC_CMD_FCNTL_QBB 0x4 */
 /* enum: Issue flow control. */
 /*               MC_CMD_FCNTL_GENERATE 0x5 */
@@ -7542,6 +8490,36 @@
 /*            Other enum values, see field(s): */
 /*               MC_CMD_MAC_STATS_V3_OUT_NO_DMA/STATISTICS */
 
+/* MC_CMD_MAC_STATS_V5_OUT_DMA msgresponse */
+#define	MC_CMD_MAC_STATS_V5_OUT_DMA_LEN 0
+
+/* MC_CMD_MAC_STATS_V5_OUT_NO_DMA msgresponse */
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_LEN (((MC_CMD_MAC_NSTATS_V5*64))>>3)
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_OFST 0
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_LEN 8
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_LO_OFST 0
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_LO_LEN 4
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_LO_LBN 0
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_LO_WIDTH 32
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_HI_OFST 4
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_HI_LEN 4
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_HI_LBN 32
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_HI_WIDTH 32
+#define	MC_CMD_MAC_STATS_V5_OUT_NO_DMA_STATISTICS_NUM MC_CMD_MAC_NSTATS_V5
+/* enum property: index */
+/* enum: Start of V5 stats buffer space */
+#define	MC_CMD_MAC_V5_DMABUF_START 0x7c
+/* enum: Link toggle counter: Number of times the link has toggled between
+ * up/down and down/up
+ */
+#define	MC_CMD_MAC_LINK_TOGGLES 0x7c
+/* enum: This includes the space at offset 125 which is the final
+ * GENERATION_END in a MAC_STATS_V5 response and otherwise unused.
+ */
+#define	MC_CMD_MAC_NSTATS_V5 0x7e
+/*            Other enum values, see field(s): */
+/*               MC_CMD_MAC_STATS_V4_OUT_NO_DMA/STATISTICS */
+
 
 /***********************************/
 /* MC_CMD_SRIOV
@@ -9410,6 +10388,28 @@
 /* MC_CMD_GET_RESOURCE_LIMITS_IN msgrequest */
 #define	MC_CMD_GET_RESOURCE_LIMITS_IN_LEN 0
 
+/* MC_CMD_GET_RESOURCE_LIMITS_IN_V2 msgrequest */
+#define	MC_CMD_GET_RESOURCE_LIMITS_IN_V2_LEN 8
+/* What type of allocation to count. */
+#define	MC_CMD_GET_RESOURCE_LIMITS_IN_V2_REQUEST_TYPE_OFST 0
+#define	MC_CMD_GET_RESOURCE_LIMITS_IN_V2_REQUEST_TYPE_LEN 4
+/* enum: Command returns the number of each resource that the function has
+ * currently allocated.
+ */
+#define	MC_CMD_GET_RESOURCE_LIMITS_IN_V2_ALLOCATED 0x0
+/* enum: Command returns the maximum number of each resource that it could be
+ * possible for the function to allocate (ie assuming that other functions have
+ * nothing allocated beyond their minimum reservations (if any).
+ */
+#define	MC_CMD_GET_RESOURCE_LIMITS_IN_V2_MAX_POSSIBLE 0x1
+/* What type of resource to count. */
+#define	MC_CMD_GET_RESOURCE_LIMITS_IN_V2_RESOURCE_TYPE_OFST 4
+#define	MC_CMD_GET_RESOURCE_LIMITS_IN_V2_RESOURCE_TYPE_LEN 4
+/* enum: Count full-featured (X2-style) queues */
+#define	MC_CMD_GET_RESOURCE_LIMITS_IN_V2_FULL_FEATURED_QUEUE 0x0
+/* enum: Count low-latency (X3-style) queues */
+#define	MC_CMD_GET_RESOURCE_LIMITS_IN_V2_LOW_LATENCY_QUEUE 0x1
+
 /* MC_CMD_GET_RESOURCE_LIMITS_OUT msgresponse */
 #define	MC_CMD_GET_RESOURCE_LIMITS_OUT_LEN 16
 #define	MC_CMD_GET_RESOURCE_LIMITS_OUT_BUFTBL_OFST 0
@@ -10515,7 +11515,7 @@
 /* MC_CMD_DYNAMIC_SENSORS_GET_DESCRIPTIONS
  * Get descriptions for a set of sensors, specified as an array of sensor
  * handles as returned by MC_CMD_DYNAMIC_SENSORS_LIST. Any handles which do not
- * correspond to a sensor currently managed by the MC will be dropped from
+ * correspond to a sensor currently managed by the MC will be dropped from from
  * the response. This may happen when a sensor table update is in progress, and
  * effectively means the set of usable sensors is the intersection between the
  * sets of sensors known to the driver and the MC. On Riverhead this command is
@@ -10562,7 +11562,7 @@
  * broken sensor, then the state of the response's MC_CMD_DYNAMIC_SENSORS_VALUE
  * entry will be set to BROKEN, and any value provided should be treated as
  * erroneous. Any handles which do not correspond to a sensor currently managed
- * by the MC will be dropped from the response. This may happen when a
+ * by the MC will be dropped from from the response. This may happen when a
  * sensor table update is in progress, and effectively means the set of usable
  * sensors is the intersection between the sets of sensors known to the driver
  * and the MC. On Riverhead this command is implemented as a wrapper for
@@ -10641,6 +11641,2644 @@
 /* MC_CMD_EVENT_CTRL_OUT msgrequest */
 #define	MC_CMD_EVENT_CTRL_OUT_LEN 0
 
+/* HNIC_FIFO_SIZE_PARAMS structuredef: HNIC FIFO size parameters */
+#define	HNIC_FIFO_SIZE_PARAMS_LEN 12
+/* FIFO handle */
+#define	HNIC_FIFO_SIZE_PARAMS_FIFO_HANDLE_OFST 0
+#define	HNIC_FIFO_SIZE_PARAMS_FIFO_HANDLE_LEN 4
+#define	HNIC_FIFO_SIZE_PARAMS_FIFO_HANDLE_LBN 0
+#define	HNIC_FIFO_SIZE_PARAMS_FIFO_HANDLE_WIDTH 32
+#define	HNIC_FIFO_SIZE_PARAMS_FLAGS_OFST 4
+#define	HNIC_FIFO_SIZE_PARAMS_FLAGS_LEN 4
+#define	HNIC_FIFO_SIZE_PARAMS_ENABLED_OFST 4
+#define	HNIC_FIFO_SIZE_PARAMS_ENABLED_LBN 0
+#define	HNIC_FIFO_SIZE_PARAMS_ENABLED_WIDTH 1
+#define	HNIC_FIFO_SIZE_PARAMS_FLAGS_LBN 32
+#define	HNIC_FIFO_SIZE_PARAMS_FLAGS_WIDTH 32
+/* Bytes allocated to this FIFO */
+#define	HNIC_FIFO_SIZE_PARAMS_ALLOC_SIZE_OFST 8
+#define	HNIC_FIFO_SIZE_PARAMS_ALLOC_SIZE_LEN 4
+#define	HNIC_FIFO_SIZE_PARAMS_ALLOC_SIZE_LBN 64
+#define	HNIC_FIFO_SIZE_PARAMS_ALLOC_SIZE_WIDTH 32
+
+/* HNIC_FIFO_DELAY_PARAMS structuredef: HNIC FIFO delay parameters */
+#define	HNIC_FIFO_DELAY_PARAMS_LEN 16
+/* FIFO handle */
+#define	HNIC_FIFO_DELAY_PARAMS_FIFO_HANDLE_OFST 0
+#define	HNIC_FIFO_DELAY_PARAMS_FIFO_HANDLE_LEN 4
+#define	HNIC_FIFO_DELAY_PARAMS_FIFO_HANDLE_LBN 0
+#define	HNIC_FIFO_DELAY_PARAMS_FIFO_HANDLE_WIDTH 32
+#define	HNIC_FIFO_DELAY_PARAMS_FLAGS_OFST 4
+#define	HNIC_FIFO_DELAY_PARAMS_FLAGS_LEN 4
+#define	HNIC_FIFO_DELAY_PARAMS_OVERRIDE_OFST 4
+#define	HNIC_FIFO_DELAY_PARAMS_OVERRIDE_LBN 0
+#define	HNIC_FIFO_DELAY_PARAMS_OVERRIDE_WIDTH 1
+#define	HNIC_FIFO_DELAY_PARAMS_FLAGS_LBN 32
+#define	HNIC_FIFO_DELAY_PARAMS_FLAGS_WIDTH 32
+/* XOFF threshold Only applies if the OVERRIDE flag is set. Represented in
+ * bytes
+ */
+#define	HNIC_FIFO_DELAY_PARAMS_XOFF_THRESHOLD_OFST 8
+#define	HNIC_FIFO_DELAY_PARAMS_XOFF_THRESHOLD_LEN 4
+#define	HNIC_FIFO_DELAY_PARAMS_XOFF_THRESHOLD_LBN 64
+#define	HNIC_FIFO_DELAY_PARAMS_XOFF_THRESHOLD_WIDTH 32
+/* XON threshold Only applies if the OVERRIDE flag is set. Represented in bytes
+ */
+#define	HNIC_FIFO_DELAY_PARAMS_XON_THRESHOLD_OFST 12
+#define	HNIC_FIFO_DELAY_PARAMS_XON_THRESHOLD_LEN 4
+#define	HNIC_FIFO_DELAY_PARAMS_XON_THRESHOLD_LBN 96
+#define	HNIC_FIFO_DELAY_PARAMS_XON_THRESHOLD_WIDTH 32
+
+
+/***********************************/
+/* MC_CMD_GET_HNIC_PORT_CONFIG
+ * Query the static HNIC port configuration for a physical port. Returns ENODEV
+ * if the target does not correspond to a physical port, or EPERM if the caller
+ * does not have permission to administer it. This command is deprecated. Use
+ * MC_CMD_FETCH_HNIC_PORT_CONFIG instead.
+ */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG 0x1d6
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_MSGSET 0x1d6
+#undef	MC_CMD_0x1d6_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1d6_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_GET_HNIC_PORT_CONFIG_IN msgrequest */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_LEN 12
+/* Target port to query. Uses MAE_LINK_ENDPOINT_SELECTOR which identifies the
+ * port by MAE port and link end, but this must correspond to a physical port
+ * to be valid. See the structure definition for more details.
+ */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_LEN 8
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_LO_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_LO_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_LO_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_LO_WIDTH 32
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_HI_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_HI_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_HI_LBN 32
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_HI_WIDTH 32
+/* See structuredef: MAE_LINK_ENDPOINT_SELECTOR */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FLAT_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FLAT_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_TYPE_OFST 3
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_TYPE_LEN 1
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_MPORT_ID_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_MPORT_ID_LEN 3
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_PPORT_ID_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_PPORT_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_LBN 20
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_LBN 16
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_OFST 2
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_LEN 1
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_LEN 2
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_LINK_END_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_LINK_END_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_LEN 8
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_LO_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_LO_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_LO_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_LO_WIDTH 32
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_HI_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_HI_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_HI_LBN 32
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_TARGET_FLAT_HI_WIDTH 32
+/* Traffic direction to query. */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_DIRECTION_OFST 8
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+
+/* MC_CMD_GET_HNIC_PORT_CONFIG_OUT msgresponse */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_LENMIN 12
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_LENMAX 252
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_LEN(num) (12+4*(num))
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_NUM(len) (((len)-12)/4)
+/* Total size of buffer region assigned to this port, in bytes. */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_REGION_SIZE_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_REGION_SIZE_LEN 4
+/* Allocation granularity, in bytes. All partitioning of the buffer region must
+ * be in multiples of this value.
+ */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_ALLOC_GRANULARITY_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_ALLOC_GRANULARITY_LEN 4
+/* The number of independent FIFOs assigned to this port. */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_NUM_FIFOS_OFST 8
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_NUM_FIFOS_LEN 4
+/* Array of FIFO handles, NUM_FIFOS items long. */
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_OFST 12
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_MINNUM 0
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_MAXNUM 60
+#define	MC_CMD_GET_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_MAXNUM_MCDI2 252
+
+
+/***********************************/
+/* MC_CMD_GET_HNIC_PORT_FIFO_SIZING
+ * Returns the current state of the FIFO sizing configuration for all of the
+ * FIFOs assigned to a physical port. Returns ENODEV if the target does not
+ * correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it. This command is deprecated. Use
+ * MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING instead.
+ */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING 0x1d7
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_MSGSET 0x1d7
+#undef	MC_CMD_0x1d7_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1d7_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN msgrequest */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_LEN 12
+/* Target port to query. Uses MAE_LINK_ENDPOINT_SELECTOR which identifies the
+ * port by MAE port and link end, but this must correspond to a physical port
+ * to be valid. See the structure definition for more details.
+ */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LEN 8
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LO_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LO_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LO_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LO_WIDTH 32
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_HI_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_HI_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_HI_LBN 32
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_HI_WIDTH 32
+/* See structuredef: MAE_LINK_ENDPOINT_SELECTOR */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FLAT_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FLAT_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_TYPE_OFST 3
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_TYPE_LEN 1
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_MPORT_ID_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_MPORT_ID_LEN 3
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_PPORT_ID_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_PPORT_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_LBN 20
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_LBN 16
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_OFST 2
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_LEN 1
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_LEN 2
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LINK_END_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LINK_END_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LEN 8
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LO_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LO_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LO_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LO_WIDTH 32
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_HI_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_HI_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_HI_LBN 32
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_HI_WIDTH 32
+/* Traffic direction to query. */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_DIRECTION_OFST 8
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+
+/* MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT msgresponse */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_LENMIN 8
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_LENMAX 248
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_LENMAX_MCDI2 1016
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_LEN(num) (8+12*(num))
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_NUM(len) (((len)-8)/12)
+/* Total size of buffer region assigned to this port, in bytes. */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_REGION_SIZE_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_REGION_SIZE_LEN 4
+/* The number of independent FIFOs assigned to this port. */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_NUM_FIFOS_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_SIZE_PARAMS structures, NUM_FIFOS items long. */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_OFST 8
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_LEN 12
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_MINNUM 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_MAXNUM 20
+#define	MC_CMD_GET_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_MAXNUM_MCDI2 84
+
+
+/***********************************/
+/* MC_CMD_SET_HNIC_PORT_FIFO_SIZING
+ * Sets the FIFO sizing configuration for a physical port. This is disruptive
+ * to port operation and will cause the link to drop while the port is
+ * reconfigured. Returns ENODEV if the target does not correspond to a physical
+ * port, or EPERM if the caller does not have permission to administer it, or
+ * EINVAL if the sizing parameters are invalid. This command is deprecated. Use
+ * MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING instead.
+ */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING 0x1d8
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_MSGSET 0x1d8
+#undef	MC_CMD_0x1d8_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1d8_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN msgrequest */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_LENMIN 16
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_LENMAX 244
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_LENMAX_MCDI2 1012
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_LEN(num) (16+12*(num))
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_NUM(len) (((len)-16)/12)
+/* Target port to configure. Uses MAE_LINK_ENDPOINT_SELECTOR which identifies
+ * the port by MAE port and link end, but this must correspond to a physical
+ * port to be valid. See the structure definition for more details.
+ */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LEN 8
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LO_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LO_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LO_LBN 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LO_WIDTH 32
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_HI_OFST 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_HI_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_HI_LBN 32
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_HI_WIDTH 32
+/* See structuredef: MAE_LINK_ENDPOINT_SELECTOR */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FLAT_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FLAT_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_TYPE_OFST 3
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_TYPE_LEN 1
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_MPORT_ID_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_MPORT_ID_LEN 3
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_PPORT_ID_LBN 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_PPORT_ID_WIDTH 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_LBN 20
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_WIDTH 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_LBN 16
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_WIDTH 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_OFST 2
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_LEN 1
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_LEN 2
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LINK_END_OFST 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_LINK_END_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LEN 8
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LO_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LO_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LO_LBN 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_LO_WIDTH 32
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_HI_OFST 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_HI_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_HI_LBN 32
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_TARGET_FLAT_HI_WIDTH 32
+/* Traffic direction to query. */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_DIRECTION_OFST 8
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+/* The number of FIFOs being configured. FIFOs assigned to the port but not
+ * included in the list are assumed to retain their current size configuration.
+ */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_NUM_FIFOS_OFST 12
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_SIZE_PARAMS structures, NUM_FIFOS items long. */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_OFST 16
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_LEN 12
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_MINNUM 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_MAXNUM 19
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_MAXNUM_MCDI2 83
+
+/* MC_CMD_SET_HNIC_PORT_FIFO_SIZING_OUT msgresponse */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_SIZING_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_GET_HNIC_PORT_PRIO_MAPPING
+ * Returns the current state of the 802.1Q priority to FIFO mapping
+ * configuration for a physical port. Returns ENODEV if the target does not
+ * correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it.. This command is deprecated. Use
+ * MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING instead.
+ */
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING 0x1d9
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_MSGSET 0x1d9
+#undef	MC_CMD_0x1d9_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1d9_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN msgrequest */
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_LEN 12
+/* Target port to query. Uses MAE_LINK_ENDPOINT_SELECTOR which identifies the
+ * port by MAE port and link end, but this must correspond to a physical port
+ * to be valid. See the structure definition for more details.
+ */
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LEN 8
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LO_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LO_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LO_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LO_WIDTH 32
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_HI_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_HI_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_HI_LBN 32
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_HI_WIDTH 32
+/* See structuredef: MAE_LINK_ENDPOINT_SELECTOR */
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FLAT_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FLAT_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_TYPE_OFST 3
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_TYPE_LEN 1
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_MPORT_ID_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_MPORT_ID_LEN 3
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_PPORT_ID_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_PPORT_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_LBN 20
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_LBN 16
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_OFST 2
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_LEN 1
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_LEN 2
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LINK_END_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LINK_END_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LEN 8
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LO_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LO_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LO_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LO_WIDTH 32
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_HI_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_HI_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_HI_LBN 32
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_HI_WIDTH 32
+/* Traffic direction to query. */
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_DIRECTION_OFST 8
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+
+/* MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_OUT msgresponse */
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_OUT_LEN 32
+/* FIFO handle for each Priority Code Point(PCP), in order from 0 to 7. */
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_OUT_FIFO_HANDLE_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_OUT_FIFO_HANDLE_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_PRIO_MAPPING_OUT_FIFO_HANDLE_NUM 8
+
+
+/***********************************/
+/* MC_CMD_SET_HNIC_PORT_PRIO_MAPPING
+ * Sets the PCP priority to FIFO mapping configuration for a physical port.
+ * Returns ENODEV if the target does not correspond to a physical port, or
+ * EPERM if the caller does not have permission to administer it, or EINVAL if
+ * any of the FIFO handles are invalid in some way. This command is deprecated.
+ * Use MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING instead.
+ */
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING 0x1da
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_MSGSET 0x1da
+#undef	MC_CMD_0x1da_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1da_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN msgrequest */
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_LEN 44
+/* Target port to configure. Uses MAE_LINK_ENDPOINT_SELECTOR which identifies
+ * the port by MAE port and link end, but this must correspond to a physical
+ * port to be valid. See the structure definition for more details.
+ */
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LEN 8
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LO_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LO_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LO_LBN 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LO_WIDTH 32
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_HI_OFST 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_HI_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_HI_LBN 32
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_HI_WIDTH 32
+/* See structuredef: MAE_LINK_ENDPOINT_SELECTOR */
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FLAT_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FLAT_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_TYPE_OFST 3
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_TYPE_LEN 1
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_MPORT_ID_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_MPORT_ID_LEN 3
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_PPORT_ID_LBN 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_PPORT_ID_WIDTH 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_LBN 20
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_WIDTH 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_LBN 16
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_WIDTH 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_OFST 2
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_LEN 1
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_LEN 2
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LINK_END_OFST 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_LINK_END_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LEN 8
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LO_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LO_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LO_LBN 0
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_LO_WIDTH 32
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_HI_OFST 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_HI_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_HI_LBN 32
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_TARGET_FLAT_HI_WIDTH 32
+/* Traffic direction to query. */
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_DIRECTION_OFST 8
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+/* FIFO handle for each PCP value, in order from 0 to 7. */
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_FIFO_HANDLE_OFST 12
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_FIFO_HANDLE_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_IN_FIFO_HANDLE_NUM 8
+
+/* MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_OUT msgresponse */
+#define	MC_CMD_SET_HNIC_PORT_PRIO_MAPPING_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS
+ * Returns the current state of the FIFO delay parameters configuration for all
+ * of the FIFOs assigned to a physical port. Returns ENODEV if the target does
+ * not correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it. This command is deprecated. Use
+ * MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS instead.
+ */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS 0x1db
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_MSGSET 0x1db
+#undef	MC_CMD_0x1db_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1db_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN msgrequest */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LEN 12
+/* Target port to query. Uses MAE_LINK_ENDPOINT_SELECTOR which identifies the
+ * port by MAE port and link end, but this must correspond to a physical port
+ * to be valid. See the structure definition for more details.
+ */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LEN 8
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LO_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LO_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LO_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LO_WIDTH 32
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_HI_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_HI_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_HI_LBN 32
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_HI_WIDTH 32
+/* See structuredef: MAE_LINK_ENDPOINT_SELECTOR */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FLAT_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FLAT_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_TYPE_OFST 3
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_TYPE_LEN 1
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_MPORT_ID_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_MPORT_ID_LEN 3
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_PPORT_ID_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_PPORT_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_LBN 20
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_LBN 16
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_WIDTH 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_OFST 2
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_LEN 1
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_LEN 2
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LINK_END_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LINK_END_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LEN 8
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LO_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LO_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LO_LBN 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LO_WIDTH 32
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_HI_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_HI_LEN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_HI_LBN 32
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_HI_WIDTH 32
+/* Traffic direction to query. */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_DIRECTION_OFST 8
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+
+/* MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT msgresponse */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LENMIN 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LENMAX 244
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LENMAX_MCDI2 1012
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LEN(num) (4+16*(num))
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_NUM(len) (((len)-4)/16)
+/* The number of independent FIFOs assigned to this port. */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_NUM_FIFOS_OFST 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_DELAY_PARAMS structures, NUM_FIFOS items long. */
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_OFST 4
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_LEN 16
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_MINNUM 0
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_MAXNUM 15
+#define	MC_CMD_GET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_MAXNUM_MCDI2 63
+
+
+/***********************************/
+/* MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS
+ * Sets the FIFO delay parameters configuration for a physical port. This is
+ * not disruptive to port operation. Returns ENODEV if the target does not
+ * correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it, or EINVAL if the sizing parameters are invalid.
+ * This command is deprecated. Use MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS
+ * instead
+ */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS 0x1dc
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_MSGSET 0x1dc
+#undef	MC_CMD_0x1dc_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1dc_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN msgrequest */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LENMIN 16
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LENMAX 240
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LENMAX_MCDI2 1008
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LEN(num) (16+16*(num))
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_NUM(len) (((len)-16)/16)
+/* Target port to configure. Uses MAE_LINK_ENDPOINT_SELECTOR which identifies
+ * the port by MAE port and link end, but this must correspond to a physical
+ * port to be valid. See the structure definition for more details.
+ */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LEN 8
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LO_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LO_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LO_LBN 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LO_WIDTH 32
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_HI_OFST 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_HI_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_HI_LBN 32
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_HI_WIDTH 32
+/* See structuredef: MAE_LINK_ENDPOINT_SELECTOR */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FLAT_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FLAT_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_TYPE_OFST 3
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_TYPE_LEN 1
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_MPORT_ID_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_MPORT_ID_LEN 3
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_PPORT_ID_LBN 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_PPORT_ID_WIDTH 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_LBN 20
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_WIDTH 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_LBN 16
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_WIDTH 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_OFST 2
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_LEN 1
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_LEN 2
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LINK_END_OFST 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_LINK_END_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LEN 8
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LO_OFST 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LO_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LO_LBN 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_LO_WIDTH 32
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_HI_OFST 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_HI_LEN 4
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_HI_LBN 32
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_TARGET_FLAT_HI_WIDTH 32
+/* Traffic direction to query. */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_DIRECTION_OFST 8
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+/* The number of FIFOs being configured. FIFOs assigned to the port but not
+ * included in the list are assumed to retain their current delay
+ * configuration.
+ */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_NUM_FIFOS_OFST 12
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_DELAY_PARAMS structures, NUM_FIFOS items long. */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_OFST 16
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_LEN 16
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_MINNUM 0
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_MAXNUM 14
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_MAXNUM_MCDI2 62
+
+/* MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT msgresponse */
+#define	MC_CMD_SET_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LEN 0
+
+/* MC_CMD_MAC_FLAGS structuredef */
+#define	MC_CMD_MAC_FLAGS_LEN 4
+/* The enums defined in this field are used as indices into the
+ * MC_CMD_MAC_FLAGS bitmask.
+ */
+#define	MC_CMD_MAC_FLAGS_MASK_OFST 0
+#define	MC_CMD_MAC_FLAGS_MASK_LEN 4
+/* enum property: bitshift */
+/* enum: Include the FCS in the packet data delivered to the host. Ignored if
+ * RX_INCLUDE_FCS not set in capabilities.
+ */
+#define	MC_CMD_MAC_FLAGS_FLAG_INCLUDE_FCS 0x0
+#define	MC_CMD_MAC_FLAGS_MASK_LBN 0
+#define	MC_CMD_MAC_FLAGS_MASK_WIDTH 32
+
+/* MC_CMD_TRANSMISSION_MODE structuredef */
+#define	MC_CMD_TRANSMISSION_MODE_LEN 4
+#define	MC_CMD_TRANSMISSION_MODE_MASK_OFST 0
+#define	MC_CMD_TRANSMISSION_MODE_MASK_LEN 4
+/* enum property: value */
+#define	MC_CMD_TRANSMISSION_MODE_PROMSC_MODE 0x0 /* enum */
+#define	MC_CMD_TRANSMISSION_MODE_UNCST_MODE 0x1 /* enum */
+#define	MC_CMD_TRANSMISSION_MODE_BRDCST_MODE 0x2 /* enum */
+#define	MC_CMD_TRANSMISSION_MODE_MASK_LBN 0
+#define	MC_CMD_TRANSMISSION_MODE_MASK_WIDTH 32
+
+/* MC_CMD_MAC_CONFIG_OPTIONS structuredef */
+#define	MC_CMD_MAC_CONFIG_OPTIONS_LEN 4
+#define	MC_CMD_MAC_CONFIG_OPTIONS_MASK_OFST 0
+#define	MC_CMD_MAC_CONFIG_OPTIONS_MASK_LEN 4
+/* enum property: bitmask */
+/* enum: Configure the MAC address. */
+#define	MC_CMD_MAC_CONFIG_OPTIONS_CFG_ADDR 0x0
+/* enum: Configure the maximum frame length. */
+#define	MC_CMD_MAC_CONFIG_OPTIONS_CFG_MAX_FRAME_LEN 0x1
+/* enum: Configure flow control. */
+#define	MC_CMD_MAC_CONFIG_OPTIONS_CFG_FCNTL 0x2
+/* enum: Configure the transmission mode. */
+#define	MC_CMD_MAC_CONFIG_OPTIONS_CFG_TRANSMISSION_MODE 0x3
+/* enum: Configure FCS. */
+#define	MC_CMD_MAC_CONFIG_OPTIONS_CFG_INCLUDE_FCS 0x4
+#define	MC_CMD_MAC_CONFIG_OPTIONS_MASK_LBN 0
+#define	MC_CMD_MAC_CONFIG_OPTIONS_MASK_WIDTH 32
+
+
+/***********************************/
+/* MC_CMD_MAC_CTRL
+ * Set MAC configuration. Return code: 0, EINVAL, ENOTSUP
+ */
+#define	MC_CMD_MAC_CTRL 0x1df
+#define	MC_CMD_MAC_CTRL_MSGSET 0x1df
+#undef	MC_CMD_0x1df_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1df_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_MAC_CTRL_IN msgrequest */
+#define	MC_CMD_MAC_CTRL_IN_LEN 32
+/* Handle for selected network port. */
+#define	MC_CMD_MAC_CTRL_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_MAC_CTRL_IN_PORT_HANDLE_LEN 4
+/* Select which parameters to configure. A parameter will only be modified if
+ * the corresponding control flag is set.
+ */
+#define	MC_CMD_MAC_CTRL_IN_CONTROL_FLAGS_OFST 4
+#define	MC_CMD_MAC_CTRL_IN_CONTROL_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_MAC_CONFIG_OPTIONS/MASK */
+/* MAC address of the device. */
+#define	MC_CMD_MAC_CTRL_IN_ADDR_OFST 8
+#define	MC_CMD_MAC_CTRL_IN_ADDR_LEN 8
+#define	MC_CMD_MAC_CTRL_IN_ADDR_LO_OFST 8
+#define	MC_CMD_MAC_CTRL_IN_ADDR_LO_LEN 4
+#define	MC_CMD_MAC_CTRL_IN_ADDR_LO_LBN 64
+#define	MC_CMD_MAC_CTRL_IN_ADDR_LO_WIDTH 32
+#define	MC_CMD_MAC_CTRL_IN_ADDR_HI_OFST 12
+#define	MC_CMD_MAC_CTRL_IN_ADDR_HI_LEN 4
+#define	MC_CMD_MAC_CTRL_IN_ADDR_HI_LBN 96
+#define	MC_CMD_MAC_CTRL_IN_ADDR_HI_WIDTH 32
+/* Includes the ethernet header, optional VLAN tags, payload and FCS. */
+#define	MC_CMD_MAC_CTRL_IN_MAX_FRAME_LEN_OFST 16
+#define	MC_CMD_MAC_CTRL_IN_MAX_FRAME_LEN_LEN 4
+/* Settings for flow control. */
+#define	MC_CMD_MAC_CTRL_IN_FCNTL_OFST 20
+#define	MC_CMD_MAC_CTRL_IN_FCNTL_LEN 4
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_FCNTL/MASK */
+/* Configure the MAC to transmit in one of promiscuous, unicast or broadcast
+ * mode.
+ */
+#define	MC_CMD_MAC_CTRL_IN_TRANSMISSION_MODE_OFST 24
+#define	MC_CMD_MAC_CTRL_IN_TRANSMISSION_MODE_LEN 4
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_TRANSMISSION_MODE/MASK */
+/* Flags to control and expand the configuration of the MAC. */
+#define	MC_CMD_MAC_CTRL_IN_FLAGS_OFST 28
+#define	MC_CMD_MAC_CTRL_IN_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_MAC_FLAGS/MASK */
+
+/* MC_CMD_MAC_CTRL_IN_V2 msgrequest: Updated MAC_CTRL with QBB mask */
+#define	MC_CMD_MAC_CTRL_IN_V2_LEN 33
+/* Handle for selected network port. */
+#define	MC_CMD_MAC_CTRL_IN_V2_PORT_HANDLE_OFST 0
+#define	MC_CMD_MAC_CTRL_IN_V2_PORT_HANDLE_LEN 4
+/* Select which parameters to configure. A parameter will only be modified if
+ * the corresponding control flag is set.
+ */
+#define	MC_CMD_MAC_CTRL_IN_V2_CONTROL_FLAGS_OFST 4
+#define	MC_CMD_MAC_CTRL_IN_V2_CONTROL_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_MAC_CONFIG_OPTIONS/MASK */
+/* MAC address of the device. */
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_OFST 8
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_LEN 8
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_LO_OFST 8
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_LO_LEN 4
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_LO_LBN 64
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_LO_WIDTH 32
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_HI_OFST 12
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_HI_LEN 4
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_HI_LBN 96
+#define	MC_CMD_MAC_CTRL_IN_V2_ADDR_HI_WIDTH 32
+/* Includes the ethernet header, optional VLAN tags, payload and FCS. */
+#define	MC_CMD_MAC_CTRL_IN_V2_MAX_FRAME_LEN_OFST 16
+#define	MC_CMD_MAC_CTRL_IN_V2_MAX_FRAME_LEN_LEN 4
+/* Settings for flow control. */
+#define	MC_CMD_MAC_CTRL_IN_V2_FCNTL_OFST 20
+#define	MC_CMD_MAC_CTRL_IN_V2_FCNTL_LEN 4
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_FCNTL/MASK */
+/* Configure the MAC to transmit in one of promiscuous, unicast or broadcast
+ * mode.
+ */
+#define	MC_CMD_MAC_CTRL_IN_V2_TRANSMISSION_MODE_OFST 24
+#define	MC_CMD_MAC_CTRL_IN_V2_TRANSMISSION_MODE_LEN 4
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_TRANSMISSION_MODE/MASK */
+/* Flags to control and expand the configuration of the MAC. */
+#define	MC_CMD_MAC_CTRL_IN_V2_FLAGS_OFST 28
+#define	MC_CMD_MAC_CTRL_IN_V2_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_MAC_FLAGS/MASK */
+/* Priority-based flow control mask (QBB). PRIO7 corresponds to the highest
+ * priority, and PRIO0 to the lowest. This field is only used when CFG_FCNTL is
+ * set and FCNTL is QBB
+ */
+#define	MC_CMD_MAC_CTRL_IN_V2_PRIO_FCNTL_MASK_OFST 32
+#define	MC_CMD_MAC_CTRL_IN_V2_PRIO_FCNTL_MASK_LEN 1
+/* enum property: bitmask */
+#define	MC_CMD_MAC_CTRL_IN_V2_QBB_PRIO0 0x0 /* enum */
+#define	MC_CMD_MAC_CTRL_IN_V2_QBB_PRIO1 0x1 /* enum */
+#define	MC_CMD_MAC_CTRL_IN_V2_QBB_PRIO2 0x2 /* enum */
+#define	MC_CMD_MAC_CTRL_IN_V2_QBB_PRIO3 0x3 /* enum */
+#define	MC_CMD_MAC_CTRL_IN_V2_QBB_PRIO4 0x4 /* enum */
+#define	MC_CMD_MAC_CTRL_IN_V2_QBB_PRIO5 0x5 /* enum */
+#define	MC_CMD_MAC_CTRL_IN_V2_QBB_PRIO6 0x6 /* enum */
+#define	MC_CMD_MAC_CTRL_IN_V2_QBB_PRIO7 0x7 /* enum */
+
+/* MC_CMD_MAC_CTRL_OUT msgresponse */
+#define	MC_CMD_MAC_CTRL_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_MAC_STATE
+ * Read the MAC state. Return code: 0, ETIME.
+ */
+#define	MC_CMD_MAC_STATE 0x1e0
+#define	MC_CMD_MAC_STATE_MSGSET 0x1e0
+#undef	MC_CMD_0x1e0_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e0_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_MAC_STATE_IN msgrequest */
+#define	MC_CMD_MAC_STATE_IN_LEN 4
+/* Handle for selected network port. */
+#define	MC_CMD_MAC_STATE_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_MAC_STATE_IN_PORT_HANDLE_LEN 4
+
+/* MC_CMD_MAC_STATE_OUT msgresponse */
+#define	MC_CMD_MAC_STATE_OUT_LEN 32
+/* The configured maximum frame length of the MAC. */
+#define	MC_CMD_MAC_STATE_OUT_MAX_FRAME_LEN_OFST 0
+#define	MC_CMD_MAC_STATE_OUT_MAX_FRAME_LEN_LEN 4
+/* This returns the negotiated flow control value. */
+#define	MC_CMD_MAC_STATE_OUT_FCNTL_OFST 4
+#define	MC_CMD_MAC_STATE_OUT_FCNTL_LEN 4
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_FCNTL/MASK */
+/* MAC address of the device. */
+#define	MC_CMD_MAC_STATE_OUT_ADDR_OFST 8
+#define	MC_CMD_MAC_STATE_OUT_ADDR_LEN 8
+#define	MC_CMD_MAC_STATE_OUT_ADDR_LO_OFST 8
+#define	MC_CMD_MAC_STATE_OUT_ADDR_LO_LEN 4
+#define	MC_CMD_MAC_STATE_OUT_ADDR_LO_LBN 64
+#define	MC_CMD_MAC_STATE_OUT_ADDR_LO_WIDTH 32
+#define	MC_CMD_MAC_STATE_OUT_ADDR_HI_OFST 12
+#define	MC_CMD_MAC_STATE_OUT_ADDR_HI_LEN 4
+#define	MC_CMD_MAC_STATE_OUT_ADDR_HI_LBN 96
+#define	MC_CMD_MAC_STATE_OUT_ADDR_HI_WIDTH 32
+/* Flags indicating MAC faults. */
+#define	MC_CMD_MAC_STATE_OUT_MAC_FAULT_FLAGS_OFST 16
+#define	MC_CMD_MAC_STATE_OUT_MAC_FAULT_FLAGS_LEN 4
+/* enum property: bitshift */
+/* enum: Indicates a local MAC fault. */
+#define	MC_CMD_MAC_STATE_OUT_LOCAL 0x0
+/* enum: Indicates a remote MAC fault. */
+#define	MC_CMD_MAC_STATE_OUT_REMOTE 0x1
+/* enum: Indicates a pending reconfiguration of the MAC. */
+#define	MC_CMD_MAC_STATE_OUT_PENDING_RECONFIG 0x2
+/* The flags that were used to configure the MAC. This is a copy of the FLAGS
+ * field in the MC_CMD_MAC_CTRL_IN command.
+ */
+#define	MC_CMD_MAC_STATE_OUT_FLAGS_OFST 20
+#define	MC_CMD_MAC_STATE_OUT_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_MAC_FLAGS/MASK */
+/* The transmission mode that was used to configure the MAC. This is a copy of
+ * the TRANSMISSION_MODE field in the MC_CMD_MAC_CTRL_IN command.
+ */
+#define	MC_CMD_MAC_STATE_OUT_TRANSMISSION_MODE_OFST 24
+#define	MC_CMD_MAC_STATE_OUT_TRANSMISSION_MODE_LEN 4
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_TRANSMISSION_MODE/MASK */
+/* The control flags that were used to configure the MAC. This is a copy of the
+ * CONTROL field in the MC_CMD_MAC_CTRL_IN command.
+ */
+#define	MC_CMD_MAC_STATE_OUT_CONTROL_FLAGS_OFST 28
+#define	MC_CMD_MAC_STATE_OUT_CONTROL_FLAGS_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_MAC_CONFIG_OPTIONS/MASK */
+
+
+/***********************************/
+/* MC_CMD_GET_MPORT_HANDLE
+ * Obtain a handle to an mport identified by the provided target. Return code:
+ * 0, ENOENT
+ */
+#define	MC_CMD_GET_MPORT_HANDLE 0x1e1
+#define	MC_CMD_GET_MPORT_HANDLE_MSGSET 0x1e1
+#undef	MC_CMD_0x1e1_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e1_PRIVILEGE_CTG SRIOV_CTG_MAE
+
+/* MC_CMD_GET_MPORT_HANDLE_IN msgrequest */
+#define	MC_CMD_GET_MPORT_HANDLE_IN_LEN 4
+/* Virtual port to get handle for. This uses the MAE_LINK_ENDPOINT_SELECTOR
+ * which identifies a real or virtual network port by MAE port and link end.
+ */
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_OFST 0
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_LEN 4
+/* See structuredef: MAE_LINK_ENDPOINT_SELECTOR */
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_OFST 0
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_LEN 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FLAT_OFST 0
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FLAT_LEN 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_TYPE_OFST 3
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_TYPE_LEN 1
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_MPORT_ID_OFST 0
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_MPORT_ID_LEN 3
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_PPORT_ID_LBN 0
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_PPORT_ID_WIDTH 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_LBN 20
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FUNC_INTF_ID_WIDTH 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_LBN 16
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FUNC_MH_PF_ID_WIDTH 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_OFST 2
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FUNC_PF_ID_LEN 1
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_OFST 0
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_MPORT_SELECTOR_FUNC_VF_ID_LEN 2
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_LINK_END_OFST 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_LINK_END_LEN 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_OFST 0
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_LEN 8
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_LO_OFST 0
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_LO_LEN 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_LO_LBN 0
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_LO_WIDTH 32
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_HI_OFST 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_HI_LEN 4
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_HI_LBN 32
+#define	MC_CMD_GET_MPORT_HANDLE_IN_TARGET_FLAT_HI_WIDTH 32
+
+/* MC_CMD_GET_MPORT_HANDLE_OUT msgresponse */
+#define	MC_CMD_GET_MPORT_HANDLE_OUT_LEN 4
+/* Handle for selected mport. */
+#define	MC_CMD_GET_MPORT_HANDLE_OUT_PORT_HANDLE_OFST 0
+#define	MC_CMD_GET_MPORT_HANDLE_OUT_PORT_HANDLE_LEN 4
+
+
+/***********************************/
+/* MC_CMD_GET_ASSIGNED_PORT_HANDLE
+ * Obtain a handle that can be operated on to configure and query the status of
+ * the link. ENOENT is returned when no port is assigned to the client. Return
+ * code: 0, ENOENT
+ */
+#define	MC_CMD_GET_ASSIGNED_PORT_HANDLE 0x1e2
+#define	MC_CMD_GET_ASSIGNED_PORT_HANDLE_MSGSET 0x1e2
+#undef	MC_CMD_0x1e2_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e2_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_GET_ASSIGNED_PORT_HANDLE_IN msgrequest */
+#define	MC_CMD_GET_ASSIGNED_PORT_HANDLE_IN_LEN 0
+
+/* MC_CMD_GET_ASSIGNED_PORT_HANDLE_OUT msgresponse */
+#define	MC_CMD_GET_ASSIGNED_PORT_HANDLE_OUT_LEN 4
+/* Handle for assigned port. */
+#define	MC_CMD_GET_ASSIGNED_PORT_HANDLE_OUT_PORT_HANDLE_OFST 0
+#define	MC_CMD_GET_ASSIGNED_PORT_HANDLE_OUT_PORT_HANDLE_LEN 4
+
+/* MC_CMD_STAT_ID structuredef */
+#define	MC_CMD_STAT_ID_LEN 4
+#define	MC_CMD_STAT_ID_SOURCE_ID_OFST 0
+#define	MC_CMD_STAT_ID_SOURCE_ID_LEN 2
+/* enum property: index */
+/* enum: Internal markers (generation start and end markers) */
+#define	MC_CMD_STAT_ID_MARKER 0x1
+/* enum: Network port MAC statistics. */
+#define	MC_CMD_STAT_ID_MAC 0x2
+/* enum: Network port PHY statistics. */
+#define	MC_CMD_STAT_ID_PHY 0x3
+#define	MC_CMD_STAT_ID_SOURCE_ID_LBN 0
+#define	MC_CMD_STAT_ID_SOURCE_ID_WIDTH 16
+#define	MC_CMD_STAT_ID_MARKER_STAT_ID_OFST 2
+#define	MC_CMD_STAT_ID_MARKER_STAT_ID_LEN 2
+/* enum property: index */
+/* enum: This value is used to mark the start of a generation of statistics for
+ * DMA synchronization. It is incremented whenever a new set of statistics is
+ * transferred. Always the first entry in the DMA buffer.
+ */
+#define	MC_CMD_STAT_ID_GENERATION_START 0x1
+/* enum: This value is used to mark the end of a generation of statistics for
+ * DMA synchronizaion. Always the last entry in the DMA buffer and set to the
+ * same value as GENERATION_START. The host driver must compare the
+ * GENERATION_START and GENERATION_END values to verify that the DMA buffer is
+ * consistent upon copying the the DMA buffer. If they do not match, it means
+ * that new DMA transfer has started while the host driver was copying the DMA
+ * buffer. In this case, the host driver must repeat the copy operation.
+ */
+#define	MC_CMD_STAT_ID_GENERATION_END 0x2
+#define	MC_CMD_STAT_ID_MARKER_STAT_ID_LBN 16
+#define	MC_CMD_STAT_ID_MARKER_STAT_ID_WIDTH 16
+#define	MC_CMD_STAT_ID_MAC_STAT_ID_OFST 2
+#define	MC_CMD_STAT_ID_MAC_STAT_ID_LEN 2
+/* enum property: index */
+/* enum: Total number of packets transmitted (includes pause frames). */
+#define	MC_CMD_STAT_ID_TX_PKTS 0x1
+/* enum: Pause frames transmitted. */
+#define	MC_CMD_STAT_ID_TX_PAUSE_PKTS 0x2
+/* enum: Control frames transmitted. */
+#define	MC_CMD_STAT_ID_TX_CONTROL_PKTS 0x3
+/* enum: Unicast packets transmitted (includes pause frames). */
+#define	MC_CMD_STAT_ID_TX_UNICAST_PKTS 0x4
+/* enum: Multicast packets transmitted (includes pause frames). */
+#define	MC_CMD_STAT_ID_TX_MULTICAST_PKTS 0x5
+/* enum: Broadcast packets transmitted (includes pause frames). */
+#define	MC_CMD_STAT_ID_TX_BROADCAST_PKTS 0x6
+/* enum: Bytes transmitted (includes pause frames). */
+#define	MC_CMD_STAT_ID_TX_BYTES 0x7
+/* enum: Bytes transmitted with bad CRC. */
+#define	MC_CMD_STAT_ID_TX_BAD_BYTES 0x8
+/* enum: Bytes transmitted with good CRC. */
+#define	MC_CMD_STAT_ID_TX_GOOD_BYTES 0x9
+/* enum: Packets transmitted with length less than 64 bytes. */
+#define	MC_CMD_STAT_ID_TX_LT64_PKTS 0xa
+/* enum: Packets transmitted with length equal to 64 bytes. */
+#define	MC_CMD_STAT_ID_TX_64_PKTS 0xb
+/* enum: Packets transmitted with length between 65 and 127 bytes. */
+#define	MC_CMD_STAT_ID_TX_65_TO_127_PKTS 0xc
+/* enum: Packets transmitted with length between 128 and 255 bytes. */
+#define	MC_CMD_STAT_ID_TX_128_TO_255_PKTS 0xd
+/* enum: Packets transmitted with length between 256 and 511 bytes. */
+#define	MC_CMD_STAT_ID_TX_256_TO_511_PKTS 0xe
+/* enum: Packets transmitted with length between 512 and 1023 bytes. */
+#define	MC_CMD_STAT_ID_TX_512_TO_1023_PKTS 0xf
+/* enum: Packets transmitted with length between 1024 and 1518 bytes. */
+#define	MC_CMD_STAT_ID_TX_1024_TO_15XX_PKTS 0x10
+/* enum: Packets transmitted with length between 1519 and 9216 bytes. */
+#define	MC_CMD_STAT_ID_TX_15XX_TO_JUMBO_PKTS 0x11
+/* enum: Packets transmitted with length greater than 9216 bytes. */
+#define	MC_CMD_STAT_ID_TX_GTJUMBO_PKTS 0x12
+/* enum: Packets transmitted with bad FCS. */
+#define	MC_CMD_STAT_ID_TX_BAD_FCS_PKTS 0x13
+/* enum: Packets transmitted with good FCS. */
+#define	MC_CMD_STAT_ID_TX_GOOD_FCS_PKTS 0x14
+/* enum: Packets received. */
+#define	MC_CMD_STAT_ID_RX_PKTS 0x15
+/* enum: Pause frames received. */
+#define	MC_CMD_STAT_ID_RX_PAUSE_PKTS 0x16
+/* enum: Total number of good packets received. */
+#define	MC_CMD_STAT_ID_RX_GOOD_PKTS 0x17
+/* enum: Total number of BAD packets received. */
+#define	MC_CMD_STAT_ID_RX_BAD_PKTS 0x18
+/* enum: Total number of control frames received. */
+#define	MC_CMD_STAT_ID_RX_CONTROL_PKTS 0x19
+/* enum: Total number of unicast packets received. */
+#define	MC_CMD_STAT_ID_RX_UNICAST_PKTS 0x1a
+/* enum: Total number of multicast packets received. */
+#define	MC_CMD_STAT_ID_RX_MULTICAST_PKTS 0x1b
+/* enum: Total number of broadcast packets received. */
+#define	MC_CMD_STAT_ID_RX_BROADCAST_PKTS 0x1c
+/* enum: Total number of bytes received. */
+#define	MC_CMD_STAT_ID_RX_BYTES 0x1d
+/* enum: Total number of bytes received with bad CRC. */
+#define	MC_CMD_STAT_ID_RX_BAD_BYTES 0x1e
+/* enum: Total number of bytes received with GOOD CRC. */
+#define	MC_CMD_STAT_ID_RX_GOOD_BYTES 0x1f
+/* enum: Packets received with length equal to 64 bytes. */
+#define	MC_CMD_STAT_ID_RX_64_PKTS 0x20
+/* enum: Packets received with length between 65 and 127 bytes. */
+#define	MC_CMD_STAT_ID_RX_65_TO_127_PKTS 0x21
+/* enum: Packets received with length between 128 and 255 bytes. */
+#define	MC_CMD_STAT_ID_RX_128_TO_255_PKTS 0x22
+/* enum: Packets received with length between 256 and 511 bytes. */
+#define	MC_CMD_STAT_ID_RX_256_TO_511_PKTS 0x23
+/* enum: Packets received with length between 512 and 1023 bytes. */
+#define	MC_CMD_STAT_ID_RX_512_TO_1023_PKTS 0x24
+/* enum: Packets received with length between 1024 and 1518 bytes. */
+#define	MC_CMD_STAT_ID_RX_1024_TO_15XX_PKTS 0x25
+/* enum: Packets received with length between 1519 and 9216 bytes. */
+#define	MC_CMD_STAT_ID_RX_15XX_TO_JUMBO_PKTS 0x26
+/* enum: Packets received with length greater than 9216 bytes. */
+#define	MC_CMD_STAT_ID_RX_GTJUMBO_PKTS 0x27
+/* enum: Packets received with length less than 64 bytes. */
+#define	MC_CMD_STAT_ID_RX_UNDERSIZE_PKTS 0x28
+/* enum: Packets received with bad FCS. */
+#define	MC_CMD_STAT_ID_RX_BAD_FCS_PKTS 0x29
+/* enum: Packets received with GOOD FCS. */
+#define	MC_CMD_STAT_ID_RX_GOOD_FCS_PKTS 0x2a
+/* enum: Packets received with overflow. */
+#define	MC_CMD_STAT_ID_RX_OVERFLOW_PKTS 0x2b
+/* enum: Packets received with symbol error. */
+#define	MC_CMD_STAT_ID_RX_SYMBOL_ERROR_PKTS 0x2c
+/* enum: Packets received with alignment error. */
+#define	MC_CMD_STAT_ID_RX_ALIGN_ERROR_PKTS 0x2d
+/* enum: Packets received with length error. */
+#define	MC_CMD_STAT_ID_RX_LENGTH_ERROR_PKTS 0x2e
+/* enum: Packets received with internal error. */
+#define	MC_CMD_STAT_ID_RX_INTERNAL_ERROR_PKTS 0x2f
+/* enum: Packets received with jabber. These packets are larger than the
+ * allowed maximum receive unit (MRU). This indicates that a packet either has
+ * a bad CRC or has an RX error.
+ */
+#define	MC_CMD_STAT_ID_RX_JABBER_PKTS 0x30
+/* enum: Packets dropped due to having no descriptor. This is a datapath stat
+ */
+#define	MC_CMD_STAT_ID_RX_NODESC_DROPS 0x31
+/* enum: Packets received with lanes 0 and 1 character error. */
+#define	MC_CMD_STAT_ID_RX_LANES01_CHAR_ERR 0x32
+/* enum: Packets received with lanes 2 and 3 character error. */
+#define	MC_CMD_STAT_ID_RX_LANES23_CHAR_ERR 0x33
+/* enum: Packets received with lanes 0 and 1 disparity error. */
+#define	MC_CMD_STAT_ID_RX_LANES01_DISP_ERR 0x34
+/* enum: Packets received with lanes 2 and 3 disparity error. */
+#define	MC_CMD_STAT_ID_RX_LANES23_DISP_ERR 0x35
+/* enum: Packets received with match fault. */
+#define	MC_CMD_STAT_ID_RX_MATCH_FAULT 0x36
+#define	MC_CMD_STAT_ID_MAC_STAT_ID_LBN 16
+#define	MC_CMD_STAT_ID_MAC_STAT_ID_WIDTH 16
+/* Include FEC stats. */
+#define	MC_CMD_STAT_ID_PHY_STAT_ID_OFST 2
+#define	MC_CMD_STAT_ID_PHY_STAT_ID_LEN 2
+/* enum property: index */
+/* enum: Number of uncorrected FEC codewords on link (RS-FEC only from Medford2
+ * onwards)
+ */
+#define	MC_CMD_STAT_ID_FEC_UNCORRECTED_ERRORS 0x1
+/* enum: Number of corrected FEC codewords on link (RS-FEC only from Medford2
+ * onwards)
+ */
+#define	MC_CMD_STAT_ID_FEC_CORRECTED_ERRORS 0x2
+/* enum: Number of corrected 10-bit symbol errors, lane 0 (RS-FEC only) */
+#define	MC_CMD_STAT_ID_FEC_CORRECTED_SYMBOLS_LANE0 0x3
+/* enum: Number of corrected 10-bit symbol errors, lane 1 (RS-FEC only) */
+#define	MC_CMD_STAT_ID_FEC_CORRECTED_SYMBOLS_LANE1 0x4
+/* enum: Number of corrected 10-bit symbol errors, lane 2 (RS-FEC only) */
+#define	MC_CMD_STAT_ID_FEC_CORRECTED_SYMBOLS_LANE2 0x5
+/* enum: Number of corrected 10-bit symbol errors, lane 3 (RS-FEC only) */
+#define	MC_CMD_STAT_ID_FEC_CORRECTED_SYMBOLS_LANE3 0x6
+#define	MC_CMD_STAT_ID_PHY_STAT_ID_LBN 16
+#define	MC_CMD_STAT_ID_PHY_STAT_ID_WIDTH 16
+
+/* MC_CMD_STAT_DESC structuredef: Structure describing the layout and size of
+ * the stats DMA buffer descriptor.
+ */
+#define	MC_CMD_STAT_DESC_LEN 8
+/* Unique identifier of the statistic. Formatted as MC_CMD_STAT_ID */
+#define	MC_CMD_STAT_DESC_STAT_ID_OFST 0
+#define	MC_CMD_STAT_DESC_STAT_ID_LEN 4
+#define	MC_CMD_STAT_DESC_STAT_ID_LBN 0
+#define	MC_CMD_STAT_DESC_STAT_ID_WIDTH 32
+/* See structuredef: MC_CMD_STAT_ID */
+#define	MC_CMD_STAT_DESC_STAT_ID_SOURCE_ID_OFST 0
+#define	MC_CMD_STAT_DESC_STAT_ID_SOURCE_ID_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_ID_SOURCE_ID_LBN 0
+#define	MC_CMD_STAT_DESC_STAT_ID_SOURCE_ID_WIDTH 16
+#define	MC_CMD_STAT_DESC_STAT_ID_MARKER_STAT_ID_OFST 2
+#define	MC_CMD_STAT_DESC_STAT_ID_MARKER_STAT_ID_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_ID_MARKER_STAT_ID_LBN 16
+#define	MC_CMD_STAT_DESC_STAT_ID_MARKER_STAT_ID_WIDTH 16
+#define	MC_CMD_STAT_DESC_STAT_ID_MAC_STAT_ID_OFST 2
+#define	MC_CMD_STAT_DESC_STAT_ID_MAC_STAT_ID_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_ID_MAC_STAT_ID_LBN 16
+#define	MC_CMD_STAT_DESC_STAT_ID_MAC_STAT_ID_WIDTH 16
+#define	MC_CMD_STAT_DESC_STAT_ID_PHY_STAT_ID_OFST 2
+#define	MC_CMD_STAT_DESC_STAT_ID_PHY_STAT_ID_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_ID_PHY_STAT_ID_LBN 16
+#define	MC_CMD_STAT_DESC_STAT_ID_PHY_STAT_ID_WIDTH 16
+/* Index of the statistic in the DMA buffer. */
+#define	MC_CMD_STAT_DESC_STAT_INDEX_OFST 4
+#define	MC_CMD_STAT_DESC_STAT_INDEX_LEN 2
+#define	MC_CMD_STAT_DESC_STAT_INDEX_LBN 32
+#define	MC_CMD_STAT_DESC_STAT_INDEX_WIDTH 16
+/* Reserved for future extension (e.g. flags field) - currently always 0. */
+#define	MC_CMD_STAT_DESC_RESERVED_OFST 6
+#define	MC_CMD_STAT_DESC_RESERVED_LEN 2
+#define	MC_CMD_STAT_DESC_RESERVED_LBN 48
+#define	MC_CMD_STAT_DESC_RESERVED_WIDTH 16
+
+
+/***********************************/
+/* MC_CMD_MAC_STATISTICS_DESCRIPTOR
+ * Get a list of descriptors that describe the layout and size of the stats
+ * buffer required for retrieving statistics for a given port. Each entry in
+ * the list is formatted as MC_CMD_STAT_DESC and provides the ID of each stat
+ * and its location and size in the buffer. It also gives the overall minimum
+ * size of the DMA buffer required when DMA mode is used. Note that the first
+ * and last entries in the list are reserved for the generation start
+ * (MC_CMD_MARKER_STAT_GENERATION_START) and end
+ * (MC_CMD_MARKER_STAT_GENERATION_END) markers respectively, to be used for DMA
+ * synchronisation as described in the documentation for the relevant enum
+ * entries. The entries are present in the buffer even if DMA mode is not used.
+ * Provisions are made (but currently unused) for extending the size of the
+ * descriptors, extending the size of the list beyond the maximum MCDI response
+ * size, as well as the dynamic runtime updates of the list. Returns: 0 on
+ * success, ENOENT on non-existent port handle
+ */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR 0x1e3
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_MSGSET 0x1e3
+#undef	MC_CMD_0x1e3_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e3_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN msgrequest */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_LEN 8
+/* Handle of port to get MAC statitstics descriptors for. */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_PORT_HANDLE_LEN 4
+/* Offset of the first entry to return, for cases where not all entries fit in
+ * the MCDI response. Should be set to 0 on initial request, and on subsequent
+ * requests updated by the number of entries already returned, as long as the
+ * MORE_ENTRIES flag is set.
+ */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_OFFSET_OFST 4
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_IN_OFFSET_LEN 4
+
+/* MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT msgresponse */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMIN 28
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX 252
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_LEN(num) (20+8*(num))
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_NUM(len) (((len)-20)/8)
+/* Generation number of the stats buffer. This is incremented each time the
+ * buffer is updated, and is used to verify the consistency of the buffer
+ * contents. Reserved for future extension (dynamic list updates). Currently
+ * always set to 0.
+ */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_GENERATION_OFST 0
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_GENERATION_LEN 4
+/* Minimum size of the DMA buffer required to retrieve all statistics for the
+ * port. This is the sum of the sizes of all the statistics, plus the size of
+ * the generation markers. Minimum buffer size in bytes required to fit all
+ * statistics. Drivers will typically round up this value to the granularity of
+ * the host DMA allocation units.
+ */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_DMA_BUFFER_SIZE_OFST 4
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_DMA_BUFFER_SIZE_LEN 4
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_FLAGS_OFST 8
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_FLAGS_LEN 4
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_MORE_ENTRIES_OFST 8
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_MORE_ENTRIES_LBN 0
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_MORE_ENTRIES_WIDTH 1
+/* Size of the individual descriptor entry in the list. Determines the entry
+ * stride in the list. Currently always set to size of MC_CMD_STAT_DESC, larger
+ * values can be used in the future for extending the descriptor, by appending
+ * new data to the end of the existing structure.
+ */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_SIZE_OFST 12
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_SIZE_LEN 4
+/* Number of entries returned in the descriptor list. */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_COUNT_OFST 16
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRY_COUNT_LEN 4
+/* List of descriptors. Each entry is formatted as MC_CMD_STAT_DESC and
+ * provides the ID of each stat and its location and size in the buffer. The
+ * first and last entries are reserved for the generation start and end markers
+ * respectively.
+ */
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_OFST 20
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_LEN 8
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_LO_OFST 20
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_LO_LEN 4
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_LO_LBN 160
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_LO_WIDTH 32
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_HI_OFST 24
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_HI_LEN 4
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_HI_LBN 192
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_HI_WIDTH 32
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_MINNUM 1
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_MAXNUM 29
+#define	MC_CMD_MAC_STATISTICS_DESCRIPTOR_OUT_ENTRIES_MAXNUM_MCDI2 125
+
+
+/***********************************/
+/* MC_CMD_MAC_STATISTICS
+ * Get generic MAC statistics. This call retrieves unified statistics managed
+ * by the MC. The MC will populate and provide all supported statistics in the
+ * format as returned by MC_CMD_MAC_STATISTICS_DESCRIPTOR. Refer to the
+ * aforementioned command for the format and contents of the stats DMA buffer.
+ * To ensure consistent and accurate results, it is essential for the driver to
+ * initialize the DMA buffer with zeros when DMA mode is used. Returns: 0 on
+ * success, ETIME if the DMA buffer is not ready, ENOENT on non-existent port
+ * handle, and EINVAL on invalid parameters (DMA buffer too small)
+ */
+#define	MC_CMD_MAC_STATISTICS 0x1e4
+#define	MC_CMD_MAC_STATISTICS_MSGSET 0x1e4
+#undef	MC_CMD_0x1e4_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e4_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_MAC_STATISTICS_IN msgrequest */
+#define	MC_CMD_MAC_STATISTICS_IN_LEN 20
+/* Handle of port to get MAC statistics for. */
+#define	MC_CMD_MAC_STATISTICS_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_MAC_STATISTICS_IN_PORT_HANDLE_LEN 4
+/* Contains options for querying the MAC statistics. */
+#define	MC_CMD_MAC_STATISTICS_IN_CMD_OFST 4
+#define	MC_CMD_MAC_STATISTICS_IN_CMD_LEN 4
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_OFST 4
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_LBN 0
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_WIDTH 1
+#define	MC_CMD_MAC_STATISTICS_IN_CLEAR_OFST 4
+#define	MC_CMD_MAC_STATISTICS_IN_CLEAR_LBN 1
+#define	MC_CMD_MAC_STATISTICS_IN_CLEAR_WIDTH 1
+#define	MC_CMD_MAC_STATISTICS_IN_PERIODIC_CHANGE_OFST 4
+#define	MC_CMD_MAC_STATISTICS_IN_PERIODIC_CHANGE_LBN 2
+#define	MC_CMD_MAC_STATISTICS_IN_PERIODIC_CHANGE_WIDTH 1
+#define	MC_CMD_MAC_STATISTICS_IN_PERIODIC_ENABLE_OFST 4
+#define	MC_CMD_MAC_STATISTICS_IN_PERIODIC_ENABLE_LBN 3
+#define	MC_CMD_MAC_STATISTICS_IN_PERIODIC_ENABLE_WIDTH 1
+#define	MC_CMD_MAC_STATISTICS_IN_PERIODIC_NOEVENT_OFST 4
+#define	MC_CMD_MAC_STATISTICS_IN_PERIODIC_NOEVENT_LBN 4
+#define	MC_CMD_MAC_STATISTICS_IN_PERIODIC_NOEVENT_WIDTH 1
+#define	MC_CMD_MAC_STATISTICS_IN_PERIOD_MS_OFST 4
+#define	MC_CMD_MAC_STATISTICS_IN_PERIOD_MS_LBN 16
+#define	MC_CMD_MAC_STATISTICS_IN_PERIOD_MS_WIDTH 16
+/* This is the address of the DMA buffer to use for transfer of the statistics.
+ * Only valid if the DMA flag is set to 1.
+ */
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_OFST 8
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_LEN 8
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_LO_OFST 8
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_LO_LEN 4
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_LO_LBN 64
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_LO_WIDTH 32
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_HI_OFST 12
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_HI_LEN 4
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_HI_LBN 96
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_ADDR_HI_WIDTH 32
+/* This is the length of the DMA buffer to use for the transfer of the
+ * statistics. The buffer should be at least DMA_BUFFER_SIZE long, as returned
+ * by MC_CMD_MAC_STATISTICS_DESCRIPTOR. If the supplied buffer is too small,
+ * the command will fail with EINVAL. Only valid if the DMA flag is set to 1.
+ */
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_LEN_OFST 16
+#define	MC_CMD_MAC_STATISTICS_IN_DMA_LEN_LEN 4
+
+/* MC_CMD_MAC_STATISTICS_OUT msgresponse */
+#define	MC_CMD_MAC_STATISTICS_OUT_LENMIN 5
+#define	MC_CMD_MAC_STATISTICS_OUT_LENMAX 252
+#define	MC_CMD_MAC_STATISTICS_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_MAC_STATISTICS_OUT_LEN(num) (4+1*(num))
+#define	MC_CMD_MAC_STATISTICS_OUT_DATA_NUM(len) (((len)-4)/1)
+/* length of the data in bytes */
+#define	MC_CMD_MAC_STATISTICS_OUT_DATALEN_OFST 0
+#define	MC_CMD_MAC_STATISTICS_OUT_DATALEN_LEN 4
+#define	MC_CMD_MAC_STATISTICS_OUT_DATA_OFST 4
+#define	MC_CMD_MAC_STATISTICS_OUT_DATA_LEN 1
+#define	MC_CMD_MAC_STATISTICS_OUT_DATA_MINNUM 1
+#define	MC_CMD_MAC_STATISTICS_OUT_DATA_MAXNUM 248
+#define	MC_CMD_MAC_STATISTICS_OUT_DATA_MAXNUM_MCDI2 1016
+
+/* NET_PORT_HANDLE_DESC structuredef: Network port descriptor containing a port
+ * handle and attributes used, for example, in MC_CMD_ENUM_PORTS.
+ */
+#define	NET_PORT_HANDLE_DESC_LEN 53
+/* The handle to identify the port */
+#define	NET_PORT_HANDLE_DESC_PORT_HANDLE_OFST 0
+#define	NET_PORT_HANDLE_DESC_PORT_HANDLE_LEN 4
+#define	NET_PORT_HANDLE_DESC_PORT_HANDLE_LBN 0
+#define	NET_PORT_HANDLE_DESC_PORT_HANDLE_WIDTH 32
+/* Includes the type of port e.g. physical, virtual or MAE MPORT and other
+ * properties relevant to the port.
+ */
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_OFST 4
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_LEN 8
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_LO_OFST 4
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_LO_LEN 4
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_LO_LBN 32
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_LO_WIDTH 32
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_HI_OFST 8
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_HI_LEN 4
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_HI_LBN 64
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_HI_WIDTH 32
+#define	NET_PORT_HANDLE_DESC_PORT_TYPE_OFST 4
+#define	NET_PORT_HANDLE_DESC_PORT_TYPE_LBN 0
+#define	NET_PORT_HANDLE_DESC_PORT_TYPE_WIDTH 3
+#define	NET_PORT_HANDLE_DESC_PHYSICAL 0x0 /* enum */
+#define	NET_PORT_HANDLE_DESC_VIRTUAL 0x1 /* enum */
+#define	NET_PORT_HANDLE_DESC_MPORT 0x2 /* enum */
+#define	NET_PORT_HANDLE_DESC_IS_ZOMBIE_OFST 4
+#define	NET_PORT_HANDLE_DESC_IS_ZOMBIE_LBN 8
+#define	NET_PORT_HANDLE_DESC_IS_ZOMBIE_WIDTH 1
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_LBN 32
+#define	NET_PORT_HANDLE_DESC_PORT_PROPERTIES_WIDTH 64
+/* The dynamic change that led to the port enumeration */
+#define	NET_PORT_HANDLE_DESC_ENTRY_SRC_OFST 12
+#define	NET_PORT_HANDLE_DESC_ENTRY_SRC_LEN 1
+/* enum: Indicates that the ENTRY_SRC field has not been initialized. */
+#define	NET_PORT_HANDLE_DESC_UNKNOWN 0x0
+/* enum: The port was enumerated at start of day. */
+#define	NET_PORT_HANDLE_DESC_PRESENT 0x1
+/* enum: The port was dynamically added. */
+#define	NET_PORT_HANDLE_DESC_ADDED 0x2
+/* enum: The port was dynamically deleted. */
+#define	NET_PORT_HANDLE_DESC_DELETED 0x3
+#define	NET_PORT_HANDLE_DESC_ENTRY_SRC_LBN 96
+#define	NET_PORT_HANDLE_DESC_ENTRY_SRC_WIDTH 8
+/* This is an opaque 40 byte label exposed to users as a unique identifier of
+ * the port. It is represented as a zero-terminated ASCII string and assigned
+ * by the port administrator which is typically either the firmware for a
+ * physical port or the host software responsible for creating the virtual
+ * port. The label is conveyed to the driver after assignment, which, unlike
+ * the port administrator, does not need to know how to interpret the label.
+ */
+#define	NET_PORT_HANDLE_DESC_PORT_LABEL_OFST 13
+#define	NET_PORT_HANDLE_DESC_PORT_LABEL_LEN 40
+#define	NET_PORT_HANDLE_DESC_PORT_LABEL_LBN 104
+#define	NET_PORT_HANDLE_DESC_PORT_LABEL_WIDTH 320
+
+
+/***********************************/
+/* MC_CMD_ENUM_PORTS
+ * This command returns handles for all ports present in the system. The PCIe
+ * function type of each port (either physical or virtual) is also reported.
+ * After a start-of-day port enumeration, firmware keeps track of all available
+ * ports upon creation or deletion and updates the ports if there is a change.
+ * This command is cleared after a control interface reset (e.g. FLR,
+ * ENTITY_RESET), in which case it must be called again to reenumerate the
+ * ports. The command is also clear-on-read and repeated calls will drain the
+ * buffer.
+ */
+#define	MC_CMD_ENUM_PORTS 0x1e5
+#define	MC_CMD_ENUM_PORTS_MSGSET 0x1e5
+#undef	MC_CMD_0x1e5_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e5_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_ENUM_PORTS_IN msgrequest */
+#define	MC_CMD_ENUM_PORTS_IN_LEN 0
+
+/* MC_CMD_ENUM_PORTS_OUT msgresponse */
+#define	MC_CMD_ENUM_PORTS_OUT_LENMIN 12
+#define	MC_CMD_ENUM_PORTS_OUT_LENMAX 252
+#define	MC_CMD_ENUM_PORTS_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_ENUM_PORTS_OUT_LEN(num) (12+1*(num))
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_NUM(len) (((len)-12)/1)
+/* Any unused flags are reserved and must be ignored. */
+#define	MC_CMD_ENUM_PORTS_OUT_FLAGS_OFST 0
+#define	MC_CMD_ENUM_PORTS_OUT_FLAGS_LEN 4
+#define	MC_CMD_ENUM_PORTS_OUT_MORE_OFST 0
+#define	MC_CMD_ENUM_PORTS_OUT_MORE_LBN 0
+#define	MC_CMD_ENUM_PORTS_OUT_MORE_WIDTH 1
+/* The number of NET_PORT_HANDLE_DESC structures in PORT_HANDLES. */
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_COUNT_OFST 4
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_COUNT_LEN 4
+#define	MC_CMD_ENUM_PORTS_OUT_SIZEOF_NET_PORT_HANDLE_DESC_OFST 8
+#define	MC_CMD_ENUM_PORTS_OUT_SIZEOF_NET_PORT_HANDLE_DESC_LEN 4
+/* Array of NET_PORT_HANDLE_DESC structures. Callers must use must use the
+ * SIZEOF_NET_PORT_HANDLE_DESC field field as the array stride between entries.
+ * This may also allow for tail padding for alignment. Fields beyond
+ * SIZEOF_NET_PORT_HANDLE_DESC are not present.
+ */
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_OFST 12
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_LEN 1
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_MINNUM 0
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_MAXNUM 240
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_MAXNUM_MCDI2 1008
+/* See structuredef: NET_PORT_HANDLE_DESC */
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_HANDLE_OFST 12
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_HANDLE_LEN 4
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_OFST 16
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_LEN 8
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_LO_OFST 16
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_LO_LEN 4
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_LO_LBN 128
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_LO_WIDTH 32
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_HI_OFST 20
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_HI_LEN 4
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_HI_LBN 160
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_PROPERTIES_HI_WIDTH 32
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_TYPE_LBN 128
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_TYPE_WIDTH 3
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_IS_ZOMBIE_LBN 136
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_IS_ZOMBIE_WIDTH 1
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_ENTRY_SRC_OFST 24
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_ENTRY_SRC_LEN 1
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_LABEL_OFST 25
+#define	MC_CMD_ENUM_PORTS_OUT_PORT_HANDLES_PORT_LABEL_LEN 40
+
+
+/***********************************/
+/* MC_CMD_GET_TRANSCEIVER_PROPERTIES
+ * Read properties of the transceiver associated with the port. Can be either
+ * for a fixed onboard transceiver or an inserted module. The returned data is
+ * interpreted from the transceiver hardware and may be fixed up by the
+ * firmware. Use MC_CMD_GET_MODULE_DATA to get raw undecoded data.
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES 0x1e6
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_MSGSET 0x1e6
+#undef	MC_CMD_0x1e6_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e6_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_GET_TRANSCEIVER_PROPERTIES_IN msgrequest */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_IN_LEN 4
+/* Handle to port to get transceiver properties from. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_IN_PORT_HANDLE_LEN 4
+
+/* MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT msgresponse */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_LEN 89
+/* Supported technology abilities. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_TECH_ABILITIES_MASK_OFST 0
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_TECH_ABILITIES_MASK_LEN 16
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_ETH_TECH/TECH */
+/* Reserved for future expansion to accommodate future Ethernet technology
+ * expansion.
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_RESERVED_OFST 16
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_RESERVED_LEN 16
+/* Preferred FEC modes. This is a function of the cable type and length. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_PREFERRED_FEC_MASK_OFST 32
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_PREFERRED_FEC_MASK_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               FEC_TYPE/TYPE */
+/* SFF-8042 code reported by the module. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_CODE_OFST 36
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_CODE_LEN 2
+/* Medium. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_MEDIUM_OFST 38
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_MEDIUM_LEN 1
+/* enum property: value */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_UNKNOWN 0x0 /* enum */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_COPPER 0x1 /* enum */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_OPTICAL 0x2 /* enum */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_BACKPLANE 0x3 /* enum */
+/* Identifies the tech */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_MEDIA_SUBTYPE_OFST 39
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_MEDIA_SUBTYPE_LEN 1
+/* enum property: value */
+/*               MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_UNKNOWN 0x0 */
+/* enum: Ethernet over twisted-pair copper cables for distances up to 100
+ * meters.
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_BASET 0x1
+/* enum: Ethernet over twin-axial, balanced copper cable. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_CR 0x2
+/* enum: Ethernet over backplane for connections on the same board. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_KX 0x3
+/* enum: Ethernet over a single backplane lane for connections between
+ * different boards.
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_KR 0x4
+/* enum: Ethernet over copper backplane. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_KP 0x5
+/* enum: Ethernet over fiber optic. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_BASEX 0x6
+/* enum: Short range ethernet over multimode fiber optic (See IEEE 802.3 Clause
+ * 49 and 52).
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_SR 0x7
+/* enum: Long range, extended range or far reach ethernet used with single mode
+ * fiber optics.
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_LR_ER_FR 0x8
+/* enum: Long reach multimode ethernet over multimode optical fiber. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_LRM 0x9
+/* enum: Very short reach PAM4 ethernet over multimode optical fiber (see IEEE
+ * 802.3db).
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_VR 0xa
+/* enum: BASE-R encoding and PAM4 over single-mode fiber with reach up to at
+ * least 500 meters (803.2 Clause 121 and 124)
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_DR 0xb
+/* String of the vendor name as intepreted by NMC firmware. NMC firmware
+ * applies workarounds for known buggy transceivers. The vendor name is
+ * presented as 16 bytes of ASCII characters padded with spaces. It can also be
+ * represented as 16 bytes of zeros if the field is unspecified for the
+ * connected module. See SFF-8472/CMIS specifications for details.
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_VENDOR_NAME_OFST 40
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_VENDOR_NAME_LEN 1
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_VENDOR_NAME_NUM 16
+/* The vendor part number as intepreted by NMC firmware. The field is presented
+ * as 16 bytes of ASCII chars padded with spaces. It can also be 16 bytes of
+ * zeros if the field is unspecified for the connected module.
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_VENDOR_PN_OFST 56
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_VENDOR_PN_LEN 1
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_VENDOR_PN_NUM 16
+/* Serial number of the module presented as 16 bytes of ASCII characters padded
+ * with spaces. It can also be 16 bytes of zeros if the field is unspecified
+ * for the connected module. See SFF-8472/CMIS specifications for details.
+ */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_SERIAL_NUMBER_OFST 72
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_SERIAL_NUMBER_LEN 1
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_SERIAL_NUMBER_NUM 16
+/* This reports the number of module changes detected by the NMC firmware. */
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_PORT_MODULECHANGE_SEQ_NUM_OFST 88
+#define	MC_CMD_GET_TRANSCEIVER_PROPERTIES_OUT_PORT_MODULECHANGE_SEQ_NUM_LEN 1
+
+
+/***********************************/
+/* MC_CMD_GET_FIXED_PORT_PROPERTIES
+ */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES 0x1e7
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_MSGSET 0x1e7
+#undef	MC_CMD_0x1e7_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e7_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_GET_FIXED_PORT_PROPERTIES_IN msgrequest: In this context, the port
+ * consists of the MAC and the PHY, and excludes any modules inserted into the
+ * cage. This information is fixed for a given board but not for a given ASIC.
+ * This command reports properties for the port as it is currently configured,
+ * and not its hardware capabilities, which can be better than the current
+ * configuration.
+ */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_LEN 4
+/* Handle to the port to from which to retreive properties */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_IN_PORT_HANDLE_LEN 4
+
+/* MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT msgresponse */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_LEN 36
+/* Supported capabilities of the port in its current configuration. */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_OFST 0
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_LEN 25
+/* See structuredef: MC_CMD_ETH_AN_FIELDS */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_TECH_MASK_OFST 0
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_TECH_MASK_LEN 16
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_FEC_MASK_OFST 16
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_FEC_MASK_LEN 4
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_FEC_REQ_OFST 20
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_FEC_REQ_LEN 4
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_PAUSE_MASK_OFST 24
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_ABILITIES_PAUSE_MASK_LEN 1
+/* Number of lanes supported by the port in its current configuration. */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_NUM_LANES_OFST 25
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_NUM_LANES_LEN 1
+/* Bitmask of supported loopback modes. Where the response to this command
+ * includes the LOOPBACK_MODES_MASK_V2 field, that field should be used in
+ * preference to ensure that all available loopback modes are seen.
+ */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_LOOPBACK_MODES_MASK_OFST 26
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_LOOPBACK_MODES_MASK_LEN 1
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LOOPBACK_V2/MODE */
+/* This field serves as a cage index that uniquely identifies the cage to which
+ * the module is connected. This is useful when splitter cables that have
+ * multiple ports on a single cage are used.
+ */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_MDI_INDEX_OFST 27
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_MDI_INDEX_LEN 1
+/* This bitmask is used to specify the lanes within the cage identified by
+ * MDI_INDEX that are allocated to the port.
+ */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_MDI_LANE_MASK_OFST 28
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_MDI_LANE_MASK_LEN 1
+/* Maximum frame length supported by the port in its current configuration. */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_MAX_FRAME_LEN_OFST 32
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_MAX_FRAME_LEN_LEN 4
+
+/* MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2 msgresponse */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LEN 48
+/* Supported capabilities of the port in its current configuration. */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_ABILITIES_OFST 0
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_ABILITIES_LEN 25
+/* Number of lanes supported by the port in its current configuration. */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_NUM_LANES_OFST 25
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_NUM_LANES_LEN 1
+/* Bitmask of supported loopback modes. Where the response to this command
+ * includes the LOOPBACK_MODES_MASK_V2 field, that field should be used in
+ * preference to ensure that all available loopback modes are seen.
+ */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_OFST 26
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_LEN 1
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LOOPBACK_V2/MODE */
+/* This field serves as a cage index that uniquely identifies the cage to which
+ * the module is connected. This is useful when splitter cables that have
+ * multiple ports on a single cage are used.
+ */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_MDI_INDEX_OFST 27
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_MDI_INDEX_LEN 1
+/* This bitmask is used to specify the lanes within the cage identified by
+ * MDI_INDEX that are allocated to the port.
+ */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_MDI_LANE_MASK_OFST 28
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_MDI_LANE_MASK_LEN 1
+/* Maximum frame length supported by the port in its current configuration. */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_MAX_FRAME_LEN_OFST 32
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_MAX_FRAME_LEN_LEN 4
+/* Bitmask of supported loopback modes. This field replaces the
+ * LOOPBACK_MODES_MASK field which is defined under version 1 of this command.
+ */
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_OFST 40
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_LEN 8
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_LO_OFST 40
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_LO_LEN 4
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_LO_LBN 320
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_LO_WIDTH 32
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_HI_OFST 44
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_HI_LEN 4
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_HI_LBN 352
+#define	MC_CMD_GET_FIXED_PORT_PROPERTIES_OUT_V2_LOOPBACK_MODES_MASK_V2_HI_WIDTH 32
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LOOPBACK_V2/MODE */
+
+
+/***********************************/
+/* MC_CMD_GET_MODULE_DATA
+ * Read media-specific data from the PHY (e.g. SFP/SFP+ module ID information
+ * for SFP+ PHYs). This command returns raw data from the module's EEPROM and
+ * it is not interpreted by the MC. Use MC_CMD_GET_TRANSCEIVER_PROPERTIES to
+ * get interpreted data. Return code: 0, ENOENT
+ */
+#define	MC_CMD_GET_MODULE_DATA 0x1e8
+#define	MC_CMD_GET_MODULE_DATA_MSGSET 0x1e8
+#undef	MC_CMD_0x1e8_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e8_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_GET_MODULE_DATA_IN msgrequest */
+#define	MC_CMD_GET_MODULE_DATA_IN_LEN 16
+/* Handle to identify the port from which to request module properties. */
+#define	MC_CMD_GET_MODULE_DATA_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_GET_MODULE_DATA_IN_PORT_HANDLE_LEN 4
+/* 7 bit I2C address of the device. DEPRECATED: This field is replaced by
+ * MODULE_ADDR in V2. Use V2 of this command for proper alignment and easier
+ * access.
+ */
+#define	MC_CMD_GET_MODULE_DATA_IN_DEVADDR_LBN 32
+#define	MC_CMD_GET_MODULE_DATA_IN_DEVADDR_WIDTH 7
+/* 0 if the page does not support banked access, non-zero otherwise. Non-zero
+ * BANK is valid if OFFSET is in the range 80h - ffh, i.e. in the Upper Memory
+ * region.
+ */
+#define	MC_CMD_GET_MODULE_DATA_IN_BANK_OFST 6
+#define	MC_CMD_GET_MODULE_DATA_IN_BANK_LEN 2
+/* 0 if paged access is not supported, non-zero otherwise. Non-zero PAGE is
+ * valid if OFFSET is in the range 80h - ffh.
+ */
+#define	MC_CMD_GET_MODULE_DATA_IN_PAGE_OFST 8
+#define	MC_CMD_GET_MODULE_DATA_IN_PAGE_LEN 2
+/* Offset in the range 00h - 7fh to access lower memory. Offset in the range
+ * 80h - ffh to access upper memory
+ */
+#define	MC_CMD_GET_MODULE_DATA_IN_OFFSET_OFST 10
+#define	MC_CMD_GET_MODULE_DATA_IN_OFFSET_LEN 1
+#define	MC_CMD_GET_MODULE_DATA_IN_LENGTH_OFST 12
+#define	MC_CMD_GET_MODULE_DATA_IN_LENGTH_LEN 4
+
+/* MC_CMD_GET_MODULE_DATA_IN_V2 msgrequest: Updated MC_CMD_GET_MODULE_DATA with
+ * 8-bit wide ADDRESSING field. This new field provides a correctly aligned
+ * container for the 7-bit DEVADDR field from V1, now renamed MODULE_ADDR, to
+ * ensure proper alignment.
+ */
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_LEN 16
+/* Handle to identify the port from which to request module properties. */
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_PORT_HANDLE_OFST 0
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_PORT_HANDLE_LEN 4
+/* 7 bit I2C address of the device. DEPRECATED: This field is replaced by
+ * MODULE_ADDR in V2. Use V2 of this command for proper alignment and easier
+ * access.
+ */
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_DEVADDR_LBN 32
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_DEVADDR_WIDTH 7
+/* 0 if the page does not support banked access, non-zero otherwise. Non-zero
+ * BANK is valid if OFFSET is in the range 80h - ffh, i.e. in the Upper Memory
+ * region.
+ */
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_BANK_OFST 6
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_BANK_LEN 2
+/* 0 if paged access is not supported, non-zero otherwise. Non-zero PAGE is
+ * valid if OFFSET is in the range 80h - ffh.
+ */
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_PAGE_OFST 8
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_PAGE_LEN 2
+/* Offset in the range 00h - 7fh to access lower memory. Offset in the range
+ * 80h - ffh to access upper memory
+ */
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_OFFSET_OFST 10
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_OFFSET_LEN 1
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_LENGTH_OFST 12
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_LENGTH_LEN 4
+/* Container for 7 bit I2C addresses. */
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_ADDRESSING_OFST 4
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_ADDRESSING_LEN 1
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_MODULE_ADDR_OFST 4
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_MODULE_ADDR_LBN 0
+#define	MC_CMD_GET_MODULE_DATA_IN_V2_MODULE_ADDR_WIDTH 7
+
+/* MC_CMD_GET_MODULE_DATA_OUT msgresponse */
+#define	MC_CMD_GET_MODULE_DATA_OUT_LENMIN 5
+#define	MC_CMD_GET_MODULE_DATA_OUT_LENMAX 252
+#define	MC_CMD_GET_MODULE_DATA_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_GET_MODULE_DATA_OUT_LEN(num) (4+1*(num))
+#define	MC_CMD_GET_MODULE_DATA_OUT_DATA_NUM(len) (((len)-4)/1)
+/* length of the data in bytes */
+#define	MC_CMD_GET_MODULE_DATA_OUT_DATALEN_OFST 0
+#define	MC_CMD_GET_MODULE_DATA_OUT_DATALEN_LEN 4
+#define	MC_CMD_GET_MODULE_DATA_OUT_DATA_OFST 4
+#define	MC_CMD_GET_MODULE_DATA_OUT_DATA_LEN 1
+#define	MC_CMD_GET_MODULE_DATA_OUT_DATA_MINNUM 1
+#define	MC_CMD_GET_MODULE_DATA_OUT_DATA_MAXNUM 248
+#define	MC_CMD_GET_MODULE_DATA_OUT_DATA_MAXNUM_MCDI2 1016
+
+/* EVENT_MASK structuredef */
+#define	EVENT_MASK_LEN 4
+#define	EVENT_MASK_TYPE_OFST 0
+#define	EVENT_MASK_TYPE_LEN 4
+/* enum: PORT_LINKCHANGE event is enabled */
+#define	EVENT_MASK_PORT_LINKCHANGE 0x0
+/* enum: PORT_MODULECHANGE event is enabled */
+#define	EVENT_MASK_PORT_MODULECHANGE 0x1
+#define	EVENT_MASK_TYPE_LBN 0
+#define	EVENT_MASK_TYPE_WIDTH 32
+
+
+/***********************************/
+/* MC_CMD_SET_NETPORT_EVENTS_MASK
+ */
+#define	MC_CMD_SET_NETPORT_EVENTS_MASK 0x1e9
+#define	MC_CMD_SET_NETPORT_EVENTS_MASK_MSGSET 0x1e9
+#undef	MC_CMD_0x1e9_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1e9_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_SET_NETPORT_EVENTS_MASK_IN msgrequest: Enable or disable delivery of
+ * specified network port events for a given port identified by PORT_HANDLE. At
+ * start of day, or after any control interface reset (FLR, ENTITY_RESET,
+ * etc.), all event delivery is disabled for all ports associated with the
+ * control interface.
+ */
+#define	MC_CMD_SET_NETPORT_EVENTS_MASK_IN_LEN 8
+/* Handle to port to set event delivery mask. */
+#define	MC_CMD_SET_NETPORT_EVENTS_MASK_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_SET_NETPORT_EVENTS_MASK_IN_PORT_HANDLE_LEN 4
+/* Bitmask of events to enable. Event delivery is enabled when corresponding
+ * bit is 1, disabled when 0.
+ */
+#define	MC_CMD_SET_NETPORT_EVENTS_MASK_IN_EVENT_MASK_OFST 4
+#define	MC_CMD_SET_NETPORT_EVENTS_MASK_IN_EVENT_MASK_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               EVENT_MASK/TYPE */
+
+/* MC_CMD_SET_NETPORT_EVENTS_MASK_OUT msgresponse */
+#define	MC_CMD_SET_NETPORT_EVENTS_MASK_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_GET_NETPORT_EVENTS_MASK
+ */
+#define	MC_CMD_GET_NETPORT_EVENTS_MASK 0x1ea
+#define	MC_CMD_GET_NETPORT_EVENTS_MASK_MSGSET 0x1ea
+#undef	MC_CMD_0x1ea_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1ea_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_GET_NETPORT_EVENTS_MASK_IN msgrequest: Get event delivery mask a
+ * given port identified by PORT_HANDLE.
+ */
+#define	MC_CMD_GET_NETPORT_EVENTS_MASK_IN_LEN 4
+/* Handle to port to get event deliver mask for. */
+#define	MC_CMD_GET_NETPORT_EVENTS_MASK_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_GET_NETPORT_EVENTS_MASK_IN_PORT_HANDLE_LEN 4
+
+/* MC_CMD_GET_NETPORT_EVENTS_MASK_OUT msgresponse */
+#define	MC_CMD_GET_NETPORT_EVENTS_MASK_OUT_LEN 4
+/* Bitmask of events enabled. Event delivery is enabled when corresponding bit
+ * is 1, disabled when 0.
+ */
+#define	MC_CMD_GET_NETPORT_EVENTS_MASK_OUT_EVENT_MASK_OFST 0
+#define	MC_CMD_GET_NETPORT_EVENTS_MASK_OUT_EVENT_MASK_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               EVENT_MASK/TYPE */
+
+
+/***********************************/
+/* MC_CMD_GET_SUPPORTED_NETPORT_EVENTS
+ */
+#define	MC_CMD_GET_SUPPORTED_NETPORT_EVENTS 0x1eb
+#define	MC_CMD_GET_SUPPORTED_NETPORT_EVENTS_MSGSET 0x1eb
+#undef	MC_CMD_0x1eb_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1eb_PRIVILEGE_CTG SRIOV_CTG_LINK
+
+/* MC_CMD_GET_SUPPORTED_NETPORT_EVENTS_IN msgrequest: Get network port events
+ * supported by the platform. Information returned is fixed for a given NIC
+ * platform.
+ */
+#define	MC_CMD_GET_SUPPORTED_NETPORT_EVENTS_IN_LEN 0
+
+/* MC_CMD_GET_SUPPORTED_NETPORT_EVENTS_OUT msgresponse */
+#define	MC_CMD_GET_SUPPORTED_NETPORT_EVENTS_OUT_LEN 4
+/* Bitmask of events enabled. Event delivery is enabled when corresponding bit
+ * is 1, disabled when 0.
+ */
+#define	MC_CMD_GET_SUPPORTED_NETPORT_EVENTS_OUT_EVENT_MASK_OFST 0
+#define	MC_CMD_GET_SUPPORTED_NETPORT_EVENTS_OUT_EVENT_MASK_LEN 4
+/* enum property: bitshift */
+/*            Enum values, see field(s): */
+/*               EVENT_MASK/TYPE */
+
+/* LINK_CHANGE_LOG structuredef */
+#define	LINK_CHANGE_LOG_LEN 16
+/* Bitmask of flags that describe the state of the link. */
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_OFST 0
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_LEN 8
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_LO_OFST 0
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_LO_LEN 4
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_LO_LBN 0
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_LO_WIDTH 32
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_HI_OFST 4
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_HI_LEN 4
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_HI_LBN 32
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_HI_WIDTH 32
+/* enum property: value */
+/*            Enum values, see field(s): */
+/*               MC_CMD_LINK_STATUS_FLAGS/STATUS_FLAGS */
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_LBN 0
+#define	LINK_CHANGE_LOG_STATUS_FLAGS_WIDTH 64
+/* This is the time elapsed in milliseconds since the last event occurred. */
+#define	LINK_CHANGE_LOG_TIME_STAMP_OFST 8
+#define	LINK_CHANGE_LOG_TIME_STAMP_LEN 4
+#define	LINK_CHANGE_LOG_TIME_STAMP_LBN 64
+#define	LINK_CHANGE_LOG_TIME_STAMP_WIDTH 32
+/* Speed of the link. 0 if the link is down. */
+#define	LINK_CHANGE_LOG_LINK_SPEED_OFST 12
+#define	LINK_CHANGE_LOG_LINK_SPEED_LEN 4
+#define	LINK_CHANGE_LOG_LINK_SPEED_LBN 96
+#define	LINK_CHANGE_LOG_LINK_SPEED_WIDTH 32
+
+
+/***********************************/
+/* MC_CMD_LINK_LOG
+ * This command retrieves the history log of link state changes and reports the
+ * timestamp, reason for link state change and new link state. This command is
+ * clear-on-read.
+ */
+#define	MC_CMD_LINK_LOG 0x1ec
+#define	MC_CMD_LINK_LOG_MSGSET 0x1ec
+#undef	MC_CMD_0x1ec_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1ec_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_LINK_LOG_IN msgrequest */
+#define	MC_CMD_LINK_LOG_IN_LEN 4
+/* A handle to identify the port on which to query the link log. */
+#define	MC_CMD_LINK_LOG_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_LINK_LOG_IN_PORT_HANDLE_LEN 4
+
+/* MC_CMD_LINK_LOG_OUT msgresponse */
+#define	MC_CMD_LINK_LOG_OUT_LENMIN 8
+#define	MC_CMD_LINK_LOG_OUT_LENMAX 248
+#define	MC_CMD_LINK_LOG_OUT_LENMAX_MCDI2 1016
+#define	MC_CMD_LINK_LOG_OUT_LEN(num) (8+16*(num))
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_NUM(len) (((len)-8)/16)
+/* Number of valid transitions of type LINK_CHANGE_LOG structures in the
+ * LINK_LOG_ARRAY
+ */
+#define	MC_CMD_LINK_LOG_OUT_NUM_LOG_ENTRIES_OFST 0
+#define	MC_CMD_LINK_LOG_OUT_NUM_LOG_ENTRIES_LEN 4
+#define	MC_CMD_LINK_LOG_OUT_MORE_OFST 0
+#define	MC_CMD_LINK_LOG_OUT_MORE_LBN 0
+#define	MC_CMD_LINK_LOG_OUT_MORE_WIDTH 1
+/* Contains additional flags or control information related to the log
+ * response. The specific bits, e.g. MORE_ENTRIES, are described below.
+ */
+#define	MC_CMD_LINK_LOG_OUT_FLAGS_OFST 4
+#define	MC_CMD_LINK_LOG_OUT_FLAGS_LEN 4
+#define	MC_CMD_LINK_LOG_OUT_MORE_ENTRIES_OFST 4
+#define	MC_CMD_LINK_LOG_OUT_MORE_ENTRIES_LBN 0
+#define	MC_CMD_LINK_LOG_OUT_MORE_ENTRIES_WIDTH 1
+/* Array of LINK_CHANGE_LOG structures */
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_OFST 8
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_LEN 16
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_MINNUM 0
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_MAXNUM 15
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_MAXNUM_MCDI2 63
+/* See structuredef: LINK_CHANGE_LOG */
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_OFST 8
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_LEN 8
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_LO_OFST 8
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_LO_LEN 4
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_LO_LBN 64
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_LO_WIDTH 32
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_HI_OFST 12
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_HI_LEN 4
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_HI_LBN 96
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_STATUS_FLAGS_HI_WIDTH 32
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_TIME_STAMP_OFST 16
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_TIME_STAMP_LEN 4
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_LINK_SPEED_OFST 20
+#define	MC_CMD_LINK_LOG_OUT_LINK_LOG_ARRAY_LINK_SPEED_LEN 4
+
+
+/***********************************/
+/* MC_CMD_CSR_INST_READ32
+ * Read 32bit words from an MCPU indirect memory map specified by its
+ * MAP_INDEX.
+ */
+#define	MC_CMD_CSR_INST_READ32 0x1ee
+#define	MC_CMD_CSR_INST_READ32_MSGSET 0x1ee
+#undef	MC_CMD_0x1ee_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1ee_PRIVILEGE_CTG SRIOV_CTG_INSECURE
+
+/* MC_CMD_CSR_INST_READ32_IN msgrequest */
+#define	MC_CMD_CSR_INST_READ32_IN_LEN 24
+/* Address */
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_OFST 0
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_LEN 8
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_LO_OFST 0
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_LO_LEN 4
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_LO_LBN 0
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_LO_WIDTH 32
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_HI_OFST 4
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_HI_LEN 4
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_HI_LBN 32
+#define	MC_CMD_CSR_INST_READ32_IN_ADDR_HI_WIDTH 32
+/* Step value between register addresses */
+#define	MC_CMD_CSR_INST_READ32_IN_STEP_OFST 8
+#define	MC_CMD_CSR_INST_READ32_IN_STEP_LEN 4
+/* Map index of indirect memory map */
+#define	MC_CMD_CSR_INST_READ32_IN_MAP_INDEX_OFST 12
+#define	MC_CMD_CSR_INST_READ32_IN_MAP_INDEX_LEN 4
+/* Number of words to read */
+#define	MC_CMD_CSR_INST_READ32_IN_NUM_WORDS_OFST 20
+#define	MC_CMD_CSR_INST_READ32_IN_NUM_WORDS_LEN 4
+
+/* MC_CMD_CSR_INST_READ32_OUT msgresponse */
+#define	MC_CMD_CSR_INST_READ32_OUT_LENMIN 4
+#define	MC_CMD_CSR_INST_READ32_OUT_LENMAX 252
+#define	MC_CMD_CSR_INST_READ32_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_CSR_INST_READ32_OUT_LEN(num) (4+4*(num))
+#define	MC_CMD_CSR_INST_READ32_OUT_BUFFER_NUM(len) (((len)-4)/4)
+/* Status response from register reads by firmware */
+#define	MC_CMD_CSR_INST_READ32_OUT_STATUS_OFST 0
+#define	MC_CMD_CSR_INST_READ32_OUT_STATUS_LEN 4
+/* Read data */
+#define	MC_CMD_CSR_INST_READ32_OUT_BUFFER_OFST 4
+#define	MC_CMD_CSR_INST_READ32_OUT_BUFFER_LEN 4
+#define	MC_CMD_CSR_INST_READ32_OUT_BUFFER_MINNUM 0
+#define	MC_CMD_CSR_INST_READ32_OUT_BUFFER_MAXNUM 62
+#define	MC_CMD_CSR_INST_READ32_OUT_BUFFER_MAXNUM_MCDI2 254
+
+
+/***********************************/
+/* MC_CMD_CSR_INST_WRITE32
+ * Write 32bit dwords to an MCPU indirect memory map specified by its
+ * MAP_INDEX.
+ */
+#define	MC_CMD_CSR_INST_WRITE32 0x1ef
+#define	MC_CMD_CSR_INST_WRITE32_MSGSET 0x1ef
+#undef	MC_CMD_0x1ef_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1ef_PRIVILEGE_CTG SRIOV_CTG_INSECURE
+
+/* MC_CMD_CSR_INST_WRITE32_IN msgrequest */
+#define	MC_CMD_CSR_INST_WRITE32_IN_LENMIN 24
+#define	MC_CMD_CSR_INST_WRITE32_IN_LENMAX 252
+#define	MC_CMD_CSR_INST_WRITE32_IN_LENMAX_MCDI2 1020
+#define	MC_CMD_CSR_INST_WRITE32_IN_LEN(num) (20+4*(num))
+#define	MC_CMD_CSR_INST_WRITE32_IN_BUFFER_NUM(len) (((len)-20)/4)
+/* Address */
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_OFST 0
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_LEN 8
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_LO_OFST 0
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_LO_LEN 4
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_LO_LBN 0
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_LO_WIDTH 32
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_HI_OFST 4
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_HI_LEN 4
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_HI_LBN 32
+#define	MC_CMD_CSR_INST_WRITE32_IN_ADDR_HI_WIDTH 32
+/* Step value between register addresses */
+#define	MC_CMD_CSR_INST_WRITE32_IN_STEP_OFST 8
+#define	MC_CMD_CSR_INST_WRITE32_IN_STEP_LEN 4
+/* Map index of indirect memory map */
+#define	MC_CMD_CSR_INST_WRITE32_IN_MAP_INDEX_OFST 12
+#define	MC_CMD_CSR_INST_WRITE32_IN_MAP_INDEX_LEN 4
+/* Write data */
+#define	MC_CMD_CSR_INST_WRITE32_IN_BUFFER_OFST 20
+#define	MC_CMD_CSR_INST_WRITE32_IN_BUFFER_LEN 4
+#define	MC_CMD_CSR_INST_WRITE32_IN_BUFFER_MINNUM 1
+#define	MC_CMD_CSR_INST_WRITE32_IN_BUFFER_MAXNUM 58
+#define	MC_CMD_CSR_INST_WRITE32_IN_BUFFER_MAXNUM_MCDI2 250
+
+/* MC_CMD_CSR_INST_WRITE32_OUT msgresponse */
+#define	MC_CMD_CSR_INST_WRITE32_OUT_LEN 4
+/* Status response from register writes by firmware */
+#define	MC_CMD_CSR_INST_WRITE32_OUT_STATUS_OFST 0
+#define	MC_CMD_CSR_INST_WRITE32_OUT_STATUS_LEN 4
+
+
+/***********************************/
+/* MC_CMD_FETCH_HNIC_PORT_CONFIG
+ * Query the static HNIC port configuration for a physical port. Returns ENODEV
+ * if the target does not correspond to a physical port, or EPERM if the caller
+ * does not have permission to administer it.
+ */
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG 0x1f0
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_MSGSET 0x1f0
+#undef	MC_CMD_0x1f0_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f0_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_FETCH_HNIC_PORT_CONFIG_IN msgrequest */
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_IN_LEN 8
+/* Port handle to the target network port. */
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to query. */
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_IN_DIRECTION_OFST 4
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+
+/* MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT msgresponse */
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_LENMIN 12
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_LENMAX 252
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_LEN(num) (12+4*(num))
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_NUM(len) (((len)-12)/4)
+/* Total size of buffer region assigned to this port, in bytes. */
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_REGION_SIZE_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_REGION_SIZE_LEN 4
+/* Allocation granularity, in bytes. All partitioning of the buffer region must
+ * be in multiples of this value.
+ */
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_ALLOC_GRANULARITY_OFST 4
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_ALLOC_GRANULARITY_LEN 4
+/* The number of independent FIFOs assigned to this port. */
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_NUM_FIFOS_OFST 8
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_NUM_FIFOS_LEN 4
+/* Array of FIFO handles, NUM_FIFOS items long. */
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_OFST 12
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_LEN 4
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_MINNUM 0
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_MAXNUM 60
+#define	MC_CMD_FETCH_HNIC_PORT_CONFIG_OUT_FIFO_HANDLE_MAXNUM_MCDI2 252
+
+
+/***********************************/
+/* MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING
+ * Returns the current state of the FIFO sizing configuration for all of the
+ * FIFOs assigned to a physical port. Returns ENODEV if the target does not
+ * correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it.
+ */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING 0x1f1
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_MSGSET 0x1f1
+#undef	MC_CMD_0x1f1_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f1_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_IN msgrequest */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_IN_LEN 8
+/* Port handle to the target network port. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to query. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_IN_DIRECTION_OFST 4
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+
+/* MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT msgresponse */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_LENMIN 8
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_LENMAX 248
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_LENMAX_MCDI2 1016
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_LEN(num) (8+12*(num))
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_NUM(len) (((len)-8)/12)
+/* Total size of buffer region assigned to this port, in bytes. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_REGION_SIZE_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_REGION_SIZE_LEN 4
+/* The number of independent FIFOs assigned to this port. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_NUM_FIFOS_OFST 4
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_SIZE_PARAMS structures, NUM_FIFOS items long. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_OFST 8
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_LEN 12
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_MINNUM 0
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_MAXNUM 20
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_SIZING_OUT_FIFO_SIZE_PARAMS_MAXNUM_MCDI2 84
+
+
+/***********************************/
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING
+ * Sets the FIFO sizing configuration for a physical port. This is disruptive
+ * to port operation and will cause the link to drop while the port is
+ * reconfigured. Returns ENODEV if the target does not correspond to a physical
+ * port, or EPERM if the caller does not have permission to administer it, or
+ * EINVAL if the sizing parameters are invalid.
+ */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING 0x1f2
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_MSGSET 0x1f2
+#undef	MC_CMD_0x1f2_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f2_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN msgrequest */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_LENMIN 12
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_LENMAX 252
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_LENMAX_MCDI2 1020
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_LEN(num) (12+12*(num))
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_NUM(len) (((len)-12)/12)
+/* Port handle to the target network port. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to query. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_DIRECTION_OFST 4
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+/* The number of FIFOs being configured. FIFOs assigned to the port but not
+ * included in the list are assumed to retain their current size configuration.
+ */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_NUM_FIFOS_OFST 8
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_SIZE_PARAMS structures, NUM_FIFOS items long. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_OFST 12
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_LEN 12
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_MINNUM 0
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_MAXNUM 20
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_IN_FIFO_SIZE_PARAMS_MAXNUM_MCDI2 84
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_OUT msgresponse */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_SIZING_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING
+ * Returns the current state of the 802.1Q priority to FIFO mapping
+ * configuration for a physical port. Returns ENODEV if the target does not
+ * correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it.
+ */
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING 0x1f3
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_MSGSET 0x1f3
+#undef	MC_CMD_0x1f3_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f3_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_IN msgrequest */
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_IN_LEN 8
+/* Port handle to the target network port. */
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to query. */
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_IN_DIRECTION_OFST 4
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+
+/* MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_OUT msgresponse */
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_OUT_LEN 32
+/* FIFO handle for each Priority Code Point(PCP), in order from 0 to 7. */
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_OUT_FIFO_HANDLE_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_OUT_FIFO_HANDLE_LEN 4
+#define	MC_CMD_FETCH_HNIC_PORT_PRIO_MAPPING_OUT_FIFO_HANDLE_NUM 8
+
+
+/***********************************/
+/* MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING
+ * Sets the PCP priority to FIFO mapping configuration for a physical port.
+ * Returns ENODEV if the target does not correspond to a physical port, or
+ * EPERM if the caller does not have permission to administer it, or EINVAL if
+ * any of the FIFO handles are invalid in some way.
+ */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING 0x1f4
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_MSGSET 0x1f4
+#undef	MC_CMD_0x1f4_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f4_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_IN msgrequest */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_IN_LEN 40
+/* Port handle to the target network port. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to query. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_IN_DIRECTION_OFST 4
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+/* FIFO handle for each PCP value, in order from 0 to 7. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_IN_FIFO_HANDLE_OFST 8
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_IN_FIFO_HANDLE_LEN 4
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_IN_FIFO_HANDLE_NUM 8
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_OUT msgresponse */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_PRIO_MAPPING_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS
+ * Returns the current state of the FIFO delay parameters configuration for all
+ * of the FIFOs assigned to a physical port. Returns ENODEV if the target does
+ * not correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it.
+ */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS 0x1f5
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_MSGSET 0x1f5
+#undef	MC_CMD_0x1f5_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f5_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_IN msgrequest */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LEN 8
+/* Port handle to the target network port. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to query. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_IN_DIRECTION_OFST 4
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+
+/* MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT msgresponse */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LENMIN 4
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LENMAX 244
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LENMAX_MCDI2 1012
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LEN(num) (4+16*(num))
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_NUM(len) (((len)-4)/16)
+/* The number of independent FIFOs assigned to this port. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_NUM_FIFOS_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_DELAY_PARAMS structures, NUM_FIFOS items long. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_OFST 4
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_LEN 16
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_MINNUM 0
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_MAXNUM 15
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_FIFO_DELAY_PARAMS_MAXNUM_MCDI2 63
+
+
+/***********************************/
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS
+ * Sets the FIFO delay parameters configuration for a physical port. This is
+ * not disruptive to port operation. Returns ENODEV if the target does not
+ * correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it, or EINVAL if the sizing parameters are invalid.
+ */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS 0x1f6
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_MSGSET 0x1f6
+#undef	MC_CMD_0x1f6_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f6_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN msgrequest */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LENMIN 16
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LENMAX 240
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LENMAX_MCDI2 1008
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_LEN(num) (16+16*(num))
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_NUM(len) (((len)-16)/16)
+/* Port handle to the target network port. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to query. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_DIRECTION_OFST 4
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+/* The number of FIFOs being configured. FIFOs assigned to the port but not
+ * included in the list are assumed to retain their current delay
+ * configuration.
+ */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_NUM_FIFOS_OFST 8
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_DELAY_PARAMS structures, NUM_FIFOS items long. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_OFST 16
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_LEN 16
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_MINNUM 0
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_MAXNUM 14
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_IN_FIFO_DELAY_PARAMS_MAXNUM_MCDI2 62
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_OUT msgresponse */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DELAY_PARAMS_OUT_LEN 0
+
+/* HNIC_FIFO_DRAIN structuredef: HNIC FIFO drain parameters */
+#define	HNIC_FIFO_DRAIN_LEN 8
+/* Handle to identify the fifo to be drained. The FIFO_HANDLE should be treated
+ * as an opaque value.
+ */
+#define	HNIC_FIFO_DRAIN_FIFO_HANDLE_OFST 0
+#define	HNIC_FIFO_DRAIN_FIFO_HANDLE_LEN 4
+#define	HNIC_FIFO_DRAIN_FIFO_HANDLE_LBN 0
+#define	HNIC_FIFO_DRAIN_FIFO_HANDLE_WIDTH 32
+#define	HNIC_FIFO_DRAIN_FLAGS_OFST 4
+#define	HNIC_FIFO_DRAIN_FLAGS_LEN 4
+#define	HNIC_FIFO_DRAIN_DRAIN_EN_OFST 4
+#define	HNIC_FIFO_DRAIN_DRAIN_EN_LBN 0
+#define	HNIC_FIFO_DRAIN_DRAIN_EN_WIDTH 1
+#define	HNIC_FIFO_DRAIN_FLAGS_LBN 32
+#define	HNIC_FIFO_DRAIN_FLAGS_WIDTH 32
+
+
+/***********************************/
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN
+ * This command configures an HNIC TX FIFO to be flushed for a physical port.
+ * This is not disruptive to port operation. Returns ENODEV if the target does
+ * not correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it. or ENOTSUP if the requested direction is RX.
+ */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN 0x1f7
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_MSGSET 0x1f7
+#undef	MC_CMD_0x1f7_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f7_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN msgrequest */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_LENMIN 16
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_LENMAX 240
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_LENMAX_MCDI2 1008
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_LEN(num) (16+16*(num))
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_FIFO_DRAIN_NUM(len) (((len)-16)/16)
+/* Port handle to the target network port. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to query. Flushing fifos is only allowed in the TX
+ * direction.
+ */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_DIRECTION_OFST 4
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+/* The number of FIFOs being configured for flushing. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_NUM_FIFOS_OFST 8
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_DRAIN structures, NUM_FIFOS items long. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_FIFO_DRAIN_OFST 16
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_FIFO_DRAIN_LEN 16
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_FIFO_DRAIN_MINNUM 0
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_FIFO_DRAIN_MAXNUM 14
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_IN_FIFO_DRAIN_MAXNUM_MCDI2 62
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_OUT msgresponse */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_DRAIN_OUT_LEN 0
+
+/* HNIC_FIFO_WEIGHT structuredef: HNIC FIFO weights used in the scheduler's
+ * round robin algorithm.
+ */
+#define	HNIC_FIFO_WEIGHT_LEN 8
+/* FIFO handle */
+#define	HNIC_FIFO_WEIGHT_FIFO_HANDLE_OFST 0
+#define	HNIC_FIFO_WEIGHT_FIFO_HANDLE_LEN 4
+#define	HNIC_FIFO_WEIGHT_FIFO_HANDLE_LBN 0
+#define	HNIC_FIFO_WEIGHT_FIFO_HANDLE_WIDTH 32
+/* Weight value expressed in units of 0.001 (i.e. value 1000 corresponds to a
+ * weight=1). Allowed values for this field are [1000-4000]
+ */
+#define	HNIC_FIFO_WEIGHT_WEIGHT_OFST 4
+#define	HNIC_FIFO_WEIGHT_WEIGHT_LEN 4
+#define	HNIC_FIFO_WEIGHT_WEIGHT_LBN 32
+#define	HNIC_FIFO_WEIGHT_WEIGHT_WIDTH 32
+
+
+/***********************************/
+/* MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS
+ * Retrieves the FIFO weights for the scheduler's round robin algorithm.
+ * Returns ENODEV if the target does not correspond to a physical port, or
+ * EPERM if the caller does not have permission to administer it.
+ */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS 0x1f8
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_MSGSET 0x1f8
+#undef	MC_CMD_0x1f8_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f8_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_IN msgrequest */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_IN_LEN 8
+/* Port handle to the target network port. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to operate on. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_IN_DIRECTION_OFST 4
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+
+/* MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT msgresponse */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_LENMIN 16
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_LENMAX 248
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_LENMAX_MCDI2 1016
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_LEN(num) (8+8*(num))
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_NUM(len) (((len)-8)/8)
+/* Total number of configured FIFOs. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_NUM_FIFOS_OFST 0
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_WEIGHT structures, NUM_FIFOS items long. */
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_OFST 8
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_LEN 8
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_LO_OFST 8
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_LO_LEN 4
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_LO_LBN 64
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_LO_WIDTH 32
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_HI_OFST 12
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_HI_LEN 4
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_HI_LBN 96
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_HI_WIDTH 32
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_MINNUM 1
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_MAXNUM 30
+#define	MC_CMD_FETCH_HNIC_PORT_FIFO_WEIGHTS_OUT_FIFO_WEIGHTS_MAXNUM_MCDI2 126
+
+
+/***********************************/
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS
+ * Configures the FIFO weights for the scheduler's round robin algorithm. This
+ * is not disruptive to port operation. Returns ENODEV if the target does not
+ * correspond to a physical port, or EPERM if the caller does not have
+ * permission to administer it or EINVAL if provided argument are not valid.
+ */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS 0x1f9
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_MSGSET 0x1f9
+#undef	MC_CMD_0x1f9_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1f9_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN msgrequest */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_LENMIN 24
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_LENMAX 248
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_LENMAX_MCDI2 1016
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_LEN(num) (16+8*(num))
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_NUM(len) (((len)-16)/8)
+/* Port handle to the target network port. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_PORT_HANDLE_LEN 4
+/* Traffic direction to operate on. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_DIRECTION_OFST 4
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_DIRECTION_LEN 4
+/*            Enum values, see field(s): */
+/*               PORT_DIRECTION */
+/* The number of FIFOs being configured. At least one FIFO needs to be
+ * specified.
+ */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_NUM_FIFOS_OFST 8
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_NUM_FIFOS_LEN 4
+/* Array of HNIC_FIFO_WEIGHT structures, NUM_FIFOS items long. */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_OFST 16
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_LEN 8
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_LO_OFST 16
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_LO_LEN 4
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_LO_LBN 128
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_LO_WIDTH 32
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_HI_OFST 20
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_HI_LEN 4
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_HI_LBN 160
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_HI_WIDTH 32
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_MINNUM 1
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_MAXNUM 29
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_IN_FIFO_WEIGHTS_MAXNUM_MCDI2 125
+
+/* MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_OUT msgresponse */
+#define	MC_CMD_CONFIGURE_HNIC_PORT_FIFO_WEIGHTS_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_GET_NETPORT_STATISTICS
+ * Get generic MAC statistics. This call retrieves unified statistics managed
+ * by the MC. The MC will populate and provide all supported statistics in the
+ * format as returned by MC_CMD_MAC_STATISTICS_DESCRIPTOR. Refer to the
+ * aforementioned command for the format and contents of the stats DMA buffer.
+ * To ensure consistent and accurate results, it is essential for the driver to
+ * initialize the DMA buffer with zeros when DMA mode is used. Returns: 0 on
+ * success, ETIME if the DMA buffer is not ready, ENOENT on non-existent port
+ * handle, and EINVAL on invalid parameters (DMA buffer too small)
+ */
+#define	MC_CMD_GET_NETPORT_STATISTICS 0x1fa
+#define	MC_CMD_GET_NETPORT_STATISTICS_MSGSET 0x1fa
+#undef	MC_CMD_0x1fa_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1fa_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_GET_NETPORT_STATISTICS_IN msgrequest */
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_LEN 20
+/* Handle of port to get MAC statistics for. */
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PORT_HANDLE_OFST 0
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PORT_HANDLE_LEN 4
+/* Contains options for querying the MAC statistics. */
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_CMD_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_CMD_LEN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_LBN 0
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_CLEAR_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_CLEAR_LBN 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_CLEAR_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIODIC_CHANGE_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIODIC_CHANGE_LBN 2
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIODIC_CHANGE_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIODIC_ENABLE_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIODIC_ENABLE_LBN 3
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIODIC_ENABLE_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIODIC_NOEVENT_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIODIC_NOEVENT_LBN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIODIC_NOEVENT_WIDTH 1
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIOD_MS_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIOD_MS_LBN 15
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_PERIOD_MS_WIDTH 17
+/* Specifies the physical address of the DMA buffer to use for statistics
+ * transfer. This field must contain a valid address under either of these
+ * conditions: 1. DMA flag is set (immediate DMA requested) 2. Both
+ * PERIODIC_CHANGE and PERIODIC_ENABLE are set (periodic DMA configured)
+ */
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_OFST 8
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_LEN 8
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_LO_OFST 8
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_LO_LEN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_LO_LBN 64
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_LO_WIDTH 32
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_HI_OFST 12
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_HI_LEN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_HI_LBN 96
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_ADDR_HI_WIDTH 32
+/* Specifies the length of the DMA buffer in bytes for statistics transfer. The
+ * buffer size must be at least DMA_BUFFER_SIZE bytes (as returned by
+ * MC_CMD_MAC_STATISTICS_DESCRIPTOR). Providing an insufficient buffer size
+ * will result in an EINVAL error. This field must contain a valid length under
+ * either of these conditions: 1. DMA flag is set (immediate DMA requested) 2.
+ * Both PERIODIC_CHANGE and PERIODIC_ENABLE are set (periodic DMA configured)
+ */
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_LEN_OFST 16
+#define	MC_CMD_GET_NETPORT_STATISTICS_IN_DMA_LEN_LEN 4
+
+/* MC_CMD_GET_NETPORT_STATISTICS_OUT msgresponse */
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMIN 0
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMAX 248
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_LENMAX_MCDI2 1016
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_LEN(num) (0+8*(num))
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_NUM(len) (((len)-0)/8)
+/* Statistics buffer. Zero-length if DMA mode is used. The statistics buffer is
+ * an array of 8-byte counter values, containing the generation start marker,
+ * stats counters, and generation end marker. The index of each counter in the
+ * array is reported by the MAC_STATISTICS_DESCRIPTOR command. The same layout
+ * is used for the DMA buffer for DMA mode stats.
+ */
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_OFST 0
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_LEN 8
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_LO_OFST 0
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_LO_LEN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_LO_LBN 0
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_LO_WIDTH 32
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_HI_OFST 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_HI_LEN 4
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_HI_LBN 32
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_HI_WIDTH 32
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_MINNUM 0
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_MAXNUM 31
+#define	MC_CMD_GET_NETPORT_STATISTICS_OUT_STATS_MAXNUM_MCDI2 127
+
 /* EVB_PORT_ID structuredef */
 #define	EVB_PORT_ID_LEN 4
 #define	EVB_PORT_ID_PORT_ID_OFST 0
@@ -11820,6 +15458,9 @@
 #define	MC_CMD_INIT_RXQ_EXT_IN_FLAG_NO_CONT_EV_OFST 16
 #define	MC_CMD_INIT_RXQ_EXT_IN_FLAG_NO_CONT_EV_LBN 20
 #define	MC_CMD_INIT_RXQ_EXT_IN_FLAG_NO_CONT_EV_WIDTH 1
+#define	MC_CMD_INIT_RXQ_EXT_IN_FLAG_SUPPRESS_RX_EVENTS_OFST 16
+#define	MC_CMD_INIT_RXQ_EXT_IN_FLAG_SUPPRESS_RX_EVENTS_LBN 21
+#define	MC_CMD_INIT_RXQ_EXT_IN_FLAG_SUPPRESS_RX_EVENTS_WIDTH 1
 /* Owner ID to use if in buffer mode (zero if physical) */
 #define	MC_CMD_INIT_RXQ_EXT_IN_OWNER_ID_OFST 20
 #define	MC_CMD_INIT_RXQ_EXT_IN_OWNER_ID_LEN 4
@@ -11926,6 +15567,9 @@
 #define	MC_CMD_INIT_RXQ_V3_IN_FLAG_NO_CONT_EV_OFST 16
 #define	MC_CMD_INIT_RXQ_V3_IN_FLAG_NO_CONT_EV_LBN 20
 #define	MC_CMD_INIT_RXQ_V3_IN_FLAG_NO_CONT_EV_WIDTH 1
+#define	MC_CMD_INIT_RXQ_V3_IN_FLAG_SUPPRESS_RX_EVENTS_OFST 16
+#define	MC_CMD_INIT_RXQ_V3_IN_FLAG_SUPPRESS_RX_EVENTS_LBN 21
+#define	MC_CMD_INIT_RXQ_V3_IN_FLAG_SUPPRESS_RX_EVENTS_WIDTH 1
 /* Owner ID to use if in buffer mode (zero if physical) */
 #define	MC_CMD_INIT_RXQ_V3_IN_OWNER_ID_OFST 20
 #define	MC_CMD_INIT_RXQ_V3_IN_OWNER_ID_LEN 4
@@ -12061,6 +15705,9 @@
 #define	MC_CMD_INIT_RXQ_V4_IN_FLAG_NO_CONT_EV_OFST 16
 #define	MC_CMD_INIT_RXQ_V4_IN_FLAG_NO_CONT_EV_LBN 20
 #define	MC_CMD_INIT_RXQ_V4_IN_FLAG_NO_CONT_EV_WIDTH 1
+#define	MC_CMD_INIT_RXQ_V4_IN_FLAG_SUPPRESS_RX_EVENTS_OFST 16
+#define	MC_CMD_INIT_RXQ_V4_IN_FLAG_SUPPRESS_RX_EVENTS_LBN 21
+#define	MC_CMD_INIT_RXQ_V4_IN_FLAG_SUPPRESS_RX_EVENTS_WIDTH 1
 /* Owner ID to use if in buffer mode (zero if physical) */
 #define	MC_CMD_INIT_RXQ_V4_IN_OWNER_ID_OFST 20
 #define	MC_CMD_INIT_RXQ_V4_IN_OWNER_ID_LEN 4
@@ -12209,6 +15856,9 @@
 #define	MC_CMD_INIT_RXQ_V5_IN_FLAG_NO_CONT_EV_OFST 16
 #define	MC_CMD_INIT_RXQ_V5_IN_FLAG_NO_CONT_EV_LBN 20
 #define	MC_CMD_INIT_RXQ_V5_IN_FLAG_NO_CONT_EV_WIDTH 1
+#define	MC_CMD_INIT_RXQ_V5_IN_FLAG_SUPPRESS_RX_EVENTS_OFST 16
+#define	MC_CMD_INIT_RXQ_V5_IN_FLAG_SUPPRESS_RX_EVENTS_LBN 21
+#define	MC_CMD_INIT_RXQ_V5_IN_FLAG_SUPPRESS_RX_EVENTS_WIDTH 1
 /* Owner ID to use if in buffer mode (zero if physical) */
 #define	MC_CMD_INIT_RXQ_V5_IN_OWNER_ID_OFST 20
 #define	MC_CMD_INIT_RXQ_V5_IN_OWNER_ID_LEN 4
@@ -13828,6 +17478,10 @@
 #define	MC_CMD_GET_PARSER_DISP_INFO_IN_OP_GET_SUPPORTED_VNIC_ENCAP_MATCHES 0x5
 /* enum: read the supported encapsulation types for the VNIC */
 #define	MC_CMD_GET_PARSER_DISP_INFO_IN_OP_GET_SUPPORTED_VNIC_ENCAP_TYPES 0x6
+/* enum: read the supported RX filter matches for low-latency queues (as
+ * allocated by MC_CMD_ALLOC_LL_QUEUES)
+ */
+#define	MC_CMD_GET_PARSER_DISP_INFO_IN_OP_GET_SUPPORTED_LL_RX_MATCHES 0x7
 
 /* MC_CMD_GET_PARSER_DISP_INFO_OUT msgresponse */
 #define	MC_CMD_GET_PARSER_DISP_INFO_OUT_LENMIN 8
@@ -14554,7 +18208,7 @@
 
 /* MC_CMD_GET_VI_TLP_PROCESSING_IN msgrequest */
 #define	MC_CMD_GET_VI_TLP_PROCESSING_IN_LEN 4
-/* VI number to get information for. */
+/* Queue handle, encodes queue type and VI number to get information for. */
 #define	MC_CMD_GET_VI_TLP_PROCESSING_IN_INSTANCE_OFST 0
 #define	MC_CMD_GET_VI_TLP_PROCESSING_IN_INSTANCE_LEN 4
 
@@ -14569,6 +18223,12 @@
 /* Use Relaxed ordering model for TLPs on this VI. */
 #define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_RELAXED_ORDERING_LBN 16
 #define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_RELAXED_ORDERING_WIDTH 1
+/* Use Relaxed ordering model for packet data transfer TLPs on this VI (alias
+ * of RELAXED_ORDERING for hardware that also understands the
+ * RELAXED_ORDERING_SYNC_DATA field and allows them to be used independently).
+ */
+#define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_RELAXED_ORDERING_PACKET_DATA_LBN 16
+#define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_RELAXED_ORDERING_PACKET_DATA_WIDTH 1
 /* Use ID based ordering for TLPs on this VI. */
 #define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_ID_BASED_ORDERING_LBN 17
 #define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_ID_BASED_ORDERING_WIDTH 1
@@ -14578,15 +18238,56 @@
 /* Enable TPH for TLPs on this VI. */
 #define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_TPH_ON_LBN 19
 #define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_TPH_ON_WIDTH 1
+/* Use Relaxed ordering model for synchronization data transfer TLPs on this
+ * VI, used for relaxed ordering of metadata transfers on LL.
+ */
+#define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_RELAXED_ORDERING_SYNC_DATA_LBN 20
+#define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_RELAXED_ORDERING_SYNC_DATA_WIDTH 1
 #define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_DATA_OFST 0
 #define	MC_CMD_GET_VI_TLP_PROCESSING_OUT_DATA_LEN 4
 
+/* MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT msgresponse: This message has the same
+ * layout as GET_VI_TLP_PROCESSING_OUT, but with corrected field ordering to
+ * simplify use in drivers
+ */
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_LEN 4
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_DATA_OFST 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_DATA_LEN 4
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_TPH_TAG1_RX_OFST 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_TPH_TAG1_RX_LBN 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_TPH_TAG1_RX_WIDTH 8
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_TPH_TAG2_EV_OFST 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_TPH_TAG2_EV_LBN 8
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_TPH_TAG2_EV_WIDTH 8
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_RELAXED_ORDERING_OFST 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_RELAXED_ORDERING_LBN 16
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_RELAXED_ORDERING_WIDTH 1
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_RELAXED_ORDERING_PACKET_DATA_OFST 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_RELAXED_ORDERING_PACKET_DATA_LBN 16
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_RELAXED_ORDERING_PACKET_DATA_WIDTH 1
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_ID_BASED_ORDERING_OFST 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_ID_BASED_ORDERING_LBN 17
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_ID_BASED_ORDERING_WIDTH 1
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_NO_SNOOP_OFST 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_NO_SNOOP_LBN 18
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_NO_SNOOP_WIDTH 1
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_TPH_ON_OFST 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_TPH_ON_LBN 19
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_TPH_ON_WIDTH 1
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_RELAXED_ORDERING_SYNC_DATA_OFST 0
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_RELAXED_ORDERING_SYNC_DATA_LBN 20
+#define	MC_CMD_GET_VI_TLP_PROCESSING_V2_OUT_RELAXED_ORDERING_SYNC_DATA_WIDTH 1
+
 
 /***********************************/
 /* MC_CMD_SET_VI_TLP_PROCESSING
  * Set TLP steering and ordering information for a VI. The caller must have the
  * GRP_FUNC_DMA privilege and must be the currently-assigned user of this VI or
- * an ancestor of the current user (see MC_CMD_SET_VI_USER).
+ * an ancestor of the current user (see MC_CMD_SET_VI_USER). Note that LL
+ * queues require this to be called after allocation but before initialisation
+ * of the queue. TLP options of a queue are fixed after queue is initialised,
+ * with the values set to current global value or they can be overriden using
+ * this command. At LL queue allocation, all overrides are cleared.
  */
 #define	MC_CMD_SET_VI_TLP_PROCESSING 0xb1
 #define	MC_CMD_SET_VI_TLP_PROCESSING_MSGSET 0xb1
@@ -14596,7 +18297,7 @@
 
 /* MC_CMD_SET_VI_TLP_PROCESSING_IN msgrequest */
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_LEN 8
-/* VI number to set information for. */
+/* Queue handle, encodes queue type and VI number to set information for. */
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_INSTANCE_OFST 0
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_INSTANCE_LEN 4
 /* Transaction processing steering hint 1 for use with the Rx Queue. */
@@ -14608,6 +18309,12 @@
 /* Use Relaxed ordering model for TLPs on this VI. */
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_RELAXED_ORDERING_LBN 48
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_RELAXED_ORDERING_WIDTH 1
+/* Use Relaxed ordering model for packet data transfer TLPs on this VI (alias
+ * of RELAXED_ORDERING for hardware that also understands the
+ * RELAXED_ORDERING_SYNC_DATA field and allows them to be used independently).
+ */
+#define	MC_CMD_SET_VI_TLP_PROCESSING_IN_RELAXED_ORDERING_PACKET_DATA_LBN 48
+#define	MC_CMD_SET_VI_TLP_PROCESSING_IN_RELAXED_ORDERING_PACKET_DATA_WIDTH 1
 /* Use ID based ordering for TLPs on this VI. */
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_ID_BASED_ORDERING_LBN 49
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_ID_BASED_ORDERING_WIDTH 1
@@ -14617,9 +18324,49 @@
 /* Enable TPH for TLPs on this VI. */
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_TPH_ON_LBN 51
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_TPH_ON_WIDTH 1
+/* Use Relaxed ordering model for synchronization data transfer TLPs on this
+ * VI, used for relaxed ordering of metadata transfers on LL.
+ */
+#define	MC_CMD_SET_VI_TLP_PROCESSING_IN_RELAXED_ORDERING_SYNC_DATA_LBN 52
+#define	MC_CMD_SET_VI_TLP_PROCESSING_IN_RELAXED_ORDERING_SYNC_DATA_WIDTH 1
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_DATA_OFST 4
 #define	MC_CMD_SET_VI_TLP_PROCESSING_IN_DATA_LEN 4
 
+/* MC_CMD_SET_VI_TLP_PROCESSING_V2_IN msgrequest: This message has the same
+ * layout as SET_VI_TLP_PROCESSING_OUT, but with corrected field ordering to
+ * simplify use in drivers.
+ */
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_LEN 8
+/* Queue handle, encodes queue type and VI number to set information for. */
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_INSTANCE_OFST 0
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_INSTANCE_LEN 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_DATA_OFST 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_DATA_LEN 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_TPH_TAG1_RX_OFST 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_TPH_TAG1_RX_LBN 0
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_TPH_TAG1_RX_WIDTH 8
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_TPH_TAG2_EV_OFST 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_TPH_TAG2_EV_LBN 8
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_TPH_TAG2_EV_WIDTH 8
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_RELAXED_ORDERING_OFST 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_RELAXED_ORDERING_LBN 16
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_RELAXED_ORDERING_WIDTH 1
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_RELAXED_ORDERING_PACKET_DATA_OFST 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_RELAXED_ORDERING_PACKET_DATA_LBN 16
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_RELAXED_ORDERING_PACKET_DATA_WIDTH 1
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_ID_BASED_ORDERING_OFST 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_ID_BASED_ORDERING_LBN 17
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_ID_BASED_ORDERING_WIDTH 1
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_NO_SNOOP_OFST 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_NO_SNOOP_LBN 18
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_NO_SNOOP_WIDTH 1
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_TPH_ON_OFST 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_TPH_ON_LBN 19
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_TPH_ON_WIDTH 1
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_RELAXED_ORDERING_SYNC_DATA_OFST 4
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_RELAXED_ORDERING_SYNC_DATA_LBN 20
+#define	MC_CMD_SET_VI_TLP_PROCESSING_V2_IN_RELAXED_ORDERING_SYNC_DATA_WIDTH 1
+
 /* MC_CMD_SET_VI_TLP_PROCESSING_OUT msgresponse */
 #define	MC_CMD_SET_VI_TLP_PROCESSING_OUT_LEN 0
 
@@ -14640,12 +18387,16 @@
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_IN_TLP_GLOBAL_CATEGORY_LEN 4
 /* enum: MISC. */
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_IN_TLP_GLOBAL_CATEGORY_MISC 0x0
-/* enum: IDO. */
+/* enum: ID-based Ordering (IDO). */
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_IN_TLP_GLOBAL_CATEGORY_IDO 0x1
-/* enum: RO. */
+/* enum: Relaxed Ordering (RO), excluding LL queues. */
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_IN_TLP_GLOBAL_CATEGORY_RO 0x2
-/* enum: TPH Type. */
+/* enum: TLP Processing Hint (TPH) Type (excluding LL queues). */
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_IN_TLP_GLOBAL_CATEGORY_TPH_TYPE 0x3
+/* enum: Relaxed Ordering (RO) of LL queues. */
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_IN_TLP_GLOBAL_CATEGORY_LL_RO 0x4
+/* enum: TPH Type of LL queues. */
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_IN_TLP_GLOBAL_CATEGORY_LL_TPH_TYPE 0x5
 
 /* MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT msgresponse */
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_LEN 8
@@ -14659,9 +18410,6 @@
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_MISC_WTAG_EN_OFST 4
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_MISC_WTAG_EN_LBN 0
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_MISC_WTAG_EN_WIDTH 1
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_MISC_SPARE_OFST 4
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_MISC_SPARE_LBN 1
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_MISC_SPARE_WIDTH 31
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_IDO_DL_EN_OFST 4
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_IDO_DL_EN_LBN 0
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_IDO_DL_EN_WIDTH 1
@@ -14674,9 +18422,6 @@
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_IDO_RX_EN_OFST 4
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_IDO_RX_EN_LBN 3
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_IDO_RX_EN_WIDTH 1
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_IDO_SPARE_OFST 4
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_IDO_SPARE_LBN 4
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_IDO_SPARE_WIDTH 28
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_RO_RXDMA_EN_OFST 4
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_RO_RXDMA_EN_LBN 0
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_RO_RXDMA_EN_WIDTH 1
@@ -14686,9 +18431,6 @@
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_RO_DL_EN_OFST 4
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_RO_DL_EN_LBN 2
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_RO_DL_EN_WIDTH 1
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_RO_SPARE_OFST 4
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_RO_SPARE_LBN 3
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_RO_SPARE_WIDTH 29
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_TPH_TYPE_MSIX_OFST 4
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_TPH_TYPE_MSIX_LBN 0
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_TPH_TYPE_MSIX_WIDTH 2
@@ -14704,9 +18446,18 @@
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_TPH_TYPE_RX_OFST 4
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_TPH_TYPE_RX_LBN 8
 #define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_TPH_TYPE_RX_WIDTH 2
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_TLP_TYPE_SPARE_OFST 4
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_TLP_TYPE_SPARE_LBN 9
-#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_TLP_TYPE_SPARE_WIDTH 23
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_RO_RXDMA_EN_OFST 4
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_RO_RXDMA_EN_LBN 0
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_RO_RXDMA_EN_WIDTH 1
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_RO_PACKET_RXDMA_EN_OFST 4
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_RO_PACKET_RXDMA_EN_LBN 0
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_RO_PACKET_RXDMA_EN_WIDTH 1
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_RO_META_RXDMA_EN_OFST 4
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_RO_META_RXDMA_EN_LBN 1
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_RO_META_RXDMA_EN_WIDTH 1
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_TPH_TYPE_RX_OFST 4
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_TPH_TYPE_RX_LBN 0
+#define	MC_CMD_GET_TLP_PROCESSING_GLOBALS_OUT_TLP_INFO_LL_TPH_TYPE_RX_WIDTH 2
 
 
 /***********************************/
@@ -14767,9 +18518,18 @@
 #define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_TPH_TYPE_RX_OFST 4
 #define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_TPH_TYPE_RX_LBN 8
 #define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_TPH_TYPE_RX_WIDTH 2
-#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_SPARE_OFST 4
-#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_SPARE_LBN 10
-#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_SPARE_WIDTH 22
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_RO_RXDMA_EN_OFST 4
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_RO_RXDMA_EN_LBN 0
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_RO_RXDMA_EN_WIDTH 1
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_RO_PACKET_RXDMA_EN_OFST 4
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_RO_PACKET_RXDMA_EN_LBN 0
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_RO_PACKET_RXDMA_EN_WIDTH 1
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_RO_META_RXDMA_EN_OFST 4
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_RO_META_RXDMA_EN_LBN 1
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_RO_META_RXDMA_EN_WIDTH 1
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_TPH_TYPE_RX_OFST 4
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_TPH_TYPE_RX_LBN 0
+#define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_IN_TLP_INFO_LL_TPH_TYPE_RX_WIDTH 2
 
 /* MC_CMD_SET_TLP_PROCESSING_GLOBALS_OUT msgresponse */
 #define	MC_CMD_SET_TLP_PROCESSING_GLOBALS_OUT_LEN 0
@@ -15557,7 +19317,10 @@
 /*               MC_CMD_GET_CAPABILITIES_V2_OUT_ACCESS_NOT_PERMITTED 0xff */
 /* enum: PF does not exist. */
 /*               MC_CMD_GET_CAPABILITIES_V2_OUT_PF_NOT_PRESENT 0xfe */
-/* Number of VIs available for each external port */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
 #define	MC_CMD_GET_CAPABILITIES_V2_OUT_NUM_VIS_PER_PORT_OFST 58
 #define	MC_CMD_GET_CAPABILITIES_V2_OUT_NUM_VIS_PER_PORT_LEN 2
 #define	MC_CMD_GET_CAPABILITIES_V2_OUT_NUM_VIS_PER_PORT_NUM 4
@@ -15967,7 +19730,10 @@
 /*               MC_CMD_GET_CAPABILITIES_V3_OUT_ACCESS_NOT_PERMITTED 0xff */
 /* enum: PF does not exist. */
 /*               MC_CMD_GET_CAPABILITIES_V3_OUT_PF_NOT_PRESENT 0xfe */
-/* Number of VIs available for each external port */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
 #define	MC_CMD_GET_CAPABILITIES_V3_OUT_NUM_VIS_PER_PORT_OFST 58
 #define	MC_CMD_GET_CAPABILITIES_V3_OUT_NUM_VIS_PER_PORT_LEN 2
 #define	MC_CMD_GET_CAPABILITIES_V3_OUT_NUM_VIS_PER_PORT_NUM 4
@@ -16402,7 +20168,10 @@
 /*               MC_CMD_GET_CAPABILITIES_V4_OUT_ACCESS_NOT_PERMITTED 0xff */
 /* enum: PF does not exist. */
 /*               MC_CMD_GET_CAPABILITIES_V4_OUT_PF_NOT_PRESENT 0xfe */
-/* Number of VIs available for each external port */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
 #define	MC_CMD_GET_CAPABILITIES_V4_OUT_NUM_VIS_PER_PORT_OFST 58
 #define	MC_CMD_GET_CAPABILITIES_V4_OUT_NUM_VIS_PER_PORT_LEN 2
 #define	MC_CMD_GET_CAPABILITIES_V4_OUT_NUM_VIS_PER_PORT_NUM 4
@@ -16845,7 +20614,10 @@
 /*               MC_CMD_GET_CAPABILITIES_V5_OUT_ACCESS_NOT_PERMITTED 0xff */
 /* enum: PF does not exist. */
 /*               MC_CMD_GET_CAPABILITIES_V5_OUT_PF_NOT_PRESENT 0xfe */
-/* Number of VIs available for each external port */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
 #define	MC_CMD_GET_CAPABILITIES_V5_OUT_NUM_VIS_PER_PORT_OFST 58
 #define	MC_CMD_GET_CAPABILITIES_V5_OUT_NUM_VIS_PER_PORT_LEN 2
 #define	MC_CMD_GET_CAPABILITIES_V5_OUT_NUM_VIS_PER_PORT_NUM 4
@@ -17293,7 +21065,10 @@
 /*               MC_CMD_GET_CAPABILITIES_V6_OUT_ACCESS_NOT_PERMITTED 0xff */
 /* enum: PF does not exist. */
 /*               MC_CMD_GET_CAPABILITIES_V6_OUT_PF_NOT_PRESENT 0xfe */
-/* Number of VIs available for each external port */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
 #define	MC_CMD_GET_CAPABILITIES_V6_OUT_NUM_VIS_PER_PORT_OFST 58
 #define	MC_CMD_GET_CAPABILITIES_V6_OUT_NUM_VIS_PER_PORT_LEN 2
 #define	MC_CMD_GET_CAPABILITIES_V6_OUT_NUM_VIS_PER_PORT_NUM 4
@@ -17752,7 +21527,10 @@
 /*               MC_CMD_GET_CAPABILITIES_V7_OUT_ACCESS_NOT_PERMITTED 0xff */
 /* enum: PF does not exist. */
 /*               MC_CMD_GET_CAPABILITIES_V7_OUT_PF_NOT_PRESENT 0xfe */
-/* Number of VIs available for each external port */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
 #define	MC_CMD_GET_CAPABILITIES_V7_OUT_NUM_VIS_PER_PORT_OFST 58
 #define	MC_CMD_GET_CAPABILITIES_V7_OUT_NUM_VIS_PER_PORT_LEN 2
 #define	MC_CMD_GET_CAPABILITIES_V7_OUT_NUM_VIS_PER_PORT_NUM 4
@@ -17872,6 +21650,12 @@
 #define	MC_CMD_GET_CAPABILITIES_V7_OUT_CLIENT_CMD_VF_PROXY_OFST 148
 #define	MC_CMD_GET_CAPABILITIES_V7_OUT_CLIENT_CMD_VF_PROXY_LBN 15
 #define	MC_CMD_GET_CAPABILITIES_V7_OUT_CLIENT_CMD_VF_PROXY_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V7_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V7_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V7_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V7_OUT_CXL_CONFIG_ENABLE_WIDTH 1
 
 /* MC_CMD_GET_CAPABILITIES_V8_OUT msgresponse */
 #define	MC_CMD_GET_CAPABILITIES_V8_OUT_LEN 160
@@ -18262,7 +22046,10 @@
 /*               MC_CMD_GET_CAPABILITIES_V8_OUT_ACCESS_NOT_PERMITTED 0xff */
 /* enum: PF does not exist. */
 /*               MC_CMD_GET_CAPABILITIES_V8_OUT_PF_NOT_PRESENT 0xfe */
-/* Number of VIs available for each external port */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
 #define	MC_CMD_GET_CAPABILITIES_V8_OUT_NUM_VIS_PER_PORT_OFST 58
 #define	MC_CMD_GET_CAPABILITIES_V8_OUT_NUM_VIS_PER_PORT_LEN 2
 #define	MC_CMD_GET_CAPABILITIES_V8_OUT_NUM_VIS_PER_PORT_NUM 4
@@ -18382,6 +22169,12 @@
 #define	MC_CMD_GET_CAPABILITIES_V8_OUT_CLIENT_CMD_VF_PROXY_OFST 148
 #define	MC_CMD_GET_CAPABILITIES_V8_OUT_CLIENT_CMD_VF_PROXY_LBN 15
 #define	MC_CMD_GET_CAPABILITIES_V8_OUT_CLIENT_CMD_VF_PROXY_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V8_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V8_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V8_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V8_OUT_CXL_CONFIG_ENABLE_WIDTH 1
 /* These bits are reserved for communicating test-specific capabilities to
  * host-side test software. All production drivers should treat this field as
  * opaque.
@@ -18786,7 +22579,10 @@
 /*               MC_CMD_GET_CAPABILITIES_V9_OUT_ACCESS_NOT_PERMITTED 0xff */
 /* enum: PF does not exist. */
 /*               MC_CMD_GET_CAPABILITIES_V9_OUT_PF_NOT_PRESENT 0xfe */
-/* Number of VIs available for each external port */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
 #define	MC_CMD_GET_CAPABILITIES_V9_OUT_NUM_VIS_PER_PORT_OFST 58
 #define	MC_CMD_GET_CAPABILITIES_V9_OUT_NUM_VIS_PER_PORT_LEN 2
 #define	MC_CMD_GET_CAPABILITIES_V9_OUT_NUM_VIS_PER_PORT_NUM 4
@@ -18906,6 +22702,12 @@
 #define	MC_CMD_GET_CAPABILITIES_V9_OUT_CLIENT_CMD_VF_PROXY_OFST 148
 #define	MC_CMD_GET_CAPABILITIES_V9_OUT_CLIENT_CMD_VF_PROXY_LBN 15
 #define	MC_CMD_GET_CAPABILITIES_V9_OUT_CLIENT_CMD_VF_PROXY_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V9_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V9_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V9_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V9_OUT_CXL_CONFIG_ENABLE_WIDTH 1
 /* These bits are reserved for communicating test-specific capabilities to
  * host-side test software. All production drivers should treat this field as
  * opaque.
@@ -19345,7 +23147,10 @@
 /*               MC_CMD_GET_CAPABILITIES_V10_OUT_ACCESS_NOT_PERMITTED 0xff */
 /* enum: PF does not exist. */
 /*               MC_CMD_GET_CAPABILITIES_V10_OUT_PF_NOT_PRESENT 0xfe */
-/* Number of VIs available for each external port */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
 #define	MC_CMD_GET_CAPABILITIES_V10_OUT_NUM_VIS_PER_PORT_OFST 58
 #define	MC_CMD_GET_CAPABILITIES_V10_OUT_NUM_VIS_PER_PORT_LEN 2
 #define	MC_CMD_GET_CAPABILITIES_V10_OUT_NUM_VIS_PER_PORT_NUM 4
@@ -19465,6 +23270,12 @@
 #define	MC_CMD_GET_CAPABILITIES_V10_OUT_CLIENT_CMD_VF_PROXY_OFST 148
 #define	MC_CMD_GET_CAPABILITIES_V10_OUT_CLIENT_CMD_VF_PROXY_LBN 15
 #define	MC_CMD_GET_CAPABILITIES_V10_OUT_CLIENT_CMD_VF_PROXY_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V10_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V10_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V10_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V10_OUT_CXL_CONFIG_ENABLE_WIDTH 1
 /* These bits are reserved for communicating test-specific capabilities to
  * host-side test software. All production drivers should treat this field as
  * opaque.
@@ -19529,6 +23340,1182 @@
 #define	MC_CMD_GET_CAPABILITIES_V10_OUT_GUARANTEED_QUEUE_SIZES_OFST 188
 #define	MC_CMD_GET_CAPABILITIES_V10_OUT_GUARANTEED_QUEUE_SIZES_LEN 4
 
+/* MC_CMD_GET_CAPABILITIES_V11_OUT msgresponse */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_LEN 196
+/* First word of flags. */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FLAGS1_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FLAGS1_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VPORT_RECONFIGURE_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VPORT_RECONFIGURE_LBN 3
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VPORT_RECONFIGURE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_STRIPING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_STRIPING_LBN 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_STRIPING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VADAPTOR_QUERY_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VADAPTOR_QUERY_LBN 5
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VADAPTOR_QUERY_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVB_PORT_VLAN_RESTRICT_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVB_PORT_VLAN_RESTRICT_LBN 6
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVB_PORT_VLAN_RESTRICT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_DRV_ATTACH_PREBOOT_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_DRV_ATTACH_PREBOOT_LBN 7
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_DRV_ATTACH_PREBOOT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_FORCE_EVENT_MERGING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_FORCE_EVENT_MERGING_LBN 8
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_FORCE_EVENT_MERGING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SET_MAC_ENHANCED_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SET_MAC_ENHANCED_LBN 9
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SET_MAC_ENHANCED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_UNKNOWN_UCAST_DST_FILTER_ALWAYS_MULTI_RECIPIENT_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_UNKNOWN_UCAST_DST_FILTER_ALWAYS_MULTI_RECIPIENT_LBN 10
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_UNKNOWN_UCAST_DST_FILTER_ALWAYS_MULTI_RECIPIENT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VADAPTOR_PERMIT_SET_MAC_WHEN_FILTERS_INSTALLED_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VADAPTOR_PERMIT_SET_MAC_WHEN_FILTERS_INSTALLED_LBN 11
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VADAPTOR_PERMIT_SET_MAC_WHEN_FILTERS_INSTALLED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_MAC_SECURITY_FILTERING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_MAC_SECURITY_FILTERING_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_MAC_SECURITY_FILTERING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_ADDITIONAL_RSS_MODES_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_ADDITIONAL_RSS_MODES_LBN 13
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_ADDITIONAL_RSS_MODES_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_QBB_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_QBB_LBN 14
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_QBB_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PACKED_STREAM_VAR_BUFFERS_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PACKED_STREAM_VAR_BUFFERS_LBN 15
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PACKED_STREAM_VAR_BUFFERS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_RSS_LIMITED_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_RSS_LIMITED_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_RSS_LIMITED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PACKED_STREAM_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PACKED_STREAM_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PACKED_STREAM_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_INCLUDE_FCS_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_INCLUDE_FCS_LBN 18
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_INCLUDE_FCS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_VLAN_INSERTION_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_VLAN_INSERTION_LBN 19
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_VLAN_INSERTION_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_VLAN_STRIPPING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_VLAN_STRIPPING_LBN 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_VLAN_STRIPPING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_LBN 21
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PREFIX_LEN_0_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PREFIX_LEN_0_LBN 22
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PREFIX_LEN_0_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PREFIX_LEN_14_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PREFIX_LEN_14_LBN 23
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_PREFIX_LEN_14_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_TIMESTAMP_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_TIMESTAMP_LBN 24
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_TIMESTAMP_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_BATCHING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_BATCHING_LBN 25
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_BATCHING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MCAST_FILTER_CHAINING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MCAST_FILTER_CHAINING_LBN 26
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MCAST_FILTER_CHAINING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_PM_AND_RXDP_COUNTERS_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_PM_AND_RXDP_COUNTERS_LBN 27
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_PM_AND_RXDP_COUNTERS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_DISABLE_SCATTER_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_DISABLE_SCATTER_LBN 28
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_DISABLE_SCATTER_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_MCAST_UDP_LOOPBACK_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_MCAST_UDP_LOOPBACK_LBN 29
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_MCAST_UDP_LOOPBACK_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVB_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVB_LBN 30
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVB_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VXLAN_NVGRE_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VXLAN_NVGRE_LBN 31
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VXLAN_NVGRE_WIDTH 1
+/* RxDPCPU firmware id. */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_DPCPU_FW_ID_OFST 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_DPCPU_FW_ID_LEN 2
+/* enum: Standard RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP 0x0
+/* enum: Low latency RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_LOW_LATENCY 0x1
+/* enum: Packed stream RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_PACKED_STREAM 0x2
+/* enum: Rules engine RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_RULES_ENGINE 0x5
+/* enum: DPDK RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_DPDK 0x6
+/* enum: BIST RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_BIST 0x10a
+/* enum: RXDP Test firmware image 1 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_FW_TO_MC_CUT_THROUGH 0x101
+/* enum: RXDP Test firmware image 2 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_FW_TO_MC_STORE_FORWARD 0x102
+/* enum: RXDP Test firmware image 3 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_FW_TO_MC_STORE_FORWARD_FIRST 0x103
+/* enum: RXDP Test firmware image 4 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_EVERY_EVENT_BATCHABLE 0x104
+/* enum: RXDP Test firmware image 5 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_BACKPRESSURE 0x105
+/* enum: RXDP Test firmware image 6 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_FW_PACKET_EDITS 0x106
+/* enum: RXDP Test firmware image 7 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_FW_RX_HDR_SPLIT 0x107
+/* enum: RXDP Test firmware image 8 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_FW_DISABLE_DL 0x108
+/* enum: RXDP Test firmware image 9 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_FW_DOORBELL_DELAY 0x10b
+/* enum: RXDP Test firmware image 10 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_TEST_FW_SLOW 0x10c
+/* TxDPCPU firmware id. */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_DPCPU_FW_ID_OFST 6
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_DPCPU_FW_ID_LEN 2
+/* enum: Standard TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXDP 0x0
+/* enum: Low latency TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXDP_LOW_LATENCY 0x1
+/* enum: High packet rate TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXDP_HIGH_PACKET_RATE 0x3
+/* enum: Rules engine TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXDP_RULES_ENGINE 0x5
+/* enum: DPDK TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXDP_DPDK 0x6
+/* enum: BIST TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXDP_BIST 0x12d
+/* enum: TXDP Test firmware image 1 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXDP_TEST_FW_TSO_EDIT 0x101
+/* enum: TXDP Test firmware image 2 */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXDP_TEST_FW_PACKET_EDITS 0x102
+/* enum: TXDP CSR bus test firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXDP_TEST_FW_CSR 0x103
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_VERSION_OFST 8
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_VERSION_LEN 2
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_VERSION_REV_OFST 8
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_VERSION_REV_LBN 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_VERSION_REV_WIDTH 12
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_VERSION_TYPE_OFST 8
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_VERSION_TYPE_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_VERSION_TYPE_WIDTH 4
+/* enum: reserved value - do not use (may indicate alternative interpretation
+ * of REV field in future)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_RESERVED 0x0
+/* enum: Trivial RX PD firmware for early Huntington development (Huntington
+ * development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_FIRST_PKT 0x1
+/* enum: RX PD firmware for telemetry prototyping (Medford2 development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_TESTFW_TELEMETRY 0x1
+/* enum: RX PD firmware with approximately Siena-compatible behaviour
+ * (Huntington development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_SIENA_COMPAT 0x2
+/* enum: Full featured RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_FULL_FEATURED 0x3
+/* enum: (deprecated original name for the FULL_FEATURED variant) */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_VSWITCH 0x3
+/* enum: siena_compat variant RX PD firmware using PM rather than MAC
+ * (Huntington development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_SIENA_COMPAT_PM 0x4
+/* enum: Low latency RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_LOW_LATENCY 0x5
+/* enum: Packed stream RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_PACKED_STREAM 0x6
+/* enum: RX PD firmware handling layer 2 only for high packet rate performance
+ * tests (Medford development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_LAYER2_PERF 0x7
+/* enum: Rules engine RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_RULES_ENGINE 0x8
+/* enum: Custom firmware variant (see SF-119495-PD and bug69716) */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_L3XUDP 0x9
+/* enum: DPDK RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_DPDK 0xa
+/* enum: RX PD firmware for GUE parsing prototype (Medford development only) */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_TESTFW_GUE_PROTOTYPE 0xe
+/* enum: RX PD firmware parsing but not filtering network overlay tunnel
+ * encapsulations (Medford development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXPD_FW_TYPE_TESTFW_ENCAP_PARSING_ONLY 0xf
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_VERSION_OFST 10
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_VERSION_LEN 2
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_VERSION_REV_OFST 10
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_VERSION_REV_LBN 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_VERSION_REV_WIDTH 12
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_VERSION_TYPE_OFST 10
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_VERSION_TYPE_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_VERSION_TYPE_WIDTH 4
+/* enum: reserved value - do not use (may indicate alternative interpretation
+ * of REV field in future)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_RESERVED 0x0
+/* enum: Trivial TX PD firmware for early Huntington development (Huntington
+ * development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_FIRST_PKT 0x1
+/* enum: TX PD firmware for telemetry prototyping (Medford2 development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_TESTFW_TELEMETRY 0x1
+/* enum: TX PD firmware with approximately Siena-compatible behaviour
+ * (Huntington development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_SIENA_COMPAT 0x2
+/* enum: Full featured TX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_FULL_FEATURED 0x3
+/* enum: (deprecated original name for the FULL_FEATURED variant) */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_VSWITCH 0x3
+/* enum: siena_compat variant TX PD firmware using PM rather than MAC
+ * (Huntington development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_SIENA_COMPAT_PM 0x4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_LOW_LATENCY 0x5 /* enum */
+/* enum: TX PD firmware handling layer 2 only for high packet rate performance
+ * tests (Medford development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_LAYER2_PERF 0x7
+/* enum: Rules engine TX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_RULES_ENGINE 0x8
+/* enum: Custom firmware variant (see SF-119495-PD and bug69716) */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_L3XUDP 0x9
+/* enum: DPDK TX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_DPDK 0xa
+/* enum: RX PD firmware for GUE parsing prototype (Medford development only) */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TXPD_FW_TYPE_TESTFW_GUE_PROTOTYPE 0xe
+/* Hardware capabilities of NIC */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_HW_CAPABILITIES_OFST 12
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_HW_CAPABILITIES_LEN 4
+/* Licensed capabilities */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_LICENSE_CAPABILITIES_OFST 16
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_LICENSE_CAPABILITIES_LEN 4
+/* Second word of flags. Not present on older firmware (check the length). */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FLAGS2_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FLAGS2_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V2_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V2_LBN 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V2_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V2_ENCAP_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V2_ENCAP_LBN 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V2_ENCAP_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVQ_TIMER_CTRL_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVQ_TIMER_CTRL_LBN 2
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVQ_TIMER_CTRL_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVENT_CUT_THROUGH_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVENT_CUT_THROUGH_LBN 3
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EVENT_CUT_THROUGH_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_CUT_THROUGH_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_CUT_THROUGH_LBN 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_CUT_THROUGH_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_VFIFO_ULL_MODE_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_VFIFO_ULL_MODE_LBN 5
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_VFIFO_ULL_MODE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAC_STATS_40G_TX_SIZE_BINS_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAC_STATS_40G_TX_SIZE_BINS_LBN 6
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAC_STATS_40G_TX_SIZE_BINS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_EVQ_TYPE_SUPPORTED_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_EVQ_TYPE_SUPPORTED_LBN 7
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_EVQ_TYPE_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_EVQ_V2_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_EVQ_V2_LBN 7
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_EVQ_V2_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_MAC_TIMESTAMPING_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_MAC_TIMESTAMPING_LBN 8
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_MAC_TIMESTAMPING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TIMESTAMP_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TIMESTAMP_LBN 9
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TIMESTAMP_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_SNIFF_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_SNIFF_LBN 10
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_SNIFF_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_SNIFF_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_SNIFF_LBN 11
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_SNIFF_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NVRAM_UPDATE_REPORT_VERIFY_RESULT_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NVRAM_UPDATE_REPORT_VERIFY_RESULT_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NVRAM_UPDATE_REPORT_VERIFY_RESULT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MCDI_BACKGROUND_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MCDI_BACKGROUND_LBN 13
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MCDI_BACKGROUND_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MCDI_DB_RETURN_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MCDI_DB_RETURN_LBN 14
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MCDI_DB_RETURN_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_CTPIO_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_CTPIO_LBN 15
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_CTPIO_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TSA_SUPPORT_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TSA_SUPPORT_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TSA_SUPPORT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TSA_BOUND_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TSA_BOUND_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TSA_BOUND_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SF_ADAPTER_AUTHENTICATION_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SF_ADAPTER_AUTHENTICATION_LBN 18
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SF_ADAPTER_AUTHENTICATION_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FILTER_ACTION_FLAG_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FILTER_ACTION_FLAG_LBN 19
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FILTER_ACTION_FLAG_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FILTER_ACTION_MARK_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FILTER_ACTION_MARK_LBN 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FILTER_ACTION_MARK_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EQUAL_STRIDE_SUPER_BUFFER_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EQUAL_STRIDE_SUPER_BUFFER_LBN 21
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EQUAL_STRIDE_SUPER_BUFFER_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EQUAL_STRIDE_PACKED_STREAM_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EQUAL_STRIDE_PACKED_STREAM_LBN 21
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EQUAL_STRIDE_PACKED_STREAM_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_L3XUDP_SUPPORT_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_L3XUDP_SUPPORT_LBN 22
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_L3XUDP_SUPPORT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FW_SUBVARIANT_NO_TX_CSUM_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FW_SUBVARIANT_NO_TX_CSUM_LBN 23
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FW_SUBVARIANT_NO_TX_CSUM_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VI_SPREADING_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VI_SPREADING_LBN 24
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VI_SPREADING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_HLB_IDLE_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_HLB_IDLE_LBN 25
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RXDP_HLB_IDLE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_RXQ_NO_CONT_EV_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_RXQ_NO_CONT_EV_LBN 26
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_RXQ_NO_CONT_EV_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_RXQ_WITH_BUFFER_SIZE_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_RXQ_WITH_BUFFER_SIZE_LBN 27
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INIT_RXQ_WITH_BUFFER_SIZE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_BUNDLE_UPDATE_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_BUNDLE_UPDATE_LBN 28
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_BUNDLE_UPDATE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V3_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V3_LBN 29
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V3_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_DYNAMIC_SENSORS_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_DYNAMIC_SENSORS_LBN 30
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_DYNAMIC_SENSORS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NVRAM_UPDATE_POLL_VERIFY_RESULT_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NVRAM_UPDATE_POLL_VERIFY_RESULT_LBN 31
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NVRAM_UPDATE_POLL_VERIFY_RESULT_WIDTH 1
+/* Number of FATSOv2 contexts per datapath supported by this NIC (when
+ * TX_TSO_V2 == 1). Not present on older firmware (check the length).
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V2_N_CONTEXTS_OFST 24
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_TSO_V2_N_CONTEXTS_LEN 2
+/* One byte per PF containing the number of the external port assigned to this
+ * PF, indexed by PF number. Special values indicate that a PF is either not
+ * present or not assigned.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_PFS_TO_PORTS_ASSIGNMENT_OFST 26
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_PFS_TO_PORTS_ASSIGNMENT_LEN 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_PFS_TO_PORTS_ASSIGNMENT_NUM 16
+/* enum: The caller is not permitted to access information on this PF. */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_ACCESS_NOT_PERMITTED 0xff
+/* enum: PF does not exist. */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_PF_NOT_PRESENT 0xfe
+/* enum: PF does exist but is not assigned to any external port. */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_PF_NOT_ASSIGNED 0xfd
+/* enum: This value indicates that PF is assigned, but it cannot be expressed
+ * in this field. It is intended for a possible future situation where a more
+ * complex scheme of PFs to ports mapping is being used. The future driver
+ * should look for a new field supporting the new scheme. The current/old
+ * driver should treat this value as PF_NOT_ASSIGNED.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INCOMPATIBLE_ASSIGNMENT 0xfc
+/* One byte per PF containing the number of its VFs, indexed by PF number. A
+ * special value indicates that a PF is not present.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NUM_VFS_PER_PF_OFST 42
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NUM_VFS_PER_PF_LEN 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NUM_VFS_PER_PF_NUM 16
+/* enum: The caller is not permitted to access information on this PF. */
+/*               MC_CMD_GET_CAPABILITIES_V11_OUT_ACCESS_NOT_PERMITTED 0xff */
+/* enum: PF does not exist. */
+/*               MC_CMD_GET_CAPABILITIES_V11_OUT_PF_NOT_PRESENT 0xfe */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NUM_VIS_PER_PORT_OFST 58
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NUM_VIS_PER_PORT_LEN 2
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NUM_VIS_PER_PORT_NUM 4
+/* Size of RX descriptor cache expressed as binary logarithm The actual size
+ * equals (2 ^ RX_DESC_CACHE_SIZE)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_DESC_CACHE_SIZE_OFST 66
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_DESC_CACHE_SIZE_LEN 1
+/* Size of TX descriptor cache expressed as binary logarithm The actual size
+ * equals (2 ^ TX_DESC_CACHE_SIZE)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_DESC_CACHE_SIZE_OFST 67
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TX_DESC_CACHE_SIZE_LEN 1
+/* Total number of available PIO buffers */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NUM_PIO_BUFFS_OFST 68
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NUM_PIO_BUFFS_LEN 2
+/* Size of a single PIO buffer */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SIZE_PIO_BUFF_OFST 70
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SIZE_PIO_BUFF_LEN 2
+/* On chips later than Medford the amount of address space assigned to each VI
+ * is configurable. This is a global setting that the driver must query to
+ * discover the VI to address mapping. Cut-through PIO (CTPIO) is not available
+ * with 8k VI windows.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VI_WINDOW_MODE_OFST 72
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VI_WINDOW_MODE_LEN 1
+/* enum: Each VI occupies 8k as on Huntington and Medford. PIO is at offset 4k.
+ * CTPIO is not mapped.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VI_WINDOW_MODE_8K 0x0
+/* enum: Each VI occupies 16k. PIO is at offset 4k. CTPIO is at offset 12k. */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VI_WINDOW_MODE_16K 0x1
+/* enum: Each VI occupies 64k. PIO is at offset 4k. CTPIO is at offset 12k. */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VI_WINDOW_MODE_64K 0x2
+/* Number of vFIFOs per adapter that can be used for VFIFO Stuffing
+ * (SF-115995-SW) in the present configuration of firmware and port mode.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VFIFO_STUFFING_NUM_VFIFOS_OFST 73
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VFIFO_STUFFING_NUM_VFIFOS_LEN 1
+/* Number of buffers per adapter that can be used for VFIFO Stuffing
+ * (SF-115995-SW) in the present configuration of firmware and port mode.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VFIFO_STUFFING_NUM_CP_BUFFERS_OFST 74
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VFIFO_STUFFING_NUM_CP_BUFFERS_LEN 2
+/* Entry count in the MAC stats array, including the final GENERATION_END
+ * entry. For MAC stats DMA, drivers should allocate a buffer large enough to
+ * hold at least this many 64-bit stats values, if they wish to receive all
+ * available stats. If the buffer is shorter than MAC_STATS_NUM_STATS * 8, the
+ * stats array returned will be truncated.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAC_STATS_NUM_STATS_OFST 76
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAC_STATS_NUM_STATS_LEN 2
+/* Maximum supported value for MC_CMD_FILTER_OP_V3/MATCH_MARK_VALUE. This field
+ * will only be non-zero if MC_CMD_GET_CAPABILITIES/FILTER_ACTION_MARK is set.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FILTER_ACTION_MARK_MAX_OFST 80
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FILTER_ACTION_MARK_MAX_LEN 4
+/* On devices where the INIT_RXQ_WITH_BUFFER_SIZE flag (in
+ * GET_CAPABILITIES_OUT_V2) is set, drivers have to specify a buffer size when
+ * they create an RX queue. Due to hardware limitations, only a small number of
+ * different buffer sizes may be available concurrently. Nonzero entries in
+ * this array are the sizes of buffers which the system guarantees will be
+ * available for use. If the list is empty, there are no limitations on
+ * concurrent buffer sizes.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_GUARANTEED_RX_BUFFER_SIZES_OFST 84
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_GUARANTEED_RX_BUFFER_SIZES_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_GUARANTEED_RX_BUFFER_SIZES_NUM 16
+/* Third word of flags. Not present on older firmware (check the length). */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FLAGS3_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_FLAGS3_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_WOL_ETHERWAKE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_WOL_ETHERWAKE_LBN 0
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_WOL_ETHERWAKE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_EVEN_SPREADING_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_EVEN_SPREADING_LBN 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_EVEN_SPREADING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_SELECTABLE_TABLE_SIZE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_SELECTABLE_TABLE_SIZE_LBN 2
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_SELECTABLE_TABLE_SIZE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAE_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAE_SUPPORTED_LBN 3
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAE_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VDPA_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VDPA_SUPPORTED_LBN 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_VDPA_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_VLAN_STRIPPING_PER_ENCAP_RULE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_VLAN_STRIPPING_PER_ENCAP_RULE_LBN 5
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RX_VLAN_STRIPPING_PER_ENCAP_RULE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EXTENDED_WIDTH_EVQS_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EXTENDED_WIDTH_EVQS_SUPPORTED_LBN 6
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EXTENDED_WIDTH_EVQS_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_UNSOL_EV_CREDIT_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_UNSOL_EV_CREDIT_SUPPORTED_LBN 7
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_UNSOL_EV_CREDIT_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_ENCAPSULATED_MCDI_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_ENCAPSULATED_MCDI_SUPPORTED_LBN 8
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_ENCAPSULATED_MCDI_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EXTERNAL_MAE_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EXTERNAL_MAE_SUPPORTED_LBN 9
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_EXTERNAL_MAE_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NVRAM_UPDATE_ABORT_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NVRAM_UPDATE_ABORT_SUPPORTED_LBN 10
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_NVRAM_UPDATE_ABORT_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAE_ACTION_SET_ALLOC_V2_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAE_ACTION_SET_ALLOC_V2_SUPPORTED_LBN 11
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAE_ACTION_SET_ALLOC_V2_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_STEER_ON_OUTER_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_STEER_ON_OUTER_SUPPORTED_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_STEER_ON_OUTER_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAE_ACTION_SET_ALLOC_V3_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAE_ACTION_SET_ALLOC_V3_SUPPORTED_LBN 13
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_MAE_ACTION_SET_ALLOC_V3_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_CLIENT_CMD_VF_PROXY_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_CLIENT_CMD_VF_PROXY_LBN 15
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_CLIENT_CMD_VF_PROXY_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_CXL_CONFIG_ENABLE_WIDTH 1
+/* These bits are reserved for communicating test-specific capabilities to
+ * host-side test software. All production drivers should treat this field as
+ * opaque.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_OFST 152
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_LEN 8
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_LO_OFST 152
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_LO_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_LO_LBN 1216
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_LO_WIDTH 32
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_HI_OFST 156
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_HI_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_HI_LBN 1248
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_TEST_RESERVED_HI_WIDTH 32
+/* The minimum size (in table entries) of indirection table to be allocated
+ * from the pool for an RSS context. Note that the table size used must be a
+ * power of 2.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_MIN_INDIRECTION_TABLE_SIZE_OFST 160
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_MIN_INDIRECTION_TABLE_SIZE_LEN 4
+/* The maximum size (in table entries) of indirection table to be allocated
+ * from the pool for an RSS context. Note that the table size used must be a
+ * power of 2.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_MAX_INDIRECTION_TABLE_SIZE_OFST 164
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_MAX_INDIRECTION_TABLE_SIZE_LEN 4
+/* The maximum number of queues that can be used by an RSS context in exclusive
+ * mode. In exclusive mode the context has a configurable indirection table and
+ * a configurable RSS key.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_MAX_INDIRECTION_QUEUES_OFST 168
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_MAX_INDIRECTION_QUEUES_LEN 4
+/* The maximum number of queues that can be used by an RSS context in even-
+ * spreading mode. In even-spreading mode the context has no indirection table
+ * but it does have a configurable RSS key.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_MAX_EVEN_SPREADING_QUEUES_OFST 172
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_MAX_EVEN_SPREADING_QUEUES_LEN 4
+/* The total number of RSS contexts supported. Note that the number of
+ * available contexts using indirection tables is also limited by the
+ * availability of indirection table space allocated from a common pool.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_NUM_CONTEXTS_OFST 176
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_NUM_CONTEXTS_LEN 4
+/* The total amount of indirection table space that can be shared between RSS
+ * contexts.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_TABLE_POOL_SIZE_OFST 180
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_RSS_TABLE_POOL_SIZE_LEN 4
+/* A bitmap of the queue sizes the device can provide, where bit N being set
+ * indicates that 2**N is a valid size. The device may be limited in the number
+ * of different queue sizes that can exist simultaneously, so a bit being set
+ * here does not guarantee that an attempt to create a queue of that size will
+ * succeed.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SUPPORTED_QUEUE_SIZES_OFST 184
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_SUPPORTED_QUEUE_SIZES_LEN 4
+/* A bitmap of queue sizes that are always available, in the same format as
+ * SUPPORTED_QUEUE_SIZES. Attempting to create a queue with one of these sizes
+ * will never fail due to unavailability of the requested size.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_GUARANTEED_QUEUE_SIZES_OFST 188
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_GUARANTEED_QUEUE_SIZES_LEN 4
+/* Number of available indirect memory maps. */
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INDIRECT_MAP_INDEX_COUNT_OFST 192
+#define	MC_CMD_GET_CAPABILITIES_V11_OUT_INDIRECT_MAP_INDEX_COUNT_LEN 4
+
+/* MC_CMD_GET_CAPABILITIES_V12_OUT msgresponse */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_LEN 204
+/* First word of flags. */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FLAGS1_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FLAGS1_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VPORT_RECONFIGURE_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VPORT_RECONFIGURE_LBN 3
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VPORT_RECONFIGURE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_STRIPING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_STRIPING_LBN 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_STRIPING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VADAPTOR_QUERY_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VADAPTOR_QUERY_LBN 5
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VADAPTOR_QUERY_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVB_PORT_VLAN_RESTRICT_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVB_PORT_VLAN_RESTRICT_LBN 6
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVB_PORT_VLAN_RESTRICT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_DRV_ATTACH_PREBOOT_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_DRV_ATTACH_PREBOOT_LBN 7
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_DRV_ATTACH_PREBOOT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_FORCE_EVENT_MERGING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_FORCE_EVENT_MERGING_LBN 8
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_FORCE_EVENT_MERGING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SET_MAC_ENHANCED_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SET_MAC_ENHANCED_LBN 9
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SET_MAC_ENHANCED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_UNKNOWN_UCAST_DST_FILTER_ALWAYS_MULTI_RECIPIENT_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_UNKNOWN_UCAST_DST_FILTER_ALWAYS_MULTI_RECIPIENT_LBN 10
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_UNKNOWN_UCAST_DST_FILTER_ALWAYS_MULTI_RECIPIENT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VADAPTOR_PERMIT_SET_MAC_WHEN_FILTERS_INSTALLED_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VADAPTOR_PERMIT_SET_MAC_WHEN_FILTERS_INSTALLED_LBN 11
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VADAPTOR_PERMIT_SET_MAC_WHEN_FILTERS_INSTALLED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_MAC_SECURITY_FILTERING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_MAC_SECURITY_FILTERING_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_MAC_SECURITY_FILTERING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_ADDITIONAL_RSS_MODES_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_ADDITIONAL_RSS_MODES_LBN 13
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_ADDITIONAL_RSS_MODES_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_QBB_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_QBB_LBN 14
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_QBB_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PACKED_STREAM_VAR_BUFFERS_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PACKED_STREAM_VAR_BUFFERS_LBN 15
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PACKED_STREAM_VAR_BUFFERS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_RSS_LIMITED_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_RSS_LIMITED_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_RSS_LIMITED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PACKED_STREAM_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PACKED_STREAM_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PACKED_STREAM_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_INCLUDE_FCS_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_INCLUDE_FCS_LBN 18
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_INCLUDE_FCS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_VLAN_INSERTION_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_VLAN_INSERTION_LBN 19
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_VLAN_INSERTION_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_VLAN_STRIPPING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_VLAN_STRIPPING_LBN 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_VLAN_STRIPPING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_LBN 21
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PREFIX_LEN_0_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PREFIX_LEN_0_LBN 22
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PREFIX_LEN_0_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PREFIX_LEN_14_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PREFIX_LEN_14_LBN 23
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_PREFIX_LEN_14_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_TIMESTAMP_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_TIMESTAMP_LBN 24
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_TIMESTAMP_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_BATCHING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_BATCHING_LBN 25
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_BATCHING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MCAST_FILTER_CHAINING_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MCAST_FILTER_CHAINING_LBN 26
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MCAST_FILTER_CHAINING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_PM_AND_RXDP_COUNTERS_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_PM_AND_RXDP_COUNTERS_LBN 27
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_PM_AND_RXDP_COUNTERS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_DISABLE_SCATTER_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_DISABLE_SCATTER_LBN 28
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_DISABLE_SCATTER_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_MCAST_UDP_LOOPBACK_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_MCAST_UDP_LOOPBACK_LBN 29
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_MCAST_UDP_LOOPBACK_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVB_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVB_LBN 30
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVB_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VXLAN_NVGRE_OFST 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VXLAN_NVGRE_LBN 31
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VXLAN_NVGRE_WIDTH 1
+/* RxDPCPU firmware id. */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_DPCPU_FW_ID_OFST 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_DPCPU_FW_ID_LEN 2
+/* enum: Standard RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP 0x0
+/* enum: Low latency RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_LOW_LATENCY 0x1
+/* enum: Packed stream RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_PACKED_STREAM 0x2
+/* enum: Rules engine RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_RULES_ENGINE 0x5
+/* enum: DPDK RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_DPDK 0x6
+/* enum: BIST RXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_BIST 0x10a
+/* enum: RXDP Test firmware image 1 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_FW_TO_MC_CUT_THROUGH 0x101
+/* enum: RXDP Test firmware image 2 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_FW_TO_MC_STORE_FORWARD 0x102
+/* enum: RXDP Test firmware image 3 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_FW_TO_MC_STORE_FORWARD_FIRST 0x103
+/* enum: RXDP Test firmware image 4 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_EVERY_EVENT_BATCHABLE 0x104
+/* enum: RXDP Test firmware image 5 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_BACKPRESSURE 0x105
+/* enum: RXDP Test firmware image 6 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_FW_PACKET_EDITS 0x106
+/* enum: RXDP Test firmware image 7 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_FW_RX_HDR_SPLIT 0x107
+/* enum: RXDP Test firmware image 8 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_FW_DISABLE_DL 0x108
+/* enum: RXDP Test firmware image 9 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_FW_DOORBELL_DELAY 0x10b
+/* enum: RXDP Test firmware image 10 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_TEST_FW_SLOW 0x10c
+/* TxDPCPU firmware id. */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_DPCPU_FW_ID_OFST 6
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_DPCPU_FW_ID_LEN 2
+/* enum: Standard TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXDP 0x0
+/* enum: Low latency TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXDP_LOW_LATENCY 0x1
+/* enum: High packet rate TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXDP_HIGH_PACKET_RATE 0x3
+/* enum: Rules engine TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXDP_RULES_ENGINE 0x5
+/* enum: DPDK TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXDP_DPDK 0x6
+/* enum: BIST TXDP firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXDP_BIST 0x12d
+/* enum: TXDP Test firmware image 1 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXDP_TEST_FW_TSO_EDIT 0x101
+/* enum: TXDP Test firmware image 2 */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXDP_TEST_FW_PACKET_EDITS 0x102
+/* enum: TXDP CSR bus test firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXDP_TEST_FW_CSR 0x103
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_VERSION_OFST 8
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_VERSION_LEN 2
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_VERSION_REV_OFST 8
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_VERSION_REV_LBN 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_VERSION_REV_WIDTH 12
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_VERSION_TYPE_OFST 8
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_VERSION_TYPE_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_VERSION_TYPE_WIDTH 4
+/* enum: reserved value - do not use (may indicate alternative interpretation
+ * of REV field in future)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_RESERVED 0x0
+/* enum: Trivial RX PD firmware for early Huntington development (Huntington
+ * development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_FIRST_PKT 0x1
+/* enum: RX PD firmware for telemetry prototyping (Medford2 development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_TESTFW_TELEMETRY 0x1
+/* enum: RX PD firmware with approximately Siena-compatible behaviour
+ * (Huntington development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_SIENA_COMPAT 0x2
+/* enum: Full featured RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_FULL_FEATURED 0x3
+/* enum: (deprecated original name for the FULL_FEATURED variant) */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_VSWITCH 0x3
+/* enum: siena_compat variant RX PD firmware using PM rather than MAC
+ * (Huntington development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_SIENA_COMPAT_PM 0x4
+/* enum: Low latency RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_LOW_LATENCY 0x5
+/* enum: Packed stream RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_PACKED_STREAM 0x6
+/* enum: RX PD firmware handling layer 2 only for high packet rate performance
+ * tests (Medford development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_LAYER2_PERF 0x7
+/* enum: Rules engine RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_RULES_ENGINE 0x8
+/* enum: Custom firmware variant (see SF-119495-PD and bug69716) */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_L3XUDP 0x9
+/* enum: DPDK RX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_DPDK 0xa
+/* enum: RX PD firmware for GUE parsing prototype (Medford development only) */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_TESTFW_GUE_PROTOTYPE 0xe
+/* enum: RX PD firmware parsing but not filtering network overlay tunnel
+ * encapsulations (Medford development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXPD_FW_TYPE_TESTFW_ENCAP_PARSING_ONLY 0xf
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_VERSION_OFST 10
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_VERSION_LEN 2
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_VERSION_REV_OFST 10
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_VERSION_REV_LBN 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_VERSION_REV_WIDTH 12
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_VERSION_TYPE_OFST 10
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_VERSION_TYPE_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_VERSION_TYPE_WIDTH 4
+/* enum: reserved value - do not use (may indicate alternative interpretation
+ * of REV field in future)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_RESERVED 0x0
+/* enum: Trivial TX PD firmware for early Huntington development (Huntington
+ * development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_FIRST_PKT 0x1
+/* enum: TX PD firmware for telemetry prototyping (Medford2 development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_TESTFW_TELEMETRY 0x1
+/* enum: TX PD firmware with approximately Siena-compatible behaviour
+ * (Huntington development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_SIENA_COMPAT 0x2
+/* enum: Full featured TX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_FULL_FEATURED 0x3
+/* enum: (deprecated original name for the FULL_FEATURED variant) */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_VSWITCH 0x3
+/* enum: siena_compat variant TX PD firmware using PM rather than MAC
+ * (Huntington development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_SIENA_COMPAT_PM 0x4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_LOW_LATENCY 0x5 /* enum */
+/* enum: TX PD firmware handling layer 2 only for high packet rate performance
+ * tests (Medford development only)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_LAYER2_PERF 0x7
+/* enum: Rules engine TX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_RULES_ENGINE 0x8
+/* enum: Custom firmware variant (see SF-119495-PD and bug69716) */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_L3XUDP 0x9
+/* enum: DPDK TX PD production firmware */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_DPDK 0xa
+/* enum: RX PD firmware for GUE parsing prototype (Medford development only) */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TXPD_FW_TYPE_TESTFW_GUE_PROTOTYPE 0xe
+/* Hardware capabilities of NIC */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_HW_CAPABILITIES_OFST 12
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_HW_CAPABILITIES_LEN 4
+/* Licensed capabilities */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_LICENSE_CAPABILITIES_OFST 16
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_LICENSE_CAPABILITIES_LEN 4
+/* Second word of flags. Not present on older firmware (check the length). */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FLAGS2_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FLAGS2_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V2_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V2_LBN 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V2_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V2_ENCAP_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V2_ENCAP_LBN 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V2_ENCAP_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVQ_TIMER_CTRL_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVQ_TIMER_CTRL_LBN 2
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVQ_TIMER_CTRL_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVENT_CUT_THROUGH_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVENT_CUT_THROUGH_LBN 3
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EVENT_CUT_THROUGH_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_CUT_THROUGH_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_CUT_THROUGH_LBN 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_CUT_THROUGH_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_VFIFO_ULL_MODE_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_VFIFO_ULL_MODE_LBN 5
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_VFIFO_ULL_MODE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAC_STATS_40G_TX_SIZE_BINS_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAC_STATS_40G_TX_SIZE_BINS_LBN 6
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAC_STATS_40G_TX_SIZE_BINS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_EVQ_TYPE_SUPPORTED_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_EVQ_TYPE_SUPPORTED_LBN 7
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_EVQ_TYPE_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_EVQ_V2_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_EVQ_V2_LBN 7
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_EVQ_V2_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_MAC_TIMESTAMPING_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_MAC_TIMESTAMPING_LBN 8
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_MAC_TIMESTAMPING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TIMESTAMP_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TIMESTAMP_LBN 9
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TIMESTAMP_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_SNIFF_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_SNIFF_LBN 10
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_SNIFF_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_SNIFF_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_SNIFF_LBN 11
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_SNIFF_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NVRAM_UPDATE_REPORT_VERIFY_RESULT_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NVRAM_UPDATE_REPORT_VERIFY_RESULT_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NVRAM_UPDATE_REPORT_VERIFY_RESULT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MCDI_BACKGROUND_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MCDI_BACKGROUND_LBN 13
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MCDI_BACKGROUND_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MCDI_DB_RETURN_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MCDI_DB_RETURN_LBN 14
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MCDI_DB_RETURN_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_CTPIO_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_CTPIO_LBN 15
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_CTPIO_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TSA_SUPPORT_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TSA_SUPPORT_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TSA_SUPPORT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TSA_BOUND_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TSA_BOUND_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TSA_BOUND_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SF_ADAPTER_AUTHENTICATION_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SF_ADAPTER_AUTHENTICATION_LBN 18
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SF_ADAPTER_AUTHENTICATION_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FILTER_ACTION_FLAG_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FILTER_ACTION_FLAG_LBN 19
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FILTER_ACTION_FLAG_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FILTER_ACTION_MARK_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FILTER_ACTION_MARK_LBN 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FILTER_ACTION_MARK_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EQUAL_STRIDE_SUPER_BUFFER_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EQUAL_STRIDE_SUPER_BUFFER_LBN 21
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EQUAL_STRIDE_SUPER_BUFFER_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EQUAL_STRIDE_PACKED_STREAM_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EQUAL_STRIDE_PACKED_STREAM_LBN 21
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EQUAL_STRIDE_PACKED_STREAM_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_L3XUDP_SUPPORT_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_L3XUDP_SUPPORT_LBN 22
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_L3XUDP_SUPPORT_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FW_SUBVARIANT_NO_TX_CSUM_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FW_SUBVARIANT_NO_TX_CSUM_LBN 23
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FW_SUBVARIANT_NO_TX_CSUM_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VI_SPREADING_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VI_SPREADING_LBN 24
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VI_SPREADING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_HLB_IDLE_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_HLB_IDLE_LBN 25
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RXDP_HLB_IDLE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_RXQ_NO_CONT_EV_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_RXQ_NO_CONT_EV_LBN 26
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_RXQ_NO_CONT_EV_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_RXQ_WITH_BUFFER_SIZE_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_RXQ_WITH_BUFFER_SIZE_LBN 27
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INIT_RXQ_WITH_BUFFER_SIZE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_BUNDLE_UPDATE_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_BUNDLE_UPDATE_LBN 28
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_BUNDLE_UPDATE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V3_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V3_LBN 29
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V3_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_DYNAMIC_SENSORS_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_DYNAMIC_SENSORS_LBN 30
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_DYNAMIC_SENSORS_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NVRAM_UPDATE_POLL_VERIFY_RESULT_OFST 20
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NVRAM_UPDATE_POLL_VERIFY_RESULT_LBN 31
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NVRAM_UPDATE_POLL_VERIFY_RESULT_WIDTH 1
+/* Number of FATSOv2 contexts per datapath supported by this NIC (when
+ * TX_TSO_V2 == 1). Not present on older firmware (check the length).
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V2_N_CONTEXTS_OFST 24
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_TSO_V2_N_CONTEXTS_LEN 2
+/* One byte per PF containing the number of the external port assigned to this
+ * PF, indexed by PF number. Special values indicate that a PF is either not
+ * present or not assigned.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_PFS_TO_PORTS_ASSIGNMENT_OFST 26
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_PFS_TO_PORTS_ASSIGNMENT_LEN 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_PFS_TO_PORTS_ASSIGNMENT_NUM 16
+/* enum: The caller is not permitted to access information on this PF. */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_ACCESS_NOT_PERMITTED 0xff
+/* enum: PF does not exist. */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_PF_NOT_PRESENT 0xfe
+/* enum: PF does exist but is not assigned to any external port. */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_PF_NOT_ASSIGNED 0xfd
+/* enum: This value indicates that PF is assigned, but it cannot be expressed
+ * in this field. It is intended for a possible future situation where a more
+ * complex scheme of PFs to ports mapping is being used. The future driver
+ * should look for a new field supporting the new scheme. The current/old
+ * driver should treat this value as PF_NOT_ASSIGNED.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INCOMPATIBLE_ASSIGNMENT 0xfc
+/* One byte per PF containing the number of its VFs, indexed by PF number. A
+ * special value indicates that a PF is not present.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_VFS_PER_PF_OFST 42
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_VFS_PER_PF_LEN 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_VFS_PER_PF_NUM 16
+/* enum: The caller is not permitted to access information on this PF. */
+/*               MC_CMD_GET_CAPABILITIES_V12_OUT_ACCESS_NOT_PERMITTED 0xff */
+/* enum: PF does not exist. */
+/*               MC_CMD_GET_CAPABILITIES_V12_OUT_PF_NOT_PRESENT 0xfe */
+/* Number of VIs available for external ports 0-3. For devices with more than
+ * four ports, the remainder are in NUM_VIS_PER_PORT2 in
+ * GET_CAPABILITIES_V12_OUT.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_VIS_PER_PORT_OFST 58
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_VIS_PER_PORT_LEN 2
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_VIS_PER_PORT_NUM 4
+/* Size of RX descriptor cache expressed as binary logarithm The actual size
+ * equals (2 ^ RX_DESC_CACHE_SIZE)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_DESC_CACHE_SIZE_OFST 66
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_DESC_CACHE_SIZE_LEN 1
+/* Size of TX descriptor cache expressed as binary logarithm The actual size
+ * equals (2 ^ TX_DESC_CACHE_SIZE)
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_DESC_CACHE_SIZE_OFST 67
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TX_DESC_CACHE_SIZE_LEN 1
+/* Total number of available PIO buffers */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_PIO_BUFFS_OFST 68
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_PIO_BUFFS_LEN 2
+/* Size of a single PIO buffer */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SIZE_PIO_BUFF_OFST 70
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SIZE_PIO_BUFF_LEN 2
+/* On chips later than Medford the amount of address space assigned to each VI
+ * is configurable. This is a global setting that the driver must query to
+ * discover the VI to address mapping. Cut-through PIO (CTPIO) is not available
+ * with 8k VI windows.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VI_WINDOW_MODE_OFST 72
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VI_WINDOW_MODE_LEN 1
+/* enum: Each VI occupies 8k as on Huntington and Medford. PIO is at offset 4k.
+ * CTPIO is not mapped.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VI_WINDOW_MODE_8K 0x0
+/* enum: Each VI occupies 16k. PIO is at offset 4k. CTPIO is at offset 12k. */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VI_WINDOW_MODE_16K 0x1
+/* enum: Each VI occupies 64k. PIO is at offset 4k. CTPIO is at offset 12k. */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VI_WINDOW_MODE_64K 0x2
+/* Number of vFIFOs per adapter that can be used for VFIFO Stuffing
+ * (SF-115995-SW) in the present configuration of firmware and port mode.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VFIFO_STUFFING_NUM_VFIFOS_OFST 73
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VFIFO_STUFFING_NUM_VFIFOS_LEN 1
+/* Number of buffers per adapter that can be used for VFIFO Stuffing
+ * (SF-115995-SW) in the present configuration of firmware and port mode.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VFIFO_STUFFING_NUM_CP_BUFFERS_OFST 74
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VFIFO_STUFFING_NUM_CP_BUFFERS_LEN 2
+/* Entry count in the MAC stats array, including the final GENERATION_END
+ * entry. For MAC stats DMA, drivers should allocate a buffer large enough to
+ * hold at least this many 64-bit stats values, if they wish to receive all
+ * available stats. If the buffer is shorter than MAC_STATS_NUM_STATS * 8, the
+ * stats array returned will be truncated.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAC_STATS_NUM_STATS_OFST 76
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAC_STATS_NUM_STATS_LEN 2
+/* Maximum supported value for MC_CMD_FILTER_OP_V3/MATCH_MARK_VALUE. This field
+ * will only be non-zero if MC_CMD_GET_CAPABILITIES/FILTER_ACTION_MARK is set.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FILTER_ACTION_MARK_MAX_OFST 80
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FILTER_ACTION_MARK_MAX_LEN 4
+/* On devices where the INIT_RXQ_WITH_BUFFER_SIZE flag (in
+ * GET_CAPABILITIES_OUT_V2) is set, drivers have to specify a buffer size when
+ * they create an RX queue. Due to hardware limitations, only a small number of
+ * different buffer sizes may be available concurrently. Nonzero entries in
+ * this array are the sizes of buffers which the system guarantees will be
+ * available for use. If the list is empty, there are no limitations on
+ * concurrent buffer sizes.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_GUARANTEED_RX_BUFFER_SIZES_OFST 84
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_GUARANTEED_RX_BUFFER_SIZES_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_GUARANTEED_RX_BUFFER_SIZES_NUM 16
+/* Third word of flags. Not present on older firmware (check the length). */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FLAGS3_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_FLAGS3_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_WOL_ETHERWAKE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_WOL_ETHERWAKE_LBN 0
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_WOL_ETHERWAKE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_EVEN_SPREADING_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_EVEN_SPREADING_LBN 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_EVEN_SPREADING_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_SELECTABLE_TABLE_SIZE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_SELECTABLE_TABLE_SIZE_LBN 2
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_SELECTABLE_TABLE_SIZE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAE_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAE_SUPPORTED_LBN 3
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAE_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VDPA_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VDPA_SUPPORTED_LBN 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_VDPA_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_VLAN_STRIPPING_PER_ENCAP_RULE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_VLAN_STRIPPING_PER_ENCAP_RULE_LBN 5
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RX_VLAN_STRIPPING_PER_ENCAP_RULE_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EXTENDED_WIDTH_EVQS_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EXTENDED_WIDTH_EVQS_SUPPORTED_LBN 6
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EXTENDED_WIDTH_EVQS_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_UNSOL_EV_CREDIT_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_UNSOL_EV_CREDIT_SUPPORTED_LBN 7
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_UNSOL_EV_CREDIT_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_ENCAPSULATED_MCDI_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_ENCAPSULATED_MCDI_SUPPORTED_LBN 8
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_ENCAPSULATED_MCDI_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EXTERNAL_MAE_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EXTERNAL_MAE_SUPPORTED_LBN 9
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_EXTERNAL_MAE_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NVRAM_UPDATE_ABORT_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NVRAM_UPDATE_ABORT_SUPPORTED_LBN 10
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NVRAM_UPDATE_ABORT_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAE_ACTION_SET_ALLOC_V2_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAE_ACTION_SET_ALLOC_V2_SUPPORTED_LBN 11
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAE_ACTION_SET_ALLOC_V2_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_STEER_ON_OUTER_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_STEER_ON_OUTER_SUPPORTED_LBN 12
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_STEER_ON_OUTER_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAE_ACTION_SET_ALLOC_V3_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAE_ACTION_SET_ALLOC_V3_SUPPORTED_LBN 13
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_MAE_ACTION_SET_ALLOC_V3_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_DYNAMIC_MPORT_JOURNAL_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_DYNAMIC_MPORT_JOURNAL_LBN 14
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_DYNAMIC_MPORT_JOURNAL_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_CLIENT_CMD_VF_PROXY_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_CLIENT_CMD_VF_PROXY_LBN 15
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_CLIENT_CMD_VF_PROXY_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_LBN 16
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_LL_RX_EVENT_SUPPRESSION_SUPPORTED_WIDTH 1
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_CXL_CONFIG_ENABLE_OFST 148
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_CXL_CONFIG_ENABLE_LBN 17
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_CXL_CONFIG_ENABLE_WIDTH 1
+/* These bits are reserved for communicating test-specific capabilities to
+ * host-side test software. All production drivers should treat this field as
+ * opaque.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_OFST 152
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_LEN 8
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_LO_OFST 152
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_LO_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_LO_LBN 1216
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_LO_WIDTH 32
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_HI_OFST 156
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_HI_LEN 4
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_HI_LBN 1248
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_TEST_RESERVED_HI_WIDTH 32
+/* The minimum size (in table entries) of indirection table to be allocated
+ * from the pool for an RSS context. Note that the table size used must be a
+ * power of 2.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_MIN_INDIRECTION_TABLE_SIZE_OFST 160
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_MIN_INDIRECTION_TABLE_SIZE_LEN 4
+/* The maximum size (in table entries) of indirection table to be allocated
+ * from the pool for an RSS context. Note that the table size used must be a
+ * power of 2.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_MAX_INDIRECTION_TABLE_SIZE_OFST 164
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_MAX_INDIRECTION_TABLE_SIZE_LEN 4
+/* The maximum number of queues that can be used by an RSS context in exclusive
+ * mode. In exclusive mode the context has a configurable indirection table and
+ * a configurable RSS key.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_MAX_INDIRECTION_QUEUES_OFST 168
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_MAX_INDIRECTION_QUEUES_LEN 4
+/* The maximum number of queues that can be used by an RSS context in even-
+ * spreading mode. In even-spreading mode the context has no indirection table
+ * but it does have a configurable RSS key.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_MAX_EVEN_SPREADING_QUEUES_OFST 172
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_MAX_EVEN_SPREADING_QUEUES_LEN 4
+/* The total number of RSS contexts supported. Note that the number of
+ * available contexts using indirection tables is also limited by the
+ * availability of indirection table space allocated from a common pool.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_NUM_CONTEXTS_OFST 176
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_NUM_CONTEXTS_LEN 4
+/* The total amount of indirection table space that can be shared between RSS
+ * contexts.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_TABLE_POOL_SIZE_OFST 180
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_RSS_TABLE_POOL_SIZE_LEN 4
+/* A bitmap of the queue sizes the device can provide, where bit N being set
+ * indicates that 2**N is a valid size. The device may be limited in the number
+ * of different queue sizes that can exist simultaneously, so a bit being set
+ * here does not guarantee that an attempt to create a queue of that size will
+ * succeed.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SUPPORTED_QUEUE_SIZES_OFST 184
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_SUPPORTED_QUEUE_SIZES_LEN 4
+/* A bitmap of queue sizes that are always available, in the same format as
+ * SUPPORTED_QUEUE_SIZES. Attempting to create a queue with one of these sizes
+ * will never fail due to unavailability of the requested size.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_GUARANTEED_QUEUE_SIZES_OFST 188
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_GUARANTEED_QUEUE_SIZES_LEN 4
+/* Number of available indirect memory maps. */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INDIRECT_MAP_INDEX_COUNT_OFST 192
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_INDIRECT_MAP_INDEX_COUNT_LEN 4
+/* Number of VIs available for external ports 4-7. Information for ports 0-3 is
+ * in NUM_VIS_PER_PORT in GET_CAPABILITIES_V2_OUT.
+ */
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_VIS_PER_PORT2_OFST 196
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_VIS_PER_PORT2_LEN 2
+#define	MC_CMD_GET_CAPABILITIES_V12_OUT_NUM_VIS_PER_PORT2_NUM 4
+
 
 /***********************************/
 /* MC_CMD_V2_EXTN
@@ -30722,7 +35709,8 @@
  * INTF=CALLER, PF=PF_NULL, VF=... to refer to a VF child of the calling PF or
  * a sibling VF of the calling VF. - INTF=CALLER, PF=..., VF=VF_NULL to refer
  * to a PF on the calling interface - INTF=CALLER, PF=..., VF=... to refer to a
- * VF on the calling interface - INTF=..., PF=..., VF=VF_NULL to refer to a PF
+ * VF on the calling interface - INTF=..., PF=PF_NULL, VF=VF_NULL to refer to
+ * the named interface itself - INTF=..., PF=..., VF=VF_NULL to refer to a PF
  * on a named interface - INTF=..., PF=..., VF=... to refer to a VF on a named
  * interface where ... refers to a small integer for the VF/PF fields, and to
  * values from the PCIE_INTERFACE enum for for the INTF field. It's only
@@ -33920,6 +38908,633 @@
 #define	MC_CMD_MAE_MPORT_READ_JOURNAL_OUT_MPORT_DESC_DATA_MAXNUM 240
 #define	MC_CMD_MAE_MPORT_READ_JOURNAL_OUT_MPORT_DESC_DATA_MAXNUM_MCDI2 1008
 
+
+/***********************************/
+/* MC_CMD_PR_OPEN
+ * Open a session to manage a programmable region. Session handles can be
+ * explicitly closed with MC_CMD_PR_CLOSE, or implicitly via
+ * MC_CMD_ENTITY_RESET or a PCIe Function Level Reset. Although this command is
+ * available to all callers that are a member of the GENERAL privilege group,
+ * an additional privilege check may be performed against the target region.
+ * Returns ENODEV if the region doesn't exist; EPERM if the caller has
+ * insufficient privilege to open the region; EBUSY is the region is currently
+ * busy; ENOSPC if the caller has too many open programmable region sessions.
+ */
+#define	MC_CMD_PR_OPEN 0x1a2
+#define	MC_CMD_PR_OPEN_MSGSET 0x1a2
+#undef	MC_CMD_0x1a2_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1a2_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_OPEN_IN msgrequest */
+#define	MC_CMD_PR_OPEN_IN_LEN 4
+/* The programmable region to open. */
+#define	MC_CMD_PR_OPEN_IN_REGION_ID_OFST 0
+#define	MC_CMD_PR_OPEN_IN_REGION_ID_LEN 4
+
+/* MC_CMD_PR_OPEN_OUT msgresponse */
+#define	MC_CMD_PR_OPEN_OUT_LEN 4
+/* Session handle for operations on the contents of the programmable region.
+ * Handles should be considered opaque, although a value of 0xFFFFFFFF is
+ * guaranteed never to be a valid handle.
+ */
+#define	MC_CMD_PR_OPEN_OUT_HANDLE_OFST 0
+#define	MC_CMD_PR_OPEN_OUT_HANDLE_LEN 4
+/* enum: Invalid programmable region session handle */
+#define	MC_CMD_PR_OPEN_OUT_HANDLE_NULL 0xffffffff
+
+
+/***********************************/
+/* MC_CMD_PR_CLOSE
+ * Close a session created with MC_CMD_PR_OPEN. Returns ENOENT if the session
+ * handle doesn't exist.
+ */
+#define	MC_CMD_PR_CLOSE 0x1a3
+#define	MC_CMD_PR_CLOSE_MSGSET 0x1a3
+#undef	MC_CMD_0x1a3_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1a3_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_CLOSE_IN msgrequest */
+#define	MC_CMD_PR_CLOSE_IN_LEN 4
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_CLOSE_IN_HANDLE_OFST 0
+#define	MC_CMD_PR_CLOSE_IN_HANDLE_LEN 4
+
+/* MC_CMD_PR_CLOSE_OUT msgresponse */
+#define	MC_CMD_PR_CLOSE_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_PR_TRANSFER_BEGIN
+ * Starts transfer of a XCLBIN to the target region associated with a session,
+ * setting the target region's data transfer offset to 0. Although this command
+ * is available to all callers that are a member of the GENERAL privilege group
+ * an extra privilege check may be performed against the target region in
+ * addition to the check performed by MC_CMD_PR_OPEN. Returns ENOENT if the
+ * session handle doesn't exist; EPERM if the caller has insufficient privilege
+ * to update the target region; EBUSY if the target region is currently busy;
+ * ESTALE if the target region has been updated since the session was opened.
+ * The caller should close this handle and open a new session to retry its
+ * transfer; EINVAL if length is too small, e.g. smaller than the AXLF/XCLBIN2
+ * header; ENOMEM if length too large, e.g. larger than the resources available
+ * to buffer the transfer.
+ */
+#define	MC_CMD_PR_TRANSFER_BEGIN 0x1a4
+#define	MC_CMD_PR_TRANSFER_BEGIN_MSGSET 0x1a4
+#undef	MC_CMD_0x1a4_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1a4_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_TRANSFER_BEGIN_IN msgrequest */
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LEN 16
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_HANDLE_OFST 0
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_HANDLE_LEN 4
+/* Reserved, must be zero. */
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_RESERVED_OFST 4
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_RESERVED_LEN 4
+/* The length (in bytes) of the XCLBIN data to be transferred. */
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_OFST 8
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_LEN 8
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_LO_OFST 8
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_LO_LEN 4
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_LO_LBN 64
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_LO_WIDTH 32
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_HI_OFST 12
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_HI_LEN 4
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_HI_LBN 96
+#define	MC_CMD_PR_TRANSFER_BEGIN_IN_LENGTH_HI_WIDTH 32
+
+/* MC_CMD_PR_TRANSFER_BEGIN_OUT msgresponse */
+#define	MC_CMD_PR_TRANSFER_BEGIN_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_PR_TRANSFER_WRITE
+ * Transfer a chunk of a XCLBIN data to the target region of a session,
+ * advancing the current data transfer offset. Chunks are transferred in a
+ * streaming like way and it is the responsibility of the caller to ensure all
+ * chunks are transferred in order and with no duplicates. Requires a transfer
+ * to have been started with MC_CMD_PR_TRANSFER_BEGIN. Returns ENOENT if the
+ * session handle doesn't exist; EACCESS if the session does not have an in-
+ * progress transfer; ESTALE if session's transfer has been cancelled, e.g.
+ * another session has started a transfer; ERANGE if the chunk exceeds the
+ * total transfer length specified in MC_CMD_PR_TRANSFER_BEGIN_IN.
+ */
+#define	MC_CMD_PR_TRANSFER_WRITE 0x1a5
+#define	MC_CMD_PR_TRANSFER_WRITE_MSGSET 0x1a5
+#undef	MC_CMD_0x1a5_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1a5_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_TRANSFER_WRITE_IN msgrequest */
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_LENMIN 5
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_LENMAX 252
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_LENMAX_MCDI2 1020
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_LEN(num) (4+1*(num))
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_DATA_NUM(len) (((len)-4)/1)
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_HANDLE_OFST 0
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_HANDLE_LEN 4
+/* Chunk of data to write */
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_DATA_OFST 4
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_DATA_LEN 1
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_DATA_MINNUM 1
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_DATA_MAXNUM 248
+#define	MC_CMD_PR_TRANSFER_WRITE_IN_DATA_MAXNUM_MCDI2 1016
+
+/* MC_CMD_PR_TRANSFER_WRITE_OUT msgresponse */
+#define	MC_CMD_PR_TRANSFER_WRITE_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_PR_TRANSFER_END
+ * End the transfer of a XCLBIN to the target region of a session. A success
+ * result indicates the firmware started the update process. If the XCLBIN data
+ * is accepted, and programming has started, all other sessions for the same
+ * target region will be marked stale. The caller can use MC_CMD_PR_STATUS_GET
+ * to determine the overall result of the update. Requires a transfer to have
+ * been started with MC_CMD_PR_TRANSFER_BEGIN. Returns ENOENT if the session
+ * handle doesn't exist; EACCESS if the session does not have an in-progress
+ * transfer; ESTALE if session's transfer has been cancelled, e.g. another
+ * session has started a transfer.
+ */
+#define	MC_CMD_PR_TRANSFER_END 0x1a6
+#define	MC_CMD_PR_TRANSFER_END_MSGSET 0x1a6
+#undef	MC_CMD_0x1a6_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1a6_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_TRANSFER_END_IN msgrequest */
+#define	MC_CMD_PR_TRANSFER_END_IN_LEN 4
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_TRANSFER_END_IN_HANDLE_OFST 0
+#define	MC_CMD_PR_TRANSFER_END_IN_HANDLE_LEN 4
+
+/* MC_CMD_PR_TRANSFER_END_OUT msgresponse */
+#define	MC_CMD_PR_TRANSFER_END_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_PR_STATUS_GET
+ * Query the current update status of the target region of a session. Returns
+ * ENOENT if the session handle doesn't exist; ESTALE if the target region has
+ * been updated by another session since the session was opened.
+ */
+#define	MC_CMD_PR_STATUS_GET 0x1a7
+#define	MC_CMD_PR_STATUS_GET_MSGSET 0x1a7
+#undef	MC_CMD_0x1a7_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1a7_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_STATUS_GET_IN msgrequest */
+#define	MC_CMD_PR_STATUS_GET_IN_LEN 4
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_STATUS_GET_IN_HANDLE_OFST 0
+#define	MC_CMD_PR_STATUS_GET_IN_HANDLE_LEN 4
+
+/* MC_CMD_PR_STATUS_GET_OUT msgresponse */
+#define	MC_CMD_PR_STATUS_GET_OUT_LENMIN 9
+#define	MC_CMD_PR_STATUS_GET_OUT_LENMAX 252
+#define	MC_CMD_PR_STATUS_GET_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_PR_STATUS_GET_OUT_LEN(num) (8+1*(num))
+#define	MC_CMD_PR_STATUS_GET_OUT_DESCRIPTION_NUM(len) (((len)-8)/1)
+/* The state of the last update attempt triggered by MC_CMD_PR_TRANSFER_END or
+ * last action triggered by MC_CMD_PR_CONTROL.
+ */
+#define	MC_CMD_PR_STATUS_GET_OUT_STATUS_OFST 0
+#define	MC_CMD_PR_STATUS_GET_OUT_STATUS_LEN 4
+/* enum: Update in progress */
+#define	MC_CMD_PR_STATUS_GET_OUT_STATUS_PENDING 0x0
+/* enum: Update successful, or no update attempted since device boot */
+#define	MC_CMD_PR_STATUS_GET_OUT_STATUS_SUCCESS 0x1
+/* enum: Update failed */
+#define	MC_CMD_PR_STATUS_GET_OUT_STATUS_ERROR 0x2
+/* Code providing more information about the state of the update process. */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_OFST 4
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_LEN 4
+/* enum: Operation successful */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_SUCCESS 0x0
+/* enum: xclbin package was not built for this platform */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_XCLBIN_UUID_MISMATCH 0x1
+/* enum: Provided xclbin package contains no bitstream */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_XCLBIN_NO_BITSTREAM 0x2
+/* enum: Provided xclbin package contains clock error */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_XCLBIN_CLK_ERROR 0x3
+/* enum: Load attempt unexpectedly rejected - bitstream may be corrupt */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_BITSTREAM_ERROR 0x4
+/* enum: Clock programming failed */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_CLK_PROG_FAIL 0x5
+/* enum: Shell DDR failed to calibrate */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_DDR_CAL_FAIL 0x6
+/* enum: ICAP was unavailable before programming */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_ICAP_BUSY 0x7
+/* enum: ICAP failed to terminate programming */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_ICAP_FAIL 0x8
+/* enum: Clock scaling operation failed */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_CLK_SCALE_FAIL 0x9
+/* enum: Clock measurement operation failed */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_CLK_MON_FAIL 0xa
+/* enum: Firewall tripped */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_FIREWALL_TRIPPED 0xb
+/* enum: XCLBIN package parse error */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_XCLBIN_PARSER_FAIL 0xc
+/* enum: Extension metadata load error */
+#define	MC_CMD_PR_STATUS_GET_OUT_RESULT_METADATA_LOAD_ERROR 0xd
+/* Result description (NUL-terminated ASCII string) */
+#define	MC_CMD_PR_STATUS_GET_OUT_DESCRIPTION_OFST 8
+#define	MC_CMD_PR_STATUS_GET_OUT_DESCRIPTION_LEN 1
+#define	MC_CMD_PR_STATUS_GET_OUT_DESCRIPTION_MINNUM 1
+#define	MC_CMD_PR_STATUS_GET_OUT_DESCRIPTION_MAXNUM 244
+#define	MC_CMD_PR_STATUS_GET_OUT_DESCRIPTION_MAXNUM_MCDI2 1012
+
+
+/***********************************/
+/* MC_CMD_PR_CONTROL
+ * Control operations on programmable regions.
+ */
+#define	MC_CMD_PR_CONTROL 0x1ed
+#define	MC_CMD_PR_CONTROL_MSGSET 0x1ed
+#undef	MC_CMD_0x1ed_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1ed_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_CONTROL_IN msgrequest */
+#define	MC_CMD_PR_CONTROL_IN_LEN 8
+/* Sub-command code */
+#define	MC_CMD_PR_CONTROL_IN_OP_OFST 0
+#define	MC_CMD_PR_CONTROL_IN_OP_LEN 4
+/* enum: Initiates the process of quiescing the logic within a programmable
+ * region in preparation for an update via an out-of-band mechanism. Returns
+ * ENOENT if the session handle doesn't exist; ESTALE if the target region has
+ * been updated by another session since the session was opened; EPERM if the
+ * caller has insufficient privilege to update the target region; EBUSY if the
+ * target region is currently busy and cannot be quieced (including if the
+ * region is being reinitialised); EALREADY if the target region is being
+ * quiesced or has already been quiesced. The progress of the quiesceing
+ * process can be checked with MC_CMD_PR_STATUS_GET. If MC_CMD_PR_STATUS_GET
+ * indicates that an error occurred during quiesceing them the programmable
+ * region is in an undefined state and the system must be reset. Once
+ * MC_CMD_PR_STATUS_GET indicates that the process has completed, a new image
+ * can be downloaded by the appropriate out-out-band mechanism.
+ */
+#define	MC_CMD_PR_CONTROL_IN_OP_QUIESCE 0x0
+/* enum: Reinitialise logic within a programmable region after an update via an
+ * out-of-band mechanism. Returns ENOENT if the session handle doesn't exist;
+ * ESTALE if the target region has been updated by another session since the
+ * session was opened; EPERM if the caller has insufficient privilege to update
+ * the target region; EBUSY if the target region is currently being quiesced;
+ * EALREADY if the target region is currently being initialised or has already
+ * been initialised. The progress of the unquiesceing process can be checked
+ * with MC_CMD_PR_STATUS_GET. If MC_CMD_PR_STATUS_GET indicates that an error
+ * occurred during unquiesceing then the programmable region is still in a
+ * quiesced state. A new image can be downloaded via the appropriate out-of-
+ * band mechanism. Once MC_CMD_PR_STATUS_GET indicates that the process has
+ * completed, the logic within the programmable region is available for use.
+ */
+#define	MC_CMD_PR_CONTROL_IN_OP_UNQUIESCE 0x1
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_CONTROL_IN_HANDLE_OFST 4
+#define	MC_CMD_PR_CONTROL_IN_HANDLE_LEN 4
+
+/* MC_CMD_PR_CONTROL_OP_QUIESCE_IN msgrequest */
+#define	MC_CMD_PR_CONTROL_OP_QUIESCE_IN_LEN 8
+/* Sub-command code */
+#define	MC_CMD_PR_CONTROL_OP_QUIESCE_IN_OP_OFST 0
+#define	MC_CMD_PR_CONTROL_OP_QUIESCE_IN_OP_LEN 4
+/* enum: Initiates the process of quiescing the logic within a programmable
+ * region in preparation for an update via an out-of-band mechanism. Returns
+ * ENOENT if the session handle doesn't exist; ESTALE if the target region has
+ * been updated by another session since the session was opened; EPERM if the
+ * caller has insufficient privilege to update the target region; EBUSY if the
+ * target region is currently busy and cannot be quieced (including if the
+ * region is being reinitialised); EALREADY if the target region is being
+ * quiesced or has already been quiesced. The progress of the quiesceing
+ * process can be checked with MC_CMD_PR_STATUS_GET. If MC_CMD_PR_STATUS_GET
+ * indicates that an error occurred during quiesceing them the programmable
+ * region is in an undefined state and the system must be reset. Once
+ * MC_CMD_PR_STATUS_GET indicates that the process has completed, a new image
+ * can be downloaded by the appropriate out-out-band mechanism.
+ */
+#define	MC_CMD_PR_CONTROL_OP_QUIESCE_IN_OP_QUIESCE 0x0
+/* enum: Reinitialise logic within a programmable region after an update via an
+ * out-of-band mechanism. Returns ENOENT if the session handle doesn't exist;
+ * ESTALE if the target region has been updated by another session since the
+ * session was opened; EPERM if the caller has insufficient privilege to update
+ * the target region; EBUSY if the target region is currently being quiesced;
+ * EALREADY if the target region is currently being initialised or has already
+ * been initialised. The progress of the unquiesceing process can be checked
+ * with MC_CMD_PR_STATUS_GET. If MC_CMD_PR_STATUS_GET indicates that an error
+ * occurred during unquiesceing then the programmable region is still in a
+ * quiesced state. A new image can be downloaded via the appropriate out-of-
+ * band mechanism. Once MC_CMD_PR_STATUS_GET indicates that the process has
+ * completed, the logic within the programmable region is available for use.
+ */
+#define	MC_CMD_PR_CONTROL_OP_QUIESCE_IN_OP_UNQUIESCE 0x1
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_CONTROL_OP_QUIESCE_IN_HANDLE_OFST 4
+#define	MC_CMD_PR_CONTROL_OP_QUIESCE_IN_HANDLE_LEN 4
+
+/* MC_CMD_PR_CONTROL_OP_QUIESCE_OUT msgresponse */
+#define	MC_CMD_PR_CONTROL_OP_QUIESCE_OUT_LEN 0
+
+/* MC_CMD_PR_CONTROL_OP_UNQUIESCE_IN msgrequest */
+#define	MC_CMD_PR_CONTROL_OP_UNQUIESCE_IN_LEN 8
+/* Sub-command code */
+#define	MC_CMD_PR_CONTROL_OP_UNQUIESCE_IN_OP_OFST 0
+#define	MC_CMD_PR_CONTROL_OP_UNQUIESCE_IN_OP_LEN 4
+/* enum: Initiates the process of quiescing the logic within a programmable
+ * region in preparation for an update via an out-of-band mechanism. Returns
+ * ENOENT if the session handle doesn't exist; ESTALE if the target region has
+ * been updated by another session since the session was opened; EPERM if the
+ * caller has insufficient privilege to update the target region; EBUSY if the
+ * target region is currently busy and cannot be quieced (including if the
+ * region is being reinitialised); EALREADY if the target region is being
+ * quiesced or has already been quiesced. The progress of the quiesceing
+ * process can be checked with MC_CMD_PR_STATUS_GET. If MC_CMD_PR_STATUS_GET
+ * indicates that an error occurred during quiesceing them the programmable
+ * region is in an undefined state and the system must be reset. Once
+ * MC_CMD_PR_STATUS_GET indicates that the process has completed, a new image
+ * can be downloaded by the appropriate out-out-band mechanism.
+ */
+#define	MC_CMD_PR_CONTROL_OP_UNQUIESCE_IN_OP_QUIESCE 0x0
+/* enum: Reinitialise logic within a programmable region after an update via an
+ * out-of-band mechanism. Returns ENOENT if the session handle doesn't exist;
+ * ESTALE if the target region has been updated by another session since the
+ * session was opened; EPERM if the caller has insufficient privilege to update
+ * the target region; EBUSY if the target region is currently being quiesced;
+ * EALREADY if the target region is currently being initialised or has already
+ * been initialised. The progress of the unquiesceing process can be checked
+ * with MC_CMD_PR_STATUS_GET. If MC_CMD_PR_STATUS_GET indicates that an error
+ * occurred during unquiesceing then the programmable region is still in a
+ * quiesced state. A new image can be downloaded via the appropriate out-of-
+ * band mechanism. Once MC_CMD_PR_STATUS_GET indicates that the process has
+ * completed, the logic within the programmable region is available for use.
+ */
+#define	MC_CMD_PR_CONTROL_OP_UNQUIESCE_IN_OP_UNQUIESCE 0x1
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_CONTROL_OP_UNQUIESCE_IN_HANDLE_OFST 4
+#define	MC_CMD_PR_CONTROL_OP_UNQUIESCE_IN_HANDLE_LEN 4
+
+/* MC_CMD_PR_CONTROL_OP_UNQUIESCE_OUT msgresponse */
+#define	MC_CMD_PR_CONTROL_OP_UNQUIESCE_OUT_LEN 0
+
+
+/***********************************/
+/* MC_CMD_PR_METADATA_INFO
+ * Query information (length and name) about the meta-data describing the
+ * active contents of the target region of a session. Returns ENOENT if the
+ * session handle doesn't exist; ESTALE if the target region has been updated
+ * by another session since the session was opened; ENODEV if the meta-data
+ * item doesn't exist.
+ */
+#define	MC_CMD_PR_METADATA_INFO 0x1a8
+#define	MC_CMD_PR_METADATA_INFO_MSGSET 0x1a8
+#undef	MC_CMD_0x1a8_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1a8_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_METADATA_INFO_IN msgrequest */
+#define	MC_CMD_PR_METADATA_INFO_IN_LEN 16
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_METADATA_INFO_IN_HANDLE_OFST 0
+#define	MC_CMD_PR_METADATA_INFO_IN_HANDLE_LEN 4
+/* Item category */
+#define	MC_CMD_PR_METADATA_INFO_IN_CATEGORY_OFST 4
+#define	MC_CMD_PR_METADATA_INFO_IN_CATEGORY_LEN 4
+/*            Enum values, see field(s): */
+/*               PR_METADATA_ITEM_CATEGORY */
+/* Item sub-category */
+#define	MC_CMD_PR_METADATA_INFO_IN_SUBCATEGORY_OFST 8
+#define	MC_CMD_PR_METADATA_INFO_IN_SUBCATEGORY_LEN 4
+/*            Enum values, see field(s): */
+/*               PR_METADATA_ITEM_SUBCATEGORY */
+/* Item index */
+#define	MC_CMD_PR_METADATA_INFO_IN_INDEX_OFST 12
+#define	MC_CMD_PR_METADATA_INFO_IN_INDEX_LEN 4
+
+/* MC_CMD_PR_METADATA_INFO_OUT msgresponse */
+#define	MC_CMD_PR_METADATA_INFO_OUT_LEN 136
+/* Length (in bytes) of the meta-data item */
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_OFST 0
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_LEN 8
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_LO_OFST 0
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_LO_LEN 4
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_LO_LBN 0
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_LO_WIDTH 32
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_HI_OFST 4
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_HI_LEN 4
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_HI_LBN 32
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_LENGTH_HI_WIDTH 32
+/* Meta-data item name (NUL-terminated ASCII string). For the SECTION category
+ * the name is AXLF section name (axlf_section_header::m_sectionName). The
+ * items of the categories (UUID, TIMESTAMP and SIGNATURE) are unnamed items
+ * and return an empty string (NAME[0] == '\0').
+ */
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_NAME_OFST 8
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_NAME_LEN 1
+#define	MC_CMD_PR_METADATA_INFO_OUT_ITEM_NAME_NUM 128
+
+
+/***********************************/
+/* MC_CMD_PR_METADATA_READ
+ * Read a chunk of the meta-data describing the active contents of the target
+ * region of a session. Returns ENOENT if the session handle doesn't exist;
+ * ESTALE if the target region has been updated by another session since the
+ * session was opened; ENODEV if the meta-data item doesn't exist; ERANGE if
+ * the offset is outside the valid range for the meta-data item, e.g. offset >=
+ * item_length.
+ */
+#define	MC_CMD_PR_METADATA_READ 0x1a9
+#define	MC_CMD_PR_METADATA_READ_MSGSET 0x1a9
+#undef	MC_CMD_0x1a9_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1a9_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_METADATA_READ_IN msgrequest */
+#define	MC_CMD_PR_METADATA_READ_IN_LEN 26
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_METADATA_READ_IN_HANDLE_OFST 0
+#define	MC_CMD_PR_METADATA_READ_IN_HANDLE_LEN 4
+/* Item category */
+#define	MC_CMD_PR_METADATA_READ_IN_CATEGORY_OFST 4
+#define	MC_CMD_PR_METADATA_READ_IN_CATEGORY_LEN 4
+/*            Enum values, see field(s): */
+/*               PR_METADATA_ITEM_CATEGORY */
+/* Item sub-category */
+#define	MC_CMD_PR_METADATA_READ_IN_SUBCATEGORY_OFST 8
+#define	MC_CMD_PR_METADATA_READ_IN_SUBCATEGORY_LEN 4
+/*            Enum values, see field(s): */
+/*               PR_METADATA_ITEM_SUBCATEGORY */
+/* Item index */
+#define	MC_CMD_PR_METADATA_READ_IN_INDEX_OFST 12
+#define	MC_CMD_PR_METADATA_READ_IN_INDEX_LEN 4
+/* Byte offset within meta-data chunk */
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_OFST 16
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_LEN 8
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_LO_OFST 16
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_LO_LEN 4
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_LO_LBN 128
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_LO_WIDTH 32
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_HI_OFST 20
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_HI_LEN 4
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_HI_LBN 160
+#define	MC_CMD_PR_METADATA_READ_IN_OFFSET_HI_WIDTH 32
+/* Maximum length (in bytes) to read */
+#define	MC_CMD_PR_METADATA_READ_IN_MAX_LENGTH_OFST 24
+#define	MC_CMD_PR_METADATA_READ_IN_MAX_LENGTH_LEN 2
+
+/* MC_CMD_PR_METADATA_READ_OUT msgresponse */
+#define	MC_CMD_PR_METADATA_READ_OUT_LENMIN 1
+#define	MC_CMD_PR_METADATA_READ_OUT_LENMAX 252
+#define	MC_CMD_PR_METADATA_READ_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_PR_METADATA_READ_OUT_LEN(num) (0+1*(num))
+#define	MC_CMD_PR_METADATA_READ_OUT_DATA_NUM(len) (((len)-0)/1)
+/* Chunk of meta-data */
+#define	MC_CMD_PR_METADATA_READ_OUT_DATA_OFST 0
+#define	MC_CMD_PR_METADATA_READ_OUT_DATA_LEN 1
+#define	MC_CMD_PR_METADATA_READ_OUT_DATA_MINNUM 1
+#define	MC_CMD_PR_METADATA_READ_OUT_DATA_MAXNUM 252
+#define	MC_CMD_PR_METADATA_READ_OUT_DATA_MAXNUM_MCDI2 1020
+
+/* PR_FREQ_INFO structuredef: Information about a single programmable region
+ * clock
+ */
+#define	PR_FREQ_INFO_LEN 140
+/* Clock frequency (in Hz) */
+#define	PR_FREQ_INFO_FREQ_HZ_OFST 0
+#define	PR_FREQ_INFO_FREQ_HZ_LEN 8
+#define	PR_FREQ_INFO_FREQ_HZ_LO_OFST 0
+#define	PR_FREQ_INFO_FREQ_HZ_LO_LEN 4
+#define	PR_FREQ_INFO_FREQ_HZ_LO_LBN 0
+#define	PR_FREQ_INFO_FREQ_HZ_LO_WIDTH 32
+#define	PR_FREQ_INFO_FREQ_HZ_HI_OFST 4
+#define	PR_FREQ_INFO_FREQ_HZ_HI_LEN 4
+#define	PR_FREQ_INFO_FREQ_HZ_HI_LBN 32
+#define	PR_FREQ_INFO_FREQ_HZ_HI_WIDTH 32
+#define	PR_FREQ_INFO_FREQ_HZ_LBN 0
+#define	PR_FREQ_INFO_FREQ_HZ_WIDTH 64
+/* Clock type, a programmable region may have multiple clocks of the same type.
+ * (matches enum CLOCK_TYPE)
+ */
+#define	PR_FREQ_INFO_TYPE_OFST 8
+#define	PR_FREQ_INFO_TYPE_LEN 2
+/* enum: Unused/reserved. */
+#define	PR_FREQ_INFO_CLOCK_TYPE_UNUSED 0x0
+/* enum: Data clock. */
+#define	PR_FREQ_INFO_CLOCK_TYPE_DATA 0x1
+/* enum: Kernel clock. */
+#define	PR_FREQ_INFO_CLOCK_TYPE_KERNEL 0x2
+/* enum: System clock. */
+#define	PR_FREQ_INFO_CLOCK_TYPE_SYSTEM 0x3
+#define	PR_FREQ_INFO_TYPE_LBN 64
+#define	PR_FREQ_INFO_TYPE_WIDTH 16
+/* Assorted flags */
+#define	PR_FREQ_INFO_FLAGS_OFST 10
+#define	PR_FREQ_INFO_FLAGS_LEN 2
+#define	PR_FREQ_INFO_SETTABLE_OFST 10
+#define	PR_FREQ_INFO_SETTABLE_LBN 0
+#define	PR_FREQ_INFO_SETTABLE_WIDTH 1
+#define	PR_FREQ_INFO_FLAGS_LBN 80
+#define	PR_FREQ_INFO_FLAGS_WIDTH 16
+/* Clock name (NUL-terminated ASCII string) */
+#define	PR_FREQ_INFO_NAME_OFST 12
+#define	PR_FREQ_INFO_NAME_LEN 1
+#define	PR_FREQ_INFO_NAME_NUM 128
+#define	PR_FREQ_INFO_NAME_LBN 96
+#define	PR_FREQ_INFO_NAME_WIDTH 8
+
+
+/***********************************/
+/* MC_CMD_PR_FREQ_GET
+ * Query the current clock frequencies of the target region of a session. If
+ * the target region is 'empty' then an empty response should be returned.
+ * Returns ENOENT if the session handle doesn't exist; ESTALE if the target
+ * region has been updated by another session since the session was opened.
+ */
+#define	MC_CMD_PR_FREQ_GET 0x1aa
+#define	MC_CMD_PR_FREQ_GET_MSGSET 0x1aa
+#undef	MC_CMD_0x1aa_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1aa_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_FREQ_GET_IN msgrequest */
+#define	MC_CMD_PR_FREQ_GET_IN_LEN 4
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_FREQ_GET_IN_HANDLE_OFST 0
+#define	MC_CMD_PR_FREQ_GET_IN_HANDLE_LEN 4
+
+/* MC_CMD_PR_FREQ_GET_OUT msgresponse */
+#define	MC_CMD_PR_FREQ_GET_OUT_LENMIN 0
+#define	MC_CMD_PR_FREQ_GET_OUT_LENMAX 140
+#define	MC_CMD_PR_FREQ_GET_OUT_LENMAX_MCDI2 980
+#define	MC_CMD_PR_FREQ_GET_OUT_LEN(num) (0+140*(num))
+#define	MC_CMD_PR_FREQ_GET_OUT_INFOS_NUM(len) (((len)-0)/140)
+/* An array of PR_FREQ_INFO structures. */
+#define	MC_CMD_PR_FREQ_GET_OUT_INFOS_OFST 0
+#define	MC_CMD_PR_FREQ_GET_OUT_INFOS_LEN 140
+
+
+/***********************************/
+/* MC_CMD_PR_FREQ_SET
+ * Set the desired clock frequencies of the target region of a session. The
+ * FREQ_HZ array must contain the same number of entries as the output to
+ * MC_CMD_PR_FREQ_GET. Callers should expect that the resulting frequencies may
+ * not precisely match the input and can use MC_CMD_PR_FREQ_GET to determine
+ * the actual frequencies selected. The algorithm for selecting the resulting
+ * clock settings is a firmware implementation detail based on the capabilities
+ * of the device and the target region. It is expected that the firmware will
+ * not exceed the desired frequency for any clock; will successfully apply a
+ * frequency value obtained from MC_CMD_PR_FREQ_GET without further adjustment;
+ * and if an error is returned no changes will have been applied to any of the
+ * clocks. Although this command is available to all callers that are a member
+ * of the GENERAL privilege group an extra privilege check may be performed
+ * against the target region in addition to tbe check performed by
+ * MC_CMD_PR_OPEN. Returns ENOENT if the session handle doesn't exist; ESTALE
+ * if the target region has been updated by another session since the session
+ * was opened; EINVAL if the target region is 'empty' or the wrong number of
+ * desired clock frequencies was specified in the input; ERANGE if one or more
+ * desired clock frequencies were not achievable.
+ */
+#define	MC_CMD_PR_FREQ_SET 0x1ab
+#define	MC_CMD_PR_FREQ_SET_MSGSET 0x1ab
+#undef	MC_CMD_0x1ab_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1ab_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_PR_FREQ_SET_IN msgrequest */
+#define	MC_CMD_PR_FREQ_SET_IN_LENMIN 16
+#define	MC_CMD_PR_FREQ_SET_IN_LENMAX 248
+#define	MC_CMD_PR_FREQ_SET_IN_LENMAX_MCDI2 1016
+#define	MC_CMD_PR_FREQ_SET_IN_LEN(num) (8+8*(num))
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_NUM(len) (((len)-8)/8)
+/* Session handle from MC_CMD_PR_OPEN_OUT */
+#define	MC_CMD_PR_FREQ_SET_IN_HANDLE_OFST 0
+#define	MC_CMD_PR_FREQ_SET_IN_HANDLE_LEN 4
+/* Reserved, must be zero. */
+#define	MC_CMD_PR_FREQ_SET_IN_RESERVED_OFST 4
+#define	MC_CMD_PR_FREQ_SET_IN_RESERVED_LEN 4
+/* Desired frequency for each clock */
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_OFST 8
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_LEN 8
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_LO_OFST 8
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_LO_LEN 4
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_LO_LBN 64
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_LO_WIDTH 32
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_HI_OFST 12
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_HI_LEN 4
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_HI_LBN 96
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_HI_WIDTH 32
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_MINNUM 1
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_MAXNUM 30
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_MAXNUM_MCDI2 126
+/* enum: Leave the clock frequency unchanged. */
+#define	MC_CMD_PR_FREQ_SET_IN_FREQ_HZ_DONT_CHANGE 0x0
+
+/* MC_CMD_PR_FREQ_SET_OUT msgresponse */
+#define	MC_CMD_PR_FREQ_SET_OUT_LEN 0
+
 /* TABLE_FIELD_DESCR structuredef: An individual table field descriptor. This
  * describes the location and properties of one N-bit field within a wider
  * M-bit key/mask/response value.
@@ -34323,4 +39938,151 @@
 /* MC_CMD_TABLE_DELETE_OUT msgresponse */
 #define	MC_CMD_TABLE_DELETE_OUT_LEN 0
 
+/* MC_CMD_QUEUE_HANDLE structuredef: On X4, to distinguish between full-
+ * featured (X2-style) VIs and low-latency (X3-style) queues, we use the top
+ * bits of the queue handle to specify the queue type in all MCDI calls which
+ * refer to VIs/queues. These bits should be masked off when indexing into a
+ * queue in the BAR.
+ */
+#define	MC_CMD_QUEUE_HANDLE_LEN 4
+/* Combined queue number and type. This is the ID returned by and passed into
+ * MCDI calls that use queues.
+ */
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_HANDLE_OFST 0
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_HANDLE_LEN 4
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_NUM_OFST 0
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_NUM_LBN 0
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_NUM_WIDTH 24
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_TYPE_OFST 0
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_TYPE_LBN 24
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_TYPE_WIDTH 8
+/* enum: Indicates that the queue instance is a full-featured VI */
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_TYPE_FF_VI 0x0
+/* enum: Indicates that the queue instance is a LL TXQ */
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_TYPE_LL_TXQ 0x1
+/* enum: Indicates that the queue instance is a LL RXQ */
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_TYPE_LL_RXQ 0x2
+/* enum: Indicates that the queue instance is a LL EVQ */
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_TYPE_LL_EVQ 0x3
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_HANDLE_LBN 0
+#define	MC_CMD_QUEUE_HANDLE_QUEUE_HANDLE_WIDTH 32
+
+/* QUEUE_HANDLE structuredef: This definition is deprecated, use
+ * MC_CMD_QUEUE_HANDLE above.
+ */
+#define	QUEUE_HANDLE_LEN 4
+/* Combined queue number and type. This is the ID returned by and passed into
+ * MCDI calls that use queues.
+ */
+#define	QUEUE_HANDLE_QUEUE_HANDLE_OFST 0
+#define	QUEUE_HANDLE_QUEUE_HANDLE_LEN 4
+#define	QUEUE_HANDLE_QUEUE_NUM_OFST 0
+#define	QUEUE_HANDLE_QUEUE_NUM_LBN 0
+#define	QUEUE_HANDLE_QUEUE_NUM_WIDTH 24
+#define	QUEUE_HANDLE_QUEUE_TYPE_OFST 0
+#define	QUEUE_HANDLE_QUEUE_TYPE_LBN 24
+#define	QUEUE_HANDLE_QUEUE_TYPE_WIDTH 8
+/* enum: Indicates that the queue instance is a full-featured VI */
+#define	QUEUE_HANDLE_QUEUE_TYPE_FF_VI 0x0
+/* enum: Indicates that the queue instance is a LL TXQ */
+#define	QUEUE_HANDLE_QUEUE_TYPE_LL_TXQ 0x1
+/* enum: Indicates that the queue instance is a LL RXQ */
+#define	QUEUE_HANDLE_QUEUE_TYPE_LL_RXQ 0x2
+/* enum: Indicates that the queue instance is a LL EVQ */
+#define	QUEUE_HANDLE_QUEUE_TYPE_LL_EVQ 0x3
+#define	QUEUE_HANDLE_QUEUE_HANDLE_LBN 0
+#define	QUEUE_HANDLE_QUEUE_HANDLE_WIDTH 32
+
+
+/***********************************/
+/* MC_CMD_ALLOC_LL_QUEUES
+ * Allocate low latency (X3-style) queues for current PCI function. Can be
+ * called more than once if desired to allocate more queues.
+ */
+#define	MC_CMD_ALLOC_LL_QUEUES 0x1dd
+#define	MC_CMD_ALLOC_LL_QUEUES_MSGSET 0x1dd
+#undef	MC_CMD_0x1dd_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1dd_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_ALLOC_LL_QUEUES_IN msgrequest */
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_LEN 24
+/* The minimum number of TXQs that is acceptable */
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MIN_TXQ_COUNT_OFST 0
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MIN_TXQ_COUNT_LEN 4
+/* The maximum number of TXQs that would be useful */
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MAX_TXQ_COUNT_OFST 4
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MAX_TXQ_COUNT_LEN 4
+/* The minimum number of RXQs that is acceptable */
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MIN_RXQ_COUNT_OFST 8
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MIN_RXQ_COUNT_LEN 4
+/* The maximum number of RXQs that would be useful */
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MAX_RXQ_COUNT_OFST 12
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MAX_RXQ_COUNT_LEN 4
+/* The minimum number of EVQs that is acceptable */
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MIN_EVQ_COUNT_OFST 16
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MIN_EVQ_COUNT_LEN 4
+/* The maximum number of EVQs that would be useful */
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MAX_EVQ_COUNT_OFST 20
+#define	MC_CMD_ALLOC_LL_QUEUES_IN_MAX_EVQ_COUNT_LEN 4
+
+/* MC_CMD_ALLOC_LL_QUEUES_OUT msgresponse */
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_LENMIN 16
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_LENMAX 252
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_LENMAX_MCDI2 1020
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_LEN(num) (12+4*(num))
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_QUEUES_NUM(len) (((len)-12)/4)
+/* The number of TXQs allocated in this request */
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_TXQ_COUNT_OFST 0
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_TXQ_COUNT_LEN 4
+/* The number of RXQs allocated in this request */
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_RXQ_COUNT_OFST 4
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_RXQ_COUNT_LEN 4
+/* The number of EVQs allocated in this request */
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_EVQ_COUNT_OFST 8
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_EVQ_COUNT_LEN 4
+/* A list of allocated queues, returned as MC_CMD_QUEUE_HANDLEs, not
+ * necessarily contiguous. TXQs are first in the list, followed by RXQs then
+ * EVQs. The type of each queue is indicated by the top bits (see the
+ * QUEUE_TYPE enum)
+ */
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_QUEUES_OFST 12
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_QUEUES_LEN 4
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_QUEUES_MINNUM 1
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_QUEUES_MAXNUM 60
+#define	MC_CMD_ALLOC_LL_QUEUES_OUT_QUEUES_MAXNUM_MCDI2 252
+
+
+/***********************************/
+/* MC_CMD_FREE_LL_QUEUES
+ * Free low latency (X3-style) queues for current PCI function.
+ */
+#define	MC_CMD_FREE_LL_QUEUES 0x1de
+#define	MC_CMD_FREE_LL_QUEUES_MSGSET 0x1de
+#undef	MC_CMD_0x1de_PRIVILEGE_CTG
+
+#define	MC_CMD_0x1de_PRIVILEGE_CTG SRIOV_CTG_GENERAL
+
+/* MC_CMD_FREE_LL_QUEUES_IN msgrequest */
+#define	MC_CMD_FREE_LL_QUEUES_IN_LENMIN 8
+#define	MC_CMD_FREE_LL_QUEUES_IN_LENMAX 252
+#define	MC_CMD_FREE_LL_QUEUES_IN_LENMAX_MCDI2 1020
+#define	MC_CMD_FREE_LL_QUEUES_IN_LEN(num) (4+4*(num))
+#define	MC_CMD_FREE_LL_QUEUES_IN_QUEUES_NUM(len) (((len)-4)/4)
+/* The number of queues to free. */
+#define	MC_CMD_FREE_LL_QUEUES_IN_QUEUE_COUNT_OFST 0
+#define	MC_CMD_FREE_LL_QUEUES_IN_QUEUE_COUNT_LEN 4
+/* A list of queues to free, as a list of MC_CMD_QUEUE_HANDLEs. They must have
+ * all been previously allocated by MC_CMD_ALLOC_LL_QUEUES. The type of each
+ * queue should be indicated by the top bits.
+ */
+#define	MC_CMD_FREE_LL_QUEUES_IN_QUEUES_OFST 4
+#define	MC_CMD_FREE_LL_QUEUES_IN_QUEUES_LEN 4
+#define	MC_CMD_FREE_LL_QUEUES_IN_QUEUES_MINNUM 1
+#define	MC_CMD_FREE_LL_QUEUES_IN_QUEUES_MAXNUM 62
+#define	MC_CMD_FREE_LL_QUEUES_IN_QUEUES_MAXNUM_MCDI2 254
+
+/* MC_CMD_FREE_LL_QUEUES_OUT msgresponse */
+#define	MC_CMD_FREE_LL_QUEUES_OUT_LEN 0
+
 #endif /* _SIENA_MC_DRIVER_PCOL_H */
-- 
2.39.5

