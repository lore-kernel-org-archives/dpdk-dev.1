Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE09C98309
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 15:53:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B53B942E7E;
	Tue, 22 Sep 2026 17:52:57 +0200 (CEST)
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40]) by mails.dpdk.org (Postfix) with ESMTP id 9F5C342DD0
 for <dev@dpdk.org>; Tue, 22 Sep 2026 17:52:54 +0200 (CEST)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc5121bcf1aso105211a12.1
 for <dev@dpdk.org>; Tue, 22 Sep 2026 08:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790092374;
 x=1790697174; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9MyT6sIoBBq4nRz9xL2iselzJ3LRbxJ18DKKNE1zszg=;
 b=qyYXlmZDAS6+F2KA6s+xQ8Un2HyE+dV/KsrOFUOx+/G3wGfU9lIngUf0KayYg4HHn+
 eI30mVMg1OxKu3G/NFn2AaS2shp0Y+Ar/YdZFFPK0LsLsFu31tmm/m4ikIlwax1PBoTi
 wtekBcJlP5GvdjzB5QeUc2i5ScdUYxwwRXiHTXwm3vwaqiCkaWzhNjg0YZiTvmWHLElz
 pkRbkCNVG7n6Rwze3TQZCovvrexcEOYd1ICMVDjuCYhnxrvuD0jhPIyyjmxim1RsQe19
 fuAS65CI15wS5uIJNlgGVceJu2P8SKdzL6eQdcyb3HoPLlHQqLC9Ndw7YVJk2izGaHj1
 bPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790092374; x=1790697174;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9MyT6sIoBBq4nRz9xL2iselzJ3LRbxJ18DKKNE1zszg=;
 b=MCHoFTASYb2kz0gs+d9MICZO/R18Afr5gfSvDOzOyLUeg4zQI8oOvO9rwN7MzgC1ju
 lVqqMab1T/berIWq0Qmy18oDSk0CBH0MaaxodjdDL/ypuSxFshA3tsRjCtEZzjg0KgqY
 ai7uu4QrudloRPvytV1ZcATTQvp3JdghpYW5IrFBO4K9YKUiZJR9hfyYxnrJAXEeumWw
 o4PqffEv2cckok/DE/kt4uVlfouehjFyY1nC0k2by9hHmmdZztSwme/f9PoY00ZtRPKe
 t/BXl1MvcFH2RGu5hTnZMiUBHwKxxM3SfEhrpFbyHUUjDwZ4fG5vqFCnffuVPK7nmFGT
 YCTg==
X-Gm-Message-State: AFuF++lfsFiI7Vz1jWg2DU8PQnqgTEco9TodGxE9AiIlfG29ya6mX35q
 q3assIT5dht4vGntWy69C63+3JoCWaZV1YBCnWEJBjva1YcAdtbRxbCsLhx/8RfEDeYze6kZlmh
 BYPCv
X-Gm-Gg: AYBFou1DJRnuupE22QxCfEw0tzkqXCQUlJRsGB6IjxPEmZcKtkspue9EnqjJwxSEYKk
 XulPEqF/Wt3clxiDmiLcH1pS9DNkI+Z3uCf22njwAG9krg3od0MANe5QVz6/kv6logaQ4SAmuqA
 rBb7xU6fctdXGUuguFnvLH5R/Liu7BkEtgDk9ETXc8/pBHoeTmhkhN9qJOhgdpKKRW34Etio4FI
 qAaXyIlGDiIYUus9juPISj91YuKM5W3WmMZMqZ81zcQ+6hMbx+ajsRhdhUymFjLRLuMobKLyi8z
 P6k5WxfD/CZzFCMsX04eALkEKJ4qpJ5ppAx3sTqenIwRQ8lV8z+StwMB1mBVE1mw8D9db8yLNik
 u7ILVhdfFbvxfDKoIoUhVibRQRHWO3O4OBKnwOw2XZ6O68pqLs49ka9TWk+m5camddWwYSwnWPb
 uP6FQKZqgGVwJSI6a2Mhqy36kv7bJSxdJUkw06CGbooOnT0cC0RFebSTJXNndaaY8Leti3O4Jv7
 s56yY64cS8CXUhhLFzROTy3JEsykNGG4li0JQ==
X-Received: by 2002:a05:6a21:2d42:b0:3dd:a196:5394 with SMTP id
 adf61e73a8af0-3ddec819b05mr2147779637.54.1790092373744; 
 Tue, 22 Sep 2026 08:52:53 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc756b5c2e7sm1219347a12.27.2026.09.22.08.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:52:53 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Anurag Mandal <anurag.mandal@intel.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 3/3] fib, rib: fix name prefixes
Date: Tue, 22 Sep 2026 08:52:10 -0700
Message-ID: <20260922155249.3115271-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922155249.3115271-1-stephen@networkplumber.org>
References: <20260921215733.404686-1-stephen@networkplumber.org>
 <20260922155249.3115271-1-stephen@networkplumber.org>
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
Acked-by: Morten Brørup <mb@smartsharesystems.com>
[stephen: recomputed the name length limits for 64 byte memzone
 names, dropped the now unneeded test, example and node renames]
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/rel_notes/release_26_11.rst | 15 +++++++++++++++
 lib/fib/rte_fib.c                      | 16 +++++++++++++---
 lib/fib/rte_fib6.c                     | 16 +++++++++++++---
 lib/rib/rte_rib.c                      | 14 ++++++++++++--
 lib/rib/rte_rib6.c                     | 14 ++++++++++++--
 5 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 99847e9745..31de764a9d 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -123,6 +123,21 @@ API Changes
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

