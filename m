Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16BBCC6B34
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 12:57:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3C2D4064C;
	Thu, 15 Oct 2026 14:57:47 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by mails.dpdk.org (Postfix) with ESMTP id 6B44B400EF
 for <dev@dpdk.org>; Thu, 15 Oct 2026 14:57:45 +0200 (CEST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 435061516;
 Thu, 15 Oct 2026 05:57:41 -0700 (PDT)
Received: from KDFJ2LQKPJ.cambridge.arm.com (KDFJ2LQKPJ.cambridge.arm.com
 [10.2.197.114])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E00493F871;
 Thu, 15 Oct 2026 05:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=foss.arm.com; s=main;
 t=1792069064; bh=famw8WJkCK0KdpuG17kPCQIgrgjxAc8uVwYcWc2pHwE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W4YOwEDkIcqp6ZUUcF4WQGcx1ScyQ8fl/mKBrSAfZki+hkHSWUw9PdnnFdfVaXcoU
 49u3okpYb+z1SLUD3xWNCIcg6ht7/KAFto/OEOEFEWp+FRi7boOBgYhYgZqgvp8yx+
 orwfaMZis1aUsZGj2/y223EQiEo/79V/87qmstDw=
From: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
To: Elena Agostini <eagostini@nvidia.com>
Cc: dev@dpdk.org,
	Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH 1/2] gpudev: fix minsize build
Date: Thu, 15 Oct 2026 13:57:39 +0100
Message-ID: <20261015125740.47008-2-jack.bond-preston@foss.arm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261015125740.47008-1-jack.bond-preston@foss.arm.com>
References: <20261015125740.47008-1-jack.bond-preston@foss.arm.com>
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

"minsize" builds of DPDK with GCC can trigger the following warning
(error with Werror):
../lib/gpudev/gpudev.c: In function 'rte_gpu_attach':
../lib/gpudev/gpudev.c:290:39: warning: 'shared_dev' may be used uninitialized [-Wmaybe-uninitialized]
  290 |         rte_atomic_fetch_add_explicit(&dev->mpshared->process_refcnt, 1, rte_memory_order_relaxed);
      |                                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This can't really happen - shared_dev is initialized in the for loop
before this usage. However, the compiler can't see that gpu_max is
guaranteed to be > 0 in that loop (which it is, as we have returned
earlier if gpus == NULL), and thus assumes the loop may not run any
iterations.

Regardless, NULL-initialize shared_dev at declaration to silence the
warning.

Signed-off-by: Jack Bond-Preston <jack.bond-preston@foss.arm.com>
Reviewed-by: Wathsala Vithanage <wathsala.vithanage@arm.com>
---
 lib/gpudev/gpudev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/gpudev/gpudev.c b/lib/gpudev/gpudev.c
index 4a2335834c..93a30464f0 100644
--- a/lib/gpudev/gpudev.c
+++ b/lib/gpudev/gpudev.c
@@ -251,7 +251,7 @@ rte_gpu_attach(const char *name)
 {
 	int16_t dev_id;
 	struct rte_gpu *dev;
-	struct rte_gpu_mpshared *shared_dev;
+	struct rte_gpu_mpshared *shared_dev = NULL;

 	if (rte_eal_process_type() != RTE_PROC_SECONDARY) {
 		GPU_LOG(ERR, "only secondary process can attach device");
--
2.43.0

