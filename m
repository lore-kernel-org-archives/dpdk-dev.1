Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 301F5CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Tue, 30 Sep 2025 07:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 75BC241144;
	Tue, 30 Sep 2025 09:06:32 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 6D1FF402A2
 for <dev@dpdk.org>; Tue, 30 Sep 2025 02:37:32 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-27d69771e3eso44386035ad.3
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759192651; x=1759797451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:dkim-signature
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=OruASCdmqiQ4EmmyOFb6oeYxcKLXj34yfU8W2Tgv+OyJHKMwolN6ZVpxQM3Ijvkysr
 DEc1Fx+a2VOp7VSzeFX+c52bpm8EceEZh5rDkotXBYiTFVEhjxznmJ4z1erabWF0luKX
 ce/GgWAD5uEwZfSI0lqePNX+EB7Kr0YagdSMMiZylNj6Q/vIOcv5f9lR8fp+7eu+sE6s
 GcHaBhCvV0XLGWAhkCaY9hjN8yCMpzY3BeSX/md6nDSiM36iEyFglBH86F+RNP3zEoml
 nHDbh6tFRTtyKSr5zdP2r0oEJKQ/Cj/dh2wOczi0FvSG1tH4FxjeIJIowER+PN7QpUmp
 PHMg==
X-Gm-Message-State: AOJu0Yzs6hljuGrOXiPmYtVjXgUv4Pt397eUhi63hu2P8XpDvAS9n68m
 cS5vNzeu9lp+jxt/zqpKxkIEULIkzxzQXQ4lwAE2jellfwzyk42S2r/x65DNRq7I+ytRqBtCI3H
 q9DxaQRt5HNkiSUM3oTb4euC4kqveNRjZfd6UAJMXuWbJcDpYl8pLKTRYl/W4UT8fD5MJKaQmwM
 poh5bMWq6ewjSVO26JJpa/EJXhTT5VGD9Vj3wLdHcR1WxmiZRWt+cc5LFfGzLHsg5Hpxq+Dw==
X-Gm-Gg: ASbGncvy/0W24rpsf/ATpteu8RxQWXn35WHPRpE797/NTADMxABOSt8l5qdhcYHoJjG
 wMi+OZvT4FVsuDwCXfK8OJONEZa16CFnt6h8PXYam0gOarwOME+NPNekWgk0zrAnB1uQ6ClXznN
 m9bgxKt7M3t3Le31vMzLzvdqk4AWkXp9bxNyGbHIhnnM0LqJc30XdtVeqBQts1o0VsWdM818DFD
 xRFMexb/ufX48fnOnjd3z1++kw2V7yjf7Ov9JCwEp3tlQOqez5n1CEdz4IRriq+2040NtFQxYxn
 Tup4m9THLKEiFnLNNZ0DqOebw1ylf5XCXsnRM/Q0rln4bA8LjzZuVJYBhwBPIHDGiPcYeGWiM6O
 ZVhfHasro1Ad/ZIQoX5tPgEdWtzrOmi2w7giKpXRxdmlmT2v4JKGEPIwQB8W9c79XKf1ozHaGF0
 coD3hOYlo=
X-Google-Smtp-Source: AGHT+IEC41tX5vA0IBM19wVxX+79lHMq+dnhmTKZXaeM6fnEnkyVBDaEuO5Y+UNRzhmuNSZny4DO2agJZJTf
X-Received: by 2002:a17:903:384b:b0:260:df70:f753 with SMTP id
 d9443c01a7336-27ed4a7eadamr203878195ad.38.1759192651506; 
 Mon, 29 Sep 2025 17:37:31 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
 by smtp-relay.gmail.com with ESMTPS id
 d9443c01a7336-27ed66dca5csm10644945ad.20.2025.09.29.17.37.31
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Sep 2025 17:37:31 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-780fb254938so4475085b3a.0
 for <dev@dpdk.org>; Mon, 29 Sep 2025 17:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1759192649; x=1759797449; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JjuOLAByoVKnasUZKyAHZH5ZFvdLXPetPkh5uNPpEDc=;
 b=G64/CC1XwzbQh6MiYMEYNPZ4Jeq2OfZTz44dJGhUTfbRJA/S1GXkEXOko3lwy3MUyK
 zJMTu14n5pGJMo4wVGTIwYQhZJSKH/JjwARVfOshABUt2xgG8e5rcraoavo537Ozn0mu
 QQajoHQNuHM+43J5Lin7fjLKRtHiuyR7lXEsA=
X-Received: by 2002:a05:6a21:6da3:b0:2d5:e559:d230 with SMTP id
 adf61e73a8af0-2e7da45e86amr23642492637.57.1759192649266; 
 Mon, 29 Sep 2025 17:37:29 -0700 (PDT)
X-Received: by 2002:a05:6a21:6da3:b0:2d5:e559:d230 with SMTP id
 adf61e73a8af0-2e7da45e86amr23642450637.57.1759192648622; 
 Mon, 29 Sep 2025 17:37:28 -0700 (PDT)
Received: from KX3WTC9T54.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b57c53bb97dsm12234825a12.9.2025.09.29.17.37.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 17:37:28 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: ajit.khaparde@broadcom.com,
	Farah Smith <farah.smith@broadcom.com>
Subject: [PATCH 39/54] net/bnxt: thor2 truflow memory manager bug
Date: Mon, 29 Sep 2025 20:35:49 -0400
Message-Id: <20250930003604.87108-40-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250930003604.87108-1-manish.kurup@broadcom.com>
References: <20250930003604.87108-1-manish.kurup@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Mailman-Approved-At: Tue, 30 Sep 2025 09:05:07 +0200
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

