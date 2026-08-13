Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C0EC5B572
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DA2242E12;
	Thu, 13 Aug 2026 19:22:56 +0200 (CEST)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mails.dpdk.org (Postfix) with ESMTP id ACA7242E1D
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:22:54 +0200 (CEST)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbef1d25500so47447a12.1
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641774; x=1787246574; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=uUr2o+kuY46bqc9Ll9j89+RTwIeHHQkE2wJ42JltC7s=;
 b=YMKkUtwAiDnupmsj/Q757QorFY5PK7z49XyggkPZLAwhdxxeTAf+gX3nrRIX2wRaVy
 OZlqIbWm48q0hzQX4X8Ho6yxN6IbnGIamqxS+uC2C3fYH+dpEHoQC6Ed33RI+O573NKu
 pK6BmmJVOBGd2nqJKsI3IBFECncRO4wJlQMNSQyvz1e8nxTRXdGtkyL2PhZmFiv2nuVO
 DXtpaDbu+aA02Ic01bAbZiEpXsv8Z5KdevJyer3fRBhXBuv5ntytpMdDQyu8k31JOwIZ
 6viQWBgypYzQZ1+3JURl2szc0UEblrpghBsoeDPr4HzISFxheyCIXqAe5+6eriVTPIvL
 5eQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641774; x=1787246574;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uUr2o+kuY46bqc9Ll9j89+RTwIeHHQkE2wJ42JltC7s=;
 b=aeIVOateL95+lhEcSG49vCSZoYPrL8/roogr2cY1xOGA2M6jVyEk0M2OStQQGqVE+Z
 4x1jH56ZyOtHDOJKIzsg6q1xsKfkQnua0aQM0zfA7A0iyIuN+Kr8NrINoG/a8NIJlfRm
 qddhdT/K6HvZ1pp/wnveBGaDiHwOP/qL1CkZ8f79dtUsXzoE0nqBwJ72/Lsl8u1g8HNS
 MDmcY1SGQHidhyMZpe1EPhZ9WSfEEWUSuuq6GRoNBdHKWSLJEKWL9B5ghOSAhrq7BEPC
 sNiGY2olXqLXsgMx6rAlxaz6HxwPZVhZpXm+fvhgGnB5iVv90Ei9tcSkQwQ8+sPDPl+c
 66dQ==
X-Gm-Message-State: AOJu0YwbHMH36FoD2sVRQ+/04rDC3e6gYHKJr3aMo2/hUnDOyegwd8AM
 4XQHemVudaU700h2/urDVM/WVqn++GKt9kzWSgz/MMnQvv2KrKZLTo1ukGb+J4bR+ECfon75eg0
 uagGH0OldW+Mu4Q==
X-Received: from pjzd3.prod.google.com ([2002:a17:90a:e283:b0:38f:f04:c1e8])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:53cb:b0:37f:c28a:de61 with SMTP id
 98e67ed59e1d1-3931e25da78mr8873397a91.17.1786641773505; 
 Thu, 13 Aug 2026 10:22:53 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:30 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-6-joshwash@google.com>
Subject: [PATCH v2 05/14] net/qede: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Content-Type: text/plain; charset="UTF-8"
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP and
RTE_DIV_ROUND_UP definitions redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/qede/base/bcm_osal.h            |  2 --
 drivers/net/qede/base/ecore_chain.h         |  2 +-
 drivers/net/qede/base/ecore_cxt.c           | 20 +++++++++++---------
 drivers/net/qede/base/ecore_init_fw_funcs.c | 21 ++++++++++++---------
 drivers/net/qede/base/ecore_mcp.c           |  6 +++---
 drivers/net/qede/qede_debug.c               | 16 ++++++++--------
 6 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/net/qede/base/bcm_osal.h b/drivers/net/qede/base/bcm_osal.h
index 357981f63d..a2f3bc838b 100644
--- a/drivers/net/qede/base/bcm_osal.h
+++ b/drivers/net/qede/base/bcm_osal.h
@@ -396,8 +396,6 @@ int qede_save_fw_dump(uint16_t port_id);
 
 /* Utility functions */
 
-#define RTE_DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-#define DIV_ROUND_UP(size, to_what) RTE_DIV_ROUND_UP(size, to_what)
 #define RTE_ROUNDUP(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #define ROUNDUP(value, to_what) RTE_ROUNDUP((value), (to_what))
 
