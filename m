Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A27CA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:42:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C15B40A77;
	Sat, 30 Aug 2025 14:41:06 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 2892A40670
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=GNW5TlVFx7Rv666rXYQUARZGa3JpFpURmAaB0TwoDiI=;
 b=TFS4g/YXmxdH4fQh4rt5yNDvuAWcRV2IU4SDfYxsEQFIP7xT9zMRTrjVZT8MIE
 GhF3BBSKfgqSW9VXBPPA0yZ5ozvQeejvbSHZPHLEn7thElKC1pLbz0PNUKBVx9EP
 JsVSFIanWKXXq37nHm3yyY3VjlPmp1VXLblsB5e4PyEZo=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S15;
 Sat, 30 Aug 2025 20:40:59 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 11/18] net/hinic3: add a mailbox communication module
Date: Sat, 30 Aug 2025 20:39:23 +0800
Message-ID: <20250830123942.5037-12-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S15
X-Coremail-Antispam: 1Uf129KBjvAXoWDGr1rGryDAryruF4kJrW7twb_yoW7Jw15Ko
 WxXFW3tFWFvrn7AryYvas7Xa97Xrs8WFy3K3yruw4fWFWxJryFq3W3GwnxXas3Xr4UAF17
 JF90gFyvkwsrJwn8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7oUqUUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiJg+5Cmiyr99mcgAAsk
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

From: Yi Chen <chenyi221@huawei.com>=0D

This patch adds support for mailbox of hinic3 PMD driver,=0D
mailbox is used for communication between PF/VF driver and MPU.=0D
This patch provides mailbox-related data structures and functional=0D
code.=0D
=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_mbox.c | 1399 +++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_mbox.h |  199 ++++=0D
 2 files changed, 1598 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_mbox.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_mbox.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_mbox.c b/drivers/net/hinic3/bas=
