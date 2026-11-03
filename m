Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DBB606A31B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 17:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rZpJN8iy
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 234E942788;
	Tue,  3 Nov 2026 18:36:15 +0100 (CET)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com
 [209.85.219.41])
 by mails.dpdk.org (Postfix) with ESMTPS id 48BF940678
 for <dev@dpdk.org>; Tue,  3 Nov 2026 18:36:13 +0100 (CET)
Received: by mail-qv1-f41.google.com with SMTP id
 6a1803df08f44-91bb5795792so53529986d6.2
 for <dev@dpdk.org>; Tue, 03 Nov 2026 09:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793727372; x=1794332172; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f+PsbjA5qXbVKly7lCRvI+SsK45hBh5DqH1w+E0Ikd4=;
 b=rZpJN8iy5PKMinovTzwS7GEB7J0oiR3Vz/TnWjO061BvGPoCL6qkeLGyCwRCElXrNn
 1RZlqFRx1wGg2c7LHbwSkM837RdCkG0DFa2WCio4PY0yxYHmbWlNZr1fKT7ikvDb+gEc
 vbxnWq5vG/B8z+zW2Z78J/s4eej4gEyclzHhfbGj8Tv56zg7vXA2YYmgV9Ad75k2PhTI
 nRTMzdbxYLNqsaaUtO+qFiBA2lw5XEXeaQnZVz9A7AoQiLEbrS4KdOBesM0KapWTjJHF
 AmCyRFdxn7ErGSSIaJlSKFqld6tlb92/dCSyXOITaVS+o6H2VrPjqrRloPtWk0v8+GgL
 AKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793727372; x=1794332172;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f+PsbjA5qXbVKly7lCRvI+SsK45hBh5DqH1w+E0Ikd4=;
 b=GK6lEj6yNza7FN1f6zEueLP5fmsm564puFWmJaLDbiFzb0qhJ0tsvNLDdlsdXiQM3R
 7HW6lRjQr2dwta6RfUswAEw2PSr2cuCYUPFgqzL5iMDlANQxc28PweDXOc+hkV8B6C3d
 RGi308K7jfdO+9+N2wczA5clujrR9EB14ePkv0PPuqBB2hmLMAowXhgv2adfJgRLquFd
 scfS7D3R6k1nre65GWKFjLK+98cMwn6h/5fRbLk6FUWZlDjEVdQ77C6YV5xI4upg9iAf
 3rxZhs1J4KftTZodVEuhXZ2WCNeoICP1Jd8F0jEgaf4fhxny8abUxrJI+NvvQHLxyJq5
 ptfA==
X-Gm-Message-State: APuU4Z+bEHTQV8scLYFfuuN7t4E5Le39kZnc9y8ndXQ7onBWPW67PClh
 zoEy4Iv/TkPvD+JCnLD7eEfI+6RjnRMoqyFQsIW3rXRKOTUDXpMTnDg1x8aok9jC
X-Gm-Gg: AYBFou3ZEXb5nFoh7NfooJhQ+mN0Pcxj8owN6bw4KKtTeUQOlTVFWjHl2gnHrPhvKjk
 ZYkY34PKDAZGEaP460IKGjjqjAV3g7Le0cngXqtcWoAnIphDiXGdL9ZVaL4JskN76MQXWpiMD45
 ECj1ccaQcHGNzSh11LuZ/zDf+tb5aXbNKJz1yM9vinkUfNs6KD6iiU0w0eLhWkrCz6ajqQYaO0s
 MxA4dkqOjfvnfW72fd2u1Bcnukak1Be07/Kh/wRsLmUkFD1QWivSCJdSP/AgG+GGI254H6pBbTP
 C9ttoat9c04T/Yj8tK0plK7w8tWSjAL6YIfHuqtbBmEoAx1ViIbLW1+HWML0eDobo/PoIl7W8uG
 5osSMvKUS/sVQwfJ6woRpZ0Wnz6Yx/lku3EOGsjmvfHbM0pXqkzfsEphfihMt7ALPmCLvcwOxwt
 iviAKl2cVoY9t+weccgy07LeA5tIhxjvml0kH4yOqNQY3PDtl1MOyKH/bHjD4f21JDxrp9phAOn
 7XKHBcpeWePGT7lhl3y9VdSIiuKQUw80cmFCgj7feOUYIE+Gqcr++JlAmJZp4T2xLAx9Z7ZknUR
 gOue7DwenJ3QI1Kk3OgrQDGCjE8H74ZDz+ZxNZLvZiU1LJFMQTTL956/yTrOJKDKI5j6TIJ+nJz
 ZXtQato3eUCV7ZnIAZIkjj8oOWxNXxwvGAmqcHUN5wNqBJkQRJL14rvCWAy3BoAJaNvPFWSy/Mc
 1C
