Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C83C55ABA
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Aug 2026 03:27:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0715640A8B;
	Thu,  6 Aug 2026 05:26:07 +0200 (CEST)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by mails.dpdk.org (Postfix) with ESMTP id CBAAE40A6F
 for <dev@dpdk.org>; Thu,  6 Aug 2026 05:26:03 +0200 (CEST)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2caea3f742bso25113325ad.0
 for <dev@dpdk.org>; Wed, 05 Aug 2026 20:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785986763;
 x=1786591563; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k/8ILKIfa50s/hXUVLxI2Yl04nBtHJF7dGyoXMJnXOk=;
 b=KHLw3mDegXTBtZlENxfYzm/1BWL/0qudDTrPP0SBAhzLMVS6ZZR1uh6hc7tVFcCGws
 YlCW7MoZmu8IslsxDACxk9cZjEiJBzMLWe1mjnLAPkRVVc0DthkzffiGFEcJM5TWSgc8
 5V86bLnMqqb6Sviw27yAkyyYm6tNvdpn4FdzcHzto5SggC1ICO+LoL/WKiEp1caFmvQ+
 yzp2NG4ufelAXlePLDzm9673u7QAUay8LrIQ6CrvmntEJBnMzToOuhtvpLE8vdF38lmf
 tKv1M+2Fa6saV6R/HT1i0hMENzg5pfnRUkIVKgnOp+zHfK4AouZcfUMCIqraVwvnO9Ol
 LFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785986763; x=1786591563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k/8ILKIfa50s/hXUVLxI2Yl04nBtHJF7dGyoXMJnXOk=;
 b=CEx8+4Cxo7s6RBN+waPg9dpghIju5ljmAoKL8mEGlBw41AqEofUKb0293xxlSczDLh
 rkcpHHbIiCJgZthpM8h374Ao7zzt4iCHUAMJNOY9LYkLK3J8AumiHcmf84r6i9hQtHYr
 OYdosdQKrcSDHEMRm88UI2wJR/ZEyaJ1riAWZll13rwR1FF105sMbqwvA7oZSUmJJRPS
 VG+5rmbNdvXHCrmH+ao8NIavdThA2tH34B7xXCo0AIDqVYYyzniISVuivsDd+iNkAirZ
 293M9S8yBByaWhg6TU1TJV0XHnSIi/aOv+7J3ATl+jNve1wfrGmcZNugZ8i6n09hdo02
 MijA==
X-Gm-Message-State: AOJu0YzL9xEP0Hiz+fRK9HcCUdy8eA4icJaSqy8VLKqUayuWni98fyfF
 piXejC1oZHc7q98BV9/Su7pH3Zkn/NjFfSw5kAdnktyfr3ZlOIJKkf1D72DOKlkjuCm2KjJRKle
 ex/9Pj6Q=
X-Gm-Gg: AR+sD12cEnaHxOu3MJKdA4l+7vJb188D9z9jllvVLNk2qkOKlHJtyfnjIZJ0tlzcNHI
 uZ7vGoh1oAlYeqXJooYOb0eyzNvrsZpZ8qdMyPHKbAD5I6YQa5YUHXqgnbSnljzBWm6rD5hWFom
 ZwDNvXTL/j0u0C0Y1CM5EcKmgmrP3iFmPDTtOYw2OW+Qfi3y8bEWP/A/EShC+cWChkMkK6qaPFH
 UOtEDtF9+9Th1rgI+rYSEr9cszQEXPphuKdbQrZIJ5ONb0XnoeOBF5R+f+4qoDWtvtncjkE4yS0
 2joWqbCS0X3cnYOClGyVizT0gfAKsvOdbxbNGZKa7ADLi0TnOohBxa1pG9tTOq6RHUv7bIVFlKU
 EVwZMVRyae5qInPaiagTLk65pYNRwuQJhzhmsWKuonVcHFK6kVaPTeJsRtucUbko2MItWvfKOy0
 T6OjMkB+UVoSQxCFESE6R5jnKaGSjer74IRfuIg9TmukkP4Gfn4Mo4BQzC3jeEYnBImR+DjORVg
 HwCzCe0cVSRiiXKxcHtSkZwxdrJ
X-Received: by 2002:a17:902:f605:b0:2c6:9f66:d573 with SMTP id
 d9443c01a7336-2d0ca71b3f0mr147630685ad.2.1785986762901; 
 Wed, 05 Aug 2026 20:26:02 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm23301631eec.6.2026.08.05.20.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 20:26:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v7 14/24] bus/vmbus: convert from rte_atomic to stdatomic
Date: Wed,  5 Aug 2026 20:23:06 -0700
Message-ID: <20260806032544.21337-15-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260806032544.21337-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260806032544.21337-1-stephen@networkplumber.org>
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

