Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37504CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:17:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AB7E34067E;
	Fri, 10 Oct 2025 00:16:09 +0200 (CEST)
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com
 [209.85.166.99]) by mails.dpdk.org (Postfix) with ESMTP id 0E1AB4067E
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:08 +0200 (CEST)
Received: by mail-io1-f99.google.com with SMTP id
 ca18e2360f4ac-938de0df471so130884539f.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048167; x=1760652967;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=evXn1Po3u4Zg9dslae6RTUJRvpOnxMVUNIhji4HfOnQ=;
 b=n5eQ9DcWsRtIo6Jo69z3oazijFx7sEmSJMMITLwHOSjbTNNvxFJ/t3vJ+mx6eLaUCA
 z2KjhveJrk2aXgI1migFosUGMlLkW+E2V0/9Z4vlDOdvrTmkZS0VCvzjlpOt9/ycp655
 KjL2HXEMxsP1opdsM2JlG4i/HTdrPjTC/ebWxkib06/jenyq5+SgpOnjZvANVgD2WL52
 v1R9L0GhjAqrWf9SiHq80aDhJ2IRsR3nPjxT2hFC9Lo8dvB1Yz/1HZz/fbFTXIw709mE
 PCfzt5J+3SZ0Y5fL1jABUBDGbwlEji5ScE8fAc6P/EiRxz48VKzV5ffxQMuCF961hu1O
 di5Q==
X-Gm-Message-State: AOJu0YxReGPhXcaHhyfdsJz2gkZjhb634a0uIGLwrE1Lv9S+fbnALwK5
 clYvQp1m1/Op7kHzZsilPOwu/N9UsScZr+1BubnubkWDOI1Ob3wsWApGZFFF6tzbdNXjOE25QXK
 zCGXGd8K6UVNTJw/D3t7eXivp9KlnvK/kNRNQ3vaqZVKhDwacLU7YX168V9YF5sIV42FXcmhr7V
 smQkYvvC77NrkTnZ4tgP9P6nApcq6oTZrt45JuAgHSqV3qB7Qj5T78Hi7AVbHUYLsvxD4Mfw==
X-Gm-Gg: ASbGncuIvdmlDaXeEYhJD1scKa4wZ4pC+w4XXVlgi/rjP+xJvlWfiukx3RRTB/9aNeb
 hJbOt10Bex5dizB4i0+vBClZjrVxf+xjoPNQ7idFfNV5spwAhBmiMC08CgxB7BbxGnjFJCI3jNH
 qA8WaQwQ5te2d9LFS563+wyIveiXfmcmBtwy1o+0kfxpJ5TF5VJw/BMXV5NdL5YJtdxK7iJVTC6
 dpmw/7rYYvoox9irMq4iEunXqj22hUUm+2hiQp95OAHCdzvkp5oSsOUgJmdqkoEm/K29UxBFdf4
 cQpJ2exNv/qlXZuZZsJUpH4z4btZMvuC4E1/cKBiUCK36i1Xyfq2kMSaMsLdKQMeUwUgu0ge5hI
 omzYII3n5qT6Z4Srkx1/UMdw594+KmK5VGSAj9HGPDR0MQdGTzmiYZB7PH+mY9hyDnmwXOiWJPt
 s65rCl
X-Google-Smtp-Source: AGHT+IFK34YwG41QOVHIdsESAz42b8YrwsuzN3wTuaYTRbNoQe/1cYJVwxn5TIFBd2Ui7GvW4rmOBm0sIrW/
X-Received: by 2002:a05:6602:1411:b0:93b:ae89:52da with SMTP id
 ca18e2360f4ac-93bd1933dacmr1125070539f.10.1760048167147; 
 Thu, 09 Oct 2025 15:16:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-93e25a748e3sm5100939f.13.2025.10.09.15.16.05
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-818c83e607bso28027196d6.2
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048165; x=1760652965; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evXn1Po3u4Zg9dslae6RTUJRvpOnxMVUNIhji4HfOnQ=;
 b=QeNFx0m/bDULhVvN1JPo8QctGTGmh3z/2+V7YZxmBfjTAR12jl8pPjai5toM95QlsD
 kgkARUHM3IVpfHBxIWA5pxtowPO1skJRtLcBUTitxnEKu6/1JgRUlgwsWoVgFzQI+kZ8
 Xeuxu0QFkyrPtyZrfM9lHWXDVWRn7xOqbJShc=
X-Received: by 2002:a05:6214:d6b:b0:820:a83:ead4 with SMTP id
 6a1803df08f44-87b20fede09mr118106196d6.1.1760048163635; 
 Thu, 09 Oct 2025 15:16:03 -0700 (PDT)
X-Received: by 2002:a05:6214:d6b:b0:820:a83:ead4 with SMTP id
 6a1803df08f44-87b20fede09mr118104686d6.1.1760048161719; 
 Thu, 09 Oct 2025 15:16:01 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:00 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
 Peter Spreadborough <peter.spreadborough@broadcom.com>,
 Jay Ding <jay.ding@broadcom.com>, Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v2 29/54] net/bnxt/tf_core: add backing store debug to dpdk
Date: Thu,  9 Oct 2025 18:11:04 -0400
Message-Id: <20251009221129.28256-30-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251009221129.28256-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
 <20251009221129.28256-1-manish.kurup@broadcom.com>
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

From: Peter Spreadborough <peter.spreadborough@broadcom.com>

This change updates the existing backing store debug by
adding more decode to EM entries and adding wildcard entry debug.
A new cli command has also been added to exercise the function that
loops through all ports and table scopes so that a single call
can dump and decode all backing stores.

Signed-off-by: Peter Spreadborough <peter.spreadborough@broadcom.com>
Reviewed-by: Jay Ding <jay.ding@broadcom.com>
Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/meson.build      |    3 +-
 drivers/net/bnxt/tf_core/v3/tfc_debug.h      |   12 +-
 drivers/net/bnxt/tf_core/v3/tfc_em.h         |   98 +-
 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c  | 1411 +++++++++++++
 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c  |  565 ------
 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c | 1875 ++++++++++++++++++
 drivers/net/bnxt/tf_core/v3/tfo.c            |   32 +
 drivers/net/bnxt/tf_core/v3/tfo.h            |   14 +
 drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h       |    5 +
 drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c     |    1 -
 drivers/net/bnxt/tf_ulp/ulp_flow_db.c        |    4 +-
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c         |    1 -
 drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c     |    1 -
 13 files changed, 3437 insertions(+), 585 deletions(-)
 create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
 delete mode 100644 drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
 create mode 100644 drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c

