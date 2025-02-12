Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B532C02198
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Feb 2025 15:33:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 97C66427E5;
	Wed, 12 Feb 2025 16:33:22 +0100 (CET)
Received: from localhost.localdomain (unknown [103.233.162.252])
 by mails.dpdk.org (Postfix) with ESMTP id 12510427D3
 for <dev@dpdk.org>; Wed, 12 Feb 2025 16:33:21 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 28248A3650; Wed, 12 Feb 2025 23:33:20 +0800 (CST)
From: Wenbo Cao <caowenbo@mucse.com>
To: thomas@monjalon.net,
	Wenbo Cao <caowenbo@mucse.com>
Cc: stephen@networkplumber.org, dev@dpdk.org, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru, yaojun@mucse.com
Subject: [PATCH v12 04/28] net/rnp: support mailbox basic operate
Date: Wed, 12 Feb 2025 23:32:24 +0800
Message-Id: <1739374368-4949-5-git-send-email-caowenbo@mucse.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1739374368-4949-1-git-send-email-caowenbo@mucse.com>
References: <1739374368-4949-1-git-send-email-caowenbo@mucse.com>
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

This patch adds support for mailbox of rnp PMD driver,
mailbox is used for communication between pf with fw
and vf driver.

Signed-off-by: Wenbo Cao <caowenbo@mucse.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/rnp/base/meson.build |  11 +
 drivers/net/rnp/base/rnp_hw.h    |  76 +++++
 drivers/net/rnp/base/rnp_mbx.c   | 512 +++++++++++++++++++++++++++++++
 drivers/net/rnp/base/rnp_mbx.h   |  58 ++++
 drivers/net/rnp/base/rnp_osdep.h |  51 +++
 drivers/net/rnp/meson.build      |   5 +
 drivers/net/rnp/rnp.h            |  19 ++
 7 files changed, 732 insertions(+)
 create mode 100644 drivers/net/rnp/base/meson.build
 create mode 100644 drivers/net/rnp/base/rnp_hw.h
 create mode 100644 drivers/net/rnp/base/rnp_mbx.c
 create mode 100644 drivers/net/rnp/base/rnp_mbx.h
 create mode 100644 drivers/net/rnp/base/rnp_osdep.h

