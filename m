Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E08CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 16:21:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7E9B40669;
	Wed, 29 Oct 2025 17:21:29 +0100 (CET)
Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com
 [209.85.210.228])
 by mails.dpdk.org (Postfix) with ESMTP id 234D34065F
 for <dev@dpdk.org>; Wed, 29 Oct 2025 17:21:29 +0100 (CET)
Received: by mail-pf1-f228.google.com with SMTP id
 d2e1a72fcca58-78af743c232so96381b3a.1
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:21:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761754888; x=1762359688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=W51HeBO41kRpKvAzYn0QekddsigjTl90wIkQ1Yuy0CeDAOV8OwdqLOl5LXU2l2hfVV
 hmMwDFnRRymzh9XvJKTQFRfMu4DgglAJZp6jl5fiJeLyxTuXZEIjqaPUAcAO8Ub5SOai
 p1bhcrjJyW2v3/XBTDYwWHaM9v9B5qbGfPOn+/vKmcur9u5lgD69Ipoi0RTtw41xY9ZQ
 ZnRyo8ROyIRvoT40k5r2OgZIyBTRqeGQJAGldch5IvtPdcjvgD5Fdsp2mQxa2EG5HMr8
 eSIcrGlcD/+GjVDUmsn+eiiIrdmjfrS5QJuxjws0xQ40EIC6chG3eSWO7KT9QU5+eYsQ
 QtqA==
X-Gm-Message-State: AOJu0YwDGBK0G/RKgcachDCR+v3++oxhDebF/SSCrcEkTaobQbAVMgjg
 N/1Yign822ugUwNXc95I2++nFOZzi+aezyhG4LK+2/ZCxVxLArehrxyB6I4BQSdHTjKhw1cwLT5
 ZEdo7zhMk+AXpK0yYf9jRAH8qpBY2GL+J9iqmJ5uBqC5AgEO0pm6hQt1ktKaMZQDTZerYV7DjEZ
 Dmox8ii6+yjQzpQY+QGRqJWm9JSXYp7iZ/KZ6t8W+PmpHsBgOkfxp+e8xUoGxz4yN7qPJwDA==
X-Gm-Gg: ASbGncvz/+tmnLNgr/donLlrFka43aMQvpoOXy9nOxtsB62Hf4N1Z8IVUvM9+jc4ZF2
 /FByPTloBo89QcswE7apQSMVp8ZkET27PPRPXE5tY5lpVLkJ5H1vJTQpJj7RP0DOVDtW2zdUJOX
 Iw+ZrYiSH17hlvlO6f/CGtyovEZlwe92lLu4kfIdZ4GVxdg3aCBY8ItsAWq6vFHNKHCAbQd3Rwu
 5WTKRQw+J1NwQh/64WMc8HZL/Xgh0SYxVjmN4Z1aZzQeAWAgUfWHmuGAZHH+K8YW8CfkII7F+Gc
 EQ6AOe5V0EyAepjdg0CYVj2RHyEfb2IxdO698aQO4nTg5+di4hQi4brgQAKyQz3VvltHEcXFoQa
 wG1KkV6VtnSHjNmbp8qyGUGCPeIgQcXrB/cpTIQdURjr4gHLngRDyO9/XtCeyqTL2oQaVCLYffo
 n6HubemDZccw5SHcgZHwtbzfYteE2rve8=
X-Google-Smtp-Source: AGHT+IEB0IIoDn4iJRjALwE4Cx5Vb/8V1k5X82+jyRND3n+H9zPUM4pZO7clcZvWnLZyyee82k6fGdxnkyXO
X-Received: by 2002:a05:6a20:7488:b0:341:5677:9d3a with SMTP id
 adf61e73a8af0-346553ffcd8mr4782890637.49.1761754888131; 
 Wed, 29 Oct 2025 09:21:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-7a4140c47a0sm994674b3a.11.2025.10.29.09.21.27
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 29 Oct 2025 09:21:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8a0aa0df911so1308199085a.3
 for <dev@dpdk.org>; Wed, 29 Oct 2025 09:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761754886; x=1762359686; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=OfeAz4wkqQiGzeVdXAhSHR6qlnrkrY8JlYNCGrxmHUnOLQJ9+s2jVfAD0PjY7ks+TT
 7XlV/vABUBnoaqEbxWG4z0LLaavWnhiIcHP3/hgYhJUi2zxKdghahJglIXEvY7e9anV/
 EqpY0Bx93eSUwt0MIwc10noMBMIYjwlLKzVKo=
