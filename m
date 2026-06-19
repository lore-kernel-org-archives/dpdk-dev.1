Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C652FCD98F2
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Jun 2026 12:29:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFAD140DD2;
	Fri, 19 Jun 2026 14:29:30 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 974DE402C9
 for <dev@dpdk.org>; Fri, 19 Jun 2026 14:29:28 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6DC1F20024A;
 Fri, 19 Jun 2026 14:29:28 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0E8E7200238;
 Fri, 19 Jun 2026 14:29:28 +0200 (CEST)
Received: from lsv03583.swis.in-blr01.nxp.com (lsv03583.swis.in-blr01.nxp.com
 [92.120.146.12])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 624601800071;
 Fri, 19 Jun 2026 20:29:26 +0800 (+08)
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: stephen@networkplumber.org,
	david.marchand@redhat.com,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 01/18] bus/dpaa: refine fman naming and fix global scope
Date: Fri, 19 Jun 2026 17:58:58 +0530
Message-Id: <20260619122922.3774666-2-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
References: <20260619122922.3774666-1-hemant.agrawal@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

Rename ccsr_map to memac_map in __fman_if struct for clarity,
as it maps the MEMAC register space not generic CCSR.
Rename bmi_map to rx_bmi_map to distinguish from TX BMI.
Make fman_ccsr_map_fd static as it is only used within fman.c.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/fman/fman.c    |  14 ++--
 drivers/bus/dpaa/base/fman/fman_hw.c | 106 ++++++++++++++-------------
 drivers/bus/dpaa/include/fman.h      |   6 +-
 3 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/bus/dpaa/base/fman/fman.c b/drivers/bus/dpaa/base/fman/fman.c
index 55311235f5..55f466d751 100644
--- a/drivers/bus/dpaa/base/fman/fman.c
+++ b/drivers/bus/dpaa/base/fman/fman.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2010-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2024 NXP
+ * Copyright 2017-2026 NXP
  *
  */
 
@@ -465,9 +465,9 @@ fman_if_init(const struct device_node *dpa_node, int fd)
 			 mname, regs_addr);
 		goto err;
 	}
