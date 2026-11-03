Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06CC606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 01:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GDFecWsU
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9964410E8;
	Tue,  3 Nov 2026 02:11:17 +0100 (CET)
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com
 [209.85.222.175])
 by mails.dpdk.org (Postfix) with ESMTPS id 0C1C0410E3
 for <dev@dpdk.org>; Tue,  3 Nov 2026 02:11:17 +0100 (CET)
Received: by mail-qk1-f175.google.com with SMTP id
 af79cd13be357-945ae2daa66so185718885a.0
 for <dev@dpdk.org>; Mon, 02 Nov 2026 17:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793668276; x=1794273076; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=COCwQbPOkfIfYnSfaRCGPgt5h/Kz4rjf2Z59WwGtPXA=;
 b=GDFecWsU25F4xw3oisTWZZJhs+BnujjecylpT/047KbGxc/P33vzbIcz+KXMzq0GH9
 iHAQlRGWb/7RFdO+dGQn4U/uZG+pMu+RToxatjgS4TwqOMNAGgwFUo2g4Wl+e4nXFm1h
 5cxWlicFylPIJEos6hMNtynBhLldCcuCwF0Ci4FZ3EgSpUWRaT3Vu26lxRrK0ZDmHpya
 +I15OR+rLTAt6h0cz+UPgREG8LSvvSaccJabrIZilPXCGu9Y+cGl6DVirw0zD4541dq/
 cqK6K4qCAvQBA7LY9HU/gsghbUFKdYUB+zLowURCsMVzF7M2aTIoe78N+j7EFF1WwLsl
 qHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793668276; x=1794273076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=COCwQbPOkfIfYnSfaRCGPgt5h/Kz4rjf2Z59WwGtPXA=;
 b=rktd3i3DuCRxI5SHq1VQpG/cgEh+UcY7+s5H3+2av1AimsOsuBMn+deIx9Zo2sA4BF
 lQkG0i80o7SdDeoENr6w6UQjmsJPJH4566hYqfZ1PKrTQ5jcVTNOtHa45HHvTfGmBUfG
 0ttRtDTc1+rc+NAkM5RJXqdu7J/HPN/RTuvfy1Nk0fqmcUFGazj0R2IAnwUP3FSBrO+t
 cQdIiYfaVGWdgJrx80GhbXu5j/zTVwj2i0jD+J2LDsIYmx6mPt1QbMIRI7OeRwL87cXy
 OzuVPVTB1UM7LDMGrGLhjysUI+zmv4OzxIk5gBpvuPZc3eM3OoOaIkwKOnHWuqHjDtkj
 QCWQ==
X-Gm-Message-State: AFq9FYLDkgTA2mr7BETEvnHrEEO3+/qrgYyPrHzvtRMrl3n/AKRXiBD3
 jCXd1EikbvEfc0Sj15MRYiIcAAsXs6AUtnOZS9nQPawwx8MIYb41tySpddKz7WbU
X-Gm-Gg: AYBFou35MRuzrs1ntWbYdXM5KVNHdq3SBE+9L8oQ098CyAy4VxTUDCTTMJ0eR1RBCLA
 rdtGS7RNvjG0KK+MT14+Ov/pGhpjtH7B4giZ2ES0imFos2/EVECCEYyXCdDEaholKp4v/LSaXcH
 yRf88C/8dUD6mbmnFPytIEXdktUi3U8OOht6y4s1M9S+vaTkoSIxCowyRpGDDnQTCWFIA3peWnf
 RHXM0uBC/sao7Vqm9duhjt21tpJSfD713/W4klVMehlMbi2gGaLXUlZ7yb6el8yBoYNnMfd/iLU
 DatdZg6+dQ0OIag91B/zE/8/8V5SUQbKUCflOP6UJwGIJOzM00NVlmiNjHMuPX4XawNTIDSiq84
 JEXTV3Cy1jn8OoEIDRoHFTSwNyeYj6FIsb3IBpcm6zzgf6hZNwnnW4rkh/7YOoldPepqTc/fezA
 zjTUyD9jP3dIpX584oGT6YpGOJqY14wr5OXBsdC2V/T7/nsjv3s1HIaz+YonEfpLvb3/ysGRlab
 71IxcqOfAn7tpK9fo/RwW8dDa8A3j+9mFLXqK5D776608iq1JXs0UK+hgk4DkALNrgHAvK0RQsj
 zGPaojwoWnVnnQVdGMiP0yoJreicSrODyb5dtNqbqPg+bs+IpBU1i7/5mBCNP1H/fwwUPHNAkJr
 W/koayFbudmZ2RtpYqNsFLv3Pe+aA2jVB3HDz7z12WX8VOE2305vuvmOfU9q0iCveSUsyLZioXF
 T7
