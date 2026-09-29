Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84BE7CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:05:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6806042E49;
	Tue, 29 Sep 2026 16:04:28 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id E79A742D27
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:21 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 d2e1a72fcca58-88098dbba5fso876045b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690661;
 x=1791295461; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E3N+8LlpTc8hcuIAubrC64R0p8hw3zimiex6fza0Jio=;
 b=fF3BwQVVcBItIVaOFpZlxTd6ybGZXMsm9g+oOh29Lgkd/GcNJhxyzRXoXVH7TOtmCk
 ymiEwJUS1jEIf1zGl91zyRXvsFSHpodrI8IDkT8/rijJT6FmcWNJoK3ftmA4S7PhytNm
 tdGtKE4B4511mM/xaUQ1K9d+7UAGqR9PAXMHxnZBEC59fOzx3v8qMIaS8kDSoQA6a6zz
 CBMRxwJyZ3MUu82Sojiaqr2SB6zaavg+IAdRXhRqRTrL6Iu2R3pGUBCbIeGtJD+WI5YI
 NJksCet5Mmx7z1S6e6YdH9U3TWg8eqr8GHC9S0sCuX5lqs7jZ27zh1yv5LzwDVGQB+H0
 3bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690661; x=1791295461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E3N+8LlpTc8hcuIAubrC64R0p8hw3zimiex6fza0Jio=;
 b=1sIZZl0TQNVvnyy09/fwVGN9etgQypYP47QEsm8Uh8MKyjswv1h5d9D1//UrsvKhsG
 PtOlNJECYJXxryJEGlnpR8Np+lmAodmuxtnGY10ZNoHoDTy1u9SxpztOi57D81sbwJ3C
 mT9bLzCWEsA03Oj+NzD5ty96fOIzW/ugtn1ko3fNYu2zV2RDlckufLDTgPObJbYIvR2B
 tVhjEcpqAJanl26LfSenwTlPWGgx1P9ijpyZZTCpNDF1muClmh98Q955TbP5tr4Q1VcW
 hLr90+oyKqzS8rbwlpGvG6IaWVigzKCXBf8UvSyi1pTajYaZFjlaJK5kM0nVjQJCr/wz
 rVMw==
X-Gm-Message-State: AFuF++nzjqnpLXrM1rUKKGeYWcsscCYpIjwHGWZ5zSHUAQQHoBqf7KMH
 Sfptn5lPGm/mfoOPR+uubXGAFNS1+bBe7Kf8EfyX+q08xlnM9u5fS4WtCgJvJGB9epE2ed3c/Qz
 yyWSNVBk=
X-Gm-Gg: AYBFou1k6ILwwhend8O4Hv9FZQRPq27PHqfLUr6cJuO9hhJKj8Ag1V6G/nfOCtPdLId
 L7Spy+a1rhMljB7C2+/ecjNziIlgT/SykWixQGJseepNoyNDaa4XIA9yQnHHqNRvKaOAK37pOkm
 +RpTvbODgmNhcCDYoacweeLAJ1GVhuE3tj6CoQLQucL5ShDjXirs2pvc3pHVDhdEaNt1eZPvmJj
 W/8/D2mLxYq3xaFeIPqdciT/pjnT7sBmQ03QCv4zG/KbOve2NTskJ2Mes1EpXqbJzuvPPCX1r67
 txogUHJPBjQ3Cdoz3BX9lvGeWSoVoqR5Ke/MG6obcxtDFZEMUo5yiPQCFiCnRSDqpcJWlduOuK6
 QuBQsUrsExkSlpkro2s3WQyXTzfwduDAuSdIFu21r4CcpLN1MC1cjMcjircq35TYcAsxI0jxDAC
 mGFBfyDtq2KO18MDnV8KV/tOGUGpEdHV7+WH/+TTrjg2UTsE5SJuUTP5wL5pX5iikm6Kz1eopup
 6zwyvRW6iH7TWqZnusi0U1aMzszybsYMBS9sA==
X-Received: by 2002:a05:6a00:2daa:b0:882:cfce:9e00 with SMTP id
 d2e1a72fcca58-8855e5a6f80mr1801492b3a.6.1790690661007; 
 Tue, 29 Sep 2026 07:04:21 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [PATCH v9 09/25] crypto/ccp: replace use of rte_atomic64 with
 stdatomic
Date: Tue, 29 Sep 2026 07:01:55 -0700
Message-ID: <20260929140409.234453-10-stephen@networkplumber.org>
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

