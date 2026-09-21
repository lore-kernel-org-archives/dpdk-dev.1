Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F83C982DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 03:03:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6097A410ED;
	Mon, 21 Sep 2026 05:03:42 +0200 (CEST)
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com
 [209.85.214.228])
 by mails.dpdk.org (Postfix) with ESMTP id 8652040EE1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 05:03:39 +0200 (CEST)
Received: by mail-pl1-f228.google.com with SMTP id
 d9443c01a7336-2dd68a16955so32902535ad.0
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789959819; x=1790564619;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=XUjyjfqKhU3IZol4rcvGDaXmLeIFjeDxXCQXsRtzmTk=;
 b=wsHhX+qp/XnM3hpwyzeNGHKYvx2/E9zI2mpNPDZJKMIYuHkujFchz1kM+3xvto/zEc
 CIsTKqE5gE66MiCTByLOsOi18pRF1Tct0Ul78oszVGo4syspeckC3fC+B+i1OB39k1BR
 v4t7zEnhAWElrW3yo/MkiNvM80Z4lngFuj44Udo8wiUBDZ92U/aPoY3SYKi+oSvN6KNU
 73oWhX8J7iZK/8XKgES6I73IXcIC656QrHs1rrWuxvueSMiCS6w2b2njeJWaG4gutysC
 26qV7MluFPVV/7llBTofx0C8TlRRRAwF+grZYvKGGirehDdJ4PcACM3wo6nbNF8wPcPP
 ZMlw==
X-Gm-Message-State: AFuF++nWnvPD4mC8MrBEdKswJRZ17acmH+8xRp079CU8DlyWE/BIuwFD
 coneBB2dLSWr8jKQomQcTmoQjeELlxa/rzEzleQwoCbbOn2+6KlAs5z0Ao6e3ma+tgI3C+RP1FM
 iHCfF95Q0BzCRDGNJQRv0w87OJoUcUbBUi8lvIFq7Gf9r5nEvbGfCC2rlc39a9VDMc3xQaK9BNP
 C0Me10rTXyrY2SkWZ5LsdObvEJ31yRA6E4DdZfjyOEwhD6WjLIRa5OXp45Cq1anW4KjuWhAdqbY
 1mOUBGYIM73
X-Gm-Gg: AYBFou0twR2/SGjLVvLEF0tTzAXHsWiWf6ugNCkWsmjhAwWcN7v/C1/FZ+GqDq25Cjt
 JPU8CL/iM0fNHj/4VAtxoXPnzQ7KyvJEZ+7OGx4j4e8/v0rNCKW1qQFdS/IeAIy7JgCOvWnIWHG
 26aaAMGgQPErsiiWKaIIboOy+T+4sloeqtmzpejKydFYlFEgJuBRyep9pPwwJKMrR9UgrPGBOyM
 vPlQYXJwFj6gT063eajQonrUqW9bPEXFvTPQqAp+OU9+QnlbL0ue6UI+zDP7JQZK6vqXg5779us
 1ZZp9yQXZUfJxlui4Qta0kIEPgCg8o8NkJ33yATuCfIpJn4i4b0mMh2ss5gnq8+1W4hG+ML1PoG
 WyssDIuGBKAu32aXcOfJ3iN2m5/vHD6OR74l0PMVd/6nC9NubrErQqU/4gudE3x0c73u4Qn50hZ
 dY6KqN9srUc6epu8AkTBeRAkDxIbZwJ7JIB1QeLPptTSKHjvQIEw==
X-Received: by 2002:a17:90b:2890:b0:39e:3dad:684f with SMTP id
 98e67ed59e1d1-39e5546c89dmr9759376a91.4.1789959818721; 
 Sun, 20 Sep 2026 20:03:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3a023bdd4d3sm3916107a91.1.2026.09.20.20.03.38
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 20 Sep 2026 20:03:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb48f41343aso3196269a12.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1789959817; x=1790564617; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XUjyjfqKhU3IZol4rcvGDaXmLeIFjeDxXCQXsRtzmTk=;
 b=Fhx8HAU/3OMfsAuB4KN7rjyyNkVm2O9hvd+cXJs+B0y9hRGarasY5LQghPsndyw+3+
 MDee+xIodUKD2aEnF8KVnjXdZO+F6tkcdIEXN3NB8JUexwO2xg1Sjjv1jlyTbyh1AFit
 yNGKQ32pRMtSOxjbtsvuAY3bzijPDf9DAKleA=
X-Received: by 2002:a17:90b:37cf:b0:3a0:25f0:d89d with SMTP id
 98e67ed59e1d1-3a025f0ddd3mr5052648a91.52.1789959816873; 
 Sun, 20 Sep 2026 20:03:36 -0700 (PDT)