diff --git a/drivers/net/rnp/base/meson.build b/drivers/net/rnp/base/meson.build
new file mode 100644
index 0000000000..0430481fe4
--- /dev/null
+++ b/drivers/net/rnp/base/meson.build
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(C) 2023 Mucse IC Design Ltd.
+
+sources = [
+        'rnp_mbx.c',
+]
+
+base_lib = static_library('rnp_base', sources,
+    dependencies: [static_rte_eal, static_rte_net, static_rte_ethdev],
+    c_args: c_args)
+base_objs = base_lib.extract_all_objects(recursive: true)
diff --git a/drivers/net/rnp/base/rnp_hw.h b/drivers/net/rnp/base/rnp_hw.h
new file mode 100644
index 0000000000..ec192ba191
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_hw.h
@@ -0,0 +1,76 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+#ifndef __RNP_HW_H__
+#define __RNP_HW_H__
+
+#include "rnp_osdep.h"
+
+struct rnp_hw;
+/* Mailbox Operate Info */
+enum RNP_MBX_ID {
+	RNP_MBX_PF = 0,
+	RNP_MBX_VF,
+	RNP_MBX_FW = 64,
+};
+
+struct rnp_mbx_ops {
+	int (*read)(struct rnp_hw *hw,
+			u32 *msg,
+			u16 size,
+			enum RNP_MBX_ID);
+	int (*write)(struct rnp_hw *hw,
+			u32 *msg,
+			u16 size,
+			enum RNP_MBX_ID);
+	int (*read_posted)(struct rnp_hw *hw,
+			u32 *msg,
+			u16 size,
+			enum RNP_MBX_ID);
+	int (*write_posted)(struct rnp_hw *hw,
+			u32 *msg,
+			u16 size,
+			enum RNP_MBX_ID);
+	int (*check_for_msg)(struct rnp_hw *hw, enum RNP_MBX_ID);
+	int (*check_for_ack)(struct rnp_hw *hw, enum RNP_MBX_ID);
+	int (*check_for_rst)(struct rnp_hw *hw, enum RNP_MBX_ID);
+};
+
+struct rnp_mbx_sync {
+	u16 req;
+	u16 ack;
+};
+
+struct rnp_mbx_info {
+	const struct rnp_mbx_ops *ops;
+	u32 usec_delay;         /* retry interval delay time */
+	u32 timeout;            /* retry ops timeout limit */
+	u16 size;               /* data buffer size*/
+	u16 vf_num;             /* Virtual Function num */
+	u16 pf_num;             /* Physical Function num */
+	u16 sriov_st;           /* Sriov state */
+	u16 en_vfs;		/* user enabled vf num */
+	bool is_pf;
+
+	struct rnp_mbx_sync syncs[RNP_MBX_FW + 1];
+};
+
+struct rnp_eth_adapter;
+
+/* hw device description */
+struct rnp_hw {
+	struct rnp_eth_adapter *back;	/* backup to the adapter handle */
+	void __iomem *e_ctrl;           /* ethernet control bar */
+	void __iomem *c_ctrl;           /* crypto control bar */
+	u32 c_blen;                     /* crypto bar size */
+
+	/* pci device info */
+	u16 device_id;
+	u16 vendor_id;
+	u16 max_vfs;			/* device max support vf */
+
+	u16 pf_vf_num;
+	struct rnp_mbx_info mbx;
+};
+
+#endif /* __RNP_H__*/
diff --git a/drivers/net/rnp/base/rnp_mbx.c b/drivers/net/rnp/base/rnp_mbx.c
new file mode 100644
index 0000000000..6aed1aef7c
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_mbx.c
@@ -0,0 +1,512 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#include <string.h>
+
+#include "rnp_hw.h"
+#include "rnp_mbx.h"
+#include "../rnp.h"
+
+/****************************PF MBX OPS************************************/
+static inline u16
+rnp_mbx_get_req(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	u32 reg = 0;
+
+	if (mbx_id == RNP_MBX_FW)
+		reg = RNP_FW2PF_SYNC;
+	else
+		reg = RNP_VF2PF_SYNC(mbx_id);
+	mb();
+
+	return RNP_E_REG_RD(hw, reg) & RNP_MBX_SYNC_REQ_MASK;
+}
+
+static inline u16
+rnp_mbx_get_ack(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	u32 reg = 0;
+	u32 v = 0;
+
+	if (mbx_id == RNP_MBX_FW)
+		reg = RNP_FW2PF_SYNC;
+	else
+		reg = RNP_VF2PF_SYNC(mbx_id);
+	mb();
+	v = RNP_E_REG_RD(hw, reg);
+
+	return (v & RNP_MBX_SYNC_ACK_MASK) >> RNP_MBX_SYNC_ACK_S;
+}
+
+/*
+ * rnp_mbx_inc_pf_ack - increase ack num of mailbox sync info
+ * @hw pointer to the HW structure
+ * @sync_base: addr of sync
+ */
+static inline void
+rnp_mbx_inc_pf_req(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	u32 sync_base;
+	u32 req;
+	u32 v;
+
+	if (mbx_id == RNP_MBX_FW)
+		sync_base = RNP_PF2FW_SYNC;
+	else
+		sync_base = RNP_PF2VF_SYNC(mbx_id);
+	v = RNP_E_REG_RD(hw, sync_base);
+	req = (v & RNP_MBX_SYNC_REQ_MASK);
+	req++;
+	/* clear sync req value */
+	v &= ~(RNP_MBX_SYNC_REQ_MASK);
+	v |= req;
+
+	mb();
+	RNP_E_REG_WR(hw, sync_base, v);
+}
+
+/*
+ * rnp_mbx_inc_pf_ack - increase ack num of maixbox sync info
+ * @hw pointer to the HW structure
+ * @sync_base: addr of sync
+ */
+static inline void
+rnp_mbx_inc_pf_ack(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	u32 ack;
+	u32 reg;
+	u32 v;
+
+	if (mbx_id == RNP_MBX_FW)
+		reg = RNP_PF2FW_SYNC;
+	else
+		reg = RNP_PF2VF_SYNC(mbx_id);
+	v = RNP_E_REG_RD(hw, reg);
+	ack = (v & RNP_MBX_SYNC_ACK_MASK) >> RNP_MBX_SYNC_ACK_S;
+	ack++;
+	/* clear old sync ack */
+	v &= ~RNP_MBX_SYNC_ACK_MASK;
+	v |= (ack << RNP_MBX_SYNC_ACK_S);
+	mb();
+	RNP_E_REG_WR(hw, reg, v);
+}
+
+static void
+rnp_mbx_write_msg(struct rnp_hw *hw,
+		  u32 *msg, u16 size,
+		  enum RNP_MBX_ID mbx_id)
+{
+	u32 msg_base;
+	u16 i = 0;
+
+	if (mbx_id == RNP_MBX_FW)
+		msg_base = RNP_FW2PF_MSG_DATA;
+	else
+		msg_base = RNP_PF2VF_MSG_DATA(mbx_id);
+	for (i = 0; i < size; i++)
+		RNP_E_REG_WR(hw, msg_base + i * 4, msg[i]);
+}
+
+static void
+rnp_mbx_read_msg(struct rnp_hw *hw,
+		 u32 *msg, u16 size,
+		 enum RNP_MBX_ID mbx_id)
+{
+	u32 msg_base;
+	u16 i = 0;
+
+	if (mbx_id == RNP_MBX_FW)
+		msg_base = RNP_FW2PF_MSG_DATA;
+	else
+		msg_base = RNP_PF2VF_MSG_DATA(mbx_id);
+	for (i = 0; i < size; i++)
+		msg[i] = RNP_E_REG_RD(hw, msg_base + 4 * i);
+	mb();
+	/* clear msg cmd */
+	RNP_E_REG_WR(hw, msg_base, 0);
+}
+
+/*
+ *  rnp_poll_for_msg - Wait for message notification
+ *  @hw: pointer to the HW structure
+ *  @mbx_id: id of mailbox to write
+ *
+ *  returns SUCCESS if it successfully received a message notification
+ */
+static int
+rnp_poll_for_msg(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	struct rnp_mbx_info *mbx = &hw->mbx;
+	u32 countdown = mbx->timeout;
+
+	if (!countdown || !mbx->ops->check_for_msg)
+		goto out;
+
+	while (countdown && mbx->ops->check_for_msg(hw, mbx_id)) {
+		countdown--;
+		if (!countdown)
+			break;
+		udelay(mbx->usec_delay);
+	}
+out:
+	return countdown ? 0 : -ETIMEDOUT;
+}
+
+/*
+ *  rnp_poll_for_ack - Wait for message acknowledgment
+ *  @hw: pointer to the HW structure
+ *  @mbx_id: id of mailbox to write
+ *
+ *  returns SUCCESS if it successfully received a message acknowledgment
+ */
+static int
+rnp_poll_for_ack(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	struct rnp_mbx_info *mbx = &hw->mbx;
+	int countdown = mbx->timeout;
+
+	if (!countdown || !mbx->ops->check_for_ack)
+		goto out;
+
+	while (countdown && mbx->ops->check_for_ack(hw, mbx_id)) {
+		countdown--;
+		if (!countdown)
+			break;
+		udelay(mbx->usec_delay);
+	}
+
+out:
+	return countdown ? 0 : -ETIMEDOUT;
+}
+
+static int
+rnp_read_mbx_msg(struct rnp_hw *hw, u32 *msg, u16 size,
+		 enum RNP_MBX_ID mbx_id)
+{
+	struct rnp_mbx_info *mbx = &hw->mbx;
+	int ret = RNP_ERR_MBX;
+
+	if (size > mbx->size)
+		return -EINVAL;
+	if (mbx->ops->read)
+		return mbx->ops->read(hw, msg, size, mbx_id);
+	return ret;
+}
+
+static int
+rnp_write_mbx_msg(struct rnp_hw *hw, u32 *msg, u16 size,
+		  enum RNP_MBX_ID mbx_id)
+{
+	struct rnp_mbx_info *mbx = &hw->mbx;
+	int ret = RNP_ERR_MBX;
+
+	/* exit if either we can't write or there isn't a defined timeout */
+	if (size > mbx->size)
+		return -EINVAL;
+	if (mbx->ops->write)
+		return mbx->ops->write(hw, msg, size, mbx_id);
+	return ret;
+}
+
+/*
+ *  rnp_obtain_mbx_lock_pf - obtain mailbox lock
+ *  @hw: pointer to the HW structure
+ *  @ctrl_base: ctrl mbx addr
+ *
+ *  return SUCCESS if we obtained the mailbox lock
+ */
+static int rnp_obtain_mbx_lock_pf(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	int ret_val = -ETIMEDOUT;
+	u32 try_cnt = 5000;  /* 500ms */
+	u32 ctrl_base;
+
+	if (mbx_id == RNP_MBX_FW)
+		ctrl_base = RNP_PF2FW_MBX_CTRL;
+	else
+		ctrl_base = RNP_PF2VF_MBX_CTRL(mbx_id);
+	while (try_cnt-- > 0) {
+		/* take ownership of the buffer */
+		RNP_E_REG_WR(hw, ctrl_base, RNP_MBX_CTRL_PF_HOLD);
+		wmb();
+		/* reserve mailbox for pf used */
+		if (RNP_E_REG_RD(hw, ctrl_base) & RNP_MBX_CTRL_PF_HOLD)
+			return 0;
+		udelay(100);
+	}
+
+	RNP_PMD_LOG(WARNING, "%s: failed to get:lock",
+			__func__);
+	return ret_val;
+}
+
+static void
+rnp_obtain_mbx_unlock_pf(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	u32 ctrl_base;
+
+	if (mbx_id == RNP_MBX_FW)
+		ctrl_base = RNP_PF2FW_MBX_CTRL;
+	else
+		ctrl_base = RNP_PF2VF_MBX_CTRL(mbx_id);
+	RNP_E_REG_WR(hw, ctrl_base, 0);
+}
+
+static void
+rnp_mbx_send_irq_pf(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	u32 ctrl_base;
+
+	if (mbx_id == RNP_MBX_FW)
+		ctrl_base = RNP_PF2FW_MBX_CTRL;
+	else
+		ctrl_base = RNP_PF2VF_MBX_CTRL(mbx_id);
+
+	RNP_E_REG_WR(hw, ctrl_base, RNP_MBX_CTRL_REQ);
+}
+/*
+ *  rnp_read_mbx_pf - Read a message from the mailbox
+ *  @hw: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @mbx_id: id of request mbx target
+ *
+ *  This function copies a message from the mailbox buffer to the caller's
+ *  memory buffer.  The presumption is that the caller knows that there was
+ *  a message due to a VF/FW request so no polling for message is needed.
+ */
+static int rnp_read_mbx_pf(struct rnp_hw *hw, u32 *msg,
+			   u16 size, enum RNP_MBX_ID mbx_id)
+{
+	struct rnp_mbx_sync *sync = &hw->mbx.syncs[mbx_id];
+	struct rnp_mbx_info *mbx = &hw->mbx;
+	int ret_val = -EBUSY;
+
+	if (size > mbx->size) {
+		RNP_PMD_LOG(ERR, "%s: mbx msg block size:%d should <%d",
+				__func__, size, mbx->size);
+		return -EINVAL;
+	}
+	memset(msg, 0, sizeof(*msg) * size);
+	/* lock the mailbox to prevent pf/vf race condition */
+	ret_val = rnp_obtain_mbx_lock_pf(hw, mbx_id);
+	if (ret_val)
+		goto out_no_read;
+	/* copy the message from the mailbox memory buffer */
+	rnp_mbx_read_msg(hw, msg, size, mbx_id);
+	/* update req. sync with fw or vf */
+	sync->req = rnp_mbx_get_req(hw, mbx_id);
+	/* Acknowledge receipt and release mailbox, then we're done */
+	rnp_mbx_inc_pf_ack(hw, mbx_id);
+	mb();
+	/* free ownership of the buffer */
+	rnp_obtain_mbx_unlock_pf(hw, mbx_id);
+
+out_no_read:
+
+	return ret_val;
+}
+
+/*
+ *  rnp_write_mbx_pf - Places a message in the mailbox
+ *  @hw: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @mbx_id: id of request mbx target
+ *
+ *  returns SUCCESS if it successfully copied message into the buffer
+ */
+static int rnp_write_mbx_pf(struct rnp_hw *hw, u32 *msg, u16 size,
+			    enum RNP_MBX_ID mbx_id)
+{
+	struct rnp_mbx_sync *sync = &hw->mbx.syncs[mbx_id];
+	struct rnp_mbx_info *mbx = &hw->mbx;
+	int ret_val = 0;
+
+	if (size > mbx->size) {
+		RNP_PMD_LOG(ERR, "%s: size:%d should <%d", __func__, size,
+				mbx->size);
+		return -EINVAL;
+	}
+	/* lock the mailbox to prevent pf/vf/cpu race condition */
+	ret_val = rnp_obtain_mbx_lock_pf(hw, mbx_id);
+	if (ret_val) {
+		RNP_PMD_LOG(ERR, "%s: get mbx:%d wlock failed. "
+				"msg:0x%08x-0x%08x", __func__, mbx_id,
+				msg[0], msg[1]);
+		goto out_no_write;
+	}
+	/* copy the caller specified message to the mailbox memory buffer */
+	rnp_mbx_write_msg(hw, msg, size, mbx_id);
+	/* flush msg and acks as we are overwriting the message buffer */
+	sync->ack = rnp_mbx_get_ack(hw, mbx_id);
+	rnp_mbx_inc_pf_req(hw, mbx_id);
+	udelay(300);
+	mb();
+	/* interrupt VF/FW to tell it a message has been sent and release buf */
+	rnp_mbx_send_irq_pf(hw, mbx_id);
+
+out_no_write:
+
+	return ret_val;
+}
+
+/*
+ *  rnp_read_posted_mbx - Wait for message notification and receive message
+ *  @hw: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @mbx_id: id of mailbox to write
+ *
+ *  returns SUCCESS if it successfully received a message notification and
+ *  copied it into the receive buffer.
+ */
+static int32_t
+rnp_read_posted_mbx(struct rnp_hw *hw,
+		    u32 *msg, u16 size, enum RNP_MBX_ID mbx_id)
+{
+	int ret_val = -EINVAL;
+
+	ret_val = rnp_poll_for_msg(hw, mbx_id);
+	/* if ack received read message, otherwise we timed out */
+	if (!ret_val)
+		return rnp_read_mbx_msg(hw, msg, size, mbx_id);
+	return ret_val;
+}
+
+/*
+ *  rnp_write_posted_mbx - Write a message to the mailbox, wait for ack
+ *  @hw: pointer to the HW structure
+ *  @msg: The message buffer
+ *  @size: Length of buffer
+ *  @mbx_id: id of mailbox to write
+ *
+ *  returns SUCCESS if it successfully copied message into the buffer and
+ *  received an ack to that message within delay * timeout period
+ */
+static int rnp_write_posted_mbx(struct rnp_hw *hw,
+				u32 *msg, u16 size,
+				enum RNP_MBX_ID mbx_id)
+{
+	int ret_val = RNP_ERR_MBX;
+
+	ret_val = rnp_write_mbx_msg(hw, msg, size, mbx_id);
+	if (ret_val)
+		return ret_val;
+	/* if msg sent wait until we receive an ack */
+	if (!ret_val)
+		ret_val = rnp_poll_for_ack(hw, mbx_id);
+	return ret_val;
+}
+
+/*
+ *  rnp_check_for_msg_pf - checks to see if the VF/FW has sent mail
+ *  @hw: pointer to the HW structure
+ *  @mbx_id: id of mailbox to write
+ *
+ *  returns SUCCESS if the VF has set the Status bit or else ERR_MBX
+ */
+static int rnp_check_for_msg_pf(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	struct rnp_mbx_sync *sync = &hw->mbx.syncs[mbx_id];
+	int ret_val = RNP_ERR_MBX;
+
+	if (rnp_mbx_get_req(hw, mbx_id) != sync->req)
+		ret_val = 0;
+
+	return ret_val;
+}
+
+/*
+ *  rnp_check_for_ack_pf - checks to see if the VF/FW has ACKed
+ *  @hw: pointer to the HW structure
+ *  @mbx_id: id of mailbox to write
+ *
+ *  returns SUCCESS if the VF has set the Status bit or else ERR_MBX
+ */
+static int rnp_check_for_ack_pf(struct rnp_hw *hw, enum RNP_MBX_ID mbx_id)
+{
+	struct rnp_mbx_sync *sync = &hw->mbx.syncs[mbx_id];
+	int ret_val = RNP_ERR_MBX;
+
+	if (rnp_mbx_get_ack(hw, mbx_id) != sync->ack)
+		ret_val = 0;
+
+	return ret_val;
+}
+
+const struct rnp_mbx_ops rnp_mbx_ops_pf = {
+	.read = rnp_read_mbx_pf,
+	.write = rnp_write_mbx_pf,
+	.read_posted = rnp_read_posted_mbx,
+	.write_posted = rnp_write_posted_mbx,
+	.check_for_msg = rnp_check_for_msg_pf,
+	.check_for_ack = rnp_check_for_ack_pf,
+};
+
+static int rnp_get_pfvfnum(struct rnp_hw *hw)
+{
+	u32 addr_mask;
+	u32 offset;
+	u32 val;
+
+	addr_mask = hw->c_blen - 1;
+	offset = RNP_SRIOV_INFO & addr_mask;
+	val = RNP_REG_RD(hw->c_ctrl, offset);
+
+	return val >> RNP_PFVF_SHIFT;
+}
+
+static void rnp_mbx_reset(struct rnp_hw *hw)
+{
+	struct rnp_mbx_sync *sync = hw->mbx.syncs;
+	int idx = 0;
+	u32 v = 0;
+
+	for (idx = 0; idx < hw->mbx.en_vfs; idx++) {
+		v = RNP_E_REG_RD(hw, RNP_VF2PF_SYNC(idx));
+		sync[idx].ack = (v & RNP_MBX_SYNC_ACK_MASK) >> RNP_MBX_SYNC_ACK_S;
+		sync[idx].req = v & RNP_MBX_SYNC_REQ_MASK;
+		/* release pf<->vf pf used buffer lock */
+		RNP_E_REG_WR(hw, RNP_PF2VF_MBX_CTRL(idx), 0);
+	}
+	/* reset pf->fw status */
+	v = RNP_E_REG_RD(hw, RNP_FW2PF_SYNC);
+	sync[RNP_MBX_FW].ack = (v & RNP_MBX_SYNC_ACK_MASK) >> RNP_MBX_SYNC_ACK_S;
+	sync[RNP_MBX_FW].req = v & RNP_MBX_SYNC_REQ_MASK;
+
+	RNP_PMD_LOG(INFO, "now fw_req %d fw_ack %d",
+			hw->mbx.syncs[idx].req, hw->mbx.syncs[idx].ack);
+	/* release pf->fw buffer lock */
+	RNP_E_REG_WR(hw, RNP_PF2FW_MBX_CTRL, 0);
+	/* setup mailbox vec id */
+	RNP_E_REG_WR(hw, RNP_FW2PF_MBOX_VEC, RNP_MISC_VEC_ID);
+	/* enable 0-31 vf interrupt */
+	RNP_E_REG_WR(hw, RNP_PF2VF_INTR_MASK(0), 0);
+	/* enable 32-63 vf interrupt */
+	RNP_E_REG_WR(hw, RNP_PF2VF_INTR_MASK(33), 0);
+	/* enable firmware interrupt */
+	RNP_E_REG_WR(hw, RNP_FW2PF_INTR_MASK, 0);
+}
+
+int rnp_init_mbx_pf(struct rnp_hw *hw)
+{
+	struct rnp_proc_priv *proc_priv = RNP_DEV_TO_PROC_PRIV(hw->back->eth_dev);
+	struct rnp_mbx_info *mbx = &hw->mbx;
+	u32 pf_vf_num;
+
+	pf_vf_num = rnp_get_pfvfnum(hw);
+	mbx->usec_delay = RNP_MBX_DELAY_US;
+	mbx->timeout = RNP_MBX_MAX_TM_SEC / mbx->usec_delay;
+	mbx->size = RNP_MBX_MSG_BLOCK_SIZE;
+	mbx->pf_num = (pf_vf_num & RNP_PF_BIT_MASK) ? 1 : 0;
+	mbx->vf_num = UINT16_MAX;
+	mbx->ops = &rnp_mbx_ops_pf;
+	proc_priv->mbx_ops = &rnp_mbx_ops_pf;
+	hw->pf_vf_num = pf_vf_num;
+	mbx->is_pf = 1;
+	rnp_mbx_reset(hw);
+
+	return 0;
+}
diff --git a/drivers/net/rnp/base/rnp_mbx.h b/drivers/net/rnp/base/rnp_mbx.h
new file mode 100644
index 0000000000..b24165722c
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_mbx.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef __RNP_MBX_H__
+#define __RNP_MBX_H__
+
+#include "rnp_osdep.h"
+
+#include "rnp_hw.h"
+
+#define RNP_ISOLATE_CTRL	(0x7982fc)
+#define RNP_SRIOV_INFO		(0x75f000)
+#define RNP_PFVF_SHIFT		(4)
+#define RNP_PF_BIT_MASK		RTE_BIT32(6)
+
+#define RNP_MBX_MSG_BLOCK_SIZE	(14)
+/* mailbox share memory detail divide */
+/*|0------------------15|---------------------31|
+ *|------master-req-----|-------master-ack------|
+ *|------slave-req------|-------slave-ack-------|
+ *|---------------------|-----------------------|
+ *|		data(56 bytes)			|
+ *----------------------------------------------|
+ */
+/* FW <--> PF */
+#define RNP_FW2PF_MBOX_VEC	_MSI_(0x5300)
+#define RNP_FW2PF_MEM_BASE	_MSI_(0xa000)
+#define RNP_FW2PF_SYNC		(RNP_FW2PF_MEM_BASE + 0)
+#define RNP_PF2FW_SYNC		(RNP_FW2PF_MEM_BASE + 4)
+#define RNP_FW2PF_MSG_DATA	(RNP_FW2PF_MEM_BASE + 8)
+#define RNP_PF2FW_MBX_CTRL	_MSI_(0xa100)
+#define RNP_FW2PF_MBX_CTRL	_MSI_(0xa200)
+#define RNP_FW2PF_INTR_MASK	_MSI_(0xa300)
+/* PF <-> VF */
+#define RNP_PF2VF_MBOX_VEC(vf)	_MSI_(0x5100 + (4 * (vf)))
+#define RNP_PF2VF_MEM_BASE(vf)	_MSI_(0x6000 + (64 * (vf)))
+#define RNP_PF2VF_SYNC(vf)	(RNP_PF2VF_MEM_BASE(vf) + 0)
+#define RNP_VF2PF_SYNC(vf)	(RNP_PF2VF_MEM_BASE(vf) + 4)
+#define RNP_PF2VF_MSG_DATA(vf)	(RNP_PF2VF_MEM_BASE(vf) + 8)
+#define RNP_VF2PF_MBX_CTRL(vf)	_MSI_(0x7000 + ((vf) * 4))
+#define RNP_PF2VF_MBX_CTRL(vf)	_MSI_(0x7100 + ((vf) * 4))
+#define RNP_PF2VF_INTR_MASK(vf)	_MSI_(0x7200 + ((((vf) & 32) / 32) * 0x4))
+/* sync memory define */
+#define RNP_MBX_SYNC_REQ_MASK	RTE_GENMASK32(15, 0)
+#define RNP_MBX_SYNC_ACK_MASK	RTE_GENMASK32(31, 16)
+#define RNP_MBX_SYNC_ACK_S	(16)
+/* for pf <--> fw/vf */
+#define RNP_MBX_CTRL_PF_HOLD	RTE_BIT32(3) /* VF:RO, PF:WR */
+#define RNP_MBX_CTRL_REQ	RTE_BIT32(0) /* msg write request */
+
+#define RNP_MBX_DELAY_US	(100) /* delay us for retry */
+#define RNP_MBX_MAX_TM_SEC	(4 * 1000 * 1000) /* 4 sec */
+
+#define RNP_ERR_MBX		(-100)
+int rnp_init_mbx_pf(struct rnp_hw *hw);
+
+#endif /* _RNP_MBX_H_ */
diff --git a/drivers/net/rnp/base/rnp_osdep.h b/drivers/net/rnp/base/rnp_osdep.h
new file mode 100644
index 0000000000..2902ddd333
--- /dev/null
+++ b/drivers/net/rnp/base/rnp_osdep.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(C) 2023 Mucse IC Design Ltd.
+ */
+
+#ifndef _RNP_OSDEP_H
+#define _RNP_OSDEP_H
+
+#include <stdint.h>
+#include <stdbool.h>
+#include <inttypes.h>
+
+#include <rte_io.h>
+#include <rte_log.h>
+#include <rte_cycles.h>
+
+#include "../rnp_logs.h"
+
+typedef uint8_t u8;
+typedef uint16_t u16;
+typedef uint32_t u32;
+
+#define mb()	rte_mb()
+#define wmb()	rte_wmb()
+
+#define udelay(x) rte_delay_us(x)
+
+#define _MSI_(off)	((off) + (0xA0000))
+
+#define __iomem
+static inline u32
+rnp_reg_read32(const void *base, size_t offset)
+{
+	u32 v = rte_read32(((const u8 *)base + offset));
+
+	RNP_PMD_REG_LOG(DEBUG, "offset=%p val=%#"PRIx32"", offset, v);
+	return v;
+}
+
+static inline void
+rnp_reg_write32(volatile void *base, size_t offset, u32 val)
+{
+	RNP_PMD_REG_LOG(DEBUG, "offset=%p val=%#"PRIx32"", offset, val);
+	rte_write32(val, ((volatile u8 *)base + offset));
+}
+
+#define RNP_REG_RD(base, offset)	rnp_reg_read32(base, offset)
+#define RNP_REG_WR(base, offset, value)	rnp_reg_write32(base, offset, value)
+#define RNP_E_REG_WR(hw, off, value)	rnp_reg_write32((hw)->e_ctrl, (off), (value))
+#define RNP_E_REG_RD(hw, off)		rnp_reg_read32((hw)->e_ctrl, (off))
+
+#endif /* _RNP_OSDEP_H_ */
diff --git a/drivers/net/rnp/meson.build b/drivers/net/rnp/meson.build
index 8f8c4b12e3..f7a7c3de97 100644
--- a/drivers/net/rnp/meson.build
+++ b/drivers/net/rnp/meson.build
@@ -13,6 +13,11 @@ if arch_subdir == 'riscv'
     subdir_done()
 endif
 