-	__if->ccsr_map = mmap(NULL, __if->regs_size,
+	__if->memac_map = mmap(NULL, __if->regs_size,
 		PROT_READ | PROT_WRITE, MAP_SHARED, fd, phys_addr);
-	if (__if->ccsr_map == MAP_FAILED) {
+	if (__if->memac_map == MAP_FAILED) {
 		FMAN_ERR(-errno, "mmap(0x%"PRIx64")", phys_addr);
 		goto err;
 	}
@@ -599,9 +599,9 @@ fman_if_init(const struct device_node *dpa_node, int fd)
 		goto err;
 	}
 
-	__if->bmi_map = mmap(NULL, __if->regs_size,
+	__if->rx_bmi_map = mmap(NULL, __if->regs_size,
 		PROT_READ | PROT_WRITE, MAP_SHARED, fd, phys_addr);
-	if (__if->bmi_map == MAP_FAILED) {
+	if (__if->rx_bmi_map == MAP_FAILED) {
 		FMAN_ERR(-errno, "mmap(0x%"PRIx64")", phys_addr);
 		goto err;
 	}
@@ -1167,13 +1167,13 @@ fman_finish(void)
 		}
 
 		/* disable Rx and Tx */
-		regs = __if->ccsr_map;
+		regs = __if->memac_map;
 		cfg = in_be32(&regs->command_config);
 		out_be32(&regs->command_config,
 			cfg & (~(MEMAC_RX_ENABLE | MEMAC_TX_ENABLE)));
 
 		/* release the mapping */
-		_errno = munmap(__if->ccsr_map, __if->regs_size);
+		_errno = munmap(__if->memac_map, __if->regs_size);
 		if (unlikely(_errno < 0))
 			FMAN_ERR(_errno, "munmap() = (%s)", strerror(errno));
 		DPAA_BUS_INFO("Tearing down %s", __if->node_path);
diff --git a/drivers/bus/dpaa/base/fman/fman_hw.c b/drivers/bus/dpaa/base/fman/fman_hw.c
index cbb0491d70..ce68581555 100644
--- a/drivers/bus/dpaa/base/fman/fman_hw.c
+++ b/drivers/bus/dpaa/base/fman/fman_hw.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- * Copyright 2017,2020,2022-2023 NXP
+ * Copyright 2017,2020,2022-2023,2026 NXP
  *
  */
 
@@ -16,6 +16,8 @@
 #include <fsl_fman_crc64.h>
 #include <fsl_bman.h>
 
+extern int fman_ccsr_map_fd;
+
 #define FMAN_SP_SG_DISABLE                          0x80000000
 #define FMAN_SP_EXT_BUF_MARG_START_SHIFT            16
 
@@ -39,7 +41,7 @@ fman_if_set_mcast_filter_table(struct fman_if *p)
 	void *hashtable_ctrl;
 	uint32_t i;
 
-	hashtable_ctrl = &((struct memac_regs *)__if->ccsr_map)->hashtable_ctrl;
+	hashtable_ctrl = &((struct memac_regs *)__if->memac_map)->hashtable_ctrl;
 	for (i = 0; i < 64; i++)
 		out_be32(hashtable_ctrl, i|HASH_CTRL_MCAST_EN);
 }
@@ -51,7 +53,7 @@ fman_if_reset_mcast_filter_table(struct fman_if *p)
 	void *hashtable_ctrl;
 	uint32_t i;
 
-	hashtable_ctrl = &((struct memac_regs *)__if->ccsr_map)->hashtable_ctrl;
+	hashtable_ctrl = &((struct memac_regs *)__if->memac_map)->hashtable_ctrl;
 	for (i = 0; i < 64; i++)
 		out_be32(hashtable_ctrl, i & ~HASH_CTRL_MCAST_EN);
 }
@@ -101,7 +103,7 @@ fman_if_add_hash_mac_addr(struct fman_if *p, uint8_t *eth)
 	hash = get_mac_hash_code(eth_addr) & HASH_CTRL_ADDR_MASK;
 	hash = hash | HASH_CTRL_MCAST_EN;
 
-	hashtable_ctrl = &((struct memac_regs *)__if->ccsr_map)->hashtable_ctrl;
+	hashtable_ctrl = &((struct memac_regs *)__if->memac_map)->hashtable_ctrl;
 	out_be32(hashtable_ctrl, hash);
 
 	return 0;
@@ -112,7 +114,7 @@ fman_if_get_primary_mac_addr(struct fman_if *p, uint8_t *eth)
 {
 	struct __fman_if *__if = container_of(p, struct __fman_if, __if);
 	void *mac_reg =
-		&((struct memac_regs *)__if->ccsr_map)->mac_addr0.mac_addr_l;
+		&((struct memac_regs *)__if->memac_map)->mac_addr0.mac_addr_l;
 	u32 val = in_be32(mac_reg);
 	int i;
 
@@ -130,7 +132,7 @@ fman_if_get_primary_mac_addr(struct fman_if *p, uint8_t *eth)
 	eth[2] = (val & 0x00ff0000) >> 16;
 	eth[3] = (val & 0xff000000) >> 24;
 
-	mac_reg =  &((struct memac_regs *)__if->ccsr_map)->mac_addr0.mac_addr_u;
+	mac_reg =  &((struct memac_regs *)__if->memac_map)->mac_addr0.mac_addr_u;
 	val = in_be32(mac_reg);
 
 	eth[4] = (val & 0x000000ff) >> 0;
@@ -151,16 +153,16 @@ fman_if_clear_mac_addr(struct fman_if *p, uint8_t addr_num)
 		return;
 
 	if (addr_num) {
-		reg = &((struct memac_regs *)m->ccsr_map)->
+		reg = &((struct memac_regs *)m->memac_map)->
 				mac_addr[addr_num-1].mac_addr_l;
 		out_be32(reg, 0x0);
-		reg = &((struct memac_regs *)m->ccsr_map)->
+		reg = &((struct memac_regs *)m->memac_map)->
 					mac_addr[addr_num-1].mac_addr_u;
 		out_be32(reg, 0x0);
 	} else {
-		reg = &((struct memac_regs *)m->ccsr_map)->mac_addr0.mac_addr_l;
+		reg = &((struct memac_regs *)m->memac_map)->mac_addr0.mac_addr_l;
 		out_be32(reg, 0x0);
-		reg = &((struct memac_regs *)m->ccsr_map)->mac_addr0.mac_addr_u;
+		reg = &((struct memac_regs *)m->memac_map)->mac_addr0.mac_addr_u;
 		out_be32(reg, 0x0);
 	}
 }
