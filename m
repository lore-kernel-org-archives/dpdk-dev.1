Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AB04CC6B2A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:10:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5638140A67;
	Wed, 14 Oct 2026 17:09:56 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.2])
 by mails.dpdk.org (Postfix) with ESMTP id EFA2E40689
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=WayhunRokRLoSjLj8ilaN2lUHDJHc2Uk0izMNup8XWo=;
 b=fINn3HTDZHoCg6KngSF6T/MHF8wP/gnv2hkkZ9MbAX9qEoXV2NCIK1biManpfw
 atkk/C3nivKnNQB8kKzlhSWmm3ENv3BxH82fJQoNgT49ckCK51s51JUlj5pKALWj
 pE/334lNiuThwyQPWD7WZzd75xTkgayT42p09GOw75X78=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 10/26] net/hinic3: add mbox message recording and debug dump
Date: Wed, 14 Oct 2026 23:09:06 +0800
Message-ID: <20261014150923.838-11-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261014150923.838-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
 <20261014150923.838-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAXMEEym89qB_SFAw--.62919S12
X-Coremail-Antispam: 1Uf129KBjvJXoW3CF48tFykXw1xJF4UAw4Utwb_yoWkCFWDpF
 W5ZF97CrZ5Ja12qrnxAa13Ca15tw18J340ga4Ika4Y9F1fXFyUA348JayjvF15Xr1xAF17
 Za10gw4DKF15KwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjc_-UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNxiDjWrPmzgfgwAA37
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

Provide recorded mbox send/receive history and a dump of it together with
the AEQ state so mailbox timeouts and response mismatches can be diagnosed.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/hinic3/base/hinic3_eqs.c   | 55 ++++++++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_eqs.h   |  2 +
 drivers/net/hinic3/base/hinic3_mbox.c  | 43 ++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_mbox.h  | 18 +++++++++
 drivers/net/hinic3/hinic3_ethdev.c     | 27 +++++++++++++
 6 files changed, 146 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 06312632d0..28770ca152 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -118,6 +118,7 @@ New Features
 
   * Added CIR drop statistics and VF link aggregation (LAG) support.
   * Added FEC mode get and set support.
+  * Added mailbox message counter reporting through the device private dump API.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/base/hinic3_eqs.c b/drivers/net/hinic3/base/hinic3_eqs.c
index 1fc78adc85..0fa412c9ae 100644
--- a/drivers/net/hinic3/base/hinic3_eqs.c
+++ b/drivers/net/hinic3/base/hinic3_eqs.c
@@ -587,6 +587,61 @@ hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev)
 	}
 }
 
