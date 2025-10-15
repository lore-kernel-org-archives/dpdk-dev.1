Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE649CCD18E
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:07:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7ACB40653;
	Wed, 15 Oct 2025 09:07:28 +0200 (CEST)
Received: from pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com [44.246.77.92])
 by mails.dpdk.org (Postfix) with ESMTP id 48A0C40647
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:07:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512045; x=1792048045;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=q5ihB1Pke+C1eczzr7PyxPGcQbCdaeEBXdeghxix0mU=;
 b=V2MnXok3cVpez3ZhWrr6F/96uMb0R8j+p5QDHth2lMDxhjBZigRZsBQV
 iFoVaC3r29+JQS8JAc4kjUHyjiml8Ngm1gnZC+QRfnz8iIq7eNiIyac3P
 MuNz9YLs28hmcWn5+P2DD9OZiGR8uAAk97Z3TAQs7VdeR2z5lfRMQJx3G
 PcYa07PQ+VDvxuFk63ZQ9E25cSfo3uVjVlVWuaC5G44FFjpOa0Pzfq2RN
 TDrmiYruLueouqeAUaSfuHp8p+IXDST+xPDym6Ya1nR9JrmHIU8WQvQuu
 i6TsyMlBoMmlKYxJ4VOVpCBHfNaA6W9uy1PCqhYo3UOpEkFmET5THOJMs A==;
X-CSE-ConnectionGUID: 26xjA8zxQiaClaPk8xkldg==
X-CSE-MsgGUID: wfCj6EtwQMmBusOHcM042Q==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4915028"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
 by internal-pdx-out-004.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:07:24 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:21586]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.112:2525]
 with esmtp (Farcaster)
 id da5b1004-67cd-4873-9e78-3be07149d1ba; Wed, 15 Oct 2025 07:07:24 +0000 (UTC)
X-Farcaster-Flow-ID: da5b1004-67cd-4873-9e78-3be07149d1ba
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:07:24 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:07:23 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 02/21] net/ena/base: rework admin timeout handling
Date: Wed, 15 Oct 2025 10:06:48 +0300
Message-ID: <20251015070707.340-3-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251015070707.340-1-shaibran@amazon.com>
References: <20251015070707.340-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

The admin queue (AQ) consists of a submission queue (SQ)
and a completion queue (CQ), sharing a command context
object per request.
Each command is identified by a unique ID, used by both the
driver and the device to track completion status.

In polling mode, the submitting thread polls the CQ until the
command completes or times out.
In interrupt mode, the thread sleeps until an IRQ signals
completion or timeout occurs.

If a timeout happens in interrupt mode, the thread begins
polling the CQ itself which might lead to:
- stale or NULL pointer access if resources are freed prematurely
- corrupted queue head counters due to concurrent updates

This patch introduces a manual spin lock using atomics to serialize
access to shared resources.
The lock avoids blocking in interrupt context and ensures safe command
completion handling.

The patch also defers updating the command status until completion
processing is done, preventing premature access to partially updated data.

The atomic operation were reworked as the DPDK has deprecated the legacy
rte_atomic32_xxx apis in favor of c11-compliant atomic operations.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.c       | 74 ++++++++++++++++++----------
 drivers/net/ena/base/ena_com.h       |  1 +
 drivers/net/ena/base/ena_plat_dpdk.h | 22 +++++++--
 3 files changed, 67 insertions(+), 30 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.c b/drivers/net/ena/base/ena_com.c
index 1a93d22b71..75145a0b3f 100644
--- a/drivers/net/ena/base/ena_com.c
+++ b/drivers/net/ena/base/ena_com.c
@@ -474,26 +474,38 @@ static void ena_com_handle_single_admin_completion(struct ena_com_admin_queue *a
 		return;
 	}
 
-	if (!comp_ctx->occupied)
-		return;
+	if (comp_ctx->user_cqe)
+		memcpy(comp_ctx->user_cqe, (void *)cqe, comp_ctx->comp_size);
 
-	comp_ctx->status = ENA_CMD_COMPLETED;
 	comp_ctx->comp_status = cqe->acq_common_descriptor.status;
 
-	if (comp_ctx->user_cqe)
-		memcpy(comp_ctx->user_cqe, (void *)cqe, comp_ctx->comp_size);
+	/* Make sure that the response is filled in before reporting completion */
+	smp_wmb();
+	comp_ctx->status = ENA_CMD_COMPLETED;
+	/* Ensure status is written before waking waiting thread */
+	smp_wmb();
 
 	if (!admin_queue->polling)
 		ENA_WAIT_EVENT_SIGNAL(comp_ctx->wait_event);
 }
 
