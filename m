Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F36CC6B0F
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 22:36:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EAD5740B9E;
	Wed, 14 Oct 2026 00:35:09 +0200 (CEST)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id B0AA940A67
 for <dev@dpdk.org>; Wed, 14 Oct 2026 00:35:07 +0200 (CEST)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2dd9cbb661bso26051165ad.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791930907;
 x=1792535707; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7abDSKLL4Lv5RNphVmTFCX67AipVyDmAgZYVZr+0piM=;
 b=LLlomHDf800rbhiRQWINaOnYJDeKXGS7P0V+dx/JpO4gn/zRhgJt2zk/NntTbrm380
 HnspM0p1BqHjjhyuu6OP0JkIP+1ij2XbmBZXrwAXBYMwlNnm9EMDTaBGCkfve+JPqexu
 KrU6VMgI0CXiTNGz38f+u50PpmcgbhgyJuR4A133bROBC1gRA8Hkx0rRwG/m/XhVkjjv
 uRD4romcK6jFZJ34nd12G+k3dDIC5LqRxcnvJZfyF0pwiU8p9/YvrLzeCtEftTHK/4YN
 Qmzuo1YqNOM9VUzWy/0s+EFoJZ50XnF5ASfc1VadW3CXUCrb4rMJj/4lAfIZoSH6n1GP
 wR+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791930907; x=1792535707;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7abDSKLL4Lv5RNphVmTFCX67AipVyDmAgZYVZr+0piM=;
 b=Lq0WbhClY4AmEnKsFv09mK2Xc63d4+smW5ZgDEKPoV7VbSeuUQz48HmEZgWAP1zTuz
 hcyRDLpoLvkO+WUdBQfAwVKt/uDqQqAk25D03QdhxQSjzL+kDJy4PaYUlYh2DWYFDqRr
 7/T7TObVxinhnU1Jd2h8LWTU+LWuA/FwmEtGuAVOSl5YWWVS/lOJKRYOmezC+qf0zpRu
 EH2yEWFy1/pVak+EFso2+khSTTJ447qVnqykaXKcr/O+MUu+cGB+2jPQK/p53wUg5n6d
 T2z02XI0Ih74zixiMjhU9DAzX24KMFSE88vZKazXTyTMrlzVQK86GE7QJkW7S1aeQ/6B
 cWdg==
X-Gm-Message-State: AFq9FYLcSvZpDV+QgYLsHKvXCQBPJZyL9o+LIOfNp6fDK8v+sZHStaa4
 +hNv7js1n+S++zBoNMSD6SsN3Tqx39YvKyyAMmugPvifzM3abIhwFxEHwskEvhJwYiiMt7woM9C
 X7wEE/Mo=
X-Gm-Gg: AYBFou1PF7TSVw4o1Dc1V068WcyXITwpJb1cCSITxC4AAZb9094NfuJbbc5Xdg2/YCy
 d6Hn/bJkIiJG5U49+lwELD0kv/aAzMJIWkuhR+BUgI0Sg6Avttw2hR9jE+mUR44Stn+ZMc99SnH
 8uBUh9LX2kE+Vz6FJLOBk93sPdAwiA9XZix5rCnrkI1wcJIMQreqi5KU1b2BNlylC4vKqv9dOPr
 /zpoTy4R+XMh7QLh3SoPTjHHI8/lDLe92dGto6juKSrVDlfhioh/UTE6MMIJT2F7XzjMu7WpF3c
 yeZBIusr2Tz9DLmR9cRj9Dhdi96UHl8MOibKEFqfORdlPpKgXg+09gcZAKkUxVp3+SGEh2HYuNe
 +kodLzTS5TkpnYLZaPjV0FsSArBn9G1+cb8QL00YAN4Edxhlq82FwIVvYonOBHFGHU5TtqpoFKm
 C34GBRDC3KmyI8rggQMDgzfmLpOjVJOnkLNwPivrtwhQ7k1vEHpl96dl9mB50HUS85hjw9aXnfO
 LM4yyVAfcEwH2T9MrX0Oq4wSFlsSLReVD5+/w==
X-Received: by 2002:a17:903:4765:b0:2e4:cc75:2727 with SMTP id
 d9443c01a7336-2e84280dfc8mr125404765ad.8.1791930906759; 
 Tue, 13 Oct 2026 15:35:06 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8421b19a2sm61865145ad.46.2026.10.13.15.35.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 15:35:05 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v4 12/29] ring: replace SMP read barrier with C11 acquire fence
Date: Tue, 13 Oct 2026 15:22:25 -0700
Message-ID: <20261013222410.2257622-13-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013222410.2257622-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261013222410.2257622-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

rte_smp_rmb() is deprecated. This code is only used where
RTE_USE_C11_MEM_MODEL is unset: x86, ppc64, loongarch and ThunderX.
The acquire fence generates the same code on x86 (a compiler
barrier) and on ThunderX (dmb ishld). On ppc64 the barrier becomes
lwsync instead of sync, which still orders load against load.

The gcc implementation itself is kept: unlike the lock-free stack,
the in-tree comment records a 10% x86 performance drop with the
C11 version, which needs re-measuring with current compilers
before RTE_USE_C11_MEM_MODEL can be removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/ring/rte_ring_gcc_pvt.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/ring/rte_ring_gcc_pvt.h b/lib/ring/rte_ring_gcc_pvt.h
index 340ece28c7..9c2c58824d 100644
--- a/lib/ring/rte_ring_gcc_pvt.h
+++ b/lib/ring/rte_ring_gcc_pvt.h
@@ -55,10 +55,10 @@ __rte_ring_headtail_move_head_st(struct rte_ring_headtail *d,
 
 	*old_head = d->head;
 
-	/* add rmb barrier to avoid load/load reorder in weak
-	 * memory model. It is noop on x86
+	/* Acquire fence to avoid load/load reorder in weak
+	 * memory model. It is noop on x86.
 	 */
-	rte_smp_rmb();
+	rte_atomic_thread_fence(rte_memory_order_acquire);
 
 	/*
 	 *  The subtraction is done between two unsigned 32bits value
-- 
2.53.0