diff --git a/drivers/net/bnxt/tf_core/v3/meson.build b/drivers/net/bnxt/tf_core/v3/meson.build
index 159e7a2b17..8d62e14274 100644
--- a/drivers/net/bnxt/tf_core/v3/meson.build
+++ b/drivers/net/bnxt/tf_core/v3/meson.build
@@ -21,7 +21,8 @@ sources += files(
         'tfc_idx_tbl.c',
         'tfc_if_tbl.c',
         'tfc_init.c',
-        'tfc_mpc_table.c',
+        'tfc_mpc_debug.c',
+        'tfc_tcam_debug.c',
         'tfc_msg.c',
         'tfc_priv.c',
         'tfc_resources.c',
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_debug.h b/drivers/net/bnxt/tf_core/v3/tfc_debug.h
index 0a4a0b4846..86492f3a69 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_debug.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_debug.h
@@ -7,6 +7,7 @@
 #define _TFC_DEBUG_H_
 
 /* #define EM_DEBUG */
+/* #define WC_DEBUG */
 /* #define ACT_DEBUG */
 
 int tfc_mpc_table_write_zero(struct tfc *tfcp,
@@ -16,13 +17,18 @@ int tfc_mpc_table_write_zero(struct tfc *tfcp,
 			     uint32_t offset,
 			     uint8_t words,
 			     uint8_t *data);
-
-int tfc_act_show(struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir);
-int tfc_em_show(struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir);
+const char *get_lrec_opcode_str(uint8_t opcode);
+void act_show(FILE *fd, struct act_info_t *act_info, uint32_t offset);
+int tfc_em_show(FILE *fd, struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir);
+int tfc_wc_show(FILE *fd, struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir);
 int tfc_mpc_table_invalidate(struct tfc *tfcp,
 			     uint8_t tsid,
 			     enum cfa_dir dir,
 			     uint32_t type,
 			     uint32_t offset,
 			     uint32_t words);
+void act_process(uint32_t act_rec_ptr,
+		 struct act_info_t *act_info,
+		 struct tfc_ts_mem_cfg *act_mem_cfg);
+void tfc_backing_store_dump(FILE *fd);
 #endif
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_em.h b/drivers/net/bnxt/tf_core/v3/tfc_em.h
index 9ad3ef9fd2..52589ea9c3 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_em.h
+++ b/drivers/net/bnxt/tf_core/v3/tfc_em.h
@@ -61,6 +61,86 @@ enum tfc_mpc_cmd_type {
 
 #define TFC_BUCKET_ENTRIES 6
 
+/* MPC opaque currently unused */
+#define TFC_MPC_OPAQUE_VAL 0
+
+#define TFC_MOD_STRING_LENGTH  512
+#define TFC_STAT_STRING_LENGTH 128
+#define TFC_ENC_STRING_LENGTH  256
+
+struct act_compact_info_t {
+	bool drop;
+	uint8_t vlan_del_rep;
+	uint8_t dest_op;
+	uint16_t vnic_vport;
+	uint8_t decap_func;
+	uint8_t mirror;
+	uint16_t meter_ptr;
+	uint8_t stat0_ctr_type;
+	bool stat0_ing_egr;
+	uint8_t stat0_offs;
+	uint8_t mod_offs;
+	uint8_t enc_offs;
+	uint8_t src_offs;
+	char mod_str[512];
+	char stat0_str[128];
+	char enc_str[256];
+};
+
+struct act_full_info_t {
+	bool drop;
+	uint8_t vlan_del_rep;
+	uint8_t dest_op;
+	uint16_t vnic_vport;
+	uint8_t decap_func;
+	uint16_t mirror;
+	uint16_t meter_ptr;
+	uint8_t stat0_ctr_type;
+	bool stat0_ing_egr;
+	uint32_t stat0_ptr;
+	uint8_t stat1_ctr_type;
+	bool stat1_ing_egr;
+	uint32_t stat1_ptr;
+	uint32_t mod_ptr;
+	uint32_t enc_ptr;
+	uint32_t src_ptr;
+	char mod_str[512];
+	char stat0_str[128];
+	char stat1_str[128];
+	char enc_str[256];
+};
+
+struct act_mcg_info_t {
+	uint8_t src_ko_en;
+	uint32_t nxt_ptr;
+	uint8_t act_hint0;
+	uint32_t act_rec_ptr0;
+	uint8_t act_hint1;
+	uint32_t act_rec_ptr1;
+	uint8_t act_hint2;
+	uint32_t act_rec_ptr2;
+	uint8_t act_hint3;
+	uint32_t act_rec_ptr3;
+	uint8_t act_hint4;
+	uint32_t act_rec_ptr4;
+	uint8_t act_hint5;
+	uint32_t act_rec_ptr5;
+	uint8_t act_hint6;
+	uint32_t act_rec_ptr6;
+	uint8_t act_hint7;
+	uint32_t act_rec_ptr7;
+};
+
+struct act_info_t {
+	bool valid;
+	uint8_t vector;
+	union {
+		struct act_compact_info_t compact;
+		struct act_full_info_t full;
+		struct act_mcg_info_t mcg;
+	};
+};
+
 struct em_info_t {
 	bool valid;
 	uint8_t rec_size;
@@ -69,12 +149,9 @@ struct em_info_t {
 	uint8_t opcode;
 	uint8_t strength;
 	uint8_t act_hint;
-
-	uint32_t act_rec_ptr; /* Not FAST */
-
-	uint32_t destination; /* Just FAST */
-
-	uint8_t tcp_direction; /* Just CT */
+	uint32_t act_rec_ptr;	/* Not FAST */
+	uint32_t destination;	/* Just FAST */
+	uint8_t tcp_direction;	/* Just CT */
 	uint8_t tcp_update_en;
 	uint8_t tcp_win;
 	uint32_t tcp_msb_loc;
@@ -82,23 +159,20 @@ struct em_info_t {
 	uint8_t tcp_msb_opp_init;
 	uint8_t state;
 	uint8_t timer_value;
-
-	uint16_t ring_table_idx; /* Not CT and not RECYCLE */
+	uint16_t ring_table_idx;	/* Not CT and not RECYCLE */
 	uint8_t act_rec_size;
 	uint8_t paths_m1;
 	uint8_t fc_op;
 	uint8_t fc_type;
 	uint32_t fc_ptr;
-
-	uint8_t recycle_dest; /* Just Recycle */
+	uint8_t recycle_dest;	/* Just Recycle */
 	uint8_t prof_func;
 	uint8_t meta_prof;
 	uint32_t metadata;
-
 	uint8_t range_profile;
 	uint16_t range_index;
-
 	uint8_t *key;
+	struct act_info_t act_info;
 };
 
 struct sb_entry_t {
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c b/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
new file mode 100644
index 0000000000..f0512c41cc
--- /dev/null
+++ b/drivers/net/bnxt/tf_core/v3/tfc_mpc_debug.c
@@ -0,0 +1,1411 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2019-2021 Broadcom
+ * All rights reserved.
+ */
+#include <stdio.h>
+#include <inttypes.h>
+#include <math.h>
+#include <string.h>
+
+#include "bnxt.h"
+#include "bnxt_mpc.h"
+
+#include "tfc.h"
+#include "cfa_bld_mpc_field_ids.h"
+#include "cfa_bld_mpcops.h"
+#include "tfo.h"
+#include "tfc_em.h"
+#include "tfc_cpm.h"
+#include "tfc_msg.h"
+#include "tfc_debug.h"
+#include "cfa_types.h"
+#include "cfa_mm.h"
+#include "sys_util.h"
+#include "cfa_bld.h"
+#include "tfc_util.h"
+
+int tfc_mpc_table_read(struct tfc *tfcp,
+		       uint8_t tsid,
+		       enum cfa_dir dir,
+		       uint32_t type,
+		       uint32_t offset,
+		       uint8_t words,
+		       uint8_t *data,
+		       uint8_t debug)
+{
+	int rc = 0;
+	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES];
+	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
+	uint16_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
+	int i;
+	uint32_t buff_len;
+	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_READ_CMD_MAX_FLD];
+	struct cfa_mpc_data_obj fields_cmp[CFA_BLD_MPC_READ_CMP_MAX_FLD];
+	struct bnxt_mpc_mbuf mpc_msg_in;
+	struct bnxt_mpc_mbuf mpc_msg_out;
+	bool is_shared;
+	struct cfa_bld_mpcinfo *mpc_info;
+	uint64_t host_address;
+	uint8_t discard_data[128];
+	uint32_t set;
+	uint32_t way;
+	bool valid;
+
+	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
+
+	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	if (rc != 0) {
+		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
+		return -EINVAL;
+	}
+	if (!valid) {
+		PMD_DRV_LOG_LINE(ERR, "tsid not allocated %d", tsid);
+		return -EINVAL;
+	}
+
+	/* Check that data pointer is word aligned */
+	if (((uint64_t)data)  & 0x1fULL) {
+		PMD_DRV_LOG_LINE(ERR, "Table read data pointer not word aligned");
+		return -EINVAL;
+	}
+
+	host_address = (uint64_t)rte_mem_virt2iova(data);
+
+	/* Check that MPC APIs are bound */
+	if (mpc_info->mpcops == NULL) {
+		PMD_DRV_LOG_LINE(ERR, "MPC not initialized");
+		return -EINVAL;
+	}
+
+	set =  offset & 0x7ff;
+	way = (offset >> 12)  & 0xf;
+
+	if (debug)
+		PMD_DRV_LOG_LINE(ERR,
+				 "Debug read table type:%s %d words32B at way:%d set:%d debug:%d words32B",
+				 (type  == 0 ? "Lookup" : "Action"),
+				 words, way, set, debug);
+	else
+		PMD_DRV_LOG_LINE(ERR,
+				 "Reading table type:%s %d words32B at offset %d words32B",
+				 (type  == 0 ? "Lookup" : "Action"),
+				 words, offset);
+
+	/* Create MPC EM insert command using builder */
+	for (i = 0; i < CFA_BLD_MPC_READ_CMD_MAX_FLD; i++)
+		fields_cmd[i].field_id = INVALID_U16;
+
+	fields_cmd[CFA_BLD_MPC_READ_CMD_OPAQUE_FLD].field_id =
+		CFA_BLD_MPC_READ_CMD_OPAQUE_FLD;
+	fields_cmd[CFA_BLD_MPC_READ_CMD_OPAQUE_FLD].val = 0xAA;
+
+	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_TYPE_FLD].field_id =
+		CFA_BLD_MPC_READ_CMD_TABLE_TYPE_FLD;
+	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_TYPE_FLD].val = (type == 0 ?
+	       CFA_BLD_MPC_HW_TABLE_TYPE_LOOKUP : CFA_BLD_MPC_HW_TABLE_TYPE_ACTION);
+
+	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_SCOPE_FLD].field_id =
+		CFA_BLD_MPC_READ_CMD_TABLE_SCOPE_FLD;
+	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_SCOPE_FLD].val =
+		(debug ? way : tsid);
+
+	fields_cmd[CFA_BLD_MPC_READ_CMD_DATA_SIZE_FLD].field_id =
+		CFA_BLD_MPC_READ_CMD_DATA_SIZE_FLD;
+	fields_cmd[CFA_BLD_MPC_READ_CMD_DATA_SIZE_FLD].val = words;
+
+	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_INDEX_FLD].field_id =
+		CFA_BLD_MPC_READ_CMD_TABLE_INDEX_FLD;
+	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_INDEX_FLD].val =
+		(debug ? set : offset);
+
+	fields_cmd[CFA_BLD_MPC_READ_CMD_HOST_ADDRESS_FLD].field_id =
+		CFA_BLD_MPC_READ_CMD_HOST_ADDRESS_FLD;
+	fields_cmd[CFA_BLD_MPC_READ_CMD_HOST_ADDRESS_FLD].val = host_address;
+
+	if (debug) {
+		fields_cmd[CFA_BLD_MPC_READ_CMD_CACHE_OPTION_FLD].field_id =
+		CFA_BLD_MPC_READ_CMD_CACHE_OPTION_FLD;
+		fields_cmd[CFA_BLD_MPC_READ_CMD_CACHE_OPTION_FLD].val = debug; /* Debug read */
+	}
+
+	buff_len = TFC_MPC_MAX_TX_BYTES;
+
+	rc = mpc_info->mpcops->cfa_bld_mpc_build_cache_read(tx_msg,
+							    &buff_len,
+							    fields_cmd);
+
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "Action read build failed: %d", rc);
+		goto cleanup;
+	}
+
+	/* Send MPC */
+	mpc_msg_in.chnl_id = (dir == CFA_DIR_TX ?
+			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_TE_CFA :
+			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_RE_CFA);
+	mpc_msg_in.msg_data = &tx_msg[16];
+	mpc_msg_in.msg_size = 16;
+	mpc_msg_out.cmp_type = CMPL_BASE_TYPE_MID_PATH_SHORT;
+	mpc_msg_out.msg_data = &rx_msg[16];
+	mpc_msg_out.msg_size = TFC_MPC_MAX_RX_BYTES;
+
+	rc = tfc_mpc_send(tfcp->bp,
+			  &mpc_msg_in,
+			  &mpc_msg_out,
+			  &msg_count,
+			  TFC_MPC_TABLE_READ,
+			  NULL);
+
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "Table read MPC send failed: %d", rc);
+		goto cleanup;
+	}
+
+		/* Process response */
+	for (i = 0; i < CFA_BLD_MPC_READ_CMP_MAX_FLD; i++)
+		fields_cmp[i].field_id = INVALID_U16;
+
+	fields_cmp[CFA_BLD_MPC_READ_CMP_STATUS_FLD].field_id =
+		CFA_BLD_MPC_READ_CMP_STATUS_FLD;
+
+	rc = mpc_info->mpcops->cfa_bld_mpc_parse_cache_read(rx_msg,
+							    mpc_msg_out.msg_size,
+							    discard_data,
+							    words * TFC_MPC_BYTES_PER_WORD,
+							    fields_cmp);
+
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "Table read parse failed: %d", rc);
+		goto cleanup;
+	}
+
+	if (fields_cmp[CFA_BLD_MPC_READ_CMP_STATUS_FLD].val != CFA_BLD_MPC_OK) {
+		PMD_DRV_LOG_LINE(ERR, "Table read failed with status code:%d",
+				 (uint32_t)fields_cmp[CFA_BLD_MPC_READ_CMP_STATUS_FLD].val);
+		rc = -1;
+		goto cleanup;
+	}
+
+	return 0;
+
+ cleanup:
+
+	return rc;
+}
+
+int tfc_mpc_table_write_zero(struct tfc *tfcp,
+			     uint8_t tsid,
+			     enum cfa_dir dir,
+			     uint32_t type,
+			     uint32_t offset,
+			     uint8_t words,
+			     uint8_t *data)
+{
+	int rc = 0;
+	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES];
+	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
+	uint16_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
+	int i;
+	uint32_t buff_len;
+	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_WRITE_CMD_MAX_FLD];
+	struct cfa_mpc_data_obj fields_cmp[CFA_BLD_MPC_WRITE_CMP_MAX_FLD];
+	struct bnxt_mpc_mbuf mpc_msg_in;
+	struct bnxt_mpc_mbuf mpc_msg_out;
+	struct cfa_bld_mpcinfo *mpc_info;
+	bool is_shared;
+	bool valid;
+
+	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
+
+	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	if (rc != 0) {
+		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
+		return -EINVAL;
+	}
+	if (!valid) {
+		PMD_DRV_LOG_LINE(ERR, "tsid not allocated %d", tsid);
+		return -EINVAL;
+	}
+	/* Check that MPC APIs are bound */
+	if (mpc_info->mpcops == NULL) {
+		PMD_DRV_LOG_LINE(ERR, " MPC not initialized");
+		return -EINVAL;
+	}
+
+	/* Create MPC EM insert command using builder */
+	for (i = 0; i < CFA_BLD_MPC_WRITE_CMD_MAX_FLD; i++)
+		fields_cmd[i].field_id = INVALID_U16;
+
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_OPAQUE_FLD].field_id =
+		CFA_BLD_MPC_WRITE_CMD_OPAQUE_FLD;
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_OPAQUE_FLD].val = 0xAA;
+
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_TYPE_FLD].field_id =
+		CFA_BLD_MPC_WRITE_CMD_TABLE_TYPE_FLD;
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_TYPE_FLD].val = (type == 0 ?
+	       CFA_BLD_MPC_HW_TABLE_TYPE_LOOKUP : CFA_BLD_MPC_HW_TABLE_TYPE_ACTION);
+
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_SCOPE_FLD].field_id =
+		CFA_BLD_MPC_WRITE_CMD_TABLE_SCOPE_FLD;
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_SCOPE_FLD].val = tsid;
+
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_DATA_SIZE_FLD].field_id =
+		CFA_BLD_MPC_WRITE_CMD_DATA_SIZE_FLD;
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_DATA_SIZE_FLD].val = words;
+
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_INDEX_FLD].field_id =
+		CFA_BLD_MPC_WRITE_CMD_TABLE_INDEX_FLD;
+	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_INDEX_FLD].val = offset;
+
+	buff_len = TFC_MPC_MAX_TX_BYTES;
+
+	rc = mpc_info->mpcops->cfa_bld_mpc_build_cache_write(tx_msg,
+							     &buff_len,
+							     data,
+							     fields_cmd);
+
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "write build failed: %d", rc);
+		goto cleanup;
+	}
+
+	/* Send MPC */
+	mpc_msg_in.chnl_id = (dir == CFA_DIR_TX ?
+			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_TE_CFA :
+			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_RE_CFA);
+	mpc_msg_in.msg_data = &tx_msg[16];
+	mpc_msg_in.msg_size = (words * TFC_MPC_BYTES_PER_WORD) + 16;
+	mpc_msg_out.cmp_type = CMPL_BASE_TYPE_MID_PATH_SHORT;
+	mpc_msg_out.msg_data = &rx_msg[16];
+	mpc_msg_out.msg_size = TFC_MPC_MAX_RX_BYTES;
+
+	rc = tfc_mpc_send(tfcp->bp,
+			  &mpc_msg_in,
+			  &mpc_msg_out,
+			  &msg_count,
+			  TFC_MPC_TABLE_WRITE,
+			  NULL);
+
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "write MPC send failed: %d", rc);
+		goto cleanup;
+	}
+
+	/* Process response */
+	for (i = 0; i < CFA_BLD_MPC_WRITE_CMP_MAX_FLD; i++)
+		fields_cmp[i].field_id = INVALID_U16;
+
+	fields_cmp[CFA_BLD_MPC_WRITE_CMP_STATUS_FLD].field_id =
+		CFA_BLD_MPC_WRITE_CMP_STATUS_FLD;
+
+	rc = mpc_info->mpcops->cfa_bld_mpc_parse_cache_write(rx_msg,
+							     mpc_msg_out.msg_size,
+							     fields_cmp);
+
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "write parse failed: %d", rc);
+		goto cleanup;
+	}
+
+	if (fields_cmp[CFA_BLD_MPC_WRITE_CMP_STATUS_FLD].val != CFA_BLD_MPC_OK) {
+		PMD_DRV_LOG_LINE(ERR, "Action write failed with status code:%d",
+				 (uint32_t)fields_cmp[CFA_BLD_MPC_WRITE_CMP_STATUS_FLD].val);
+		PMD_DRV_LOG_LINE(ERR, "Hash MSB:0x%0x",
+		       (uint32_t)fields_cmp[CFA_BLD_MPC_WRITE_CMP_HASH_MSB_FLD].val);
+		goto cleanup;
+	}
+
+	return 0;
+
+ cleanup:
+
+	return rc;
+}
+
+int tfc_mpc_table_invalidate(struct tfc *tfcp,
+			     uint8_t tsid,
+			     enum cfa_dir dir,
+			     uint32_t type,
+			     uint32_t offset,
+			     uint32_t words)
+{
+	int rc = 0;
+	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES];
+	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
+	uint16_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
+	int i;
+	uint32_t buff_len;
+	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_MAX_FLD];
+	struct cfa_mpc_data_obj fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_MAX_FLD];
+	struct bnxt_mpc_mbuf mpc_msg_in;
+	struct bnxt_mpc_mbuf mpc_msg_out;
+	struct cfa_bld_mpcinfo *mpc_info;
+	bool is_shared;
+	bool valid;
+
+	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
+
+	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	if (rc != 0) {
+		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
+		return -EINVAL;
+	}
+	if (!valid) {
+		PMD_DRV_LOG_LINE(ERR, "tsid not allocated %d", tsid);
+		return -EINVAL;
+	}
+	/* Check that MPC APIs are bound */
+	if (mpc_info->mpcops == NULL) {
+		PMD_DRV_LOG_LINE(ERR, " MPC not initialized");
+		return -EINVAL;
+	}
+
+	/* Create MPC EM insert command using builder */
+	for (i = 0; i < CFA_BLD_MPC_INVALIDATE_CMD_MAX_FLD; i++)
+		fields_cmd[i].field_id = INVALID_U16;
+
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_OPAQUE_FLD].field_id =
+		CFA_BLD_MPC_INVALIDATE_CMD_OPAQUE_FLD;
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_OPAQUE_FLD].val = 0xAA;
+
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_TYPE_FLD].field_id =
+		CFA_BLD_MPC_INVALIDATE_CMD_TABLE_TYPE_FLD;
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_TYPE_FLD].val = (type == 0 ?
+	       CFA_BLD_MPC_HW_TABLE_TYPE_LOOKUP : CFA_BLD_MPC_HW_TABLE_TYPE_ACTION);
+
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_SCOPE_FLD].field_id =
+		CFA_BLD_MPC_INVALIDATE_CMD_TABLE_SCOPE_FLD;
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_SCOPE_FLD].val = tsid;
+
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_DATA_SIZE_FLD].field_id =
+		CFA_BLD_MPC_INVALIDATE_CMD_DATA_SIZE_FLD;
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_DATA_SIZE_FLD].val = words;
+
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_INDEX_FLD].field_id =
+		CFA_BLD_MPC_INVALIDATE_CMD_TABLE_INDEX_FLD;
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_INDEX_FLD].val = offset;
+
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_CACHE_OPTION_FLD].field_id =
+		CFA_BLD_MPC_INVALIDATE_CMD_CACHE_OPTION_FLD;
+	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_CACHE_OPTION_FLD].val =
+		CFA_BLD_MPC_EV_EVICT_SCOPE_ADDRESS;
+
+	buff_len = TFC_MPC_MAX_TX_BYTES;
+
+	rc = mpc_info->mpcops->cfa_bld_mpc_build_cache_evict(tx_msg,
+							     &buff_len,
+							     fields_cmd);
+
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "evict build failed: %d", rc);
+		goto cleanup;
+	}
+
+	/* Send MPC */
+	mpc_msg_in.chnl_id = (dir == CFA_DIR_TX ?
+			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_TE_CFA :
+			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_RE_CFA);
+	mpc_msg_in.msg_data = &tx_msg[16];
+	mpc_msg_in.msg_size = 16;
+	mpc_msg_out.cmp_type = CMPL_BASE_TYPE_MID_PATH_SHORT;
+	mpc_msg_out.msg_data = &rx_msg[16];
+	mpc_msg_out.msg_size = TFC_MPC_MAX_RX_BYTES;
+
+	rc = tfc_mpc_send(tfcp->bp,
+			  &mpc_msg_in,
+			  &mpc_msg_out,
+			  &msg_count,
+			  TFC_MPC_INVALIDATE,
+			  NULL);
+
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "write MPC send failed: %d", rc);
+		goto cleanup;
+	}
+
+	/* Process response */
+	for (i = 0; i < CFA_BLD_MPC_INVALIDATE_CMP_MAX_FLD; i++)
+		fields_cmp[i].field_id = INVALID_U16;
+
+	fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_STATUS_FLD].field_id =
+		CFA_BLD_MPC_INVALIDATE_CMP_STATUS_FLD;
+
+	rc = mpc_info->mpcops->cfa_bld_mpc_parse_cache_evict(rx_msg,
+							     mpc_msg_out.msg_size,
+							     fields_cmp);
+
+	if (rc) {
+		PMD_DRV_LOG_LINE(ERR, "evict parse failed: %d", rc);
+		goto cleanup;
+	}
+
+	if (fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_STATUS_FLD].val != CFA_BLD_MPC_OK) {
+		PMD_DRV_LOG_LINE(ERR, "evict failed with status code:%d",
+				 (uint32_t)fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_STATUS_FLD].val);
+		PMD_DRV_LOG_LINE(ERR, "Hash MSB:0x%0x",
+		       (uint32_t)fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_HASH_MSB_FLD].val);
+		goto cleanup;
+	}
+
+	return 0;
+
+ cleanup:
+
+	return rc;
+}
+
+#define TFC_ACTION_SIZE_BYTES  32
+#define TFC_BUCKET_SIZE_BYTES  32
+
+#define TFC_STRING_LENGTH_32  32
+#define TFC_STRING_LENGTH_64  64
+#define TFC_STRING_LENGTH_96  96
+#define TFC_STRING_LENGTH_256 256
+
+static const char * const opcode_string[] = {
+	"NORMAL",
+	"NORMAL_RFS",
+	"FAST",
+	"FAST_RFS",
+	"CT_MISS_DEF",
+	"INVALID",
+	"CT_HIT_DEF",
+	"INVALID",
+	"RECYCLE"
+};
+
+static void act_decode(uint32_t *act_ptr,
+		       uint64_t base,
+		       struct act_info_t *act_info);
+static void stat_decode(char *str,
+			uint8_t stat_num,
+			uint8_t stat1_ctr_type,
+			uint32_t *stat_ptr);
+
+const char *get_lrec_opcode_str(uint8_t opcode)
+{
+	return opcode_string[opcode];
+}
+
+static uint64_t get_address(struct tfc_ts_mem_cfg *mem, uint32_t offset)
+{
+	uint32_t page =  offset / mem->pg_tbl[0].pg_size;
+	uint32_t adj_offset = offset % mem->pg_tbl[0].pg_size;
+	int level = 0;
+	uint64_t addr;
+
+	/*
+	 * Use the level according to the num_level of page table
+	 */
+	level = mem->num_lvl - 1;
+
+	addr = (uint64_t)mem->pg_tbl[level].pg_va_tbl[page] + adj_offset;
+
+	return addr;
+}
+
+void act_process(uint32_t act_rec_ptr,
+		 struct act_info_t *act_info,
+		 struct tfc_ts_mem_cfg *act_mem_cfg)
+{
+	uint8_t *act_ptr;
+	uint64_t base;
+	uint32_t act_offset = act_rec_ptr << 5;
+
+	base = get_address(act_mem_cfg, 0);
+	act_ptr = (uint8_t *)get_address(act_mem_cfg, act_offset);
+	act_decode((uint32_t *)act_ptr, base, act_info);
+}
+
+static void em_decode(uint32_t *em_ptr,
+		      struct em_info_t *em_info,
+		      struct tfc_ts_mem_cfg *act_mem_cfg)
+{
+	em_info->key = (uint8_t *)em_ptr;
+
+	em_ptr += (128 / 8) / 4; /* For EM records the LREC follows 128 bits of key */
+	em_info->valid = tfc_getbits(em_ptr, 127, 1);
+	em_info->rec_size = tfc_getbits(em_ptr, 125, 2);
+	em_info->epoch0 = tfc_getbits(em_ptr, 113, 12);
+	em_info->epoch1 = tfc_getbits(em_ptr, 107, 6);
+	em_info->opcode = tfc_getbits(em_ptr, 103, 4);
+	em_info->strength = tfc_getbits(em_ptr, 101, 2);
+	em_info->act_hint = tfc_getbits(em_ptr, 99, 2);
+
+	if (em_info->opcode != 2 && em_info->opcode != 3) {
+		/* All but FAST */
+		em_info->act_rec_ptr = tfc_getbits(em_ptr, 73, 26);
+		act_process(em_info->act_rec_ptr, &em_info->act_info, act_mem_cfg);
+	} else {
+		/* Just FAST */
+		em_info->destination = tfc_getbits(em_ptr, 73, 17);
+	}
+
+	if (em_info->opcode == 4 || em_info->opcode == 6) {
+		/* CT only */
+		em_info->tcp_direction = tfc_getbits(em_ptr, 72, 1);
+		em_info->tcp_update_en = tfc_getbits(em_ptr, 71, 1);
+		em_info->tcp_win = tfc_getbits(em_ptr, 66, 5);
+		em_info->tcp_msb_loc = tfc_getbits(em_ptr, 48, 18);
+		em_info->tcp_msb_opp = tfc_getbits(em_ptr, 30, 18);
+		em_info->tcp_msb_opp_init = tfc_getbits(em_ptr, 29, 1);
+		em_info->state = tfc_getbits(em_ptr, 24, 5);
+		em_info->timer_value  = tfc_getbits(em_ptr, 20, 4);
+	} else if (em_info->opcode != 8) {
+		/* Not CT and nor RECYCLE */
+		em_info->ring_table_idx = tfc_getbits(em_ptr, 64, 9);
+		em_info->act_rec_size = tfc_getbits(em_ptr, 59, 5);
+		em_info->paths_m1 = tfc_getbits(em_ptr, 55, 4);
+		em_info->fc_op  = tfc_getbits(em_ptr, 54, 1);
+		em_info->fc_type = tfc_getbits(em_ptr, 52, 2);
+		em_info->fc_ptr = tfc_getbits(em_ptr, 24, 28);
+	} else {
+		em_info->recycle_dest = tfc_getbits(em_ptr, 72, 1); /* Just Recycle */
+		em_info->prof_func = tfc_getbits(em_ptr, 64, 8);
+		em_info->meta_prof = tfc_getbits(em_ptr, 61, 3);
+		em_info->metadata = tfc_getbits(em_ptr, 29, 32);
+	}
+
+	em_info->range_profile = tfc_getbits(em_ptr, 16, 4);
+	em_info->range_index = tfc_getbits(em_ptr, 0, 16);
+}
+
+static void em_show(FILE *fd, struct em_info_t *em_info)
+{
+	int i;
+	char *line1 = NULL;
+	char *line2 = NULL;
+	char *line3 = NULL;
+	char *line4 = NULL;
+	char tmp1[TFC_STRING_LENGTH_64];
+	char tmp2[TFC_STRING_LENGTH_64];
+	char tmp3[TFC_STRING_LENGTH_64];
+	char tmp4[TFC_STRING_LENGTH_64];
+
+	line1 = rte_zmalloc("data", TFC_STRING_LENGTH_256, 8);
+	line2 = rte_zmalloc("data", TFC_STRING_LENGTH_256, 8);
+	line3 = rte_zmalloc("data", TFC_STRING_LENGTH_256, 8);
+	line4 = rte_zmalloc("data", TFC_STRING_LENGTH_256, 8);
+	if (!line1 || !line2 || !line3 || !line4) {
+		rte_free(line1);
+		rte_free(line2);
+		rte_free(line3);
+		rte_free(line4);
+		fprintf(fd, "%s: Failed to allocate temp buffer\n",
+			   __func__);
+		return;
+	}
+
+	fprintf(fd, ":LREC: opcode:%s\n", get_lrec_opcode_str(em_info->opcode));
+
+	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+-Epoch-+--+--+--+");
+	snprintf(line2, TFC_STRING_LENGTH_256, " V|rs|  0  1 |Op|St|ah|");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+----+--+--+--+--+");
+	snprintf(line4, TFC_STRING_LENGTH_256, " %1d %2d %4d %2d %2d %2d %2d ",
+		 em_info->valid,
+		 em_info->rec_size,
+		 em_info->epoch0,
+		 em_info->epoch1,
+		 em_info->opcode,
+		 em_info->strength,
+		 em_info->act_hint);
+
+	if (em_info->opcode != 2 && em_info->opcode != 3) {
+		/* All but FAST */
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "-Act Rec--+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, " Ptr      |");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "----------+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "0x%08x ",
+			 em_info->act_rec_ptr);
+	} else {
+		/* Just FAST */
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "-------+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, " Dest  |");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "-------+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "0x05%x ",
+			 em_info->destination);
+	}
+
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+
+	if (em_info->opcode == 4 || em_info->opcode == 6) {
+		/* CT only */
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "--+--+-------------TCP-------+--+---+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, "Dr|ue| Win|   lc  |   op  |oi|st|tmr|");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "--+--+----+-------+-------+--+--+---+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "%2d %2d %4d %0x5x %0x5x %2d %2d %3d ",
+			 em_info->tcp_direction,
+			 em_info->tcp_update_en,
+			 em_info->tcp_win,
+			 em_info->tcp_msb_loc,
+			 em_info->tcp_msb_opp,
+			 em_info->tcp_msb_opp_init,
+			 em_info->state,
+			 em_info->timer_value);
+	} else if (em_info->opcode != 8) {
+		/* Not CT and nor RECYCLE */
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "--+--+--+-------FC-------+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, "RI|as|pm|op|tp|     Ptr  |");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "--+--+--+--+--+----------+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "%2d %2d %2d %2d %2d 0x%08x ",
+			 em_info->ring_table_idx,
+			 em_info->act_rec_size,
+			 em_info->paths_m1,
+			 em_info->fc_op,
+			 em_info->fc_type,
+			 em_info->fc_ptr);
+	} else {
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "--+--+--+---------+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, "RD|pf|mp| cMData  |");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "--+--+--+---------+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "%2d 0x%2x %2d %08x ",
+			 em_info->recycle_dest,
+			 em_info->prof_func,
+			 em_info->meta_prof,
+			 em_info->metadata);
+	}
+
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-----Range-+\n");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "Prof|  Idx |\n");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "----+------+\n");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, "0x%02x 0x%04x\n",
+		 em_info->range_profile,
+		 em_info->range_index);
+
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+
+	fprintf(fd, "%s%s%s%s",
+		   line1,
+		   line2,
+		   line3,
+		   line4);
+
+	fputs("Key:", fd);
+	for (i = 0; i < ((em_info->rec_size + 1) * 32); i++) {
+		if (i % 32 == 0)
+			fprintf(fd, "\n%04d:  ", i);
+		fprintf(fd, "%02x", em_info->key[i]);
+	}
+	i = ((em_info->rec_size + 1) * 32);
+	fprintf(fd, "\nKey Reversed:\n%04d:  ", i - 32);
+	do {
+		i--;
+		fprintf(fd, "%02x", em_info->key[i]);
+		if (i != 0 && i % 32 == 0)
+			fprintf(fd, "\n%04d:  ", i - 32);
+	} while (i > 0);
+	fputs("\n", fd);
+
+	if (em_info->opcode != 2 && em_info->opcode != 3)
+		act_show(fd, &em_info->act_info, em_info->act_rec_ptr << 5);
+
+	rte_free(line1);
+	rte_free(line2);
+	rte_free(line3);
+	rte_free(line4);
+}
+
+struct mod_field_s {
+	uint8_t num_bits;
+	const char *name;
+};
+
+struct mod_data_s {
+	uint8_t num_fields;
+	const char *name;
+	struct mod_field_s field[4];
+};
+
+struct mod_data_s mod_data[] = {
+	{1, "Replace", {{16,  "DPort"}}},
+	{1, "Replace", {{16,  "SPort"}}},
+	{1, "Replace", {{32,  "IPv4 DIP"}}},
+	{1, "Replace", {{32,  "IPv4 SIP"}}},
+	{1, "Replace", {{128, "IPv6 DIP"}}},
+	{1, "Replace", {{128, "IPv6 SIP"}}},
+	{1, "Replace", {{48,  "SMAC"}}},
+	{1, "Replace", {{48,  "DMAC"}}},
+	{2, "Update Field",  {{16, "uf_vec"}, {32, "uf_data"}}},
+	{3, "Tunnel Modify", {{16, "tun_mv"}, {16, "tun_ex_prot"}, {16, "tun_new_prot"}}},
+	{4, "TTL Update",    {{5,  "alt_pfid"}, {12, "alt_vid"}, {10, "rsvd"}, {5, "ttl_op"}}},
+	{4, "Replace/Add Outer VLAN", {{16, "tpid"}, {3, "pri"}, {1, "de"}, {12, "vid"}}},
+	{4, "Replace/Add Inner",      {{16, "tpid"}, {3, "pri"}, {1, "de"}, {12, "vid"}}},
+	{0, "Remove outer VLAN", {{0, NULL}}},
+	{0, "Remove inner VLAN", {{0, NULL}}},
+	{4, "Metadata Update",   {{2, "md_op"}, {4, "md_prof"}, {10, "rsvd"}, {32, "md_data"}}},
+};
+
+static void mod_decode(uint32_t *data, char *mod_str)
+{
+	int i;
+	int j;
+	int k;
+	uint16_t mod_vector;
+	int32_t row_offset = 64;
+	int32_t read_offset;
+	int32_t row = 0;
+	uint32_t val[8];
+	char str[256];
+	int16_t vect;
+	uint16_t bit = 0x8000;
+
+	row_offset -= 16;
+	read_offset = row_offset;
+	mod_vector = tfc_getbits(data, read_offset, 16);
+	snprintf(mod_str,
+		 TFC_MOD_STRING_LENGTH,
+		 "\nModify Record: Vector:0x%08x\n", mod_vector);
+
+	for (vect = 15; vect >= 0; vect--) {
+		if (mod_vector & bit) {
+			snprintf(str, TFC_STRING_LENGTH_256, "%s: ", mod_data[vect].name);
+			strcat(mod_str, str);
+
+			for (i = 0; i < mod_data[vect].num_fields; i++) {
+				row_offset -= mod_data[vect].field[i].num_bits;
+				if (row_offset < 0) {
+					row++;
+					row_offset = 64 + row_offset;
+				}
+				read_offset = row_offset + (row * 64);
+
+				for (j = 0; j < mod_data[vect].field[i].num_bits / 32; j++) {
+					val[j] = tfc_getbits(data, read_offset, 32);
+					read_offset -= 32;
+				}
+
+				if (mod_data[vect].field[i].num_bits % 32) {
+					val[j] = tfc_getbits(data,
+							     read_offset,
+						     (mod_data[vect].field[i].num_bits % 32));
+					j++;
+				}
+
+				snprintf(str,
+					 TFC_STRING_LENGTH_256,
+					 "%s:0x",
+					 mod_data[vect].field[i].name);
+				strcat(mod_str, str);
+
+				switch (mod_data[vect].field[i].num_bits) {
+				case 128:
+					for (k = 0; k < 8; k++) {
+						snprintf(str,
+							 TFC_STRING_LENGTH_256,
+							 "%08x",
+							 val[k]);
+						strcat(mod_str, str);
+					}
+					break;
+				case 48:
+					snprintf(str, TFC_STRING_LENGTH_256, "%08x", val[0]);
+					strcat(mod_str, str);
+					snprintf(str,
+						 TFC_STRING_LENGTH_256,
+						 "%04x",
+						 (val[1] & 0xffff));
+					strcat(mod_str, str);
+					break;
+				case 32:
+					snprintf(str, TFC_STRING_LENGTH_256, "%08x ", val[0]);
+					strcat(mod_str, str);
+					break;
+				case 16:
+					snprintf(str, TFC_STRING_LENGTH_256, "%04x ", val[0]);
+					strcat(mod_str, str);
+					break;
+				default:
+					snprintf(str, TFC_STRING_LENGTH_256, "%04x ",
+						 (val[0] &
+						  ((1 << mod_data[vect].field[i].num_bits) - 1)));
+					strcat(mod_str, str);
+					break;
+				}
+			}
+
+			snprintf(str, TFC_STRING_LENGTH_256, "\n");
+			strcat(mod_str, str);
+		}
+
+		bit = bit >> 1;
+	}
+
+	snprintf(str, TFC_STRING_LENGTH_256, "\n");
+	strcat(mod_str, str);
+}
+
+static void enc_decode(uint32_t *data, char *enc_str)
+{
+	uint16_t vector;
+	char str[64];
+	uint32_t val[16];
+	uint32_t offset = 0;
+	uint8_t vtag;
+	uint8_t l2;
+	uint8_t l3;
+	uint8_t l4;
+	uint8_t tunnel;
+
+	vector = tfc_getbits(data, offset, 16);
+	offset += 16;
+
+	vtag = ((vector >> 2) & 0xf);
+	l2 = ((vector >> 6) & 0x1);
+	l3 = ((vector >> 7) & 0x7);
+	l4 = ((vector >> 10) & 0x7);
+	tunnel = ((vector >> 13) & 0x7);
+
+	snprintf(enc_str,
+		 TFC_ENC_STRING_LENGTH,
+		 "Encap Record: vector:0x%04x\n", vector);
+
+	snprintf(str, TFC_STRING_LENGTH_64,
+		 "Valid:%d EC:%d VTAG:0x%01x L2:%d L3:0x%01x L4:0x%01x Tunnel:0x%01x\n",
+		 (vector & 0x1),
+		 ((vector >> 1) & 0x1),
+		 vtag,
+		 l2,
+		 l3,
+		 l4,
+		 tunnel);
+
+	strcat(enc_str, str);
+
+	if (l2) { /* L2 */
+		snprintf(str, TFC_STRING_LENGTH_64, "L2:\n");
+		strcat(enc_str, str);
+
+		val[0] = tfc_getbits(data, offset, 32);
+		offset += 32;
+		val[1] = tfc_getbits(data, offset, 16);
+		offset += 16;
+
+		snprintf(str, TFC_STRING_LENGTH_64, "DMAC:0x%08x%04x\n", val[0], val[1]);
+		strcat(enc_str, str);
+	}
+
+	if (l3) { /* L3 */
+		snprintf(str, TFC_STRING_LENGTH_64, "L3:\n");
+		strcat(enc_str, str);
+	}
+
+	if (l4) { /* L4 */
+		snprintf(str, TFC_STRING_LENGTH_64, "L4:\n");
+		strcat(enc_str, str);
+	}
+
+	if (tunnel) { /* Tunnel */
+		snprintf(str, TFC_STRING_LENGTH_64, "Tunnel:\n");
+		strcat(enc_str, str);
+	}
+}
+
+static void act_decode(uint32_t *act_ptr,
+		       uint64_t base,
+		       struct act_info_t *act_info)
+{
+	if (!act_ptr || !act_info) {
+		PMD_DRV_LOG_LINE(ERR, "act_ptr %p, act_info %p", act_ptr, act_info);
+		return;
+	}
+
+	act_info->valid = false;
+	act_info->vector = tfc_getbits(act_ptr, 0, 3);
+
+	if (act_info->vector == 0 ||
+	    act_info->vector == 1 ||
+	    act_info->vector == 4)
+		act_info->valid = true;
+
+	switch (act_info->vector) {
+	case 0:
+		act_info->compact.drop = tfc_getbits(act_ptr, 3, 1);
+		act_info->compact.vlan_del_rep = tfc_getbits(act_ptr, 4, 2);
+		act_info->compact.vnic_vport = tfc_getbits(act_ptr, 6, 11);
+		act_info->compact.dest_op = tfc_getbits(act_ptr, 17, 2);
+		act_info->compact.decap_func = tfc_getbits(act_ptr, 19, 5);
+		act_info->compact.mirror = tfc_getbits(act_ptr, 24, 5);
+		act_info->compact.meter_ptr = tfc_getbits(act_ptr, 29, 10);
+		act_info->compact.stat0_offs = tfc_getbits(act_ptr, 39, 3);
+		act_info->compact.stat0_ing_egr = tfc_getbits(act_ptr, 42, 1);
+		act_info->compact.stat0_ctr_type = tfc_getbits(act_ptr, 43, 2);
+		act_info->compact.mod_offs = tfc_getbits(act_ptr, 45, 5);
+		act_info->compact.enc_offs = tfc_getbits(act_ptr, 50, 6);
+		act_info->compact.src_offs = tfc_getbits(act_ptr, 56, 4);
+
+		if (act_info->compact.mod_offs) {
+			mod_decode((uint32_t *)(act_ptr + (act_info->compact.mod_offs <<  3)),
+				   act_info->compact.mod_str);
+		}
+		if (act_info->compact.stat0_offs)
+			stat_decode(act_info->compact.stat0_str,
+				    0,
+				    act_info->compact.stat0_ctr_type,
+				    (uint32_t *)(act_ptr + (act_info->compact.stat0_offs <<  3)));
+		if (act_info->compact.enc_offs)
+			enc_decode((uint32_t *)(act_ptr + (act_info->compact.enc_offs <<  3)),
+				   act_info->compact.enc_str);
+	break;
+	case 1:
+		act_info->full.drop = tfc_getbits(act_ptr, 3, 1);
+		act_info->full.vlan_del_rep = tfc_getbits(act_ptr, 4, 2);
+		act_info->full.vnic_vport = tfc_getbits(act_ptr, 6, 11);
+		act_info->full.dest_op = tfc_getbits(act_ptr, 17, 2);
+		act_info->full.decap_func = tfc_getbits(act_ptr, 19, 5);
+		act_info->full.mirror = tfc_getbits(act_ptr, 24, 5);
+		act_info->full.meter_ptr = tfc_getbits(act_ptr, 29, 10);
+		act_info->full.stat0_ptr = tfc_getbits(act_ptr, 39, 28);
+		act_info->full.stat0_ing_egr = tfc_getbits(act_ptr, 67, 1);
+		act_info->full.stat0_ctr_type = tfc_getbits(act_ptr, 68, 2);
+		act_info->full.stat1_ptr = tfc_getbits(act_ptr, 70, 28);
+		act_info->full.stat1_ing_egr = tfc_getbits(act_ptr, 98, 1);
+		act_info->full.stat1_ctr_type = tfc_getbits(act_ptr, 99, 2);
+		act_info->full.mod_ptr = tfc_getbits(act_ptr, 101, 28);
+		act_info->full.enc_ptr = tfc_getbits(act_ptr, 129, 28);
+		act_info->full.src_ptr = tfc_getbits(act_ptr, 157, 28);
+
+		if (act_info->full.mod_ptr)
+			mod_decode((uint32_t *)(base + (act_info->full.mod_ptr <<  3)),
+				   act_info->full.mod_str);
+		if (act_info->full.stat0_ptr)
+			stat_decode(act_info->full.stat0_str,
+				    0,
+				    act_info->full.stat0_ctr_type,
+				    (uint32_t *)(base + (act_info->full.stat0_ptr <<  3)));
+		if (act_info->full.stat1_ptr)
+			stat_decode(act_info->full.stat1_str,
+				    1,
+				    act_info->full.stat1_ctr_type,
+				    (uint32_t *)(base + (act_info->full.stat1_ptr <<  3)));
+		if (act_info->full.enc_ptr)
+			enc_decode((uint32_t *)(base + (act_info->full.enc_ptr <<  3)),
+				   act_info->full.enc_str);
+	break;
+	case 4:
+		act_info->mcg.nxt_ptr = tfc_getbits(act_ptr, 6, 26);
+		act_info->mcg.act_hint0    = tfc_getbits(act_ptr, 32, 2);
+		act_info->mcg.act_rec_ptr0 = tfc_getbits(act_ptr, 34, 26);
+		act_info->mcg.act_hint1    = tfc_getbits(act_ptr, 60, 2);
+		act_info->mcg.act_rec_ptr1 = tfc_getbits(act_ptr, 62, 26);
+		act_info->mcg.act_hint2    = tfc_getbits(act_ptr, 88, 2);
+		act_info->mcg.act_rec_ptr2 = tfc_getbits(act_ptr, 90, 26);
+		act_info->mcg.act_hint3    = tfc_getbits(act_ptr, 116, 2);
+		act_info->mcg.act_rec_ptr3 = tfc_getbits(act_ptr, 118, 26);
+		act_info->mcg.act_hint4    = tfc_getbits(act_ptr, 144, 2);
+		act_info->mcg.act_rec_ptr4 = tfc_getbits(act_ptr, 146, 26);
+		act_info->mcg.act_hint5    = tfc_getbits(act_ptr, 172, 2);
+		act_info->mcg.act_rec_ptr5 = tfc_getbits(act_ptr, 174, 26);
+		act_info->mcg.act_hint6    = tfc_getbits(act_ptr, 200, 2);
+		act_info->mcg.act_rec_ptr6 = tfc_getbits(act_ptr, 202, 26);
+		act_info->mcg.act_hint7    = tfc_getbits(act_ptr, 228, 2);
+		act_info->mcg.act_rec_ptr7 = tfc_getbits(act_ptr, 230, 26);
+		break;
+	}
+}
+
+void act_show(FILE *fd, struct act_info_t *act_info, uint32_t offset)
+{
+	if (act_info->valid) {
+		switch (act_info->vector) {
+		case 0:
+			fputs("Compact Action Record\n", fd);
+			fputs("+----------+--+-+--+--+-----+--+-+------+---Stat0"
+			      "---+------+------+------+\n", fd);
+			fputs("|   Index  |V |d|dr|do|vn/p |df|m| mtp  |ct|ie| offs|"
+			      " moffs| eoffs| soffs|\n", fd);
+			fputs("+----------+--+-+--+--+-----+--+-+------+--+--+-----+"
+			      "------+------+------+\n", fd);
+
+			fprintf(fd,
+	" 0x%08x %2d %d %2d %2d 0x%03x %2d %d 0x%04x %2d %2d  0x%02x   0x%02x   0x%02x   0x%02x\n",
+				offset,
+				act_info->vector,
+				act_info->compact.drop,
+				act_info->compact.vlan_del_rep,
+				act_info->compact.dest_op,
+				act_info->compact.vnic_vport,
+				act_info->compact.decap_func,
+				act_info->compact.mirror,
+				act_info->compact.meter_ptr,
+				act_info->compact.stat0_ctr_type,
+				act_info->compact.stat0_ing_egr,
+				act_info->compact.stat0_offs,
+				act_info->compact.mod_offs,
+				act_info->compact.enc_offs,
+				act_info->compact.src_offs);
+
+		if (act_info->compact.mod_offs)
+			fprintf(fd, "%s", act_info->compact.mod_str);
+		if (act_info->compact.stat0_offs)
+			fprintf(fd, "%s", act_info->compact.stat0_str);
+		if (act_info->compact.enc_offs)
+			fprintf(fd, "%s", act_info->compact.enc_str);
+		break;
+		case 1:
+		fputs("Full Action Record\n", fd);
+		fputs("+----------+--+-+--+--+-----+--+-+------+----Stat0-------+------Stat1-----+----------+----------+----------+\n",
+		      fd);
+		fputs("|   Index  |V |d|dr|do|vn/p |df|m| mtp  |ct|ie|    ptr   |ct|ie|    ptr   |   mptr   |   eptr   |   sptr   |\n",
+		      fd);
+		fputs("+----------+--+-+--+--+-----+--+-+------+--+--+----------+--+--+----------+----------+----------+----------+\n",
+		      fd);
+
+		fprintf(fd, " 0x%08x %2d %d %2d %2d 0x%03x %2d %d 0x%04x %2d %2d 0x%08x %2d %2d 0x%08x 0x%08x 0x%08x 0x%08x\n",
+			offset,
+			act_info->vector,
+			act_info->full.drop,
+			act_info->full.vlan_del_rep,
+			act_info->full.dest_op,
+			act_info->full.vnic_vport,
+			act_info->full.decap_func,
+			act_info->full.mirror,
+			act_info->full.meter_ptr,
+			act_info->full.stat0_ctr_type,
+			act_info->full.stat0_ing_egr,
+			act_info->full.stat0_ptr,
+			act_info->full.stat1_ctr_type,
+			act_info->full.stat1_ing_egr,
+			act_info->full.stat1_ptr,
+			act_info->full.mod_ptr,
+			act_info->full.enc_ptr,
+			act_info->full.src_ptr);
+		if (act_info->full.mod_ptr)
+			fprintf(fd, "%s", act_info->full.mod_str);
+		if (act_info->full.stat0_ptr)
+			fprintf(fd, "%s", act_info->full.stat0_str);
+		if (act_info->full.stat1_ptr)
+			fprintf(fd, "%s", act_info->full.stat1_str);
+		if (act_info->full.enc_ptr)
+			fprintf(fd, "%s", act_info->full.enc_str);
+
+		break;
+		case 4:
+			fputs("Multicast Group Record\n", fd);
+			fputs("+----------+--+----------+----------+--+----------+--+----------+--+----------+--+----------+--+----------+--+----------+--+----------+--+\n",
+			      fd);
+			fputs("|   Index  |V |  NxtPtr  | ActRPtr0 |ah| ActRPtr1 |ah| ActRPtr2 |ah| ActRPtr3 |ah| ActRPtr4 |ah| ActRPtr5 |ah| ActRPtr6 |ah| ActRPtr7 |ah|\n",
+			      fd);
+			fputs("+----------+--+----------+----------+--+----------+--+----------+--+----------+--+----------+--+----------+--+----------+--+----------+--+\n",
+			      fd);
+
+		fprintf(fd, " 0x%08x %2d 0x%08x 0x%08x %2d 0x%08x %2d 0x%08x %2d 0x%08x %2d 0x%08x %2d 0x%08x %2d 0x%08x %2d 0x%08x %2d\n",
+			offset,
+			act_info->vector,
+			act_info->mcg.nxt_ptr,
+			act_info->mcg.act_rec_ptr0,
+			act_info->mcg.act_hint0,
+			act_info->mcg.act_rec_ptr1,
+			act_info->mcg.act_hint1,
+			act_info->mcg.act_rec_ptr2,
+			act_info->mcg.act_hint2,
+			act_info->mcg.act_rec_ptr3,
+			act_info->mcg.act_hint3,
+			act_info->mcg.act_rec_ptr4,
+			act_info->mcg.act_hint4,
+			act_info->mcg.act_rec_ptr5,
+			act_info->mcg.act_hint5,
+			act_info->mcg.act_rec_ptr6,
+			act_info->mcg.act_hint6,
+			act_info->mcg.act_rec_ptr7,
+			act_info->mcg.act_hint7);
+			break;
+		}
+	}
+}
+
+struct stat_fields_s {
+	uint64_t pkt_cnt;
+	uint64_t byte_cnt;
+	union {
+		struct {
+			uint32_t timestamp;
+			uint16_t tcp_flags;
+		} c_24b;
+		struct {
+			uint64_t meter_pkt_cnt;
+			uint64_t meter_byte_cnt;
+		} c_32b;
+		struct {
+			uint64_t timestamp : 32;
+			uint64_t tcp_flags : 16;
+			uint64_t meter_pkt_cnt : 38;
+			uint64_t meter_byte_cnt : 42;
+		} c_32b_all;
+	} t;
+};
+
+#define STATS_COMMON_FMT    \
+	"Stats:%d Pkt count:%016ld Byte count:%016ld\n"
+#define STATS_METER_FMT     \
+	"\tMeter pkt count:%016ld Meter byte count:%016ld\n"
+#define STATS_TCP_FLAGS_FMT \
+	"\tTCP flags:0x%04x timestamp:0x%08x\n"
+
+static void stat_decode(char *str,
+			uint8_t stat_num,
+			uint8_t stat_ctr_type,
+			uint32_t *stat_ptr)
+{
+	struct stat_fields_s *stats = (struct stat_fields_s *)stat_ptr;
+	uint64_t meter_pkt_cnt;
+	uint64_t meter_byte_cnt;
+	uint32_t timestamp;
+	char tmp0[96];
+
+	/* Common fields */
+	snprintf(str,
+		 TFC_STAT_STRING_LENGTH,
+		 STATS_COMMON_FMT,
+		 stat_num, stats->pkt_cnt, stats->byte_cnt);
+
+	switch (stat_ctr_type) {
+	case CFA_BLD_STAT_COUNTER_SIZE_16B:
+		/* Nothing further to do */
+		break;
+	case CFA_BLD_STAT_COUNTER_SIZE_24B:
+		timestamp = stats->t.c_24b.timestamp;
+		snprintf(tmp0,
+			 TFC_STRING_LENGTH_96,
+			 STATS_TCP_FLAGS_FMT,
+			 stats->t.c_24b.tcp_flags,
+			 timestamp);
+		strcat(str, tmp0);
+		break;
+	case CFA_BLD_STAT_COUNTER_SIZE_32B:
+		snprintf(tmp0,
+			 TFC_STRING_LENGTH_96,
+			 STATS_METER_FMT,
+			 stats->t.c_32b.meter_pkt_cnt,
+			 stats->t.c_32b.meter_byte_cnt);
+		strcat(str, tmp0);
+		break;
+	case CFA_BLD_STAT_COUNTER_SIZE_32B_ALL:
+		meter_pkt_cnt = stats->t.c_32b_all.meter_pkt_cnt;
+		meter_byte_cnt = stats->t.c_32b_all.meter_byte_cnt;
+		timestamp = stats->t.c_32b_all.timestamp;
+		snprintf(tmp0,
+			 TFC_STRING_LENGTH_96,
+			 STATS_METER_FMT STATS_TCP_FLAGS_FMT,
+			 meter_pkt_cnt,
+			 meter_byte_cnt,
+			 stats->t.c_32b_all.tcp_flags,
+			 timestamp);
+		strcat(str, tmp0);
+		break;
+	default:
+		       /* Should never happen since type is 2 bits in size */
+		snprintf(tmp0,
+			 TFC_STRING_LENGTH_96,
+			 "Unknown counter type %d\n", stat_ctr_type);
+		strcat(str, tmp0);
+		break;
+	}
+}
+
+static void bucket_decode(uint32_t *bucket_ptr,
+			  struct bucket_info_t *bucket_info,
+			  struct tfc_ts_mem_cfg *lkup_mem_cfg,
+			  struct tfc_ts_mem_cfg *act_mem_cfg)
+{
+	int i;
+	int offset = 0;
+	uint8_t *em_ptr;
+
+	bucket_info->valid = false;
+	bucket_info->chain = tfc_getbits(bucket_ptr, 254, 1);
+	bucket_info->chain_ptr = tfc_getbits(bucket_ptr, 228, 26);
+
+	if  (bucket_info->chain ||
+	     bucket_info->chain_ptr)
+		bucket_info->valid = true;
+
+	for (i = 0; i < TFC_BUCKET_ENTRIES; i++) {
+		bucket_info->entries[i].entry_ptr = tfc_getbits(bucket_ptr, offset, 26);
+		offset +=  26;
+		bucket_info->entries[i].hash_msb = tfc_getbits(bucket_ptr, offset, 12);
+		offset += 12;
+
+		if  (bucket_info->entries[i].hash_msb ||
+		     bucket_info->entries[i].entry_ptr) {
+			bucket_info->valid = true;
+
+			em_ptr = (uint8_t *)get_address(lkup_mem_cfg,
+							bucket_info->entries[i].entry_ptr * 32);
+			em_decode((uint32_t *)em_ptr, &bucket_info->em_info[i], act_mem_cfg);
+		}
+	}
+}
+
+static void bucket_show(FILE *fd, struct bucket_info_t *bucket_info, uint32_t offset)
+{
+	int i;
+
+	if (bucket_info->valid) {
+		fprintf(fd, "Static Bucket:0x%08x\n", offset);
+		fputs("+-+ +---------+ +----------------------------------- Entries --------------------------------------------------------------+\n",
+		      fd);
+		fputs(" C     CPtr     0                 1                 2                 3                 4                 5\n",
+		      fd);
+		fputs("+-+ +---------+ +-----+---------+ +-----+---------+ +-----+---------+ +-----+---------+ +-----+---------+ +------+---------+\n",
+		      fd);
+		fprintf(fd, " %d   0x%07x",
+			   bucket_info->chain,
+			   bucket_info->chain_ptr);
+		for (i = 0; i < TFC_BUCKET_ENTRIES; i++) {
+			fprintf(fd, "   0x%03x 0x%07x",
+				   bucket_info->entries[i].hash_msb,
+				   bucket_info->entries[i].entry_ptr);
+		}
+		fputs("\n", fd);
+
+		/*
+		 * Now display each valid EM entry from the bucket
+		 */
+		for (i = 0; i < TFC_BUCKET_ENTRIES; i++) {
+			if (bucket_info->entries[i].entry_ptr != 0) {
+				if (bucket_info->em_info[i].valid)
+					em_show(fd, &bucket_info->em_info[i]);
+				else
+					fputs("<<< Invalid LREC  >>>\n", fd);
+			}
+		}
+
+		fputs("\n", fd);
+	}
+}
+
+int tfc_em_show(FILE *fd, struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir)
+{
+	int rc = 0;
+	bool is_shared;
+	bool is_bs_owner;
+	struct tfc_ts_mem_cfg *lkup_mem_cfg;
+	struct tfc_ts_mem_cfg *act_mem_cfg;
+	uint32_t bucket_row;
+	uint32_t bucket_count;
+	uint8_t *bucket_ptr;
+	struct bucket_info_t *bucket_info;
+	uint32_t bucket_offset = 0;
+	bool valid;
+
+	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
+	if (rc != 0) {
+		fprintf(fd, "%s: failed to get tsid: %d\n",
+			   __func__, rc);
+		return -EINVAL;
+	}
+	if (!valid) {
+		fprintf(fd, "%s: tsid not allocated %d\n",
+			   __func__, tsid);
+		return -EINVAL;
+	}
+
+	lkup_mem_cfg = rte_zmalloc("data", sizeof(*lkup_mem_cfg), 8);
+	if (!lkup_mem_cfg)
+		return -ENOMEM;
+
+	rc = tfo_ts_get_mem_cfg(tfcp->tfo, tsid,
+				dir,
+				CFA_REGION_TYPE_LKUP,
+				&is_bs_owner,
+				lkup_mem_cfg);   /* Gets rec_cnt */
+	if (rc != 0) {
+		fprintf(fd, "%s: tfo_ts_get_mem_cfg() failed for LKUP: %d\n",
+			   __func__, rc);
+		rte_free(lkup_mem_cfg);
+		return -EINVAL;
+	}
+
+	act_mem_cfg = rte_zmalloc("data", sizeof(*act_mem_cfg), 8);
+	if (!act_mem_cfg) {
+		rte_free(lkup_mem_cfg);
+		return -ENOMEM;
+	}
+
+	rc = tfo_ts_get_mem_cfg(tfcp->tfo, tsid,
+				dir,
+				CFA_REGION_TYPE_ACT,
+				&is_bs_owner,
+				act_mem_cfg);   /* Gets rec_cnt */
+	if (rc != 0) {
+		fprintf(fd, "%s: tfo_ts_get_mem_cfg() failed for ACT: %d\n",
+			   __func__, rc);
+		rte_free(lkup_mem_cfg);
+		rte_free(act_mem_cfg);
+		return -EINVAL;
+	}
+
+	bucket_count = lkup_mem_cfg->lkup_rec_start_offset;
+
+	fputs(" Lookup Table\n", fd);
+	fprintf(fd, " Static bucket count:%d\n", bucket_count);
+
+	bucket_info = rte_zmalloc("data", sizeof(*bucket_info), 8);
+	if (!bucket_info) {
+		fprintf(fd, "%s: Failed to allocate bucket info struct\n",
+			   __func__);
+		rte_free(lkup_mem_cfg);
+		rte_free(act_mem_cfg);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Go through the static buckets looking for valid entries.
+	 * If a valid entry is found then  display it and also display
+	 * the EM entries it points to.
+	 */
+	for (bucket_row = 0; bucket_row < bucket_count; ) {
+		bucket_ptr = (uint8_t *)get_address(lkup_mem_cfg, bucket_offset);
+		bucket_decode((uint32_t *)bucket_ptr, bucket_info, lkup_mem_cfg, act_mem_cfg);
+
+		if (bucket_info->valid)
+			bucket_show(fd, bucket_info, bucket_offset);
+
+		bucket_offset += TFC_BUCKET_SIZE_BYTES;
+		bucket_row++;
+	}
+
+	rte_free(bucket_info);
+	rte_free(lkup_mem_cfg);
+	rte_free(act_mem_cfg);
+
+	return rc;
+}
+
+void tfc_backing_store_dump(FILE *fd)
+{
+	uint16_t port;
+	struct bnxt *bp;
+	uint8_t tsid;
+	int dir;
+
+	RTE_ETH_FOREACH_DEV(port) {
+		bp = bnxt_pmd_get_bp(port);
+		if (bp && !tfo_tsid_get(bp->tfcp.tfo, &tsid)) {
+			for (dir = 0; dir <= 1; dir++) {
+				fputs("+------------------- EM ------------------+\n", fd);
+				fprintf(fd, "+--------- Port:%d TSID:%d DIR:%s ----------+\n",
+					port, tsid, (dir == CFA_DIR_RX ? "rx" : "tx"));
+				fputs("+-----------------------------------------+\n", fd);
+				tfc_em_show(fd, &bp->tfcp, tsid, dir);
+
+				fputs("+------------------- WC ------------------+\n", fd);
+				fprintf(fd, "+--------- Port:%d TSID:%d DIR:%s ----------+\n",
+					port, tsid, (dir == CFA_DIR_RX ? "rx" : "tx"));
+				fputs("+-----------------------------------------+\n", fd);
+				tfc_wc_show(fd, &bp->tfcp, tsid, dir);
+			}
+		}
+	}
+}
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c b/drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
deleted file mode 100644
index be16d00deb..0000000000
--- a/drivers/net/bnxt/tf_core/v3/tfc_mpc_table.c
+++ /dev/null
@@ -1,565 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2019-2021 Broadcom
- * All rights reserved.
- */
-#include <stdio.h>
-#include <inttypes.h>
-#include <math.h>
-
-#include "bnxt.h"
-#include "bnxt_mpc.h"
-
-#include "tfc.h"
-#include "cfa_bld_mpc_field_ids.h"
-#include "cfa_bld_mpcops.h"
-#include "tfo.h"
-#include "tfc_em.h"
-#include "tfc_cpm.h"
-#include "tfc_msg.h"
-#include "tfc_debug.h"
-#include "cfa_types.h"
-#include "cfa_mm.h"
-#include "sys_util.h"
-#include "cfa_bld.h"
-#include "tfc_util.h"
-
-int tfc_mpc_table_read(struct tfc *tfcp,
-		       uint8_t tsid,
-		       enum cfa_dir dir,
-		       uint32_t type,
-		       uint32_t offset,
-		       uint8_t words,
-		       uint8_t *data,
-		       uint8_t debug)
-{
-	int rc = 0;
-	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES];
-	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
-	uint32_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
-	int i;
-	uint32_t buff_len;
-	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_READ_CMD_MAX_FLD];
-	struct cfa_mpc_data_obj fields_cmp[CFA_BLD_MPC_READ_CMP_MAX_FLD];
-	struct bnxt_mpc_mbuf mpc_msg_in;
-	struct bnxt_mpc_mbuf mpc_msg_out;
-	bool is_shared;
-	struct cfa_bld_mpcinfo *mpc_info;
-	uint64_t host_address;
-	uint8_t discard_data[128];
-	uint32_t set;
-	uint32_t way;
-	bool valid;
-
-	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
-
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
-	if (rc != 0) {
-		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
-		return -EINVAL;
-	}
-	if (!valid) {
-		PMD_DRV_LOG_LINE(ERR, "tsid not allocated %d", tsid);
-		return -EINVAL;
-	}
-
-	/* Check that data pointer is word aligned */
-	if (((uint64_t)data)  & 0x1fULL) {
-		PMD_DRV_LOG_LINE(ERR, "Table read data pointer not word aligned");
-		return -EINVAL;
-	}
-
-	host_address = (uint64_t)rte_mem_virt2iova(data);
-
-	/* Check that MPC APIs are bound */
-	if (mpc_info->mpcops == NULL) {
-		PMD_DRV_LOG_LINE(ERR, "MPC not initialized");
-		return -EINVAL;
-	}
-
-	set =  offset & 0x7ff;
-	way = (offset >> 12)  & 0xf;
-
-	if (debug)
-		PMD_DRV_LOG_LINE(ERR,
-				 "Debug read table type:%s %d words32B at way:%d set:%d debug:%d words32B",
-				 (type  == 0 ? "Lookup" : "Action"),
-				 words, way, set, debug);
-	else
-		PMD_DRV_LOG_LINE(ERR,
-				 "Reading table type:%s %d words32B at offset %d words32B",
-				 (type  == 0 ? "Lookup" : "Action"),
-				 words, offset);
-
-	/* Create MPC EM insert command using builder */
-	for (i = 0; i < CFA_BLD_MPC_READ_CMD_MAX_FLD; i++)
-		fields_cmd[i].field_id = INVALID_U16;
-
-	fields_cmd[CFA_BLD_MPC_READ_CMD_OPAQUE_FLD].field_id =
-		CFA_BLD_MPC_READ_CMD_OPAQUE_FLD;
-	fields_cmd[CFA_BLD_MPC_READ_CMD_OPAQUE_FLD].val = 0xAA;
-
-	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_TYPE_FLD].field_id =
-		CFA_BLD_MPC_READ_CMD_TABLE_TYPE_FLD;
-	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_TYPE_FLD].val = (type == 0 ?
-	       CFA_BLD_MPC_HW_TABLE_TYPE_LOOKUP : CFA_BLD_MPC_HW_TABLE_TYPE_ACTION);
-
-	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_SCOPE_FLD].field_id =
-		CFA_BLD_MPC_READ_CMD_TABLE_SCOPE_FLD;
-	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_SCOPE_FLD].val =
-		(debug ? way : tsid);
-
-	fields_cmd[CFA_BLD_MPC_READ_CMD_DATA_SIZE_FLD].field_id =
-		CFA_BLD_MPC_READ_CMD_DATA_SIZE_FLD;
-	fields_cmd[CFA_BLD_MPC_READ_CMD_DATA_SIZE_FLD].val = words;
-
-	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_INDEX_FLD].field_id =
-		CFA_BLD_MPC_READ_CMD_TABLE_INDEX_FLD;
-	fields_cmd[CFA_BLD_MPC_READ_CMD_TABLE_INDEX_FLD].val =
-		(debug ? set : offset);
-
-	fields_cmd[CFA_BLD_MPC_READ_CMD_HOST_ADDRESS_FLD].field_id =
-		CFA_BLD_MPC_READ_CMD_HOST_ADDRESS_FLD;
-	fields_cmd[CFA_BLD_MPC_READ_CMD_HOST_ADDRESS_FLD].val = host_address;
-
-	if (debug) {
-		fields_cmd[CFA_BLD_MPC_READ_CMD_CACHE_OPTION_FLD].field_id =
-		CFA_BLD_MPC_READ_CMD_CACHE_OPTION_FLD;
-		fields_cmd[CFA_BLD_MPC_READ_CMD_CACHE_OPTION_FLD].val = debug; /* Debug read */
-	}
-
-	buff_len = TFC_MPC_MAX_TX_BYTES;
-
-	rc = mpc_info->mpcops->cfa_bld_mpc_build_cache_read(tx_msg,
-							    &buff_len,
-							    fields_cmd);
-
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "Action read build failed: %d", rc);
-		goto cleanup;
-	}
-
-	/* Send MPC */
-	mpc_msg_in.chnl_id = (dir == CFA_DIR_TX ?
-			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_TE_CFA :
-			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_RE_CFA);
-	mpc_msg_in.msg_data = &tx_msg[16];
-	mpc_msg_in.msg_size = 16;
-	mpc_msg_out.cmp_type = CMPL_BASE_TYPE_MID_PATH_SHORT;
-	mpc_msg_out.msg_data = &rx_msg[16];
-	mpc_msg_out.msg_size = TFC_MPC_MAX_RX_BYTES;
-
-	rc = tfc_mpc_send(tfcp->bp,
-			  &mpc_msg_in,
-			  &mpc_msg_out,
-			  &msg_count,
-			  TFC_MPC_TABLE_READ,
-			  NULL);
-
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "Table read MPC send failed: %d", rc);
-		goto cleanup;
-	}
-
-		/* Process response */
-	for (i = 0; i < CFA_BLD_MPC_READ_CMP_MAX_FLD; i++)
-		fields_cmp[i].field_id = INVALID_U16;
-
-	fields_cmp[CFA_BLD_MPC_READ_CMP_STATUS_FLD].field_id =
-		CFA_BLD_MPC_READ_CMP_STATUS_FLD;
-
-	rc = mpc_info->mpcops->cfa_bld_mpc_parse_cache_read(rx_msg,
-							    mpc_msg_out.msg_size,
-							    discard_data,
-							    words * TFC_MPC_BYTES_PER_WORD,
-							    fields_cmp);
-
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "Table read parse failed: %d", rc);
-		goto cleanup;
-	}
-
-	if (fields_cmp[CFA_BLD_MPC_READ_CMP_STATUS_FLD].val != CFA_BLD_MPC_OK) {
-		PMD_DRV_LOG_LINE(ERR, "Table read failed with status code:%d",
-				 (uint32_t)fields_cmp[CFA_BLD_MPC_READ_CMP_STATUS_FLD].val);
-		rc = -1;
-		goto cleanup;
-	}
-
-	return 0;
-
- cleanup:
-
-	return rc;
-}
-
-int tfc_mpc_table_write_zero(struct tfc *tfcp,
-			     uint8_t tsid,
-			     enum cfa_dir dir,
-			     uint32_t type,
-			     uint32_t offset,
-			     uint8_t words,
-			     uint8_t *data)
-{
-	int rc = 0;
-	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES];
-	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
-	uint32_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
-	int i;
-	uint32_t buff_len;
-	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_WRITE_CMD_MAX_FLD];
-	struct cfa_mpc_data_obj fields_cmp[CFA_BLD_MPC_WRITE_CMP_MAX_FLD];
-	struct bnxt_mpc_mbuf mpc_msg_in;
-	struct bnxt_mpc_mbuf mpc_msg_out;
-	struct cfa_bld_mpcinfo *mpc_info;
-	bool is_shared;
-	bool valid;
-
-	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
-
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
-	if (rc != 0) {
-		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
-		return -EINVAL;
-	}
-	if (!valid) {
-		PMD_DRV_LOG_LINE(ERR, "tsid not allocated %d", tsid);
-		return -EINVAL;
-	}
-	/* Check that MPC APIs are bound */
-	if (mpc_info->mpcops == NULL) {
-		PMD_DRV_LOG_LINE(ERR, " MPC not initialized");
-		return -EINVAL;
-	}
-
-	/* Create MPC EM insert command using builder */
-	for (i = 0; i < CFA_BLD_MPC_WRITE_CMD_MAX_FLD; i++)
-		fields_cmd[i].field_id = INVALID_U16;
-
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_OPAQUE_FLD].field_id =
-		CFA_BLD_MPC_WRITE_CMD_OPAQUE_FLD;
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_OPAQUE_FLD].val = 0xAA;
-
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_TYPE_FLD].field_id =
-		CFA_BLD_MPC_WRITE_CMD_TABLE_TYPE_FLD;
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_TYPE_FLD].val = (type == 0 ?
-	       CFA_BLD_MPC_HW_TABLE_TYPE_LOOKUP : CFA_BLD_MPC_HW_TABLE_TYPE_ACTION);
-
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_SCOPE_FLD].field_id =
-		CFA_BLD_MPC_WRITE_CMD_TABLE_SCOPE_FLD;
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_SCOPE_FLD].val = tsid;
-
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_DATA_SIZE_FLD].field_id =
-		CFA_BLD_MPC_WRITE_CMD_DATA_SIZE_FLD;
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_DATA_SIZE_FLD].val = words;
-
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_INDEX_FLD].field_id =
-		CFA_BLD_MPC_WRITE_CMD_TABLE_INDEX_FLD;
-	fields_cmd[CFA_BLD_MPC_WRITE_CMD_TABLE_INDEX_FLD].val = offset;
-
-	buff_len = TFC_MPC_MAX_TX_BYTES;
-
-	rc = mpc_info->mpcops->cfa_bld_mpc_build_cache_write(tx_msg,
-							     &buff_len,
-							     data,
-							     fields_cmd);
-
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "write build failed: %d", rc);
-		goto cleanup;
-	}
-
-	/* Send MPC */
-	mpc_msg_in.chnl_id = (dir == CFA_DIR_TX ?
-			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_TE_CFA :
-			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_RE_CFA);
-	mpc_msg_in.msg_data = &tx_msg[16];
-	mpc_msg_in.msg_size = (words * TFC_MPC_BYTES_PER_WORD) + 16;
-	mpc_msg_out.cmp_type = CMPL_BASE_TYPE_MID_PATH_SHORT;
-	mpc_msg_out.msg_data = &rx_msg[16];
-	mpc_msg_out.msg_size = TFC_MPC_MAX_RX_BYTES;
-
-	rc = tfc_mpc_send(tfcp->bp,
-			  &mpc_msg_in,
-			  &mpc_msg_out,
-			  &msg_count,
-			  TFC_MPC_TABLE_WRITE,
-			  NULL);
-
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "write MPC send failed: %d", rc);
-		goto cleanup;
-	}
-
-	/* Process response */
-	for (i = 0; i < CFA_BLD_MPC_WRITE_CMP_MAX_FLD; i++)
-		fields_cmp[i].field_id = INVALID_U16;
-
-	fields_cmp[CFA_BLD_MPC_WRITE_CMP_STATUS_FLD].field_id =
-		CFA_BLD_MPC_WRITE_CMP_STATUS_FLD;
-
-	rc = mpc_info->mpcops->cfa_bld_mpc_parse_cache_write(rx_msg,
-							     mpc_msg_out.msg_size,
-							     fields_cmp);
-
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "write parse failed: %d", rc);
-		goto cleanup;
-	}
-
-	if (fields_cmp[CFA_BLD_MPC_WRITE_CMP_STATUS_FLD].val != CFA_BLD_MPC_OK) {
-		PMD_DRV_LOG_LINE(ERR, "Action write failed with status code:%d",
-				 (uint32_t)fields_cmp[CFA_BLD_MPC_WRITE_CMP_STATUS_FLD].val);
-		PMD_DRV_LOG_LINE(ERR, "Hash MSB:0x%0x",
-		       (uint32_t)fields_cmp[CFA_BLD_MPC_WRITE_CMP_HASH_MSB_FLD].val);
-		goto cleanup;
-	}
-
-	return 0;
-
- cleanup:
-
-	return rc;
-}
-
-int tfc_mpc_table_invalidate(struct tfc *tfcp,
-			     uint8_t tsid,
-			     enum cfa_dir dir,
-			     uint32_t type,
-			     uint32_t offset,
-			     uint32_t words)
-{
-	int rc = 0;
-	uint8_t tx_msg[TFC_MPC_MAX_TX_BYTES];
-	uint8_t rx_msg[TFC_MPC_MAX_RX_BYTES];
-	uint32_t msg_count = BNXT_MPC_COMP_MSG_COUNT;
-	int i;
-	uint32_t buff_len;
-	struct cfa_mpc_data_obj fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_MAX_FLD];
-	struct cfa_mpc_data_obj fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_MAX_FLD];
-	struct bnxt_mpc_mbuf mpc_msg_in;
-	struct bnxt_mpc_mbuf mpc_msg_out;
-	struct cfa_bld_mpcinfo *mpc_info;
-	bool is_shared;
-	bool valid;
-
-	tfo_mpcinfo_get(tfcp->tfo, &mpc_info);
-
-	rc = tfo_ts_get(tfcp->tfo, tsid, &is_shared, NULL, &valid, NULL);
-	if (rc != 0) {
-		PMD_DRV_LOG_LINE(ERR, "failed to get tsid: %s", strerror(-rc));
-		return -EINVAL;
-	}
-	if (!valid) {
-		PMD_DRV_LOG_LINE(ERR, "tsid not allocated %d", tsid);
-		return -EINVAL;
-	}
-	/* Check that MPC APIs are bound */
-	if (mpc_info->mpcops == NULL) {
-		PMD_DRV_LOG_LINE(ERR, " MPC not initialized");
-		return -EINVAL;
-	}
-
-	/* Create MPC EM insert command using builder */
-	for (i = 0; i < CFA_BLD_MPC_INVALIDATE_CMD_MAX_FLD; i++)
-		fields_cmd[i].field_id = INVALID_U16;
-
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_OPAQUE_FLD].field_id =
-		CFA_BLD_MPC_INVALIDATE_CMD_OPAQUE_FLD;
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_OPAQUE_FLD].val = 0xAA;
-
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_TYPE_FLD].field_id =
-		CFA_BLD_MPC_INVALIDATE_CMD_TABLE_TYPE_FLD;
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_TYPE_FLD].val = (type == 0 ?
-	       CFA_BLD_MPC_HW_TABLE_TYPE_LOOKUP : CFA_BLD_MPC_HW_TABLE_TYPE_ACTION);
-
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_SCOPE_FLD].field_id =
-		CFA_BLD_MPC_INVALIDATE_CMD_TABLE_SCOPE_FLD;
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_SCOPE_FLD].val = tsid;
-
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_DATA_SIZE_FLD].field_id =
-		CFA_BLD_MPC_INVALIDATE_CMD_DATA_SIZE_FLD;
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_DATA_SIZE_FLD].val = words;
-
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_INDEX_FLD].field_id =
-		CFA_BLD_MPC_INVALIDATE_CMD_TABLE_INDEX_FLD;
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_TABLE_INDEX_FLD].val = offset;
-
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_CACHE_OPTION_FLD].field_id =
-		CFA_BLD_MPC_INVALIDATE_CMD_CACHE_OPTION_FLD;
-	fields_cmd[CFA_BLD_MPC_INVALIDATE_CMD_CACHE_OPTION_FLD].val =
-		CFA_BLD_MPC_EV_EVICT_SCOPE_ADDRESS;
-
-	buff_len = TFC_MPC_MAX_TX_BYTES;
-
-	rc = mpc_info->mpcops->cfa_bld_mpc_build_cache_evict(tx_msg,
-							     &buff_len,
-							     fields_cmd);
-
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "evict build failed: %d", rc);
-		goto cleanup;
-	}
-
-	/* Send MPC */
-	mpc_msg_in.chnl_id = (dir == CFA_DIR_TX ?
-			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_TE_CFA :
-			      HWRM_RING_ALLOC_INPUT_MPC_CHNLS_TYPE_RE_CFA);
-	mpc_msg_in.msg_data = &tx_msg[16];
-	mpc_msg_in.msg_size = 16;
-	mpc_msg_out.cmp_type = CMPL_BASE_TYPE_MID_PATH_SHORT;
-	mpc_msg_out.msg_data = &rx_msg[16];
-	mpc_msg_out.msg_size = TFC_MPC_MAX_RX_BYTES;
-
-	rc = tfc_mpc_send(tfcp->bp,
-			  &mpc_msg_in,
-			  &mpc_msg_out,
-			  &msg_count,
-			  TFC_MPC_INVALIDATE,
-			  NULL);
-
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "write MPC send failed: %d", rc);
-		goto cleanup;
-	}
-
-	/* Process response */
-	for (i = 0; i < CFA_BLD_MPC_INVALIDATE_CMP_MAX_FLD; i++)
-		fields_cmp[i].field_id = INVALID_U16;
-
-	fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_STATUS_FLD].field_id =
-		CFA_BLD_MPC_INVALIDATE_CMP_STATUS_FLD;
-
-	rc = mpc_info->mpcops->cfa_bld_mpc_parse_cache_evict(rx_msg,
-							     mpc_msg_out.msg_size,
-							     fields_cmp);
-
-	if (rc) {
-		PMD_DRV_LOG_LINE(ERR, "evict parse failed: %d", rc);
-		goto cleanup;
-	}
-
-	if (fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_STATUS_FLD].val != CFA_BLD_MPC_OK) {
-		PMD_DRV_LOG_LINE(ERR, "evict failed with status code:%d",
-				 (uint32_t)fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_STATUS_FLD].val);
-		PMD_DRV_LOG_LINE(ERR, "Hash MSB:0x%0x",
-		       (uint32_t)fields_cmp[CFA_BLD_MPC_INVALIDATE_CMP_HASH_MSB_FLD].val);
-		goto cleanup;
-	}
-
-	return 0;
-
- cleanup:
-
-	return rc;
-}
-
-#define TFC_ACTION_SIZE_BYTES  32
-#define TFC_BUCKET_SIZE_BYTES  32
-
-struct act_full_info_t {
-	bool drop;
-	uint8_t vlan_del_rep;
-	uint8_t dest_op;
-	uint16_t vnic_vport;
-	uint8_t decap_func;
-	uint16_t mirror;
-	uint16_t meter_ptr;
-	uint8_t stat0_ctr_type;
-	bool stat0_ing_egr;
-	uint32_t stat0_ptr;
-	uint8_t stat1_ctr_type;
-	bool stat1_ing_egr;
-	uint32_t stat1_ptr;
-	uint32_t mod_ptr;
-	uint32_t enc_ptr;
-	uint32_t src_ptr;
-	char mod_str[512];
-};
-
-struct act_mcg_info_t {
-	uint8_t src_ko_en;
-	uint32_t nxt_ptr;
-	uint8_t act_hint0;
-	uint32_t act_rec_ptr0;
-	uint8_t act_hint1;
-	uint32_t act_rec_ptr1;
-	uint8_t act_hint2;
-	uint32_t act_rec_ptr2;
-	uint8_t act_hint3;
-	uint32_t act_rec_ptr3;
-	uint8_t act_hint4;
-	uint32_t act_rec_ptr4;
-	uint8_t act_hint5;
-	uint32_t act_rec_ptr5;
-	uint8_t act_hint6;
-	uint32_t act_rec_ptr6;
-	uint8_t act_hint7;
-	uint32_t act_rec_ptr7;
-};
-
-struct act_info_t {
-	bool valid;
-	uint8_t vector;
-	union {
-		struct act_full_info_t full;
-		struct act_mcg_info_t mcg;
-	};
-};
-
-struct mod_field_s {
-	uint8_t num_bits;
-	const char *name;
-};
-
-struct mod_data_s {
-	uint8_t num_fields;
-	const char *name;
-	struct mod_field_s field[4];
-};
-
-struct mod_data_s mod_data[] = {
-	{1, "Replace:", {{16,  "DPort"} } },
-	{1, "Replace:", {{16,  "SPort"} } },
-	{1, "Replace:", {{32,  "IPv4 DIP"} } },
-	{1, "Replace:", {{32,  "IPv4 SIP"} } },
-	{1, "Replace:", {{128, "IPv6 DIP"} } },
-	{1, "Replace:", {{128, "IPv6 SIP"} } },
-	{1, "Replace:", {{48,  "SMAC"} } },
-	{1, "Replace:", {{48,  "DMAC"} } },
-	{2, "Update Field:",  {{16, "uf_vec"}, {32, "uf_data"} } },
-	{3, "Tunnel Modify:", {{16, "tun_mv"}, {16, "tun_ex_prot"}, {16, "tun_new_prot"} } },
-	{3, "TTL Update:",    {{5,  "alt_pfid"}, {12, "alt_vid"}, {5, "ttl_op"} } },
-	{4, "Replace/Add Outer VLAN:", {{16, "tpid"}, {3, "pri"}, {1, "de"}, {12, "vid"} } },
-	{4, "Replace/Add Inner:",      {{16, "tpid"}, {3, "pri"}, {1, "de"}, {12, "vid"} } },
-	{0, "Remove outer VLAN:", {{0, NULL} } },
-	{0, "Remove inner VLAN:", {{0, NULL} } },
-	{4, "Metadata Update:",   {{2, "md_op"}, {4, "md_prof"}, {10, "rsvd"}, {32, "md_data"} } },
-};
-
-struct stat_fields_s {
-	uint64_t pkt_cnt;
-	uint64_t byte_cnt;
-	union {
-		struct __rte_packed_begin {
-			uint32_t timestamp;
-			uint16_t tcp_flags;
-		} c_24b __rte_packed_end;
-		struct {
-			uint64_t meter_pkt_cnt;
-			uint64_t meter_byte_cnt;
-		} c_32b;
-		struct __rte_packed_begin {
-			uint64_t timestamp:32;
-			uint64_t tcp_flags:16;
-			uint64_t meter_pkt_cnt:38;
-			uint64_t meter_byte_cnt:42;
-		} c_32b_all __rte_packed_end;
-	} t;
-};
-
-#define STATS_COMMON_FMT    \
-	"\tPkt count    : 0x%016" PRIu64 ", Byte count    : 0x%016" PRIu64 "\n"
-#define STATS_METER_FMT     \
-	"\tMeter pkt cnt: 0x%016" PRIx64 ", Meter byte cnt: 0x%016" PRIx64 "\n"
-#define STATS_TCP_FLAGS_FMT \
-	"\tTCP flags    : 0x%04x, timestamp     : 0x%08x\n"
diff --git a/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c b/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
new file mode 100644
index 0000000000..cff93f931f
--- /dev/null
+++ b/drivers/net/bnxt/tf_core/v3/tfc_tcam_debug.c
@@ -0,0 +1,1875 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright(c) 2024 Broadcom
+ * All rights reserved.
+ */
+#include <stdio.h>
+#include <inttypes.h>
+#include <string.h>
+
+#include "bnxt.h"
+
+#include "tfc.h"
+#include "tfo.h"
+#include "tfc_em.h"
+#include "tfc_debug.h"
+#include "cfa_types.h"
+
+#include "sys_util.h"
+#include "tfc_util.h"
+/* only debug files can include ULP headers */
+#include "ulp_flow_db.h"
+#include "bnxt_ulp_tfc.h"
+#include "bnxt_ulp_utils.h"
+#include "tfc_debug.h"
+
+#define TFC_STRING_LENGTH_32  32
+#define TFC_STRING_LENGTH_64  64
+#define TFC_STRING_LENGTH_96  96
+#define TFC_STRING_LENGTH_256 256
+
+/* Enable this flag if you want to dump all TCAM records,
+ * including the default L2 context records and profile TCAM
+ * entries. This method is sub-optimal, but can used for lack of
+ * a better way to walk and dump flow DB resources for particular
+ * flow types.
+ * Disabling this flag will dump WC TCAM entries and their
+ * associated action-records by default.
+ */
+#define TFC_DEBUG_DUMP_ALL_FLOWS 1
+
+/*
+ * Function pointer type for custom processing resources
+ */
+typedef int (*FDB_RESOURCE_PROCFUNC)(struct ulp_flow_db_res_params *rp,
+				     void *frp_ctxt);
+static
+void hex_buf_dump(FILE *fd, const char *hdr, uint8_t *msg,
+		  int msglen, int prtwidth, int linewidth);
+
+struct wc_frp_context {
+	FILE *fd;
+	struct bnxt_ulp_context *ulp_ctxt;
+	struct tfc_ts_mem_cfg *act_mem_cfg;
+};
+
+struct wc_lrec_t {
+	bool valid;
+	uint8_t rec_size;
+	uint16_t epoch0;
+	uint16_t epoch1;
+	uint8_t opcode;
+	uint8_t strength;
+	uint8_t act_hint;
+	uint32_t act_rec_ptr;	/* Not FAST */
+	uint32_t destination;	/* Just FAST */
+	uint8_t tcp_direction;	/* Just CT */
+	uint8_t tcp_update_en;
+	uint8_t tcp_win;
+	uint32_t tcp_msb_loc;
+	uint32_t tcp_msb_opp;
+	uint8_t tcp_msb_opp_init;
+	uint8_t state;
+	uint8_t timer_value;
+	uint16_t ring_table_idx;	/* Not CT and not RECYCLE */
+	uint8_t act_rec_size;
+	uint8_t paths_m1;
+	uint8_t fc_op;
+	uint8_t fc_type;
+	uint32_t fc_ptr;
+	uint8_t recycle_dest;	/* Just Recycle */
+	uint8_t prof_func;
+	uint8_t meta_prof;
+	uint32_t metadata;
+	uint8_t range_profile;
+	uint16_t range_index;
+	struct act_info_t act_info;
+};
+
+/* L2 context TCAM key formats
+ *
+ * IPv4
+ * ----
+ * valid                       255       1   TCAM entry is valid
+ * spare                       254:253   2   Spare bits.
+ * mpass_cnt                   252:251   2   Multi-pass cycle count ? {0,1,2,3}
+ * rcyc[3:0]                   250:247   4   Recycle count from prof_in
+ * loopback                    246       1   loopback input from prof_in
+ * spif                        245:244   2   Source network port from prof_in
+ * parif                       243:239   5   Partition provided by input block
+ * svif                        238:228   11  Source of the packet: Ethernet network port or
+ *                                           vnic; provided on prof_in
+ * metadata                    227:196   32  Metadata provided by Input block
+ * l2ip_func                   195:188   8   Used to create logical (feature specific) context
+ *                                           TCAM tables. Provided from ILT or Recycle.
+ * roce                        187       1   ROCE Packet detected by the Parser
+ * pure_llc                    186       1   Pure LLC Packet detected by the Parser. If set
+ *                                           the etype field will contain the DSAP/SSAP from
+ *                                           LLC header.
+ * ot_hdr_type                 185:181   5   5b encoded Outer Tunnel Type (see Table 4-12)
+ * t_hdr_type                  180:176   5   5b encoded Tunnel Type (see Table 4-12)
+ * tunnel_id/context/L4        175:144   32  Tunnel ID/Tunnel Context/L4 ports selected.
+ * ADDR0                       143:96    48  ADDR0: DMAC/SMAC/IPv4 selected.
+ * ADDR1                       95:48     48  ADDR1: DMAC/SMAC/IPv4 selected.
+ * otl2/tl2/l2_vtag_present    47        1   1+ VLAN tags present (L2 selected)
+ * otl2/tl2/l2_two_vtags       46        1   2 VLAN tags present (comp. flds_num_vtags)
+ * otl2/tl2/l2_ovlan_vid       45:34     12  VID from outer VLAN tag if present (L2 selected)
+ * otl2/tl2/l2_ovlan_tpid_sel  33:31     3   3b encoding for TPID (L2 selected)
+ * otl2/tl2/l2_ivlan_vid       30:19     12  VID from inner VLAN tag if present (L2 selected)
+ * otl2/tl2/l2_ivlan_tpid_sel  18:16     3   3b encoding for TPID (L2 selected)
+ * otl2/tl2/l2_etype           15:0      16  L2 Header Ethertype (L2 selected)
+ *
+ * IPv6
+ * ----
+ * valid                 255      1    TCAM entry is valid
+ * spare                 254:253  2    Spare bits.
+ * mpass_cnt             252:251  2    Multi-pass cycle count ? {0,1,2,3}
+ * rcyc[3:0]             250:247  4    Recycle count from prof_in
+ * loopback              246      1    loopback input from prof_in
+ * spif                  245:244  2    Source network port from prof_in
+ * parif                 243:239  5    Partition provided by input block
+ * svif                  238:228  11   Source of the packet: Ethernet network port or
+ *                                     vnic; provided on prof_in
+ * metadata              227:196  32   Metadata provided by Input block
+ * l2ip_func             195:188  8    Used to create logical (feature specific) context
+ *                                     TCAM tables. Provided from ILT or Recycle.
+ * roce                  187      1    ROCE Packet detected by the Parser
+ * pure_llc              186      1    Pure LLC Packet detected by the Parser. If set
+ *                                     the etype field will contain the DSAP/SSAP from
+ *                                     LLC header.
+ * ot_hdr_type           185:181  5    5b encoded Outer Tunnel Type (see Table 4-12)
+ * t_hdr_type            180:176  5    5b encoded Tunnel Type (see Table 4-12)
+ * tunnel_id/context/L4  175:144  32   Tunnel ID/Tunnel Context/L4 ports selected.
+ * ADDR0                 143:16   128  ADDR0: IPv6 selected.
+ * otl2/tl2/l2_etype     15:0     16   L2 Header Ethertype (L2 selected)
+ */
+struct l2ctx_tcam_key_t {
+	uint8_t valid;
+	uint8_t spare;
+	uint8_t mpass_cnt;
+	uint8_t rcyc;
+	uint8_t loopback;
+	uint8_t spif;
+	uint8_t parif;
+	uint16_t svif;
+	uint32_t metadata;
+	uint8_t l2ip_func;
+	uint8_t roce;
+	uint8_t pure_llc;
+	uint8_t ot_hdr_type;
+	uint8_t t_hdr_type;
+	uint32_t tunnel_id_context_L4;
+	union {
+		struct ipv4_key_t {
+			uint64_t ADDR0;
+			uint64_t ADDR1;
+			uint8_t otl2_tl2_l2_vtag_present;
+			uint8_t otl2_tl2_l2_two_vtags;
+			uint16_t otl2_tl2_l2_ovlan_vid;
+			uint8_t otl2_tl2_l2_ovlan_tpid_sel;
+			uint16_t otl2_tl2_l2_ivlan_vid;
+			uint8_t otl2_tl2_l2_ivlan_tpid_sel;
+			uint16_t otl2_tl2_l2_etype;
+		} ipv4;
+		struct ipv6_key_t {
+			uint64_t ADDR0[2];
+			uint16_t otl2_tl2_l2_etype;
+		} ipv6;
+	};
+};
+
+/* L2 context TCAM remap
+ *
+ * prsv_parif      126      1   Preserve incoming partition, i.e. don?t remap.
+ * parif           125:121  5   Partition. Replaces parif from Input block
+ * prsv_l2ip_ctxt  120      1   Preserve incoming l2ip_ctxt, i.e. don?t remap.
+ * l2ip_ctxt       119:109  11  May be used in EM and WC Lookups to support logical
+ *                              partitions of these tables
+ * prsv_prof_func  108      1   Preserve incoming PROF_FUNC, i.e. don?t remap.
+ * prof_func       107:100  8   Allow Profile TCAM Lookup Table to be logically partitioned.
+ * ctxt_opcode     99:98    2   0: BYPASS_CFA
+ *                              1: BYPASS_LKUP
+ *                              2: NORMAL_FLOW
+ *                              3: DROP
+ * l2ip_meta_enb   97       1   Enables remap of meta_data from Input block.
+ * l2ip_meta       96:62    35  l2ip_meta_prof[2:0] = l2ip_meta[34:32]
+ *                              l2ip_meta_data[31:0] = l2ip_meta[31:0]
+ * l2ip_act_enb    61       1   Enables remap of Action Record pointer from Input block.
+ * l2ip_act_data   60:28    33  l2ip_act_hint[1:0] = l2ip_act_data[32:31]
+ *                              l2ip_act_scope[4:0] = l2ip_act_data[30:26]
+ *                              l2ip_act_rec_ptr[25:0] = l2ip_act_data[25:0]
+ * l2ip_rfs_enb    27       1   Enables remap of ring_table_idx and sets rfs_valid.
+ * l2ip_rfs_data   26:18    9   ring_table_idx[8:0] = l2ip_rfs_data[8:0] (RX only)
+ * l2ip_dest_enb   17       1   Enables remap of destination from Input block.
+ * l2ip_dest_data  16:0     17  destination[16:0] = l2ip_dest_data[16:0]
+ */
+struct l2ctx_tcam_remap_t {
+	uint8_t prsv_parif;
+	uint8_t parif;
+	uint8_t prsv_l2ip_ctxt;
+	uint16_t l2ip_ctxt;
+	uint8_t prsv_prof_func;
+	uint8_t prof_func;
+	uint8_t ctxt_opcode;
+	uint8_t l2ip_meta_enb;
+	uint8_t l2ip_meta_prof;
+	uint32_t l2ip_meta_data;
+	uint8_t l2ip_act_enb;
+	uint8_t l2ip_act_hint;
+	uint8_t l2ip_act_scope;
+	uint32_t l2ip_act_ptr;
+	uint8_t l2ip_rfs_enb;
+	uint16_t l2ip_rfs_data;
+	uint8_t l2ip_dest_enb;
+	uint32_t l2ip_dest_data;
+	struct act_info_t act_info;
+};
+
+/* Profile TCAM key
+ *
+ * valid                 183      1  Valid(1)/Invalid(0) TCAM entry.
+ * spare                 182:181  2  Spare bits.
+ * loopback              180      1  END.loopback
+ * pkt_type              179:176  4  Packet type directly from END bus.
+ * rcyc[3:0]             175:172  4  Recycle count from prof_in
+ * metadata              171:140  32 From previous stage.
+ * agg_error             139      1  Aggregate error flag from Input stage.
+ * l2ip_func             138:131  8  L2-IP Context function from Input Lookup stage.
+ * prof_func             130:123  8  Profile function from L2-IP Context Lookup stage.
+ * hrec_next             122:121  2  From FLDS Input, General Status
+ *                                   1=tunnel/0=no tunnel
+ * int_hdr_type          120:119  2  INT header type directly from FLDS.
+ * int_hdr_group         118:117  2  INT header group directly from FLDS.
+ * int_ifa_tail          116      1  INT metadata is tail stamp.
+ * otl2_hdr_valid        115      1  !(flds_otl2_hdr_valid==stop_w_error |
+ *                                     flds_otl2_hdr_valid==not_reached)
+ * otl2_hdr_type         114:113  2  Outer Tunnel L2 header type directly from FLDS.
+ * otl2_uc_mc_bc         112:111  2  flds_otl2_dst_type remapped: UC(0)/MC(2)/BC(3)
+ * otl2_vtag_present     110      1  1+ VLAN tags present (comp. lds_otl2_num_vtags)
+ * otl2_two_vtags        109      1  2 VLAN tags present (comp. flds_otl2_num_vtags)
+ * otl3_hdr_valid        108      1  !(flds_otl3_hdr_valid== stop_w_error |
+ *                                     flds_otl3_hdr_valid== not_reached )
+ * otl3_hdr_error        107      1  flds_tl3_hdr_valid == stop_w_error
+ * otl3_hdr_type         106:103  4  Outer Tunnel L3 header type directly from FLDS.
+ * otl3_hdr_isip         102      1  Outer Tunnel L3 header is IPV4 or IPV6.
+ * otl4_hdr_valid        101      1  !(flds_otl4_hdr_valid== stop_w_error |
+ *                                     flds_otl4_hdr_valid== not_reached )
+ * otl4_hdr_error        100      1  flds_otl4_hdr_valid == stop_w_error
+ * otl4_hdr_type         99:96    4  Outer Tunnel L4 header type directly from FLDS.
+ * otl4_hdr_is_udp_tcp   95       1  OTL4 header is UDP-TCP. (comp. flds_otl4_hdr_type)
+ * ot_hdr_valid          94       1  !(flds_ot_hdr_valid== stop_w_error |
+ *                                     flds_ot_hdr_valid== not_reached )
+ * ot_hdr_error          93       1  flds_ot_hdr_valid == stop_w_error
+ * ot_hdr_type           92:88    5  Outer Tunnel header type directly from FLDS.
+ * ot_hdr_flags          87:80    8  Outer Tunnel header flags directly from FLDS.
+ * tl2_hdr_valid         79       1  !(flds_tl2_hdr_valid==stop_w_error |
+ *                                     flds_tl2_hdr_valid==not_reached)
+ * tl2_hdr_type          78:77    2  Tunnel L2 header type directly from FLDS.
+ * tl2_uc_mc_bc          76:75    2  flds_tl2_dst_type remapped: UC(0)/MC(2)/BC(3)
+ * tl2_vtag_present      74       1  1+ VLAN tags present (comp. lds_tl2_num_vtags)
+ * tl2_two_vtags         73       1  2 VLAN tags present (comp. flds_tl2_num_vtags)
+ * tl3_hdr_valid         72       1  !(flds_tl3_hdr_valid== stop_w_error |
+ *                                     flds_tl3_hdr_valid== not_reached )
+ * tl3_hdr_error         71       1  flds_tl3_hdr_valid == stop_w_error
+ * tl3_hdr_type          70:67    4  Tunnel L3 header type directly from FLDS.
+ * tl3_hdr_isip          66       1  Tunnel L3 header is IPV4 or IPV6.
+ * tl4_hdr_valid         65       1  !(flds_tl4_hdr_valid== stop_w_error |
+ *                                     flds_tl4_hdr_valid== not_reached )
+ * tl4_hdr_error         64       1  flds_tl4_hdr_valid == stop_w_error
+ * tl4_hdr_type          63:60    4  Tunnel L4 header type directly from FLDS.
+ * tl4_hdr_is_udp_tcp    59       1  TL4 header is UDP or TCP. (comp. flds_tl4_hdr_type)
+ * t_hdr_valid           58       1  !(flds_tun_hdr_valid== stop_w_error |
+ *                                     flds_tun_hdr_valid== not_reached )
+ * t_hdr_error           57       1  flds_tun_hdr_valid == stop_w_error
+ * t_hdr_type            56:52    5  Tunnel header type directly from FLDS.
+ * t_hdr_flags           51:44    8  Tunnel header flags directly from FLDS.
+ * l2_hdr_valid          43       1  !(flds_l2_hdr_valid== stop_w_error |
+ *                                     flds_l2_hdr_valid== not_reached )
+ * l2_hdr_error          42       1  flds_l2_hdr_valid == stop_w_error
+ * l2_hdr_type           41:40    2  L2 header type directly from FLDS.
+ * l2_uc_mc_bc           39:38    2  flds_l2_dst_type remapped: UC(0)/MC(2)/BC(3)
+ * l2_vtag_present       37       1  1+ VLAN tags present (comp. flds_l2_num_vtags)
+ * l2_two_vtags          36       1  2 VLAN tags present (comp. flds_l2_num_vtags)
+ * l3_hdr_valid          35       1  !(flds_l3_hdr_valid== stop_w_error |
+ *                                     flds_l3_hdr_valid== not_reached )
+ * l3_hdr_error          34       1  flds_l3_hdr_valid == stop_w_error
+ * l3_hdr_type           33:30    4  L3 header type directly from FLDS.
+ * l3_hdr_isip           29       1  L3 header is IPV4 or IPV6.
+ * l3_protocol           28:21    8  L3 header next protocol directly from FLDS.
+ * l4_hdr_valid          20       1  !(flds_l4_hdr_valid== stop_w_error |
+ *                                     flds_l4_hdr_valid== not_reached )
+ * l4_hdr_error          19       1  flds_l4_hdr_valid == stop_w_error
+ * l4_hdr_type           18:15    4  L4 header type directly from FLDS.
+ * l4_hdr_is_udp_tcp     14       1  L4 header is UDP or TCP (comp. flds_l4_hdr_type)
+ * l4_hdr_subtype        13:11    3  L4 header sub-type directly from FLDS.
+ * l4_flags              10:2     9  L4 header flags directly from FLDS.
+ * l4_dcn_present        1:0      2  DCN present bits directly from L4 header FLDS.
+ */
+
+struct prof_tcam_key_t {
+	uint8_t valid;
+	uint8_t spare;
+	uint8_t loopback;
+	uint8_t pkt_type;
+	uint8_t rcyc;
+	uint32_t metadata;
+	uint8_t agg_error;
+	uint8_t l2ip_func;
+	uint8_t prof_func;
+	uint8_t hrec_next;
+	uint8_t int_hdr_type;
+	uint8_t int_hdr_group;
+	uint8_t int_ifa_tail;
+	uint8_t otl2_hdr_valid;
+	uint8_t otl2_hdr_type;
+	uint8_t otl2_uc_mc_bc;
+	uint8_t otl2_vtag_present;
+	uint8_t otl2_two_vtags;
+	uint8_t otl3_hdr_valid;
+	uint8_t otl3_hdr_error;
+	uint8_t otl3_hdr_type;
+	uint8_t otl3_hdr_isip;
+	uint8_t otl4_hdr_valid;
+	uint8_t otl4_hdr_error;
+	uint8_t otl4_hdr_type;
+	uint8_t otl4_hdr_is_udp_tcp;
+	uint8_t ot_hdr_valid;
+	uint8_t ot_hdr_error;
+	uint8_t ot_hdr_type;
+	uint8_t ot_hdr_flags;
+	uint8_t tl2_hdr_valid;
+	uint8_t tl2_hdr_type;
+	uint8_t tl2_uc_mc_bc;
+	uint8_t tl2_vtag_present;
+	uint8_t tl2_two_vtags;
+	uint8_t tl3_hdr_valid;
+	uint8_t tl3_hdr_error;
+	uint8_t tl3_hdr_type;
+	uint8_t tl3_hdr_isip;
+	uint8_t tl4_hdr_valid;
+	uint8_t tl4_hdr_error;
+	uint8_t tl4_hdr_type;
+	uint8_t tl4_hdr_is_udp_tcp;
+	uint8_t t_hdr_valid;
+	uint8_t t_hdr_error;
+	uint8_t t_hdr_type;
+	uint8_t t_hdr_flags;
+	uint8_t l2_hdr_valid;
+	uint8_t l2_hdr_error;
+	uint8_t l2_hdr_type;
+	uint8_t l2_uc_mc_bc;
+	uint8_t l2_vtag_present;
+	uint8_t l2_two_vtags;
+	uint8_t l3_hdr_valid;
+	uint8_t l3_hdr_error;
+	uint8_t l3_hdr_type;
+	uint8_t l3_hdr_isip;
+	uint8_t l3_protocol;
+	uint8_t l4_hdr_valid;
+	uint8_t l4_hdr_error;
+	uint8_t l4_hdr_type;
+	uint8_t l4_hdr_is_udp_tcp;
+	uint8_t l4_hdr_subtype;
+	uint16_t l4_flags;
+	uint8_t l4_dcn_present;
+};
+
+/*
+ * Profile TCAM remap record:
+ *
+ * pl_byp_lkup_en   1  42     When set to ?0? remaining bits are defined below.
+ * em_search_en     1  41     Enable search in EM database
+ * em_profile_id    8  40:33  Selected key structure for EM search. This is used as part of
+ *                            the EM keys to differentiate common key types.
+ * em_key_id        7  32:26  Exact match key template select
+ * em_scope         5  25:21  Exact Match Lookup scope. Action scope on EM hit.
+ * tcam_search_en   1  20     Enable search in TCAM database
+ * tcam_profile_id  8  19:12  Selected key structure for TCAM search. This is used as part of
+ *                            the TCAM keys to differentiate common key types.
+ * tcam_key_id      7  11:5   TCAM key template select
+ * tcam_scope       5  4:0    Wild Card Lookup Action table scope (used if WC hits).
+ */
+struct prof_tcam_remap_t {
+	bool pl_byp_lkup_en;
+	bool em_search_en;
+	uint8_t em_profile_id;
+	uint8_t em_key_id;
+	uint8_t em_scope;
+	bool tcam_search_en;
+	uint8_t tcam_profile_id;
+	uint8_t tcam_key_id;
+	uint8_t tcam_scope;
+};
+
+/* Internal function to read the tcam entry */
+static int
+tfc_tcam_entry_read(struct bnxt_ulp_context *ulp_ctxt,
+		    uint8_t dir,
+		    uint8_t res_type,
+		    uint16_t res_idx,
+		    uint8_t *key,
+		    uint8_t *mask,
+		    uint8_t *remap,
+		    uint16_t *key_size,
+		    uint16_t *remap_size)
+{
+	struct tfc_tcam_info tfc_info = {0};
+	struct tfc_tcam_data tfc_data = {0};
+	struct tfc *tfcp = NULL;
+	uint16_t fw_fid;
+	int rc;
+
+	tfcp = bnxt_ulp_cntxt_tfcp_get(ulp_ctxt);
+	if (!tfcp) {
+		PMD_DRV_LOG_LINE(ERR, "Failed to get tfcp pointer");
+		return -EINVAL;
+	}
+
+	rc = bnxt_ulp_cntxt_fid_get(ulp_ctxt, &fw_fid);
+	if (rc)
+		return rc;
+
+	tfc_info.dir = dir;
+	tfc_info.rsubtype = res_type;
+	tfc_info.id = res_idx;
+
+	tfc_data.key = key;
+	tfc_data.mask = mask;
+	tfc_data.remap = remap;
+	tfc_data.key_sz_in_bytes = *key_size;
+	tfc_data.remap_sz_in_bytes = *remap_size;
+
+	if (tfc_tcam_get(tfcp, fw_fid, &tfc_info, &tfc_data)) {
+		PMD_DRV_LOG_LINE(ERR, "tcam[%s][%s][%x] read failed.",
+				 tfc_tcam_2_str(tfc_info.rsubtype),
+				 tfc_dir_2_str(tfc_info.dir), tfc_info.id);
+		return -EIO;
+	}
+
+	*key_size = (uint16_t)tfc_data.key_sz_in_bytes;
+	*remap_size = (uint16_t)tfc_data.remap_sz_in_bytes;
+
+	return rc;
+}
+
+/*
+ * bnxt_tfc_buf_dump: Pretty-prints a buffer using the following options
+ *
+ * Parameters:
+ * hdr       - A header that is printed as-is
+ * msg       - This is a pointer to the uint8_t buffer to be dumped
+ * prtwidth  - The width of the words to be printed, allowed options 1, 2, 4
+ *             Defaults to 1 if either:
+ *             1) any other value
+ *             2) if buffer length is not a multiple of width
+ * linewidth - The length of the lines printed (in items/words)
+ */
+static
+void hex_buf_dump(FILE *fd, const char *hdr, uint8_t *msg,
+		  int msglen, int prtwidth, int linewidth)
+{
+	char msg_line[128];
+	int msg_i = 0, i;
+	uint16_t *sw_msg = (uint16_t *)msg;
+	uint32_t *lw_msg = (uint32_t *)msg;
+
+	if (hdr)
+		fprintf(fd, "%s\n", hdr);
+
+	if (msglen % prtwidth) {
+		fprintf(fd, "msglen[%u] not aligned on width[%u]\n",
+			   msglen, prtwidth);
+		prtwidth = 1;
+	}
+
+	for (i = 0; i < msglen / prtwidth; i++) {
+		if ((i % linewidth == 0) && i)
+			fprintf(fd, "%s\n", msg_line);
+		if (i % linewidth == 0) {
+			msg_i = 0;
+			msg_i += snprintf(&msg_line[msg_i],
+					  (sizeof(msg_line) - msg_i),
+					  "0x%04x: ", (i * prtwidth));
+		}
+		switch (prtwidth) {
+		case 2:
+			msg_i += snprintf(&msg_line[msg_i],
+					  (sizeof(msg_line) - msg_i),
+					  "0x%04x ", sw_msg[i]);
+			break;
+
+		case 4:
+			msg_i += snprintf(&msg_line[msg_i],
+					  (sizeof(msg_line) - msg_i),
+					  "0x%08x ", lw_msg[i]);
+			break;
+
+		case 1:
+		default:
+			msg_i += snprintf(&msg_line[msg_i],
+					  (sizeof(msg_line) - msg_i),
+					  "0x%02x ", msg[i]);
+			break;
+		}
+	}
+	fprintf(fd, "%s\n", msg_line);
+}
+
+#define L2CTX_KEY_INFO_VALID(kptr)				tfc_getbits(kptr, 255, 1)
+#define L2CTX_KEY_INFO_SPARE(kptr)				tfc_getbits(kptr, 253, 2)
+#define L2CTX_KEY_INFO_MPASS_CNT(kptr)				tfc_getbits(kptr, 251, 2)
+#define L2CTX_KEY_INFO_RCYC(kptr)				tfc_getbits(kptr, 247, 4)
+#define L2CTX_KEY_INFO_LOOPBACK(kptr)				tfc_getbits(kptr, 246, 1)
+#define L2CTX_KEY_INFO_SPIF(kptr)				tfc_getbits(kptr, 244, 2)
+#define L2CTX_KEY_INFO_PARIF(kptr)				tfc_getbits(kptr, 239, 5)
+#define L2CTX_KEY_INFO_SVIF(kptr)				tfc_getbits(kptr, 228, 11)
+#define L2CTX_KEY_INFO_METADATA(kptr)				tfc_getbits(kptr, 196, 32)
+#define L2CTX_KEY_INFO_L2IP_FUNC(kptr)				tfc_getbits(kptr, 188, 8)
+#define L2CTX_KEY_INFO_ROCE(kptr)				tfc_getbits(kptr, 187, 1)
+#define L2CTX_KEY_INFO_PURE_LLC(kptr)				tfc_getbits(kptr, 186, 1)
+#define L2CTX_KEY_INFO_OT_HDR_TYPE(kptr)			tfc_getbits(kptr, 181, 5)
+#define L2CTX_KEY_INFO_T_HDR_TYPE(kptr)				tfc_getbits(kptr, 176, 5)
+#define L2CTX_KEY_INFO_TUNNEL_ID_CONTEXT_L4(kptr)		tfc_getbits(kptr, 144, 32)
+
+#define L2CTX_KEY_INFO_IPV6_ADDR0_1(kptr)			tfc_getbits(kptr, 80, 64)
+#define L2CTX_KEY_INFO_IPV6_ADDR0_0(kptr)			tfc_getbits(kptr, 16, 64)
+#define L2CTX_KEY_INFO_IPV6_OTL2_TL2_L2_ETYPE(kptr)		tfc_getbits(kptr, 0, 16)
+
+#define L2CTX_KEY_INFO_IPV4_ADDR0(kptr)				tfc_getbits(kptr, 96, 48)
+#define L2CTX_KEY_INFO_IPV4_ADDR1(kptr)				tfc_getbits(kptr, 48, 48)
+#define L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_VTAG_PRESENT(kptr)	tfc_getbits(kptr, 47, 1)
+#define L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_TWO_VTAGS(kptr)		tfc_getbits(kptr, 46, 1)
+#define L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_OVLAN_VID(kptr)		tfc_getbits(kptr, 34, 12)
+#define L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_OVLAN_TPID_SEL(kptr)	tfc_getbits(kptr, 31, 3)
+#define L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_IVLAN_VID(kptr)		tfc_getbits(kptr, 19, 12)
+#define L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_IVLAN_TPID_SEL(kptr)	tfc_getbits(kptr, 16, 3)
+#define L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_ETYPE(kptr)		tfc_getbits(kptr, 0, 16)
+
+static void l2ctx_tcam_key_decode(uint32_t *l2ctx_key_ptr,
+				  struct l2ctx_tcam_key_t *l2ctx_key_info)
+{
+	l2ctx_key_info->valid                = L2CTX_KEY_INFO_VALID(l2ctx_key_ptr);
+	l2ctx_key_info->spare                = L2CTX_KEY_INFO_SPARE(l2ctx_key_ptr);
+	l2ctx_key_info->mpass_cnt            = L2CTX_KEY_INFO_MPASS_CNT(l2ctx_key_ptr);
+	l2ctx_key_info->rcyc                 = L2CTX_KEY_INFO_RCYC(l2ctx_key_ptr);
+	l2ctx_key_info->loopback             = L2CTX_KEY_INFO_LOOPBACK(l2ctx_key_ptr);
+	l2ctx_key_info->spif                 = L2CTX_KEY_INFO_SPIF(l2ctx_key_ptr);
+	l2ctx_key_info->parif                = L2CTX_KEY_INFO_PARIF(l2ctx_key_ptr);
+	l2ctx_key_info->svif                 = L2CTX_KEY_INFO_SVIF(l2ctx_key_ptr);
+	l2ctx_key_info->metadata             = L2CTX_KEY_INFO_METADATA(l2ctx_key_ptr);
+	l2ctx_key_info->l2ip_func            = L2CTX_KEY_INFO_L2IP_FUNC(l2ctx_key_ptr);
+	l2ctx_key_info->roce                 = L2CTX_KEY_INFO_ROCE(l2ctx_key_ptr);
+	l2ctx_key_info->pure_llc             = L2CTX_KEY_INFO_PURE_LLC(l2ctx_key_ptr);
+	l2ctx_key_info->ot_hdr_type          = L2CTX_KEY_INFO_OT_HDR_TYPE(l2ctx_key_ptr);
+	l2ctx_key_info->t_hdr_type           = L2CTX_KEY_INFO_T_HDR_TYPE(l2ctx_key_ptr);
+	l2ctx_key_info->tunnel_id_context_L4 = L2CTX_KEY_INFO_TUNNEL_ID_CONTEXT_L4(l2ctx_key_ptr);
+
+	if (l2ctx_key_info->t_hdr_type == 0x5 ||
+	    l2ctx_key_info->ot_hdr_type == 0x5) {
+		l2ctx_key_info->ipv6.ADDR0[1] = L2CTX_KEY_INFO_IPV6_ADDR0_1(l2ctx_key_ptr);
+		l2ctx_key_info->ipv6.ADDR0[0] = L2CTX_KEY_INFO_IPV6_ADDR0_0(l2ctx_key_ptr);
+		l2ctx_key_info->ipv6.otl2_tl2_l2_etype =
+					L2CTX_KEY_INFO_IPV6_OTL2_TL2_L2_ETYPE(l2ctx_key_ptr);
+	} else {
+		l2ctx_key_info->ipv4.ADDR0 = L2CTX_KEY_INFO_IPV4_ADDR0(l2ctx_key_ptr);
+		l2ctx_key_info->ipv4.ADDR1 = L2CTX_KEY_INFO_IPV4_ADDR1(l2ctx_key_ptr);
+		l2ctx_key_info->ipv4.otl2_tl2_l2_vtag_present =
+				L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_VTAG_PRESENT(l2ctx_key_ptr);
+		l2ctx_key_info->ipv4.otl2_tl2_l2_two_vtags =
+				L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_TWO_VTAGS(l2ctx_key_ptr);
+		l2ctx_key_info->ipv4.otl2_tl2_l2_ovlan_vid =
+				L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_OVLAN_VID(l2ctx_key_ptr);
+		l2ctx_key_info->ipv4.otl2_tl2_l2_ovlan_tpid_sel =
+				L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_OVLAN_TPID_SEL(l2ctx_key_ptr);
+		l2ctx_key_info->ipv4.otl2_tl2_l2_ivlan_vid =
+				L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_IVLAN_VID(l2ctx_key_ptr);
+		l2ctx_key_info->ipv4.otl2_tl2_l2_ivlan_tpid_sel =
+				L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_IVLAN_TPID_SEL(l2ctx_key_ptr);
+		l2ctx_key_info->ipv4.otl2_tl2_l2_etype =
+				L2CTX_KEY_INFO_IPV4_OTL2_TL2_L2_ETYPE(l2ctx_key_ptr);
+	}
+}
+
+#define L2CTX_RMP_INFO_PRSV_PARIF(kptr)      tfc_getbits(l2ctx_rmp_ptr, 126, 1)
+#define L2CTX_RMP_INFO_PARIF(kptr)           tfc_getbits(l2ctx_rmp_ptr, 121, 5)
+#define L2CTX_RMP_INFO_PRSV_L2IP_CTXT(kptr)  tfc_getbits(l2ctx_rmp_ptr, 120, 1)
+#define L2CTX_RMP_INFO_L2IP_CTXT(kptr)       tfc_getbits(l2ctx_rmp_ptr, 109, 11)
+#define L2CTX_RMP_INFO_PRSV_PROF_FUNC(kptr)  tfc_getbits(l2ctx_rmp_ptr, 108, 1)
+#define L2CTX_RMP_INFO_PROF_FUNC(kptr)       tfc_getbits(l2ctx_rmp_ptr, 100, 8)
+#define L2CTX_RMP_INFO_CTXT_OPCODE(kptr)     tfc_getbits(l2ctx_rmp_ptr, 98, 2)
+#define L2CTX_RMP_INFO_L2IP_META_ENB(kptr)   tfc_getbits(l2ctx_rmp_ptr, 97, 1)
+#define L2CTX_RMP_INFO_L2IP_META_PROF(kptr)  tfc_getbits(l2ctx_rmp_ptr, 94, 3)
+#define L2CTX_RMP_INFO_L2IP_META_DATA(kptr)  tfc_getbits(l2ctx_rmp_ptr, 62, 32)
+#define L2CTX_RMP_INFO_L2IP_ACT_ENB(kptr)    tfc_getbits(l2ctx_rmp_ptr, 61, 1)
+#define L2CTX_RMP_INFO_L2IP_ACT_HINT(kptr)   tfc_getbits(l2ctx_rmp_ptr, 59, 2)
+#define L2CTX_RMP_INFO_L2IP_ACT_SCOPE(kptr)  tfc_getbits(l2ctx_rmp_ptr, 54, 5)
+#define L2CTX_RMP_INFO_L2IP_ACT_PTR(kptr)    tfc_getbits(l2ctx_rmp_ptr, 28, 26)
+#define L2CTX_RMP_INFO_L2IP_RFS_ENB(kptr)    tfc_getbits(l2ctx_rmp_ptr, 27, 1)
+#define L2CTX_RMP_INFO_L2IP_RFS_DATA(kptr)   tfc_getbits(l2ctx_rmp_ptr, 18, 9)
+#define L2CTX_RMP_INFO_L2IP_DEST_ENB(kptr)   tfc_getbits(l2ctx_rmp_ptr, 17, 1)
+#define L2CTX_RMP_INFO_L2IP_DEST_DATA(kptr)  tfc_getbits(l2ctx_rmp_ptr, 0, 17)
+
+static void l2ctx_tcam_remap_decode(uint32_t *l2ctx_rmp_ptr,
+				    struct l2ctx_tcam_remap_t *l2ctx_rmp_info,
+				    struct tfc_ts_mem_cfg *act_mem_cfg)
+{
+	l2ctx_rmp_info->prsv_parif      = L2CTX_RMP_INFO_PRSV_PARIF(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->parif           = L2CTX_RMP_INFO_PARIF(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->prsv_l2ip_ctxt  = L2CTX_RMP_INFO_PRSV_L2IP_CTXT(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_ctxt       = L2CTX_RMP_INFO_L2IP_CTXT(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->prsv_prof_func  = L2CTX_RMP_INFO_PRSV_PROF_FUNC(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->prof_func       = L2CTX_RMP_INFO_PROF_FUNC(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->ctxt_opcode     = L2CTX_RMP_INFO_CTXT_OPCODE(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_meta_enb   = L2CTX_RMP_INFO_L2IP_META_ENB(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_meta_prof  = L2CTX_RMP_INFO_L2IP_META_PROF(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_meta_data  = L2CTX_RMP_INFO_L2IP_META_DATA(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_act_enb    = L2CTX_RMP_INFO_L2IP_ACT_ENB(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_act_hint   = L2CTX_RMP_INFO_L2IP_ACT_HINT(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_act_scope  = L2CTX_RMP_INFO_L2IP_ACT_SCOPE(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_act_ptr    = L2CTX_RMP_INFO_L2IP_ACT_PTR(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_rfs_enb    = L2CTX_RMP_INFO_L2IP_RFS_ENB(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_rfs_data   = L2CTX_RMP_INFO_L2IP_RFS_DATA(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_dest_enb   = L2CTX_RMP_INFO_L2IP_DEST_ENB(l2ctx_rmp_ptr);
+	l2ctx_rmp_info->l2ip_dest_data  = L2CTX_RMP_INFO_L2IP_DEST_DATA(l2ctx_rmp_ptr);
+	act_process(l2ctx_rmp_info->l2ip_act_ptr, &l2ctx_rmp_info->act_info, act_mem_cfg);
+}
+
+static void l2ctx_tcam_show(FILE *fd,
+			    struct l2ctx_tcam_key_t *l2ctx_key_info,
+			    struct l2ctx_tcam_key_t *l2ctx_mask_info,
+			    struct l2ctx_tcam_remap_t *l2ctx_rmp_info)
+{
+	char *line1 = NULL;
+	char *line2 = NULL;
+	char *line3 = NULL;
+	char *line4 = NULL;
+	char *line5 = NULL;
+
+	line1 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line2 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line3 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line4 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line5 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	if (!line1 || !line2 || !line3 || !line4 || !line5) {
+		rte_free(line1);
+		rte_free(line2);
+		rte_free(line3);
+		rte_free(line4);
+		rte_free(line5);
+		fprintf(fd, "%s: Failed to allocate temp buffer\n",
+			__func__);
+		return;
+	}
+
+	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+---+----+---+----+-----+----+---------"
+		 "+------+----+----+---+---+----------+\n");
+	snprintf(line2, TFC_STRING_LENGTH_256, "|V|Sp|mpc|rcyc|lbk|spif|parif|svif| metadata"
+		 "|l2func|roce|pllc|OTH| TH|TID/ctx/L4|\n");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+---+----+---+----+-----+----+---------"
+		 "+------+----+----+---+---+----------+\n");
+	snprintf(line4, TFC_STRING_LENGTH_256, " %01x  %01x  %01x   x%01x   %01x    %01x   x%02x"
+		 "  x%03x x%08x   x%02x    %01x    %01x  x%02x x%02x  x%08x  key\n",
+		 l2ctx_key_info->valid,
+		 l2ctx_key_info->spare,
+		 l2ctx_key_info->mpass_cnt,
+		 l2ctx_key_info->rcyc,
+		 l2ctx_key_info->loopback,
+		 l2ctx_key_info->spif,
+		 l2ctx_key_info->parif,
+		 l2ctx_key_info->svif,
+		 l2ctx_key_info->metadata,
+		 l2ctx_key_info->l2ip_func,
+		 l2ctx_key_info->roce,
+		 l2ctx_key_info->pure_llc,
+		 l2ctx_key_info->ot_hdr_type,
+		 l2ctx_key_info->t_hdr_type,
+		 l2ctx_key_info->tunnel_id_context_L4);
+	snprintf(line5, TFC_STRING_LENGTH_256, " %01x  %01x  %01x   x%01x   %01x    %01x   x%02x"
+		 "  x%03x x%08x   x%02x    %01x    %01x  x%02x x%02x  x%08x  mask\n",
+		 l2ctx_mask_info->valid,
+		 l2ctx_mask_info->spare,
+		 l2ctx_mask_info->mpass_cnt,
+		 l2ctx_mask_info->rcyc,
+		 l2ctx_mask_info->loopback,
+		 l2ctx_mask_info->spif,
+		 l2ctx_mask_info->parif,
+		 l2ctx_mask_info->svif,
+		 l2ctx_mask_info->metadata,
+		 l2ctx_mask_info->l2ip_func,
+		 l2ctx_mask_info->roce,
+		 l2ctx_mask_info->pure_llc,
+		 l2ctx_mask_info->ot_hdr_type,
+		 l2ctx_mask_info->t_hdr_type,
+		 l2ctx_mask_info->tunnel_id_context_L4);
+	fprintf(fd, "%s%s%s%s%s",
+		line1,
+		line2,
+		line3,
+		line5,
+		line4);
+
+	if (l2ctx_key_info->t_hdr_type == 0x5 ||
+	    l2ctx_key_info->ot_hdr_type == 0x5) {
+		snprintf(line1, TFC_STRING_LENGTH_256, "+------IPv6-------+------IPv6-------"
+			 "+-----+\n");
+		snprintf(line2, TFC_STRING_LENGTH_256, "|      ADDR0      |      ADDR1      "
+			 "|etype|\n");
+		snprintf(line3, TFC_STRING_LENGTH_256, "+-----------------+-----------------"
+			 "+-----+\n");
+		snprintf(line4, TFC_STRING_LENGTH_256, " x%016lx x%016lx x%04x  key\n",
+			 l2ctx_key_info->ipv6.ADDR0[1],
+			 l2ctx_key_info->ipv6.ADDR0[0],
+			 l2ctx_key_info->ipv6.otl2_tl2_l2_etype);
+		snprintf(line5, TFC_STRING_LENGTH_256, " x%016lx x%016lx x%04x  mask\n",
+			 l2ctx_mask_info->ipv6.ADDR0[1],
+			 l2ctx_mask_info->ipv6.ADDR0[0],
+			 l2ctx_mask_info->ipv6.otl2_tl2_l2_etype);
+	} else {
+		snprintf(line1, TFC_STRING_LENGTH_256, "+----IPv4-----+----IPv4-----+--+---"
+			 "+----+-----+----+-----+-----+\n");
+		snprintf(line2, TFC_STRING_LENGTH_256, "|    ADDR0    |    ADDR1    |VT|2VT"
+			 "|ovid|otpid|ivid|itpid|etype|\n");
+		snprintf(line3, TFC_STRING_LENGTH_256, "+-------------+-------------+--+---"
+			 "+----+-----+----+-----+-----+\n");
+		snprintf(line4, TFC_STRING_LENGTH_256, " x%012lx x%012lx  %01x  %01x  x%03x"
+			 "    %01x  x%03x   %01x   x%04x  key\n",
+			 l2ctx_key_info->ipv4.ADDR0,
+			 l2ctx_key_info->ipv4.ADDR1,
+			 l2ctx_key_info->ipv4.otl2_tl2_l2_vtag_present,
+			 l2ctx_key_info->ipv4.otl2_tl2_l2_two_vtags,
+			 l2ctx_key_info->ipv4.otl2_tl2_l2_ovlan_vid,
+			 l2ctx_key_info->ipv4.otl2_tl2_l2_ovlan_tpid_sel,
+			 l2ctx_key_info->ipv4.otl2_tl2_l2_ivlan_vid,
+			 l2ctx_key_info->ipv4.otl2_tl2_l2_ivlan_tpid_sel,
+			 l2ctx_key_info->ipv4.otl2_tl2_l2_etype);
+		snprintf(line5, TFC_STRING_LENGTH_256, " x%012lx x%012lx  %01x  %01x  x%03x"
+			 "    %01x  x%03x   %01x   x%04x  mask\n",
+			 l2ctx_mask_info->ipv4.ADDR0,
+			 l2ctx_mask_info->ipv4.ADDR1,
+			 l2ctx_mask_info->ipv4.otl2_tl2_l2_vtag_present,
+			 l2ctx_mask_info->ipv4.otl2_tl2_l2_two_vtags,
+			 l2ctx_mask_info->ipv4.otl2_tl2_l2_ovlan_vid,
+			 l2ctx_mask_info->ipv4.otl2_tl2_l2_ovlan_tpid_sel,
+			 l2ctx_mask_info->ipv4.otl2_tl2_l2_ivlan_vid,
+			 l2ctx_mask_info->ipv4.otl2_tl2_l2_ivlan_tpid_sel,
+			 l2ctx_mask_info->ipv4.otl2_tl2_l2_etype);
+	}
+	fprintf(fd, "%s%s%s%s%s",
+		   line1,
+		   line2,
+		   line3,
+		   line5,
+		   line4);
+
+	fputs(":L2CTX TCAM: remap\n", fd);
+	snprintf(line1, TFC_STRING_LENGTH_256, "+---+----+----+----+---+---+-----+---"
+		 "+-----+---------+\n");
+	snprintf(line2, TFC_STRING_LENGTH_256, "|PIP|prif|PL2C| L2C|PPF|PRF|ctxop|mde"
+		 "|mprof| metadata|\n");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+---+----+----+----+---+---+-----+---"
+		 "+-----+---------+\n");
+	snprintf(line4, TFC_STRING_LENGTH_256, "  %01x   x%02x   %01x  x%03x  %01x  x%02x"
+		 "    %01x    %01x    %01x  x%08x\n",
+		 l2ctx_rmp_info->prsv_parif,
+		 l2ctx_rmp_info->parif,
+		 l2ctx_rmp_info->prsv_l2ip_ctxt,
+		 l2ctx_rmp_info->l2ip_ctxt,
+		 l2ctx_rmp_info->prsv_prof_func,
+		 l2ctx_rmp_info->prof_func,
+		 l2ctx_rmp_info->ctxt_opcode,
+		 l2ctx_rmp_info->l2ip_meta_enb,
+		 l2ctx_rmp_info->l2ip_meta_prof,
+		 l2ctx_rmp_info->l2ip_meta_data);
+	fprintf(fd, "%s%s%s%s",
+		line1,
+		line2,
+		line3,
+		line4);
+
+	snprintf(line1, TFC_STRING_LENGTH_256, "+----+----+----+---------+----+-------"
+		 "+----+--------+\n");
+	snprintf(line2, TFC_STRING_LENGTH_256, "|acte|ahnt|ascp|   act   |rfse|rfsdata"
+		 "|dste|dst_data|\n");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+----+----+----+---------+----+-------"
+		 "+----+--------+\n");
+	snprintf(line4, TFC_STRING_LENGTH_256, "   %01x    %01x   x%02x x%08x   %01x"
+		 "    x%03x    %01x   x%05x\n",
+		 l2ctx_rmp_info->l2ip_act_enb,
+		 l2ctx_rmp_info->l2ip_act_hint,
+		 l2ctx_rmp_info->l2ip_act_scope,
+		 l2ctx_rmp_info->l2ip_act_ptr,
+		 l2ctx_rmp_info->l2ip_rfs_enb,
+		 l2ctx_rmp_info->l2ip_rfs_data,
+		 l2ctx_rmp_info->l2ip_dest_enb,
+		 l2ctx_rmp_info->l2ip_dest_data);
+	fprintf(fd, "%s%s%s%s",
+		line1,
+		line2,
+		line3,
+		line4);
+
+	act_show(fd, &l2ctx_rmp_info->act_info, l2ctx_rmp_info->l2ip_act_ptr << 5);
+
+	rte_free(line1);
+	rte_free(line2);
+	rte_free(line3);
+	rte_free(line4);
+	rte_free(line5);
+}
+
+#define PTKEY_INFO_VALID(kptr)                tfc_getbits(kptr, 183, 1)
+#define PTKEY_INFO_SPARE(kptr)                tfc_getbits(kptr, 181, 2)
+#define PTKEY_INFO_LOOPBACK(kptr)             tfc_getbits(kptr, 180, 1)
+#define PTKEY_INFO_PKT_TYPE(kptr)             tfc_getbits(kptr, 176, 4)
+#define PTKEY_INFO_RCYC(kptr)                 tfc_getbits(kptr, 172, 4)
+#define PTKEY_INFO_METADATA(kptr)             tfc_getbits(kptr, 140, 32)
+#define PTKEY_INFO_AGG_ERROR(kptr)            tfc_getbits(kptr, 139, 1)
+#define PTKEY_INFO_L2IP_FUNC(kptr)            tfc_getbits(kptr, 131, 8)
+#define PTKEY_INFO_PROF_FUNC(kptr)            tfc_getbits(kptr, 123, 8)
+#define PTKEY_INFO_HREC_NEXT(kptr)            tfc_getbits(kptr, 121, 2)
+#define PTKEY_INFO_INT_HDR_TYPE(kptr)         tfc_getbits(kptr, 119, 2)
+#define PTKEY_INFO_INT_HDR_GROUP(kptr)        tfc_getbits(kptr, 117, 2)
+#define PTKEY_INFO_INT_IFA_TAIL(kptr)         tfc_getbits(kptr, 116, 1)
+
+#define PTKEY_INFO_OTL2_HDR_VALID(kptr)       tfc_getbits(kptr, 115, 1)
+#define PTKEY_INFO_OTL2_HDR_TYPE(kptr)        tfc_getbits(kptr, 113, 2)
+#define PTKEY_INFO_OTL2_UC_MC_BC(kptr)        tfc_getbits(kptr, 111, 2)
+#define PTKEY_INFO_OTL2_VTAG_PRESENT(kptr)    tfc_getbits(kptr, 110, 1)
+#define PTKEY_INFO_OTL2_TWO_VTAGS(kptr)       tfc_getbits(kptr, 109, 1)
+
+#define PTKEY_INFO_OTL3_HDR_VALID(kptr)       tfc_getbits(kptr, 108, 1)
+#define PTKEY_INFO_OTL3_HDR_ERROR(kptr)       tfc_getbits(kptr, 107, 1)
+#define PTKEY_INFO_OTL3_HDR_TYPE(kptr)        tfc_getbits(kptr, 103, 4)
+#define PTKEY_INFO_OTL3_HDR_ISIP(kptr)        tfc_getbits(kptr, 102, 1)
+
+#define PTKEY_INFO_OTL4_HDR_VALID(kptr)       tfc_getbits(kptr, 101, 1)
+#define PTKEY_INFO_OTL4_HDR_ERROR(kptr)       tfc_getbits(kptr, 100, 1)
+#define PTKEY_INFO_OTL4_HDR_TYPE(kptr)        tfc_getbits(kptr, 96, 4)
+#define PTKEY_INFO_OTL4_HDR_IS_UDP_TCP(kptr)  tfc_getbits(kptr, 95, 1)
+
+#define PTKEY_INFO_OT_HDR_VALID(kptr)         tfc_getbits(kptr, 94, 1)
+#define PTKEY_INFO_OT_HDR_ERROR(kptr)         tfc_getbits(kptr, 93, 1)
+#define PTKEY_INFO_OT_HDR_TYPE(kptr)          tfc_getbits(kptr, 88, 5)
+#define PTKEY_INFO_OT_HDR_FLAGS(kptr)         tfc_getbits(kptr, 80, 8)
+
+#define PTKEY_INFO_TL2_HDR_VALID(kptr)        tfc_getbits(kptr, 79, 1)
+#define PTKEY_INFO_TL2_HDR_TYPE(kptr)         tfc_getbits(kptr, 77, 2)
+#define PTKEY_INFO_TL2_UC_MC_BC(kptr)         tfc_getbits(kptr, 75, 2)
+#define PTKEY_INFO_TL2_VTAG_PRESENT(kptr)     tfc_getbits(kptr, 74, 1)
+#define PTKEY_INFO_TL2_TWO_VTAGS(kptr)        tfc_getbits(kptr, 73, 1)
+
+#define PTKEY_INFO_TL3_HDR_VALID(kptr)        tfc_getbits(kptr, 72, 1)
+#define PTKEY_INFO_TL3_HDR_ERROR(kptr)        tfc_getbits(kptr, 71, 1)
+#define PTKEY_INFO_TL3_HDR_TYPE(kptr)         tfc_getbits(kptr, 67, 4)
+#define PTKEY_INFO_TL3_HDR_ISIP(kptr)         tfc_getbits(kptr, 66, 1)
+
+#define PTKEY_INFO_TL4_HDR_VALID(kptr)        tfc_getbits(kptr, 65, 1)
+#define PTKEY_INFO_TL4_HDR_ERROR(kptr)        tfc_getbits(kptr, 64, 1)
+#define PTKEY_INFO_TL4_HDR_TYPE(kptr)         tfc_getbits(kptr, 60, 4)
+#define PTKEY_INFO_TL4_HDR_IS_UDP_TCP(kptr)   tfc_getbits(kptr, 59, 1)
+
+#define PTKEY_INFO_T_HDR_VALID(kptr)          tfc_getbits(kptr, 58, 1)
+#define PTKEY_INFO_T_HDR_ERROR(kptr)          tfc_getbits(kptr, 57, 1)
+#define PTKEY_INFO_T_HDR_TYPE(kptr)           tfc_getbits(kptr, 52, 5)
+#define PTKEY_INFO_T_HDR_FLAGS(kptr)          tfc_getbits(kptr, 44, 8)
+
+#define PTKEY_INFO_L2_HDR_VALID(kptr)         tfc_getbits(kptr, 43, 1)
+#define PTKEY_INFO_L2_HDR_ERROR(kptr)         tfc_getbits(kptr, 42, 1)
+#define PTKEY_INFO_L2_HDR_TYPE(kptr)          tfc_getbits(kptr, 40, 2)
+#define PTKEY_INFO_L2_UC_MC_BC(kptr)          tfc_getbits(kptr, 38, 2)
+#define PTKEY_INFO_L2_VTAG_PRESENT(kptr)      tfc_getbits(kptr, 37, 1)
+#define PTKEY_INFO_L2_TWO_VTAGS(kptr)         tfc_getbits(kptr, 36, 1)
+
+#define PTKEY_INFO_L3_HDR_VALID(kptr)         tfc_getbits(kptr, 35, 1)
+#define PTKEY_INFO_L3_HDR_ERROR(kptr)         tfc_getbits(kptr, 34, 1)
+#define PTKEY_INFO_L3_HDR_TYPE(kptr)          tfc_getbits(kptr, 30, 4)
+#define PTKEY_INFO_L3_HDR_ISIP(kptr)          tfc_getbits(kptr, 29, 1)
+#define PTKEY_INFO_L3_PROTOCOL(kptr)          tfc_getbits(kptr, 21, 8)
+
+#define PTKEY_INFO_L4_HDR_VALID(kptr)         tfc_getbits(kptr, 20, 1)
+#define PTKEY_INFO_L4_HDR_ERROR(kptr)         tfc_getbits(kptr, 19, 1)
+#define PTKEY_INFO_L4_HDR_TYPE(kptr)          tfc_getbits(kptr, 15, 4)
+#define PTKEY_INFO_L4_HDR_IS_UDP_TCP(kptr)    tfc_getbits(kptr, 14, 1)
+#define PTKEY_INFO_L4_HDR_SUBTYPE(kptr)       tfc_getbits(kptr, 11, 3)
+#define PTKEY_INFO_L4_FLAGS(kptr)             tfc_getbits(kptr, 2, 9)
+#define PTKEY_INFO_L4_DCN_PRESENT(kptr)       tfc_getbits(kptr, 0, 2)
+
+static void prof_tcam_key_decode(uint32_t *ptc_key_ptr,
+				 struct prof_tcam_key_t *ptkey_info)
+{
+	ptkey_info->valid               = PTKEY_INFO_VALID(ptc_key_ptr);
+	ptkey_info->spare               = PTKEY_INFO_SPARE(ptc_key_ptr);
+	ptkey_info->loopback            = PTKEY_INFO_LOOPBACK(ptc_key_ptr);
+	ptkey_info->pkt_type            = PTKEY_INFO_PKT_TYPE(ptc_key_ptr);
+	ptkey_info->rcyc                = PTKEY_INFO_RCYC(ptc_key_ptr);
+	ptkey_info->metadata            = PTKEY_INFO_METADATA(ptc_key_ptr);
+	ptkey_info->agg_error           = PTKEY_INFO_AGG_ERROR(ptc_key_ptr);
+	ptkey_info->l2ip_func           = PTKEY_INFO_L2IP_FUNC(ptc_key_ptr);
+	ptkey_info->prof_func           = PTKEY_INFO_PROF_FUNC(ptc_key_ptr);
+	ptkey_info->hrec_next           = PTKEY_INFO_HREC_NEXT(ptc_key_ptr);
+	ptkey_info->int_hdr_type        = PTKEY_INFO_INT_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->int_hdr_group       = PTKEY_INFO_INT_HDR_GROUP(ptc_key_ptr);
+	ptkey_info->int_ifa_tail        = PTKEY_INFO_INT_IFA_TAIL(ptc_key_ptr);
+
+	ptkey_info->otl2_hdr_valid      = PTKEY_INFO_OTL2_HDR_VALID(ptc_key_ptr);
+	ptkey_info->otl2_hdr_type       = PTKEY_INFO_OTL2_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->otl2_uc_mc_bc       = PTKEY_INFO_OTL2_UC_MC_BC(ptc_key_ptr);
+	ptkey_info->otl2_vtag_present   = PTKEY_INFO_OTL2_VTAG_PRESENT(ptc_key_ptr);
+	ptkey_info->otl2_two_vtags      = PTKEY_INFO_OTL2_TWO_VTAGS(ptc_key_ptr);
+
+	ptkey_info->otl3_hdr_valid      = PTKEY_INFO_OTL3_HDR_VALID(ptc_key_ptr);
+	ptkey_info->otl3_hdr_error      = PTKEY_INFO_OTL3_HDR_ERROR(ptc_key_ptr);
+	ptkey_info->otl3_hdr_type       = PTKEY_INFO_OTL3_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->otl3_hdr_isip       = PTKEY_INFO_OTL3_HDR_ISIP(ptc_key_ptr);
+
+	ptkey_info->otl4_hdr_valid      = PTKEY_INFO_OTL4_HDR_VALID(ptc_key_ptr);
+	ptkey_info->otl4_hdr_error      = PTKEY_INFO_OTL4_HDR_ERROR(ptc_key_ptr);
+	ptkey_info->otl4_hdr_type       = PTKEY_INFO_OTL4_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->otl4_hdr_is_udp_tcp = PTKEY_INFO_OTL4_HDR_IS_UDP_TCP(ptc_key_ptr);
+
+	ptkey_info->ot_hdr_valid        = PTKEY_INFO_OT_HDR_VALID(ptc_key_ptr);
+	ptkey_info->ot_hdr_error        = PTKEY_INFO_OT_HDR_ERROR(ptc_key_ptr);
+	ptkey_info->ot_hdr_type         = PTKEY_INFO_OT_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->ot_hdr_flags        = PTKEY_INFO_OT_HDR_FLAGS(ptc_key_ptr);
+
+	ptkey_info->tl2_hdr_valid       = PTKEY_INFO_TL2_HDR_VALID(ptc_key_ptr);
+	ptkey_info->tl2_hdr_type        = PTKEY_INFO_TL2_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->tl2_uc_mc_bc        = PTKEY_INFO_TL2_UC_MC_BC(ptc_key_ptr);
+	ptkey_info->tl2_vtag_present    = PTKEY_INFO_TL2_VTAG_PRESENT(ptc_key_ptr);
+	ptkey_info->tl2_two_vtags       = PTKEY_INFO_TL2_TWO_VTAGS(ptc_key_ptr);
+
+	ptkey_info->tl3_hdr_valid       = PTKEY_INFO_TL3_HDR_VALID(ptc_key_ptr);
+	ptkey_info->tl3_hdr_error       = PTKEY_INFO_TL3_HDR_ERROR(ptc_key_ptr);
+	ptkey_info->tl3_hdr_type        = PTKEY_INFO_TL3_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->tl3_hdr_isip        = PTKEY_INFO_TL3_HDR_ISIP(ptc_key_ptr);
+
+	ptkey_info->tl4_hdr_valid       = PTKEY_INFO_TL4_HDR_VALID(ptc_key_ptr);
+	ptkey_info->tl4_hdr_error       = PTKEY_INFO_TL4_HDR_ERROR(ptc_key_ptr);
+	ptkey_info->tl4_hdr_type        = PTKEY_INFO_TL4_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->tl4_hdr_is_udp_tcp  = PTKEY_INFO_TL4_HDR_IS_UDP_TCP(ptc_key_ptr);
+
+	ptkey_info->t_hdr_valid         = PTKEY_INFO_T_HDR_VALID(ptc_key_ptr);
+	ptkey_info->t_hdr_error         = PTKEY_INFO_T_HDR_ERROR(ptc_key_ptr);
+	ptkey_info->t_hdr_type          = PTKEY_INFO_T_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->t_hdr_flags         = PTKEY_INFO_T_HDR_FLAGS(ptc_key_ptr);
+
+	ptkey_info->l2_hdr_valid        = PTKEY_INFO_L2_HDR_VALID(ptc_key_ptr);
+	ptkey_info->l2_hdr_error        = PTKEY_INFO_L2_HDR_ERROR(ptc_key_ptr);
+	ptkey_info->l2_hdr_type         = PTKEY_INFO_L2_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->l2_uc_mc_bc         = PTKEY_INFO_L2_UC_MC_BC(ptc_key_ptr);
+	ptkey_info->l2_vtag_present     = PTKEY_INFO_L2_VTAG_PRESENT(ptc_key_ptr);
+	ptkey_info->l2_two_vtags        = PTKEY_INFO_L2_TWO_VTAGS(ptc_key_ptr);
+
+	ptkey_info->l3_hdr_valid        = PTKEY_INFO_L3_HDR_VALID(ptc_key_ptr);
+	ptkey_info->l3_hdr_error        = PTKEY_INFO_L3_HDR_ERROR(ptc_key_ptr);
+	ptkey_info->l3_hdr_type         = PTKEY_INFO_L3_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->l3_hdr_isip         = PTKEY_INFO_L3_HDR_ISIP(ptc_key_ptr);
+	ptkey_info->l3_protocol         = PTKEY_INFO_L3_PROTOCOL(ptc_key_ptr);
+
+	ptkey_info->l4_hdr_valid        = PTKEY_INFO_L4_HDR_VALID(ptc_key_ptr);
+	ptkey_info->l4_hdr_error        = PTKEY_INFO_L4_HDR_ERROR(ptc_key_ptr);
+	ptkey_info->l4_hdr_type         = PTKEY_INFO_L4_HDR_TYPE(ptc_key_ptr);
+	ptkey_info->l4_hdr_is_udp_tcp   = PTKEY_INFO_L4_HDR_IS_UDP_TCP(ptc_key_ptr);
+	ptkey_info->l4_hdr_subtype      = PTKEY_INFO_L4_HDR_SUBTYPE(ptc_key_ptr);
+	ptkey_info->l4_flags            = PTKEY_INFO_L4_FLAGS(ptc_key_ptr);
+	ptkey_info->l4_dcn_present      = PTKEY_INFO_L4_DCN_PRESENT(ptc_key_ptr);
+}
+
+#define PTRMP_INFO_PL_BYP_LKUP_EN(kptr)   tfc_getbits(ptc_rmp_ptr, 42, 1)
+#define PTRMP_INFO_EM_SEARCH_EN(kptr)     tfc_getbits(ptc_rmp_ptr, 41, 1)
+#define PTRMP_INFO_EM_PROFILE_ID(kptr)    tfc_getbits(ptc_rmp_ptr, 33, 8)
+#define PTRMP_INFO_EM_KEY_ID(kptr)        tfc_getbits(ptc_rmp_ptr, 26, 7)
+#define PTRMP_INFO_EM_SCOPE(kptr)         tfc_getbits(ptc_rmp_ptr, 21, 5)
+#define PTRMP_INFO_TCAM_SEARCH_EN(kptr)   tfc_getbits(ptc_rmp_ptr, 20, 1)
+#define PTRMP_INFO_TCAM_PROFILE_ID(kptr)  tfc_getbits(ptc_rmp_ptr, 12, 8)
+#define PTRMP_INFO_TCAM_KEY_ID(kptr)      tfc_getbits(ptc_rmp_ptr, 5, 7)
+#define PTRMP_INFO_TCAM_SCOPE(kptr)       tfc_getbits(ptc_rmp_ptr, 0, 5)
+
+static void prof_tcam_remap_decode(uint32_t *ptc_rmp_ptr,
+				   struct prof_tcam_remap_t *ptrmp_info)
+{
+	ptrmp_info->pl_byp_lkup_en  = PTRMP_INFO_PL_BYP_LKUP_EN(ptc_rmp_ptr) ? true : false;
+	ptrmp_info->em_search_en    = PTRMP_INFO_EM_SEARCH_EN(ptc_rmp_ptr) ? true : false;
+	ptrmp_info->em_profile_id   = PTRMP_INFO_EM_PROFILE_ID(ptc_rmp_ptr);
+	ptrmp_info->em_key_id       = PTRMP_INFO_EM_KEY_ID(ptc_rmp_ptr);
+	ptrmp_info->em_scope        = PTRMP_INFO_EM_SCOPE(ptc_rmp_ptr);
+	ptrmp_info->tcam_search_en  = PTRMP_INFO_TCAM_SEARCH_EN(ptc_rmp_ptr) ? true : false;
+	ptrmp_info->tcam_profile_id = PTRMP_INFO_TCAM_PROFILE_ID(ptc_rmp_ptr);
+	ptrmp_info->tcam_key_id     = PTRMP_INFO_TCAM_KEY_ID(ptc_rmp_ptr);
+	ptrmp_info->tcam_scope      = PTRMP_INFO_TCAM_SCOPE(ptc_rmp_ptr);
+}
+
+static void prof_tcam_show(FILE *fd,
+			   struct prof_tcam_key_t *ptkey_info,
+			   struct prof_tcam_key_t *ptmask_info,
+			   struct prof_tcam_remap_t *ptrmp_info)
+{
+	char tmph[TFC_STRING_LENGTH_64];
+	char tmp1[TFC_STRING_LENGTH_64];
+	char tmp2[TFC_STRING_LENGTH_64];
+	char tmp3[TFC_STRING_LENGTH_64];
+	char tmp4[TFC_STRING_LENGTH_64];
+	char tmp5[TFC_STRING_LENGTH_64];
+	char *lineh = NULL;
+	char *line1 = NULL;
+	char *line2 = NULL;
+	char *line3 = NULL;
+	char *line4 = NULL;
+	char *line5 = NULL;
+
+	lineh = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line1 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line2 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line3 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line4 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line5 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	if (!lineh || !line1 || !line2 || !line3 || !line4 || !line5) {
+		rte_free(lineh);
+		rte_free(line1);
+		rte_free(line2);
+		rte_free(line3);
+		rte_free(line4);
+		rte_free(line5);
+		fprintf(fd, "%s: Failed to allocate temp buffer\n",
+			__func__);
+		return;
+	}
+
+	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+----+----+----+---------+------"
+		 "+--------+-------+-----+---+---+---+\n");
+	snprintf(line2, TFC_STRING_LENGTH_256, "|V|Sp|lpbk|ptyp|rcyc|    MD   |aggerr"
+		 "|l2ipfunc|profunc|hrnxt|IHT|IHG|IIT|\n");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+----+----+----+---------+------"
+		 "+--------+-------+-----+---+---+---+\n");
+	snprintf(line4, TFC_STRING_LENGTH_256, " %01x x%01x   %01x   x%01x  x%01x  x%08x"
+		 "    %01x     x%02x      x%02x     x%01x   x%01x  x%01x   %01x  key\n",
+		 ptkey_info->valid,
+		 ptkey_info->spare,
+		 ptkey_info->loopback,
+		 ptkey_info->pkt_type,
+		 ptkey_info->rcyc,
+		 ptkey_info->metadata,
+		 ptkey_info->agg_error,
+		 ptkey_info->l2ip_func,
+		 ptkey_info->prof_func,
+		 ptkey_info->hrec_next,
+		 ptkey_info->int_hdr_type,
+		 ptkey_info->int_hdr_group,
+		 ptkey_info->int_ifa_tail);
+	snprintf(line5, TFC_STRING_LENGTH_256, " %01x x%01x   %01x   x%01x  x%01x  x%08x"
+		 "    %01x     x%02x      x%02x     x%01x   x%01x  x%01x   %01x  mask\n",
+		 ptmask_info->valid,
+		 ptmask_info->spare,
+		 ptmask_info->loopback,
+		 ptmask_info->pkt_type,
+		 ptmask_info->rcyc,
+		 ptmask_info->metadata,
+		 ptmask_info->agg_error,
+		 ptmask_info->l2ip_func,
+		 ptmask_info->prof_func,
+		 ptmask_info->hrec_next,
+		 ptmask_info->int_hdr_type,
+		 ptmask_info->int_hdr_group,
+		 ptmask_info->int_ifa_tail);
+	fprintf(fd, "%s%s%s%s%s",
+		line1,
+		line2,
+		line3,
+		line5,
+		line4);
+
+	snprintf(lineh, TFC_STRING_LENGTH_256, "|OTL2 hdr       |");
+	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	snprintf(line2, TFC_STRING_LENGTH_256, "|V|HT|UMB|VT|2VT|");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	snprintf(line4, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+		 ptkey_info->otl2_hdr_valid,
+		 ptkey_info->otl2_hdr_type,
+		 ptkey_info->otl2_uc_mc_bc,
+		 ptkey_info->otl2_vtag_present,
+		 ptkey_info->otl2_two_vtags);
+	snprintf(line5, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+		 ptmask_info->otl2_hdr_valid,
+		 ptmask_info->otl2_hdr_type,
+		 ptmask_info->otl2_uc_mc_bc,
+		 ptmask_info->otl2_vtag_present,
+		 ptmask_info->otl2_two_vtags);
+
+	snprintf(tmph, TFC_STRING_LENGTH_64, "OTL3 hdr  |");
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "V|HE|HT|IP|");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "-+--+--+--+");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, " %01x  %01x x%01x  %01x ",
+		 ptkey_info->otl3_hdr_valid,
+		 ptkey_info->otl3_hdr_error,
+		 ptkey_info->otl3_hdr_type,
+		 ptkey_info->otl3_hdr_isip);
+	snprintf(tmp5, TFC_STRING_LENGTH_64, " %01x  %01x x%01x  %01x ",
+		 ptmask_info->otl3_hdr_valid,
+		 ptmask_info->otl3_hdr_error,
+		 ptmask_info->otl3_hdr_type,
+		 ptmask_info->otl3_hdr_isip);
+
+	strcat(lineh, tmph);
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+	strcat(line5, tmp5);
+
+	snprintf(tmph, TFC_STRING_LENGTH_64, "OTL4 hdr  |");
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "V|HE|HT|IP|");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "-+--+--+--+");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, "%01x  %01x x%01x  %01x ",
+		 ptkey_info->otl4_hdr_valid,
+		 ptkey_info->otl4_hdr_error,
+		 ptkey_info->otl4_hdr_type,
+		 ptkey_info->otl4_hdr_is_udp_tcp);
+	snprintf(tmp5, TFC_STRING_LENGTH_64, "%01x  %01x x%01x  %01x ",
+		 ptmask_info->otl4_hdr_valid,
+		 ptmask_info->otl4_hdr_error,
+		 ptmask_info->otl4_hdr_type,
+		 ptmask_info->otl4_hdr_is_udp_tcp);
+
+	strcat(lineh, tmph);
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+	strcat(line5, tmp5);
+
+	snprintf(tmph, TFC_STRING_LENGTH_64, "OT hdr      |\n");
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+---+---+\n");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "V|HE| HT|flg|\n");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "-+--+---+---+\n");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, "%01x  %01x x%02x x%02x  key\n",
+		 ptkey_info->ot_hdr_valid,
+		 ptkey_info->ot_hdr_error,
+		 ptkey_info->ot_hdr_type,
+		 ptkey_info->ot_hdr_flags);
+	snprintf(tmp5, TFC_STRING_LENGTH_64, "%01x  %01x x%02x x%02x  mask\n",
+		 ptmask_info->ot_hdr_valid,
+		 ptmask_info->ot_hdr_error,
+		 ptmask_info->ot_hdr_type,
+		 ptmask_info->ot_hdr_flags);
+
+	strcat(lineh, tmph);
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+	strcat(line5, tmp5);
+
+	fprintf(fd, "%s%s%s%s%s%s",
+		lineh,
+		line1,
+		line2,
+		line3,
+		line5,
+		line4);
+
+	snprintf(lineh, TFC_STRING_LENGTH_256, "|TL2 hdr        |");
+	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	snprintf(line2, TFC_STRING_LENGTH_256, "|V|HT|UMB|VT|2VT|");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	snprintf(line4, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+		 ptkey_info->tl2_hdr_valid,
+		 ptkey_info->tl2_hdr_type,
+		 ptkey_info->tl2_uc_mc_bc,
+		 ptkey_info->tl2_vtag_present,
+		 ptkey_info->tl2_two_vtags);
+	snprintf(line5, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+		 ptmask_info->tl2_hdr_valid,
+		 ptmask_info->tl2_hdr_type,
+		 ptmask_info->tl2_uc_mc_bc,
+		 ptmask_info->tl2_vtag_present,
+		 ptmask_info->tl2_two_vtags);
+
+	snprintf(tmph, TFC_STRING_LENGTH_64, "TL3 hdr   |");
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "V|HE|HT|IP|");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "-+--+--+--+");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, " %01x  %01x x%01x  %01x ",
+		 ptkey_info->tl3_hdr_valid,
+		 ptkey_info->tl3_hdr_error,
+		 ptkey_info->tl3_hdr_type,
+		 ptkey_info->tl3_hdr_isip);
+	snprintf(tmp5, TFC_STRING_LENGTH_64, " %01x  %01x x%01x  %01x ",
+		 ptmask_info->tl3_hdr_valid,
+		 ptmask_info->tl3_hdr_error,
+		 ptmask_info->tl3_hdr_type,
+		 ptmask_info->tl3_hdr_isip);
+
+	strcat(lineh, tmph);
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+	strcat(line5, tmp5);
+
+	snprintf(tmph, TFC_STRING_LENGTH_64, "TL4 hdr   |");
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "V|HE|HT|IP|");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "-+--+--+--+");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, "%01x  %01x x%01x  %01x ",
+		 ptkey_info->tl4_hdr_valid,
+		 ptkey_info->tl4_hdr_error,
+		 ptkey_info->tl4_hdr_type,
+		 ptkey_info->tl4_hdr_is_udp_tcp);
+	snprintf(tmp5, TFC_STRING_LENGTH_64, "%01x  %01x x%01x  %01x ",
+		 ptmask_info->tl4_hdr_valid,
+		 ptmask_info->tl4_hdr_error,
+		 ptmask_info->tl4_hdr_type,
+		 ptmask_info->tl4_hdr_is_udp_tcp);
+
+	strcat(lineh, tmph);
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+	strcat(line5, tmp5);
+
+	snprintf(tmph, TFC_STRING_LENGTH_64, "T hdr       |\n");
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+---+---+\n");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "V|HE| HT|flg|\n");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "-+--+---+---+\n");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, "%01x  %01x x%02x x%02x  key\n",
+		 ptkey_info->t_hdr_valid,
+		 ptkey_info->t_hdr_error,
+		 ptkey_info->t_hdr_type,
+		 ptkey_info->t_hdr_flags);
+	snprintf(tmp5, TFC_STRING_LENGTH_64, "%01x  %01x x%02x x%02x  mask\n",
+		 ptmask_info->t_hdr_valid,
+		 ptmask_info->t_hdr_error,
+		 ptmask_info->t_hdr_type,
+		 ptmask_info->t_hdr_flags);
+
+	strcat(lineh, tmph);
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+	strcat(line5, tmp5);
+
+	fprintf(fd, "%s%s%s%s%s%s",
+		lineh,
+		line1,
+		line2,
+		line3,
+		line5,
+		line4);
+
+	snprintf(lineh, TFC_STRING_LENGTH_256, "|L2 hdr         |");
+	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	snprintf(line2, TFC_STRING_LENGTH_256, "|V|HT|UMB|VT|2VT|");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+---+--+---+");
+	snprintf(line4, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+		 ptkey_info->l2_hdr_valid,
+		 ptkey_info->l2_hdr_type,
+		 ptkey_info->l2_uc_mc_bc,
+		 ptkey_info->l2_vtag_present,
+		 ptkey_info->l2_two_vtags);
+	snprintf(line5, TFC_STRING_LENGTH_256, " %01x x%01x  x%01x  %01x  %01x ",
+		 ptmask_info->l2_hdr_valid,
+		 ptmask_info->l2_hdr_type,
+		 ptmask_info->l2_uc_mc_bc,
+		 ptmask_info->l2_vtag_present,
+		 ptmask_info->l2_two_vtags);
+
+	snprintf(tmph, TFC_STRING_LENGTH_64, "L3 hdr         |");
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+----+");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "V|HE|HT|IP|prot|");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "-+--+--+--+----+");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, " %01x  %01x x%01x  %01x  x%02x ",
+		 ptkey_info->l3_hdr_valid,
+		 ptkey_info->l3_hdr_error,
+		 ptkey_info->l3_hdr_type,
+		 ptkey_info->l3_hdr_isip,
+		 ptkey_info->l3_protocol);
+	snprintf(tmp5, TFC_STRING_LENGTH_64, " %01x  %01x x%01x  %01x  x%02x ",
+		 ptmask_info->l3_hdr_valid,
+		 ptmask_info->l3_hdr_error,
+		 ptmask_info->l3_hdr_type,
+		 ptmask_info->l3_hdr_isip,
+		 ptmask_info->l3_protocol);
+
+	strcat(lineh, tmph);
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+	strcat(line5, tmp5);
+
+	snprintf(tmph, TFC_STRING_LENGTH_64, "L4 hdr                 |\n");
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-+--+--+--+---+----+---+\n");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "V|HE|HT|IP|HST|flgs|DCN|\n");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "-+--+--+--+---+----+---+\n");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, "%01x  %01x x%01x  %01x  x%01x x%03x  x%01x  key\n",
+		 ptkey_info->l4_hdr_valid,
+		 ptkey_info->l4_hdr_error,
+		 ptkey_info->l4_hdr_type,
+		 ptkey_info->l4_hdr_is_udp_tcp,
+		 ptkey_info->l4_hdr_subtype,
+		 ptkey_info->l4_flags,
+		 ptkey_info->l4_dcn_present);
+	snprintf(tmp5, TFC_STRING_LENGTH_64, "%01x  %01x x%01x  %01x  x%01x x%03x  x%01x  mask\n",
+		 ptmask_info->l4_hdr_valid,
+		 ptmask_info->l4_hdr_error,
+		 ptmask_info->l4_hdr_type,
+		 ptmask_info->l4_hdr_is_udp_tcp,
+		 ptmask_info->l4_hdr_subtype,
+		 ptmask_info->l4_flags,
+		 ptmask_info->l4_dcn_present);
+
+	strcat(lineh, tmph);
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+	strcat(line5, tmp5);
+
+	fprintf(fd, "%s%s%s%s%s%s",
+		lineh,
+		line1,
+		line2,
+		line3,
+		line5,
+		line4);
+
+	fputs("\n:Profile TCAM: remap\n", fd);
+	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+---+---+---+--+---+---+---+\n");
+	snprintf(line2, TFC_STRING_LENGTH_256, "|B|EM|PID|KId|Scp|WC|PID|KId|Scp|\n");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+---+---+---+--+---+---+---+\n");
+	snprintf(line4, TFC_STRING_LENGTH_256, " %c  %c x%02x x%02x x%02x  %c x%02x x%02x x%02x\n",
+		 ptrmp_info->pl_byp_lkup_en ? 'Y' : 'N',
+		 ptrmp_info->em_search_en ? 'Y' : 'N',
+		 ptrmp_info->em_profile_id,
+		 ptrmp_info->em_key_id,
+		 ptrmp_info->em_scope,
+		 ptrmp_info->tcam_search_en ? 'Y' : 'N',
+		 ptrmp_info->tcam_profile_id,
+		 ptrmp_info->tcam_key_id,
+		 ptrmp_info->tcam_scope);
+
+	fprintf(fd, "%s%s%s%s",
+		line1,
+		line2,
+		line3,
+		line4);
+
+	rte_free(lineh);
+	rte_free(line1);
+	rte_free(line2);
+	rte_free(line3);
+	rte_free(line4);
+	rte_free(line5);
+}
+
+/* Offset all WC LREC fields by -24  as per CFA EAS */
+#define WC_INFO_VALID(kptr)		tfc_getbits(kptr, (127 - 24), 1)
+#define WC_INFO_REC_SIZE(kptr)		tfc_getbits(kptr, (125 - 24), 2)
+#define WC_INFO_EPOCH0(kptr)		tfc_getbits(kptr, (113 - 24), 12)
+#define WC_INFO_EPOCH1(kptr)		tfc_getbits(kptr, (107 - 24), 6)
+#define WC_INFO_OPCODE(kptr)		tfc_getbits(kptr, (103 - 24), 4)
+#define WC_INFO_STRENGTH(kptr)		tfc_getbits(kptr, (101 - 24), 2)
+#define WC_INFO_ACT_HINT(kptr)		tfc_getbits(kptr, (99 - 24), 2)
+
+#define WC_INFO_ACT_REC_PTR(kptr)	tfc_getbits(kptr, (73 - 24), 26)
+
+#define WC_INFO_DESTINATION(kptr)	tfc_getbits(kptr, (73 - 24), 17)
+
+#define WC_INFO_TCP_DIRECTION(kptr)	tfc_getbits(kptr, (72 - 24), 1)
+#define WC_INFO_TCP_UPDATE_EN(kptr)	tfc_getbits(kptr, (71 - 24), 1)
+#define WC_INFO_TCP_WIN(kptr)		tfc_getbits(kptr, (66 - 24), 5)
+#define WC_INFO_TCP_MSB_LOC(kptr)	tfc_getbits(kptr, (48 - 24), 18)
+#define WC_INFO_TCP_MSB_OPP(kptr)	tfc_getbits(kptr, (30 - 24), 18)
+#define WC_INFO_TCP_MSB_OPP_INIT(kptr)	tfc_getbits(kptr, (29 - 24), 1)
+#define WC_INFO_STATE(kptr)		tfc_getbits(kptr, (24 - 24), 5)
+
+#define WC_INFO_RING_TABLE_IDX(kptr)	tfc_getbits(kptr, (64 - 24), 9)
+#define WC_INFO_ACT_REC_SIZE(kptr)	tfc_getbits(kptr, (59 - 24), 5)
+#define WC_INFO_PATHS_M1(kptr)		tfc_getbits(kptr, (55 - 24), 4)
+#define WC_INFO_FC_OP(kptr)		tfc_getbits(kptr, (54 - 24), 1)
+#define WC_INFO_FC_TYPE(kptr)		tfc_getbits(kptr, (52 - 24), 2)
+#define WC_INFO_FC_PTR(kptr)		tfc_getbits(kptr, (24 - 24), 28)
+
+#define WC_INFO_RECYCLE_DEST(kptr)	tfc_getbits(kptr, (72 - 24), 1)
+#define WC_INFO_PROF_FUNC(kptr)		tfc_getbits(kptr, (64 - 24), 8)
+#define WC_INFO_META_PROF(kptr)		tfc_getbits(kptr, (61 - 24), 3)
+#define WC_INFO_METADATA(kptr)		tfc_getbits(kptr, (29 - 24), 32)
+
+static void wc_tcam_decode(uint32_t *wc_res_ptr,
+			   struct wc_lrec_t *wc_info,
+			   struct tfc_ts_mem_cfg *act_mem_cfg)
+{
+	wc_info->valid    = WC_INFO_VALID(wc_res_ptr);
+	wc_info->rec_size = WC_INFO_REC_SIZE(wc_res_ptr);
+	wc_info->epoch0   = WC_INFO_EPOCH0(wc_res_ptr);
+	wc_info->epoch1   = WC_INFO_EPOCH1(wc_res_ptr);
+	wc_info->opcode   = WC_INFO_OPCODE(wc_res_ptr);
+	wc_info->strength = WC_INFO_STRENGTH(wc_res_ptr);
+	wc_info->act_hint = WC_INFO_ACT_HINT(wc_res_ptr);
+
+	if (wc_info->opcode != 2 && wc_info->opcode != 3) {
+		/* All but FAST */
+		wc_info->act_rec_ptr = WC_INFO_ACT_REC_PTR(wc_res_ptr);
+		act_process(wc_info->act_rec_ptr, &wc_info->act_info, act_mem_cfg);
+	} else {
+		/* Just FAST */
+		wc_info->destination = WC_INFO_DESTINATION(wc_res_ptr);
+	}
+
+	if (wc_info->opcode == 4 || wc_info->opcode == 6) {
+		/* CT only */
+		wc_info->tcp_direction    = WC_INFO_TCP_DIRECTION(wc_res_ptr);
+		wc_info->tcp_update_en    = WC_INFO_TCP_UPDATE_EN(wc_res_ptr);
+		wc_info->tcp_win          = WC_INFO_TCP_WIN(wc_res_ptr);
+		wc_info->tcp_msb_loc      = WC_INFO_TCP_MSB_LOC(wc_res_ptr);
+		wc_info->tcp_msb_opp      = WC_INFO_TCP_MSB_OPP(wc_res_ptr);
+		wc_info->tcp_msb_opp_init = WC_INFO_TCP_MSB_OPP_INIT(wc_res_ptr);
+		wc_info->state            = WC_INFO_STATE(wc_res_ptr);
+	} else if (wc_info->opcode != 8) {
+		/* Not CT and nor RECYCLE */
+		wc_info->ring_table_idx = WC_INFO_RING_TABLE_IDX(wc_res_ptr);
+		wc_info->act_rec_size   = WC_INFO_ACT_REC_SIZE(wc_res_ptr);
+		wc_info->paths_m1       = WC_INFO_PATHS_M1(wc_res_ptr);
+		wc_info->fc_op          = WC_INFO_FC_OP(wc_res_ptr);
+		wc_info->fc_type        = WC_INFO_FC_TYPE(wc_res_ptr);
+		wc_info->fc_ptr         = WC_INFO_FC_PTR(wc_res_ptr);
+	} else {
+		/* Recycle */
+		wc_info->recycle_dest = WC_INFO_RECYCLE_DEST(wc_res_ptr);
+		wc_info->prof_func    = WC_INFO_PROF_FUNC(wc_res_ptr);
+		wc_info->meta_prof    = WC_INFO_META_PROF(wc_res_ptr);
+		wc_info->metadata     = WC_INFO_METADATA(wc_res_ptr);
+	}
+}
+
+static void wc_tcam_show(FILE *fd, struct wc_lrec_t *wc_info)
+{
+	char *line1 = NULL;
+	char *line2 = NULL;
+	char *line3 = NULL;
+	char *line4 = NULL;
+	char tmp1[TFC_STRING_LENGTH_64];
+	char tmp2[TFC_STRING_LENGTH_64];
+	char tmp3[TFC_STRING_LENGTH_64];
+	char tmp4[TFC_STRING_LENGTH_64];
+
+	line1 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line2 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line3 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	line4 = rte_malloc("data", TFC_STRING_LENGTH_256, 8);
+	if (!line1 || !line2 || !line3 || !line4) {
+		rte_free(line1);
+		rte_free(line2);
+		rte_free(line3);
+		rte_free(line4);
+		fprintf(fd, "%s: Failed to allocate temp buffer\n",
+			__func__);
+		return;
+	}
+
+	fprintf(fd, ":LREC: opcode:%s\n", get_lrec_opcode_str(wc_info->opcode));
+
+	snprintf(line1, TFC_STRING_LENGTH_256, "+-+--+-Epoch-+--+--+--+");
+	snprintf(line2, TFC_STRING_LENGTH_256, " V|rs|  0  1 |Op|St|ah|");
+	snprintf(line3, TFC_STRING_LENGTH_256, "+-+--+----+--+--+--+--+");
+	snprintf(line4, TFC_STRING_LENGTH_256, " %1d %2d %4d %2d %2d %2d %2d ",
+		 wc_info->valid,
+		 wc_info->rec_size,
+		 wc_info->epoch0,
+		 wc_info->epoch1,
+		 wc_info->opcode,
+		 wc_info->strength,
+		 wc_info->act_hint);
+
+	if (wc_info->opcode != 2 && wc_info->opcode != 3) {
+		/* All but FAST */
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "-Act Rec--+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, " Ptr      |");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "----------+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "0x%08x ",
+			 wc_info->act_rec_ptr);
+	} else {
+		/* Just FAST */
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "-------+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, " Dest  |");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "-------+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "0x05%x ",
+			 wc_info->destination);
+	}
+
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+
+	if (wc_info->opcode == 4 || wc_info->opcode == 6) {
+		/* CT only */
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "--+--+-------------TCP-------+--+---+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, "Dr|ue| Win|   lc  |   op  |oi|st|tmr|");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "--+--+----+-------+-------+--+--+---+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "%2d %2d %4d %0x5x %0x5x %2d %2d %3d ",
+			 wc_info->tcp_direction,
+			 wc_info->tcp_update_en,
+			 wc_info->tcp_win,
+			 wc_info->tcp_msb_loc,
+			 wc_info->tcp_msb_opp,
+			 wc_info->tcp_msb_opp_init,
+			 wc_info->state,
+			 wc_info->timer_value);
+	} else if (wc_info->opcode != 8) {
+		/* Not CT and nor RECYCLE */
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "--+--+--+-------FC-------+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, "RI|as|pm|op|tp|     Ptr  |");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "--+--+--+--+--+----------+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "%2d %2d %2d %2d %2d 0x%08x ",
+			 wc_info->ring_table_idx,
+			 wc_info->act_rec_size,
+			 wc_info->paths_m1,
+			 wc_info->fc_op,
+			 wc_info->fc_type,
+			 wc_info->fc_ptr);
+	} else {
+		snprintf(tmp1, TFC_STRING_LENGTH_64, "--+--+--+---------+");
+		snprintf(tmp2, TFC_STRING_LENGTH_64, "RD|pf|mp| cMData  |");
+		snprintf(tmp3, TFC_STRING_LENGTH_64, "--+--+--+---------+");
+		snprintf(tmp4, TFC_STRING_LENGTH_64, "%2d 0x%2x %2d %08x ",
+			 wc_info->recycle_dest,
+			 wc_info->prof_func,
+			 wc_info->meta_prof,
+			 wc_info->metadata);
+	}
+
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+
+	snprintf(tmp1, TFC_STRING_LENGTH_64, "-----Range-+\n");
+	snprintf(tmp2, TFC_STRING_LENGTH_64, "Prof|  Idx |\n");
+	snprintf(tmp3, TFC_STRING_LENGTH_64, "----+------+\n");
+	snprintf(tmp4, TFC_STRING_LENGTH_64, "0x%02x 0x%04x\n",
+		 wc_info->range_profile,
+		 wc_info->range_index);
+
+	strcat(line1, tmp1);
+	strcat(line2, tmp2);
+	strcat(line3, tmp3);
+	strcat(line4, tmp4);
+
+	fprintf(fd, "%s%s%s%s",
+		line1,
+		line2,
+		line3,
+		line4);
+
+	if (wc_info->opcode != 2 && wc_info->opcode != 3)
+		act_show(fd, &wc_info->act_info, wc_info->act_rec_ptr << 5);
+
+	rte_free(line1);
+	rte_free(line2);
+	rte_free(line3);
+	rte_free(line4);
+}
+
+static int tfc_tcam_process(struct ulp_flow_db_res_params *rp,
+			    void *frp_ctxt)
+{
+	struct wc_frp_context *wc_frp = (struct wc_frp_context *)frp_ctxt;
+	struct l2ctx_tcam_key_t *l2ctx_key_info, *l2ctx_mask_info;
+	struct prof_tcam_key_t *ptkey_info, *ptmask_info;
+	struct l2ctx_tcam_remap_t *l2ctx_rmp_info;
+	struct prof_tcam_remap_t *ptrmp_info;
+	FILE *fd = wc_frp->fd;
+	struct wc_lrec_t *wc_lrec;
+	uint8_t *key, *mask, *remap;
+	uint16_t key_sz = 128, remap_sz = 128;
+	int rc = -ENOMEM;
+
+	/* Allocate all temp storage */
+	wc_lrec = rte_zmalloc("data", sizeof(*wc_lrec), 8);
+	l2ctx_key_info = rte_zmalloc("data", sizeof(*l2ctx_key_info), 8);
+	l2ctx_mask_info = rte_zmalloc("data", sizeof(*l2ctx_mask_info), 8);
+	l2ctx_rmp_info = rte_zmalloc("data", sizeof(*l2ctx_rmp_info), 8);
+	ptkey_info = rte_zmalloc("data", sizeof(*ptkey_info), 8);
+	ptmask_info = rte_zmalloc("data", sizeof(*ptmask_info), 8);
+	ptrmp_info = rte_zmalloc("data", sizeof(*ptrmp_info), 8);
+	key = rte_zmalloc("data", key_sz, 8);
+	mask = rte_zmalloc("data", key_sz, 8);
+	remap = rte_zmalloc("data", remap_sz, 8);
+
+	if (!wc_lrec || !l2ctx_key_info || !l2ctx_mask_info ||
+	    !l2ctx_rmp_info || !ptkey_info || !ptmask_info ||
+	    !ptrmp_info || !key || !mask || !remap) {
+		fputs("Out of memory:\n", fd);
+		fprintf(fd, "%p:%p:%p\n", wc_lrec, l2ctx_key_info, l2ctx_mask_info);
+		fprintf(fd, "%p:%p:%p\n", l2ctx_rmp_info, ptkey_info, ptmask_info);
+		fprintf(fd, "%p:%p:%p:%p\n", ptrmp_info, key, mask, remap);
+		goto tcam_process_error;
+	}
+
+	rc = tfc_tcam_entry_read(wc_frp->ulp_ctxt,
+				 rp->direction,
+				 rp->resource_type,
+				 rp->resource_hndl,
+				 key,
+				 mask,
+				 remap,
+				 &key_sz,
+				 &remap_sz);
+	if (rc) {
+		fprintf(fd, "TCAM read error rc[%d]\n", rc);
+		rc = -EINVAL;
+		goto tcam_process_error;
+	}
+
+	/*
+	 * Decode result, and extract act_ptr, only for L2 ctx or WC TCAM
+	 * entries
+	 */
+	switch (rp->resource_type) {
+	case CFA_RSUBTYPE_TCAM_L2CTX:
+		fprintf(fd, "\n:L2CTX TCAM [%u]:\n", (uint16_t)rp->resource_hndl);
+		hex_buf_dump(fd, "Key:", key, (int)key_sz, 1, 16);
+		hex_buf_dump(fd, "Mask:", mask, (int)key_sz, 1, 16);
+		l2ctx_tcam_key_decode((uint32_t *)key, l2ctx_key_info);
+		l2ctx_tcam_key_decode((uint32_t *)mask, l2ctx_mask_info);
+		l2ctx_tcam_remap_decode((uint32_t *)remap,
+					l2ctx_rmp_info, wc_frp->act_mem_cfg);
+		l2ctx_tcam_show(fd, l2ctx_key_info, l2ctx_mask_info, l2ctx_rmp_info);
+		break;
+
+	case CFA_RSUBTYPE_TCAM_WC:
+		fprintf(fd, "\n:WC TCAM [%u]:\n", (uint16_t)rp->resource_hndl);
+		hex_buf_dump(fd, "Key:", key, (int)key_sz, 1, 16);
+		hex_buf_dump(fd, "Mask:", mask, (int)key_sz, 1, 16);
+		wc_tcam_decode((uint32_t *)remap, wc_lrec, wc_frp->act_mem_cfg);
+		wc_tcam_show(fd, wc_lrec);
+		break;
+
+	case CFA_RSUBTYPE_TCAM_PROF_TCAM:
+		fprintf(fd, "\n:Profile TCAM [%u]:\n", (uint16_t)rp->resource_hndl);
+		hex_buf_dump(fd, "Key:", key, (int)key_sz, 1, 16);
+		hex_buf_dump(fd, "Mask:", mask, (int)key_sz, 1, 16);
+		prof_tcam_key_decode((uint32_t *)key, ptkey_info);
+		prof_tcam_key_decode((uint32_t *)mask, ptmask_info);
+		prof_tcam_remap_decode((uint32_t *)remap, ptrmp_info);
+		prof_tcam_show(fd, ptkey_info, ptmask_info, ptrmp_info);
+		break;
+
+	case CFA_RSUBTYPE_TCAM_CT_RULE:
+	case CFA_RSUBTYPE_TCAM_VEB:
+	case CFA_RSUBTYPE_TCAM_FEATURE_CHAIN:
+		fprintf(fd, "Unsupported decode: %s\n", tfc_tcam_2_str(rp->resource_type));
+	default:
+		break;
+	}
+
+tcam_process_error:
+	rte_free(l2ctx_key_info);
+	rte_free(l2ctx_mask_info);
+	rte_free(l2ctx_rmp_info);
+	rte_free(wc_lrec);
+	rte_free(ptkey_info);
+	rte_free(ptmask_info);
+	rte_free(ptrmp_info);
+	rte_free(key);
+	rte_free(mask);
+	rte_free(remap);
+	return rc;
+}
+
+/*
+ * Check for the following conditions:
+ * 1. res_dir == p_res_dir
+ * 2. res_func == p_res_func
+ * 3. res_type == p_res_type
+ * 4. if res_dir == CFA_DIR_MAX, skip #1
+ * 5. if res_func == BNXT_ULP_RESOURCE_FUNC_INVALID, skip #2
+ * 6. if res_type == CFA_RSUBTYPE_TCAM_MAX, skip #3
+ *
+ * Bascally implements a wildcarded match for either-or-and all conditions.
+ */
+#define TFC_INVALID_RES 0xFFFFFFFF
+static bool tfc_flow_db_resource_filter(uint32_t p_res_dir, uint32_t p_res_func,
+					uint32_t p_res_type, uint32_t res_dir,
+					uint32_t res_func, uint32_t res_type)
+{
+	if (res_dir != CFA_DIR_MAX && p_res_dir != res_dir)
+		return false;
+
+	/* res_dir == CFA_DIR_MAX */
+	if (res_func == TFC_INVALID_RES &&
+	    res_type == TFC_INVALID_RES)
+		return true;
+	else if (res_func == TFC_INVALID_RES &&
+		 res_type == p_res_type)
+		return true;
+	else if (res_func == p_res_func &&
+		 res_type == TFC_INVALID_RES)
+		return true;
+
+	return false;
+}
+
+/**
+ * Walk through a resource matching a spec (resource_func+resource_type) for a
+ * particular flow (or all flows), and call a processing callback to handle
+ * data per resource/type.
+ *
+ * @ulp_ctxt:      Ptr to ulp_context
+ * @flow_type:     FDB flow type (default/regular)
+ * @resource_func: if zero then all resource_funcs are dumped.
+ * @resource_type: if zero then all resource_types are dumped.
+ * @frp:           FDB resource processor function
+ * @frp_ctxt:      FDB resource processor context
+ *
+ * returns 0 if success, error code if not
+ */
+static
+int tfc_flow_db_resource_walk(struct bnxt_ulp_context *ulp_ctxt, uint8_t flow_type,
+			      uint32_t resource_dir, uint32_t resource_func, uint32_t resource_type,
+			      FDB_RESOURCE_PROCFUNC frp,
+			      void *frp_ctxt)
+{
+	struct wc_frp_context *wc_frp = (struct wc_frp_context *)frp_ctxt;
+	FILE *fd = wc_frp->fd;
+	struct ulp_flow_db_res_params params;
+#if (TFC_DEBUG_DUMP_ALL_FLOWS)
+	struct bnxt_ulp_flow_tbl *flow_tbl;
+#endif
+	struct bnxt_ulp_flow_db *flow_db;
+	uint32_t ridx, fid = 1;
+	int rc;
+
+	if (!ulp_ctxt || !ulp_ctxt->cfg_data)
+		return -EINVAL;
+
+	if (!frp) {
+		fputs("No FDB proc_func\n", fd);
+		return -EINVAL;
+	}
+
+	flow_db = bnxt_ulp_cntxt_ptr2_flow_db_get(ulp_ctxt);
+	if (!flow_db) {
+		fputs("Invalid Arguments\n", fd);
+		return -EINVAL;
+	}
+
+#if (TFC_DEBUG_DUMP_ALL_FLOWS)
+	flow_tbl = &flow_db->flow_tbl;
+
+	for (fid = 1; fid < flow_tbl->num_flows; fid++) {
+#else
+	while (!ulp_flow_db_next_entry_get(flow_db, flow_type, &fid)) {
+#endif
+		ridx = 0;
+
+		rc = ulp_flow_db_resource_get(ulp_ctxt, flow_type, fid,
+					      &ridx, &params);
+		if (!rc) {
+			if (tfc_flow_db_resource_filter(params.direction,
+							params.resource_func,
+							params.resource_type,
+							resource_dir,
+							resource_func,
+							resource_type)) {
+				(*frp)(&params, (void *)frp_ctxt);
+			}
+
+			do {
+				rc = ulp_flow_db_resource_get(ulp_ctxt, flow_type, fid,
+							      &ridx, &params);
+				if (!rc) {
+					if (tfc_flow_db_resource_filter(params.direction,
+									params.resource_func,
+									params.resource_type,
+									resource_dir,
+									resource_func,
+									resource_type))
+						(*frp)(&params, (void *)frp_ctxt);
+				}
+			} while (ridx);
+		}
+	}
+	return 0;
+}
+
+int tfc_wc_show(FILE *fd, struct tfc *tfcp, uint8_t tsid, enum cfa_dir dir)
+{
+	struct tfc_ts_mem_cfg *act_mem_cfg;
+	struct bnxt_ulp_context *ulp_ctx;
+	struct wc_frp_context wc_frp;
+	bool is_bs_owner;
+	struct bnxt *bp;
+	bool is_shared;
+	bool valid;
+	int rc = 0;
+
+	if (!tfcp)
+		return -EINVAL;
+
+	rc = tfo_ts_get(tfcp->tfo, tsid, &scope_type, NULL, &valid, NULL);
+	if (rc != 0) {
+		fprintf(fd, "%s: failed to get tsid: %d\n",
+			   __func__, rc);
+		return -EINVAL;
+	}
+	if (!valid) {
+		fprintf(fd, "%s: tsid not allocated %d\n",
+			   __func__, tsid);
+		return -EINVAL;
+	}
+
+	act_mem_cfg = rte_zmalloc("data", sizeof(*act_mem_cfg), 8);
+	if (!act_mem_cfg)
+		return -ENOMEM;
+
+	rc = tfo_ts_get_mem_cfg(tfcp->tfo, tsid,
+				dir,
+				CFA_REGION_TYPE_ACT,
+				&is_bs_owner,
+				act_mem_cfg);   /* Gets rec_cnt */
+	if (rc != 0) {
+		fprintf(fd, "%s: tfo_ts_get_mem_cfg() failed for ACT: %d\n",
+			   __func__, rc);
+		rte_free(act_mem_cfg);
+		return -EINVAL;
+	}
+
+	if (tfcp &&
+	    tfcp->bp) {
+		bp = (struct bnxt *)(tfcp->bp);
+		ulp_ctx = bp->ulp_ctx;
+
+		if (ulp_ctx) {
+			wc_frp.ulp_ctxt = ulp_ctx;
+			wc_frp.fd = fd;
+			wc_frp.act_mem_cfg = act_mem_cfg;
+
+			/* Dump-decode all TCAM resources for default flows */
+			fputs("\nDefault flows TCAM:\n", fd);
+			fputs("===================\n", fd);
+			tfc_flow_db_resource_walk(ulp_ctx, BNXT_ULP_FDB_TYPE_DEFAULT, dir,
+						  BNXT_ULP_RESOURCE_FUNC_TCAM_TABLE,
+						  -1, &tfc_tcam_process, (void *)&wc_frp);
+			/* Dump-decode all TCAM resources for resource-id flows */
+			fputs("\nRID flows TCAM:\n", fd);
+			fputs("===============\n", fd);
+			tfc_flow_db_resource_walk(ulp_ctx, BNXT_ULP_FDB_TYPE_RID, dir,
+						  BNXT_ULP_RESOURCE_FUNC_TCAM_TABLE,
+						  -1, &tfc_tcam_process, (void *)&wc_frp);
+			/* Dump-decode all TCAM resources for regular flows */
+			fputs("\nRegular flows TCAM:\n", fd);
+			fputs("===================\n", fd);
+			tfc_flow_db_resource_walk(ulp_ctx, BNXT_ULP_FDB_TYPE_REGULAR, dir,
+						  BNXT_ULP_RESOURCE_FUNC_TCAM_TABLE,
+						  -1, &tfc_tcam_process, (void *)&wc_frp);
+		}
+	}
+
+	rte_free(act_mem_cfg);
+	return rc;
+}
diff --git a/drivers/net/bnxt/tf_core/v3/tfo.c b/drivers/net/bnxt/tf_core/v3/tfo.c
index f4ee81aefd..12d80877a6 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.c
+++ b/drivers/net/bnxt/tf_core/v3/tfo.c
@@ -573,3 +573,35 @@ int tfo_tim_get(void *tfo, void **tim)
 
 	return 0;
 }
