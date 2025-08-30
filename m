Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E671CA0EFF
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:41:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A1CB40691;
	Sat, 30 Aug 2025 14:41:00 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 558FE40262
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=IBhttIiZMVddT1ndL6mFxu3+/jgahiwY5SLMslf5cBk=;
 b=dpcAogsPB9c+0MRH8vbRhtnEad9FwD7c3jxA/uX/xjdP0rtvHyypwsn6nYfGiS
 BiBWNrUN4QlTlil4m9kme94uolzGrfuPmQPqvrBfFZM3estEW6/oFntbnrf6+RPz
 r/AhT/HcF8e6U7q5MIdCF/+kRPungB30IT/wlT/5ko0Tc=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S11;
 Sat, 30 Aug 2025 20:40:53 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 07/18] net/hinic3: add mgmt module function code
Date: Sat, 30 Aug 2025 20:39:19 +0800
Message-ID: <20250830123942.5037-8-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S11
X-Coremail-Antispam: 1Uf129KBjvAXoWfGF4rCFW5Ar4rWry8XrW3Awb_yoW8Xr4DKo
 WxJF4aqr1kZrn5Aa4293srJF97A393urnxJrs3Cws3XF1UAryFg3WUGr1fZ3WxX3y8Cry7
 uF90ga1fKw4xJw1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7tkuDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAQi5CmiydD3F1AAAs4
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

Mgmt module is a kind of administration module for the chip.=0D
It is responsible for handling administration command from host.=0D
It mainly uses aeq to implement. This patch adds related data=0D
structures, packaged interfaces and function codes.=0D
=0D
Signed-off-by: Yi Chen <chenyi221@huawei.com>=0D
Reviewed-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_mgmt.c | 392 ++++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_mgmt.h | 121 ++++++++=0D
 2 files changed, 513 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_mgmt.c b/drivers/net/hinic3/bas=
