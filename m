Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1003CC55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:00:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BF6F40151;
	Fri, 31 Jul 2026 07:00:03 +0200 (CEST)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by mails.dpdk.org (Postfix) with ESMTP id 0AA4640B90
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:02 +0200 (CEST)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so684570b3a.1
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474001;
 x=1786078801; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E3N+8LlpTc8hcuIAubrC64R0p8hw3zimiex6fza0Jio=;
 b=gdvp7qkCG4BnJNZmw4fHcN1oMq+TSipTzBCJd3VsWABKebZ2VTK6jn1kxrgIhgyqzq
 +kqcUd5sEGXhIGM7C3QJwggmTJwGdEnxoQwopiSa7Z+Kki1SjYdl7sNGeEmHpKf5Dctg
 SsnzqrSsy8qxsUCAMZ/rWjIl2T4L+I4ebsG7P+jAzpfq6e5YyvPTW+D7tdnpS1c9Zr9E
 CmC+bG/m1CWD0gtYOqb6jX8OkZ+MDqljfpqXDhwGYBv358kypQ9a0XxnpI4yUw0qBLSP
 UHvb81adF/UPeZ/pNtSC87z5emp7lIhrIYkuVahe0vFP+hCRFbevHlbg4eGrOuihk1O6
 BKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474001; x=1786078801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=E3N+8LlpTc8hcuIAubrC64R0p8hw3zimiex6fza0Jio=;
 b=qGhq4O6j7pVPIdjhXAzD+2vybr7doOl3zFTeYQ7ev1JfbeN8o9qdLDfzwOMRGW8ENs
 dtDusH4utqHX13qD/HVPHPdKiw7/8brzGjk6dEIY5fGywa8ynoInSepRjwxydf3Wc7oG
 plW9B6b/AQLuo81xsO6AWQOPdYkC7jQqHr9soNXU3ZA6G25+dKZwp1LuEvPyfdlH5sra
 a5xRsXNIzm7fz7oxKFv6iFicMwi1J/ZJxhtvcgZd8zI6co2dKDvpJSzjmmxLYDcwSK2Q
 xteGwv2Nec++oW+Vk9RwlnPl4hvBtynAHlrViUWVVtgNgXOgzmEJbQ2qQFpTBbaBxzno
 CvQA==
X-Gm-Message-State: AOJu0Yz5MusVPHDutpOSLw28Qew4V1Zf6gTBl5PDymmgnfmrmn5aRqh9
 drsBnVW8da5r9uuBHsfpIAwSdfre8boMZ6MlTVp+UAie5RecmwAU0UlIyLdZV1Ix0SIgKH79nz1
 DIgwI
X-Gm-Gg: AR+sD10OZOhSheuAuXKXrz/eRy+6rs5ZLbLIwLRdV9Kkfa34O8CDs4Wx09FqluPg0Tz
 y9z1540CjjokHryKKd4vpBemA16y6CqoYy6zPdAZc8He48XYK8S2fubetZsQyKxwUgJT7eZemfs
 npITeKPBgQCsFWFqUTZRS7WblJKxGbaYtK0C0Y5+wsn8I3xq03QcgSSaeVQIlEvCOJYuhpT9dHd
 mkQsXpMpoDG12Z2gdjJHOnqf2Pc4qkF3ZQjSrAO8oRWR8qw6kmWhFc5sQHv6FDm5jK1nfrnrpz1
 Hqa5lG8mZzMyFOfCJ7oLzRLuW8B9fIWP/rHlwHHh7XedDSTZj0XRlAEt6p97YgVR3yyHLdLD/ZW
 zho18Jnp0BfSegfqjt1nsTlodVohVNClmZ9OD7zl/bWsgo2QHzktbAEboL4ByY04+l3Nj7cWIAh
 rJYg0vVZEc6EtfRByR35ftuQFGHRR1H6ZTkiaHRgcCVFc+BlRG086yPRmJY5AuzgIwr2rqGa29n
 gn3NA253h7pV5ywtJXNfBPS4QY=
X-Received: by 2002:a05:6a20:748e:b0:3c3:7019:64ad with SMTP id
 adf61e73a8af0-3c91b47013emr478090637.66.1785474001134; 
 Thu, 30 Jul 2026 22:00:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [PATCH v6 09/24] crypto/ccp: replace use of rte_atomic64 with
 stdatomic
Date: Thu, 30 Jul 2026 21:57:47 -0700
Message-ID: <20260731045948.769926-10-stephen@networkplumber.org>
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

