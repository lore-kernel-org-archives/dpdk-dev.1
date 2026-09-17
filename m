Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EF2C982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:13:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6D7943269;
	Thu, 17 Sep 2026 22:11:43 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id 9FA3343257
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:38 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 d9443c01a7336-2dd88a115c1so254165ad.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675898;
 x=1790280698; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=p9N5vRqSHUcLH7URa15KYU4PSmpdGB6B/uE9gDTATHPjrF10HLZFoQD/JamZQY3tgX
 tLJJ7JGQR3/cbMGIIasq0l2pQNqGCb2peW1sD3WnQslaJRX4guRdrKPN2NykB95EU0nR
 ZTIwPicncckSApFAus7dorFEUSg9XGi3BE2OUxfRMFy7t5p7h8HY7YVzgdPmBFjwMo6J
 ++dYxvDDB4V7DCb1vEBIF2scjxzUG1a/fe9NPvy2UusKkHQYne5Tp62+A5euB6iuFbqz
 /PgtbKOgRcAojhGL54fQNhglfty2ok3WTO4wHX++at2vqSkq5zktsUA1w9bKstjHz9Xe
 5myA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675898; x=1790280698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=fRzxmUKA+gy7lRje3g2k86SrD6pqXwjlTUdAh0nc86TvPSoq7i0mHr+wv5RjF3tp+X
 2c99lGyBH0nqd7u8GSl6/i88sUjbrgORmjx6Vgr1XuojyUqMna1SsTm94jJL+q0rs6Po
 OdXcI35od0AmUc7N2XzZEU/rHGms5DM0/EBb2j3MHdIBJ50lpUpjbGkniloDldaV+njQ
 xqqrM9pCBX1OkBa0RzeJEqwI8S2eNMCA2w+6G6KDLplgO6acsbjXIyGeaUXONX11C6P+
 S7TvaqGbUgnqoi8PgztI+DxNJ2xHwBIvCl4TznM2sTEWTqpaZNHFJjYpsZjLa0j31Xn1
 yXLQ==
X-Gm-Message-State: AFuF++mvMTb04rlu03Fkfz16cJpJ+w7tkPg2CBftkU+18znn0JMaemZ8
 aNHcnaayC09D5okWbVINOcmKH8UKj9rwzRrnLfmZ+omzMR2sDSi2Dlpvg2LTIV8K42oxHXapFHv
 i+w3J
X-Gm-Gg: AYBFou18XNh70wOz74t8CEQwKAoK6R5T+tBOWjNklMLcLa9xyKepFlVubvfZCAE3FQv
 6vVIJADK+pSaK3xcL/ed7XcXiWZy0eq3n47pfNaP9Y37QLmq5uyr7mDF17puWvpQ4/gUt/llKRP
 iofxzFg01uqxnK+lQmtKVGGz4NFqm0QeNfjYiobOjalX9UFtr3LGky6erMpC6ziHrdBI+hD51TM
 LEUe3rqgir5ND3kbfTlb3QZK926VDZjUzdDRTtBBYSCcvaBifyl+Ib79hQ4xC+svSMsZrM91kL9
 lcxwUA0aglENDrJV7E5XZGw6yXTKJ2TtwnZlveNm8OEg0bSwsoEg0mgJ4UUssy7vQQK+TQxT9lO
 rP2tbSlAHhOAXNQARiUrMd4pI825c1bCsL7N9335vNr9yZ1M7uf/gsmK0ecdu+Bs7y0AbdK8kkJ
 X0JN2pUt4yKelMi/Pb4tG3ImkyGZyUUAIXA6DgTv1AyDqOYI57+zoCHEfJAuj9lJshSkVFVUhd2
 0WBehe8KwNTBiOEOmqJNzR7rrFFJZV+Oit8BA==
X-Received: by 2002:a17:903:1a0b:b0:2dd:7549:39d0 with SMTP id
 d9443c01a7336-2ddb1b86d77mr4741645ad.18.1789675897579; 
 Thu, 17 Sep 2026 13:11:37 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v8 17/25] net/bnx2x: convert from rte_atomic32 to stdatomic
Date: Thu, 17 Sep 2026 13:10:21 -0700
Message-ID: <20260917201119.2168234-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

