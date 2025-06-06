Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66447C5B549
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Jun 2025 08:01:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5538B4042E;
	Fri,  6 Jun 2025 10:01:53 +0200 (CEST)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id EEB55400EF
 for <dev@dpdk.org>; Fri,  6 Jun 2025 10:01:49 +0200 (CEST)
X-QQ-mid: zesmtpsz2t1749196904t76a42261
X-QQ-Originating-IP: NSKzl5LONXlRFYEFNQ4EvIAasnAyWvpOLd63fSUtc+c=
Received: from w-MS-7E16.trustnetic.com ( [220.184.249.46])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Fri, 06 Jun 2025 16:01:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2459876505805271072
EX-QQ-RecipientCnt: 3
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH 01/12] net/txgbe: support flow filter for VF
Date: Fri,  6 Jun 2025 16:01:06 +0800
Message-ID: <866CBBA4EA9DD587+20250606080117.183198-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606080117.183198-1-jiawenwu@trustnetic.com>
References: <20250606080117.183198-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N2K7JO7TcIoEcRf6mJY1Y1xN8d4tqMWLOTY9Uv5FXvq++dTzoGE89rLJ
 g15GwUvHAH0u0L+j/NChz3Kxob9grer5BpSTzuZybiSGYEYBW+2JcMoBLrZlt5cVy/C+o/l
 x5gHhtvTnERslhm3YUyqPGYf2wno7mIg42rbPTfL7/v0sB2qlvxvDc3lWPpK7XNAGlV8lt1
 vSdxvMx6xweAP/9vGjep0Nb2ot+qJY+iNITOjIqDeEEhlpvcloiRS+yLti9Dm1ZV8GT/ay+
 pr1tJeAwX/Wm9wycWm6dux9NHHVSgcwgf7WnfYdLWrmkCFeb0FR42xvcSHnZ/eu176UKOhy
 KsOwJ/Yyx1H8I8Czk+VzSDHiXTic1xy0+y1DWCv1ACsLsBRmZ0AnEK6lg3vZ0fU6tRgi8+R
 TDXFO1PpIi5FzM3mafSt+QBZZDVygeToRS5ZgO4uidkCeUNMBdjZ9yKRTNXmuznkonKU3w7
 lHr3aWhRhNaCuNmhsaFKPCyfAb6LKmXiRUbcsTzrLJYc2FBkohFWxMfjGHGhMuRQSPxGnyq
 /DHFnUsg7KLuncJ20bTnl7NQ97jhVRx03nk+hGI4ieY4xJkiQ10xqTMUzaepdKlvAm+3z1w
 BFfhcA+llzRIo/sdP35pf0fKb7wye6QfKr9D9P2lk6oWSi9y8Vb6yia3IgcgrV3Pd7X4CEN
 pQ7TLiK6hU9LAqNNSZOGReX64pfYYOYew2g1h/H5rAltevskpesGNsgVTH05HGZJ/tmHojM
 14HFTCYiqFNXPzX1mB0DLJHLtU6Ej9E5ASegv0Jb+ndbHZ09NcIKZwWJR+AbMbkvHEowzE8
 nJz9Zxfm3soLy7JdIKOREuIYp0emoOBoFwW1kuhC72XeAOg8m/2Tak1UUzCDITz6CqQD4QT
 felWDbhBtlupzQt2M5+R4oXmiBYjwYN67llfHJMAWi4yN3s37kSzpH/qcG9WIjfQT29ta0o
 XFn79ow+jZh9aibXVgG3NmAUIBT550Ig3jfPslaxLOp5aweDdzUBbb/yrFCUeYLCUiJH20/
 yiXF0yfl5J/wqxuZWZ
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0
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

Add 5-tuple filter for VF driver, which request PF driver to write the
hardware configurations. So add new PF-VF mailbox API version 2.1 to
implement it.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_hw.c   | 10 ++++
 drivers/net/txgbe/base/txgbe_hw.h   |  1 +
 drivers/net/txgbe/base/txgbe_mbx.h  | 17 ++++++
 drivers/net/txgbe/base/txgbe_vf.c   | 29 +++++++++++
 drivers/net/txgbe/base/txgbe_vf.h   |  2 +
 drivers/net/txgbe/txgbe_ethdev.c    | 12 ++++-
 drivers/net/txgbe/txgbe_ethdev.h    |  5 ++
 drivers/net/txgbe/txgbe_ethdev_vf.c | 80 +++++++++++++++++++++++++++++
 drivers/net/txgbe/txgbe_flow.c      | 10 ++++
 9 files changed, 164 insertions(+), 2 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_hw.c b/drivers/net/txgbe/base/txgbe_hw.c