X-Received: by 2002:a05:620a:4001:b0:93f:4f87:4f5e with SMTP id
 af79cd13be357-9442175bcecmr2443558285a.72.1793727372128; 
 Tue, 03 Nov 2026 09:36:12 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-945d33c0052sm15113385a.8.2026.11.03.09.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:36:10 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v2 1/3] mempool: fix race between list walk and free
Date: Tue,  3 Nov 2026 12:35:41 -0500
Message-Id: <20261103173543.130142-2-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261103173543.130142-1-rsanford2@gmail.com>
References: <20261103011107.3658840-1-rsanford2@gmail.com>
 <20261103173543.130142-1-rsanford2@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

rte_mempool_walk(), rte_mempool_lookup() and rte_mempool_list_dump()
traverse the mempool list holding only the mempool list lock.
rte_mempool_create_empty() inserts into the list holding both the
mempool list lock and the tailq lock, but rte_mempool_free() unlinks
and frees the list entry holding only the tailq lock. So a mempool can
be unlinked and freed, together with its list entry, while another
thread is walking the list. The walker then reads freed memory. Since
freed heap memory is zeroed, the walk callback is passed a NULL
mempool, or rte_mempool_lookup() compares the name of one, and the
process crashes.

Take the mempool list lock in rte_mempool_free() as well, in the same
order as rte_mempool_create_empty(). As a result, a rte_mempool_walk()
callback must not free a mempool, as it already could not create one.
Document this.

Fixes: a3791ff0a3f8 ("mempool: introduce a function to free a pool")
Cc: stable@dpdk.org

Signed-off-by: Robert Sanford <rsanford@akamai.com>
Reviewed-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mempool/rte_mempool.c | 8 ++++++++
 lib/mempool/rte_mempool.h | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 069aabaa70..d9f339a3c2 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -729,6 +729,13 @@ rte_mempool_free(struct rte_mempool *mp)
 		return;
 
 	mempool_list = RTE_TAILQ_CAST(rte_mempool_tailq.head, rte_mempool_list);
+	/*
+	 * Take the mempool list lock as well, like rte_mempool_create_empty(),
+	 * so that the entry is not unlinked and freed while
+	 * rte_mempool_walk(), rte_mempool_lookup() or rte_mempool_list_dump()
+	 * is traversing the list.
+	 */
+	rte_mcfg_mempool_write_lock();
 	rte_mcfg_tailq_write_lock();
 	/* find out tailq entry */
 	TAILQ_FOREACH(te, mempool_list, next) {
@@ -741,6 +748,7 @@ rte_mempool_free(struct rte_mempool *mp)
 		rte_free(te);
 	}
 	rte_mcfg_tailq_write_unlock();
+	rte_mcfg_mempool_write_unlock();
 
 	mempool_event_callback_invoke(RTE_MEMPOOL_EVENT_DESTROY, mp);
 	rte_mempool_trace_free(mp);
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index b34cd893b1..bd58d8a9d5 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1947,6 +1947,9 @@ uint32_t rte_mempool_calc_obj_size(uint32_t elt_size, uint32_t flags,
 /**
  * Walk list of all memory pools
  *
+ * The mempool list is locked while the iterator function runs, so the
+ * iterator function must not create or free a mempool.
+ *
  * @param func
  *   Iterator function
  * @param arg
-- 
2.34.1

