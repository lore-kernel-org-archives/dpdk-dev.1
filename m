Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C08103E168
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 12:33:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C37C34065C;
	Wed, 18 Mar 2026 13:32:42 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTP id B0176402A0
 for <dev@dpdk.org>; Wed, 18 Mar 2026 13:32:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=R8RpNQKqvxk4jiqwqOr3aoQKWJPQJhjZXRK+St3nrts=;
 b=B8Oi/22hswHDcJYzZZPz2rmM6G6WZ5wGt0/waP709jxnJmo7mojXkG8QMiFENJ
 h9qTg2fhNm895jrYIJJ6RuFOxdu0MUnZpusjsGEqoELmrGGnVz2DTF2reu24XDcN
 yqAQ8uek+W9wRBmEWuQP4w/upV7NPaQhL5GEO3MYf6Rc4=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgDXr95am7pplRv4Ag--.47359S6;
 Wed, 18 Mar 2026 20:32:32 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V5 2/7] net/hinic3: add enhance cmdq support for new SPx series NIC
Date: Wed, 18 Mar 2026 20:31:57 +0800
Message-ID: <20260318123208.2199-3-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260318123208.2199-1-wff_light@vip.163.com>
References: <20260131100608.12429-2-wff_light@vip.163.com>
 <20260318123208.2199-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: Ac8vCgDXr95am7pplRv4Ag--.47359S6
X-Coremail-Antispam: 1Uf129KBjvAXoWDZr1UKry8Gw4rXFy7Cr47CFg_yoW7Gw43uo
 WfJr4fKr1Fq340kw1DK3yIkFZxJwn8Z3Z8Jana9FZFq3ZrJF97tay3Jw4rW3W8ZrW5AF17
 CFW3JwsYq3ykuw1Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrYL9UUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMgAIEmm6m2BgtwAA3X
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

From: Feifei Wang <wangfeifei40@huawei.com>=0D

Add enhance command queue for new SPx series NIC=0D
=0D
New SPx series NIC uses enhance command queue to send messages to=0D
hardware NIC, which is different from previous SPx NIC's common=0D
command queue.HINIC3_CMDQ_BUF_SIZE changed from 2048 to 1024 to adapt to=0D
the two types of NICs.=0D
=0D
Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_cmd.h          |  80 ++--=0D
 drivers/net/hinic3/base/hinic3_cmdq.c         | 370 +++++++-----------=0D
 drivers/net/hinic3/base/hinic3_cmdq.h         | 112 +++++-=0D
 drivers/net/hinic3/base/hinic3_cmdq_enhance.c | 111 ++++++=0D
 drivers/net/hinic3/base/hinic3_cmdq_enhance.h | 125 ++++++=0D
 drivers/net/hinic3/base/hinic3_hw_comm.c      |  15 +-=0D
 drivers/net/hinic3/base/hinic3_hw_comm.h      |  31 +-=0D
 drivers/net/hinic3/base/hinic3_hwdev.c        |  13 +-=0D
 drivers/net/hinic3/base/hinic3_hwdev.h        |  18 +=0D
 drivers/net/hinic3/base/hinic3_mgmt.c         |   5 +-=0D
 drivers/net/hinic3/base/hinic3_mgmt.h         |   2 +=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  77 ++--=0D
 drivers/net/hinic3/base/meson.build           |   1 +=0D
 13 files changed, 627 insertions(+), 333 deletions(-)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_cmd.h b/drivers/net/hinic3/base=
