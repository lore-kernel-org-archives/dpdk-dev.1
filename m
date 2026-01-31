Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448C0D79769
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 10:06:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E562402F1;
	Sat, 31 Jan 2026 11:06:48 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTP id 3BB0A402B2
 for <dev@dpdk.org>; Sat, 31 Jan 2026 11:06:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=vS2oOx8QLSIFt8s4BwzNTQiJ0Oz+Jnid8lKkv5Ub2m4=;
 b=UsYm/PqdCoYiqriARTGo0Rnj/n/Rw8Pv3gAM28GCMDvPovOVVPC3RfdXteHJWO
 bTW6KeeBcFi93YyfYH5yre2TmzJZfnbOs+Jdh0Chv8uTV04TwY8x2JUZcAa27sRz
 riQDJArpcFApXhaiN9WKbu4E5erKPAK1N87l1bXKHvrU0=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAndJof1H1pOVL+BQ--.9138S6;
 Sat, 31 Jan 2026 18:06:42 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [PATCH 2/7] net/hinic3: add enhance cmdq support for new SPx series
 NIC
Date: Sat, 31 Jan 2026 18:05:58 +0800
Message-ID: <20260131100608.12429-3-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260131100608.12429-1-wff_light@vip.163.com>
References: <20260131100608.12429-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAndJof1H1pOVL+BQ--.9138S6
X-Coremail-Antispam: 1Uf129KBjvAXoWDCw4rKF17Gr17tF1DXw18Zrb_yoW7AF4xJo
 WfJr4fKr1Fq340kw1qg3yIkFZxJwn8ZFn8tana9FZFqanrtFyxtay3Jw4fWa48ZrW5AF17
 CFy5JanYqw4kuw1Dn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUrYL9UUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNhL6BWl91DJIHAAA39
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

From: Feifei Wang <wangfeifei40@huawei.com>

Add enhance command queue for new SPx series NIC

New SPx series NIC uses enhance command queue to send messages to
hardware NIC, which is different from previous SPx NIC's common
command queue.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/base/hinic3_cmd.h          | 145 ++++---
 drivers/net/hinic3/base/hinic3_cmdq.c         | 400 +++++++-----------
 drivers/net/hinic3/base/hinic3_cmdq.h         |  65 ++-
 drivers/net/hinic3/base/hinic3_cmdq_enhance.c | 110 +++++
 drivers/net/hinic3/base/hinic3_cmdq_enhance.h | 169 ++++++++
 drivers/net/hinic3/base/hinic3_hw_comm.c      |  15 +-
 drivers/net/hinic3/base/hinic3_hw_comm.h      |  31 +-
 drivers/net/hinic3/base/hinic3_hwdev.c        |  13 +-
 drivers/net/hinic3/base/hinic3_hwdev.h        |  18 +
 drivers/net/hinic3/base/hinic3_mgmt.c         |   5 +-
 drivers/net/hinic3/base/hinic3_mgmt.h         |   2 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  74 ++--
 drivers/net/hinic3/base/meson.build           |   1 +
 13 files changed, 667 insertions(+), 381 deletions(-)
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.c
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq_enhance.h

diff --git a/drivers/net/hinic3/base/hinic3_cmd.h b/drivers/net/hinic3/base/hinic3_cmd.h
index 6042ca51bd..b73faca070 100644
--- a/drivers/net/hinic3/base/hinic3_cmd.h
+++ b/drivers/net/hinic3/base/hinic3_cmd.h
@@ -8,13 +8,13 @@
 #define NIC_RSS_CMD_TEMP_ALLOC			0x01
 #define NIC_RSS_CMD_TEMP_FREE			0x02
 
-#define HINIC3_RSS_TYPE_VALID_SHIFT		23
+#define HINIC3_RSS_TYPE_VALID_SHIFT			23
 #define HINIC3_RSS_TYPE_TCP_IPV6_EXT_SHIFT	24
 #define HINIC3_RSS_TYPE_IPV6_EXT_SHIFT		25
 #define HINIC3_RSS_TYPE_TCP_IPV6_SHIFT		26
-#define HINIC3_RSS_TYPE_IPV6_SHIFT		27
+#define HINIC3_RSS_TYPE_IPV6_SHIFT			27
 #define HINIC3_RSS_TYPE_TCP_IPV4_SHIFT		28
-#define HINIC3_RSS_TYPE_IPV4_SHIFT		29
+#define HINIC3_RSS_TYPE_IPV4_SHIFT			29
 #define HINIC3_RSS_TYPE_UDP_IPV6_SHIFT		30
 #define HINIC3_RSS_TYPE_UDP_IPV4_SHIFT		31
 #define HINIC3_RSS_TYPE_SET(val, member)	\
