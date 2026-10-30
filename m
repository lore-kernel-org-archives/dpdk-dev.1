Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BD8606A31F
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=NTz4TZh5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A1D4B40E2E;
	Fri, 30 Oct 2026 15:48:10 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTPS id CD21F40B94
 for <dev@dpdk.org>; Fri, 30 Oct 2026 15:47:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=LolXwtaA+8E162SKsunVSnWZll0kpaxp/3dAplN3U2w=;
 b=NTz4TZh5ix1Vr1+d4Uw+4xade9FrZ/r1chF3yAHFy3nAeG0bZRaI2hQwR4bRiF
 EujIs6/zrJUZboSp3n97Ngp57Rh4MQ9GzrIHM1IpN24rFf4io8AAzzuMCXTYrnA7
 eELu/6FBX31iZmVVEU8VYriztFU1Jd0FckoIgQq2xFdC8=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 14/28] net/hinic3: add mbox message recording and debug dump
Date: Fri, 30 Oct 2026 22:47:18 +0800
Message-ID: <20261030144733.2120-15-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261030144733.2120-1-yejiacheng4@h-partners.com>
References: <20261023155809.855-1-yejiacheng4@h-partners.com>
 <20261030144733.2120-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDHb_EUruRqpJ41BA--.59781S16
X-Coremail-Antispam: 1Uf129KBjvAXoW3tr47tr4DXF45Kw1fGFy3urg_yoW8JF4kto
 WfXFWakF4Fgrn7A34jvFn7ZFs7Xw1DGrn8J39xCanxXay7ury3JFn8Jrn3Ja47X34UCFnr
 AF97G3yktw47Xw4Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzgAwUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNxuFj2rkrhtbjAAA3K
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Provide recorded mbox send/receive history and a dump of it together with
the AEQ state so mailbox timeouts and response mismatches can be diagnosed.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst |  1 +
 drivers/net/hinic3/base/hinic3_eqs.c   | 65 ++++++++++++++++++++++++--
 drivers/net/hinic3/base/hinic3_eqs.h   |  6 ++-
 drivers/net/hinic3/base/hinic3_mbox.c  | 45 ++++++++++++++++++
 drivers/net/hinic3/base/hinic3_mbox.h  | 19 ++++++++
 drivers/net/hinic3/hinic3_ethdev.c     | 28 +++++++++++
 6 files changed, 158 insertions(+), 6 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index fa5b9d68fa..3e9dd6b1e6 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -150,6 +150,7 @@ New Features
 
   * Added CIR drop statistics and VF link aggregation (LAG) support.
   * Added FEC mode get and set support.
+  * Added mailbox message counter reporting through the device private dump API.
 
 * **Updated Intel iavf driver.**
 
diff --git a/drivers/net/hinic3/base/hinic3_eqs.c b/drivers/net/hinic3/base/hinic3_eqs.c
index 1fc78adc85..30b03426aa 100644
--- a/drivers/net/hinic3/base/hinic3_eqs.c
+++ b/drivers/net/hinic3/base/hinic3_eqs.c
@@ -553,7 +553,7 @@ hinic3_aeqs_free(struct hinic3_hwdev *hwdev)
 }
 
 void
-hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev)
+hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev, FILE *file)
 {
 	struct hinic3_aeq_elem *aeqe_pos = NULL;
 	struct hinic3_eq *eq = NULL;
@@ -580,10 +580,65 @@ hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev)
 		addr = HINIC3_CSR_AEQ_PROD_IDX_ADDR;
 		pi = hinic3_hwif_read_reg(hwdev->hwif, addr);
 		aeqe_pos = GET_AEQ_ELEM(eq, eq->cons_idx);
-		PMD_DRV_LOG(ERR,
-			    "Aeq id: %d, idx: %u, ctrl0: 0x%08x, wrap: %d, pi: 0x%x, ci: 0x%08x, desc: 0x%x",
-			    q_id, idx, ctrl0, eq->wrapped, pi, ci,
-			    rte_be_to_cpu_32(aeqe_pos->desc));
+		fprintf(file, "Aeq id: %d, idx: %u, ctrl0: 0x%08x, wrap: %d, pi: 0x%x, ci: 0x%08x, desc: 0x%x\n",
+				q_id, idx, ctrl0, eq->wrapped, pi, ci,
+				rte_be_to_cpu_32(aeqe_pos->desc));
+	}
+}
+
+void
+hinic3_dump_aeq_mbox_info(struct hinic3_hwdev *hwdev, FILE *file)
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
+	fprintf(file, "Sending the latest mbox messages:\n");
+	for (i = 0; i < HINIC3_MBOX_SAVE_NUM; i++) {
+		pos = (hwdev->func_to_func->save_mbox->start + i) % HINIC3_MBOX_SAVE_NUM;
+		fprintf(file, "send_msg_id: %u, cmd: %u, mod: %u\n",
+			save_mbox->send_info[pos].send_msg_id, save_mbox->send_info[pos].cmd,
+			save_mbox->send_info[pos].mod);
+	}
+
+	fprintf(file, "dump aeqe info:\n");
+	fprintf(file, "port: %u, eq cid: %u, func id: %u, bus: %u, devid: %u, wrapped: %u\n",
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
+		fprintf(file, "index: %d, msg_id: %u, mod: %u, cmd: %u, seq_id: %u, seg_len: %u, src_func_idx: %u, event: %u, src: %u, size: %u, wrapped: %u\n",
+			i, msg_id, mod, cmd, seq_id, seg_len, src_func_idx,
+			event, src, size, wrapped);
 	}
 }
 