X-Received: by 2002:a05:620a:8007:b0:93e:9792:fd47 with SMTP id
 af79cd13be357-94421585e39mr1689124285a.4.1793668275588; 
 Mon, 02 Nov 2026 17:11:15 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91ca7e2749asm103788266d6.1.2026.11.02.17.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 17:11:14 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v1 2/3] mempool: skip unpopulated pools in walk and dump
Date: Mon,  2 Nov 2026 20:11:06 -0500
Message-Id: <20261103011107.3658840-3-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103011107.3658840-1-rsanford2@gmail.com>
References: <20261103011107.3658840-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Robert Sanford <rsanford@akamai.com>

rte_mempool_create_empty() adds a mempool to the mempool list before
the mempool has a store. The store is allocated, and
RTE_MEMPOOL_F_POOL_CREATED is set, by the first populate call. In
between, rte_mempool_walk() passes the mempool to its callback, and
rte_mempool_list_dump() calls rte_mempool_dump() on it, which reads
the number of objects in the store. With the ring driver this
dereferences a NULL ring, and the process crashes.

Skip mempools that do not have RTE_MEMPOOL_F_POOL_CREATED set in
rte_mempool_walk() and rte_mempool_list_dump(), and document it. The
populating thread sets the flag without holding a lock, so add a
release fence before setting it and an acquire fence after checking
it. A walker that sees the flag then also sees the store.

rte_mempool_lookup() is unchanged. It does not access the store, and
callers may look up a mempool that is not populated yet.

Fixes: 449c49b93a6b ("mempool: support handler operations")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
---
 lib/mempool/rte_mempool.c | 20 +++++++++++++++++++-
 lib/mempool/rte_mempool.h |  3 +++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index d9f339a3c2..7c4d4697c7 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -304,6 +304,12 @@ mempool_ops_alloc_once(struct rte_mempool *mp)
 		ret = rte_mempool_ops_alloc(mp);
 		if (ret != 0)
 			return ret;
+		/*
+		 * rte_mempool_walk() and rte_mempool_list_dump() access the
+		 * store of pools with this flag set. Make the store visible
+		 * before the flag.
+		 */
+		rte_atomic_thread_fence(rte_memory_order_release);
 		mp->flags |= RTE_MEMPOOL_F_POOL_CREATED;
 	}
 	return 0;
@@ -1412,6 +1418,11 @@ rte_mempool_list_dump(FILE *f)
 
 	TAILQ_FOREACH(te, mempool_list, next) {
 		mp = (struct rte_mempool *) te->data;
+		/* skip mempools that are not populated yet */
+		if ((mp->flags & RTE_MEMPOOL_F_POOL_CREATED) == 0)
+			continue;
+		/* pairs with the release fence in mempool_ops_alloc_once() */
+		rte_atomic_thread_fence(rte_memory_order_acquire);
 		rte_mempool_dump(f, mp);
 	}
 
@@ -1460,7 +1471,14 @@ void rte_mempool_walk(void (*func)(struct rte_mempool *, void *),
 	rte_mcfg_mempool_read_lock();
 
 	RTE_TAILQ_FOREACH_SAFE(te, mempool_list, next, tmp_te) {
-		(*func)((struct rte_mempool *) te->data, arg);
+		struct rte_mempool *mp = (struct rte_mempool *) te->data;
+
+		/* skip mempools that are not populated yet */
+		if ((mp->flags & RTE_MEMPOOL_F_POOL_CREATED) == 0)
+			continue;
+		/* pairs with the release fence in mempool_ops_alloc_once() */
+		rte_atomic_thread_fence(rte_memory_order_acquire);
+		(*func)(mp, arg);
 	}
 
 	rte_mcfg_mempool_read_unlock();
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index bd58d8a9d5..7782768a2d 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1907,6 +1907,8 @@ static inline void *rte_mempool_get_priv(struct rte_mempool *mp)
 /**
  * Dump the status of all mempools on the console
  *
+ * Mempools that are not populated yet are skipped.
+ *
  * @param f
  *   A pointer to a file for output
  */
@@ -1949,6 +1951,7 @@ uint32_t rte_mempool_calc_obj_size(uint32_t elt_size, uint32_t flags,
  *
  * The mempool list is locked while the iterator function runs, so the
  * iterator function must not create or free a mempool.
+ * Mempools that are not populated yet are skipped.
  *
  * @param func
  *   Iterator function
-- 
2.34.1

