Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA292C0219D
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 08:52:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 579B640673;
	Tue, 11 Feb 2025 09:51:08 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id B0B274066F
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:50:59 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 69E16A3A68; Tue, 11 Feb 2025 16:50:35 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v9 12/28] net/rnp: add support link update operations
Date: Tue, 11 Feb 2025 16:50:02 +0800
Message-Id: <1739263818-59770-13-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
References: <1739263818-59770-1-git-send-email-caowenbo@mucse.com>
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

This patch add support poll/irq link get mode.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
---
 doc/guides/nics/features/rnp.ini  |   2 +
 doc/guides/nics/rnp.rst           |   1 +
 drivers/net/rnp/base/rnp_fw_cmd.c |  45 ++++++++++++
 drivers/net/rnp/base/rnp_fw_cmd.h |  58 ++++++++++++++-
 drivers/net/rnp/base/rnp_hw.h     |   1 +
 drivers/net/rnp/base/rnp_mbx_fw.c |  72 ++++++++++++++++++-
 drivers/net/rnp/base/rnp_mbx_fw.h |   4 ++
 drivers/net/rnp/meson.build       |   1 +
 drivers/net/rnp/rnp.h             |  12 ++++
 drivers/net/rnp/rnp_ethdev.c      | 116 ++++++++++++++++++++++++++++--
 drivers/net/rnp/rnp_link.h        |   2 +-
 11 files changed, 305 insertions(+), 9 deletions(-)

diff --git a/doc/guides/nics/features/rnp.ini b/doc/guides/nics/features/rnp.ini
index 2fc94825f5..695b9c0dba 100644
--- a/doc/guides/nics/features/rnp.ini
+++ b/doc/guides/nics/features/rnp.ini
@@ -5,6 +5,8 @@
 ;
 [Features]
 Speed capabilities   = Y
+Link status          = Y
+Link status event    = Y
 Queue start/stop     = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
diff --git a/doc/guides/nics/rnp.rst b/doc/guides/nics/rnp.rst
index ee325b1aa4..72a7c49590 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -15,6 +15,7 @@ Features
   Receiver Side Steering (RSS) on IPv4, IPv6, IPv4-TCP/UDP/SCTP, IPv6-TCP/UDP/SCTP
   Inner RSS is only support for vxlan/nvgre
 - Promiscuous mode
+- Link state information
 
 Prerequisites
 -------------
diff --git a/drivers/net/rnp/base/rnp_fw_cmd.c b/drivers/net/rnp/base/rnp_fw_cmd.c
index 34a88a154f..c5ae7b954c 100644
--- a/drivers/net/rnp/base/rnp_fw_cmd.c
+++ b/drivers/net/rnp/base/rnp_fw_cmd.c
@@ -68,6 +68,45 @@ rnp_build_get_lane_status_req(struct rnp_mbx_fw_cmd_req *req,
 	arg->nr_lane = req_arg->param0;
 }
 
+static void
+rnp_build_set_event_mask(struct rnp_mbx_fw_cmd_req *req,
+			 struct rnp_fw_req_arg *req_arg,
+			 void *cookie)
+{
+	struct rnp_set_pf_event_mask *arg =
+		(struct rnp_set_pf_event_mask *)req->data;
+
+	req->flags = 0;
+	req->opcode = RNP_SET_EVENT_MASK;
+	req->datalen = sizeof(*arg);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+
+	arg->event_mask = req_arg->param0;
+	arg->event_en = req_arg->param1;
+}
+
+static void
+rnp_build_lane_evet_mask(struct rnp_mbx_fw_cmd_req *req,
+			 struct rnp_fw_req_arg *req_arg,
+			 void *cookie)
+{
+	struct rnp_set_lane_event_mask *arg =
+		(struct rnp_set_lane_event_mask *)req->data;
+
+	req->flags = 0;
+	req->opcode = RNP_SET_LANE_EVENT_EN;
+	req->datalen = sizeof(*arg);
+	req->cookie = cookie;
+	req->reply_lo = 0;
+	req->reply_hi = 0;
+
+	arg->nr_lane = req_arg->param0;
+	arg->event_mask = req_arg->param1;
+	arg->event_en = req_arg->param2;
+}
+
 int rnp_build_fwcmd_req(struct rnp_mbx_fw_cmd_req *req,
 			struct rnp_fw_req_arg *arg,
 			void *cookie)
