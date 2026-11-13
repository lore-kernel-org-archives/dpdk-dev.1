Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4D606A88B
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=dBHwZ4K9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0F16402A4;
	Fri, 13 Nov 2026 16:56:50 +0100 (CET)
Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com
 [209.85.216.100])
 by mails.dpdk.org (Postfix) with ESMTPS id 11A954028E
 for <dev@dpdk.org>; Fri, 13 Nov 2026 16:56:50 +0100 (CET)
Received: by mail-pj1-f100.google.com with SMTP id
 98e67ed59e1d1-3acb11973c3so1776487a91.3
 for <dev@dpdk.org>; Fri, 13 Nov 2026 07:56:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794585408; x=1795190208;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EHvkC+MqDIJ2jA88kzOxsgnh1u49a8hNLi3p4DAigOE=;
 b=Gr2AKyzdDcP6cjwYPzPfwUUa7dH/W8/8QqzQVHbgyj0YjETvVHIyMQOtyApiyA5H46
 p/hppW+lGorcbXa+SzGUKUkMPArb/j/j+Xu+McqjjNrRoyLkVub6QaDcS03C6HfJ3vkH
 dZASb+1Xp4QvhPTZOEkA/KxW5sSdK9cJyyZTE1sR3h//QR6dMXzh3mAxjatAXAx6wh9U
 fKl4hhglAbZZ9zSZNUgFATQ6ropjgGlGmkLqE7fCQHAnO5nk5Ng1kEqX0kTFK3wZ0cSk
 zk7wrngPI/tOr2wcI+wmmDpAPnvOV/W/7XLkvZbxZ4uDUdwbtdKUZ1UHPEjtue5Ie5sV
 LOhA==
X-Gm-Message-State: APuU4Z8RkkkZqoBsJYCCO/C5Sz23elfTB7bHVWUSlnpdVZ5C+Z9Cg51m
 rqTBigzBDXUrreIbmMWZxxJrAXZ2QqY32nR0ANg78md/cdvR4qmtr1Fls3gnVGbRNZIsRtTaWWA
 MJRgifo3PK4u/nNWlwkH6+lAabzd/5/e4xYhCcGl/vSTXpfBnbf/3mJ52o4GYUPob8CCJNEjpr3
 0YXDBC18JH6+oLV+HN4H2QkZN8KJKDrhJAbRg0bV8nXt4WaCfIpIl7j9JXpvFcgeE8QBavcJP8W
 fTMpA==
X-Gm-Gg: AYBFou0KQL2POnII1RGqPRGx/4pEfpVyrolLZIgpaTzaY7vb5VCQva2xFS7zsPP3LY9
 c+tVw0PEaj+mQormbRTu8kaXrkKvbMHq6m3b+IbYkQCgkVXJsEbmpuvanN+fRhhp/uix/PTpFDT
 UcLxpoPlF6hCSkRcfZ9/CbaZubRFyAHYoR9j9pg+0tZm2dL2Qi+Rh2wHk+d3Pc7OgjpBghbzNPF
 3cEaqPxQp1Dyzhg/490CRPSU7aatCLFGc1USCj+zQ8JLXU9v80dXyo8scLKOZg6X2hmqGv71RGH
 lITcTNVBP4nyJY43A5cYnC227QXYNNgZApnp4utizuopZpwrPqa7nQo+I0UJe0GEOEM/EG2FIeO
 h0qrFI3dTABfFqmLneuCQJifyuTRn6aIjNJYuH6+3Vju5A9KIj3E//fxGOHBdnfWNhV31Ss/NvO
 ndOU/21yD2a7oRpkqYGVOdS5zMglJK0hnp30Fen6RyiK0=
