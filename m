Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C725CA5FFD
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 02:31:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6CA240E7C;
	Tue,  6 Oct 2026 04:31:14 +0200 (CEST)
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mails.dpdk.org (Postfix) with ESMTP id B1B3740ED0
 for <dev@dpdk.org>; Tue,  6 Oct 2026 04:31:13 +0200 (CEST)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2db3d832827so25893195ad.2
 for <dev@dpdk.org>; Mon, 05 Oct 2026 19:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791253873; x=1791858673; darn=dpdk.org;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6r0P5Ba7gh0fUNBL/gKynsnLc76KBRhGmivKv+7vrnE=;
 b=K+FYSXx+loslMeG26Y0EaLsGAzbUi9cDcynOQrclMFG6LUZFLV64KEfEgLQeDaAZ09
 mdJWAwwBK2MdYe2tjMRQDdPG+ZLSwhcg0WvKi3ardkDOgHywV1Brhvcoph2v9knvBztV
 HsAo8g2zOKSe1yA8GcAmBsLomS93lv4r+XrV8wzsW73DOguJjxry+IknjsO+odZxkhmt
 FdZ0F8KvvnO+B5S4a5ICqcILSh3kw7N1y4fyu+FrIIcMY06zMWykoftx8AMCj8Fbw+ao
 CqKi+EeNpZeM8juM9/tDzSC9aEIIzfP4WLwAWiUvjwM6Nwe48c/tMFiy2U/3LfjtGdR0
 jXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791253873; x=1791858673;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6r0P5Ba7gh0fUNBL/gKynsnLc76KBRhGmivKv+7vrnE=;
 b=R6woEIYEMH7WoNitEw3fWGU4ej5kKDGDNEF3OTho6eBmkbebH6bllJgNSfw4ntW1O3
 Aqj2Dh7oljxRkazX/UOyjc9M0CzqO7gUkDVywDPS7z/bvEeknZ+unckzEYNKaIZ/6gQt
 6TH86eEDd9srv2clZ7HiF8MaVakxCJRSIrpVO0W4r3y4Wr2OGvapQ7f8h+E5J0cJCOTz
 MkFqzw6PUReD5dVg7+S2f5QE+q0pV1o1cFBzg3bPrtX8+RqQ732XDqFLIK3/DNaF89ys
 SxC1EuP6bGoj5BHUxsSjH578beJPmTIBShOPd6s7jifDY2VVdowZyRcLT4a3sd/qRApx
 sfGw==
X-Gm-Message-State: AFq9FYIxSHdhBsalfNY+v/BETtJFxp83ClvKpbpW6J/pj2ScJImCG7QS
 0TJY4b6BuxVwc0MeaXx5uozY7kICGLG700o6Bf+xsFrCqwS96fz5ruj1zFb/yS9dp8lHRVBeRJX
 AVNakilFGqgr48g==
X-Received: from plble12.prod.google.com ([2002:a17:902:fb0c:b0:2df:6eb9:45a2])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:b90:b0:2d9:2fc9:5706 with SMTP id
 d9443c01a7336-2e5dcd0fb55mr902515ad.2.1791253872623; 
 Mon, 05 Oct 2026 19:31:12 -0700 (PDT)
Date: Mon,  5 Oct 2026 19:30:45 -0700
In-Reply-To: <20261006023053.2572501-1-joshwash@google.com>
Mime-Version: 1.0
References: <20260923010742.2468145-1-joshwash@google.com>
 <20261006023053.2572501-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20261006023053.2572501-10-joshwash@google.com>
Subject: [PATCH v4 09/15] net/bnx2x: use common division round up macro
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
Changes in v4:
  - Add rte_common.h include.
---
 drivers/net/bnx2x/bnx2x.c |  4 ++--
 drivers/net/bnx2x/bnx2x.h | 12 +++++-------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 13b451bae9..2924fed66b 100644
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
index c5de4b71aa..fe375219dd 100644
--- a/drivers/net/bnx2x/bnx2x.h
+++ b/drivers/net/bnx2x/bnx2x.h
@@ -18,6 +18,7 @@
 #include <rte_spinlock.h>
 #include <bus_pci_driver.h>
 #include <rte_io.h>
+#include <rte_common.h>
 
 #include "bnx2x_osal.h"
 #include "bnx2x_ethdev.h"
@@ -37,9 +38,6 @@
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(arr) RTE_DIM(arr)
 #endif
-#ifndef DIV_ROUND_UP
-#define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
-#endif
 #ifndef roundup
 #define roundup(x, y) ((((x) + ((y) - 1)) / (y)) * (y))
 #endif
@@ -393,7 +391,7 @@ union cdu_context {
 #define CNIC_ISCSI_CID_MAX 256
 #define CNIC_FCOE_CID_MAX  2048
 #define CNIC_CID_MAX       (CNIC_ISCSI_CID_MAX + CNIC_FCOE_CID_MAX)
-#define CNIC_ILT_LINES     DIV_ROUND_UP(CNIC_CID_MAX, ILT_PAGE_CIDS)
+#define CNIC_ILT_LINES     RTE_DIV_ROUND_UP(CNIC_CID_MAX, ILT_PAGE_CIDS)
 
 #define QM_ILT_PAGE_SZ_HW  0
 #define QM_ILT_PAGE_SZ     (4096 << QM_ILT_PAGE_SZ_HW) /* 4K */
@@ -405,7 +403,7 @@ union cdu_context {
 /*#define TM_CONN_NUM        (CNIC_STARTING_CID+CNIC_ISCSI_CXT_MAX) */
 #define TM_CONN_NUM        1024
 #define TM_ILT_SZ          (8 * TM_CONN_NUM)
-#define TM_ILT_LINES       DIV_ROUND_UP(TM_ILT_SZ, TM_ILT_PAGE_SZ)
+#define TM_ILT_LINES       RTE_DIV_ROUND_UP(TM_ILT_SZ, TM_ILT_PAGE_SZ)
 
 /* SRC (Searcher) host DB constants */
 #define SRC_ILT_PAGE_SZ_HW 0
@@ -414,7 +412,7 @@ union cdu_context {
 #define SRC_CONN_NUM       (1 << SRC_HASH_BITS) /* 1024 */
 #define SRC_ILT_SZ         (sizeof(struct src_ent) * SRC_CONN_NUM)
 #define SRC_T2_SZ          SRC_ILT_SZ
-#define SRC_ILT_LINES      DIV_ROUND_UP(SRC_ILT_SZ, SRC_ILT_PAGE_SZ)
+#define SRC_ILT_LINES      RTE_DIV_ROUND_UP(SRC_ILT_SZ, SRC_ILT_PAGE_SZ)
 
 struct hw_context {
     struct bnx2x_dma    vcxt_dma;
@@ -1258,7 +1256,7 @@ struct bnx2x_softc {
 #define BNX2X_L2_CID_COUNT(sc)                                             \
 	(BNX2X_NUM_ETH_QUEUES(sc) * ECORE_MULTI_TX_COS + 2 * CNIC_SUPPORT(sc))
 #define L2_ILT_LINES(sc)                                \
-	(DIV_ROUND_UP(BNX2X_L2_CID_COUNT(sc), ILT_PAGE_CIDS))
+	(RTE_DIV_ROUND_UP(BNX2X_L2_CID_COUNT(sc), ILT_PAGE_CIDS))
 
 	int qm_cid_count;
 
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