index dd5d3ea1fe..ae2ad87c83 100644
--- a/drivers/net/txgbe/base/txgbe_hw.c
+++ b/drivers/net/txgbe/base/txgbe_hw.c
@@ -2485,6 +2485,16 @@ s32 txgbe_init_shared_code(struct txgbe_hw *hw)
 	return status;
 }
 
+bool txgbe_is_pf(struct txgbe_hw *hw)
+{
+	switch (hw->mac.type) {
+	case txgbe_mac_raptor:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /**
  *  txgbe_set_mac_type - Sets MAC type
  *  @hw: pointer to the HW structure
diff --git a/drivers/net/txgbe/base/txgbe_hw.h b/drivers/net/txgbe/base/txgbe_hw.h
index 1ed2892f61..7a45020824 100644
--- a/drivers/net/txgbe/base/txgbe_hw.h
+++ b/drivers/net/txgbe/base/txgbe_hw.h
@@ -85,6 +85,7 @@ void txgbe_set_mta(struct txgbe_hw *hw, u8 *mc_addr);
 s32 txgbe_negotiate_fc(struct txgbe_hw *hw, u32 adv_reg, u32 lp_reg,
 			u32 adv_sym, u32 adv_asm, u32 lp_sym, u32 lp_asm);
 s32 txgbe_init_shared_code(struct txgbe_hw *hw);
+bool txgbe_is_pf(struct txgbe_hw *hw);
 s32 txgbe_set_mac_type(struct txgbe_hw *hw);
 s32 txgbe_init_ops_pf(struct txgbe_hw *hw);
 s32 txgbe_get_link_capabilities_raptor(struct txgbe_hw *hw,
diff --git a/drivers/net/txgbe/base/txgbe_mbx.h b/drivers/net/txgbe/base/txgbe_mbx.h
index 894ad6a2f7..31e2d51658 100644
--- a/drivers/net/txgbe/base/txgbe_mbx.h
+++ b/drivers/net/txgbe/base/txgbe_mbx.h
@@ -38,6 +38,7 @@ enum txgbe_pfvf_api_rev {
 	txgbe_mbox_api_12,	/* API version 1.2, linux/freebsd VF driver */
 	txgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
 	txgbe_mbox_api_20,	/* API version 2.0, solaris Phase1 VF driver */
+	txgbe_mbox_api_21,	/* API version 2.1 */
 	/* This value should always be last */
 	txgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -61,6 +62,9 @@ enum txgbe_pfvf_api_rev {
 #define TXGBE_VF_GET_RSS_KEY	0x0b    /* get RSS key */
 #define TXGBE_VF_UPDATE_XCAST_MODE	0x0c
 
+/* mailbox API, version 2.1 VF requests */
+#define TXGBE_VF_SET_5TUPLE	0x20 /* VF request PF for 5-tuple filter */
+
 #define TXGBE_VF_BACKUP		0x8001 /* VF requests backup */
 
 /* mode choices for TXGBE_VF_UPDATE_XCAST_MODE */
@@ -71,6 +75,19 @@ enum txgbevf_xcast_modes {
 	TXGBEVF_XCAST_MODE_PROMISC,
 };
 
+enum txgbevf_5tuple_msg {
+	TXGBEVF_5T_REQ = 0,
+	TXGBEVF_5T_CMD,
+	TXGBEVF_5T_CTRL0,
+	TXGBEVF_5T_CTRL1,
+	TXGBEVF_5T_PORT,
+	TXGBEVF_5T_DA,
+	TXGBEVF_5T_SA,
+	TXGBEVF_5T_MAX /* must be last */
+};
+
+#define TXGBEVF_5T_ADD_SHIFT	31
+
 /* GET_QUEUES return data indices within the mailbox */
 #define TXGBE_VF_TX_QUEUES	1	/* number of Tx queues supported */
 #define TXGBE_VF_RX_QUEUES	2	/* number of Rx queues supported */
diff --git a/drivers/net/txgbe/base/txgbe_vf.c b/drivers/net/txgbe/base/txgbe_vf.c
index a73502351e..8c731b4776 100644
--- a/drivers/net/txgbe/base/txgbe_vf.c
+++ b/drivers/net/txgbe/base/txgbe_vf.c
@@ -357,6 +357,7 @@ s32 txgbevf_update_xcast_mode(struct txgbe_hw *hw, int xcast_mode)
 			return TXGBE_ERR_FEATURE_NOT_SUPPORTED;
 		/* Fall through */
 	case txgbe_mbox_api_13:
+	case txgbe_mbox_api_21:
 		break;
 	default:
 		return TXGBE_ERR_FEATURE_NOT_SUPPORTED;
@@ -610,6 +611,7 @@ int txgbevf_get_queues(struct txgbe_hw *hw, unsigned int *num_tcs,
 	case txgbe_mbox_api_11:
 	case txgbe_mbox_api_12:
 	case txgbe_mbox_api_13:
+	case txgbe_mbox_api_21:
 		break;
 	default:
 		return 0;
@@ -656,3 +658,30 @@ int txgbevf_get_queues(struct txgbe_hw *hw, unsigned int *num_tcs,
 
 	return err;
 }
+
+int
+txgbevf_add_5tuple_filter(struct txgbe_hw *hw, u32 *msg, u16 index)
+{
+	if (hw->api_version < txgbe_mbox_api_21)
+		return TXGBE_ERR_FEATURE_NOT_SUPPORTED;
+
+	msg[TXGBEVF_5T_REQ] = TXGBE_VF_SET_5TUPLE;
+	msg[TXGBEVF_5T_CMD] = index;
+	msg[TXGBEVF_5T_CMD] |= 1 << TXGBEVF_5T_ADD_SHIFT;
+
+	return txgbevf_write_msg_read_ack(hw, msg, msg, TXGBEVF_5T_MAX);
+}
+
+int
+txgbevf_del_5tuple_filter(struct txgbe_hw *hw, u16 index)
+{
+	u32 msg[2] = {0, 0};
+
+	if (hw->api_version < txgbe_mbox_api_21)
+		return TXGBE_ERR_FEATURE_NOT_SUPPORTED;
+
+	msg[TXGBEVF_5T_REQ] = TXGBE_VF_SET_5TUPLE;
+	msg[TXGBEVF_5T_CMD] = index;
+
+	return txgbevf_write_msg_read_ack(hw, msg, msg, 2);
+}
diff --git a/drivers/net/txgbe/base/txgbe_vf.h b/drivers/net/txgbe/base/txgbe_vf.h
index c3a90ab861..1fac1c7e32 100644
--- a/drivers/net/txgbe/base/txgbe_vf.h
+++ b/drivers/net/txgbe/base/txgbe_vf.h
@@ -58,5 +58,7 @@ s32 txgbevf_rlpml_set_vf(struct txgbe_hw *hw, u16 max_size);
 int txgbevf_negotiate_api_version(struct txgbe_hw *hw, int api);
 int txgbevf_get_queues(struct txgbe_hw *hw, unsigned int *num_tcs,
 		       unsigned int *default_tc);
+int txgbevf_add_5tuple_filter(struct txgbe_hw *hw, u32 *msg, u16 index);
+int txgbevf_del_5tuple_filter(struct txgbe_hw *hw, u16 index);
 
 #endif /* __TXGBE_VF_H__ */
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index ea9faba2c0..e5736bf387 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -826,7 +826,7 @@ eth_txgbe_dev_uninit(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-static int txgbe_ntuple_filter_uninit(struct rte_eth_dev *eth_dev)
+int txgbe_ntuple_filter_uninit(struct rte_eth_dev *eth_dev)
 {
 	struct txgbe_filter_info *filter_info = TXGBE_DEV_FILTER(eth_dev);
 	struct txgbe_5tuple_filter *p_5tuple;
@@ -4236,7 +4236,10 @@ txgbe_add_5tuple_filter(struct rte_eth_dev *dev,
 		return -ENOSYS;
 	}
 
-	txgbe_inject_5tuple_filter(dev, filter);
+	if (txgbe_is_pf(TXGBE_DEV_HW(dev)))
+		txgbe_inject_5tuple_filter(dev, filter);
+	else
+		txgbevf_inject_5tuple_filter(dev, filter);
 
 	return 0;
 }
@@ -4261,6 +4264,11 @@ txgbe_remove_5tuple_filter(struct rte_eth_dev *dev,
 	TAILQ_REMOVE(&filter_info->fivetuple_list, filter, entries);
 	rte_free(filter);
 
+	if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
+		txgbevf_remove_5tuple_filter(dev, index);
+		return;
+	}
+
 	wr32(hw, TXGBE_5TFDADDR(index), 0);
 	wr32(hw, TXGBE_5TFSADDR(index), 0);
 	wr32(hw, TXGBE_5TFPORT(index), 0);
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 302ea9f037..36d51fcbb8 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -526,6 +526,11 @@ int txgbe_add_del_ethertype_filter(struct rte_eth_dev *dev,
 int txgbe_syn_filter_set(struct rte_eth_dev *dev,
 			struct rte_eth_syn_filter *filter,
 			bool add);
+int txgbe_ntuple_filter_uninit(struct rte_eth_dev *eth_dev);
+
+int txgbevf_inject_5tuple_filter(struct rte_eth_dev *dev,
+				 struct txgbe_5tuple_filter *filter);
+void txgbevf_remove_5tuple_filter(struct rte_eth_dev *dev, u16 index);
 
 /**
  * l2 tunnel configuration.
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index d075f9d232..c0d8aa15b2 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -129,6 +129,7 @@ txgbevf_negotiate_api(struct txgbe_hw *hw)
 
 	/* start with highest supported, proceed down */
 	static const int sup_ver[] = {
+		txgbe_mbox_api_21,
 		txgbe_mbox_api_13,
 		txgbe_mbox_api_12,
 		txgbe_mbox_api_11,
@@ -157,6 +158,59 @@ generate_random_mac_addr(struct rte_ether_addr *mac_addr)
 	memcpy(&mac_addr->addr_bytes[3], &random, 3);
 }
 
+int
+txgbevf_inject_5tuple_filter(struct rte_eth_dev *dev,
+			     struct txgbe_5tuple_filter *filter)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	uint32_t mask = TXGBE_5TFCTL0_MASK;
+	uint16_t index = filter->index;
+	uint32_t msg[TXGBEVF_5T_MAX];
+	int err;
+
+	memset(msg, 0, sizeof(*msg));
+
+	/* 0 means compare */
+	mask &= ~TXGBE_5TFCTL0_MPOOL;
+	if (filter->filter_info.src_ip_mask == 0)
+		mask &= ~TXGBE_5TFCTL0_MSADDR;
+	if (filter->filter_info.dst_ip_mask == 0)
+		mask &= ~TXGBE_5TFCTL0_MDADDR;
+	if (filter->filter_info.src_port_mask == 0)
+		mask &= ~TXGBE_5TFCTL0_MSPORT;
+	if (filter->filter_info.dst_port_mask == 0)
+		mask &= ~TXGBE_5TFCTL0_MDPORT;
+	if (filter->filter_info.proto_mask == 0)
+		mask &= ~TXGBE_5TFCTL0_MPROTO;
+
+	msg[TXGBEVF_5T_CTRL0] = mask;
+	msg[TXGBEVF_5T_CTRL0] |= TXGBE_5TFCTL0_ENA;
+	msg[TXGBEVF_5T_CTRL0] |= TXGBE_5TFCTL0_PROTO(filter->filter_info.proto);
+	msg[TXGBEVF_5T_CTRL0] |= TXGBE_5TFCTL0_PRI(filter->filter_info.priority);
+	msg[TXGBEVF_5T_CTRL1] = TXGBE_5TFCTL1_QP(filter->queue);
+	msg[TXGBEVF_5T_PORT] = TXGBE_5TFPORT_DST(be_to_le16(filter->filter_info.dst_port));
+	msg[TXGBEVF_5T_PORT] |= TXGBE_5TFPORT_SRC(be_to_le16(filter->filter_info.src_port));
+	msg[TXGBEVF_5T_DA] = be_to_le32(filter->filter_info.dst_ip);
+	msg[TXGBEVF_5T_SA] = be_to_le32(filter->filter_info.src_ip);
+
+	err = txgbevf_add_5tuple_filter(hw, msg, index);
+	if (err)
+		PMD_DRV_LOG(ERR, "VF request PF to add 5tuple filters failed.");
+
+	return err;
+}
+
+void
+txgbevf_remove_5tuple_filter(struct rte_eth_dev *dev, u16 index)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	int err;
+
+	err = txgbevf_del_5tuple_filter(hw, index);
+	if (err)
+		PMD_DRV_LOG(ERR, "VF request PF to delete 5tuple filters failed.");
+}
+
 /*
  * Virtual Function device init
  */
@@ -173,6 +227,7 @@ eth_txgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	struct txgbe_hwstrip *hwstrip = TXGBE_DEV_HWSTRIP(eth_dev);
 	struct rte_ether_addr *perm_addr =
 			(struct rte_ether_addr *)hw->mac.perm_addr;
+	struct txgbe_filter_info *filter_info = TXGBE_DEV_FILTER(eth_dev);
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -308,6 +363,16 @@ eth_txgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	rte_intr_enable(intr_handle);
 	txgbevf_intr_enable(eth_dev);
 
+	/* initialize filter info */
+	memset(filter_info, 0,
+	       sizeof(struct txgbe_filter_info));
+
+	/* initialize 5tuple filter list */
+	TAILQ_INIT(&filter_info->fivetuple_list);
+
+	/* initialize flow filter lists */
+	txgbe_filterlist_init();
+
 	PMD_INIT_LOG(DEBUG, "port %d vendorID=0x%x deviceID=0x%x mac.type=%s",
 		     eth_dev->data->port_id, pci_dev->id.vendor_id,
 		     pci_dev->id.device_id, "txgbe_mac_raptor_vf");
@@ -794,6 +859,12 @@ txgbevf_dev_close(struct rte_eth_dev *dev)
 	rte_intr_callback_unregister(intr_handle,
 				     txgbevf_dev_interrupt_handler, dev);
 
+	/* Remove all ntuple filters of the device */
+	txgbe_ntuple_filter_uninit(dev);
+
+	/* clear all the filters list */
+	txgbe_filterlist_flush();
+
 	return ret;
 }
 
@@ -1341,6 +1412,14 @@ txgbevf_dev_interrupt_handler(void *param)
 	txgbevf_dev_interrupt_action(dev);
 }
 
+static int
+txgbevf_dev_flow_ops_get(__rte_unused struct rte_eth_dev *dev,
+			 const struct rte_flow_ops **ops)
+{
+	*ops = &txgbe_flow_ops;
+	return 0;
+}
+
 /*
  * dev_ops for virtual function, bare necessities for basic vf
  * operation have been implemented
@@ -1385,6 +1464,7 @@ static const struct eth_dev_ops txgbevf_eth_dev_ops = {
 	.rss_hash_update      = txgbe_dev_rss_hash_update,
 	.rss_hash_conf_get    = txgbe_dev_rss_hash_conf_get,
 	.tx_done_cleanup      = txgbe_dev_tx_done_cleanup,
+	.flow_ops_get         = txgbevf_dev_flow_ops_get,
 };
 
 RTE_PMD_REGISTER_PCI(net_txgbe_vf, rte_txgbevf_pmd);
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index 5d2dd45368..0fc2cb1d3b 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -2768,6 +2768,11 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		goto out;
 	}
 
+	if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
+		PMD_DRV_LOG(ERR, "Flow type not suppotted yet on VF.");
+		goto out;
+	}
+
 	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
 	ret = txgbe_parse_ethertype_filter(dev, attr, pattern,
 				actions, &ethertype_filter, error);
@@ -3146,6 +3151,10 @@ txgbe_flow_flush(struct rte_eth_dev *dev,
 	int ret = 0;
 
 	txgbe_clear_all_ntuple_filter(dev);
+
+	if (!txgbe_is_pf(TXGBE_DEV_HW(dev)))
+		goto out;
+
 	txgbe_clear_all_ethertype_filter(dev);
 	txgbe_clear_syn_filter(dev);
 
@@ -3165,6 +3174,7 @@ txgbe_flow_flush(struct rte_eth_dev *dev,
 
 	txgbe_clear_rss_filter(dev);
 
+out:
 	txgbe_filterlist_flush();
 
 	return 0;
-- 
2.48.1

