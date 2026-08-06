Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D73C55838
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:26:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E4F10406B4;
	Thu,  6 Aug 2026 05:26:00 +0200 (CEST)
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52]) by mails.dpdk.org (Postfix) with ESMTP id 6477D406B4
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:25:58 +0200 (CEST)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38dc4553f62so1855154a91.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986757;
 x=1786591557; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E3N+8LlpTc8hcuIAubrC64R0p8hw3zimiex6fza0Jio=;
 b=bVuUkdiGQS7cSqaPiOOKnl0tgCorw3PB+JZUuN7nsNjwdamE5m47oMA+nmqNdMedhN
 ftMmTy0WOBzs2TrAckfbPCrmu0xvGvrnUs3qRDNtF6DkllbmxFNBC7FiBgp8IOemis4A
 nsQ2gBJ+9/odBDpBkxxQly7TaPaZQf696pYxyX2CVVZZjwYRyJd5V6NHYpxDiLT9aK6l
 aDWCV1c0TaxW6V/9Uy8kU/8UDZtArTxRAGMFoApBE/g3JFz0CU5Z4TbtDi9KE12HA8ic
 CQbGt6XQJJBKoQA6LyVl+yXnTmW48n4CcGzKWddXRbrfoCzolPmGgPvuQyxajWk20tPy
 HqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986757; x=1786591557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E3N+8LlpTc8hcuIAubrC64R0p8hw3zimiex6fza0Jio=;
 b=C/cVYoEZM2DPMgdAgtImc2ajIwUIVPapyiKzYB7BgLun7rG46ca9lmexHxGZhkLoPT
 EJNL1/+vug5qcYilZqhdQyvXU6GJrUbLmjt40HlAC4ybaeNwmX2lyJqv15KHrOhR9uqZ
 ICELIXz1tBmUdhfk7Te7ksGP65rk+CRrAp7iIwBAPw1RkqfzkAitxkGfmwveW+gwuZaF
 Nwa9hawKzpT/U7gqfhXDa2oU+pt/cXUCQyEqFGWcsqT/lSMuZAhrEnE6mSttaFZzyFvI
 Y1szdrnxIozvl39L3DYCYNstNrfoeh1wwEvXGOHsM8bG0u5R4z4uFPpbJc/GzYoiYk28
 eYVA==
X-Gm-Message-State: AOJu0YzFXnSTnPChJqS1actiPgrj4x0lIk9lrG03gSnB5Lc8B/93ZuAE
 zcntY11OKGtEiJmYGMLDQqOblxRvRBXWv3YAjPLrrhV5GCg/S8ANIMheL36sgxuJ7u+EUP+PjiI
 lmcc0YS8=
X-Gm-Gg: AR+sD10sDNIV7/4vydcFWAGscfUkeRGbCKKOipv8aMbOyykY+PAoskilh76maGwsmSS
 x8SUxlalOsarAZ9bpCa/oH+wKiihHW+AcZ+7ypk7+fs0J9dHz7LoyxpFO1YjPthLvkaOycn2nCU
 OyNLSRxt6izZE5l4IhuIYP43r3uvW+WxXQE0qNvRyrL1W1+QGf8zQSlsjx8p6vQhbQXlpP+KfzT
 AWtQHQNK2aoBJe3Zd/nHRh5Xrynk2fRkiuZuSk/nPhbPoYRMMOvGxCTg41OhNTYwTjyMHdmykAE
 aeimHbvcz89RH2OFHwLBoIH19At3RWHtBSf7pJa3Wc8z4GOrdrtTwtuK1X5IJBxWZOo6RWFEvIS
 8IHmjRBHBuQbcoAv58vbXhamq0Pbd7nlNkA2Befc2LqwycNtt7SQdJdL8LCRZ+aAam0+OeAKzmH
 lmilWXIuo6cXksJVb578O4CopUpdauBC0/dS6PMxnrdwE0K/JdIr4opxScu5fF3iYpUQo/cXZOc
 +HHiEmBkLwzfbXWML0PuMFj+Xg=
X-Received: by 2002:a17:90b:3a8e:b0:381:152b:d596 with SMTP id
 98e67ed59e1d1-3903c59a6f9mr9693719a91.11.1785986757496; 
 Wed, 05 Aug 2026 20:25:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:25:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [PATCH v7 09/24] crypto/ccp: replace use of rte_atomic64 with
 stdatomic
Date: Wed,  5 Aug 2026 20:23:01 -0700
Message-ID: <20260806032544.21337-10-stephen@networkplumber.org>
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

The rte_atomicNN functions are deprecated. Replace the free
count with stdatomic.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/ccp/ccp_crypto.c | 11 +++++++----
 drivers/crypto/ccp/ccp_crypto.h |  2 +-
 drivers/crypto/ccp/ccp_dev.c    | 10 ++++++----
 drivers/crypto/ccp/ccp_dev.h    |  4 ++--
 4 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/ccp/ccp_crypto.c b/drivers/crypto/ccp/ccp_crypto.c
