Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA18DC021BC
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Feb 2025 07:45:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 044B840E15;
	Wed, 26 Feb 2025 08:43:01 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 9F41E40662
 for <dev@dpdk.org>; Wed, 26 Feb 2025 08:42:52 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id F0BE954B9DF; Wed, 26 Feb 2025 15:42:51 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org,
	dev@dpdk.org,
	yaojun@mucse.com
Subject: [PATCH v16 26/29] net/rnp: add support VLAN filters operations
Date: Wed, 26 Feb 2025 15:42:13 +0800
Message-Id: <1740555736-19894-27-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740555736-19894-1-git-send-email-caowenbo@mucse.com>
References: <1740555736-19894-1-git-send-email-caowenbo@mucse.com>
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

add support to update vid for vlan filter.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini    |  1 +
 doc/guides/nics/rnp.rst             |  3 +-
 drivers/net/rnp/base/meson.build    |  1 +
 drivers/net/rnp/base/rnp_bitrev.h   | 64 ++++++++++++++++++++
 drivers/net/rnp/base/rnp_crc32.c    | 37 ++++++++++++
 drivers/net/rnp/base/rnp_crc32.h    | 10 ++++
 drivers/net/rnp/base/rnp_eth_regs.h |  1 +
 drivers/net/rnp/base/rnp_hw.h       |  1 +
 drivers/net/rnp/base/rnp_mac.c      | 90 ++++++++++++++++++++++++++++-
 drivers/net/rnp/base/rnp_mac.h      |  1 +
 drivers/net/rnp/base/rnp_mac_regs.h |  6 ++
 drivers/net/rnp/base/rnp_osdep.h    | 13 +++++
 drivers/net/rnp/rnp.h               | 11 ++++
 drivers/net/rnp/rnp_ethdev.c        | 11 ++++
 14 files changed, 247 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/rnp/base/rnp_bitrev.h
 create mode 100644 drivers/net/rnp/base/rnp_crc32.c
 create mode 100644 drivers/net/rnp/base/rnp_crc32.h

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index c1ab91697a..48d250c86b 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -20,6 +20,7 @@ Promiscuous mode     = Y
 Allmulticast mode    = Y
 MTU update           = Y
 Unicast MAC filter   = Y
+VLAN filter          = Y
 VLAN offload         = Y
 QinQ offload         = P
 RSS hash             = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index 320f19451b..737b980291 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -51,7 +51,7 @@ Features
 - Promiscuous mode
 - Link state information
 - MTU update
-- MAC filtering
+- MAC/VLAN filtering
 - Jumbo frames
 - Scatter-Gather IO support
 - Port hardware statistic
@@ -105,6 +105,7 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_dev_get_vlan_offload``
 * ``rte_eth_dev_set_vlan_offload``
 * ``rte_eth_dev_set_vlan_strip_on_queue``
+* ``rte_eth_dev_vlan_filter``
 * ``rte_eth_promiscuous_disable``
 * ``rte_eth_promiscuous_enable``
 * ``rte_eth_allmulticast_enable``
diff --git a/drivers/net/rnp/base/meson.build b/drivers/net/rnp/base/meson.build
index ba49accdec..2a1f2c22ea 100644
--- a/drivers/net/rnp/base/meson.build
+++ b/drivers/net/rnp/base/meson.build
@@ -8,6 +8,7 @@ sources = [
         'rnp_common.c',
         'rnp_mac.c',
         'rnp_bdq_if.c',
+        'rnp_crc32.c',
 ]
 
 c_args = cflags