X-Received: by 2002:a05:620a:394f:b0:886:173f:1b4c with SMTP id
 af79cd13be357-8a8efb03020mr399121085a.80.1761754886211; 
 Wed, 29 Oct 2025 09:21:26 -0700 (PDT)
X-Received: by 2002:a05:620a:394f:b0:886:173f:1b4c with SMTP id
 af79cd13be357-8a8efb03020mr399114685a.80.1761754885487; 
 Wed, 29 Oct 2025 09:21:25 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-89f2421fba6sm1089026785a.4.2025.10.29.09.21.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 09:21:25 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v5 42/57] net/bnxt: thor2 truflow memory manager bug
Date: Wed, 29 Oct 2025 12:06:57 -0400
Message-Id: <20251029160712.58519-43-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251029160712.58519-1-manish.kurup@broadcom.com>
References: <20251021175049.46092-1-manish.kurup@broadcom.com>
 <20251029160712.58519-1-manish.kurup@broadcom.com>
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

From: Farah Smith <farah.smith@broadcom.com>

A performance optimization was made based upon the belief that blocks
in the memory manager always had non-full blocks prior to full blocks.
But this is not the case.  The performance optimization stopped looking
for space in the block list as soon as the first full block was found
in the list.  This fix adds code so that whenever a block is full, it is
moved to the end of the list so that the search can stop upon reaching
the first full block.  Remove current_blk_idx.  Adjust max_records based
upon max contiguous.

Signed-off-by: Farah Smith <farah.smith@broadcom.com>
Reviewed-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c     | 83 ++++++++++++-------
 .../net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h    |  2 +-
 2 files changed, 56 insertions(+), 29 deletions(-)

diff --git a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c
index 05528dd3e4..6e21d513ac 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c
+++ b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm.c
@@ -48,6 +48,10 @@ int cfa_mm_query(struct cfa_mm_query_parms *parms)
 	max_records = parms->max_records;
 	max_contig_records = (uint16_t)parms->max_contig_records;
 