diff --git a/drivers/net/hinic3/base/hinic3_eqs.h b/drivers/net/hinic3/base/hinic3_eqs.h
index 365c9cbf39..c0a7ca2290 100644
--- a/drivers/net/hinic3/base/hinic3_eqs.h
+++ b/drivers/net/hinic3/base/hinic3_eqs.h
@@ -5,6 +5,8 @@
 #ifndef _HINIC3_EQS_H_
 #define _HINIC3_EQS_H_
 
+#include <stdio.h>
+
 #define HINIC3_MAX_AEQS	    4
 #define HINIC3_MIN_AEQS	    2
 #define HINIC3_EQ_MAX_PAGES 4
@@ -83,7 +85,9 @@ int hinic3_aeqs_init(struct hinic3_hwdev *hwdev);
 
 void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);
 
-void hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev);
+void hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev, FILE *file);
+
+void hinic3_dump_aeq_mbox_info(struct hinic3_hwdev *hwdev, FILE *file);
 
 int hinic3_aeq_poll_msg(struct hinic3_eq *eq, uint32_t timeout, void *param);
 
diff --git a/drivers/net/hinic3/base/hinic3_mbox.c b/drivers/net/hinic3/base/hinic3_mbox.c
index c4ca2ed7ba..6d0d4cce2b 100644
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
@@ -917,6 +946,8 @@ hinic3_mbox_to_func(struct hinic3_mbox *func_to_func, enum hinic3_mod_type mod,
 		*handler_info->out_size = mbox_for_resp->mbox_len;
 	}
 send_err:
+	if (err != 0)
+		func_to_func->mbox_error = true;
 	return err;
 }
 
@@ -1129,6 +1160,16 @@ hinic3_func_to_func_init(struct hinic3_hwdev *hwdev)
 
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
@@ -1170,6 +1211,9 @@ hinic3_func_to_func_init(struct hinic3_hwdev *hwdev)
 	free_mbox_info(func_to_func->mbox_send);
 
 alloc_mbox_for_send_err:
+	rte_free(save_mbox);
+alloc_save_mbox_err:
+	hwdev->func_to_func = NULL;
 	rte_free(func_to_func);
 
 	return err;
@@ -1184,5 +1228,6 @@ hinic3_func_to_func_free(struct hinic3_hwdev *hwdev)
 	free_mbox_tlp_buffer(func_to_func);
 	free_mbox_info(func_to_func->mbox_resp);
 	free_mbox_info(func_to_func->mbox_send);
+	rte_free(func_to_func->save_mbox);
 	rte_free(func_to_func);
 }
diff --git a/drivers/net/hinic3/base/hinic3_mbox.h b/drivers/net/hinic3/base/hinic3_mbox.h
index df6de062e2..8797c19697 100644
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
 
@@ -163,6 +178,10 @@ struct hinic3_mbox {
 	enum mbox_event_state event_flag;
 	/* Lock for mbox event flag. */
 	rte_spinlock_t mbox_lock;
+
+	uint64_t mbox_send_cnt;
+	uint64_t mbox_ack_cnt;
+	bool mbox_error;
 };
 
 int hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, uint8_t *header,
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 42bad3311a..b4eee529af 100644
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
@@ -3501,6 +3502,31 @@ hinic3_fec_capability_get(struct rte_eth_dev *dev,
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
+	hinic3_dump_aeq_info(hwdev, file);
+	if (hwdev->func_to_func->mbox_error)
+		hinic3_dump_aeq_mbox_info(hwdev, file);
+
+	return 0;
+}
+
 static const struct eth_dev_ops hinic3_pmd_ops = {
 	.dev_configure                 = hinic3_dev_configure,
 	.dev_infos_get                 = hinic3_dev_infos_get,
@@ -3550,6 +3576,7 @@ static const struct eth_dev_ops hinic3_pmd_ops = {
 	.fec_get_capability            = hinic3_fec_capability_get,
 	.fec_get                       = hinic3_fec_get,
 	.fec_set                       = hinic3_fec_set,
+	.eth_dev_priv_dump             = hinic3_eth_dev_priv_dump,
 };
 
 static const struct eth_dev_ops hinic3_pmd_vf_ops = {
@@ -3594,6 +3621,7 @@ static const struct eth_dev_ops hinic3_pmd_vf_ops = {
 	.mac_addr_add                  = hinic3_mac_addr_add,
 	.set_mc_addr_list              = hinic3_set_mc_addr_list,
 	.flow_ops_get                  = hinic3_dev_filter_ctrl,
+	.eth_dev_priv_dump             = hinic3_eth_dev_priv_dump,
 };
 
 static void hinic3_nic_tx_rx_ops_init(struct hinic3_nic_dev *nic_dev)
-- 
2.33.0

