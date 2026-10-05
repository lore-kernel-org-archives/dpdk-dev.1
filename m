Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AEDCA5FFC
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 15:16:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDD994029D;
	Mon,  5 Oct 2026 17:16:47 +0200 (CEST)
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com
 [209.85.215.226])
 by mails.dpdk.org (Postfix) with ESMTP id 94F7E4029D
 for <dev@dpdk.org>; Mon,  5 Oct 2026 17:16:46 +0200 (CEST)
Received: by mail-pg1-f226.google.com with SMTP id
 41be03b00d2f7-cc73a80ede5so685333a12.1
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:16:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791213405; x=1791818205;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=d7SjXvMALE129Nlj16ZI+FMFbhjHoBJm9SpGta+VuEg=;
 b=l+I5Wt0FcYiORfunUTOAv/Doub5tHVS8Rjn1n3mXBsMKy0ddIZl/iwUwpMPGv+8Q9F
 QtBwOERkhRhGnPKHRMqfMkuTjIZMdZio4A47XAnG7J8KO+J3lBqm5pRM/mYDglO/v7ap
 oSrYOpR7GFhGXyOadH4THz0ieLMw2UvXTrFjFekdBcy70R/1hsviCvIA5MhqaXeEwyVp
 q4VsKyUkFER0rFjJXbRTbyft0U6iOlj6ZnJJh9Mm9tQFJH3ljcozmI6B41zOSRfSL2ZB
 och+7M+ptTQ19IiLcMUeskHpQq2w3Pw7sYspE0Nbz7N9GIffWJjftp7ni2pTk2YOyBVX
 McQw==
X-Gm-Message-State: AFuF++mr++ZhW0uIeCvqdeh3+OxHfohaeKJ9PB9MCPOZX8/jg/R2t+nL
 mtkx6tvBwmyqyyVOVtMbYemoRmbhNYeaGyP//J+jeVlEL+X2pe1BLuvBdQ77sQheW5rGoAu0ReT
 ZDQ+oZ4UiRvyDqDBtcMqQb32RKWM7tx1HpFo8kDIj3A7JhJf3U8LFk/SfUd04CBMdvPp8h8Hnx7
 ZXZ9k2VJWH49eJPy2mu1UVXh2jDdYO6vmD86+d8WuJF+w5H9Z33oGAcGimejzSbcCFEQ+T0w==
X-Gm-Gg: AYBFou2C8m11m3XdXec9/YijitJGmkRvKt3VKGFhxOBIPnuE689VVufwIazhTWSR3ml
 wy2wEXjxxHrEiCftk3FQJCIOYzoQG3f0++1hA9DeU7/55fUaEXQithPTIbX9R8wCu6EARe+RvrS
 r6mmvv25WvjmaPHo293IGGnKo+9QTWq7lOnXBtVMzhczbXtiF/iIkiSPgCacv1eBiGG/1lHWU1S
 smlhEFXH44InAEfmY8/cEMKYzUvfQ+nLh5lvlEa22oTzkZsBKas8Ga76O2NBmatAxFmIS/fbSaF
 6U5eT0k8o7ya4g+NBB5/iItmfRSucvA+o5MiltOPpiOLs3Lovx886G11SgnDvujGzn8eA3MybAp
 T7L18ZiTzKW2MVz0+nQmv1vqE9TI1aNfODYlqpWDnmLmkMJmwuyW5ZyDRzrKb9TIs5KPRWWUClg
 Joqm8LV8Wy7ncjNUioV5BnOJ+qz32lj3Z6vFeV+w==
X-Received: by 2002:a05:6a20:3944:b0:3de:188c:27b7 with SMTP id
 adf61e73a8af0-3e0d6ba9712mr7026308637.38.1791213405089; 
 Mon, 05 Oct 2026 08:16:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
 by smtp-relay.gmail.com with ESMTPS id
 d2e1a72fcca58-88b0ae3012csm1756607b3a.4.2026.10.05.08.16.44
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Oct 2026 08:16:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-917ae0d52d2so45098976d6.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 08:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1791213404; x=1791818204; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=d7SjXvMALE129Nlj16ZI+FMFbhjHoBJm9SpGta+VuEg=;
 b=D40nAvv01lq6rEqMR4TDODn7fwdFsMynwgTeqxSmxxzMTGap5WyOY5qdv7ioJLzI5u
 C5+Dm1FXMNApABuenYpatRWAAtd0YUKdXcm+5k81pDzCOQmsXT1XQJDHJQf8Br86dcpN
 it6Ejg6MSAySoE33jgGddXyGtirFi2I4D180w=
