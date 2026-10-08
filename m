Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1356BCA6015
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Oct 2026 23:37:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 210FA40A4B;
	Fri,  9 Oct 2026 01:37:05 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id 637DE4066C
 for <dev@dpdk.org>; Fri,  9 Oct 2026 01:37:02 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8899a204034so2075711b3a.2
 for <dev@dpdk.org>; Thu, 08 Oct 2026 16:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791502621;
 x=1792107421; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0c5plQpEGWiBRdC6cI1Ff3IycnxOGKVy89yWqbpXbzw=;
 b=jjEnSmFA6Zc5WHKOiJ8rXtgVbsJoFmp4Q28kBq4pH2AOnCVgcJ3uotsTnjDUTComo2
 KCwfrOP+tnQenMmRqug9akPI03UCR4U5ZnNmcnSdzdlEDSRZVqzDmseq2B4P6+k5nYd7
 e0n9ZP2VvSyWxCVMpBzT8CA06FIhHlA/uIikAODysjumAJS830sNvI/F+HqEpBe0sZej
 f2oI/PpjRLpwqKcLCh2ABMwTqbttogETC1sGBBCxmuYEYn/i6YoqfCLBmBoikeX1gfJ8
 aD0BcrHp8Ur16Asx4pWuVo42JL6uooXVTvHt8H/AYyaWTg+QrB9b70VWeaxhZbujvoER
 GB+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791502621; x=1792107421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0c5plQpEGWiBRdC6cI1Ff3IycnxOGKVy89yWqbpXbzw=;
 b=0Wz9M/ePUMYO8uhxEyKuDD3y8GCM00A/tA3A9KCWTUWD6D+NUR3NDzQv9HS+eNo+1X
 s9PePwcmgAKOGrmwNqZIKX4SVUwaYC8OGUnI8xo/48bWaZAoiSW6AcvFKdklxqQUB5Il
 GQFsSCPQGfq70bITPGdIUOeIruhYtIPJxCxAakwwyY71XrjQhBMu8NmgfkEoly4D8Gnu
 sR0JgV8VDNMHsfpAgDB94cuD+VzkOgi+r4OvwtrokXop5B84BZa7nAXejiNnSl3aOAov
 wu1Z0WUBWFPVVP89Z1qE+IY6nbd/rxh1pFhYLd9B4x10+jKmllSEqEpWkrgomZHoyr0D
 dwqQ==
X-Gm-Message-State: AFuF++n+sCwkK7GDBWPBCbjLY3eWubtIyblxnaIY99p7S+g1EoDhaGld
 PZdHhKC8GHo9JVThKNKKiJ/LS8QeFfPpChXtRrZWTnGZlauZ/0P6VPafSl2FfBfcfb03spDaQ8t
 E/GTjJS0=
X-Gm-Gg: AYBFou1zh1aTbTf2BoJGRXBmGI/WCVIP+lXM5e6mNKCDQop5Y26wekS4hHfSXfKMFKr
 MHkeHZaPjWCeQm6ilEiBaeROUWpDI1/PJDS9LTwzus4uCplAhKcf4BEqO3+Omzx275bZTcpzmih
 x33g2QFwWv4KtXXDBC3zx+CT7l7sExrLDYrY8LPpwbM5R0vg6e6M2ax5bAhUyssCnjoVt/i3E54
 nfv4EVt2RCdi33uwg2YS2cM+031FGHr995/FpVgnK53wTP3NDqAuyAn3CsUPG722AJ8zfw7JrXI
 VeOuo6PZd7cDlXSG3DM4fVvcZzkP7xXvl9BR9jkzdHSb7oTLZOC7jnu/GpILgSpdYoycKWt8KFj
 bbyYDu8aGVPJTBs24SFL1+BCTwDzrbo63O7jwx2bmxcROyGDF6U1DtlFK6mDAu4ZS69tUo7udu/
 obRVFPqtOZGO69Ay94TP9GnpqKFNaBA2uurJbzW3Vg81vXmmPv+eyQlHeFb4HCJ+6gUWwy9EPQW
 X00zxHpX3UQn50dnVeTsoh1WO/PuiDImyythA==
X-Received: by 2002:a05:6300:67c8:b0:3e1:5f42:d77e with SMTP id
 adf61e73a8af0-3e16bf53ef4mr12042637.79.1791502621517; 
 Thu, 08 Oct 2026 16:37:01 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c42b06e9sm187909b3a.42.2026.10.08.16.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 16:37:00 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Maxime Coquelin <maxime.coquelin@redhat.com>,
 Chenbo Xia <chenbox@nvidia.com>
Subject: [PATCH v3 09/29] net/virtio: replace rte_smp_rmb
Date: Thu,  8 Oct 2026 16:35:02 -0700
Message-ID: <20261008233649.1260843-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261008233649.1260843-1-stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
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

