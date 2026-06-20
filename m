Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D71CD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:33:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 241AC40E19;
	Sat, 20 Jun 2026 04:32:04 +0200 (CEST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by mails.dpdk.org (Postfix) with ESMTP id 3BA9C40DD5
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:32:01 +0200 (CEST)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-800619d5e7eso23548567b3.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922720;
 x=1782527520; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=nSML5W5lVrDEW0D8+qAlTnd2ZzCqFXJQYdEEOXgQM5A7feJIVCTPeWkRqLLhtDC+eP
 /ZielB6Fdn/c58dcXiTNch0CMwbZ/12lNPJxD5aXTXG0TROwwsBUo7LoABK5ZF2iCTqP
 duePH9w+72dVF2rIadSUypJ6xX04dbJjLFXdu48Js8DyTC47NzIYPyRgZtJTpVS9VmuW
 mW8VonI308Q0YIpQov7/6KfKuRkWNSXA+Xm8jvCucK2Aamw1JR72bd04iEdJKKJpUTOE
 SJSNbZXoabZTR6w+YKEMBiX+zVR1MWJQS6NYh4Ijes0cyTAZfrYF9XBrgSs/Sp0Vp4qH
 mnvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922720; x=1782527520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SXiPVZ3pipZ+5iEEZIAV+QxIF4vuY89DwJfyoIBwidU=;
 b=ehriwbKcBG5nMvYK1mR0ICCXykkg34dCZoyL5MJdMk6+ZQHap0+dPKlaAHH4Q4kNRX
 ZZHeMeW8e7mKZaXzxPk0zXOyJ1W2eN9eqM+PYI277KP5p1cn9IQUnnSoAHGJJi623QSu
 7e1Gf3ZXV12Rd6sHMOGo8lcL0goAw4FTo+GmKn7Ljg96REvqXzAAgbhjKeJmmu8+rauQ
 b9ccg07FuQAc3EiYGn0ZB0Y4jtdcdNv8hcSdsxDVQ41coSRQJ+4ajfZDnxCqYmam2ORu
 dwZJR1CZlEhkGyQsBtlUnhtr8ISOnK/2S+e9t1ugHsFiUWh0gG5vyqeAI/iq8jE9GmQb
 W1ZQ==
X-Gm-Message-State: AOJu0Yx05ylz2KbsStz0JNQTEZnYNYaPlkYdAlVRIq2Urpwq19cSccs6
 k33gEYuuhe25c2bp65AsRrJ8kG67I/+K5zIWISii0f5Rg2akbBKYAJWnQtC8+7nywMPde3kKhVz
 0qnOe
X-Gm-Gg: AfdE7cmwiqr6978PKyGIQFB2xajw+RgKo2tK+Kt6uoP8YL3VAHcxTosjUne2Ml+lA7v
 DgqIIzMX/8qRddUoxky29lHtWDNIpz0XG6D+hemJswAACPTfLCvRyPytu9DKUGBi05jcuYLcHLy
 CH5zSOSjQxqFA+wIN9QNHjQlQ1lwj1ewqM0uoKcwoXPkUoDVD4CbDwfN79ReSogxDkKAe49VnEZ
 txbMSMzAdtM8UKYMysnkUS5sGL+z2IZgpALWGotsBURCbqb1tNd+LuXRK6a3zBTGRi3F+sdiX+7
 gkd0bW1DAkZZCtFjVXLhYf7xb4crcpHzPM0h1eUdSU8AhnC8Rn4VYGWWBhD1R8C43bnZkN87OO1
 LwM4s70hdOsxHz39Z79ClPzKHiWiqNW244ucNHqhPuXzWxY/CKC01hi8UQmGfYVzl/Drw30QDUE
 +aWOHE254Qe3xVT3nqD/u3zGXYGoFS7UqWnQEe8riIkwHqpus0y4U=
X-Received: by 2002:a05:690c:4b0c:b0:7f5:87d3:c38c with SMTP id
 00721157ae682-80264aa6c2emr24149147b3.21.1781922720453; 
 Fri, 19 Jun 2026 19:32:00 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:32:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Julien Aube <julien_dpdk@jaube.fr>
Subject: [PATCH v5 16/24] net/bnx2x: convert from rte_atomic32 to stdatomic
Date: Fri, 19 Jun 2026 19:28:41 -0700
Message-ID: <20260620023134.42877-17-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260620023134.42877-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
 <20260620023134.42877-1-stephen@networkplumber.org>
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

