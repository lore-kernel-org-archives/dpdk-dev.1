Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9759CD5BD1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 16:00:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D09664042C;
	Mon,  1 Jun 2026 18:00:24 +0200 (CEST)
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169]) by mails.dpdk.org (Postfix) with ESMTP id 42B4B4025F
 for <dev@dpdk.org>; Mon,  1 Jun 2026 18:00:24 +0200 (CEST)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-307263ad0cbso1009313eec.0
 for <dev@dpdk.org>; Mon, 01 Jun 2026 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780329623;
 x=1780934423; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/sRSAQXa24zUNzsvlwUODZnOFm6QTRckkwcaUdhnM9I=;
 b=QcJ19k8HbdiaUa/EMz+PO/PTAIsFcL9s5P62WLOHYg3ZGAQ5OU1XklXACeY0cmpW42
 9TqLtCqkAHEWYuQ1yAdAPXL30bcMiohlw/MB2witByYLGgnmiLpO08RuqpfLqcqqzAYJ
 N0qhdNkNkySEmBsF16qlE+vjwwZgV4kPTA0QxS2RwZmTSNmtZ1C9gz3zWbRTyoXt2Xvr
 rXakgq6Fts968htH71EX74hnQPB1EemNmtwZZ5V9kH0K8+Ss//O+lTIwt2hG+a0rTWPZ
 f0VX6xfV4uccR6sAWI+SgXyPsap4ZhTnnqN6l3xhgbSVnCHxi4tWX/njL9L92yK9hHSB
 6ksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780329623; x=1780934423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/sRSAQXa24zUNzsvlwUODZnOFm6QTRckkwcaUdhnM9I=;
 b=Eko8ehR595z7yW+CNWVf+3FY3LKk/JfchilbgFg6dJ+0rU68RzYMuK4O9hhBDnXO3w
 LZ7yJsDQ/P50DzOiYMZUfCcqaPrfCq6hawlvddJZjx4kNrbuXcz5NCLgU0rUcj32tAt8
 zAKdoaYiCxH3+lHxDihJh+3jT5OSScoakZ/Y7Brp+/SNE83jcPAKYP2UvK+5wKvXXfui
 W/SzdSswhB4c8C9YAd0ERuMOZKBa6dYyReRtsjyS5EO5+0lrZ5NzJNlYW2GOKYCEBc54
 qi0Fhs0DRZhwQbO+VqTEFrMvSjCk3lW2h77kmdgpDmhMwNtxaR/u353EKwMiM//UHOl+
 keLg==
X-Gm-Message-State: AOJu0YwMD+bGHJHeT2m4Wtdb4jASXs1opycrmoDTJKwkz9l4RAV0N8Qr
 2LMfNCl0M4xjPlZqlVmCEZT3/3Wo+7XurrqYdl8NfYoHZtESHBfrUG26DHuc/hZmklZ5Gq0BYUA
 ItgA+
X-Gm-Gg: Acq92OHvL0hSC5g1Z60Jhn2/GaQo+C0LctNZC66TaaDAWuwW1N6M0cP7BOjpq/+Eq4o
 2e/mYyZLUDX8dH/2G/BSsERYBRsVN0ow2Df/yw+dx9P6YS6xTOSIHjutslMjy782qetfKb/kY2r
 p5ID/I3w8l1pGzLMekKS3O7SM7QKYEKjyYB0hW5cSZVTGbmDWo9uJxiz9IVkD70IzNd9Sb7YRIr
 34ey7hdUhsqE0lT9Q4bMIbP2lqKoBWF7NeuAxrRJpyvDo5W9krJ+202w9xTbKKqye1T6IZ50f+z
 Oe+VZ3EPOkL32d3LPfElpj9ykqjIzsHQuwuvTQAW80az0y0MDiML32Tb1BFeW8Q11p84Z0QsH6+
 HFiKbVtwXnybz7kuV7NeBdigiypmkQlWoE91DwlwK73m/A6/mH0JjXXRD7toh2B48aa1Y++yUEL
 87FfXfx6VVuwUcFBxKa8BHWEzB/w4zSxfpH3hkh8syruS7ccK4Ytgg5l2N4I5vgyC8kvzUKQOE
X-Received: by 2002:a05:7300:cb13:b0:2f1:496c:94d4 with SMTP id
 5a478bee46e88-304fa4a8298mr5297419eec.4.1780329622706; 
 Mon, 01 Jun 2026 09:00:22 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c10c1sm8798906eec.1.2026.06.01.09.00.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 09:00:22 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Michal Sieron <michal.sieron@nokia.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2] eal: fix data race in hugepage prefault
Date: Mon,  1 Jun 2026 09:00:18 -0700
Message-ID: <20260601160019.116067-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520170812.759638-1-stephen@networkplumber.org>
References: <20260520170812.759638-1-stephen@networkplumber.org>
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
 lib/eal/linux/eal_memalloc.c | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/.mailmap b/.mailmap
index 43febb9030..3c45e365d3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1094,6 +1094,7 @@ Michal Mazurek <maz@semihalf.com>
 Michal Michalik <michal.michalik@intel.com>
 Michal Nowak <michal2.nowak@intel.com>
 Michal Schmidt <mschmidt@redhat.com>
+Michal Sieron <michal.sieron@nokia.com>
 Michal Swiatkowski <michal.swiatkowski@intel.com>
 Michal Wilczynski <michal.wilczynski@intel.com>
 Michał Mirosław <michal.miroslaw@atendesoftware.pl> <mirq-linux@rere.qmqm.pl>
diff --git a/lib/eal/linux/eal_memalloc.c b/lib/eal/linux/eal_memalloc.c
index a39bc31c7b..7359a41d3f 100644
--- a/lib/eal/linux/eal_memalloc.c
+++ b/lib/eal/linux/eal_memalloc.c
@@ -25,6 +25,7 @@
 #include <linux/falloc.h>
 #include <linux/mman.h> /* for hugetlb-related mmap flags */
 
+#include <rte_atomic.h>
 #include <rte_common.h>
 #include <rte_log.h>
 #include <rte_eal.h>
@@ -597,10 +598,11 @@ alloc_seg(struct rte_memseg *ms, void *addr, int socket_id,
 
 	/* we need to trigger a write to the page to enforce page fault and
 	 * ensure that page is accessible to us, but we can't overwrite value
-	 * that is already there, so read the old value, and write itback.
-	 * kernel populates the page with zeroes initially.
+	 * that is already there.
+	 * Use an atomic OR with zero to touch the page without changing its contents.
 	 */
-	*(volatile int *)addr = *(volatile int *)addr;
+	(void)rte_atomic_fetch_or_explicit((__rte_atomic uint64_t *)addr, 0,
+					   rte_memory_order_relaxed);
 
 	iova = rte_mem_virt2iova(addr);
 	if (iova == RTE_BAD_PHYS_ADDR) {
-- 
2.53.0

