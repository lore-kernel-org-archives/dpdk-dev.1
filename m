Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE9ACCF9E9
	for <dpdk-dev@archiver.kernel.org>; Mon, 27 Oct 2025 03:18:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4840E40A77;
	Mon, 27 Oct 2025 04:16:34 +0100 (CET)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
 by mails.dpdk.org (Postfix) with ESMTP id 7234A40689;
 Mon, 27 Oct 2025 04:16:29 +0100 (CET)
X-QQ-mid: esmtpsz16t1761534984t363d01e4
X-QQ-Originating-IP: SVbVgy2jxrFlkqc6ZQawOg82BISLVYC8B86rOeYilbU=
Received: from lap-jiawenwu.trustnetic.com ( [36.20.107.118])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 27 Oct 2025 11:16:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7883488525545948569
EX-QQ-RecipientCnt: 4
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: dev@dpdk.org
Cc: zaiyuwang@trustnetic.com, Jiawen Wu <jiawenwu@trustnetic.com>,
 stable@dpdk.org
Subject: [PATCH 18/19] net/txgbe: switch to use FDIR on VF
Date: Mon, 27 Oct 2025 11:15:41 +0800
Message-Id: <20251027031542.10512-19-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20251027031542.10512-1-jiawenwu@trustnetic.com>
References: <20251027031542.10512-1-jiawenwu@trustnetic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NTMm76RsSGXE64YBfKmUXFU8P7AdhRhvHuQzRI1auKqzxrk6fl0afb+h
 ddTfl0QQwQrVkU6eQ+EyBvFqlZiNea6XB9LwIGav9Vdpt51c9s9EHqQPU8w+9p6EQ+hzZjN
 YCzpZl67h1SyPdUXZDtAGDz0UtiGDBgoswoZ+Zpz0RDn0u6XBGiQCIz77kUzVcBA2SOWTp4
 +nJMmKuPSBx3GBz+gdvqIunpUlDnPzUSZ91G6r1fu9e/kfch0fLAN0n+fWIyUf15CI69ZBk
 ncUeEvnjnLPGqgvMVzrbBeUm2Hkdo1T2+Si9MXQfVsmyheapr5g2bT1ZEDjCitz+6giZVNr
 hXn3R0N595cEUjVs01RZvPv/25CSpAOeGAjdx+lpk7OAd7uRkIFfJr5ZFpPjetNROeu847M
 Lq5lWnPvn+T7IWwO7ZGgRu5VDz+c8gKngJOzvT70ENOJJpYpUaCJJEEBSsmWVhRx7VHRmk0
 lAMVqNMe6U7d03FPsO27LJjUR81URDPEakMtVsWKJ+RMNiSitAlINsNOGjJR6YI7Lk+sjzs
 aWQmyPVGBNhW43oTyFnz9uhkiVE0AYGVoiixC+Q7OeD2ZP68jshdXgsGGuUAV+YgHWH8JaR
 NXWjgwJft8QzM3F1VnTz1CdBUytkE3wn3ILdF1Q4lLB6ZYmhmXWqPaafyFyBwG8rN4jh5Mo
 kwgTWUAFAbezUVh44KVTOnB8U04eW2Ltwz8+bPMUCyf4so4VYmGXRIJvVxStFtmK5fAOkyp
 Sk9BALD5vc8N0WyZ2Ah1ZKyYP036y4qXUO1Q03220ZWfQjtWUv+nbimKE3d3IWx/KXURLxi
 TJGrwadG/fVMg8MNrMwbPTlTkybMBa/njImj0MHhK3VTKu9Z2d+3yDDqmyeX/AAxswtRU5U
 8qs8xpPx+OAQsX7NzETpcchKsAqWWnScOISnuXBHL1GgmDbRN40o0fEhB+GJKlublnyjVjk
 x3pxQnguNn9+RPkHDk0Dqc19+6wMEWInpVy49gzKlCR0WxnjR29P+QAgc5Af9Oj+EbMGvCq
 wdQQyF9mmyWsvpS9hkbGwls315UFUTHj6/OYEAjCU2Jt/D0aDuBa5CM0Dp1YA=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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

