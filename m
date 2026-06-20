Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7262ACD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5861540DC9;
	Sat, 20 Jun 2026 04:31:53 +0200 (CEST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by mails.dpdk.org (Postfix) with ESMTP id 7C2B340B9D
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:51 +0200 (CEST)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-7e0b3db3499so24011247b3.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922711;
 x=1782527511; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nDYV133tPGLNB28x768FvU8sRH4MsgtOau61HqKRaSs=;
 b=J5MD+yyIHans+rOfs+z00cMpdVDz7/7nj3nVn1u1Vd7Gs3C6FonlPGjof55QYsoNIw
 QoVzqFztMinAUaU4W43d1KaXwdyh6hIGh0NHeOaLLkdlacHhGG5HiED+wN2UspN6iYqA
 ss1d23xZ1320X9X33/NYVrGBQV4NpLVIdTzHItVj0ZkXchY4d5cwJJIi+SJMO4+SQVuh
 eMQD2aXfRn+jqyw9WgDMsAk1/4fPp5pQQGZM5+2sTMWzXA2chMf+pvazIgijjUuF1VmB
 SSSVhG2/nY+cPB3bW9TQQvZgWT4nwuoxcYoSzuKACR80rUve0TIfrmMmT9PGatHv5P4L
 TKZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922711; x=1782527511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nDYV133tPGLNB28x768FvU8sRH4MsgtOau61HqKRaSs=;
 b=SS0ExuEQu+mv/hFl1cM94clIXya1EGYg5Sj3BTmgOpKZVD3G9LjUted7STGM4jbPIF
 KwhJzzMnojnBgrC1gorOfmn7hlb3+c6ByBwjrEEcg2ND4m6qvqvVdgEh4h+24Mlum9lb
 XFlheR/QkAryx0pCP0oq5gtjrqPRyilH4y8/CI3jjMoe+c5GlCb8k9MEd5cTtzDhKVJv
 N13xA7o0o0CpKgEEFV3irUFBQHZepo8Zt6D70A3IDYqzghuj7ZPrZApmtOY7qgeBNLxu
 TIgyevwjK9614oK3Z6bCVu0hVdssQRO4omWmwdrJuYoQtVqEsiK9fr3elThb1efgD/0Q
 6oRQ==
X-Gm-Message-State: AOJu0YyWu2NdKAi8/jTtHbbxCSGk+baLA5PNWA3N9ZVy73LcJj7BloVR
 S3EW1zEzPI9wcAB4cAW2iTaI2ldScL0hnQW+U5oXv0MIB5ZCyPL9o9Bjm8aHK8K2ZTgLamYGWNb
 Xp3gl
X-Gm-Gg: AfdE7cmEEdwsZc5UaGEbvHgpa7iAlgCJ7NnHlUE8lNlTh5veAZB1Q/vJuYJrdRNK8HE
 SzlcLqSgc/ltmHA0pj3/z/yIEEPhUo80iY82vvrPs2JYCUM1ujTvTU6yCVS9P3/c06qDvt5mi5R
 cnuVgTMbHcFPcd3OMT4lhQiQjmo/nBKhM3fbcMFcnKeAgSDxHhntt1Ac24PAZl25nsnwrNvXrZw
 sbfiSTtKwfz48QPjKQ9DdSuL93t3EHjKTXan2mUHANlaySAwbwpcc5zcc4DNtprJd70df1tusWW
 svg61gG3NvJb/eSUDibiFIdGj53UJdlwDJhPVJiQOl3HPGFPvqZKfRQaHHD5lwLyUi9TAfuPCzQ
 8uS1v9xSRRF8gAS9T4M1nPBq6Xw5PdPt1gedoNbG/myM/DTLep0qAiG3P+e+YUoSzH2dzNefyKG
 wDaCyRXScqFCWRmH2jkKRmlr2BHZdx6Y7ja85kf0FsLBOGvN9Nkb+EinuwOK6JeA==
X-Received: by 2002:a05:690c:b90:b0:7dd:73e7:84d1 with SMTP id
 00721157ae682-80135d10810mr63753147b3.13.1781922710575; 
 Fri, 19 Jun 2026 19:31:50 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [PATCH v5 09/24] crypto/ccp: replace use of rte_atomic64 with
 stdatomic
Date: Fri, 19 Jun 2026 19:28:34 -0700
Message-ID: <20260620023134.42877-10-stephen@networkplumber.org>
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

