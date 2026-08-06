Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F183C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2E5640A67;
	Thu,  6 Aug 2026 05:26:08 +0200 (CEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by mails.dpdk.org (Postfix) with ESMTP id D541940A8B
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:05 +0200 (CEST)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c9c26a5fb98so356211a12.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986765;
 x=1786591565; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=u1wmvv/mjzu6WgLPUHvPBroxZOUEqPkucu8b19EoDtaEi5XwQvrHvVbjd3gaadlY7F
 pb3cWcXdFYfATHQzs+UAezpS07CNr9MJ5FPMt+MQ7shmMiXPxLOwun3qjhxFseEzH3bL
 UQxYjICKLGCC13g0vfHTVSQ5oj31LZfG7Dzh1Q8T62eKxmW9LmqdVMkOggK1ytC+KQeM
 qIdvE2kb5e+biiFNICT5g0+ALULiM2Io0k5Dwjv0556MrnbC63ZuGIKokb1AUgMfcQY7
 Ch95MzE3KdR+TJTxWKlpNz4AKO1+epbNjv5FsMeK8fbmAw0H/v+CDhVZOx9dZO003U6V
 6Q6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986765; x=1786591565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=Ij9/eENJogZy1bwmnX/k0Lu7eKca1HKHjNztA1/Z+ZDfJtF4O8Iwi5WzcodYbjBP66
 C/SZ6drXl04bF6/7D42dW5NKIQGPFY7a1MrsHYWEdHcRBTmL+vnGKCVPuKuviQzfMlr9
 QWvKvYHi5FHq9mmrSKmGKoD/9FZ/iI2jOLTkAfhkSqYgPkC/Q9GyjAcsF2kFHe0epkKl
 1CbVXVFYu5BX+9X2u5XSArk4fLMSzr7KkQiJOH1E10seDA015fNxrjTaLRseJA/XvSjX
 y9w+f/fYHd385NP5Uyi5orvP6VRMTga1mVKznVKkiHiJeDdiCfio0bP1kl0yQZolPgCq
 Q8jA==
X-Gm-Message-State: AOJu0YwFtacNJ1FmWjE3QF/JQYU0ZMFnsXI8MGk5WBFiCJBK/b9DC48n
 uGReBYinmh2hj1jVcCsNXsrPtnTg25RmpyVn7B5sNfMv29sPTVML6E9VNYGO6E93yi6b85Z7dhw
 NeGI70+I=
X-Gm-Gg: AR+sD10bdFi1jnQgQXHVBcS0F+XN46rijT0ocmAUVYjNlXhCYi1UbThyRFZ7u1XQ4cY
 YaYUTnfPcsnlcEeQqNXtwu0LnkTyZbDW8+tzDwDJI3nMZps2h2epyy5CH8Y00RPZkylOIxeHrza
 if4PDhMwCFCWv5KZXsOvyiO+fbmrHLnxQxqKJwG0R91p6l6XRWwiH8koSP4i6gQfjEyRy/Zszzr
 MvZ/MNTTnJE8AzxkTtwOlqkKJXcFHhy6VXcAIr9zdP18SV2SkbRFyQnGeKraSpselHKYFG5w9Xi
 JP0xAYm6+HKoMDru5bVHmhADJbe2cl31iJ7TzR3cB++hDs/y8KG9nDvm5H8djREvYRtgsYWmrno
 3T+i5GJaHFzBL5eOINV0Ut6anQxQuRZ77SijmE0WiYa/2ZcNCBt9mtCDbXSbyFzhcAy8665OOV+
 XV17X5y/NxDOREHWiI2WWeSeDnKkIzuAm2DJ5Oy+JV/nSN9v4cgWAvv1wOl4qYUixgcSHii3axY
 NbOUZ9h16ziJ2lyPjvms9Vip0I=
X-Received: by 2002:a05:6a20:7f91:b0:3ba:d7b0:fcac with SMTP id
 adf61e73a8af0-3cb9c0a2040mr4153392637.5.1785986765032; 
 Wed, 05 Aug 2026 20:26:05 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:04 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v7 16/24] net/bnx2x: convert from rte_atomic32 to stdatomic
Date: Wed,  5 Aug 2026 20:23:08 -0700
Message-ID: <20260806032544.21337-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