@@ -180,10 +182,10 @@ fman_if_add_mac_addr(struct fman_if *p, uint8_t *eth, uint8_t addr_num)
 	memcpy(&m->__if.mac_addr, eth, ETHER_ADDR_LEN);
 
 	if (addr_num)
-		reg = &((struct memac_regs *)m->ccsr_map)->
+		reg = &((struct memac_regs *)m->memac_map)->
 					mac_addr[addr_num-1].mac_addr_l;
 	else
-		reg = &((struct memac_regs *)m->ccsr_map)->mac_addr0.mac_addr_l;
+		reg = &((struct memac_regs *)m->memac_map)->mac_addr0.mac_addr_l;
 
 	val = (m->__if.mac_addr.addr_bytes[0] |
 	       (m->__if.mac_addr.addr_bytes[1] << 8) |
@@ -192,10 +194,10 @@ fman_if_add_mac_addr(struct fman_if *p, uint8_t *eth, uint8_t addr_num)
 	out_be32(reg, val);
 
 	if (addr_num)
-		reg = &((struct memac_regs *)m->ccsr_map)->
+		reg = &((struct memac_regs *)m->memac_map)->
 					mac_addr[addr_num-1].mac_addr_u;
 	else
-		reg = &((struct memac_regs *)m->ccsr_map)->mac_addr0.mac_addr_u;
+		reg = &((struct memac_regs *)m->memac_map)->mac_addr0.mac_addr_u;
 
 	val = ((m->__if.mac_addr.addr_bytes[4] << 0) |
 	       (m->__if.mac_addr.addr_bytes[5] << 8));
@@ -214,7 +216,7 @@ fman_if_set_rx_ignore_pause_frames(struct fman_if *p, bool enable)
 	assert(fman_ccsr_map_fd != -1);
 
 	/* Set Rx Ignore Pause Frames */
-	cmdcfg = &((struct memac_regs *)__if->ccsr_map)->command_config;
+	cmdcfg = &((struct memac_regs *)__if->memac_map)->command_config;
 	if (enable)
 		value = in_be32(cmdcfg) | CMD_CFG_PAUSE_IGNORE;
 	else
@@ -232,7 +234,7 @@ fman_if_conf_max_frame_len(struct fman_if *p, unsigned int max_frame_len)
 	assert(fman_ccsr_map_fd != -1);
 
 	/* Set Max frame length */
-	maxfrm = &((struct memac_regs *)__if->ccsr_map)->maxfrm;
+	maxfrm = &((struct memac_regs *)__if->memac_map)->maxfrm;
 	out_be32(maxfrm, (MAXFRM_RX_MASK & max_frame_len));
 }
 
@@ -240,7 +242,7 @@ void
 fman_if_stats_get(struct fman_if *p, struct rte_eth_stats *stats)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
-	struct memac_regs *regs = m->ccsr_map;
+	struct memac_regs *regs = m->memac_map;
 
 	/* read recved packet count */
 	stats->ipackets = (u64)in_be32(&regs->rfrm_l) |
