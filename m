Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81A10C54F51
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Jul 2026 18:00:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 745A340E35;
	Wed, 29 Jul 2026 19:57:57 +0200 (CEST)
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46]) by mails.dpdk.org (Postfix) with ESMTP id 21F4740DFD
 for <dev@dpdk.org>; Wed, 29 Jul 2026 19:57:49 +0200 (CEST)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38e041ea211so1408711a91.0
 for <dev@dpdk.org>; Wed, 29 Jul 2026 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785347868;
 x=1785952668; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e9Z+AlBVLeMASY+A8efzbicNl0fgh+e1duimGjCSeQs=;
 b=JpEZFxmXQfpeSXRCgzvU67wTH+58iMgclWf9WqjfkCPw2jtOZg4wgVcebPVVhYXPTS
 ZmmerRZKNTwQu+3z+zuaR5b5crezI+b9DmQeVLeFJDQIpKSHSAYN1qnuSfjQepNq3Ol2
 6GK/7KhVoz+cMa8pz4xA9yie3lx21FGSLv5yNN9T+iMh/FcM1mo8n4SoltrCD4H+kjZj
 ZasufNt1gjIGjisrsb68WtbQjPmui83COYuKnR6qPzYZuBuUhcue0IUvO3e/QbKnKBp5
 +CzduSzKDWoC8FEQN1CXxpAz8ytCFIILbNOfmBp6vv/hsQU0RAvi67gEHB0EzT4fmBUx
 KfCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785347868; x=1785952668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=e9Z+AlBVLeMASY+A8efzbicNl0fgh+e1duimGjCSeQs=;
 b=kyKpH26RFc7ILiSYsNA7BRIbZgTSBQyZbLvamp/WRnRQiJZ4R6ucJuUGDjLvgb9S3U
 Psx7gvtZon4Zfzwvmy6qZ1XOJ4/KpeR4SiKjlSo4QPTKrHtAcKvG+D/d4UmYIChVnKCH
 1y9UPMfWk8+Q/Earrvmoc70L6vuIyUcdJGCaBH42AvBNf9GtdNxgCPC/iQw6jitXmV37
 Y93gEwo8k6uvCkZ5eJBQ2+ekqjmsRFwJwUzM0s3YtHBKGFmBDSirxSi9mhyp/A9VT0x/
 iwcLIF6oPrY4FAMcjuBTsLqL8zEUMZQNEkSI4YYKkW4e6l1bSg9bvnIaofRhIt70uskh
 ETrg==
X-Gm-Message-State: AOJu0YxtsKrsuX7EP5KXMomUbqDYOUprbpSARPvTjcUNigftI0v2VrDw
 8r5Rn5rPmw1St3UHKrEQ6Jcjm8c13BO/IWCXoQhCxQLytwYr6BYh+MIcVCH5DVyibgD6je8p+HP
 UltfF
X-Gm-Gg: AR+sD11zf64DdA4gJ2Jz04BPARegqKsMAl0ExFABuDNwyTiNPUPm3e8ruaMkUOJVMUL
 HYEfLwy5XAbSUne65T/DSTFqi330BUeMq/f74T43CIBH+QnDX/jM8+DTMmeTOtP/r4Bi8Z/K3TD
 wlc7WAINbeu76a1ty3hIQkDVb71v6Lios/xoNC0hAgPBCrrDD4qbfyrVafXovjpiS6Izz8fE49z
 ZNausoKyTidXxaX7ayoKz4UAtRUBDH1Q/L0cnZP6Vm1k4bVvmRffZYqPNDctS1YsyNziGFpY1tq
 ELoPt39Ls/ODrDX8teg92d3qU154tizNNqXOu/BNau7hoOfplvwKG0T8MO5SEh2d2oypRbiXI9x
 SaceZK2shRUek5jDQnWYebvh0QED2aW2I9cnq51KTq7Sk8y0S8pfs4hB28Qi/AfBqiZH+haZg50
 6qaSjm2T3yp4eiXH1rswOLuBe7NucSjmSrJGFJq/EfwyuHiVPbma8RfNL5KEECqCjEPatw5m+Bv
 LrEc9zle88PsK+XMGnWGwRGSQA=
X-Received: by 2002:a17:90b:5383:b0:38e:c721:7c5f with SMTP id
 98e67ed59e1d1-38f6a3732c3mr8107196a91.13.1785347868307; 
 Wed, 29 Jul 2026 10:57:48 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31504b15f77sm13111562eec.4.2026.07.29.10.57.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 10:57:47 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [RFC 28/32] net/virtio: replace deprecated barrier in avail index
 update
Date: Wed, 29 Jul 2026 10:54:21 -0700
Message-ID: <20260729175715.165120-29-stephen@networkplumber.org>
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

