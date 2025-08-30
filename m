Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D4ACA0FFD
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 Aug 2025 12:41:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6458040658;
	Sat, 30 Aug 2025 14:40:56 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 80ADC40151
 for <dev@dpdk.org>; Sat, 30 Aug 2025 14:40:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=0v1dGrYjJcEn9s4vPyd7kRcQsz4v1riv6zfBlSqC5g4=;
 b=iDee63R8eDOM/TcOJ8YiXeMKA8SPMRrIt/ienMQwyKEI/9vnjxYwASEFcvmsIr
 fgA/7xGJ1kcIa8ltI0xsogHKg97dvPBgdHiYwwdU9Kdb9BdNmn8M/W9u0cq0VyZ0
 wGYbTCm2oEEhEruLpTJ/Rj1hY/ZRsXxtevbdyHDvD4d0M=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgDHT8sf8bJohyfMAg--.4754S8;
 Sat, 30 Aug 2025 20:40:50 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Xin Wang <wangxin679@h-partners.com>,
 Feifei Wang <wangfeifei40@huawei.com>, Yi Chen <chenyi221@huawei.com>
Subject: [V5 04/18] net/hinic3: add support for cmdq mechanism
Date: Sat, 30 Aug 2025 20:39:16 +0800
Message-ID: <20250830123942.5037-5-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20250830123942.5037-1-wff_light@vip.163.com>
References: <20250418090621.9638-1-wff_light@vip.163.com>
 <20250830123942.5037-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDHT8sf8bJohyfMAg--.4754S8
X-Coremail-Antispam: 1Uf129KBjvAXoWfury8Zw1xKw1kCr4DWr15urg_yoW5uFW5Zo
 WfJ3y5tr1rtry8C3WDKF4IkF9rtw1DXFn8GayrXFWIqan7JF9aga47Ww4Fg3WrZFWayF17
 ZFW7Jw45Jw4UA3W8n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2rWrDUUUU
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiHw65Cmiy3h4h1gAAsP
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

From: Xin Wang <wangxin679@h-partners.com>=0D

Micocode is named ucode in SP series NIC. Its main responsibility is data=0D
transmission and reception. But it can also handle some administration=0D
works. It uses cmdq mechanism. This patch introduces data structures,=0D
initialization, interfaces, and commands sending functions of cmdq.=0D
=0D
Signed-off-by: Xin Wang <wangxin679@h-partners.com>=0D
Reviewed-by: Feifei Wang <wangfeifei40@huawei.com>=0D
Reviewed-by: Yi Chen <chenyi221@huawei.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_cmdq.c | 978 ++++++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_cmdq.h | 230 ++++++=0D
 2 files changed, 1208 insertions(+)=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.c=0D
 create mode 100644 drivers/net/hinic3/base/hinic3_cmdq.h=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_cmdq.c b/drivers/net/hinic3/bas=
