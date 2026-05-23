Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DF3CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4103F40BA0;
	Sat, 23 May 2026 21:59:01 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 48A5C40667
 for <dev@dpdk.org>; Sat, 23 May 2026 21:58:55 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30246cfd41aso3138548eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566334;
 x=1780171134; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64hXulL9/StHbvtICSYy93il1Zt/TSw7ltUk9Ubbgc0=;
 b=TkLQCRjxxzlFeQf4qD7j58L90bsszYZy70AVpBAk3+U5yLRO1CsH/dVlP53HS0IJc1
 SPsY/iXgCWhd/uIw0KEovckW/9q274DnbDjFdk69eKaYmhJqMoFj1Fkmdootmv3I5+ud
 BLUCvClrH+s8p4ghhYxwuLzG6guMuaRasRR331hW4cJ+rEy0MQ8kkB0ButRl32TgziN2
 5gqGfBs1CCq5YAXPIwcofYtuOymvxCNSQQWexrOEpVYWjYYMXBtYSydnlwWkEXzUqi4V
 bjJX8X83dHCj18ZKUntuEZZR1HAGTQlQARVxKjIXf+9QknJBxIiMj55VFt0xTOD6IrjG
 Sllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566334; x=1780171134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=64hXulL9/StHbvtICSYy93il1Zt/TSw7ltUk9Ubbgc0=;
 b=jG79RhCmSzYcsmGyIFKwr3guIts7kutS5sPVewIpX5zm44m2D3zj659/W/hefr6j7K
 AkCvnXYUa6ZFZUzzoepvwNLYkLv/JR1Bmgr0bQppd5VrlhYcyeQeSdEF85loa5Rw+4uR
 GpXQ6koeypF10Z92w8FXJK4b0tidUcoypvRnlLHkJWidsUsiMzMduTzvD4gCX4CwOO3m
 i/6S6XVw4F2+EAi+skGBs6qTc/f2Drhd+FLoRsS8Ak0AI7vq1P1i41c6tRGoBlqhypuM
 fyTJfUnsijNFoRPawA0DvKLrJxgFVeuqFyTSuQjXh4uGHLqCdoDgdo6Q6hKMEl0eH0/0
 v3pQ==
X-Gm-Message-State: AOJu0YybQF5fP9fuUiHFCLvtRPlgQL4f0mJrhmsE8Gfb423ii3kzWey/
 53nsATRCKMgbXMJsbgIz16RYWyL9I8da0LCOOt//jiCuBw5uEOhk3lp6sy0rrFsxFcJjSDpy8kO
 QKtUl
X-Gm-Gg: Acq92OGc6X8iZcQKt3FaCiTZtOIx4dVmcQkU+q39M7F2GCTDNgxGSCH/qu/7bAsdEgQ
 lSwWRmYX6MfMUsuRnBh1Kl4JTZOifB1BDMz5sEjJ3s7v8COcRxHP013KoMZ3yQo6GyqK6WhGIZS
 hwFPvDsEex9aAbsw2K4bt2SdDtvnLhSZniRjPIH5VLin7JDUL+MYNGn9N8WfFpFjRw/zPt+x54n
 44FTtBTJ18GyYfmg4QcvByblLiqCMnHd9w7AsK6tH21WbsGvxjO00G3LcHY5ku0AgaDpTzv6cKj
 WXCIx6ck4rcd+gPKqTaf8PStxpppDxYWV2vh8Qr2pUfLU8ErOn5YkNdMmMQal2kvYhyWWsIGSCM
 bQNT5gqR4aButNONFhpbUTvuAWcTkpRpTSPH0myL8ZWt6g0m4aRI/s8ZloAGAawWxvWzz8HPOVT
 ElhQI//Q4WF/A5u2DbLta/UryI25gacF4I/YeX0/ZT+1TM9NvEvjdntqPnNePYkA==
X-Received: by 2002:a05:7300:72d0:b0:304:2176:a871 with SMTP id
 5a478bee46e88-30448d5e96fmr4801688eec.0.1779566334258; 
 Sat, 23 May 2026 12:58:54 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
Subject: [PATCH v3 12/27] crypto/ccp: replace use of rte_atomic64 with
 stdatomic
Date: Sat, 23 May 2026 12:56:26 -0700
Message-ID: <20260523195839.454952-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523195839.454952-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260523195839.454952-1-stephen@networkplumber.org>
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

