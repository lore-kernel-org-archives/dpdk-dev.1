Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5392DC9832A
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:06:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5884A42E86;
	Tue, 29 Sep 2026 16:04:42 +0200 (CEST)
Received: from mail-pz2-f38.google.com (mail-pz2-f38.google.com
 [74.125.228.38]) by mails.dpdk.org (Postfix) with ESMTP id AFEE742E71
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:30 +0200 (CEST)
Received: by mail-pz2-f38.google.com with SMTP id
 d2e1a72fcca58-8814e797a5bso1588761b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690670;
 x=1791295470; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Lc4v3wIkMf9JnA4/yu7E/MVx7SE2rCtLUJBy9hbm0CY=;
 b=qx9IC4CBK+xeV1AOF49xP/wGVTuNmvbIyKmuOw6NPu/kQVzXoDO/AEDZzj5ex5D/fc
 Id3idEijlliuRBmXx7MLoZmK/UoB0+A6R/j5NFoSEFtFRDo1NFQtAnMq47wkS/8FAP4W
 pyQ1dl9mv8jxOzIWmbxiTry5vcKDqUvMJDQ5Z3Yjgz61cMAhXAo+3FscaXWUcbmonbWM
 3dN2N2jYeVobTqk1bGMhBm6NAGO9VF1yKcayvCBDB2LTxnjm2KneIZq++cvUEZ0VE3el
 B0uzCB+EU1xeOaEhTJ7R2djwVxdrH6ycUx1wpbAG2U0TuLbr+xiRayKeLramepaPfXNt
 OgbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690670; x=1791295470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Lc4v3wIkMf9JnA4/yu7E/MVx7SE2rCtLUJBy9hbm0CY=;
 b=ZmvHDk0u3XIPIWP/fcTT5IEZPfB686RSC3t/rQsxTH+mgfvqjXf4XXl3KIO61IDIvM
 XytqLLEK3qvtSGCqjaCaKQobaeBtPOUOOGhJbrBI2cYkcp/il6pFnH5CbfCt6epWNIeG
 zaIYAGuD74UzWexeiAmVTW19acZxCvz6TrkEz49jzuBHqJUmyRbRyyyvvUWYvp/ZggR4
 IDVg5AusR6bvFloJE/UvqD1wBOXoPKqBeuD54AFPGpdtoVZAPlnpE9nFBaGHO2/HpHfg
 A5bnG5E6r6TVYv1O6YxpTGl8VFRZY6zy/anp7btBoRMGkAlmjk6vtFpMmE0e3oYxyTXd
 uhSw==
X-Gm-Message-State: AFuF++mfI7770Bu01jf5HwCHZzdH6hIjhOjFcLQlrv/yy8GP3DeIw3dN
 0rNB5P0cvQoaFPK3hBRWzR9LrgvhIPz14MkL9X2WZ4qMH9aCF9HiqCmpVR5wc5BNEvJin3LI8XQ
 h0d/B48U=
X-Gm-Gg: AYBFou3ht6ZhSs9WG3oh4K/+H7XbpbS9kt2hA0qdR+a0m0Rvr1zEb/qLj7+HsEEhwG5
 yemoYqDwyCK1Kpdwsiki69YaAEhg8ODjRsWbEnpC/x80Ijb+W0oX39QMrvOnl8wr0W0Hec0xt3p
 eBk08aqzzRzKLbq5d4VRv7jRdcZi7RJVXIzOgJ2+bCPdO+qDhjdenzVpqwZV3hhCfGvwKPFnO03
 xp4o6tDrWIQRSLtwRwcoY+wbtUInP0kwj/izCq/U18zc4UL8m//0qyKtcSy3NV54wsompqNDx3G
 I/ZQMrykwwO/7xuroLqUk1fJG1vyMK0euIn9K1kzg4upETmkcRLbpeNQSef7tsORBb8FLu8pP2O
 2Bq+HJT5S+8EUaULc7l7Ikl6CidmD6/cOGdP4hKADoJWffWnABoTaLEePshD92+mNglbYTK/X7h
 2z6I9JDURFOGc4tYQgCj7AQW01/jWw0ajfML/uEZuYXFYlSnPh/ajUuYCE2mdhUncbbrR63Ilc1
 I7BLUWjGzuiOEhNo0XZ8Qild3lpdzSub0/kv6g=
X-Received: by 2002:a05:6a00:4c96:b0:886:73c9:89d7 with SMTP id
 d2e1a72fcca58-88673c98f3dmr238119b3a.11.1790690669700; 
 Tue, 29 Sep 2026 07:04:29 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:28 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v9 17/25] net/bnx2x: convert from rte_atomic32 to stdatomic