@@ -23,113 +23,126 @@
 #define HINIC3_RSS_TYPE_GET(val, member)	\
 	(((uint32_t)(val) >> HINIC3_RSS_TYPE_##member##_SHIFT) & 0x1)
 
+#define CMDQ_PFN(addr, page_size) ((addr) >> (rte_log2_u32(page_size)))
+
 /* NIC CMDQ MODE. */
 enum hinic3_ucode_cmd {
-	HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX	= 0,
+	HINIC3_UCODE_CMD_MODIFY_QUEUE_CTX		= 0,
 	HINIC3_UCODE_CMD_CLEAN_QUEUE_CONTEXT	= 1,
 	HINIC3_UCODE_CMD_SET_RSS_INDIR_TABLE	= 4,
 	HINIC3_UCODE_CMD_SET_RSS_CONTEXT_TABLE	= 5,
 	HINIC3_UCODE_CMD_GET_RSS_INDIR_TABLE	= 6,
-	HINIC3_UCODE_CMD_SET_RQ_FLUSH		= 10,
+	HINIC3_UCODE_CMD_SET_RQ_FLUSH			= 10,
 };
 
 /* Commands between NIC to MPU. */
 enum hinic3_nic_cmd {
 	/* Only for PFD and VFD. */
-	HINIC3_NIC_CMD_VF_REGISTER			= 0,
+	HINIC3_NIC_CMD_VF_REGISTER					= 0,
 
 	/* FUNC CFG */
-	HINIC3_NIC_CMD_SET_FUNC_TBL			= 5,
-	HINIC3_NIC_CMD_SET_VPORT_ENABLE			= 6,
-	HINIC3_NIC_CMD_SET_RX_MODE			= 7,
-	HINIC3_NIC_CMD_SQ_CI_ATTR_SET			= 8,
-	HINIC3_NIC_CMD_GET_VPORT_STAT			= 9,
-	HINIC3_NIC_CMD_CLEAN_VPORT_STAT			= 10,
-	HINIC3_NIC_CMD_CLEAR_QP_RESOURCE		= 11,
-	HINIC3_NIC_CMD_CFG_FLEX_QUEUE			= 12,
+	HINIC3_NIC_CMD_SET_FUNC_TBL					= 5,
+	HINIC3_NIC_CMD_SET_VPORT_ENABLE				= 6,
+	HINIC3_NIC_CMD_SET_RX_MODE					= 7,
+	HINIC3_NIC_CMD_SQ_CI_ATTR_SET				= 8,
+	HINIC3_NIC_CMD_GET_VPORT_STAT				= 9,
+	HINIC3_NIC_CMD_CLEAN_VPORT_STAT				= 10,
+	HINIC3_NIC_CMD_CLEAR_QP_RESOURCE			= 11,
+	HINIC3_NIC_CMD_CFG_FLEX_QUEUE				= 12,
 	/* LRO CFG */
-	HINIC3_NIC_CMD_CFG_RX_LRO			= 13,
-	HINIC3_NIC_CMD_CFG_LRO_TIMER			= 14,
-	HINIC3_NIC_CMD_FEATURE_NEGO			= 15,
+	HINIC3_NIC_CMD_CFG_RX_LRO					= 13,
+	HINIC3_NIC_CMD_CFG_LRO_TIMER				= 14,
+	HINIC3_NIC_CMD_FEATURE_NEGO					= 15,
+	HINIC3_NIC_CMD_CFG_LOCAL_LRO_STATE			= 16,
+
+	HINIC3_NIC_CMD_CACHE_OUT_QP_RES				= 17,
+	HINIC3_NIC_CMD_SET_RQ_CI_CTX				= 18,
+	HINIC3_NIC_CMD_SET_RQ_ENABLE				= 19,
+
 	/* MAC & VLAN CFG */
-	HINIC3_NIC_CMD_GET_MAC				= 20,
-	HINIC3_NIC_CMD_SET_MAC				= 21,
-	HINIC3_NIC_CMD_DEL_MAC				= 22,
-	HINIC3_NIC_CMD_UPDATE_MAC			= 23,
-	HINIC3_NIC_CMD_CFG_FUNC_VLAN			= 25,
-	HINIC3_NIC_CMD_SET_VLAN_FILTER_EN		= 26,
-	HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD		= 27,
+	HINIC3_NIC_CMD_GET_MAC						= 20,
+	HINIC3_NIC_CMD_SET_MAC						= 21,
+	HINIC3_NIC_CMD_DEL_MAC						= 22,
+	HINIC3_NIC_CMD_UPDATE_MAC					= 23,
+	HINIC3_NIC_CMD_CFG_FUNC_VLAN				= 25,
+	HINIC3_NIC_CMD_SET_VLAN_FILTER_EN			= 26,
+	HINIC3_NIC_CMD_SET_RX_VLAN_OFFLOAD			= 27,
+
+	HINIC3_NIC_CMD_SET_RQ_CI_CTX_HTN			= 34,
+	HINIC3_NIC_CMD_SET_RQ_ENABLE_HTN			= 35,
+
 	/* RSS CFG */
-	HINIC3_NIC_CMD_RSS_CFG				= 60,
-	HINIC3_NIC_CMD_RSS_TEMP_MGR			= 61,
-	HINIC3_NIC_CMD_GET_RSS_CTX_TBL			= 62,
-	HINIC3_NIC_CMD_CFG_RSS_HASH_KEY			= 63,
-	HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE		= 64,
+	HINIC3_NIC_CMD_RSS_CFG						= 60,
+	HINIC3_NIC_CMD_RSS_TEMP_MGR					= 61,
+	HINIC3_NIC_CMD_GET_RSS_CTX_TBL				= 62,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_KEY				= 63,
+	HINIC3_NIC_CMD_CFG_RSS_HASH_ENGINE			= 64,
 	HINIC3_NIC_CMD_SET_RSS_CTX_TBL_INTO_FUNC	= 65,
 	/* FDIR */
-	HINIC3_NIC_CMD_ADD_TC_FLOW			= 80,
-	HINIC3_NIC_CMD_DEL_TC_FLOW			= 81,
-	HINIC3_NIC_CMD_FLUSH_TCAM			= 83,
-	HINIC3_NIC_CMD_CFG_TCAM_BLOCK			= 84,
-	HINIC3_NIC_CMD_ENABLE_TCAM			= 85,
+	HINIC3_NIC_CMD_ADD_TC_FLOW					= 80,
+	HINIC3_NIC_CMD_DEL_TC_FLOW					= 81,
+	HINIC3_NIC_CMD_FLUSH_TCAM					= 83,
+	HINIC3_NIC_CMD_CFG_TCAM_BLOCK				= 84,
+	HINIC3_NIC_CMD_ENABLE_TCAM					= 85,
 
-	HINIC3_NIC_CMD_SET_FDIR_STATUS			= 91,
+	HINIC3_NIC_CMD_SET_FDIR_STATUS				= 91,
 	/* PORT CFG */
-	HINIC3_NIC_CMD_CFG_PAUSE_INFO			= 101,
-	HINIC3_NIC_CMD_VF_COS				= 104,
+	HINIC3_NIC_CMD_CFG_PAUSE_INFO				= 101,
+	HINIC3_NIC_CMD_VF_COS						= 104,
 };
 
 /* COMM commands between driver to MPU. */
 enum hinic3_mgmt_cmd {
-	HINIC3_MGMT_CMD_FUNC_RESET			= 0,
+	HINIC3_MGMT_CMD_FUNC_RESET				= 0,
 	HINIC3_MGMT_CMD_FEATURE_NEGO			= 1,
-	HINIC3_MGMT_CMD_SET_FUNC_SVC_USED_STATE		= 7,
+	HINIC3_MGMT_CMD_SET_FUNC_SVC_USED_STATE	= 7,
 	HINIC3_MGMT_CMD_SET_CMDQ_CTXT			= 20,
-	HINIC3_MGMT_CMD_SET_VAT				= 21,
+	HINIC3_MGMT_CMD_SET_VAT					= 21,
 	HINIC3_MGMT_CMD_CFG_PAGESIZE			= 22,
 	HINIC3_MGMT_CMD_CFG_MSIX_CTRL_REG		= 23,
 	HINIC3_MGMT_CMD_SET_DMA_ATTR			= 25,
+	HINIC3_MGMT_CMD_SET_ENHANCE_CMDQ_CTXT	= 39,
 	HINIC3_MGMT_CMD_GET_MQM_FIX_INFO		= 40,
 	HINIC3_MGMT_CMD_GET_FW_VERSION			= 60,
 	HINIC3_MGMT_CMD_GET_BOARD_INFO			= 61,
 	HINIC3_MGMT_CMD_FAULT_REPORT			= 100,
-	HINIC3_MGMT_CMD_FFM_SET				= 103,
+	HINIC3_MGMT_CMD_FFM_SET					= 103,
 };
 
 enum mag_cmd {
-	SERDES_CMD_PROCESS	  = 0,
+	SERDES_CMD_PROCESS				= 0,
 
-	MAG_CMD_SET_PORT_CFG      = 1,
-	MAG_CMD_SET_PORT_ADAPT    = 2,
-	MAG_CMD_CFG_LOOPBACK_MODE = 3,
+	MAG_CMD_SET_PORT_CFG			= 1,
+	MAG_CMD_SET_PORT_ADAPT			= 2,
+	MAG_CMD_CFG_LOOPBACK_MODE		= 3,
 
-	MAG_CMD_GET_PORT_ENABLE   = 5,
-	MAG_CMD_SET_PORT_ENABLE   = 6,
-	MAG_CMD_GET_LINK_STATUS   = 7,
-	MAG_CMD_SET_LINK_FOLLOW   = 8,
-	MAG_CMD_SET_PMA_ENABLE    = 9,
-	MAG_CMD_CFG_FEC_MODE      = 10,
+	MAG_CMD_GET_PORT_ENABLE			= 5,
+	MAG_CMD_SET_PORT_ENABLE			= 6,
+	MAG_CMD_GET_LINK_STATUS			= 7,
+	MAG_CMD_SET_LINK_FOLLOW			= 8,
+	MAG_CMD_SET_PMA_ENABLE			= 9,
+	MAG_CMD_CFG_FEC_MODE			= 10,
 
 	/* PHY */
-	MAG_CMD_GET_XSFP_INFO     = 60,
-	MAG_CMD_SET_XSFP_ENABLE   = 61,
-	MAG_CMD_GET_XSFP_PRESENT  = 62,
+	MAG_CMD_GET_XSFP_INFO			= 60,
+	MAG_CMD_SET_XSFP_ENABLE			= 61,
+	MAG_CMD_GET_XSFP_PRESENT		= 62,
 	/* sfp/qsfp single byte read/write, for equipment test. */
-	MAG_CMD_SET_XSFP_RW       = 63,
-	MAG_CMD_CFG_XSFP_TEMPERATURE = 64,
+	MAG_CMD_SET_XSFP_RW				= 63,
+	MAG_CMD_CFG_XSFP_TEMPERATURE	= 64,
 
-	MAG_CMD_WIRE_EVENT        = 100,
-	MAG_CMD_LINK_ERR_EVENT    = 101,
+	MAG_CMD_WIRE_EVENT				= 100,
+	MAG_CMD_LINK_ERR_EVENT			= 101,
 
-	MAG_CMD_EVENT_PORT_INFO   = 150,
-	MAG_CMD_GET_PORT_STAT     = 151,
-	MAG_CMD_CLR_PORT_STAT     = 152,
-	MAG_CMD_GET_PORT_INFO     = 153,
-	MAG_CMD_GET_PCS_ERR_CNT   = 154,
-	MAG_CMD_GET_MAG_CNT       = 155,
-	MAG_CMD_DUMP_ANTRAIN_INFO = 156,
+	MAG_CMD_EVENT_PORT_INFO			= 150,
+	MAG_CMD_GET_PORT_STAT			= 151,
+	MAG_CMD_CLR_PORT_STAT			= 152,
+	MAG_CMD_GET_PORT_INFO			= 153,
+	MAG_CMD_GET_PCS_ERR_CNT			= 154,
+	MAG_CMD_GET_MAG_CNT				= 155,
+	MAG_CMD_DUMP_ANTRAIN_INFO		= 156,
 
-	MAG_CMD_MAX = 0xFF
+	MAG_CMD_MAX						= 0xFF
 };
 
 #endif /* _HINIC3_CMD_H_ */
diff --git a/drivers/net/hinic3/base/hinic3_cmdq.c b/drivers/net/hinic3/base/hinic3_cmdq.c
index e2b30ff94e..faf5fd6a54 100644
--- a/drivers/net/hinic3/base/hinic3_cmdq.c
+++ b/drivers/net/hinic3/base/hinic3_cmdq.c
@@ -5,6 +5,7 @@
 #include "hinic3_compat.h"
 #include "hinic3_cmd.h"
 #include "hinic3_cmdq.h"
+#include "hinic3_cmdq_enhance.h"
 #include "hinic3_hwdev.h"
 #include "hinic3_hwif.h"
 #include "hinic3_mgmt.h"
@@ -125,17 +126,17 @@
 
 #define CMDQ_DB_ADDR(db_base, pi) ((db_base) + CMDQ_DB_PI_OFF(pi))
 
-#define CMDQ_PFN(addr, page_size) ((addr) >> (rte_log2_u32(page_size)))
-
 #define FIRST_DATA_TO_WRITE_LAST sizeof(uint64_t)
 
-#define WQE_LCMD_SIZE 64
-#define WQE_SCMD_SIZE 64
+#define WQE_LCMDQ_SIZE 64
+#define WQE_SCMDQ_SIZE 64
+#define WQE_ENHANCE_CMDQ_SIZE 32
 
 #define COMPLETE_LEN 3
 
 #define CMDQ_WQEBB_SIZE	 64
 #define CMDQ_WQEBB_SHIFT 6
+#define CMDQ_ENHANCE_WQEBB_SHIFT 4
 
 #define CMDQ_WQE_SIZE 64
 
@@ -203,43 +204,6 @@ hinic3_free_cmd_buf(struct hinic3_cmd_buf *cmd_buf)
 	rte_free(cmd_buf);
 }
 
-static uint32_t
-cmdq_wqe_size(enum cmdq_wqe_type wqe_type)
-{
-	uint32_t wqe_size = 0;
-
-	switch (wqe_type) {
-	case WQE_LCMD_TYPE:
-		wqe_size = WQE_LCMD_SIZE;
-		break;
-	case WQE_SCMD_TYPE:
-		wqe_size = WQE_SCMD_SIZE;
-		break;
-	}
-
-	return wqe_size;
-}
-
-static uint32_t
-cmdq_get_wqe_size(enum bufdesc_len len)
-{
-	uint32_t wqe_size = 0;
-
-	switch (len) {
-	case BUFDESC_LCMD_LEN:
-		wqe_size = WQE_LCMD_SIZE;
-		break;
-	case BUFDESC_SCMD_LEN:
-		wqe_size = WQE_SCMD_SIZE;
-		break;
-	default:
-		PMD_DRV_LOG(ERR, "Invalid bufdesc_len");
-		break;
-	}
-
-	return wqe_size;
-}
-
 static void
 cmdq_set_completion(struct hinic3_cmdq_completion *complete,
 		    struct hinic3_cmd_buf *buf_out)
@@ -274,11 +238,11 @@ cmdq_set_db(struct hinic3_cmdq *cmdq, enum hinic3_cmdq_type cmdq_type,
 }
 
 static void
-cmdq_wqe_fill(void *dst, void *src)
+cmdq_wqe_fill(void *dst, void *src, int wqe_size)
 {
 	memcpy((void *)((uint8_t *)dst + FIRST_DATA_TO_WRITE_LAST),
 	       (void *)((uint8_t *)src + FIRST_DATA_TO_WRITE_LAST),
-	       CMDQ_WQE_SIZE - FIRST_DATA_TO_WRITE_LAST);
+	       wqe_size - FIRST_DATA_TO_WRITE_LAST);
 
 	/* The first 8 bytes should be written last. */
 	rte_atomic_thread_fence(rte_memory_order_release);
@@ -369,190 +333,100 @@ cmdq_set_lcmd_wqe(struct hinic3_cmdq_wqe *wqe, enum cmdq_cmd_type cmd_type,
 	cmdq_set_lcmd_bufdesc(wqe_lcmd, buf_in);
 }
 
-/**
- * Prepare necessary context for command queue, send a synchronous command with
- * a direct response to hardware. It waits for completion of command by polling
- * command queue for a response.
- *
- * @param[in] cmdq
- * The command queue object that represents the queue to send the command to.
- * @param[in] mod
- * The module type that the command belongs to.
- * @param[in] cmd
- * The command to be executed.
- * @param[in] buf_in
- * The input buffer containing the command parameters.
- * @param[out] out_param
- * A pointer to the location where the response data will be stored, if
- * available.
- * @param[in] timeout
- * The timeout value (ms) to wait for the command completion. If zero, a default
- * timeout will be used.
- *
- * @return
- * 0 on success, non-zero on failure.
- * - -EBUSY: The command queue is busy.
- * - -ETIMEDOUT: The command did not complete within the specified timeout.
- */
-static int
-cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, enum hinic3_mod_type mod,
-			  uint8_t cmd, struct hinic3_cmd_buf *buf_in,
-			  uint64_t *out_param, uint32_t timeout)
+static void cmdq_sync_wqe_prepare(struct hinic3_cmdq *cmdq, u8 mod, u8 cmd,
+								struct hinic3_cmd_buf *buf_in, struct hinic3_cmd_buf *buf_out,
+								struct hinic3_cmdq_wqe *curr_wqe, u16 curr_pi,
+								enum hinic3_cmdq_cmd_type nic_cmd_type)
 {
 	struct hinic3_cmdq_wqe wqe;
-	struct hinic3_wq *wq = cmdq->wq;
-	struct hinic3_cmdq_wqe *curr_wqe = NULL;
-	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd = NULL;
-	uint16_t curr_prod_idx, next_prod_idx, num_wqebbs;
-	uint32_t timeo, wqe_size;
-	int wrapped, err;
-
-	wqe_size = cmdq_wqe_size(WQE_LCMD_TYPE);
-	num_wqebbs = WQE_NUM_WQEBBS(wqe_size, wq);
+	int wrapped, wqe_size;
+	enum cmdq_cmd_type cmd_type;
 
-	/* ensure thread safety and maintain wrapped and doorbell index correct. */
-	rte_spinlock_lock(&cmdq->cmdq_lock);
+	wqe_size = cmdq->cmdqs->cmdq_mode == HINIC3_NORMAL_CMDQ ? WQE_LCMD_SIZE : WQE_ENHANCED_CMDQ_SIZE;
 
-	curr_wqe = hinic3_get_wqe(cmdq->wq, num_wqebbs, &curr_prod_idx);
-	if (curr_wqe == NULL) {
-		err = -EBUSY;
-		goto cmdq_unlock;
-	}
+	memset(&wqe, 0, (u32)wqe_size);
 
-	memset(&wqe, 0, sizeof(wqe));
 	wrapped = cmdq->wrapped;
 
-	next_prod_idx = curr_prod_idx + num_wqebbs;
-	if (next_prod_idx >= wq->q_depth) {
-		cmdq->wrapped = !cmdq->wrapped;
-		next_prod_idx -= wq->q_depth;
-	}
-
-	cmdq_set_lcmd_wqe(&wqe, SYNC_CMD_DIRECT_RESP, buf_in, NULL, wrapped,
-			  mod, cmd, curr_prod_idx);
-
-
-	hinic3_cpu_to_hw(&wqe, wqe_size);
-
-	/* Cmdq wqe is not shadow, therefore wqe will be written to wq. */
-	cmdq_wqe_fill(curr_wqe, &wqe);
-
-	cmdq->cmd_infos[curr_prod_idx].cmd_type = HINIC3_CMD_TYPE_DIRECT_RESP;
-
-	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);
-
-	timeo = timeout ? timeout : CMDQ_CMD_TIMEOUT;
-	err = hinic3_cmdq_poll_msg(cmdq, timeo);
-	if (err) {
-		PMD_DRV_LOG(ERR, "Cmdq poll msg ack failed, prod idx: 0x%x",
-			    curr_prod_idx);
-		err = -ETIMEDOUT;
-		goto cmdq_unlock;
-	}
-
-	rte_smp_rmb(); /*Ensure all cmdq return messages are completed*/
-
-	if (out_param) {
-		wqe_lcmd = &curr_wqe->wqe_lcmd;
-		*out_param = rte_cpu_to_be_64(wqe_lcmd->completion.direct_resp);
-	}
-
-	if (cmdq->errcode[curr_prod_idx])
-		err = cmdq->errcode[curr_prod_idx];
+	cmd_type = (nic_cmd_type == HINIC3_CMD_TYPE_DIRECT_RESP) ?
+				SYNC_CMD_DIRECT_RESP : SYNC_CMD_SGE_RESP;
+	if (cmdq->cmdqs->cmdq_mode == HINIC3_NORMAL_CMDQ)
+		cmdq_set_lcmd_wqe(&wqe, cmd_type, buf_in, buf_out, wrapped, mod, cmd, curr_pi);
+	else
+		enhance_cmdq_set_wqe(&wqe, cmd_type, buf_in, buf_out, wrapped, mod, cmd);
 
