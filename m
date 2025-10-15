Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB71CCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 09:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9685F410E6;
	Wed, 15 Oct 2025 11:05:11 +0200 (CEST)
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com
 [209.85.166.100])
 by mails.dpdk.org (Postfix) with ESMTP id D243F410E7
 for <dev@dpdk.org>; Wed, 15 Oct 2025 11:05:09 +0200 (CEST)
Received: by mail-io1-f100.google.com with SMTP id
 ca18e2360f4ac-9298eba27c2so278108039f.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760519109; x=1761123909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=k/FZp6r409nm/5jhFUR7mYUv+P0npkKo4YfG8c7fg/5++QuA4tT6l1XK32B58SnYvQ
 V9PrPDQXC6fGICkoQiAN6zGinzlmqzkJkHgZ/TY3nTyMgj9mSTpbfPVlW+uVW6MJnjYg
 NBPnwRlFFFCos8iIsegJzfHJvL2FlQDq6xVScjJTeJe0gZDGkHe3CFMNY4wUw5O6P0kj
 nBDGOz9yAqSjYNCB3bDCGt41vss81kck0peuv0t0XDMi7sQ0umSWp8giGgO4+6dqdHMU
 DldOHQREOJVyP9YZb0V93CVh3H2GdMJ5JsOBYeghRGsdTPrTUzT2oM27dbeLjMpp7KdS
 FqFA==
X-Gm-Message-State: AOJu0YzpnNMwCPPSwByZTiRuT6vdUvdMw6pbeSlJbLD+wpwuKOCLQcGl
 cPolnVZEZUJNs5av1UCH//gvn+h/WtU1zS9jg9KQjCBrKWbFyoYwWLfLzO6xmfzf4xrD+PUdeu9
 FmZZRRxMJL7s9A9Qc6eon6tmeDwI+E+D0H/9JzasOGMC8yZrIndrbfqoTe5Q8WLxu9HO7GtZMKJ
 4kdlYTIhkosvopVOyCMQJ7gXNmWv1c6OzYlcI0C4+N5hgNqtii1FL0gXTitY4CqHPJjExOgg==
X-Gm-Gg: ASbGncsqV2nAGGyHBk+RKYeC8nAiiJ7hSNw+dd1NH7itQQjY69SfPXWDeeZbDIrbXf6
 Lk950lvVr7NLInIfu7ZIB8UMGAobSVJTv93i4s+TCHhO+sLvDPyrie6QYGlItfK93i12/r90Akm
 hL2/BeFHbhsUxxcjNs3Y6e5/7Cf7/JzgThs49h6ei02k9Gl/NPLYU03vy5bf+g6fWtEi7depyyy
 kgMCd5TGpa3qKMQ92PtxHPsUB4RAEi+U40vvhsKLxahxurQOCTqdO4mwhRGSdUsHM7ea3vW59oR
 +tcoNykKRi7KtbinnSIXiAy1u+PwaroeDdOXZ/0SgKYf0QS4Ah6kQBq+xZCnBICj3NOGY5u8GMT
 UsTmITqEpS9kQRCkcjyt/mXYI5quDmKk3hx/1N3A3N5gG04dZGuJ+m0hIj9P2WswWlZp602WRNM
 CABw==
X-Google-Smtp-Source: AGHT+IFyFv6IvJSzHJvB8J3JSrSFcy0Ry2vGQuzvRRy5n1n4ckbo6JoFsRq3Xp+L3FGuTyNlIQteH56138ZH
X-Received: by 2002:a05:6602:a008:b0:93e:4f78:c5d4 with SMTP id
 ca18e2360f4ac-93e4f78fde1mr1018444139f.7.1760519108751; 
 Wed, 15 Oct 2025 02:05:08 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
 by smtp-relay.gmail.com with ESMTPS id
 ca18e2360f4ac-93e25a4c78esm94421339f.11.2025.10.15.02.05.07
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 15 Oct 2025 02:05:08 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-78117b8e49fso18331164b3a.3
 for <dev@dpdk.org>; Wed, 15 Oct 2025 02:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760519106; x=1761123906; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=hzVMhOAJBn+f1D3FSnLHLfZG6I1z5UgRiXRyreOL5qsTo5c1+XKcqvW0omJrnaibaM
 zceze+OT7f44cNHzcn2xEuRnDbxDIKM0HGxCFmI5Ho3e7QFKiKqCnR3Xqx1s8Y2fJaKf
 G7NIsBbhbbcEYL8hJwZelOKGHUsJsdPARlOG8=
X-Received: by 2002:a05:6a00:2e1f:b0:783:6042:114a with SMTP id
 d2e1a72fcca58-79387435dd1mr31817753b3a.25.1760519105870; 
 Wed, 15 Oct 2025 02:05:05 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e1f:b0:783:6042:114a with SMTP id
 d2e1a72fcca58-79387435dd1mr31817674b3a.25.1760519104596; 
 Wed, 15 Oct 2025 02:05:04 -0700 (PDT)
Received: from localhost.localdomain ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bc12a8asm17832412b3a.34.2025.10.15.02.05.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Oct 2025 02:05:04 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v3 39/54] net/bnxt: thor2 truflow memory manager bug
Date: Wed, 15 Oct 2025 05:00:09 -0400
Message-Id: <20251015090024.32250-40-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251015090024.32250-1-manish.kurup@broadcom.com>
References: <20251009221129.28256-1-manish.kurup@broadcom.com>
 <20251015090024.32250-1-manish.kurup@broadcom.com>
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