Date: Tue, 29 Sep 2026 07:02:03 -0700
Message-ID: <20260929140409.234453-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929140409.234453-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260929140409.234453-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Replace the legacy rte_atomic32_* API on sc->scan_fp with the
equivalent rte_atomic_*_explicit C11 helpers, ahead of the
deprecation of rte_atomicNN_t and its associated wrappers.

All accesses use rte_memory_order_seq_cst, matching the semantics
of the legacy API. No functional change.

The scan_fp field is a notification flag between the slow-path
command poster (bnx2x_sp_post) and the fastpath task that reaps
ramrod completions (bnx2x_handle_fp_tq), also cleared from
ecore_state_wait on success, panic, and timeout.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/bnx2x/bnx2x.c    | 6 +++---
 drivers/net/bnx2x/bnx2x.h    | 2 +-
 drivers/net/bnx2x/ecore_sp.c | 6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/bnx2x/bnx2x.c b/drivers/net/bnx2x/bnx2x.c
index 1a3956b224..13b451bae9 100644
--- a/drivers/net/bnx2x/bnx2x.c
+++ b/drivers/net/bnx2x/bnx2x.c
@@ -1098,7 +1098,7 @@ bnx2x_sp_post(struct bnx2x_softc *sc, int command, int cid, uint32_t data_hi,
 	 * Ask bnx2x_intr_intr() to process RAMROD
 	 * completion whenever it gets scheduled.
 	 */
-	rte_atomic32_set(&sc->scan_fp, 1);
+	rte_atomic_store_explicit(&sc->scan_fp, 1, rte_memory_order_seq_cst);
 	bnx2x_sp_prod_update(sc);
 
 	return 0;
@@ -4575,7 +4575,7 @@ static void bnx2x_handle_fp_tq(struct bnx2x_fastpath *fp)
 	/* update the fastpath index */
 	bnx2x_update_fp_sb_idx(fp);
 
-	if (rte_atomic32_read(&sc->scan_fp) == 1) {
+	if (rte_atomic_load_explicit(&sc->scan_fp, rte_memory_order_seq_cst)) {
 		if (bnx2x_has_rx_work(fp)) {
 			more_rx = bnx2x_rxeof(sc, fp);
 		}
@@ -4586,7 +4586,7 @@ static void bnx2x_handle_fp_tq(struct bnx2x_fastpath *fp)
 			return;
 		}
 		/* We have completed slow path completion, clear the flag */
-		rte_atomic32_set(&sc->scan_fp, 0);
+		rte_atomic_store_explicit(&sc->scan_fp, 0, rte_memory_order_seq_cst);
 	}
 
 	bnx2x_ack_sb(sc, fp->igu_sb_id, USTORM_ID,
diff --git a/drivers/net/bnx2x/bnx2x.h b/drivers/net/bnx2x/bnx2x.h
index 35206b4758..c5de4b71aa 100644
--- a/drivers/net/bnx2x/bnx2x.h
+++ b/drivers/net/bnx2x/bnx2x.h
@@ -1043,7 +1043,7 @@ struct bnx2x_softc {
 #define PERIODIC_STOP 0
 #define PERIODIC_GO   1
 	volatile unsigned long periodic_flags;
-	rte_atomic32_t	scan_fp;
+	RTE_ATOMIC(uint32_t) scan_fp;
 	struct bnx2x_fastpath fp[MAX_RSS_CHAINS];
 	struct bnx2x_sp_objs  sp_objs[MAX_RSS_CHAINS];
 
diff --git a/drivers/net/bnx2x/ecore_sp.c b/drivers/net/bnx2x/ecore_sp.c
index c6c3857778..33a40dea6e 100644
--- a/drivers/net/bnx2x/ecore_sp.c
+++ b/drivers/net/bnx2x/ecore_sp.c
@@ -299,21 +299,21 @@ static int ecore_state_wait(struct bnx2x_softc *sc, int state,
 #ifdef ECORE_STOP_ON_ERROR
 			ECORE_MSG(sc, "exit  (cnt %d)", 5000 - cnt);
 #endif
-			rte_atomic32_set(&sc->scan_fp, 0);
+			rte_atomic_store_explicit(&sc->scan_fp, 0, rte_memory_order_seq_cst);
 			return ECORE_SUCCESS;
 		}
 
 		ECORE_WAIT(sc, delay_us);
 
 		if (sc->panic) {
-			rte_atomic32_set(&sc->scan_fp, 0);
+			rte_atomic_store_explicit(&sc->scan_fp, 0, rte_memory_order_seq_cst);
 			return ECORE_IO;
 		}
 	}
 
 	/* timeout! */
 	PMD_DRV_LOG(ERR, sc, "timeout waiting for state %d", state);
-	rte_atomic32_set(&sc->scan_fp, 0);
+	rte_atomic_store_explicit(&sc->scan_fp, 0, rte_memory_order_seq_cst);
 #ifdef ECORE_STOP_ON_ERROR
 	ecore_panic();
 #endif
-- 
2.53.0