/hinic3_cmd.h=0D
index 6042ca51bd..f2d5d47522 100644=0D
--- a/drivers/net/hinic3/base/hinic3_cmd.h=0D
+++ b/drivers/net/hinic3/base/hinic3_cmd.h=0D
@@ -23,14 +23,21 @@=0D
 #define HINIC3_RSS_TYPE_GET(val, member)	\=0D
 	(((uint32_t)(val) >> HINIC3_RSS_TYPE_##member##_SHIFT) & 0x1)=0D
 =0D
+#define CMDQ_PFN(addr, page_size) ((addr) >> (rte_log2_u32(page_size)))=0D
+=0D
 /* NIC CMDQ MODE. */=0D
 enum hinic3_ucode_cmd {=0D
-	HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX	=3D 0,=0D
-	HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT	=3D 1,=0D
-	HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE	=3D 4,=0D
-	HINIC3_UCODE_CMD_SET_RSS_CONTEXT_TABLE	=3D 5,=0D
-	HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE	=3D 6,=0D
-	HINIC3_UCODE_CMD_SET_RQ_FLUSH		=3D 10,=0D
+	HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX =3D 0,=0D
+	HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT,=0D
+	HINIC3_UCODE_CMD_ARM_SQ,=0D
+	HINIC3_UCODE_CMD_ARM_RQ,=0D
+	HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE,=0D
+	HINIC3_UCODE_CMD_SET_RSS_CONTEXT_TABLE,=0D
+	HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE,=0D
+	HINIC3_UCODE_CMD_GET_RSS_CONTEXT_TABLE,=0D
+	HINIC3_UCODE_CMD_SET_IQ_ENABLE,=0D
+	HINIC3_UCODE_CMD_SET_RQ_FLUSH =3D 10,=0D
+	HINIC3_UCODE_CMD_MODIFY_VLAN_CTX,=0D
 };=0D
 =0D
 /* Commands between NIC to MPU. */=0D
@@ -51,6 +58,12 @@ enum hinic3_nic_cmd {=0D
 	HINIC3_NIC_CMD_CFG_RX_LRO			=3D 13,=0D
 	HINIC3_NIC_CMD_CFG_LRO_TIMER			=3D 14,=0D
 	HINIC3_NIC_CMD_FEATURE_NEGO			=3D 15,=0D
+	HINIC3_NIC_CMD_CFG_LOCAL_LRO_STATE		=3D 16,=0D
+=0D
+	HINIC3_NIC_CMD_CACHE_OUT_QP_RES			=3D 17,=0D
+	HINIC3_NIC_CMD_SET_RQ_CI_CTX			=3D 18,=0D
+	HINIC3_NIC_CMD_SET_RQ_ENABLE			=3D 19,=0D
+=0D
 	/* MAC & VLAN CFG */=0D
 	HINIC3_NIC_CMD_GET_MAC				=3D 20,=0D
 	HINIC3_NIC_CMD_SET_MAC				=3D 21,=0D
@@ -59,6 +72,10 @@ enum hinic3_nic_cmd {=0D
 	HINIC3_NIC_CMD_CFG_FUNC_VLAN			=3D 25,=0D
 	HINIC3_NIC_CMD_SET_VLAN_FILTER_EN		=3D 26,=0D
 	HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD		=3D 27,=0D
+=0D
+	HINIC3_NIC_CMD_SET_RQ_CI_CTX_HTN		=3D 34,=0D
+	HINIC3_NIC_CMD_SET_RQ_ENABLE_HTN		=3D 35,=0D
+=0D
 	/* RSS CFG */=0D
 	HINIC3_NIC_CMD_RSS_CFG				=3D 60,=0D
 	HINIC3_NIC_CMD_RSS_TEMP_MGR			=3D 61,=0D
@@ -89,6 +106,7 @@ enum hinic3_mgmt_cmd {=0D
 	HINIC3_MGMT_CMD_CFG_PAGESIZE			=3D 22,=0D
 	HINIC3_MGMT_CMD_CFG_MSIX_CTRL_REG		=3D 23,=0D
 	HINIC3_MGMT_CMD_SET_DMA_ATTR			=3D 25,=0D
+	HINIC3_MGMT_CMD_SET_ENHANCE_CMDQ_CTXT		=3D 26,=0D
 	HINIC3_MGMT_CMD_GET_MQM_FIX_INFO		=3D 40,=0D
 	HINIC3_MGMT_CMD_GET_FW_VERSION			=3D 60,=0D
 	HINIC3_MGMT_CMD_GET_BOARD_INFO			=3D 61,=0D
@@ -97,39 +115,39 @@ enum hinic3_mgmt_cmd {=0D
 };=0D
 =0D
 enum mag_cmd {=0D
-	SERDES_CMD_PROCESS	  =3D 0,=0D
+	SERDES_CMD_PROCESS		=3D 0,=0D
 =0D
-	MAG_CMD_SET_PORT_CFG      =3D 1,=0D
-	MAG_CMD_SET_PORT_ADAPT    =3D 2,=0D
-	MAG_CMD_CFG_LOOPBACK_MODE =3D 3,=0D
+	MAG_CMD_SET_PORT_CFG		=3D 1,=0D
+	MAG_CMD_SET_PORT_ADAPT		=3D 2,=0D
+	MAG_CMD_CFG_LOOPBACK_MODE	=3D 3,=0D
 =0D
-	MAG_CMD_GET_PORT_ENABLE   =3D 5,=0D
-	MAG_CMD_SET_PORT_ENABLE   =3D 6,=0D
-	MAG_CMD_GET_LINK_STATUS   =3D 7,=0D
-	MAG_CMD_SET_LINK_FOLLOW   =3D 8,=0D
-	MAG_CMD_SET_PMA_ENABLE    =3D 9,=0D
-	MAG_CMD_CFG_FEC_MODE      =3D 10,=0D
+	MAG_CMD_GET_PORT_ENABLE		=3D 5,=0D
+	MAG_CMD_SET_PORT_ENABLE		=3D 6,=0D
+	MAG_CMD_GET_LINK_STATUS		=3D 7,=0D
+	MAG_CMD_SET_LINK_FOLLOW		=3D 8,=0D
+	MAG_CMD_SET_PMA_ENABLE		=3D 9,=0D
+	MAG_CMD_CFG_FEC_MODE		=3D 10,=0D
 =0D
 	/* PHY */=0D
-	MAG_CMD_GET_XSFP_INFO     =3D 60,=0D
-	MAG_CMD_SET_XSFP_ENABLE   =3D 61,=0D
-	MAG_CMD_GET_XSFP_PRESENT  =3D 62,=0D
+	MAG_CMD_GET_XSFP_INFO		=3D 60,=0D
+	MAG_CMD_SET_XSFP_ENABLE		=3D 61,=0D
+	MAG_CMD_GET_XSFP_PRESENT	=3D 62,=0D
 	/* sfp/qsfp single byte read/write, for equipment test. */=0D
-	MAG_CMD_SET_XSFP_RW       =3D 63,=0D
-	MAG_CMD_CFG_XSFP_TEMPERATURE =3D 64,=0D
+	MAG_CMD_SET_XSFP_RW		=3D 63,=0D
+	MAG_CMD_CFG_XSFP_TEMPERATURE	=3D 64,=0D
 =0D
-	MAG_CMD_WIRE_EVENT        =3D 100,=0D
-	MAG_CMD_LINK_ERR_EVENT    =3D 101,=0D
+	MAG_CMD_WIRE_EVENT		=3D 100,=0D
+	MAG_CMD_LINK_ERR_EVENT		=3D 101,=0D
 =0D
-	MAG_CMD_EVENT_PORT_INFO   =3D 150,=0D
-	MAG_CMD_GET_PORT_STAT     =3D 151,=0D
-	MAG_CMD_CLR_PORT_STAT     =3D 152,=0D
-	MAG_CMD_GET_PORT_INFO     =3D 153,=0D
-	MAG_CMD_GET_PCS_ERR_CNT   =3D 154,=0D
-	MAG_CMD_GET_MAG_CNT       =3D 155,=0D
-	MAG_CMD_DUMP_ANTRAIN_INFO =3D 156,=0D
+	MAG_CMD_EVENT_PORT_INFO		=3D 150,=0D
+	MAG_CMD_GET_PORT_STAT		=3D 151,=0D
+	MAG_CMD_CLR_PORT_STAT		=3D 152,=0D
+	MAG_CMD_GET_PORT_INFO		=3D 153,=0D
+	MAG_CMD_GET_PCS_ERR_CNT		=3D 154,=0D
+	MAG_CMD_GET_MAG_CNT		=3D 155,=0D
+	MAG_CMD_DUMP_ANTRAIN_INFO	=3D 156,=0D
 =0D
-	MAG_CMD_MAX =3D 0xFF=0D
+	MAG_CMD_MAX			=3D 0xFF=0D
 };=0D
 =0D
 #endif /* _HINIC3_CMD_H_ */=0D
diff --git a/drivers/net/hinic3/base/hinic3_cmdq.c b/drivers/net/hinic3/bas=
e/hinic3_cmdq.c=0D
index e2b30ff94e..9c27c6f54c 100644=0D
--- a/drivers/net/hinic3/base/hinic3_cmdq.c=0D
+++ b/drivers/net/hinic3/base/hinic3_cmdq.c=0D
@@ -5,6 +5,7 @@=0D
 #include "hinic3_compat.h"=0D
 #include "hinic3_cmd.h"=0D
 #include "hinic3_cmdq.h"=0D
+#include "hinic3_cmdq_enhance.h"=0D
 #include "hinic3_hwdev.h"=0D
 #include "hinic3_hwif.h"=0D
 #include "hinic3_mgmt.h"=0D
@@ -125,17 +126,17 @@=0D
 =0D
 #define CMDQ_DB_ADDR(db_base, pi) ((db_base) + CMDQ_DB_PI_OFF(pi))=0D
 =0D
-#define CMDQ_PFN(addr, page_size) ((addr) >> (rte_log2_u32(page_size)))=0D
-=0D
 #define FIRST_DATA_TO_WRITE_LAST sizeof(uint64_t)=0D
 =0D
-#define WQE_LCMD_SIZE 64=0D
-#define WQE_SCMD_SIZE 64=0D
+#define WQE_LCMDQ_SIZE 64=0D
+#define WQE_SCMDQ_SIZE 64=0D
+#define WQE_ENHANCE_CMDQ_SIZE 32=0D
 =0D
 #define COMPLETE_LEN 3=0D
 =0D
 #define CMDQ_WQEBB_SIZE	 64=0D
 #define CMDQ_WQEBB_SHIFT 6=0D
+#define CMDQ_ENHANCE_WQEBB_SHIFT 4=0D
 =0D
 #define CMDQ_WQE_SIZE 64=0D
 =0D
@@ -203,43 +204,6 @@ hinic3_free_cmd_buf(struct hinic3_cmd_buf *cmd_buf)=0D
 	rte_free(cmd_buf);=0D
 }=0D
 =0D
-static uint32_t=0D
-cmdq_wqe_size(enum cmdq_wqe_type wqe_type)=0D
-{=0D
-	uint32_t wqe_size =3D 0;=0D
-=0D
-	switch (wqe_type) {=0D
-	case WQE_LCMD_TYPE:=0D
-		wqe_size =3D WQE_LCMD_SIZE;=0D
-		break;=0D
-	case WQE_SCMD_TYPE:=0D
-		wqe_size =3D WQE_SCMD_SIZE;=0D
-		break;=0D
-	}=0D
-=0D
-	return wqe_size;=0D
-}=0D
-=0D
-static uint32_t=0D
-cmdq_get_wqe_size(enum bufdesc_len len)=0D
-{=0D
-	uint32_t wqe_size =3D 0;=0D
-=0D
-	switch (len) {=0D
-	case BUFDESC_LCMD_LEN:=0D
-		wqe_size =3D WQE_LCMD_SIZE;=0D
-		break;=0D
-	case BUFDESC_SCMD_LEN:=0D
-		wqe_size =3D WQE_SCMD_SIZE;=0D
-		break;=0D
-	default:=0D
-		PMD_DRV_LOG(ERR, "Invalid bufdesc_len");=0D
-		break;=0D
-	}=0D
-=0D
-	return wqe_size;=0D
-}=0D
-=0D
 static void=0D
 cmdq_set_completion(struct hinic3_cmdq_completion *complete,=0D
 		    struct hinic3_cmd_buf *buf_out)=0D
@@ -274,11 +238,11 @@ cmdq_set_db(struct hinic3_cmdq *cmdq, enum hinic3_cmd=
q_type cmdq_type,=0D
 }=0D
 =0D
 static void=0D
-cmdq_wqe_fill(void *dst, void *src)=0D
+cmdq_wqe_fill(void *dst, void *src, int wqe_size)=0D
 {=0D
 	memcpy((void *)((uint8_t *)dst + FIRST_DATA_TO_WRITE_LAST),=0D
 	       (void *)((uint8_t *)src + FIRST_DATA_TO_WRITE_LAST),=0D
-	       CMDQ_WQE_SIZE - FIRST_DATA_TO_WRITE_LAST);=0D
+	       wqe_size - FIRST_DATA_TO_WRITE_LAST);=0D
 =0D
 	/* The first 8 bytes should be written last. */=0D
 	rte_atomic_thread_fence(rte_memory_order_release);=0D
@@ -369,182 +333,94 @@ cmdq_set_lcmd_wqe(struct hinic3_cmdq_wqe *wqe, enum =
cmdq_cmd_type cmd_type,=0D
 	cmdq_set_lcmd_bufdesc(wqe_lcmd, buf_in);=0D
 }=0D
 =0D
-/**=0D
- * Prepare necessary context for command queue, send a synchronous command=
 with=0D
- * a direct response to hardware. It waits for completion of command by po=
lling=0D
- * command queue for a response.=0D
- *=0D
- * @param[in] cmdq=0D
- * The command queue object that represents the queue to send the command =
to.=0D
- * @param[in] mod=0D
- * The module type that the command belongs to.=0D
- * @param[in] cmd=0D
- * The command to be executed.=0D
- * @param[in] buf_in=0D
- * The input buffer containing the command parameters.=0D
- * @param[out] out_param=0D
- * A pointer to the location where the response data will be stored, if=0D
- * available.=0D
- * @param[in] timeout=0D
- * The timeout value (ms) to wait for the command completion. If zero, a d=
efault=0D
- * timeout will be used.=0D
- *=0D
- * @return=0D
- * 0 on success, non-zero on failure.=0D
- * - -EBUSY: The command queue is busy.=0D
- * - -ETIMEDOUT: The command did not complete within the specified timeout=
.=0D
- */=0D
-static int=0D
-cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, enum hinic3_mod_type m=
od,=0D
-			  uint8_t cmd, struct hinic3_cmd_buf *buf_in,=0D
-			  uint64_t *out_param, uint32_t timeout)=0D
+static void=0D
+cmdq_sync_wqe_prepare(struct hinic3_cmdq *cmdq, uint8_t mod, uint8_t cmd,=
=0D
+		      struct hinic3_cmd_buf *buf_in, struct hinic3_cmd_buf *buf_out,=0D
+		      struct hinic3_cmdq_wqe *curr_wqe, uint16_t curr_pi,=0D
+		      enum hinic3_cmdq_cmd_type nic_cmd_type)=0D
 {=0D
 	struct hinic3_cmdq_wqe wqe;=0D
-	struct hinic3_wq *wq =3D cmdq->wq;=0D
-	struct hinic3_cmdq_wqe *curr_wqe =3D NULL;=0D
-	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd =3D NULL;=0D
-	uint16_t curr_prod_idx, next_prod_idx, num_wqebbs;=0D
-	uint32_t timeo, wqe_size;=0D
-	int wrapped, err;=0D
+	int wrapped, wqe_size;=0D
+	enum cmdq_cmd_type cmd_type;=0D
 =0D
-	wqe_size =3D cmdq_wqe_size(WQE_LCMD_TYPE);=0D
-	num_wqebbs =3D WQE_NUM_WQEBBS(wqe_size, wq);=0D
+	wqe_size =3D cmdq->cmdqs->cmdq_mode =3D=3D HINIC3_NORMAL_CMDQ ?=0D
+					     WQE_LCMDQ_SIZE : WQE_ENHANCE_CMDQ_SIZE;=0D
 =0D
-	/* ensure thread safety and maintain wrapped and doorbell index correct. =
*/=0D
-	rte_spinlock_lock(&cmdq->cmdq_lock);=0D
+	memset(&wqe, 0, (uint32_t)wqe_size);=0D
 =0D
-	curr_wqe =3D hinic3_get_wqe(cmdq->wq, num_wqebbs, &curr_prod_idx);=0D
-	if (curr_wqe =3D=3D NULL) {=0D
-		err =3D -EBUSY;=0D
-		goto cmdq_unlock;=0D
-	}=0D
-=0D
-	memset(&wqe, 0, sizeof(wqe));=0D
 	wrapped =3D cmdq->wrapped;=0D
 =0D
-	next_prod_idx =3D curr_prod_idx + num_wqebbs;=0D
-	if (next_prod_idx >=3D wq->q_depth) {=0D
-		cmdq->wrapped =3D !cmdq->wrapped;=0D
-		next_prod_idx -=3D wq->q_depth;=0D
-	}=0D
-=0D
-	cmdq_set_lcmd_wqe(&wqe, SYNC_CMD_DIRECT_RESP, buf_in, NULL, wrapped,=0D
-			  mod, cmd, curr_prod_idx);=0D
-=0D
+	cmd_type =3D (nic_cmd_type =3D=3D HINIC3_CMD_TYPE_DIRECT_RESP) ?=0D
+				SYNC_CMD_DIRECT_RESP : SYNC_CMD_SGE_RESP;=0D
+	if (cmdq->cmdqs->cmdq_mode =3D=3D HINIC3_NORMAL_CMDQ)=0D
+		cmdq_set_lcmd_wqe(&wqe, cmd_type, buf_in, buf_out, wrapped, mod, cmd, cu=
rr_pi);=0D
+	else=0D
+		hinic3_enhance_cmdq_set_wqe(&wqe, cmd_type, buf_in, buf_out, wrapped, mo=
d, cmd);=0D
 =0D
+	/* The data written to HW should be in Big Endian Format */=0D
 	hinic3_cpu_to_hw(&wqe, wqe_size);=0D
 =0D
-	/* Cmdq wqe is not shadow, therefore wqe will be written to wq. */=0D
-	cmdq_wqe_fill(curr_wqe, &wqe);=0D
-=0D
-	cmdq->cmd_infos[curr_prod_idx].cmd_type =3D HINIC3_CMD_TYPE_DIRECT_RESP;=
=0D
-=0D
-	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);=0D
-=0D
-	timeo =3D timeout ? timeout : CMDQ_CMD_TIMEOUT;=0D
-	err =3D hinic3_cmdq_poll_msg(cmdq, timeo);=0D
-	if (err) {=0D
-		PMD_DRV_LOG(ERR, "Cmdq poll msg ack failed, prod idx: 0x%x",=0D
-			    curr_prod_idx);=0D
-		err =3D -ETIMEDOUT;=0D
-		goto cmdq_unlock;=0D
-	}=0D
-=0D
-	rte_smp_rmb(); /*Ensure all cmdq return messages are completed*/=0D
-=0D
-	if (out_param) {=0D
-		wqe_lcmd =3D &curr_wqe->wqe_lcmd;=0D
-		*out_param =3D rte_cpu_to_be_64(wqe_lcmd->completion.direct_resp);=0D
-	}=0D
-=0D
-	if (cmdq->errcode[curr_prod_idx])=0D
-		err =3D cmdq->errcode[curr_prod_idx];=0D
-=0D
-cmdq_unlock:=0D
-	rte_spinlock_unlock(&cmdq->cmdq_lock);=0D
-=0D
-	return err;=0D
+	cmdq_wqe_fill(curr_wqe, &wqe, wqe_size);=0D
 }=0D
 =0D
-/**=0D
- * Send a synchronous command with detailed response and wait for the=0D
- * completion.=0D
- *=0D
- * @param[in] cmdq=0D
- * The command queue object representing the queue to send the command to.=
=0D
- * @param[in] mod=0D
- * The module type that the command belongs to.=0D
- * @param[in] cmd=0D
- * The command to be executed.=0D
- * @param[in] buf_in=0D
- * The input buffer containing the parameters for the command.=0D
- * @param[out] buf_out=0D
- * The output buffer where the detailed response from the hardware will be=
=0D
- * stored.=0D
- * @param[in] timeout=0D
- * The timeout value (ms) to wait for the command completion. If zero, a d=
efault=0D
- * timeout will be used.=0D
- *=0D
- * @return=0D
- * 0 on success, non-zero on failure.=0D
- * - -EBUSY: The command queue is busy.=0D
- * - -ETIMEDOUT: The command did not complete within the specified timeout=
.=0D
- */=0D
-static int=0D
-cmdq_sync_cmd_detail_resp(struct hinic3_cmdq *cmdq, enum hinic3_mod_type m=
od,=0D
-			  uint8_t cmd, struct hinic3_cmd_buf *buf_in,=0D
-			  struct hinic3_cmd_buf *buf_out, uint32_t timeout)=0D
+#define NUM_WQEBBS_FOR_CMDQ_WQE		1=0D
+#define NUM_WQEBBS_FOR_ENHANCE_CMDQ_WQE	2=0D
+=0D
+static int cmdq_sync_cmd(struct hinic3_cmdq *cmdq, enum hinic3_mod_type mo=
d, uint8_t cmd,=0D
+			 struct hinic3_cmd_buf *buf_in, struct hinic3_cmd_buf *buf_out,=0D
+			 uint64_t *out_param, uint32_t timeout,=0D
+			 enum hinic3_cmdq_cmd_type nic_cmd_type)=0D
 {=0D
-	struct hinic3_cmdq_wqe wqe;=0D
 	struct hinic3_wq *wq =3D cmdq->wq;=0D
 	struct hinic3_cmdq_wqe *curr_wqe =3D NULL;=0D
 	uint16_t curr_prod_idx, next_prod_idx, num_wqebbs;=0D
-	uint32_t timeo, wqe_size;=0D
-	int wrapped, err;=0D
+	uint32_t time;=0D
+	uint64_t *direct_resp =3D NULL;=0D
+	int err;=0D
 =0D
-	wqe_size =3D cmdq_wqe_size(WQE_LCMD_TYPE);=0D
-	num_wqebbs =3D WQE_NUM_WQEBBS(wqe_size, wq);=0D
+	num_wqebbs =3D (cmdq->cmdqs->cmdq_mode =3D=3D HINIC3_NORMAL_CMDQ) ?=0D
+				NUM_WQEBBS_FOR_CMDQ_WQE : NUM_WQEBBS_FOR_ENHANCE_CMDQ_WQE;=0D
 =0D
-	/* ensure thread safety and maintain wrapped and doorbell index correct. =
*/=0D
+	/* Keep wrapped and doorbell index correct */=0D
 	rte_spinlock_lock(&cmdq->cmdq_lock);=0D
 =0D
 	curr_wqe =3D hinic3_get_wqe(cmdq->wq, num_wqebbs, &curr_prod_idx);=0D
-	if (curr_wqe =3D=3D NULL) {=0D
+	if (!curr_wqe) {=0D
 		err =3D -EBUSY;=0D
 		goto cmdq_unlock;=0D
 	}=0D
 =0D
-	memset(&wqe, 0, sizeof(wqe));=0D
-	wrapped =3D cmdq->wrapped;=0D
+	cmdq_sync_wqe_prepare(cmdq, mod, cmd, buf_in, buf_out,=0D
+			      curr_wqe, curr_prod_idx, nic_cmd_type);=0D
+=0D
+	cmdq->cmd_infos[curr_prod_idx].cmd_type =3D nic_cmd_type;=0D
 =0D
 	next_prod_idx =3D curr_prod_idx + num_wqebbs;=0D
 	if (next_prod_idx >=3D wq->q_depth) {=0D
 		cmdq->wrapped =3D !cmdq->wrapped;=0D
 		next_prod_idx -=3D wq->q_depth;=0D
 	}=0D
-=0D
-	cmdq_set_lcmd_wqe(&wqe, SYNC_CMD_SGE_RESP, buf_in, buf_out, wrapped,=0D
-			  mod, cmd, curr_prod_idx);=0D
-=0D
-	hinic3_cpu_to_hw(&wqe, wqe_size);=0D
-=0D
-	/* Cmdq wqe is not shadow, therefore wqe will be written to wq. */=0D
-	cmdq_wqe_fill(curr_wqe, &wqe);=0D
-=0D
-	cmdq->cmd_infos[curr_prod_idx].cmd_type =3D HINIC3_CMD_TYPE_SGE_RESP;=0D
-=0D
-	cmdq_set_db(cmdq, cmdq->cmdq_type, next_prod_idx);=0D
-=0D
-	timeo =3D timeout ? timeout : CMDQ_CMD_TIMEOUT;=0D
-	err =3D hinic3_cmdq_poll_msg(cmdq, timeo);=0D
+	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);=0D
+	time =3D msecs_to_cycles(timeout ? timeout : CMDQ_CMD_TIMEOUT);=0D
+	err =3D hinic3_cmdq_poll_msg(cmdq, time);=0D
 	if (err) {=0D
-		PMD_DRV_LOG(ERR, "Cmdq poll msg ack failed, prod idx: 0x%x",=0D
-			    curr_prod_idx);=0D
+		PMD_DRV_LOG(ERR, "Cmdq poll msg ack failed, prod idx: 0x%x", curr_prod_i=
dx);=0D
 		err =3D -ETIMEDOUT;=0D
 		goto cmdq_unlock;=0D
 	}=0D
 =0D
-	rte_smp_rmb(); /*Ensure all cmdq return messages are completed*/=0D
+	rte_atomic_thread_fence(rte_memory_order_acquire); /* Read error code aft=
er completion */=0D
+=0D
+	if (out_param) {=0D
+		if (cmdq->cmdqs->cmdq_mode =3D=3D HINIC3_NORMAL_CMDQ)=0D
+			direct_resp =3D=0D
+				(uint64_t *)(&curr_wqe->wqe_lcmd.completion.direct_resp);=0D
+		else=0D
+			direct_resp =3D (uint64_t *)=0D
+				(&curr_wqe->enhanced_cmdq_wqe.completion.sge_resp_lo_addr);=0D
+=0D
+		*out_param =3D rte_cpu_to_be_64(*direct_resp);=0D
+	}=0D
 =0D
 	if (cmdq->errcode[curr_prod_idx])=0D
 		err =3D cmdq->errcode[curr_prod_idx];=0D
@@ -588,7 +464,8 @@ wait_cmdqs_enable(struct hinic3_cmdqs *cmdqs)=0D
 =0D
 int=0D
 hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, enum hinic3_mod_type m=
od, uint8_t cmd,=0D
-			struct hinic3_cmd_buf *buf_in, uint64_t *out_param, uint32_t timeout)=0D
+			struct hinic3_cmd_buf *buf_in,=0D
+			uint64_t *out_param, uint32_t timeout)=0D
 {=0D
 	struct hinic3_cmdqs *cmdqs =3D hwdev->cmdqs;=0D
 	int err;=0D
@@ -605,8 +482,8 @@ hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, enu=
m hinic3_mod_type mod, ui=0D
 		return err;=0D
 	}=0D
 =0D
-	return cmdq_sync_cmd_direct_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod,=0D
-					 cmd, buf_in, out_param, timeout);=0D
+	return cmdq_sync_cmd(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod, cmd, buf_in,=0D
+			     NULL, out_param, timeout, HINIC3_CMD_TYPE_DIRECT_RESP);=0D
 }=0D
 =0D
 int=0D