+subdir('base')
+objs = [base_objs]
+
+includes += include_directories('base')
+
 sources = files(
                 'rnp_ethdev.c',
 )
diff --git a/drivers/net/rnp/rnp.h b/drivers/net/rnp/rnp.h
index 6cd717a36e..904b7ad2f8 100644
--- a/drivers/net/rnp/rnp.h
+++ b/drivers/net/rnp/rnp.h
@@ -4,10 +4,29 @@
 #ifndef __RNP_H__
 #define __RNP_H__
 
+#include <ethdev_driver.h>
+#include <rte_interrupts.h>
+
+#include "base/rnp_hw.h"
+
 #define PCI_VENDOR_ID_MUCSE	(0x8848)
 #define RNP_DEV_ID_N10G		(0x1000)
+#define RNP_MAX_VF_NUM		(64)
+#define RNP_MISC_VEC_ID		RTE_INTR_VEC_ZERO_OFFSET
+
+struct rnp_proc_priv {
+	const struct rnp_mbx_ops *mbx_ops;
+};
 
 struct rnp_eth_port {
 };
 
+struct rnp_eth_adapter {
+	struct rnp_hw hw;
+	struct rte_eth_dev *eth_dev; /* alloc eth_dev by platform */
+};
+
+#define RNP_DEV_TO_PROC_PRIV(eth_dev) \
+	((struct rnp_proc_priv *)(eth_dev)->process_private)
+
 #endif /* __RNP_H__ */
-- 
2.48.1

