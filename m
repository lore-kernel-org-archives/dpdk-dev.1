Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2E8C982EA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:06:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F3FC410ED;
	Mon, 21 Sep 2026 05:06:34 +0200 (CEST)
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com
 [209.85.216.99]) by mails.dpdk.org (Postfix) with ESMTP id 2F06A410E8
 for <dev@dpdk.org>; Mon, 21 Sep 2026 05:06:32 +0200 (CEST)
Received: by mail-pj1-f99.google.com with SMTP id
 98e67ed59e1d1-39e4d1ed719so1182453a91.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959991; x=1790564791;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=OYV1rqcvlbYsube8aUYw+F4pgDy78BeIe9+FPK5Kavs=;
 b=MYFtpXLOwtMq4pvDLxehajJwDXqCG/mf56745lQFpfMW6cHKB94G4uijEap8cA2eVy
 WlLH+z4IqPOLi6i3dlXZuRMvUca46VztHCorw3pIGpCqIXaUy2UgWGQMHgzZB51/sSMz
 hYKdQ6YPWTPI0hpxD2CNZ/Ni+fdgRvJ73XJgrEvYiGqtnsIbrBfd2XlFNL7ESpa3UQAc
 TX0vtRkDOlBiA8FsNEFZaZYbz8qjp061X1p12kt7VVK3SB1i1nYl2MrATy8yi6amCGA7
 UsqImHX8/A8tor9qbuXvCO4FBDb65R1n42YaXsuIhVLwaL4j8vWX3+nqkN/4i13JomO1
 pZvA==
X-Gm-Message-State: AFuF++leiiEr89WfB/IcckuFTnvVdco3PQtDircCrpzD4xgIXQUijSoP
 Iklm28pgCm5c8w/do35nYDGfR1S1YJ502uEMci6FQFLFw/D6EOZhlu4cXGfAxunqZDja8aty1D7
 Vcx+KmkzHVX5GFtkEAVXTdmjf+1qA9Lly9YZOX1WmP/yY2Q9oaVS1wMyYpYU8aggbow167pWU8y
 k4vyw2WwycQ8EwaTOwmLV0fKmVl0lcwp2fAYYxM2eiRuKdKmgGKjbu+74LOnmnJjS8Oqxgj1+M4
 hveNlk4n1j9
X-Gm-Gg: AYBFou0P2qZuekrdmlv+Z2s/wbnk6dTGZSTanBTuy4HZpReoFb7HAt+jECVB9jKgch2
 6v8OKz6yjxUMUx8+kfi06gYUW6sE4MsQaOTkJCqd9vuenmtLrRvmRvHk+FfdkddVB1V/Jh8PDqE
 aZ1ycqG5+2pLeXv2XApDCu25RRHkdtuNJdmG8kxyC1T/9nUGxoHdGtZn5mMYVwNRX55BFo7sCOi
 /mT4u0BeJJw1xzRFn0KxihIkXP2XxlQD0Zt8vW9oTQAchU8+28zwKbmUcMifA1UQpbpZzB00o7S
 +yh++ES/H3b1n60nftvyJTnB2fiWPhqp4Qa8FJzcW8nC7P1JBCjXKhQHSwgzT66zlB2s4Et5Zuz
 wWXmWLnfmep9GXE/wSkpksls9J+ntJevvkkFK4dD2teH5YH0Wxlms+gE9LOEzLkYfJdUDe8oARO
 7q+2SJ4ijfab2PRCgak3eIipqvVp49go8RPGE6H29tHxpYBlLJUw==
X-Received: by 2002:a17:90b:1b41:b0:39e:6c68:c788 with SMTP id
 98e67ed59e1d1-39e6c68c9e6mr8178126a91.62.1789959991059; 
 Sun, 20 Sep 2026 20:06:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
 by smtp-relay.gmail.com with ESMTPS id
 a92af1059eb24-144d5492c1fsm143971c88.2.2026.09.20.20.06.30
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 20:06:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39e087a17dfso4704539a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959989; x=1790564789; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OYV1rqcvlbYsube8aUYw+F4pgDy78BeIe9+FPK5Kavs=;
 b=NFcQXMu4mHLCSfUSlCY1Vn2SEU89/mm65BcP9aagxmRn6nz673UtNxPp6J8gefAD5T
 kjVxMV8AGlkPkWX+aWyd1t6dUf6nP3uDb1s15oHLtpPLyv7qOiINvkxG0HVoqOwA3HDU
 WAM1IZ0fWppPYkpHuQgVocdv52KP6wkSuKbQw=
X-Received: by 2002:a17:90a:d88b:b0:39e:6c68:c78b with SMTP id
 98e67ed59e1d1-39e6c68caafmr8571313a91.65.1789959988661; 
 Sun, 20 Sep 2026 20:06:28 -0700 (PDT)
