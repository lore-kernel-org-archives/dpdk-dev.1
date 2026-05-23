Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7210CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE3CE40E0B;
	Sat, 23 May 2026 21:59:07 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 6A68240A8A
 for <dev@dpdk.org>; Sat, 23 May 2026 21:59:02 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-304545e6c7fso1893505eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566341;
 x=1780171141; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=cCYMMw7vK/heFIixnsJn8p6UyE1tsFm+V3747yJkXki2hIdTSaH/IF8wpI1aQIJnFi
 l1FNwoiyZsWTseVCgmqs8w9RowAzm6mMltITX4BUyTavl1Dife/5/sJkJ8dzpJ23WAVz
 Dcee3o0ate4hWeq3BRQ073Kned1jXkLaHR4Hkd1wHlyKMdFCvxxyWutIxbsXvgzwqGqS
 +WxSQMLuPFptObgvAQr3p8+poAA492MqHsaPDf2/EBbsbcFf86e0uzwf/bAl3PAI4e1B
 fu1//YWA4yTddlZ1P/lyZtDYPu723+gH4WLYDl2/OOnU4RfQWSnlXg5aEY+oEim+vVMn
 gGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566341; x=1780171141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=qTL/meGUvORN/OTr9JKg8bG69LBF3Yw6KeN61+Lqntv1EJaUh4YkvwaJUsLGoUVXpk
 CqZAW+oaHltScV3XQMlg2hSMcjj4Ke9ixrCGMEzf1hn3/zkFxckra2Zi7pg3D0FsYgXZ
 ho1GCSSDRwhFeSYgO7hiqzSZ87hV/RCfZcJ0yNOvm5C3gAgIeh+BlCemCS0Tqzg/cars
 KVfgkFZNxhDBaLbjnnIjFkKuA1r8/iq4jZxmHRJ9TYAAJXTm/Cafn/exN+ilv/dWO06P
 dUQO28HhIxB8iQCRUDLtU+1DKnACNuGEr/CLVv3tys+wRaqFIfA+yjZb+MJfDCv+4O2m
 LTsA==
X-Gm-Message-State: AOJu0Ywn6rGBszN/psobdtXN1XFudx/D+XsmfpORXBzVl2NgVyBeJe5/
 9BAd5494GyI+D7osChBqB1yE1r/WsE5H4QYzq7sQxrDzUr/Cw11fIUfYEWt/H6ZLHZyjEx0oNvc
 yFDfA
X-Gm-Gg: Acq92OHRRMgK85hkpXotEkIafXe1tHJOBCpbRA9w1VL3bq9IBD/XX4q2kHI6GLMlFwK
 QYwE+N2dONJ4jMckHMdpXHYzIFnC2lquUvlSa2a+gs69E06+GjcD0KOE8ZPh4UrBV7E1lnyaDyb
 L+Qr0mIZ5+eL166dhOfvw0PdQwleKUTInka9ue9pYdbCeb2kYFs5GzFDOQbk4u9CbEnQ1nAgCh4
 f3+ie9Gd8kUAy/a5D64UMEtfUgxJb65b77nXhgxcEIK2Lg3C8SKge6BVdyMFLV1DFm2oFO3+7to
 vB5fpCjoC+xBMZfajAVUZtoLH/v1fhYnpF7RT39MoJDVUpnigrqRA0QGsgn/q/18U9ZWdmWpBP5
 8TfxBiMBeXEmkuG+ufCTLZuDlQxTdWjvc2N4IcXItQ7rNzw/kFur/JZyxZtRCASZ0icVRQFuB8A
 WZZAxdnrM0O89+8Mm1pRuZv/VDgO4pT3QEhSyT/stEs7wGz2ohe8jaeuZb7bHycQ9OBn5XXLbN/
 5P3CZiY/Sc=
X-Received: by 2002:a05:7300:ad02:b0:2d8:71c2:255d with SMTP id
 5a478bee46e88-30448fbdddcmr4603963eec.14.1779566341477; 
 Sat, 23 May 2026 12:59:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.59.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:59:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v3 19/27] net/bnx2x: convert from rte_atomic32 to stdatomic
Date: Sat, 23 May 2026 12:56:33 -0700
Message-ID: <20260523195839.454952-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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
index 8790c858d5..027a0a50d5 100644
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

