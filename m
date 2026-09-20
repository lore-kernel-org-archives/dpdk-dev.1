Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA5AC982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:14:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B149840E21;
	Sun, 20 Sep 2026 20:14:09 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 5C29A40DD7
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:03 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso2071368a91.1
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928042;
 x=1790532842; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UzK+HGfDuccdwwqU/7kgbZLBnuytApUqFxoH3y2rhIU=;
 b=dXy8oidavS73ZbA9i2nXTHgkMtlNNS3N8RKaJgv6Gtkwf+FJKzm5N2ivgh9vJ2jYSB
 wWHPtmrx/ZXZ0oppz2r36oTDcbEqTbm66xGffz3bjeM1nXBu9JK0gznoc31lUagu5CA6
 gxQIi4+GiqGAd2idCaeq8/YDtkUxmtEfZtcSZEmfPUgRiVwAgyejngYzxwOzIollATY1
 iSLamK2laU6N+CAI44AtZ8ZcZkTpzWDMTLdBBFTH2DE1e1bK+V4/6LwbrukYOOqbq/8v
 EpOuo+MtlVzlbq7mf8/OIF8n5nKiH2firx2/ldCIyAp2Pm6nMjSDrJnNljtW45ArvJXZ
 5aBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928042; x=1790532842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UzK+HGfDuccdwwqU/7kgbZLBnuytApUqFxoH3y2rhIU=;
 b=2qsF5i1SFQSNFBbeqUUi0p7ae8eZrN5int7Vvgq5Z2Igd5qhzYv5tnj84Ka9vsVI3Q
 1NGa9kx6MWh4xuhjFqsnLh0KWozwqAuol7iUTQLKiyto7+mK5Y5NC459X3i+530kbBY8
 iP6cZheGuOtbV6ScIZqKIld5u3leJAcoMDBbhUSs7mALOg0dmUc+A/3ZMeta4S9RpqCW
 Q1dPo0T20ZZh5Zxl2Ri3KmisDZjWfJ7rHYD4iQvdIl13hBAEXOFpPEh/FJKjfIq4D0Oc
 YCpqnwzwT8EkIe+EFKsuRHYVsff5RLFSRPK45H9/+fvabB6LbYTgzh75k2xakSyU7f1v
 USmw==
X-Gm-Message-State: AFuF++kCucC4RVMoMnPC3X7NZd7e93BxQ6RROxQnc+ZP9M0KdTo7w0pd
 tXRRP7vHdLpT3RO61QxNWvPnu2i8Sct9mYv1rl02DS2+6b5+sHSWANSYLeaGT3YMrKSqR2LRDZo
 jXGiV
X-Gm-Gg: AYBFou0Aa7UoQK1XYyEAaXKHzwDJYAtJQkDidhb7ODvc4ArcKa3TC5/81+eK855jlMx
 RdsArSlpgXfD244kFFo7wy4OfG3h+48fvBnWOql5o0y1xqK5Iqnt0Hcnh9UHhFIS83VNdI6R7aK
 OOWIbBgB/H4srqAAIF68vzH01pn8ZgWyM9G8ilsS0KlwSzwN0mY7/1G3FC60OR8Qoq5FMXJBpCC
 MF9YuBiu2vVx7IK1fsuXn+F7vm7HQIFjB8L7HUCF6D7mqKJbQ1Z5SR/Zz8UqZxnT/rv7yG3wR8y
 KhGSrTdSkmH0TwDDgkEERBHd8hEojS/B1TmsNoBIl+LG+Xtddc3jU3unaTJvko/hkisM2vg/2ks
 9t/ujonJc9z1Eo/dpaN4+0q9d1pjnALIL+s8ULjwqlzxEmH9uT9SxF01ZvEL6QVimWWdr6BoPVV
 KS1IhwlR3hICth6hg6ajJUvLXHvkp5DKCw1F2OUDAHEo+q/UCZUQeDO7Uwzr/CN4HwRjbH5CpdI
 KRlyS3L7lZJJcbsDeSHdGS6zv00+gLeplJiNqI8KX22O0os
X-Received: by 2002:a17:90b:380c:b0:3a0:42a9:9c80 with SMTP id
 98e67ed59e1d1-3a042a9a098mr1783675a91.39.1789928042529; 
 Sun, 20 Sep 2026 11:14:02 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 09/33] net/virtio: replace rte_smp_rmb
Date: Sun, 20 Sep 2026 11:10:01 -0700
Message-ID: <20260920181347.747210-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260920181347.747210-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20260920181347.747210-1-stephen@networkplumber.org>
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

Replace rte_smp_rmb with equivalent
rte_atomic_thread_fence(rte_memory_order_acquire).

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtqueue.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/virtio/virtqueue.h b/drivers/net/virtio/virtqueue.h
index 1f0e6ae77e..37fbd47d42 100644
--- a/drivers/net/virtio/virtqueue.h
+++ b/drivers/net/virtio/virtqueue.h
@@ -445,15 +445,15 @@ virtqueue_nused(const struct virtqueue *vq)
 
 	if (vq->hw->weak_barriers) {
 	/**
-	 * x86 prefers to using rte_smp_rmb over rte_atomic_load_explicit as it
-	 * reports a slightly better perf, which comes from the saved
+	 * x86 prefers to using rte_atomic_thread_fence over rte_atomic_load_explicit
+	 * as it reports a slightly better perf, which comes from the saved
 	 * branch by the compiler.
 	 * The if and else branches are identical with the smp and io
 	 * barriers both defined as compiler barriers on x86.
 	 */
 #ifdef RTE_ARCH_X86_64
 		idx = vq->vq_split.ring.used->idx;
-		rte_smp_rmb();
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 #else
 		idx = rte_atomic_load_explicit(&(vq)->vq_split.ring.used->idx,
 				rte_memory_order_acquire);
-- 
2.53.0

