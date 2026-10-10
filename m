Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5094CCA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:45:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95696402E2;
	Sat, 10 Oct 2026 16:45:19 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 8EAEB4027F
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=mg193TbeVTzKgGGDA9qprql+XZs3zundM51fRX0eZ/g=;
 b=b64liRB7qFBdymon2l3cEXII/XmkHFJWqIWXoHl5m1arehS/RCl5dVYX2bQaH/
 Hvq1fDMX4c60u+4LH8EIdwD7JMMnVtnm6xqnHaKKnAaOGSgBS+goYF3YQMowxtu+
 SsPUvFoE64E50OGiDoPuDHljASh6bHKzhlXkA3fsCUCzo=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 04/17] net/hinic3: add mbox message recording and debug dump
Date: Sat, 10 Oct 2026 22:44:55 +0800
Message-ID: <20261010144509.2731-5-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S6
X-Coremail-Antispam: 1Uf129KBjvJXoW3Kw4ruw1DZw45GF4DJw4xWFg_yoWDAr4rpF
 45ZF97urZ5Xa17XrnxAa1akay3tw18A348Wa4IkFyY9F1xZFyUAa4UJayqva15Wr1xJF17
 Za10gw4DGF15KwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1iihUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhs-SWrKT3s2EQAA3o
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

Provide recorded mbox send/receive history and a dump of it together with=0D
the AEQ state so mailbox timeouts and response mismatches can be diagnosed.=
=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_eqs.c  | 59 +++++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_eqs.h  |  2 +=0D
 drivers/net/hinic3/base/hinic3_mbox.c | 53 ++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_mbox.h | 22 ++++++++++=0D
 4 files changed, 136 insertions(+)=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_eqs.c b/drivers/net/hinic3/base=
/hinic3_eqs.c=0D
index 1fc78adc85..e961eda374 100644=0D
--- a/drivers/net/hinic3/base/hinic3_eqs.c=0D
+++ b/drivers/net/hinic3/base/hinic3_eqs.c=0D
@@ -587,6 +587,65 @@ hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev)=0D
 	}=0D
 }=0D
 =0D
+void hinic3_dump_aeq_mbox_info(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct save_mbox_info *save_mbox =3D NULL;=0D
+	struct hinic3_eq *aeq =3D NULL;=0D
+	struct hinic3_aeq_elem *aeqe_pos =3D NULL;=0D
+	struct rte_pci_device *pci_dev =3D NULL;=0D
+	struct rte_eth_dev *eth_dev =3D NULL;=0D
+	uint32_t i, pos;=0D
+	uint8_t src, size, wrapped, seq_id, seg_len, msg_id, mod;=0D
+	uint8_t data[HINIC3_AEQE_DATA_SIZE];=0D
+	uint16_t src_func_idx, cmd;=0D
+	uint32_t aeqe_desc;=0D
+	uint64_t mbox_header;=0D
+	enum hinic3_aeq_type event;=0D
+=0D
+	eth_dev =3D &rte_eth_devices[hwdev->port_id];=0D
+	pci_dev =3D RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);=0D
+	save_mbox =3D hwdev->func_to_func->save_mbox;=0D
+	aeq =3D &hwdev->aeqs->aeq[HINIC3_MBOX_RSP_MSG_AEQ];=0D
+=0D
+	PMD_DRV_LOG(ERR, "Sending the latest mbox messages:");=0D
+	for (i =3D 0; i < HINIC3_MBOX_SAVE_NUM; i++) {=0D
+		pos =3D (hwdev->func_to_func->save_mbox->start + i) % HINIC3_MBOX_SAVE_N=
UM;=0D
+		PMD_DRV_LOG(ERR, "send_msg_id: %u, cmd: %u, mod: %u, port: %u, func id: =
%u, bus: %u, devid: %u",=0D
+			save_mbox->send_info[pos].send_msg_id, save_mbox->send_info[pos].cmd,=0D
+			save_mbox->send_info[pos].mod, save_mbox->send_info[pos].port,=0D
+			save_mbox->send_info[pos].func_id, save_mbox->send_info[pos].bus,=0D
+			save_mbox->send_info[pos].devid);=0D
+	}=0D
+=0D
+	PMD_DRV_LOG(ERR, "dump aeqe info:");=0D
+	PMD_DRV_LOG(ERR, "port: %u, eq cid: %u, func id: %u, bus: %u, devid: %u, =
wrapped: %u",=0D
+		hwdev->port_id, aeq->cons_idx, pci_dev->addr.function, pci_dev->addr.bus=
,=0D
+		pci_dev->addr.devid, aeq->wrapped);=0D
+	for (i =3D 0; i < aeq->eq_len; i++) {=0D
+		/* Parsing the data field. */=0D
+		aeqe_pos =3D GET_AEQ_ELEM(aeq, i);=0D
+		aeqe_desc =3D rte_be_to_cpu_32(aeqe_pos->desc);=0D
+		memcpy(data, aeqe_pos->aeqe_data, HINIC3_AEQE_DATA_SIZE);=0D
+		hinic3_be32_to_cpu(data, HINIC3_AEQE_DATA_SIZE);=0D
+		mbox_header =3D *((uint64_t *)data);=0D
+		seq_id =3D HINIC3_MSG_HEADER_GET(mbox_header, SEQID);=0D
+		seg_len =3D HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN);=0D
+		src_func_idx =3D HINIC3_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);=0D
+		msg_id =3D HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID);=0D
+		mod =3D HINIC3_MSG_HEADER_GET(mbox_header, MODULE);=0D
+		cmd =3D HINIC3_MSG_HEADER_GET(mbox_header, CMD);=0D
+		/* Parsing the desc field. */=0D
+		event =3D EQ_ELEM_DESC_GET(aeqe_desc, TYPE);=0D
+		src =3D EQ_ELEM_DESC_GET(aeqe_desc, SRC);=0D
+		size =3D EQ_ELEM_DESC_GET(aeqe_desc, SIZE);=0D
+		wrapped =3D EQ_ELEM_DESC_GET(aeqe_desc, WRAPPED);=0D
+=0D
+		PMD_DRV_LOG(ERR, "index: %d, msg_id: %u, mod: %u, cmd: %u, seq_id: %u, s=
eg_len: %u,"=0D
+			"src_func_idx: %u, event: %u, src: %u, size: %u, wrapped: %u", i, msg_i=
d,=0D
+			mod, cmd, seq_id, seg_len, src_func_idx, event, src, size, wrapped);=0D
+	}=0D
+}=0D
+=0D
 static int=0D
 aeq_elem_handler(struct hinic3_eq *eq, uint32_t aeqe_desc,=0D
 		 struct hinic3_aeq_elem *aeqe_pos, void *param)=0D
