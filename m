Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934BFC98302
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Sep 2026 01:08:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB51642ED8;
	Wed, 23 Sep 2026 03:08:03 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id D258642EC7
 for <dev@dpdk.org>; Wed, 23 Sep 2026 03:08:00 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d6fb956002so4055475ad.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 18:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790125680; x=1790730480; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ieZv8wDgTTo2JMR/CcDK5yvS1gM09CIXHymYifQ+NGw=;
 b=RxUYR+C2diQBMotdHXuWyVperMwTIP1Zs0zyAf1/1H9uKkcwoNlc5Sbjp4y26qJleK
 3QeIUwHqe6fzBFI09Y5q3XxwPCE3G2jVi526h+cRugV9WpKXK9ORYRtAHLezMtlAxZCO
 lbcaBMMxEQeuU0cByOHrUlWFzCpPVEVXai46USPOEV1sEqMfEvmEnG2Sjg4qOWRE8H15
 VbDZTnlT3i5eARw1oD8vH/FLBBqK4keR/Ayaj0CA/fJD4pBNG7sqQ3fAru5k4iBO3Wtg
 5AmmwMo5TFKy+seobvGG/tyml12MmPzCK/pTg8V7cmnwsQPGtMpxWACP8KObqiMq6z2d
 hSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790125680; x=1790730480;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ieZv8wDgTTo2JMR/CcDK5yvS1gM09CIXHymYifQ+NGw=;
 b=tF74+z2k+dbnwOXbP9IchHL3nVem6jgU2oyenZQiZxCmHtFRPt0nbqaWDFpfs9aKVG
 4mvtW9H+Zon8rkrNxepSDIrW1EjgZpour8evf3o7tDuZlE91BEVKuwPoOKgnScV6yB8b
 YREjRleGK0Id78aoku5A16N6jxHlcuZautWGxMlz0/w2EX7eYl6gZEUpPRZdxTWFgKh+
 9s3Pmrq/vG5RFFb3J5Ds30QfFMZjWT+6FPjGkzBrFLZrQ54xoEW5+PCwMjLq/bqIJBCB
 6gUR33ILR3KJW4F2k9o3Poe2nyhzhjJOoZCKh5eBQW5UgY0DyKmqUtjjwNDnJ4GqGtQO
 5F8g==
X-Gm-Message-State: AFuF++lJ3puHoP/b1QlT3i2i0402EdInbQTL0lHXikxfqIgDfTyLhmYX
 wTUZovCcLJqnOKp9oY0adn+XXWOGeg9VjZjgnbofRpjVjYjFaiwbGFy3E8YAmF6cc3E1RbCxNB1
 dElPeByTaPUjtVQ==
X-Received: from plbe10.prod.google.com ([2002:a17:902:f10a:b0:2df:578a:41d7])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:db08:b0:2dd:7a0d:e51d with SMTP id
 d9443c01a7336-2df69d34bf7mr8824285ad.16.1790125679711; 
 Tue, 22 Sep 2026 18:07:59 -0700 (PDT)
Date: Tue, 22 Sep 2026 18:07:32 -0700
In-Reply-To: <20260923010742.2468145-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260923010742.2468145-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260923010742.2468145-10-joshwash@google.com>
Subject: [PATCH v3 09/16] net/bnx2x: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Julien Aube <julien_dpdk@jaube.fr>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnx2x/bnx2x.c |  4 ++--
 drivers/net/bnx2x/bnx2x.h | 11 ++++-------
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 8790c858d5..ce9dbdf7c6 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -2334,8 +2334,8 @@ static void bnx2x_ilt_set_info(struct bnx2x_softc *sc)
 		ilt_client->start = line;
 
 		/* 4 bytes for each cid */
-		line += DIV_ROUND_UP(sc->qm_cid_count * QM_QUEUES_PER_FUNC * 4,
-				     QM_ILT_PAGE_SZ);
+		line += RTE_DIV_ROUND_UP(sc->qm_cid_count * QM_QUEUES_PER_FUNC * 4,
+					 QM_ILT_PAGE_SZ);
 
 		ilt_client->end = (line - 1);
 	}
diff --git a/drivers/net/bnx2x/bnx2x.h b/drivers/net/bnx2x/bnx2x.h
index 35206b4758..0cdd118ad5 100644
--- a/drivers/net/bnx2x/bnx2x.h
+++ b/drivers/net/bnx2x/bnx2x.h
@@ -37,9 +37,6 @@
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) RTE_DIM(arr)
 #endif
-#ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-#endif
 #ifndef roundup
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #endif
@@ -393,7 +390,7 @@ union cdu_context {
 #define CNIC_ISCSI_CID_MAX 256
 #define CNIC_FCOE_CID_MAX  2048
 #define CNIC_CID_MAX       (CNIC_ISCSI_CID_MAX + CNIC_FCOE_CID_MAX)
-#define CNIC_ILT_LINES     DIV_ROUND_UP(CNIC_CID_MAX, ILT_PAGE_CIDS)
+#define CNIC_ILT_LINES     RTE_DIV_ROUND_UP(CNIC_CID_MAX, ILT_PAGE_CIDS)
 
 #define QM_ILT_PAGE_SZ_HW  0
 #define QM_ILT_PAGE_SZ     (4096 << QM_ILT_PAGE_SZ_HW) /* 4K */
@@ -405,7 +402,7 @@ union cdu_context {
 /*#define TM_CONN_NUM        (CNIC_STARTING_CID+CNIC_ISCSI_CXT_MAX) */
 #define TM_CONN_NUM        1024
 #define TM_ILT_SZ          (8 * TM_CONN_NUM)
-#define TM_ILT_LINES       DIV_ROUND_UP(TM_ILT_SZ, TM_ILT_PAGE_SZ)
+#define TM_ILT_LINES       RTE_DIV_ROUND_UP(TM_ILT_SZ, TM_ILT_PAGE_SZ)
 
 /* SRC (Searcher) host DB constants */
 #define SRC_ILT_PAGE_SZ_HW 0
@@ -414,7 +411,7 @@ union cdu_context {
 #define SRC_CONN_NUM       (1 << SRC_HASH_BITS) /* 1024 */
 #define SRC_ILT_SZ         (sizeof(struct src_ent) * SRC_CONN_NUM)
 #define SRC_T2_SZ          SRC_ILT_SZ
-#define SRC_ILT_LINES      DIV_ROUND_UP(SRC_ILT_SZ, SRC_ILT_PAGE_SZ)
+#define SRC_ILT_LINES      RTE_DIV_ROUND_UP(SRC_ILT_SZ, SRC_ILT_PAGE_SZ)
 
 struct hw_context {
     struct bnx2x_dma    vcxt_dma;
@@ -1258,7 +1255,7 @@ struct bnx2x_softc {
 #define BNX2X_L2_CID_COUNT(sc)                                             \
 	(BNX2X_NUM_ETH_QUEUES(sc) * ECORE_MULTI_TX_COS + 2 * CNIC_SUPPORT(sc))
 #define L2_ILT_LINES(sc)                                \
-	(DIV_ROUND_UP(BNX2X_L2_CID_COUNT(sc), ILT_PAGE_CIDS))
+	(RTE_DIV_ROUND_UP(BNX2X_L2_CID_COUNT(sc), ILT_PAGE_CIDS))
 
 	int qm_cid_count;
 
-- 
2.55.0.1082.g2b9226bbc0-goog