diff --git a/drivers/net/rnp/base/rnp_bitrev.h b/drivers/net/rnp/base/rnp_bitrev.h
new file mode 100644
index 0000000000..05c36ca80d
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_bitrev.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_BITREV_H_
+#define _RNP_BITREV_H_
+
+#include "rnp_osdep.h"
+
+static const u8 byte_rev_table[256] = {
+	0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,
+	0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
+	0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8,
+	0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,
+	0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4,
+	0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,
+	0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec,
+	0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,
+	0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2,
+	0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,
+	0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea,
+	0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,
+	0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6,
+	0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,
+	0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee,
+	0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,
+	0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1,
+	0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,
+	0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9,
+	0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,
+	0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5,
+	0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,
+	0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed,
+	0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,
+	0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3,
+	0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,
+	0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb,
+	0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,
+	0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7,
+	0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,
+	0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef,
+	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff,
+};
+
+static inline u8 bitrev8(u8 byte)
+{
+	return byte_rev_table[byte];
+}
+
+static u16 bitrev16(u16 x)
+{
+	return (bitrev8(x & 0xff) << 8) | bitrev8(x >> 8);
+}
+
+/**
+ * bitrev32 - reverse the order of bits in a u32 value
+ * @x: value to be bit-reversed
+ */
+static u32 bitrev32(uint32_t x)
+{
+	return (bitrev16(x & 0xffff) << 16) | bitrev16(x >> 16);
+}
+
+#endif /* _RNP_BITREV_H */
diff --git a/drivers/net/rnp/base/rnp_crc32.c b/drivers/net/rnp/base/rnp_crc32.c
new file mode 100644
index 0000000000..c287b35759
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_crc32.c
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include "rnp_osdep.h"
+#include "rnp_crc32.h"
+
+static inline int get_bitmask_order(u32 count)
+{
+	int order;
+
+	order = fls(count);
+
+	return order;   /* We could be slightly more clever with -1 here... */
+}
+
+u32 rnp_vid_crc32_calc(u32 crc_init, u16 vid_le)
+{
+	u8 *data = (u8 *)&vid_le;
+	u32 crc = crc_init;
+	u8 data_byte = 0;
+	u32 temp = 0;
+	int i, bits;
+
+	bits = get_bitmask_order(VLAN_VID_MASK);
+	for (i = 0; i < bits; i++) {
+		if ((i % 8) == 0)
+			data_byte = data[i / 8];
+		temp = ((crc & 1) ^ data_byte) & 1;
+		crc >>= 1;
+		data_byte >>= 1;
+		if (temp)
+			crc ^= 0xedb88320;
+	}
+
+	return crc;
+}
diff --git a/drivers/net/rnp/base/rnp_crc32.h b/drivers/net/rnp/base/rnp_crc32.h
new file mode 100644
index 0000000000..e117dcfc2f
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_crc32.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_CRC32_H_
+#define _RNP_CRC32_H_
+
+u32 rnp_vid_crc32_calc(u32 crc_init, u16 vid_le);
+
+#endif /* _RNP_CRC32_H_ */
diff --git a/drivers/net/rnp/base/rnp_eth_regs.h b/drivers/net/rnp/base/rnp_eth_regs.h
index f84386d93a..5c3f7f906c 100644
--- a/drivers/net/rnp/base/rnp_eth_regs.h
+++ b/drivers/net/rnp/base/rnp_eth_regs.h
@@ -62,6 +62,7 @@
 /* vlan filter ctrl */
 #define RNP_VLAN_FILTER_CTRL	_ETH_(0x9118)
 #define RNP_VLAN_FILTER_EN	RTE_BIT32(30)
+#define RNP_VFTA_HASH_TABLE(id) _ETH_(0xB000 + 0x4 * (id))
 /* rss function ctrl */
 #define RNP_RSS_INNER_CTRL	_ETH_(0x805c)
 #define RNP_INNER_RSS_EN	(1)
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index c7e5a2f506..8cf57db185 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -76,6 +76,7 @@ struct rnp_mac_ops {
 	int (*clear_rafb)(struct rnp_eth_port *port, u32 index);
 	/* receive vlan filter */
 	int (*vlan_f_en)(struct rnp_eth_port *port, bool en);
+	int (*update_vlan)(struct rnp_eth_port *port, u16 vid, bool en);
 };
 
 struct rnp_eth_adapter;
diff --git a/drivers/net/rnp/base/rnp_mac.c b/drivers/net/rnp/base/rnp_mac.c
index b6b969a020..b723c29ac5 100644
--- a/drivers/net/rnp/base/rnp_mac.c
+++ b/drivers/net/rnp/base/rnp_mac.c
@@ -8,6 +8,8 @@
 #include "rnp_mac.h"
 #include "rnp_eth_regs.h"
 #include "rnp_mac_regs.h"