diff --git a/drivers/net/hinic3/base/hinic3_eqs.h b/drivers/net/hinic3/base=
/hinic3_eqs.h=0D
index 365c9cbf39..38de79a705 100644=0D
--- a/drivers/net/hinic3/base/hinic3_eqs.h=0D
+++ b/drivers/net/hinic3/base/hinic3_eqs.h=0D
@@ -85,6 +85,8 @@ void hinic3_aeqs_free(struct hinic3_hwdev *hwdev);=0D
 =0D
 void hinic3_dump_aeq_info(struct hinic3_hwdev *hwdev);=0D
 =0D
+void hinic3_dump_aeq_mbox_info(struct hinic3_hwdev *hwdev);=0D
+=0D
 int hinic3_aeq_poll_msg(struct hinic3_eq *eq, uint32_t timeout, void *para=
m);=0D
 =0D
 void hinic3_dev_handle_aeq_event(struct hinic3_hwdev *hwdev, void *param);=
=0D
diff --git a/drivers/net/hinic3/base/hinic3_mbox.c b/drivers/net/hinic3/bas=
e/hinic3_mbox.c=0D
index c4ca2ed7ba..03aa5cfbb2 100644=0D
--- a/drivers/net/hinic3/base/hinic3_mbox.c=0D
+++ b/drivers/net/hinic3/base/hinic3_mbox.c=0D
@@ -711,6 +711,35 @@ send_tlp_mbox_seg(struct hinic3_mbox *func_to_func, ui=
nt64_t header, uint16_t ds=0D
 	return 0;=0D
 }=0D
 =0D
