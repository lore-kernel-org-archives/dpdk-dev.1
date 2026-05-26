Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74273CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:27:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C8D3640A7D;
	Wed, 27 May 2026 01:26:10 +0200 (CEST)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180]) by mails.dpdk.org (Postfix) with ESMTP id E23D1406A2
 for <dev@dpdk.org>; Wed, 27 May 2026 01:26:04 +0200 (CEST)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-3045c195251so4410900eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837964;
 x=1780442764; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytQYTIOBfQm49WCEl9crr3zXsomhLW4LmR/UlxIUP0A=;
 b=FdSHi7kxf3VwrB4bzs3VptCzimd4SJez67scshxI924CaLQSgm0Vu3p/j4MhEqXDEf
 ALwosaPxxcvbWFrWKXezqJn612omHBZ7GvBEwXFA59PqIcSOQ2odl98/TAPiLGl+ejky
 ev9TX92v9z1bMUfFBF3Hyd969tVNV63PjzGR1mmloexSdpgG7a1XQjTQvMQDMWvyQjxR
 secQa8mggIMV31iir7OwPQDHYoqE01W4EhR3fLgQ58f5S1On70fKrlVyv1exPoANwBiF
 13m39A//S8srGWtLJX6OCxzRO4uWjNtH3kUbsXaQ72bJ5HHlF9LPTZSfeJKW21c9l7Sf
 GfLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837964; x=1780442764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ytQYTIOBfQm49WCEl9crr3zXsomhLW4LmR/UlxIUP0A=;
 b=Ze+MEMLp3tbZXA7kdgnGSV/RM31Sj+j12DF5eSSDQuK+zUd1hK/Z+GJQwPjsXVIP59
 VKk8ZIOSKtByvD8Q+albuVUqX5e0bvpLld5Uh5AsbebdgbJWY+nfCYb+gVMCmPRZ4Yof
 qpMror209ebbDcONwFp24jYlhP5z+YTW/pe3dJD45e4grLX7PcMlu1uHhRc/hE3leitO
 anWkhWVnGyd+VW75xMu7JCvU33R1Bwzad67hdFsnBp+5TefUTUlSmek6v7AtCMEcWQcK
 dqvhe4nJBnVn6Otf6sRXDPCAT2EJ53BOsk2fSD+XiONCHRHZDwAnuUW/v/irO4wrPKy8
 FT8A==
X-Gm-Message-State: AOJu0YwsgJPwXDQEPUSSZKbFnw+Lr8ropFK/W6mYJOLk6/LBY6gUnCTz
 Z0FKNkZBqFVjUU9OWc6fPBBRVuACqxD+x6dxootRk8sKGXLk1OvT/Ix51JG2OwKiAjeDprMbpW/
 nHJck
X-Gm-Gg: Acq92OGmB8wFUcg3CgAhkM6438fZ2GYzysaVsgjbHAyDi/n7lmIx8o/bs++0AIXWtPF
 jQWILmABiYaQUxDFq7tJlzguyrA02ufTF0d9GFLmMdzn9a14sPt1YSBDqaGMbxzbotfrxcFNcJy
 3IoppT3vbtQxk+Hz6uqOVULNawpD8uMsMLpave5QQvhdLgE8RK2wMiPvPui9W5+lXLvDJ59QCQe
 didHKSzd0N83u4an4//rFDDtb3W3tH1F3wwAV6ArBs/ttvacbv+lnGJQfbRsWkS8mRNwTFg90EE
 sJgHe86rxyjRjPeThF3wIOJTRl+OQGh+SHLe12ULqvMGsPScamtD4r4JaPBblvtgKJYfo1Lb+6M
 LD/2FfJNVm5Q8KD/hh19ErTt6Pr7qmFOfsaJp1t993U2MRy9m57erhzrjHeQwqpsixtZqcgl/qX
 XCck/y6tielaS3admv9lvnvQFPMbOZFVFbjL3PsaZ+0YEnSWNQ9aFRcS9qQ3G29DWidopiyxxpW
 x1JU64JUnE=
X-Received: by 2002:a05:693c:2c8e:b0:2ed:f791:3417 with SMTP id
 5a478bee46e88-3044912c0ecmr8799518eec.25.1779837963974; 
 Tue, 26 May 2026 16:26:03 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.26.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:26:03 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 17/27] bus/vmbus: convert from rte_atomic to stdatomic
Date: Tue, 26 May 2026 16:24:07 -0700
Message-ID: <20260526232542.620966-18-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526232542.620966-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260526232542.620966-1-stephen@networkplumber.org>
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