X-Received: by 2002:a17:90a:d88b:b0:39e:6c68:c78b with SMTP id
 98e67ed59e1d1-39e6c68caafmr8571279a91.65.1789959987858; 
 Sun, 20 Sep 2026 20:06:27 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144d54af4d5sm16000916c88.2.2026.09.20.20.06.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 20:06:27 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: add support for driver mapping layer
Date: Sun, 20 Sep 2026 21:09:32 -0600
Message-ID: <20260921030932.1034887-1-Mohammad-Shuab.Siddique@broadcom.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
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

From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>

Add a driver mapping layer that abstracts HWRM send-message, FW
status register mapping, and doorbell setup/write operations behind
a per-mode operations table (struct bnxt_drv_api_ops), selected at
runtime via a new bp->drv_map_ctx context. This lays the groundwork
for supporting an additional driver backend alongside the current
native mode, without disturbing existing native call sites.

Only the native backend is implemented here. Each abstracted
operation keeps a fallback to calling its native implementation
directly when bp->drv_map_ctx has not been initialized, so behavior
is unchanged for any code path that doesn't go through
bnxt_drv_init(). The higher-frequency doorbell ring/arm operations
(bnxt_db_write/_epoch_write/_mpc_write/_nq/_nq_arm/_cq/_mpc_cq) stay
static inline and call their native implementation directly rather
than through the ops table, to avoid adding an indirect call to the
per-packet doorbell path; only the control-path operations (HWRM
send, FW status register mapping, doorbell setup) actually dispatch
through bp->drv_map_ctx->ops.

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt.h            |   3 +
 drivers/net/bnxt/bnxt_drv_map.c    | 184 +++++++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_drv_map.h    | 158 +++++++++++++++++++++++++
 drivers/net/bnxt/bnxt_drv_native.c | 101 ++++++++++++++++
 drivers/net/bnxt/bnxt_ethdev.c     |  27 ++++-
 drivers/net/bnxt/bnxt_hwrm.c       |  16 ++-
 drivers/net/bnxt/bnxt_hwrm.h       |   3 +
 drivers/net/bnxt/bnxt_ring.c       |  35 ++++--
 drivers/net/bnxt/bnxt_ring.h       |  57 +++++++--
 drivers/net/bnxt/meson.build       |   2 +
 10 files changed, 570 insertions(+), 16 deletions(-)
 create mode 100644 drivers/net/bnxt/bnxt_drv_map.c
 create mode 100644 drivers/net/bnxt/bnxt_drv_map.h
 create mode 100644 drivers/net/bnxt/bnxt_drv_native.c

diff --git a/drivers/net/bnxt/bnxt.h b/drivers/net/bnxt/bnxt.h
index 336de75da0..7edd72cdf9 100644
--- a/drivers/net/bnxt/bnxt.h
+++ b/drivers/net/bnxt/bnxt.h
@@ -21,6 +21,7 @@
 #include <rte_eal_paging.h>
 
 #include "bnxt_cpr.h"
+#include "bnxt_drv_map.h"
 #include "bnxt_util.h"
 
 #include "tf_core.h"
@@ -1112,6 +1113,7 @@ struct bnxt {
 	uint8_t			nq_dpi_start;			/* Starting DPI for NQ rings */
 	uint8_t			nq_dpi_count;			/* Number of DPI pages for NQ */
 	uint8_t			nq_dpi_counter;			/* Round-robin counter for NQ DPI */
+	struct bnxt_drv_map_ctx	*drv_map_ctx;
 };
 
 static
@@ -1230,6 +1232,7 @@ int bnxt_link_update(struct rte_eth_dev *eth_dev, int wait_to_complete,
 		     bool exp_link_status);
 int bnxt_rcv_msg_from_vf(struct bnxt *bp, uint16_t vf_id, void *msg);
 int is_bnxt_in_error(struct bnxt *bp);
+int bnxt_native_map_fw_status_reg(struct bnxt *bp);
 
 int bnxt_map_fw_health_status_regs(struct bnxt *bp);
 uint32_t bnxt_read_fw_status_reg(struct bnxt *bp, uint32_t index);
