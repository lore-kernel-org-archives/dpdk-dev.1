Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8F8606A32A
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Nov 2026 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HCH9LKng
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0E944270A;
	Thu, 12 Nov 2026 16:44:12 +0100 (CET)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 4FE7C40682
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:44:08 +0100 (CET)
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-91eb7d1478cso43403016d6.0
 for <dev@dpdk.org>; Thu, 12 Nov 2026 07:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794498247; x=1795103047; darn=dpdk.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=f+PsbjA5qXbVKly7lCRvI+SsK45hBh5DqH1w+E0Ikd4=;
 b=HCH9LKnginFXqXq5W6cE5jK2dUCLrCMuhxm17euhsadVYlOpHea4P375BYdoj5vkGR
 nX40ObcJaUwaPlfZaCft34vpiQf+84hCoLYan0xJVRQSm2W6IBMCWMg1lJ33ULUTKu53
 YxlMpXZ0abO/BzmT3rni42gTYiVdJ6RxvrPJDhXz1mbO5BXcy7g8wQn+35MY4LviHGXs
 XXotUN8klagM5HI2XZiAMtLvXp/UKcljp7R46XkaYWEKSvoQ3/rldgk/67v9MvWt+N+b
 yZ3njWbp5l5NDeg5Aq9js5Ydaprmz573EklRU8Kkt73pzJe4DWABfOef6k6ewhFo9aGW
 R32Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794498247; x=1795103047;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=f+PsbjA5qXbVKly7lCRvI+SsK45hBh5DqH1w+E0Ikd4=;
 b=kf6y+ZmLlNeFdJ6/32ugZH0+9prIfi5Om3VF8WrqBWhSNcZNr2lwHi04FrV8Cwub3U
 ZrxNz1YNKVVLwKTYExHPxh6yDykPHRQ/Ufs1DhF+zfuax9mX0qUSe+bQPlQf+DUVvkgv
 S0wNfgwGB+2hOIvtQ57lr72MrdGf889IODl4EYJDKRFOdhLP5GQcXnFv3pc/nU6Lcu/J
 v1Crk8N44lFmO4IvIIj6PfgJvgWxqpWei/wOVBjMf5pHNOvKbiewmSlr65TY12vnS85g
 4AyhviuuPtmqb/uW51bE9Iw+xC1JTMuuokHfdpPpJ3ykkALCiI5Q6jvLOLpvgvXey9XZ
 RBPQ==
X-Gm-Message-State: APuU4Z+HDfeAhosEbSMgGQL3C2NtFiGVpZY8VQ//G/C1zXK1ahudIyxZ
 NwAOXlYIFPoTaq4/EpQccrENE6dxDFgbwUkfj2FIYNC74Qiug2nOyUG/odOygJSE
X-Gm-Gg: AYBFou1tSMM/D3n16NQrWHORcguWVEyXBCjwoFr5OkYg8pBCYOINEkU2rgJn+/Hyckb
 u1hu4WaSbp8kOQRjnVYhrESqaeampTtwzZAh4VMwCnkbTdu9TWilJQH4uio5wnJsLEC1XvVAxcf
 UZMKR15HBRvAdFOBFVB/YOyb15IOZ9lfb/2p/m9TScWCDurcVRAgGhfC4yROY0p/W0Gx73uQatm
 hgrA1Lm4ZNmENiNBsCZm/YosJCGJOwHIG+et+o8pWOiuuicaUsTja5RQClINydxFT9oIIZxHBxz
 kaYYaHyMMUCOmE5ZRr+8GoBoHWH0EaMQVlKkR929RuqFA0c+mU/7IWGuga4jqT3wJRYfwwkt/ZT
 FN2ebYmdAHkyHlh9u6+avIBNBmYHcVOxekzdbC5jWOzqwdkdJqYw/fmy9RwUDIJT9BKoZW3Vdxv
 rXagrakkOiGSmz0RRbBuxfsX3xwx7btJ2u+ckX1tBq6tvOkJZLMxMnQ5BhZtyXsrAtXC71UB/FM
 dmN3zpoWwrpXDog59okWCsMrxfx0wZ0HVvurh48lkqI1XxuGj9xCdGX1gy3NkR7UEnmCpBsvLpF
 pmjusDvM71seDgHq54h1UzUkIsTo3tl/G5QTs7vpzG9J2FPdeKlUhm+AL7wv5qN2vX35CG3WQGr
 xFVdGayvMdxrbBuG/0tyCpQtfpTNaxz9LyyBoXKDQnXSJBqYM/KCAUPk4GgjWq8mdA6fnlw5hBq
 A=
X-Received: by 2002:a05:620a:1707:b0:93c:2c0e:7ac with SMTP id
 af79cd13be357-947b0054268mr927200785a.53.1794498247085; 
 Thu, 12 Nov 2026 07:44:07 -0800 (PST)
Received: from bos-lhvwah.bos01.corp.akamai.com
 (g2001-4878-8037-0700-526b-8dff-fef6-cfbf.deploy.static.akamaitechnologies.com.
 [2001:4878:8037:700:526b:8dff:fef6:cfbf])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-91f02df714csm50400586d6.28.2026.11.12.07.44.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 07:44:06 -0800 (PST)
From: Robert Sanford <rsanford2@gmail.com>
To: dev@dpdk.org
Cc: andrew.rybchenko@oktetlabs.ru, mb@smartsharesystems.com,
 olivier.matz@6wind.com, Robert Sanford <rsanford@akamai.com>,
 stable@dpdk.org
Subject: [PATCH v4 1/3] mempool: fix race between list walk and free
Date: Thu, 12 Nov 2026 10:43:40 -0500
Message-Id: <20261112154342.1484709-2-rsanford2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261112154342.1484709-1-rsanford2@gmail.com>
References: <20261109144054.3784583-1-rsanford2@gmail.com>
 <20261112154342.1484709-1-rsanford2@gmail.com>
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