-static void ena_com_handle_admin_completion(struct ena_com_admin_queue *admin_queue)
+static void ena_com_handle_admin_completion(struct ena_com_admin_queue *admin_queue,
+					    bool busy_poll_ownership)
 {
 	struct ena_admin_acq_entry *cqe = NULL;
 	u16 comp_num = 0;
 	u16 head_masked;
 	u8 phase;
 
+	/* Only try to acquire ownership once if busy_poll_ownership is false. This
+	 * is to prevent two threads fighting over ownership concurrently. The boolean
+	 * allows to distinguish the thread with the higher priority
+	 */
+	while (!ATOMIC32_CMP_EXCHANGE(&admin_queue->polling_for_completions, 0, 1)) {
+		if (!busy_poll_ownership)
+			return;
+	}
+
 	head_masked = admin_queue->cq.head & (admin_queue->q_depth - 1);
 	phase = admin_queue->cq.phase;
 
@@ -522,6 +534,8 @@ static void ena_com_handle_admin_completion(struct ena_com_admin_queue *admin_qu
 	admin_queue->cq.phase = phase;
 	admin_queue->sq.head += comp_num;
 	admin_queue->stats.completed_cmd += comp_num;
+
+	ATOMIC32_SET_RELEASE(&admin_queue->polling_for_completions, 0);
 }
 
 static int ena_com_comp_status_to_errno(struct ena_com_admin_queue *admin_queue,
@@ -570,7 +584,7 @@ static int ena_com_wait_and_process_admin_cq_polling(struct ena_comp_ctx *comp_c
 
 	while (1) {
 		ENA_SPINLOCK_LOCK(admin_queue->q_lock, flags);
-		ena_com_handle_admin_completion(admin_queue);
+		ena_com_handle_admin_completion(admin_queue, true);
 		ENA_SPINLOCK_UNLOCK(admin_queue->q_lock, flags);
 
 		if (comp_ctx->status != ENA_CMD_SUBMITTED)
@@ -793,32 +807,33 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
 	 */
 	if (unlikely(comp_ctx->status == ENA_CMD_SUBMITTED)) {
 		ENA_SPINLOCK_LOCK(admin_queue->q_lock, flags);
-		ena_com_handle_admin_completion(admin_queue);
+		ena_com_handle_admin_completion(admin_queue, true);
 		admin_queue->stats.no_completion++;
 		ENA_SPINLOCK_UNLOCK(admin_queue->q_lock, flags);
 
-		if (comp_ctx->status == ENA_CMD_COMPLETED) {
-			admin_queue->is_missing_admin_interrupt = true;
-			ena_trc_err(admin_queue->ena_dev,
-				    "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d), autopolling mode is %s\n",
-				    comp_ctx->cmd_opcode, admin_queue->auto_polling ? "ON" : "OFF");
-			/* Check if fallback to polling is enabled */
-			if (admin_queue->auto_polling)
-				admin_queue->polling = true;
-		} else {
+		ret = ENA_COM_TIMER_EXPIRED;
+		/* Now that the admin queue has been polled, check whether the
+		 * request was fulfilled by the device
+		 */
+		if (comp_ctx->status != ENA_CMD_COMPLETED) {
 			ena_trc_err(admin_queue->ena_dev,
 				    "The ena device didn't send a completion for the admin cmd %d status %d\n",
 				    comp_ctx->cmd_opcode, comp_ctx->status);
+			goto close_aq;
 		}
-		/* Check if shifted to polling mode.
-		 * This will happen if there is a completion without an interrupt
-		 * and autopolling mode is enabled. Continuing normal execution in such case
+
+		admin_queue->is_missing_admin_interrupt = true;
+
+		ena_trc_err(admin_queue->ena_dev,
+			    "The ena device sent a completion but the driver didn't receive a MSI-X interrupt (cmd %d), autopolling mode is %s\n",
+			    comp_ctx->cmd_opcode, admin_queue->auto_polling ? "ON" : "OFF");
+		/* If fallback to polling is not enabled, missing an interrupt
+		 * is considered an error
 		 */
-		if (!admin_queue->polling) {
-			admin_queue->running_state = false;
-			ret = ENA_COM_TIMER_EXPIRED;
-			goto err;
-		}
+		if (!admin_queue->auto_polling)
+			goto close_aq;
+
+		ena_com_set_admin_polling_mode(admin_queue->ena_dev, true);
 	} else if (unlikely(comp_ctx->status == ENA_CMD_ABORTED)) {
 		ena_trc_err(admin_queue->ena_dev, "Command was aborted\n");
 		ENA_SPINLOCK_LOCK(admin_queue->q_lock, flags);
@@ -829,8 +844,14 @@ static int ena_com_wait_and_process_admin_cq_interrupts(struct ena_comp_ctx *com
 	}
 
 	ret = ena_com_comp_status_to_errno(admin_queue, comp_ctx->comp_status);
+	comp_ctxt_release(admin_queue, comp_ctx);
+
+	return ret;
+close_aq:
+	admin_queue->running_state = false;
 err:
 	comp_ctxt_release(admin_queue, comp_ctx);
+
 	return ret;
 }
 
@@ -2107,6 +2128,7 @@ int ena_com_admin_init(struct ena_com_dev *ena_dev,
 	admin_queue->curr_cmd_id = 0;
 
 	ATOMIC32_SET(&admin_queue->outstanding_cmds, 0);
+	ATOMIC32_SET(&admin_queue->polling_for_completions, 0);
 
 	ENA_SPINLOCK_INIT(admin_queue->q_lock);
 
@@ -2394,7 +2416,7 @@ int ena_com_get_dev_attr_feat(struct ena_com_dev *ena_dev,
 
 void ena_com_admin_q_comp_intr_handler(struct ena_com_dev *ena_dev)
 {
-	ena_com_handle_admin_completion(&ena_dev->admin_queue);
+	ena_com_handle_admin_completion(&ena_dev->admin_queue, false);
 }
 
 /* ena_handle_specific_aenq_event:
diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index 1c752327dc..6b9a780755 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -226,6 +226,7 @@ struct ena_com_admin_queue {
 
 	/* Indicate if the admin queue should poll for completion */
 	bool polling;
+	ena_atomic32_t polling_for_completions;
 
 	/* Define if fallback to polling mode should occur */
 	bool auto_polling;
diff --git a/drivers/net/ena/base/ena_plat_dpdk.h b/drivers/net/ena/base/ena_plat_dpdk.h
index 3b574f888a..18c6837566 100644
--- a/drivers/net/ena/base/ena_plat_dpdk.h
+++ b/drivers/net/ena/base/ena_plat_dpdk.h
@@ -74,6 +74,10 @@ typedef uint64_t dma_addr_t;
 #define mmiowb rte_io_wmb
 #define __iomem
 
+#define smp_wmb rte_smp_wmb
+#define smp_rmb rte_smp_rmb
+#define smp_mb rte_smp_mb
+
 #ifndef READ_ONCE
 #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
 #endif
@@ -267,10 +271,20 @@ ena_mem_alloc_coherent(struct rte_eth_dev_data *data, size_t size,
 #define ENA_REG_READ32(bus, reg)					       \
 	__extension__ ({ (void)(bus); rte_read32_relaxed((reg)); })
 
-#define ATOMIC32_INC(i32_ptr) rte_atomic32_inc(i32_ptr)
-#define ATOMIC32_DEC(i32_ptr) rte_atomic32_dec(i32_ptr)
-#define ATOMIC32_SET(i32_ptr, val) rte_atomic32_set(i32_ptr, val)
-#define ATOMIC32_READ(i32_ptr) rte_atomic32_read(i32_ptr)
+#define ATOMIC32_INC(i32_ptr)									\
+	rte_atomic_fetch_add_explicit(&(i32_ptr)->cnt, 1, rte_memory_order_seq_cst)
+#define ATOMIC32_DEC(i32_ptr)									\
+	rte_atomic_fetch_sub_explicit(&(i32_ptr)->cnt, 1, rte_memory_order_seq_cst)
+#define ATOMIC32_SET(i32_ptr, val)								\
+	rte_atomic_store_explicit(&(i32_ptr)->cnt, val, rte_memory_order_seq_cst)
+#define ATOMIC32_SET_RELEASE(i32_ptr, val)							\
+	do {											\
+		rte_atomic_thread_fence(rte_memory_order_release);				\
+		rte_atomic_store_explicit(&(i32_ptr)->cnt, val, rte_memory_order_seq_cst);	\
+	} while (0)
+#define ATOMIC32_READ(i32_ptr) rte_atomic_load_explicit(&(i32_ptr)->cnt, rte_memory_order_seq_cst)
+#define ATOMIC32_CMP_EXCHANGE(I32_PTR, OLD, NEW) \
+	rte_atomic32_cmpset((volatile uint32_t *)(I32_PTR), OLD, NEW)
 
 #define msleep(x) rte_delay_us(x * 1000)
 #define udelay(x) rte_delay_us(x)
-- 
2.17.1