@@ -263,7 +265,7 @@ void
 fman_if_stats_get_all(struct fman_if *p, uint64_t *value, int n)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
-	struct memac_regs *regs = m->ccsr_map;
+	struct memac_regs *regs = m->memac_map;
 	int i;
 	uint64_t base_offset = offsetof(struct memac_regs, reoct_l);
 
@@ -278,7 +280,7 @@ void
 fman_if_stats_reset(struct fman_if *p)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
-	struct memac_regs *regs = m->ccsr_map;
+	struct memac_regs *regs = m->memac_map;
 	uint32_t tmp;
 
 	tmp = in_be32(&regs->statn_config);
@@ -295,7 +297,7 @@ void
 fman_if_bmi_stats_enable(struct fman_if *p)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
-	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->bmi_map;
+	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->rx_bmi_map;
 	uint32_t tmp;
 
 	tmp = in_be32(&regs->fmbm_rstc);
@@ -309,7 +311,7 @@ void
 fman_if_bmi_stats_disable(struct fman_if *p)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
-	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->bmi_map;
+	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->rx_bmi_map;
 	uint32_t tmp;
 
 	tmp = in_be32(&regs->fmbm_rstc);
@@ -323,7 +325,7 @@ void
 fman_if_bmi_stats_get_all(struct fman_if *p, uint64_t *value)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
-	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->bmi_map;
+	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->rx_bmi_map;
 	int i = 0;
 
 	value[i++] = (u32)in_be32(&regs->fmbm_rfrc);
@@ -340,7 +342,7 @@ void
 fman_if_bmi_stats_reset(struct fman_if *p)
 {
 	struct __fman_if *m = container_of(p, struct __fman_if, __if);
-	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->bmi_map;
+	struct rx_bmi_regs *regs = (struct rx_bmi_regs *)m->rx_bmi_map;
 
 	out_be32(&regs->fmbm_rfrc, 0);
 	out_be32(&regs->fmbm_rfbc, 0);
@@ -361,7 +363,7 @@ fman_if_promiscuous_enable(struct fman_if *p)
 	assert(fman_ccsr_map_fd != -1);
 
 	/* Enable Rx promiscuous mode */
-	cmdcfg = &((struct memac_regs *)__if->ccsr_map)->command_config;
+	cmdcfg = &((struct memac_regs *)__if->memac_map)->command_config;
 	out_be32(cmdcfg, in_be32(cmdcfg) | CMD_CFG_PROMIS_EN);
 }
 
@@ -374,7 +376,7 @@ fman_if_promiscuous_disable(struct fman_if *p)
 	assert(fman_ccsr_map_fd != -1);
 
 	/* Disable Rx promiscuous mode */
-	cmdcfg = &((struct memac_regs *)__if->ccsr_map)->command_config;
+	cmdcfg = &((struct memac_regs *)__if->memac_map)->command_config;
 	out_be32(cmdcfg, in_be32(cmdcfg) & (~CMD_CFG_PROMIS_EN));
 }
 
@@ -386,7 +388,7 @@ fman_if_enable_rx(struct fman_if *p)
 	assert(fman_ccsr_map_fd != -1);
 
 	/* enable Rx and Tx */
-	out_be32(__if->ccsr_map + 8, in_be32(__if->ccsr_map + 8) | 3);
+	out_be32(__if->memac_map + 8, in_be32(__if->memac_map + 8) | 3);
 }
 
 void
@@ -397,7 +399,7 @@ fman_if_disable_rx(struct fman_if *p)
 	assert(fman_ccsr_map_fd != -1);
 
 	/* only disable Rx, not Tx */
-	out_be32(__if->ccsr_map + 8, in_be32(__if->ccsr_map + 8) & ~(u32)2);
+	out_be32(__if->memac_map + 8, in_be32(__if->memac_map + 8) & ~(u32)2);
 }
 
 int
@@ -408,7 +410,7 @@ fman_if_get_rx_status(struct fman_if *p)
 	assert(fman_ccsr_map_fd != -1);
 
 	/* return true if RX bit is set */