@@ -628,8 +505,8 @@ hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, enu=
m hinic3_mod_type mod, ui=0D
 		return err;=0D
 	}=0D
 =0D
-	return cmdq_sync_cmd_detail_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod,=0D
-					 cmd, buf_in, buf_out, timeout);=0D
+	return cmdq_sync_cmd(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod, cmd, buf_in, bu=
f_out,=0D
+			     NULL, timeout, HINIC3_CMD_TYPE_SGE_RESP);=0D
 }=0D
 =0D
 static void=0D
@@ -643,21 +520,23 @@ clear_wqe_complete_bit(struct hinic3_cmdq *cmdq, stru=
ct hinic3_cmdq_wqe *wqe)=0D
 {=0D
 	struct hinic3_ctrl *ctrl =3D NULL;=0D
 	uint32_t header_info =3D hinic3_hw_cpu32(WQE_HEADER(wqe)->header_info);=0D
-	int buf_len =3D CMDQ_WQE_HEADER_GET(header_info, BUFDESC_LEN);=0D
-	uint32_t wqe_size =3D cmdq_get_wqe_size(buf_len);=0D
 	uint16_t num_wqebbs;=0D
-=0D
-	if (wqe_size =3D=3D WQE_LCMD_SIZE)=0D
-		ctrl =3D &wqe->wqe_lcmd.ctrl;=0D
-	else=0D
-		ctrl =3D &wqe->inline_wqe.wqe_scmd.ctrl;=0D
-=0D
-	/* Clear HW busy bit. */=0D
-	ctrl->ctrl_info =3D 0;=0D
+	enum data_format df;=0D
+	if (cmdq->cmdqs->cmdq_mode =3D=3D HINIC3_NORMAL_CMDQ) {=0D
+		df =3D CMDQ_WQE_HEADER_GET(header_info, DATA_FMT);=0D
+		if (df =3D=3D DATA_SGE)=0D
+			ctrl =3D &wqe->wqe_lcmd.ctrl;=0D
+		else=0D
+			ctrl =3D &wqe->inline_wqe.wqe_scmd.ctrl;=0D
+		ctrl->ctrl_info =3D 0; /* clear HW busy bit */=0D
+		num_wqebbs =3D NUM_WQEBBS_FOR_CMDQ_WQE;=0D
+	} else {=0D
+		wqe->enhanced_cmdq_wqe.completion.cs_format =3D 0; /* clear HW busy bit =
*/=0D
+		num_wqebbs =3D NUM_WQEBBS_FOR_ENHANCE_CMDQ_WQE;=0D
+	}=0D
 =0D
 	rte_atomic_thread_fence(rte_memory_order_release); /**< Verify wqe is cle=
ared. */=0D
 =0D
-	num_wqebbs =3D WQE_NUM_WQEBBS(wqe_size, cmdq->wq);=0D
 	hinic3_put_wqe(cmdq->wq, num_wqebbs);=0D
 }=0D
 =0D
