Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E372C021AB
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Feb 2025 07:59:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF47040B99;
	Wed, 19 Feb 2025 08:57:56 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 344B740DF8
 for <dev@dpdk.org>; Wed, 19 Feb 2025 08:57:48 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 7E844AE85B; Wed, 19 Feb 2025 15:57:47 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net, Wenbo Cao <caowenbo@mucse.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v13 12/28] net/rnp: add support link update operations
Date: Wed, 19 Feb 2025 15:57:13 +0800
Message-Id: <1739951849-67601-13-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
References: <1739951849-67601-1-git-send-email-caowenbo@mucse.com>
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
 doc/guides/nics/rnp.rst           |   3 +
 drivers/net/rnp/base/rnp_fw_cmd.c |  45 ++++
 drivers/net/rnp/base/rnp_fw_cmd.h |  55 +++++
 drivers/net/rnp/base/rnp_hw.h     |   2 +-
 drivers/net/rnp/base/rnp_mbx_fw.c |  72 ++++++-
 drivers/net/rnp/base/rnp_mbx_fw.h |   4 +
 drivers/net/rnp/meson.build       |   1 +
 drivers/net/rnp/rnp.h             |  12 ++
 drivers/net/rnp/rnp_ethdev.c      | 116 +++++++++-
 drivers/net/rnp/rnp_link.c        | 340 ++++++++++++++++++++++++++++++
 drivers/net/rnp/rnp_link.h        |  50 +++++
 12 files changed, 695 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/rnp/rnp_link.c
 create mode 100644 drivers/net/rnp/rnp_link.h

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
index 90af73d71f..e6a1aadefc 100644
--- a/doc/guides/nics/rnp.rst
+++ b/doc/guides/nics/rnp.rst
@@ -49,6 +49,7 @@ Features
   Receiver Side Steering (RSS) on IPv4, IPv6, IPv4-TCP/UDP/SCTP, IPv6-TCP/UDP/SCTP
   Inner RSS is only support for vxlan/nvgre
 - Promiscuous mode
+- Link state information
 
 Prerequisites and Pre-conditions
 --------------------------------
@@ -92,3 +93,5 @@ Listed below are the rte_eth functions supported:
 * ``rte_eth_allmulticast_get``
 * ``rte_eth_rx_queue_setup``
 * ``rte_eth_tx_queue_setup``
+* ``rte_eth_link_get``
+* ``rte_eth_link_get_nowait``
diff --git a/drivers/net/rnp/base/rnp_fw_cmd.c b/drivers/net/rnp/base/rnp_fw_cmd.c
index 3891249499..a4a2171868 100644
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
index 5f60ac6187..6c6fd1803e 100644
--- a/drivers/net/rnp/base/rnp_fw_cmd.h
+++ b/drivers/net/rnp/base/rnp_fw_cmd.h
@@ -6,6 +6,7 @@
 #define _RNP_FW_CMD_H_
 
 #include "rnp_osdep.h"
