Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 044E3C79F9E
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Sep 2026 05:48:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 221A040E31;
	Tue,  8 Sep 2026 07:47:56 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 09CCD4067B
 for <dev@dpdk.org>; Tue,  8 Sep 2026 07:47:45 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E14D4200129;
 Tue,  8 Sep 2026 07:47:44 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ABA6A200284;
 Tue,  8 Sep 2026 07:47:44 +0200 (CEST)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3554018000B5;
 Tue,  8 Sep 2026 13:47:44 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v13 12/15] net/enetc4: add SI-based port VLAN insertion and
 removal
Date: Tue,  8 Sep 2026 11:17:33 +0530
Message-Id: <20260908054736.842738-13-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260908054736.842738-1-g.singh@nxp.com>
References: <20260819053415.645865-1-g.singh@nxp.com>
 <20260908054736.842738-1-g.singh@nxp.com>
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

Implement hardware VLAN tag insertion on Tx and removal on Rx
via the per-SI VLAN isolation (pvid) mechanism on ENETC4.

On a PF, the driver writes directly to PSIaVLANR(0) (VID + enable
bit) and PSIaCFGR0(0) (SIVIE for Tx insertion, VTE for Rx removal,
SIVC_CVLAN to allow C-VLAN 0x8100 TPID).

On a privileged VF, the request is forwarded to the kernel PF via
the VSI-PSI mailbox using a new command class 0x24 (SI VLAN
isolation, cmd ID 0x1). The kernel PF handler programs the same
registers on behalf of the VF's station interface. The class 0x24
reply is added to the pass-through list in enetc4_msg_vsi_send() so
it is handled correctly alongside the existing command classes

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/nics/enetc4.rst             |  4 ++
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/enetc/base/enetc4_hw.h     | 14 ++++
 drivers/net/enetc/enetc.h              | 23 ++++++
 drivers/net/enetc/enetc4_ethdev.c      | 45 ++++++++++++
 drivers/net/enetc/enetc4_vf.c          | 96 ++++++++++++++++++++++++++
 6 files changed, 183 insertions(+)

diff --git a/doc/guides/nics/enetc4.rst b/doc/guides/nics/enetc4.rst
index dff12919fc..6c71108de6 100644
--- a/doc/guides/nics/enetc4.rst
+++ b/doc/guides/nics/enetc4.rst
@@ -67,6 +67,10 @@ Key functionality includes:
   See `Rx Interrupt Mode (VF)`_ for setup details.
 - Firmware version: The NETC IP version is reported via ``rte_eth_dev_fw_version_get``.
 - Registers dump: The station interface, port (PF only) and BD ring registers are dumped via ``rte_eth_dev_get_reg_info``.
+- SI-based port VLAN (pvid): Hardware VLAN tag insertion on Tx and removal on Rx, configured
+  via ``rte_eth_dev_set_vlan_pvid``. On a PF the registers are written directly; on a privileged
+  VF the request is forwarded to the kernel PF through the VSI-PSI mailbox (class 0x24).
+  Use the testpmd command ``tx_vlan set pvid <port_id> <vlan_id> on|off`` to enable or disable.
 
 .. note::
 
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c182495118..190d77ecee 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -72,6 +72,7 @@ New Features
   * Refreshed VF link speed on the link-up interrupt in the ENETC4 VF driver.
   * Added stats reset for the ENETC4 VF using a software snapshot/delta approach.
   * Added per-queue MSI-X Rx interrupt support for the ENETC4 VF.