+#include "rnp_bitrev.h"
+#include "rnp_crc32.h"
 #include "../rnp.h"
 
 static int
@@ -194,11 +196,11 @@ rnp_en_vlan_filter_indep(struct rnp_eth_port *port, bool en)
 	vlan_reg = RNP_MAC_REG_RD(hw, lane, RNP_MAC_VLAN_TAG);
 	if (en) {
 		flt_reg |= RNP_MAC_VTFE;
-		vlan_reg |= (RNP_MAC_VLAN_VTHM | RNP_MAC_VLAN_ETV | \;
+		vlan_reg |= (RNP_MAC_VLAN_VTHM | RNP_MAC_VLAN_ETV |
 			     RNP_MAC_VLAN_HASH_EN);
 	} else {
 		flt_reg &= ~RNP_MAC_VTFE;
-		vlan_reg &= ~(RNP_MAC_VLAN_VTHM | RNP_MAC_VLAN_ETV | \;
+		vlan_reg &= ~(RNP_MAC_VLAN_VTHM | RNP_MAC_VLAN_ETV |
 			      RNP_MAC_VLAN_HASH_EN);
 	}
 	RNP_MAC_REG_WR(hw, lane, RNP_MAC_PKT_FLT_CTRL, flt_reg);
@@ -207,12 +209,87 @@ rnp_en_vlan_filter_indep(struct rnp_eth_port *port, bool en)
 	return 0;
 }
 
+static int
+rnp_update_vlan_filter_pf(struct rnp_eth_port *port,
+			  u16 vlan, bool add)
+{
+	struct rnp_vlan_filter *vfta_tb = &port->vfta;
+	struct rnp_hw *hw = port->hw;
+	u32 vid_idx;
+	u32 vid_bit;
+	u32 vfta;
+
+	vid_idx = (u32)((vlan >> 5) & 0x7F);
+	vid_bit = (u32)(1 << (vlan & 0x1F));
+	vfta = RNP_E_REG_RD(hw, RNP_VFTA_HASH_TABLE(vid_idx));
+	if (add)
+		vfta |= vid_bit;
+	else
+		vfta &= ~vid_bit;
+	RNP_E_REG_WR(hw, RNP_VFTA_HASH_TABLE(vid_idx), vfta);
+	/* update local VFTA copy */
+	vfta_tb->vfta_entries[vid_idx] = vfta;
+
+	return 0;
+}
+
+static void
+rnp_update_vlan_hash_indep(struct rnp_eth_port *port)
+{
+	struct rnp_hw *hw = port->hw;
+	u16 lane = port->attr.nr_lane;
+	u64 vid_idx, vid_bit;
+	u16 shift_bit = 0;
+	u16 hash = 0;
+	u16 vid_le;
+	u32 crc;
+	u16 vid;
+
+	/* Generate VLAN Hash Table */
+	for (vid = 0; vid < VLAN_N_VID; vid++) {
+		vid_idx = RNP_VLAN_BITMAP_IDX(vid);
+		vid_bit = port->vfta.vlans_bitmap[vid_idx];
+		shift_bit = vid - (BITS_TO_LONGS(VLAN_N_VID) * vid_idx);
+		shift_bit &= 0x3f;
+		vid_bit = (u64)(vid_bit >> shift_bit);
+		/* If Vid isn't Set, Calc Next Vid Hash Value */
+		if (!(vid_bit & 1))
+			continue;
+		vid_le = cpu_to_le16(vid);
+		crc = bitrev32(~rnp_vid_crc32_calc(~0, vid_le));
+		crc >>= RNP_MAC_VLAN_HASH_SHIFT;
+		hash |= (1 << crc);
+	}
+	/* Update vlan hash table */
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_VLAN_HASH, hash);
+}
+
+static int
+rnp_update_vlan_filter_indep(struct rnp_eth_port *port,
+			     u16 vid,
+			     bool add)
+{
+	u64 vid_bit, vid_idx;
+
+	vid_bit = RNP_VLAN_BITMAP_BIT(vid);
+	vid_idx = RNP_VLAN_BITMAP_IDX(vid);
+	if (add)
+		port->vfta.vlans_bitmap[vid_idx] |= vid_bit;
+	else
+		port->vfta.vlans_bitmap[vid_idx] &= ~vid_bit;
+
+	rnp_update_vlan_hash_indep(port);
+
+	return 0;
+}
+
 const struct rnp_mac_ops rnp_mac_ops_pf = {
 	.get_macaddr = rnp_mbx_fw_get_macaddr,
 	.update_mpfm = rnp_update_mpfm_pf,
 	.set_rafb = rnp_set_mac_addr_pf,
 	.clear_rafb = rnp_clear_mac_pf,
 	.vlan_f_en = rnp_en_vlan_filter_pf,
+	.update_vlan = rnp_update_vlan_filter_pf,
 };
 
 const struct rnp_mac_ops rnp_mac_ops_indep = {
@@ -221,6 +298,7 @@ const struct rnp_mac_ops rnp_mac_ops_indep = {
 	.set_rafb = rnp_set_mac_addr_indep,
 	.clear_rafb = rnp_clear_mac_indep,
 	.vlan_f_en = rnp_en_vlan_filter_indep,
+	.update_vlan = rnp_update_vlan_filter_indep,
 };
 
 int rnp_get_mac_addr(struct rnp_eth_port *port, u8 *mac)
@@ -264,6 +342,14 @@ int rnp_rx_vlan_filter_en(struct rnp_eth_port *port, bool en)
 	return rnp_call_hwif_impl(port, mac_ops->vlan_f_en, en);
 }
 