+
+
+int tfo_tsid_get(void *tfo, uint8_t *tsid)
+{
+	struct tfc_object *tfco = (struct tfc_object *)tfo;
+	struct tfc_tsid_db *tsid_db;
+	uint8_t i;
+
+	if (tfo == NULL) {
+		PMD_DRV_LOG(ERR, "%s: Invalid tfo pointer", __func__);
+		return -EINVAL;
+	}
+	if (tfco->signature != TFC_OBJ_SIGNATURE) {
+		PMD_DRV_LOG(ERR, "%s: Invalid tfo object", __func__);
+		return -EINVAL;
+	}
+	if (tsid == NULL) {
+		PMD_DRV_LOG(ERR, "%s: Invalid tsid pointer", __func__);
+		return -EINVAL;
+	}
+
+	for (i = 1; i < TFC_TBL_SCOPE_MAX; i++) {
+		tsid_db = &tfco->tsid_db[i];
+
+		if (tsid_db->ts_valid) {
+			*tsid = i;
+			return 0;
+		}
+	}
+
+	return -1;
+}
diff --git a/drivers/net/bnxt/tf_core/v3/tfo.h b/drivers/net/bnxt/tf_core/v3/tfo.h
index f97d4cdd2d..e572db5991 100644
--- a/drivers/net/bnxt/tf_core/v3/tfo.h
+++ b/drivers/net/bnxt/tf_core/v3/tfo.h
@@ -426,4 +426,18 @@ int tfo_tim_set(void *tfo, void *tim);
  */
 int tfo_tim_get(void *tfo, void **tim);
 
