Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF2FCD5BB1
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 20:00:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 31A5240DDC;
	Sat, 23 May 2026 21:59:06 +0200 (CEST)
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170]) by mails.dpdk.org (Postfix) with ESMTP id 8DC0440B9C
 for <dev@dpdk.org>; Sat, 23 May 2026 21:59:00 +0200 (CEST)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-304545e6c7fso1893494eec.0
 for <dev@dpdk.org>; Sat, 23 May 2026 12:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566340;
 x=1780171140; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytQYTIOBfQm49WCEl9crr3zXsomhLW4LmR/UlxIUP0A=;
 b=P7v8GCKE/4qiMuTAziu50g8OUBwlokovGMJ+GvtMFtS5inI22PYjA5GaNl/OMCLvQz
 /u/qcrTz3urHbOVyjLrRj5lP+LKG8TJnhNSqogRiWfOl91mLdrOkmXS1nnB/VIXkK6Zq
 fUFs6XWV9KPcMoQacSxfBoam8WqHjcPtns6tSTrSoPaJKJqQ8Bem/ugoc8tffkJ78vBv
 lZ787BVuHcki3T6pRwNUAA2YFYEiJvmBZOHH3ZSK05UsU0hvx6kCN6L1yYXrKV4N9DPF
 fQHch1JDH7osGI9VAyWzwZm5fDSPHuvTqvkSV29SDPtn8Oc2Kq0Z1IROareEDDH5CHzE
 G/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566340; x=1780171140;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ytQYTIOBfQm49WCEl9crr3zXsomhLW4LmR/UlxIUP0A=;
 b=p/JF+6SD8574J5sDhZttMoetbqJBB6WxlfOIg8eVoYuMgLvjnYnBzH4HVicFSfh8uu
 xGQMPI5iU9dNXivRgIfyMwKgBV6wHyxwEsiTMnKk5TKnzyk7ij585u7ygD+NeeMr6DRF
 lPAGmme51Otb8HUWAtJYMQ3yCphb5X/fXm+kmQZLSS52zfe1+tXgvhSW60NDUdfDQikt
 dFbLdgKvAj3yfK7zNClSYU70okyQIVZgEDNEU2SDPT2AOJHLhDfAfEVyQgH8RdkpeX0C
 eoX0ga5Qc9Y0PhjmDPdTmiRzCZUhz8GqNxOdZqAM3FlMXF3B+hceKB7E4slrM4fdMAwi
 VgxQ==
X-Gm-Message-State: AOJu0YznTJ2jR/XHsI6FzhgHg1eXvhzG0o3mVwjWqDFUnLofFmw0g5Aj
 KIvM5O37t6A+1EHnK/la9zBVnZMGRP/1m49iQ215mFRpgk+e1uh/p20EEFvNFyJ0QLGHCfyjpZZ
 rKsir
X-Gm-Gg: Acq92OFPUsMtx3+TWr6Khi8vzpJ0Cu6QOMVEzwUcI2dBOdmUMnjMscdewn6xT7f/FpC
 QuIQAEw3/NPC6FYDQmGLVKvNxtU9JiFdkO/lEHU8TYSAa32aED3/vCqP/6exbqg8wPQiyqQ7dlf
 oA6Va2oTZIi0qam5zH+Xy3acM65nTfSnvdyP9TCxfT/u08l+IXXlJzKsCPRhT153xaLe+vyFYE1
 HKUWgP/Oe6uAfZyD/PDGqTrbtXIv304otrCS7U8Ht5DW4tH9B3dljsXRMa0+9y6U6TT+FVJUcVh
 mSYrEfcR3Pw55mZEjcx5RMHC7p+S92ZHIIUAvVUAqaLdcsBm1MDjUTW9frJOWcXCVyFgHAXakq1
 7ggLwZe6kjz25LjyWKHWkOKjsc4qjBUwLJ2nd1IvwFZwhSLMP9nbL/VVPt7/m2obwGD7DUwx5Oy
 bLoGQBiEMBk7PiDsx7GjE/l8vUpjtiWCJ27K47G2x6ala0YQQQR2ujeqe23+dy6w==
X-Received: by 2002:a05:7301:9bc6:b0:2f4:3a9c:819c with SMTP id
 5a478bee46e88-304490b7e55mr4478781eec.25.1779566339555; 
 Sat, 23 May 2026 12:58:59 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452255234sm4838428eec.20.2026.05.23.12.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:58:59 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 17/27] bus/vmbus: convert from rte_atomic to stdatomic
Date: Sat, 23 May 2026 12:56:31 -0700
Message-ID: <20260523195839.454952-18-stephen@networkplumber.org>
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
index 8ac6119ef2..42c4e81ac0 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -41,7 +41,7 @@ extern int vmbus_logtype_bus;
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

