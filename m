Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDBC606A335
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 19:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=OH4Ow4Qq
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6921E4028E;
	Fri, 13 Nov 2026 20:44:36 +0100 (CET)
Received: from mail-vs1-f99.google.com (mail-vs1-f99.google.com
 [209.85.217.99])
 by mails.dpdk.org (Postfix) with ESMTPS id 7629240264
 for <dev@dpdk.org>; Fri, 13 Nov 2026 20:44:35 +0100 (CET)
Received: by mail-vs1-f99.google.com with SMTP id
 ada2fe7eead31-7cc1cf48a39so397920137.1
 for <dev@dpdk.org>; Fri, 13 Nov 2026 11:44:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794599074; x=1795203874;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=tzJqW1F4ao15+a0Led8oKSFHtrOOIvH6TdTDKWQ1KII=;
 b=z9LbOe/2KpgrYHBbmNAiWBJYbxXsybFEDQUkGRfvshm+eeUtuBEvHmaTnu7mmU6c4m
 NC3z6oQK/HgrbYKNNTvnrSsILeMoOA5ozJBFC+bjjdZAJDZz0uR1k6jhQFvE9GTjjKwL
 mwBIO7gLXdiLaqIn2dnwL3u7w6s4DInVabioWzxFaoY73y1q3ylLGNpSCoxF7ANh3/Ui
 sfVTgZsgN5S6fbnJrRSH19zWQysDaEn6HUqoWlCL272y60B0yz1ai576ngE+2cu9WtJM
 H94HMXbaSMXT2rYmbxPqLcZwXjqxEoTzD7u3zdT/N1ohc5Wnq2jWL66zvij9nLPya3tg
 2JMA==
X-Gm-Message-State: APuU4Z9yW00s1y2L9Lgx9j42dx9icmapOLB+PF0G+DIwodAt2geHcXKv
 G/OnUNSyi9/lDgp4hZwKRqSCoiNO6+V+1tvuHG0+AvCOH+O8xfmznc1dtCbsa3GAquxkon5kgHu
 HzOmgB1Go3cnyo0RUEtUIYqDUbLhhs0EkQr6U66IvUavE9oebgYoxQ9jC8oU6NrLIv7cLokFawp
 xoT1domsep5TlPSGvu9qAt5oNyXV/GEK4gP/tMmqtOwW/vwovoHHCCjIrOCAFceOEto+mS/GXog
 dtIWw==
X-Gm-Gg: AYBFou3rRKu4XGVRg3pLrrkjsO5cQ2sijhYwjIKnLfPBnvJnftyH5GiLNbwTT1r3IPP
 4Bdivvq9vcvokXtHBntlxQwOrUt5uiJly6FQ2r0kp/W3YzsdTE0tsDOOz7HZgPCW/eGjm5+CW2e
 sLnBx0Mr/rRdRDkh/UvccRQ5/z7vCtT7t5r/bJOodmqKxhCVksqrOApoU4W9VPy0MuQyHLJ+IQD
 pCgctgWI1numOXOX7E8Soy1OkQS0GAbqcZhsuR0Jc9Q8od9Ey/4NkcP0PfvjQlLyXtaJEZWwaoN
 wLJ6IhlpDObXoO6Vzyo4tUEyqPSDL+/Cl2wBlE7SH3+ZlggYrIjdWeGOKUOflntmUaw6AWb/M/y
 +UtPQvaKDS77cOIj3/9kShmnaa5ccFXx0FUBsaTE3l3LOZX1K7eAytwNXKvkz6JLqdNnAudK2KA
 tMN70ivtmWjfLxmJvbGiMtxtZhj9JmZsAP/iEZzdNg4IzoZw==
X-Received: by 2002:a05:6102:54a3:b0:7d2:7266:2c71 with SMTP id
 ada2fe7eead31-7d64d12f547mr1172456137.0.1794599073898; 
 Fri, 13 Nov 2026 11:44:33 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com
 (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
 by smtp-relay.gmail.com with ESMTPS id
 ada2fe7eead31-7d64c4cc5aesm95426137.20.2026.11.13.11.44.33
 for <dev@dpdk.org>
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 13 Nov 2026 11:44:33 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-945b0154705so224779985a.3
 for <dev@dpdk.org>; Fri, 13 Nov 2026 11:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1794599073; x=1795203873; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tzJqW1F4ao15+a0Led8oKSFHtrOOIvH6TdTDKWQ1KII=;
 b=OH4Ow4QquOLaFU2SSaBVvCu/HmozdkA6H5MVbkbKuDQ/dK+5iMY7d66r1zeU9IJhaJ
 T9lVHLVimxcQoR4wUNxNUJ06GCrcn9oCWlpeJm+15ur4/vMEfB0q88K7UYy86C/+lU7W
 BmyndTaJGOtRK8K1XHazB6tlvvOeWkK4taPfs=
X-Received: by 2002:a05:620a:28c9:b0:940:ed10:aedb with SMTP id
 af79cd13be357-9494bac431amr590448485a.30.1794599072745; 
 Fri, 13 Nov 2026 11:44:32 -0800 (PST)
X-Received: by 2002:a05:620a:28c9:b0:940:ed10:aedb with SMTP id
 af79cd13be357-9494bac431amr590444785a.30.1794599072107; 
 Fri, 13 Nov 2026 11:44:32 -0800 (PST)
Received: from accvda5707.acc.broadcom.net ([192.19.144.250])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c870f31sm257145185a.27.2026.11.13.11.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 11:44:31 -0800 (PST)
From: Kishore Padmanabha <kishore.padmanabha@broadcom.com>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 1/3] mempool: remove assumptions on maximum cache size
Date: Fri, 13 Nov 2026 14:44:26 -0500
Message-ID: <20261113194428.1954550-1-kishore.padmanabha@broadcom.com>
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
Reviewed-by: Morten Brorup <mb@smartsharesystems.com>
---
v2:
* Added Reviewed-by tag, no code change.

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

