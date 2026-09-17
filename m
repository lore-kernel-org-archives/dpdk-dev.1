Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A84C982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4939142FD5;
	Thu, 17 Sep 2026 22:11:36 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 021F342FDF
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:31 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d8fb334e72so322035ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675891;
 x=1790280691; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E3N+8LlpTc8hcuIAubrC64R0p8hw3zimiex6fza0Jio=;
 b=HnNfcQoc1I1cgNxVZdSN3DNGBeQeLDcNAUK7rWv327AsKJhqbd/Gw1/hM8wx+dT3GR
 LQJHCT1JWfub3OESfSzXwtXNdVgj43fzRInW6l82USPazXXz4rjH976mU8PUoeOEzIHv
 l29gmYhng2N+GglFvXipUuMzFirtFW8//Ii0O8cXdV9wcFkk41oag8OrLEM2o3UarFm5
 lhesRZzQTTyamMy3sxl4qj9qtXWzy8NSSJQMwB7NuEoQwGM6Z1VNHtxwvI6VReGNPKaF
 HgH4n96bKHLD8dblL+j7V093Moo9IA04HzFm2By5mJVtIyDIQHfHo0LjTkT+9Ko2tF0D
 iTrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675891; x=1790280691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E3N+8LlpTc8hcuIAubrC64R0p8hw3zimiex6fza0Jio=;
 b=wRWWr99Htv41DXOjvYNu+H1U/w3phlpaHcAQI4UH7PWImYKk7nkYveUtj4J3zFILGs
 hXN7YtDyn4TJt+rnbMtxY+sEiwhRfq8Mf+2mOwGywSDTPGbc6Q6G/n2n9NhmntCsy37g
 4Xkjew/vIwlNiejQt3V3o08h4wqWKE/6WvlQrS4lLzowlJAzDNrCnmYLCXCJTi8k4IxG
 L2FTYgKuKr+/qasTkh8Bz/FLQ3ms+W52yJoMBID6qO0kXMq9gau3ckQC2E2wWho6EAqA
 REQXm0K5S6zejebE5xizlZ5eWwFrX6nMJ1G3Ma376bP3UePj1n98UQeJHQTRQkR9OIca
 p79A==
X-Gm-Message-State: AFuF++mhRUpDTwdQ+7yrCeliQryB85fWvw8k9sRBx3gvzuSA1SoVtA/T
 mtH8rii+nOtTVhEx5EC7GtSjWQwoGQpzpc9QL/mhc0fsm/4rSJyA/hmfuHkuRlKhnubgEzUvTRd
 Mbxwl
X-Gm-Gg: AYBFou2+MzfRm8SFG4Deq70lV6+VxEYu5BKT/PHtU2/l8hwYJo04KouaWfe0Vv+wMK4
 1hRBRnNB9i8mPbTCenblFlg7+sk5IUJBRlGPnEY1SWyqdrWTrAxM2A/2F2CsHmGX+4blNXCX8WY
 4+mf1/k/M43C1j+L2GmfxfI00PBwLHKfSIyfUiQIKKgPyPTW+nm7H+WlrAfRXiMnvIGYQ7i14Ql
 nr8m02gY9yPbxJ1tUeKKJx6txFo8cN93gkqkwr/kx/r3VPziO6AUDtfbwP16JxClWliMk5h/iLu
 qml+7yfATFvUQgcPYrtUJdkg3eT6uHc7Z0IbkndX0639UpdWZXb3DTQFkXd//XyC07pm74nmwgT
 YxwIYDTSpM/mXFEWaIybTGF2eVLiYkmQUfmxnWxrbCZiTP3Act+ADtaTaUlV2HJ+F6wgT7OvQ1Q
 7CGEpAg67e0M1KX/wQdbTR0v+v9pFy2VxPGCRK1V4HTXXE48UY1z4ETykdkfHZZjOhEQvlEhTIv
 lOaiTrYIuxHrdqAF+oiozbet6ZHXQzmLFLm7Q==
X-Received: by 2002:a17:903:1b2d:b0:2dd:ad73:5b6e with SMTP id
 d9443c01a7336-2ddb1c45e55mr4267985ad.30.1789675891063; 
 Thu, 17 Sep 2026 13:11:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:30 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [PATCH v8 09/25] crypto/ccp: replace use of rte_atomic64 with
 stdatomic
Date: Thu, 17 Sep 2026 13:10:13 -0700
Message-ID: <20260917201119.2168234-10-stephen@networkplumber.org>
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