X-Received: by 2002:a17:90b:390f:b0:3ac:8446:c1b5 with SMTP id
 98e67ed59e1d1-3b1b0a0fdaemr2679993a91.31.1794585407964; 
 Fri, 13 Nov 2026 07:56:47 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
 by smtp-relay.gmail.com with ESMTPS id
 98e67ed59e1d1-3b197a330f9sm7354411a91.0.2026.11.13.07.56.47
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Nov 2026 07:56:47 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so534103c88.0
 for <dev@dpdk.org>; Fri, 13 Nov 2026 07:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794585406; x=1795190206; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EHvkC+MqDIJ2jA88kzOxsgnh1u49a8hNLi3p4DAigOE=;
 b=dBHwZ4K97gU9g79vI2tyakJDNSw1itJNWrVvkDelOEWRp8d+nLWbu29DbRIzny6iXj
 YlPMoaQ6Cqf0TjKL0BPs9kUUqOQYNcj9+SmWafbWU68kKzsKRRyR8cLI+tgc1YhvVmx+
 0Syk4ElToVpvSvr5d7vMUOSqymGc55+qSIkOI=
X-Received: by 2002:a05:7022:3a06:b0:184:19ee:1fdd with SMTP id
 a92af1059eb24-1b503068266mr2996056c88.5.1794585405774; 
 Fri, 13 Nov 2026 07:56:45 -0800 (PST)
X-Received: by 2002:a05:7022:3a06:b0:184:19ee:1fdd with SMTP id
 a92af1059eb24-1b503068266mr2996013c88.5.1794585404971; 
 Fri, 13 Nov 2026 07:56:44 -0800 (PST)
Received: from accvda5707.acc.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm8386190c88.14.2026.11.13.07.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 07:56:44 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH 1/3] mempool: remove assumptions on maximum cache size
Date: Fri, 13 Nov 2026 10:56:31 -0500
Message-ID: <20261113155633.1883479-1-kishore.padmanabha@broadcom.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since the cache size limit was removed, a mempool cache can be created
with any size up to the number of objects in the mempool.
RTE_MEMPOOL_CACHE_MAX_SIZE is therefore no longer an upper bound for
the cache size, nor for the number of objects in the cache.

The put and get functions still passed assumptions derived from this
constant to the compiler. They are wrong for a cache larger than
RTE_MEMPOOL_CACHE_MAX_SIZE, and violating a compiler assumption is
undefined behavior.

Remove the assumptions based on the constant, and assume that the number
of objects in the cache does not exceed the cache size instead.

Fixes: b815acfdfc48 ("mempool: remove cache size limit")
Signed-off-by: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
---
 lib/mempool/rte_mempool.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index b34cd893b1b6..fa2b9f00d516 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1433,9 +1433,6 @@ rte_mempool_do_generic_put(struct rte_mempool *mp, void * const *obj_table,
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_bulk, 1);
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, put_objs, n);
 
-	__rte_assume(cache->size <= RTE_MEMPOOL_CACHE_MAX_SIZE);
-	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
-	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
 	__rte_assume(cache->len <= cache->size);
 	if (likely(cache->len + n <= cache->size)) {
 		/* Sufficient room in the cache for the objects. */
@@ -1575,7 +1572,7 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	/* The cache is a stack, so copy will be in reverse order. */
 	cache_objs = &cache->objs[cache->len];
 
-	__rte_assume(cache->len <= RTE_MEMPOOL_CACHE_MAX_SIZE);
+	__rte_assume(cache->len <= cache->size);
 	if (likely(n <= cache->len)) {
 		/* The entire request can be satisfied from the cache. */
 		RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
@@ -1600,7 +1597,6 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 		*obj_table++ = *--cache_objs;
 
 	/* Dequeue below would exceed the cache bounce buffer limit? */
-	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
 	if (unlikely(remaining > cache->size / 2))
 		goto driver_dequeue;
 
@@ -1619,8 +1615,6 @@ rte_mempool_do_generic_get(struct rte_mempool *mp, void **obj_table,
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_bulk, 1);
 	RTE_MEMPOOL_CACHE_STAT_ADD(cache, get_success_objs, n);
 
-	__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
-	__rte_assume(remaining <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
 	__rte_assume(remaining <= cache->size / 2);
 	cache_objs = &cache->objs[cache->size / 2];
 	cache->len = cache->size / 2 - remaining;
-- 
2.54.0