diff --git a/drivers/net/qede/base/ecore_chain.h b/drivers/net/qede/base/ecore_chain.h
index c69920be54..50b3196f02 100644
--- a/drivers/net/qede/base/ecore_chain.h
+++ b/drivers/net/qede/base/ecore_chain.h
@@ -157,7 +157,7 @@ struct ecore_chain {
 	UNUSABLE_ELEMS_PER_PAGE(elem_size, mode)))
 
 #define ECORE_CHAIN_PAGE_CNT(elem_cnt, elem_size, mode)		\
-	DIV_ROUND_UP(elem_cnt, USABLE_ELEMS_PER_PAGE(elem_size, mode))
+	RTE_DIV_ROUND_UP(elem_cnt, USABLE_ELEMS_PER_PAGE(elem_size, mode))
 
 #define is_chain_u16(p)	((p)->cnt_type == ECORE_CHAIN_CNT_TYPE_U16)
 #define is_chain_u32(p)	((p)->cnt_type == ECORE_CHAIN_CNT_TYPE_U32)
diff --git a/drivers/net/qede/base/ecore_cxt.c b/drivers/net/qede/base/ecore_cxt.c
index d3025724b6..f877d31ecc 100644
--- a/drivers/net/qede/base/ecore_cxt.c
+++ b/drivers/net/qede/base/ecore_cxt.c
@@ -341,7 +341,8 @@ static void ecore_ilt_cli_adv_line(struct ecore_hwfn *p_hwfn,
 		p_cli->first.val = *p_line;
 
 	p_cli->active = true;
-	*p_line += DIV_ROUND_UP(p_blk->total_size, p_blk->real_size_in_page);
+	*p_line += RTE_DIV_ROUND_UP(p_blk->total_size,
+				    p_blk->real_size_in_page);
 	p_cli->last.val = *p_line - 1;
 
 	DP_VERBOSE(p_hwfn, ECORE_MSG_ILT,
@@ -761,7 +762,7 @@ static enum _ecore_status_t ecore_cxt_src_t2_alloc(struct ecore_hwfn *p_hwfn)
 	/* use the same page size as the SRC ILT client */
 	psz = ILT_PAGE_IN_BYTES(p_src->p_size.val);
 	p_t2 = &p_mngr->src_t2;
-	p_t2->num_pages = DIV_ROUND_UP(total_size, psz);
+	p_t2->num_pages = RTE_DIV_ROUND_UP(total_size, psz);
 
 	/* allocate t2 */
 	p_t2->dma_mem = OSAL_ZALLOC(p_hwfn->p_dev, GFP_KERNEL,
@@ -877,7 +878,8 @@ ecore_ilt_blk_alloc(struct ecore_hwfn *p_hwfn,
 
 	sz_left = p_blk->total_size;
 	lines_to_skip = p_blk->dynamic_line_cnt;
-	lines = DIV_ROUND_UP(sz_left, p_blk->real_size_in_page) - lines_to_skip;
+	lines = RTE_DIV_ROUND_UP(sz_left, p_blk->real_size_in_page) -
+		lines_to_skip;
 	line = p_blk->start_line + start_line_offset -
 	       p_hwfn->p_cxt_mngr->pf_start_line;
 	first_skipped_line = line + p_blk->dynamic_line_offset;
@@ -1000,7 +1002,7 @@ __ecore_cid_map_alloc_single(struct ecore_hwfn *p_hwfn, u32 type,
 	if (!cid_count)
 		return ECORE_SUCCESS;
 
-	size = MAP_WORD_SIZE * DIV_ROUND_UP(cid_count, BITS_PER_MAP_WORD);
+	size = MAP_WORD_SIZE * RTE_DIV_ROUND_UP(cid_count, BITS_PER_MAP_WORD);
 	p_map->cid_map = OSAL_ZALLOC(p_hwfn->p_dev, GFP_KERNEL, size);
 	if (p_map->cid_map == OSAL_NULL)
 		return ECORE_NOMEM;
@@ -1217,8 +1219,8 @@ void ecore_cxt_mngr_setup(struct ecore_hwfn *p_hwfn)
 		p_cfg = &p_mngr->conn_cfg[type];
 		if (p_cfg->cid_count) {
 			p_map = &p_mngr->acquired[type];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   BITS_PER_MAP_WORD) *
+			len = RTE_DIV_ROUND_UP(p_map->max_count,
+					       BITS_PER_MAP_WORD) *
 			      MAP_WORD_SIZE;
 			OSAL_MEM_ZERO(p_map->cid_map, len);
 		}
@@ -1228,8 +1230,8 @@ void ecore_cxt_mngr_setup(struct ecore_hwfn *p_hwfn)
 
 		for (vf = 0; vf < max_num_vfs; vf++) {
 			p_map = &p_mngr->acquired_vf[type][vf];
-			len = DIV_ROUND_UP(p_map->max_count,
-					   BITS_PER_MAP_WORD) *
+			len = RTE_DIV_ROUND_UP(p_map->max_count,
+					       BITS_PER_MAP_WORD) *
 			      MAP_WORD_SIZE;
 			OSAL_MEM_ZERO(p_map->cid_map, len);
 		}
@@ -2184,7 +2186,7 @@ static u16 ecore_blk_calculate_pages(struct ecore_ilt_cli_blk *p_blk)
 	if (p_blk->real_size_in_page == 0)
 		return 0;
 
-	return DIV_ROUND_UP(p_blk->total_size, p_blk->real_size_in_page);
+	return RTE_DIV_ROUND_UP(p_blk->total_size, p_blk->real_size_in_page);
 }
 
 u16 ecore_get_cdut_num_pf_init_pages(struct ecore_hwfn *p_hwfn)
diff --git a/drivers/net/qede/base/ecore_init_fw_funcs.c b/drivers/net/qede/base/ecore_init_fw_funcs.c
index 4e4d1dc374..e3a39d0958 100644
--- a/drivers/net/qede/base/ecore_init_fw_funcs.c
+++ b/drivers/net/qede/base/ecore_init_fw_funcs.c
@@ -24,9 +24,11 @@ static u16 task_region_offsets[1][NUM_OF_CONNECTION_TYPES] = {
 
 /* General constants */
 #define QM_PQ_MEM_4KB(pq_size) \
-	(pq_size ? DIV_ROUND_UP((pq_size + 1) * QM_PQ_ELEMENT_SIZE, 0x1000) : 0)
+	(pq_size \
+		? RTE_DIV_ROUND_UP((pq_size + 1) * QM_PQ_ELEMENT_SIZE, 0x1000) \
+		: 0)
 #define QM_PQ_SIZE_256B(pq_size) \
-	(pq_size ? DIV_ROUND_UP(pq_size, 0x100) - 1 : 0)
+	(pq_size ? RTE_DIV_ROUND_UP(pq_size, 0x100) - 1 : 0)
 #define QM_INVALID_PQ_ID		0xffff
 
 /* Max link speed (in Mbps) */
@@ -1313,10 +1315,10 @@ void ecore_init_brb_ram(struct ecore_hwfn *p_hwfn,
 	u32 active_port_blocks, reg_offset = 0;
 	u8 port, active_ports = 0;
 
-	tc_headroom_blocks = (u32)DIV_ROUND_UP(req->headroom_per_tc,
-					       BRB_BLOCK_SIZE);
-	min_pkt_size_blocks = (u32)DIV_ROUND_UP(req->min_pkt_size,
-						BRB_BLOCK_SIZE);
+	tc_headroom_blocks = (u32)RTE_DIV_ROUND_UP(req->headroom_per_tc,
+						   BRB_BLOCK_SIZE);
+	min_pkt_size_blocks = (u32)RTE_DIV_ROUND_UP(req->min_pkt_size,
+						    BRB_BLOCK_SIZE);
 	total_blocks = ECORE_IS_K2(p_hwfn->p_dev) ? BRB_TOTAL_RAM_BLOCKS_K2 :
 						    BRB_TOTAL_RAM_BLOCKS_BB;
 
@@ -1334,8 +1336,9 @@ void ecore_init_brb_ram(struct ecore_hwfn *p_hwfn,
 		u8 tc;
 
 		/* Calculate per-port sizes */
-		tc_guaranteed_blocks = (u32)DIV_ROUND_UP(req->guranteed_per_tc,
-							 BRB_BLOCK_SIZE);
+		tc_guaranteed_blocks =
+			(u32)RTE_DIV_ROUND_UP(req->guranteed_per_tc,
+					      BRB_BLOCK_SIZE);
 		port_blocks = req->num_active_tcs[port] ? active_port_blocks :
 							  0;
 		port_guaranteed_blocks = req->num_active_tcs[port] *
@@ -2059,7 +2062,7 @@ void ecore_enable_context_validation(struct ecore_hwfn *p_hwfn,
 	ecore_wr(p_hwfn, p_ptt, CDU_REG_TCFC_CTX_VALID0, ctx_validation);
 }
 
-#define PHYS_ADDR_DWORDS        DIV_ROUND_UP(sizeof(dma_addr_t), 4)
+#define PHYS_ADDR_DWORDS        RTE_DIV_ROUND_UP(sizeof(dma_addr_t), 4)
 #define OVERLAY_HDR_SIZE_DWORDS (sizeof(struct fw_overlay_buf_hdr) / 4)
 
 static u32 ecore_get_overlay_addr_ram_addr(struct ecore_hwfn *p_hwfn,
diff --git a/drivers/net/qede/base/ecore_mcp.c b/drivers/net/qede/base/ecore_mcp.c
index ec83b244e6..07ba41e1a8 100644
--- a/drivers/net/qede/base/ecore_mcp.c
+++ b/drivers/net/qede/base/ecore_mcp.c
@@ -713,7 +713,7 @@ ecore_mcp_cmd_and_union(struct ecore_hwfn *p_hwfn,
 	}
 #endif
 	if (ECORE_MB_FLAGS_IS_SET(p_mb_params, CAN_SLEEP)) {
-		max_retries = DIV_ROUND_UP(max_retries, 1000);
+		max_retries = RTE_DIV_ROUND_UP(max_retries, 1000);
 		usecs *= 1000;
 	}
 
@@ -4243,8 +4243,8 @@ ecore_mcp_resc_lock(struct ecore_hwfn *p_hwfn, struct ecore_ptt *p_ptt,
 		if (retry_cnt) {
 			if (p_params->sleep_b4_retry) {
 				u16 retry_interval_in_ms =
-					DIV_ROUND_UP(p_params->retry_interval,
-						     1000);
+					RTE_DIV_ROUND_UP(p_params->retry_interval,
+							 1000);
 
 				OSAL_MSLEEP(retry_interval_in_ms);
 			} else {
diff --git a/drivers/net/qede/qede_debug.c b/drivers/net/qede/qede_debug.c
index 1d3147b724..c4cf40b15d 100644
--- a/drivers/net/qede/qede_debug.c
+++ b/drivers/net/qede/qede_debug.c
@@ -332,7 +332,7 @@ struct split_type_defs {
 
 #define BYTES_IN_DWORD			sizeof(u32)
 /* In the macros below, size and offset are specified in bits */
-#define CEIL_DWORDS(size)		DIV_ROUND_UP(size, 32)
+#define CEIL_DWORDS(size)		RTE_DIV_ROUND_UP(size, 32)
 #define FIELD_BIT_OFFSET(type, field)	type ## _ ## field ## _ ## OFFSET
 #define FIELD_BIT_SIZE(type, field)	type ## _ ## field ## _ ## SIZE
 #define FIELD_DWORD_OFFSET(type, field) \
@@ -3060,7 +3060,7 @@ static u32 qed_grc_dump_big_ram(struct ecore_hwfn *p_hwfn,
 		return offset + ram_size;
 
 	/* Dump Big RAM */
-	for (i = 0; i < DIV_ROUND_UP(ram_size, BRB_REG_BIG_RAM_DATA_SIZE);
+	for (i = 0; i < RTE_DIV_ROUND_UP(ram_size, BRB_REG_BIG_RAM_DATA_SIZE);
 	     i++) {
 		u32 addr, len;
 
@@ -4161,8 +4161,8 @@ static enum dbg_status qed_mcp_trace_dump(struct ecore_hwfn *p_hwfn,
 
 	/* Find trace data size */
 	trace_data_size_dwords =
-	    DIV_ROUND_UP(trace_data_size_bytes + sizeof(struct mcp_trace),
-			 BYTES_IN_DWORD);
+	    RTE_DIV_ROUND_UP(trace_data_size_bytes + sizeof(struct mcp_trace),
+			     BYTES_IN_DWORD);
 
 	/* Dump trace data section header and param */
 	offset += qed_dump_section_hdr(dump_buf + offset,
@@ -4817,10 +4817,10 @@ static u32 qed_ilt_dump(struct ecore_hwfn *p_hwfn,
 		offset += num_pages * PAGE_MEM_DESC_SIZE_DWORDS;
 	}
 
-	valid_conn_pf_pages = DIV_ROUND_UP(valid_conn_pf_cids,
-					   num_cids_per_page);
-	valid_conn_vf_pages = DIV_ROUND_UP(valid_conn_vf_cids,
-					   num_cids_per_page);
+	valid_conn_pf_pages = RTE_DIV_ROUND_UP(valid_conn_pf_cids,
+					       num_cids_per_page);
+	valid_conn_vf_pages = RTE_DIV_ROUND_UP(valid_conn_vf_cids,
+					       num_cids_per_page);
 
 	/* Dump ILT pages IDs */
 	offset += qed_ilt_dump_pages_section(p_hwfn,
-- 
2.55.0.691.gc56d675ccc-goog