+int rnp_update_vlan_filter(struct rnp_eth_port *port, u16 vid, bool en)
+{
+	const struct rnp_mac_ops *mac_ops =
+		RNP_DEV_PP_TO_MAC_OPS(port->eth_dev);
+
+	return rnp_call_hwif_impl(port, mac_ops->update_vlan, vid, en);
+}
+
 void rnp_mac_ops_init(struct rnp_hw *hw)
 {
 	struct rnp_proc_priv *proc_priv = RNP_DEV_TO_PROC_PRIV(hw->back->eth_dev);
diff --git a/drivers/net/rnp/base/rnp_mac.h b/drivers/net/rnp/base/rnp_mac.h
index 4a5206ded3..6f22c8279a 100644
--- a/drivers/net/rnp/base/rnp_mac.h
+++ b/drivers/net/rnp/base/rnp_mac.h
@@ -29,5 +29,6 @@ int rnp_clear_macaddr(struct rnp_eth_port *port, u32 index);
 int rnp_update_mpfm(struct rnp_eth_port *port,
 		    u32 mode, bool en);
 int rnp_rx_vlan_filter_en(struct rnp_eth_port *port, bool en);
+int rnp_update_vlan_filter(struct rnp_eth_port *port, u16 vid, bool en);
 
 #endif /* _RNP_MAC_H_ */
diff --git a/drivers/net/rnp/base/rnp_mac_regs.h b/drivers/net/rnp/base/rnp_mac_regs.h
index 045fc28ec9..f15d7b2d72 100644
--- a/drivers/net/rnp/base/rnp_mac_regs.h
+++ b/drivers/net/rnp/base/rnp_mac_regs.h
@@ -85,6 +85,12 @@
 #define RNP_MAC_VLAN_ETV	RTE_BIT32(16)
 /* enable vid valid  */
 #define RNP_MAC_VLAN_HASH_EN	RTE_GENMASK32(15, 0)
+/* mac vlan hash filter */
+#define RNP_MAC_VLAN_HASH	(0x58)
+#define RNP_MAC_VLAN_HASH_MASK	RTE_GENMASK32(15, 0)
+#define RNP_MAC_VLAN_HASH_SHIFT	(28)
+#define RNP_VLAN_BITMAP_BIT(vlan_id)	(1UL << ((vlan_id) & 0x3F))
+#define RNP_VLAN_BITMAP_IDX(vlan_id)	((vlan_id) >> 6)
 /* MAC VLAN CTRL INSERT REG */
 #define RNP_MAC_VLAN_INCL	(0x60)
 #define RNP_MAC_INNER_VLAN_INCL	(0x64)
diff --git a/drivers/net/rnp/base/rnp_osdep.h b/drivers/net/rnp/base/rnp_osdep.h
index 3b23ed3ed0..58dcb40f90 100644
--- a/drivers/net/rnp/base/rnp_osdep.h
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -53,6 +53,19 @@ typedef uint64_t u64;
 #define cpu_to_le32(v)	rte_cpu_to_le_32((u32)(v))
 #endif
 
+#ifndef DIV_ROUND_UP
+#define DIV_ROUND_UP(n, d)      (((n) + (d) - 1) / (d))
+#define BITS_PER_BYTE           (8)
+#define BITS_TO_LONGS(nr)       DIV_ROUND_UP(nr, BITS_PER_BYTE * sizeof(long))
+#endif
+
+#define fls(n)	rte_fls_u32(n)
+
+#ifndef VLAN_N_VID
+#define VLAN_N_VID		(4096)
+#define VLAN_VID_MASK		(0x0fff)
+#endif
+
 #define spinlock_t			rte_spinlock_t
 #define spin_lock_init(spinlock_v)	rte_spinlock_init(spinlock_v)
 #define spin_lock(spinlock_v)		rte_spinlock_lock(spinlock_v)
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 1ee326ca03..301e6ef203 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -66,6 +66,7 @@
 #define RNP_MAX_HASH_MC_MAC_SIZE	(4096)	/* max multicast hash mac num */
 #define RNP_MAX_UC_HASH_TABLE		(128)	/* max unicast hash mac filter table */
 #define RNP_MAC_MC_HASH_TABLE		(128)	/* max multicast hash mac filter table*/
+#define RNP_MAX_VFTA_SIZE		(128)   /* max pf vlan hash table size */
 /* Peer port own independent resource */
 #define RNP_PORT_MAX_MACADDR         (32)
 #define RNP_PORT_MAX_MC_HASH_TB      (8)
@@ -172,6 +173,15 @@ enum rnp_vlan_type {
 	RNP_SVLAN_TYPE = 1,
 };
 
+struct rnp_vlan_filter {
+	union {
+		/* indep vlan hash filter table used */
+		uint64_t vlans_bitmap[BITS_TO_LONGS(VLAN_N_VID)];
+		/* PF vlan filter table used */
+		uint32_t vfta_entries[RNP_MAX_VFTA_SIZE];
+	};
+};
+
 struct rnp_eth_port {
 	struct rnp_proc_priv *proc_priv;
 	struct rte_ether_addr mac_addr;
@@ -196,6 +206,7 @@ struct rnp_eth_port {
 
 	enum rnp_vlan_type outvlan_type;
 	enum rnp_vlan_type invlan_type;
+	struct rnp_vlan_filter vfta;
 	rte_spinlock_t rx_mac_lock;
 	bool port_stopped;
 };
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index c7438101eb..b6453be079 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -395,6 +395,15 @@ rnp_vlan_offload_set(struct rte_eth_dev *dev, int mask)
 	return 0;
 }
 
+static int
+rnp_vlan_filter_set(struct rte_eth_dev *dev,
+		uint16_t vlan_id, int on)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+
+	return rnp_update_vlan_filter(port, vlan_id, on);
+}
+
 static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
@@ -828,6 +837,7 @@ static int rnp_dev_infos_get(struct rte_eth_dev *eth_dev,
 	dev_info->rx_queue_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 	/* rx support offload cap */
 	dev_info->rx_offload_capa = RNP_RX_CHECKSUM_SUPPORT |
+				    RTE_ETH_RX_OFFLOAD_VLAN_FILTER |
 				    RTE_ETH_RX_OFFLOAD_SCATTER;
 	dev_info->rx_offload_capa |= dev_info->rx_queue_offload_capa;
 	/* tx support offload cap */
@@ -1496,6 +1506,7 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	/* vlan offload */
 	.vlan_offload_set             = rnp_vlan_offload_set,
 	.vlan_strip_queue_set         = rnp_vlan_strip_queue_set,
+	.vlan_filter_set              = rnp_vlan_filter_set,
 	.dev_supported_ptypes_get     = rnp_dev_supported_ptypes_get,
 };
 
-- 
2.25.1