+	/* Align to max_contig_records */
+	max_records = (max_records + (max_contig_records - 1)) &
+		      ~(max_contig_records - 1);
+
 	if (unlikely(!(CFA_CHECK_BOUNDS(max_records, 1, CFA_MM_MAX_RECORDS) &&
 	      IS_POWER_2(max_contig_records) &&
 	      CFA_CHECK_BOUNDS(max_contig_records, 1,
@@ -79,6 +83,10 @@ int cfa_mm_open(void *cmm, struct cfa_mm_open_parms *parms)
 	max_records = parms->max_records;
 	max_contig_records = (uint16_t)parms->max_contig_records;
 
+	/* Align to max_contig_records */
+	max_records = (max_records + (max_contig_records - 1)) &
+		      ~(max_contig_records - 1);
+
 	if (unlikely(!(CFA_CHECK_BOUNDS(max_records, 1, CFA_MM_MAX_RECORDS) &&
 	      IS_POWER_2(max_contig_records) &&
 	      CFA_CHECK_BOUNDS(max_contig_records, 1,
@@ -115,11 +123,11 @@ int cfa_mm_open(void *cmm, struct cfa_mm_open_parms *parms)
 	context->blk_bmap_tbl = (uint8_t *)(context->blk_tbl + num_blocks);
 
 	context->blk_list_tbl[0].first_blk_idx = 0;
-	context->blk_list_tbl[0].current_blk_idx = 0;
+	context->blk_list_tbl[0].last_blk_idx = 0;
 
 	for (i = 1; i < num_lists; i++) {
 		context->blk_list_tbl[i].first_blk_idx = CFA_MM_INVALID32;
-		context->blk_list_tbl[i].current_blk_idx = CFA_MM_INVALID32;
+		context->blk_list_tbl[i].last_blk_idx = CFA_MM_INVALID32;
 	}
 
 	for (i = 0; i < num_blocks; i++) {
@@ -162,6 +170,7 @@ int cfa_mm_close(void *cmm)
 	return 0;
 }
 
+/* Allocate a block idx from the free list */
 static uint32_t cfa_mm_blk_alloc(struct cfa_mm *context)
 {
 	uint32_t blk_idx;
@@ -179,8 +188,6 @@ static uint32_t cfa_mm_blk_alloc(struct cfa_mm *context)
 	free_list->first_blk_idx =
 		context->blk_tbl[free_list->first_blk_idx].next_blk_idx;
 
-	free_list->current_blk_idx = free_list->first_blk_idx;
-
 	if (free_list->first_blk_idx != CFA_MM_INVALID32) {
 		context->blk_tbl[free_list->first_blk_idx].prev_blk_idx =
 			CFA_MM_INVALID32;
@@ -192,6 +199,7 @@ static uint32_t cfa_mm_blk_alloc(struct cfa_mm *context)
 	return blk_idx;
 }
 
+/* Return a block index to the free list */
 static void cfa_mm_blk_free(struct cfa_mm *context, uint32_t blk_idx)
 {
 	struct cfa_mm_blk_list *free_list = context->blk_list_tbl;
@@ -208,16 +216,17 @@ static void cfa_mm_blk_free(struct cfa_mm *context, uint32_t blk_idx)
 	}
 
 	free_list->first_blk_idx = blk_idx;
-	free_list->current_blk_idx = blk_idx;
 }
 
+/* insert at the top of a non-free list */
 static void cfa_mm_blk_insert(struct cfa_mm *context,
 			      struct cfa_mm_blk_list *blk_list,
 			      uint32_t blk_idx)
 {
+	/* there are no entries in the list so init all to this one */
 	if (blk_list->first_blk_idx == CFA_MM_INVALID32) {
 		blk_list->first_blk_idx = blk_idx;
-		blk_list->current_blk_idx = blk_idx;
+		blk_list->last_blk_idx = blk_idx;
 	} else {
 		struct cfa_mm_blk *blk_info = &context->blk_tbl[blk_idx];
 
@@ -226,10 +235,29 @@ static void cfa_mm_blk_insert(struct cfa_mm *context,
 		context->blk_tbl[blk_list->first_blk_idx].prev_blk_idx =
 			blk_idx;
 		blk_list->first_blk_idx = blk_idx;
-		blk_list->current_blk_idx = blk_idx;
 	}
 }
 
+/* insert at the bottom of a non-free list */
+static void cfa_mm_blk_insert_last(struct cfa_mm *context,
+				   struct cfa_mm_blk_list *blk_list,
+				   uint32_t blk_idx)
+{
+	if (blk_list->last_blk_idx == CFA_MM_INVALID32) {
+		blk_list->first_blk_idx = blk_idx;
+		blk_list->last_blk_idx = blk_idx;
+	} else {
+		struct cfa_mm_blk *blk_info = &context->blk_tbl[blk_idx];
+
+		blk_info->prev_blk_idx = blk_list->last_blk_idx;
+		blk_info->next_blk_idx = CFA_MM_INVALID32;
+		context->blk_tbl[blk_list->last_blk_idx].next_blk_idx =
+			blk_idx;
+		blk_list->last_blk_idx = blk_idx;
+	}
+}
+
+/* delete from anywhere in the list */
 static void cfa_mm_blk_delete(struct cfa_mm *context,
 			      struct cfa_mm_blk_list *blk_list,
 			      uint32_t blk_idx)
@@ -239,15 +267,20 @@ static void cfa_mm_blk_delete(struct cfa_mm *context,
 	if (blk_list->first_blk_idx == CFA_MM_INVALID32)
 		return;
 
+	if (blk_list->last_blk_idx == blk_idx) {
+		blk_list->last_blk_idx = blk_info->prev_blk_idx;
+		if (blk_list->last_blk_idx != CFA_MM_INVALID32) {
+			context->blk_tbl[blk_list->last_blk_idx].next_blk_idx =
+				CFA_MM_INVALID32;
+		}
+	}
+
 	if (blk_list->first_blk_idx == blk_idx) {
 		blk_list->first_blk_idx = blk_info->next_blk_idx;
 		if (blk_list->first_blk_idx != CFA_MM_INVALID32) {
 			context->blk_tbl[blk_list->first_blk_idx].prev_blk_idx =
 				CFA_MM_INVALID32;
 		}
-		if (blk_list->current_blk_idx == blk_idx)
-			blk_list->current_blk_idx = blk_list->first_blk_idx;
-
 		return;
 	}
 
@@ -260,20 +293,6 @@ static void cfa_mm_blk_delete(struct cfa_mm *context,
 		context->blk_tbl[blk_info->next_blk_idx].prev_blk_idx =
 			blk_info->prev_blk_idx;
 	}
-
-	if (blk_list->current_blk_idx == blk_idx) {
-		if (blk_info->next_blk_idx != CFA_MM_INVALID32) {
-			blk_list->current_blk_idx = blk_info->next_blk_idx;
-		} else {
-			if (blk_info->prev_blk_idx != CFA_MM_INVALID32) {
-				blk_list->current_blk_idx =
-					blk_info->prev_blk_idx;
-			} else {
-				blk_list->current_blk_idx =
-					blk_list->first_blk_idx;
-			}
-		}
-	}
 }
 
 /* Returns true if the bit in the bitmap is set to 'val' else returns false */
@@ -413,12 +432,19 @@ int cfa_mm_alloc(void *cmm, struct cfa_mm_alloc_parms *parms)
 
 		blk_info->num_contig_records = num_records;
 	} else {
-		blk_idx = blk_list->current_blk_idx;
+		blk_idx = blk_list->first_blk_idx;
 		blk_info = &context->blk_tbl[blk_idx];
 	}
 
 	while (blk_info->num_free_records < num_records) {
-		if (blk_info->next_blk_idx == CFA_MM_INVALID32 || !blk_info->num_free_records) {
+		/*
+		 * All non-full entries precede full entries so
+		 * upon seeing the first full entry, allocate
+		 * new block as this means all following records
+		 * are full.
+		 */
+		if (blk_info->next_blk_idx == CFA_MM_INVALID32 ||
+		    !blk_info->num_free_records) {
 			blk_idx = cfa_mm_blk_alloc(context);
 			if (unlikely(blk_idx == CFA_MM_INVALID32)) {
 				ret = -ENOMEM;
@@ -433,8 +459,6 @@ int cfa_mm_alloc(void *cmm, struct cfa_mm_alloc_parms *parms)
 		} else {
 			blk_idx = blk_info->next_blk_idx;
 			blk_info = &context->blk_tbl[blk_idx];
-
-			blk_list->current_blk_idx = blk_idx;
 		}
 	}
 
@@ -459,6 +483,9 @@ int cfa_mm_alloc(void *cmm, struct cfa_mm_alloc_parms *parms)
 	blk_info->num_free_records -= num_records;
 
 	if (!blk_info->num_free_records) {
+		/* move block to the end of the list if it is full */
+		cfa_mm_blk_delete(context, blk_list, blk_idx);
+		cfa_mm_blk_insert_last(context, blk_list, blk_idx);
 		blk_info->first_free_record = context->records_per_block;
 	} else {
 		cnt = NUM_ALIGN_UNITS(context->records_per_block,
diff --git a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h
index 2a646217ec..dbac1c3cf2 100644
--- a/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h
+++ b/drivers/net/bnxt/hcapi/cfa_v3/mm/cfa_mm_priv.h
@@ -47,7 +47,7 @@ struct cfa_mm_blk_list {
 	/* Index of the first block in the list */
 	uint32_t first_blk_idx;
 	/* Index of the current block having free records */
-	uint32_t current_blk_idx;
+	uint32_t last_blk_idx;
 };
 
 /**
-- 
2.39.5 (Apple Git-154)