+void hinic3_dump_aeq_mbox_info(struct hinic3_hwdev *hwdev)
+{
+	struct save_mbox_info *save_mbox = NULL;
+	struct hinic3_eq *aeq = NULL;
+	struct hinic3_aeq_elem *aeqe_pos = NULL;
+	struct rte_pci_device *pci_dev = NULL;
+	uint32_t i, pos;
+	uint8_t src, size, wrapped, seq_id, seg_len, msg_id, mod;
+	uint8_t data[HINIC3_AEQE_DATA_SIZE];
+	uint16_t src_func_idx, cmd;
+	uint32_t aeqe_desc;
+	uint64_t mbox_header;
+	enum hinic3_aeq_type event;
+
+	pci_dev = hwdev->pci_dev;
+	save_mbox = hwdev->func_to_func->save_mbox;
+	aeq = &hwdev->aeqs->aeq[HINIC3_MBOX_RSP_MSG_AEQ];
+
+	PMD_DRV_LOG(ERR, "Sending the latest mbox messages:");
+	for (i = 0; i < HINIC3_MBOX_SAVE_NUM; i++) {
+		pos = (hwdev->func_to_func->save_mbox->start + i) % HINIC3_MBOX_SAVE_NUM;
+		PMD_DRV_LOG(ERR, "send_msg_id: %u, cmd: %u, mod: %u",
+			save_mbox->send_info[pos].send_msg_id, save_mbox->send_info[pos].cmd,
+			save_mbox->send_info[pos].mod);
+	}
+
+	PMD_DRV_LOG(ERR, "dump aeqe info:");
+	PMD_DRV_LOG(ERR, "port: %u, eq cid: %u, func id: %u, bus: %u, devid: %u, wrapped: %u",
+		hwdev->port_id, aeq->cons_idx, pci_dev->addr.function, pci_dev->addr.bus,
+		pci_dev->addr.devid, aeq->wrapped);
+	for (i = 0; i < aeq->eq_len; i++) {
+		/* Parsing the data field. */
+		aeqe_pos = GET_AEQ_ELEM(aeq, i);
+		aeqe_desc = rte_be_to_cpu_32(aeqe_pos->desc);
+		memcpy(data, aeqe_pos->aeqe_data, HINIC3_AEQE_DATA_SIZE);
+		hinic3_be32_to_cpu(data, HINIC3_AEQE_DATA_SIZE);
+		memcpy(&mbox_header, data, sizeof(mbox_header));
+		seq_id = HINIC3_MSG_HEADER_GET(mbox_header, SEQID);
+		seg_len = HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN);
+		src_func_idx = HINIC3_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);
+		msg_id = HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID);
+		mod = HINIC3_MSG_HEADER_GET(mbox_header, MODULE);
+		cmd = HINIC3_MSG_HEADER_GET(mbox_header, CMD);
+		/* Parsing the desc field. */
+		event = EQ_ELEM_DESC_GET(aeqe_desc, TYPE);
+		src = EQ_ELEM_DESC_GET(aeqe_desc, SRC);
+		size = EQ_ELEM_DESC_GET(aeqe_desc, SIZE);
+		wrapped = EQ_ELEM_DESC_GET(aeqe_desc, WRAPPED);
+
+		PMD_DRV_LOG(ERR, "index: %d, msg_id: %u, mod: %u, cmd: %u, seq_id: %u, seg_len: %u,"
+			"src_func_idx: %u, event: %u, src: %u, size: %u, wrapped: %u", i, msg_id,
+			mod, cmd, seq_id, seg_len, src_func_idx, event, src, size, wrapped);
+	}
+}
+
 static int
 aeq_elem_handler(struct hinic3_eq *eq, uint32_t aeqe_desc,
 		 struct hinic3_aeq_elem *aeqe_pos, void *param)
diff --git a/drivers/net/hinic3/base/hinic3_eqs.h b/drivers/net/hinic3/base/hinic3_eqs.h
index 365c9cbf39..38de79a705 100644
--- a/drivers/net/hinic3/base/hinic3_eqs.h
+++ b/drivers/net/hinic3/base/hinic3_eqs.h
@@ -85,6 +85,8 @@ void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);
 
 void hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev);
 
+void hinic3_dump_aeq_mbox_info(struct hinic3_hwdev *hwdev);
+
 int hinic3_aeq_poll_msg(struct hinic3_eq *eq, uint32_t timeout, void *param);
 
 void hinic3_dev_handle_aeq_event(struct hinic3_hwdev *hwdev, void *param);
diff --git a/drivers/net/hinic3/base/hinic3_mbox.c b/drivers/net/hinic3/base/hinic3_mbox.c
index c4ca2ed7ba..f2cf86ad54 100644
--- a/drivers/net/hinic3/base/hinic3_mbox.c
+++ b/drivers/net/hinic3/base/hinic3_mbox.c
@@ -711,6 +711,27 @@ send_tlp_mbox_seg(struct hinic3_mbox *func_to_func, uint64_t header, uint16_t ds
 	return 0;
 }
 
+static void hinic3_record_mbox_info(struct hinic3_mbox *func_to_func,
+				    enum hinic3_mod_type mod, uint16_t cmd,
+				    uint8_t msg_id)
+{
+	struct mbox_send_info send_mbox;
+
+	send_mbox.cmd = cmd;
+	send_mbox.mod = mod;
+	send_mbox.send_msg_id = msg_id;
+
+	uint8_t pos = (func_to_func->save_mbox->start + func_to_func->save_mbox->count) %
+		      HINIC3_MBOX_SAVE_NUM;
+	func_to_func->save_mbox->send_info[pos] = send_mbox;
+
+	if (func_to_func->save_mbox->count < HINIC3_MBOX_SAVE_NUM)
+		func_to_func->save_mbox->count++;
+	else
+		func_to_func->save_mbox->start = (func_to_func->save_mbox->start + 1) %
+						 HINIC3_MBOX_SAVE_NUM;
+}
+
 static int
 send_mbox_to_func(struct hinic3_mbox *func_to_func, enum hinic3_mod_type mod,
 		struct hinic3_handler_info *handler_info, struct mbox_msg_info *msg_info)
