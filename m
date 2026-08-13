Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDABCC5CFCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 17:23:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6A2C042E3A;
	Thu, 13 Aug 2026 19:23:07 +0200 (CEST)
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mails.dpdk.org (Postfix) with ESMTP id 9A22F42E36
 for <dev@dpdk.org>; Thu, 13 Aug 2026 19:23:06 +0200 (CEST)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8487ed7f7beso4713b3a.0
 for <dev@dpdk.org>; Thu, 13 Aug 2026 10:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786641786; x=1787246586; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=b7LWtsTC3UAmjqSEv6T+NZHX3XI2BJzpHNsmKhMUk8o=;
 b=skzP4q91/snODoW5qsY1kEWIcUA4grSvC9W+b47C7yHVeLPTVmyQ9tygQwoan3ciIR
 GFAR3CxaPU7H5Fje3e4QVvYll2iurv2iVkvGHtXgbFp3t+w7LjBHkkLA9qxuWSMLp7Q9
 sA6HHM/r76gR6mo8K0Ubi89GbssBPtMCkVU1gRMdHzgLHE6rd8bDrxrZoX5GELmnlCaM
 WxoeazNZT2lgxhwbUaX+4FsI844RE7wJdGFzgosTxJj3j9fVd/m4Jp1GVDofG++JaBmn
 xEItWnpyU5q2AfpCbdMemarxsx+z2LcMeGc/FKBg+ZLtii2fXtUHXJjh1Eie35h29AmJ
 VT/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786641786; x=1787246586;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b7LWtsTC3UAmjqSEv6T+NZHX3XI2BJzpHNsmKhMUk8o=;
 b=VbMayCc8uDjnEGo53nyfzjrJzvr9SRiPV0v+K2lNIkO99hkJx/uISU7vCQOq4L+MJ3
 rXFOT2OPgNa2w2AvEP1oorYcJqzy6MaAXz6pyM2n7ZytDUIQeJTajyLLm5FZRlucw+Fk
 GOQg/TNMbTQSWe6tVpeTIVPpo96FVideliRVtykXTF5iAxe7P+bjXmyo9yg27KIHFtrq
 c+xaVHKoa74VYfXcnOoEy0XXVfr1Ybyt1MXc7FVIty9yi+BZyvYx3G4K4UenC58LCfgB
 NC+HlnGvM0aG+dtgbV0RraLSHpLCiPGxoEYHisNasp/qCB3OXRRmrsqs4FJomEL0SSVB
 NV8A==
X-Gm-Message-State: AOJu0YwF7/oCgzAE9mW09GMR3BGvPiZfRH8xh+Ethp1XNfAX8KMzPoxn
 hHT9Col0ojocVx1ljLhoZ69JqaQX00uHbkBuRTmWg9q84+sxPWaTRpzPpeoA4tA48Xnu2nKBzQa
 IOBng2DScL/hwlg==
X-Received: from pfbhj23.prod.google.com
 ([2002:a05:6a00:8717:b0:84c:23c5:6759])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1828:b0:84e:216d:7e4e with SMTP id
 d2e1a72fcca58-84fc6e02b19mr7463780b3a.1.1786641785432; 
 Thu, 13 Aug 2026 10:23:05 -0700 (PDT)
Date: Thu, 13 Aug 2026 10:22:34 -0700
In-Reply-To: <20260813172241.964736-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260812223017.2980190-1-joshwash@google.com>
 <20260813172241.964736-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813172241.964736-10-joshwash@google.com>
Subject: [PATCH v2 09/14] net/bnx2x: use common division round up macro
From: Joshua Washington <joshwash@google.com>
To: Julien Aube <julien_dpdk@jaube.fr>
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

The RTE_DIV_ROUND_UP in rte_common.h makes DIV_ROUND_UP redundant.

Signed-off-by: Joshua Washington <joshwash@google.com>
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
2.55.0.691.gc56d675ccc-goog

