Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F15C982DA
	for <dpdk-dev@archiver.kernel.org>; Sun, 20 Sep 2026 18:16:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAD1641140;
	Sun, 20 Sep 2026 20:14:33 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 36CB840EE6
 for <dev@dpdk.org>; Sun, 20 Sep 2026 20:14:24 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a990so2018186a91.3
 for <dev@dpdk.org>; Sun, 20 Sep 2026 11:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789928063;
 x=1790532863; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e9Z+AlBVLeMASY+A8efzbicNl0fgh+e1duimGjCSeQs=;
 b=ou5jaX3AcW4jsuNUQWDe46830U7CrfhPPBDttV1Qz/L+LBVPaw+umq1+UTLTODAVJG
 8YEpYe06VwFPES87rfsXhc8LkdFD+HvZzvHHeYk/CTkVrJUxiHg+Vmq8WhUi3HIJfl+u
 Xziqec8LsYsk9enYxAES1pRh81c9EZ9Q7iEpGCBFVQWL5HnRv5LpVFzJjITWKtBfT2kR
 hGhg0gz4GpjKaoBefax8OG+CahBNVl70Vo3RNJTGx2LptVmeax7Kod50JecBjmnjGMHj
 thSFvqn2u8gfq/H8G0nJ+sTtXGPk0cbdeJ8nqSChHJkA7mulhLlVHPziLfBu6+zEhSPB
 7sIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789928063; x=1790532863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e9Z+AlBVLeMASY+A8efzbicNl0fgh+e1duimGjCSeQs=;
 b=Ez6UhGIOhnZFMrT3EjhGIEbGsqwL7l+wzlJswIA/ObhTO16AaJiqA3E0l8A/i28AVY
 9Ie+XfoQ5h0UxJoNxpAxEe+AHrYP5aMYm09nGbEekUYfzzMKdOBZyiRZ/wYCsayRUCer
 sXI8R5znSDjLM91DHyzMgL+qs6r2eghudCsu9VJo9pVnomnTcbJsyoqfY+wOxMGenZQq
 ONjaQ5welLWo3QJC4Iss2tQOXb1hPVcigxv/P9kk3LPEVjTKHWtSYR/9xwm2JE+TOtpP
 p1SZmUOzYcmM+EiMMUEf7gAJrn9I5nkokCKf/XxoPD5x4fQKZUXEgqz9A2Tz3kCPpLtO
 ehpQ==
X-Gm-Message-State: AFuF++nRsMs77G/eUJohdo+NB3nAlzpXbADIvnh6+KmEK7nWh+6gYH6m
 Q16t+maQIxWZcVfvyKb5n1UfQOsjB1wC8vewP357dGw0tRJjazo7OSAVm8ayFyVf6hfHLvd19ZF
 UivqS
X-Gm-Gg: AYBFou11Ucf140g3xBl4GTBchpOsDla6fxUzpVfRInpKp48Hr6MqJWXx1DjB09d0vRZ
 Q/W3yqgRelBJu71fffcZazuaxiNJm8ioH0iJdSJvrpBROfjq0Fhogw4yfSJ3wzlm32TQaAo4O1Z
 8fan9qJGcthv6tRPFhQVbHRku8eXRuuzCE0tqb4D0P/P3drA7/RTmDVT+0zeSQzRUCa8pjUn1Ql
 r4Nj281fCJiYKV/G4FI/Y35CzAxZzsxhBbWQaAAIFPgTEvqPPPjEBSgas2hOo+P7y0OYFAZoTa1
 0X8Et4ZOUsib+gwkZQToqR3KEl2f/2ki+ivsmG6hP3uMxGfylcEfx1g5usFdP8eq4zg+vypf7pG
 55J/kE9pIRRoy47PGqQVH0n+G6yfxzKHqV0FBJqVS0Zz9GBn6Lt6/HRLAXC/Dkq7awN+mz3Hx0u
 1eyvJhnhlXciVRVGUXriNm/slfFT0+Mi1wNiGVH8ZQCLyhTdeNcA9I+v68ESJ5nSBXip54i9w6J
 Wu68BlWf0tZ/YoDgei476JJDgwqVQ9J+s0ktEaLsB8pKjV7
X-Received: by 2002:a17:90b:1dce:b0:39d:f064:3a68 with SMTP id
 98e67ed59e1d1-39e54d36e3emr14719272a91.21.1789928063327; 
 Sun, 20 Sep 2026 11:14:23 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e6c37a88csm10088091a91.8.2026.09.20.11.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 11:14:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v2 29/33] net/virtio: replace deprecated barrier in avail
 index update
Date: Sun, 20 Sep 2026 11:10:21 -0700
Message-ID: <20260920181347.747210-30-stephen@networkplumber.org>
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

The x86 special case keeps its shape: a release fence is the same
compiler barrier the SMP write barrier was, so the measured perf
reason for the branch is preserved.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/virtio/virtqueue.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/virtio/virtqueue.h b/drivers/net/virtio/virtqueue.h
index 37fbd47d42..cd954108a8 100644
--- a/drivers/net/virtio/virtqueue.h
+++ b/drivers/net/virtio/virtqueue.h
@@ -474,14 +474,14 @@ static inline void
 vq_update_avail_idx(struct virtqueue *vq)
 {
 	if (vq->hw->weak_barriers) {
-	/* x86 prefers to using rte_smp_wmb over rte_atomic_store_explicit as
-	 * it reports a slightly better perf, which comes from the
-	 * saved branch by the compiler.
-	 * The if and else branches are identical with the smp and
-	 * io barriers both defined as compiler barriers on x86.
+	/* x86 prefers a fence plus plain store over
+	 * rte_atomic_store_explicit as it reports a slightly better
+	 * perf, which comes from the saved branch by the compiler.
+	 * The if and else branches are identical with the release
+	 * and io barriers both compiler barriers on x86.
 	 */
 #ifdef RTE_ARCH_X86_64
-		rte_smp_wmb();
+		rte_atomic_thread_fence(rte_memory_order_release);
 		vq->vq_split.ring.avail->idx = vq->vq_avail_idx;
 #else
 		rte_atomic_store_explicit(&vq->vq_split.ring.avail->idx,
-- 
2.53.0

