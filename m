Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9AA2CC6B38
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 15:40:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B7FC40695;
	Fri, 16 Oct 2026 17:40:00 +0200 (CEST)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by mails.dpdk.org (Postfix) with ESMTP id 7DEF140658
 for <dev@dpdk.org>; Fri, 16 Oct 2026 17:39:58 +0200 (CEST)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2e934449bb0so25926505ad.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 08:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792165197;
 x=1792769997; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ZL6cIQtoMmHT3zDCUvqu8gXpkSVirNYNjmtEgF5egzQ=;
 b=PItHaDPXEUEsUnifV1x5ccm/WL+qhVcxm1vaELH1DbyUnzNbewCf11CBmMZ/AioDTC
 sGtdO49yrGPHGa4ghLXOeOVN+sceXTflBWyB8eFgoNHkpqYUtm9ivvrbh+JrzGUUyRio
 nA3AUTNJh6K5Aq7yWyq9rJh/dEjVioabd/gSAzEGJekm02piw/bO6zje/1E61PNsL4MD
 /4qgVwbOS0ZS+RzBozco+bDqdvtdJtcIKgxH+XRfAD32X4BVflasUh1HV/8Q7ICaJtbJ
 reQJymwoJCPx72jVLHNkmyd92vN8mSIcpfgxKrP/4WsG6xCevaEdSJiXc6/NxNSEISNd
 cn7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792165197; x=1792769997;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ZL6cIQtoMmHT3zDCUvqu8gXpkSVirNYNjmtEgF5egzQ=;
 b=RrF8GWzX8HoKfMDcZbgX/LbQPX8zPjqUIzDJ5I6Tpq9Itfwesw4N1ZNYorVV8AjEPy
 8f43tRQl7MIOMXygGjYaEq13pkWZyUF4r4SbZClCaTGCQVywZo+iXuQawThJ/vytSjeL
 4vlJ5mB/exmyE9xeAO+rISOSmU4wi9eNaHDorpLsYzhSBpxxobR6OFeN2fyznI0APtxu
 w+TL8i/fl2Qp2qyY2+tUvd1K8LSzGaGoXlSKMt8LDIvtn88a0NRQEneeTGkW3fRL1JeO
 Z5oqa2RqzxAB3NyTGQQmJnW8bCCloj2DXCHdV+eyW2W7zjadSsnMeUcpET6dTjUe4gGM
 DTOw==
X-Gm-Message-State: AFq9FYJsZtoZUT4a9LwUpohoTS4q1DQmfIKE6hLW73Afjhk9QcwPSql3
 q73vexNOnA+Q9hrrYoOOo4kh96NJjgHOI8v4w67vdXwnLLCPaL4D3pQyvy3yM3MKxzAz2Fhbcfq
 rAorMSqQ=
X-Gm-Gg: AYBFou3EBtd7+nI+NRBa2f88BeRAu0T9CZ0Z2oNJzUdwlLnQhzzLsQ/EPlzBOhAWd9T
 VZTYkDxHktWYCxjaxRbNyGXhh4c7cji+hRNFr3HdBwoTF/kUHfyO8Vw6cYfTsxTgU3nV6+iH/YI
 K+vHHr+mCpP5pIQSRzwfxM8i39hQg5w9AvDkKX7ovUZ8VDlL1AowOFMlxSWCPFPuhUZ36rkiycy
 6cf9PaDUGKIfxHBKX3wQEcyBTZMcNciord4iyltat3vh7MMMKodyWI7yNlYf8lz9NIg/pgQrCEe
 8HIJCGnNcEIu0yQ2v8aVx+KvypAPvBGv1lt7GjrW2MqsQh+i2uebjuyE+cJan0rOWF4Kl23HQTk
 e7Oiugy+3AKFwZ9ZFdx8Kks84JF1aMjKxgWgJp9CF4KklU9BYYDP16IjcUGpp7A7Jmch+ONm8Yo
 1zS0EhTSt2FT0+JlM5wRozHSMfaF+R2DBXNpq2qpsr51RzP2dpm1gC7pHWyegwQfs0UnPMBAN0N
 1JAWZZCSLZRPVlzGFzNEFC3e6bEnbQJssEdow==
X-Received: by 2002:a17:903:2f87:b0:2e9:4175:3079 with SMTP id
 d9443c01a7336-2e9a69e4360mr3553485ad.21.1792165197410; 
 Fri, 16 Oct 2026 08:39:57 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e97e804cf3sm12214445ad.25.2026.10.16.08.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 08:39:56 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Anurag Mandal <anurag.mandal@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 3/3] fib, rib: fix name prefixes
Date: Fri, 16 Oct 2026 08:38:45 -0700
Message-ID: <20261016153949.2965592-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016153949.2965592-1-stephen@networkplumber.org>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20261016153949.2965592-1-stephen@networkplumber.org>
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

From: Anurag Mandal <anurag.mandal@intel.com>