-	return !!(in_be32(__if->ccsr_map + 8) & (u32)2);
+	return !!(in_be32(__if->memac_map + 8) & (u32)2);
 }
 
 void
@@ -421,11 +423,11 @@ fman_if_loopback_enable(struct fman_if *p)
 	/* Enable loopback mode */
 	if ((__if->__if.is_memac) && (__if->__if.is_rgmii)) {
 		unsigned int *ifmode =
-			&((struct memac_regs *)__if->ccsr_map)->if_mode;
+			&((struct memac_regs *)__if->memac_map)->if_mode;
 		out_be32(ifmode, in_be32(ifmode) | IF_MODE_RLP);
 	} else{
 		unsigned int *cmdcfg =
-			&((struct memac_regs *)__if->ccsr_map)->command_config;
+			&((struct memac_regs *)__if->memac_map)->command_config;
 		out_be32(cmdcfg, in_be32(cmdcfg) | CMD_CFG_LOOPBACK_EN);
 	}
 }
@@ -439,11 +441,11 @@ fman_if_loopback_disable(struct fman_if *p)
 	/* Disable loopback mode */
 	if ((__if->__if.is_memac) && (__if->__if.is_rgmii)) {
 		unsigned int *ifmode =
-			&((struct memac_regs *)__if->ccsr_map)->if_mode;
+			&((struct memac_regs *)__if->memac_map)->if_mode;
 		out_be32(ifmode, in_be32(ifmode) & ~IF_MODE_RLP);
 	} else {
 		unsigned int *cmdcfg =
-			&((struct memac_regs *)__if->ccsr_map)->command_config;
+			&((struct memac_regs *)__if->memac_map)->command_config;
 		out_be32(cmdcfg, in_be32(cmdcfg) & ~CMD_CFG_LOOPBACK_EN);
 	}
 }