@@ -87,6 +126,12 @@ int rnp_build_fwcmd_req(struct rnp_mbx_fw_cmd_req *req,
 	case RNP_GET_LANE_STATUS:
 		rnp_build_get_lane_status_req(req, arg, cookie);
 		break;
+	case RNP_SET_EVENT_MASK:
+		rnp_build_set_event_mask(req, arg, cookie);
+		break;
+	case RNP_SET_LANE_EVENT_EN:
+		rnp_build_lane_evet_mask(req, arg, cookie);
+		break;
 	default:
 		err = -EOPNOTSUPP;
 	}
diff --git a/drivers/net/rnp/base/rnp_fw_cmd.h b/drivers/net/rnp/base/rnp_fw_cmd.h
index 4d5fa10a7f..6734834644 100644
--- a/drivers/net/rnp/base/rnp_fw_cmd.h
+++ b/drivers/net/rnp/base/rnp_fw_cmd.h
@@ -6,8 +6,9 @@
 #define _RNP_FW_CMD_H_
 
 #include "rnp_osdep.h"
+#include "rnp_hw.h"
 
-#define RNP_FW_LINK_SYNC	_NIC_(0x000c)
+#define RNP_FW_LINK_SYNC	(0x000c)
 #define RNP_LINK_MAGIC_CODE	(0xa5a40000)
 #define RNP_LINK_MAGIC_MASK	RTE_GENMASK32(31, 16)
 
@@ -73,6 +74,22 @@ enum RNP_GENERIC_CMD {
 	RNP_SET_DDR_CSL			= 0xFF11,
 };
 