+#include "rnp_hw.h"
 
 #define RNP_FW_LINK_SYNC	(0x000c)
 #define RNP_LINK_MAGIC_CODE	(0xa5a40000)
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
+};
+
 /* firmware -> driver reply */
 struct __rte_aligned(4) __rte_packed_begin rnp_phy_abilities_rep {
 	u8 link_stat;
@@ -203,6 +220,18 @@ struct rnp_lane_stat_rep {
 	u32 rsvd;
 };
 
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
@@ -254,6 +283,32 @@ struct rnp_get_lane_st_req {
 	u32 rsv[7];
 };
 
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
index 548e3a4468..db671b1bfa 100644
--- a/drivers/net/rnp/base/rnp_hw.h
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -124,7 +124,7 @@ struct rnp_hw {
 
 	spinlock_t rxq_reset_lock; /* reset op isn't thread safe */
 	spinlock_t txq_reset_lock; /* reset op isn't thread safe */
-
+	spinlock_t link_sync; /* link info update must be one user */
 };
 
 #endif /* _RNP_HW_H_ */
diff --git a/drivers/net/rnp/base/rnp_mbx_fw.c b/drivers/net/rnp/base/rnp_mbx_fw.c
index f77542f835..d4aa4a1626 100644
--- a/drivers/net/rnp/base/rnp_mbx_fw.c
+++ b/drivers/net/rnp/base/rnp_mbx_fw.c
@@ -292,7 +292,7 @@ int rnp_mbx_fw_reset_phy(struct rnp_hw *hw)
 
 	memset(&arg, 0, sizeof(arg));
 	arg.opcode = RNP_RESET_PHY;
-	err = rnp_fw_send_norep_cmd(port, &arg);
+	err = rnp_fw_send_cmd(port, &arg, NULL);
 	if (err) {
 		RNP_PMD_LOG(ERR, "%s: failed. err:%d", __func__, err);
 		return err;
@@ -388,3 +388,73 @@ rnp_mbx_fw_get_lane_stat(struct rnp_eth_port *port)
 
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
index e20cc88497..12c54b1414 100644
--- a/drivers/net/rnp/meson.build
+++ b/drivers/net/rnp/meson.build
@@ -23,4 +23,5 @@ sources = files(
         'rnp_ethdev.c',
         'rnp_rxtx.c',
         'rnp_rss.c',
+        'rnp_link.c',
 )
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 17a6309632..7322cba69b 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -92,6 +92,11 @@ struct rnp_port_attr {
 
 	struct rnp_phy_meta phy_meta;
 
+	bool link_ready;
+	bool pre_link;
+	bool duplex;
+	uint32_t speed;
+
 	uint16_t port_id;	/* platform manage port sequence id */
 	uint8_t port_offset;	/* port queue offset */
 	uint8_t sw_id;		/* software port init sequence id */
@@ -122,6 +127,12 @@ struct rnp_eth_port {
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
@@ -129,6 +140,7 @@ struct rnp_eth_adapter {
 
 	struct rte_mempool *reset_pool;
 	struct rnp_eth_port *ports[RNP_MAX_PORT_OF_PF];
+	RTE_ATOMIC(uint16_t) pf_op;
 	uint16_t closed_ports;
 	uint16_t inited_ports;
 	bool intr_registered;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index 75bc57746c..eadff7c3f8 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -19,6 +19,7 @@
 #include "base/rnp_mac_regs.h"
 #include "rnp_rxtx.h"
 #include "rnp_rss.h"
+#include "rnp_link.h"
 
 static struct rte_eth_dev *
 rnp_alloc_eth_port(struct rte_pci_device *pci, char *name)
@@ -51,9 +52,81 @@ rnp_alloc_eth_port(struct rte_pci_device *pci, char *name)
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
+		RNP_PMD_ERR("invalid cookie:%p opcode:0x%x v0:0x%x",
+				cookie, reply->opcode, *((int *)reply));
+		return -EIO;
+	}
+	if (cookie->priv_len > 0)
+		memcpy(cookie->priv, reply->data, cookie->priv_len);
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
+	uint8_t msgbuf[64];
+	struct rnp_hw *hw = &adapter->hw;
+	uint16_t msg_flag = 0;
+
+	memset(msgbuf, 0, sizeof(msgbuf));
+	/* check fw req */
+	if (!ops->check_for_msg(hw, RNP_MBX_FW)) {
+		rnp_rcv_msg_from_fw(adapter, (uint32_t *)msgbuf);
+		msg_flag = msgbuf[0] | msgbuf[1];
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
+	uint16_t exp = RNP_PF_OP_DONE;
+
+	if (!rte_atomic_compare_exchange_strong_explicit(&adapter->pf_op, &exp,
+			RNP_PF_OP_PROCESS, rte_memory_order_acquire,
+			rte_memory_order_acquire))
+		return;
+	rnp_process_fw_msg(adapter);
+	rte_atomic_store_explicit(&adapter->pf_op, RNP_PF_OP_DONE,
+			rte_memory_order_release);
 }
 
 static void rnp_mac_rx_enable(struct rte_eth_dev *dev)
@@ -221,6 +294,7 @@ static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
 	struct rte_eth_dev_data *data = eth_dev->data;
+	bool lsc = data->dev_conf.intr_conf.lsc;
 	struct rnp_hw *hw = port->hw;
 	uint16_t lane = 0;
 	uint16_t idx = 0;
@@ -249,6 +323,9 @@ static int rnp_dev_start(struct rte_eth_dev *eth_dev)
 	if (ret)
 		goto rxq_start_failed;
 	rnp_mac_init(eth_dev);
+	rnp_mbx_fw_lane_link_event_en(port, lsc);
+	if (!lsc)
+		rnp_run_link_poll_task(port);
 	/* enable eth rx flow */
 	RNP_RX_ETH_ENABLE(hw, lane);
 	port->port_stopped = 0;
@@ -323,6 +400,7 @@ static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
 {
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
 	const struct rte_eth_dev_data *data = eth_dev->data;
+	bool lsc = eth_dev->data->dev_conf.intr_conf.lsc;
 	struct rte_eth_link link;
 	int ret;
 
@@ -335,7 +413,6 @@ static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
 	/* clear the recorded link status */
 	memset(&link, 0, sizeof(link));
 	rte_eth_linkstatus_set(eth_dev, &link);
-
 	ret = rnp_disable_all_tx_queue(eth_dev);
 	if (ret < 0) {
 		RNP_PMD_ERR("port[%u] disable tx queue failed", data->port_id);
@@ -348,6 +425,10 @@ static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
 	}
 	rnp_mac_tx_disable(eth_dev);
 	rnp_mac_rx_disable(eth_dev);
+	if (!lsc)
+		rnp_cancel_link_poll_task(port);
+	port->attr.link_ready = false;
+	port->attr.speed = 0;
 
 	eth_dev->data->dev_started = 0;
 	port->port_stopped = 1;
@@ -355,9 +436,22 @@ static int rnp_dev_stop(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+static void rnp_change_manage_port(struct rnp_eth_adapter *adapter)
+{
+	uint16_t idx = 0;
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
+	uint16_t exp = RNP_PF_OP_DONE;
 	int ret = 0;
 
 	PMD_INIT_FUNC_TRACE();
@@ -367,6 +461,15 @@ static int rnp_dev_close(struct rte_eth_dev *eth_dev)
 	ret = rnp_dev_stop(eth_dev);
 	if (ret < 0)
 		return ret;
+	do {
+		ret = rte_atomic_compare_exchange_strong_explicit(&adapter->pf_op,
+				&exp, RNP_PF_OP_CLOSING, rte_memory_order_acquire,
+				rte_memory_order_acquire);
+	} while (!ret);
+	adapter->closed_ports++;
+	adapter->ports[port->attr.sw_id] = NULL;
+	if (adapter->intr_registered && adapter->eth_dev == eth_dev)
+		rnp_change_manage_port(adapter);
 	if (adapter->closed_ports == adapter->inited_ports) {
 		struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(eth_dev->device);
 		if (adapter->intr_registered) {
@@ -380,7 +483,8 @@ static int rnp_dev_close(struct rte_eth_dev *eth_dev)
 		rnp_dma_mem_free(&adapter->hw, &adapter->hw.fw_info.mem);
 		rte_free(adapter);
 	}
-	adapter->closed_ports++;
+	rte_atomic_store_explicit(&adapter->pf_op, RNP_PF_OP_DONE,
+			rte_memory_order_release);
 
 	return 0;
 }
@@ -553,6 +657,8 @@ static const struct eth_dev_ops rnp_eth_dev_ops = {
 	.reta_query                   = rnp_dev_rss_reta_query,
 	.rss_hash_update              = rnp_dev_rss_hash_update,
 	.rss_hash_conf_get            = rnp_dev_rss_hash_conf_get,
+	/* link impl */
+	.link_update                  = rnp_dev_link_update,
 };
 
 static void
@@ -729,6 +835,7 @@ rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 		RNP_PMD_ERR("hardware common ops setup failed");
 		goto free_ad;
 	}
+	rnp_mbx_fw_pf_link_event_en(port, false);
 	for (p_id = 0; p_id < hw->max_port_num; p_id++) {
 		/* port 0 resource has been allocated when probe */
 		if (!p_id) {
@@ -771,8 +878,7 @@ rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 	rte_intr_callback_register(intr_handle,
 			rnp_dev_interrupt_handler, adapter);
 	rte_intr_enable(intr_handle);
-	adapter->intr_registered = true;
-	hw->fw_info.fw_irq_en = true;
+	rnp_mbx_fw_pf_link_event_en(port, true);
 
 	return 0;
 
diff --git a/drivers/net/rnp/rnp_link.c b/drivers/net/rnp/rnp_link.c
new file mode 100644
index 0000000000..7a3b137dff
--- /dev/null
+++ b/drivers/net/rnp/rnp_link.c
@@ -0,0 +1,340 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include <rte_alarm.h>
+
+#include "base/rnp_mac_regs.h"
+#include "base/rnp_dma_regs.h"
+#include "base/rnp_mac.h"
+#include "base/rnp_fw_cmd.h"
+#include "base/rnp_mbx_fw.h"
+
+#include "rnp.h"
+#include "rnp_rxtx.h"
+#include "rnp_link.h"
+
+static void
+rnp_link_flow_setup(struct rnp_eth_port *port)
+{
+	struct rnp_hw *hw = port->hw;
+	u32 ctrl = 0;
+	u16 lane = 0;
+
+	lane = port->attr.nr_lane;
+	rte_spinlock_lock(&port->rx_mac_lock);
+	ctrl = RNP_MAC_REG_RD(hw, lane, RNP_MAC_RX_CFG);
+	if (port->attr.link_ready) {
+		ctrl &= ~RNP_MAC_LM;
+		RNP_RX_ETH_ENABLE(hw, lane);
+	} else {
+		RNP_RX_ETH_DISABLE(hw, lane);
+		ctrl |= RNP_MAC_LM;
+	}
+	RNP_MAC_REG_WR(hw, lane, RNP_MAC_RX_CFG, ctrl);
+	rte_spinlock_unlock(&port->rx_mac_lock);
+}
+
+static uint64_t
+rnp_parse_speed_code(uint32_t speed_code)
+{
+	uint32_t speed = 0;
+
+	switch (speed_code) {
+	case RNP_LANE_SPEED_10M:
+		speed = RTE_ETH_SPEED_NUM_10M;
+		break;
+	case RNP_LANE_SPEED_100M:
+		speed = RTE_ETH_SPEED_NUM_100M;
+		break;
+	case RNP_LANE_SPEED_1G:
+		speed = RTE_ETH_SPEED_NUM_1G;
+		break;
+	case RNP_LANE_SPEED_10G:
+		speed = RTE_ETH_SPEED_NUM_10G;
+		break;
+	case RNP_LANE_SPEED_25G:
+		speed = RTE_ETH_SPEED_NUM_25G;
+		break;
+	case RNP_LANE_SPEED_40G:
+		speed = RTE_ETH_SPEED_NUM_40G;
+		break;
+	default:
+		speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+	}
+
+	return speed;
+}
+
+static bool
+rnp_update_speed_changed(struct rnp_eth_port *port)
+{
+	struct rnp_hw *hw = port->hw;
+	uint32_t speed_code = 0;
+	bool speed_changed = 0;
+	bool duplex = false;
+	uint32_t magic = 0;
+	uint32_t linkstate;
+	uint64_t speed = 0;
+	uint16_t lane = 0;
+
+	lane = port->attr.nr_lane;
+	linkstate = RNP_E_REG_RD(hw, RNP_DEVICE_LINK_EX);
+	magic = linkstate & 0xF0000000;
+	/* check if speed is changed. even if link is not changed */
+	if (RNP_SPEED_META_VALID(magic) &&
+			(linkstate & RNP_LINK_STATE(lane))) {
+		speed_code = rnpce_link_speed_code(linkstate, lane);
+		speed = rnp_parse_speed_code(speed_code);
+		if (speed != port->attr.speed) {
+			duplex = RNP_LINK_DUPLEX_STATE(linkstate, lane);
+			port->attr.phy_meta.link_duplex = duplex;
+			port->attr.speed = speed;
+			speed_changed = 1;
+		}
+	}
+
+	return speed_changed;
+}
+
+static bool
+rnp_update_link_changed(struct rnp_eth_port *port,
+			struct rnp_link_stat_req *link)
+{
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	uint32_t link_up_bit = 0;
+	bool link_changed = 0;
+	uint32_t sync_bit = 0;
+	bool duplex = 0;
+
+	link_up_bit = link->lane_status & RTE_BIT32(lane);
+	sync_bit = RNP_E_REG_RD(hw, RNP_FW_LINK_SYNC);
+	lane = port->attr.nr_lane;
+	if (link_up_bit) {
+		/* port link down to up */
+		if (!port->attr.link_ready)
+			link_changed = true;
+		port->attr.link_ready = true;
+		if (link->port_st_magic == RNP_SPEED_VALID_MAGIC) {
+			port->attr.speed = link->states[lane].speed;
+			duplex = link->states[lane].duplex;
+			port->attr.duplex = duplex;
+			RNP_PMD_INFO("phy_id %d speed %d duplex "
+					"%d issgmii %d PortID %d",
+					link->states[lane].phy_addr,
+					link->states[lane].speed,
+					link->states[lane].duplex,
+					link->states[lane].is_sgmii,
+					port->attr.port_id);
+		}
+	} else {
+		/* port link to down */
+		if (port->attr.link_ready)
+			link_changed = true;
+		port->attr.link_ready = false;
+	}
+	if (!link_changed && sync_bit != link_up_bit)
+		link_changed = 1;
+
+	return link_changed;
+}
+
+static void rnp_link_stat_sync_mark(struct rnp_hw *hw, int lane, int up)
+{
+	uint32_t sync;
+
+	rte_spinlock_lock(&hw->link_sync);
+	sync = RNP_E_REG_RD(hw, RNP_FW_LINK_SYNC);
+	sync &= ~RNP_LINK_MAGIC_MASK;
+	sync |= RNP_LINK_MAGIC_CODE;
+	if (up)
+		sync |= RTE_BIT32(lane);
+	else
+		sync &= ~RTE_BIT32(lane);
+	RNP_E_REG_WR(hw, RNP_FW_LINK_SYNC, sync);
+	rte_spinlock_unlock(&hw->link_sync);
+}
+
+static void rnp_link_report(struct rnp_eth_port *port, bool link_en)
+{
+	struct rte_eth_dev_data *data = port->eth_dev->data;
+	struct rnp_hw *hw = port->hw;
+	struct rnp_rx_queue *rxq;
+	struct rnp_tx_queue *txq;
+	struct rte_eth_link link;
+	uint16_t idx;
+
+	if (data == NULL)
+		return;
+	for (idx = 0; idx < data->nb_rx_queues; idx++) {
+		rxq = data->rx_queues[idx];
+		if (!rxq)
+			continue;
+		rxq->rx_link = link_en;
+	}
+	for (idx = 0; idx < data->nb_tx_queues; idx++) {
+		txq = data->tx_queues[idx];
+		if (!txq)
+			continue;
+		txq->tx_link = link_en;
+	}
+	/* set default link info */
+	link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+	link.link_status = RTE_ETH_LINK_DOWN;
+	link.link_autoneg = RTE_ETH_LINK_FIXED;
+	if (link_en) {
+		link.link_duplex = port->attr.phy_meta.link_duplex;
+		link.link_speed = port->attr.speed;
+		link.link_status = link_en;
+	}
+	link.link_autoneg = port->attr.phy_meta.link_autoneg;
+	RNP_PMD_LOG(INFO, "PF[%d]link changed: changed_lane:0x%x, "
+			"status:0x%x",
+			hw->mbx.pf_num,
+			port->attr.nr_lane,
+			link_en);
+	/* report link info to upper firmwork */
+	rte_eth_linkstatus_set(port->eth_dev, &link);
+	/* notice event process link status change */
+	rte_eth_dev_callback_process(port->eth_dev, RTE_ETH_EVENT_INTR_LSC, NULL);
+	/* notice firmware LSC event sw received */
+	rnp_link_stat_sync_mark(hw, port->attr.nr_lane, link_en);
+}
+
+static void rnp_dev_alarm_link_handler(void *param)
+{
+	struct rnp_eth_port *port = param;
+	uint32_t status;
+
+	if (port == NULL || port->eth_dev == NULL)
+		return;
+	status = port->attr.link_ready;
+	rnp_link_report(port, status);
+}
+
+void rnp_link_event(struct rnp_eth_adapter *adapter,
+		    struct rnp_mbx_fw_cmd_req *req)
+{
+	struct rnp_link_stat_req *link = (struct rnp_link_stat_req *)req->data;
+	struct rnp_hw *hw = &adapter->hw;
+	struct rnp_eth_port *port = NULL;
+	bool speed_changed;
+	bool link_changed;
+	uint32_t lane;
+	uint8_t i = 0;
+
+	/* get real-time link && speed info */
+	for (i = 0; i < hw->max_port_num; i++) {
+		port = adapter->ports[i];
+		if (port == NULL)
+			continue;
+		speed_changed = false;
+		link_changed = false;
+		lane = port->attr.nr_lane;
+		if (RNP_LINK_NOCHANGED(lane, link->changed_lanes)) {
+			speed_changed = rnp_update_speed_changed(port);
+			if (!speed_changed)
+				continue;
+		}
+		link_changed = rnp_update_link_changed(port, link);
+		if (link_changed || speed_changed) {
+			rnp_link_flow_setup(port);
+			rte_eal_alarm_set(RNP_ALARM_INTERVAL,
+					rnp_dev_alarm_link_handler,
+					(void *)port);
+		}
+	}
+}
+
+int rnp_dev_link_update(struct rte_eth_dev *eth_dev,
+			int wait_to_complete)
+{
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
+	struct rnp_phy_meta *phy_meta = &port->attr.phy_meta;
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	struct rte_eth_link link;
+	uint32_t status;
+
+	PMD_INIT_FUNC_TRACE();
+	memset(&link, 0, sizeof(link));
+	if (wait_to_complete && rte_eal_process_type() == RTE_PROC_PRIMARY)
+		rnp_mbx_fw_get_lane_stat(port);
+	status = port->attr.link_ready;
+	link.link_duplex = phy_meta->link_duplex;
+	link.link_status = status ? RTE_ETH_LINK_UP : RTE_ETH_LINK_DOWN;
+	if (link.link_status)
+		link.link_speed = port->attr.speed;
+	link.link_autoneg = phy_meta->link_autoneg ?
+		RTE_ETH_LINK_AUTONEG : RTE_ETH_LINK_FIXED;
+	rnp_link_stat_sync_mark(hw, lane, link.link_status);
+	rte_eth_linkstatus_set(eth_dev, &link);
+
+	return 0;
+}
+
+static void rnp_dev_link_task(void *param)
+{
+	struct rte_eth_dev *dev = (struct rte_eth_dev *)param;
+	struct rnp_eth_port *port = RNP_DEV_TO_PORT(dev);
+	uint16_t lane = port->attr.nr_lane;
+	struct rnp_hw *hw = port->hw;
+	bool speed_changed = false;
+	bool link_changed = false;
+	bool duplex_attr = false;
+	uint32_t speed_code = 0;
+	uint32_t link_state;
+	bool duplex = false;
+	uint32_t speed = 0;
+
+	link_state = RNP_E_REG_RD(hw, RNP_DEVICE_LINK_EX);
+	if (link_state & RNP_LINK_DUPLEX_ATTR_EN)
+		duplex_attr = true;
+	else
+		link_state = RNP_E_REG_RD(hw, RNP_DEVICE_LINK);
+	if (link_state & RNP_LINK_STATE(lane)) {
+		/* Port link change to up */
+		speed_code = rnpce_link_speed_code(link_state, lane);
+		speed = rnp_parse_speed_code(speed_code);
+		if (duplex_attr) {
+			duplex = RNP_LINK_DUPLEX_STATE(link_state, lane);
+			port->attr.phy_meta.link_duplex = duplex;
+		}
+		port->attr.speed = speed;
+		port->attr.pre_link = port->attr.link_ready;
+		port->attr.link_ready = true;
+	} else {
+		/* Port link to down */
+		port->attr.speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+		port->attr.pre_link = port->attr.link_ready;
+		port->attr.link_ready = false;
+	}
+	if (port->attr.pre_link != port->attr.link_ready)
+		link_changed = true;
+	if (!link_changed)
+		speed_changed = rnp_update_speed_changed(port);
+	if (link_changed || speed_changed) {
+		if (!duplex_attr)
+			rnp_mbx_fw_get_lane_stat(port);
+		rnp_link_flow_setup(port);
+		rnp_link_report(port, port->attr.link_ready);
+	}
+	rte_eal_alarm_set(RNP_ALARM_INTERVAL,
+			rnp_dev_link_task,
+			(void *)dev);
+}
+
+void
+rnp_run_link_poll_task(struct rnp_eth_port *port)
+{
+	rte_eal_alarm_set(RNP_ALARM_INTERVAL, rnp_dev_link_task,
+			(void *)port->eth_dev);
+}
+
+void
+rnp_cancel_link_poll_task(struct rnp_eth_port *port)
+{
+	rte_eal_alarm_cancel(rnp_dev_link_task, port->eth_dev);
+}
diff --git a/drivers/net/rnp/rnp_link.h b/drivers/net/rnp/rnp_link.h
new file mode 100644
index 0000000000..e59b7bf120
--- /dev/null
+++ b/drivers/net/rnp/rnp_link.h
@@ -0,0 +1,50 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_LINK_H_
+#define _RNP_LINK_H_
+
+#define RNP_DEVICE_LINK		(0x3000c)
+#define RNP_DEVICE_LINK_EX	(0xa800 + 64 * 64 - 4)
+#define RNP_LINK_NOCHANGED(lane_bit, change_lane) \
+	(!((RTE_BIT32(lane_bit)) & (change_lane)))
+#define RNP_LINK_DUPLEX_ATTR_EN		(0xA0000000)
+#define RNP_SPEED_META_VALID(magic)	(!!((magic) == UINT32_C(0xA0000000)))
+#define RNP_LINK_STATE(n)		RTE_BIT32(n)
+#define RNP_LINK_DUPLEX_STATE(sp, n)	((sp) & RTE_BIT32((24) + (n)))
+#define RNP_ALARM_INTERVAL	(50000) /* unit us */
+enum rnp_lane_speed {
+	RNP_LANE_SPEED_10M = 0,
+	RNP_LANE_SPEED_100M,
+	RNP_LANE_SPEED_1G,
+	RNP_LANE_SPEED_10G,
+	RNP_LANE_SPEED_25G,
+	RNP_LANE_SPEED_40G,
+};
+
+#define RNP_SPEED_CODE_S(n)             ((8) + ((4) * (n)))
+#define RNP_SPEED_CODE_START(n)         ((8) + ((4) * (n)))
+#define RNP_SPEED_CODE_END(n)           ((11) + ((4) * (n)))
+static inline uint32_t
+rnpce_link_speed_code(uint32_t link_state, uint16_t lane_id)
+{
+	uint32_t start, end;
+	uint32_t speed_code;
+
+	start = RNP_SPEED_CODE_START(lane_id);
+	end = RNP_SPEED_CODE_END(lane_id);
+	link_state &= RTE_GENMASK32(end, start);
+	speed_code = link_state >> RNP_SPEED_CODE_S(lane_id);
+
+	return speed_code;
+}
+
+void rnp_link_event(struct rnp_eth_adapter *adapter,
+		    struct rnp_mbx_fw_cmd_req *req);
+int rnp_dev_link_update(struct rte_eth_dev *eth_dev,
+			int wait_to_complete);
+void rnp_run_link_poll_task(struct rnp_eth_port *port);
+void rnp_cancel_link_poll_task(struct rnp_eth_port *port);
+
+#endif /* _RNP_LINK_H_ */
-- 
2.25.1

