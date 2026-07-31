Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C38C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 05:01:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 952A740E01;
	Fri, 31 Jul 2026 07:00:08 +0200 (CEST)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by mails.dpdk.org (Postfix) with ESMTP id 184EB40B9D
 for <dev@dpdk.org>; Fri, 31 Jul 2026 07:00:07 +0200 (CEST)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8486672f03cso753486b3a.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 22:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785474006;
 x=1786078806; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k/8ILKIfa50s/hXUVLxI2Yl04nBtHJF7dGyoXMJnXOk=;
 b=x0ujB0Bbw0IlGU3MZ6Qmpn55oqp9HlCQf+HOfHTs+wv3bnXIG7aPfrukxIatDO20QH
 xbt4tg85GLncm+zqsPbtGV503OminZBKt+UBjCgmdEJMusZrK6krQSoYbh4mbaLD4O0m
 QHOm7psyylwGb4JqkXMMdCQj91i/ZU4O1uBvsIjPhLBRKBRVhdCoEAnlcVL+k2LVsdsO
 /6yK5C2hPTkLRMZDb2rGLQR92iafKMNC+59w3AhqftELzecCpqypJtZ2NIPSjczgX8c+
 E4f1o/JgQLFhEayxKrjeryLQYxSL+xbsIBTbmnJ5jOYLYb1paD5MIss6Zrc97HAvSZMF
 9T2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785474006; x=1786078806;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=k/8ILKIfa50s/hXUVLxI2Yl04nBtHJF7dGyoXMJnXOk=;
 b=LyqAba23DSON6V9nPVVowtMJ0OFSSnHJ8eN7r7LUj1n5ipLTchQWn2sR92XZi8v96Q
 1HFxmQyD8hS0x+4ZPtyg2Fr47pnh2rDLi9CQBc9+Ui/bDMyWYC30+EmfhvVTtc5pVY3T
 UQJDqJCM6aBhoAN71yxnO0/OFVjs9ck9TovrT48VWcwP4UkO23kjhjGpBWOM69syLB4D
 BQtg+sRTLpE/7IWCjx4jYTQEOq91qh8mt5GKd6ipv/yBhjDVlsFlSSa/TsfyhFIO+ct5
 Ct/Cb/aiilZY8vxJymnJEVVhG/KNCusBuZwpmY/Y1ULmt43IkmqtxR5U7IFI9P0jPGOy
 yLZw==
X-Gm-Message-State: AOJu0YyC1c65ScNvfv3ogHD4Oypo3CDkuSQtvD2f79lw937h6sEyaXv9
 vaaGO69vFuaCQZ1Xk2GOdb3Yp0iUh6MMhcbzx/+xwm0qrFCIxn60UKC+FHMa3N7iJUobIVr5hVm
 YNMC+
X-Gm-Gg: AR+sD117gDgSJx0P5mRfBHZ2mPoVZ+ErmG1f0Yhr1ZzaUVJzD9DFio5i7+Xh8ZPRMMJ
 D0MnIxXzA6bwMbqkZfFNTIE69pcxNhUJ2NVYvk2T/wnvhBAJgjpuJT6Rt2YlnrHMCgCcervMv/T
 6qSEpk0hESdL0o8CPnkD17+lpzvsxPjRDoyyiExxMROfjX9Y+8FjVpfs4R2FfdGY46AHVpDGPwm
 vUX8iGlqJQqsYNWu/skBMpIxf8dZt5Voz5MEQOCzJCd85wS0TZV6vDCY2+ltf1Bm2irMlIplcnC
 BXgcnptBwf2o+rb/f6Q6WyhDrqAnp61volipKRnS27By6NmJXjVlC9saLZvSYS55SXhEZ7bkyyk
 C9DX+53kgE4hsop7NQI3BWw8BSshH2TEImP6AvUVVjGdVkgSj1r7nh4+3VU3TaTKRHX9G81rFdi
 pCS8LVZDDxPMCX/OaR07bSFhyPPeiXFieIHW7ji0SoECcEpwVLjPc6eFTfdB1NTLF/0HiRsUqnf
 CyHyCB8grwNd2EtVWKRAxbuObQ=
X-Received: by 2002:a05:6a20:7f9e:b0:3bf:e24e:3afe with SMTP id
 adf61e73a8af0-3c91b314376mr423360637.43.1785474006285; 
 Thu, 30 Jul 2026 22:00:06 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.22.00.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 22:00:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: [PATCH v6 14/24] bus/vmbus: convert from rte_atomic to stdatomic
Date: Thu, 30 Jul 2026 21:57:52 -0700
Message-ID: <20260731045948.769926-15-stephen@networkplumber.org>
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

