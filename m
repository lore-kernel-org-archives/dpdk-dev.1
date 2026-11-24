Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47B7606A336
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 18:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AH6O8mTv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAF8D40664;
	Tue, 24 Nov 2026 19:03:40 +0100 (CET)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 1F4694069D
 for <dev@dpdk.org>; Tue, 24 Nov 2026 19:03:40 +0100 (CET)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4ad6219f7d8so4196405f8f.0
 for <dev@dpdk.org>; Tue, 24 Nov 2026 10:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795543420; x=1796148220; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tXKQfd1u+s+hbBuo03s11wI/S7GY1vkh+8KVfh0UbYk=;
 b=AH6O8mTvvVvzgZC6cQ1/sZ5wkRpSWOYBtAdpm10OgqI11jZIbSIdynyhWCfBFAjE5X
 ZSAh4h1cIQssydf8TtmpB3RtbQqj9SYLn/njGNKk9YER/myv7XXfqTb7jCCdaLUD2vpR
 T0BudCJYX6Cr5vVt4YMtxA0JtqLQjRVSiJpDmwJSlo9BnqJUMS4frrbLfrck3b0YHH/T
 J6kHfjW+aVNDdGyfn/1JtwLAGaiDa8A5Xlea8sg/GTqEoZWSziS0X+aPqYIBngPBXoEl
 eiaFAPRyDPBmN0aK6/GhirhwyUFz+PfCab8vQKeBwkPZcFvNSHNQNb0t7OPv9L4gcv+6
 0vBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795543420; x=1796148220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tXKQfd1u+s+hbBuo03s11wI/S7GY1vkh+8KVfh0UbYk=;
 b=ZSPlYwE87GjoUQEvLuDBRlU8zmmLloHqEQJkfpO5dgnoRXqhZQrx8WN7lruyjNYFIH
 gYZdcsl+eacasWRspv+GFkVWBlyPmO9IAN/kgao4TFbptRREZrOjCfOurokffwh/fHqz
 xpG61vEQwRr0cBJ4l5aBxhvsLWvCV3RS6Ie1fPOBrYEuW+R72o6cOVhKg8L/1HQIj5eF
 Wt/PXMyTXMhXFdKAvWzj2uEp6tIaMunUznBsZ3e+K6OymGXD1YPLwBEc/RGvs94a8onz
 6scvU191ukxE0VZ5VfeRCXyApLdOXfjClOmdk5vXKdJtwXtf0jZuReBN8sXPcEgpDqh9
 wIUw==
X-Gm-Message-State: APuU4Z8lvE418Dek3wSqh+ivaSd7MsBJDUsza2b7YrzB8tczSewJfQUj
 wjF5Pdlb+n03GscnS5XtG18YSEvexV3zIog1RZ6Hrq2tMxZdGmW53cYk
X-Gm-Gg: AZFdTZfISsIwcauBvCrDx0HgOHij+wI4lwvmA7tdaxEjkBkI/H1I1MSeSQzc1vVu85h
 5ak0hpS6InJe4FRCfXN/Ymcf2RESYxfb7PHgQ21RDL6rynfDjhpzAJP/0qt7/v4fAECc4bLgsz7
 4HysmCwZj0fw57UNPWpLR0g7yorp74pDLkPuKJarh4VMpXKYkIvdNYbwX3NnjBLxl7dQg087/Sq
 2TMXsw3SQGobQn+nWH/bE4h0N4ZEoLlzMZJNm4f7XrCZ9tw3Xd9br/RM8BYDOya05M4yQow6W9n
 NMuXeoa6K1fgze6SpENPgMfBu7BDYaayfM8gC9o8nqYXQgJ0Q2opzPD9FSSBYJGTaNWXqQy/hWX
 2+BdQZ4loUM826VeR9YX/AI2J7J4g741bCsBbwUmh2P7sQnI2M+aq7YBKTD2Y50x1IQCNQAnkrQ
 Dnv0WdY2cbRyvkW+jp2bdoju7+lJ6GSaBfcnitMWpMDTgEiSm3OamDt1V6nv1AKcAz+oIn+y+/7
 Qgpn2/SklMfnzBQnBPMFyrzAyiBqorgFe46r2TC2iMC4S2NlEXCwTYAgUaI0r5dVkI69W6tSOXE
 CCbOGz5umUtYDrUUVr4jzMO8wDfxuGACvsXaTLK3dNqKLl2zclWYhwXBsBhn