The RIB library named the mempool holding its nodes "MP_<name>".
That prefix is the one the mempool library itself prepends to
the backing memzone, so the memzone ended up named
"MP_MP_<name>" which is improper.

The FIB library passed its own name unchanged to the underlying
RIB and did not add a prefix to the RIB name.

This patch names each object after its owner.
The node mempool of a RIB is now "RIB_<name>" or "RIB6_<name>",
and the RIB owned by a FIB is now "FIB_<name>" or "FIB6_<name>".

A mempool name is limited to RTE_MEMPOOL_NAMESIZE, which is
shorter than RTE_RIB_NAMESIZE.
The name was passed down silently and an oversized one surfaced
as an opaque rte_mempool_create() failure, so check the derived
name up front and return ENAMETOOLONG instead.
As the prefixes above are added on top of the name, the maximum
length of a name is limited to the following:
RIB : 53 characters
RIB6: 52 characters
FIB : 49 characters
FIB6: 47 characters

Bugzilla ID: 1981 1982
Fixes: 5a5793a5ffa2 ("rib: add RIB library")
Fixes: f7e861e21c46 ("rib: support IPv6")
Fixes: 39e927248416 ("fib: add FIB library")
Fixes: 40d41a8a7b34 ("fib: support IPv6")

Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/rel_notes/release_26_11.rst | 15 +++++++++++++++
 lib/fib/rte_fib.c                      | 16 +++++++++++++---
 lib/fib/rte_fib6.c                     | 16 +++++++++++++---
 lib/rib/rte_rib.c                      | 14 ++++++++++++--
 lib/rib/rte_rib6.c                     | 14 ++++++++++++--
 5 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 0d9465c9e2..e67eb8770f 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -545,6 +545,21 @@ API Changes
   * ``rte_tel_data_add_dict_uint_hex``
   * ``rte_telemetry_register_cmd_arg``
 
+* rib: The node mempool created by ``rte_rib_create()`` and ``rte_rib6_create()``
+  is now named ``RIB_<name>`` and ``RIB6_<name>`` instead of ``MP_<name>``.
+
+* fib: The RIB created by ``rte_fib_create()`` and ``rte_fib6_create()``
+  is now named ``FIB_<name>`` and ``FIB6_<name>``.
+
+* rib, fib: The name of a RIB, RIB6, FIB or FIB6 is used to derive the name of
+  its node mempool, which is bounded by ``RTE_MEMPOOL_NAMESIZE``.
+  As the prefixes above are added on top of the name,
+  the maximum length of a name is the following:
+
+  * RIB  - 53 characters.
+  * RIB6 - 52 characters.
+  * FIB  - 49 characters.
+  * FIB6 - 47 characters.
 
 ABI Changes
 -----------
diff --git a/lib/fib/rte_fib.c b/lib/fib/rte_fib.c
index 184210f380..7a587820ad 100644
--- a/lib/fib/rte_fib.c
+++ b/lib/fib/rte_fib.c
@@ -37,6 +37,9 @@ EAL_REGISTER_TAILQ(rte_fib_tailq)
 #define FIB_RETURN_IF_TRUE(cond, retval)
 #endif
 
