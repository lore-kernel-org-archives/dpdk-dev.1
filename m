Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C233AC83F1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 13:32:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF60D40E1E;
	Wed, 23 Jul 2025 15:32:45 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id B003440DFB
 for <dev@dpdk.org>; Wed, 23 Jul 2025 15:32:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753277563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AS3qLt/1kAGHiJ4lpmxBuKNjsb7wMZOZW6QZ+CSumwg=;
 b=QhvSh+VUIkJSQeaiUaVQshgGEKiBpuPyJISoRWhcPPAGF6CopK1Y7Z3VTZvuipZ/VoN94D
 ckQ+X/Kcu7FKr562J48nVxKmf2nAlZi6vXP/iH7mcPhWUKeKIbp+W2LHDaSndN0SxtacrD
 5TtRq4GSWzCdFLBOOvY57IvE5pcJ+Ms=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-126-LM_eQurkNyKre9LT_aXO3A-1; Wed,
 23 Jul 2025 09:32:38 -0400
X-MC-Unique: LM_eQurkNyKre9LT_aXO3A-1
X-Mimecast-MFC-AGG-ID: LM_eQurkNyKre9LT_aXO3A_1753277557
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 344A518009DA; Wed, 23 Jul 2025 13:32:24 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.51])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B137C180045B; Wed, 23 Jul 2025 13:32:21 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Marat Khalili <marat.khalili@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v5 03/22] test/mempool: fix test without stack driver
Date: Wed, 23 Jul 2025 15:31:36 +0200
Message-ID: <20250723133157.159825-4-david.marchand@redhat.com>
In-Reply-To: <20250723133157.159825-1-david.marchand@redhat.com>
References: <20250619071037.37325-1-david.marchand@redhat.com>
 <20250723133157.159825-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vdWgwg7Q6e5wZAw0zP8Nfkk3WGPFrW3PxBPUu8QiWR8_1753277557
X-Mimecast-Originator: redhat.com
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

In a minimal build, the mempool/stack driver is disabled.
Separate the code specific to this external driver and rename unrelated
variables.

Signed-off-by: David Marchand <david.marchand@redhat.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Reviewed-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
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
2.50.0