-cmdq_unlock:
-	rte_spinlock_unlock(&cmdq->cmdq_lock);
+	/* The data written to HW should be in Big Endian Format */
+	hinic3_hw_be32_len(&wqe, wqe_size);
 
-	return err;
+	cmdq_wqe_fill(curr_wqe, &wqe, wqe_size);
 }
 
-/**
- * Send a synchronous command with detailed response and wait for the
- * completion.
- *
- * @param[in] cmdq
- * The command queue object representing the queue to send the command to.
- * @param[in] mod
- * The module type that the command belongs to.
- * @param[in] cmd
- * The command to be executed.
- * @param[in] buf_in
- * The input buffer containing the parameters for the command.
- * @param[out] buf_out
- * The output buffer where the detailed response from the hardware will be
- * stored.
- * @param[in] timeout
- * The timeout value (ms) to wait for the command completion. If zero, a default
- * timeout will be used.
- *
- * @return
- * 0 on success, non-zero on failure.
- * - -EBUSY: The command queue is busy.
- * - -ETIMEDOUT: The command did not complete within the specified timeout.
- */
-static int
-cmdq_sync_cmd_detail_resp(struct hinic3_cmdq *cmdq, enum hinic3_mod_type mod,
-			  uint8_t cmd, struct hinic3_cmd_buf *buf_in,
-			  struct hinic3_cmd_buf *buf_out, uint32_t timeout)
+#define NUM_WQEBBS_FOR_CMDQ_WQE			1
+#define NUM_WQEBBS_FOR_ENHANCE_CMDQ_WQE	2
+
+static int cmdq_sync_cmd(struct hinic3_cmdq *cmdq, enum hinic3_mod_type mod, u8 cmd,
+					struct hinic3_cmd_buf *buf_in, struct hinic3_cmd_buf *buf_out,
+					u64 *out_param, u32 timeout, enum hinic3_cmdq_cmd_type nic_cmd_type)
 {
-	struct hinic3_cmdq_wqe wqe;
 	struct hinic3_wq *wq = cmdq->wq;
+	struct hinic3_cmdq_wqe wqe;
 	struct hinic3_cmdq_wqe *curr_wqe = NULL;
-	uint16_t curr_prod_idx, next_prod_idx, num_wqebbs;
-	uint32_t timeo, wqe_size;
-	int wrapped, err;
 
-	wqe_size = cmdq_wqe_size(WQE_LCMD_TYPE);
-	num_wqebbs = WQE_NUM_WQEBBS(wqe_size, wq);
+	u16 curr_prod_idx, next_prod_idx, num_wqebbs;
+	u32 time;
+	u64 *direct_resp = NULL;
+	int err;
+
+	num_wqebbs = (cmdq->cmdqs->cmdq_mode == HINIC3_NORMAL_CMDQ) ?
+				NUM_WQEBBS_FOR_CMDQ_WQE : NUM_WQEBBS_FOR_ENHANCE_CMDQ_WQE;
 
-	/* ensure thread safety and maintain wrapped and doorbell index correct. */
+	/* Keep wrapped and doorbell index correct */
 	rte_spinlock_lock(&cmdq->cmdq_lock);
 
 	curr_wqe = hinic3_get_wqe(cmdq->wq, num_wqebbs, &curr_prod_idx);
-	if (curr_wqe == NULL) {
-		err = -EBUSY;
-		goto cmdq_unlock;
-	}
+		if (!curr_wqe) {
+			err = -EBUSY;
+			goto cmdq_unlock;
+		}
 
-	memset(&wqe, 0, sizeof(wqe));
-	wrapped = cmdq->wrapped;
+		memset(&wqe, 0, sizeof(wqe));
 
-	next_prod_idx = curr_prod_idx + num_wqebbs;
-	if (next_prod_idx >= wq->q_depth) {
-		cmdq->wrapped = !cmdq->wrapped;
-		next_prod_idx -= wq->q_depth;
-	}
+		cmdq_sync_wqe_prepare(cmdq, mod, cmd, buf_in, buf_out, curr_wqe, curr_prod_idx, nic_cmd_type);
+		cmdq->cmd_infos[curr_prod_idx].cmd_type = nic_cmd_type;
 
-	cmdq_set_lcmd_wqe(&wqe, SYNC_CMD_SGE_RESP, buf_in, buf_out, wrapped,
-			  mod, cmd, curr_prod_idx);
-
-	hinic3_cpu_to_hw(&wqe, wqe_size);
+		next_prod_idx = curr_prod_idx + num_wqebbs;
+		if (next_prod_idx >= wq->q_depth) {
+			cmdq->wrapped = !cmdq->wrapped;
+			next_prod_idx -= wq->q_depth;
+		}
+		cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);
 
-	/* Cmdq wqe is not shadow, therefore wqe will be written to wq. */
-	cmdq_wqe_fill(curr_wqe, &wqe);
+		time = msecs_to_jiffies(timeout ? timeout : CMDQ_CMD_TIMEOUT);
+		err = hinic3_cmdq_poll_msg(cmdq, time);
+		if (err) {
+			PMD_DRV_LOG(ERR, "Cmdq poll msg ack failed, prod idx: 0x%x", curr_prod_idx);
+			err = -ETIMEDOUT;
+			goto cmdq_unlock;
+		}
 
-	cmdq->cmd_infos[curr_prod_idx].cmd_type = HINIC3_CMD_TYPE_SGE_RESP;
+		rte_smp_rmb(); /* Read error code after completion */
 
-	cmdq_set_db(cmdq, cmdq->cmdq_type, next_prod_idx);
+		if (out_param) {
+			if (cmdq->cmdqs->cmdq_mode == HINIC3_NORMAL_CMDQ)
+				direct_resp = (u64 *)(&curr_wqe->wqe_lcmd.completion.direct_resp);
+			else
+				direct_resp = (u64 *)(&curr_wqe->enhanced_cmdq_wqe.completion.sge_resp_lo_addr);
 
-	timeo = timeout ? timeout : CMDQ_CMD_TIMEOUT;
-	err = hinic3_cmdq_poll_msg(cmdq, timeo);
-	if (err) {
-		PMD_DRV_LOG(ERR, "Cmdq poll msg ack failed, prod idx: 0x%x",
-			    curr_prod_idx);
-		err = -ETIMEDOUT;
-		goto cmdq_unlock;
-	}
-
-	rte_smp_rmb(); /*Ensure all cmdq return messages are completed*/
+			*out_param = cpu_to_be64(*direct_resp);
+		}
 
-	if (cmdq->errcode[curr_prod_idx])
-		err = cmdq->errcode[curr_prod_idx];
+		if (cmdq->errcode[curr_prod_idx])
+			err = cmdq->errcode[curr_prod_idx];
 
 cmdq_unlock:
