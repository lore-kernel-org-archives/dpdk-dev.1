Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3692CD5BA4
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 17:08:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB3554066C;
	Wed, 20 May 2026 19:08:18 +0200 (CEST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com
 [209.85.128.171])
 by mails.dpdk.org (Postfix) with ESMTP id 3571E400EF
 for <dev@dpdk.org>; Wed, 20 May 2026 19:08:16 +0200 (CEST)
Received: by mail-yw1-f171.google.com with SMTP id
 00721157ae682-7bd6f65c781so41932937b3.1
 for <dev@dpdk.org>; Wed, 20 May 2026 10:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779296895;
 x=1779901695; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RYPT2GQEnsacgCQX6c7wwF9kFmghN2e6dJUeXgmHSt0=;
 b=mdV9xRQPDrV1s0NXnghnW7FWlNNlENxRAP3/tR+N/bJwx4sb/qlp6/Glbpipm6zqkK
 yhuMp9SHe5fx9kzrRVTThBaTFMfvhfiXpT0UE8PGdBVrEykrP7mxOYGFOFmoLuKjCcX7
 4IimY5jBMxMdA1b47Sk0QJouUDitU6Vkj6+L+ztdEd7uZ9S/PgeGHsYQMkAdaXPDxFyL
 PRfA/hpEgPg+OCFh84nn9RBFkTIuqW3JVDEDtwoBCevvmY5D3ZLFsTOo05EfcBDx/zHb
 8Y21d3H2KRZirxj27Zv1AbLsUi9XXeII0zOJQtHnGvCeRl4hQCQxn7QCubyft6SANZo+
 OMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779296895; x=1779901695;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RYPT2GQEnsacgCQX6c7wwF9kFmghN2e6dJUeXgmHSt0=;
 b=JBFNBeEthQrQ+NgVkkuV3TTTdYwZXJbc29CGluUx1+NT3LVkrx6ZvfHKKRpB8SBm2O
 ZC110m52mRXtab19Bmz0z7RYcLTA163y5UCr5WvUYYu37ymGHuKZyDkYCbYtQHL4Ivje
 UHdYlzJTTqGuy40Uob5M2OM13igU6sFSSVU+lPuAWNs6rrvlfLx8277b4zHg/VQHadmg
 oGFEoVFaBGE1GukRHjzTf591yu/tnwISggPYaTXZZfcG9Xcaoq/U1N93J3wgbhP6XB3I
 AMgetm0mgurFrJ0Gta1dSJoGE0NUxhRYJTSGAbrg7QSIYaADtTEerOPH5Iqb55aJHuiA
 DTUA==
X-Gm-Message-State: AOJu0YwhgZA5UucXabekAL4fY9o4+fcHAe188qkB+DOf2J8Jf5ol5Vh6
 R2kZX4pslluaj3FzN9pcEauuR/UGdj5af/TBhesrT7KY3IeyZPaxlIbUzUa637BoIr9AyN5cdjw
 7LanmCI0=
X-Gm-Gg: Acq92OEScv9tPk3t4X5dMsQETG3RbTpHem3h9omuGh8MdEanUdbSkzP9x8yvuP2UMAW
 8+xTAMt6jpT91pFcg9fNI0Mana45Mm1N5mTJfCRjzn/7DUtkNpRU1JCnuFFhzHWk3EaBCHeVX0E
 2r+kCnjKFxKiJpIg9Gg3EZtfVyP5cYHDDFKuTBODfrdT67GZaXkTlp3jKDqD4mrl3APrj20CDUB
 xyCpkdzs1xYBBIGp3BtOFapPmm+gg4jGDixhDc9qHs/cfp/id/XEvcS68D+431XThCaDH5D1yzC
 OKU93XadKyLcJNHgH0LBOaD4G1Yh2bCgr1EMEYQgUauu956SVX8YvS2M4rgpB5/B+vsiic0Vnt3
 c9Kg8BPnuWsWWg9qEWEAKXn5YdQR5mh46Mj3PXm0m0mprnsJdDCgIIgtyzgFWQGLsWfy9gE0vlI
 JqWSM0KSPmVE8Ufb+4ryejDszWekvwbe87VLkdd3sPglQ/JzlxmVLYEA1UZZLQHLpYBDxBkjMa
X-Received: by 2002:a05:690c:4884:b0:7bd:69b8:f2ec with SMTP id
 00721157ae682-7d1c49a0968mr3804007b3.15.1779296895379; 
 Wed, 20 May 2026 10:08:15 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7cc99abe9bcsm56278247b3.22.2026.05.20.10.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 10:08:15 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Michal Sieron <michal.sieron@nokia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] eal: fix data race in hugepage prefault
Date: Wed, 20 May 2026 10:08:10 -0700
Message-ID: <20260520170812.759638-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520125756.530808-1-michal.sieron@nokia.com>
References: <20260520125756.530808-1-michal.sieron@nokia.com>
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

The prefault step in alloc_seg() reads a value from the hugepage and
writes it back unchanged to force the kernel to commit the backing
page. The read and write were not atomic, which races with concurrent
access to the same physical page from a secondary process attaching
to the hugetlbfs-backed mapping during rte_eal_init().

Replace the non-atomic load+store with a single atomic fetch-or of
zero. This touches the page with an atomic read-modify-write without
changing its contents, eliminating the race while preserving the
original intent of forcing a write fault.

Fixes: 0f1631be24bd ("mem: fix page fault trigger")
Cc: stable@dpdk.org

Reported-by: Michal Sieron <michal.sieron@nokia.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 .mailmap                     | 1 +
 lib/eal/linux/eal_memalloc.c | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4d26d9c286..07c49eb32f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1086,6 +1086,7 @@ Michal Mazurek <maz@semihalf.com>
 Michal Michalik <michal.michalik@intel.com>
 Michal Nowak <michal2.nowak@intel.com>
 Michal Schmidt <mschmidt@redhat.com>
+Michal Sieron <michal.sieron@nokia.com>
 Michal Swiatkowski <michal.swiatkowski@intel.com>
 Michal Wilczynski <michal.wilczynski@intel.com>
 Michał Mirosław <michal.miroslaw@atendesoftware.pl> <mirq-linux@rere.qmqm.pl>
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index a39bc31c7b..e73a0c11a6 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -25,6 +25,7 @@
 #include <linux/falloc.h>
 #include <linux/mman.h> /* for hugetlb-related mmap flags */
 
+#include <rte_atomic.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_eal.h>
@@ -597,10 +598,10 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 
 	/* we need to trigger a write to the page to enforce page fault and
 	 * ensure that page is accessible to us, but we can't overwrite value
-	 * that is already there, so read the old value, and write itback.
-	 * kernel populates the page with zeroes initially.
+	 * that is already there.
+	 * Use an atomic OR with zero to touch the page without changing its contents.
 	 */
-	*(volatile int *)addr = *(volatile int *)addr;
+	(void)rte_atomic_fetch_or_explicit((int *)addr, 0, rte_memory_order_relaxed);
 
 	iova = rte_mem_virt2iova(addr);
 	if (iova == RTE_BAD_PHYS_ADDR) {
-- 
2.53.0