X-Received: by 2002:a17:90b:37cf:b0:3a0:25f0:d89d with SMTP id
 98e67ed59e1d1-3a025f0ddd3mr5052622a91.52.1789959816180; 
 Sun, 20 Sep 2026 20:03:36 -0700 (PDT)
Received: from nic1-cos.dhcp.broadcom.net ([192.19.220.253])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c32f17dbdsm16245314eec.1.2026.09.20.20.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 20:03:35 -0700 (PDT)
From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
X-Google-Original-From: Mohammad Shuab Siddique
 <Mohammad-Shuab.Siddique@broadcom.com>
To: dev@dpdk.org
Cc: kishore.padmanabha@broadcom.com, stable@dpdk.org,
 Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Subject: [PATCH] net/bnxt: fix bounds in RSS queue match and ctx initializer
Date: Sun, 20 Sep 2026 21:06:40 -0600
Message-ID: <20260921030640.1034836-1-Mohammad-Shuab.Siddique@broadcom.com>
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

From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>

Two independent out-of-bounds issues:

- match_vnic_rss_cfg() indexed bp->rx_queues[] with firmware/
  application-supplied RSS queue IDs without validating them against
  bp->rx_nr_rings first, and dereferenced the resulting (possibly
  NULL) queue pointer unconditionally.

- bnxt_init_ctx_initializer() computed ctxm->init_offset from a
  firmware-supplied byte offset without checking it against the
  context entry's own size, allowing an out-of-range init offset to
  be used later when initializing backing-store entries.

Fixes: adc0f81c6552 ("net/bnxt: support RSS action")
Fixes: fe2f715ca580 ("net/bnxt: support backing store v2")
Cc: stable@dpdk.org

Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
---
 drivers/net/bnxt/bnxt_flow.c | 13 +++++++++++++
 drivers/net/bnxt/bnxt_hwrm.c | 14 +++++++++++---
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bnxt/bnxt_flow.c b/drivers/net/bnxt/bnxt_flow.c
index a2e590540b..12d21c4853 100644
--- a/drivers/net/bnxt/bnxt_flow.c
+++ b/drivers/net/bnxt/bnxt_flow.c
@@ -968,10 +968,23 @@ static int match_vnic_rss_cfg(struct bnxt *bp,
 {
 	unsigned int match = 0, i;
 
+	if (rss->queue_num > bp->rx_nr_rings)
+		return -EINVAL;
+
 	if (vnic->rx_queue_cnt != rss->queue_num)
 		return -EINVAL;
 
 	for (i = 0; i < rss->queue_num; i++) {
+		if (rss->queue[i] >= bp->rx_nr_rings) {
+			PMD_DRV_LOG_LINE(ERR, "Queue ID %u for RSS exceeds ring count %u",
+					 rss->queue[i], bp->rx_nr_rings);
+			return -EINVAL;
+		}
+		if (!bp->rx_queues[rss->queue[i]]) {
+			PMD_DRV_LOG_LINE(ERR, "Queue ID %u for RSS is not configured",
+					 rss->queue[i]);
+			return -EINVAL;
+		}
 		if (!bp->rx_queues[rss->queue[i]]->vnic->rx_queue_cnt &&
 		    !bp->rx_queues[rss->queue[i]]->rx_started)
 			return -EINVAL;
diff --git a/drivers/net/bnxt/bnxt_hwrm.c b/drivers/net/bnxt/bnxt_hwrm.c
index 1615b36aae..8d2253160f 100644
--- a/drivers/net/bnxt/bnxt_hwrm.c
+++ b/drivers/net/bnxt/bnxt_hwrm.c
@@ -6770,10 +6770,18 @@ static void bnxt_init_ctx_initializer(struct bnxt_ctx_mem *ctxm,
 {
 	ctxm->init_value = init_val;
 	ctxm->init_offset = BNXT_CTX_INIT_INVALID_OFFSET;
-	if (init_mask_set)
-		ctxm->init_offset = init_offset * 4;
-	else
+	if (init_mask_set) {
+		ctxm->init_offset = (uint16_t)(init_offset * 4);
+		if (ctxm->init_offset >= ctxm->entry_size) {
+			PMD_DRV_LOG_LINE(WARNING,
+					 "ctx type 0x%x: init_offset %u >= entry_size %u, disabling init",
+					 ctxm->type, ctxm->init_offset, ctxm->entry_size);
+			ctxm->init_value = 0;
+			ctxm->init_offset = BNXT_CTX_INIT_INVALID_OFFSET;
+		}
+	} else {
 		ctxm->init_value = 0;
+	}
 }
 
 static int bnxt_alloc_all_ctx_pg_info(struct bnxt *bp)
-- 
2.47.3