index b07a786d8e..f966335be5 100644
--- a/drivers/crypto/ccp/ccp_crypto.c
+++ b/drivers/crypto/ccp/ccp_crypto.c
@@ -2683,7 +2683,8 @@ process_ops_to_enqueue(struct ccp_qp *qp,
 	b_info->cmd_q = cmd_q;
 	b_info->lsb_buf_phys = (phys_addr_t)rte_mem_virt2iova((void *)b_info->lsb_buf);
 
-	rte_atomic64_sub(&b_info->cmd_q->free_slots, slots_req);
+	rte_atomic_fetch_sub_explicit(&b_info->cmd_q->free_slots, slots_req,
+				      rte_memory_order_seq_cst);
 
 	b_info->head_offset = (uint32_t)(cmd_q->qbase_phys_addr + cmd_q->qidx *
 					 Q_DESC_SIZE);
@@ -2729,8 +2730,9 @@ process_ops_to_enqueue(struct ccp_qp *qp,
 			result = -1;
 		}
 		if (unlikely(result < 0)) {
-			rte_atomic64_add(&b_info->cmd_q->free_slots,
-					 (slots_req - b_info->desccnt));
+			rte_atomic_fetch_add_explicit(&b_info->cmd_q->free_slots,
+						      slots_req - b_info->desccnt,
+						      rte_memory_order_seq_cst);
 			break;
 		}
 		b_info->op[i] = op[i];
@@ -2914,7 +2916,8 @@ process_ops_to_dequeue(struct ccp_qp *qp,
 success:
 	*total_nb_ops = b_info->total_nb_ops;
 	nb_ops = ccp_prepare_ops(qp, op, b_info, nb_ops);
-	rte_atomic64_add(&b_info->cmd_q->free_slots, b_info->desccnt);
+	rte_atomic_fetch_add_explicit(&b_info->cmd_q->free_slots, b_info->desccnt,
+				      rte_memory_order_seq_cst);
 	b_info->desccnt = 0;
 	if (b_info->opcnt > 0) {
 		qp->b_info = b_info;
diff --git a/drivers/crypto/ccp/ccp_crypto.h b/drivers/crypto/ccp/ccp_crypto.h
index d0b417ca29..5c61b1582d 100644
--- a/drivers/crypto/ccp/ccp_crypto.h
+++ b/drivers/crypto/ccp/ccp_crypto.h
@@ -10,7 +10,7 @@
 #include <stdint.h>
 #include <string.h>
 
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_byteorder.h>
 #include <rte_io.h>
 #include <rte_pci.h>
diff --git a/drivers/crypto/ccp/ccp_dev.c b/drivers/crypto/ccp/ccp_dev.c
index 5088d8ded6..a75816cdfc 100644
--- a/drivers/crypto/ccp/ccp_dev.c
+++ b/drivers/crypto/ccp/ccp_dev.c
@@ -47,14 +47,15 @@ ccp_allot_queue(struct rte_cryptodev *cdev, int slot_req)
 	priv->last_dev = dev;
 	if (dev->qidx >= dev->cmd_q_count)
 		dev->qidx = 0;
-	ret = rte_atomic64_read(&dev->cmd_q[dev->qidx].free_slots);
+	ret = rte_atomic_load_explicit(&dev->cmd_q[dev->qidx].free_slots, rte_memory_order_relaxed);
 	if (ret >= slot_req)
 		return &dev->cmd_q[dev->qidx];
 	for (i = 0; i < dev->cmd_q_count; i++) {
 		dev->qidx++;
 		if (dev->qidx >= dev->cmd_q_count)
 			dev->qidx = 0;
-		ret = rte_atomic64_read(&dev->cmd_q[dev->qidx].free_slots);
+		ret = rte_atomic_load_explicit(&dev->cmd_q[dev->qidx].free_slots,
+					       rte_memory_order_relaxed);
 		if (ret >= slot_req)
 			return &dev->cmd_q[dev->qidx];
 	}
@@ -583,8 +584,9 @@ ccp_add_device(struct ccp_device *dev)
 			CCP_LOG_ERR("queue doesn't have lsb regions");
 		cmd_q->lsb = -1;
 
-		rte_atomic64_init(&cmd_q->free_slots);
-		rte_atomic64_set(&cmd_q->free_slots, (COMMANDS_PER_QUEUE - 1));
+		rte_atomic_store_explicit(&cmd_q->free_slots,
+					  COMMANDS_PER_QUEUE - 1,
+					  rte_memory_order_seq_cst);
 		/* unused slot barrier b/w H&T */
 	}
 
diff --git a/drivers/crypto/ccp/ccp_dev.h b/drivers/crypto/ccp/ccp_dev.h
index cd63830759..8c408ac8d3 100644
--- a/drivers/crypto/ccp/ccp_dev.h
+++ b/drivers/crypto/ccp/ccp_dev.h
@@ -11,7 +11,7 @@
 #include <string.h>
 
 #include <bus_pci_driver.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_byteorder.h>
 #include <rte_io.h>
 #include <rte_pci.h>
@@ -182,7 +182,7 @@ struct __rte_cache_aligned ccp_queue {
 	struct ccp_device *dev;
 	char memz_name[RTE_MEMZONE_NAMESIZE];
 
-	rte_atomic64_t free_slots;
+	RTE_ATOMIC(int64_t) free_slots;
 	/**< available free slots updated from enq/deq calls */
 
 	/* Queue identifier */
-- 
2.53.0