-	rte_spinlock_unlock(&cmdq->cmdq_lock);
+		rte_spinlock_unlock(&cmdq->cmdq_lock);
 
-	return err;
+		return err;
 }
 
 static int
@@ -586,11 +460,11 @@ wait_cmdqs_enable(struct hinic3_cmdqs *cmdqs)
 	return -EBUSY;
 }
 
-int
-hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod, uint8_t cmd,
-			struct hinic3_cmd_buf *buf_in, uint64_t *out_param, uint32_t timeout)
+int hinic3_cmdq_direct_resp(void *hwdev, enum hinic3_mod_type mod, u8 cmd,
+			   struct hinic3_cmd_buf *buf_in,
+			   u64 *out_param, u32 timeout)
 {
-	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
+	struct hinic3_cmdqs *cmdqs = ((struct hinic3_hwdev *)hwdev)->cmdqs;
 	int err;
 
 	err = cmdq_params_valid(hwdev, buf_in);
@@ -605,8 +479,8 @@ hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod, ui
 		return err;
 	}
 
-	return cmdq_sync_cmd_direct_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod,
-					 cmd, buf_in, out_param, timeout);
+	return cmdq_sync_cmd(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod, cmd, buf_in,
+						NULL, out_param, timeout, HINIC3_CMD_TYPE_DIRECT_RESP);
 }
 
 int
@@ -628,8 +502,8 @@ hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod, ui
 		return err;
 	}
 
-	return cmdq_sync_cmd_detail_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod,
-					 cmd, buf_in, buf_out, timeout);
+	return cmdq_sync_cmd(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod, cmd, buf_in, buf_out,
+						NULL, timeout, HINIC3_CMD_TYPE_SGE_RESP);
 }
 
 static void
@@ -643,21 +517,23 @@ clear_wqe_complete_bit(struct hinic3_cmdq *cmdq, struct hinic3_cmdq_wqe *wqe)
 {
 	struct hinic3_ctrl *ctrl = NULL;
 	uint32_t header_info = hinic3_hw_cpu32(WQE_HEADER(wqe)->header_info);
-	int buf_len = CMDQ_WQE_HEADER_GET(header_info, BUFDESC_LEN);
-	uint32_t wqe_size = cmdq_get_wqe_size(buf_len);
 	uint16_t num_wqebbs;
-
-	if (wqe_size == WQE_LCMD_SIZE)
-		ctrl = &wqe->wqe_lcmd.ctrl;
-	else
-		ctrl = &wqe->inline_wqe.wqe_scmd.ctrl;
-
-	/* Clear HW busy bit. */
-	ctrl->ctrl_info = 0;
+	enum data_format df;
+	if (cmdq->cmdqs->cmdq_mode == HINIC3_NORMAL_CMDQ) {
+		df = CMDQ_WQE_HEADER_GET(header_info, DATA_FMT);
+		if (df == DATA_SGE)
+			ctrl = &wqe->wqe_lcmd.ctrl;
+		else
+			ctrl = &wqe->inline_wqe.wqe_scmd.ctrl;
+		ctrl->ctrl_info = 0; /* clear HW busy bit */
+		num_wqebbs = NUM_WQEBBS_FOR_CMDQ_WQE;
+	} else {
+		wqe->enhanced_cmdq_wqe.completion.cs_format = 0; /* clear HW busy bit */
+		num_wqebbs = NUM_WQEBBS_FOR_ENHANCE_CMDQ_WQE;
+	}
 
 	rte_atomic_thread_fence(rte_memory_order_release); /**< Verify wqe is cleared. */
 
-	num_wqebbs = WQE_NUM_WQEBBS(wqe_size, cmdq->wq);
 	hinic3_put_wqe(cmdq->wq, num_wqebbs);
 }
 