+/* Prefix used for the memory objects owned by a FIB. */
+#define FIB_MEM_PREFIX		"FIB_"
+
 struct rte_fib {
 	char			name[RTE_FIB_NAMESIZE];
 	enum rte_fib_type	type;	/**< Type of FIB struct */
@@ -173,14 +176,21 @@ rte_fib_create(const char *name, int socket_id, struct rte_fib_conf *conf)
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
-	rib = rte_rib_create(name, socket_id, &rib_conf);
+	/* Add FIB Prefix to its mempool name */
+	ret = snprintf(mem_name, sizeof(mem_name), FIB_MEM_PREFIX "%s", name);
+	if (ret < 0 || ret >= (int)sizeof(mem_name)) {
+		FIB_LOG(ERR, "FIB name %s is too long", name);
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
+	rib = rte_rib_create(mem_name, socket_id, &rib_conf);
 	if (rib == NULL) {
 		FIB_LOG(ERR,
-			"Can not allocate RIB %s", name);
+			"Can not allocate RIB for FIB: %s", mem_name);
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "FIB_%s", name);
 	fib_list = RTE_TAILQ_CAST(rte_fib_tailq.head, rte_fib_list);
 
 	rte_mcfg_tailq_write_lock();
diff --git a/lib/fib/rte_fib6.c b/lib/fib/rte_fib6.c
index 770becdb61..1a31ab09aa 100644
--- a/lib/fib/rte_fib6.c
+++ b/lib/fib/rte_fib6.c
@@ -37,6 +37,9 @@ EAL_REGISTER_TAILQ(rte_fib6_tailq)
 #define FIB6_RETURN_IF_TRUE(cond, retval)
 #endif
 
+/* Prefix used for the memory objects owned by a FIB6. */
+#define FIB6_MEM_PREFIX		"FIB6_"
+
 struct rte_fib6 {
 	char			name[RTE_FIB6_NAMESIZE];
 	enum rte_fib6_type	type;	/**< Type of FIB struct */
@@ -172,14 +175,21 @@ rte_fib6_create(const char *name, int socket_id, struct rte_fib6_conf *conf)
 	rib_conf.ext_sz = conf->rib_ext_sz;
 	rib_conf.max_nodes = conf->max_routes * 2;
 
-	rib = rte_rib6_create(name, socket_id, &rib_conf);
+	/* Add FIB6 Prefix to its mempool name */
+	ret = snprintf(mem_name, sizeof(mem_name), FIB6_MEM_PREFIX "%s", name);
+	if (ret < 0 || ret >= (int)sizeof(mem_name)) {
+		FIB_LOG(ERR, "FIB6 name %s is too long", name);
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
+	rib = rte_rib6_create(mem_name, socket_id, &rib_conf);
 	if (rib == NULL) {
 		FIB_LOG(ERR,
-			"Can not allocate RIB %s", name);
+			"Can not allocate RIB6 for FIB6 %s", mem_name);
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "FIB6_%s", name);
 	fib_list = RTE_TAILQ_CAST(rte_fib6_tailq.head, rte_fib6_list);
 
 	rte_mcfg_tailq_write_lock();
diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca..55802f0060 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -32,6 +32,8 @@ EAL_REGISTER_TAILQ(rte_rib_tailq)
 #define RIB_MAXDEPTH		32
 /* Maximum length of a RIB name. */
 #define RTE_RIB_NAMESIZE	64
+/* Prefix used for the memory objects owned by a RIB. */
+#define RIB_MEM_PREFIX		"RIB_"
 
 struct rte_rib_node {
 	struct rte_rib_node	*left;
@@ -417,6 +419,7 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 	struct rte_tailq_entry *te;
 	struct rte_rib_list *rib_list;
 	struct rte_mempool *node_pool;
+	int ret;
 
 	/* Check user arguments. */
 	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0)) {
@@ -424,7 +427,15 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
+	/* Add RIB Prefix to its node mempool name */
+	ret = snprintf(mem_name, sizeof(mem_name), RIB_MEM_PREFIX "%s", name);
+	if (unlikely(ret < 0 || ret >= (int)RTE_MEMPOOL_NAMESIZE)) {
+		RIB_LOG(ERR, "RIB name %s is too long, limit is %zu characters",
+			name, RTE_MEMPOOL_NAMESIZE - sizeof(RIB_MEM_PREFIX));
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
 		sizeof(struct rte_rib_node) + conf->ext_sz, 0, 0,
 		NULL, NULL, NULL, NULL, socket_id, 0);
@@ -435,7 +446,6 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "RIB_%s", name);
 	rib_list = RTE_TAILQ_CAST(rte_rib_tailq.head, rte_rib_list);
 
 	rte_mcfg_tailq_write_lock();
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index 918ddbdfd3..7d9a0ba36f 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -24,6 +24,8 @@
 #define RTE_RIB_VALID_NODE	1
 /* Maximum length of a RIB6 name. */
 #define RTE_RIB6_NAMESIZE	64
+/* Prefix used for the memory objects owned by a RIB6. */
+#define RIB6_MEM_PREFIX		"RIB6_"
 
 TAILQ_HEAD(rte_rib6_list, rte_tailq_entry);
 static struct rte_tailq_elem rte_rib6_tailq = {
@@ -480,6 +482,7 @@ rte_rib6_create(const char *name, int socket_id,
 	struct rte_tailq_entry *te;
 	struct rte_rib6_list *rib6_list;
 	struct rte_mempool *node_pool;
+	int ret;
 
 	/* Check user arguments. */
 	if (unlikely(name == NULL || conf == NULL || conf->max_nodes <= 0)) {
@@ -487,7 +490,15 @@ rte_rib6_create(const char *name, int socket_id,
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
+	/* Add RIB6 Prefix to its node mempool name */
+	ret = snprintf(mem_name, sizeof(mem_name), RIB6_MEM_PREFIX "%s", name);
+	if (unlikely(ret < 0 || ret >= (int)RTE_MEMPOOL_NAMESIZE)) {
+		RIB_LOG(ERR, "RIB6 name %s is too long, limit is %zu characters",
+			name, RTE_MEMPOOL_NAMESIZE - sizeof(RIB6_MEM_PREFIX));
+		rte_errno = ENAMETOOLONG;
+		return NULL;
+	}
+
 	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
 		sizeof(struct rte_rib6_node) + conf->ext_sz, 0, 0,
 		NULL, NULL, NULL, NULL, socket_id, 0);
@@ -498,7 +509,6 @@ rte_rib6_create(const char *name, int socket_id,
 		return NULL;
 	}
 
-	snprintf(mem_name, sizeof(mem_name), "RIB6_%s", name);
 	rib6_list = RTE_TAILQ_CAST(rte_rib6_tailq.head, rte_rib6_list);
 
 	rte_mcfg_tailq_write_lock();
-- 
2.53.0

