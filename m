Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3D1CCD1B9
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Oct 2025 18:58:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED15440ED3;
	Tue, 21 Oct 2025 20:58:04 +0200 (CEST)
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com
 [209.85.210.226])
 by mails.dpdk.org (Postfix) with ESMTP id AC0E440B8D
 for <dev@dpdk.org>; Tue, 21 Oct 2025 20:58:03 +0200 (CEST)
Received: by mail-pf1-f226.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so4892972b3a.2
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761073083; x=1761677883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=D5X4gAtvCKjEJ+bM6R774mknJ66lyT2gjNIcl/7+nR0sYov4kRO46bN9eCussLce4A
 +txemisggTjEjL8xcaEN+nu5sVa/BDb7PsvyY2M1nHc/nDV+2Qd2m0XhsuhIeCJswplE
 HEh3BAaBME6Ylq04Q/5/AfquuZhT5kjncWAqjozSVNHQ2r9le2XPDKqD9I2/rPn4zCvk
 E4NRvcRYMp0GWsFM14r4bRsf2/CAQ2DuAPJSpFV0Hx0Niox+FfRug90PWiMWqn6pQWcy
 nLDbUfGFzwqAoAHTs9wV6MNYmzCO5QEAgWLwDjICTLE+Vevon9rSy3HSxYCJFgEqTYMu
 P4yg==
X-Gm-Message-State: AOJu0YzPaa5UYRpy019qu9tAvg552TnoCqPF0E69tDVAS1n28+pCew7f
 uXY2sqkMmLpOlNx2Md4YZtalD3fXIL3ip/9pEifq/+3DmVCGyZ3haDeoYShTB46sDEM0UYu13NB
 BMQyzP3UuYkjJRj4t7Yxa/Nl1TLz6o2YjrO1R9f2qN59B8XQDmaPZBHoFz4t/B2kflVbGwPm6qU
 pqlvZSd6sDBCHJoOZSdIb2Peddl4E2UngR7D76riYYp6fmvdFg9t+533bFoia1K3o18Vd5pg==
X-Gm-Gg: ASbGnctGEHhXS9NXIsxvOOdleU4HW5ZKu7cpGh9MV1UpwNJa3lpRTyb4dD9iNqBaP4V
 umDGxB7+rxClNE5H+LX49c7AbiZCDw3JGatz0b5Draj2LeHMHuGiXtimMMNveL4Pr8BhX4TFbTs
 7yIA1yseXxbDkCL2x0t6X/zN6IZCMwy5HSALdcaFFdCfolU2CgKVisMimqF2mt3xlzVEA53+6pK
 066zPs9+C07BOCSkCuu1la21mKUQxNfiYxI22RLeeQu4cR2u/e9YQs2kkJYrOFMKPnViMUIWUQv
 JP5aSIRjUHlxH6CwUviWLOnshioDOiWykJ/aGOiklMEkd3sjts8+QUlmY6AFzQWAd51iymCjqEP
 7QAj9XjIR5x53xENGof9mXOIsAkOc2JQW/wSDFnmlLDQIjIUutoRROjMyDkpzP3IPkQ0VlAlT1n
 ij8kyDjJibPAHYahGUhtt4xL1OeZu+IUL/pA==
X-Google-Smtp-Source: AGHT+IGIWZj8e3/rfa1rNfZUcaKhYR0fYZ54imKR1m2f6pETGB7A+DscaX42ZiPa4uWhrxw8n51IXDB1Wjh4
X-Received: by 2002:a05:6a20:6a0e:b0:2cc:acef:95ee with SMTP id
 adf61e73a8af0-334a864846amr25625852637.52.1761073082620; 
 Tue, 21 Oct 2025 11:58:02 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
 by smtp-relay.gmail.com with ESMTPS id
 41be03b00d2f7-b6cd0ce3200sm139411a12.11.2025.10.21.11.58.02
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 21 Oct 2025 11:58:02 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-b6cd0ee184aso305290a12.0
 for <dev@dpdk.org>; Tue, 21 Oct 2025 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1761073080; x=1761677880; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=APsfh8JlxwPYo1/seCXXxwWzdurinMIP9Vfjy333nL+HsBCBDz+fOpzIN9gwnggKWO
 a2mpLGs3L/PjDcqER9MaZzR/oG6mKY6uMwYJjRJFGlmQtpNRgMYyDbuNKIkZokiDl9NX
 ceNk4o3UH0Rf2TpON21nUQNgwapUbpU8pNNrU=
X-Received: by 2002:a17:902:f605:b0:24c:b39f:baaa with SMTP id
 d9443c01a7336-290cb183b74mr239695615ad.49.1761073080318; 
 Tue, 21 Oct 2025 11:58:00 -0700 (PDT)
X-Received: by 2002:a17:902:f605:b0:24c:b39f:baaa with SMTP id
 d9443c01a7336-290cb183b74mr239695275ad.49.1761073079624; 
 Tue, 21 Oct 2025 11:57:59 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246fdc9cfsm116598155ad.45.2025.10.21.11.57.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 11:57:59 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v4 42/57] net/bnxt: thor2 truflow memory manager bug
Date: Tue, 21 Oct 2025 14:56:46 -0400
Message-Id: <20251021185701.71881-11-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251021185701.71881-1-manish.kurup@broadcom.com>
References: <20251021185701.71881-1-manish.kurup@broadcom.com>
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