@@ -735,25 +611,32 @@ static int
 hinic3_set_cmdq_ctxts(struct hinic3_hwdev *hwdev)
 {
 	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
-	struct hinic3_cmd_cmdq_ctxt cmdq_ctxt;
-	enum hinic3_cmdq_type cmdq_type;
+	struct hinic3_cmd_cmdq_ctxt cmdq_ctxt = {0};
+	enum hinic3_cmdq_type cmdq_type = HINIC3_CMDQ_SYNC;
 	uint16_t out_size = sizeof(cmdq_ctxt);
+	u16 cmd;
 	int err;
 
-	for (cmdq_type = HINIC3_CMDQ_SYNC; cmdq_type < HINIC3_MAX_CMDQ_TYPES; cmdq_type++) {
-		memset(&cmdq_ctxt, 0, sizeof(cmdq_ctxt));
-		cmdq_ctxt.ctxt_info = cmdqs->cmdq[cmdq_type].cmdq_ctxt;
+	for (; cmdq_type < HINIC3_MAX_CMDQ_TYPES; cmdq_type++) {
+		if (hwdev->cmdqs->cmdq_mode == HINIC3_NORMAL_CMDQ) {
+			memcpy((void *)&cmdq_ctxt.ctxt_info,
+			       (void *)&cmdqs->cmdq[cmdq_type].cmdq_ctxt,
+			       sizeof(cmdq_ctxt.ctxt_info));
+			cmd = HINIC3_MGMT_CMD_SET_CMDQ_CTXT;
+		} else {
+			memcpy((void *)&cmdq_ctxt.enhance_ctxt_info,
+				(void *)&cmdqs->cmdq[cmdq_type].cmdq_enhance_ctxt,
+				sizeof(cmdq_ctxt.enhance_ctxt_info));
+			cmd = HINIC3_MGMT_CMD_SET_ENHANCE_CMDQ_CTXT;
+		}
 		cmdq_ctxt.func_idx = hinic3_global_func_id(hwdev);
 		cmdq_ctxt.cmdq_id = cmdq_type;
 
-		err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,
-					      HINIC3_MGMT_CMD_SET_CMDQ_CTXT,
+		err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM, cmd,
 					      &cmdq_ctxt, sizeof(cmdq_ctxt),
-					      &cmdq_ctxt, &out_size);
-
+					      &cmdq_ctxt, &out_size, 0);
 		if (err || !out_size || cmdq_ctxt.status) {
-			PMD_DRV_LOG(ERR,
-				    "Set cmdq ctxt failed, err: %d, status: 0x%x, out_size: 0x%x",
+			PMD_DRV_LOG(ERR, "Set cmdq ctxt failed, err: %d, status: 0x%x, out_size: 0x%x",
 				    err, cmdq_ctxt.status, out_size);
 			return -EFAULT;
 		}
@@ -794,6 +677,7 @@ hinic3_set_cmdqs(struct hinic3_hwdev *hwdev, struct hinic3_cmdqs *cmdqs)
 	cmdqs->cmdqs_db_base = (uint8_t *)db_base;
 
 	for (cmdq_type = HINIC3_CMDQ_SYNC; cmdq_type < HINIC3_MAX_CMDQ_TYPES; cmdq_type++) {
+		cmdqs->cmdq[cmdq_type].cmdqs = cmdqs;
 		err = init_cmdq(&cmdqs->cmdq[cmdq_type], hwdev,
 				&cmdqs->saved_wqs[cmdq_type], cmdq_type);
 		if (err) {
@@ -801,8 +685,10 @@ hinic3_set_cmdqs(struct hinic3_hwdev *hwdev, struct hinic3_cmdqs *cmdqs)
 			goto init_cmdq_err;
 		}
 
-		cmdq_init_queue_ctxt(&cmdqs->cmdq[cmdq_type],
-				     &cmdqs->cmdq[cmdq_type].cmdq_ctxt);
+		if (cmdqs->cmdq_mode == HINIC3_NORMAL_CMDQ)
+			cmdq_init_queue_ctxt(&cmdqs->cmdq[cmdq_type], &cmdqs->cmdq[cmdq_type].cmdq_ctxt);
+		else
+			enhance_cmdq_init_queue_ctxt(&cmdqs->cmdq[cmdq_type]);
 	}
 
 	err = hinic3_set_cmdq_ctxts(hwdev);
@@ -821,7 +707,7 @@ hinic3_set_cmdqs(struct hinic3_hwdev *hwdev, struct hinic3_cmdqs *cmdqs)
 }
 
 int
-hinic3_init_cmdqs(struct hinic3_hwdev *hwdev)
+hinic3_cmdq_init(struct hinic3_hwdev *hwdev)
 {
 	struct hinic3_cmdqs *cmdqs = NULL;
 	size_t saved_wqs_size;
@@ -835,6 +721,13 @@ hinic3_init_cmdqs(struct hinic3_hwdev *hwdev)
 	hwdev->cmdqs = cmdqs;
 	cmdqs->hwdev = hwdev;
 
+	if (HINIC3_SUPPORT_ONLY_ENHANCE_CMDQ(hwdev))
+		cmdqs->cmdq_mode = HINIC3_ENHANCE_CMDQ;
+	else
+		cmdqs->cmdq_mode = HINIC3_NORMAL_CMDQ;
+	wqebb_shift = (cmdqs->cmdq_mode == HINIC3_ENHANCE_CMDQ) ?
+			CMDQ_ENHANCE_WQEBB_SHIFT : CMDQ_WQEBB_SHIFT;
+
 	saved_wqs_size = HINIC3_MAX_CMDQ_TYPES * sizeof(struct hinic3_wq);
 	cmdqs->saved_wqs = rte_zmalloc(NULL, saved_wqs_size, 0);
 	if (!cmdqs->saved_wqs) {
@@ -857,7 +750,7 @@ hinic3_init_cmdqs(struct hinic3_hwdev *hwdev)
 	}
 
 	err = hinic3_cmdq_alloc(cmdqs->saved_wqs, hwdev, HINIC3_MAX_CMDQ_TYPES,
-				HINIC3_CMDQ_WQ_BUF_SIZE, CMDQ_WQEBB_SHIFT,
+				HINIC3_CMDQ_WQ_BUF_SIZE, wqebb_shift,
 				HINIC3_CMDQ_DEPTH);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Allocate cmdq failed");
@@ -884,7 +777,7 @@ hinic3_init_cmdqs(struct hinic3_hwdev *hwdev)
 }
 
 void
-hinic3_free_cmdqs(struct hinic3_hwdev *hwdev)
+hinic3_cmdq_free(struct hinic3_hwdev *hwdev)
 {
 	struct hinic3_cmdqs *cmdqs = hwdev->cmdqs;
 	enum hinic3_cmdq_type cmdq_type = HINIC3_CMDQ_SYNC;
@@ -900,14 +793,36 @@ hinic3_free_cmdqs(struct hinic3_hwdev *hwdev)
 	rte_free(cmdqs);
 }
 
+static int
+hinic3_check_cmdq_done(struct hinic3_cmdq *cmdq, struct hinic3_cmdq_wqe *wqe)
+{
+	struct hinic3_ctrl *ctrl = NULL;
+	uint32_t ctrl_info;
+
+	if (cmdq->cmdqs->cmdq_mode == HINIC3_NORMAL_CMDQ) {
+		/* Only arm bit using scmd wqe, the wqe is lcmd. */
+		ctrl = &wqe->wqe_lcmd.ctrl;
+		ctrl_info = hinic3_hw_cpu32((ctrl)->ctrl_info);
+
+		if (!WQE_COMPLETED(ctrl_info))
+			return -EBUSY;
+	} else {
+		ctrl_info = wqe->enhanced_cmdq_wqe.completion.cs_format;
+		ctrl_info = hinic3_hw_cpu32(ctrl_info);
+
+		if (!ENHANCE_CMDQ_WQE_CS_GET(ctrl_info, HW_BUSY))
+			return -EBUSY;
+	}
+	return 0;
+}
+
 static int
 hinic3_cmdq_poll_msg(struct hinic3_cmdq *cmdq, uint32_t timeout)
 {
 	struct hinic3_cmdq_wqe *wqe = NULL;
 	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd = NULL;
-	struct hinic3_ctrl *ctrl = NULL;
 	struct hinic3_cmdq_cmd_info *cmd_info = NULL;
-	uint32_t status_info, ctrl_info;
+	uint32_t status_info;
 	uint16_t ci;
 	int errcode;
 	uint64_t end;
@@ -928,13 +843,10 @@ hinic3_cmdq_poll_msg(struct hinic3_cmdq *cmdq, uint32_t timeout)
 		return -EINVAL;
 	}
 
-	/* Only arm bit is using scmd wqe, the wqe is lcmd. */
-	wqe_lcmd = &wqe->wqe_lcmd;
-	ctrl = &wqe_lcmd->ctrl;
+	/* Only arm bit using scmd wqe, the wqe is lcmd. */
 	end = cycles + msecs_to_cycles(timeout);
 	do {
-		ctrl_info = hinic3_hw_cpu32((ctrl)->ctrl_info);
-		if (WQE_COMPLETED(ctrl_info)) {
+		if (hinic3_check_cmdq_done(cmdq, wqe) == 0) {
 			done = 1;
 			break;
 		}
@@ -943,8 +855,14 @@ hinic3_cmdq_poll_msg(struct hinic3_cmdq *cmdq, uint32_t timeout)
 	} while (time_before(cycles, end));
 
 	if (done) {
-		status_info = hinic3_hw_cpu32(wqe_lcmd->status.status_info);
-		errcode = WQE_ERRCODE_GET(status_info, VAL);
+		if (cmdq->cmdqs->cmdq_mode == HINIC3_NORMAL_CMDQ) {
+			wqe_lcmd = &wqe->wqe_lcmd;
+			status_info = hinic3_hw_cpu32(wqe_lcmd->status.status_info);
+			errcode = WQE_ERRCODE_GET(status_info, VAL);
+		} else {
+			status_info = hinic3_hw_cpu32(wqe->enhanced_cmdq_wqe.completion.cs_format);
+			errcode = ENHANCE_CMDQ_WQE_CS_GET(status_info, ERR_CODE);
+		}
 		cmdq_update_errcode(cmdq, ci, errcode);
 		clear_wqe_complete_bit(cmdq, wqe);
 		err = 0;
diff --git a/drivers/net/hinic3/base/hinic3_cmdq.h b/drivers/net/hinic3/base/hinic3_cmdq.h
index deac909488..75a5dbaab5 100644
--- a/drivers/net/hinic3/base/hinic3_cmdq.h
+++ b/drivers/net/hinic3/base/hinic3_cmdq.h
@@ -7,31 +7,62 @@
 
 #include "hinic3_mgmt.h"
 #include "hinic3_wq.h"
+#include "hinic3_pmd_cmdq_enhance.h"
 
 #define HINIC3_SCMD_DATA_LEN 16
 
 /* Pmd driver uses 64, kernel l2nic uses 4096. */
 #define HINIC3_CMDQ_DEPTH 64
 
-#define HINIC3_CMDQ_BUF_SIZE 2048U
+#define HINIC3_CMDQ_BUF_SIZE 1024U
 
 #define HINIC3_CEQ_ID_CMDQ 0
 
-enum cmdq_scmd_type { CMDQ_SET_ARM_CMD = 2 };
+#define WQ_BLOCK_PFN_SHIFT		9
+#define WQ_BLOCK_PFN(page_addr)		((page_addr) >> WQ_BLOCK_PFN_SHIFT)
 
-enum cmdq_wqe_type { WQE_LCMD_TYPE = 0, WQE_SCMD_TYPE = 1 };
+enum hinic3_cmdq_mode {
+	HINIC3_NORMAL_CMDQ,
+	HINIC3_ENHANCE_CMDQ
+};
+
+enum cmdq_scmd_type {
+	CMDQ_SET_ARM_CMD = 2
+};
 
-enum ctrl_sect_len { CTRL_SECT_LEN = 1, CTRL_DIRECT_SECT_LEN = 2 };
+enum cmdq_wqe_type {
+	WQE_LCMD_TYPE,
+	WQE_SCMD_TYPE
+};
+
+enum ctrl_sect_len {
+	CTRL_SECT_LEN = 1,
+	CTRL_DIRECT_SECT_LEN = 2
+};
 
-enum bufdesc_len { BUFDESC_LCMD_LEN = 2, BUFDESC_SCMD_LEN = 3 };
+enum bufdesc_len {
+	BUFDESC_LCMD_LEN = 2,
+	BUFDESC_SCMD_LEN = 3
+};
 
-enum data_format { DATA_SGE = 0};
+enum data_format {
+		DATA_SGE
+};
 
-enum completion_format { COMPLETE_DIRECT = 0, COMPLETE_SGE = 1 };
+enum completion_format {
+	COMPLETE_DIRECT,
+	COMPLETE_SGE
+};
 
-enum completion_request { CEQ_SET = 1 };
+enum completion_request {
+		CEQ_SET = 1
+};
 
-enum cmdq_cmd_type { SYNC_CMD_DIRECT_RESP, SYNC_CMD_SGE_RESP, ASYNC_CMD };
+enum cmdq_cmd_type {
+	SYNC_CMD_DIRECT_RESP,
+	SYNC_CMD_SGE_RESP,
+	ASYNC_CMD
+};
 
 enum hinic3_cmdq_type {
 	HINIC3_CMDQ_SYNC,
@@ -44,7 +75,10 @@ enum hinic3_db_src_type {
 	HINIC3_DB_SRC_L2NIC_SQ_TYPE
 };
 
-enum hinic3_cmdq_db_type { HINIC3_DB_SQ_RQ_TYPE, HINIC3_DB_CMDQ_TYPE };
+enum hinic3_cmdq_db_type {
+	HINIC3_DB_SQ_RQ_TYPE,
+	HINIC3_DB_CMDQ_TYPE
+};
 
 /* Cmdq ack type. */
 enum hinic3_ack_type {
@@ -52,7 +86,7 @@ enum hinic3_ack_type {
 	HINIC3_ACK_TYPE_SHARE_CQN	= 1,
 	HINIC3_ACK_TYPE_APP_CQN		= 2,
 
-	HINIC3_MOD_ACK_MAX		= 15
+	HINIC3_MOD_ACK_MAX			= 15
 };
 
 /* Cmdq wqe ctrls. */
@@ -126,6 +160,7 @@ struct hinic3_cmdq_wqe {
 	union {
 		struct hinic3_cmdq_inline_wqe inline_wqe;
 		struct hinic3_cmdq_wqe_lcmd wqe_lcmd;
+		struct enhanced_cmdq_wqe enhanced_cmdq_wqe;
 	};
 };
 
@@ -144,6 +179,7 @@ struct hinic3_cmd_cmdq_ctxt {
 	uint8_t rsvd1[5];
 
 	struct hinic3_cmdq_ctxt_info ctxt_info;
+	struct enhance_cmdq_ctxt_info enhance_ctxt_info;
 };
 
 enum hinic3_cmdq_status {
@@ -173,8 +209,10 @@ struct hinic3_cmdq {
 	rte_spinlock_t cmdq_lock;
 
 	struct hinic3_cmdq_ctxt_info cmdq_ctxt;
+	struct enhance_cmdq_ctxt_info cmdq_enhance_ctxt;
 
 	struct hinic3_cmdq_cmd_info *cmd_infos;
+	struct hinic3_cmdqs *cmdqs;
 };
 
 struct hinic3_cmdqs {
@@ -188,6 +226,7 @@ struct hinic3_cmdqs {
 	struct hinic3_cmdq cmdq[HINIC3_MAX_CMDQ_TYPES];
 
 	uint32_t status;
+	uint8_t cmdq_mode;
 };
 
 struct hinic3_cmd_buf {
@@ -215,8 +254,8 @@ int hinic3_cmdq_direct_resp(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod
 int hinic3_cmdq_detail_resp(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod, uint8_t cmd,
 		 struct hinic3_cmd_buf *buf_in, struct hinic3_cmd_buf *buf_out, uint32_t timeout);
 
-int hinic3_init_cmdqs(struct hinic3_hwdev *hwdev);
+int hinic3_cmdq_init(struct hinic3_hwdev *hwdev);
 
-void hinic3_free_cmdqs(struct hinic3_hwdev *hwdev);
+void hinic3_cmdq_free(struct hinic3_hwdev *hwdev);
 
 #endif /* _HINIC3_CMDQ_H_ */
diff --git a/drivers/net/hinic3/base/hinic3_cmdq_enhance.c b/drivers/net/hinic3/base/hinic3_cmdq_enhance.c
new file mode 100644
index 0000000000..22a4c81482
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_cmdq_enhance.c
@@ -0,0 +1,110 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2019 Huawei Technologies Co., Ltd
+ */
+
+#include <rte_mbuf.h>
+
+#include "hinic3_compat.h"
+#include "hinic3_hwdev.h"
+#include "hinic3_hwif.h"
+#include "hinic3_wq.h"
+#include "hinic3_cmd.h"
+#include "hinic3_mgmt.h"
+#include "hinic3_cmdq.h"
+#include "hinic3_cmdq_enhance.h"
+
+#define WQ_PREFETCH_MAX			4
+#define WQ_PREFETCH_MIN			1
+#define WQ_PREFETCH_THRESHOLD	256
+
+void enhance_cmdq_init_queue_ctxt(struct hinic3_cmdq *cmdq)
+{
+	struct enhance_cmdq_ctxt_info *ctxt_info = &cmdq->cmdq_enhance_ctxt;
+	struct hinic3_wq *wq = cmdq->wq;
+	uint64_t cmdq_first_block_paddr, pfn;
+	uint16_t start_ci = (uint16_t)wq->cons_idx;
+	uint32_t start_pi = (uint16_t)wq->prod_idx;
+
+	/* The data in HW is Big Endian Format */
+	cmdq_first_block_paddr = wq->queue_buf_paddr;
+	pfn = CMDQ_PFN(cmdq_first_block_paddr, RTE_PGSIZE_4K);
+
+	/* First part 16B */
+	ctxt_info->eq_cfg =
+		ENHANCED_CMDQ_SET(pfn, CTXT0_CI_WQE_ADDR) |
+		ENHANCED_CMDQ_SET(0, CTXT0_EQ) |
+		ENHANCED_CMDQ_SET(0, CTXT0_CEQ_ARM) |
+		ENHANCED_CMDQ_SET(0, CTXT0_CEQ_EN) |
+		ENHANCED_CMDQ_SET(1, CTXT0_HW_BUSY_BIT);
+
+	ctxt_info->dfx_pi_ci =
+		ENHANCED_CMDQ_SET(0, CTXT1_Q_DIS) |
+		ENHANCED_CMDQ_SET(0, CTXT1_ERR_CODE) |
+		ENHANCED_CMDQ_SET(start_pi, CTXT1_PI) |
+		ENHANCED_CMDQ_SET(start_ci, CTXT1_CI);
+
+	/* Second part 16B */
+	ctxt_info->pft_thd =
+		ENHANCED_CMDQ_SET(CI_HIGN_IDX(start_ci), CTXT2_PFT_CI) |
+		ENHANCED_CMDQ_SET(1, CTXT2_O_BIT) |
+		ENHANCED_CMDQ_SET(WQ_PREFETCH_MIN, CTXT2_PFT_MIN) |
+		ENHANCED_CMDQ_SET(WQ_PREFETCH_MAX, CTXT2_PFT_MAX) |
+		ENHANCED_CMDQ_SET(WQ_PREFETCH_THRESHOLD, CTXT2_PFT_THD);
+	ctxt_info->pft_ci =
+		ENHANCED_CMDQ_SET(pfn, CTXT3_PFT_CI_ADDR) |
+		ENHANCED_CMDQ_SET(start_ci, CTXT3_PFT_CI);
+
+	/* Third part 16B */
+	cmdq_first_block_paddr = cmdq_first_block_paddr;
+	pfn = WQ_BLOCK_PFN(cmdq_first_block_paddr);
+
+	ctxt_info->ci_cla_addr = ENHANCED_CMDQ_SET(pfn, CTXT4_CI_CLA_ADDR);
+}
+
+static void enhance_cmdq_set_completion(struct cmdq_enhance_completion *completion,
+					const struct hinic3_cmd_buf *buf_out)
+{
+	completion->sge_resp_hi_addr = upper_32_bits(buf_out->dma_addr);
+	completion->sge_resp_lo_addr = lower_32_bits(buf_out->dma_addr);
+	completion->sge_resp_len = HINIC3_CMDQ_BUF_SIZE;
+}
+
+void enhance_cmdq_set_wqe(struct hinic3_cmdq_wqe *wqe,
+			   enum cmdq_cmd_type cmd_type,
+			   const struct hinic3_cmd_buf *buf_in,
+			   const struct hinic3_cmd_buf *buf_out, int wrapped,
+			   uint8_t mod, uint8_t cmd)
+{
+	struct enhanced_cmdq_wqe *enhanced_wqe = &wqe->enhanced_cmdq_wqe;
+
+	enhanced_wqe->ctrl_sec.header =
+		ENHANCE_CMDQ_WQE_HEADER_SET(buf_in->size, SEND_SGE_LEN) |
+		ENHANCE_CMDQ_WQE_HEADER_SET(1, BDSL) |
+		ENHANCE_CMDQ_WQE_HEADER_SET(DATA_SGE, DF) |
+		ENHANCE_CMDQ_WQE_HEADER_SET(NORMAL_WQE_TYPE, DN) |
+		ENHANCE_CMDQ_WQE_HEADER_SET(COMPACT_WQE_TYPE, EC) |
+		ENHANCE_CMDQ_WQE_HEADER_SET((uint32_t)wrapped, HW_BUSY_BIT);
+
+	enhanced_wqe->ctrl_sec.sge_send_hi_addr = upper_32_bits(buf_in->dma_addr);
+	enhanced_wqe->ctrl_sec.sge_send_lo_addr = lower_32_bits(buf_in->dma_addr);
+
+	enhanced_wqe->completion.cs_format =
+		ENHANCE_CMDQ_WQE_CS_SET(cmd, CMD) |
+		ENHANCE_CMDQ_WQE_CS_SET(HINIC3_ACK_TYPE_CMDQ, ACK_TYPE) |
+		ENHANCE_CMDQ_WQE_CS_SET(mod, MOD);
+
+	switch (cmd_type) {
+	case SYNC_CMD_DIRECT_RESP:
+		enhanced_wqe->completion.cs_format |= ENHANCE_CMDQ_WQE_CS_SET(INLINE_DATA, CF);
+		break;
+	case SYNC_CMD_SGE_RESP:
+		if (buf_out) {
+			enhanced_wqe->completion.cs_format |=
+				ENHANCE_CMDQ_WQE_CS_SET(SGE_RESPONSE, CF);
+			enhance_cmdq_set_completion(&enhanced_wqe->completion, buf_out);
+		}
+		break;
+	case ASYNC_CMD:
+		break;
+	}
+}
diff --git a/drivers/net/hinic3/base/hinic3_cmdq_enhance.h b/drivers/net/hinic3/base/hinic3_cmdq_enhance.h
new file mode 100644
index 0000000000..c762c07eb5
--- /dev/null
+++ b/drivers/net/hinic3/base/hinic3_cmdq_enhance.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Huawei Technologies Co., Ltd
+ */
+
+#ifndef _HINIC3_CMDQ_ENHANCE_H_
+#define _HINIC3_CMDQ_ENHANCE_H_
+
+#include "hinic3_mgmt.h"
+
+#define NORMAL_WQE_TYPE  0
+#define COMPACT_WQE_TYPE 1
+
+/* First part 16B */
+#define ENHANCED_CMDQ_CTXT0_CI_WQE_ADDR_SHIFT   0
+#define ENHANCED_CMDQ_CTXT0_RSV1_SHIFT          52
+#define ENHANCED_CMDQ_CTXT0_EQ_SHIFT            53
+#define ENHANCED_CMDQ_CTXT0_CEQ_ARM_SHIFT       61
+#define ENHANCED_CMDQ_CTXT0_CEQ_EN_SHIFT        62
+#define ENHANCED_CMDQ_CTXT0_HW_BUSY_BIT_SHIFT   63
+
+#define ENHANCED_CMDQ_CTXT0_CI_WQE_ADDR_MASK    0xFFFFFFFFFFFFFU
+#define ENHANCED_CMDQ_CTXT0_RSV1_MASK           0x1U
+#define ENHANCED_CMDQ_CTXT0_EQ_MASK             0xFFU
+#define ENHANCED_CMDQ_CTXT0_CEQ_ARM_MASK        0x1U
+#define ENHANCED_CMDQ_CTXT0_CEQ_EN_MASK         0x1U
+#define ENHANCED_CMDQ_CTXT0_HW_BUSY_BIT_MASK    0x1U
+
+#define ENHANCED_CMDQ_CTXT1_Q_DIS_SHIFT         0
+#define ENHANCED_CMDQ_CTXT1_ERR_CODE_SHIFT      1
+#define ENHANCED_CMDQ_CTXT1_RSV1_SHIFT          3
+#define ENHANCED_CMDQ_CTXT1_PI_SHIFT            32
+#define ENHANCED_CMDQ_CTXT1_CI_SHIFT            48
+
+#define ENHANCED_CMDQ_CTXT1_Q_DIS_MASK          0x1U
+#define ENHANCED_CMDQ_CTXT1_ERR_CODE_MASK       0x3U
+#define ENHANCED_CMDQ_CTXT1_RSV1_MASK           0x1FFFFFFFU
+#define ENHANCED_CMDQ_CTXT1_PI_MASK             0xFFFFU
+#define ENHANCED_CMDQ_CTXT1_CI_MASK             0xFFFFU
+
+/* Second part 16B */
+#define ENHANCED_CMDQ_CTXT2_PFT_CI_SHIFT        0
+#define ENHANCED_CMDQ_CTXT2_O_BIT_SHIFT         4
+#define ENHANCED_CMDQ_CTXT2_PFT_THD_SHIFT       32
+#define ENHANCED_CMDQ_CTXT2_PFT_MAX_SHIFT       46
+#define ENHANCED_CMDQ_CTXT2_PFT_MIN_SHIFT       57
+
+#define ENHANCED_CMDQ_CTXT2_PFT_CI_MASK         0xFU
+#define ENHANCED_CMDQ_CTXT2_O_BIT_MASK          0x1U
+#define ENHANCED_CMDQ_CTXT2_PFT_THD_MASK        0x3FFFFU
+#define ENHANCED_CMDQ_CTXT2_PFT_MAX_MASK        0x7FFFU
+#define ENHANCED_CMDQ_CTXT2_PFT_MIN_MASK        0x7FU
+
+#define ENHANCED_CMDQ_CTXT3_PFT_CI_ADDR_SHIFT	0
+#define ENHANCED_CMDQ_CTXT3_PFT_CI_SHIFT		52
+
+#define ENHANCED_CMDQ_CTXT3_PFT_CI_ADDR_MASK	0xFFFFFFFFFFFFFU
+#define ENHANCED_CMDQ_CTXT3_PFT_CI_MASK			0xFFFFU
+
+/* Third part 16B */
+#define ENHANCED_CMDQ_CTXT4_CI_CLA_ADDR_SHIFT	0
+#define ENHANCED_CMDQ_CTXT4_CI_CLA_ADDR_MASK	0x7FFFFFFFFFFFFFU
+
+#define ENHANCED_CMDQ_SET(val, member)      \
+			(((uint64_t)(val) & ENHANCED_CMDQ_##member##_MASK) << \
+			 ENHANCED_CMDQ_##member##_SHIFT)
+
+#define CI_IDX_HIGH_SHIFH       12
+#define CI_HIGN_IDX(val)        ((val) >> CI_IDX_HIGH_SHIFH)
+
+#define ENHANCE_CMDQ_WQE_HEADER_SEND_SGE_LEN_SHIFT  0
+#define ENHANCE_CMDQ_WQE_HEADER_BDSL_SHIFT          19
+#define ENHANCE_CMDQ_WQE_HEADER_DF_SHIFT            28
+#define ENHANCE_CMDQ_WQE_HEADER_DN_SHIFT            29
+#define ENHANCE_CMDQ_WQE_HEADER_EC_SHIFT            30
+#define ENHANCE_CMDQ_WQE_HEADER_HW_BUSY_BIT_SHIFT   31
+
+#define ENHANCE_CMDQ_WQE_HEADER_SEND_SGE_LEN_MASK   0x3FFFFU
+#define ENHANCE_CMDQ_WQE_HEADER_BDSL_MASK           0xFFU
+#define ENHANCE_CMDQ_WQE_HEADER_DF_MASK             0x1U
+#define ENHANCE_CMDQ_WQE_HEADER_DN_MASK             0x1U
+#define ENHANCE_CMDQ_WQE_HEADER_EC_MASK             0x1U
+#define ENHANCE_CMDQ_WQE_HEADER_HW_BUSY_BIT_MASK    0x1U
+
+#define ENHANCE_CMDQ_WQE_HEADER_SET(val, member)        \
+			((((uint32_t)(val)) & ENHANCE_CMDQ_WQE_HEADER_##member##_MASK) << \
+			 ENHANCE_CMDQ_WQE_HEADER_##member##_SHIFT)
+
+#define ENHANCE_CMDQ_WQE_HEADER_GET(val, member)        \
+			(((val) >> ENHANCE_CMDQ_WQE_HEADER_##member##_SHIFT) & \
+			 ENHANCE_CMDQ_WQE_HEADER_##member##_MASK)
+
+#define ENHANCE_CMDQ_WQE_CS_ERR_CODE_SHIFT          0
+#define ENHANCE_CMDQ_WQE_CS_CMD_SHIFT               4
+#define ENHANCE_CMDQ_WQE_CS_ACK_TYPE_SHIFT          12
+#define ENHANCE_CMDQ_WQE_CS_HW_BUSY_SHIFT           14
+#define ENHANCE_CMDQ_WQE_CS_MOD_SHIFT               16
+#define ENHANCE_CMDQ_WQE_CS_CF_SHIFT                31
+
+#define ENHANCE_CMDQ_WQE_CS_ERR_CODE_MASK           0xFU
+#define ENHANCE_CMDQ_WQE_CS_CMD_MASK                0xFFU
+#define ENHANCE_CMDQ_WQE_CS_ACK_TYPE_MASK           0x3U
+#define ENHANCE_CMDQ_WQE_CS_HW_BUSY_MASK            0x1U
+#define ENHANCE_CMDQ_WQE_CS_MOD_MASK                0x1FU
+#define ENHANCE_CMDQ_WQE_CS_CF_MASK                 0x1U
+
+#define ENHANCE_CMDQ_WQE_CS_SET(val, member)        \
+			((((uint32_t)(val)) & ENHANCE_CMDQ_WQE_CS_##member##_MASK) << \
+			 ENHANCE_CMDQ_WQE_CS_##member##_SHIFT)
+
+#define ENHANCE_CMDQ_WQE_CS_GET(val, member)        \
+			(((val) >> ENHANCE_CMDQ_WQE_CS_##member##_SHIFT) & \
+			 ENHANCE_CMDQ_WQE_CS_##member##_MASK)
+
+enum complete_format {
+	INLINE_DATA,
+	SGE_RESPONSE
+};
+
+struct cmdq_enhance_completion {
+	uint32_t cs_format;
+	uint32_t sge_resp_hi_addr;
+	uint32_t sge_resp_lo_addr;
+	uint32_t sge_resp_len; /* bit 14~31 rsvd, soft can't use. */
+};
+
+struct cmdq_enhance_response {
+	uint32_t cs_format;
+	uint32_t resvd;
+	uint64_t direct_data;
+};
+
+struct sge_send_info {
+	uint32_t sge_hi_addr;
+	uint32_t sge_li_addr;
+	uint32_t seg_len;
+	uint32_t rsvd;
+};
+
+struct ctrl_section {
+	uint32_t header;
+	uint32_t rsv;
+	uint32_t sge_send_hi_addr;
+	uint32_t sge_send_lo_addr;
+};
+
+struct enhanced_cmdq_wqe {
+	struct ctrl_section     ctrl_sec; /* 16B */
+	struct cmdq_enhance_completion  completion; /* 16B */
+};
+
+/* 	Enhance cmdq context of hardware */
+struct enhance_cmdq_ctxt_info {
+	uint64_t eq_cfg;
+	uint64_t dfx_pi_ci;
+
+	uint64_t pft_thd;
+	uint64_t pft_ci;
+
+	uint64_t rsv;
+	uint64_t ci_cla_addr;
+};
+
+void enhance_cmdq_set_wqe(struct hinic3_cmdq_wqe *wqe, enum cmdq_cmd_type cmd_type,
+			   const struct hinic3_cmd_buf *buf_in, const struct hinic3_cmd_buf *buf_out,
+			   int wrapped, uint8_t mod, uint8_t cmd);
+
+void enhance_cmdq_init_queue_ctxt(struct hinic3_cmdq *cmdq);
+
+#endif /*_HINIC3_CMDQ_ENHANCE_H_ */
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.c b/drivers/net/hinic3/base/hinic3_hw_comm.c
index d259b88a2d..6541bc0428 100644
--- a/drivers/net/hinic3/base/hinic3_hw_comm.c
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.c
@@ -12,7 +12,7 @@
 #include "hinic3_wq.h"
 #include "hinic3_nic_cfg.h"
 
-/* Buffer sizes in hinic3_convert_rx_buf_size must be in ascending order. */
+/* Buffer sizes must be in ascending order. */
 const uint32_t hinic3_hw_rx_buf_size[] = {
 	HINIC3_RX_BUF_SIZE_32B,
 	HINIC3_RX_BUF_SIZE_64B,
@@ -239,11 +239,14 @@ hinic3_convert_rx_buf_size(uint32_t rx_buf_sz, uint32_t *match_sz)
 }
 
 static uint16_t
-get_hw_rx_buf_size(uint32_t rx_buf_sz)
+get_hw_rx_buf_size(struct hinic3_hwdev *hwdev, uint32_t rx_buf_sz)
 {
 	uint16_t num_hw_types = RTE_DIM(hinic3_hw_rx_buf_size);
 	uint16_t i;
 
+	if (HINIC3_IS_USE_REAL_RX_BUF_SIZE(hwdev))
+		return rx_buf_sz;
+
 	for (i = 0; i < num_hw_types; i++) {
 		if (hinic3_hw_rx_buf_size[i] == rx_buf_sz)
 			return i;
@@ -271,8 +274,12 @@ hinic3_set_root_ctxt(struct hinic3_hwdev *hwdev, uint32_t rq_depth,
 	root_ctxt.cmdq_depth = 0;
 	root_ctxt.lro_en = 1;
 	root_ctxt.rq_depth = (uint16_t)rte_log2_u32(rq_depth);
-	root_ctxt.rx_buf_sz = get_hw_rx_buf_size(rx_buf_sz);
+	root_ctxt.rx_buf_sz = get_hw_rx_buf_size(hwdev, rx_buf_sz);
 	root_ctxt.sq_depth = (uint16_t)rte_log2_u32(sq_depth);
+	root_ctxt.cmdq_mode = hwdev->cmdqs->cmdq_mode;
+
+	if (hwdev->cmdqs->cmdq_mode == HINIC3_ENHANCE_CMDQ)
+		root_ctxt.cmdq_depth--;
 
 	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,
 				      HINIC3_MGMT_CMD_SET_VAT,
@@ -403,7 +410,7 @@ hinic3_comm_features_nego(struct hinic3_hwdev *hwdev,
 	uint16_t out_size = sizeof(feature_nego);
 	int err;
 
-	if (!hwdev || !s_feature || size > COMM_MAX_FEATURE_QWORD)
+	if (!hwdev || !s_feature || size > HINIC3_MAX_FEATURE_QWORD)
 		return -EINVAL;
 
 	memset(&feature_nego, 0, sizeof(feature_nego));
diff --git a/drivers/net/hinic3/base/hinic3_hw_comm.h b/drivers/net/hinic3/base/hinic3_hw_comm.h
index b86f5aad8f..186a826ce1 100644
--- a/drivers/net/hinic3/base/hinic3_hw_comm.h
+++ b/drivers/net/hinic3/base/hinic3_hw_comm.h
@@ -9,17 +9,17 @@
 #define HINIC3_MGMT_CMD_OP_GET 0
 #define HINIC3_MGMT_CMD_OP_SET 1
 
-#define HINIC3_MSIX_CNT_LLI_TIMER_SHIFT	    0
-#define HINIC3_MSIX_CNT_LLI_CREDIT_SHIFT    8
-#define HINIC3_MSIX_CNT_COALESCE_TIMER_SHIFT 8
-#define HINIC3_MSIX_CNT_PENDING_SHIFT	    8
-#define HINIC3_MSIX_CNT_RESEND_TIMER_SHIFT  29
-
-#define HINIC3_MSIX_CNT_LLI_TIMER_MASK	   0xFFU
-#define HINIC3_MSIX_CNT_LLI_CREDIT_MASK	   0xFFU
-#define HINIC3_MSIX_CNT_COALESCE_TIMER_MASK 0xFFU
-#define HINIC3_MSIX_CNT_PENDING_MASK	   0x1FU
-#define HINIC3_MSIX_CNT_RESEND_TIMER_MASK  0x7U
+#define HINIC3_MSIX_CNT_LLI_TIMER_SHIFT			0
+#define HINIC3_MSIX_CNT_LLI_CREDIT_SHIFT		8
+#define HINIC3_MSIX_CNT_COALESCE_TIMER_SHIFT	8
+#define HINIC3_MSIX_CNT_PENDING_SHIFT			8
+#define HINIC3_MSIX_CNT_RESEND_TIMER_SHIFT		29
+
+#define HINIC3_MSIX_CNT_LLI_TIMER_MASK			0xFFU
+#define HINIC3_MSIX_CNT_LLI_CREDIT_MASK			0xFFU
+#define HINIC3_MSIX_CNT_COALESCE_TIMER_MASK		0xFFU
+#define HINIC3_MSIX_CNT_PENDING_MASK			0x1FU
+#define HINIC3_MSIX_CNT_RESEND_TIMER_MASK		0x7U
 
 #define HINIC3_MSIX_CNT_SET(val, member)           \
 	(((val) & HINIC3_MSIX_CNT_##member##_MASK) \
@@ -129,7 +129,7 @@ struct hinic3_cmd_root_ctxt {
 	uint8_t cmdq_depth;
 	uint16_t rx_buf_sz;
 	uint8_t lro_en;
-	uint8_t rsvd1;
+	uint8_t cmdq_mode;
 	uint16_t sq_depth;
 	uint16_t rq_depth;
 	uint64_t rsvd2;
@@ -143,17 +143,16 @@ enum hinic3_fw_ver_type {
 	HINIC3_FW_VER_TYPE_CFG,
 };
 
-#define MGMT_MSG_CMD_OP_SET 1
-#define MGMT_MSG_CMD_OP_GET 0
+#define MGMT_MSG_CMD_OP_SET	1
+#define MGMT_MSG_CMD_OP_GET	0
 
-#define COMM_MAX_FEATURE_QWORD 4
 struct comm_cmd_feature_nego {
 	struct mgmt_msg_head head;
 
 	uint16_t func_id;
 	uint8_t opcode; /**< 1: set, 0: get. */
 	uint8_t rsvd;
-	uint64_t s_feature[COMM_MAX_FEATURE_QWORD];
+	uint64_t s_feature[HINIC3_MAX_FEATURE_QWORD];
 };
 
 #define HINIC3_FW_VERSION_LEN	    16
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.c b/drivers/net/hinic3/base/hinic3_hwdev.c
index 668bbf4a0e..6e1b1372a5 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.c
+++ b/drivers/net/hinic3/base/hinic3_hwdev.c
@@ -261,7 +261,7 @@ hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)
 {
 	int err;
 
-	err = hinic3_init_cmdqs(hwdev);
+	err = hinic3_cmdq_init(hwdev);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Init cmd queues failed");
 		return err;
@@ -276,7 +276,7 @@ hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)
 	return 0;
 
 set_cmdq_depth_err:
-	hinic3_free_cmdqs(hwdev);
+	hinic3_cmdq_free(hwdev);
 
 	return err;
 }
@@ -284,7 +284,7 @@ hinic3_comm_cmdqs_init(struct hinic3_hwdev *hwdev)
 static void
 hinic3_comm_cmdqs_free(struct hinic3_hwdev *hwdev)
 {
-	hinic3_free_cmdqs(hwdev);
+	hinic3_cmdq_free(hwdev);
 }
 
 static void
@@ -426,6 +426,12 @@ hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
 		goto func_reset_err;
 	}
 
+	err = hinic3_get_comm_features(hwdev, hwdev->features, HINIC3_MAX_FEATURE_QWORD);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Get comm features failed");
+		goto get_common_features_err;
+	}
+
 	err = hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 1);
 	if (err)
 		goto set_used_state_err;
@@ -444,6 +450,7 @@ hinic3_init_comm_ch(struct hinic3_hwdev *hwdev)
 	hinic3_set_func_svc_used_state(hwdev, HINIC3_MOD_COMM, 0);
 set_used_state_err:
 func_reset_err:
+get_common_features_err:
 get_func_info_err:
 	free_mgmt_channel(hwdev);
 
diff --git a/drivers/net/hinic3/base/hinic3_hwdev.h b/drivers/net/hinic3/base/hinic3_hwdev.h
index 161f1e2de5..c6661aa1a6 100644
--- a/drivers/net/hinic3/base/hinic3_hwdev.h
+++ b/drivers/net/hinic3/base/hinic3_hwdev.h
@@ -23,6 +23,18 @@ enum hinic3_set_arm_type {
 	HINIC3_SET_ARM_TYPE_NUM
 };
 
+enum {
+	HINIC3_F_API_CHAIN = 1U << 0,
+	HINIC3_F_CLP = 1U << 1,
+	HINIC3_F_CHANNEL_DETECT = 1U << 2,
+	HINIC3_F_MBOX_SEGMENT = 1U << 3,
+	HINIC3_F_CMDQ_NUM = 1U << 4,
+	HINIC3_F_VIRTIO_VQ_SIZE = 1U << 5,
+	HINIC3_F_EXTEND_CAP = 1U << 6,
+	HINIC3_F_SMF_CACHE_INVALID = 1U << 7,
+	HINIC3_F_ONLY_ENHANCE_CMDQ = 1U << 8,
+	HINIC3_F_USE_REAL_RX_BUF_SIZE = 1U << 9,
+};
 struct hinic3_page_addr {
 	void *virt_addr;
 	uint64_t phys_addr;
@@ -78,6 +90,11 @@ struct hinic3_hw_stats {
 #define HINIC3_CHIP_FAULT_SIZE (110 * 1024)
 #define MAX_DRV_BUF_SIZE       4096
 
+#define HINIC3_SUPPORT_ONLY_ENHANCE_CMDQ(hwdev) \
+	(((struct hinic3_hwdev *)hwdev)->features[0] & HINIC3_F_ONLY_ENHANCE_CMDQ)
+#define HINIC3_IS_USE_REAL_RX_BUF_SIZE(hwdev) \
+	(((struct hinic3_hwdev *)hwdev)->features[0] & HINIC3_F_USE_REAL_RX_BUF_SIZE)
+
 struct nic_cmd_chip_fault_stats {
 	uint32_t offset;
 	uint8_t chip_fault_stats[MAX_DRV_BUF_SIZE];
@@ -141,6 +158,7 @@ struct hinic3_hwdev {
 
 	uint16_t max_vfs;
 	uint16_t link_status;
+	uint64_t features[HINIC3_MAX_FEATURE_QWORD];
 };
 
 bool hinic3_is_vfio_iommu_enable(const struct rte_eth_dev *rte_dev);
diff --git a/drivers/net/hinic3/base/hinic3_mgmt.c b/drivers/net/hinic3/base/hinic3_mgmt.c
index 5db6d49922..b1f850dfff 100644
--- a/drivers/net/hinic3/base/hinic3_mgmt.c
+++ b/drivers/net/hinic3/base/hinic3_mgmt.c
@@ -13,6 +13,8 @@
 #define SEGMENT_LEN	     48
 #define MGMT_MSG_MAX_SEQ_ID \
 	(RTE_ALIGN(HINIC3_MSG_TO_MGMT_MAX_LEN, SEGMENT_LEN) / SEGMENT_LEN)
+#define MGMT_MSG_LAST_SEG_MAX_LEN \
+	(MAX_PF_MGMT_BUF_SIZE - SEGMENT_LEN * MGMT_MSG_MAX_SEQ_ID)
 
 #define BUF_OUT_DEFAULT_SIZE 1
 
@@ -34,7 +36,8 @@ static bool
 check_mgmt_seq_id_and_seg_len(struct hinic3_recv_msg *recv_msg, uint8_t seq_id,
 			      uint8_t seg_len, uint16_t msg_id)
 {
-	if (seq_id > MGMT_MSG_MAX_SEQ_ID || seg_len > SEGMENT_LEN)
+	if (seq_id > MGMT_MSG_MAX_SEQ_ID || seg_len > SEGMENT_LEN ||
+		(seq_id == MGMT_MSG_MAX_SEQ_ID && seg_len > MGMT_MSG_LAST_SEG_MAX_LEN))
 		return false;
 
 	if (seq_id == 0) {
diff --git a/drivers/net/hinic3/base/hinic3_mgmt.h b/drivers/net/hinic3/base/hinic3_mgmt.h
index f8148406d3..4e77b9bec4 100644
--- a/drivers/net/hinic3/base/hinic3_mgmt.h
+++ b/drivers/net/hinic3/base/hinic3_mgmt.h
@@ -70,6 +70,8 @@ typedef enum {
 #define HINIC3_TOE_RES	 (1 << RES_TYPE_TOE)
 #define HINIC3_IPSEC_RES (1 << RES_TYPE_IPSEC)
 
+#define HINIC3_MAX_FEATURE_QWORD 4
+
 struct hinic3_recv_msg {
 	void *msg;
 
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index c35fefdeac..0bee1ae3fc 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -48,6 +48,43 @@ static const struct vf_msg_handler vf_mag_cmd_handler[] = {
 	},
 };
 
+int
+hinic3_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod,
+			uint16_t cmd, void *buf_in, uint16_t in_size,
+			void *buf_out, uint16_t *out_size)
+{
+	uint32_t i;
+	bool cmd_to_pf = false;
+	struct hinic3_handler_info handler_info = {
+		.cmd = cmd,
+		.buf_in = buf_in,
+		.in_size = in_size,
+		.buf_out = buf_out,
+		.out_size = out_size,
+		.dst_func = HINIC3_MGMT_SRC_ID,
+		.direction = HINIC3_MSG_DIRECT_SEND,
+		.ack_type = HINIC3_MSG_ACK,
+	};
+
+	if (hinic3_func_type(hwdev) == TYPE_VF) {
+		if (mod == HINIC3_MOD_HILINK) {
+			for (i = 0; i < RTE_DIM(vf_mag_cmd_handler); i++) {
+				if (cmd == vf_mag_cmd_handler[i].cmd)
+					cmd_to_pf = true;
+			}
+		} else if (mod == HINIC3_MOD_L2NIC) {
+			for (i = 0; i < RTE_DIM(vf_cmd_handler); i++) {
+				if (cmd == vf_cmd_handler[i].cmd)
+					cmd_to_pf = true;
+			}
+		}
+	}
+	if (cmd_to_pf)
+		handler_info.dst_func = hinic3_pf_id_of_vf(hwdev);
+
+	return hinic3_send_mbox_to_mgmt(hwdev, mod, &handler_info, 0);
+}
+
 /**
  * Set CI table for a SQ.
  *
@@ -1712,43 +1749,6 @@ hinic3_set_rq_flush(struct hinic3_hwdev *hwdev, uint16_t q_id)
 	return err;
 }
 
-int
-hinic3_msg_to_mgmt_sync(struct hinic3_hwdev *hwdev, enum hinic3_mod_type mod,
-			uint16_t cmd, void *buf_in, uint16_t in_size,
-			void *buf_out, uint16_t *out_size)
-{
-	uint32_t i;
-	bool cmd_to_pf = false;
-	struct hinic3_handler_info handler_info = {
-		.cmd = cmd,
-		.buf_in = buf_in,
-		.in_size = in_size,
-		.buf_out = buf_out,
-		.out_size = out_size,
-		.dst_func = HINIC3_MGMT_SRC_ID,
-		.direction = HINIC3_MSG_DIRECT_SEND,
-		.ack_type = HINIC3_MSG_ACK,
-	};
-
-	if (hinic3_func_type(hwdev) == TYPE_VF) {
-		if (mod == HINIC3_MOD_HILINK) {
-			for (i = 0; i < RTE_DIM(vf_mag_cmd_handler); i++) {
-				if (cmd == vf_mag_cmd_handler[i].cmd)
-					cmd_to_pf = true;
-			}
-		} else if (mod == HINIC3_MOD_L2NIC) {
-			for (i = 0; i < RTE_DIM(vf_cmd_handler); i++) {
-				if (cmd == vf_cmd_handler[i].cmd)
-					cmd_to_pf = true;
-			}
-		}
-	}
-	if (cmd_to_pf)
-		handler_info.dst_func = hinic3_pf_id_of_vf(hwdev);
-
-	return hinic3_send_mbox_to_mgmt(hwdev, mod, &handler_info, 0);
-}
-
 int
 hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,
 			      enum hinic3_link_follow_status status)
diff --git a/drivers/net/hinic3/base/meson.build b/drivers/net/hinic3/base/meson.build
index 48ac7a47f5..30c0a1c9d6 100644
--- a/drivers/net/hinic3/base/meson.build
+++ b/drivers/net/hinic3/base/meson.build
@@ -2,6 +2,7 @@
 # Copyright(c) 2025 Huawei Technologies Co., Ltd
 
 base_sources = files(
+        'hinic3_cmdq_enhance.c'
         'hinic3_cmdq.c',
         'hinic3_eqs.c',
         'hinic3_hw_cfg.c',
-- 
2.45.1.windows.1