diff --git a/drivers/net/bnxt/bnxt_drv_map.c b/drivers/net/bnxt/bnxt_drv_map.c
new file mode 100644
index 0000000000..91c6b6652f
--- /dev/null
+++ b/drivers/net/bnxt/bnxt_drv_map.c
@@ -0,0 +1,184 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2014-2026 Broadcom
+ * All rights reserved.
+ */
+
+/**
+ * Driver Mapping Layer Dispatcher
+ * ================================
+ *
+ * This file implements the dispatcher that selects between native and
+ * bifurcated driver implementations based on the configured mode. Only
+ * the native backend is wired up so far.
+ */
+
+#include <rte_common.h>
+#include <rte_malloc.h>
+#include <rte_errno.h>
+
+#include "bnxt.h"
+#include "bnxt_drv_map.h"
+
+/*
+ * Macro to validate driver mapping context and operations.
+ * "op" is used as a struct member name after "->", not as an
+ * expression, so it must stay unparenthesized here.
+ */
+#define BNXT_DRV_MAP_INVALID(bp, op) \
+	(!(bp) || !(bp)->drv_map_ctx || !(bp)->drv_map_ctx->ops || \
+	 !(bp)->drv_map_ctx->ops->op)
+
+/**
+ * Initialize driver mapping layer
+ */
+int bnxt_drv_map_init(struct bnxt *bp, enum bnxt_drv_mode mode)
+{
+	if (!bp)
+		return -EINVAL;
+
+	/* Allocate drv_map context if not already allocated */
+	if (!bp->drv_map_ctx) {
+		bp->drv_map_ctx = rte_zmalloc("bnxt_drv_map_ctx",
+					      sizeof(struct bnxt_drv_map_ctx),
+					      RTE_CACHE_LINE_SIZE);
+		if (!bp->drv_map_ctx) {
+			PMD_DRV_LOG_LINE(ERR, "Failed to allocate drv_map context");
+			return -ENOMEM;
+		}
+	}
+
+	/* Set the mode and operations table */
+	bp->drv_map_ctx->mode = mode;
+
+	switch (mode) {
+	case BNXT_DRV_MODE_NATIVE:
+		bp->drv_map_ctx->ops = &bnxt_drv_native_ops;
+		PMD_DRV_LOG_LINE(INFO, "Initialized native driver mode");
+		break;
+
+	default:
+		PMD_DRV_LOG_LINE(ERR, "Invalid driver mode: %d", mode);
+		rte_free(bp->drv_map_ctx);
+		bp->drv_map_ctx = NULL;
+		return -EINVAL;
+	}
+
+	bp->drv_map_ctx->priv_data = NULL;
+
+	return 0;
+}
+
+/**
+ * Cleanup driver mapping layer
+ */
+void bnxt_drv_map_cleanup(struct bnxt *bp)
+{
+	if (!bp)
+		return;
+
+	if (bp->drv_map_ctx) {
+		rte_free(bp->drv_map_ctx);
+		bp->drv_map_ctx = NULL;
+	}
+}
+
+/**
+ * Driver Map API Implementations - HWRM Operations
+ */
+int bnxt_drv_hwrm_send_msg(struct bnxt *bp, void *msg,
+			   uint32_t msg_len, bool use_kong_mb)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, hwrm_send_msg))
+		return -EINVAL;
+
+	return bp->drv_map_ctx->ops->hwrm_send_msg(bp, msg, msg_len, use_kong_mb);
+}
+
+/**
+ * Driver Map API Implementations - FW Status Register Mapping
+ */
+int bnxt_drv_map_fw_status_reg(struct bnxt *bp)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, map_fw_status_reg))
+		return -EINVAL;
+
+	return bp->drv_map_ctx->ops->map_fw_status_reg(bp);
+}
+
+/**
+ * Driver Map API Implementations - Doorbell Setup
+ */
+void bnxt_drv_set_db(struct bnxt *bp,
+		     struct bnxt_db_info *db,
+		     uint32_t ring_type,
+		     uint32_t map_idx,
+		     uint32_t fid,
+		     uint32_t ring_mask,
+		     uint16_t dpi)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, set_db))
+		return;
+
+	bp->drv_map_ctx->ops->set_db(bp, db, ring_type, map_idx, fid, ring_mask, dpi);
+}
+
+/**
+ * Driver Map API Implementations - Doorbell Write Operations
+ */
+void bnxt_drv_db_write(struct bnxt *bp, struct bnxt_db_info *db, uint32_t idx)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, db_write))
+		return;
+
+	bp->drv_map_ctx->ops->db_write(db, idx);
+}
+
+void bnxt_drv_db_epoch_write(struct bnxt *bp, struct bnxt_db_info *db,
+			     uint32_t idx, uint32_t epoch)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, db_epoch_write))
+		return;
+
+	bp->drv_map_ctx->ops->db_epoch_write(db, idx, epoch);
+}
+
+void bnxt_drv_db_mpc_write(struct bnxt *bp, struct bnxt_db_info *db,
+			   uint32_t idx, uint32_t epoch)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, db_mpc_write))
+		return;
+
+	bp->drv_map_ctx->ops->db_mpc_write(db, idx, epoch);
+}
+
+void bnxt_drv_db_nq(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, db_nq))
+		return;
+
+	bp->drv_map_ctx->ops->db_nq(cpr);
+}
+
+void bnxt_drv_db_nq_arm(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, db_nq_arm))
+		return;
+
+	bp->drv_map_ctx->ops->db_nq_arm(cpr);
+}
+
+void bnxt_drv_db_cq(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, db_cq))
+		return;
+
+	bp->drv_map_ctx->ops->db_cq(cpr);
+}
+
+void bnxt_drv_db_mpc_cq(struct bnxt *bp, struct bnxt_cp_ring_info *cpr)
+{
+	if (BNXT_DRV_MAP_INVALID(bp, db_mpc_cq))
+		return;
+
+	bp->drv_map_ctx->ops->db_mpc_cq(cpr);
+}
diff --git a/drivers/net/bnxt/bnxt_drv_map.h b/drivers/net/bnxt/bnxt_drv_map.h
new file mode 100644
index 0000000000..f1ee8c160f
--- /dev/null
+++ b/drivers/net/bnxt/bnxt_drv_map.h
@@ -0,0 +1,158 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2014-2026 Broadcom
+ * All rights reserved.
+ */
+
+#ifndef _BNXT_DRV_MAP_H_
+#define _BNXT_DRV_MAP_H_
+
+#include <inttypes.h>
+#include <stdbool.h>
+
+struct bnxt;
+struct bnxt_db_info;
+struct bnxt_cp_ring_info;
+
+/**
+ * BNXT Driver Mapping Layer
+ * ==========================
+ *
+ * This layer abstracts HWRM and doorbell operations to support multiple
+ * backend implementations (native vs bifurcated driver). Only the native
+ * backend is implemented so far; the bifurcated backend is added in a
+ * follow-up patch.
+ */
+
+/* Driver mode enumeration */
+enum bnxt_drv_mode {
+	BNXT_DRV_MODE_NATIVE = 0,      /* Native DPDK with direct MMIO */
+};
+
+/**
+ * HWRM API Function Pointers
+ */
+typedef int (*bnxt_drv_hwrm_send_msg_t)(struct bnxt *bp, void *msg,
+					uint32_t msg_len, bool use_kong_mb);
+
+/**
+ * FW Status Register Mapping API Function Pointer
+ */
+typedef int (*bnxt_drv_map_fw_status_reg_t)(struct bnxt *bp);
+
+/**
+ * Doorbell Setup API Function Pointers
+ */
+typedef void (*bnxt_drv_set_db_t)(struct bnxt *bp,
+				  struct bnxt_db_info *db,
+				  uint32_t ring_type,
+				  uint32_t map_idx,
+				  uint32_t fid,
+				  uint32_t ring_mask,
+				  uint16_t dpi);
+
+/**
+ * Doorbell Write API Function Pointers
+ */
+typedef void (*bnxt_drv_db_write_t)(struct bnxt_db_info *db, uint32_t idx);
+
+typedef void (*bnxt_drv_db_epoch_write_t)(struct bnxt_db_info *db,
+					  uint32_t idx,
+					  uint32_t epoch);
+
+typedef void (*bnxt_drv_db_mpc_write_t)(struct bnxt_db_info *db,
+					uint32_t idx,
+					uint32_t epoch);
+
+typedef void (*bnxt_drv_db_nq_t)(struct bnxt_cp_ring_info *cpr);
+
+typedef void (*bnxt_drv_db_nq_arm_t)(struct bnxt_cp_ring_info *cpr);
+
+typedef void (*bnxt_drv_db_cq_t)(struct bnxt_cp_ring_info *cpr);
+
+typedef void (*bnxt_drv_db_mpc_cq_t)(struct bnxt_cp_ring_info *cpr);
+
+/**
+ * Driver API Operations Table
+ */
+struct bnxt_drv_api_ops {
+	/* HWRM operations */
+	bnxt_drv_hwrm_send_msg_t	hwrm_send_msg;
+
+	/* FW status register mapping */
+	bnxt_drv_map_fw_status_reg_t	map_fw_status_reg;
+
+	/* Doorbell setup operations */
+	bnxt_drv_set_db_t		set_db;
+
+	/* Doorbell write operations */
+	bnxt_drv_db_write_t		db_write;
+	bnxt_drv_db_epoch_write_t	db_epoch_write;
+	bnxt_drv_db_mpc_write_t		db_mpc_write;
+	bnxt_drv_db_nq_t		db_nq;
+	bnxt_drv_db_nq_arm_t		db_nq_arm;
+	bnxt_drv_db_cq_t		db_cq;
+	bnxt_drv_db_mpc_cq_t		db_mpc_cq;
+};
+
+/**
+ * Driver Mapping Context
+ */
+struct bnxt_drv_map_ctx {
+	enum bnxt_drv_mode mode;
+	const struct bnxt_drv_api_ops *ops;
+	void *priv_data;  /* Mode-specific private data */
+};
+
+/**
+ * Driver Map Initialization and Cleanup
+ */
+int bnxt_drv_map_init(struct bnxt *bp, enum bnxt_drv_mode mode);
+void bnxt_drv_map_cleanup(struct bnxt *bp);
+
+/**
+ * Driver Map API - HWRM Operations
+ */
+int bnxt_drv_hwrm_send_msg(struct bnxt *bp, void *msg,
+			   uint32_t msg_len, bool use_kong_mb);
+
+/**
+ * Driver Map API - FW Status Register Mapping
+ */
+int bnxt_drv_map_fw_status_reg(struct bnxt *bp);
+
+/**
+ * Driver Map API - Doorbell Setup
+ */
+void bnxt_drv_set_db(struct bnxt *bp,
+		     struct bnxt_db_info *db,
+		     uint32_t ring_type,
+		     uint32_t map_idx,
+		     uint32_t fid,
+		     uint32_t ring_mask,
+		     uint16_t dpi);
+
+/**
+ * Driver Map API - Doorbell Write Operations
+ */
+void bnxt_drv_db_write(struct bnxt *bp, struct bnxt_db_info *db, uint32_t idx);
+
+void bnxt_drv_db_epoch_write(struct bnxt *bp, struct bnxt_db_info *db,
+			     uint32_t idx, uint32_t epoch);
+
+void bnxt_drv_db_mpc_write(struct bnxt *bp, struct bnxt_db_info *db,
+			   uint32_t idx, uint32_t epoch);
+
+void bnxt_drv_db_nq(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+
+void bnxt_drv_db_nq_arm(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+
+void bnxt_drv_db_cq(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+
+void bnxt_drv_db_mpc_cq(struct bnxt *bp, struct bnxt_cp_ring_info *cpr);
+
+/**
+ * Native Driver API Operations (exported for direct use if needed)
+ */
+extern const struct bnxt_drv_api_ops bnxt_drv_native_ops;
+
+#endif /* _BNXT_DRV_MAP_H_ */
diff --git a/drivers/net/bnxt/bnxt_drv_native.c b/drivers/net/bnxt/bnxt_drv_native.c
new file mode 100644
index 0000000000..73f2c85f14
--- /dev/null
+++ b/drivers/net/bnxt/bnxt_drv_native.c
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2014-2026 Broadcom
+ * All rights reserved.
+ */
+
+/**
+ * Native Driver Implementation
+ * =============================
+ *
+ * This file contains wrapper functions that call the native implementations
+ * of HWRM and doorbell operations. The actual implementations remain in
+ * their original files (bnxt_hwrm.c, bnxt_ring.c, bnxt_ring.h).
+ */
+
+#include <rte_common.h>
+
+#include "bnxt.h"
+#include "bnxt_drv_map.h"
+#include "bnxt_hwrm.h"
+#include "bnxt_ring.h"
+#include "bnxt_cpr.h"
+
+/**
+ * Wrapper Functions
+ * These simply call the native implementations in their original locations
+ */
+
+static int bnxt_drv_native_hwrm_send_msg(struct bnxt *bp, void *msg,
+					 uint32_t msg_len, bool use_kong_mb)
+{
+	return bnxt_native_hwrm_send_message(bp, msg, msg_len, use_kong_mb);
+}
+
+static int bnxt_drv_native_map_fw_status_reg(struct bnxt *bp)
+{
+	return bnxt_native_map_fw_status_reg(bp);
+}
+
+static void bnxt_drv_native_set_db(struct bnxt *bp,
+				   struct bnxt_db_info *db,
+				   uint32_t ring_type,
+				   uint32_t map_idx,
+				   uint32_t fid,
+				   uint32_t ring_mask,
+				   uint16_t dpi)
+{
+	bnxt_native_set_db(bp, db, ring_type, map_idx, fid, ring_mask, dpi);
+}
+
+static void bnxt_drv_native_db_write(struct bnxt_db_info *db, uint32_t idx)
+{
+	bnxt_native_db_write(db, idx);
+}
+
+static void bnxt_drv_native_db_epoch_write(struct bnxt_db_info *db,
+					   uint32_t idx, uint32_t epoch)
+{
+	bnxt_native_db_epoch_write(db, idx, epoch);
+}
+
+static void bnxt_drv_native_db_mpc_write(struct bnxt_db_info *db,
+					 uint32_t idx, uint32_t epoch)
+{
+	bnxt_native_db_mpc_write(db, idx, epoch);
+}
+
+static void bnxt_drv_native_db_nq(struct bnxt_cp_ring_info *cpr)
+{
+	bnxt_native_db_nq(cpr);
+}
+
+static void bnxt_drv_native_db_nq_arm(struct bnxt_cp_ring_info *cpr)
+{
+	bnxt_native_db_nq_arm(cpr);
+}
+
+static void bnxt_drv_native_db_cq(struct bnxt_cp_ring_info *cpr)
+{
+	bnxt_native_db_cq(cpr);
+}
+
+static void bnxt_drv_native_db_mpc_cq(struct bnxt_cp_ring_info *cpr)
+{
+	bnxt_native_db_mpc_cq(cpr);
+}
+
+/**
+ * Native Driver API Operations Table
+ */
+const struct bnxt_drv_api_ops bnxt_drv_native_ops = {
+	.hwrm_send_msg = bnxt_drv_native_hwrm_send_msg,
+	.map_fw_status_reg = bnxt_drv_native_map_fw_status_reg,
+	.set_db = bnxt_drv_native_set_db,
+	.db_write = bnxt_drv_native_db_write,
+	.db_epoch_write = bnxt_drv_native_db_epoch_write,
+	.db_mpc_write = bnxt_drv_native_db_mpc_write,
+	.db_nq = bnxt_drv_native_db_nq,
+	.db_nq_arm = bnxt_drv_native_db_nq_arm,
+	.db_cq = bnxt_drv_native_db_cq,
+	.db_mpc_cq = bnxt_drv_native_db_mpc_cq,
+};
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 8e8ead8f61..09bce6c19e 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -17,6 +17,7 @@
 #include <rte_vect.h>
 
 #include "bnxt.h"
+#include "bnxt_drv_map.h"
 #include "bnxt_filter.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_irq.h"
@@ -1983,6 +1984,9 @@ static void bnxt_drv_uninit(struct bnxt *bp)
 
 	rte_free(bp->grp_info);
 	bp->grp_info = NULL;
+
+	/* Cleanup driver mapping layer */
+	bnxt_drv_map_cleanup(bp);
 }
 
 static int bnxt_dev_close_op(struct rte_eth_dev *eth_dev)
@@ -5626,7 +5630,8 @@ static void bnxt_check_fw_status(struct bnxt *bp)
 			    fw_status);
 }
 
