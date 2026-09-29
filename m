Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C28DCA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:06:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FCEC42E80;
	Tue, 29 Sep 2026 16:04:41 +0200 (CEST)
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43]) by mails.dpdk.org (Postfix) with ESMTP id 6D0A742E5A
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:29 +0200 (CEST)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469e25400so1667196b3a.0
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690668;
 x=1791295468; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EfNwzqQ54yjLtPHAuV3VrqTEhZNx6XBsApLdrgfWeJM=;
 b=kJBcg9QKq/2e3pQ/0Zyoan83biZOjiDPDMsz1TxWtrwOGkI/xkVOP+dFW82Nj2sO1b
 Gqs1aik7DXHBtWiXxz6VbmecyR7NVxp0TpxgWxmWJSNwmbOOhNG/ESnovyTS/PtqjVl1
 a9i2opZIWmHH7xoLS5oTZDu3bQ+F95hYOjL9JB2kF7Le8sgR3fvvOPUZRaPqCCRWZtT/
 Ed/rzP2B6ZQsyr1GsP08YWxbHwpS/77O1xRSsbn65XHaZQgv2upICC+D1RWiT2WY4g4i
 Mgpm4oLDl3loxPYLZdB8ITwIuzkgRiv1/deZyCQ2KgIhxhOXTpvpVmjWsMy67buId5p0
 nGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690668; x=1791295468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EfNwzqQ54yjLtPHAuV3VrqTEhZNx6XBsApLdrgfWeJM=;
 b=u+3O75blNlIx6X3C8viXoYUoqCnoshgyhwr4kC6ULwh3X4f49ZsQuOr8f+dNGkZYgG
 opo/qLKYzi2ydA68uFnMoTHuA2Jx/dzBRpMXghbzreh7iW2w+XeIgU/UUz5hEnTJasWZ
 flopP5AiWyTDx8rJtqcAViher80Ab0uHTC6gIhGiejgXV2S35oCGSktbaxOo6YM7IUQj
 +S5bCsjrRzas1+BXIPFURWC2yo36RQOm8gYw3uXDlq8UMgSY5ko/HEx159MRgwQQjTA2
 rn5pLsc/LpBuGZ+oylMeaIWux1KMovx7dJzeHfyJwQzfDdv16PHHvesILGijeBtwR7w/
 eV7g==
X-Gm-Message-State: AFuF++kQ815n9Kr9wZMJNBO3YG2RNpMp+6oCKjx3bUW+Nohn7ggOBOPk
 Wnw0Gv/CshjBps6WelpufrM0g/IGUdUGNIfjm6siz+RVovTKIfSosUI2UJPZtqcBWwOnKuV2MuV
 IB4opexQ=
X-Gm-Gg: AYBFou29c/KJ9VlfBOskp3M3M+WwSif9zQs/Ae5fbb877/S46SunRIONVvkpie7SwSq
 ADx9AKV+XI9BDxaNZhdHP7wOiaHORblZro/mlBsa59ucOZHoUy6CX/LCmAjKgZA0EqpqjWns+oy
 oRAG4BpYN22QOY23/EOIDXx+qmadkcWnO1BHNYQoQ6CptccQLUen1n2hracB/+rTHcDSkarBUC2
 rjy5WcxYAXuXSRdHKCpMnhhklflOaSKOvcKRVQ49cyc149SPQCDF03bjVMXofr9MZ9zurkkG144
 IR9Rhj1O2UIHT42RhZhAnBmgggXs4WzBXZpjP8+nZ+hFFwGm7MyzYQCglbynfwBFA5yW+vtUCQ1
 n1A8cgsb+jrz+oh+nP0K8OJJfGVmHZTtFXLQmRG5uGM5SYTEd/dPKz2qrfT91MaWozOOayywnLo
 9CNHqYVImfRqbq/CtJrhALciVoqdECHRm5gGMPewy3aZxSZgp7XZU2GBlwhkGHRfiIfa4jBueEg
 VtEjsykSTR1jk9QTV/KLRzkCsqkI7l2a9EXOOCCIfSLhxRd
X-Received: by 2002:a05:6a00:4099:b0:878:6ee:672b with SMTP id
 d2e1a72fcca58-87e9b8970d2mr13034404b3a.35.1790690668501; 
 Tue, 29 Sep 2026 07:04:28 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:27 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v9 16/25] bus/vmbus: convert from rte_atomic to stdatomic
Date: Tue, 29 Sep 2026 07:02:02 -0700
Message-ID: <20260929140409.234453-17-stephen@networkplumber.org>
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

The tx ring producer uses two cursors:
- tbr->windex which is driver private. It lets producers reserve space
  concurrently without a lock
- vbr->windex is the host visible commit cursor and has to advance in
  reservation order so the host never sees it point past unwritten data.

Convert the reservation CAS on tbr->windex to a weak compare exchange,
and replace the smp_wmb plus CAS spin that published the commit with
rte_wait_until_equal_32 on the previous producer followed by a release
store. The release ordering on that store covers what the barrier did.