+static void hinic3_record_mbox_info(struct hinic3_mbox *func_to_func,=0D
+				    enum hinic3_mod_type mod, uint16_t cmd,=0D
+				    uint8_t msg_id)=0D
+{=0D
+	struct rte_pci_device *pci_dev =3D NULL;=0D
+	struct rte_eth_dev *eth_dev =3D NULL;=0D
+	struct mbox_send_info send_mbox;=0D
+=0D
+	eth_dev =3D &rte_eth_devices[func_to_func->hwdev->port_id];=0D
+	pci_dev =3D RTE_CLASS_TO_BUS_DEVICE(eth_dev, *pci_dev);=0D
+	send_mbox.cmd =3D cmd;=0D
+	send_mbox.mod =3D mod;=0D
+	send_mbox.port =3D func_to_func->hwdev->port_id;=0D
+	send_mbox.send_msg_id =3D msg_id;=0D
+	send_mbox.func_id =3D pci_dev->addr.function;=0D
+	send_mbox.devid =3D pci_dev->addr.devid;=0D
+	send_mbox.bus =3D pci_dev->addr.bus;=0D
+=0D
+	uint8_t pos =3D (func_to_func->save_mbox->start + func_to_func->save_mbox=
->count) %=0D
+		      HINIC3_MBOX_SAVE_NUM;=0D
+	func_to_func->save_mbox->send_info[pos] =3D send_mbox;=0D
+=0D
+	if (func_to_func->save_mbox->count < HINIC3_MBOX_SAVE_NUM)=0D
+		func_to_func->save_mbox->count++;=0D
+	else=0D
+		func_to_func->save_mbox->start =3D (func_to_func->save_mbox->start + 1) =
%=0D
+						 HINIC3_MBOX_SAVE_NUM;=0D
+}=0D
+=0D
 static int=0D
 send_mbox_to_func(struct hinic3_mbox *func_to_func, enum hinic3_mod_type m=
od,=0D
 		struct hinic3_handler_info *handler_info, struct mbox_msg_info *msg_info=
)=0D
@@ -724,6 +753,9 @@ send_mbox_to_func(struct hinic3_mbox *func_to_func, enu=
m hinic3_mod_type mod,=0D
 =0D
 	rsp_aeq_id =3D HINIC3_MBOX_RSP_MSG_AEQ;=0D
 =0D
+	hinic3_record_mbox_info(func_to_func, mod, handler_info->cmd,=0D
+				msg_info->msg_id);=0D
+=0D
 	/* Set the header message. */=0D
 	header =3D HINIC3_MSG_HEADER_SET(handler_info->in_size, MSG_LEN) |=0D
 		 HINIC3_MSG_HEADER_SET(mod, MODULE) |=0D
@@ -782,6 +814,9 @@ send_tlp_mbox_to_func(struct hinic3_mbox *func_to_func,=
 enum hinic3_mod_type mod=0D
 =0D
 	rsp_aeq_id =3D HINIC3_MBOX_RSP_MSG_AEQ;=0D
 =0D
+	hinic3_record_mbox_info(func_to_func, mod, handler_info->cmd,=0D
+				msg_info->msg_id);=0D
+=0D
 	/* Set the header message. */=0D
 	header =3D HINIC3_MSG_HEADER_SET(MBOX_TLP_HEADER_SZ, MSG_LEN) |=0D
 		 HINIC3_MSG_HEADER_SET(MBOX_TLP_HEADER_SZ, SEG_LEN) |=0D
@@ -873,6 +908,7 @@ hinic3_mbox_to_func(struct hinic3_mbox *func_to_func, e=
num hinic3_mod_type mod,=0D
 		goto send_err;=0D
 	}=0D
 =0D
+	func_to_func->mbox_send_cnt++;=0D
 	/* Wait for the response message. */=0D
 	time =3D timeout ? timeout : HINIC3_MBOX_COMP_TIME;=0D
 	aeq =3D &func_to_func->hwdev->aeqs->aeq[HINIC3_MBOX_RSP_MSG_AEQ];=0D
@@ -880,15 +916,18 @@ hinic3_mbox_to_func(struct hinic3_mbox *func_to_func,=
 enum hinic3_mod_type mod,=0D
 	if (err) {=0D
 		set_mbox_to_func_event(func_to_func, EVENT_TIMEOUT);=0D
 		PMD_DRV_LOG(ERR, "Send mailbox message time out");=0D
+		hinic3_dump_aeq_mbox_info(func_to_func->hwdev);=0D
 		err =3D -ETIMEDOUT;=0D
 		goto send_err;=0D
 	}=0D
 =0D
+	func_to_func->mbox_ack_cnt++;=0D
 	/* Check whether mod and command of the rsp message match the sent messag=
e. */=0D
 	if (mod !=3D mbox_for_resp->mod || handler_info->cmd !=3D mbox_for_resp->=
cmd) {=0D
 		PMD_DRV_LOG(ERR,=0D
 			    "Invalid response mbox message, mod: 0x%x, cmd: 0x%x, expect mod: 0=
x%x, cmd: 0x%x",=0D
 			    mbox_for_resp->mod, mbox_for_resp->cmd, mod, handler_info->cmd);=0D
+		hinic3_dump_aeq_mbox_info(func_to_func->hwdev);=0D
 		err =3D -EFAULT;=0D
 		goto send_err;=0D
 	}=0D
@@ -1129,6 +1168,16 @@ hinic3_func_to_func_init(struct hinic3_hwdev *hwdev)=
=0D
 =0D
 	hwdev->func_to_func =3D func_to_func;=0D
 	func_to_func->hwdev =3D hwdev;=0D
+=0D
+	struct save_mbox_info *save_mbox =3D rte_zmalloc("save_mbox_info",=0D
+						      sizeof(struct save_mbox_info), 0);=0D
+	if (!save_mbox) {=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_save_mbox_err;=0D
+	}=0D
+=0D
+	func_to_func->save_mbox =3D save_mbox;=0D
+=0D
 	rte_spinlock_init(&func_to_func->mbox_lock);=0D
 =0D
 	/* Alloc the memory required by the mailbox. */=0D
@@ -1170,6 +1219,9 @@ hinic3_func_to_func_init(struct hinic3_hwdev *hwdev)=
=0D
 	free_mbox_info(func_to_func->mbox_send);=0D
 =0D
 alloc_mbox_for_send_err:=0D
+	rte_free(save_mbox);=0D
+alloc_save_mbox_err:=0D
+	hwdev->func_to_func =3D NULL;=0D
 	rte_free(func_to_func);=0D
 =0D
 	return err;=0D
@@ -1184,5 +1236,6 @@ hinic3_func_to_func_free(struct hinic3_hwdev *hwdev)=
=0D
 	free_mbox_tlp_buffer(func_to_func);=0D
 	free_mbox_info(func_to_func->mbox_resp);=0D
 	free_mbox_info(func_to_func->mbox_send);=0D
+	rte_free(func_to_func->save_mbox);=0D
 	rte_free(func_to_func);=0D
 }=0D
diff --git a/drivers/net/hinic3/base/hinic3_mbox.h b/drivers/net/hinic3/bas=
e/hinic3_mbox.h=0D
index df6de062e2..c0ee700ae6 100644=0D
--- a/drivers/net/hinic3/base/hinic3_mbox.h=0D
+++ b/drivers/net/hinic3/base/hinic3_mbox.h=0D
@@ -15,6 +15,8 @@=0D
 =0D
 #define HINIC3_MAX_PF_FUNCS 32=0D
 =0D
+#define HINIC3_MBOX_SAVE_NUM          20=0D
+=0D
 /* Message header define. */=0D
 #define HINIC3_MSG_HEADER_SRC_GLB_FUNC_IDX_SHIFT 0=0D
 #define HINIC3_MSG_HEADER_STATUS_SHIFT		 13=0D
@@ -150,8 +152,25 @@ enum hinic3_mbox_cb_state {=0D
 	HINIC3_PPF_TO_PF_MBOX_CB_RUNNING=0D
 };=0D
 =0D
+struct mbox_send_info {=0D
+	uint16_t cmd;=0D
+	enum hinic3_mod_type mod;=0D
+	uint8_t send_msg_id;=0D
+	uint8_t port;=0D
+	uint8_t func_id;=0D
+	uint8_t devid;=0D
+	uint8_t bus;=0D
+};=0D
+=0D
+struct save_mbox_info {=0D
+	struct mbox_send_info send_info[HINIC3_MBOX_SAVE_NUM];=0D
+	uint8_t start;=0D
+	uint8_t count;=0D
+};=0D
+=0D
 struct hinic3_mbox {=0D
 	struct hinic3_hwdev *hwdev;=0D
+	struct save_mbox_info *save_mbox;=0D
 =0D
 	struct hinic3_send_mbox send_mbox;=0D
 =0D
@@ -163,6 +182,9 @@ struct hinic3_mbox {=0D
 	enum mbox_event_state event_flag;=0D
 	/* Lock for mbox event flag. */=0D
 	rte_spinlock_t mbox_lock;=0D
+=0D
+	uint64_t mbox_send_cnt;=0D
+	uint64_t mbox_ack_cnt;=0D
 };=0D
 =0D
 int hinic3_mbox_func_aeqe_handler(struct hinic3_hwdev *hwdev, uint8_t *hea=
der,=0D
-- =0D
2.33.0=0D
=0D

