Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3575C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:01:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C00A4064C;
	Fri, 31 Jul 2026 07:00:10 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id 5DB2940DD7
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:09 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c9aea40d799so287953a12.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474008;
 x=1786078808; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=lCajr6trzOSKK53z3QRW73fTcsxGItHXvgbtjVoqjywJ39erX2yGgP5d20+09OQF3A
 vtflf1GUvm1AeAuNq+DzNc41QnbXr2cmJuueFl1eZoPYDT54MF8iScT/FwLopEUfkBuP
 +X2zr8V6zk1tIecjHooNRsnfnMhBwIYpdadAlICgajI+J+U8hM33r2u/rzPqN3XtqJGG
 DzsvBsWu+RWq7npRMpQNx0wWONIOTRIdPW+vcXflaJG3vuNH3kPlWVKNauYy0EvXqx3J
 U/rAACal+EN98Ij3pTohli2c/4IV6UFwu3Wqgd83qRfiKZbw0jzKt7Ie4g+GhyL2vzOF
 xNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474008; x=1786078808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=sYFPtEWkr9Dj9INUJ62df5LDxSs1dg5Cp9pWkHOfrZZLtwCYoBAzXL4vULh4I1OdRx
 3lCMX9XLaWTH8lx+WXU3g7LOQYNGkDJEpgNsTOuU0BUTB3pLgD+OghqWjqv0pu7nGFTI
 0pItcwwh7VrOViiXVMfSaCeSWHoLE6V3PfeWj+sBMadZbDlycNOTfT58TVBZmJf3PdWN
 AWWM1nvl9JBfTE/H2OiQQTzm9IXbOmBpYITgFY6aVlRAcPkZu76FQvQzjtuvmbG0u3QB
 2gQuk8zkIbK7Nl1TkU4Cee9mq+/SlAqEAkftEONbv8CB++uyswNckEZq1yI2e3b3on5e
 Zcgg==
X-Gm-Message-State: AOJu0YygZ1Xj9YdACwrxbXe7w+OwBlRH3SwZD7JzcR0+89A7uuX+YOG5
 /kQJfofQngBBLoh0H9Ml6ymtdr7DjWz1AAJTnOgOalLEAQKFZ/lVXj8OUMSsb0tSHqgegr97yFs
 7TCn/
X-Gm-Gg: AR+sD1339TWcq728hW2LqAszuqNtFjcG5dFvV18AMkfhd3ZR04cQ+mGiQH1X8u8WFRP
 EQNrAdKwfgoEDYOYG0kVpb7BNYiewiC0aNrQkF3b9rA081KnprBMyNih3iC3LR7ZsLa5ZiOtwQb
 31Lb+HiLq5eubgVm8H1kRLw5gm/sgTTD4Ml0FKmZNQYLa4jt5AodobzMYUjpEdefuB2xidjb6Le
 kaj1hBBHuk9z2r7v3xAMtRFH8Gaf/5Tn8vSfeoHyFexd6hw+1Wa+UNjw+kynY7zqUK/xHC9tk0E
 qLJSZCyMYrcxsxMGs9z5cMlOEoFjMPUVSlh6A0fpdp0K4ajHbUPkn/lZRcD3xPbYCUrxD/qinEh
 FKTi1fjTa0Toml3oeAZEOfTltkJ4rw9StSxv1rxLgcEcmP/xnMN1mwb6UV1AYtA7Tpc5iSE6XS4
 lW5qjt4RWgCJvTXuotqos8Sm/oYa/EHqQOZFATCV4xm63hyJoBtn4U5PzRoybt+X0wtyE8zk4v2
 LtKEVGPM9ysIMRbv2OdTEY0ncg=
X-Received: by 2002:a05:6a21:4592:b0:3bf:7e2a:e874 with SMTP id
 adf61e73a8af0-3c91b128bc3mr474607637.1.1785474008527; 
 Thu, 30 Jul 2026 22:00:08 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v6 16/24] net/bnx2x: convert from rte_atomic32 to stdatomic
Date: Thu, 30 Jul 2026 21:57:54 -0700
Message-ID: <20260731045948.769926-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731045948.769926-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260731045948.769926-1-stephen@networkplumber.org>
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

