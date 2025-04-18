Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D429C369AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 18 Apr 2025 09:08:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF92D40657;
	Fri, 18 Apr 2025 11:07:35 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.4])
 by mails.dpdk.org (Postfix) with ESMTP id 84263402ED
 for <dev@dpdk.org>; Fri, 18 Apr 2025 11:07:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:Subject:Date:Message-ID:
 MIME-Version; bh=F5YN+4GUBC3PudwzCn4srlHjXYeiHEGAxSq7IsJvbpw=;
 b=NqRVG5amfEYSYLPYxEP2oc5KxPj1BO+7Vk4qegMS3py9UJTiVSfx+L7qO9BQhZ
 l/TgZXyVYfRceWsVhGryJ0O6luC7ooMqAugXRHsb1iEGXwcXlGuZ/M0z59NS6jXM
 g4oLvfBiuzFs34I6uo51bVEAWewpverWHOdxPrzwcbhco=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDXqJVFFgJorqzGAg--.15042S11;
 Fri, 18 Apr 2025 17:07:29 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Yi Chen <chenyi221@huawei.com>, Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>
Subject: [RFC 07/18] net/hinic3: add mgmt module function code
Date: Fri, 18 Apr 2025 17:05:53 +0800
Message-ID: <20250418090621.9638-8-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250418090621.9638-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgDXqJVFFgJorqzGAg--.15042S11
X-Coremail-Antispam: 1Uf129KBjvAXoWfGF4rCFW5Ar4rWry8XrW3Awb_yoW8Xr4DKo
 WxJF4aqr1kZrn5Aa4293srJF97A393urnxtrs3Cws3XF1UAryFg3WUGr1fZ3WxX3y8Cry7
 uF90ga1fKw4xJw1rn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVv31DUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiAwUzCmgB4rzg8QAAsZ
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

From: Yi Chen <chenyi221@huawei.com>

Mgmt module is a kind of administration module for the chip.
It is responsible for handling administration command from host.
It mainly uses aeq to implement. This patch adds related data
structures, packaged interfaces and function codes.

Signed-off-by: Yi Chen <chenyi221@huawei.com>
Reviewed-by: Xin Wang <wangxin679@h-partners.com>
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/base/hinic3_mgmt.c | 392 ++++++++++++++++++++++++++
 drivers/net/hinic3/base/hinic3_mgmt.h | 121 ++++++++
 2 files changed, 513 insertions(+)
 create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.c
 create mode 100644 drivers/net/hinic3/base/hinic3_mgmt.h