X-Received: by 2002:a05:6214:2b9d:b0:914:4aa4:4f67 with SMTP id
 6a1803df08f44-9195d0a70d5mr137970136d6.15.1791213403580; 
 Mon, 05 Oct 2026 08:16:43 -0700 (PDT)
X-Received: by 2002:a05:6214:2b9d:b0:914:4aa4:4f67 with SMTP id
 6a1803df08f44-9195d0a70d5mr137969596d6.15.1791213402848; 
 Mon, 05 Oct 2026 08:16:42 -0700 (PDT)
Received: from r740-105-132.dhcp.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-917e0b69e41sm90144256d6.25.2026.10.05.08.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:16:42 -0700 (PDT)
From: Manish Kurup <manish.kurup@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com,
	stable@dpdk.org
Subject: [PATCH] net/bnxt: fix TruFlow CPM pool-use list insertion
Date: Mon,  5 Oct 2026 10:16:39 -0500
Message-Id: <20261005151639.1705792-1-manish.kurup@broadcom.com>
X-Mailer: git-send-email 2.31.1
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

cpm_insert_pool_id() builds the initial list entry when a pool is
registered (tfc_cpm_set_cmm_inst()). It contains two bugs in the
loop/insert logic.

Bug 1: prev advances in lockstep with pool_use. prev is supposed to
track the node *before* pool_use so that the "within list" case can
insert between them. Instead, after each iteration prev == pool_use
(both point to the same node), but the more damaging case occurs when
the loop exhausts the list: pool_use advances to NULL, and then prev
is set to that NULL too, instead of pointing to the last real node.
This caused the "empty list" branch to fire even on a non-empty list,
overwriting cpm->pool_use_list and silently losing all existing nodes
(a list-head clobber on tail insert). Add an explicit "insert at tail"
case to fix this.

Bug 2: missing backward link in the "within list" case. pool_use->prev
was left pointing at prev (the old predecessor) instead of being
updated to new_pool_use, corrupting the backward linkage of the list.

Fixes: 80317ff6adfd ("net/bnxt/tf_core: support Thor2")
Cc: stable@dpdk.org

Signed-off-by: Manish Kurup <manish.kurup@broadcom.com>
---
 drivers/net/bnxt/tf_core/v3/tfc_cpm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bnxt/tf_core/v3/tfc_cpm.c b/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
index 8d95a0c205..f2c14fa8b8 100644
--- a/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
+++ b/drivers/net/bnxt/tf_core/v3/tfc_cpm.c
@@ -83,8 +83,8 @@ static int cpm_insert_pool_id(struct tfc_cpm *cpm, uint16_t pool_id)
 		if (cpm->pools[pool_use->pool_id].valid &&
 			cpm->pools[pool_use->pool_id].used_count >
 			pool->used_count) {
-			pool_use = pool_use->next;
 			prev =	pool_use;
+			pool_use = pool_use->next;
 		} else {
 			break;
 		}
@@ -101,16 +101,20 @@ static int cpm_insert_pool_id(struct tfc_cpm *cpm, uint16_t pool_id)
 	new_pool_use->next = NULL;
 	pool->pool_use = new_pool_use;
 
-	if (pool_use == NULL) { /* Empty list */
+	if (pool_use == NULL && prev == NULL) { /* Empty list */
 		cpm->pool_use_list = new_pool_use;
-	} else if (prev == NULL) { /* Start of list */
+	} else if (pool_use == NULL) { /* Insert at tail */
+		prev->next = new_pool_use;
+		new_pool_use->prev = prev;
+	} else if (prev == NULL) { /* Insert at head */
 		cpm->pool_use_list = new_pool_use;
 		new_pool_use->next = pool_use;
 		pool_use->prev = new_pool_use;
-	} else { /* Within list */
+	} else { /* Insert in middle */
 		prev->next = new_pool_use;
 		new_pool_use->next = pool_use;
 		new_pool_use->prev = prev;
+		pool_use->prev = new_pool_use;
 	}
 
 	cpm->available_pool_id = cpm->pool_use_list->pool_id;
-- 
2.31.1