e/hinic3_cmdq.c=0D
new file mode 100644=0D
index 0000000000..5b5c1da999=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_cmdq.c=0D
@@ -0,0 +1,978 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#include <rte_atomic.h>=0D
+#include <rte_mbuf.h>=0D
+=0D
+#include "hinic3_compat.h"=0D
+#include "hinic3_cmd.h"=0D
+#include "hinic3_cmdq.h"=0D
+#include "hinic3_hwdev.h"=0D
+#include "hinic3_hwif.h"=0D
+#include "hinic3_mgmt.h"=0D
+#include "hinic3_wq.h"=0D
+=0D
+#define CMDQ_CMD_TIMEOUT 5000 /**< Millisecond. */=0D
+=0D
+#define UPPER_8_BITS(data) (((data) >> 8) & 0xFF)=0D
+#define LOWER_8_BITS(data) ((data) & 0xFF)=0D
+=0D
+#define CMDQ_DB_INFO_HI_PROD_IDX_SHIFT 0=0D
+#define CMDQ_DB_INFO_HI_PROD_IDX_MASK  0xFFU=0D
+=0D
+#define CMDQ_DB_INFO_SET(val, member)                  \=0D
+	((((u32)(val)) & CMDQ_DB_INFO_##member##_MASK) \=0D
+	 << CMDQ_DB_INFO_##member##_SHIFT)=0D
+#define CMDQ_DB_INFO_UPPER_32(val) ((u64)(val) << 32)=0D
+=0D
+#define CMDQ_DB_HEAD_QUEUE_TYPE_SHIFT 23=0D
+#define CMDQ_DB_HEAD_CMDQ_TYPE_SHIFT  24=0D
+#define CMDQ_DB_HEAD_SRC_TYPE_SHIFT   27=0D
+#define CMDQ_DB_HEAD_QUEUE_TYPE_MASK  0x1U=0D
+#define CMDQ_DB_HEAD_CMDQ_TYPE_MASK   0x7U=0D
+#define CMDQ_DB_HEAD_SRC_TYPE_MASK    0x1FU=0D
+#define CMDQ_DB_HEAD_SET(val, member)                  \=0D
+	((((u32)(val)) & CMDQ_DB_HEAD_##member##_MASK) \=0D
+	 << CMDQ_DB_HEAD_##member##_SHIFT)=0D
+=0D
+#define CMDQ_CTRL_PI_SHIFT	    0=0D
+#define CMDQ_CTRL_CMD_SHIFT	    16=0D
+#define CMDQ_CTRL_MOD_SHIFT	    24=0D
+#define CMDQ_CTRL_ACK_TYPE_SHIFT    29=0D
+#define CMDQ_CTRL_HW_BUSY_BIT_SHIFT 31=0D
+=0D
+#define CMDQ_CTRL_PI_MASK	   0xFFFFU=0D
+#define CMDQ_CTRL_CMD_MASK	   0xFFU=0D
+#define CMDQ_CTRL_MOD_MASK	   0x1FU=0D
+#define CMDQ_CTRL_ACK_TYPE_MASK	   0x3U=0D
+#define CMDQ_CTRL_HW_BUSY_BIT_MASK 0x1U=0D
+=0D
+#define CMDQ_CTRL_SET(val, member) \=0D
+	(((u32)(val) & CMDQ_CTRL_##member##_MASK) << CMDQ_CTRL_##member##_SHIFT)=
=0D
+=0D
+#define CMDQ_CTRL_GET(val, member) \=0D
+	(((val) >> CMDQ_CTRL_##member##_SHIFT) & CMDQ_CTRL_##member##_MASK)=0D
+=0D
+#define CMDQ_WQE_HEADER_BUFDESC_LEN_SHIFT	0=0D
+#define CMDQ_WQE_HEADER_COMPLETE_FMT_SHIFT	15=0D
+#define CMDQ_WQE_HEADER_DATA_FMT_SHIFT		22=0D
+#define CMDQ_WQE_HEADER_COMPLETE_REQ_SHIFT	23=0D
+#define CMDQ_WQE_HEADER_COMPLETE_SECT_LEN_SHIFT 27=0D
+#define CMDQ_WQE_HEADER_CTRL_LEN_SHIFT		29=0D
+#define CMDQ_WQE_HEADER_HW_BUSY_BIT_SHIFT	31=0D
+=0D
+#define CMDQ_WQE_HEADER_BUFDESC_LEN_MASK       0xFFU=0D
+#define CMDQ_WQE_HEADER_COMPLETE_FMT_MASK      0x1U=0D
+#define CMDQ_WQE_HEADER_DATA_FMT_MASK	       0x1U=0D
+#define CMDQ_WQE_HEADER_COMPLETE_REQ_MASK      0x1U=0D
+#define CMDQ_WQE_HEADER_COMPLETE_SECT_LEN_MASK 0x3U=0D
+#define CMDQ_WQE_HEADER_CTRL_LEN_MASK	       0x3U=0D
+#define CMDQ_WQE_HEADER_HW_BUSY_BIT_MASK       0x1U=0D
+=0D
+#define CMDQ_WQE_HEADER_SET(val, member)                \=0D
+	(((u32)(val) & CMDQ_WQE_HEADER_##member##_MASK) \=0D
+	 << CMDQ_WQE_HEADER_##member##_SHIFT)=0D
+=0D
+#define CMDQ_WQE_HEADER_GET(val, member)               \=0D
+	(((val) >> CMDQ_WQE_HEADER_##member##_SHIFT) & \=0D
+	 CMDQ_WQE_HEADER_##member##_MASK)=0D
+=0D
+#define CMDQ_CTXT_CURR_WQE_PAGE_PFN_SHIFT 0=0D
+#define CMDQ_CTXT_EQ_ID_SHIFT		  53=0D
+#define CMDQ_CTXT_CEQ_ARM_SHIFT		  61=0D
+#define CMDQ_CTXT_CEQ_EN_SHIFT		  62=0D
+#define CMDQ_CTXT_HW_BUSY_BIT_SHIFT	  63=0D
+=0D
+#define CMDQ_CTXT_CURR_WQE_PAGE_PFN_MASK 0xFFFFFFFFFFFFF=0D
+#define CMDQ_CTXT_EQ_ID_MASK		 0xFF=0D
+#define CMDQ_CTXT_CEQ_ARM_MASK		 0x1=0D
+#define CMDQ_CTXT_CEQ_EN_MASK		 0x1=0D
+#define CMDQ_CTXT_HW_BUSY_BIT_MASK	 0x1=0D
+=0D
+#define CMDQ_CTXT_PAGE_INFO_SET(val, member) \=0D
+	(((u64)(val) & CMDQ_CTXT_##member##_MASK) << CMDQ_CTXT_##member##_SHIFT)=
=0D
+=0D
+#define CMDQ_CTXT_WQ_BLOCK_PFN_SHIFT 0=0D
+#define CMDQ_CTXT_CI_SHIFT	     52=0D
+=0D
+#define CMDQ_CTXT_WQ_BLOCK_PFN_MASK 0xFFFFFFFFFFFFF=0D
+#define CMDQ_CTXT_CI_MASK	    0xFFF=0D
+=0D
+#define CMDQ_CTXT_BLOCK_INFO_SET(val, member) \=0D
+	(((u64)(val) & CMDQ_CTXT_##member##_MASK) << CMDQ_CTXT_##member##_SHIFT)=
=0D
+=0D
+#define SAVED_DATA_ARM_SHIFT 31=0D
+=0D
+#define SAVED_DATA_ARM_MASK 0x1U=0D
+=0D
+#define SAVED_DATA_SET(val, member) \=0D
+	(((val) & SAVED_DATA_##member##_MASK) << SAVED_DATA_##member##_SHIFT)=0D
+=0D
+#define SAVED_DATA_CLEAR(val, member) \=0D
+	((val) & (~(SAVED_DATA_##member##_MASK << SAVED_DATA_##member##_SHIFT)))=
=0D
+=0D
+#define WQE_ERRCODE_VAL_SHIFT 0=0D
+=0D
+#define WQE_ERRCODE_VAL_MASK 0x7FFFFFFF=0D
+=0D
+#define WQE_ERRCODE_GET(val, member) \=0D
+	(((val) >> WQE_ERRCODE_##member##_SHIFT) & WQE_ERRCODE_##member##_MASK)=0D
+=0D
+#define WQE_COMPLETED(ctrl_info) CMDQ_CTRL_GET(ctrl_info, HW_BUSY_BIT)=0D
+=0D
+#define WQE_HEADER(wqe) ((struct hinic3_cmdq_header *)(wqe))=0D
+=0D
+#define CMDQ_DB_PI_OFF(pi) (((u16)LOWER_8_BITS(pi)) << 3)=0D
+=0D
+#define CMDQ_DB_ADDR(db_base, pi) (((u8 *)(db_base)) + CMDQ_DB_PI_OFF(pi))=
=0D
+=0D
+#define CMDQ_PFN(addr, page_size) ((addr) >> (ilog2(page_size)))=0D
+=0D
+#define FIRST_DATA_TO_WRITE_LAST sizeof(u64)=0D
+=0D
+#define WQE_LCMD_SIZE 64=0D
+#define WQE_SCMD_SIZE 64=0D
+=0D
+#define COMPLETE_LEN 3=0D
+=0D
+#define CMDQ_WQEBB_SIZE	 64=0D
+#define CMDQ_WQEBB_SHIFT 6=0D
+=0D
+#define CMDQ_WQE_SIZE 64=0D
+=0D
+#define HINIC3_CMDQ_WQ_BUF_SIZE 4096=0D
+=0D
+#define WQE_NUM_WQEBBS(wqe_size, wq)                                 \=0D
+	({                                                           \=0D
+		typeof(wq) __wq =3D (wq);                              \=0D
+		(u16)(RTE_ALIGN((u32)(wqe_size), __wq->wqebb_size) / \=0D
+		      __wq->wqebb_size);                             \=0D
+	})=0D
+=0D
+#define cmdq_to_cmdqs(cmdq)                                               =
    \=0D
+	({                                                                    \=0D
+		typeof(cmdq) __cmdq =3D (cmdq);                                 \=0D
+		container_of(__cmdq - __cmdq->cmdq_type, struct hinic3_cmdqs, \=0D
+			     __cmdq[0]);                                      \=0D
+	})=0D
+=0D
+#define WAIT_CMDQ_ENABLE_TIMEOUT 300=0D
+=0D
+static int hinic3_cmdq_poll_msg(struct hinic3_cmdq *cmdq, u32 timeout);=0D
+=0D
+bool=0D
+hinic3_cmdq_idle(struct hinic3_cmdq *cmdq)=0D
+{=0D
+	struct hinic3_wq *wq =3D cmdq->wq;=0D
+=0D
+	return rte_atomic_load_explicit(&wq->delta, rte_memory_order_seq_cst) =3D=
=3D=0D
+	       wq->q_depth;=0D
+}=0D
+=0D
+struct hinic3_cmd_buf *=0D
+hinic3_alloc_cmd_buf(void *hwdev)=0D
+{=0D
+	struct hinic3_cmdqs *cmdqs =3D ((struct hinic3_hwdev *)hwdev)->cmdqs;=0D
+	struct hinic3_cmd_buf *cmd_buf;=0D
+=0D
+	cmd_buf =3D rte_zmalloc(NULL, sizeof(*cmd_buf), 0);=0D
+	if (!cmd_buf) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmd buffer failed");=0D
+		return NULL;=0D
+	}=0D
+=0D
+	cmd_buf->mbuf =3D rte_pktmbuf_alloc(cmdqs->cmd_buf_pool);=0D
+	if (!cmd_buf->mbuf) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmd from the pool failed");=0D
+		goto alloc_pci_buf_err;=0D
+	}=0D
+=0D
+	cmd_buf->dma_addr =3D rte_mbuf_data_iova(cmd_buf->mbuf);=0D
+	cmd_buf->buf =3D rte_pktmbuf_mtod(cmd_buf->mbuf, void *);=0D
+=0D
+	return cmd_buf;=0D
+=0D
+alloc_pci_buf_err:=0D
+	rte_free(cmd_buf);=0D
+	return NULL;=0D
+}=0D
+=0D
+void=0D
+hinic3_free_cmd_buf(struct hinic3_cmd_buf *cmd_buf)=0D
+{=0D
+	rte_pktmbuf_free(cmd_buf->mbuf);=0D
+=0D
+	rte_free(cmd_buf);=0D
+}=0D
+=0D
+static u32=0D
+cmdq_wqe_size(enum cmdq_wqe_type wqe_type)=0D
+{=0D
+	u32 wqe_size =3D 0;=0D
+=0D
+	switch (wqe_type) {=0D
+	case WQE_LCMD_TYPE:=0D
+		wqe_size =3D WQE_LCMD_SIZE;=0D
+		break;=0D
+	case WQE_SCMD_TYPE:=0D
+		wqe_size =3D WQE_SCMD_SIZE;=0D
+		break;=0D
+	default:=0D
+		break;=0D
+	}=0D
+=0D
+	return wqe_size;=0D
+}=0D
+=0D
+static int=0D
+cmdq_get_wqe_size(enum bufdesc_len len)=0D
+{=0D
+	int wqe_size =3D 0;=0D
+=0D
+	switch (len) {=0D
+	case BUFDESC_LCMD_LEN:=0D
+		wqe_size =3D WQE_LCMD_SIZE;=0D
+		break;=0D
+	case BUFDESC_SCMD_LEN:=0D
+		wqe_size =3D WQE_SCMD_SIZE;=0D
+		break;=0D
+	default:=0D
+		break;=0D
+	}=0D
+=0D
+	return wqe_size;=0D
+}=0D
+=0D
+static void=0D
+cmdq_set_completion(struct hinic3_cmdq_completion *complete,=0D
+		    struct hinic3_cmd_buf *buf_out)=0D
+{=0D
+	struct hinic3_sge_resp *sge_resp =3D &complete->sge_resp;=0D
+=0D
+	hinic3_set_sge(&sge_resp->sge, buf_out->dma_addr, HINIC3_CMDQ_BUF_SIZE);=
=0D
+}=0D
+=0D
+static void=0D
+cmdq_set_lcmd_bufdesc(struct hinic3_cmdq_wqe_lcmd *wqe,=0D
+		      struct hinic3_cmd_buf *buf_in)=0D
+{=0D
+	hinic3_set_sge(&wqe->buf_desc.sge, buf_in->dma_addr, buf_in->size);=0D
+}=0D
+=0D
+static void=0D
+cmdq_set_db(struct hinic3_cmdq *cmdq, enum hinic3_cmdq_type cmdq_type,=0D
+	    u16 prod_idx)=0D
+{=0D
+	u64 db =3D 0;=0D
+=0D
+	/* Hardware will do endianness converting. */=0D
+	db =3D CMDQ_DB_INFO_SET(UPPER_8_BITS(prod_idx), HI_PROD_IDX);=0D
+	db =3D CMDQ_DB_INFO_UPPER_32(db) |=0D
+	     CMDQ_DB_HEAD_SET(HINIC3_DB_CMDQ_TYPE, QUEUE_TYPE) |=0D
+	     CMDQ_DB_HEAD_SET(cmdq_type, CMDQ_TYPE) |=0D
+	     CMDQ_DB_HEAD_SET(HINIC3_DB_SRC_CMDQ_TYPE, SRC_TYPE);=0D
+=0D
+	/**< Write all before the doorbell. */=0D
+	rte_atomic_thread_fence(rte_memory_order_release);=0D
+=0D
+	rte_write64(db, CMDQ_DB_ADDR(cmdq->db_base, prod_idx));=0D
+}=0D
+=0D
+static void=0D
+cmdq_wqe_fill(void *dst, void *src)=0D
+{=0D
+	memcpy((void *)((u8 *)dst + FIRST_DATA_TO_WRITE_LAST),=0D
+	       (void *)((u8 *)src + FIRST_DATA_TO_WRITE_LAST),=0D
+	       CMDQ_WQE_SIZE - FIRST_DATA_TO_WRITE_LAST);=0D
+=0D
+	/* The first 8 bytes should be written last. */=0D
+	rte_atomic_thread_fence(rte_memory_order_release);=0D
+=0D
+	*(u64 *)dst =3D *(u64 *)src;=0D
+}=0D
+=0D
+static void=0D
+cmdq_prepare_wqe_ctrl(struct hinic3_cmdq_wqe *wqe, int wrapped,=0D
+		      enum hinic3_mod_type mod, u8 cmd, u16 prod_idx,=0D
+		      enum completion_format complete_format,=0D
+		      enum data_format local_data_format,=0D
+		      enum bufdesc_len buf_len)=0D
+{=0D
+	struct hinic3_ctrl *ctrl =3D NULL;=0D
+	enum ctrl_sect_len ctrl_len;=0D
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd =3D NULL;=0D
+	struct hinic3_cmdq_wqe_scmd *wqe_scmd =3D NULL;=0D
+	u32 saved_data =3D WQE_HEADER(wqe)->saved_data;=0D
+=0D
+	if (local_data_format =3D=3D DATA_SGE) {=0D
+		wqe_lcmd =3D &wqe->wqe_lcmd;=0D
+=0D
+		wqe_lcmd->status.status_info =3D 0;=0D
+		ctrl =3D &wqe_lcmd->ctrl;=0D
+		ctrl_len =3D CTRL_SECT_LEN;=0D
+	} else {=0D
+		wqe_scmd =3D &wqe->inline_wqe.wqe_scmd;=0D
+=0D
+		wqe_scmd->status.status_info =3D 0;=0D
+		ctrl =3D &wqe_scmd->ctrl;=0D
+		ctrl_len =3D CTRL_DIRECT_SECT_LEN;=0D
+	}=0D
+=0D
+	ctrl->ctrl_info =3D CMDQ_CTRL_SET(prod_idx, PI) |=0D
+			  CMDQ_CTRL_SET(cmd, CMD) | CMDQ_CTRL_SET(mod, MOD) |=0D
+			  CMDQ_CTRL_SET(HINIC3_ACK_TYPE_CMDQ, ACK_TYPE);=0D
+=0D
+	WQE_HEADER(wqe)->header_info =3D=0D
+		CMDQ_WQE_HEADER_SET(buf_len, BUFDESC_LEN) |=0D
+		CMDQ_WQE_HEADER_SET(complete_format, COMPLETE_FMT) |=0D
+		CMDQ_WQE_HEADER_SET(local_data_format, DATA_FMT) |=0D
+		CMDQ_WQE_HEADER_SET(CEQ_SET, COMPLETE_REQ) |=0D
+		CMDQ_WQE_HEADER_SET(COMPLETE_LEN, COMPLETE_SECT_LEN) |=0D
+		CMDQ_WQE_HEADER_SET(ctrl_len, CTRL_LEN) |=0D
+		CMDQ_WQE_HEADER_SET((u32)wrapped, HW_BUSY_BIT);=0D
+=0D
+	saved_data &=3D SAVED_DATA_CLEAR(saved_data, ARM);=0D
+	if (cmd =3D=3D CMDQ_SET_ARM_CMD && mod =3D=3D HINIC3_MOD_COMM)=0D
+		WQE_HEADER(wqe)->saved_data =3D saved_data |=0D
+					      SAVED_DATA_SET(1, ARM);=0D
+	else=0D
+		WQE_HEADER(wqe)->saved_data =3D saved_data;=0D
+}=0D
+=0D
+static void=0D
+cmdq_set_lcmd_wqe(struct hinic3_cmdq_wqe *wqe, enum cmdq_cmd_type cmd_type=
,=0D
+		  struct hinic3_cmd_buf *buf_in, struct hinic3_cmd_buf *buf_out,=0D
+		  int wrapped, enum hinic3_mod_type mod, u8 cmd, u16 prod_idx)=0D
+{=0D
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd =3D &wqe->wqe_lcmd;=0D
+	enum completion_format complete_format =3D COMPLETE_DIRECT;=0D
+=0D
+	switch (cmd_type) {=0D
+	case SYNC_CMD_DIRECT_RESP:=0D
+		complete_format =3D COMPLETE_DIRECT;=0D
+		wqe_lcmd->completion.direct_resp =3D 0;=0D
+		break;=0D
+	case SYNC_CMD_SGE_RESP:=0D
+		if (buf_out) {=0D
+			complete_format =3D COMPLETE_SGE;=0D
+			cmdq_set_completion(&wqe_lcmd->completion, buf_out);=0D
+		}=0D
+		break;=0D
+	case ASYNC_CMD:=0D
+		complete_format =3D COMPLETE_DIRECT;=0D
+		wqe_lcmd->completion.direct_resp =3D 0;=0D
+		wqe_lcmd->buf_desc.saved_async_buf =3D (u64)(buf_in);=0D
+		break;=0D
+	default:=0D
+		break;=0D
+	}=0D
+=0D
+	cmdq_prepare_wqe_ctrl(wqe, wrapped, mod, cmd, prod_idx, complete_format,=
=0D
+			      DATA_SGE, BUFDESC_LCMD_LEN);=0D
+=0D
+	cmdq_set_lcmd_bufdesc(wqe_lcmd, buf_in);=0D
+}=0D
+=0D
+/**=0D
+ * Prepare necessary context for command queue, send a synchronous command=
 with=0D
+ * a direct response to hardware. It waits for completion of command by po=
lling=0D
+ * command queue for a response.=0D
+ *=0D
+ * @param[in] cmdq=0D
+ * The command queue object that represents the queue to send the command =
to.=0D
+ * @param[in] mod=0D
+ * The module type that the command belongs to.=0D
+ * @param[in] cmd=0D
+ * The command to be executed.=0D
+ * @param[in] buf_in=0D
+ * The input buffer containing the command parameters.=0D
+ * @param[out] out_param=0D
+ * A pointer to the location where the response data will be stored, if=0D
+ * available.=0D
+ * @param[in] timeout=0D
+ * The timeout value (ms) to wait for the command completion. If zero, a d=
efault=0D
+ * timeout will be used.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - -EBUSY: The command queue is busy.=0D
+ * - -ETIMEDOUT: The command did not complete within the specified timeout=
.=0D
+ */=0D
+static int=0D
+cmdq_sync_cmd_direct_resp(struct hinic3_cmdq *cmdq, enum hinic3_mod_type m=
od,=0D
+			  u8 cmd, struct hinic3_cmd_buf *buf_in, u64 *out_param,=0D
+			  u32 timeout)=0D
+{=0D
+	struct hinic3_wq *wq =3D cmdq->wq;=0D
+	struct hinic3_cmdq_wqe wqe;=0D
+	struct hinic3_cmdq_wqe *curr_wqe =3D NULL;=0D
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd =3D NULL;=0D
+	u16 curr_prod_idx, next_prod_idx, num_wqebbs;=0D
+	int wrapped;=0D
+	u32 timeo, wqe_size;=0D
+	int err;=0D
+=0D
+	wqe_size =3D cmdq_wqe_size(WQE_LCMD_TYPE);=0D
+	num_wqebbs =3D WQE_NUM_WQEBBS(wqe_size, wq);=0D
+=0D
+	/* Keep wrapped and doorbell index correct. */=0D
+	rte_spinlock_lock(&cmdq->cmdq_lock);=0D
+=0D
+	curr_wqe =3D hinic3_get_wqe(cmdq->wq, num_wqebbs, &curr_prod_idx);=0D
+	if (!curr_wqe) {=0D
+		err =3D -EBUSY;=0D
+		goto cmdq_unlock;=0D
+	}=0D
+=0D
+	memset(&wqe, 0, sizeof(wqe));=0D
+	wrapped =3D cmdq->wrapped;=0D
+=0D
+	next_prod_idx =3D curr_prod_idx + num_wqebbs;=0D
+	if (next_prod_idx >=3D wq->q_depth) {=0D
+		cmdq->wrapped =3D !cmdq->wrapped;=0D
+		next_prod_idx -=3D wq->q_depth;=0D
+	}=0D
+=0D
+	cmdq_set_lcmd_wqe(&wqe, SYNC_CMD_DIRECT_RESP, buf_in, NULL, wrapped,=0D
+			  mod, cmd, curr_prod_idx);=0D
+=0D
+	/* The data that is written to HW should be in Big Endian Format. */=0D
+	hinic3_hw_be32_len(&wqe, (int)wqe_size);=0D
+=0D
+	/* Cmdq wqe is not shadow, therefore wqe will be written to wq. */=0D
+	cmdq_wqe_fill(curr_wqe, &wqe);=0D
+=0D
+	cmdq->cmd_infos[curr_prod_idx].cmd_type =3D HINIC3_CMD_TYPE_DIRECT_RESP;=
=0D
+=0D
+	cmdq_set_db(cmdq, HINIC3_CMDQ_SYNC, next_prod_idx);=0D
+=0D
+	timeo =3D msecs_to_jiffies(timeout ? timeout : CMDQ_CMD_TIMEOUT);=0D
+	err =3D hinic3_cmdq_poll_msg(cmdq, timeo);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Cmdq poll msg ack failed, prod idx: 0x%x",=0D
+			    curr_prod_idx);=0D
+		err =3D -ETIMEDOUT;=0D
+		goto cmdq_unlock;=0D
+	}=0D
+=0D
+	rte_smp_rmb(); /**< Read error code after completion. */=0D
+=0D
+	if (out_param) {=0D
+		wqe_lcmd =3D &curr_wqe->wqe_lcmd;=0D
+		*out_param =3D cpu_to_be64(wqe_lcmd->completion.direct_resp);=0D
+	}=0D
+=0D
+	if (cmdq->errcode[curr_prod_idx])=0D
+		err =3D cmdq->errcode[curr_prod_idx];=0D
+=0D
+cmdq_unlock:=0D
+	rte_spinlock_unlock(&cmdq->cmdq_lock);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+/**=0D
+ * Send a synchronous command with detailed response and wait for the=0D
+ * completion.=0D
+ *=0D
+ * @param[in] cmdq=0D
+ * The command queue object representing the queue to send the command to.=
=0D
+ * @param[in] mod=0D
+ * The module type that the command belongs to.=0D
+ * @param[in] cmd=0D
+ * The command to be executed.=0D
+ * @param[in] buf_in=0D
+ * The input buffer containing the parameters for the command.=0D
+ * @param[out] buf_out=0D
+ * The output buffer where the detailed response from the hardware will be=
=0D
+ * stored.=0D
+ * @param[in] timeout=0D
+ * The timeout value (ms) to wait for the command completion. If zero, a d=
efault=0D
+ * timeout will be used.=0D
+ *=0D
+ * @return=0D
+ * 0 on success, non-zero on failure.=0D
+ * - -EBUSY: The command queue is busy.=0D
+ * - -ETIMEDOUT: The command did not complete within the specified timeout=
.=0D
+ */=0D
+static int=0D
+cmdq_sync_cmd_detail_resp(struct hinic3_cmdq *cmdq, enum hinic3_mod_type m=
od,=0D
+			  u8 cmd, struct hinic3_cmd_buf *buf_in,=0D
+			  struct hinic3_cmd_buf *buf_out, u32 timeout)=0D
+{=0D
+	struct hinic3_wq *wq =3D cmdq->wq;=0D
+	struct hinic3_cmdq_wqe wqe;=0D
+	struct hinic3_cmdq_wqe *curr_wqe =3D NULL;=0D
+	u16 curr_prod_idx, next_prod_idx, num_wqebbs;=0D
+	int wrapped;=0D
+	u32 timeo, wqe_size;=0D
+	int err;=0D
+=0D
+	wqe_size =3D cmdq_wqe_size(WQE_LCMD_TYPE);=0D
+	num_wqebbs =3D WQE_NUM_WQEBBS(wqe_size, wq);=0D
+=0D
+	/* Keep wrapped and doorbell index correct. */=0D
+	rte_spinlock_lock(&cmdq->cmdq_lock);=0D
+=0D
+	curr_wqe =3D hinic3_get_wqe(cmdq->wq, num_wqebbs, &curr_prod_idx);=0D
+	if (!curr_wqe) {=0D
+		err =3D -EBUSY;=0D
+		goto cmdq_unlock;=0D
+	}=0D
+=0D
+	memset(&wqe, 0, sizeof(wqe));=0D
+	wrapped =3D cmdq->wrapped;=0D
+=0D
+	next_prod_idx =3D curr_prod_idx + num_wqebbs;=0D
+	if (next_prod_idx >=3D wq->q_depth) {=0D
+		cmdq->wrapped =3D !cmdq->wrapped;=0D
+		next_prod_idx -=3D wq->q_depth;=0D
+	}=0D
+=0D
+	cmdq_set_lcmd_wqe(&wqe, SYNC_CMD_SGE_RESP, buf_in, buf_out, wrapped,=0D
+			  mod, cmd, curr_prod_idx);=0D
+=0D
+	/* The data that is written to HW should be in Big Endian Format. */=0D
+	hinic3_hw_be32_len(&wqe, (int)wqe_size);=0D
+=0D
+	/* Cmdq wqe is not shadow, therefore wqe will be written to wq. */=0D
+	cmdq_wqe_fill(curr_wqe, &wqe);=0D
+=0D
+	cmdq->cmd_infos[curr_prod_idx].cmd_type =3D HINIC3_CMD_TYPE_SGE_RESP;=0D
+=0D
+	cmdq_set_db(cmdq, cmdq->cmdq_type, next_prod_idx);=0D
+=0D
+	timeo =3D msecs_to_jiffies(timeout ? timeout : CMDQ_CMD_TIMEOUT);=0D
+	err =3D hinic3_cmdq_poll_msg(cmdq, timeo);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Cmdq poll msg ack failed, prod idx: 0x%x",=0D
+			    curr_prod_idx);=0D
+		err =3D -ETIMEDOUT;=0D
+		goto cmdq_unlock;=0D
+	}=0D
+=0D
+	rte_smp_rmb(); /**< Read error code after completion. */=0D
+=0D
+	if (cmdq->errcode[curr_prod_idx])=0D
+		err =3D cmdq->errcode[curr_prod_idx];=0D
+=0D
+cmdq_unlock:=0D
+	rte_spinlock_unlock(&cmdq->cmdq_lock);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static int=0D
+cmdq_params_valid(void *hwdev, struct hinic3_cmd_buf *buf_in)=0D
+{=0D
+	if (!buf_in || !hwdev) {=0D
+		PMD_DRV_LOG(ERR, "Invalid CMDQ buffer or hwdev is NULL");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	if (buf_in->size =3D=3D 0 || buf_in->size > HINIC3_CMDQ_BUF_SIZE) {=0D
+		PMD_DRV_LOG(ERR, "Invalid CMDQ buffer size: 0x%x",=0D
+			    buf_in->size);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+static int=0D
+wait_cmdqs_enable(struct hinic3_cmdqs *cmdqs)=0D
+{=0D
+	unsigned long end;=0D
+=0D
+	end =3D jiffies + msecs_to_jiffies(WAIT_CMDQ_ENABLE_TIMEOUT);=0D
+	do {=0D
+		if (cmdqs->status & HINIC3_CMDQ_ENABLE)=0D
+			return 0;=0D
+	} while (time_before(jiffies, end));=0D
+=0D
+	return -EBUSY;=0D
+}=0D
+=0D
+int=0D
+hinic3_cmdq_direct_resp(void *hwdev, enum hinic3_mod_type mod, u8 cmd,=0D
+			struct hinic3_cmd_buf *buf_in, u64 *out_param,=0D
+			u32 timeout)=0D
+{=0D
+	struct hinic3_cmdqs *cmdqs =3D ((struct hinic3_hwdev *)hwdev)->cmdqs;=0D
+	int err;=0D
+=0D
+	err =3D cmdq_params_valid(hwdev, buf_in);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Invalid cmdq parameters");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D wait_cmdqs_enable(cmdqs);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Cmdq is disabled");=0D
+		return err;=0D
+	}=0D
+=0D
+	return cmdq_sync_cmd_direct_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod,=0D
+					 cmd, buf_in, out_param, timeout);=0D
+}=0D
+=0D
+int=0D
+hinic3_cmdq_detail_resp(void *hwdev, enum hinic3_mod_type mod, u8 cmd,=0D
+			struct hinic3_cmd_buf *buf_in,=0D
+			struct hinic3_cmd_buf *buf_out, u32 timeout)=0D
+{=0D
+	struct hinic3_cmdqs *cmdqs =3D ((struct hinic3_hwdev *)hwdev)->cmdqs;=0D
+	int err;=0D
+=0D
+	err =3D cmdq_params_valid(hwdev, buf_in);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Invalid cmdq parameters");=0D
+		return err;=0D
+	}=0D
+=0D
+	err =3D wait_cmdqs_enable(cmdqs);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Cmdq is disabled");=0D
+		return err;=0D
+	}=0D
+=0D
+	return cmdq_sync_cmd_detail_resp(&cmdqs->cmdq[HINIC3_CMDQ_SYNC], mod,=0D
+					 cmd, buf_in, buf_out, timeout);=0D
+}=0D
+=0D
+static void=0D
+cmdq_update_errcode(struct hinic3_cmdq *cmdq, u16 prod_idx, int errcode)=0D
+{=0D
+	cmdq->errcode[prod_idx] =3D errcode;=0D
+}=0D
+=0D
+static void=0D
+clear_wqe_complete_bit(struct hinic3_cmdq *cmdq, struct hinic3_cmdq_wqe *w=
qe)=0D
+{=0D
+	struct hinic3_ctrl *ctrl =3D NULL;=0D
+	u32 header_info =3D hinic3_hw_cpu32(WQE_HEADER(wqe)->header_info);=0D
+	int buf_len =3D CMDQ_WQE_HEADER_GET(header_info, BUFDESC_LEN);=0D
+	int wqe_size =3D cmdq_get_wqe_size(buf_len);=0D
+	u16 num_wqebbs;=0D
+=0D
+	if (wqe_size =3D=3D WQE_LCMD_SIZE)=0D
+		ctrl =3D &wqe->wqe_lcmd.ctrl;=0D
+	else=0D
+		ctrl =3D &wqe->inline_wqe.wqe_scmd.ctrl;=0D
+=0D
+	/* Clear HW busy bit. */=0D
+	ctrl->ctrl_info =3D 0;=0D
+=0D
+	rte_atomic_thread_fence(rte_memory_order_release); /**< Verify wqe is cle=
ared. */=0D
+=0D
+	num_wqebbs =3D WQE_NUM_WQEBBS(wqe_size, cmdq->wq);=0D
+	hinic3_put_wqe(cmdq->wq, num_wqebbs);=0D
+}=0D
+=0D
+static void=0D
+cmdq_init_queue_ctxt(struct hinic3_cmdq *cmdq,=0D
+		     struct hinic3_cmdq_ctxt_info *ctxt_info)=0D
+{=0D
+	struct hinic3_wq *wq =3D cmdq->wq;=0D
+	u64 wq_first_page_paddr, pfn;=0D
+=0D
+	u16 start_ci =3D (u16)(wq->cons_idx);=0D
+=0D
+	/* The data in the HW is in Big Endian Format. */=0D
+	wq_first_page_paddr =3D wq->queue_buf_paddr;=0D
+=0D
+	pfn =3D CMDQ_PFN(wq_first_page_paddr, RTE_PGSIZE_4K);=0D
+	ctxt_info->curr_wqe_page_pfn =3D=0D
+		CMDQ_CTXT_PAGE_INFO_SET(1, HW_BUSY_BIT) |=0D
+		CMDQ_CTXT_PAGE_INFO_SET(0, CEQ_EN) |=0D
+		CMDQ_CTXT_PAGE_INFO_SET(0, CEQ_ARM) |=0D
+		CMDQ_CTXT_PAGE_INFO_SET(HINIC3_CEQ_ID_CMDQ, EQ_ID) |=0D
+		CMDQ_CTXT_PAGE_INFO_SET(pfn, CURR_WQE_PAGE_PFN);=0D
+=0D
+	ctxt_info->wq_block_pfn =3D CMDQ_CTXT_BLOCK_INFO_SET(start_ci, CI) |=0D
+				  CMDQ_CTXT_BLOCK_INFO_SET(pfn, WQ_BLOCK_PFN);=0D
+}=0D
+=0D
+static int=0D
+init_cmdq(struct hinic3_cmdq *cmdq, struct hinic3_hwdev *hwdev,=0D
+	  struct hinic3_wq *wq, enum hinic3_cmdq_type q_type)=0D
+{=0D
+	int err =3D 0;=0D
+	size_t errcode_size;=0D
+	size_t cmd_infos_size;=0D
+=0D
+	cmdq->wq =3D wq;=0D
+	cmdq->cmdq_type =3D q_type;=0D
+	cmdq->wrapped =3D 1;=0D
+=0D
+	rte_spinlock_init(&cmdq->cmdq_lock);=0D
+=0D
+	errcode_size =3D wq->q_depth * sizeof(*cmdq->errcode);=0D
+	cmdq->errcode =3D rte_zmalloc(NULL, errcode_size, 0);=0D
+	if (!cmdq->errcode) {=0D
+		PMD_DRV_LOG(ERR, "Allocate errcode for cmdq failed");=0D
+		return -ENOMEM;=0D
+	}=0D
+=0D
+	cmd_infos_size =3D wq->q_depth * sizeof(*cmdq->cmd_infos);=0D
+	cmdq->cmd_infos =3D rte_zmalloc(NULL, cmd_infos_size, 0);=0D
+	if (!cmdq->cmd_infos) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmd info for cmdq failed");=0D
+		err =3D -ENOMEM;=0D
+		goto cmd_infos_err;=0D
+	}=0D
+=0D
+	cmdq->db_base =3D hwdev->cmdqs->cmdqs_db_base;=0D
+=0D
+	return 0;=0D
+=0D
+cmd_infos_err:=0D
+	rte_free(cmdq->errcode);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+static void=0D
+free_cmdq(struct hinic3_cmdq *cmdq)=0D
+{=0D
+	rte_free(cmdq->cmd_infos);=0D
+	rte_free(cmdq->errcode);=0D
+}=0D
+=0D
+static int=0D
+hinic3_set_cmdq_ctxts(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_cmdqs *cmdqs =3D hwdev->cmdqs;=0D
+	struct hinic3_cmd_cmdq_ctxt cmdq_ctxt;=0D
+	enum hinic3_cmdq_type cmdq_type;=0D
+	u16 out_size =3D sizeof(cmdq_ctxt);=0D
+	int err;=0D
+=0D
+	cmdq_type =3D HINIC3_CMDQ_SYNC;=0D
+	for (; cmdq_type < HINIC3_MAX_CMDQ_TYPES; cmdq_type++) {=0D
+		memset(&cmdq_ctxt, 0, sizeof(cmdq_ctxt));=0D
+		memcpy((void *)&cmdq_ctxt.ctxt_info,=0D
+		       (void *)&cmdqs->cmdq[cmdq_type].cmdq_ctxt,=0D
+		       sizeof(cmdq_ctxt.ctxt_info));=0D
+		cmdq_ctxt.func_idx =3D hinic3_global_func_id(hwdev);=0D
+		cmdq_ctxt.cmdq_id =3D cmdq_type;=0D
+=0D
+		err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_COMM,=0D
+					      HINIC3_MGMT_CMD_SET_CMDQ_CTXT,=0D
+					      &cmdq_ctxt, sizeof(cmdq_ctxt),=0D
+					      &cmdq_ctxt, &out_size, 0);=0D
+		if (err || !out_size || cmdq_ctxt.status) {=0D
+			PMD_DRV_LOG(ERR,=0D
+				    "Set cmdq ctxt failed, err: %d, status: "=0D
+				    "0x%x, out_size: 0x%x",=0D
+				    err, cmdq_ctxt.status, out_size);=0D
+			return -EFAULT;=0D
+		}=0D
+	}=0D
+=0D
+	cmdqs->status |=3D HINIC3_CMDQ_ENABLE;=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
+int=0D
+hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_cmdqs *cmdqs =3D hwdev->cmdqs;=0D
+	enum hinic3_cmdq_type cmdq_type =3D HINIC3_CMDQ_SYNC;=0D
+=0D
+	for (; cmdq_type < HINIC3_MAX_CMDQ_TYPES; cmdq_type++) {=0D
+		cmdqs->cmdq[cmdq_type].wrapped =3D 1;=0D
+		hinic3_wq_wqe_pg_clear(cmdqs->cmdq[cmdq_type].wq);=0D
+	}=0D
+=0D
+	return hinic3_set_cmdq_ctxts(hwdev);=0D
+}=0D
+=0D
+static int=0D
+hinic3_set_cmdqs(struct hinic3_hwdev *hwdev, struct hinic3_cmdqs *cmdqs)=0D
+{=0D
+	void *db_base =3D NULL;=0D
+	enum hinic3_cmdq_type type, cmdq_type;=0D
+	int err;=0D
+=0D
+	err =3D hinic3_alloc_db_addr(hwdev, &db_base, HINIC3_DB_TYPE_CMDQ);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Failed to allocate doorbell address");=0D
+		goto alloc_db_err;=0D
+	}=0D
+	cmdqs->cmdqs_db_base =3D (u8 *)db_base;=0D
+=0D
+	cmdq_type =3D HINIC3_CMDQ_SYNC;=0D
+	for (; cmdq_type < HINIC3_MAX_CMDQ_TYPES; cmdq_type++) {=0D
+		err =3D init_cmdq(&cmdqs->cmdq[cmdq_type], hwdev,=0D
+				&cmdqs->saved_wqs[cmdq_type], cmdq_type);=0D
+		if (err) {=0D
+			PMD_DRV_LOG(ERR, "Initialize cmdq failed");=0D
+			goto init_cmdq_err;=0D
+		}=0D
+=0D
+		cmdq_init_queue_ctxt(&cmdqs->cmdq[cmdq_type],=0D
+				     &cmdqs->cmdq[cmdq_type].cmdq_ctxt);=0D
+	}=0D
+=0D
+	err =3D hinic3_set_cmdq_ctxts(hwdev);=0D
+	if (err)=0D
+		goto init_cmdq_err;=0D
+=0D
+	return 0;=0D
+=0D
+init_cmdq_err:=0D
+	type =3D HINIC3_CMDQ_SYNC;=0D
+	for (; type < cmdq_type; type++)=0D
+		free_cmdq(&cmdqs->cmdq[type]);=0D
+=0D
+alloc_db_err:=0D
+	hinic3_cmdq_free(cmdqs->saved_wqs, HINIC3_MAX_CMDQ_TYPES);=0D
+	return -ENOMEM;=0D
+}=0D
+=0D
+int=0D
+hinic3_cmdqs_init(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_cmdqs *cmdqs =3D NULL;=0D
+	size_t saved_wqs_size;=0D
+	char cmdq_pool_name[RTE_MEMPOOL_NAMESIZE];=0D
+	int err;=0D
+=0D
+	cmdqs =3D rte_zmalloc(NULL, sizeof(*cmdqs), 0);=0D
+	if (!cmdqs)=0D
+		return -ENOMEM;=0D
+=0D
+	hwdev->cmdqs =3D cmdqs;=0D
+	cmdqs->hwdev =3D hwdev;=0D
+=0D
+	saved_wqs_size =3D HINIC3_MAX_CMDQ_TYPES * sizeof(struct hinic3_wq);=0D
+	cmdqs->saved_wqs =3D rte_zmalloc(NULL, saved_wqs_size, 0);=0D
+	if (!cmdqs->saved_wqs) {=0D
+		PMD_DRV_LOG(ERR, "Allocate saved wqs failed");=0D
+		err =3D -ENOMEM;=0D
+		goto alloc_wqs_err;=0D
+	}=0D
+=0D
+	memset(cmdq_pool_name, 0, RTE_MEMPOOL_NAMESIZE);=0D
+	snprintf(cmdq_pool_name, sizeof(cmdq_pool_name), "hinic3_cmdq_%u",=0D
+		       hwdev->port_id);=0D
+=0D
+	cmdqs->cmd_buf_pool =3D rte_pktmbuf_pool_create(cmdq_pool_name,=0D
+		HINIC3_CMDQ_DEPTH * HINIC3_MAX_CMDQ_TYPES, 0, 0,=0D
+		HINIC3_CMDQ_BUF_SIZE, (int)rte_socket_id());=0D
+	if (!cmdqs->cmd_buf_pool) {=0D
+		PMD_DRV_LOG(ERR, "Create cmdq buffer pool failed");=0D
+		err =3D -ENOMEM;=0D
+		goto pool_create_err;=0D
+	}=0D
+=0D
+	err =3D hinic3_cmdq_alloc(cmdqs->saved_wqs, hwdev, HINIC3_MAX_CMDQ_TYPES,=
=0D
+				HINIC3_CMDQ_WQ_BUF_SIZE, CMDQ_WQEBB_SHIFT,=0D
+				HINIC3_CMDQ_DEPTH);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Allocate cmdq failed");=0D
+		goto cmdq_alloc_err;=0D
+	}=0D
+=0D
+	err =3D hinic3_set_cmdqs(hwdev, cmdqs);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "set_cmdqs failed");=0D
+		goto cmdq_alloc_err;=0D
+	}=0D
+	return 0;=0D
+=0D
+cmdq_alloc_err:=0D
+	rte_mempool_free(cmdqs->cmd_buf_pool);=0D
+=0D
+pool_create_err:=0D
+	rte_free(cmdqs->saved_wqs);=0D
+=0D
+alloc_wqs_err:=0D
+	rte_free(cmdqs);=0D
+=0D
+	return err;=0D
+}=0D
+=0D
+void=0D
+hinic3_cmdqs_free(struct hinic3_hwdev *hwdev)=0D
+{=0D
+	struct hinic3_cmdqs *cmdqs =3D hwdev->cmdqs;=0D
+	enum hinic3_cmdq_type cmdq_type =3D HINIC3_CMDQ_SYNC;=0D
+=0D
+	cmdqs->status &=3D ~HINIC3_CMDQ_ENABLE;=0D
+=0D
+	for (; cmdq_type < HINIC3_MAX_CMDQ_TYPES; cmdq_type++)=0D
+		free_cmdq(&cmdqs->cmdq[cmdq_type]);=0D
+=0D
+	hinic3_cmdq_free(cmdqs->saved_wqs, HINIC3_MAX_CMDQ_TYPES);=0D
+=0D
+	rte_mempool_free(cmdqs->cmd_buf_pool);=0D
+=0D
+	rte_free(cmdqs->saved_wqs);=0D
+=0D
+	rte_free(cmdqs);=0D
+}=0D
+=0D
+static int=0D
+hinic3_cmdq_poll_msg(struct hinic3_cmdq *cmdq, u32 timeout)=0D
+{=0D
+	struct hinic3_cmdq_wqe *wqe =3D NULL;=0D
+	struct hinic3_cmdq_wqe_lcmd *wqe_lcmd =3D NULL;=0D
+	struct hinic3_ctrl *ctrl =3D NULL;=0D
+	struct hinic3_cmdq_cmd_info *cmd_info =3D NULL;=0D
+	u32 status_info, ctrl_info;=0D
+	u16 ci;=0D
+	int errcode;=0D
+	unsigned long end;=0D
+	int done =3D 0;=0D
+	int err =3D 0;=0D
+=0D
+	wqe =3D hinic3_read_wqe(cmdq->wq, 1, &ci);=0D
+	if (!wqe) {=0D
+		PMD_DRV_LOG(ERR, "No outstanding cmdq msg");=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	cmd_info =3D &cmdq->cmd_infos[ci];=0D
+	if (cmd_info->cmd_type =3D=3D HINIC3_CMD_TYPE_NONE) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Cmdq msg has not been filled and send to hw, "=0D
+			    "or get TMO msg ack. cmdq ci: %u",=0D
+			    ci);=0D
+		return -EINVAL;=0D
+	}=0D
+=0D
+	/* Only arm bit is using scmd wqe, the wqe is lcmd. */=0D
+	wqe_lcmd =3D &wqe->wqe_lcmd;=0D
+	ctrl =3D &wqe_lcmd->ctrl;=0D
+	end =3D jiffies + msecs_to_jiffies(timeout);=0D
+	do {=0D
+		ctrl_info =3D hinic3_hw_cpu32((ctrl)->ctrl_info);=0D
+		if (WQE_COMPLETED(ctrl_info)) {=0D
+			done =3D 1;=0D
+			break;=0D
+		}=0D
+=0D
+		rte_delay_us(1);=0D
+	} while (time_before(jiffies, end));=0D
+=0D
+	if (done) {=0D
+		status_info =3D hinic3_hw_cpu32(wqe_lcmd->status.status_info);=0D
+		errcode =3D WQE_ERRCODE_GET(status_info, VAL);=0D
+		cmdq_update_errcode(cmdq, ci, errcode);=0D
+		clear_wqe_complete_bit(cmdq, wqe);=0D
+		err =3D 0;=0D
+	} else {=0D
+		PMD_DRV_LOG(ERR, "Poll cmdq msg time out, ci: %u", ci);=0D
+		err =3D -ETIMEDOUT;=0D
+	}=0D
+=0D
+	/* Set this cmd invalid. */=0D
+	cmd_info->cmd_type =3D HINIC3_CMD_TYPE_NONE;=0D
+=0D
+	return err;=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_cmdq.h b/drivers/net/hinic3/bas=
e/hinic3_cmdq.h=0D
new file mode 100644=0D
index 0000000000..fdff69fd51=0D
--- /dev/null=0D
+++ b/drivers/net/hinic3/base/hinic3_cmdq.h=0D
@@ -0,0 +1,230 @@=0D
+/* SPDX-License-Identifier: BSD-3-Clause=0D
+ * Copyright(c) 2025 Huawei Technologies Co., Ltd=0D
+ */=0D
+=0D
+#ifndef _HINIC3_CMDQ_H_=0D
+#define _HINIC3_CMDQ_H_=0D
+=0D
+#include "hinic3_mgmt.h"=0D
+#include "hinic3_wq.h"=0D
+=0D
+#define HINIC3_SCMD_DATA_LEN 16=0D
+=0D
+/* Pmd driver uses 64, kernel l2nic uses 4096. */=0D
+#define HINIC3_CMDQ_DEPTH 64=0D
+=0D
+#define HINIC3_CMDQ_BUF_SIZE 2048U=0D
+=0D
+#define HINIC3_CEQ_ID_CMDQ 0=0D
+=0D
+enum cmdq_scmd_type {=0D
+	CMDQ_SET_ARM_CMD =3D 2,=0D
+};=0D
+=0D
+enum cmdq_wqe_type { WQE_LCMD_TYPE, WQE_SCMD_TYPE };=0D
+=0D
+enum ctrl_sect_len { CTRL_SECT_LEN =3D 1, CTRL_DIRECT_SECT_LEN =3D 2 };=0D
+=0D
+enum bufdesc_len { BUFDESC_LCMD_LEN =3D 2, BUFDESC_SCMD_LEN =3D 3 };=0D
+=0D
+enum data_format {=0D
+	DATA_SGE,=0D
+};=0D
+=0D
+enum completion_format { COMPLETE_DIRECT, COMPLETE_SGE };=0D
+=0D
+enum completion_request {=0D
+	CEQ_SET =3D 1,=0D
+};=0D
+=0D
+enum cmdq_cmd_type { SYNC_CMD_DIRECT_RESP, SYNC_CMD_SGE_RESP, ASYNC_CMD };=
=0D
+=0D
+enum hinic3_cmdq_type {=0D
+	HINIC3_CMDQ_SYNC,=0D
+	HINIC3_CMDQ_ASYNC,=0D
+	HINIC3_MAX_CMDQ_TYPES=0D
+};=0D
+=0D
+enum hinic3_db_src_type {=0D
+	HINIC3_DB_SRC_CMDQ_TYPE,=0D
+	HINIC3_DB_SRC_L2NIC_SQ_TYPE=0D
+};=0D
+=0D
+enum hinic3_cmdq_db_type { HINIC3_DB_SQ_RQ_TYPE, HINIC3_DB_CMDQ_TYPE };=0D
+=0D
+/* Cmdq ack type. */=0D
+enum hinic3_ack_type {=0D
+	HINIC3_ACK_TYPE_CMDQ,=0D
+	HINIC3_ACK_TYPE_SHARE_CQN,=0D
+	HINIC3_ACK_TYPE_APP_CQN,=0D
+=0D
+	HINIC3_MOD_ACK_MAX =3D 15=0D
+};=0D
+=0D
+/* Cmdq wqe ctrls. */=0D
+struct hinic3_cmdq_header {=0D
+	u32 header_info;=0D
+	u32 saved_data;=0D
+};=0D
+=0D
+struct hinic3_scmd_bufdesc {=0D
+	u32 buf_len;=0D
+	u32 rsvd;=0D
+	u8 data[HINIC3_SCMD_DATA_LEN];=0D
+};=0D
+=0D
+struct hinic3_lcmd_bufdesc {=0D
+	struct hinic3_sge sge;=0D
+	u32 rsvd1;=0D
+	u64 saved_async_buf;=0D
+	u64 rsvd3;=0D
+};=0D
+=0D
+struct hinic3_cmdq_db {=0D
+	u32 db_head;=0D
+	u32 db_info;=0D
+};=0D
+=0D
+struct hinic3_status {=0D
+	u32 status_info;=0D
+};=0D
+=0D
+struct hinic3_ctrl {=0D
+	u32 ctrl_info;=0D
+};=0D
+=0D
+struct hinic3_sge_resp {=0D
+	struct hinic3_sge sge;=0D
+	u32 rsvd;=0D
+};=0D
+=0D
+struct hinic3_cmdq_completion {=0D
+	/* HW format. */=0D
+	union {=0D
+		struct hinic3_sge_resp sge_resp;=0D
+		u64 direct_resp;=0D
+	};=0D
+};=0D
+=0D
+struct hinic3_cmdq_wqe_scmd {=0D
+	struct hinic3_cmdq_header header;=0D
+	u64 rsvd;=0D
+	struct hinic3_status status;=0D
+	struct hinic3_ctrl ctrl;=0D
+	struct hinic3_cmdq_completion completion;=0D
+	struct hinic3_scmd_bufdesc buf_desc;=0D
+};=0D
+=0D
+struct hinic3_cmdq_wqe_lcmd {=0D
+	struct hinic3_cmdq_header header;=0D
+	struct hinic3_status status;=0D
+	struct hinic3_ctrl ctrl;=0D
+	struct hinic3_cmdq_completion completion;=0D
+	struct hinic3_lcmd_bufdesc buf_desc;=0D
+};=0D
+=0D
+struct hinic3_cmdq_inline_wqe {=0D
+	struct hinic3_cmdq_wqe_scmd wqe_scmd;=0D
+};=0D
+=0D
+struct hinic3_cmdq_wqe {=0D
+	/* HW format. */=0D
+	union {=0D
+		struct hinic3_cmdq_inline_wqe inline_wqe;=0D
+		struct hinic3_cmdq_wqe_lcmd wqe_lcmd;=0D
+	};=0D
+};=0D
+=0D
+struct hinic3_cmdq_ctxt_info {=0D
+	u64 curr_wqe_page_pfn;=0D
+	u64 wq_block_pfn;=0D
+};=0D
+=0D
+struct hinic3_cmd_cmdq_ctxt {=0D
+	u8 status;=0D
+	u8 version;=0D
+	u8 rsvd0[6];=0D
+=0D
+	u16 func_idx;=0D
+	u8 cmdq_id;=0D
+	u8 rsvd1[5];=0D
+=0D
+	struct hinic3_cmdq_ctxt_info ctxt_info;=0D
+};=0D
+=0D
+enum hinic3_cmdq_status {=0D
+	HINIC3_CMDQ_ENABLE =3D BIT(0),=0D
+};=0D
+=0D
+enum hinic3_cmdq_cmd_type {=0D
+	HINIC3_CMD_TYPE_NONE,=0D
+	HINIC3_CMD_TYPE_SET_ARM,=0D
+	HINIC3_CMD_TYPE_DIRECT_RESP,=0D
+	HINIC3_CMD_TYPE_SGE_RESP=0D
+};=0D
+=0D
+struct hinic3_cmdq_cmd_info {=0D
+	enum hinic3_cmdq_cmd_type cmd_type;=0D
+};=0D
+=0D
+struct hinic3_cmdq {=0D
+	struct hinic3_wq *wq;=0D
+=0D
+	enum hinic3_cmdq_type cmdq_type;=0D
+	int wrapped;=0D
+=0D
+	int *errcode;=0D
+	u8 *db_base;=0D
+=0D
+	rte_spinlock_t cmdq_lock;=0D
+=0D
+	struct hinic3_cmdq_ctxt_info cmdq_ctxt;=0D
+=0D
+	struct hinic3_cmdq_cmd_info *cmd_infos;=0D
+};=0D
+=0D
+struct hinic3_cmdqs {=0D
+	struct hinic3_hwdev *hwdev;=0D
+	u8 *cmdqs_db_base;=0D
+=0D
+	struct rte_mempool *cmd_buf_pool;=0D
+=0D
+	struct hinic3_wq *saved_wqs;=0D
+=0D
+	struct hinic3_cmdq cmdq[HINIC3_MAX_CMDQ_TYPES];=0D
+=0D
+	u32 status;=0D
+};=0D
+=0D
+struct hinic3_cmd_buf {=0D
+	void *buf;=0D
+	uint64_t dma_addr;=0D
+	struct rte_mbuf *mbuf;=0D
+	u16 size;=0D
+};=0D
+=0D
+int hinic3_reinit_cmdq_ctxts(struct hinic3_hwdev *hwdev);=0D
+=0D
+bool hinic3_cmdq_idle(struct hinic3_cmdq *cmdq);=0D
+=0D
+struct hinic3_cmd_buf *hinic3_alloc_cmd_buf(void *hwdev);=0D
+=0D
+void hinic3_free_cmd_buf(struct hinic3_cmd_buf *cmd_buf);=0D
+=0D
+/*=0D
+ * PF/VF sends cmd to ucode by cmdq, and return 0 if success.=0D
+ * timeout=3D0, use default timeout.=0D
+ */=0D
+int hinic3_cmdq_direct_resp(void *hwdev, enum hinic3_mod_type mod, u8 cmd,=
=0D
+			    struct hinic3_cmd_buf *buf_in, u64 *out_param,=0D
+			    u32 timeout);=0D
+=0D
+int hinic3_cmdq_detail_resp(void *hwdev, enum hinic3_mod_type mod, u8 cmd,=
=0D
+			    struct hinic3_cmd_buf *buf_in,=0D
+			    struct hinic3_cmd_buf *buf_out, u32 timeout);=0D
+=0D
+int hinic3_cmdqs_init(struct hinic3_hwdev *hwdev);=0D
+=0D
+void hinic3_cmdqs_free(struct hinic3_hwdev *hwdev);=0D
+=0D
+#endif /* _HINIC3_CMDQ_H_ */=0D
-- =0D
2.45.1.windows.1=0D
=0D