+  * Added SI-based port VLAN insertion (Tx) and removal (Rx) for ENETC4 PF and VF.
 
 Removed Items
 -------------
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index d4cdb01bcf..b3c6b02100 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -275,6 +275,20 @@ struct enetc_rx_bd_ext {
 #define ENETC4_SICTR0		0x18
 #define ENETC4_SICTR1		0x1c
 
+/* PSI SI VLAN register: per-SI VLAN tag for insertion/removal */
+#define ENETC4_PSIVLANR(a)		((a) * 0x80 + 0x2008)
+#define ENETC4_PSIVLANR_E		BIT(31)  /* enable SI VLAN processing */
+#define ENETC4_PSIVLANR_VTEA		BIT(30)  /* 0=strip tag, 1=zero VID */
+#define ENETC4_PSIVLANR_PCP(v)		(((uint32_t)(v) & 0x7) << 13)
+#define ENETC4_PSIVLANR_DEI		BIT(12)
+#define ENETC4_PSIVLANR_VID(v)		((uint32_t)(v) & 0xfff)
+
+/* PSI SI configuration register 0 */
+#define ENETC4_PSICFGR0(a)		((a) * 0x80 + 0x2010)
+#define ENETC4_PSICFGR0_SIVC_CVLAN	BIT(24)  /* allow C-VLAN 0x8100 */
+#define ENETC4_PSICFGR0_SIVIE		BIT(14)  /* SI VLAN insertion enable */
+#define ENETC4_PSICFGR0_VTE		BIT(12)  /* SI VLAN removal enable */
+
 /* general register accessors */
 #define enetc4_rd_reg(reg)	rte_read32((void *)(reg))
 #define enetc4_wr_reg(reg, val)  rte_write32((val), (void *)(reg))
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index dc5f66c0b7..6b8299c370 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -188,6 +188,8 @@ struct enetc_eth_adapter {
 enum enetc_msg_cmd_class_id {
 	ENETC_CLASS_ID_MAC_FILTER = 0x20,
 	ENETC_CLASS_ID_VLAN_FILTER = 0x21,
+	/* Configure SI VLAN isolation (insert / remove) */
+	ENETC_CLASS_ID_SI_VLAN_ISO = 0x24,
 	ENETC_CLASS_ID_LINK_STATUS = 0x80,
 	ENETC_CLASS_ID_LINK_SPEED = 0x81,
 	ENETC_CLASS_ID_GET_IP_VER = 0xF0
@@ -213,6 +215,11 @@ enum enetc_msg_cmd_id {
 	ENETC_CMD_ID_GET_IP_CFG = 4
 };
 
+/* Command IDs for class ID 0x24 (SI VLAN isolation) */
+enum enetc_msg_si_vlan_cmd_id {
+	ENETC_CMD_ID_SET_SI_VLAN_ISO = 1,
+};
+
 /* IP_VER value returned when the version is not available */
 #define ENETC_IP_VER_NOT_AVAILABLE	0xFF
 
@@ -322,6 +329,22 @@ struct enetc_msg_vlan_exact_filter {
 	uint8_t reserved2;
 };
 
+/* VSI-PSI SI VLAN isolation message (class 0x24, cmd 0x1) */
+struct enetc_msg_si_vlan_iso {
+	struct enetc_msg_cmd_header header;
+	uint8_t ctrl;          /* E[7], VTEA[6], TPID[1:0] */
+	uint8_t pcp_dei_vid_hi; /* PCP[7:5], DEI[4], VID[11:8] */
+	uint8_t vid_lo;        /* VID[7:0] */
+	uint8_t reserved_0;
+	uint8_t flags;         /* SVIE[2], VTE[1] */
+	uint8_t reserved_1[3];
+};
+
+#define ENETC_SI_VLAN_ISO_E	BIT(7)  /* ctrl: enable SI VLAN */
+#define ENETC_SI_VLAN_ISO_VTEA	BIT(6)  /* ctrl: 0=strip, 1=zero VID */
+#define ENETC_SI_VLAN_ISO_SVIE	BIT(2)  /* flags: Tx insertion enable */
+#define ENETC_SI_VLAN_ISO_VTE	BIT(1)  /* flags: Rx removal enable */
+
 struct enetc_psi_reply_msg {
 	uint8_t class_id;
 	uint8_t status;
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 5280804423..c3a5d683be 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -913,6 +913,50 @@ enetc4_dev_close(struct rte_eth_dev *dev)
 	return ret;
 }
 
+/* Configure SI-based VLAN insertion (Tx) and removal (Rx) for the PF. */
+static int
+enetc4_vlan_pvid_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t psivlanr, psicfgr0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (vlan_id > RTE_ETHER_MAX_VLAN_ID) {
+		ENETC_PMD_ERR("Invalid vlan_id = %u > %d", vlan_id,
+			      RTE_ETHER_MAX_VLAN_ID);
+		return -EINVAL;
+	}
+
+	psicfgr0 = enetc4_port_rd(enetc_hw, ENETC4_PSICFGR0(0));
+
+	if (on) {
+		/* Build the VLAN register: enable bit + VID (PCP/DEI left 0) */
+		psivlanr = (uint32_t)ENETC4_PSIVLANR_E |
+			   ENETC4_PSIVLANR_VID(vlan_id);
+		enetc4_port_wr(enetc_hw, ENETC4_PSIVLANR(0), psivlanr);
+
+		/* Allow C-VLAN TPID, enable Tx insertion and Rx removal */
+		psicfgr0 |= ENETC4_PSICFGR0_SIVC_CVLAN |
+			    ENETC4_PSICFGR0_SIVIE |
+			    ENETC4_PSICFGR0_VTE;
+		enetc4_port_wr(enetc_hw, ENETC4_PSICFGR0(0), psicfgr0);
+	} else {
+		/* Clear Tx insertion, Rx removal and C-VLAN allow bits */
+		psicfgr0 &= ~(ENETC4_PSICFGR0_SIVC_CVLAN |
+			      ENETC4_PSICFGR0_SIVIE |
+			      ENETC4_PSICFGR0_VTE);
+		enetc4_port_wr(enetc_hw, ENETC4_PSICFGR0(0), psicfgr0);
+
+		/* Clear the VLAN register (disable SI VLAN processing) */
+		enetc4_port_wr(enetc_hw, ENETC4_PSIVLANR(0), 0);
+	}
+
+	return 0;
+}
+
 static int
 enetc4_promiscuous_enable(struct rte_eth_dev *dev)
 {
@@ -1310,6 +1354,7 @@ static const struct eth_dev_ops enetc4_ops = {
 	.get_reg              = enetc4_get_regs,
 	.promiscuous_enable   = enetc4_promiscuous_enable,
 	.promiscuous_disable  = enetc4_promiscuous_disable,
+	.vlan_pvid_set        = enetc4_vlan_pvid_set,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 7e22eda149..d2999b4547 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -1532,6 +1532,101 @@ static int enetc4_vf_vlan_offload_set(struct rte_eth_dev *dev, int mask __rte_un
 	return 0;
 }
 
+/* Configure SI-based VLAN insertion/removal via VSI-PSI mailbox (class 0x24). */
+static int
+enetc4_vf_vlan_pvid_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_msg_si_vlan_iso *cmd;
+	struct enetc_msg_swbd *msg;
+	struct enetc_psi_reply_msg *reply_msg;
+	uint32_t msg_size;
+	int err = 0;
+	int vsimsgsr_pvid = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (vlan_id > RTE_ETHER_MAX_VLAN_ID) {
+		ENETC_PMD_ERR("Invalid vlan_id = %u > %d", vlan_id,
+			      RTE_ETHER_MAX_VLAN_ID);
+		return -EINVAL;
+	}
+
+	reply_msg = rte_zmalloc(NULL, sizeof(*reply_msg), RTE_CACHE_LINE_SIZE);
+	if (!reply_msg) {
+		ENETC_PMD_ERR("Failed to alloc memory for reply_msg");
+		return -ENOMEM;
+	}
+
+	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+	if (!msg) {
+		ENETC_PMD_ERR("Failed to alloc msg");
+		rte_free(reply_msg);
+		return -ENOMEM;
+	}
+
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_si_vlan_iso),
+			     ENETC_VSI_PSI_MSG_SIZE);
+	msg->vaddr = rte_zmalloc(NULL, msg_size, 0);
+	if (!msg->vaddr) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg body");
+		rte_free(msg);
+		rte_free(reply_msg);
+		return -ENOMEM;
+	}
+	msg->dma = rte_mem_virt2iova((const void *)msg->vaddr);
+	if (msg->dma == RTE_BAD_IOVA) {
+		ENETC_PMD_ERR("Failed to get IOVA for SI VLAN isolation msg body");
+		rte_free(msg->vaddr);
+		rte_free(msg);
+		rte_free(reply_msg);
+		return -ENOMEM;
+	}
+	msg->size = msg_size;
+
+	cmd = (struct enetc_msg_si_vlan_iso *)msg->vaddr;
+
+	if (on) {
+		cmd->ctrl = (uint8_t)ENETC_SI_VLAN_ISO_E;
+		cmd->pcp_dei_vid_hi = (uint8_t)((vlan_id >> 8) & 0x0f);
+		cmd->vid_lo = (uint8_t)(vlan_id & 0xff);
+		cmd->flags = (uint8_t)(ENETC_SI_VLAN_ISO_SVIE | ENETC_SI_VLAN_ISO_VTE);
+	}
+	/* on=0: all fields zero (rte_zmalloc cleared the buffer) */
+
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_SI_VLAN_ISO,
+				     ENETC_CMD_ID_SET_SI_VLAN_ISO, 0, 0, 0);
+
+	/* send the command and wait for PSI reply */
+	err = enetc4_msg_vsi_send(hw, msg, &vsimsgsr_pvid);
+	if (err) {
+		ENETC_PMD_ERR("VSI message send error for SI VLAN isolation");
+		goto end;
+	}
+
+	enetc4_msg_vsi_reply_msg(hw, vsimsgsr_pvid, reply_msg);
+
+	/*
+	 * The PSI reports command completion in the reply class_id: a
+	 * successful command returns ENETC_MSG_CLASS_ID_CMD_SUCCESS (0x1),
+	 * while any other class_id (e.g. CMD_NOT_SUPPORT 0x3) indicates a
+	 * failure. The command class value (0x24) is only used in the
+	 * outgoing VF-to-PSI header and is never echoed back in the reply,
+	 * so treat class_id != CMD_SUCCESS as failure.
+	 */
+	if (reply_msg->class_id != ENETC_MSG_CLASS_ID_CMD_SUCCESS) {
+		ENETC_PMD_ERR("SI VLAN isolation command failed: class_id=0x%x status=0x%x",
+			      reply_msg->class_id, reply_msg->status);
+		err = -EINVAL;
+	}
+
+end:
+	rte_free(msg->vaddr);
+	rte_free(msg);
+	rte_free(reply_msg);
+	return err;
+}
+
 static int
 enetc4_vf_mtu_set(struct rte_eth_dev *dev __rte_unused, uint16_t mtu __rte_unused)
 {
@@ -1696,6 +1791,7 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.link_update	      = enetc4_vf_link_update,
 	.vlan_filter_set      = enetc4_vf_vlan_filter_set,
 	.vlan_offload_set     = enetc4_vf_vlan_offload_set,
+	.vlan_pvid_set        = enetc4_vf_vlan_pvid_set,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
-- 
2.25.1

