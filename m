Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D022DCCD184
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 22:18:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4589340E15;
	Fri, 10 Oct 2025 00:16:27 +0200 (CEST)
Received: from mail-io1-f98.google.com (mail-io1-f98.google.com
 [209.85.166.98]) by mails.dpdk.org (Postfix) with ESMTP id 27B0A40E30
 for <dev@dpdk.org>; Fri, 10 Oct 2025 00:16:26 +0200 (CEST)
Received: by mail-io1-f98.google.com with SMTP id
 ca18e2360f4ac-90a0b3ddebeso55588539f.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760048185; x=1760652985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=pucuAlXbFMMW2u4VAuTNlDjz+vd5nLl9Z4TET2yJoVjSrSsdtxCQR83/ywTjK6jC3M
 RmIpqLHwakPPBmDJzcwXp+uWGi0Q9J8xyz4jAROLbashV4puvfpEEi8aJK3ndivQA02J
 rnIJ78XpiHE6jJjUkSMORjrS+4UIpS32mankb1XnXb+4X/ond5fvPLiv4EEDRph9x1AO
 om6m6W7ZUmYaP+gIQQixrf5bVSQIP9G64PjzGJQus/0Rzf9k1fZ8M3NLJs5YNH/xq09f
 Sk19HyS5j7U/QL/h2VltJlt0XDHpi3wNXn0JVW7hpf4jYOmpAnjcXXqsHBazb2igOLzQ
 imcA==
X-Gm-Message-State: AOJu0Yyq9RfBbqRlXNQaIZRYDEuWVes+pY2HGH+02yBsd8tLVgxOZHVI
 SJH7zaq4K0QUZ2UjzFtCXG60ASPixjGpZODyyRrFisF+O1mSaKhKw9F1qfJTTFyG96RVZrh51jo
 LMSKtkgcHtaJ4n4IFP3vQsBODAEWbeqw9BZXuWY1xZoJnCF+d/uoIs1ElnvWAN9X3WEhvMHk6AI
 hn2YHPY3qJGgccIwa3N7CppmGPztIgzVkmIyPGwVWjaZNhG5/KzptKgGbYzJUhFLT6lXu3JQ==
X-Gm-Gg: ASbGncttIdmKZc4haqJfANDzDu5eVq3eyTTVQGC7hMZv6BQM13Zn4Bq2lF0gEOlgXkh
 y2C+4HDJo93o5vMiVCMFwjoBNEbyAi2p3loGK2o3bllsYw/p1Ht5OmhxJeOV31zAKTzCisVB5Z8
 ntX9Nl3/DhztHlG9lamrGks4h5aJ9EFpiBb58dMSfh2pI/l0lAADtssm97prNRmIaTqPnCGTEtS
 nTZnvN5ZQ5d4qbcDp4PXMILYFXdotbF4TXc2wjyLsD3ovkHfdviXrCcer+Fi4aPGY3CrwWJY4Gh
 AZ9RwwhrwfTmysoNAwrsymnKHZmeDo7Y7cqdkrEHw37NIHqWLrSBmltnLJrYVRKAr1x/TVbnoTv
 mZw/NXYfqcS0vnVgMMzrDBSqkfXZrZemjH4kMcHuNdHOCfEH8BLnYjsB/u2A1oc12OvUzYEfXTj
 a5vIkqq4w=
X-Google-Smtp-Source: AGHT+IGr3IT8roiEqamg8yqmWndC6vCN/qEaFWhkjz3+buMHPuP2R6O96wGtYuVuhStgP8GdoTi4/YE8IRvZ
X-Received: by 2002:a05:6e02:461c:b0:42f:880a:cffe with SMTP id
 e9e14a558f8ab-42f880ad145mr62811105ab.26.1760048185309; 
 Thu, 09 Oct 2025 15:16:25 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
 by smtp-relay.gmail.com with ESMTPS id
 e9e14a558f8ab-42f9025f1afsm2328425ab.10.2025.10.09.15.16.24
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 09 Oct 2025 15:16:25 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-78e4e07aa39so44054706d6.0
 for <dev@dpdk.org>; Thu, 09 Oct 2025 15:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1760048183; x=1760652983; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=SA7HgMfb3BJuPSczM/3SZWAibXxiMFBqKGeLT972vuRgnEVgyGyp2GCOVGudxx4Dno
 jwm4PSBpnDkpspvXpCc5KJQwWvwS8ly2cu9vMXpEPmucilhI41MpzPr3LeIdwM2vSyTr
 cRTuNBqERt6mPcJnpJ8f8KHjixd57tk1BfnUw=
X-Received: by 2002:ad4:5ccd:0:b0:769:cd09:9d77 with SMTP id
 6a1803df08f44-87b20ff9d64mr148726576d6.4.1760048182926; 
 Thu, 09 Oct 2025 15:16:22 -0700 (PDT)
X-Received: by 2002:ad4:5ccd:0:b0:769:cd09:9d77 with SMTP id
 6a1803df08f44-87b20ff9d64mr148726066d6.4.1760048182353; 
 Thu, 09 Oct 2025 15:16:22 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87bc3479344sm4189986d6.17.2025.10.09.15.16.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 09 Oct 2025 15:16:21 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH v2 39/54] net/bnxt: thor2 truflow memory manager bug
Date: Thu,  9 Oct 2025 18:11:14 -0400
Message-Id: <20251009221129.28256-40-manish.kurup@broadcom.com>
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

