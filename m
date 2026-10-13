Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C046CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:35:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F1A140A84;
	Wed, 14 Oct 2026 00:35:06 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 34B80406BC
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:04 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e934449bb0so1330465ad.0
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930903;
 x=1792535703; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0c5plQpEGWiBRdC6cI1Ff3IycnxOGKVy89yWqbpXbzw=;
 b=INSbBGY5tFBE/AV5vsAU9wRLTJbA2REwrKwEEjgf1N+Nvl/DcAImz176d5zR8Kcf3u
 EMf5Dv476HCoCBYGcYo4aSY6iNktDN0UGY8poR9vJ1W/q2TnOTQDQ3knN0mQXeMJCGSE
 mOSJdsupZpxhkZ9giwP7YOcat6QdEQssXVc+xz0or+sQ7dKtZ6hOkziSTwAnDjqpL/CB
 cy8qu3dPWAMiaoLVGXKVFAX6+lN7QPUkcYXh7dDDv2luscsW3lXu7Wkc6YFs3RfzWLe2
 sdEn3ICl05Mq1TlNIdg6aDfQa+/DWBE/lrYrVP4r8T3x1oAO/a7yUu6nspl3yWDCHnI/
 bDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930903; x=1792535703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0c5plQpEGWiBRdC6cI1Ff3IycnxOGKVy89yWqbpXbzw=;
 b=CgyEAYhLw7wffHsbddJXzMqU8JmKZlano7u3dHZqdhbdeGWR1XoMUGwPgjYzoJZFXW
 E3hxITvB7w45N44IT4KVQQaztAP4lNIs9O8/G5XDv7yhMkdmPEP3BUbveEMc0/zVUgdW
 lOK/UUNhKMi9ADKOFaAVna0XCCBMn4t0orGDrVEpLSt1TIsQP0TTYCRcxxJ1+tkyN4pY
 GU1Ll+AhIc8T68Wi5Pk93L1l2tK18lw2V1bRmuoH5YjvzhJhQlLB0t4fbgJvq+tCS58f
 bAQMSDmNJlg1wIh3JFVwqBmotN1dmzFrFH52FJ0PUczjkMxv1kJJM6C4ZHkywrbJ/iDv
 Pktg==
X-Gm-Message-State: AFq9FYJpCRfpDFbcW3N/fiUb7lz0X3Na6TQjJOFcUw5M7oXYpzm0aqtk
 TUb/5ylG20Ja4fLVm5ZQq22UccGNnZdEJw13Y3NRx67v2znAOrz5pnNs23ObvhB/B6lcv1g71d9
 F/zTJQiQ=
X-Gm-Gg: AYBFou2M3JquCdfb5D6qHNWTPPNJk3e36bbWwPxXsC1fPUj8mXlcHJd5gUaKbxktaUO
 +oq+B58kfbDUPl0gpDlaZdsLWlDLxE4oTep2Xa2SPQbWSGBFw1cxxc/z83SZgZxwTZgRUyhw9LN
 tH264uz9ep4wPwTelS04kMUESkpmMVl7atEWgyCB9kWOMppnpequPXB0Ft6RnvpFKjp0AFcI9J9
 xUZq6CNgUjL43bEtrNQmGxl9MQ5BAygW/SSTPGcv5RZPn55esitiyFoDk2omxPwM+OumBrPjDBS
 pBmBDOGy69eiZopMJ3HxZoVQsitKu6SLLTyvctWwSlj5uLdy6P2MVEgpkWD4+FnsQGF1Sk5MFY/
 31DzX2m+3B5TMrovBP6XPwp0pvUOpW2X3WDl8fqtuL+W5NdIDEYECzvFghrZd0LmhAopPWKlwZz
 z65vUQGpEXUPnZjDw5z6IBaN2qD7ii5x67puBzzisvpjBaPsBJxKvL+h24BmoJQm58liIiXjtNw
 lY8FH6aUTQcjWqvXYZN5kiOx/XBh4dv6ufv3Q==
X-Received: by 2002:a17:902:cece:b0:2df:b5bb:7d12 with SMTP id
 d9443c01a7336-2e842f11c2fmr127461515ad.46.1791930903291; 
 Tue, 13 Oct 2026 15:35:03 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:02 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v4 09/29] net/virtio: replace rte_smp_rmb
Date: Tue, 13 Oct 2026 15:22:22 -0700
Message-ID: <20261013222410.2257622-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
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

The x86 special case exists so that both arms of the weak_barriers
test compile to the same thing and the compiler drops the branch.
That only holds while the barrier is a plain compiler barrier, which
rte_atomic_thread_fence(rte_memory_order_acquire) is not: it grows
every function in virtio_rxtx.o and brings the branch back.

Use rte_io_rmb(), which is what the else arm already uses and is a
compiler barrier on x86, keeping the generated code unchanged. The
ordering is unchanged too: x86 does not reorder loads with loads.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtqueue.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/virtio/virtqueue.h b/drivers/net/virtio/virtqueue.h
index 1f0e6ae77e..ee21d43068 100644
--- a/drivers/net/virtio/virtqueue.h
+++ b/drivers/net/virtio/virtqueue.h
@@ -445,15 +445,15 @@ virtqueue_nused(const struct virtqueue *vq)
 
 	if (vq->hw->weak_barriers) {
 	/**
-	 * x86 prefers to using rte_smp_rmb over rte_atomic_load_explicit as it
+	 * x86 prefers rte_io_rmb over rte_atomic_load_explicit as it
 	 * reports a slightly better perf, which comes from the saved
-	 * branch by the compiler.
-	 * The if and else branches are identical with the smp and io
-	 * barriers both defined as compiler barriers on x86.
+	 * branch by the compiler: on x86 this makes the two branches
+	 * identical, since rte_io_rmb() is only a compiler barrier and
+	 * loads are not reordered with other loads.
 	 */
 #ifdef RTE_ARCH_X86_64
 		idx = vq->vq_split.ring.used->idx;
-		rte_smp_rmb();
+		rte_io_rmb();
 #else
 		idx = rte_atomic_load_explicit(&(vq)->vq_split.ring.used->idx,
 				rte_memory_order_acquire);
-- 
2.53.0