+/**
+ * Get the table scope
+ *
+ * @param[in] tfo
+ *   Pointer to TFC object
+ *
+ * @param[out] tsid
+ *   Pointer to the returned table scope
+ *
+ * @return
+ *   0 for SUCCESS, negative error value for FAILURE (errno.h)
+ */
+int tfo_tsid_get(void *tfo, uint8_t *tsid);
+
 #endif /* _TFO_H_ */
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h
index f2426ce3c1..ab6608ac74 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp_tfc.h
@@ -76,4 +76,9 @@ bnxt_ulp_cntxt_page_sz_get(struct bnxt_ulp_context *ulp_ctxt);
 int32_t
 bnxt_ulp_cntxt_page_sz_set(struct bnxt_ulp_context *ulp_ctxt,
 			   uint32_t page_sz);
+
+int32_t
+ulp_flow_db_next_entry_get(struct bnxt_ulp_flow_db *flow_db,
+			   enum bnxt_ulp_fdb_type flow_type,
+			   uint32_t *fid);
 #endif
diff --git a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c
index d1b374e603..8e61c71f97 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_fc_mgr_tfc.c
@@ -18,7 +18,6 @@
 #include "ulp_template_db_enum.h"
 #include "ulp_template_struct.h"
 #include "tfc.h"