+struct rnp_port_stat {
+	u8 phy_addr;	     /* Phy MDIO address */
+
+	u8 duplex	: 1; /* FIBRE is always 1,Twisted Pair 1 or 0 */
+	u8 autoneg	: 1; /* autoned state */
+	u8 fec		: 1;
+	u8 an_rev	: 1;
+	u8 link_traing	: 1;
+	u8 is_sgmii	: 1; /* avild fw >= 0.5.0.17 */
+	u8 rsvd0	: 2;
+	u16 speed;	     /* cur port linked speed */
+
+	u16 pause	: 4;
+	u16 rsvd1	: 12;
+} _PACKED_ALIGN4;
+
 /* firmware -> driver reply */
 struct rnp_phy_abilities_rep {
 	u8 link_stat;
@@ -203,6 +220,19 @@ struct rnp_lane_stat_rep {
 	u32 rsvd;
 } _PACKED_ALIGN4;
 
+
+#define RNP_MBX_SYNC_MASK RTE_GENMASK32(15, 0)
+/* == flags == */
+#define RNP_FLAGS_DD  RTE_BIT32(0) /* driver clear 0, FW must set 1 */
+#define RNP_FLAGS_CMP RTE_BIT32(1) /* driver clear 0, FW mucst set */
+#define RNP_FLAGS_ERR RTE_BIT32(2) /* driver clear 0, FW must set only if it reporting an error */
+#define RNP_FLAGS_LB  RTE_BIT32(9)
+#define RNP_FLAGS_RD  RTE_BIT32(10) /* set if additional buffer has command parameters */
+#define RNP_FLAGS_BUF RTE_BIT32(12) /* set 1 on indirect command */
+#define RNP_FLAGS_SI  RTE_BIT32(13) /* not irq when command complete */
+#define RNP_FLAGS_EI  RTE_BIT32(14) /* interrupt on error */
+#define RNP_FLAGS_FE  RTE_BIT32(15) /* flush error */
+
 #define RNP_FW_REP_DATA_NUM	(40)
 struct rnp_mbx_fw_cmd_reply {
 	u16 flags;
@@ -254,6 +284,32 @@ struct rnp_get_lane_st_req {
 	u32 rsv[7];
 } _PACKED_ALIGN4;
 
+#define RNP_FW_EVENT_LINK_UP	RTE_BIT32(0)
+#define RNP_FW_EVENT_PLUG_IN	RTE_BIT32(1)
+#define RNP_FW_EVENT_PLUG_OUT	RTE_BIT32(2)
+struct rnp_set_pf_event_mask {
+	u16 event_mask;
+	u16 event_en;
+
+	u32 rsv[7];
+};
+
+struct rnp_set_lane_event_mask {
+	u32 nr_lane;
+	u8 event_mask;
+	u8 event_en;
+	u8 rsvd[26];
+};
+
+/* FW op -> driver */
+struct rnp_link_stat_req {
+	u16 changed_lanes;
+	u16 lane_status;
+#define RNP_SPEED_VALID_MAGIC	(0xa4a6a8a9)
+	u32 port_st_magic;
+	struct rnp_port_stat states[RNP_MAX_PORT_OF_PF];
+};
+
 struct rnp_mbx_fw_cmd_req {
 	u16 flags;
 	u16 opcode;
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
index 6a08df9d67..f47371ad75 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -124,6 +124,7 @@ struct rnp_hw {
 
 	spinlock_t rxq_reset_lock; /* reset op isn't thread safe */
 	spinlock_t txq_reset_lock; /* reset op isn't thread safe */
+	spinlock_t link_sync; /* link info update must be one user */
 };
 
 #endif /* __RNP_H__*/
diff --git a/drivers/net/rnp/base/rnp_mbx_fw.c b/drivers/net/rnp/base/rnp_mbx_fw.c
index a2a14472c3..070fee5d29 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.c
+++ b/drivers/net/rnp/base/rnp_mbx_fw.c
@@ -295,7 +295,7 @@ int rnp_mbx_fw_reset_phy(struct rnp_hw *hw)
 
 	memset(&arg, 0, sizeof(arg));
 	arg.opcode = RNP_RESET_PHY;
-	err = rnp_fw_send_norep_cmd(port, &arg);
+	err = rnp_fw_send_cmd(port, &arg, NULL);
 	if (err) {
 		RNP_PMD_LOG(ERR, "%s: failed. err:%d", __func__, err);
 		return err;
@@ -394,3 +394,73 @@ rnp_mbx_fw_get_lane_stat(struct rnp_eth_port *port)
 
 	return 0;
 }
+
+static void
+rnp_link_sync_init(struct rnp_hw *hw, bool en)
+{
+	RNP_E_REG_WR(hw, RNP_FW_LINK_SYNC, en ? RNP_LINK_MAGIC_CODE : 0);
+}
+
+int
+rnp_mbx_fw_pf_link_event_en(struct rnp_eth_port *port, bool en)
+{
+	struct rnp_eth_adapter *adapter = NULL;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_fw_req_arg arg;
+	int err;
+
+	adapter = hw->back;
+	memset(&arg, 0, sizeof(arg));
+	arg.opcode = RNP_SET_EVENT_MASK;
+	arg.param0 = RNP_FW_EVENT_LINK_UP;
+	arg.param1 = en ? RNP_FW_EVENT_LINK_UP : 0;
+
+	err = rnp_fw_send_norep_cmd(port, &arg);
+	if (err) {
+		RNP_PMD_LOG(ERR, "%s: failed. err:%d", __func__, err);
+		return err;
+	}
+	rnp_link_sync_init(hw, en);
+	adapter->intr_registered = en;
+	hw->fw_info.fw_irq_en = en;
+
+	return 0;
+}
+
+int
+rnp_mbx_fw_lane_link_event_en(struct rnp_eth_port *port, bool en)
+{
+	u16 nr_lane = port->attr.nr_lane;
+	struct rnp_fw_req_arg arg;
+	int err;
+
+	memset(&arg, 0, sizeof(arg));
+	arg.opcode = RNP_SET_LANE_EVENT_EN;
+	arg.param0 = nr_lane;
+	arg.param1 = RNP_FW_EVENT_LINK_UP;
+	arg.param2 = en ? RNP_FW_EVENT_LINK_UP : 0;
+
+	err = rnp_fw_send_norep_cmd(port, &arg);
+	if (err) {
+		RNP_PMD_LOG(ERR, "%s: failed. err:%d", __func__, err);
+		return err;
+	}
+
+	return 0;
+}
+
+int
+rnp_rcv_msg_from_fw(struct rnp_eth_adapter *adapter, u32 *msgbuf)
+{
+	const struct rnp_mbx_ops *ops = RNP_DEV_PP_TO_MBX_OPS(adapter->eth_dev);
+	struct rnp_hw *hw = &adapter->hw;
+	int retval;
+
+	retval = ops->read(hw, msgbuf, RNP_MBX_MSG_BLOCK_SIZE, RNP_MBX_FW);
+	if (retval) {
+		RNP_PMD_ERR("Error receiving message from FW");
+		return retval;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/rnp/base/rnp_mbx_fw.h b/drivers/net/rnp/base/rnp_mbx_fw.h
index fd0110b539..159a0237be 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.h
+++ b/drivers/net/rnp/base/rnp_mbx_fw.h
@@ -14,6 +14,10 @@ int rnp_mbx_fw_get_macaddr(struct rnp_eth_port *port, u8 *mac_addr);
 int rnp_mbx_fw_get_capability(struct rnp_eth_port *port);
 int rnp_mbx_fw_get_lane_stat(struct rnp_eth_port *port);
 int rnp_mbx_fw_reset_phy(struct rnp_hw *hw);
+int rnp_mbx_fw_pf_link_event_en(struct rnp_eth_port *port, bool en);
 int rnp_fw_init(struct rnp_hw *hw);
+int rnp_rcv_msg_from_fw(struct rnp_eth_adapter *adapter, u32 *msgbuf);
+int rnp_fw_mbx_ifup_down(struct rnp_eth_port *port, int up);
+int rnp_mbx_fw_lane_link_event_en(struct rnp_eth_port *port, bool en);
 
 #endif /* _RNP_MBX_FW_H_ */
diff --git a/drivers/net/rnp/meson.build b/drivers/net/rnp/meson.build
index a74fbe42bf..8a03f29dcd 100644
--- a/drivers/net/rnp/meson.build
+++ b/drivers/net/rnp/meson.build
@@ -16,4 +16,5 @@ sources = files(
                 'rnp_ethdev.c',
                 'rnp_rxtx.c',
                 'rnp_rss.c',
+                'rnp_link.c',
 )
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index c62204f851..c61ade7925 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -89,6 +89,11 @@ struct rnp_port_attr {
 
 	struct rnp_phy_meta phy_meta;
 
+	bool link_ready;
+	bool pre_link;
+	bool duplex;
+	uint32_t speed;
+
 	uint16_t port_id;	/* platform manage port sequence id */
 	uint8_t port_offset;	/* port queue offset */
 	uint8_t sw_id;		/* software port init sequence id */
@@ -119,6 +124,12 @@ struct rnp_eth_port {
 	bool port_stopped;
 };
 
+enum rnp_pf_op {
+	RNP_PF_OP_DONE,
+	RNP_PF_OP_CLOSING = 1,
+	RNP_PF_OP_PROCESS,
+};
+
 struct rnp_eth_adapter {
 	struct rnp_hw hw;
 	struct rte_pci_device *pdev;
@@ -126,6 +137,7 @@ struct rnp_eth_adapter {
 
 	struct rte_mempool *reset_pool;
 	struct rnp_eth_port *ports[RNP_MAX_PORT_OF_PF];
+	rte_atomic32_t pf_op;
 	uint16_t closed_ports;
 	uint16_t inited_ports;
 	bool intr_registered;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 107ce43ff0..7211793d20 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -19,6 +19,7 @@
 #include "base/rnp_mac_regs.h"
 #include "rnp_rxtx.h"
 #include "rnp_rss.h"
+#include "rnp_link.h"
 
 static struct rte_eth_dev *
 rnp_alloc_eth_port(struct rte_pci_device *pci, char *name)
@@ -51,9 +52,82 @@ rnp_alloc_eth_port(struct rte_pci_device *pci, char *name)
 	return NULL;
 }
 
+static int
+rnp_mbx_fw_reply_handler(struct rnp_eth_adapter *adapter,
+			 struct rnp_mbx_fw_cmd_reply *reply)
+{
+	struct rnp_mbx_req_cookie *cookie;
+
+	RTE_SET_USED(adapter);
+	/* dbg_here; */
+	cookie = reply->cookie;
+	if (!cookie || cookie->magic != RNP_COOKIE_MAGIC) {
+		RNP_PMD_ERR("[%s] invalid cookie:%p opcode: "
+				"0x%x v0:0x%x",
+				__func__,
+				cookie,
+				reply->opcode,
+				*((int *)reply));
+		return -EIO;
+	}
+	if (cookie->priv_len > 0)
+		rte_memcpy(cookie->priv, reply->data, cookie->priv_len);
+
+	cookie->done = 1;
+	if (reply->flags & RNP_FLAGS_ERR)
+		cookie->errcode = reply->error_code;
+	else
+		cookie->errcode = 0;
+
+	return 0;
+}
+
+static int rnp_mbx_fw_req_handler(struct rnp_eth_adapter *adapter,
+				  struct rnp_mbx_fw_cmd_req *req)
+{
+	switch (req->opcode) {
+	case RNP_LINK_STATUS_EVENT:
+		rnp_link_event(adapter, req);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int rnp_process_fw_msg(struct rnp_eth_adapter *adapter)
+{
+	const struct rnp_mbx_ops *ops = RNP_DEV_PP_TO_MBX_OPS(adapter->eth_dev);
+	uint32_t msgbuf[64];
+	struct rnp_hw *hw = &adapter->hw;
+	uint32_t msg_flag = 0;
+
+	memset(msgbuf, 0, sizeof(msgbuf));
+	/* check fw req */
+	if (!ops->check_for_msg(hw, RNP_MBX_FW)) {
+		rnp_rcv_msg_from_fw(adapter, msgbuf);
+		msg_flag = msgbuf[0] & RNP_MBX_SYNC_MASK;
+		if (msg_flag & RNP_FLAGS_DD)
+			rnp_mbx_fw_reply_handler(adapter,
+					(struct rnp_mbx_fw_cmd_reply *)msgbuf);
+		else
+			rnp_mbx_fw_req_handler(adapter,
+					(struct rnp_mbx_fw_cmd_req *)msgbuf);
+	}
+
+	return 0;
+}
+
 static void rnp_dev_interrupt_handler(void *param)
 {
-	RTE_SET_USED(param);
+	struct rnp_eth_adapter *adapter = param;
+
+	if (!rte_atomic32_cmpset((volatile uint32_t *)&adapter->pf_op,
+				RNP_PF_OP_DONE, RNP_PF_OP_PROCESS))
+		return;
+	rnp_process_fw_msg(adapter);
+	rte_atomic32_set(&adapter->pf_op, RNP_PF_OP_DONE);
 }
 
 static void rnp_mac_rx_enable(struct rte_eth_dev *dev)
@@ -221,6 +295,7 @@ static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
 	struct rte_eth_dev_data *data = eth_dev->data;
+	bool lsc = data->dev_conf.intr_conf.lsc;
 	struct rnp_hw *hw = port->hw;
 	uint16_t lane = 0;
 	uint16_t idx = 0;
@@ -249,6 +324,9 @@ static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 	if (ret)
 		goto rxq_start_failed;
 	rnp_mac_init(eth_dev);
+	rnp_mbx_fw_lane_link_event_en(port, lsc);
+	if (!lsc)
+		rnp_run_link_poll_task(port);
 	/* enable eth rx flow */
 	RNP_RX_ETH_ENABLE(hw, lane);
 	port->port_stopped = 0;
@@ -322,6 +400,7 @@ static int rnp_dev_configure(struct rte_eth_dev *eth_dev)
 static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	bool lsc = eth_dev->data->dev_conf.intr_conf.lsc;
 	struct rte_eth_link link;
 
 	if (port->port_stopped)
@@ -333,21 +412,35 @@ static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
 	/* clear the recorded link status */
 	memset(&link, 0, sizeof(link));
 	rte_eth_linkstatus_set(eth_dev, &link);
-
 	rnp_disable_all_tx_queue(eth_dev);
 	rnp_disable_all_rx_queue(eth_dev);
 	rnp_mac_tx_disable(eth_dev);
 	rnp_mac_rx_disable(eth_dev);
-
+	if (!lsc)
+		rnp_cancel_link_poll_task(port);
+	port->attr.link_ready = false;
+	port->attr.speed = 0;
 	eth_dev->data->dev_started = 0;
 	port->port_stopped = 1;
 
 	return 0;
 }
 
+static void rnp_change_manage_port(struct rnp_eth_adapter *adapter)
+{
+	uint8_t idx = 0;
+
+	adapter->eth_dev = NULL;
+	for (idx = 0; idx < adapter->inited_ports; idx++) {
+		if (adapter->ports[idx])
+			adapter->eth_dev = adapter->ports[idx]->eth_dev;
+	}
+}
+
 static int rnp_dev_close(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_adapter *adapter = RNP_DEV_TO_ADAPTER(eth_dev);
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
 	struct rte_pci_device *pci_dev;
 	int ret = 0;
 
@@ -358,6 +451,14 @@ static int rnp_dev_close(struct rte_eth_dev *eth_dev)
 	ret = rnp_dev_stop(eth_dev);
 	if (ret < 0)
 		return ret;
+	do {
+		ret = rte_atomic32_cmpset((volatile uint32_t *)&adapter->pf_op,
+				RNP_PF_OP_DONE, RNP_PF_OP_CLOSING);
+	} while (!ret);
+	adapter->closed_ports++;
+	adapter->ports[port->attr.sw_id] = NULL;
+	if (adapter->intr_registered && adapter->eth_dev == eth_dev)
+		rnp_change_manage_port(adapter);
 	if (adapter->closed_ports == adapter->inited_ports) {
 		pci_dev = RTE_DEV_TO_PCI(eth_dev->device);
 		if (adapter->intr_registered) {
@@ -371,7 +472,7 @@ static int rnp_dev_close(struct rte_eth_dev *eth_dev)
 		rnp_dma_mem_free(&adapter->hw, &adapter->hw.fw_info.mem);
 		rte_free(adapter);
 	}
-	adapter->closed_ports++;
+	rte_atomic32_set(&adapter->pf_op, RNP_PF_OP_DONE);
 
 	return 0;
 }
@@ -543,6 +644,8 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.reta_query                   = rnp_dev_rss_reta_query,
 	.rss_hash_update              = rnp_dev_rss_hash_update,
 	.rss_hash_conf_get            = rnp_dev_rss_hash_conf_get,
+	/* link impl */
+	.link_update                  = rnp_dev_link_update,
 };
 
 static void
@@ -681,6 +784,7 @@ rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 	adapter->pdev = pci_dev;
 	adapter->eth_dev = eth_dev;
 	adapter->ports[0] = port;
+	rte_atomic32_init(&adapter->pf_op);
 	hw->back = (void *)adapter;
 	port->eth_dev = eth_dev;
 	port->hw = hw;
@@ -719,6 +823,7 @@ rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 		RNP_PMD_ERR("hardware common ops setup failed");
 		goto free_ad;
 	}
+	rnp_mbx_fw_pf_link_event_en(port, false);
 	for (p_id = 0; p_id < hw->max_port_num; p_id++) {
 		/* port 0 resource has been allocated when probe */
 		if (!p_id) {
@@ -760,8 +865,7 @@ rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 	rte_intr_callback_register(intr_handle,
 			rnp_dev_interrupt_handler, adapter);
 	rte_intr_enable(intr_handle);
-	adapter->intr_registered = true;
-	hw->fw_info.fw_irq_en = true;
+	rnp_mbx_fw_pf_link_event_en(port, true);
 
 	return 0;
 
diff --git a/drivers/net/rnp/rnp_link.h b/drivers/net/rnp/rnp_link.h
index f0705f17da..8c2a3cbd59 100644
--- a/drivers/net/rnp/rnp_link.h
+++ b/drivers/net/rnp/rnp_link.h
@@ -10,7 +10,7 @@
 #define RNP_LINK_NOCHANGED(lane_bit, change_lane) \
 	(!((RTE_BIT32(lane_bit)) & (change_lane)))
 #define RNP_LINK_DUPLEX_ATTR_EN		(0xA0000000)
-#define RNP_SPEED_META_VALID(magic)	(!!(magic) == 0xA0000000)
+#define RNP_SPEED_META_VALID(magic)	(!!((magic) == 0xA0000000))
 #define RNP_LINK_STATE(n)		RTE_BIT32(n)
 #define RNP_LINK_SPEED_CODE(sp, n) \
 	(((sp) & RTE_GENMASK32((11) + ((4) * (n)), \
-- 
2.34.1