The wait on the previous producer uses acquire ordering, not relaxed.
A release store only carries the writes of the storing thread and
anything it has a happens-before edge to. Producers publish in
reservation order, so when this thread stores its own windex the host
may then consume the data of every earlier producer as well. The
acquire on the wait pairs with the earlier producer's release store,
putting that producer's data writes into this thread's happens-before
set so they are carried by this store too.

vbr->windex stays volatile uint32_t in the packed bufring struct.
The host is not a C11 thread.

The atomic qualifier is applied by cast at the single publishing store;
the (uintptr_t) launder there avoids a bogus misaligned atomic warning
from the packed attribute, since windex sits at offset 0 of a page
aligned struct.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/vmbus/private.h       |  2 +-
 drivers/bus/vmbus/vmbus_bufring.c | 40 +++++++++++++++++--------------
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index 6efac86b77..6b7782724f 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -25,7 +25,7 @@ extern int vmbus_logtype_bus;
 struct vmbus_br {
 	struct vmbus_bufring *vbr;
 	uint32_t	dsize;
-	uint32_t	windex; /* next available location */
+	RTE_ATOMIC(uint32_t) windex; /* next available location */
 };
 
 #define UIO_NAME_MAX 64
diff --git a/drivers/bus/vmbus/vmbus_bufring.c b/drivers/bus/vmbus/vmbus_bufring.c
index fcb97287dc..dcd66390a3 100644
--- a/drivers/bus/vmbus/vmbus_bufring.c
+++ b/drivers/bus/vmbus/vmbus_bufring.c
@@ -15,7 +15,7 @@
 #include <rte_tailq.h>
 #include <rte_log.h>
 #include <rte_malloc.h>
-#include <rte_atomic.h>
+#include <rte_stdatomic.h>
 #include <rte_memory.h>
 #include <rte_pause.h>
 #include <rte_bus_vmbus.h>
@@ -121,17 +121,13 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
 		total += iov[i].iov_len;
 	total += sizeof(save_windex);
 
+	/* Get current free location */
+	old_windex = rte_atomic_load_explicit(&tbr->windex,
+					      rte_memory_order_relaxed);
+
 	/* Reserve space in ring */
 	do {
-		uint32_t avail;
-
-		/* Get current free location */
-		old_windex = tbr->windex;
-
-		/* Prevent compiler reordering this with calculation */
-		rte_compiler_barrier();
-
-		avail = vmbus_br_availwrite(tbr, old_windex);
+		uint32_t avail = vmbus_br_availwrite(tbr, old_windex);
 
 		/* If not enough space in ring, then tell caller. */
 		if (avail <= total)
@@ -139,8 +135,12 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
 
 		next_windex = vmbus_br_idxinc(old_windex, total, ring_size);
 
-		/* Atomic update of next write_index for other threads */
-	} while (!rte_atomic32_cmpset(&tbr->windex, old_windex, next_windex));
+		/* Atomic update of next write_index for other threads
+		 * Can use weak since easy to recompute and retry.
+		 */
+	} while (!rte_atomic_compare_exchange_weak_explicit(
+			 &tbr->windex, &old_windex, next_windex,
+			 rte_memory_order_acquire, rte_memory_order_relaxed));
 
 	/* Space from old..new is now reserved */
 	windex = old_windex;
@@ -157,12 +157,15 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
 	/* The region reserved should match region used */
 	RTE_ASSERT(windex == next_windex);
 
-	/* Ensure that data is available before updating host index */
-	rte_smp_wmb();
+	/* Wait for previous producer to publish their windex update */
+	rte_wait_until_equal_32(&vbr->windex, old_windex, rte_memory_order_acquire);
 
-	/* Checkin for our reservation. wait for our turn to update host */
-	while (!rte_atomic32_cmpset(&vbr->windex, old_windex, next_windex))
-		rte_pause();
+	/* Publish our windex update; prior data writes ordered via release.
+	 * windex is 4-byte aligned in practice (struct is page-aligned, windex
+	 * at offset 0); cast launders the packed-struct alignment-1 attribute.
+	 */
+	rte_atomic_store_explicit((volatile __rte_atomic uint32_t *)(uintptr_t)&vbr->windex,
+				  next_windex, rte_memory_order_release);
 
 	/* If host had read all data before this, then need to signal */
 	*need_sig |= vmbus_txbr_need_signal(vbr, old_windex);
@@ -224,7 +227,8 @@ vmbus_rxbr_read(struct vmbus_br *rbr, void *data, size_t dlen, size_t skip)
 		return -EAGAIN;
 
 	/* Record where host was when we started read (for debug) */
-	rbr->windex = rbr->vbr->windex;
+	rte_atomic_store_explicit(&rbr->windex, rbr->vbr->windex,
+				  rte_memory_order_relaxed);
 
 	/*
 	 * Copy channel packet from RX bufring.
-- 
2.53.0

