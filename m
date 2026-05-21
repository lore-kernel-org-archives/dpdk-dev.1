Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA9CCD5BAF
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 18:08:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B54E34069D;
	Thu, 21 May 2026 20:07:26 +0200 (CEST)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174]) by mails.dpdk.org (Postfix) with ESMTP id 77D4340697
 for <dev@dpdk.org>; Thu, 21 May 2026 20:07:22 +0200 (CEST)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-303dbfbec77so7018344eec.0
 for <dev@dpdk.org>; Thu, 21 May 2026 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779386841;
 x=1779991641; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64hXulL9/StHbvtICSYy93il1Zt/TSw7ltUk9Ubbgc0=;
 b=OtPQ0kLA3DNiiKT+WKV5BpkLVzR4Yt3hKDjVEyHPkpC9+JtkukUkBYjsNLLZETPZWW
 TMwZT9yGcmAPGz8hApBv7jbIxeEQClJ21T9sGzqOp7wtOBemGnEDxP+DP1ynMQIyRzWi
 dDc+sKt3S9hOVl4kNY9sZ4lWQq/Y0DLGlBNebffh9vTlcEj/wFh7zfsR9w3fYoL/Q1NR
 VnKE9sq7GVetxHfy+SGgHuOyw8FYUder1xM4BXUhf+ToVx5+16jACsO4wPwJJh6+U5wp
 8XnKPbN+nv6E1RVqxHM/uvYB41ZdWJnl4YZEdvGNIbs8COoQt30pwr281AIa10Ci7a0n
 BFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779386841; x=1779991641;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=64hXulL9/StHbvtICSYy93il1Zt/TSw7ltUk9Ubbgc0=;
 b=XnySsY+pkOwRV9/M0wSKa0Y/hWMj76y83Xbbx5YWvKON2diDsvT21WEp4eNoiLOvV0
 LCXxWVE9Tsm3acnLqHdxv1kxiGS7oJcSc8JRnas9QIgJXMLVo5kxqIzlDVBAlL2Klrbh
 e5KKrOqzjTFmFu/SBLS9k2ZNPgSX4BmfPgWUwfvhSVx1sjAEsY3k/0qO3gpg5X15wg3O
 NGc9jROlv3l5AffS8Ds252UMEeQi5gaUhF8U0beX7WHOfjI6joJwg5GF6wxvXpJbWhh/
 u0j/z9/bvao7HycrO/KA7Db8ug2+NdAMIJkkGhlTgrDSqXqRCuCGN9Aeb/eXOLJmb1RS
 BlCw==
X-Gm-Message-State: AOJu0Yxmsend+AcVh1RaxYCzuCvT7h6i80XPvr79O0DkkhFkMla38G10
 6R5VyrI9Euyc6czNV/zzQgnGwjMtgCmF+JGP1RG9t/ImDKScEwDoorgwu8du2cabeW4X0BBoT60
 yD7Ao
X-Gm-Gg: Acq92OHz+E6NIC73AQDb4ZD1oYBGHqn1ZDH5vFz5h1F/+JQ4thXGUNHDNuzH2JxqOFv
 lxfivOLrNzOTQBohAHgxKt2r7EWtxTBvPh0ipRa3A3ss6n4XrdnSb3iN0KL77Dx/YPc77EIp2nK
 656akeSjGlZTPjmvUlueCPSFSNZ7zjCDI74zh87MpyPqtClR1O0dmFqF9ESvauh7euaVGSkGHN6
 Rxz7l62OrQlZVc3zDmyQPIyIT5rmHD2/byomzW6KGkUFYFofYSjq9jZ0BZjrWHVhae51zYgtg2z
 WtYR9qzBnnUBT/DRD28HqPhugNFcKvdc4sCx6TFlnbdA44UoPAUK8yLSXVSNy2ot2KtmjDnG0zb
 EaV2jzc/EvK9ELTqejAZuJ51SFGdddbEeFyXTHfyEHIZJnSEiBBHiLdthif0HUjOGjBonhcRaDI
 zuFIDsFgpmp8+eChcIGmmkmSttSN8OcxDvbOV+ZJabOpP136uOn0JtuN+w14+Nai+a0DQFDNTt
X-Received: by 2002:a05:7300:5792:b0:2ed:e14:e954 with SMTP id
 5a478bee46e88-304490e00ddmr123107eec.30.1779386841505; 
 Thu, 21 May 2026 11:07:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304435c10desm1034069eec.27.2026.05.21.11.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 11:07:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [RFC v2 11/11] crypto/ccp: replace use of rte_atomic64 with stdatomic
Date: Thu, 21 May 2026 11:04:23 -0700
Message-ID: <20260521180706.678377-12-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521180706.678377-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260521180706.678377-1-stephen@networkplumber.org>
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
index cd63830759..0d343c2426 100644
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
+	RTE_ATOMIC(uint64_t) free_slots;
 	/**< available free slots updated from enq/deq calls */
 
 	/* Queue identifier */
-- 
2.53.0