-static int bnxt_map_hcomm_fw_status_reg(struct bnxt *bp)
+/* Native implementation of FW status register mapping */
+int bnxt_native_map_fw_status_reg(struct bnxt *bp)
 {
 	struct bnxt_error_recovery_info *info = bp->recovery_info;
 	uint32_t status_loc;
@@ -5674,6 +5679,17 @@ static int bnxt_map_hcomm_fw_status_reg(struct bnxt *bp)
 	return 0;
 }
 
+/* Wrapper for drv_map layer - dispatches to appropriate implementation */
+static int bnxt_map_hcomm_fw_status_reg(struct bnxt *bp)
+{
+	/* Use drv_map layer if initialized */
+	if (bp->drv_map_ctx)
+		return bnxt_drv_map_fw_status_reg(bp);
+
+	/* Fall back to native implementation for compatibility */
+	return bnxt_native_map_fw_status_reg(bp);
+}
+
 /* This function gets the FW version along with the
  * capabilities(MAX and current) of the function, vnic,
  * error recovery, phy and other chip related info
@@ -6483,6 +6499,15 @@ static int bnxt_drv_init(struct rte_eth_dev *eth_dev)
 		return rc;
 	}
 
+	/* Initialize driver mapping layer */
+	rc = bnxt_drv_map_init(bp, BNXT_DRV_MODE_NATIVE);
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR,
+				 "Failed to initialize driver mapping layer rc: %x",
+				 rc);
+		return rc;
+	}
+
 	rc = bnxt_alloc_pf_info(bp);
 	if (rc)
 		return rc;
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 1615b36aae..fdf77791f4 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -14,6 +14,7 @@
 #include <rte_io.h>
 
 #include "bnxt.h"
