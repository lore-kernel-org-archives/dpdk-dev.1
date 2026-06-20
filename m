Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00BECD98F8
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:32:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B17C140DD5;
	Sat, 20 Jun 2026 04:32:01 +0200 (CEST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id 99B9A40656
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:58 +0200 (CEST)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-7dfceeaf168so36861347b3.0
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922718;
 x=1782527518; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/8ILKIfa50s/hXUVLxI2Yl04nBtHJF7dGyoXMJnXOk=;
 b=n/VxBaFSm6ToCC3IFh47N71A+CWNg33wt5RfDI7OyUYQRx9+KGYq5BBl3GA5vHtEwc
 ZxHcJMD/ECKyLzYZh2beQkV16XPV3Lc7CjZw/m0LUvViUE7BuQZqgT2oxd7yTIevP58s
 1yYPvyyFs1T/CjmUCnN6cpH9J0yCBAIIO4mrCktmhW5F+DELNc6LuWIMl64fCe3zTHPU
 rFLlMCNNBobDOM5OMxQ5OWBRPa3Rj6qklD/8ALqEh2MAagjb3QUZdd/BnDgVGcPxNDVJ
 CfP05S0UaKO+BGufzjMPvoAPIbQkWefVyJDsC852cKr4pAEDRMc5rvWEvwJaRyuHoDmA
 1jAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922718; x=1782527518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k/8ILKIfa50s/hXUVLxI2Yl04nBtHJF7dGyoXMJnXOk=;
 b=Zk0xI511SzY3NkBX00jHheWv/MqFAXW4PGoeQy9wnY4fJp2+srLFfB4B5ZBfcxDuog
 TaVwB3VUpE1JL+FI3lvBLJxoDOYt8ZTCOGgyuF4xE85Z5m4nZzCmWlJPtO8wJ+cKW+Hc
 PlmjfXNmmDUI0Y6I3h+tU6pnzoB87Dgbzi44OskFa7LNPPL9R5TUhT/jS2d/7LOkDSQV
 NCazIGENoXkOWGW3dIgvxp6yMk5rL8cbUlRcZH84grbGF5Uz+trZplwomE7jvNGqmIxW
 wq8OdfKERtwuD3qQStgSmNG+mOJGF91J//NTJh37dLISG7BO3ZtYAEH7sUZlBXC0ZMxS
 TEFg==
X-Gm-Message-State: AOJu0YweSDEX7MvrX1bji48WsI9KIA0tJwHFZUa+EjnXUJ7ysC2dzTjB
 qnYrTab+zzMHi0NfMvi98s8dpZFoM0XqUGfyUo/Bv+Vw0z7PNPsh9GIWYq/l/beUCF/ffUBjwiC
 aSqsu
X-Gm-Gg: AfdE7cncTsXdJcXKa1AZDrsKTMjQP/KvJIM+NuActYbzSX8WC+fqWbUjdeB5kseh547
 yBPsjSM3jAgV/SfdXRwaiT9fZDMxYtozsEgNTE9xFIB/VVVULVD9Xjkz6RNOEooJDoegnOjenbF
 fxNTIocmBVgUrq8Au1k/CvYxzKgMYyKCvCIsegoDlVL6MS9GAHLnHbjV1cDmndql0sLTCXHqJNK
 r/jWbgNYwddeAEPNeDyAFoBJKLfbZCYOz3Io6QHCZHII6o8yLL22cX0S67jgzKPcx6J1/PIXxCC
 MZXIjP/9yE2tXmnWbh7eCdA6cX2Z6O1lMpKcRu+0Ll6qym4GxbGEo5AGR5UmuIWoALDU6k0ehsI
 qLiZeV/i+68R3KHu7i14H5vFG5e40N+R1zzXgEDk3J+dUog8T6M39Z8FJ8/Epa4JL/sLa/62vPM
 IOZ+p9RDCZxqdSKcXm4NPj5yidluUePkdsQUMO8y6MNiQalbZOyPs=
X-Received: by 2002:a05:690c:dd0:b0:7fd:d4c0:394b with SMTP id
 00721157ae682-8017817ab97mr49580307b3.37.1781922717842; 
 Fri, 19 Jun 2026 19:31:57 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:57 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v5 14/24] bus/vmbus: convert from rte_atomic to stdatomic
Date: Fri, 19 Jun 2026 19:28:39 -0700
Message-ID: <20260620023134.42877-15-stephen@networkplumber.org>
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

Replace deprecated rte_atomic32 operations in the vmbus ring buffer
producer with stdatomic equivalents, and replace the smp_wmb + CAS-spin
publish with rte_wait_until_equal_32 + release-store.

The two-cursor design is preserved: tbr->windex is the driver-private
reservation cursor that lets producers reserve slots concurrently
without a lock; vbr->windex is the host-visible commit cursor, updated
in reservation order so the host never observes windex pointing past
unwritten data. This is the lockless analogue of the spinlock-around-
single-cursor pattern used by the Linux (drivers/hv/ring_buffer.c
hv_ringbuffer_write) and FreeBSD (sys/dev/hyperv/vmbus/vmbus_br.c
vmbus_txbr_write) implementations of the same host contract.

The memory ordering mirrors __rte_ring_headtail_move_head and
__rte_ring_update_tail in lib/ring/rte_ring_c11_pvt.h: relaxed wait
for the previous producer's commit, release-store to publish. The
rte_smp_wmb before the publish is folded into the release ordering
on the store itself.

The host-shared vbr->windex remains volatile uint32_t in the packed
bufring struct; the atomic qualifier is added via cast at the access
site. The (uintptr_t) launder on the store-side cast suppresses a
spurious misaligned-atomic warning from the packed-struct attribute
(windex is 4-byte aligned in practice, at offset 0 of a page-aligned
struct).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/bus/vmbus/private.h       |  2 +-
 drivers/bus/vmbus/vmbus_bufring.c | 39 +++++++++++++++++--------------
 2 files changed, 23 insertions(+), 18 deletions(-)

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
index fcb97287dc..624fe8b6c5 100644
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
@@ -114,6 +114,7 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
 	uint32_t ring_size = tbr->dsize;
 	uint32_t old_windex, next_windex, windex, total;
 	uint64_t save_windex;
+	bool success;
 	int i;
 
 	total = 0;
@@ -121,17 +122,13 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
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
@@ -139,8 +136,13 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
 
 		next_windex = vmbus_br_idxinc(old_windex, total, ring_size);
 
-		/* Atomic update of next write_index for other threads */
-	} while (!rte_atomic32_cmpset(&tbr->windex, old_windex, next_windex));
+		/* Atomic update of next write_index for other threads
+		 * Can use weak since easy to recompute and retry.
+		 */
+		success = rte_atomic_compare_exchange_weak_explicit(
+				&tbr->windex, &old_windex, next_windex,
+				rte_memory_order_acquire, rte_memory_order_relaxed);
+	} while (unlikely(!success));
 
 	/* Space from old..new is now reserved */
 	windex = old_windex;
@@ -157,12 +159,15 @@ vmbus_txbr_write(struct vmbus_br *tbr, const struct iovec iov[], int iovlen,
 	/* The region reserved should match region used */
 	RTE_ASSERT(windex == next_windex);
 
-	/* Ensure that data is available before updating host index */
-	rte_smp_wmb();
+	/* Wait for previous producer to publish their windex update */
+	rte_wait_until_equal_32(&vbr->windex, old_windex, rte_memory_order_relaxed);
 
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
-- 
2.53.0

