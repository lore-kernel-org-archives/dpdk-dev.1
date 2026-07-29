Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F117C53200
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 17:58:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D8C0F40B8D;
	Wed, 29 Jul 2026 19:57:38 +0200 (CEST)
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by mails.dpdk.org (Postfix) with ESMTP id D399B40A84
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:32 +0200 (CEST)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c9d1fff21edso737936a12.1
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347852;
 x=1785952652; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oA5A1Ni8WQE+4XDiD4nnL+IFXMmbm2wkxfraprRDcmI=;
 b=Hqk0XLJzlIykOS0qErKb6nOzoWPiPfQIx19BUeaqgPKHxUB6Lo2k2da4rx6bd1e49P
 eKNsrYNnu1rhKdJF7D6/wPabu9lNU8GJyNfBOPeyegpTKbQtyyzr2wOpmga2OOPSVpYs
 FxNwgMtuCePthI82GVQ1KjAu9aXfWib1t8EvywFuL8GYniwHXa5hwJ4cVqUEQPwvzEDP
 3ET3wn3YI21Ehjao/nE+YOcOWxFyJ3pbWG8uCGApMahuuD1vm5DoNh1yICy+YHHFtKiU
 U2SETPy0VHci8ZO5iqZxYvK5V5WO6iO/ZfGHbddX7cP5bnb8ryWcmhe+BQHcXZOJV2Sq
 VxsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347852; x=1785952652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oA5A1Ni8WQE+4XDiD4nnL+IFXMmbm2wkxfraprRDcmI=;
 b=i0GSuOH1n4vG3Xjz+sqiHFhLEJGLAESUPFJiEosMDp1fll+qIUUMmVdRDiabCJwqzF
 rSODbXBupKFIiEK8TzHHvpsQL+ze3ivK1G75//G0P6uwKjnu7czQyZVTXjYgIv3AZXDR
 ywj1FlhgF76ofNf2ckYcT5yzPe9UuSxWV69Ys8UtJ25J40AauIeVfZ6rZOOkUs75RITH
 qjSORv8dGqaaZdLjCZMA6XpcBDh3ZQzbHzxG8pxAFbCTlIw5x5GcE4Ht2+tmjRMq7gMU
 UzSMhM8u2cwJVpsAsmXYY7dvnA8f6t+RTIPBioqkem8bSlRbCnIH67rayeghv7lKcZXH
 VFfw==
X-Gm-Message-State: AOJu0YyxcVTKg+pLgGYfA731kTfwyxJsxJf/uA06+nOnVslaj7DrCmV0
 JPqzXeZRTogpsfxynfbYalMNwNNfIoyY1BobYCB3nhgC1y891lF/z/1Wl0Ht0ZmCF5uxpE67n1I
 EnCHZ
X-Gm-Gg: AR+sD12odAH6KmNgHzgjIpQzfm4eF6HYXEkRjEoBJLlq7RfYkRAYTUR9pj5QipmPT6I
 4kZ1JouVgEVOf6ohcponayhtFNK5u2KDiqnA66Cxhsp06G2M9Ry6XZpw8GqyqAIEYF9C0XM+wpj
 j+ImdER0FhvqfTPMVhBPMQ1+Gjch38GfmAogG7UyEAjqpq82qsSTxvyhwkSxatZbT6UsfhGpC96
 c4tQKrLZ48rf9r9n8R3XaZ+9cHpkdXs0j1Pgs2N3MYh5U6iLoAL3LYmJksn0l6KOjixXsndwdXa
 kB91Ljds147vKR9rBqdVJemCx8jB4jzUXXzwrS52N6WxEaA3c+PqRpgw9kPDsGWuAabGgsJjmnV
 9YYC34hugRYTnRbez1r+goX+WJih2H/EueHu5nnTBneCq0tLOJmnLD3C1NNKH0u/+OgsLlhOdLm
 iR4hZNyxLdxNQeh/6gnXGID4AvTcY/Scn09UEfmppzic9LuOjlvJKOpCgj422Z2mQ56gxE4E2kp
 NTkCvNQIlpEIfyVbYA3HzjDzO0=
X-Received: by 2002:a05:6a21:b8c:b0:3c3:9ed1:2549 with SMTP id
 adf61e73a8af0-3c8ba5b7f4amr9740226637.41.1785347852022; 
 Wed, 29 Jul 2026 10:57:32 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [RFC 13/32] ring: replace SMP read barrier with C11 acquire fence
Date: Wed, 29 Jul 2026 10:54:06 -0700
Message-ID: <20260729175715.165120-14-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260729175715.165120-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
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

rte_smp_rmb() is deprecated. The acquire fence generates the same
code everywhere the gcc implementation is used: a compiler barrier
on x86 and dmb ishld on ThunderX.

The gcc implementation itself is kept: unlike the lock-free stack,
the in-tree comment records a 10% x86 performance drop with the
C11 version, which needs re-measuring with current compilers
before RTE_USE_C11_MEM_MODEL can be removed.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