-#include "tfc_debug.h"
 #include "tfc_action_handle.h"
 
 /* Need to create device parms for these values and handle
diff --git a/drivers/net/bnxt/tf_ulp/ulp_flow_db.c b/drivers/net/bnxt/tf_ulp/ulp_flow_db.c
index 943c9b799c..46f5a96baf 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_flow_db.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_flow_db.c
@@ -9,6 +9,8 @@
 #include "bnxt.h"
 #include "bnxt_tf_common.h"
 #include "bnxt_ulp_utils.h"
+#include "bnxt_ulp_tfc.h"
+#include "ulp_utils.h"
 #include "ulp_template_struct.h"
 #include "ulp_mapper.h"
 #include "ulp_flow_db.h"
@@ -883,7 +885,7 @@ ulp_flow_db_resource_get(struct bnxt_ulp_context *ulp_ctxt,
  *
  * returns 0 on success and negative on failure.
  */
-static int32_t
+int32_t
 ulp_flow_db_next_entry_get(struct bnxt_ulp_flow_db *flow_db,
 			   enum bnxt_ulp_fdb_type flow_type,
 			   uint32_t *fid)
diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
index 24012e30b1..191157ebe1 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr.c
@@ -19,7 +19,6 @@
 #include "ulp_template_db_enum.h"
 #include "ulp_template_struct.h"
 #include "tfc.h"
-#include "tfc_debug.h"
 #include "tfc_action_handle.h"
 
 #define ULP_TFC_CNTR_READ_BYTES 32
diff --git a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c
index 23edf9f755..3b863115f0 100644
--- a/drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c
+++ b/drivers/net/bnxt/tf_ulp/ulp_sc_mgr_tfc.c
@@ -18,7 +18,6 @@
 #include "ulp_template_db_enum.h"
 #include "ulp_template_struct.h"
 #include "tfc.h"
-#include "tfc_debug.h"
 #include "tfc_action_handle.h"
 
 static int32_t
-- 
2.39.5 (Apple Git-154)

