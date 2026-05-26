Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C81FCD5BDE
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B91D40395;
	Wed, 27 May 2026 01:26:06 +0200 (CEST)
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by mails.dpdk.org (Postfix) with ESMTP id 97FF74068E
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:59 +0200 (CEST)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-132c338a537so7424495c88.0
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837959;
 x=1780442759; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDYV133tPGLNB28x768FvU8sRH4MsgtOau61HqKRaSs=;
 b=MVMIdb0OCVxuvI9mF8xvD8fKJHRv/HTzLbGNp/QbF+ueF5b/rP/dNNoA42wyvgjNua
 AqbAV4tIDg0Rkijk3NfhX/7RL9LdXFycYy6NReeRC1f+gyMr2d7S/7y4aG9RaKUfHkMQ
 A3BoNJWf2YLazXJalNpNYQlhHwEXXK4zzEOmxGVLTj/IQYqxvt/gZgelfhyMqx8SilU+
 fYLD+Lgidc0Iv6pBk8TbFEsdnHmVZ06OsSwzI9y+NvNOyEB5cbvSi6So42BLaPF8cVov
 4KIkzb3chK2Pw2mEDkcOeUOv6RmEV1YK1I0PfCGVM7APCpVIcTfF1HDCFsAxnTKHtD+W
 VvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837959; x=1780442759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nDYV133tPGLNB28x768FvU8sRH4MsgtOau61HqKRaSs=;
 b=Yazkdr1YMa/yjB1TImGyYUBTxMmfDwQ7AQ8YaWr51yJ81mEy+XoNMFWr7opPECUhtC
 IN7ao4jM8fRv7eVyiIYgMHZQiGQXiqgWGdMnMv/dDyba6vdUu2At9sIH3yFyoy5We7de
 07IHeBO8r154W0sYqlFIw17doJtQ0UJ7qVJhD88eVI5ekgufUJNH9vx0zOmnH4efhiuw
 rVHVOGdTSzNIhXc54N9UunbkrSKZZAuESzx6VPSj8/OOVMWlvPLqb+lfFi3B+8mU+cop
 OCILJCHPTgFBisKfIaWHceLDYe1S4vMhvZ0XXD1/wDsLmxn4T3C5zRQk5d/X4JY0nU+K
 X8Tg==
X-Gm-Message-State: AOJu0YxJmoaBsmn4tpXiYOoRHJsXsB2YS948qevoyc3Rtx+WhbuUGaoF
 bowy480oQAoNj6BM46UnbfrOM2dWhVAj+lLf+jUJmpWf/8wd0UcXbLkA/6raG7BrwiSdZ4HpyIq
 W6EOH
X-Gm-Gg: Acq92OGqFwcsXubAjEYTfKTgI5NcWcU6XdW9Vi5wG7JhrInNaAoR1LVWZjH38c6julC
 PMJoy1pZB28wG8LQhzYrtskrzXPkdXKFIM3bWi9SdzZBUzqnD/gZCZvMwdfISykd1P7w5gsTJmd
 +7ZrNcX+BltfJpIrSW2HGK079QilfSobseQRt1cXh0ZxTHmUDEYHL4GRApMEYMvryXPGkTYoVWt
 YAfSSUNoHBkKE5eMPNrXCYX6tILwJr121E7w1MjFFKcFxMtZOVO6l8XsoaI3R/I/rCLxSNL6Cu7
 fRDwWsI/JRxPuqOwTONFyy3pDG2Ms68oNAR4GZW8JHBr62AiyD2cd7/DSS7eJOPIJJbtk4gtiW/
 Rba6SPwyWI+K3ZSuRvOGKPq1veX8zvEOb50w1B1v2Pdnmuu6PjPWp4vJRXvPZy0yMM+97yAhOsS
 EsgrYI8ZVDNMsgAZCrogMeWNTqIwkghhe+tf1tiP05HYRPbTYF1lKlLHV/WUkc1ubgjjnZfqnO
X-Received: by 2002:a05:7301:388a:b0:304:81b6:fd51 with SMTP id
 5a478bee46e88-30481b6fe6dmr3933134eec.6.1779837958640; 
 Tue, 26 May 2026 16:25:58 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:58 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [PATCH v4 12/27] crypto/ccp: replace use of rte_atomic64 with
 stdatomic
Date: Tue, 26 May 2026 16:24:02 -0700
Message-ID: <20260526232542.620966-13-stephen@networkplumber.org>
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
index 5899d83bae..1800ad41c9 100644
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