@@ -735,25 +614,28 @@ static int=0D
 hinic3_set_cmdq_ctxts(struct hinic3_hwdev *hwdev)=0D
 {=0D
 	struct hinic3_cmdqs *cmdqs =3D hwdev->cmdqs;=0D
-	struct hinic3_cmd_cmdq_ctxt cmdq_ctxt;=0D
-	enum hinic3_cmdq_type cmdq_type;=0D
+	struct hinic3_cmd_cmdq_ctxt cmdq_ctxt =3D {0};=0D
+	enum hinic3_cmdq_type cmdq_type =3D HINIC3_CMDQ_SYNC;=0D
 	uint16_t out_size =3D sizeof(cmdq_ctxt);=0D
+	uint16_t cmd;=0D
 	int err;=0D
 =0D
-	for (cmdq_type =3D HINIC3_CMDQ_SYNC; cmdq_type < HINIC3_MAX_CMDQ_TYPES; c=
mdq_type++) {=0D
-		memset(&cmdq_ctxt, 0, sizeof(cmdq_ctxt));=0D
-		cmdq_ctxt.ctxt_info =3D cmdqs->cmdq[cmdq_type].cmdq_ctxt;=0D
+	for (; cmdq_type < HINIC3_MAX_CMDQ_TYPES; cmdq_type++) {=0D
+		if (hwdev->cmdqs->cmdq_mode =3D=3D HINIC3_NORMAL_CMDQ) {=0D
+			cmdq_ctxt.ctxt_info =3D cmdqs->cmdq[cmdq_type].cmdq_ctxt;=0D
+			cmd =3D HINIC3_MGMT_CMD_SET_CMDQ_CTXT;=0D
+		} else {=0D
+			cmdq_ctxt.enhance_ctxt_info =3D cmdqs->cmdq[cmdq_type].cmdq_enhance_ctx=
t;=0D
+			cmd =3D HINIC3_MGMT_CMD_SET_ENHANCE_CMDQ_CTXT;=0D
+		}=0D
 		cmdq_ctxt.func_idx =3D hinic3_global_func_id(hwdev);=0D
 		cmdq_ctxt.cmdq_id =3D cmdq_type;=0D
 =0D
-		err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,=0D
-					      HINIC3_MGMT_CMD_SET_CMDQ_CTXT,=0D
+		err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM, cmd,=0D
 					      &cmdq_ctxt, sizeof(cmdq_ctxt),=0D
 					      &cmdq_ctxt, &out_size);=0D
-=0D
 		if (err || !out_size || cmdq_ctxt.status) {=0D
-			PMD_DRV_LOG(ERR,=0D
-				    "Set cmdq ctxt failed, err: %d, status: 0x%x, out_size: 0x%x",=0D
+			PMD_DRV_LOG(ERR, "Set cmdq ctxt failed, err: %d, status: 0x%x, out_size=
: 0x%x",=0D
 				    err, cmdq_ctxt.status, out_size);=0D
 			return -EFAULT;=0D
 		}=0D
@@ -794,6 +676,7 @@ hinic3_set_cmdqs(struct hinic3_hwdev *hwdev, struct hin=
ic3_cmdqs *cmdqs)=0D
 	cmdqs->cmdqs_db_base =3D (uint8_t *)db_base;=0D
 =0D
 	for (cmdq_type =3D HINIC3_CMDQ_SYNC; cmdq_type < HINIC3_MAX_CMDQ_TYPES; c=
mdq_type++) {=0D
+		cmdqs->cmdq[cmdq_type].cmdqs =3D cmdqs;=0D
 		err =3D init_cmdq(&cmdqs->cmdq[cmdq_type], hwdev,=0D
 				&cmdqs->saved_wqs[cmdq_type], cmdq_type);=0D
 		if (err) {=0D
@@ -801,8 +684,11 @@ hinic3_set_cmdqs(struct hinic3_hwdev *hwdev, struct hi=
nic3_cmdqs *cmdqs)=0D
 			goto init_cmdq_err;=0D
 		}=0D
 =0D
-		cmdq_init_queue_ctxt(&cmdqs->cmdq[cmdq_type],=0D
-				     &cmdqs->cmdq[cmdq_type].cmdq_ctxt);=0D
+		if (cmdqs->cmdq_mode =3D=3D HINIC3_NORMAL_CMDQ)=0D
+			cmdq_init_queue_ctxt(&cmdqs->cmdq[cmdq_type],=0D
+					     &cmdqs->cmdq[cmdq_type].cmdq_ctxt);=0D
+		else=0D
+			hinic3_enhance_cmdq_init_queue_ctxt(&cmdqs->cmdq[cmdq_type]);=0D
 	}=0D
 =0D
 	err =3D hinic3_set_cmdq_ctxts(hwdev);=0D
@@ -821,11 +707,12 @@ hinic3_set_cmdqs(struct hinic3_hwdev *hwdev, struct h=
inic3_cmdqs *cmdqs)=0D
 }=0D
 =0D
 int=0D
-hinic3_init_cmdqs(struct hinic3_hwdev *hwdev)=0D
+hinic3_cmdq_init(struct hinic3_hwdev *hwdev)=0D
 {=0D
 	struct hinic3_cmdqs *cmdqs =3D NULL;=0D
 	size_t saved_wqs_size;=0D
 	char cmdq_pool_name[RTE_MEMPOOL_NAMESIZE];=0D
+	uint32_t wqebb_shift;=0D
 	int err;=0D
 =0D
 	cmdqs =3D rte_zmalloc(NULL, sizeof(*cmdqs), 0);=0D
@@ -835,6 +722,14 @@ hinic3_init_cmdqs(struct hinic3_hwdev *hwdev)=0D
 	hwdev->cmdqs =3D cmdqs;=0D
 	cmdqs->hwdev =3D hwdev;=0D
 =0D
+	if (HINIC3_SUPPORT_ONLY_ENHANCE_CMDQ(hwdev))=0D
+		cmdqs->cmdq_mode =3D HINIC3_ENHANCE_CMDQ;=0D
+	else=0D
+		cmdqs->cmdq_mode =3D HINIC3_NORMAL_CMDQ;=0D
+=0D
+	wqebb_shift =3D (cmdqs->cmdq_mode =3D=3D HINIC3_ENHANCE_CMDQ) ?=0D
+			CMDQ_ENHANCE_WQEBB_SHIFT : CMDQ_WQEBB_SHIFT;=0D
+=0D
 	saved_wqs_size =3D HINIC3_MAX_CMDQ_TYPES * sizeof(struct hinic3_wq);=0D
 	cmdqs->saved_wqs =3D rte_zmalloc(NULL, saved_wqs_size, 0);=0D
 	if (!cmdqs->saved_wqs) {=0D
@@ -844,8 +739,7 @@ hinic3_init_cmdqs(struct hinic3_hwdev *hwdev)=0D
 	}=0D
 =0D
 	memset(cmdq_pool_name, 0, RTE_MEMPOOL_NAMESIZE);=0D
-	snprintf(cmdq_pool_name, sizeof(cmdq_pool_name), "hinic3_cmdq_%u",=0D
-		       hwdev->port_id);=0D
+	snprintf(cmdq_pool_name, sizeof(cmdq_pool_name), "hinic3_cmdq_%u", hwdev-=
>port_id);=0D
 =0D
 	cmdqs->cmd_buf_pool =3D rte_pktmbuf_pool_create(cmdq_pool_name,=0D
 		HINIC3_CMDQ_DEPTH * HINIC3_MAX_CMDQ_TYPES, 0, 0,=0D
@@ -857,8 +751,7 @@ hinic3_init_cmdqs(struct hinic3_hwdev *hwdev)=0D
 	}=0D
 =0D
 	err =3D hinic3_cmdq_alloc(cmdqs->saved_wqs, hwdev, HINIC3_MAX_CMDQ_TYPES,=
=0D
-				HINIC3_CMDQ_WQ_BUF_SIZE, CMDQ_WQEBB_SHIFT,=0D
-				HINIC3_CMDQ_DEPTH);=0D
+				HINIC3_CMDQ_WQ_BUF_SIZE, wqebb_shift, HINIC3_CMDQ_DEPTH);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Allocate cmdq failed");=0D
 		goto cmdq_alloc_err;=0D
@@ -884,7 +777,7 @@ hinic3_init_cmdqs(struct hinic3_hwdev *hwdev)=0D
 }=0D
 =0D
 void=0D
-hinic3_free_cmdqs(struct hinic3_hwdev *hwdev)=0D
+hinic3_cmdqs_free(struct hinic3_hwdev *hwdev)=0D
 {=0D
 	struct hinic3_cmdqs *cmdqs =3D hwdev->cmdqs;=0D
 	enum hinic3_cmdq_type cmdq_type =3D HINIC3_CMDQ_SYNC;=0D
@@ -900,14 +793,36 @@ hinic3_free_cmdqs(struct hinic3_hwdev *hwdev)=0D
 	rte_free(cmdqs);=0D
 }=0D
 =0D
+static int=0D
+hinic3_check_cmdq_done(struct hinic3_cmdq *cmdq, struct hinic3_cmdq_wqe *w=
qe)=0D
+{=0D
+	struct hinic3_ctrl *ctrl =3D NULL;=0D
+	uint32_t ctrl_info;=0D
+=0D
+	if (cmdq->cmdqs->cmdq_mode =3D=3D HINIC3_NORMAL_CMDQ) {=0D
+		/* Only arm bit using scmd wqe, the wqe is lcmd. */=0D
+		ctrl =3D &wqe->wqe_lcmd.ctrl;=0D
+		ctrl_info =3D hinic3_hw_cpu32((ctrl)->ctrl_info);=0D
+=0D
+		if (!WQE_COMPLETED(ctrl_info))=0D
+			return -EBUSY;=0D
+	} else {=0D
+		ctrl_info =3D wqe->enhanced_cmdq_wqe.completion.cs_format;=0D
+		ctrl_info =3D hinic3_hw_cpu32(ctrl_info);=0D
+=0D
+		if (!ENHANCE_CMDQ_WQE_CS_GET(ctrl_info, HW_BUSY))=0D
+			return -EBUSY;=0D
+	}=0D
+	return 0;=0D
+}=0D
+=0D
 static int=0D
 hinic3_cmdq_poll_msg(struct hinic3_cmdq *cmdq, uint32_t timeout)=0D
 {=0D
 	struct hinic3_cmdq_wqe *wqe =3D NULL;=0D
 	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd =3D NULL;=0D
-	struct hinic3_ctrl *ctrl =3D NULL;=0D
 	struct hinic3_cmdq_cmd_info *cmd_info =3D NULL;=0D
-	uint32_t status_info, ctrl_info;=0D
+	uint32_t status_info;=0D
 	uint16_t ci;=0D
 	int errcode;=0D
 	uint64_t end;=0D
@@ -928,13 +843,10 @@ hinic3_cmdq_poll_msg(struct hinic3_cmdq *cmdq, uint32=
_t timeout)=0D
 		return -EINVAL;=0D
 	}=0D
 =0D
-	/* Only arm bit is using scmd wqe, the wqe is lcmd. */=0D
-	wqe_lcmd =3D &wqe->wqe_lcmd;=0D
-	ctrl =3D &wqe_lcmd->ctrl;=0D
+	/* Only arm bit using scmd wqe, the wqe is lcmd. */=0D
 	end =3D cycles + msecs_to_cycles(timeout);=0D
 	do {=0D
-		ctrl_info =3D hinic3_hw_cpu32((ctrl)->ctrl_info);=0D
-		if (WQE_COMPLETED(ctrl_info)) {=0D
+		if (hinic3_check_cmdq_done(cmdq, wqe) =3D=3D 0) {=0D
 			done =3D 1;=0D
 			break;=0D
 		}=0D
@@ -943,8 +855,14 @@ hinic3_cmdq_poll_msg(struct hinic3_cmdq *cmdq, uint32_=
t timeout)=0D
 	} while (time_before(cycles, end));=0D
 =0D
 	if (done) {=0D
-		status_info =3D hinic3_hw_cpu32(wqe_lcmd->status.status_info);=0D
-		errcode =3D WQE_ERRCODE_GET(status_info, VAL);=0D
+		if (cmdq->cmdqs->cmdq_mode =3D=3D HINIC3_NORMAL_CMDQ) {=0D
+			wqe_lcmd =3D &wqe->wqe_lcmd;=0D
+			status_info =3D hinic3_hw_cpu32(wqe_lcmd->status.status_info);=0D
+			errcode =3D WQE_ERRCODE_GET(status_info, VAL);=0D
+		} else {=0D
+			status_info =3D hinic3_hw_cpu32(wqe->enhanced_cmdq_wqe.completion.cs_fo=
rmat);=0D
+			errcode =3D ENHANCE_CMDQ_WQE_CS_GET(status_info, ERR_CODE);=0D
+		}=0D
 		cmdq_update_errcode(cmdq, ci, errcode);=0D
 		clear_wqe_complete_bit(cmdq, wqe);=0D
 		err =3D 0;=0D
diff --git a/drivers/net/hinic3/base/hinic3_cmdq.h b/drivers/net/hinic3/bas=
e/hinic3_cmdq.h=0D
index deac909488..b31b61029e 100644=0D
--- a/drivers/net/hinic3/base/hinic3_cmdq.h=0D
+++ b/drivers/net/hinic3/base/hinic3_cmdq.h=0D
@@ -13,25 +13,55 @@=0D
 /* Pmd driver uses 64, kernel l2nic uses 4096. */=0D
 #define HINIC3_CMDQ_DEPTH 64=0D
 =0D
-#define HINIC3_CMDQ_BUF_SIZE 2048U=0D
+#define HINIC3_CMDQ_BUF_SIZE 1024U=0D
 =0D
 #define HINIC3_CEQ_ID_CMDQ 0=0D
 =0D
-enum cmdq_scmd_type { CMDQ_SET_ARM_CMD =3D 2 };=0D
+#define WQ_BLOCK_PFN_SHIFT		9=0D
+#define WQ_BLOCK_PFN(page_addr)		((page_addr) >> WQ_BLOCK_PFN_SHIFT)=0D
 =0D
-enum cmdq_wqe_type { WQE_LCMD_TYPE =3D 0, WQE_SCMD_TYPE =3D 1 };=0D
+enum hinic3_cmdq_mode {=0D
+	HINIC3_NORMAL_CMDQ,=0D
+	HINIC3_ENHANCE_CMDQ=0D
+};=0D
+=0D
+enum cmdq_scmd_type {=0D
+	CMDQ_SET_ARM_CMD =3D 2=0D
+};=0D
+=0D
+enum cmdq_wqe_type {=0D
+	WQE_LCMD_TYPE,=0D
+	WQE_SCMD_TYPE=0D
+};=0D
 =0D
-enum ctrl_sect_len { CTRL_SECT_LEN =3D 1, CTRL_DIRECT_SECT_LEN =3D 2 };=0D
+enum ctrl_sect_len {=0D
+	CTRL_SECT_LEN =3D 1,=0D
+	CTRL_DIRECT_SECT_LEN =3D 2=0D
+};=0D
 =0D
-enum bufdesc_len { BUFDESC_LCMD_LEN =3D 2, BUFDESC_SCMD_LEN =3D 3 };=0D
+enum bufdesc_len {=0D
+	BUFDESC_LCMD_LEN =3D 2,=0D
+	BUFDESC_SCMD_LEN =3D 3=0D
+};=0D
 =0D
-enum data_format { DATA_SGE =3D 0};=0D
+enum data_format {=0D
+	DATA_SGE=0D
+};=0D
 =0D
-enum completion_format { COMPLETE_DIRECT =3D 0, COMPLETE_SGE =3D 1 };=0D
+enum completion_format {=0D
+	COMPLETE_DIRECT,=0D
+	COMPLETE_SGE=0D
+};=0D
 =0D
-enum completion_request { CEQ_SET =3D 1 };=0D
+enum completion_request {=0D
+	CEQ_SET =3D 1=0D
+};=0D
 =0D
-enum cmdq_cmd_type { SYNC_CMD_DIRECT_RESP, SYNC_CMD_SGE_RESP, ASYNC_CMD };=
=0D
+enum cmdq_cmd_type {=0D
+	SYNC_CMD_DIRECT_RESP,=0D
+	SYNC_CMD_SGE_RESP,=0D
+	ASYNC_CMD=0D
+};=0D
 =0D
 enum hinic3_cmdq_type {=0D
 	HINIC3_CMDQ_SYNC,=0D
@@ -44,17 +74,63 @@ enum hinic3_db_src_type {=0D
 	HINIC3_DB_SRC_L2NIC_SQ_TYPE=0D
 };=0D
 =0D
-enum hinic3_cmdq_db_type { HINIC3_DB_SQ_RQ_TYPE, HINIC3_DB_CMDQ_TYPE };=0D
+enum hinic3_cmdq_db_type {=0D
+	HINIC3_DB_SQ_RQ_TYPE,=0D
+	HINIC3_DB_CMDQ_TYPE=0D
+};=0D
 =0D
 /* Cmdq ack type. */=0D
 enum hinic3_ack_type {=0D
 	HINIC3_ACK_TYPE_CMDQ		=3D 0,=0D
 	HINIC3_ACK_TYPE_SHARE_CQN	=3D 1,=0D
 	HINIC3_ACK_TYPE_APP_CQN		=3D 2,=0D
-=0D
 	HINIC3_MOD_ACK_MAX		=3D 15=0D
 };=0D
 =0D
+struct cmdq_enhance_completion {=0D
+	uint32_t cs_format;=0D
+	uint32_t sge_resp_hi_addr;=0D
+	uint32_t sge_resp_lo_addr;=0D
+	uint32_t sge_resp_len; /* bit 14~31 rsvd, soft can't use. */=0D
+};=0D
+=0D
+struct cmdq_enhance_response {=0D
+	uint32_t cs_format;=0D
+	uint32_t resvd;=0D
+	uint64_t direct_data;=0D
+};=0D
+=0D
+struct sge_send_info {=0D
+	uint32_t sge_hi_addr;=0D
+	uint32_t sge_li_addr;=0D
+	uint32_t seg_len;=0D
+	uint32_t rsvd;=0D
+};=0D
+=0D
+struct ctrl_section {=0D
+	uint32_t header;=0D
+	uint32_t rsv;=0D
+	uint32_t sge_send_hi_addr;=0D
+	uint32_t sge_send_lo_addr;=0D
+};=0D
+=0D
+struct enhanced_cmdq_wqe {=0D
+	struct ctrl_section     ctrl_sec; /* 16B */=0D
+	struct cmdq_enhance_completion  completion; /* 16B */=0D
+};=0D
+=0D
+/* Enhance cmdq context of hardware */=0D
+struct enhance_cmdq_ctxt_info {=0D
+	uint64_t eq_cfg;=0D
+	uint64_t dfx_pi_ci;=0D
+=0D
+	uint64_t pft_thd;=0D
+	uint64_t pft_ci;=0D
+=0D
+	uint64_t rsv;=0D
+	uint64_t ci_cla_addr;=0D
+};=0D
+=0D
 /* Cmdq wqe ctrls. */=0D
 struct hinic3_cmdq_header {=0D
 	uint32_t header_info;=0D
@@ -126,6 +202,7 @@ struct hinic3_cmdq_wqe {=0D
 	union {=0D
 		struct hinic3_cmdq_inline_wqe inline_wqe;=0D
 		struct hinic3_cmdq_wqe_lcmd wqe_lcmd;=0D
+		struct enhanced_cmdq_wqe enhanced_cmdq_wqe;=0D
 	};=0D
 };=0D
 =0D
@@ -142,8 +219,10 @@ struct hinic3_cmd_cmdq_ctxt {=0D
 	uint16_t func_idx;=0D
 	uint8_t cmdq_id;=0D
 	uint8_t rsvd1[5];=0D
-=0D
-	struct hinic3_cmdq_ctxt_info ctxt_info;=0D
+	union {=0D
+		struct hinic3_cmdq_ctxt_info ctxt_info;=0D
+		struct enhance_cmdq_ctxt_info enhance_ctxt_info;=0D
+	};=0D
 };=0D
 =0D
 enum hinic3_cmdq_status {=0D
@@ -173,8 +252,10 @@ struct hinic3_cmdq {=0D
 	rte_spinlock_t cmdq_lock;=0D
 =0D
 	struct hinic3_cmdq_ctxt_info cmdq_ctxt;=0D
+	struct enhance_cmdq_ctxt_info cmdq_enhance_ctxt;=0D
 =0D
 	struct hinic3_cmdq_cmd_info *cmd_infos;=0D
+	struct hinic3_cmdqs *cmdqs;=0D
 };=0D
 =0D
 struct hinic3_cmdqs {=0D
@@ -188,6 +269,7 @@ struct hinic3_cmdqs {=0D
 	struct hinic3_cmdq cmdq[HINIC3_MAX_CMDQ_TYPES];=0D
 =0D
 	uint32_t status;=0D
+	uint8_t cmdq_mode;=0D
 };=0D
 =0D
 struct hinic3_cmd_buf {=0D
@@ -215,8 +297,8 @@ int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev,=
 enum hinic3_mod_type mod=0D
 int hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, enum hinic3_mod_ty=
pe mod, uint8_t cmd,=0D
 		 struct hinic3_cmd_buf *buf_in, struct hinic3_cmd_buf *buf_out, uint32_t=
 timeout);=0D
 =0D
-int hinic3_init_cmdqs(struct hinic3_hwdev *hwdev);=0D
+int hinic3_cmdq_init(struct hinic3_hwdev *hwdev);=0D
 =0D
-void hinic3_free_cmdqs(struct hinic3_hwdev *hwdev);=0D
+void hinic3_cmdqs_free(struct hinic3_hwdev *hwdev);=0D
 =0D
 #endif /* _HINIC3_CMDQ_H_ */=0D
diff --git a/drivers/net/hinic3/base/hinic3_cmdq_enhance.c b/drivers/net/hi=
nic3/base/hinic3_cmdq_enhance.c=0D
new file mode 100644=0D
index 0000000000..e09597c9f3=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_cmdq_enhance.c=0D
@@ -0,0 +1,111 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2019 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_mbuf.h>=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_wq.h"=0D
+#include "hinic3_cmd.h"=0D
+#include "hinic3_mgmt.h"=0D
+#include "hinic3_cmdq.h"=0D
+#include "hinic3_cmdq_enhance.h"=0D
+=0D
+#define WQ_PREFETCH_MAX			4=0D
+#define WQ_PREFETCH_MIN			1=0D
+#define WQ_PREFETCH_THRESHOLD	256=0D
+=0D
+void=0D
+hinic3_enhance_cmdq_init_queue_ctxt(struct hinic3_cmdq *cmdq)=0D
+{=0D
+	struct enhance_cmdq_ctxt_info *ctxt_info =3D &cmdq->cmdq_enhance_ctxt;=0D
+	struct hinic3_wq *wq =3D cmdq->wq;=0D
+	uint64_t cmdq_first_block_paddr, pfn;=0D
+	uint16_t start_ci =3D (uint16_t)wq->cons_idx;=0D
+	uint32_t start_pi =3D (uint16_t)wq->prod_idx;=0D
+=0D
+	/* The data in HW is Big Endian Format */=0D
+	cmdq_first_block_paddr =3D wq->queue_buf_paddr;=0D
+	pfn =3D CMDQ_PFN(cmdq_first_block_paddr, RTE_PGSIZE_4K);=0D
+=0D
+	/* First part 16B */=0D
+	ctxt_info->eq_cfg =3D=0D
+		ENHANCED_CMDQ_SET(pfn, CTXT0_CI_WQE_ADDR) |=0D
+		ENHANCED_CMDQ_SET(0, CTXT0_EQ) |=0D
+		ENHANCED_CMDQ_SET(0, CTXT0_CEQ_ARM) |=0D
+		ENHANCED_CMDQ_SET(0, CTXT0_CEQ_EN) |=0D
+		ENHANCED_CMDQ_SET(1, CTXT0_HW_BUSY_BIT);=0D
+=0D
+	ctxt_info->dfx_pi_ci =3D=0D
+		ENHANCED_CMDQ_SET(0, CTXT1_Q_DIS) |=0D
+		ENHANCED_CMDQ_SET(0, CTXT1_ERR_CODE) |=0D
+		ENHANCED_CMDQ_SET(start_pi, CTXT1_PI) |=0D
+		ENHANCED_CMDQ_SET(start_ci, CTXT1_CI);=0D
+=0D
+	/* Second part 16B */=0D
+	ctxt_info->pft_thd =3D=0D
+		ENHANCED_CMDQ_SET(CI_HIGN_IDX(start_ci), CTXT2_PFT_CI) |=0D
+		ENHANCED_CMDQ_SET(1, CTXT2_O_BIT) |=0D
+		ENHANCED_CMDQ_SET(WQ_PREFETCH_MIN, CTXT2_PFT_MIN) |=0D
+		ENHANCED_CMDQ_SET(WQ_PREFETCH_MAX, CTXT2_PFT_MAX) |=0D
+		ENHANCED_CMDQ_SET(WQ_PREFETCH_THRESHOLD, CTXT2_PFT_THD);=0D
+	ctxt_info->pft_ci =3D=0D
+		ENHANCED_CMDQ_SET(pfn, CTXT3_PFT_CI_ADDR) |=0D
+		ENHANCED_CMDQ_SET(start_ci, CTXT3_PFT_CI);=0D
+=0D
+	/* Third part 16B */=0D
+	pfn =3D WQ_BLOCK_PFN(cmdq_first_block_paddr);=0D
+=0D
+	ctxt_info->ci_cla_addr =3D ENHANCED_CMDQ_SET(pfn, CTXT4_CI_CLA_ADDR);=0D
+}=0D
+=0D
+static void=0D
+enhance_cmdq_set_completion(struct cmdq_enhance_completion *completion,=0D
+			    const struct hinic3_cmd_buf *buf_out)=0D
+{=0D
+	completion->sge_resp_hi_addr =3D upper_32_bits(buf_out->dma_addr);=0D
+	completion->sge_resp_lo_addr =3D lower_32_bits(buf_out->dma_addr);=0D
+	completion->sge_resp_len =3D HINIC3_CMDQ_BUF_SIZE;=0D
+}=0D
+=0D
+void hinic3_enhance_cmdq_set_wqe(struct hinic3_cmdq_wqe *wqe,=0D
+				 enum cmdq_cmd_type cmd_type,=0D
+				 struct hinic3_cmd_buf *buf_in,=0D
+				 struct hinic3_cmd_buf *buf_out,=0D
+				 int wrapped, uint8_t mod, uint8_t cmd)=0D
+{=0D
+	struct enhanced_cmdq_wqe *enhanced_wqe =3D &wqe->enhanced_cmdq_wqe;=0D
+=0D
+	enhanced_wqe->ctrl_sec.header =3D=0D
+		ENHANCE_CMDQ_WQE_HEADER_SET(buf_in->size, SEND_SGE_LEN) |=0D
+		ENHANCE_CMDQ_WQE_HEADER_SET(1, BDSL) |=0D
+		ENHANCE_CMDQ_WQE_HEADER_SET(DATA_SGE, DF) |=0D
+		ENHANCE_CMDQ_WQE_HEADER_SET(NORMAL_WQE_TYPE, DN) |=0D
+		ENHANCE_CMDQ_WQE_HEADER_SET(COMPACT_WQE_TYPE, EC) |=0D
+		ENHANCE_CMDQ_WQE_HEADER_SET((uint32_t)wrapped, HW_BUSY_BIT);=0D
+=0D
+	enhanced_wqe->ctrl_sec.sge_send_hi_addr =3D upper_32_bits(buf_in->dma_add=
r);=0D
+	enhanced_wqe->ctrl_sec.sge_send_lo_addr =3D lower_32_bits(buf_in->dma_add=
r);=0D
+=0D
+	enhanced_wqe->completion.cs_format =3D=0D
+		ENHANCE_CMDQ_WQE_CS_SET(cmd, CMD) |=0D
+		ENHANCE_CMDQ_WQE_CS_SET(HINIC3_ACK_TYPE_CMDQ, ACK_TYPE) |=0D
+		ENHANCE_CMDQ_WQE_CS_SET(mod, MOD);=0D
+=0D
+	switch (cmd_type) {=0D
+	case SYNC_CMD_DIRECT_RESP:=0D
+		enhanced_wqe->completion.cs_format |=3D ENHANCE_CMDQ_WQE_CS_SET(INLINE_D=
ATA, CF);=0D
+		break;=0D
+	case SYNC_CMD_SGE_RESP:=0D
+		if (buf_out) {=0D
+			enhanced_wqe->completion.cs_format |=3D=0D
+				ENHANCE_CMDQ_WQE_CS_SET(SGE_RESPONSE, CF);=0D
+			enhance_cmdq_set_completion(&enhanced_wqe->completion, buf_out);=0D
+		}=0D
+		break;=0D
+	case ASYNC_CMD:=0D
+		break;=0D
+	}=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_cmdq_enhance.h b/drivers/net/hi=
nic3/base/hinic3_cmdq_enhance.h=0D
new file mode 100644=0D
index 0000000000..8de0ae4d71=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_cmdq_enhance.h=0D
@@ -0,0 +1,125 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_CMDQ_ENHANCE_H_=0D
+#define _HINIC3_CMDQ_ENHANCE_H_=0D
+=0D
+#include "hinic3_mgmt.h"=0D
+=0D
+#define NORMAL_WQE_TYPE  0=0D
+#define COMPACT_WQE_TYPE 1=0D
+=0D
+/* First part 16B */=0D
+#define ENHANCED_CMDQ_CTXT0_CI_WQE_ADDR_SHIFT   0=0D
+#define ENHANCED_CMDQ_CTXT0_RSV1_SHIFT          52=0D
+#define ENHANCED_CMDQ_CTXT0_EQ_SHIFT            53=0D
+#define ENHANCED_CMDQ_CTXT0_CEQ_ARM_SHIFT       61=0D
+#define ENHANCED_CMDQ_CTXT0_CEQ_EN_SHIFT        62=0D
+#define ENHANCED_CMDQ_CTXT0_HW_BUSY_BIT_SHIFT   63=0D
+=0D
+#define ENHANCED_CMDQ_CTXT0_CI_WQE_ADDR_MASK    0xFFFFFFFFFFFFFU=0D
+#define ENHANCED_CMDQ_CTXT0_RSV1_MASK           0x1U=0D
+#define ENHANCED_CMDQ_CTXT0_EQ_MASK             0xFFU=0D
+#define ENHANCED_CMDQ_CTXT0_CEQ_ARM_MASK        0x1U=0D
+#define ENHANCED_CMDQ_CTXT0_CEQ_EN_MASK         0x1U=0D
+#define ENHANCED_CMDQ_CTXT0_HW_BUSY_BIT_MASK    0x1U=0D
+=0D
+#define ENHANCED_CMDQ_CTXT1_Q_DIS_SHIFT         0=0D
+#define ENHANCED_CMDQ_CTXT1_ERR_CODE_SHIFT      1=0D
+#define ENHANCED_CMDQ_CTXT1_RSV1_SHIFT          3=0D
+#define ENHANCED_CMDQ_CTXT1_PI_SHIFT            32=0D
+#define ENHANCED_CMDQ_CTXT1_CI_SHIFT            48=0D
+=0D
+#define ENHANCED_CMDQ_CTXT1_Q_DIS_MASK          0x1U=0D
+#define ENHANCED_CMDQ_CTXT1_ERR_CODE_MASK       0x3U=0D
+#define ENHANCED_CMDQ_CTXT1_RSV1_MASK           0x1FFFFFFFU=0D
+#define ENHANCED_CMDQ_CTXT1_PI_MASK             0xFFFFU=0D
+#define ENHANCED_CMDQ_CTXT1_CI_MASK             0xFFFFU=0D
+=0D
+/* Second part 16B */=0D
+#define ENHANCED_CMDQ_CTXT2_PFT_CI_SHIFT        0=0D
+#define ENHANCED_CMDQ_CTXT2_O_BIT_SHIFT         4=0D
+#define ENHANCED_CMDQ_CTXT2_PFT_THD_SHIFT       32=0D
+#define ENHANCED_CMDQ_CTXT2_PFT_MAX_SHIFT       46=0D
+#define ENHANCED_CMDQ_CTXT2_PFT_MIN_SHIFT       57=0D
+=0D
+#define ENHANCED_CMDQ_CTXT2_PFT_CI_MASK         0xFU=0D
+#define ENHANCED_CMDQ_CTXT2_O_BIT_MASK          0x1U=0D
+#define ENHANCED_CMDQ_CTXT2_PFT_THD_MASK        0x3FFFFU=0D
+#define ENHANCED_CMDQ_CTXT2_PFT_MAX_MASK        0x7FFFU=0D
+#define ENHANCED_CMDQ_CTXT2_PFT_MIN_MASK        0x7FU=0D
+=0D
+#define ENHANCED_CMDQ_CTXT3_PFT_CI_ADDR_SHIFT	0=0D
+#define ENHANCED_CMDQ_CTXT3_PFT_CI_SHIFT	52=0D
+=0D
+#define ENHANCED_CMDQ_CTXT3_PFT_CI_ADDR_MASK	0xFFFFFFFFFFFFFU=0D
+#define ENHANCED_CMDQ_CTXT3_PFT_CI_MASK		0xFFFFU=0D
+=0D
+/* Third part 16B */=0D
+#define ENHANCED_CMDQ_CTXT4_CI_CLA_ADDR_SHIFT	0=0D
+#define ENHANCED_CMDQ_CTXT4_CI_CLA_ADDR_MASK	0x7FFFFFFFFFFFFFU=0D
+=0D
+#define ENHANCED_CMDQ_SET(val, member)      \=0D
+			(((uint64_t)(val) & ENHANCED_CMDQ_##member##_MASK) << \=0D
+			 ENHANCED_CMDQ_##member##_SHIFT)=0D
+=0D
+#define CI_IDX_HIGH_SHIFH       12=0D
+#define CI_HIGN_IDX(val)        ((val) >> CI_IDX_HIGH_SHIFH)=0D
+=0D
+#define ENHANCE_CMDQ_WQE_HEADER_SEND_SGE_LEN_SHIFT  0=0D
+#define ENHANCE_CMDQ_WQE_HEADER_BDSL_SHIFT          19=0D
+#define ENHANCE_CMDQ_WQE_HEADER_DF_SHIFT            28=0D
+#define ENHANCE_CMDQ_WQE_HEADER_DN_SHIFT            29=0D
+#define ENHANCE_CMDQ_WQE_HEADER_EC_SHIFT            30=0D
+#define ENHANCE_CMDQ_WQE_HEADER_HW_BUSY_BIT_SHIFT   31=0D
+=0D
+#define ENHANCE_CMDQ_WQE_HEADER_SEND_SGE_LEN_MASK   0x3FFFFU=0D
+#define ENHANCE_CMDQ_WQE_HEADER_BDSL_MASK           0xFFU=0D
+#define ENHANCE_CMDQ_WQE_HEADER_DF_MASK             0x1U=0D
+#define ENHANCE_CMDQ_WQE_HEADER_DN_MASK             0x1U=0D
+#define ENHANCE_CMDQ_WQE_HEADER_EC_MASK             0x1U=0D
+#define ENHANCE_CMDQ_WQE_HEADER_HW_BUSY_BIT_MASK    0x1U=0D
+=0D
+#define ENHANCE_CMDQ_WQE_HEADER_SET(val, member)        \=0D
+			((((uint32_t)(val)) & ENHANCE_CMDQ_WQE_HEADER_##member##_MASK) << \=0D
+			 ENHANCE_CMDQ_WQE_HEADER_##member##_SHIFT)=0D
+=0D
+#define ENHANCE_CMDQ_WQE_HEADER_GET(val, member)        \=0D
+			(((val) >> ENHANCE_CMDQ_WQE_HEADER_##member##_SHIFT) & \=0D
+			 ENHANCE_CMDQ_WQE_HEADER_##member##_MASK)=0D
+=0D
+#define ENHANCE_CMDQ_WQE_CS_ERR_CODE_SHIFT          0=0D
+#define ENHANCE_CMDQ_WQE_CS_CMD_SHIFT               4=0D
+#define ENHANCE_CMDQ_WQE_CS_ACK_TYPE_SHIFT          12=0D
+#define ENHANCE_CMDQ_WQE_CS_HW_BUSY_SHIFT           14=0D
+#define ENHANCE_CMDQ_WQE_CS_MOD_SHIFT               16=0D
+#define ENHANCE_CMDQ_WQE_CS_CF_SHIFT                31=0D
+=0D
+#define ENHANCE_CMDQ_WQE_CS_ERR_CODE_MASK           0xFU=0D
+#define ENHANCE_CMDQ_WQE_CS_CMD_MASK                0xFFU=0D
+#define ENHANCE_CMDQ_WQE_CS_ACK_TYPE_MASK           0x3U=0D
+#define ENHANCE_CMDQ_WQE_CS_HW_BUSY_MASK            0x1U=0D
+#define ENHANCE_CMDQ_WQE_CS_MOD_MASK                0x1FU=0D
+#define ENHANCE_CMDQ_WQE_CS_CF_MASK                 0x1U=0D
+=0D
+#define ENHANCE_CMDQ_WQE_CS_SET(val, member)        \=0D
+			((((uint32_t)(val)) & ENHANCE_CMDQ_WQE_CS_##member##_MASK) << \=0D
+			 ENHANCE_CMDQ_WQE_CS_##member##_SHIFT)=0D
+=0D
+#define ENHANCE_CMDQ_WQE_CS_GET(val, member)        \=0D
+			(((val) >> ENHANCE_CMDQ_WQE_CS_##member##_SHIFT) & \=0D
+			 ENHANCE_CMDQ_WQE_CS_##member##_MASK)=0D
+=0D
+enum complete_format {=0D
+	INLINE_DATA,=0D
+	SGE_RESPONSE=0D
+};=0D
+=0D
+void hinic3_enhance_cmdq_set_wqe(struct hinic3_cmdq_wqe *wqe, enum cmdq_cm=
d_type cmd_type,=0D
+			  struct hinic3_cmd_buf *buf_in, struct hinic3_cmd_buf *buf_out,=0D
+			  int wrapped, uint8_t mod, uint8_t cmd);=0D
+=0D
+void hinic3_enhance_cmdq_init_queue_ctxt(struct hinic3_cmdq *cmdq);=0D
+=0D
+#endif /*_HINIC3_CMDQ_ENHANCE_H_ */=0D
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.c b/drivers/net/hinic3/=
base/hinic3_hw_comm.c=0D
index d259b88a2d..6541bc0428 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hw_comm.c=0D
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.c=0D
@@ -12,7 +12,7 @@=0D
 #include "hinic3_wq.h"=0D
 #include "hinic3_nic_cfg.h"=0D
 =0D
-/* Buffer sizes in hinic3_convert_rx_buf_size must be in ascending order. =
*/=0D
+/* Buffer sizes must be in ascending order. */=0D
 const uint32_t hinic3_hw_rx_buf_size[] =3D {=0D
 	HINIC3_RX_BUF_SIZE_32B,=0D
 	HINIC3_RX_BUF_SIZE_64B,=0D
@@ -239,11 +239,14 @@ hinic3_convert_rx_buf_size(uint32_t rx_buf_sz, uint32=
_t *match_sz)=0D
 }=0D
 =0D
 static uint16_t=0D
-get_hw_rx_buf_size(uint32_t rx_buf_sz)=0D
+get_hw_rx_buf_size(struct hinic3_hwdev *hwdev, uint32_t rx_buf_sz)=0D
 {=0D
 	uint16_t num_hw_types =3D RTE_DIM(hinic3_hw_rx_buf_size);=0D
 	uint16_t i;=0D
 =0D
+	if (HINIC3_IS_USE_REAL_RX_BUF_SIZE(hwdev))=0D
+		return rx_buf_sz;=0D
+=0D
 	for (i =3D 0; i < num_hw_types; i++) {=0D
 		if (hinic3_hw_rx_buf_size[i] =3D=3D rx_buf_sz)=0D
 			return i;=0D
@@ -271,8 +274,12 @@ hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, uint3=
2_t rq_depth,=0D
 	root_ctxt.cmdq_depth =3D 0;=0D
 	root_ctxt.lro_en =3D 1;=0D
 	root_ctxt.rq_depth =3D (uint16_t)rte_log2_u32(rq_depth);=0D
-	root_ctxt.rx_buf_sz =3D get_hw_rx_buf_size(rx_buf_sz);=0D
+	root_ctxt.rx_buf_sz =3D get_hw_rx_buf_size(hwdev, rx_buf_sz);=0D
 	root_ctxt.sq_depth =3D (uint16_t)rte_log2_u32(sq_depth);=0D
+	root_ctxt.cmdq_mode =3D hwdev->cmdqs->cmdq_mode;=0D
+=0D
+	if (hwdev->cmdqs->cmdq_mode =3D=3D HINIC3_ENHANCE_CMDQ)=0D
+		root_ctxt.cmdq_depth--;=0D
 =0D
 	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,=0D
 				      HINIC3_MGMT_CMD_SET_VAT,=0D
@@ -403,7 +410,7 @@ hinic3_comm_features_nego(struct hinic3_hwdev *hwdev,=0D
 	uint16_t out_size =3D sizeof(feature_nego);=0D
 	int err;=0D
 =0D
-	if (!hwdev || !s_feature || size > COMM_MAX_FEATURE_QWORD)=0D
+	if (!hwdev || !s_feature || size > HINIC3_MAX_FEATURE_QWORD)=0D
 		return -EINVAL;=0D
 =0D
 	memset(&feature_nego, 0, sizeof(feature_nego));=0D
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.h b/drivers/net/hinic3/=
base/hinic3_hw_comm.h=0D
index b86f5aad8f..42ff04ee9d 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hw_comm.h=0D
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.h=0D
@@ -9,17 +9,17 @@=0D
 #define HINIC3_MGMT_CMD_OP_GET 0=0D
 #define HINIC3_MGMT_CMD_OP_SET 1=0D
 =0D
-#define HINIC3_MSIX_CNT_LLI_TIMER_SHIFT	    0=0D
-#define HINIC3_MSIX_CNT_LLI_CREDIT_SHIFT    8=0D
-#define HINIC3_MSIX_CNT_COALESCE_TIMER_SHIFT 8=0D
-#define HINIC3_MSIX_CNT_PENDING_SHIFT	    8=0D
-#define HINIC3_MSIX_CNT_RESEND_TIMER_SHIFT  29=0D
-=0D
-#define HINIC3_MSIX_CNT_LLI_TIMER_MASK	   0xFFU=0D
-#define HINIC3_MSIX_CNT_LLI_CREDIT_MASK	   0xFFU=0D
-#define HINIC3_MSIX_CNT_COALESCE_TIMER_MASK 0xFFU=0D
-#define HINIC3_MSIX_CNT_PENDING_MASK	   0x1FU=0D
-#define HINIC3_MSIX_CNT_RESEND_TIMER_MASK  0x7U=0D
+#define HINIC3_MSIX_CNT_LLI_TIMER_SHIFT			0=0D
+#define HINIC3_MSIX_CNT_LLI_CREDIT_SHIFT		8=0D
+#define HINIC3_MSIX_CNT_COALESCE_TIMER_SHIFT		8=0D
+#define HINIC3_MSIX_CNT_PENDING_SHIFT			8=0D
+#define HINIC3_MSIX_CNT_RESEND_TIMER_SHIFT		29=0D
+=0D
+#define HINIC3_MSIX_CNT_LLI_TIMER_MASK			0xFFU=0D
+#define HINIC3_MSIX_CNT_LLI_CREDIT_MASK			0xFFU=0D
+#define HINIC3_MSIX_CNT_COALESCE_TIMER_MASK		0xFFU=0D
+#define HINIC3_MSIX_CNT_PENDING_MASK			0x1FU=0D
+#define HINIC3_MSIX_CNT_RESEND_TIMER_MASK		0x7U=0D
 =0D
 #define HINIC3_MSIX_CNT_SET(val, member)           \=0D
 	(((val) & HINIC3_MSIX_CNT_##member##_MASK) \=0D
@@ -129,7 +129,7 @@ struct hinic3_cmd_root_ctxt {=0D
 	uint8_t cmdq_depth;=0D
 	uint16_t rx_buf_sz;=0D
 	uint8_t lro_en;=0D
-	uint8_t rsvd1;=0D
+	uint8_t cmdq_mode;=0D
 	uint16_t sq_depth;=0D
 	uint16_t rq_depth;=0D
 	uint64_t rsvd2;=0D
@@ -143,17 +143,16 @@ enum hinic3_fw_ver_type {=0D
 	HINIC3_FW_VER_TYPE_CFG,=0D
 };=0D
 =0D
-#define MGMT_MSG_CMD_OP_SET 1=0D
-#define MGMT_MSG_CMD_OP_GET 0=0D
+#define MGMT_MSG_CMD_OP_SET	1=0D
+#define MGMT_MSG_CMD_OP_GET	0=0D
 =0D
-#define COMM_MAX_FEATURE_QWORD 4=0D
 struct comm_cmd_feature_nego {=0D
 	struct mgmt_msg_head head;=0D
 =0D
 	uint16_t func_id;=0D
 	uint8_t opcode; /**< 1: set, 0: get. */=0D
 	uint8_t rsvd;=0D
-	uint64_t s_feature[COMM_MAX_FEATURE_QWORD];=0D
+	uint64_t s_feature[HINIC3_MAX_FEATURE_QWORD];=0D
 };=0D
 =0D
 #define HINIC3_FW_VERSION_LEN	    16=0D
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/ba=
se/hinic3_hwdev.c=0D
index 668bbf4a0e..5d12cf7b5f 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hwdev.c=0D
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c=0D
@@ -261,7 +261,7 @@ hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)=0D
 {=0D
 	int err;=0D
 =0D
-	err =3D hinic3_init_cmdqs(hwdev);=0D
+	err =3D hinic3_cmdq_init(hwdev);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Init cmd queues failed");=0D
 		return err;=0D
@@ -276,7 +276,7 @@ hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)=0D
 	return 0;=0D
 =0D
 set_cmdq_depth_err:=0D
-	hinic3_free_cmdqs(hwdev);=0D
+	hinic3_cmdqs_free(hwdev);=0D
 =0D
 	return err;=0D
 }=0D
@@ -284,7 +284,7 @@ hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)=0D
 static void=0D
 hinic3_comm_cmdqs_free(struct hinic3_hwdev *hwdev)=0D
 {=0D
-	hinic3_free_cmdqs(hwdev);=0D
+	hinic3_cmdqs_free(hwdev);=0D
 }=0D
 =0D
 static void=0D
@@ -426,6 +426,12 @@ hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)=0D
 		goto func_reset_err;=0D
 	}=0D
 =0D
+	err =3D hinic3_get_comm_features(hwdev, hwdev->features, HINIC3_MAX_FEATU=
RE_QWORD);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Get comm features failed");=0D
+		goto get_common_features_err;=0D
+	}=0D
+=0D
 	err =3D hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 1);=0D
 	if (err)=0D
 		goto set_used_state_err;=0D
@@ -444,6 +450,7 @@ hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)=0D
 	hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 0);=0D
 set_used_state_err:=0D
 func_reset_err:=0D
+get_common_features_err:=0D
 get_func_info_err:=0D
 	free_mgmt_channel(hwdev);=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.h b/drivers/net/hinic3/ba=
se/hinic3_hwdev.h=0D
index 161f1e2de5..c6661aa1a6 100644=0D
--- a/drivers/net/hinic3/base/hinic3_hwdev.h=0D
+++ b/drivers/net/hinic3/base/hinic3_hwdev.h=0D
@@ -23,6 +23,18 @@ enum hinic3_set_arm_type {=0D
 	HINIC3_SET_ARM_TYPE_NUM=0D
 };=0D
 =0D
+enum {=0D
+	HINIC3_F_API_CHAIN =3D 1U << 0,=0D
+	HINIC3_F_CLP =3D 1U << 1,=0D
+	HINIC3_F_CHANNEL_DETECT =3D 1U << 2,=0D
+	HINIC3_F_MBOX_SEGMENT =3D 1U << 3,=0D
+	HINIC3_F_CMDQ_NUM =3D 1U << 4,=0D
+	HINIC3_F_VIRTIO_VQ_SIZE =3D 1U << 5,=0D
+	HINIC3_F_EXTEND_CAP =3D 1U << 6,=0D
+	HINIC3_F_SMF_CACHE_INVALID =3D 1U << 7,=0D
+	HINIC3_F_ONLY_ENHANCE_CMDQ =3D 1U << 8,=0D
+	HINIC3_F_USE_REAL_RX_BUF_SIZE =3D 1U << 9,=0D
+};=0D
 struct hinic3_page_addr {=0D
 	void *virt_addr;=0D
 	uint64_t phys_addr;=0D
@@ -78,6 +90,11 @@ struct hinic3_hw_stats {=0D
 #define HINIC3_CHIP_FAULT_SIZE (110 * 1024)=0D
 #define MAX_DRV_BUF_SIZE       4096=0D
 =0D
+#define HINIC3_SUPPORT_ONLY_ENHANCE_CMDQ(hwdev) \=0D
+	(((struct hinic3_hwdev *)hwdev)->features[0] & HINIC3_F_ONLY_ENHANCE_CMDQ=
)=0D
+#define HINIC3_IS_USE_REAL_RX_BUF_SIZE(hwdev) \=0D
+	(((struct hinic3_hwdev *)hwdev)->features[0] & HINIC3_F_USE_REAL_RX_BUF_S=
IZE)=0D
+=0D
 struct nic_cmd_chip_fault_stats {=0D
 	uint32_t offset;=0D
 	uint8_t chip_fault_stats[MAX_DRV_BUF_SIZE];=0D
@@ -141,6 +158,7 @@ struct hinic3_hwdev {=0D
 =0D
 	uint16_t max_vfs;=0D
 	uint16_t link_status;=0D
+	uint64_t features[HINIC3_MAX_FEATURE_QWORD];=0D
 };=0D
 =0D
 bool hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev);=0D
diff --git a/drivers/net/hinic3/base/hinic3_mgmt.c b/drivers/net/hinic3/bas=
e/hinic3_mgmt.c=0D
index 5db6d49922..b1f850dfff 100644=0D
--- a/drivers/net/hinic3/base/hinic3_mgmt.c=0D
+++ b/drivers/net/hinic3/base/hinic3_mgmt.c=0D
@@ -13,6 +13,8 @@=0D
 #define SEGMENT_LEN	     48=0D
 #define MGMT_MSG_MAX_SEQ_ID \=0D
 	(RTE_ALIGN(HINIC3_MSG_TO_MGMT_MAX_LEN, SEGMENT_LEN) / SEGMENT_LEN)=0D
+#define MGMT_MSG_LAST_SEG_MAX_LEN \=0D
+	(MAX_PF_MGMT_BUF_SIZE - SEGMENT_LEN * MGMT_MSG_MAX_SEQ_ID)=0D
 =0D
 #define BUF_OUT_DEFAULT_SIZE 1=0D
 =0D
@@ -34,7 +36,8 @@ static bool=0D
 check_mgmt_seq_id_and_seg_len(struct hinic3_recv_msg *recv_msg, uint8_t se=
q_id,=0D
 			      uint8_t seg_len, uint16_t msg_id)=0D
 {=0D
-	if (seq_id > MGMT_MSG_MAX_SEQ_ID || seg_len > SEGMENT_LEN)=0D
+	if (seq_id > MGMT_MSG_MAX_SEQ_ID || seg_len > SEGMENT_LEN ||=0D
+		(seq_id =3D=3D MGMT_MSG_MAX_SEQ_ID && seg_len > MGMT_MSG_LAST_SEG_MAX_LE=
N))=0D
 		return false;=0D
 =0D
 	if (seq_id =3D=3D 0) {=0D
diff --git a/drivers/net/hinic3/base/hinic3_mgmt.h b/drivers/net/hinic3/bas=
e/hinic3_mgmt.h=0D
index f8148406d3..4e77b9bec4 100644=0D
--- a/drivers/net/hinic3/base/hinic3_mgmt.h=0D
+++ b/drivers/net/hinic3/base/hinic3_mgmt.h=0D
@@ -70,6 +70,8 @@ typedef enum {=0D
 #define HINIC3_TOE_RES	 (1 << RES_TYPE_TOE)=0D
 #define HINIC3_IPSEC_RES (1 << RES_TYPE_IPSEC)=0D
 =0D
+#define HINIC3_MAX_FEATURE_QWORD 4=0D
+=0D
 struct hinic3_recv_msg {=0D
 	void *msg;=0D
 =0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index c35fefdeac..ac44da46c2 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -48,6 +48,46 @@ static const struct vf_msg_handler vf_mag_cmd_handler[] =
=3D {=0D
 	},=0D
 };=0D
 =0D
+int=0D
+hinic3_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, enum hinic3_mod_type m=
od,=0D
+			uint16_t cmd, void *buf_in, uint16_t in_size,=0D
+			void *buf_out, uint16_t *out_size)=0D
+{=0D
+	uint32_t i;=0D
+	bool cmd_to_pf =3D false;=0D
+	struct hinic3_handler_info handler_info =3D {=0D
+		.cmd =3D cmd,=0D
+		.buf_in =3D buf_in,=0D
+		.in_size =3D in_size,=0D
+		.buf_out =3D buf_out,=0D
+		.out_size =3D out_size,=0D
+		.dst_func =3D HINIC3_MGMT_SRC_ID,=0D
+		.direction =3D HINIC3_MSG_DIRECT_SEND,=0D
+		.ack_type =3D HINIC3_MSG_ACK,=0D
+	};=0D
+=0D
+	if (hwdev =3D=3D NULL)=0D
+		return -EINVAL;=0D
+=0D
+	if (hinic3_func_type(hwdev) =3D=3D TYPE_VF) {=0D
+		if (mod =3D=3D HINIC3_MOD_HILINK) {=0D
+			for (i =3D 0; i < RTE_DIM(vf_mag_cmd_handler); i++) {=0D
+				if (cmd =3D=3D vf_mag_cmd_handler[i].cmd)=0D
+					cmd_to_pf =3D true;=0D
+			}=0D
+		} else if (mod =3D=3D HINIC3_MOD_L2NIC) {=0D
+			for (i =3D 0; i < RTE_DIM(vf_cmd_handler); i++) {=0D
+				if (cmd =3D=3D vf_cmd_handler[i].cmd)=0D
+					cmd_to_pf =3D true;=0D
+			}=0D
+		}=0D
+	}=0D
+	if (cmd_to_pf)=0D
+		handler_info.dst_func =3D hinic3_pf_id_of_vf(hwdev);=0D
+=0D
+	return hinic3_send_mbox_to_mgmt(hwdev, mod, &handler_info, 0);=0D
+}=0D
+=0D
 /**=0D
  * Set CI table for a SQ.=0D
  *=0D
@@ -1712,43 +1752,6 @@ hinic3_set_rq_flush(struct hinic3_hwdev *hwdev, uint=
16_t q_id)=0D
 	return err;=0D
 }=0D
 =0D
-int=0D
-hinic3_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, enum hinic3_mod_type m=
od,=0D
-			uint16_t cmd, void *buf_in, uint16_t in_size,=0D
-			void *buf_out, uint16_t *out_size)=0D
-{=0D
-	uint32_t i;=0D
-	bool cmd_to_pf =3D false;=0D
-	struct hinic3_handler_info handler_info =3D {=0D
-		.cmd =3D cmd,=0D
-		.buf_in =3D buf_in,=0D
-		.in_size =3D in_size,=0D
-		.buf_out =3D buf_out,=0D
-		.out_size =3D out_size,=0D
-		.dst_func =3D HINIC3_MGMT_SRC_ID,=0D
-		.direction =3D HINIC3_MSG_DIRECT_SEND,=0D
-		.ack_type =3D HINIC3_MSG_ACK,=0D
-	};=0D
-=0D
-	if (hinic3_func_type(hwdev) =3D=3D TYPE_VF) {=0D
-		if (mod =3D=3D HINIC3_MOD_HILINK) {=0D
-			for (i =3D 0; i < RTE_DIM(vf_mag_cmd_handler); i++) {=0D
-				if (cmd =3D=3D vf_mag_cmd_handler[i].cmd)=0D
-					cmd_to_pf =3D true;=0D
-			}=0D
-		} else if (mod =3D=3D HINIC3_MOD_L2NIC) {=0D
-			for (i =3D 0; i < RTE_DIM(vf_cmd_handler); i++) {=0D
-				if (cmd =3D=3D vf_cmd_handler[i].cmd)=0D
-					cmd_to_pf =3D true;=0D
-			}=0D
-		}=0D
-	}=0D
-	if (cmd_to_pf)=0D
-		handler_info.dst_func =3D hinic3_pf_id_of_vf(hwdev);=0D
-=0D
-	return hinic3_send_mbox_to_mgmt(hwdev, mod, &handler_info, 0);=0D
-}=0D
-=0D
 int=0D
 hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,=0D
 			      enum hinic3_link_follow_status status)=0D
diff --git a/drivers/net/hinic3/base/meson.build b/drivers/net/hinic3/base/=
meson.build=0D
index 48ac7a47f5..729980d087 100644=0D
--- a/drivers/net/hinic3/base/meson.build=0D
+++ b/drivers/net/hinic3/base/meson.build=0D
@@ -2,6 +2,7 @@=0D
 # Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
 =0D
 base_sources =3D files(=0D
+        'hinic3_cmdq_enhance.c',=0D
         'hinic3_cmdq.c',=0D
         'hinic3_eqs.c',=0D
         'hinic3_hw_cfg.c',=0D
-- =0D
2.45.1.windows.1=0D
=0D