e/hinic3_mgmt.c=0D
new file mode 100644=0D
index 0000000000..dfed1229e4=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_mgmt.c=0D
@@ -0,0 +1,392 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+#include <rte_ethdev.h>=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_mbox.h"=0D
+#include "hinic3_mgmt.h"=0D
+#include "hinic3_nic_event.h"=0D
+=0D
+#define HINIC3_MSG_TO_MGMT_MAX_LEN 2016=0D
+=0D
+#define MAX_PF_MGMT_BUF_SIZE 2048UL=0D
+#define SEGMENT_LEN	     48=0D
+#define ASYNC_MSG_FLAG	     0x20=0D
+#define MGMT_MSG_MAX_SEQ_ID \=0D
+	(RTE_ALIGN(HINIC3_MSG_TO_MGMT_MAX_LEN, SEGMENT_LEN) / SEGMENT_LEN)=0D
+=0D
+#define BUF_OUT_DEFAULT_SIZE 1=0D
+=0D
+#define MGMT_MSG_SIZE_MIN     20=0D
+#define MGMT_MSG_SIZE_STEP    16=0D
+#define MGMT_MSG_RSVD_FOR_DEV 8=0D
+=0D
+#define SYNC_MSG_ID_MASK  0x1F=0D
+#define ASYNC_MSG_ID_MASK 0x1F=0D
+=0D
+#define SYNC_FLAG  0=0D
+#define ASYNC_FLAG 1=0D
+=0D
+#define MSG_NO_RESP 0xFFFF=0D
+=0D
+#define MGMT_MSG_TIMEOUT 5000 /**< Millisecond. */=0D
+=0D
+int=0D
+hinic3_msg_to_mgmt_sync(void *hwdev, enum hinic3_mod_type mod, u16 cmd,=0D
+			void *buf_in, u16 in_size, void *buf_out, u16 *out_size,=0D
+			u32 timeout)=0D
+{=0D
+	int err;=0D
+=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	/* Send a mailbox message to the management. */=0D
+	err =3D hinic3_send_mbox_to_mgmt(hwdev, mod, cmd, buf_in, in_size,=0D
+				       buf_out, out_size, timeout);=0D
+	return err;=0D
+}=0D
+=0D
+int=0D
+hinic3_msg_to_mgmt_no_ack(void *hwdev, enum hinic3_mod_type mod, u16 cmd,=
=0D
+			  void *buf_in, u16 in_size)=0D
+{=0D
+	if (!hwdev)=0D
+		return -EINVAL;=0D
+=0D
+	return hinic3_send_mbox_to_mgmt_no_ack(hwdev, mod, cmd, buf_in,=0D
+					       in_size);=0D
+}=0D
+=0D
+static void=0D
+send_mgmt_ack(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,=0D
+	      enum hinic3_mod_type mod, u16 cmd, void *buf_in, u16 in_size,=0D
+	      u16 msg_id)=0D
+{=0D
+	u16 buf_size;=0D
+=0D
+	if (!in_size)=0D
+		buf_size =3D BUF_OUT_DEFAULT_SIZE;=0D
+	else=0D
+		buf_size =3D in_size;=0D
+=0D
+	hinic3_response_mbox_to_mgmt(pf_to_mgmt->hwdev, mod, cmd, buf_in,=0D
+				     buf_size, msg_id);=0D
+}=0D
+=0D
+static bool=0D
+check_mgmt_seq_id_and_seg_len(struct hinic3_recv_msg *recv_msg, u8 seq_id,=
=0D
+			      u8 seg_len, u16 msg_id)=0D
+{=0D
+	if (seq_id > MGMT_MSG_MAX_SEQ_ID || seg_len > SEGMENT_LEN)=0D
+		return false;=0D
+=0D
+	if (seq_id =3D=3D 0) {=0D
+		recv_msg->seq_id =3D seq_id;=0D
+		recv_msg->msg_id =3D msg_id;=0D
+	} else {=0D
+		if ((seq_id !=3D recv_msg->seq_id + 1) ||=0D
+		    msg_id !=3D recv_msg->msg_id) {=0D
+			recv_msg->seq_id =3D 0;=0D
+			return false;=0D
+		}=0D
+=0D
+		recv_msg->seq_id =3D seq_id;=0D
+	}=0D
+=0D
+	return true;=0D
+}=0D
+=0D
+static void=0D
+hinic3_mgmt_recv_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,=0D
+			     struct hinic3_recv_msg *recv_msg,=0D
+			     __rte_unused void *param)=0D
+{=0D
+	void *buf_out =3D pf_to_mgmt->mgmt_ack_buf;=0D
+	bool ack_first =3D false;=0D
+	u16 out_size =3D 0;=0D
+=0D
+	memset(buf_out, 0, MAX_PF_MGMT_BUF_SIZE);=0D
+=0D
+	/* Select the corresponding processing function according to the mod. */=
=0D
+	switch (recv_msg->mod) {=0D
+	case HINIC3_MOD_COMM:=0D
+		pf_handle_mgmt_comm_event(pf_to_mgmt->hwdev,=0D
+			pf_to_mgmt, recv_msg->cmd,=0D
+			recv_msg->msg, recv_msg->msg_len, buf_out, &out_size);=0D
+		break;=0D
+	case HINIC3_MOD_L2NIC:=0D
+		hinic3_pf_event_handler(pf_to_mgmt->hwdev, pf_to_mgmt,=0D
+					recv_msg->cmd, recv_msg->msg,=0D
+					recv_msg->msg_len, buf_out, &out_size);=0D
+		break;=0D
+	case HINIC3_MOD_HILINK:=0D
+		hinic3_pf_mag_event_handler(pf_to_mgmt->hwdev,=0D
+			pf_to_mgmt, recv_msg->cmd,=0D
+			recv_msg->msg, recv_msg->msg_len, buf_out, &out_size);=0D
+		break;=0D
+=0D
+	default:=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Not support mod, maybe need to response, mod: %d",=0D
+			    recv_msg->mod);=0D
+		break;=0D
+	}=0D
+=0D
+	if (!ack_first && !recv_msg->async_mgmt_to_pf)=0D
+		/* Mgmt sends async msg, sends the response. */=0D
+		send_mgmt_ack(pf_to_mgmt, recv_msg->mod, recv_msg->cmd, buf_out,=0D
+			      out_size, recv_msg->msg_id);=0D
+}=0D
+=0D
+/**=0D
+ * Handler a recv message from mgmt channel.=0D
+ *=0D
+ * @param[in] pf_to_mgmt=0D
+ * PF to mgmt channel.=0D
+ * @param[in] recv_msg=0D
+ * Received message details.=0D
+ * @param[in] param=0D
+ * Customized parameter.=0D
+ * @return=0D
+ * 0 : When aeqe is response message.=0D
+ * -1 : Default result, when wrong message or not last message.=0D
+ */=0D
+static int=0D
+recv_mgmt_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt, u8 *header=
,=0D
+		      struct hinic3_recv_msg *recv_msg, void *param)=0D
+{=0D
+	u64 mbox_header =3D *((u64 *)header);=0D
+	void *msg_body =3D header + sizeof(mbox_header);=0D
+	u8 seq_id, seq_len;=0D
+	u32 offset;=0D
+	u8 front_id;=0D
+	u16 msg_id;=0D
+=0D
+	/* Don't need to get anything from hw when cmd is async. */=0D
+	if (HINIC3_MSG_HEADER_GET(mbox_header, DIRECTION) =3D=3D=0D
+	    HINIC3_MSG_RESPONSE)=0D
+		return 0;=0D
+=0D
+	seq_len =3D HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN);=0D
+	seq_id =3D HINIC3_MSG_HEADER_GET(mbox_header, SEQID);=0D
+	msg_id =3D HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID);=0D
+	front_id =3D recv_msg->seq_id;=0D
+=0D
+	/* Check the consistency between seq_id and seg_len. */=0D
+	if (!check_mgmt_seq_id_and_seg_len(recv_msg, seq_id, seq_len, msg_id)) {=
=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Mgmt msg sequence id and segment length check "=0D
+			    "failed, front seq_id: 0x%x, current seq_id: 0x%x,"=0D
+			    " seg len: 0x%x front msg_id: %d, cur msg_id: %d",=0D
+			    front_id, seq_id, seq_len, recv_msg->msg_id,=0D
+			    msg_id);=0D
+		/* Set seq_id to invalid seq_id. */=0D
+		recv_msg->seq_id =3D MGMT_MSG_MAX_SEQ_ID;=0D
+		return HINIC3_MSG_HANDLER_RES;=0D
+	}=0D
+=0D
+	offset =3D seq_id * SEGMENT_LEN;=0D
+	memcpy((u8 *)recv_msg->msg + offset, msg_body, seq_len);=0D
+=0D
+	if (!HINIC3_MSG_HEADER_GET(mbox_header, LAST))=0D
+		return HINIC3_MSG_HANDLER_RES;=0D
+	/* Setting the message receiving information. */=0D
+	recv_msg->cmd =3D HINIC3_MSG_HEADER_GET(mbox_header, CMD);=0D
+	recv_msg->mod =3D HINIC3_MSG_HEADER_GET(mbox_header, MODULE);=0D
+	recv_msg->async_mgmt_to_pf =3D HINIC3_MSG_HEADER_GET(mbox_header, NO_ACK)=
;=0D
+	recv_msg->msg_len =3D HINIC3_MSG_HEADER_GET(mbox_header, MSG_LEN);=0D
+	recv_msg->msg_id =3D HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID);=0D
+	recv_msg->seq_id =3D MGMT_MSG_MAX_SEQ_ID;=0D
+=0D
+	hinic3_mgmt_recv_msg_handler(pf_to_mgmt, recv_msg, param);=0D
+=0D
+	return HINIC3_MSG_HANDLER_RES;=0D
+}=0D
+=0D
+/**=0D
+ * Handler for a aeqe from mgmt channel.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device.=0D
+ * @param[in] header=0D
+ * The header of the message.=0D
+ * @param[in] size=0D
+ * Indicate size.=0D
+ * @param[in] param=0D
+ * Customized parameter.=0D
+ * @return=0D
+ * zero: When aeqe is response message=0D
+ * negative: When wrong message or not last message.=0D
+ */=0D
+int=0D
+hinic3_mgmt_msg_aeqe_handler(void *hwdev, u8 *header, u8 size, void *param=
)=0D
+{=0D
+	struct hinic3_hwdev *dev =3D (struct hinic3_hwdev *)hwdev;=0D
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt =3D NULL;=0D
+	struct hinic3_recv_msg *recv_msg =3D NULL;=0D
+	bool is_send_dir =3D false;=0D
+=0D
+	/* For mbox message, invoke the mailbox processing function. */=0D
+	if ((HINIC3_MSG_HEADER_GET(*(u64 *)header, SOURCE) =3D=3D=0D
+	     HINIC3_MSG_FROM_MBOX)) {=0D
+		return hinic3_mbox_func_aeqe_handler(hwdev, header, size,=0D
+						     param);=0D
+	}=0D
+=0D
+	pf_to_mgmt =3D dev->pf_to_mgmt;=0D
+=0D
+	is_send_dir =3D (HINIC3_MSG_HEADER_GET(*(u64 *)header, DIRECTION) =3D=3D=
=0D
+		       HINIC3_MSG_DIRECT_SEND) ? true : false;=0D
+=0D
+	/* Determine whether a message is received or responded. */=0D
+	recv_msg =3D is_send_dir ? &pf_to_mgmt->recv_msg_from_mgmt=0D
+			       : &pf_to_mgmt->recv_resp_msg_from_mgmt;=0D
+=0D
+	return recv_mgmt_msg_handler(pf_to_mgmt, header, recv_msg, param);=0D
+}=0D
+=0D
+/**=0D
+ * Allocate received message memory.=0D
+ *=0D
+ * @param[in] recv_msg=0D
+ * Pointer that will hold the allocated data.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+alloc_recv_msg(struct hinic3_recv_msg *recv_msg)=0D
+{=0D
+	recv_msg->seq_id =3D MGMT_MSG_MAX_SEQ_ID;=0D
+=0D
+	recv_msg->msg =3D rte_zmalloc("recv_msg", MAX_PF_MGMT_BUF_SIZE,=0D
+				    HINIC3_MEM_ALLOC_ALIGN_MIN);=0D
+	if (!recv_msg->msg)=0D
+		return -ENOMEM;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static void=0D
+free_recv_msg(struct hinic3_recv_msg *recv_msg)=0D
+{=0D
+	rte_free(recv_msg->msg);=0D
+}=0D
+=0D
+/**=0D
+ * Allocate all the message buffers of PF to mgmt channel.=0D
+ *=0D
+ * @param[in] pf_to_mgmt=0D
+ * PF to mgmt channel.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+static int=0D
+alloc_msg_buf(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt)=0D
+{=0D
+	int err;=0D
+=0D
+	err =3D alloc_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Allocate recv msg failed");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D alloc_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Allocate resp recv msg failed");=0D
+		goto alloc_msg_for_resp_err;=0D
+	}=0D
+=0D
+	pf_to_mgmt->mgmt_ack_buf =3D rte_zmalloc("mgmt_ack_buf",=0D
+					       MAX_PF_MGMT_BUF_SIZE,=0D
+					       HINIC3_MEM_ALLOC_ALIGN_MIN);=0D
+	if (!pf_to_mgmt->mgmt_ack_buf) {=0D
+		err =3D -ENOMEM;=0D
+		goto ack_msg_buf_err;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+ack_msg_buf_err:=0D
+	free_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);=0D
+=0D
+alloc_msg_for_resp_err:=0D
+	free_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Free all the message buffers of PF to mgmt channel.=0D
+ *=0D
+ * @param[in] pf_to_mgmt=0D
+ * PF to mgmt channel.=0D
+ */=0D
+static void=0D
+free_msg_buf(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt)=0D
+{=0D
+	rte_free(pf_to_mgmt->mgmt_ack_buf);=0D
+	free_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);=0D
+	free_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);=0D
+}=0D
+=0D
+/**=0D
+ * Initialize PF to mgmt channel.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device.=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ */=0D
+int=0D
+hinic3_pf_to_mgmt_init(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;=0D
+	int err;=0D
+=0D
+	pf_to_mgmt =3D rte_zmalloc("pf_to_mgmt", sizeof(*pf_to_mgmt),=0D
+				 HINIC3_MEM_ALLOC_ALIGN_MIN);=0D
+	if (!pf_to_mgmt)=0D
+		return -ENOMEM;=0D
+=0D
+	hwdev->pf_to_mgmt =3D pf_to_mgmt;=0D
+	pf_to_mgmt->hwdev =3D hwdev;=0D
+=0D
+	err =3D hinic3_mutex_init(&pf_to_mgmt->sync_msg_mutex, NULL);=0D
+	if (err)=0D
+		goto mutex_init_err;=0D
+=0D
+	err =3D alloc_msg_buf(pf_to_mgmt);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Allocate msg buffers failed");=0D
+		goto alloc_msg_buf_err;=0D
+	}=0D
+=0D
+	return 0;=0D
+=0D
+alloc_msg_buf_err:=0D
+	hinic3_mutex_destroy(&pf_to_mgmt->sync_msg_mutex);=0D
+=0D
+mutex_init_err:=0D
+	rte_free(pf_to_mgmt);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Free PF to mgmt channel.=0D
+ *=0D
+ * @param[in] hwdev=0D
+ * The pointer to the private hardware device.=0D
+ */=0D
+void=0D
+hinic3_pf_to_mgmt_free(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt =3D hwdev->pf_to_mgmt;=0D
+=0D
+	free_msg_buf(pf_to_mgmt);=0D
+	hinic3_mutex_destroy(&pf_to_mgmt->sync_msg_mutex);=0D
+	rte_free(pf_to_mgmt);=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_mgmt.h b/drivers/net/hinic3/bas=
e/hinic3_mgmt.h=0D
new file mode 100644=0D
index 0000000000..23454773b9=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_mgmt.h=0D
@@ -0,0 +1,121 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_MGMT_H_=0D
+#define _HINIC3_MGMT_H_=0D
+=0D
+#define HINIC3_MSG_HANDLER_RES (-1)=0D
+=0D
+struct mgmt_msg_head {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+};=0D
+=0D
+/* Cmdq module type. */=0D
+enum hinic3_mod_type {=0D
+	HINIC3_MOD_COMM =3D 0,  /**< HW communication module. */=0D
+	HINIC3_MOD_L2NIC =3D 1, /**< L2NIC module. */=0D
+	HINIC3_MOD_ROCE =3D 2,=0D
+	HINIC3_MOD_PLOG =3D 3,=0D
+	HINIC3_MOD_TOE =3D 4,=0D
+	HINIC3_MOD_FLR =3D 5,=0D
+	HINIC3_MOD_FC =3D 6,=0D
+	HINIC3_MOD_CFGM =3D 7, /**< Configuration module. */=0D
+	HINIC3_MOD_CQM =3D 8,=0D
+	HINIC3_MOD_VSWITCH =3D 9,=0D
+	COMM_MOD_FC =3D 10,=0D
+	HINIC3_MOD_OVS =3D 11,=0D
+	HINIC3_MOD_DSW =3D 12,=0D
+	HINIC3_MOD_MIGRATE =3D 13,=0D
+	HINIC3_MOD_HILINK =3D 14,=0D
+	HINIC3_MOD_CRYPT =3D 15,	/**< Secure crypto module. */=0D
+	HINIC3_MOD_HW_MAX =3D 16, /**< Hardware max module id. */=0D
+=0D
+	HINIC3_MOD_SW_FUNC =3D 17, /**< SW module for PF/VF and multi-host. */=0D
+	HINIC3_MOD_IOE =3D 18,=0D
+	HINIC3_MOD_MAX=0D
+};=0D
+=0D
+typedef enum {=0D
+	RES_TYPE_FLUSH_BIT =3D 0,=0D
+	RES_TYPE_MQM,=0D
+	RES_TYPE_SMF,=0D
+=0D
+	RES_TYPE_COMM =3D 10,=0D
+	/* Clear mbox and aeq, The RES_TYPE_COMM bit must be set. */=0D
+	RES_TYPE_COMM_MGMT_CH,=0D
+	/* Clear cmdq and ceq, The RES_TYPE_COMM bit must be set. */=0D
+	RES_TYPE_COMM_CMD_CH,=0D
+	RES_TYPE_NIC,=0D
+	RES_TYPE_OVS,=0D
+	RES_TYPE_VBS,=0D
+	RES_TYPE_ROCE,=0D
+	RES_TYPE_FC,=0D
+	RES_TYPE_TOE,=0D
+	RES_TYPE_IPSEC,=0D
+	RES_TYPE_MAX,=0D
+} func_reset_flag_e;=0D
+=0D
+#define HINIC3_COMM_RES                                 \=0D
+	((1 << RES_TYPE_COMM) | (1 << RES_TYPE_FLUSH_BIT) | \=0D
+	 (1 << RES_TYPE_MQM) | (1 << RES_TYPE_SMF) |        \=0D
+	 (1 << RES_TYPE_COMM_CMD_CH))=0D
+#define HINIC3_NIC_RES	 (1 << RES_TYPE_NIC)=0D
+#define HINIC3_OVS_RES	 (1 << RES_TYPE_OVS)=0D
+#define HINIC3_VBS_RES	 (1 << RES_TYPE_VBS)=0D
+#define HINIC3_ROCE_RES	 (1 << RES_TYPE_ROCE)=0D
+#define HINIC3_FC_RES	 (1 << RES_TYPE_FC)=0D
+#define HINIC3_TOE_RES	 (1 << RES_TYPE_TOE)=0D
+#define HINIC3_IPSEC_RES (1 << RES_TYPE_IPSEC)=0D
+=0D
+struct hinic3_recv_msg {=0D
+	void *msg;=0D
+=0D
+	u16 msg_len;=0D
+	enum hinic3_mod_type mod;=0D
+	u16 cmd;=0D
+	u8 seq_id;=0D
+	u16 msg_id;=0D
+	int async_mgmt_to_pf;=0D
+};=0D
+=0D
+/* Indicate the event status in pf-to-management communication. */=0D
+enum comm_pf_to_mgmt_event_state {=0D
+	SEND_EVENT_UNINIT =3D 0,=0D
+	SEND_EVENT_START,=0D
+	SEND_EVENT_SUCCESS,=0D
+	SEND_EVENT_FAIL,=0D
+	SEND_EVENT_TIMEOUT,=0D
+	SEND_EVENT_END=0D
+};=0D
+=0D
+struct hinic3_msg_pf_to_mgmt {=0D
+	struct hinic3_hwdev *hwdev;=0D
+=0D
+	/* Mutex for sync message. */=0D
+	pthread_mutex_t sync_msg_mutex;=0D
+=0D
+	void *mgmt_ack_buf;=0D
+=0D
+	struct hinic3_recv_msg recv_msg_from_mgmt;=0D
+	struct hinic3_recv_msg recv_resp_msg_from_mgmt;=0D
+=0D
+	u16 sync_msg_id;=0D
+};=0D
+=0D
+int hinic3_mgmt_msg_aeqe_handler(void *hwdev, u8 *header, u8 size, void *p=
aram);=0D
+=0D
+int hinic3_pf_to_mgmt_init(struct hinic3_hwdev *hwdev);=0D
+=0D
+void hinic3_pf_to_mgmt_free(struct hinic3_hwdev *hwdev);=0D
+=0D
+int hinic3_msg_to_mgmt_sync(void *hwdev, enum hinic3_mod_type mod, u16 cmd=
,=0D
+			    void *buf_in, u16 in_size, void *buf_out,=0D
+			    u16 *out_size, u32 timeout);=0D
+=0D
+int hinic3_msg_to_mgmt_no_ack(void *hwdev, enum hinic3_mod_type mod, u16 c=
md,=0D
+			      void *buf_in, u16 in_size);=0D
+=0D
+#endif /**< _HINIC3_MGMT_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