@@ -724,6 +745,9 @@ send_mbox_to_func(struct hinic3_mbox *func_to_func, enum hinic3_mod_type mod,
 
 	rsp_aeq_id = HINIC3_MBOX_RSP_MSG_AEQ;
 
+	hinic3_record_mbox_info(func_to_func, mod, handler_info->cmd,
+				msg_info->msg_id);
+
 	/* Set the header message. */
 	header = HINIC3_MSG_HEADER_SET(handler_info->in_size, MSG_LEN) |
 		 HINIC3_MSG_HEADER_SET(mod, MODULE) |
@@ -782,6 +806,9 @@ send_tlp_mbox_to_func(struct hinic3_mbox *func_to_func, enum hinic3_mod_type mod
 
 	rsp_aeq_id = HINIC3_MBOX_RSP_MSG_AEQ;
 
+	hinic3_record_mbox_info(func_to_func, mod, handler_info->cmd,
+				msg_info->msg_id);
+
 	/* Set the header message. */
 	header = HINIC3_MSG_HEADER_SET(MBOX_TLP_HEADER_SZ, MSG_LEN) |
 		 HINIC3_MSG_HEADER_SET(MBOX_TLP_HEADER_SZ, SEG_LEN) |
@@ -873,6 +900,7 @@ hinic3_mbox_to_func(struct hinic3_mbox *func_to_func, enum hinic3_mod_type mod,
 		goto send_err;
 	}
 
+	func_to_func->mbox_send_cnt++;
 	/* Wait for the response message. */
 	time = timeout ? timeout : HINIC3_MBOX_COMP_TIME;
 	aeq = &func_to_func->hwdev->aeqs->aeq[HINIC3_MBOX_RSP_MSG_AEQ];
@@ -884,6 +912,7 @@ hinic3_mbox_to_func(struct hinic3_mbox *func_to_func, enum hinic3_mod_type mod,
 		goto send_err;
 	}
 
+	func_to_func->mbox_ack_cnt++;
 	/* Check whether mod and command of the rsp message match the sent message. */
 	if (mod != mbox_for_resp->mod || handler_info->cmd != mbox_for_resp->cmd) {
 		PMD_DRV_LOG(ERR,
@@ -1129,6 +1158,16 @@ hinic3_func_to_func_init(struct hinic3_hwdev *hwdev)
 
 	hwdev->func_to_func = func_to_func;
 	func_to_func->hwdev = hwdev;
+
+	struct save_mbox_info *save_mbox = rte_zmalloc("save_mbox_info",
+						      sizeof(struct save_mbox_info), 0);
+	if (!save_mbox) {
+		err = -ENOMEM;
+		goto alloc_save_mbox_err;
+	}
+
+	func_to_func->save_mbox = save_mbox;
+
 	rte_spinlock_init(&func_to_func->mbox_lock);
 
 	/* Alloc the memory required by the mailbox. */
@@ -1170,6 +1209,9 @@ hinic3_func_to_func_init(struct hinic3_hwdev *hwdev)
 	free_mbox_info(func_to_func->mbox_send);
 
 alloc_mbox_for_send_err:
+	rte_free(save_mbox);
+alloc_save_mbox_err:
+	hwdev->func_to_func = NULL;
 	rte_free(func_to_func);
 
 	return err;
@@ -1184,5 +1226,6 @@ hinic3_func_to_func_free(struct hinic3_hwdev *hwdev)
 	free_mbox_tlp_buffer(func_to_func);
 	free_mbox_info(func_to_func->mbox_resp);
 	free_mbox_info(func_to_func->mbox_send);
+	rte_free(func_to_func->save_mbox);
 	rte_free(func_to_func);
 }
diff --git a/drivers/net/hinic3/base/hinic3_mbox.h b/drivers/net/hinic3/base/hinic3_mbox.h
index df6de062e2..39016b3098 100644
--- a/drivers/net/hinic3/base/hinic3_mbox.h
+++ b/drivers/net/hinic3/base/hinic3_mbox.h
@@ -15,6 +15,8 @@
 
 #define HINIC3_MAX_PF_FUNCS 32
 
+#define HINIC3_MBOX_SAVE_NUM          20
+
 /* Message header define. */
 #define HINIC3_MSG_HEADER_SRC_GLB_FUNC_IDX_SHIFT 0
 #define HINIC3_MSG_HEADER_STATUS_SHIFT		 13
@@ -150,8 +152,21 @@ enum hinic3_mbox_cb_state {
 	HINIC3_PPF_TO_PF_MBOX_CB_RUNNING
 };
 
+struct mbox_send_info {
+	uint16_t cmd;
+	enum hinic3_mod_type mod;
+	uint8_t send_msg_id;
+};
+
+struct save_mbox_info {
+	struct mbox_send_info send_info[HINIC3_MBOX_SAVE_NUM];
+	uint8_t start;
+	uint8_t count;
+};
+
 struct hinic3_mbox {
 	struct hinic3_hwdev *hwdev;
+	struct save_mbox_info *save_mbox;
 
 	struct hinic3_send_mbox send_mbox;
 
@@ -163,6 +178,9 @@ struct hinic3_mbox {
 	enum mbox_event_state event_flag;
 	/* Lock for mbox event flag. */
 	rte_spinlock_t mbox_lock;
+
+	uint64_t mbox_send_cnt;
+	uint64_t mbox_ack_cnt;
 };
 
 int hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, uint8_t *header,
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index f09b6248a7..70652fd793 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -10,6 +10,7 @@
 #include "base/hinic3_eqs.h"
 #include "base/hinic3_cmdq.h"
 #include "base/hinic3_hwdev.h"
+#include "base/hinic3_mbox.h"
 #include "base/hinic3_hwif.h"
 #include "base/hinic3_hw_cfg.h"
 #include "base/hinic3_hw_comm.h"
@@ -3445,6 +3446,30 @@ hinic3_fec_capability_get(struct rte_eth_dev *dev,
 	return HINIC3_FEC_CAPA_NUM_PER_SPEED;
 }
 
+static int
+hinic3_eth_dev_priv_dump(struct rte_eth_dev *dev, FILE *file)
+{
+	struct hinic3_nic_dev *nic_dev = HINIC3_ETH_DEV_TO_PRIVATE_NIC_DEV(dev);
+	struct hinic3_hwdev *hwdev;
+
+	if (file == NULL)
+		return -EINVAL;
+
+	hwdev = nic_dev->hwdev;
+	if (hwdev == NULL || hwdev->func_to_func == NULL)
+		return 0;
+
+	fprintf(file, "mbox_send_cnt: %" PRIu64 "\n",
+		hwdev->func_to_func->mbox_send_cnt);
+	fprintf(file, "mbox_ack_cnt: %" PRIu64 "\n",
+		hwdev->func_to_func->mbox_ack_cnt);
+
+	hinic3_dump_aeq_info(hwdev);
+	hinic3_dump_aeq_mbox_info(hwdev);
+
+	return 0;
+}
+
 static const struct eth_dev_ops hinic3_pmd_ops = {
 	.dev_configure                 = hinic3_dev_configure,
 	.dev_infos_get                 = hinic3_dev_infos_get,
@@ -3494,6 +3519,7 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.fec_get_capability            = hinic3_fec_capability_get,
 	.fec_get                       = hinic3_fec_get,
 	.fec_set                       = hinic3_fec_set,
+	.eth_dev_priv_dump             = hinic3_eth_dev_priv_dump,
 };
 
 static const struct eth_dev_ops hinic3_pmd_vf_ops = {
@@ -3538,6 +3564,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
+	.eth_dev_priv_dump             = hinic3_eth_dev_priv_dump,
 };
 
 static void hinic3_nic_tx_rx_ops_init(struct hinic3_nic_dev *nic_dev)
-- 
2.33.0