Switch to use FDIR when ntuple filters are full on VF, just like PF. And
VF should request PF driver to configure the FDIR rule on hardware, so
new PF-VF mailbox API version 2.3 is added to implement it.

Fixes: 065d64788cdc ("net/txgbe: support flow filter for VF")
Cc: stable@dpdk.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/txgbe/base/txgbe_mbx.h  |  21 ++++
 drivers/net/txgbe/base/txgbe_vf.c   |  52 +++++++++-
 drivers/net/txgbe/base/txgbe_vf.h   |   1 +
 drivers/net/txgbe/txgbe_ethdev.c    |  22 ++--
 drivers/net/txgbe/txgbe_ethdev.h    |   6 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c |  19 +++-
 drivers/net/txgbe/txgbe_fdir.c      | 150 +++++++++++++++++++++++++++-
 drivers/net/txgbe/txgbe_flow.c      |  74 +++++++++++---
 8 files changed, 318 insertions(+), 27 deletions(-)

diff --git a/drivers/net/txgbe/base/txgbe_mbx.h b/drivers/net/txgbe/base/txgbe_mbx.h
index 31e2d51658..b5b586bd30 100644
--- a/drivers/net/txgbe/base/txgbe_mbx.h
+++ b/drivers/net/txgbe/base/txgbe_mbx.h
@@ -20,6 +20,8 @@
 #define TXGBE_VT_MSGTYPE_NACK	0x40000000
 /* Indicates that VF is still clear to send requests */
 #define TXGBE_VT_MSGTYPE_CTS	0x20000000
+/* Messages below or'd with this are the specific case */
+#define TXGBE_VT_MSGTYPE_SPEC	0x10000000
 
 #define TXGBE_VT_MSGINFO_SHIFT	16
 /* bits 23:16 are used for extra info for certain messages */
@@ -39,6 +41,7 @@ enum txgbe_pfvf_api_rev {
 	txgbe_mbox_api_13,	/* API version 1.3, linux/freebsd VF driver */
 	txgbe_mbox_api_20,	/* API version 2.0, solaris Phase1 VF driver */
 	txgbe_mbox_api_21,	/* API version 2.1 */
+	txgbe_mbox_api_23,	/* API version 2.3 */
 	/* This value should always be last */
 	txgbe_mbox_api_unknown,	/* indicates that API version is not known */
 };