@@ -461,11 +463,11 @@ fman_if_set_bp(struct fman_if *fm_if, unsigned num __always_unused,
 	assert(fman_ccsr_map_fd != -1);
 
 	fmbm_ebmpi =
-	       in_be32(&((struct rx_bmi_regs *)__if->bmi_map)->fmbm_ebmpi[0]);
+	       in_be32(&((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_ebmpi[0]);
 	fmbm_ebmpi = ebmpi_val_ace | (fmbm_ebmpi & ebmpi_mask) | (bpid << 16) |
 		     (bufsize);
 
-	out_be32(&((struct rx_bmi_regs *)__if->bmi_map)->fmbm_ebmpi[0],
+	out_be32(&((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_ebmpi[0],
 		 fmbm_ebmpi);
 }
 
@@ -477,7 +479,7 @@ fman_if_get_fc_threshold(struct fman_if *fm_if)
 
 	assert(fman_ccsr_map_fd != -1);
 
-	fmbm_mpd = &((struct rx_bmi_regs *)__if->bmi_map)->fmbm_mpd;
+	fmbm_mpd = &((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_mpd;
 	return in_be32(fmbm_mpd);
 }
 
@@ -490,7 +492,7 @@ fman_if_set_fc_threshold(struct fman_if *fm_if, u32 high_water,
 
 	assert(fman_ccsr_map_fd != -1);
 
-	fmbm_mpd = &((struct rx_bmi_regs *)__if->bmi_map)->fmbm_mpd;
+	fmbm_mpd = &((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_mpd;
 	out_be32(fmbm_mpd, FMAN_ENABLE_BPOOL_DEPLETION);
 	return bm_pool_set_hw_threshold(bpid, low_water, high_water);
 
@@ -503,7 +505,7 @@ fman_if_get_fc_quanta(struct fman_if *fm_if)
 
 	assert(fman_ccsr_map_fd != -1);
 
-	return in_be32(&((struct memac_regs *)__if->ccsr_map)->pause_quanta[0]);
+	return in_be32(&((struct memac_regs *)__if->memac_map)->pause_quanta[0]);
 }
 
 int
@@ -513,7 +515,7 @@ fman_if_set_fc_quanta(struct fman_if *fm_if, u16 pause_quanta)
 
 	assert(fman_ccsr_map_fd != -1);
 
-	out_be32(&((struct memac_regs *)__if->ccsr_map)->pause_quanta[0],
+	out_be32(&((struct memac_regs *)__if->memac_map)->pause_quanta[0],
 		 pause_quanta);
 	return 0;
 }
@@ -528,7 +530,7 @@ fman_if_get_fdoff(struct fman_if *fm_if)
 
 	assert(fman_ccsr_map_fd != -1);
 
-	fmbm_rebm = in_be32(&((struct rx_bmi_regs *)__if->bmi_map)->fmbm_rebm);
+	fmbm_rebm = in_be32(&((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_rebm);
 
 	fdoff = (fmbm_rebm >> FMAN_SP_EXT_BUF_MARG_START_SHIFT) & 0x1ff;
 
@@ -543,7 +545,7 @@ fman_if_set_err_fqid(struct fman_if *fm_if, uint32_t err_fqid)
 	assert(fman_ccsr_map_fd != -1);
 
 	unsigned int *fmbm_refqid =
-			&((struct rx_bmi_regs *)__if->bmi_map)->fmbm_refqid;
+			&((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_refqid;
 	out_be32(fmbm_refqid, err_fqid);
 }
 
@@ -559,7 +561,7 @@ fman_if_get_ic_params(struct fman_if *fm_if, struct fman_if_ic_params *icp)
 	assert(fman_ccsr_map_fd != -1);
 
 	unsigned int *fmbm_ricp =
-		&((struct rx_bmi_regs *)__if->bmi_map)->fmbm_ricp;
+		&((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_ricp;
 	val = in_be32(fmbm_ricp);
 
 	icp->iceof = (val & iceof_mask) >> 12;
@@ -586,7 +588,7 @@ fman_if_set_ic_params(struct fman_if *fm_if,
 	val |= (icp->icsz >> 4) & icsz_mask;
 
 	unsigned int *fmbm_ricp =
-		&((struct rx_bmi_regs *)__if->bmi_map)->fmbm_ricp;
+		&((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_ricp;
 	out_be32(fmbm_ricp, val);
 
 	unsigned int *fmbm_ticp =
@@ -608,7 +610,7 @@ fman_if_set_fdoff(struct fman_if *fm_if, uint32_t fd_offset)
 
 	assert(fman_ccsr_map_fd != -1);
 
-	fmbm_rebm = &((struct rx_bmi_regs *)__if->bmi_map)->fmbm_rebm;
+	fmbm_rebm = &((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_rebm;
 
 	out_be32(fmbm_rebm, (in_be32(fmbm_rebm) & ~fmbm_mask) | val);
 }
@@ -621,7 +623,7 @@ fman_if_set_maxfrm(struct fman_if *fm_if, uint16_t max_frm)
 
 	assert(fman_ccsr_map_fd != -1);
 
-	reg_maxfrm = &((struct memac_regs *)__if->ccsr_map)->maxfrm;
+	reg_maxfrm = &((struct memac_regs *)__if->memac_map)->maxfrm;
 
 	out_be32(reg_maxfrm, (in_be32(reg_maxfrm) & 0xFFFF0000) | max_frm);
 }
@@ -634,7 +636,7 @@ fman_if_get_maxfrm(struct fman_if *fm_if)
 
 	assert(fman_ccsr_map_fd != -1);
 
-	reg_maxfrm = &((struct memac_regs *)__if->ccsr_map)->maxfrm;
+	reg_maxfrm = &((struct memac_regs *)__if->memac_map)->maxfrm;
 
 	return (in_be32(reg_maxfrm) | 0x0000FFFF);
 }
@@ -655,7 +657,7 @@ fman_if_get_sg_enable(struct fman_if *fm_if)
 
 	assert(fman_ccsr_map_fd != -1);
 
-	fmbm_rebm = in_be32(&((struct rx_bmi_regs *)__if->bmi_map)->fmbm_rebm);
+	fmbm_rebm = in_be32(&((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_rebm);
 
 	return (fmbm_rebm & FMAN_SP_SG_DISABLE) ? 0 : 1;
 }
@@ -675,7 +677,7 @@ fman_if_set_sg(struct fman_if *fm_if, int enable)
 
 	assert(fman_ccsr_map_fd != -1);
 
-	fmbm_rebm = &((struct rx_bmi_regs *)__if->bmi_map)->fmbm_rebm;
+	fmbm_rebm = &((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_rebm;
 
 	out_be32(fmbm_rebm, (in_be32(fmbm_rebm) & ~fmbm_mask) | val);
 }
@@ -699,14 +701,14 @@ fman_if_discard_rx_errors(struct fman_if *fm_if)
 	struct __fman_if *__if = container_of(fm_if, struct __fman_if, __if);
 	unsigned int *fmbm_rfsdm, *fmbm_rfsem;
 
-	fmbm_rfsem = &((struct rx_bmi_regs *)__if->bmi_map)->fmbm_rfsem;
+	fmbm_rfsem = &((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_rfsem;
 	out_be32(fmbm_rfsem, 0);
 
 	/* Configure the discard mask to discard the error packets which have
 	 * DMA errors, Frame size error, Header error etc. The mask 0x010EE3F0
 	 * is to configured discard all the errors which come in the FD[STATUS]
 	 */
-	fmbm_rfsdm = &((struct rx_bmi_regs *)__if->bmi_map)->fmbm_rfsdm;
+	fmbm_rfsdm = &((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_rfsdm;
 	out_be32(fmbm_rfsdm, 0x010EE3F0);
 }
 
@@ -718,9 +720,9 @@ fman_if_receive_rx_errors(struct fman_if *fm_if,
 	unsigned int *fmbm_rcfg, *fmbm_rfsdm, *fmbm_rfsem;
 	unsigned int val;
 
-	fmbm_rcfg = &((struct rx_bmi_regs *)__if->bmi_map)->fmbm_rcfg;
-	fmbm_rfsdm = &((struct rx_bmi_regs *)__if->bmi_map)->fmbm_rfsdm;
-	fmbm_rfsem = &((struct rx_bmi_regs *)__if->bmi_map)->fmbm_rfsem;
+	fmbm_rcfg = &((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_rcfg;
+	fmbm_rfsdm = &((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_rfsdm;
+	fmbm_rfsem = &((struct rx_bmi_regs *)__if->rx_bmi_map)->fmbm_rfsem;
 
 	val = in_be32(fmbm_rcfg);
 	out_be32(fmbm_rcfg, val | BMI_PORT_CFG_FDOVR);
diff --git a/drivers/bus/dpaa/include/fman.h b/drivers/bus/dpaa/include/fman.h
index 6e3abf1b50..6e35af57d7 100644
--- a/drivers/bus/dpaa/include/fman.h
+++ b/drivers/bus/dpaa/include/fman.h
@@ -462,8 +462,8 @@ struct __fman_if {
 	char node_name[IF_NAME_MAX_LEN];
 	char node_path[PATH_MAX];
 	uint64_t regs_size;
-	void *ccsr_map;
-	void *bmi_map;
+	void *memac_map;
+	void *rx_bmi_map;
 	void *tx_bmi_map;
 	void *qmi_map;
 };
@@ -473,8 +473,6 @@ struct __fman_if {
  */
 extern const struct list_head *fman_if_list;
 
-extern int fman_ccsr_map_fd;
-
 /* To iterate the "bpool_list" for an interface. Eg;
  *        struct fman_if *p = get_ptr_to_some_interface();
  *        struct fman_if_bpool *bp;
-- 
2.25.1

