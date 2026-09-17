Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF01C982D0
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C01E343274;
	Thu, 17 Sep 2026 22:11:42 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id A869B43252
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:37 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2dd77300816so58675ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675897;
 x=1790280697; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EfNwzqQ54yjLtPHAuV3VrqTEhZNx6XBsApLdrgfWeJM=;
 b=VEOAaffi4KMbQW3JJTrqOp1MMCd22rkPWhTSlMilP6KlTQQeBhA2TX6rUGRaRoUgRa
 mrW7SywVAqIUnHoAkqXnnTA7xv7dQ6MwdapsxUYnwqdnBZwfipon/nYNQonhhj6yWkum
 ipP0uWlxPUNYGj1vWGKANq8OfT++mXQKgG9LOpafKz/IlgMqxVMXR/pFlITQRfSFWmio
 2HUlp6MSQZFQVU2lehsm/UcnPPR2vy98UB0oBu/fUhs/4qXrCEBpF8PdSJpKa6RaFTbM
 GtSxkcx5TThmXSGYTlXH1VFhJ0c7potWRNo77lKkF+lCZUWE/pqLG5uCSdka8s1C3C3o
 xzNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675897; x=1790280697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EfNwzqQ54yjLtPHAuV3VrqTEhZNx6XBsApLdrgfWeJM=;
 b=HKtvusinnzk4eTrtZBPV30TI5NW7bJ6VBbzLb4ohLI1hoQLx9NIQYaMIDh9i70AvAr
 ef3RNZJcCujLgjWGqt1RfLTWkiXUwRIQUHKFL8lf2Y7wML4W7CgnanMFckLAJkaGYxAm
 ohT9yo9kRlccy64CTCm9PsWbDgfqft11b5M5SRfWFOge01ztjeiK87KfIFI9PpWiNbXc
 qvrnEJEPl6bgPWaNPd8XW5le71azpuRZH0FZGY3xeDLGkhDQzacm5T/je50a4QTFJqMR
 w/Sdy8Suwmt4Vkya2ufRSiH8E0OQigXyl9PhNYP4LNIFBsx3xbxcNgbBmcyEQBRPy7Ag
 p/CQ==
X-Gm-Message-State: AFuF++nKrghEmr6R4BpxD+rVQYSGO3+Qy8brUw2p4i4FUqhmyyJ3LseW
 jybdGOqrHxwagFiuBqLf1HhgjA52OOlvj3nNn/El9TU67WEi+1RcurSKFL25F6r8TvF0bF8KDxY
 yoeFd
X-Gm-Gg: AYBFou1ytBWAVnnO055BkDik4nFpc2y6Z+oKRepjg7HepqqCEE545bp+VROs/GKZfCi
 8PM32/vv54frJBjmMJiG6TC49YqPXVp7zStvtL3x9UO3+6JYdm90tyX2vbQn/I+PXxoALgYljbC
 1DXMjjkXQiLI7eTdCo6vMsn0ZdahBNPp+WiJ4MsqGkX6Psq/VbG9oYwUTZYcVpkcy3Uq4YBR9XW
 bG80wjPllVtIw8UX4tiCuqqtK1Sn11IQ1Ra69raCEtYDmmJJhRdvQToJzAN7DyifT2IqCkdiUVU
 hlvX0obyLyIX7KRTNe7Tgyqsw9gW6W7TQ+kHbzNt8+gg/mV+vPpUvntw4zZZFptGz8RoR3ZdTj4
 UTlyqoLJANuRPKvWn3r/5cmocKrqzO0HXUFgqC9Sy7/BFcBHoVk+q6Td+hChCYB7NWkLmmejKDp
 kAKocWG1KvIM93jetllyFTdBX3mqvs0k39e6cAWvLQEHYofHWNr2cwFKiSRUXtaCBlfWa9pkRuW
 yU4ycDI3WE4Wjb3rvy4T56xSPODe1aN+1itJQ==
X-Received: by 2002:a17:902:fc4e:b0:2d8:d4cf:fe47 with SMTP id
 d9443c01a7336-2ddb21c0e64mr2276055ad.13.1789675896787; 
 Thu, 17 Sep 2026 13:11:36 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:36 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v8 16/25] bus/vmbus: convert from rte_atomic to stdatomic
Date: Thu, 17 Sep 2026 13:10:20 -0700
Message-ID: <20260917201119.2168234-17-stephen@networkplumber.org>
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