@@ -65,6 +68,9 @@ enum txgbe_pfvf_api_rev {
 /* mailbox API, version 2.1 VF requests */
 #define TXGBE_VF_SET_5TUPLE	0x20 /* VF request PF for 5-tuple filter */
 
+/* mailbox API, version 2.3 VF requests */
+#define TXGBE_VF_SET_FDIR	0x22 /* VF request PF for FDIR filter */
+
 #define TXGBE_VF_BACKUP		0x8001 /* VF requests backup */
 
 /* mode choices for TXGBE_VF_UPDATE_XCAST_MODE */
@@ -88,6 +94,21 @@ enum txgbevf_5tuple_msg {
 
 #define TXGBEVF_5T_ADD_SHIFT	31
 
+enum txgbevf_fdir_msg {
+	TXGBEVF_FDIR_REQ = 0,
+	TXGBEVF_FDIR_CMD,
+	TXGBEVF_FDIR_IP4SA,
+	TXGBEVF_FDIR_IP4DA,
+	TXGBEVF_FDIR_PORT,
+	TXGBEVF_FDIR_FLEX,
+	TXGBEVF_FDIR_IP4DM,
+	TXGBEVF_FDIR_IP4SM,
+	TXGBEVF_FDIR_PORTM,
+	TXGBEVF_FDIR_MAX /* must be last */
+};
+
+#define TXGBEVF_FDIR_ADD_SHIFT	31
+
 /* GET_QUEUES return data indices within the mailbox */
 #define TXGBE_VF_TX_QUEUES	1	/* number of Tx queues supported */
 #define TXGBE_VF_RX_QUEUES	2	/* number of Rx queues supported */
diff --git a/drivers/net/txgbe/base/txgbe_vf.c b/drivers/net/txgbe/base/txgbe_vf.c
index 5e41ba1a3e..7d418b9b37 100644
--- a/drivers/net/txgbe/base/txgbe_vf.c
+++ b/drivers/net/txgbe/base/txgbe_vf.c
@@ -358,6 +358,7 @@ s32 txgbevf_update_xcast_mode(struct txgbe_hw *hw, int xcast_mode)
 		/* Fall through */
 	case txgbe_mbox_api_13:
 	case txgbe_mbox_api_21:
+	case txgbe_mbox_api_23:
 		break;
 	default:
 		return TXGBE_ERR_FEATURE_NOT_SUPPORTED;
@@ -612,6 +613,7 @@ int txgbevf_get_queues(struct txgbe_hw *hw, unsigned int *num_tcs,
 	case txgbe_mbox_api_12:
 	case txgbe_mbox_api_13:
 	case txgbe_mbox_api_21:
+	case txgbe_mbox_api_23:
 		break;
 	default:
 		return 0;
@@ -662,6 +664,8 @@ int txgbevf_get_queues(struct txgbe_hw *hw, unsigned int *num_tcs,
 int
 txgbevf_add_5tuple_filter(struct txgbe_hw *hw, u32 *msg, u16 index)
 {
+	int err;
+
 	if (hw->api_version < txgbe_mbox_api_21)
 		return TXGBE_ERR_FEATURE_NOT_SUPPORTED;
 
@@ -669,13 +673,22 @@ txgbevf_add_5tuple_filter(struct txgbe_hw *hw, u32 *msg, u16 index)
 	msg[TXGBEVF_5T_CMD] = index;
 	msg[TXGBEVF_5T_CMD] |= 1 << TXGBEVF_5T_ADD_SHIFT;
 
-	return txgbevf_write_msg_read_ack(hw, msg, msg, TXGBEVF_5T_MAX);
+	err = txgbevf_write_msg_read_ack(hw, msg, msg, TXGBEVF_5T_MAX);
+	if (err)
+		return err;
+
+	msg[0] &= ~TXGBE_VT_MSGTYPE_CTS;
+	if (msg[0] != (TXGBE_VF_SET_5TUPLE | TXGBE_VT_MSGTYPE_ACK))
+		return TXGBE_ERR_NOSUPP;
+
+	return 0;
 }
 
 int
 txgbevf_del_5tuple_filter(struct txgbe_hw *hw, u16 index)
 {
 	u32 msg[2] = {0, 0};
+	int err;
 
 	if (hw->api_version < txgbe_mbox_api_21)
 		return TXGBE_ERR_FEATURE_NOT_SUPPORTED;
@@ -683,5 +696,40 @@ txgbevf_del_5tuple_filter(struct txgbe_hw *hw, u16 index)
 	msg[TXGBEVF_5T_REQ] = TXGBE_VF_SET_5TUPLE;
 	msg[TXGBEVF_5T_CMD] = index;
 
-	return txgbevf_write_msg_read_ack(hw, msg, msg, 2);
+	err = txgbevf_write_msg_read_ack(hw, msg, msg, 2);
+	if (err)
+		return err;
+
+	msg[0] &= ~TXGBE_VT_MSGTYPE_CTS;
+	if (msg[0] != (TXGBE_VF_SET_5TUPLE | TXGBE_VT_MSGTYPE_ACK))
+		return TXGBE_ERR_NOSUPP;
+
+	return 0;
+}
+
+int
+txgbevf_set_fdir(struct txgbe_hw *hw, u32 *msg, bool add)
+{
+	u16 msg_len = TXGBEVF_FDIR_MAX;
+	int err = 0;
+
+	if (hw->api_version < txgbe_mbox_api_23)
+		return TXGBE_ERR_FEATURE_NOT_SUPPORTED;
+
+	msg[TXGBEVF_FDIR_REQ] = TXGBE_VF_SET_FDIR;
+
+	if (add)
+		msg[TXGBEVF_FDIR_CMD] |= 1 << TXGBEVF_FDIR_ADD_SHIFT;
+	else
+		msg_len = 2;
+
+	err = txgbevf_write_msg_read_ack(hw, msg, msg, msg_len);
+	if (err)
+		return err;
+
+	msg[0] &= ~TXGBE_VT_MSGTYPE_CTS;
+	if (msg[0] == (TXGBE_VF_SET_FDIR | TXGBE_VT_MSGTYPE_NACK))
+		return TXGBE_ERR_FEATURE_NOT_SUPPORTED;
+
+	return 0;
 }
diff --git a/drivers/net/txgbe/base/txgbe_vf.h b/drivers/net/txgbe/base/txgbe_vf.h
index 1fac1c7e32..c67e2f59b3 100644
--- a/drivers/net/txgbe/base/txgbe_vf.h
+++ b/drivers/net/txgbe/base/txgbe_vf.h
@@ -60,5 +60,6 @@ int txgbevf_get_queues(struct txgbe_hw *hw, unsigned int *num_tcs,
 		       unsigned int *default_tc);
 int txgbevf_add_5tuple_filter(struct txgbe_hw *hw, u32 *msg, u16 index);
 int txgbevf_del_5tuple_filter(struct txgbe_hw *hw, u16 index);
+int txgbevf_set_fdir(struct txgbe_hw *hw, u32 *msg, bool add);
 
 #endif /* __TXGBE_VF_H__ */
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index 21f0711762..5d360f8305 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -90,8 +90,6 @@ static const struct reg_info *txgbe_regs_others[] = {
 				txgbe_regs_diagnostic,
 				NULL};
 
-static int txgbe_fdir_filter_init(struct rte_eth_dev *eth_dev);
-static int txgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev);
 static int txgbe_l2_tn_filter_init(struct rte_eth_dev *eth_dev);
 static int txgbe_l2_tn_filter_uninit(struct rte_eth_dev *eth_dev);
 static int  txgbe_dev_set_link_up(struct rte_eth_dev *dev);
@@ -898,7 +896,7 @@ int txgbe_ntuple_filter_uninit(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-static int txgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev)
+int txgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev)
 {
 	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(eth_dev);
 	struct txgbe_fdir_filter *fdir_filter;
@@ -934,7 +932,7 @@ static int txgbe_l2_tn_filter_uninit(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-static int txgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
+int txgbe_fdir_filter_init(struct rte_eth_dev *eth_dev)
 {
 	struct rte_eth_fdir_conf *fdir_conf = TXGBE_DEV_FDIR_CONF(eth_dev);
 	struct txgbe_hw_fdir_info *fdir_info = TXGBE_DEV_FDIR(eth_dev);
@@ -4478,6 +4476,7 @@ txgbe_add_5tuple_filter(struct rte_eth_dev *dev,
 {
 	struct txgbe_filter_info *filter_info = TXGBE_DEV_FILTER(dev);
 	int i, idx, shift;
+	int err;
 
 	/*
 	 * look for an unused 5tuple filter index,
@@ -4501,12 +4500,19 @@ txgbe_add_5tuple_filter(struct rte_eth_dev *dev,
 		return -ENOSYS;
 	}
 
-	if (txgbe_is_pf(TXGBE_DEV_HW(dev)))
+	if (txgbe_is_pf(TXGBE_DEV_HW(dev))) {
 		txgbe_inject_5tuple_filter(dev, filter);
-	else
-		txgbevf_inject_5tuple_filter(dev, filter);
+		return 0;
+	}
 
-	return 0;
+	err = txgbevf_inject_5tuple_filter(dev, filter);
+	if (err) {
+		filter_info->fivetuple_mask[i / (sizeof(uint32_t) * NBBY)] &=
+				~(1 << (i % (sizeof(uint32_t) * NBBY)));
+		TAILQ_REMOVE(&filter_info->fivetuple_list, filter, entries);
+	}
+
+	return err;
 }
 
 /*
diff --git a/drivers/net/txgbe/txgbe_ethdev.h b/drivers/net/txgbe/txgbe_ethdev.h
index 1e7cc5ea80..189fbac541 100644
--- a/drivers/net/txgbe/txgbe_ethdev.h
+++ b/drivers/net/txgbe/txgbe_ethdev.h
@@ -555,6 +555,8 @@ txgbe_dev_l2_tunnel_filter_del(struct rte_eth_dev *dev,
 			       struct txgbe_l2_tunnel_conf *l2_tunnel);
 void txgbe_filterlist_init(void);
 void txgbe_filterlist_flush(void);
+int txgbe_fdir_filter_init(struct rte_eth_dev *eth_dev);
+int txgbe_fdir_filter_uninit(struct rte_eth_dev *eth_dev);
 
 void txgbe_set_ivar_map(struct txgbe_hw *hw, int8_t direction,
 			       uint8_t queue, uint8_t msix_vector);
@@ -570,7 +572,9 @@ int txgbe_fdir_set_flexbytes_offset(struct rte_eth_dev *dev,
 int txgbe_fdir_filter_program(struct rte_eth_dev *dev,
 			      struct txgbe_fdir_rule *rule,
 			      bool del, bool update);
-
+int txgbevf_fdir_filter_program(struct rte_eth_dev *dev,
+				struct txgbe_fdir_rule *rule,
+				bool del);
 void txgbe_configure_pb(struct rte_eth_dev *dev);
 void txgbe_configure_port(struct rte_eth_dev *dev);
 void txgbe_configure_dcb(struct rte_eth_dev *dev);
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index ae04054d02..0f914fa3f5 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -129,6 +129,7 @@ txgbevf_negotiate_api(struct txgbe_hw *hw)
 
 	/* start with highest supported, proceed down */
 	static const int sup_ver[] = {
+		txgbe_mbox_api_23,
 		txgbe_mbox_api_21,
 		txgbe_mbox_api_13,
 		txgbe_mbox_api_12,
@@ -162,6 +163,7 @@ int
 txgbevf_inject_5tuple_filter(struct rte_eth_dev *dev,
 			     struct txgbe_5tuple_filter *filter)
 {
+	struct txgbe_filter_info *filter_info = TXGBE_DEV_FILTER(dev);
 	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
 	uint32_t mask = TXGBE_5TFCTL0_MASK;
 	uint16_t index = filter->index;
@@ -194,9 +196,16 @@ txgbevf_inject_5tuple_filter(struct rte_eth_dev *dev,
 	msg[TXGBEVF_5T_SA] = be_to_le32(filter->filter_info.src_ip);
 
 	err = txgbevf_add_5tuple_filter(hw, msg, index);
-	if (err)
-		PMD_DRV_LOG(ERR, "VF request PF to add 5tuple filters failed.");
+	if (!err)
+		return 0;
+
+	if (msg[TXGBEVF_5T_REQ] & TXGBE_VT_MSGTYPE_SPEC) {
+		PMD_DRV_LOG(INFO, "5tuple filters are full, switch to FDIR");
+		filter_info->ntuple_is_full = true;
+		return -ENOSYS;
+	}
 
+	PMD_DRV_LOG(ERR, "VF request PF to add 5tuple filters failed.");
 	return err;
 }
 
@@ -367,6 +376,9 @@ eth_txgbevf_dev_init(struct rte_eth_dev *eth_dev)
 	memset(filter_info, 0,
 	       sizeof(struct txgbe_filter_info));
 
+	/* initialize flow director filter list & hash */
+	txgbe_fdir_filter_init(eth_dev);
+
 	/* initialize 5tuple filter list */
 	TAILQ_INIT(&filter_info->fivetuple_list);
 
@@ -860,6 +872,9 @@ txgbevf_dev_close(struct rte_eth_dev *dev)
 	rte_intr_callback_unregister(intr_handle,
 				     txgbevf_dev_interrupt_handler, dev);
 
+	/* remove all the fdir filters & hash */
+	txgbe_fdir_filter_uninit(dev);
+
 	/* Remove all ntuple filters of the device */
 	txgbe_ntuple_filter_uninit(dev);
 
diff --git a/drivers/net/txgbe/txgbe_fdir.c b/drivers/net/txgbe/txgbe_fdir.c
index 6b83a7379d..67f586ffc7 100644
--- a/drivers/net/txgbe/txgbe_fdir.c
+++ b/drivers/net/txgbe/txgbe_fdir.c
@@ -775,7 +775,7 @@ txgbe_insert_fdir_filter(struct txgbe_hw_fdir_info *fdir_info,
 
 	TAILQ_INSERT_TAIL(&fdir_info->fdir_list, fdir_filter, entries);
 
-	return 0;
+	return ret;
 }
 
 static inline int
@@ -795,7 +795,7 @@ txgbe_remove_fdir_filter(struct txgbe_hw_fdir_info *fdir_info,
 	TAILQ_REMOVE(&fdir_info->fdir_list, fdir_filter, entries);
 	rte_free(fdir_filter);
 
-	return 0;
+	return ret;
 }
 
 static void
@@ -929,6 +929,147 @@ txgbe_fdir_filter_program(struct rte_eth_dev *dev,
 	return err;
 }
 
+static void
+txgbevf_flush_fdir_filter(struct rte_eth_dev *dev)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	uint32_t msg[2] = {0, 0};
+
+	/* flush bit */
+	msg[TXGBEVF_FDIR_CMD] = 1 << 16;
+
+	txgbevf_set_fdir(hw, msg, FALSE);
+}
+
+static int
+txgbevf_del_fdir_filter(struct rte_eth_dev *dev,
+			struct txgbe_fdir_rule *rule,
+			int id)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	struct txgbe_hw_fdir_info *info = TXGBE_DEV_FDIR(dev);
+	uint32_t msg[2] = {0, 0};
+	int ret = 0;
+
+	/* node id [15:0] */
+	msg[TXGBEVF_FDIR_CMD] = id;
+
+	ret = txgbevf_set_fdir(hw, msg, FALSE);
+	if (ret) {
+		PMD_DRV_LOG(ERR, "VF request PF to delete FDIR filters failed.");
+		return ret;
+	}
+
+	ret = txgbe_remove_fdir_filter(info, &rule->input);
+	if (ret < 0)
+		PMD_DRV_LOG(ERR, "Fail to delete FDIR filter!");
+
+	return 0;
+}
+
+static int
+txgbevf_add_fdir_filter(struct rte_eth_dev *dev,
+			struct txgbe_fdir_rule *rule,
+			int id)
+{
+	struct txgbe_hw *hw = TXGBE_DEV_HW(dev);
+	uint32_t msg[TXGBEVF_FDIR_MAX];
+	int ret = 0;
+
+	memset(msg, 0, sizeof(msg));
+
+	/* node id [15:0] */
+	msg[TXGBEVF_FDIR_CMD] = id;
+	/* ring_idx [23:16] */
+	msg[TXGBEVF_FDIR_CMD] |= rule->queue << 16;
+	/* flow_type [30:24] */
+	msg[TXGBEVF_FDIR_CMD] |= rule->input.flow_type << 24;
+
+	msg[TXGBEVF_FDIR_IP4SA] = rule->input.src_ip[0];
+	msg[TXGBEVF_FDIR_IP4DA] = rule->input.dst_ip[0];
+	msg[TXGBEVF_FDIR_PORT] = (rule->input.dst_port << 16) |
+				rule->input.src_port;
+	if (rule->mask.flex_bytes_mask) {
+		/* base [1:0] */
+		msg[TXGBEVF_FDIR_FLEX] = txgbe_fdir_get_flex_base(rule);
+		/* offset [7:3] */
+		msg[TXGBEVF_FDIR_FLEX] |=
+			TXGBE_FDIRFLEXCFG_OFST(rule->flex_bytes_offset / 2);
+		/* flex bytes [31:16]*/
+		msg[TXGBEVF_FDIR_FLEX] |= rule->input.flex_bytes << 16;
+	}
+	msg[TXGBEVF_FDIR_IP4SM] = rule->mask.src_ipv4_mask;
+	msg[TXGBEVF_FDIR_IP4DM] = rule->mask.dst_ipv4_mask;
+	msg[TXGBEVF_FDIR_PORTM] = (rule->mask.dst_port_mask << 16) |
+				rule->mask.src_port_mask;
+
+	ret = txgbevf_set_fdir(hw, msg, TRUE);
+	if (ret)
+		PMD_DRV_LOG(ERR, "VF request PF to add FDIR filters failed.");
+
+	return ret;
+}
+
+int
+txgbevf_fdir_filter_program(struct rte_eth_dev *dev,
+			    struct txgbe_fdir_rule *rule,
+			    bool del)
+{
+	struct txgbe_hw_fdir_info *info = TXGBE_DEV_FDIR(dev);
+	struct txgbe_atr_input *input = &rule->input;
+	struct txgbe_fdir_filter *node;
+	uint32_t fdirhash;
+	int ret;
+
+	if (rule->mode != RTE_FDIR_MODE_PERFECT ||
+	    rule->fdirflags == TXGBE_FDIRPICMD_DROP)
+		return -ENOTSUP;
+
+	if (input->flow_type & TXGBE_ATR_FLOW_TYPE_IPV6)
+		return -ENOTSUP;
+
+	fdirhash = atr_compute_perfect_hash(input,
+			TXGBE_DEV_FDIR_CONF(dev)->pballoc);
+
+	ret = rte_hash_lookup(info->hash_handle, (const void *)input);
+	if (ret < 0) {
+		if (del) {
+			PMD_DRV_LOG(ERR, "No such fdir filter to delete!");
+			return ret;
+		}
+	} else {
+		if (!del) {
+			PMD_DRV_LOG(ERR, "Conflict with existing fdir filter!");
+			return -EINVAL;
+		}
+	}
+
+	if (del)
+		return txgbevf_del_fdir_filter(dev, rule, ret);
+
+	node = rte_zmalloc("txgbe_fdir",
+			   sizeof(struct txgbe_fdir_filter), 0);
+	if (!node)
+		return -ENOMEM;
+	rte_memcpy(&node->input, input,
+		   sizeof(struct txgbe_atr_input));
+	node->fdirflags = rule->fdirflags;
+	node->fdirhash = fdirhash;
+	node->queue = rule->queue;
+
+	ret = txgbe_insert_fdir_filter(info, node);
+	if (ret < 0) {
+		rte_free(node);
+		return ret;
+	}
+
+	ret = txgbevf_add_fdir_filter(dev, rule, ret);
+	if (ret)
+		txgbe_remove_fdir_filter(info, input);
+
+	return ret;
+}
+
 static int
 txgbe_fdir_flush(struct rte_eth_dev *dev)
 {
@@ -936,6 +1077,11 @@ txgbe_fdir_flush(struct rte_eth_dev *dev)
 	struct txgbe_hw_fdir_info *info = TXGBE_DEV_FDIR(dev);
 	int ret;
 
+	if (!txgbe_is_pf(hw)) {
+		txgbevf_flush_fdir_filter(dev);
+		return 0;
+	}
+
 	ret = txgbe_reinit_fdir_tables(hw);
 	if (ret < 0) {
 		PMD_INIT_LOG(ERR, "Failed to re-initialize FD table.");
diff --git a/drivers/net/txgbe/txgbe_flow.c b/drivers/net/txgbe/txgbe_flow.c
index cd05ceffed..5647165d52 100644
--- a/drivers/net/txgbe/txgbe_flow.c
+++ b/drivers/net/txgbe/txgbe_flow.c
@@ -828,6 +828,13 @@ txgbe_parse_ethertype_filter(struct rte_eth_dev *dev,
 {
 	int ret;
 
+	if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ITEM,
+				   NULL, "Flow type not suppotted yet on VF");
+		return -rte_errno;
+	}
+
 	ret = cons_parse_ethertype_filter(attr, pattern,
 					actions, filter, error);
 
@@ -1114,6 +1121,13 @@ txgbe_parse_syn_filter(struct rte_eth_dev *dev,
 {
 	int ret;
 
+	if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ITEM,
+				   NULL, "Flow type not suppotted yet on VF");
+		return -rte_errno;
+	}
+
 	ret = cons_parse_syn_filter(attr, pattern,
 					actions, filter, error);
 
@@ -1317,6 +1331,13 @@ txgbe_parse_l2_tn_filter(struct rte_eth_dev *dev,
 	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(dev);
 	uint16_t vf_num;
 
+	if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ITEM,
+				   NULL, "Flow type not suppotted yet on VF");
+		return -rte_errno;
+	}
+
 	ret = cons_parse_l2_tn_filter(dev, attr, pattern,
 				actions, l2_tn_filter, error);
 
@@ -2960,6 +2981,9 @@ txgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 		return ret;
 
 step_next:
+	if (!txgbe_is_pf(TXGBE_DEV_HW(dev)))
+		return ret;
+
 	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
 		fdir_conf->mode = rule->mode;
 		ret = txgbe_fdir_configure(dev);
@@ -2988,6 +3012,13 @@ txgbe_parse_rss_filter(struct rte_eth_dev *dev,
 	const struct rte_flow_action_rss *rss;
 	uint16_t n;
 
+	if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
+		rte_flow_error_set(error, EINVAL,
+				   RTE_FLOW_ERROR_TYPE_ITEM,
+				   NULL, "Flow type not suppotted yet on VF");
+		return -rte_errno;
+	}
+
 	/**
 	 * rss only supports forwarding,
 	 * check if the first not void action is RSS.
@@ -3256,11 +3287,6 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 		goto out;
 	}
 
-	if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
-		PMD_DRV_LOG(ERR, "Flow type not suppotted yet on VF.");
-		goto out;
-	}
-
 next:
 	memset(&ethertype_filter, 0, sizeof(struct rte_eth_ethertype_filter));
 	ret = txgbe_parse_ethertype_filter(dev, attr, pattern,
@@ -3317,6 +3343,27 @@ txgbe_flow_create(struct rte_eth_dev *dev,
 	ret = txgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
 	if (!ret) {
+		if (!txgbe_is_pf(TXGBE_DEV_HW(dev))) {
+			ret = txgbevf_fdir_filter_program(dev, &fdir_rule, FALSE);
+			if (ret < 0)
+				goto out;
+
+			fdir_rule_ptr = rte_zmalloc("txgbe_fdir_filter",
+					    sizeof(struct txgbe_fdir_rule_ele), 0);
+			if (!fdir_rule_ptr) {
+				PMD_DRV_LOG(ERR, "failed to allocate memory");
+				goto out;
+			}
+			rte_memcpy(&fdir_rule_ptr->filter_info,
+				   &fdir_rule,
+				   sizeof(struct txgbe_fdir_rule));
+			TAILQ_INSERT_TAIL(&filter_fdir_list,
+					  fdir_rule_ptr, entries);
+			flow->rule = fdir_rule_ptr;
+			flow->filter_type = RTE_ETH_FILTER_FDIR;
+			return flow;
+		}
+
 		/* A mask cannot be deleted. */
 		if (fdir_rule.b_mask) {
 			if (!fdir_info->mask_added) {
@@ -3583,7 +3630,10 @@ txgbe_flow_destroy(struct rte_eth_dev *dev,
 		rte_memcpy(&fdir_rule,
 			&fdir_rule_ptr->filter_info,
 			sizeof(struct txgbe_fdir_rule));
-		ret = txgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
+		if (txgbe_is_pf(TXGBE_DEV_HW(dev)))
+			ret = txgbe_fdir_filter_program(dev, &fdir_rule, TRUE, FALSE);
+		else
+			ret = txgbevf_fdir_filter_program(dev, &fdir_rule, TRUE);
 		if (!ret) {
 			TAILQ_REMOVE(&filter_fdir_list,
 				fdir_rule_ptr, entries);
@@ -3656,12 +3706,6 @@ txgbe_flow_flush(struct rte_eth_dev *dev,
 
 	txgbe_clear_all_ntuple_filter(dev);
 
-	if (!txgbe_is_pf(TXGBE_DEV_HW(dev)))
-		goto out;
-
-	txgbe_clear_all_ethertype_filter(dev);
-	txgbe_clear_syn_filter(dev);
-
 	ret = txgbe_clear_all_fdir_filter(dev);
 	if (ret < 0) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
@@ -3669,6 +3713,12 @@ txgbe_flow_flush(struct rte_eth_dev *dev,
 		return ret;
 	}
 
+	if (!txgbe_is_pf(TXGBE_DEV_HW(dev)))
+		goto out;
+
+	txgbe_clear_all_ethertype_filter(dev);
+	txgbe_clear_syn_filter(dev);
+
 	ret = txgbe_clear_all_l2_tn_filter(dev);
 	if (ret < 0) {
 		rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_HANDLE,
-- 
2.48.1

