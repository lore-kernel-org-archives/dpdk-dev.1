Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A702BC0219D
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 21:32:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0810440612;
	Mon, 10 Feb 2025 22:32:29 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id BA010402E6
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:32:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739223146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zb2+k5k9GMYad/LaTNZ71qbITh3aicshGCu9RU4U7Fs=;
 b=T11n6A/Zf36JGm6WxMzmBkw5ZDSdzd7rxEQ4wQ35ozFloiQ2e/0qh5kFdP7tfaSwI5Er/U
 ufTONsXIKmr8UYWNvgb6AD1DgbaJUhSyGPaAYo2CfPRThkycflkeZlW0TisFusXsib+pNy
 Mc8y6iXFc2cqk84Yvo8/z0y21Q3Qtes=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-Rxxk78G_OpOF55u1vJYhVA-1; Mon,
 10 Feb 2025 16:32:21 -0500
X-MC-Unique: Rxxk78G_OpOF55u1vJYhVA-1
X-Mimecast-MFC-AGG-ID: Rxxk78G_OpOF55u1vJYhVA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C523D1955D65; Mon, 10 Feb 2025 21:32:18 +0000 (UTC)
Received: from dmarchan.com (unknown [10.44.32.76])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A037C195608D; Mon, 10 Feb 2025 21:32:13 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, frode.nordahl@canonical.com,
 mattias.ronnblom@ericsson.com, anatoly.burakov@intel.com, stable@dpdk.org,
 Tyler Retzlaff <roretzla@linux.microsoft.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v3 2/5] random: defer seeding to EAL init
Date: Mon, 10 Feb 2025 22:31:55 +0100
Message-ID: <20250210213158.4165701-3-david.marchand@redhat.com>
In-Reply-To: <20250210213158.4165701-1-david.marchand@redhat.com>
References: <20241205175754.1673888-1-david.marchand@redhat.com>
 <20250210213158.4165701-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Q2isvl-jkx66kREusn5BaTyorjgtuASFoj8D1GYcXZY_1739223140
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

The RNG is documented as being seeded as part of EAL init.

Move the initialisation (seeding) helper out of a constructor and
call it explicitly from rte_eal_init() as it was done before commit
3f002f069612 ("eal: replace libc-based random generation with LFSR").

This also moves the unconditional lcore variable allocation out of a
constructor.

While at it, mark local symbol rand_state as static.

Fixes: 29c39cd3d54d ("random: keep PRNG state in lcore variable")
Cc: stable@dpdk.org

Signed-off-by: David Marchand <david.marchand@redhat.com>
Reviewed-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
Acked-by: Anatoly Burakov <anatoly.burakov@intel.com>
Acked-by: Frode Nordahl <frode.nordahl@canonical.com>
---
Changes since v2:
- added assert in rte_s?rand(),

Changes since v1:
- updated commitlog,

---
 lib/eal/common/eal_private.h |  6 ++++++
 lib/eal/common/rte_random.c  | 12 +++++++++---
 lib/eal/freebsd/eal.c        |  2 ++
 lib/eal/linux/eal.c          |  2 ++
 lib/eal/windows/eal.c        |  2 ++
 5 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/lib/eal/common/eal_private.h b/lib/eal/common/eal_private.h
index b2a80dbec8..04ba8ddb86 100644
--- a/lib/eal/common/eal_private.h
+++ b/lib/eal/common/eal_private.h
@@ -702,6 +702,12 @@ eal_get_internal_configuration(void);
 rte_usage_hook_t
 eal_get_application_usage_hook(void);
 
+/**
+ * Initialise random subsystem.
+ */
+void
+eal_rand_init(void);
+
 /**
  * Instruct primary process that a secondary process wants to attach.
  */
diff --git a/lib/eal/common/rte_random.c b/lib/eal/common/rte_random.c
index cf0756f26a..8e62578176 100644
--- a/lib/eal/common/rte_random.c
+++ b/lib/eal/common/rte_random.c
@@ -14,6 +14,8 @@
 #include <rte_lcore_var.h>
 #include <rte_random.h>
 
+#include "eal_private.h"
+
 struct __rte_cache_aligned rte_rand_state {
 	uint64_t z1;
 	uint64_t z2;
@@ -22,7 +24,7 @@ struct __rte_cache_aligned rte_rand_state {
 	uint64_t z5;
 };
 
-RTE_LCORE_VAR_HANDLE(struct rte_rand_state, rand_state);
+static RTE_LCORE_VAR_HANDLE(struct rte_rand_state, rand_state);
 
 /* instance to be shared by all unregistered non-EAL threads */
 static struct rte_rand_state unregistered_rand_state;
@@ -129,8 +131,11 @@ struct rte_rand_state *__rte_rand_get_state(void)
 
 	idx = rte_lcore_id();
 
-	if (unlikely(idx == LCORE_ID_ANY))
+	if (unlikely(idx == LCORE_ID_ANY)) {
+		/* Make sure rte_*rand() was called after rte_eal_init(). */
+		RTE_ASSERT(rand_state != NULL);
 		return &unregistered_rand_state;
+	}
 
 	return RTE_LCORE_VAR(rand_state);
 }
@@ -228,7 +233,8 @@ __rte_random_initial_seed(void)
 	return rte_get_tsc_cycles();
 }
 
-RTE_INIT(rte_rand_init)
+void
+eal_rand_init(void)
 {
 	uint64_t seed;
 
diff --git a/lib/eal/freebsd/eal.c b/lib/eal/freebsd/eal.c
index a96bbf5836..d07cff8651 100644
--- a/lib/eal/freebsd/eal.c
+++ b/lib/eal/freebsd/eal.c
@@ -777,6 +777,8 @@ rte_eal_init(int argc, char **argv)
 		return -1;
 	}
 
+	eal_rand_init();
+
 	eal_check_mem_on_local_socket();
 
 	if (rte_thread_set_affinity_by_id(rte_thread_self(),
diff --git a/lib/eal/linux/eal.c b/lib/eal/linux/eal.c
index a6220524a4..b1e63e37fc 100644
--- a/lib/eal/linux/eal.c
+++ b/lib/eal/linux/eal.c
@@ -1173,6 +1173,8 @@ rte_eal_init(int argc, char **argv)
 		return -1;
 	}
 
+	eal_rand_init();
+
 	eal_check_mem_on_local_socket();
 
 	if (rte_thread_set_affinity_by_id(rte_thread_self(),
diff --git a/lib/eal/windows/eal.c b/lib/eal/windows/eal.c
index 5cdc053a02..5c7526f922 100644
--- a/lib/eal/windows/eal.c
+++ b/lib/eal/windows/eal.c
@@ -410,6 +410,8 @@ rte_eal_init(int argc, char **argv)
 		return -1;
 	}
 
+	eal_rand_init();
+
 	if (rte_thread_set_affinity_by_id(rte_thread_self(),
 			&lcore_config[config->main_lcore].cpuset) != 0) {
 		rte_eal_init_alert("Cannot set affinity");
-- 
2.48.1