X-Received: by 2002:a05:6000:22c2:b0:4ad:5e91:8fcb with SMTP id
 ffacd0b85a97d-4ad5e918ff5mr32823549f8f.25.1795543419617; 
 Tue, 24 Nov 2026 10:03:39 -0800 (PST)
Received: from freepad.home ([2a01:e0a:1248:bd70:ee15:c1ae:fed0:c345])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bc8ce06sm28775426f8f.47.2026.11.24.10.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:03:39 -0800 (PST)
Sender: Maxime Leroy <maxime.leroys@gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
To: vladimir.medvedkin@intel.com
Cc: dev@dpdk.org,
	rjarry@redhat.com,
	Maxime Leroy <maxime@leroys.fr>
Subject: [RFC v2 09/13] fib: add tbl8 pool stats API
Date: Tue, 24 Nov 2026 19:02:45 +0100
Message-ID: <20261124180249.1099506-10-maxime@leroys.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124180249.1099506-1-maxime@leroys.fr>
References: <20260331214117.142495-1-maxime@leroys.fr>
 <20261124180249.1099506-1-maxime@leroys.fr>
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add rte_fib_tbl8_pool_get_stats() to retrieve the number of used and
total tbl8 groups from a pool handle directly, without going through
a FIB instance.

Signed-off-by: Maxime Leroy <maxime@leroys.fr>
---
 doc/guides/prog_guide/fib_lib.rst |  3 +++
 lib/fib/fib_tbl8_pool.c           | 17 +++++++++++++++++
 lib/fib/rte_fib_tbl8_pool.h       | 20 ++++++++++++++++++++
 3 files changed, 40 insertions(+)

diff --git a/doc/guides/prog_guide/fib_lib.rst b/doc/guides/prog_guide/fib_lib.rst
index 9623ffd44b..5d421c7fbd 100644
--- a/doc/guides/prog_guide/fib_lib.rst
+++ b/doc/guides/prog_guide/fib_lib.rst
@@ -160,6 +160,9 @@ variable, attached with ``rte_fib_tbl8_pool_rcu_qsbr_add()``, or by the first
 The previous array is freed once the readers are done with it.
 The pool never shrinks.
 
+``rte_fib_tbl8_pool_get_stats()`` returns the number of tbl8 groups taken
+from the pool, its current capacity and its maximum capacity.
+
 The pool is not thread safe: the updates of all the FIBs sharing it,
 their creation and their destruction must be serialized by the caller.
 
diff --git a/lib/fib/fib_tbl8_pool.c b/lib/fib/fib_tbl8_pool.c
index 2ea1484c29..3251647d11 100644
--- a/lib/fib/fib_tbl8_pool.c
+++ b/lib/fib/fib_tbl8_pool.c
@@ -346,3 +346,20 @@ rte_fib_tbl8_pool_rcu_qsbr_add(struct rte_fib_tbl8_pool *pool,
 	pool->v = cfg->v;
 	return 0;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fib_tbl8_pool_get_stats, 27.03)
+int
+rte_fib_tbl8_pool_get_stats(struct rte_fib_tbl8_pool *pool,
+			    uint32_t *used, uint32_t *total, uint32_t *max)
+{
+	if (pool == NULL)
+		return -EINVAL;
+
+	if (used != NULL)
+		*used = pool->pool_pos;
+	if (total != NULL)
+		*total = pool->num_tbl8s;
+	if (max != NULL)
+		*max = pool->max_tbl8s;
+	return 0;
+}
diff --git a/lib/fib/rte_fib_tbl8_pool.h b/lib/fib/rte_fib_tbl8_pool.h
index c9354cdbad..28201d833f 100644
--- a/lib/fib/rte_fib_tbl8_pool.h
+++ b/lib/fib/rte_fib_tbl8_pool.h
@@ -132,6 +132,26 @@ int
 rte_fib_tbl8_pool_resize(struct rte_fib_tbl8_pool *pool,
 			 uint32_t new_num_tbl8);
 
+/**
+ * Retrieve tbl8 pool statistics.
+ *
+ * @param pool
+ *   Pool handle
+ * @param used
+ *   Number of tbl8 groups taken from the pool, including those waiting
+ *   in an RCU defer queue (can be NULL)
+ * @param total
+ *   Total number of tbl8 groups (current capacity, can be NULL)
+ * @param max
+ *   Maximum number of tbl8 groups (0 = fixed, can be NULL)
+ * @return
+ *   0 on success, -EINVAL if pool is NULL
+ */
+__rte_experimental
+int
+rte_fib_tbl8_pool_get_stats(struct rte_fib_tbl8_pool *pool,
+			    uint32_t *used, uint32_t *total, uint32_t *max);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.43.0