+#include "bnxt_drv_map.h"
 #include "bnxt_filter.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_rxq.h"
@@ -477,7 +478,8 @@ bnxt_check_cq_hwrm_done(struct bnxt_cp_ring_info *cpr,
  * command was failed by the FW.
  */
 
-static int bnxt_hwrm_send_message(struct bnxt *bp, void *msg,
+/* Native HWRM send message implementation - renamed for drv_map layer */
+int bnxt_native_hwrm_send_message(struct bnxt *bp, void *msg,
 				  uint32_t msg_len, bool use_kong_mb)
 {
 	unsigned int i;
@@ -611,6 +613,18 @@ static int bnxt_hwrm_send_message(struct bnxt *bp, void *msg,
 	return 0;
 }
 
+/* Wrapper for drv_map layer - dispatches to appropriate implementation */
+static int bnxt_hwrm_send_message(struct bnxt *bp, void *msg,
+				  uint32_t msg_len, bool use_kong_mb)
+{
+	/* Use drv_map layer if initialized */
+	if (bp->drv_map_ctx)
+		return bnxt_drv_hwrm_send_msg(bp, msg, msg_len, use_kong_mb);
+
+	/* Fall back to native implementation for compatibility */
+	return bnxt_native_hwrm_send_message(bp, msg, msg_len, use_kong_mb);
+}
+
 /*
  * HWRM_PREP() should be used to prepare *ALL* HWRM commands. It grabs the
  * spinlock, and does initial processing.
diff --git a/drivers/net/bnxt/bnxt_hwrm.h b/drivers/net/bnxt/bnxt_hwrm.h
index 3034803023..b09b472082 100644
--- a/drivers/net/bnxt/bnxt_hwrm.h
+++ b/drivers/net/bnxt/bnxt_hwrm.h
@@ -398,4 +398,7 @@ int bnxt_hwrm_release_afm_func(struct bnxt *bp,
 			       uint16_t rfid,
 			       uint8_t type,
 			       uint32_t flags);
+
+int bnxt_native_hwrm_send_message(struct bnxt *bp, void *msg,
+				  uint32_t msg_len, bool use_kong_mb);
 #endif
diff --git a/drivers/net/bnxt/bnxt_ring.c b/drivers/net/bnxt/bnxt_ring.c
index 064520aa62..fe1b857980 100644
--- a/drivers/net/bnxt/bnxt_ring.c
+++ b/drivers/net/bnxt/bnxt_ring.c
@@ -9,6 +9,7 @@
 #include <unistd.h>
 
 #include "bnxt.h"
+#include "bnxt_drv_map.h"
 #include "bnxt_hwrm.h"
 #include "bnxt_ring.h"
 #include "bnxt_rxq.h"
@@ -348,13 +349,14 @@ void bnxt_init_dflt_coal(struct bnxt_coal *coal)
 	coal->cmpl_aggr_dma_tmr_during_int = BNXT_CMPL_AGGR_DMA_TMR_DURING_INT;
 }
 
-void bnxt_set_db(struct bnxt *bp,
-		 struct bnxt_db_info *db,
-		 uint32_t ring_type,
-		 uint32_t map_idx,
-		 uint32_t fid,
-		 uint32_t ring_mask,
-		 uint16_t dpi)
+/* Native doorbell setup implementation - renamed for drv_map layer */
+void bnxt_native_set_db(struct bnxt *bp,
+			struct bnxt_db_info *db,
+			uint32_t ring_type,
+			uint32_t map_idx,
+			uint32_t fid,
+			uint32_t ring_mask,
+			uint16_t dpi)
 {
 	uint64_t dpi_offset;
 
@@ -411,6 +413,25 @@ void bnxt_set_db(struct bnxt *bp,
 	db->db_ring_mask = ring_mask;
 }
 
+/* Wrapper for drv_map layer - dispatches to appropriate implementation */
+void bnxt_set_db(struct bnxt *bp,
+		 struct bnxt_db_info *db,
+		 uint32_t ring_type,
+		 uint32_t map_idx,
+		 uint32_t fid,
+		 uint32_t ring_mask,
+		 uint16_t dpi)
+{
+	/* Use drv_map layer if initialized */
+	if (bp->drv_map_ctx) {
+		bnxt_drv_set_db(bp, db, ring_type, map_idx, fid, ring_mask, dpi);
+		return;
+	}
+
+	/* Fall back to native implementation for compatibility */
+	bnxt_native_set_db(bp, db, ring_type, map_idx, fid, ring_mask, dpi);
+}
+
 int bnxt_alloc_cmpl_ring(struct bnxt *bp, int queue_index,
 			 struct bnxt_cp_ring_info *cpr)
 {
diff --git a/drivers/net/bnxt/bnxt_ring.h b/drivers/net/bnxt/bnxt_ring.h
index 496c3e111f..942762615d 100644
--- a/drivers/net/bnxt/bnxt_ring.h
+++ b/drivers/net/bnxt/bnxt_ring.h
@@ -92,7 +92,8 @@ void bnxt_set_db(struct bnxt *bp,
 		 uint32_t ring_mask,
 		 uint16_t dpi);
 
-static inline void bnxt_db_write(struct bnxt_db_info *db, uint32_t idx)
+/* Native doorbell write inline functions */
+static inline void bnxt_native_db_write(struct bnxt_db_info *db, uint32_t idx)
 {
 	uint32_t db_idx = DB_RING_IDX(db, idx);
 	void *doorbell = db->doorbell;
@@ -109,7 +110,12 @@ static inline void bnxt_db_write(struct bnxt_db_info *db, uint32_t idx)
 	}
 }
 
-static inline void bnxt_db_epoch_write(struct bnxt_db_info *db, uint32_t idx, uint32_t epoch)
+static inline void bnxt_db_write(struct bnxt_db_info *db, uint32_t idx)
+{
+	bnxt_native_db_write(db, idx);
+}
+
+static inline void bnxt_native_db_epoch_write(struct bnxt_db_info *db, uint32_t idx, uint32_t epoch)
 {
 	uint32_t db_idx = DB_RING_IDX(db, idx);
 	void *doorbell = db->doorbell;
@@ -128,7 +134,12 @@ static inline void bnxt_db_epoch_write(struct bnxt_db_info *db, uint32_t idx, ui
 	}
 }
 
-static inline void bnxt_db_mpc_write(struct bnxt_db_info *db, uint32_t idx, uint32_t epoch)
+static inline void bnxt_db_epoch_write(struct bnxt_db_info *db, uint32_t idx, uint32_t epoch)
+{
+	bnxt_native_db_epoch_write(db, idx, epoch);
+}
+
+static inline void bnxt_native_db_mpc_write(struct bnxt_db_info *db, uint32_t idx, uint32_t epoch)
 {
 	uint32_t db_idx = DB_RING_IDX(db, idx);
 	void *doorbell = db->doorbell;
@@ -144,8 +155,13 @@ static inline void bnxt_db_mpc_write(struct bnxt_db_info *db, uint32_t idx, uint
 	}
 }
 
+static inline void bnxt_db_mpc_write(struct bnxt_db_info *db, uint32_t idx, uint32_t epoch)
+{
+	bnxt_native_db_mpc_write(db, idx, epoch);
+}
+
 /* Ring an NQ doorbell and disable interrupts for the ring. */
-static inline void bnxt_db_nq(struct bnxt_cp_ring_info *cpr)
+static inline void bnxt_native_db_nq(struct bnxt_cp_ring_info *cpr)
 {
 	uint32_t db_idx = DB_RING_IDX(&cpr->cp_db, cpr->cp_raw_cons);
 	uint64_t key_idx = cpr->cp_db.db_key64 | DBR_TYPE_NQ | db_idx;
@@ -158,8 +174,13 @@ static inline void bnxt_db_nq(struct bnxt_cp_ring_info *cpr)
 	rte_write64(key_idx, doorbell);
 }
 
+static inline void bnxt_db_nq(struct bnxt_cp_ring_info *cpr)
+{
+	bnxt_native_db_nq(cpr);
+}
+
 /* Ring an NQ doorbell and enable interrupts for the ring. */
-static inline void bnxt_db_nq_arm(struct bnxt_cp_ring_info *cpr)
+static inline void bnxt_native_db_nq_arm(struct bnxt_cp_ring_info *cpr)
 {
 	uint32_t db_idx = DB_RING_IDX(&cpr->cp_db, cpr->cp_raw_cons);
 	uint64_t key_idx = cpr->cp_db.db_key64 | DBR_TYPE_NQ_ARM | db_idx;
@@ -171,7 +192,12 @@ static inline void bnxt_db_nq_arm(struct bnxt_cp_ring_info *cpr)
 	rte_write64(key_idx, doorbell);
 }
 
-static inline void bnxt_db_cq(struct bnxt_cp_ring_info *cpr)
+static inline void bnxt_db_nq_arm(struct bnxt_cp_ring_info *cpr)
+{
+	bnxt_native_db_nq_arm(cpr);
+}
+
+static inline void bnxt_native_db_cq(struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_db_info *db = &cpr->cp_db;
 	uint32_t idx = DB_RING_IDX(&cpr->cp_db, cpr->cp_raw_cons);
@@ -190,7 +216,12 @@ static inline void bnxt_db_cq(struct bnxt_cp_ring_info *cpr)
 	}
 }
 
-static inline void bnxt_db_mpc_cq(struct bnxt_cp_ring_info *cpr)
+static inline void bnxt_db_cq(struct bnxt_cp_ring_info *cpr)
+{
+	bnxt_native_db_cq(cpr);
+}
+
+static inline void bnxt_native_db_mpc_cq(struct bnxt_cp_ring_info *cpr)
 {
 	struct bnxt_db_info *db = &cpr->cp_db;
 	uint32_t idx = DB_RING_IDX(&cpr->cp_db, cpr->cp_raw_cons);
@@ -210,4 +241,16 @@ static inline void bnxt_db_mpc_cq(struct bnxt_cp_ring_info *cpr)
 	}
 }
 
+static inline void bnxt_db_mpc_cq(struct bnxt_cp_ring_info *cpr)
+{
+	bnxt_native_db_mpc_cq(cpr);
+}
+
+void bnxt_native_set_db(struct bnxt *bp,
+			struct bnxt_db_info *db,
+			uint32_t ring_type,
+			uint32_t map_idx,
+			uint32_t fid,
+			uint32_t ring_mask,
+			uint16_t dpi);
 #endif
diff --git a/drivers/net/bnxt/meson.build b/drivers/net/bnxt/meson.build
index dc122fb3df..858cd929dc 100644
--- a/drivers/net/bnxt/meson.build
+++ b/drivers/net/bnxt/meson.build
@@ -32,6 +32,8 @@ deps += ['hash']
 
 sources = files(
         'bnxt_cpr.c',
+        'bnxt_drv_map.c',
+        'bnxt_drv_native.c',
         'bnxt_ethdev.c',
         'bnxt_filter.c',
         'bnxt_flow.c',
-- 
2.47.3

