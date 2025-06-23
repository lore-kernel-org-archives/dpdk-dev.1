Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0742AC77B7F
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Jun 2025 13:53:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A78434066A;
	Mon, 23 Jun 2025 15:53:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 4A1E440664
 for <dev@dpdk.org>; Mon, 23 Jun 2025 15:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750686785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ImnNfVTBBCNThDstYuii/li9gp2xkkxGV98Ze4+goEQ=;
 b=At2ED34HMhjdLrtk2JmCnEXPojVghpv5ECq55LGstu5GeFxZbj26H2hWhfunG/+hhwSNZ/
 4LNH7W+0tB83HzYKiTKs/fBYmdM+ab+Cwx1Fho3iU1ewLqOLSczz5HH1xhdYEk25mUL2ub
 8M2sBqUVzTGYMsVrCznl5TTkusafHgU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-vEBUXrbBMXuVsPPOJ0YVJQ-1; Mon,
 23 Jun 2025 09:53:04 -0400
X-MC-Unique: vEBUXrbBMXuVsPPOJ0YVJQ-1
X-Mimecast-MFC-AGG-ID: vEBUXrbBMXuVsPPOJ0YVJQ_1750686783
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 353961956046; Mon, 23 Jun 2025 13:53:03 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.32.240])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 58F5E18046C3; Mon, 23 Jun 2025 13:53:01 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2 03/10] test/mempool: fix test without stack driver
Date: Mon, 23 Jun 2025 15:52:33 +0200
Message-ID: <20250623135242.461965-4-david.marchand@redhat.com>
In-Reply-To: <20250623135242.461965-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250623135242.461965-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J0AMVbTJDO3BD9_blfilGiNbsyWkm-Wnt0JLbAe2tBQ_1750686783
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

In a minimal build, the mempool/stack driver is disabled.
Separate the code specific to this external driver and rename unrelated
variables.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 app/test/test_mempool.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/app/test/test_mempool.c b/app/test/test_mempool.c
index 61385e096e..63356998fd 100644
--- a/app/test/test_mempool.c
+++ b/app/test/test_mempool.c
@@ -847,9 +847,11 @@ test_mempool(void)
 	size_t alignment = 0;
 	struct rte_mempool *mp_cache = NULL;
 	struct rte_mempool *mp_nocache = NULL;
-	struct rte_mempool *mp_stack_anon = NULL;
-	struct rte_mempool *mp_stack_mempool_iter = NULL;
+	struct rte_mempool *mp_anon = NULL;
+	struct rte_mempool *mp_mempool_iter = NULL;
+#ifdef RTE_MEMPOOL_STACK
 	struct rte_mempool *mp_stack = NULL;
+#endif
 	struct rte_mempool *default_pool = NULL;
 	struct rte_mempool *mp_alignment = NULL;
 	struct mp_data cb_arg = {
@@ -884,28 +886,28 @@ test_mempool(void)
 	}
 
 	/* create an empty mempool  */
-	mp_stack_anon = rte_mempool_create_empty("test_stack_anon",
+	mp_anon = rte_mempool_create_empty("test_anon",
 		MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE,
 		RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
 		SOCKET_ID_ANY, 0);
 
-	if (mp_stack_anon == NULL)
+	if (mp_anon == NULL)
 		GOTO_ERR(ret, err);
 
 	/* populate an empty mempool */
-	ret = rte_mempool_populate_anon(mp_stack_anon);
+	ret = rte_mempool_populate_anon(mp_anon);
 	printf("%s ret = %d\n", __func__, ret);
 	if (ret < 0)
 		GOTO_ERR(ret, err);
 
 	/* Try to populate when already populated */
-	ret = rte_mempool_populate_anon(mp_stack_anon);
+	ret = rte_mempool_populate_anon(mp_anon);
 	if (ret != 0)
 		GOTO_ERR(ret, err);
 
 	/* create a mempool  */
-	mp_stack_mempool_iter = rte_mempool_create("test_iter_obj",
+	mp_mempool_iter = rte_mempool_create("test_iter_obj",
 		MEMPOOL_SIZE,
 		MEMPOOL_ELT_SIZE,
 		RTE_MEMPOOL_CACHE_MAX_SIZE, 0,
@@ -913,20 +915,21 @@ test_mempool(void)
 		my_obj_init, NULL,
 		SOCKET_ID_ANY, 0);
 
-	if (mp_stack_mempool_iter == NULL)
+	if (mp_mempool_iter == NULL)
 		GOTO_ERR(ret, err);
 
 	/* test to initialize mempool objects and memory */
-	nb_objs = rte_mempool_obj_iter(mp_stack_mempool_iter, my_obj_init,
+	nb_objs = rte_mempool_obj_iter(mp_mempool_iter, my_obj_init,
 			NULL);
 	if (nb_objs == 0)
 		GOTO_ERR(ret, err);
 
-	nb_mem_chunks = rte_mempool_mem_iter(mp_stack_mempool_iter,
+	nb_mem_chunks = rte_mempool_mem_iter(mp_mempool_iter,
 			test_mp_mem_init, &cb_arg);
 	if (nb_mem_chunks == 0 || cb_arg.ret < 0)
 		GOTO_ERR(ret, err);
 
+#ifdef RTE_MEMPOOL_STACK
 	/* create a mempool with an external handler */
 	mp_stack = rte_mempool_create_empty("test_stack",
 		MEMPOOL_SIZE,
@@ -947,6 +950,7 @@ test_mempool(void)
 		GOTO_ERR(ret, err);
 	}
 	rte_mempool_obj_iter(mp_stack, my_obj_init, NULL);
+#endif /* RTE_MEMPOOL_STACK */
 
 	/* Create a mempool based on Default handler */
 	printf("Testing %s mempool handler\n", default_pool_ops);
@@ -1077,9 +1081,11 @@ test_mempool(void)
 	if (test_mempool_same_name_twice_creation() < 0)
 		GOTO_ERR(ret, err);
 
+#ifdef RTE_MEMPOOL_STACK
 	/* test the stack handler */
 	if (test_mempool_basic(mp_stack, 1) < 0)
 		GOTO_ERR(ret, err);
+#endif
 
 	if (test_mempool_basic(default_pool, 1) < 0)
 		GOTO_ERR(ret, err);
@@ -1105,9 +1111,11 @@ test_mempool(void)
 err:
 	rte_mempool_free(mp_nocache);
 	rte_mempool_free(mp_cache);
-	rte_mempool_free(mp_stack_anon);
-	rte_mempool_free(mp_stack_mempool_iter);
+	rte_mempool_free(mp_anon);
+	rte_mempool_free(mp_mempool_iter);
+#ifdef RTE_MEMPOOL_STACK
 	rte_mempool_free(mp_stack);
+#endif
 	rte_mempool_free(default_pool);
 	rte_mempool_free(mp_alignment);
 
-- 
2.49.0