diff --git a/drivers/net/hinic3/base/hinic3_mgmt.c b/drivers/net/hinic3/base/hinic3_mgmt.c
new file mode 100644
index 0000000000..a755c5aa97
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_mgmt.c
@@ -0,0 +1,392 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+#include <rte_ethdev.h>
+
+#include "hinic3_compat.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_mbox.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_nic_event.h"
+
+#define HINIC3_MSG_TO_MGMT_MAX_LEN 2016
+
+#define MAX_PF_MGMT_BUF_SIZE 2048UL
+#define SEGMENT_LEN	     48
+#define ASYNC_MSG_FLAG	     0x20
+#define MGMT_MSG_MAX_SEQ_ID \
+	(RTE_ALIGN(HINIC3_MSG_TO_MGMT_MAX_LEN, SEGMENT_LEN) / SEGMENT_LEN)
+
+#define BUF_OUT_DEFAULT_SIZE 1
+
+#define MGMT_MSG_SIZE_MIN     20
+#define MGMT_MSG_SIZE_STEP    16
+#define MGMT_MSG_RSVD_FOR_DEV 8
+
+#define SYNC_MSG_ID_MASK  0x1F
+#define ASYNC_MSG_ID_MASK 0x1F
+
+#define SYNC_FLAG  0
+#define ASYNC_FLAG 1
+
+#define MSG_NO_RESP 0xFFFF
+
+#define MGMT_MSG_TIMEOUT 5000 /**< Millisecond. */
+
+int
+hinic3_msg_to_mgmt_sync(void *hwdev, enum hinic3_mod_type mod, u16 cmd,
+			void *buf_in, u16 in_size, void *buf_out, u16 *out_size,
+			u32 timeout)
+{
+	int err;
+
+	if (!hwdev)
+		return -EINVAL;
+
+	/* Send a mailbox message to the management. */
+	err = hinic3_send_mbox_to_mgmt(hwdev, mod, cmd, buf_in, in_size,
+				       buf_out, out_size, timeout);
+	return err;
+}
+
+int
+hinic3_msg_to_mgmt_no_ack(void *hwdev, enum hinic3_mod_type mod, u16 cmd,
+			  void *buf_in, u16 in_size)
+{
+	if (!hwdev)
+		return -EINVAL;
+
+	return hinic3_send_mbox_to_mgmt_no_ack(hwdev, mod, cmd, buf_in,
+					       in_size);
+}
+
+static void
+send_mgmt_ack(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
+	      enum hinic3_mod_type mod, u16 cmd, void *buf_in, u16 in_size,
+	      u16 msg_id)
+{
+	u16 buf_size;
+
+	if (!in_size)
+		buf_size = BUF_OUT_DEFAULT_SIZE;
+	else
+		buf_size = in_size;
+
+	hinic3_response_mbox_to_mgmt(pf_to_mgmt->hwdev, mod, cmd, buf_in,
+				     buf_size, msg_id);
+}
+
+static bool
+check_mgmt_seq_id_and_seg_len(struct hinic3_recv_msg *recv_msg, u8 seq_id,
+			      u8 seg_len, u16 msg_id)
+{
+	if (seq_id > MGMT_MSG_MAX_SEQ_ID || seg_len > SEGMENT_LEN)
+		return false;
+
+	if (seq_id == 0) {
+		recv_msg->seq_id = seq_id;
+		recv_msg->msg_id = msg_id;
+	} else {
+		if ((seq_id != recv_msg->seq_id + 1) ||
+		    msg_id != recv_msg->msg_id) {
+			recv_msg->seq_id = 0;
+			return false;
+		}
+
+		recv_msg->seq_id = seq_id;
+	}
+
+	return true;
+}
+
+static void
+hinic3_mgmt_recv_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt,
+			     struct hinic3_recv_msg *recv_msg,
+			     __rte_unused void *param)
+{
+	void *buf_out = pf_to_mgmt->mgmt_ack_buf;
+	bool ack_first = false;
+	u16 out_size = 0;
+
+	memset(buf_out, 0, MAX_PF_MGMT_BUF_SIZE);
+
+	/* Select the corresponding processing function according to the mod. */
+	switch (recv_msg->mod) {
+	case HINIC3_MOD_COMM:
+		pf_handle_mgmt_comm_event(pf_to_mgmt->hwdev,
+			pf_to_mgmt, recv_msg->cmd,
+			recv_msg->msg, recv_msg->msg_len, buf_out, &out_size);
+		break;
+	case HINIC3_MOD_L2NIC:
+		hinic3_pf_event_handler(pf_to_mgmt->hwdev, pf_to_mgmt,
+					recv_msg->cmd, recv_msg->msg,
+					recv_msg->msg_len, buf_out, &out_size);
+		break;
+	case HINIC3_MOD_HILINK:
+		hinic3_pf_mag_event_handler(pf_to_mgmt->hwdev,
+			pf_to_mgmt, recv_msg->cmd,
+			recv_msg->msg, recv_msg->msg_len, buf_out, &out_size);
+		break;
+
+	default:
+		PMD_DRV_LOG(ERR,
+			    "Not support mod, maybe need to response, mod: %d",
+			    recv_msg->mod);
+		break;
+	}
+
+	if (!ack_first && !recv_msg->async_mgmt_to_pf)
+		/* Mgmt sends async msg, sends the response. */
+		send_mgmt_ack(pf_to_mgmt, recv_msg->mod, recv_msg->cmd, buf_out,
+			      out_size, recv_msg->msg_id);
+}
+
+/**
+ * Handler a recv message from mgmt channel.
+ *
+ * @param[in] pf_to_mgmt
+ * PF to mgmt channel.
+ * @param[in] recv_msg
+ * Received message details.
+ * @param[in] param
+ * Customized parameter.
+ * @return
+ * 0 : When aeqe is response message.
+ * -1 : Default result, when wrong message or not last message.
+ */
+static int
+recv_mgmt_msg_handler(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt, u8 *header,
+		      struct hinic3_recv_msg *recv_msg, void *param)
+{
+	u64 mbox_header = *((u64 *)header);
+	void *msg_body = header + sizeof(mbox_header);
+	u8 seq_id, seq_len;
+	u32 offset;
+	u8 front_id;
+	u16 msg_id;
+
+	/* Don't need to get anything from hw when cmd is async. */
+	if (HINIC3_MSG_HEADER_GET(mbox_header, DIRECTION) ==
+	    HINIC3_MSG_RESPONSE)
+		return 0;
+
+	seq_len = HINIC3_MSG_HEADER_GET(mbox_header, SEG_LEN);
+	seq_id = HINIC3_MSG_HEADER_GET(mbox_header, SEQID);
+	msg_id = HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID);
+	front_id = recv_msg->seq_id;
+
+	/* Check the consistency between seq_id and seg_len. */
+	if (!check_mgmt_seq_id_and_seg_len(recv_msg, seq_id, seq_len, msg_id)) {
+		PMD_DRV_LOG(ERR,
+			    "Mgmt msg sequence id and segment length check "
+			    "failed, front seq_id: 0x%x, current seq_id: 0x%x,"
+			    " seg len: 0x%x front msg_id: %d, cur msg_id: %d",
+			    front_id, seq_id, seq_len, recv_msg->msg_id,
+			    msg_id);
+		/* Set seq_id to invalid seq_id. */
+		recv_msg->seq_id = MGMT_MSG_MAX_SEQ_ID;
+		return HINIC3_MSG_HANDLER_RES;
+	}
+
+	offset = seq_id * SEGMENT_LEN;
+	memcpy((u8 *)recv_msg->msg + offset, msg_body, seq_len);
+
+	if (!HINIC3_MSG_HEADER_GET(mbox_header, LAST))
+		return HINIC3_MSG_HANDLER_RES;
+	/* Setting the message receiving information. */
+	recv_msg->cmd = HINIC3_MSG_HEADER_GET(mbox_header, CMD);
+	recv_msg->mod = HINIC3_MSG_HEADER_GET(mbox_header, MODULE);
+	recv_msg->async_mgmt_to_pf = HINIC3_MSG_HEADER_GET(mbox_header, NO_ACK);
+	recv_msg->msg_len = HINIC3_MSG_HEADER_GET(mbox_header, MSG_LEN);
+	recv_msg->msg_id = HINIC3_MSG_HEADER_GET(mbox_header, MSG_ID);
+	recv_msg->seq_id = MGMT_MSG_MAX_SEQ_ID;
+
+	hinic3_mgmt_recv_msg_handler(pf_to_mgmt, recv_msg, param);
+
+	return HINIC3_MSG_HANDLER_RES;
+}
+
+/**
+ * Handler for a aeqe from mgmt channel.
+ *
+ * @param[in] hwdev
+ * The pointer to the private hardware device.
+ * @param[in] header
+ * The header of the message.
+ * @param[in] size
+ * Indicate size.
+ * @param[in] param
+ * Customized parameter.
+ * @return
+ * zero: When aeqe is response message
+ * negative: When wrong message or not last message.
+ */
+int
+hinic3_mgmt_msg_aeqe_handler(void *hwdev, u8 *header, u8 size, void *param)
+{
+	struct hinic3_hwdev *dev = (struct hinic3_hwdev *)hwdev;
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt = NULL;
+	struct hinic3_recv_msg *recv_msg = NULL;
+	bool is_send_dir = false;
+
+	/* For mbox messgae, invoke the mailbox processing function. */
+	if ((HINIC3_MSG_HEADER_GET(*(u64 *)header, SOURCE) ==
+	     HINIC3_MSG_FROM_MBOX)) {
+		return hinic3_mbox_func_aeqe_handler(hwdev, header, size,
+						     param);
+	}
+
+	pf_to_mgmt = dev->pf_to_mgmt;
+
+	is_send_dir = (HINIC3_MSG_HEADER_GET(*(u64 *)header, DIRECTION) ==
+		       HINIC3_MSG_DIRECT_SEND) ? true : false;
+
+	/* Determine whether a message is received or responsed. */
+	recv_msg = is_send_dir ? &pf_to_mgmt->recv_msg_from_mgmt
+			       : &pf_to_mgmt->recv_resp_msg_from_mgmt;
+
+	return recv_mgmt_msg_handler(pf_to_mgmt, header, recv_msg, param);
+}
+
+/**
+ * Allocate received message memory.
+ *
+ * @param[in] recv_msg
+ * Pointer that will hold the allocated data.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+alloc_recv_msg(struct hinic3_recv_msg *recv_msg)
+{
+	recv_msg->seq_id = MGMT_MSG_MAX_SEQ_ID;
+
+	recv_msg->msg = rte_zmalloc("recv_msg", MAX_PF_MGMT_BUF_SIZE,
+				    HINIC3_MEM_ALLOC_ALIGN_MIN);
+	if (!recv_msg->msg)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void
+free_recv_msg(struct hinic3_recv_msg *recv_msg)
+{
+	rte_free(recv_msg->msg);
+}
+
+/**
+ * Allocate all the message buffers of PF to mgmt channel.
+ *
+ * @param[in] pf_to_mgmt
+ * PF to mgmt channel.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+static int
+alloc_msg_buf(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt)
+{
+	int err;
+
+	err = alloc_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Allocate recv msg failed");
+		return err;
+	}
+
+	err = alloc_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Allocate resp recv msg failed");
+		goto alloc_msg_for_resp_err;
+	}
+
+	pf_to_mgmt->mgmt_ack_buf = rte_zmalloc("mgmt_ack_buf",
+					       MAX_PF_MGMT_BUF_SIZE,
+					       HINIC3_MEM_ALLOC_ALIGN_MIN);
+	if (!pf_to_mgmt->mgmt_ack_buf) {
+		err = -ENOMEM;
+		goto ack_msg_buf_err;
+	}
+
+	return 0;
+
+ack_msg_buf_err:
+	free_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);
+
+alloc_msg_for_resp_err:
+	free_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);
+	return err;
+}
+
+/**
+ * Free all the message buffers of PF to mgmt channel.
+ *
+ * @param[in] pf_to_mgmt
+ * PF to mgmt channel.
+ */
+static void
+free_msg_buf(struct hinic3_msg_pf_to_mgmt *pf_to_mgmt)
+{
+	rte_free(pf_to_mgmt->mgmt_ack_buf);
+	free_recv_msg(&pf_to_mgmt->recv_resp_msg_from_mgmt);
+	free_recv_msg(&pf_to_mgmt->recv_msg_from_mgmt);
+}
+
+/**
+ * Initialize PF to mgmt channel.
+ *
+ * @param[in] hwdev
+ * The pointer to the private hardware device.
+ * @return
+ * 0 on success, non-zero on failure.
+ */
+int
+hinic3_pf_to_mgmt_init(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt;
+	int err;
+
+	pf_to_mgmt = rte_zmalloc("pf_to_mgmt", sizeof(*pf_to_mgmt),
+				 HINIC3_MEM_ALLOC_ALIGN_MIN);
+	if (!pf_to_mgmt)
+		return -ENOMEM;
+
+	hwdev->pf_to_mgmt = pf_to_mgmt;
+	pf_to_mgmt->hwdev = hwdev;
+
+	err = hinic3_mutex_init(&pf_to_mgmt->sync_msg_mutex, NULL);
+	if (err)
+		goto mutex_init_err;
+
+	err = alloc_msg_buf(pf_to_mgmt);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Allocate msg buffers failed");
+		goto alloc_msg_buf_err;
+	}
+
+	return 0;
+
+alloc_msg_buf_err:
+	hinic3_mutex_destroy(&pf_to_mgmt->sync_msg_mutex);
+
+mutex_init_err:
+	rte_free(pf_to_mgmt);
+
+	return err;
+}
+
+/**
+ * Free PF to mgmt channel.
+ *
+ * @param[in] hwdev
+ * The pointer to the private hardware device.
+ */
+void
+hinic3_pf_to_mgmt_free(struct hinic3_hwdev *hwdev)
+{
+	struct hinic3_msg_pf_to_mgmt *pf_to_mgmt = hwdev->pf_to_mgmt;
+
+	free_msg_buf(pf_to_mgmt);
+	hinic3_mutex_destroy(&pf_to_mgmt->sync_msg_mutex);
+	rte_free(pf_to_mgmt);
+}
diff --git a/drivers/net/hinic3/base/hinic3_mgmt.h b/drivers/net/hinic3/base/hinic3_mgmt.h
new file mode 100644
index 0000000000..23454773b9
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_mgmt.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_MGMT_H_
+#define _HINIC3_MGMT_H_
+
+#define HINIC3_MSG_HANDLER_RES (-1)
+
+struct mgmt_msg_head {
+	u8 status;
+	u8 version;
+	u8 rsvd0[6];
+};
+
+/* Cmdq module type. */
+enum hinic3_mod_type {
+	HINIC3_MOD_COMM = 0,  /**< HW communication module. */
+	HINIC3_MOD_L2NIC = 1, /**< L2NIC module. */
+	HINIC3_MOD_ROCE = 2,
+	HINIC3_MOD_PLOG = 3,
+	HINIC3_MOD_TOE = 4,
+	HINIC3_MOD_FLR = 5,
+	HINIC3_MOD_FC = 6,
+	HINIC3_MOD_CFGM = 7, /**< Configuration module. */
+	HINIC3_MOD_CQM = 8,
+	HINIC3_MOD_VSWITCH = 9,
+	COMM_MOD_FC = 10,
+	HINIC3_MOD_OVS = 11,
+	HINIC3_MOD_DSW = 12,
+	HINIC3_MOD_MIGRATE = 13,
+	HINIC3_MOD_HILINK = 14,
+	HINIC3_MOD_CRYPT = 15,	/**< Secure crypto module. */
+	HINIC3_MOD_HW_MAX = 16, /**< Hardware max module id. */
+
+	HINIC3_MOD_SW_FUNC = 17, /**< SW module for PF/VF and multi-host. */
+	HINIC3_MOD_IOE = 18,
+	HINIC3_MOD_MAX
+};
+
+typedef enum {
+	RES_TYPE_FLUSH_BIT = 0,
+	RES_TYPE_MQM,
+	RES_TYPE_SMF,
+
+	RES_TYPE_COMM = 10,
+	/* Clear mbox and aeq, The RES_TYPE_COMM bit must be set. */
+	RES_TYPE_COMM_MGMT_CH,
+	/* Clear cmdq and ceq, The RES_TYPE_COMM bit must be set. */
+	RES_TYPE_COMM_CMD_CH,
+	RES_TYPE_NIC,
+	RES_TYPE_OVS,
+	RES_TYPE_VBS,
+	RES_TYPE_ROCE,
+	RES_TYPE_FC,
+	RES_TYPE_TOE,
+	RES_TYPE_IPSEC,
+	RES_TYPE_MAX,
+} func_reset_flag_e;
+
+#define HINIC3_COMM_RES                                 \
+	((1 << RES_TYPE_COMM) | (1 << RES_TYPE_FLUSH_BIT) | \
+	 (1 << RES_TYPE_MQM) | (1 << RES_TYPE_SMF) |        \
+	 (1 << RES_TYPE_COMM_CMD_CH))
+#define HINIC3_NIC_RES	 (1 << RES_TYPE_NIC)
+#define HINIC3_OVS_RES	 (1 << RES_TYPE_OVS)
+#define HINIC3_VBS_RES	 (1 << RES_TYPE_VBS)
+#define HINIC3_ROCE_RES	 (1 << RES_TYPE_ROCE)
+#define HINIC3_FC_RES	 (1 << RES_TYPE_FC)
+#define HINIC3_TOE_RES	 (1 << RES_TYPE_TOE)
+#define HINIC3_IPSEC_RES (1 << RES_TYPE_IPSEC)
+
+struct hinic3_recv_msg {
+	void *msg;
+
+	u16 msg_len;
+	enum hinic3_mod_type mod;
+	u16 cmd;
+	u8 seq_id;
+	u16 msg_id;
+	int async_mgmt_to_pf;
+};
+
+/* Indicate the event status in pf-to-management communication. */
+enum comm_pf_to_mgmt_event_state {
+	SEND_EVENT_UNINIT = 0,
+	SEND_EVENT_START,
+	SEND_EVENT_SUCCESS,
+	SEND_EVENT_FAIL,
+	SEND_EVENT_TIMEOUT,
+	SEND_EVENT_END
+};
+
+struct hinic3_msg_pf_to_mgmt {
+	struct hinic3_hwdev *hwdev;
+
+	/* Mutex for sync message. */
+	pthread_mutex_t sync_msg_mutex;
+
+	void *mgmt_ack_buf;
+
+	struct hinic3_recv_msg recv_msg_from_mgmt;
+	struct hinic3_recv_msg recv_resp_msg_from_mgmt;
+
+	u16 sync_msg_id;
+};
+
+int hinic3_mgmt_msg_aeqe_handler(void *hwdev, u8 *header, u8 size, void *param);
+
+int hinic3_pf_to_mgmt_init(struct hinic3_hwdev *hwdev);
+
+void hinic3_pf_to_mgmt_free(struct hinic3_hwdev *hwdev);
+
+int hinic3_msg_to_mgmt_sync(void *hwdev, enum hinic3_mod_type mod, u16 cmd,
+			    void *buf_in, u16 in_size, void *buf_out,
+			    u16 *out_size, u32 timeout);
+
+int hinic3_msg_to_mgmt_no_ack(void *hwdev, enum hinic3_mod_type mod, u16 cmd,
+			      void *buf_in, u16 in_size);
+
+#endif /**< _HINIC3_MGMT_H_ */
-- 
2.47.0.windows.2

