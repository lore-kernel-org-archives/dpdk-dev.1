Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED87BCD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6117C40B9D;
	Wed, 27 May 2026 01:26:14 +0200 (CEST)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 100B440A73
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:07 +0200 (CEST)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1329fc4bf77so11025561c88.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837966;
 x=1780442766; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=LofFIB2wweVJNfuQsal4TkqF4rI0o1sdUY4SpUZtNkytYRlMlEwrim4AbTwC5U9v2a
 PYWJ77dP61b4DcO0Itdoqwy0zOa46yPggj8oFf4/nI4l72eHfwUYBw+GjIWnOW/suuvx
 JC0kDqicB7BB/EWMIHgcsptiCgrXd14gxhdEjf9PofgWKwxtImtCPCEvJxLZjHxQeT+v
 f9TSFL28F9wgTHI7q+7+buZ4gKrrNaeaRiABs23kCrbBV9fM7sVEoUGhPw8f23Nx9Ewj
 nINdjLljBApYu0S5NOoClU0CGv1R9QUymSFyZ21i6KvbYicL4xGMMaum0JF3OtvTnFRV
 qo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837966; x=1780442766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=Tbucr4uHAHEeah9oxydhfUtI9Cb2e9PrqD3RjgOlo6MSQiBvRJpluwRymIFpRy2Btg
 qzMhslU8+2ZWeeQEy8SwKUgzgOfhHqjZlw+XksjeY4g6JLWtbkE3kipVLYHv1JpOvOd6
 QD8L4qCk4H4o1iEMsqcVIzhmh6b6+q4A2YGD917E/ncqcUlU2aJHuSiNF8fqClXnyj0P
 WorT1UFB+SrSGJkeOy+402uZ6wSJLR+g8b7q6DIfHj0lF+htHbCjfM/K97DARDC6FDTj
 XREGKgyCX0OBxokk0yV6wvBZ30+AsH70vCrK2JFDa/aesUNSbxcRfkVtflNc2mpGxCVs
 Vfaw==
X-Gm-Message-State: AOJu0YzI6XCU2VXsNTnIuiwnOyR+SLbUeLUn4AKWtEs2DECFgnvym8k8
 qTSrXHxwog/5y4cO2leKTLMbbZO9TkPFHMKop0T13CKzAMATyRsje6ornF0uiXLNASPvrwHWm4Z
 D5P5i
X-Gm-Gg: Acq92OHiYchXj8EpDzw+RGhL3vukjGjD3hH4VzSOXuWx3ZQcxlBUU8ewH35dkSGVl2i
 R0KN/EGiaycgfIPB89qdL7ThIsOLH/EgAmhq1e0/tlUwnMuFSMqaGRfQyZDTcCWc49mzOtyv0oE
 bkCk2yJk5ybdUUNVCasbU0nLl9DelTSoidttrNh2f1YmYYphSRm6z5YqfggZqARc12+/3iEXQD3
 9Pw/xlIR6VJsRrqwkDpEE6CGOJnacoYvVPMNAn9kq7kZkXERvfDXmmoQ8bS7bW+JXdP64jyO9vc
 NCKd+naOgrnJM/W4rk4LT/ElhIv05e3a7f14pXc6ZBZJ4zPOGm4Nb8iWBeA7MyR7SkYH0uPO1j2
 gIShFY5ivYPtPanAnUVeYFQthrf9x0S5mKmI/OB3iQmQL/Gjo4FIvCGJdg6Q5Zg9LJZ8kgIpEC+
 M2IIx2A/OK1olC1vhiekPY1I0IjXAsl3NPYHhkNw97luMmm+SXvdxdPBrvroD0lFFH47y/wjsO
X-Received: by 2002:a05:693c:8303:b0:304:8364:e95f with SMTP id
 5a478bee46e88-3048364f868mr2942004eec.27.1779837966112; 
 Tue, 26 May 2026 16:26:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v4 19/27] net/bnx2x: convert from rte_atomic32 to stdatomic
Date: Tue, 26 May 2026 16:24:09 -0700
Message-ID: <20260526232542.620966-20-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