e/hinic3_mbox.c=0D
new file mode 100644=0D
index 0000000000..845ab9cfc3=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_mbox.c=0D
@@ -0,0 +1,1399 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_atomic.h>=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_csr.h"=0D
+#include "hinic3_eqs.h"=0D
+#include "hinic3_hw_cfg.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mbox.h"=0D
+#include "hinic3_mgmt.h"=0D
+#include "hinic3_nic_event.h"=0D
+=0D
+#define HINIC3_MBOX_INT_DST_FUNC_SHIFT	    0=0D
+#define HINIC3_MBOX_INT_DST_AEQN_SHIFT	    10=0D
+#define HINIC3_MBOX_INT_SRC_RESP_AEQN_SHIFT 12=0D
+#define HINIC3_MBOX_INT_STAT_DMA_SHIFT	    14=0D
+/* The size of data to be send (unit of 4 bytes). */=0D
+#define HINIC3_MBOX_INT_TX_SIZE_SHIFT 20=0D
+/* SO_RO(strong order, relax order). */=0D
+#define HINIC3_MBOX_INT_STAT_DMA_SO_RO_SHIFT 25=0D
+#define HINIC3_MBOX_INT_WB_EN_SHIFT	     28=0D
+=0D
+#define HINIC3_MBOX_INT_DST_AEQN_MASK	    0x3=0D
+#define HINIC3_MBOX_INT_SRC_RESP_AEQN_MASK  0x3=0D
+#define HINIC3_MBOX_INT_STAT_DMA_MASK	    0x3F=0D
+#define HINIC3_MBOX_INT_TX_SIZE_MASK	    0x1F=0D
+#define HINIC3_MBOX_INT_STAT_DMA_SO_RO_MASK 0x3=0D
+#define HINIC3_MBOX_INT_WB_EN_MASK	    0x1=0D
+=0D
+#define HINIC3_MBOX_INT_SET(val, field)           \=0D
+	(((val) & HINIC3_MBOX_INT_##field##_MASK) \=0D
+	 << HINIC3_MBOX_INT_##field##_SHIFT)=0D
+=0D
+enum hinic3_mbox_tx_status {=0D
+	TX_NOT_DONE =3D 1,=0D
+};=0D
+=0D
+#define HINIC3_MBOX_CTRL_TRIGGER_AEQE_SHIFT 0=0D
+=0D
+/*=0D
+ * Specifies the issue request for the message data.=0D
+ * 0 - Tx request is done;=0D
+ * 1 - Tx request is in process.=0D
+ */=0D
+#define HINIC3_MBOX_CTRL_TX_STATUS_SHIFT 1=0D
+#define HINIC3_MBOX_CTRL_DST_FUNC_SHIFT	 16=0D
+=0D
+#define HINIC3_MBOX_CTRL_TRIGGER_AEQE_MASK 0x1=0D
+#define HINIC3_MBOX_CTRL_TX_STATUS_MASK	   0x1=0D
+#define HINIC3_MBOX_CTRL_DST_FUNC_MASK	   0x1FFF=0D
+=0D
+#define HINIC3_MBOX_CTRL_SET(val, field)           \=0D
+	(((val) & HINIC3_MBOX_CTRL_##field##_MASK) \=0D
+	 << HINIC3_MBOX_CTRL_##field##_SHIFT)=0D
+=0D
+#define MBOX_SEGLEN_MASK \=0D
+	HINIC3_MSG_HEADER_SET(HINIC3_MSG_HEADER_SEG_LEN_MASK, SEG_LEN)=0D
+=0D
+#define MBOX_MSG_POLLING_TIMEOUT 500000 /* Unit is 10us. */=0D
+#define HINIC3_MBOX_COMP_TIME	 40000U=0D
+=0D
+#define MBOX_MAX_BUF_SZ	      2048UL=0D
+#define MBOX_HEADER_SZ	      8=0D
+#define HINIC3_MBOX_DATA_SIZE (MBOX_MAX_BUF_SZ - MBOX_HEADER_SZ)=0D
+=0D
+#define MBOX_TLP_HEADER_SZ 16=0D
+=0D
+/* Mbox size is 64B, 8B for mbox_header, 8B reserved. */=0D
+#define MBOX_SEG_LEN	   48=0D
+#define MBOX_SEG_LEN_ALIGN 4=0D
+#define MBOX_WB_STATUS_LEN 16UL=0D
+=0D
+/* Mbox write back status is 16B, only first 4B is used. */=0D
+#define MBOX_WB_STATUS_ERRCODE_MASK	 0xFFFF=0D
+#define MBOX_WB_STATUS_MASK		 0xFF=0D
+#define MBOX_WB_ERROR_CODE_MASK		 0xFF00=0D
+#define MBOX_WB_STATUS_FINISHED_SUCCESS	 0xFF=0D
+#define MBOX_WB_STATUS_FINISHED_WITH_ERR 0xFE=0D
+#define MBOX_WB_STATUS_NOT_FINISHED	 0x00=0D
+=0D
+/* Determine the write back status. */=0D
+#define MBOX_STATUS_FINISHED(wb) \=0D
+	(((wb) & MBOX_WB_STATUS_MASK) !=3D MBOX_WB_STATUS_NOT_FINISHED)=0D
+#define MBOX_STATUS_SUCCESS(wb) \=0D
+	(((wb) & MBOX_WB_STATUS_MASK) =3D=3D MBOX_WB_STATUS_FINISHED_SUCCESS)=0D
+#define MBOX_STATUS_ERRCODE(wb) ((wb) & MBOX_WB_ERROR_CODE_MASK)=0D
+=0D
+/* Indicate the value related to the sequence ID. */=0D
+#define SEQ_ID_START_VAL 0=0D
+#define SEQ_ID_MAX_VAL	 42=0D
+=0D
+#define DST_AEQ_IDX_DEFAULT_VAL 0=0D
+#define SRC_AEQ_IDX_DEFAULT_VAL 0=0D
+#define NO_DMA_ATTRIBUTE_VAL	0=0D
+=0D
+#define MBOX_MSG_NO_DATA_LEN 1=0D
+=0D
+/* Obtain the specified content of the mailbox. */=0D
+#define MBOX_BODY_FROM_HDR(header) ((u8 *)(header) + MBOX_HEADER_SZ)=0D
+#define MBOX_AREA(hwif) \=0D
+	((hwif)->cfg_regs_base + HINIC3_FUNC_CSR_MAILBOX_DATA_OFF)=0D
+=0D
+#define IS_PF_OR_PPF_SRC(src_func_idx) ((src_func_idx) < HINIC3_MAX_PF_FUN=
CS)=0D
+=0D
+#define MBOX_RESPONSE_ERROR	  0x1=0D
+#define MBOX_MSG_ID_MASK	  0xF=0D
+#define MBOX_MSG_ID(func_to_func) ((func_to_func)->send_msg_id)=0D
+#define MBOX_MSG_ID_INC(func_to_func)                             \=0D
+	({                                                        \=0D
+		typeof(func_to_func) __func =3D (func_to_func);     \=0D
+		MBOX_MSG_ID(__func) =3D (MBOX_MSG_ID(__func) + 1) & \=0D
+				      MBOX_MSG_ID_MASK;           \=0D
+	})=0D
+=0D
+/* Max message counter waits to process for one function. */=0D
+#define HINIC3_MAX_MSG_CNT_TO_PROCESS 10=0D
+=0D
+enum mbox_ordering_type {=0D
+	STRONG_ORDER,=0D
+};=0D
+=0D
+enum mbox_write_back_type {=0D
+	WRITE_BACK =3D 1,=0D
+};=0D
+=0D
+enum mbox_aeq_trig_type {=0D
+	NOT_TRIGGER,=0D
+	TRIGGER,=0D
+};=0D
+=0D
+static int send_mbox_to_func(struct hinic3_mbox *func_to_func,=0D
+			     enum hinic3_mod_type mod, u16 cmd, void *msg,=0D
+			     u16 msg_len, u16 dst_func,=0D
+			     enum hinic3_msg_direction_type direction,=0D
+			     enum hinic3_msg_ack_type ack_type,=0D
+			     struct mbox_msg_info *msg_info);=0D
+static int send_tlp_mbox_to_func(struct hinic3_mbox *func_to_func,=0D
+				 enum hinic3_mod_type mod, u16 cmd, void *msg,=0D
+				 u16 msg_len, u16 dst_func,=0D
+				 enum hinic3_msg_direction_type direction,=0D
+				 enum hinic3_msg_ack_type ack_type,=0D
+				 struct mbox_msg_info *msg_info);=0D
+=0D
+static int=0D
+recv_vf_mbox_handler(struct hinic3_mbox *func_to_func,=0D
+		     struct hinic3_recv_mbox *recv_mbox, void *buf_out,=0D
+		     u16 *out_size, __rte_unused void *param)=0D
+{=0D
+	int err =3D 0;=0D
+=0D
+	/*=0D
+	 * Invoke the corresponding processing function according to the type of=
=0D
+	 * the received mailbox.=0D
+	 */=0D
+	switch (recv_mbox->mod) {=0D
+	case HINIC3_MOD_COMM:=0D
+		err =3D vf_handle_pf_comm_mbox(func_to_func->hwdev, func_to_func,=0D
+					     recv_mbox->cmd, recv_mbox->mbox,=0D
+					     recv_mbox->mbox_len, buf_out,=0D
+					     out_size);=0D
+		break;=0D
+	case HINIC3_MOD_CFGM:=0D
+		err =3D cfg_mbx_vf_proc_msg(func_to_func->hwdev,=0D
+			func_to_func->hwdev->cfg_mgmt,=0D
+			recv_mbox->cmd, recv_mbox->mbox, recv_mbox->mbox_len,=0D
+			buf_out, out_size);=0D
+		break;=0D
+	case HINIC3_MOD_L2NIC:=0D
+		err =3D hinic3_vf_event_handler(func_to_func->hwdev,=0D
+			func_to_func->hwdev->cfg_mgmt,=0D
+			recv_mbox->cmd, recv_mbox->mbox, recv_mbox->mbox_len,=0D
+			buf_out, out_size);=0D
+		break;=0D
+	case HINIC3_MOD_HILINK:=0D
+		err =3D hinic3_vf_mag_event_handler(func_to_func->hwdev,=0D
+			func_to_func->hwdev->cfg_mgmt,=0D
+			recv_mbox->cmd, recv_mbox->mbox, recv_mbox->mbox_len,=0D
+			buf_out, out_size);=0D
+		break;=0D
+	default:=0D
+		PMD_DRV_LOG(ERR, "No handler, mod: %d", recv_mbox->mod);=0D
+		err =3D HINIC3_MBOX_VF_CMD_ERROR;=0D
+		break;=0D
+	}=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Respond to the accept packet, construct a response message, and send it=
.=0D
+ *=0D
+ * @param[in] func_to_func=0D
+ * Context for inter-function communication.=0D
+ * @param[in] recv_mbox=0D
+ * Pointer to the received inter-function mailbox structure.=0D
+ * @param[in] err=0D
+ * Error Code.=0D
+ * @param[in] out_size=0D
+ * Output Size.=0D
+ * @param[in] src_func_idx=0D
+ * Index of the source function.=0D
+ */=0D
+static void=0D
+response_for_recv_func_mbox(struct hinic3_mbox *func_to_func,=0D
+			    struct hinic3_recv_mbox *recv_mbox, int err,=0D
+			    u16 out_size, u16 src_func_idx)=0D
+{=0D
+	struct mbox_msg_info msg_info =3D {0};=0D
+=0D
+	if (recv_mbox->ack_type =3D=3D HINIC3_MSG_ACK) {=0D
+		msg_info.msg_id =3D recv_mbox->msg_info.msg_id;=0D
+		if (err)=0D
+			msg_info.status =3D HINIC3_MBOX_PF_SEND_ERR;=0D
+=0D
+		/* Select the sending function based on the packet type. */=0D
+		if (IS_TLP_MBX(src_func_idx))=0D
+			send_tlp_mbox_to_func(func_to_func, recv_mbox->mod,=0D
+					      recv_mbox->cmd,=0D
+					      recv_mbox->buf_out, out_size,=0D
+					      src_func_idx, HINIC3_MSG_RESPONSE,=0D
+					      HINIC3_MSG_NO_ACK, &msg_info);=0D
+		else=0D
+			send_mbox_to_func(func_to_func, recv_mbox->mod,=0D
+					  recv_mbox->cmd, recv_mbox->buf_out,=0D
+					  out_size, src_func_idx,=0D
+					  HINIC3_MSG_RESPONSE,=0D
+					  HINIC3_MSG_NO_ACK, &msg_info);=0D
+	}=0D
+}=0D
+=0D
+static bool=0D
+check_func_mbox_ack_first(u8 mod)=0D
+{=0D
+	return mod =3D=3D HINIC3_MOD_HILINK;=0D
+}=0D
+=0D
+static void=0D
+recv_func_mbox_handler(struct hinic3_mbox *func_to_func,=0D
+		       struct hinic3_recv_mbox *recv_mbox, u16 src_func_idx,=0D
+		       void *param)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D func_to_func->hwdev;=0D
+	void *buf_out =3D recv_mbox->buf_out;=0D
+	bool ack_first =3D false;=0D
+	u16 out_size =3D MBOX_MAX_BUF_SZ;=0D
+	int err =3D 0;=0D
+	/* Check whether the response is the first ACK message. */=0D
+	ack_first =3D check_func_mbox_ack_first(recv_mbox->mod);=0D
+	if (ack_first && recv_mbox->ack_type =3D=3D HINIC3_MSG_ACK) {=0D
+		response_for_recv_func_mbox(func_to_func, recv_mbox, err,=0D
+					    out_size, src_func_idx);=0D
+	}=0D
+=0D
+	/* Processe mailbox information in the VF. */=0D
+	if (HINIC3_IS_VF(hwdev)) {=0D
+		err =3D recv_vf_mbox_handler(func_to_func, recv_mbox, buf_out,=0D
+					   &out_size, param);=0D
+	} else {=0D
+		err =3D -EINVAL;=0D
+		PMD_DRV_LOG(ERR,=0D
+			"PMD doesn't support non-VF handle mailbox message");=0D
+	}=0D
+=0D
+	if (!out_size || err)=0D
+		out_size =3D MBOX_MSG_NO_DATA_LEN;=0D
+=0D
+	if (!ack_first && recv_mbox->ack_type =3D=3D HINIC3_MSG_ACK) {=0D
+		response_for_recv_func_mbox(func_to_func, recv_mbox, err,=0D
+					    out_size, src_func_idx);=0D
+	}=0D
+}=0D
+=0D
+/**=0D
+ * Processe mailbox responses from functions.=0D
+ *=0D
+ * @param[in] func_to_func=0D
+ * Mailbox for inter-function communication.=0D
+ * @param[in] recv_mbox=0D
+ * Received mailbox message.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+resp_mbox_handler(struct hinic3_mbox *func_to_func,=0D
+		  struct hinic3_recv_mbox *recv_mbox)=0D
+{=0D
+	int ret;=0D
+	rte_spinlock_lock(&func_to_func->mbox_lock);=0D
+	if (recv_mbox->msg_info.msg_id =3D=3D func_to_func->send_msg_id &&=0D
+	    func_to_func->event_flag =3D=3D EVENT_START) {=0D
+		func_to_func->event_flag =3D EVENT_SUCCESS;=0D
+		ret =3D 0;=0D
+	} else {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Mbox response timeout, current send msg id(0x%x), "=0D
+			    "recv msg id(0x%x), status(0x%x)",=0D
+			    func_to_func->send_msg_id,=0D
+			    recv_mbox->msg_info.msg_id,=0D
+			    recv_mbox->msg_info.status);=0D
+		ret =3D HINIC3_MSG_HANDLER_RES;=0D
+	}=0D
+	rte_spinlock_unlock(&func_to_func->mbox_lock);=0D
+	return ret;=0D
+}=0D
+=0D
+/**=0D
+ * Check whether the received mailbox message segment is valid.=0D
+ *=0D
+ * @param[out] recv_mbox=0D
+ * Received mailbox message.=0D
+ * @param[in] mbox_header=0D
+ * Mailbox header.=0D
+ * @return=0D
+ * The value true indicates valid, and the value false indicates invalid.=
=0D
+ */=0D
+static bool=0D
+check_mbox_segment(struct hinic3_recv_mbox *recv_mbox, u64 mbox_header)=0D
+{=0D
+	u8 seq_id, seg_len, msg_id, mod;=0D
+	u16 src_func_idx, cmd;=0D
+=0D
+	/* Get info from the mailbox header. */=0D
+	seq_id =3D HINIC3_MSG_HEADER_GET(mbox_header, SEQID);=0D
+	seg_len =3D HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN);=0D
+	src_func_idx =3D HINIC3_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);=0D
+	msg_id =3D HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID);=0D
+	mod =3D HINIC3_MSG_HEADER_GET(mbox_header, MODULE);=0D
+	cmd =3D HINIC3_MSG_HEADER_GET(mbox_header, CMD);=0D
+=0D
+	if (seq_id > SEQ_ID_MAX_VAL || seg_len > MBOX_SEG_LEN)=0D
+		goto seg_err;=0D
+=0D
+	/* New message segment, which saves its information to recv_mbox. */=0D
+	if (seq_id =3D=3D 0) {=0D
+		recv_mbox->seq_id =3D seq_id;=0D
+		recv_mbox->msg_info.msg_id =3D msg_id;=0D
+		recv_mbox->mod =3D mod;=0D
+		recv_mbox->cmd =3D cmd;=0D
+	} else {=0D
+		if ((seq_id !=3D recv_mbox->seq_id + 1) ||=0D
+		    msg_id !=3D recv_mbox->msg_info.msg_id ||=0D
+		    mod !=3D recv_mbox->mod || cmd !=3D recv_mbox->cmd)=0D
+			goto seg_err;=0D
+=0D
+		recv_mbox->seq_id =3D seq_id;=0D
+	}=0D
+=0D
+	return true;=0D
+=0D
+seg_err:=0D
+	PMD_DRV_LOG(ERR,=0D
+		    "Mailbox segment check failed, src func id: 0x%x, "=0D
+		    "front seg info: seq id: 0x%x, msg id: 0x%x, mod: 0x%x, "=0D
+		    "cmd: 0x%x",=0D
+		    src_func_idx, recv_mbox->seq_id, recv_mbox->msg_info.msg_id,=0D
+		    recv_mbox->mod, recv_mbox->cmd);=0D
+	PMD_DRV_LOG(ERR,=0D
+		    "Current seg info: seg len: 0x%x, seq id: 0x%x, "=0D
+		    "msg id: 0x%x, mod: 0x%x, cmd: 0x%x",=0D
+		    seg_len, seq_id, msg_id, mod, cmd);=0D
+=0D
+	return false;=0D
+}=0D
+=0D
+static int=0D
+recv_mbox_handler(struct hinic3_mbox *func_to_func, void *header,=0D
+		  struct hinic3_recv_mbox *recv_mbox, void *param)=0D
+{=0D
+	u64 mbox_header =3D *((u64 *)header);=0D
+	void *mbox_body =3D MBOX_BODY_FROM_HDR(header);=0D
+	u16 src_func_idx;=0D
+	int pos;=0D
+	u8 seq_id;=0D
+	/* Obtain information from the mailbox header. */=0D
+	seq_id =3D HINIC3_MSG_HEADER_GET(mbox_header, SEQID);=0D
+	src_func_idx =3D HINIC3_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);=0D
+=0D
+	if (!check_mbox_segment(recv_mbox, mbox_header)) {=0D
+		recv_mbox->seq_id =3D SEQ_ID_MAX_VAL;=0D
+		return HINIC3_MSG_HANDLER_RES;=0D
+	}=0D
+=0D
+	pos =3D seq_id * MBOX_SEG_LEN;=0D
+	memcpy((void *)((u8 *)recv_mbox->mbox + pos), (void *)mbox_body,=0D
+	       (size_t)HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN));=0D
+=0D
+	if (!HINIC3_MSG_HEADER_GET(mbox_header, LAST))=0D
+		return HINIC3_MSG_HANDLER_RES;=0D
+	/* Setting the information about the recv mailbox. */=0D
+	recv_mbox->cmd =3D HINIC3_MSG_HEADER_GET(mbox_header, CMD);=0D
+	recv_mbox->mod =3D HINIC3_MSG_HEADER_GET(mbox_header, MODULE);=0D
+	recv_mbox->mbox_len =3D HINIC3_MSG_HEADER_GET(mbox_header, MSG_LEN);=0D
+	recv_mbox->ack_type =3D HINIC3_MSG_HEADER_GET(mbox_header, NO_ACK);=0D
+	recv_mbox->msg_info.msg_id =3D HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID)=
;=0D
+	recv_mbox->msg_info.status =3D HINIC3_MSG_HEADER_GET(mbox_header, STATUS)=
;=0D
+	recv_mbox->seq_id =3D SEQ_ID_MAX_VAL;=0D
+=0D
+	/*=0D
+	 * If the received message is a response message, call the mbox response=
=0D
+	 * processing function.=0D
+	 */=0D
+	if (HINIC3_MSG_HEADER_GET(mbox_header, DIRECTION) =3D=3D=0D
+	    HINIC3_MSG_RESPONSE) {=0D
+		return resp_mbox_handler(func_to_func, recv_mbox);=0D
+	}=0D
+=0D
+	recv_func_mbox_handler(func_to_func, recv_mbox, src_func_idx, param);=0D
+	return HINIC3_MSG_HANDLER_RES;=0D
+}=0D
+=0D
+static inline int=0D
+hinic3_mbox_get_index(int func)=0D
+{=0D
+	return (func =3D=3D HINIC3_MGMT_SRC_ID) ? HINIC3_MBOX_MPU_INDEX=0D
+					    : HINIC3_MBOX_PF_INDEX;=0D
+}=0D
+=0D
+int=0D
+hinic3_mbox_func_aeqe_handler(void *handle, u8 *header, __rte_unused u8 si=
ze,=0D
+			      void *param)=0D
+{=0D
+	struct hinic3_mbox *func_to_func =3D NULL;=0D
+	struct hinic3_recv_mbox *recv_mbox =3D NULL;=0D
+	u64 mbox_header =3D *((u64 *)header);=0D
+	u64 src, dir;=0D
+	/* Obtain the mailbox for communication between functions. */=0D
+	func_to_func =3D ((struct hinic3_hwdev *)handle)->func_to_func;=0D
+=0D
+	dir =3D HINIC3_MSG_HEADER_GET(mbox_header, DIRECTION);=0D
+	src =3D HINIC3_MSG_HEADER_GET(mbox_header, SRC_GLB_FUNC_IDX);=0D
+=0D
+	src =3D hinic3_mbox_get_index((int)src);=0D
+	recv_mbox =3D (dir =3D=3D HINIC3_MSG_DIRECT_SEND)=0D
+			    ? &func_to_func->mbox_send[src]=0D
+			    : &func_to_func->mbox_resp[src];=0D
+	/* Processing Received Mailbox info. */=0D
+	return recv_mbox_handler(func_to_func, (u64 *)header, recv_mbox, param);=
=0D
+}=0D
+=0D
+static void=0D
+clear_mbox_status(struct hinic3_send_mbox *mbox)=0D
+{=0D
+	*mbox->wb_status =3D 0;=0D
+=0D
+	/* Clear mailbox write back status. */=0D
+	rte_atomic_thread_fence(rte_memory_order_release);=0D
+}=0D
+=0D
+static void=0D
+mbox_copy_header(struct hinic3_send_mbox *mbox, u64 *header)=0D
+{=0D
+	u32 *data =3D (u32 *)header;=0D
+	u32 i, idx_max =3D MBOX_HEADER_SZ / sizeof(u32);=0D
+=0D
+	for (i =3D 0; i < idx_max; i++) {=0D
+		rte_write32(cpu_to_be32(*(data + i)),=0D
+			    mbox->data + i * sizeof(u32));=0D
+	}=0D
+}=0D
+=0D
+#define MBOX_DMA_MSG_INIT_XOR_VAL 0x5a5a5a5a=0D
+static u32=0D
+mbox_dma_msg_xor(u32 *data, u16 msg_len)=0D
+{=0D
+	u32 xor =3D MBOX_DMA_MSG_INIT_XOR_VAL;=0D
+	u16 dw_len =3D msg_len / sizeof(u32);=0D
+	u16 i;=0D
+=0D
+	for (i =3D 0; i < dw_len; i++)=0D
+		xor ^=3D data[i];=0D
+=0D
+	return xor;=0D
+}=0D
+=0D
+static void=0D
+mbox_copy_send_data_addr(struct hinic3_send_mbox *mbox, u16 seg_len)=0D
+{=0D
+	u32 addr_h, addr_l, xor;=0D
+=0D
+	xor =3D mbox_dma_msg_xor(mbox->sbuff_vaddr, seg_len);=0D
+	addr_h =3D upper_32_bits(mbox->sbuff_paddr);=0D
+	addr_l =3D lower_32_bits(mbox->sbuff_paddr);=0D
+=0D
+	rte_write32(cpu_to_be32(xor), mbox->data + MBOX_HEADER_SZ);=0D
+	rte_write32(cpu_to_be32(addr_h),=0D
+		    mbox->data + MBOX_HEADER_SZ + sizeof(u32));=0D
+	rte_write32(cpu_to_be32(addr_l),=0D
+		    mbox->data + MBOX_HEADER_SZ + 0x2 * sizeof(u32));=0D
+	rte_write32(cpu_to_be32((u32)seg_len),=0D
+		    mbox->data + MBOX_HEADER_SZ + 0x3 * sizeof(u32));=0D
+	/* Reserved field. */=0D
+	rte_write32(0, mbox->data + MBOX_HEADER_SZ + 0x4 * sizeof(u32));=0D
+	rte_write32(0, mbox->data + MBOX_HEADER_SZ + 0x5 * sizeof(u32));=0D
+}=0D
+=0D
+static void=0D
+mbox_copy_send_data(struct hinic3_send_mbox *mbox, void *seg, u16 seg_len)=
=0D
+{=0D
+	u32 *data =3D seg;=0D
+	u32 data_len, chk_sz =3D sizeof(u32);=0D
+	u32 i, idx_max;=0D
+	u8 mbox_max_buf[MBOX_SEG_LEN] =3D {0};=0D
+=0D
+	/* The mbox message should be aligned in 4 bytes. */=0D
+	if (seg_len % chk_sz) {=0D
+		if (seg_len <=3D sizeof(mbox_max_buf)) {=0D
+			memcpy(mbox_max_buf, seg, seg_len);=0D
+			data =3D (u32 *)mbox_max_buf;=0D
+		} else {=0D
+			PMD_DRV_LOG(ERR, "mbox_max_buf overflow: seg_len=3D%u.", seg_len);=0D
+			return;=0D
+		}=0D
+	}=0D
+=0D
+	data_len =3D seg_len;=0D
+	idx_max =3D RTE_ALIGN(data_len, chk_sz) / chk_sz;=0D
+=0D
+	for (i =3D 0; i < idx_max; i++) {=0D
+		rte_write32(cpu_to_be32(*(data + i)),=0D
+			    mbox->data + MBOX_HEADER_SZ + i * sizeof(u32));=0D
+	}=0D
+}=0D
+=0D
+static void=0D
+write_mbox_msg_attr(struct hinic3_mbox *func_to_func, u16 dst_func,=0D
+		    u16 dst_aeqn, u16 seg_len)=0D
+{=0D
+	u32 mbox_int, mbox_ctrl;=0D
+=0D
+	/* If VF, function ids must self-learning by HW(PPF=3D1 PF=3D0). */=0D
+	if (HINIC3_IS_VF(func_to_func->hwdev) &&=0D
+	    dst_func !=3D HINIC3_MGMT_SRC_ID) {=0D
+		if (dst_func =3D=3D HINIC3_HWIF_PPF_IDX(func_to_func->hwdev->hwif))=0D
+			dst_func =3D 1;=0D
+		else=0D
+			dst_func =3D 0;=0D
+	}=0D
+	/* Set the interrupt attribute of the mailbox. */=0D
+	mbox_int =3D HINIC3_MBOX_INT_SET(dst_aeqn, DST_AEQN) |=0D
+		   HINIC3_MBOX_INT_SET(0, SRC_RESP_AEQN) |=0D
+		   HINIC3_MBOX_INT_SET(NO_DMA_ATTRIBUTE_VAL, STAT_DMA) |=0D
+		   HINIC3_MBOX_INT_SET(RTE_ALIGN(seg_len + MBOX_HEADER_SZ,=0D
+						 MBOX_SEG_LEN_ALIGN) >>=0D
+					       2,=0D
+				       TX_SIZE) |=0D
+		   HINIC3_MBOX_INT_SET(STRONG_ORDER, STAT_DMA_SO_RO) |=0D
+		   HINIC3_MBOX_INT_SET(WRITE_BACK, WB_EN);=0D
+=0D
+	/* The interrupt attribute is written to the interrupt register. */=0D
+	hinic3_hwif_write_reg(func_to_func->hwdev->hwif,=0D
+			      HINIC3_FUNC_CSR_MAILBOX_INT_OFFSET_OFF, mbox_int);=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_release); /**< Writing the mbox =
intr attributes */=0D
+=0D
+	/* Set the control attributes of the mailbox and write to register. */=0D
+	mbox_ctrl =3D HINIC3_MBOX_CTRL_SET(TX_NOT_DONE, TX_STATUS);=0D
+	mbox_ctrl |=3D HINIC3_MBOX_CTRL_SET(NOT_TRIGGER, TRIGGER_AEQE);=0D
+	mbox_ctrl |=3D HINIC3_MBOX_CTRL_SET(dst_func, DST_FUNC);=0D
+	hinic3_hwif_write_reg(func_to_func->hwdev->hwif,=0D
+			      HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF, mbox_ctrl);=0D
+}=0D
+=0D
+/**=0D
+ * Read the value of the mailbox register of the hardware device.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ */=0D
+static void=0D
+dump_mbox_reg(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	u32 val;=0D
+	/* Read the value of the MBOX control register. */=0D
+	val =3D hinic3_hwif_read_reg(hwdev->hwif,=0D
+				   HINIC3_FUNC_CSR_MAILBOX_CONTROL_OFF);=0D
+	PMD_DRV_LOG(ERR, "Mailbox control reg: 0x%x", val);=0D
+	/* Read the value of the MBOX interrupt offset register. */=0D
+	val =3D hinic3_hwif_read_reg(hwdev->hwif,=0D
+				   HINIC3_FUNC_CSR_MAILBOX_INT_OFFSET_OFF);=0D
+	PMD_DRV_LOG(ERR, "Mailbox interrupt offset: 0x%x", val);=0D
+}=0D
+=0D
+static u16=0D
+get_mbox_status(struct hinic3_send_mbox *mbox)=0D
+{=0D
+	/* Write back is 16B, but only use first 4B. */=0D
+	u64 wb_val =3D be64_to_cpu(*mbox->wb_status);=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_acquire); /**< Verify reading be=
fore check. */=0D
+=0D
+	return (u16)(wb_val & MBOX_WB_STATUS_ERRCODE_MASK);=0D
+}=0D
+=0D
+/**=0D
+ * Sending Mailbox Message Segment.=0D
+ *=0D
+ * @param[in] func_to_func=0D
+ * Mailbox for inter-function communication.=0D
+ * @param[in] header=0D
+ * Mailbox header.=0D
+ * @param[in] dst_func=0D
+ * Indicate destination func.=0D
+ * @param[in] seg=0D
+ * Segment data to be sent.=0D
+ * @param[in] seg_len=0D
+ * Length of the segment to be sent.=0D
+ * @param[in] msg_info=0D
+ * Indicate the message information.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+send_mbox_seg(struct hinic3_mbox *func_to_func, u64 header, u16 dst_func,=
=0D
+	      void *seg, u16 seg_len, __rte_unused void *msg_info)=0D
+{=0D
+	struct hinic3_send_mbox *send_mbox =3D &func_to_func->send_mbox;=0D
+	struct hinic3_hwdev *hwdev =3D func_to_func->hwdev;=0D
+	u8 num_aeqs =3D hwdev->hwif->attr.num_aeqs;=0D
+	u16 dst_aeqn, wb_status =3D 0, errcode;=0D
+	u16 seq_dir =3D HINIC3_MSG_HEADER_GET(header, DIRECTION);=0D
+	u32 cnt =3D 0;=0D
+=0D
+	/* Mbox to mgmt cpu, hardware doesn't care dst aeq id. */=0D
+	if (num_aeqs >=3D 2)=0D
+		dst_aeqn =3D (seq_dir =3D=3D HINIC3_MSG_DIRECT_SEND)=0D
+				   ? HINIC3_ASYNC_MSG_AEQ=0D
+				   : HINIC3_MBOX_RSP_MSG_AEQ;=0D
+	else=0D
+		dst_aeqn =3D 0;=0D
+=0D
+	clear_mbox_status(send_mbox);=0D
+	mbox_copy_header(send_mbox, &header);=0D
+	mbox_copy_send_data(send_mbox, seg, seg_len);=0D
+=0D
+	/* Set mailbox msg seg len. */=0D
+	write_mbox_msg_attr(func_to_func, dst_func, dst_aeqn, seg_len);=0D
+	rte_atomic_thread_fence(rte_memory_order_release); /**< Writing the mbox =
msg attributes. */=0D
+=0D
+	/* Wait until the status of the mailbox changes to Complete. */=0D
+	while (cnt < MBOX_MSG_POLLING_TIMEOUT) {=0D
+		wb_status =3D get_mbox_status(send_mbox);=0D
+		if (MBOX_STATUS_FINISHED(wb_status))=0D
+			break;=0D
+=0D
+		rte_delay_us(10);=0D
+		cnt++;=0D
+	}=0D
+=0D
+	if (cnt =3D=3D MBOX_MSG_POLLING_TIMEOUT) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Send mailbox segment timeout, wb status: 0x%x",=0D
+			    wb_status);=0D
+		dump_mbox_reg(hwdev);=0D
+		return -ETIMEDOUT;=0D
+	}=0D
+=0D
+	if (!MBOX_STATUS_SUCCESS(wb_status)) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Send mailbox segment to function %d error, wb "=0D
+			    "status: 0x%x",=0D
+			    dst_func, wb_status);=0D
+		errcode =3D MBOX_STATUS_ERRCODE(wb_status);=0D
+		return errcode ? errcode : -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+send_tlp_mbox_seg(struct hinic3_mbox *func_to_func, u64 header, u16 dst_fu=
nc,=0D
+		  void *seg, u16 seg_len, __rte_unused void *msg_info)=0D
+{=0D
+	struct hinic3_send_mbox *send_mbox =3D &func_to_func->send_mbox;=0D
+	struct hinic3_hwdev *hwdev =3D func_to_func->hwdev;=0D
+	u8 num_aeqs =3D hwdev->hwif->attr.num_aeqs;=0D
+	u16 dst_aeqn, errcode, wb_status =3D 0;=0D
+	u16 seq_dir =3D HINIC3_MSG_HEADER_GET(header, DIRECTION);=0D
+	u32 cnt =3D 0;=0D
+=0D
+	/* Mbox to mgmt cpu, hardware doesn't care dst aeq id. */=0D
+	if (num_aeqs >=3D 2)=0D
+		dst_aeqn =3D (seq_dir =3D=3D HINIC3_MSG_DIRECT_SEND)=0D
+				   ? HINIC3_ASYNC_MSG_AEQ=0D
+				   : HINIC3_MBOX_RSP_MSG_AEQ;=0D
+	else=0D
+		dst_aeqn =3D 0;=0D
+=0D
+	clear_mbox_status(send_mbox);=0D
+	mbox_copy_header(send_mbox, &header);=0D
+=0D
+	/* Copy data to DMA buffer. */=0D
+	memcpy((void *)send_mbox->sbuff_vaddr, (void *)seg, (size_t)seg_len);=0D
+=0D
+	/*=0D
+	 * Copy data address to mailbox ctrl CSR(Control and Status Register).=0D
+	 */=0D
+	mbox_copy_send_data_addr(send_mbox, seg_len);=0D
+=0D
+	/* Set mailbox msg header size. */=0D
+	write_mbox_msg_attr(func_to_func, dst_func, dst_aeqn,=0D
+			    MBOX_TLP_HEADER_SZ);=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_release); /**< Writing the mbox =
msg attributes. */=0D
+=0D
+	/* Wait until the status of the mailbox changes to Complete. */=0D
+	while (cnt < MBOX_MSG_POLLING_TIMEOUT) {=0D
+		wb_status =3D get_mbox_status(send_mbox);=0D
+		if (MBOX_STATUS_FINISHED(wb_status))=0D
+			break;=0D
+=0D
+		rte_delay_us(10);=0D
+		cnt++;=0D
+	}=0D
+=0D
+	if (cnt =3D=3D MBOX_MSG_POLLING_TIMEOUT) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Send mailbox segment timeout, wb status: 0x%x",=0D
+			    wb_status);=0D
+		dump_mbox_reg(hwdev);=0D
+		return -ETIMEDOUT;=0D
+	}=0D
+=0D
+	if (!MBOX_STATUS_SUCCESS(wb_status)) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Send mailbox segment to function %d error, wb "=0D
+			    "status: 0x%x",=0D
+			    dst_func, wb_status);=0D
+		errcode =3D MBOX_STATUS_ERRCODE(wb_status);=0D
+		return errcode ? errcode : -EFAULT;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+send_mbox_to_func(struct hinic3_mbox *func_to_func, enum hinic3_mod_type m=
od,=0D
+		  u16 cmd, void *msg, u16 msg_len, u16 dst_func,=0D
+		  enum hinic3_msg_direction_type direction,=0D
+		  enum hinic3_msg_ack_type ack_type,=0D
+		  struct mbox_msg_info *msg_info)=0D
+{=0D
+	int err =3D 0;=0D
+	u32 seq_id =3D 0;=0D
+	u16 seg_len =3D MBOX_SEG_LEN;=0D
+	u16 rsp_aeq_id, left =3D msg_len;=0D
+	u8 *msg_seg =3D (u8 *)msg;=0D
+	u64 header =3D 0;=0D
+=0D
+	rsp_aeq_id =3D HINIC3_MBOX_RSP_MSG_AEQ;=0D
+=0D
+	err =3D hinic3_mutex_lock(&func_to_func->msg_send_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	/* Set the header message. */=0D
+	header =3D HINIC3_MSG_HEADER_SET(msg_len, MSG_LEN) |=0D
+		 HINIC3_MSG_HEADER_SET(mod, MODULE) |=0D
+		 HINIC3_MSG_HEADER_SET(seg_len, SEG_LEN) |=0D
+		 HINIC3_MSG_HEADER_SET(ack_type, NO_ACK) |=0D
+		 HINIC3_MSG_HEADER_SET(HINIC3_DATA_INLINE, DATA_TYPE) |=0D
+		 HINIC3_MSG_HEADER_SET(SEQ_ID_START_VAL, SEQID) |=0D
+		 HINIC3_MSG_HEADER_SET(NOT_LAST_SEGMENT, LAST) |=0D
+		 HINIC3_MSG_HEADER_SET(direction, DIRECTION) |=0D
+		 HINIC3_MSG_HEADER_SET(cmd, CMD) |=0D
+		 /* The VF's offset to it's associated PF. */=0D
+		 HINIC3_MSG_HEADER_SET(msg_info->msg_id, MSG_ID) |=0D
+		 HINIC3_MSG_HEADER_SET(rsp_aeq_id, AEQ_ID) |=0D
+		 HINIC3_MSG_HEADER_SET(HINIC3_MSG_FROM_MBOX, SOURCE) |=0D
+		 HINIC3_MSG_HEADER_SET(!!msg_info->status, STATUS);=0D
+	/* Loop until all messages are sent. */=0D
+	while (!(HINIC3_MSG_HEADER_GET(header, LAST))) {=0D
+		if (left <=3D MBOX_SEG_LEN) {=0D
+			header &=3D ~MBOX_SEGLEN_MASK;=0D
+			header |=3D HINIC3_MSG_HEADER_SET(left, SEG_LEN);=0D
+			header |=3D HINIC3_MSG_HEADER_SET(LAST_SEGMENT, LAST);=0D
+=0D
+			seg_len =3D left;=0D
+		}=0D
+=0D
+		err =3D send_mbox_seg(func_to_func, header, dst_func, msg_seg,=0D
+				    seg_len, msg_info);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Send mbox seg failed, seq_id: 0x%" PRIx64,=0D
+				    HINIC3_MSG_HEADER_GET(header, SEQID));=0D
+=0D
+			goto send_err;=0D
+		}=0D
+=0D
+		left -=3D MBOX_SEG_LEN;=0D
+		msg_seg +=3D MBOX_SEG_LEN;=0D
+=0D
+		seq_id++;=0D
+		header &=3D ~(HINIC3_MSG_HEADER_SET(HINIC3_MSG_HEADER_SEQID_MASK,=0D
+						  SEQID));=0D
+		header |=3D HINIC3_MSG_HEADER_SET(seq_id, SEQID);=0D
+	}=0D
+=0D
+send_err:=0D
+	hinic3_mutex_unlock(&func_to_func->msg_send_mutex);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+send_tlp_mbox_to_func(struct hinic3_mbox *func_to_func,=0D
+		      enum hinic3_mod_type mod, u16 cmd, void *msg, u16 msg_len,=0D
+		      u16 dst_func, enum hinic3_msg_direction_type direction,=0D
+		      enum hinic3_msg_ack_type ack_type,=0D
+		      struct mbox_msg_info *msg_info)=0D
+{=0D
+	struct hinic3_hwdev *hwdev =3D func_to_func->hwdev;=0D
+	u8 *msg_seg =3D (u8 *)msg;=0D
+	int err =3D 0;=0D
+	u16 rsp_aeq_id;=0D
+	u64 header =3D 0;=0D
+=0D
+	rsp_aeq_id =3D HINIC3_MBOX_RSP_MSG_AEQ;=0D
+=0D
+	err =3D hinic3_mutex_lock(&func_to_func->msg_send_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	/* Set the header message. */=0D
+	header =3D HINIC3_MSG_HEADER_SET(MBOX_TLP_HEADER_SZ, MSG_LEN) |=0D
+		 HINIC3_MSG_HEADER_SET(MBOX_TLP_HEADER_SZ, SEG_LEN) |=0D
+		 HINIC3_MSG_HEADER_SET(mod, MODULE) |=0D
+		 HINIC3_MSG_HEADER_SET(LAST_SEGMENT, LAST) |=0D
+		 HINIC3_MSG_HEADER_SET(ack_type, NO_ACK) |=0D
+		 HINIC3_MSG_HEADER_SET(HINIC3_DATA_DMA, DATA_TYPE) |=0D
+		 HINIC3_MSG_HEADER_SET(SEQ_ID_START_VAL, SEQID) |=0D
+		 HINIC3_MSG_HEADER_SET(direction, DIRECTION) |=0D
+		 HINIC3_MSG_HEADER_SET(cmd, CMD) |=0D
+		 /* The VF's offset to it's associated PF. */=0D
+		 HINIC3_MSG_HEADER_SET(msg_info->msg_id, MSG_ID) |=0D
+		 HINIC3_MSG_HEADER_SET(rsp_aeq_id, AEQ_ID) |=0D
+		 HINIC3_MSG_HEADER_SET(HINIC3_MSG_FROM_MBOX, SOURCE) |=0D
+		 HINIC3_MSG_HEADER_SET(!!msg_info->status, STATUS) |=0D
+		 HINIC3_MSG_HEADER_SET(hinic3_global_func_id(hwdev),=0D
+				       SRC_GLB_FUNC_IDX);=0D
+=0D
+	/* Send a message. */=0D
+	err =3D send_tlp_mbox_seg(func_to_func, header, dst_func, msg_seg,=0D
+				msg_len, msg_info);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Send mbox seg failed, seq_id: 0x%" PRIx64,=0D
+			    HINIC3_MSG_HEADER_GET(header, SEQID));=0D
+	}=0D
+=0D
+	hinic3_mutex_unlock(&func_to_func->msg_send_mutex);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Set mailbox F2F(Function to Function) event status.=0D
+ *=0D
+ * @param[out] func_to_func=0D
+ * Context for inter-function communication.=0D
+ * @param[in] event_flag=0D
+ * Event status enumerated value.=0D
+ */=0D
+static void=0D
+set_mbox_to_func_event(struct hinic3_mbox *func_to_func,=0D
+		       enum mbox_event_state event_flag)=0D
+{=0D
+	rte_spinlock_lock(&func_to_func->mbox_lock);=0D
+	func_to_func->event_flag =3D event_flag;=0D
+	rte_spinlock_unlock(&func_to_func->mbox_lock);=0D
+}=0D
+=0D
+/**=0D
+ * Send data from one function to another and receive responses.=0D
+ *=0D
+ * @param[in] func_to_func=0D
+ * Context for inter-function communication.=0D
+ * @param[in] mod=0D
+ * Command queue module type.=0D
+ * @param[in] cmd=0D
+ * Indicate the command to be executed.=0D
+  the command to be executed.=0D
+ * @param[in] dst_func=0D
+ * Indicate destination func.=0D
+ * @param[in] buf_in=0D
+ * Pointer to the input buffer.=0D
+ * @param[in] in_size=0D
+ * Input buffer size.=0D
+ * @param[out] buf_out=0D
+ * Pointer to the output buffer.=0D
+ * @param[out] out_size=0D
+ * Output buffer size.=0D
+ * @param[in] timeout=0D
+ * Timeout interval for waiting for a response.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+hinic3_mbox_to_func(struct hinic3_mbox *func_to_func, enum hinic3_mod_type=
 mod,=0D
+		    u16 cmd, u16 dst_func, void *buf_in, u16 in_size,=0D
+		    void *buf_out, u16 *out_size, u32 timeout)=0D
+{=0D
+	/* Use mbox_resp to hole data which responded from other function. */=0D
+	struct hinic3_recv_mbox *mbox_for_resp =3D NULL;=0D
+	struct mbox_msg_info msg_info =3D {0};=0D
+	struct hinic3_eq *aeq =3D NULL;=0D
+	u16 mbox_rsp_idx;=0D
+	u32 time;=0D
+	int err;=0D
+=0D
+	mbox_rsp_idx =3D (u16)hinic3_mbox_get_index(dst_func);=0D
+	mbox_for_resp =3D &func_to_func->mbox_resp[mbox_rsp_idx];=0D
+=0D
+	err =3D hinic3_mutex_lock(&func_to_func->mbox_send_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	/* Set message ID and start event. */=0D
+	msg_info.msg_id =3D MBOX_MSG_ID_INC(func_to_func);=0D
+	set_mbox_to_func_event(func_to_func, EVENT_START);=0D
+=0D
+	/* Select a function to send messages based on the dst_func type. */=0D
+	if (IS_TLP_MBX(dst_func))=0D
+		err =3D send_tlp_mbox_to_func(func_to_func,=0D
+			mod, cmd, buf_in, in_size, dst_func,=0D
+			HINIC3_MSG_DIRECT_SEND, HINIC3_MSG_ACK, &msg_info);=0D
+	else=0D
+		err =3D send_mbox_to_func(func_to_func, mod, cmd, buf_in, in_size,=0D
+					dst_func, HINIC3_MSG_DIRECT_SEND,=0D
+					HINIC3_MSG_ACK, &msg_info);=0D
+=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Send mailbox failed, msg_id: %d",=0D
+			    msg_info.msg_id);=0D
+		set_mbox_to_func_event(func_to_func, EVENT_FAIL);=0D
+		goto send_err;=0D
+	}=0D
+=0D
+	/* Wait for the response message. */=0D
+	time =3D msecs_to_jiffies(timeout ? timeout : HINIC3_MBOX_COMP_TIME);=0D
+	aeq =3D &func_to_func->hwdev->aeqs->aeq[HINIC3_MBOX_RSP_MSG_AEQ];=0D
+	err =3D hinic3_aeq_poll_msg(aeq, time, NULL);=0D
+	if (err) {=0D
+		set_mbox_to_func_event(func_to_func, EVENT_TIMEOUT);=0D
+		PMD_DRV_LOG(ERR, "Send mailbox message time out");=0D
+		err =3D -ETIMEDOUT;=0D
+		goto send_err;=0D
+	}=0D
+=0D
+	/* Check whether mod and command of the rsp message match the sent messag=
e. */=0D
+	if (mod !=3D mbox_for_resp->mod || cmd !=3D mbox_for_resp->cmd) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Invalid response mbox message, mod: 0x%x, cmd: "=0D
+			    "0x%x, expect mod: 0x%x, cmd: 0x%x",=0D
+			    mbox_for_resp->mod, mbox_for_resp->cmd, mod, cmd);=0D
+		err =3D -EFAULT;=0D
+		goto send_err;=0D
+	}=0D
+=0D
+	/* Check the response status. */=0D
+	if (mbox_for_resp->msg_info.status) {=0D
+		err =3D mbox_for_resp->msg_info.status;=0D
+		goto send_err;=0D
+	}=0D
+=0D
+	/* Check whether the length of the response message is valid. */=0D
+	if (buf_out && out_size) {=0D
+		if (*out_size < mbox_for_resp->mbox_len) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				"Invalid response mbox message length: %d for "=0D
+				"mod: %d cmd: %d, should less than: %d",=0D
+				mbox_for_resp->mbox_len, mod, cmd, *out_size);=0D
+			err =3D -EFAULT;=0D
+			goto send_err;=0D
+		}=0D
+=0D
+		if (mbox_for_resp->mbox_len)=0D
+			memcpy(buf_out, mbox_for_resp->mbox,=0D
+			       (size_t)(mbox_for_resp->mbox_len));=0D
+=0D
+		*out_size =3D mbox_for_resp->mbox_len;=0D
+	}=0D
+=0D
+send_err:=0D
+	hinic3_mutex_unlock(&func_to_func->mbox_send_mutex);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+mbox_func_params_valid(__rte_unused struct hinic3_mbox *func_to_func,=0D
+		       void *buf_in, u16 in_size)=0D
+{=0D
+	if (!buf_in || !in_size)=0D
+		return -EINVAL;=0D
+=0D
+	if (in_size > HINIC3_MBOX_DATA_SIZE) {=0D
+		PMD_DRV_LOG(ERR, "Mbox msg len(%d) exceed limit(%" PRIu64 ")",=0D
+			    in_size, HINIC3_MBOX_DATA_SIZE);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+hinic3_mbox_to_func_no_ack(struct hinic3_hwdev *hwdev, u16 func_idx,=0D
+			   enum hinic3_mod_type mod, u16 cmd, void *buf_in,=0D
+			   u16 in_size)=0D
+{=0D
+	struct hinic3_mbox *func_to_func =3D hwdev->func_to_func;=0D
+	struct mbox_msg_info msg_info =3D {0};=0D
+	int err;=0D
+=0D
+	err =3D mbox_func_params_valid(hwdev->func_to_func, buf_in, in_size);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	err =3D hinic3_mutex_lock(&func_to_func->mbox_send_mutex);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	if (IS_TLP_MBX(func_idx))=0D
+		err =3D send_tlp_mbox_to_func(func_to_func,=0D
+			mod, cmd, buf_in, in_size, func_idx,=0D
+			HINIC3_MSG_DIRECT_SEND, HINIC3_MSG_NO_ACK, &msg_info);=0D
+	else=0D
+		err =3D send_mbox_to_func(func_to_func, mod, cmd, buf_in, in_size,=0D
+					func_idx, HINIC3_MSG_DIRECT_SEND,=0D
+					HINIC3_MSG_NO_ACK, &msg_info);=0D
+	if (err)=0D
+		PMD_DRV_LOG(ERR, "Send mailbox no ack failed");=0D
+=0D
+	hinic3_mutex_unlock(&func_to_func->mbox_send_mutex);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+int=0D
+hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev, enum hinic3_mod_type =
mod,=0D
+			 u16 cmd, void *buf_in, u16 in_size, void *buf_out,=0D
+			 u16 *out_size, u32 timeout)=0D
+{=0D
+	struct hinic3_mbox *func_to_func =3D hwdev->func_to_func;=0D
+	int err;=0D
+	/* Verify the validity of the input parameters. */=0D
+	err =3D mbox_func_params_valid(func_to_func, buf_in, in_size);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	return hinic3_mbox_to_func(func_to_func, mod, cmd, HINIC3_MGMT_SRC_ID,=0D
+				   buf_in, in_size, buf_out, out_size, timeout);=0D
+}=0D
+=0D
+void=0D
+hinic3_response_mbox_to_mgmt(struct hinic3_hwdev *hwdev,=0D
+			     enum hinic3_mod_type mod, u16 cmd, void *buf_in,=0D
+			     u16 in_size, u16 msg_id)=0D
+{=0D
+	struct mbox_msg_info msg_info;=0D
+	u16 dst_func;=0D
+=0D
+	msg_info.msg_id =3D (u8)msg_id;=0D
+	msg_info.status =3D 0;=0D
+	dst_func =3D HINIC3_MGMT_SRC_ID;=0D
+=0D
+	if (IS_TLP_MBX(dst_func))=0D
+		send_tlp_mbox_to_func(hwdev->func_to_func, mod, cmd, buf_in,=0D
+				      in_size, HINIC3_MGMT_SRC_ID,=0D
+				      HINIC3_MSG_RESPONSE, HINIC3_MSG_NO_ACK,=0D
+				      &msg_info);=0D
+	else=0D
+		send_mbox_to_func(hwdev->func_to_func, mod, cmd, buf_in,=0D
+				  in_size, HINIC3_MGMT_SRC_ID,=0D
+				  HINIC3_MSG_RESPONSE, HINIC3_MSG_NO_ACK,=0D
+				  &msg_info);=0D
+}=0D
+=0D
+int=0D
+hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev,=0D
+				enum hinic3_mod_type mod, u16 cmd, void *buf_in,=0D
+				u16 in_size)=0D
+{=0D
+	struct hinic3_mbox *func_to_func =3D hwdev->func_to_func;=0D
+	int err;=0D
+=0D
+	err =3D mbox_func_params_valid(func_to_func, buf_in, in_size);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	return hinic3_mbox_to_func_no_ack(hwdev, HINIC3_MGMT_SRC_ID, mod, cmd,=0D
+					  buf_in, in_size);=0D
+}=0D
+=0D
+int=0D
+hinic3_mbox_to_pf(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod, u1=
6 cmd,=0D
+		  void *buf_in, u16 in_size, void *buf_out, u16 *out_size,=0D
+		  u32 timeout)=0D
+{=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	/* Check the validity of parameters. */=0D
+	err =3D mbox_func_params_valid(hwdev->func_to_func, buf_in, in_size);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	if (!HINIC3_IS_VF(hwdev)) {=0D
+		PMD_DRV_LOG(ERR, "Params error, func_type: %d",=0D
+			    hinic3_func_type(hwdev));=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	/* Sending Email to PF. */=0D
+	return hinic3_mbox_to_func(hwdev->func_to_func, mod, cmd,=0D
+				   hinic3_pf_id_of_vf(hwdev), buf_in, in_size,=0D
+				   buf_out, out_size, timeout);=0D
+}=0D
+=0D
+int=0D
+hinic3_mbox_to_vf(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod,=0D
+		  u16 vf_id, u16 cmd, void *buf_in, u16 in_size, void *buf_out,=0D
+		  u16 *out_size, u32 timeout)=0D
+{=0D
+	struct hinic3_mbox *func_to_func =3D NULL;=0D
+	u16 dst_func_idx;=0D
+	int err =3D 0;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	func_to_func =3D hwdev->func_to_func;=0D
+	err =3D mbox_func_params_valid(func_to_func, buf_in, in_size);=0D
+	if (err)=0D
+		return err;=0D
+=0D
+	if (HINIC3_IS_VF(hwdev)) {=0D
+		PMD_DRV_LOG(ERR, "Params error, func_type: %d",=0D
+			    hinic3_func_type(hwdev));=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (!vf_id) {=0D
+		PMD_DRV_LOG(ERR, "VF id: %d error!", vf_id);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	/*=0D
+	 * The sum of vf_offset_to_pf + vf_id is the VF's global function id of=0D
+	 * VF in this pf.=0D
+	 */=0D
+	dst_func_idx =3D hinic3_glb_pf_vf_offset(hwdev) + vf_id;=0D
+=0D
+	return hinic3_mbox_to_func(func_to_func, mod, cmd, dst_func_idx, buf_in,=
=0D
+				   in_size, buf_out, out_size, timeout);=0D
+}=0D
+=0D
+static int=0D
+init_mbox_info(struct hinic3_recv_mbox *mbox_info, int mbox_max_buf_sz)=0D
+{=0D
+	int err;=0D
+=0D
+	mbox_info->seq_id =3D SEQ_ID_MAX_VAL;=0D
+=0D
+	mbox_info->mbox =3D=0D
+		rte_zmalloc("mbox", (size_t)mbox_max_buf_sz, 1); /*lint !e571*/=0D
+	if (!mbox_info->mbox)=0D
+		return -ENOMEM;=0D
+=0D
+	mbox_info->buf_out =3D rte_zmalloc("mbox_buf_out",=0D
+		(size_t)mbox_max_buf_sz, 1); /*lint !e571*/=0D
+	if (!mbox_info->buf_out) {=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_buf_out_err;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+alloc_buf_out_err:=0D
+	rte_free(mbox_info->mbox);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void=0D
+clean_mbox_info(struct hinic3_recv_mbox *mbox_info)=0D
+{=0D
+	rte_free(mbox_info->buf_out);=0D
+	rte_free(mbox_info->mbox);=0D
+}=0D
+=0D
+static int=0D
+alloc_mbox_info(struct hinic3_recv_mbox *mbox_info, int mbox_max_buf_sz)=0D
+{=0D
+	u16 func_idx, i;=0D
+	int err;=0D
+=0D
+	for (func_idx =3D 0; func_idx < HINIC3_MAX_FUNCTIONS + 1; func_idx++) {=0D
+		err =3D init_mbox_info(&mbox_info[func_idx], mbox_max_buf_sz);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Init mbox info failed");=0D
+			goto init_mbox_info_err;=0D
+		}=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+init_mbox_info_err:=0D
+	for (i =3D 0; i < func_idx; i++)=0D
+		clean_mbox_info(&mbox_info[i]);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void=0D
+free_mbox_info(struct hinic3_recv_mbox *mbox_info)=0D
+{=0D
+	u16 func_idx;=0D
+=0D
+	for (func_idx =3D 0; func_idx < HINIC3_MAX_FUNCTIONS + 1; func_idx++)=0D
+		clean_mbox_info(&mbox_info[func_idx]);=0D
+}=0D
+=0D
+static void=0D
+prepare_send_mbox(struct hinic3_mbox *func_to_func)=0D
+{=0D
+	struct hinic3_send_mbox *send_mbox =3D &func_to_func->send_mbox;=0D
+=0D
+	send_mbox->data =3D MBOX_AREA(func_to_func->hwdev->hwif);=0D
+}=0D
+=0D
+/**=0D
+ * Allocate memory for the write-back state of the mailbox and write to=0D
+ * register.=0D
+ *=0D
+ * @param[in] func_to_func=0D
+ * Context for inter-function communication.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+alloc_mbox_wb_status(struct hinic3_mbox *func_to_func)=0D
+{=0D
+	struct hinic3_send_mbox *send_mbox =3D &func_to_func->send_mbox;=0D
+	struct hinic3_hwdev *hwdev =3D func_to_func->hwdev;=0D
+	u32 addr_h, addr_l;=0D
+=0D
+	/* Reserved DMA area. */=0D
+	send_mbox->wb_mz =3D hinic3_dma_zone_reserve(hwdev->eth_dev,=0D
+		"wb_mz", 0, MBOX_WB_STATUS_LEN,=0D
+		RTE_CACHE_LINE_SIZE, SOCKET_ID_ANY);=0D
+	if (!send_mbox->wb_mz)=0D
+		return -ENOMEM;=0D
+=0D
+	send_mbox->wb_vaddr =3D send_mbox->wb_mz->addr;=0D
+	send_mbox->wb_paddr =3D send_mbox->wb_mz->iova;=0D
+	send_mbox->wb_status =3D send_mbox->wb_vaddr;=0D
+=0D
+	addr_h =3D upper_32_bits(send_mbox->wb_paddr);=0D
+	addr_l =3D lower_32_bits(send_mbox->wb_paddr);=0D
+=0D
+	/* Write info to the register. */=0D
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,=
=0D
+			      addr_h);=0D
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,=
=0D
+			      addr_l);=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+free_mbox_wb_status(struct hinic3_mbox *func_to_func)=0D
+{=0D
+	struct hinic3_send_mbox *send_mbox =3D &func_to_func->send_mbox;=0D
+	struct hinic3_hwdev *hwdev =3D func_to_func->hwdev;=0D
+=0D
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_H_OFF,=
=0D
+			      0);=0D
+	hinic3_hwif_write_reg(hwdev->hwif, HINIC3_FUNC_CSR_MAILBOX_RESULT_L_OFF,=
=0D
+			      0);=0D
+=0D
+	hinic3_memzone_free(send_mbox->wb_mz);=0D
+}=0D
+=0D
+static int=0D
+alloc_mbox_tlp_buffer(struct hinic3_mbox *func_to_func)=0D
+{=0D
+	struct hinic3_send_mbox *send_mbox =3D &func_to_func->send_mbox;=0D
+	struct hinic3_hwdev *hwdev =3D func_to_func->hwdev;=0D
+=0D
+	send_mbox->sbuff_mz =3D hinic3_dma_zone_reserve(hwdev->eth_dev,=0D
+		"sbuff_mz", 0, MBOX_MAX_BUF_SZ, MBOX_MAX_BUF_SZ,=0D
+		SOCKET_ID_ANY);=0D
+	if (!send_mbox->sbuff_mz)=0D
+		return -ENOMEM;=0D
+=0D
+	send_mbox->sbuff_vaddr =3D send_mbox->sbuff_mz->addr;=0D
+	send_mbox->sbuff_paddr =3D send_mbox->sbuff_mz->iova;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+free_mbox_tlp_buffer(struct hinic3_mbox *func_to_func)=0D
+{=0D
+	struct hinic3_send_mbox *send_mbox =3D &func_to_func->send_mbox;=0D
+=0D
+	hinic3_memzone_free(send_mbox->sbuff_mz);=0D
+}=0D
+=0D
+/**=0D
+ * Initialize function to function communication.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * Pointer to hardware device structure.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_func_to_func_init(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_mbox *func_to_func;=0D
+	int err;=0D
+=0D
+	func_to_func =3D rte_zmalloc("func_to_func", sizeof(*func_to_func), 1);=0D
+	if (!func_to_func)=0D
+		return -ENOMEM;=0D
+=0D
+	hwdev->func_to_func =3D func_to_func;=0D
+	func_to_func->hwdev =3D hwdev;=0D
+	hinic3_mutex_init(&func_to_func->mbox_send_mutex, NULL);=0D
+	hinic3_mutex_init(&func_to_func->msg_send_mutex, NULL);=0D
+	rte_spinlock_init(&func_to_func->mbox_lock);=0D
+=0D
+	/* Alloc the memory required by the mailbox. */=0D
+	err =3D alloc_mbox_info(func_to_func->mbox_send, MBOX_MAX_BUF_SZ);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Alloc mem for mbox_active failed");=0D
+		goto alloc_mbox_for_send_err;=0D
+	}=0D
+=0D
+	err =3D alloc_mbox_info(func_to_func->mbox_resp, MBOX_MAX_BUF_SZ);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Alloc mem for mbox_passive failed");=0D
+		goto alloc_mbox_for_resp_err;=0D
+	}=0D
+=0D
+	err =3D alloc_mbox_tlp_buffer(func_to_func);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Alloc mbox send buffer failed");=0D
+		goto alloc_tlp_buffer_err;=0D
+	}=0D
+=0D
+	err =3D alloc_mbox_wb_status(func_to_func);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Alloc mbox write back status failed");=0D
+		goto alloc_wb_status_err;=0D
+	}=0D
+=0D
+	prepare_send_mbox(func_to_func);=0D
+=0D
+	return 0;=0D
+=0D
+alloc_wb_status_err:=0D
+	free_mbox_tlp_buffer(func_to_func);=0D
+=0D
+alloc_tlp_buffer_err:=0D
+	free_mbox_info(func_to_func->mbox_resp);=0D
+=0D
+alloc_mbox_for_resp_err:=0D
+	free_mbox_info(func_to_func->mbox_send);=0D
+=0D
+alloc_mbox_for_send_err:=0D
+	hinic3_mutex_destroy(&func_to_func->msg_send_mutex);=0D
+	hinic3_mutex_destroy(&func_to_func->mbox_send_mutex);=0D
+	rte_free(func_to_func);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+void=0D
+hinic3_func_to_func_free(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_mbox *func_to_func =3D hwdev->func_to_func;=0D
+=0D
+	free_mbox_wb_status(func_to_func);=0D
+	free_mbox_tlp_buffer(func_to_func);=0D
+	free_mbox_info(func_to_func->mbox_resp);=0D
+	free_mbox_info(func_to_func->mbox_send);=0D
+	hinic3_mutex_destroy(&func_to_func->mbox_send_mutex);=0D
+	hinic3_mutex_destroy(&func_to_func->msg_send_mutex);=0D
+=0D
+	rte_free(func_to_func);=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_mbox.h b/drivers/net/hinic3/bas=
e/hinic3_mbox.h=0D
new file mode 100644=0D
index 0000000000..60336000ab=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_mbox.h=0D
@@ -0,0 +1,199 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_MBOX_H_=0D
+#define _HINIC3_MBOX_H_=0D
+=0D
+#include "hinic3_mgmt.h"=0D
+=0D
+#define HINIC3_MBOX_PF_SEND_ERR	      0x1=0D
+#define HINIC3_MBOX_PF_BUSY_ACTIVE_FW 0x2=0D
+#define HINIC3_MBOX_VF_CMD_ERROR      0x3=0D
+=0D
+#define HINIC3_MGMT_SRC_ID 0x1FFF=0D
+=0D
+#define HINIC3_MAX_PF_FUNCS 32=0D
+=0D
+/* Message header define. */=0D
+#define HINIC3_MSG_HEADER_SRC_GLB_FUNC_IDX_SHIFT 0=0D
+#define HINIC3_MSG_HEADER_STATUS_SHIFT		 13=0D
+#define HINIC3_MSG_HEADER_SOURCE_SHIFT		 15=0D
+#define HINIC3_MSG_HEADER_AEQ_ID_SHIFT		 16=0D
+#define HINIC3_MSG_HEADER_MSG_ID_SHIFT		 18=0D
+#define HINIC3_MSG_HEADER_CMD_SHIFT		 22=0D
+=0D
+#define HINIC3_MSG_HEADER_MSG_LEN_SHIFT	  32=0D
+#define HINIC3_MSG_HEADER_MODULE_SHIFT	  43=0D
+#define HINIC3_MSG_HEADER_SEG_LEN_SHIFT	  48=0D
+#define HINIC3_MSG_HEADER_NO_ACK_SHIFT	  54=0D
+#define HINIC3_MSG_HEADER_DATA_TYPE_SHIFT 55=0D
+#define HINIC3_MSG_HEADER_SEQID_SHIFT	  56=0D
+#define HINIC3_MSG_HEADER_LAST_SHIFT	  62=0D
+#define HINIC3_MSG_HEADER_DIRECTION_SHIFT 63=0D
+=0D
+#define HINIC3_MSG_HEADER_CMD_MASK		0x3FF=0D
+#define HINIC3_MSG_HEADER_MSG_ID_MASK		0xF=0D
+#define HINIC3_MSG_HEADER_AEQ_ID_MASK		0x3=0D
+#define HINIC3_MSG_HEADER_SOURCE_MASK		0x1=0D
+#define HINIC3_MSG_HEADER_STATUS_MASK		0x1=0D
+#define HINIC3_MSG_HEADER_SRC_GLB_FUNC_IDX_MASK 0x1FFF=0D
+=0D
+#define HINIC3_MSG_HEADER_MSG_LEN_MASK	 0x7FF=0D
+#define HINIC3_MSG_HEADER_MODULE_MASK	 0x1F=0D
+#define HINIC3_MSG_HEADER_SEG_LEN_MASK	 0x3F=0D
+#define HINIC3_MSG_HEADER_NO_ACK_MASK	 0x1=0D
+#define HINIC3_MSG_HEADER_DATA_TYPE_MASK 0x1=0D
+#define HINIC3_MSG_HEADER_SEQID_MASK	 0x3F=0D
+#define HINIC3_MSG_HEADER_LAST_MASK	 0x1=0D
+#define HINIC3_MSG_HEADER_DIRECTION_MASK 0x1=0D
+=0D
+#define HINIC3_MSG_HEADER_GET(val, field)               \=0D
+	(((val) >> HINIC3_MSG_HEADER_##field##_SHIFT) & \=0D
+	 HINIC3_MSG_HEADER_##field##_MASK)=0D
+#define HINIC3_MSG_HEADER_SET(val, field)                       \=0D
+	((u64)(((u64)(val)) & HINIC3_MSG_HEADER_##field##_MASK) \=0D
+	 << HINIC3_MSG_HEADER_##field##_SHIFT)=0D
+=0D
+#define IS_TLP_MBX(dst_func) ((dst_func) =3D=3D HINIC3_MGMT_SRC_ID)=0D
+=0D
+enum hinic3_msg_direction_type {=0D
+	HINIC3_MSG_DIRECT_SEND =3D 0,=0D
+	HINIC3_MSG_RESPONSE =3D 1=0D
+};=0D
+=0D
+enum hinic3_msg_segment_type { NOT_LAST_SEGMENT =3D 0, LAST_SEGMENT =3D 1 =
};=0D
+=0D
+enum hinic3_msg_ack_type { HINIC3_MSG_ACK, HINIC3_MSG_NO_ACK };=0D
+=0D
+enum hinic3_data_type { HINIC3_DATA_INLINE =3D 0, HINIC3_DATA_DMA =3D 1 };=
=0D
+=0D
+enum hinic3_msg_src_type { HINIC3_MSG_FROM_MGMT =3D 0, HINIC3_MSG_FROM_MBO=
X =3D 1 };=0D
+=0D
+enum hinic3_msg_aeq_type {=0D
+	HINIC3_ASYNC_MSG_AEQ =3D 0,=0D
+	/* Indicate dst_func or mgmt cpu which aeq to response mbox message. */=0D
+	HINIC3_MBOX_RSP_MSG_AEQ =3D 1,=0D
+	/* Indicate mgmt cpu which aeq to response api cmd message. */=0D
+	HINIC3_MGMT_RSP_MSG_AEQ =3D 2=0D
+};=0D
+=0D
+enum hinic3_mbox_seg_errcode {=0D
+	MBOX_ERRCODE_NO_ERRORS =3D 0,=0D
+	/* VF sends the mailbox data to the wrong destination functions. */=0D
+	MBOX_ERRCODE_VF_TO_WRONG_FUNC =3D 0x100,=0D
+	/* PPF sends the mailbox data to the wrong destination functions. */=0D
+	MBOX_ERRCODE_PPF_TO_WRONG_FUNC =3D 0x200,=0D
+	/* PF sends the mailbox data to the wrong destination functions. */=0D
+	MBOX_ERRCODE_PF_TO_WRONG_FUNC =3D 0x300,=0D
+	/* The mailbox data size is set to all zero. */=0D
+	MBOX_ERRCODE_ZERO_DATA_SIZE =3D 0x400,=0D
+	/* The sender func attribute has not been learned by CPI hardware. */=0D
+	MBOX_ERRCODE_UNKNOWN_SRC_FUNC =3D 0x500,=0D
+	/* The receiver func attr has not been learned by CPI hardware. */=0D
+	MBOX_ERRCODE_UNKNOWN_DES_FUNC =3D 0x600=0D
+};=0D
+=0D
+enum hinic3_mbox_func_index {=0D
+	HINIC3_MBOX_MPU_INDEX =3D 0,=0D
+	HINIC3_MBOX_PF_INDEX =3D 1,=0D
+	HINIC3_MAX_FUNCTIONS =3D 2,=0D
+};=0D
+=0D
+struct mbox_msg_info {=0D
+	u8 msg_id;=0D
+	u8 status; /**< Can only use 3 bit. */=0D
+};=0D
+=0D
+struct hinic3_recv_mbox {=0D
+	void *mbox;=0D
+	u16 cmd;=0D
+	enum hinic3_mod_type mod;=0D
+	u16 mbox_len;=0D
+	void *buf_out;=0D
+	enum hinic3_msg_ack_type ack_type;=0D
+	struct mbox_msg_info msg_info;=0D
+	u8 seq_id;=0D
+	RTE_ATOMIC(int32_t)msg_cnt;=0D
+};=0D
+=0D
+struct hinic3_send_mbox {=0D
+	u8 *data;=0D
+	u64 *wb_status; /**< Write back status. */=0D
+=0D
+	const struct rte_memzone *wb_mz;=0D
+	void *wb_vaddr;	     /**< Write back virtual address. */=0D
+	rte_iova_t wb_paddr; /**< Write back physical address. */=0D
+=0D
+	const struct rte_memzone *sbuff_mz;=0D
+	void *sbuff_vaddr;=0D
+	rte_iova_t sbuff_paddr;=0D
+};=0D
+=0D
+enum mbox_event_state {=0D
+	EVENT_START =3D 0,=0D
+	EVENT_FAIL,=0D
+	EVENT_SUCCESS,=0D
+	EVENT_TIMEOUT,=0D
+	EVENT_END=0D
+};=0D
+=0D
+/* Execution status of the callback function. */=0D
+enum hinic3_mbox_cb_state {=0D
+	HINIC3_VF_MBOX_CB_REG =3D 0,=0D
+	HINIC3_VF_MBOX_CB_RUNNING,=0D
+	HINIC3_PF_MBOX_CB_REG,=0D
+	HINIC3_PF_MBOX_CB_RUNNING,=0D
+	HINIC3_PPF_MBOX_CB_REG,=0D
+	HINIC3_PPF_MBOX_CB_RUNNING,=0D
+	HINIC3_PPF_TO_PF_MBOX_CB_REG,=0D
+	HINIC3_PPF_TO_PF_MBOX_CB_RUNNING=0D
+};=0D
+=0D
+struct hinic3_mbox {=0D
+	struct hinic3_hwdev *hwdev;=0D
+=0D
+	pthread_mutex_t mbox_send_mutex;=0D
+	pthread_mutex_t msg_send_mutex;=0D
+=0D
+	struct hinic3_send_mbox send_mbox;=0D
+=0D
+	/* Last element for mgmt. */=0D
+	struct hinic3_recv_mbox mbox_resp[HINIC3_MAX_FUNCTIONS + 1];=0D
+	struct hinic3_recv_mbox mbox_send[HINIC3_MAX_FUNCTIONS + 1];=0D
+=0D
+	u8 send_msg_id;=0D
+	enum mbox_event_state event_flag;=0D
+	/* Lock for mbox event flag. */=0D
+	rte_spinlock_t mbox_lock;=0D
+};=0D
+=0D
+int hinic3_mbox_func_aeqe_handler(void *handle, u8 *header,=0D
+				  __rte_unused u8 size, void *param);=0D
+=0D
+int hinic3_func_to_func_init(struct hinic3_hwdev *hwdev);=0D
+=0D
+void hinic3_func_to_func_free(struct hinic3_hwdev *hwdev);=0D
+=0D
+int hinic3_send_mbox_to_mgmt(struct hinic3_hwdev *hwdev,=0D
+			     enum hinic3_mod_type mod, u16 cmd, void *buf_in,=0D
+			     u16 in_size, void *buf_out, u16 *out_size,=0D
+			     u32 timeout);=0D
+=0D
+void hinic3_response_mbox_to_mgmt(struct hinic3_hwdev *hwdev,=0D
+				  enum hinic3_mod_type mod, u16 cmd,=0D
+				  void *buf_in, u16 in_size, u16 msg_id);=0D
+=0D
+int hinic3_send_mbox_to_mgmt_no_ack(struct hinic3_hwdev *hwdev,=0D
+				    enum hinic3_mod_type mod, u16 cmd,=0D
+				    void *buf_in, u16 in_size);=0D
+=0D
+int hinic3_mbox_to_pf(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod=
,=0D
+		      u16 cmd, void *buf_in, u16 in_size, void *buf_out,=0D
+		      u16 *out_size, u32 timeout);=0D
+=0D
+int hinic3_mbox_to_vf(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod=
,=0D
+		      u16 vf_id, u16 cmd, void *buf_in, u16 in_size,=0D
+		      void *buf_out, u16 *out_size, u32 timeout);=0D
+=0D
+#endif /**< _HINIC3_MBOX_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

